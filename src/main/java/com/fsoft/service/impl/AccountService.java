package com.fsoft.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.ServletContext;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fsoft.config.Constant;
import com.fsoft.converter.AccountConverter;
import com.fsoft.dto.AccountDTO;
import com.fsoft.dto.TableUserDTO;
import com.fsoft.entity.Role;
import com.fsoft.entity.AccountEntity;
import com.fsoft.repository.RoleRepository;
import com.fsoft.security.JWTGenerator;
import com.fsoft.repository.AccountRepository;
import com.fsoft.service.IAccountService;
import com.fsoft.utils.SecurityUtils;

@Service
public class AccountService implements IAccountService {

    private static final Logger logger = Logger.getLogger(AccountService.class);

    private final AccountRepository adminRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;
    private final EntityManager entityManager;
    private final AccountConverter adminConverter;
    private final ServletContext servletContext;
    private final AuthenticationManager authenticationManager;
    private final JWTGenerator jwtGenerator;


    @Autowired
    public AccountService(AccountRepository adminRepository, RoleRepository roleRepository, PasswordEncoder passwordEncoder,
                          EntityManager entityManager, AccountConverter adminConverter, ServletContext servletContext,
                          AuthenticationManager authenticationManager, JWTGenerator jwtGenerator) {
        super();
        this.adminRepository = adminRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
        this.entityManager = entityManager;
        this.adminConverter = adminConverter;
        this.servletContext = servletContext;
        this.authenticationManager = authenticationManager;
        this.jwtGenerator = jwtGenerator;

    }

    @Override
    @Transactional
    public void saveUser(AccountDTO adminDTO) throws Exception {
        AccountEntity adminEntity = new AccountEntity();
        adminEntity.setFullname(adminDTO.getFullname());
        adminEntity.setUsername(adminDTO.getUsername());
        adminEntity.setEmail(adminDTO.getEmail());
        adminEntity.setPassword(passwordEncoder.encode(adminDTO.getPassword()));

        if (adminEntity.getId() != null) {
            updateRoleUser(adminEntity.getId(), adminDTO.getTypeRole());
        }

        Role role = getRole(adminDTO.getTypeRole());
        adminEntity.setRoles(Arrays.asList(role));

        try {
            adminRepository.save(adminEntity);
            logger.info("User saved successfully: " + adminEntity);
        } catch (Exception e) {
            logger.error("Error saving user: " + e.getMessage(), e);
            throw e;
        }
    }


    private Role getRole(Long typeRole) {
        String roleName = getRoleNameByType(typeRole);
        Role role = roleRepository.findByName(roleName);
        if (role == null) {
            throw new RuntimeException("Role not found: " + roleName);
        }
        if (!entityManager.contains(role)) {
            role = entityManager.merge(role);
        }
        return role;
    }

    @Override
    @Transactional
    public String updateRoleUser(Long idUser, Long idRole) throws Exception {
        AccountEntity adminEntity = adminRepository.findById(idUser);

        if (adminEntity.getUsername().equals(SecurityUtils.getSessionUser())) {
            return "permission_error";
        }

        adminEntity.getRoles().clear();
        Role role = getRole(idRole);
        adminEntity.setRoles(new ArrayList<>(Arrays.asList(role)));

        try {
            adminRepository.save(adminEntity);
            logger.info("User updated role successfully: " + adminEntity);
        } catch (Exception e) {
            logger.error("Error updating user role: " + e.getMessage(), e);
            throw e;
        }

        return role.getName();
    }

    private String getRoleNameByType(Long type) {
        switch (type.intValue()) {
            case Constant.IS_ROLE_ADMIN:
                return "ROLE_ADMIN";
            case Constant.IS_ROLE_MANAGER:
                return "ROLE_MANAGER";
            case Constant.IS_ROLE_EMPLOYEE:
                return "ROLE_EMPLOYEE";
            default:
                throw new IllegalArgumentException("Invalid role type: " + type);
        }
    }

    @Override
    public AccountEntity findByUserName(String userName) {
        return adminRepository.findByUsername(userName);
    }

