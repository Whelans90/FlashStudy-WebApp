package com.techelevator.model;

import java.util.List;

public interface CardDeckDAO {
	
	public Flashcard saveFlashcard(int userId, String frontText, String backText, int[] tagId);
	
	public void deleteFlashcard(int cardId);
	
	public Flashcard getFlashcardByCardId(int cardId);
	
	public void assignFlashcardToDeck(int cardId, int deckId);
	
	public void removeFlashcardFromDeck(int cardId, int deckId);
	
	public List<Flashcard> getFlashcardsForDeckOrdered(int deckId);
	
	public List<Flashcard> getFlashcardsForDeckShuffled(int deckId);
	
	public void updateFlashcard(int cardId, String frontText, String backText, int[] tagId);
	
	public void updateFlashcardStudySession(Flashcard flashcard);
	
	public CardDeck saveCardDeck(int userId, String name, String description);
	
	public List<CardDeck> getCardDecksByUserName(String userName);
	
	public List<CardDeck> getAllCardDecks();
	
	public CardDeck getCardDeckByDeckId(int deckId);
	
	public void updateCardDeck(int deckId, String name, String description);
	
	public List<Tag> getAllTags();
	
	public List<Flashcard> searchCardsByTags(String tagNames);

	public List<Flashcard> getFlashcardsByUserId(int userId);
	
	public List<Integer> getAllDeckIdsForCard(int cardId);

}
