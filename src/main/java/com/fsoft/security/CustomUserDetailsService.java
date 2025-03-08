package com.fsoft.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.fsoft.entity.AccountEntity;
import com.fsoft.repository.AccountRepository;

@Service
public class CustomUserDetailsService implements UserDetailsService {

	private AccountRepository adminRepository;

	@Autowired
	public CustomUserDetailsService(AccountRepository adminRepository) {
		this.adminRepository = adminRepository;
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub

		AccountEntity adminEntity = adminRepository.findFirstByUsername(username);

		if (adminEntity == null) {
			throw new UsernameNotFoundException("User not found with username: " + username);
		}

		return new UserDetails() {
			@Override
			public Collection<? extends GrantedAuthority> getAuthorities() {
				return adminEntity.getRoles().stream().map(role -> new SimpleGrantedAuthority(role.getName()))
						.collect(Collectors.toList());
			}

			@Override
			public String getPassword() {
				return adminEntity.getPassword();
			}

			@Override
			public String getUsername() {
				return adminEntity.getUsername();
			}

			@Override
			public boolean isAccountNonExpired() {
				return true;
			}

			@Override
			public boolean isAccountNonLocked() {
				return true;
			}

			@Override
			public boolean isCredentialsNonExpired() {
				return true;
			}

			@Override
			public boolean isEnabled() {
				return true;
			}
		};
	}

}
