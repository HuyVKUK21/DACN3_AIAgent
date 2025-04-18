package com.fsoft.service.impl;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fsoft.config.VNPayConfig;
import com.fsoft.service.IVNPayService;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class VNPayService implements IVNPayService {
	@Value("${vnpay.tmnCode}")
	private String vnp_TmnCode;

	@Value("${vnpay.hashSecret}")
	private String vnp_HashSecret;

	@Value("${vnpay.payUrl}")
	private String vnp_PayUrl;

	@Value("${vnpay.returnUrl}")
	private String vnp_ReturnUrl;

	@Override
	public String createPaymentUrl(long amount, String orderInfo, String ipAddress) throws UnsupportedEncodingException {
		String vnp_Version = "2.1.0";
		String vnp_Command = "pay";
		String vnp_OrderType = "other";
		String vnp_TxnRef = String.valueOf(System.currentTimeMillis());
		String vnp_Locale = "vn";
		String vnp_CurrCode = "VND";

		Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		String vnp_CreateDate = formatter.format(calendar.getTime());
		calendar.add(Calendar.MINUTE, 15);
		String vnp_ExpireDate = formatter.format(calendar.getTime());

		Map<String, String> vnp_Params = new HashMap<>();
		vnp_Params.put("vnp_Version", vnp_Version);
		vnp_Params.put("vnp_Command", vnp_Command);
		vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
		vnp_Params.put("vnp_Amount", String.valueOf(amount * 100));
		vnp_Params.put("vnp_CurrCode", vnp_CurrCode);
		vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
		vnp_Params.put("vnp_OrderInfo", orderInfo);
		vnp_Params.put("vnp_OrderType", vnp_OrderType);
		vnp_Params.put("vnp_ReturnUrl", vnp_ReturnUrl);
		vnp_Params.put("vnp_IpAddr", ipAddress);
		vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
		vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);
		vnp_Params.put("vnp_Locale", vnp_Locale);

		// Tạo chuỗi query + secure hash
		List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
		Collections.sort(fieldNames);
		StringBuilder hashData = new StringBuilder();
		StringBuilder query = new StringBuilder();
		for (String fieldName : fieldNames) {
			String fieldValue = vnp_Params.get(fieldName);
			if (fieldValue != null && !fieldValue.isEmpty()) {
				hashData.append(fieldName).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.name()))
		        .append('&');
				query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.name())).append('=')
				     .append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.name())).append('&');

			}
		}

		// Xóa ký tự & cuối
		hashData.setLength(hashData.length() - 1);
		query.setLength(query.length() - 1);

		// Tính secure hash
		String vnp_SecureHash = hmacSHA512(vnp_HashSecret, hashData.toString());
		query.append("&vnp_SecureHash=").append(vnp_SecureHash);

		return vnp_PayUrl + "?" + query.toString();
	}

	public static String hmacSHA512(String key, String data) {
		try {
			Mac hmac512 = Mac.getInstance("HmacSHA512");
			SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
			hmac512.init(secretKey);
			byte[] hash = hmac512.doFinal(data.getBytes(StandardCharsets.UTF_8));
			StringBuilder result = new StringBuilder();
			for (byte b : hash) {
				result.append(String.format("%02x", b));
			}
			return result.toString();
		} catch (Exception ex) {
			throw new RuntimeException("HmacSHA512 error: " + ex.getMessage());
		}
	}
}
