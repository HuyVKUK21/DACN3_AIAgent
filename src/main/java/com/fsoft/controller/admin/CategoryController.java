
package com.fsoft.controller.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fsoft.dto.AccountDTO;
import com.fsoft.dto.CategoryDTO;
import com.fsoft.service.impl.CategoryService;
import com.fsoft.utils.Utils;

@Controller
public class CategoryController {

	private static final Logger logger = Logger.getLogger(CategoryController.class);

	@Autowired
	private CategoryService categoryService;

	@RequestMapping(value = "admin/category/list-category", method = RequestMethod.GET)
	public ModelAndView showList(@RequestParam(name = "page", defaultValue = "1", required = true) int page,
			@RequestParam(name = "limit", defaultValue = "3", required = true) int limit) {
		ModelAndView mav = new ModelAndView("admin/category/list-category");
		CategoryDTO category = new CategoryDTO();

		category.setPage(page);
		category.setLimit(limit);
		category.setTotalItem(categoryService.getTotalItem());
		category.setTotalPage((int) Math.ceil((double) category.getTotalItem() / category.getLimit()));
		Pageable pageable = new PageRequest(page - 1, limit);

		category.setListResult(categoryService.findAll(pageable));

		mav.addObject("category", category);
		return mav;
	}

	@RequestMapping(value = "admin/category/add-category", method = RequestMethod.GET)
	public ModelAndView addList(@ModelAttribute("categoryDTO") CategoryDTO categoryDTO) {

		ModelAndView mav = new ModelAndView("admin/category/add-category");
		mav.addObject("categoryDTO", categoryDTO);

		return mav;
	}

	@RequestMapping(value = "/admin/category/save-category", method = RequestMethod.POST)
	public String saveList(@RequestParam(value = "categoryImage") CommonsMultipartFile commonsMultipartFiles,
			HttpServletRequest request, HttpSession session) {
		String nameNewFile = "";
		try {
			nameNewFile = Utils.uploadPartFiles(request.getServletContext(), commonsMultipartFiles, "category");
		} catch (Exception e) {
			// Xử lý ngoại lệ ở đây
			logger.error("Failed to upload file: " + e.getMessage(), e);
			// Thực hiện các hành động khác như thông báo cho người dùng
		}
		CategoryDTO dto = new CategoryDTO();
		dto.setCategoryName(request.getParameter("categoryName"));
		dto.setCategoryImage(nameNewFile);
		dto.setCategoryStatus(Integer.parseInt(request.getParameter("categoryStatus")));
		dto.setCategoryDesc(request.getParameter("categoryDesc"));

		categoryService.insert(dto);

		return "redirect:/admin/category/list-category";
	}

	@RequestMapping(value = "admin/category/edit", method = RequestMethod.GET)
	public ModelAndView editList(@RequestParam("id") String itemid,
			@ModelAttribute("categoryDTO") CategoryDTO categoryDTO) {
		ModelAndView mav = new ModelAndView("admin/category/edit-category");
		categoryDTO = categoryService.findByID(Integer.parseInt(itemid));
		mav.addObject("categoryDTO", categoryDTO);
		return mav;
	}

	@RequestMapping(value = "/admin/category/edit", method = RequestMethod.POST)
	public String saveEditCategory(@ModelAttribute("categoryDTO") @Valid CategoryDTO categoryDTO, BindingResult result,
			HttpServletRequest request) {

		if (result.hasErrors()) {
			return "admin/category/edit-category";
		}

		CategoryDTO existingCategory = categoryService.findByID(categoryDTO.getCategoryId());

		if (existingCategory == null) {

			return "redirect:/admin/category/list-category";
		}

		String nameNewFile = "";
		CommonsMultipartFile commonsMultipartFile = (CommonsMultipartFile) categoryDTO.getCategoryImageFile();

		if (commonsMultipartFile != null && !commonsMultipartFile.isEmpty()) {
			try {

				nameNewFile = Utils.uploadPartFiles(request.getServletContext(), commonsMultipartFile, "category");
				categoryDTO.setCategoryImage(nameNewFile);
			} catch (Exception e) {
				logger.error("Failed to upload file: " + e.getMessage(), e);

				categoryDTO.setCategoryImage(existingCategory.getCategoryImage());
			}
		} else {

			categoryDTO.setCategoryImage(existingCategory.getCategoryImage());
		}

		categoryService.update(categoryDTO);
		return "redirect:/admin/category/list-category";
	}

}
