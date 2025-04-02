package com.fsoft.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.fsoft.entity.Role;

public interface RoleRepository extends JpaRepository<Role, Long>{
	Role findByName(String nameRole);
}
