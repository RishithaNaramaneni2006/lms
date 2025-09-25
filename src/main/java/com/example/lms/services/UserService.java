package com.example.lms.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.lms.entities.User;
import com.example.lms.repository.UserRepository;


@Service
public class UserService {
	
	@Autowired
	private UserRepository ur;

	public UserService(UserRepository ur) {
		super();
		this.ur = ur;
	}
	
	public User findByUsername(String username) {
		return ur.findByUsername(username);
	}
	
	public void addUser(User user) {
		ur.save(user);
	}
	
	public List<User> findAll(){
		return ur.findAll();
	}
	
	public void updateDue(String username,float due) {
		User user=ur.findByUsername(username);
		user.setDue(due);
		ur.save(user);
	}
	
	public List<User> findUsers(){
		return ur.findUsers();
	}

}
