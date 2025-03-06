package com.fsoft.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ResponseDTO {
    private int code;       // Mã trạng thái (200, 400, 500, etc.)
    private String message; // Thông báo kết quả
    private Object data;    // Dữ liệu trả về (có thể null)
} 