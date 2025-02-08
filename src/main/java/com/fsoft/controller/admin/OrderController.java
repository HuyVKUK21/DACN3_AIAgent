package com.fsoft.controller.admin;

import java.io.ByteArrayInputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.fsoft.dto.OrderDTO;
import com.fsoft.dto.OrderDetailsDTO;
import com.fsoft.dto.ProductDTO;
import com.fsoft.service.IOrderDetailsService;
import com.fsoft.service.IOrderService;

@Controller
public class OrderController {
    private static final Logger logger = Logger.getLogger(AccountController.class);
    
    @Autowired
    IOrderService orderService;
    
    @Autowired
    IOrderDetailsService orderDetailsService;
    
    
    @RequestMapping(value = "admin/order/list-order", method = RequestMethod.GET)
    public ModelAndView showList(
 		   @RequestParam(name="page",defaultValue = "1" ,required = true) int page , 
 		   @RequestParam(name="limit",defaultValue = "5" ,required = true) int limit,
 		   @RequestParam(name="search",defaultValue = "" ,required = false) String search) {
       ModelAndView mav = new ModelAndView("admin/order/list-order");
       OrderDTO orderDTO = new OrderDTO();
       
       orderDTO.setPage(page);
       orderDTO.setLimit(limit);
       orderDTO.setTotalItem(orderService.getTotalItem());
       orderDTO.setTotalPage((int) Math.ceil((double) orderDTO.getTotalItem() / orderDTO.getLimit()));
       Pageable pageable = new PageRequest(page - 1, limit);
       
       if (search.isEmpty()) {
    	   orderDTO.setListResult(orderService.findAll(pageable));
       }else {
    	   orderDTO.setListResult(orderService.search(pageable,search));
       }
       
      
      
   	  mav.addObject("orderDTO", orderDTO);
       return mav;
    }
    
    @RequestMapping(value = "admin/order/print-order", method = RequestMethod.GET)
    public void printOrder(
    		HttpServletResponse response,
    		HttpServletRequest request,
 		   @RequestParam(name="id",required = false) Integer id) throws IOException {
    	
    	   if (id != null) {
    		   
    	       byte[] pdfData =orderService.generateInvoicePdf(id);

    	        response.setContentType("application/pdf");
    	        response.setHeader("Content-Disposition", "inline; filename="+id+".pdf");
    	        response.setContentLength(pdfData.length);

    	        try (ByteArrayInputStream bais = new ByteArrayInputStream(pdfData)) {
    	            org.apache.commons.io.IOUtils.copy(bais, response.getOutputStream());
    	        }
    	       
    	     
    	   	   
    	    }else {
    	    	  return;
    	    }
    	
     
    }
    
    
    @RequestMapping(value = "admin/order/details-order", method = RequestMethod.GET)
    public ModelAndView showListOrderDetails(
    		HttpServletRequest request,
 		   @RequestParam(name="id",required = false) Integer id , 
 		   @RequestParam(name="page",defaultValue = "1" ,required = true) int  page ,
 		   @RequestParam(name="limit",defaultValue = "5" ,required = true) int limit) {
    	
    	   if (id != null) {
    		   ModelAndView mav = new ModelAndView("admin/order/list-order-details");
    	       OrderDetailsDTO detailsDTO = new OrderDetailsDTO();
    	       
    	       
    	       OrderDTO orderDTO = orderService.findByID(id);
    	    		   
    	       detailsDTO.setPage(page);
    	       detailsDTO.setLimit(limit);
    	       detailsDTO.setTotalItem(orderDetailsService.getTotalItemByOrderID(id));
    	       detailsDTO.setTotalPage((int) Math.ceil((double) detailsDTO.getTotalItem() / detailsDTO.getLimit()));
    	       Pageable pageable = new PageRequest(page - 1, limit);
    	       
    	       detailsDTO.setListResult(orderDetailsService.findAll(id,pageable));
    	      
    	   	   mav.addObject("detailsDTO", detailsDTO);
    	   	   mav.addObject("orderDTO", orderDTO);
    	   	    return mav;
    	    }else {
    	    	  return new ModelAndView(new RedirectView(request.getContextPath()+"/admin/order/list-order"));
    	    }
    	
     
    }
}
