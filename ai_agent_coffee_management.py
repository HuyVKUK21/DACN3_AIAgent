from flask import Flask, request, jsonify, redirect, url_for
from flask_cors import CORS
import google.generativeai as genai
import pandas as pd
import re
import json
import requests
from datetime import datetime

app = Flask(__name__)
CORS(app)


OPENWEATHER_API_KEY = ""
genai.configure(api_key="")
model = genai.GenerativeModel("models/gemini-1.5-flash-latest")


df = pd.read_csv("C:\\database_export\\product_menu.csv", encoding="utf-8-sig")

chat_states = {}
weather_cache = {
    'data': None,
    'last_update': None
}


def get_danang_weather():
    current_time = datetime.now()
    if (weather_cache['data'] is not None and 
        weather_cache['last_update'] is not None and 
        (current_time - weather_cache['last_update']).total_seconds() < 600):
        return weather_cache['data']
    
    try:
        url = f"http://api.openweathermap.org/data/2.5/weather?q=Da Nang,VN&appid={OPENWEATHER_API_KEY}&units=metric&lang=vi"
        response = requests.get(url)
        if response.status_code == 200:
            data = response.json()
            weather_data = {
                'temp': round(data['main']['temp'], 1),
                'humidity': data['main']['humidity'],
                'description': data['weather'][0]['description'],
                'feels_like': round(data['main']['feels_like'], 1),
                'time': current_time.strftime('%H:%M')
            }
            weather_cache['data'] = weather_data
            weather_cache['last_update'] = current_time
            return weather_data
    except Exception as e:
        print(f"Error getting weather: {e}")
    return None

def find_items_in_menu(query, limit=5):
    matches = df[df['product_name'].str.contains(query, case=False, na=False)]
    if matches.empty:
        keywords = query.lower().split()
        matches = df[df['product_name'].str.lower().apply(
            lambda x: any(keyword in x for keyword in keywords)
        )]
    return matches.head(limit)