    @Override
    public AccountEntity findByEmail(String email) {
        return adminRepository.findByEmail(email);
    }

    @Override
    public AccountDTO findByID(Long id) {
        // TODO Auto-generated method stub
        return adminConverter.toDto(adminRepository.findById(id));
    }

    @Override
    public List<AccountDTO> getListUser() {
        List<AccountDTO> userDTOList = new ArrayList<>();
        adminRepository.findAll().forEach(user -> userDTOList.add(adminConverter.toDto(user)));
        return userDTOList;
    }

    @Override
    public String loadTableListUser() {
        // TODO Auto-generated method stub
        List<AccountDTO> adminDTOs = getListUser();
        return outputTableAdmin(adminDTOs);
    }

    public String outputTableAdmin(List<AccountDTO> admins) {
        String contextPath = servletContext.getContextPath();
        StringBuilder output = new StringBuilder();

        for (AccountDTO admin : admins) {
            if (admin.getRoles() != null && !admin.getRoles().isEmpty()) {
                if (admin.getRoles().get(0).getId() == 4) {
                    continue;
                }

                output.append("<tr>")
                        .append("<td><input class=\"form-check-input m-0 align-middle\" type=\"checkbox\" ").append("id=\"checkbox_").append(admin.getId()).append("\" ").append("value=\"").append(admin.getId()).append("\" ").append("aria-label=\"Select admin\"></td>")
                        .append("<td class=\"sort-id\">").append(admin.getId()).append("</td>")
                        .append("<td class=\"sort-name\">").append(admin.getFullname()).append("</td>")
                        .append("<td class=\"sort-account\">").append(admin.getUsername()).append("</td>")
                        .append("<td class=\"sort-email\">").append(admin.getEmail()).append("</td>");

                // Radio button for roles
                int[] roleIds = {1, 2, 3};
                for (int roleId : roleIds) {
                    output.append("<td>")
                            .append("<div class=\"col-auto\">")
                            .append("<label class=\"form-colorinput\">")
                            .append("<input ")
                            .append("name=\"roles").append(admin.getId()).append("\" ")  // Đảm bảo name có giá trị đúng
                            .append("data-admin_id='").append(admin.getId()).append("' ")  // Thêm thuộc tính data-admin_id
                            .append("type=\"radio\" ")
                            .append("value=\"").append(roleId).append("\" ")
                            .append("class=\"check-input-role form-colorinput-input\" ");
                    if (admin.getRoles().get(0).getId() == roleId) {
                        output.append("checked ").append("/>").append("<span class=\"form-colorinput-color bg-indigo rounded-circle\"></span>");
                    } else {
                        output.append("/>").append("<span class=\"form-colorinput-color bg-white rounded-circle\"></span>");
                    }
                    output.append("</label>")
                            .append("</div>")
                            .append("</td>");
                }


                // Action buttons
	 /*           output.append("<td>")
	                  .append("<div style=\"margin-top: 10px\">")
	                  .append("<button type='button' class='btn-sm btn-gradient-dark btn-rounded btn-fw btn-delete-admin-roles' data-admin_id='")
	                  .append(admin.getId()).append("'>Xóa Quyền</button>")
	                  .append("</div>")
	                  .append("<div style=\"margin-top: 10px\">")
	                  .append("<a href='").append(contextPath)
	                  .append("/admin/account-admin/add?admin_id=").append(admin.getId())
	                  .append("'><button type='button' class='btn-sm btn-gradient-danger btn-fw'>Chỉnh sửa</button></a>")
	                  .append("</div>")
	                  .append("</td>")*/
                output.append("</tr>");
            }
        }

        return output.toString();
    }


    @Override
    @Transactional
    public String deleteAdmin(Long id) {
        AccountEntity adminEntity = adminRepository.findById(id);
        adminEntity.getRoles().clear();

        if (adminEntity.getUsername().equals(SecurityUtils.getSessionUser())) {
//            return "permission_error";
            throw new RuntimeException("permission_error");
        }

        try {
            adminRepository.delete(adminEntity);
            logger.info("User deleted successfully: " + adminEntity);
        } catch (Exception e) {
            logger.error("Error deleting user: " + e.getMessage(), e);
            throw new RuntimeException("Error deleting user: " + e.getMessage(), e);
        }

        return "success";
    }

