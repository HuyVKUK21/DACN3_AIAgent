package com.fsoft.dto;

import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fsoft.entity.Role;

public class AccountDTO extends BaseDTO<AccountDTO> {
    private Long id;

    @NotEmpty(message = "{NotEmpty.fullname}")
    @Size(max = 50, message = "{Size.fullname}")
    private String fullname;

    @NotEmpty(message = "{NotEmpty.username}")
    @Size(min = 5, max = 20, message = "{Size.username}")
    private String username;

    @NotEmpty(message = "{NotEmpty.email}")
    @Email(message = "{Email.email}")
    private String email;

    @NotEmpty(message = "{NotEmpty.password}")
    @Size(min = 6, message = "{Size.password}")
    private String password;

    @NotNull(message = "{NotNull.typeRole}")
    private Long typeRole;

    private List<Role> roles = new ArrayList<>();

    public AccountDTO() {
        
    }

    public AccountDTO(Long id, String fullname, String username, String email, String password, Long typeRole) {
       
        this.id = id;
        this.fullname = fullname;
        this.username = username;
        this.email = email;
        this.password = password;
        this.typeRole = typeRole;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

    public Long getTypeRole() {
        return typeRole;
    }

    public void setTypeRole(Long typeRole) {
        this.typeRole = typeRole;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }


    
}
