package com.example.lms.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.lms.entities.Payment;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, Integer>{
	
	@Query("select p from Payment p where p.username=:username")
	public List<Payment> paymentsOf(String username);
}
