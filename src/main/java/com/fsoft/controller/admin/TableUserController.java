package com.fsoft.controller.admin;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fsoft.dto.TableUserDTO;
import com.fsoft.service.ITableUserService;

@Controller(value = "tableUserControllerOfAdmin")
public class TableUserController {
	private static final Logger logger = Logger.getLogger(TableUserController.class);

	@Autowired
	private ITableUserService tableUserService;

	@RequestMapping(value = "admin/table-user/list", method = RequestMethod.GET)
	public ModelAndView showList(@RequestParam(name = "page", defaultValue = "1", required = true) int page,
			@RequestParam(name = "limit", defaultValue = "5", required = true) int limit) {
		ModelAndView mav = new ModelAndView("admin/tableuser/list-tableuser");

		TableUserDTO tableUser = new TableUserDTO();

		tableUser.setPage(page);
		tableUser.setLimit(limit);
		tableUser.setTotalItem(tableUserService.getTotalItem());
		tableUser.setTotalPage((int) Math.ceil((double) tableUser.getTotalItem() / tableUser.getLimit()));
		Pageable pageable = new PageRequest(page - 1, limit);

		tableUser.setListResult(tableUserService.getList(pageable));

		mav.addObject("userTableDTO", tableUser);
		return mav;
	}

	@PostMapping("/admin/table-user/save")
	private String saveTableUser(@ModelAttribute("userTableDTO") TableUserDTO tableUserDTO) {
		System.out.println(tableUserDTO.toString());
		tableUserService.insert(tableUserDTO);
		return "redirect:/admin/table-user/list";
	}

	@PostMapping("/admin/table-user/update-status")
	public void updateTableUserStatus(HttpServletResponse response, HttpServletRequest request) throws IOException {
		int userTableID = Integer.parseInt(request.getParameter("userTableID"));
		int tableUserStatus = Integer.parseInt(request.getParameter("tableUserStatus"));
		String statusUpdate;

		try {
			tableUserService.updateStatus(userTableID, tableUserStatus);
			statusUpdate = "Status updated successfully";
		} catch (Exception e) {
			logger.error(e);
			statusUpdate = e.getMessage();
		}

		response.setContentType("text/plain");
		response.getWriter().write(statusUpdate);
	}

	@RequestMapping(value = "admin/table-user/edit", method = RequestMethod.GET)
	public ModelAndView editTableUser(@RequestParam("id") int itemId) {
		ModelAndView mav = new ModelAndView("admin/tableuser/edit-tableuser");
		TableUserDTO tableUserDTO = tableUserService.findByID(itemId);
		mav.addObject("tableUserDTO", tableUserDTO);
		return mav;
	}

	@RequestMapping(value = "/admin/table-user/edit", method = RequestMethod.POST)
	public String saveEditTableUser(@ModelAttribute("tableUserDTO") @Valid TableUserDTO tableUserDTO,
			BindingResult result, HttpServletRequest request) {

		if (result.hasErrors()) {
			return "admin/tableuser/edit-tableuser";
		}

		tableUserService.update(tableUserDTO);
		return "redirect:/admin/table-user/list";
	}

}
