package com.fsoft.utils;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletContext;

import org.apache.log4j.Logger;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class Utils {
	public static Logger logger = Logger.getLogger(Utils.class);
	
	public static String generateCode() {
        String prefix = "SHOPCF";
        // Lấy thời gian hiện tại và định dạng thành chuỗi yyyyMMddHHmmss
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        String timestamp = now.format(formatter);

        // Thêm một số ngẫu nhiên (có thể là số lượng ký tự thay đổi tùy theo yêu cầu)
        Random random = new Random();
        int randomNumber = random.nextInt(1000); // 3 chữ số ngẫu nhiên

        // Kết hợp prefix, timestamp và số ngẫu nhiên
        return prefix + timestamp + String.format("%03d", randomNumber);
    }
	
	public static Map<String, String> messageUtils(String type, String content){
		   Map<String, String> message = new HashMap<>();
           message.put("type", type);
           message.put("message", content);
           return message;
	}
	
	public static String uploadPartFiles(ServletContext servletContext, CommonsMultipartFile commonsMultipartFiles, String archiveFolder) throws Exception {
	    String nameFile = commonsMultipartFiles.getOriginalFilename();
	    String nameFileNew = null;

	    if (nameFile != null && !nameFile.isEmpty()) {
	        String dirFile = servletContext.getRealPath("/") + "template" + File.separator + "web" + File.separator + "img";

	        File fileDir = new File(dirFile + File.separator + archiveFolder);
	        if (!fileDir.exists()) {
	            if (!fileDir.mkdirs()) {
	                throw new IOException("Failed to create directories: " + fileDir.getAbsolutePath());
	            }
	        }

	        try {
	            String[] parts = nameFile.split("\\.");
	            if (parts.length == 2) {
	                String fileName = parts[0];
	                String extension = parts[1];
	                nameFileNew = fileName + System.currentTimeMillis() + "." + extension;
	            } else {
	                logger.error("Invalid file name format!");
	                nameFileNew = nameFile;
	            }

	            File newFile = new File(fileDir, nameFileNew);
	            commonsMultipartFiles.transferTo(newFile);
	            logger.info("File uploaded successfully!");
	        } catch (IOException e) {
	            logger.error("File upload failed: " + e.getMessage(), e);
	            throw new Exception("File upload failed: " + e.getMessage(), e);
	        } catch (Exception e) {
	            logger.error("An error occurred during file upload: " + e.getMessage(), e);
	            throw new Exception("An error occurred during file upload: " + e.getMessage(), e);
	        }
	    }

	    return nameFileNew;
	}


	public static Date convertStringToDate(String dateString) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		try {
			date = formatter.parse(dateString);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	public static boolean compareTimeString(String time1, String time2) {
		SimpleDateFormat formatter = new SimpleDateFormat("HH:mm");
		try {
			Date date1 = formatter.parse(time1);
			Date date2 = formatter.parse(time2);
			if (date1.compareTo(date2) >= 0) {
				return true;
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return false;
	}

	public static String getCurrentDate() {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		return formatter.format(date);
	}

	public static String getCurrentTime() {
		SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");
		Date date = new Date();
		return formatter.format(date);
	}
}
