package com.example.lms.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.lms.entities.Book;
import com.example.lms.repository.BookRepository;

@Service
public class BookService {
	
	@Autowired
	private BookRepository bookRepository;
	
	public Book findById(int id) {
		return bookRepository.getById(id);
	}
	
	public void addbook(Book book) {
		bookRepository.save(book);
	}
	
	public List<Book> findAll(){
		return bookRepository.findAll();
	}
	
	public void updateQuantity(int id,int q) {
		Book book=bookRepository.getById(id);
		book.setQuantity(q);
		bookRepository.save(book);
	}

}
