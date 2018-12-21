package com.techelevator.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

@Component
public class JDBCCardDeckDAO implements CardDeckDAO {
	
	private JdbcTemplate jdbcTemplate;

	@Autowired
	public JDBCCardDeckDAO(DataSource datasource) {
		this.jdbcTemplate = new JdbcTemplate(datasource);
	}

	@Override
	public Flashcard saveFlashcard(int userId, String frontText, String backText, int[] tagId) {
		
		
		jdbcTemplate.update("INSERT INTO flashcard (user_id, front_text, back_text) VALUES(?, ?, ?)", userId,
				frontText, backText);
		
		SqlRowSet result = jdbcTemplate.queryForRowSet("SELECT currval('seq_card_id');");
		result.next();
		int currval = result.getInt("currval");
		
		//Stores Multiple tag ids to a single card
		for(int id : tagId) {
			jdbcTemplate.update("INSERT INTO card_tag (card_id, tag_id) VALUES(?, ?)", currval, id);
		}
		
		return getFlashcardByCardId(currval);
	}
	
	@Override
	public void deleteFlashcard(int cardId) {
		String sqlDeleteFlashcard = "DELETE FROM card_deck " + 
				"WHERE card_id = ?; " + 
				"DELETE FROM card_tag " + 
				"WHERE card_id = ?; " + 
				"DELETE FROM flashcard " + 
				"WHERE card_id = ?;";
		jdbcTemplate.update(sqlDeleteFlashcard, cardId, cardId, cardId);
		
	}

	@Override
	public Flashcard getFlashcardByCardId(int cardId) {
		String sqlGetFlashcardById = "SELECT * FROM flashcard WHERE card_id = ?";
		SqlRowSet result = jdbcTemplate.queryForRowSet(sqlGetFlashcardById, cardId);
		Flashcard flashcard = null;
		if (result.next()) {
			flashcard = mapRowToCard(result);
		}
		return flashcard;
	}
	
	@Override
	public List<Flashcard> getFlashcardsByUserId(int userId) {
		List<Flashcard> allCards = new ArrayList<Flashcard>();
		String sqlGetFlashcardById = "SELECT * FROM flashcard WHERE user_id = ?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetFlashcardById, userId);
		while(results.next()) {
			allCards.add(mapRowToCard(results));
		
		}
		return allCards;
	}
	
	@Override
	public void assignFlashcardToDeck(int cardId, int deckId) {
		String sqlAssignFlashcardToDeck = "INSERT INTO card_deck (card_id, deck_id) VALUES (?, ?) "
				+ "ON CONFLICT (card_id, deck_id) DO NOTHING;";
		jdbcTemplate.update(sqlAssignFlashcardToDeck, cardId, deckId);
	}
	
	@Override
	public void removeFlashcardFromDeck(int cardId, int deckId) {
		String sqlRemoveFlashcardFromDeck = "DELETE FROM card_deck WHERE card_id = ? AND deck_id = ?;";
		jdbcTemplate.update(sqlRemoveFlashcardFromDeck, cardId, deckId);
		
	}
	
