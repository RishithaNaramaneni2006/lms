package com.example.lms.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.lms.entities.Borrow;
import com.example.lms.repository.BorrowRepository;

@Service
public class BorrowService {
	
	@Autowired
	private BorrowRepository borrowRepository;
	
	public void borrowBook(Borrow borrow) {
		borrowRepository.save(borrow);
	}
	
	public void depositeBook(Borrow borrow) {
		borrowRepository.delete(borrow.getBookId(),borrow.getUsername());;
	}
	
	public boolean isBorrowedby(int id,String username) {
		Borrow b=borrowRepository.isborrowedby(id, username);
		if(b==null) return false;
		return true;
	}
	
	public Borrow getB(int id,String username) {
		Borrow b=borrowRepository.isborrowedby(id, username);
		return b;
	}
	
	public List<Borrow> findAll(){
		return borrowRepository.findAll();
	}
	
	public List<Borrow> borrowsOf(String username){
		return borrowRepository.borrowsOf(username);
	}

}
