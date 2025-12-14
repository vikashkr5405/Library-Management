package com.vikash.Library_Management.controller;

import com.vikash.Library_Management.entity.Book;
import com.vikash.Library_Management.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable; // <-- MUST BE IMPORTED
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class BookController {

    @Autowired
    private BookRepository bookRepository;

    // --- 1. Display All Books (Read) ---
    // Handles requests to the homepage (http://localhost:8080/)
    @GetMapping("/")
    public String listBooks(Model model) {
        model.addAttribute("books", bookRepository.findAll());
        return "list_books";
    }

    // --- 2. Show Add Form (Create) ---
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("book", new Book());
        return "add_book";
    }

    // --- 3. Save/Update Book (Create/Update) ---
    @PostMapping("/save")
    public String saveBook(Book book) {
        bookRepository.save(book);
        return "redirect:/";
    }

    // --- 4. Toggle Status (Borrow/Return - Update) ---
    @GetMapping("/toggle/{id}")
    public String toggleBookStatus(@PathVariable("id") Long id) {
        Book book = bookRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid book Id:" + id));

        // Inverting the status
        book.setBorrowed(!book.isBorrowed());

        bookRepository.save(book);
        return "redirect:/";
    }

    // --- 5. Show Edit Form (Update) ---
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model) {
        Book book = bookRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid book Id:" + id));

        model.addAttribute("book", book);
        return "add_book"; // Reuses the add_book form
    }

    // --- 6. Delete Book (Delete) ---
    @GetMapping("/delete/{id}")
    public String deleteBook(@PathVariable("id") Long id) {
        Book book = bookRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid book Id:" + id));

        bookRepository.delete(book);
        return "redirect:/";
    }
}