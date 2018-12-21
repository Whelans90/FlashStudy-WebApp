package com.techelevator.model;

import java.util.List;

import javax.validation.constraints.Size;

public class CardDeck {
	private int deckId;
	private int userId;
	@Size(min=1, max=128, message="Deck name must be between 1 and 128 characters")
	private String name;
	private String description;
	private List<Flashcard> flashcards;
	
	public int getDeckId() {
		return deckId;
	}
	public void setDeckId(int deckId) {
		this.deckId = deckId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public List<Flashcard> getFlashcards() {
		return flashcards;
	}
	public void setFlashcards(List<Flashcard> flashcards) {
		this.flashcards = flashcards;
	}
}