def handle_chat_context(session_id, message, table_id=None):
    if session_id not in chat_states:
        chat_states[session_id] = {
            "state": "initial",
            "selected_items": [],
            "current_item": None,
            "table_id": table_id,
            "last_context": None
        }
    
    state = chat_states[session_id]
    message_lower = message.lower()

    weather_drink_patterns = [
        r"nên uống gì",
        r"uống gì",
        r"khát quá",
        r"có gì mát",
        r"món nào ngon",
        r"gợi ý",
        r"nóng quá",
        r"oi bức"
    ]

    order_patterns = [
        r"(?:tôi\s+)?(?:muốn|chọn)\s+(?:đặt\s+)?(\d*)\s*(?:ly|phần)?\s*(.*?)(?:\s+nhé?)?$",
        r"(?:cho|lấy|đặt)\s+(?:tôi|mình)?\s*(\d*)\s*(?:ly|phần)?\s*(.*?)(?:\s+nhé?)?$"
    ]

    payment_patterns = [
        r"thanh toán",
        r"tính tiền",
        r"trả tiền",
        r"bill",
        r"checkout"
    ]

    if any(pattern in message_lower for pattern in payment_patterns):
        if state["selected_items"]:
            total = sum(item["price"] * item["quantity"] for item in state["selected_items"])
            checkout_url = f"/payment?session_id={session_id}&table_id={state['table_id']}&total={total}"
            
            return {
                "response": f"Tổng hóa đơn của bạn là: {total:,}đ\nEm đang chuyển bạn đến trang thanh toán!",
                "action": "checkout",
                "checkout_url": checkout_url,
                "total": total,
                "items": state["selected_items"]
            }
        else:
            return {
                "response": "Bạn chưa đặt món nào. Hãy đặt món trước khi thanh toán nhé!"
            }

    for pattern in order_patterns:
        match = re.search(pattern, message_lower)
        if match:
            quantity = match.group(1)
            item_name = match.group(2).strip()
            
            quantity = int(quantity) if quantity else 1
            items = find_items_in_menu(item_name)
            
            if not items.empty:
                item = items.iloc[0]
                total = quantity * item["product_price"]
                
                order_info = {
                    "productId": int(item["product_id"]),
                    "quantity": quantity,
                    "price": float(item["product_price"]),
                    "name": item["product_name"]
                }
                
                response = f"Đã thêm {quantity} {item['product_name']} vào đơn hàng.\n"
                response += f"Đơn giá: {item['product_price']:,}đ × {quantity} = {total:,}đ\n\n"
                response += "Bạn có thể:\n"
                response += "1. Đặt thêm món khác\n"
                response += "2. Nói 'thanh toán' để thanh toán\n"
                
                state["selected_items"].append(order_info)
                
                return {
                    "response": response,
                    "order": order_info
                }
            else:
                similar_items = find_items_in_menu(item_name, limit=3)
                suggestion = "\n\nCó phải bạn muốn đặt một trong các món này?\n"
                for _, item in similar_items.iterrows():
                    suggestion += f"- {item['product_name']}: {item['product_price']:,}đ\n"
                
                return {
                    "response": f"Xin lỗi, không tìm thấy món '{item_name}' trong menu.{suggestion if not similar_items.empty else ''}"
                }

    if any(pattern in message_lower for pattern in weather_drink_patterns):
        weather = get_danang_weather()
        if weather:
            response = f"🌡️ Đà Nẵng hiện tại {weather['temp']}°C, {weather['description']}\n\n"
            
            if weather['temp'] >= 30:
                response += "Em gợi ý anh/chị một số món giải nhiệt:\n"
                cold_drinks = df[df['product_name'].str.contains('đá|lạnh|chanh|trà|soda', case=False, na=False)]
                suggestions = cold_drinks.sample(n=min(5, len(cold_drinks)))
            elif weather['temp'] <= 22:
                response += "Thời tiết se lạnh, em gợi ý các món ấm:\n"
                hot_drinks = df[df['product_name'].str.contains('nóng|ấm|cà phê', case=False, na=False)]
                suggestions = hot_drinks.sample(n=min(5, len(hot_drinks)))
            else:
                response += "Em gợi ý một số món phổ biến:\n"
                suggestions = df.sample(n=5)
            
            for _, drink in suggestions.iterrows():
                response += f"- {drink['product_name']}: {drink['product_price']:,}đ\n"
            
            response += "\nAnh/chị có thể đặt bằng cách nói 'Tôi chọn [tên món]' ạ!"
            return {"response": response}


    simple_confirms = ["ok", "ừ", "được", "đồng ý", "yes", "yeah", "uk"]
    if message_lower in simple_confirms:
        menu_response = "Menu quán:\n\n"
        
        if 'category' in df.columns:
            for category in df['category'].unique():
                menu_response += f"== {category} ==\n"
                category_items = df[df['category'] == category]
                for _, item in category_items.iterrows():
                    menu_response += f"- {item['product_name']}: {item['product_price']:,}đ\n"
                menu_response += "\n"
        else:
            for _, item in df.iterrows():
                menu_response += f"- {item['product_name']}: {item['product_price']:,}đ\n"
        
        menu_response += "\nAnh/chị có thể đặt bằng cách nói 'Tôi chọn [tên món]' ạ!"
        return {"response": menu_response}

    weather = get_danang_weather()
    weather_context = f"Hiện tại ở Đà Nẵng: {weather['temp']}°C, {weather['description']}" if weather else ""

    prompt = f"""Bạn là nhân viên phục vụ thân thiện tại một quán cafe. 
{weather_context}

Khách hàng nói: "{message}"

Hãy trả lời ngắn gọn, tự nhiên và thân thiện. Nếu khách có vẻ quan tâm đến đồ uống, hãy gợi ý họ xem menu hoặc đặt món trực tiếp."""

    try:
        response = model.generate_content(prompt)
        return {"response": response.text}
    except Exception as e:
        return {
            "response": "Xin lỗi, tôi đang gặp chút vấn đề. Bạn có thể nói lại được không?"
        }


@app.route("/chat", methods=["POST"])
def chat():
    data = request.json
    message = data.get("message", "")
    session_id = data.get("session_id", "default")
    table_id = data.get("table_id")
    
    result = handle_chat_context(session_id, message, table_id)
    return jsonify(result)

@app.route("/payment", methods=["GET"])
def payment():
    session_id = request.args.get("session_id")
    table_id = request.args.get("table_id")
    total = request.args.get("total")
    
    if session_id in chat_states:
        state = chat_states[session_id]
        items = state["selected_items"]
        return redirect(f"/customer/payment?table_id={table_id}&total={total}&items={json.dumps(items)}")
    
    return jsonify({"error": "Invalid session"}), 400

if __name__ == "__main__":
    app.run(port=5005)