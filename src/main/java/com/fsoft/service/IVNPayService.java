package com.fsoft.service;

public interface IVNPayService {
    String createPaymentUrl(long amount, String orderInfo, String ipAddress) throws Exception;
}