	@Override
	public List<Flashcard> getFlashcardsForDeckOrdered(int deckId) {
		String sqlGetFlashcardsForDeck = "SELECT * FROM flashcard JOIN card_deck ON flashcard.card_id = card_deck.card_id "
				+ "WHERE deck_id = ? ORDER BY flashcard.card_id";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetFlashcardsForDeck, deckId);
		List<Flashcard> flashcards = new ArrayList<>();
		while(results.next()) {
			flashcards.add(mapRowToCardWithIsRight(results));
		}
		return flashcards;
	}
	
	@Override
	public List<Flashcard> getFlashcardsForDeckShuffled(int deckId) {
		String sqlGetFlashcardsForDeck = "SELECT * FROM flashcard JOIN card_deck ON flashcard.card_id = card_deck.card_id "
				+ "WHERE deck_id = ? ORDER BY flashcard.card_id";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetFlashcardsForDeck, deckId);
		List<Flashcard> flashcards = new ArrayList<>();
		while(results.next()) {
			flashcards.add(mapRowToCardWithIsRight(results));
		}
		Collections.shuffle(flashcards);
		return flashcards;
	}

	@Override
	public void updateFlashcard(int cardId, String frontText, String backText, int[] tagId) {
		jdbcTemplate.update("UPDATE flashcard SET front_text = ?, back_text = ? WHERE card_id = ?",
				frontText, backText, cardId);
		// "Remove" tags by wiping everything out and reapplying them
		jdbcTemplate.update("DELETE FROM card_tag WHERE card_id = ?", cardId);
		//Stores Multiple tag ids to a single card
		for(int id : tagId) {
			jdbcTemplate.update("INSERT INTO card_tag (card_id, tag_id) VALUES(?, ?) "
					+ "ON CONFLICT (card_id, tag_id) DO NOTHING;", cardId, id);
		} 

	}
	
	// The flashcard parameter must have an assigned deckId for this function to work correctly.
	@Override
	public void updateFlashcardStudySession(Flashcard flashcard) {
		jdbcTemplate.update("UPDATE card_deck SET isright = ? "
				+ "FROM flashcard WHERE card_deck.card_id = flashcard.card_id "
				+ "AND card_deck.card_id = ? AND card_deck.deck_id = ?", 
				flashcard.getIsCorrect(), 
				flashcard.getCardId(), 
				flashcard.getDeckId());
		
	}
	
	@Override
	public CardDeck saveCardDeck(int userId, String name, String description) {
		jdbcTemplate.update("INSERT INTO deck (user_id, name, description) VALUES (?, ?, ?);", 
				userId, name, description);
		
		SqlRowSet result = jdbcTemplate.queryForRowSet("SELECT currval('seq_deck_id');");
		result.next();
		
		
		
		return getCardDeckByDeckId(result.getInt("currval"));

	}

	@Override
	public List<CardDeck> getAllCardDecks() {
		String sqlGetAllCardDecks = "SELECT * FROM deck;";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetAllCardDecks);
		List<CardDeck> allCardDecks = new ArrayList<>();
		while(results.next()) {
			CardDeck cardDeck = mapRowToDeck(results);
			allCardDecks.add(cardDeck);
		}
		return allCardDecks;
	}

	@Override
	public CardDeck getCardDeckByDeckId(int deckId) {
		String sqlGetAllCardDecks = "SELECT * FROM deck WHERE deck_id = ?;";
		SqlRowSet result = jdbcTemplate.queryForRowSet(sqlGetAllCardDecks, deckId);
		CardDeck cardDeck = null;
		if(result.next()) {
			cardDeck = mapRowToDeck(result);
		}
		return cardDeck;
	}
	
	@Override
	public List<CardDeck> getCardDecksByUserName(String userName) {
		String sqlGetAllCardDecks = "SELECT * FROM deck"+
									" JOIN app_user ON deck.user_id = app_user.user_id"+""
									+ " WHERE app_user.user_name = ?;";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetAllCardDecks, userName);
		CardDeck cardDeck = null;
		List<CardDeck> allCardDecks = new ArrayList<>();
		while(results.next()) {
			cardDeck = mapRowToDeck(results);
			allCardDecks.add(cardDeck);
		}
		return allCardDecks;
	}

	@Override
	public void updateCardDeck(int deckId, String name, String description) {
		jdbcTemplate.update("UPDATE deck SET name = ?, description = ? WHERE deck_id = ?", 
				name, description, deckId);
	}
	
	@Override
	public List<Tag> getAllTags() {
		String sqlGetAllTags = "SELECT * FROM tag";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetAllTags);
		List<Tag> tagList = new ArrayList<>();
		while(results.next()) {
			Tag tag = new Tag();
			tag.setTagId(results.getInt("tag_id"));
			tag.setName(results.getString("name"));
			tagList.add(tag);
		}
		return tagList;
	}
	
	@Override
	public List<Flashcard> searchCardsByTags(String tagName) {
		String name = tagName.toLowerCase();
		String sqlGetFlashcards = "SELECT * FROM flashcard JOIN card_tag ON flashcard.card_id = card_tag.card_id "
				+ "JOIN tag ON card_tag.tag_id = tag.tag_id "
				+ "WHERE tag.name ILIKE ?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetFlashcards, name);
		List<Flashcard> flashcards = new ArrayList<>();
		while(results.next()) {
			flashcards.add(mapRowToCard(results));
		}
		return flashcards;
	}
	
	
	private Flashcard mapRowToCard(SqlRowSet results) {
		Flashcard flashcard = new Flashcard();
		flashcard.setCardId(results.getInt("card_id"));
		flashcard.setUserId(results.getInt("user_id"));
		flashcard.setFrontText(results.getString("front_text"));
		flashcard.setBackText(results.getString("back_text"));
		flashcard.setTagIds(getCardTags(flashcard.getCardId()));
		return flashcard;
	}
	
	private Flashcard mapRowToCardWithIsRight(SqlRowSet results) {
		Flashcard flashcard = mapRowToCard(results);
		flashcard.setDeckId(results.getInt("deck_id"));  // Make sure this doesn't cause trouble for us
		flashcard.setIsCorrect(results.getBoolean("isright"));
		return flashcard;
	}
	
	private CardDeck mapRowToDeck(SqlRowSet results) {
		CardDeck cardDeck = new CardDeck();
		cardDeck.setDeckId(results.getInt("deck_id"));
		cardDeck.setUserId(results.getInt("user_id"));
		cardDeck.setName(results.getString("name"));
		cardDeck.setDescription(results.getString("description"));
		cardDeck.setFlashcards(getFlashcardsForDeckOrdered(results.getInt("deck_id")));	//Keep an eye on this
		return cardDeck;
	}
	
	private List<Integer> getCardTags(int cardId) {
		String sqlGetCardTags = "SELECT tag_id FROM flashcard "
				+ "JOIN card_tag ON flashcard.card_id = card_tag.card_id "
				+ "WHERE flashcard.card_id = ?;";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetCardTags, cardId);
		List<Integer> tagIds = new ArrayList<>();
		while(results.next()) {
			tagIds.add(results.getInt("tag_id"));
		}
		return tagIds;
	}
	
	public List<Integer> getAllDeckIdsForCard(int cardId) {
		String sqlGetDeckIds = "SELECT deck_id FROM flashcard JOIN card_deck "
				+ "ON flashcard.card_id = card_deck.card_id "
				+ "WHERE flashcard.card_id = ?;";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetDeckIds, cardId);
		List<Integer> deckIds = new ArrayList<>();
		while(results.next()) {
			deckIds.add(results.getInt("deck_id"));
		}
		return deckIds;
	}

}
