package com.fsoft.controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fsoft.api.S3Uploader;
import com.fsoft.converter.ProductConverter;
import com.fsoft.dto.CategoryDTO;
import com.fsoft.dto.ProductDTO;
import com.fsoft.entity.ProductEntity;
import com.fsoft.service.IProductService;
import com.fsoft.service.impl.CategoryService;
import com.fsoft.utils.Utils;

@Controller
public class ProductController {
	private static final Logger logger = Logger.getLogger(ProductController.class);

	@Autowired
	private CategoryService categoryService;
	@Autowired
	private IProductService ProductService;
	@Autowired
    private ProductConverter productConvert;


	@RequestMapping(value = "admin/product/list-product", method = RequestMethod.GET)
	public ModelAndView showList(@RequestParam(name = "page", defaultValue = "1", required = true) int page,
			@RequestParam(name = "limit", defaultValue = "5", required = true) int limit) {
		ModelAndView mav = new ModelAndView("admin/product/list-product");
		ProductDTO productDTO = new ProductDTO();

		productDTO.setPage(page);
		productDTO.setLimit(limit);
		productDTO.setTotalItem(ProductService.getTotalItem());
		productDTO.setTotalPage((int) Math.ceil((double) productDTO.getTotalItem() / productDTO.getLimit()));
		Pageable pageable = new PageRequest(page - 1, limit);
		
		productDTO.setListResult(ProductService.findAll(pageable));
		List<CategoryDTO> categoryDTOs = categoryService.findAll();

		mav.addObject("categorys", categoryDTOs);

		mav.addObject("productDTO", productDTO);
		return mav;
	}

	@GetMapping("admin/product/add-product")
	public String showAddProductForm(Model model) {
		List<CategoryDTO> categoryDTOs = categoryService.findAll();
		model.addAttribute("productDTO", new ProductDTO());
		model.addAttribute("categories", categoryDTOs);
	    model.addAttribute("pageTitle", "Thêm Sản Phẩm");

		return "admin/product/add-product";
	}

	@RequestMapping(value = "/admin/product/save-product", method = RequestMethod.POST)
	public String saveList(@Valid @ModelAttribute("productDTO") ProductDTO productDTO, BindingResult result,
			Model model, HttpServletRequest request, RedirectAttributes redirectAttributes,
			HttpServletResponse response,
			@RequestParam(value = "productImage") CommonsMultipartFile commonsMultipartFiles, HttpSession session) {

		String nameNewFile = "";
		try {
			nameNewFile = Utils.uploadPartFiles(request.getServletContext(), commonsMultipartFiles, "product");
		} catch (Exception e) {
			// Xử lý ngoại lệ ở đây
			logger.error("Failed to upload file: " + e.getMessage(), e);
			// Thực hiện các hành động khác như thông báo cho người dùng
		}

		productDTO.setProductImage(nameNewFile);
		ProductService.updateProduct(productDTO);

		return "redirect:/admin/product/list-product";
	}

	
	  @GetMapping("admin/product/update-product/{id}")
	   public String showUpdateProductForm(@PathVariable("id") int id, Model model) {
	       List<CategoryDTO> categoryDTOs = categoryService.findAll();
	       ProductEntity productEntity = ProductService.findById(id);
	       
	       if (productEntity == null) {
	           return "redirect:/admin/product/list-product";
	       }
	       ProductDTO productDTO = productConvert.toDto(productEntity);

	       model.addAttribute("productDTO", productDTO);
	       model.addAttribute("categories", categoryDTOs);
	       model.addAttribute("pageTitle", "Cập Nhật Sản Phẩm");

	       return "admin/product/add-product";
	   }

	@PostMapping("/admin/product/update-status")
	public void updateProductStatus(HttpServletResponse response, HttpServletRequest request) throws IOException {
		int productId = Integer.parseInt(request.getParameter("productId"));
		int productStatus = Integer.parseInt(request.getParameter("productStatus"));
		String statusUpdate;

		try {
			ProductService.updateStatus(productId, productStatus);
			statusUpdate = "Product status updated successfully";
		} catch (Exception e) {
			logger.error(e);
			statusUpdate = e.getMessage();
		}

		response.setContentType("text/plain");
		response.getWriter().write(statusUpdate);
	}

}
