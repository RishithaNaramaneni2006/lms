package com.example.lms.controller;

import java.io.IOException;
import java.security.Principal;
import java.sql.Blob;
import java.sql.SQLException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import com.example.lms.entities.Book;
import com.example.lms.entities.Borrow;
import com.example.lms.entities.Payment;
import com.example.lms.entities.Rating;
import com.example.lms.entities.User;
import com.example.lms.services.BookService;
import com.example.lms.services.BorrowService;
import com.example.lms.services.PaymentService;
import com.example.lms.services.RatingService;
import com.example.lms.services.UserService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class AppController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private RatingService ratingService;
	
	@Autowired
	private BorrowService borrowService;
	
	@Autowired
	private PaymentService paymentService;
	
	@GetMapping("/")
	public String index() {
		return "redirect:/login";
	}
	
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	@GetMapping("/register")
	public String register(Model model) throws JsonProcessingException {
		List<User> users = userService.findAll();
	    List<String> numberslist = new ArrayList<>();
	    for (User user : users) {
	        numberslist.add(user.getUsername());
	    }

	    ObjectMapper mapper = new ObjectMapper();
	    String numberslistJson = mapper.writeValueAsString(numberslist);

	    model.addAttribute("numberslist", numberslistJson);
	    return "register";
	
	}
	
	@PostMapping("/register")
	public String registration(@ModelAttribute("user") User user) {
		userService.addUser(user);
		return "redirect:/register";
	}
	
	@GetMapping("/home")
	public String home(Model model,Principal principal) {
		User user=userService.findByUsername(principal.getName());
		model.addAttribute("user", user);
		int totalBooks=bookService.findAll().size();
		int borrowedBooks=borrowService.findAll().size();
		int totalUsers=userService.findUsers().size();
		model.addAttribute("totalBooks",totalBooks);
		model.addAttribute("borrowedBooks",borrowedBooks);
		model.addAttribute("totalUsers",totalUsers);
		return "home";
	}
	
	@GetMapping("/users")
	public String users(Model model) {
		model.addAttribute("users",userService.findUsers());
		return "users";
	}
	
	@GetMapping("/addbook")
	public String addbooks() {
		return "addbook";
	}
	
	@PostMapping("/addbook")
	public String addbook(@RequestParam("bookimage") MultipartFile file,@ModelAttribute("book") Book book,HttpServletRequest request) throws IOException, SerialException, SQLException{
		byte[] bytes = file.getBytes();
        Blob blob = new javax.sql.rowset.serial.SerialBlob(bytes);
        book.setImage(blob);
        bookService.addbook(book);
        return "redirect:/Books";
	}
	
	@GetMapping("/bookimage/{id}")
	public ResponseEntity<byte[]> displayImage(@PathVariable("id") int id)throws IOException, SQLException{
		Book image=bookService.findById(id);
		byte[] imageBytes=null;
		imageBytes=image.getImage().getBytes(1,(int) image.getImage().length());
		return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(imageBytes);
	}
	
	@GetMapping("/books")
	public String Books(Model model,Principal principal) {
		User user=userService.findByUsername(principal.getName());
		model.addAttribute("user", user);
		List<Book> books=bookService.findAll();
		model.addAttribute("books", books);
		List<String> ratings=new ArrayList<String>();
		for(Book b:books) {
			ratings.add(Float.toString(ratingService.brating(b.getId())));
		}
		model.addAttribute("ratings", ratings);
		return "Books";
	}
	
	@GetMapping("/book/{id}")
	public String book(@PathVariable int id,Model model,Principal principal) {
		Book book=bookService.findById(id);
		model.addAttribute("book", book);
		User user=userService.findByUsername(principal.getName());
		model.addAttribute("user", user);
		String isr=ratingService.isRated(id,user.getUsername())?"yes":"no";
		model.addAttribute("isr", isr);
		String rating=Float.toString(ratingService.brating(id));
		model.addAttribute("rating", rating);
		String isb=borrowService.isBorrowedby(id,user.getUsername())?"y":"n";
		String isnb=isb.equals("y")?"n":"y";
		if(book.getQuantity()==0) {
			isb="y";
		}
		model.addAttribute("isb", isb);
		model.addAttribute("isnb", isnb);
		return "book";
	}
	
	@PostMapping("/submitRating")
	public String submitRating(@ModelAttribute("rating") Rating rating) {
		ratingService.addRating(rating);
		return "redirect:/book/"+rating.getBookId();
	}
	
	public static String getCurrentDateTime() {
        ZonedDateTime now = ZonedDateTime.now(ZoneId.systemDefault());
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd-HH-mm-ss");
        return now.format(formatter);
    }
	
	public static float getMinutesDifference(String dateTime1, String dateTime2) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd-HH-mm-ss");
        LocalDateTime dt1 = LocalDateTime.parse(dateTime1, formatter);
        LocalDateTime dt2 = LocalDateTime.parse(dateTime2, formatter);
        Duration duration = Duration.between(dt1, dt2);
        float hours = duration.toMinutes();

        return hours;
    }
	
	@PostMapping("/borrow")
	public String borrow(@ModelAttribute("borrow") Borrow borrow) {
		borrow.setDate_time(getCurrentDateTime());
		bookService.updateQuantity(borrow.getBookId(), bookService.findById(borrow.getBookId()).getQuantity()-1);
		borrowService.borrowBook(borrow);
		return "redirect:/book/"+borrow.getBookId();
	}
	
	@PostMapping("/deposit")
	public String deposit(@ModelAttribute("deposit") Borrow deposit) {
		Borrow dep=borrowService.getB(deposit.getBookId(),deposit.getUsername());
		deposit.setDate_time(dep.getDate_time());
		bookService.updateQuantity(deposit.getBookId(), bookService.findById(deposit.getBookId()).getQuantity()+1);
		String cd=getCurrentDateTime();
		float mins=getMinutesDifference(deposit.getDate_time(),cd);
		Book book=bookService.findById(deposit.getBookId());
		mins*=book.getPpp();
		mins/=60;
		userService.updateDue(deposit.getUsername(),mins);
		borrowService.depositeBook(deposit);
		return "redirect:/book/"+deposit.getBookId();
	}
	
	@GetMapping("/borrows")
	public String borrows(Principal principal,Model model) {
		User user=userService.findByUsername(principal.getName());
		List<Borrow> borrows;
		if(user.getRole().equals("ADMIN")) borrows=borrowService.findAll();
		else borrows=borrowService.borrowsOf(user.getUsername());
		model.addAttribute("borrows", borrows);
		List<List<String>> ext=new ArrayList<List<String>>();
		for(Borrow b:borrows) {
			List<String> e=new ArrayList<String>();
			Book book=bookService.findById(b.getBookId());
			e.add(book.getName());
			User u=userService.findByUsername(b.getUsername());
			e.add(u.getName());
			ext.add(e);
		}
		model.addAttribute("user", user);
		model.addAttribute("ext", ext);
		return "borrows";
	}
	
	@GetMapping("/payments")
	public String payments(Principal principal,Model model) {
		User user=userService.findByUsername(principal.getName());
		List<Payment> payments=user.getRole().equals("ADMIN")?paymentService.findAll():
			paymentService.paymentsOf(user.getUsername());
		model.addAttribute("payments", payments);
		List<String> ext=new ArrayList<String>();
		for(Payment p:payments) {
			User u=userService.findByUsername(p.getUsername());
			ext.add(u.getName());
		}
		model.addAttribute("ext", ext);
		model.addAttribute("user", user);
		List<User> users=userService.findUsers();
		List<String> usernames=new ArrayList<String>();
		for(User u:users) usernames.add(u.getUsername());
		model.addAttribute("usernames", usernames);
		String r=user.getRole().equals("ADMIN")?"y":"n";
		model.addAttribute("r", r);
		return "payments";
	}
	
	@PostMapping("/addPayment")
	public String addPayment(@ModelAttribute("payment") Payment payment) {
		payment.setDate_time(getCurrentDateTime());
		paymentService.pay(payment);
		userService.updateDue(payment.getUsername(),
				userService.findByUsername(payment.getUsername()).getDue()-payment.getPaid());
		return "redirect:/payments";
	}
	
}
