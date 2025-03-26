package com.fsoft.controller.user;

import java.io.ByteArrayInputStream;

import javax.servlet.http.HttpServletResponse;


import java.io.ByteArrayOutputStream;
import java.util.List;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
@Controller
public class HomeController {

    @GetMapping("/user/home")
    public String index() {
        return "user/home/index";
    }
    @GetMapping("/viewInvoice")
    public void viewInvoice(HttpServletResponse response) throws IOException {
        byte[] pdfData = generateInvoicePdf();

        // Set MIME type for PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=invoice.pdf");
        response.setContentLength(pdfData.length);

        try (ByteArrayInputStream bais = new ByteArrayInputStream(pdfData)) {
            org.apache.commons.io.IOUtils.copy(bais, response.getOutputStream());
        }
    }
    
    @GetMapping("/printInvoice")
    public void printInvoice( HttpServletResponse response) throws IOException {
        byte[] pdfData =generateInvoicePdf();

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=invoice.pdf");
        response.setContentLength(pdfData.length);

        try (ByteArrayInputStream bais = new ByteArrayInputStream(pdfData)) {
            org.apache.commons.io.IOUtils.copy(bais, response.getOutputStream());
        }
    }
    
    
    public byte[] generateInvoicePdf() throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Document document = new Document();

        try {
            PdfWriter.getInstance(document, baos);
            document.open();
            document.add(new Paragraph("Invoice ID"));
            document.add(new Paragraph("Date: " + new java.util.Date()));
            document.add(new Paragraph("Product: Sample Product"));
            document.add(new Paragraph("Price: $100"));
            document.close();
        } catch (DocumentException e) {
            e.printStackTrace();
        }
        
        return baos.toByteArray();
    }
    
}
