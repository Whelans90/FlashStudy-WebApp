package com.techelevator.model.test;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.techelevator.model.CardDeck;
import com.techelevator.model.CardDeckDAO;
import com.techelevator.model.Flashcard;
import com.techelevator.model.JDBCCardDeckDAO;


public class DAOCardDeckTest extends DAOIntegrationTest {

	CardDeckDAO dao = new JDBCCardDeckDAO(getDataSource());
	JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());
	
	// Dummy data
	private static final int USER_ID = 999999;
	private static final String USER_NAME = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	private static final String PASSWORD = "password";
	private static final String SALT = "salt";
	private static final int CARD_ID = 999999;
	private static final int DECK_ID = 999999;
	
	@Test
	public void testSaveFlashcard() {
		createDummyUser();
		
		String sqlStatement = "SELECT COUNT(card_id) FROM flashcard";
		SqlRowSet result = jdbcTemplate.queryForRowSet(sqlStatement);
		result.next();
		int pretestNumberOfCards = result.getInt("count");
		int [] tags = new int[] {1,2};
		
		dao.saveFlashcard(USER_ID, "Front Text", "Back Text", tags);
		
		result = jdbcTemplate.queryForRowSet(sqlStatement);
		result.next();
		int posttestNumberOfCards = result.getInt("count");
		
		assertEquals("Test: saveFlashcard", pretestNumberOfCards + 1, posttestNumberOfCards);
	}
	
	@Test
	public void testGetFlashcardByCardId() {
		createDummyUser();
		
		createDummyFlashcards(1);
		
		Flashcard flashcard = dao.getFlashcardByCardId(CARD_ID);
		
		assertEquals("Test: getFlashcardByCardId", "Front Text " + CARD_ID, flashcard.getFrontText());
		assertEquals("Test: getFlashcardByCardId", CARD_ID, flashcard.getCardId());
	}
	
	@Test
	public void testAssignFlashcardToDeck() {
		createDummyUser();
		createDummyCardDecks(1);
		createDummyFlashcards(3);
		
		for(int i = CARD_ID; i < (CARD_ID + 3); i++) {
			dao.assignFlashcardToDeck(i, DECK_ID);
		}
		
		assertEquals("Test: assignFlashcardToDeck (3 cards)", 3, dao.getCardDeckByDeckId(DECK_ID).getFlashcards().size());
	}
	
	@Test
	public void testRemoveFlashcardFromDeck() {
		createDummyUser();
		createDummyCardDecks(1);
		createDummyFlashcards(1);
		
		dao.assignFlashcardToDeck(CARD_ID, DECK_ID);
		assertEquals("Test: remove card setup", 1, dao.getCardDeckByDeckId(DECK_ID).getFlashcards().size());
		
		dao.removeFlashcardFromDeck(CARD_ID, DECK_ID);
		assertEquals("Test: removeFlashcardToDeck", 0, dao.getCardDeckByDeckId(DECK_ID).getFlashcards().size());
	}
	
	@Test
	public void testGetFlashcardsForDeck() {
		createDummyUser();
		createDummyCardDecks(1);
		createDummyFlashcards(3);
		
		for(int i = CARD_ID; i < (CARD_ID + 3); i++) {
			dao.assignFlashcardToDeck(i, DECK_ID);
		}
		
		List<Flashcard> testCardList = dao.getFlashcardsForDeckOrdered(DECK_ID);
		
		assertEquals("Test: getFlashcardsForDeck (3 cards)", 3, testCardList.size());
	}
	
	@Test
	public void testUpdateFlashcard() {
		createDummyUser();
		
		createDummyFlashcards(1);
		
		dao.updateFlashcard(CARD_ID, "New Front Text", "New Back Text", new int[] {1});
		
		assertEquals("Test: updateFlashcard (front text)", "New Front Text", dao.getFlashcardByCardId(CARD_ID).getFrontText());
		assertEquals("Test: updateFlashcard (back text)", "New Back Text", dao.getFlashcardByCardId(CARD_ID).getBackText());
	}
	
	@Test 
	public void testSaveCardDeck() {
		createDummyUser();
		String sqlStatement = "SELECT COUNT(deck_id) FROM deck";
		SqlRowSet result = jdbcTemplate.queryForRowSet(sqlStatement);
		result.next();
		int pretestNumberOfDecks = result.getInt("count");
		
		dao.saveCardDeck(USER_ID, "Test Deck", "This is a deck used for integration tests.");
		
		result = jdbcTemplate.queryForRowSet(sqlStatement);
		result.next();
		int posttestNumberOfDecks = result.getInt("count");
		
		assertEquals("Test: saveFlashcard", pretestNumberOfDecks + 1, posttestNumberOfDecks);
	}
	
	@Test 
	public void testGetAllCardDecks() {
		createDummyUser();
		String sqlStatement = "SELECT COUNT(deck_id) FROM deck";
		SqlRowSet result = jdbcTemplate.queryForRowSet(sqlStatement);
		result.next();
		int pretestNumberOfDecks = result.getInt("count");
		
		dao.saveCardDeck(USER_ID, "Test Deck", "This is a deck used for integration tests.");
		
		List<CardDeck> allDecks = dao.getAllCardDecks();
		
		assertEquals("Test: saveFlashcard", pretestNumberOfDecks + 1, allDecks.size());
	}
	
	@Test
	public void testGetCardDeckByDeckId() {
		createDummyUser();
		createDummyCardDecks(1);
		
		CardDeck testDeck = dao.getCardDeckByDeckId(DECK_ID);
		
		assertEquals("Test: getCardDeckByDeckId", DECK_ID, testDeck.getDeckId());
	}
	
	@Test
	public void testGetCardDecksByUserName() {
		createDummyUser();
		createDummyCardDecks(3);
		
		List<CardDeck> testDeckList = dao.getCardDecksByUserName(USER_NAME);
		
		assertEquals("Test: getCardDecksByUserId", 3, testDeckList.size());
	}
	
	@Test
	public void testUpdateCardDeck() {
		createDummyUser();
		createDummyCardDecks(1);
		
		dao.updateCardDeck(DECK_ID, "Test Name 2", "Here's a description.");
		
		assertEquals("Test: updateCardDeck (name)", "Test Name 2", dao.getCardDeckByDeckId(DECK_ID).getName());
		assertEquals("Test: updateCardDeck (description)", "Here's a description.", 
				dao.getCardDeckByDeckId(DECK_ID).getDescription());
	}
	
	private void createDummyUser() {
		String sqlCreateDummyUser = "INSERT INTO app_user (user_id, user_name, password, salt) VALUES (?, ?, ?, ?);";
		jdbcTemplate.update(sqlCreateDummyUser, USER_ID, USER_NAME, PASSWORD, SALT);
	}
	
	private void createDummyFlashcards(int num) {
		for(int i = CARD_ID; i < (CARD_ID + num); i++) {
			String sqlCreateDummyFlashcard = "INSERT INTO flashcard (card_id, user_id, front_text, back_text) "
					+ "VALUES (?, ?, ?, ?);";
			jdbcTemplate.update(sqlCreateDummyFlashcard, i, USER_ID, "Front Text " + i, "Back Text " + i);
		}
	}
	
	private void createDummyCardDecks(int num) {
		for(int i = DECK_ID; i < (DECK_ID + num); i++) {
			String sqlCreateDummyDeck = "INSERT INTO deck (deck_id, user_id, name) VALUES (?, ?, ?);";
			jdbcTemplate.update(sqlCreateDummyDeck, i, USER_ID, "Test Name " + i);
		}
	}

}
