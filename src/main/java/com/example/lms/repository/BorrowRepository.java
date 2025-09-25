package com.example.lms.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.lms.entities.Borrow;

import jakarta.transaction.Transactional;

@Repository
public interface BorrowRepository extends JpaRepository<Borrow, Integer>{

	@Query("select b from Borrow b where b.bookId=:id and b.username=:username")
	public Borrow isborrowedby(int id,String username);
	
	@Modifying
    @Transactional
    @Query("DELETE FROM Borrow b WHERE b.bookId = :bookId AND b.username = :username")
    public void delete(int bookId, String username);
	
	@Query("select b from Borrow b where b.username=:username")
	public List<Borrow> borrowsOf(String username);
}
