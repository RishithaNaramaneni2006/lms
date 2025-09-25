package com.example.lms.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.lms.entities.User;

@Repository
public interface UserRepository extends JpaRepository<User, Integer>{
	public User findByUsername(String username);
	
	@Query("select u from User u where u.role='USER'")
	public List<User> findUsers();
}
