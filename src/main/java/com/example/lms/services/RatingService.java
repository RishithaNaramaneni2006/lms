package com.example.lms.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.lms.entities.Rating;
import com.example.lms.repository.RatingRepository;

@Service
public class RatingService {
	
	@Autowired
	private RatingRepository rr;
	
	public void addRating(Rating rating) {
		rr.save(rating);
	}
	
	public float brating(int id) {
		List<Integer> ratings=rr.ratingsOfBook(id);
		float sum=0;
		for(int i:ratings) sum+=i;
		float rating=sum/ratings.size();
		return rating;
	}
	
	public boolean isRated(int id,String username) {
		Rating r=rr.findRating(id, username);
		if(r==null) return false;
		return true;
	}

}
