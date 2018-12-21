package com.techelevator.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.techelevator.model.CardDeck;
import com.techelevator.model.CardDeckDAO;
import com.techelevator.model.Flashcard;
import com.techelevator.model.User;

@Controller
public class StudySessionController {
	
	private CardDeckDAO cardDeckDAO;

	@Autowired
	public StudySessionController(CardDeckDAO cardDeckDAO) {
		this.cardDeckDAO = cardDeckDAO;
	}
	
	@RequestMapping(path = "/studysession/{deckName}", method = RequestMethod.GET)
	public String beginStudySession(@PathVariable("deckName") String deckName, HttpSession session, RedirectAttributes redirAttribs, 
			@RequestParam(required=false) String sessionType) {
		if(!(boolean)session.getAttribute("quizIsActive")) {
			CardDeck deck = null;
			@SuppressWarnings("unchecked")
			List<CardDeck> decks = (List<CardDeck>) session.getAttribute("decks");
			for (CardDeck item : decks) {
				if (item.getName().equals(deckName)) {
					deck = item;
				}
			}
			// Select which type of study session
			if(sessionType.equals("standard")) {
				deck.setFlashcards(cardDeckDAO.getFlashcardsForDeckOrdered(deck.getDeckId()));
			} else if(sessionType.equals("random")) {
				deck.setFlashcards(cardDeckDAO.getFlashcardsForDeckShuffled(deck.getDeckId()));
			}
			if(deck.getFlashcards().size() <1 ) {
				List<String> errorMessages = new ArrayList<String>();
				errorMessages.add("Please Add A Card To Begin A Study Session");
				redirAttribs.addFlashAttribute("errorMessages", errorMessages);
				return "redirect:/home/";
			}
			// wipe out pre-existing answers
			for (Flashcard card : deck.getFlashcards()) {
				card.setIsCorrect(false);
				cardDeckDAO.updateFlashcardStudySession(card);
			}
			session.setAttribute("deck", deck);
			session.setAttribute("sessionLength", deck.getFlashcards().size());
			session.setAttribute("currVal", 0);
			session.setAttribute("card", deck.getFlashcards().get((int) session.getAttribute("currVal")));
			session.setAttribute("quizIsActive", true);
		}
		return "studySession";
	}
	
//	@RequestMapping(path = "/studysession/random/{deckName}", method = RequestMethod.GET)
//	public String beginRandomStudySession(@PathVariable("deckName") String deckName, HttpSession session, RedirectAttributes redirAttribs) {
//		if(!(boolean)session.getAttribute("quizIsActive")) {
//			CardDeck deck = null;
//			@SuppressWarnings("unchecked")
//			List<CardDeck> decks = (List<CardDeck>) session.getAttribute("decks");
//			for (CardDeck item : decks) {
//				if (item.getName().equals(deckName)) {
//					deck = item;
//				}
//			}
//			deck.setFlashcards(cardDeckDAO.getFlashcardsForDeckShuffled(deck.getDeckId()));
//			if(deck.getFlashcards().size() <1 ) {
//				List<String> errorMessages = new ArrayList<String>();
//				errorMessages.add("Please Add A Card To Begin A Study Session");
//				redirAttribs.addFlashAttribute("errorMessages", errorMessages);
//				return "redirect:/home/";
//			}
//			// wipe out pre-existing answers
//			for (Flashcard card : deck.getFlashcards()) {
//				card.setIsCorrect(false);
//				cardDeckDAO.updateFlashcardStudySession(card);
//			}
//			session.setAttribute("deck", deck);
//			session.setAttribute("sessionLength", deck.getFlashcards().size());
//			session.setAttribute("currVal", 0);
//			session.setAttribute("card", deck.getFlashcards().get((int) session.getAttribute("currVal")));
//			session.setAttribute("quizIsActive", true);
//		}
//		return "studySession";
//	}
	
	@RequestMapping(path = "/studysession/{deckName}", method = RequestMethod.POST)
	public String nextStudySessionPage(@PathVariable("deckName") String deckName, HttpSession session, @RequestParam boolean isCorrect) {
		// want to submit previous page's card data
		// Need: Flashcard Object (but set deckId first), the currVal variable
		Flashcard flashcard = (Flashcard) session.getAttribute("card");
		flashcard.setIsCorrect(isCorrect);
		cardDeckDAO.updateFlashcardStudySession(flashcard); 
		// then increment currVal (but not beyond deck length) and submit to next page
		session.setAttribute("currVal", (int) session.getAttribute("currVal") + 1);
		if((int) session.getAttribute("currVal") < (int) session.getAttribute("sessionLength")) {
			
			CardDeck deck = (CardDeck) session.getAttribute("deck");
			session.setAttribute("card", deck.getFlashcards().get((int) session.getAttribute("currVal")));
			return "redirect:/studysession/" +deck.getName(); // Next page
		} else {
			return "redirect:/studysession/score"; // Redirect to score screen
		}
	}
	
	@RequestMapping(path = "/studysession/choosedeck", method = RequestMethod.GET)
	public String chooseStudyDeck(HttpSession session, ModelMap map, @RequestParam String sessionType) {
		// "decks" already in session
		map.addAttribute("sessionType", sessionType);
		return "selectDeck";
	}
	
	
	
	@RequestMapping(path = "/studysession/score", method = RequestMethod.GET)
	public String displayStudySessionScore(String deckName, HttpSession session, ModelMap map) {
		CardDeck deck = (CardDeck)session.getAttribute("deck");
		int currVal = (int)session.getAttribute("currVal");
		List<Flashcard> cards = deck.getFlashcards();
		int counter = 0;
		int numWrong = 0;
		for(Flashcard card: cards) {
			if(card.getIsCorrect()){
				counter ++;
			}
		}
		numWrong = currVal - counter;
		map.addAttribute("correctTotal", counter);
		map.addAttribute("wrongTotal", numWrong);
		session.setAttribute("quizIsActive", false);
		return "studySessionScore";
	}

}
