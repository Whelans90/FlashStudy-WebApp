package com.techelevator.model;

import java.util.List;

public class Flashcard {
	private int cardId;
	private int userId;
	private int deckId;  // Now represents current deck only
	private List<Integer> allDeckIds;
	private String frontText;
	private String backText;
	private List<Integer> tagIds;
	private boolean isCorrect; 
	
	public int getCardId() {
		return cardId;
	}
	public void setCardId(int cardId) {
		this.cardId = cardId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getDeckId() {
		return deckId;
	}
	public void setDeckId(int deckId) {
		this.deckId = deckId;
	}
	public List<Integer> getAllDeckIds() {
		return this.allDeckIds;
	}
	public void setAllDeckIds(List<Integer> allDeckIds) {
		this.allDeckIds = allDeckIds;
	}
	public String getFrontText() {
		return frontText;
	}
	public void setFrontText(String frontText) {
		this.frontText = frontText;
	}
	public String getBackText() {
		return backText;
	}
	public void setBackText(String backText) {
		this.backText = backText;
	}
	public List<Integer> getTagIds() {
		return tagIds;
	}
	public void setTagIds(List<Integer> tagIds) {
		this.tagIds = tagIds;
	}
	public boolean getIsCorrect() {
		return isCorrect;
	}
	public void setIsCorrect(boolean isCorrect) {
		this.isCorrect = isCorrect;
	}
}