    @Override
    @Transactional
    public void deleteAdmins(long[] ids) {
        // TODO Auto-generated method stub
        for (long id : ids) {
            deleteAdmin(id);
        }

    }

    @Override
    public Integer getTotalItem() {
        // TODO Auto-generated method stub
        return (int) adminRepository.count();
    }

    @Override
    public List<AccountDTO> findAll(Pageable pageable) {
    	Sort sort = new Sort(Sort.Direction.ASC, "username");
        Pageable sortedByName = new PageRequest(pageable.getPageNumber(), pageable.getPageSize(), sort);
        return adminConverter.toListDTO(adminRepository.findAll(sortedByName).getContent());
    }

    @Override
	public List<AccountDTO> findAllDesc(Pageable pageable) {
    	Sort sort = new Sort(Sort.Direction.DESC, "username");
        Pageable sortedByName = new PageRequest(pageable.getPageNumber(), pageable.getPageSize(), sort);
        return adminConverter.toListDTO(adminRepository.findAll(sortedByName).getContent());
	}

    @Override
    public List<AccountDTO> findByUsernameContaining(String username, Pageable pageable) {
        // TODO Auto-generated method stub
        return adminConverter.toListDTO(adminRepository.findByUsernameContaining(username, pageable));
    }

    @Override
    public int countByUsernameLike(String username) {
        // TODO Auto-generated method stub
        return adminRepository.countByUsernameLike("%" + username + "%");
    }

    @Override
    public AccountDTO findByUserNameDTO(String sessionUser) {
        // TODO Auto-generated method stub
        return adminConverter.toDto(findByUserName(sessionUser));
    }

    @Override
    @Transactional
    public void createDefautAdmin() {
        // TODO Auto-generated method stub
        if (adminRepository.count() == 0) {
            AccountEntity adminEntity = new AccountEntity();
            adminEntity.setFullname("Nhân Admin");
            adminEntity.setUsername("admin");
            adminEntity.setEmail("nhan@admin.com");
            adminEntity.setPassword(passwordEncoder.encode("123456"));

            Role role = getRole((long) 1);
            adminEntity.setRoles(Arrays.asList(role));

            try {
                adminRepository.save(adminEntity);
                logger.info("User saved successfully: " + adminEntity);
            } catch (Exception e) {
                logger.error("Error saving user: " + e.getMessage(), e);
                throw e;
            }
        }

    }

    @Override
    public void createDefautRole() {
        // TODO Auto-generated method stub
        if (roleRepository.count() == 0) {
            Role role = new Role();
            role.setName("ROLE_ADMIN");
            roleRepository.save(role);

            Role role1 = new Role();
            role1.setName("ROLE_MANAGER");
            roleRepository.save(role1);

            Role role2 = new Role();
            role2.setName("ROLE_EMPLOYEE");
            roleRepository.save(role2);

            Role role3 = new Role();
            role3.setName("ROLE_USER");
            roleRepository.save(role3);
        }
    }

    @Override
    public List<AccountDTO> findAllByRoleEmployee() {
        return adminConverter.toListDTO(adminRepository.findAllByRoles_Name("ROLE_EMPLOYEE"));
    }

    @Override
    public AccountEntity findByIdAndRoles_name(Long id, String role) {
        return adminRepository.findAccountEntityByIdAndRoles_Name(id, role);
    }


	@Override
	public int countUsersByRoleId(Long roleId) {
		// TODO Auto-generated method stub
		return adminRepository.countUsersByRoleId(roleId);
	}

	@Override
	public List<AccountDTO> findUsersByRoleId(Long roleId, Pageable pageable) {
		// TODO Auto-generated method stub
		return adminConverter.toListDTO(adminRepository.findUsersByRoleId(roleId, pageable));
	}

	
}
