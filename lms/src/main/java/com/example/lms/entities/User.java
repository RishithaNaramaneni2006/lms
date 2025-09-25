package com.example.lms.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	int id;
	
	String username;
	String name;
	String password;
	String email;
	String role;
	String address;
	float due;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public float getDue() {
		return due;
	}
	public void setDue(float due) {
		this.due = due;
	}
	
	public User(int id, String username, String name, String password, String email, String role, String address,
			float due) {
		super();
		this.id = id;
		this.username = username;
		this.name = name;
		this.password = password;
		this.email = email;
		this.role = role;
		this.address = address;
		this.due = due;
	}
	public User() {}
	
}
