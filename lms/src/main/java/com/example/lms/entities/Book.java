package com.example.lms.entities;

import java.sql.Blob;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Book {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int id;
	
	String name;
	String authors;
	int quantity;
	int ppp;
	Blob image;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAuthors() {
		return authors;
	}
	public void setAuthors(String authors) {
		this.authors = authors;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public int getPpp() {
		return ppp;
	}
	public void setPpp(int ppp) {
		this.ppp = ppp;
	}
	
	public Blob getImage() {
		return image;
	}
	public void setImage(Blob image) {
		this.image = image;
	}
	
	public Book(int id, String name, String authors, int quantity, int ppp, Blob image) {
		super();
		this.id = id;
		this.name = name;
		this.authors = authors;
		this.quantity = quantity;
		this.ppp = ppp;
		this.image = image;
	}
	public Book() {}
	
}
