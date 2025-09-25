package com.example.lms.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.lms.entities.Rating;

@Repository
public interface RatingRepository extends JpaRepository<Rating, Integer>{

	@Query("select r.rating from Rating r where r.bookId= :id")
	public List<Integer> ratingsOfBook(int id);
	
	@Query("select r from Rating r where r.bookId=:id and r.username=:username")
	public Rating findRating(int id,String username);
	
}
