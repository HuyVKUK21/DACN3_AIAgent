function Validator(options){

    var selectorRules = {

    };
    // Hàm thực hiện validate
    function validate(inputElement , rule){
        
        var errorElement = inputElement.parentElement.querySelector(options.errorSelector);
        var errorMessage;
        // Lấy ra các rules của selector
        var rules = selectorRules[rule.selector];
        // Lặp qua từ rule và kiểm tra
        // có lỗi thì dừng việc kiểm tra
        for ( var i = 0 ; i < rules.length ; ++i){
            errorMessage = rules[i](inputElement.value);
            if (errorMessage) break;
        }

        if(errorMessage){
            errorElement.innerText = errorMessage;
            inputElement.classList.add('is-invalid');
            inputElement.classList.remove('is-valid');
            inputElement.parentElement.classList.add('invalid');
        }
        else{
            errorElement.innerText = '';
            inputElement.classList.remove('is-invalid');
            inputElement.classList.add('is-valid');
            inputElement.parentElement.classList.remove('invalid');
        }
    }
   // Lấy element của form cần validate
    var formElement = document.querySelector(options.form);

    if(formElement){

        options.rules.forEach(function(rule){
            // Lưu lại các rules cho mỗi input
             if(Array.isArray(selectorRules[rule.selector])){
                selectorRules[rule.selector].push(rule.test);
             }else{
                selectorRules[rule.selector] = [rule.test];
            }

            var inputElement = formElement.querySelector(rule.selector);

           
            
            if(inputElement){
                // Xử lý trường hợp blur khỏi input
                inputElement.onblur = function(){
                    validate(inputElement,rule);
               
                }

                 // Xử lý trường hợp khi người dùng vào input
                 inputElement.oninput = function(){
                    var errorElement = inputElement.parentElement.querySelector(options.errorSelector);
                    errorElement.innerText = '';
                    inputElement.parentElement.classList.remove('invalid');
               
                }
            }
        });

    }
}

Validator.isRequired = function(selector, message){
    return{
        selector: selector,
        test: function(value){
            return value.trim() ? undefined : message || 'Vui lòng nhập trường này'
        }
    };

}

Validator.isEmail = function(selector, message){
    return{
        selector: selector,
        test: function(value){
            var regex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            return regex.test(value) ? undefined : message || 'Trường này phải là email'
        }
    };

}

Validator.maxLength = function(selector , max, message){
    return{
        selector: selector,
        test: function(value) {
            return value.length <= max ? undefined : message || `Chỉ được nhập tối đa ${max} kí tự`
        }
    };

}

Validator.minLength = function(selector , min, message){
    return{
        selector: selector,
        test: function(value) {
            return value.length >= min ? undefined : message || `Vui lòng nhập tối thiểu ${min} kí tự`
        }
    };

}

Validator.isNumber = function(selector, message) {
    return {
        selector: selector,
        test: function(value) {
            return !isNaN(value) ? undefined : message || 'Trường này phải là số';
        }
    };
};

Validator.isConfirmed = function(selector , getCofirmValue , message){
    return{
        selector: selector,
        test: function(value){
            return value == getCofirmValue ? undefined : message || 'Giá trị nhập vào không chính xác'
        }
    };
}

Validator.isDateAfterTest = function(selector, compareDate, message) {
    return {
        selector: selector,
        test: function(value) {
            // Chuyển đổi ngày nhập vào và ngày so sánh thành đối tượng moment
            var inputDate = moment(value, 'YYYY-MM-DD');
            var compareToDate = moment(compareDate, 'YYYY-MM-DD');

            // Kiểm tra tính hợp lệ của ngày
            if (!inputDate.isValid() || !compareToDate.isValid()) {
                return message || 'Ngày không hợp lệ';
            }

            // Kiểm tra nếu ngày nhập vào lớn hơn ngày so sánh
            return inputDate.isAfter(compareToDate) ? undefined : message || 'Ngày phải lớn hơn ngày ' + compareDate;
        }
    };
};

Validator.isDateBeforeTest = function(selector, compareDate, message) {
    return {
        selector: selector,
        test: function(value) {
            // Chuyển đổi ngày nhập vào và ngày so sánh thành đối tượng moment
            var inputDate = moment(value, 'YYYY-MM-DD');
            var compareToDate = moment(compareDate, 'YYYY-MM-DD');
            
            // Kiểm tra tính hợp lệ của ngày
            if (!inputDate.isValid() || !compareToDate.isValid()) {
                return message || 'Ngày không hợp lệ';
            }

            // Kiểm tra nếu ngày nhập vào nhỏ hơn ngày so sánh
            return inputDate.isBefore(compareToDate) ? undefined : message || 'Ngày phải nhỏ hơn ngày ' + compareDate;
        }
    };
};

