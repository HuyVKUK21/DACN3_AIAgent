package com.fsoft.dto;

public class AuthResponseDTO {
	private String assetToken;
	private String tokenType;
	
	public AuthResponseDTO () {}
	
	
	
	public AuthResponseDTO(String assetToken, String tokenType) {
		super();
		this.assetToken = assetToken;
		this.tokenType = tokenType;
	}



	public String getAssetToken() {
		return assetToken;
	}
	public void setAssetToken(String assetToken) {
		this.assetToken = assetToken;
	}
	public String getTokenType() {
		return tokenType;
	}
	public void setTokenType(String tokenType) {
		this.tokenType = tokenType;
	}
	
	
}
