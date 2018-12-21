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
import com.techelevator.model.UserDAO;

@Controller
public class HomeController {

	private UserDAO userDAO;
	private CardDeckDAO cardDeckDAO;

	@Autowired
	public HomeController(UserDAO userDAO, CardDeckDAO cardDeckDAO) {
		this.userDAO = userDAO;
		this.cardDeckDAO = cardDeckDAO;
	}

	@RequestMapping(path = "/home/", method = RequestMethod.GET)
	public String displayProfile(HttpSession session, ModelMap map) {

		if (session.getAttribute("currentUser") == null) {
			return "redirect:/";
		} else {
			User user = (User) session.getAttribute("currentUser");

			String userName = user.getUserName();
			int userId = user.getUserId();
			List<CardDeck> decks = cardDeckDAO.getCardDecksByUserName(userName);
			List<Flashcard> cards = cardDeckDAO.getFlashcardsByUserId(userId);

			session.setAttribute("decks", decks);
			session.setAttribute("cards", cards);

			if (cards.size() == 0) {
				map.addAttribute("welcomeHeader", "Welcome!");
				map.addAttribute("message1",
						"Welcome to FlashStudy, the site that lets you create flashcards so you can quiz yourself and test your knowledge on any subject.  You can make your own cards and decks or you can search for ones created by other users.");
				map.addAttribute("message2",
						"To get started, create a new card to add to your first deck from the DECKS menu.");
			} else {
				map.addAttribute("welcomeHeader", "Welcome Back!");
				map.addAttribute("message1",
						"Welcome back to FlashStudy, the site that lets you create flashcards so you can quiz yourself and test your knowledge on any subject.  You can make your own cards and decks or you can search for ones created by other users.");
				map.addAttribute("message2",
						"Make a selection from the DECKS menu or click the button below to begin a new study session.");
			}

			if (decks.size() < 1) {
				decks.add(cardDeckDAO.saveCardDeck(user.getUserId(), "My First Deck",
						"My First Deck is designed to help you create your first cards!"));

			}

			session.setAttribute("quizIsActive", false);
			session.setAttribute("tags", cardDeckDAO.getAllTags());
			return "welcome";
		}
	}

	@RequestMapping(path = "/home/newCard", method = RequestMethod.GET)
	public String createFlashcard(HttpSession session) {
		session.setAttribute("requestType", "new");
		return "modifyCard";
	}
	
	@RequestMapping(path = "/home/deleteCard/{cardId}", method = RequestMethod.POST)
	public String deleteFlashcard(HttpSession session, @PathVariable("cardId") int cardId) {
		cardDeckDAO.deleteFlashcard(cardId);
		return "redirect:/home/";
	}

	@RequestMapping(path = "/home/{cardId}/editCard", method = RequestMethod.GET)
	public String editDeck(@PathVariable("cardId") int cardId, HttpSession session, ModelMap map) {
		Flashcard card = cardDeckDAO.getFlashcardByCardId(cardId);
		card.setAllDeckIds(cardDeckDAO.getAllDeckIdsForCard(cardId));
		map.addAttribute("card", card);
		session.setAttribute("cardDeckIds", card.getAllDeckIds());
		session.setAttribute("requestType", "edit");
		map.addAttribute("allDecks", card.getAllDeckIds());
		return "modifyCard";
	}

	@RequestMapping(path = "/home/postCard", method = RequestMethod.POST)
	public String postNewFlashcard(HttpSession session, RedirectAttributes redirAttr, @RequestParam String frontText,
			@RequestParam String backText, @RequestParam int[] tagId, @RequestParam int[] deckId,
			@RequestParam String form_btn) {
		// Validation
		boolean isValid = true;
		if (frontText.length() < 1 || backText.length() < 1) {
			isValid = false;
			redirAttr.addFlashAttribute("errorMessage", "Please complete all fields.");
		}
		// Actions
		if (isValid) {
			User user = (User) session.getAttribute("currentUser");
			int userId = user.getUserId();
			Flashcard flashcard = cardDeckDAO.saveFlashcard(userId, frontText, backText, tagId);
			int cardId = flashcard.getCardId();
			for (int i = 0; i < deckId.length; i++) {
				cardDeckDAO.assignFlashcardToDeck(cardId, deckId[i]);
			}
			return "redirect:/home/cardDetails/" + cardId;
		}
		return "redirect:/home/newCard";
	}

	@RequestMapping(path = "/home/updateCard", method = RequestMethod.POST)
	public String updateFlashcard(HttpSession session, RedirectAttributes redirAttr, @RequestParam int cardId,
			@RequestParam String frontText, @RequestParam String backText, @RequestParam int[] tagId,
			@RequestParam int[] deckId, @RequestParam String form_btn) {
		// Validation
		boolean isValid = true;
		if (frontText.length() < 1 || backText.length() < 1) {
			isValid = false;
			redirAttr.addFlashAttribute("errorMessage", "Please complete all fields.");
		}
		// Actions
		if (isValid) {
			cardDeckDAO.updateFlashcard(cardId, frontText, backText, tagId);

			// Remove card from appropriate decks
			@SuppressWarnings("unchecked")
			List<Integer> allDeckIds = (List<Integer>) session.getAttribute("cardDeckIds");
			session.removeAttribute("cardDeckIds");
			List<Integer> newDeckAssignments = new ArrayList<>();
			for (int i = 0; i < deckId.length; i++) {
				newDeckAssignments.add(deckId[i]);
			}
			List<Integer> deadDecks = new ArrayList<>();
			for (int id : allDeckIds) {
				if (!newDeckAssignments.contains(id)) {
					deadDecks.add(id);
				}
			}
			for (int id : deadDecks) {
				cardDeckDAO.removeFlashcardFromDeck(cardId, id);
			}

			for (int i = 0; i < deckId.length; i++) {
				cardDeckDAO.assignFlashcardToDeck(cardId, deckId[i]);
			}
			return "redirect:/home/cardDetails/" + cardId;
		} else {
			return "redirect:/home/updateCard";
		}
	}

	@RequestMapping(path = "/home/{deckName}", method = RequestMethod.GET)
	public String deckMenu(@PathVariable("deckName") String deckName, HttpSession session, ModelMap map) {
		CardDeck deck = null;

		@SuppressWarnings("unchecked")

		List<CardDeck> decks = (List<CardDeck>) session.getAttribute("decks");
		for (CardDeck item : decks) {
			if (item.getName().equals(deckName)) {
				deck = item;
			}
		}
		List<Flashcard> cards = new ArrayList<>();
		try {
			cards = cardDeckDAO.getFlashcardsForDeckOrdered(deck.getDeckId());
		} catch (NullPointerException e) {

		}
		map.addAttribute("cards", cards);
		session.setAttribute("deck", deck);
		return "deckMenu";
	}

	@RequestMapping(path = "/home/{deckName}/cards", method = RequestMethod.GET)
	public String deckDetails(@PathVariable("deckName") String deckName, HttpSession session, ModelMap map) {
		CardDeck deck = null;
		@SuppressWarnings("unchecked")
		List<CardDeck> decks = (List<CardDeck>) session.getAttribute("decks");
		for (CardDeck item : decks) {
			if (item.getName().equals(deckName)) {
				deck = item;
			}
		}

		List<Flashcard> flashcards = new ArrayList<>();
		flashcards = cardDeckDAO.getFlashcardsForDeckOrdered(deck.getDeckId());
		map.addAttribute("flashcards", flashcards);
		// map.addAttribute("deck", deck);
		return "deckCards";
	}

	@RequestMapping(path = "/home/newDeck", method = RequestMethod.GET)
	public String createDeck(HttpSession session) {
		session.setAttribute("requestType", "new");
		session.setAttribute("tags", cardDeckDAO.getAllTags());
		return "modifyDeck";
	}

	@RequestMapping(path = "/home/postDeck", method = RequestMethod.POST)
	public String saveDeck(HttpSession session, RedirectAttributes redirAttr, @RequestParam String name,
			@RequestParam String description, @RequestParam String form_btn) {
		// Validation
		boolean isValid = true;
		if (name.length() < 1 || description.length() < 1) {
			isValid = false;
			redirAttr.addFlashAttribute("errorMessage", "Please complete all fields.");
		}
		if (isValid) {
			User user = (User) session.getAttribute("currentUser");
			CardDeck deck = cardDeckDAO.saveCardDeck(user.getUserId(), name, description);

			if (session.getAttribute("decks") == null) {
				session.setAttribute("decks", deck);
			} else {
				List<CardDeck> decks = (List<CardDeck>) session.getAttribute("decks");
				decks.add(deck);
				session.setAttribute("decks", decks);
			}
			return "redirect:/home/" + name;
		} else {
			return "redirect:/home/newDeck";
		}
	}

	@RequestMapping(path = "/home/updateDeck", method = RequestMethod.POST)
	public String updateDeck(HttpSession session, RedirectAttributes redirAttr, @RequestParam String name,
			@RequestParam String description, @RequestParam int deckId, @RequestParam String form_btn) {
		List<CardDeck> decks = (List<CardDeck>) session.getAttribute("decks");
		// Validation
		boolean isValid = true;
		if (name.length() < 1 || description.length() < 1) {
			isValid = false;
			redirAttr.addFlashAttribute("errorMessage", "Please complete all fields.");
		}
		if (isValid) {
			cardDeckDAO.updateCardDeck(deckId, name, description);
			CardDeck deck = cardDeckDAO.getCardDeckByDeckId(deckId);
			List<CardDeck> toRemove = new ArrayList();
			for (CardDeck item : decks) {
				if (item.getDeckId() == deck.getDeckId())
					toRemove.add(item);
			}
			decks.removeAll(toRemove);
			decks.add(deck);
			session.setAttribute("deck", deck);
			session.setAttribute("decks", decks);
			return "redirect:/home/" + name;
		} else {
			// Send deckId here?
			return "redirect:/home/updateDeck";
		}
	}

	@RequestMapping(path = "/home/{deckName}/editDeck", method = RequestMethod.GET)
	public String editDeck(@PathVariable("deckName") String deckName, HttpSession session, ModelMap map) {
		session.setAttribute("requestType", "edit");
		session.setAttribute("name", deckName);
		CardDeck deck = null;
		@SuppressWarnings("unchecked")
		List<CardDeck> decks = (List<CardDeck>) session.getAttribute("decks");
		for (CardDeck item : decks) {
			if (item.getName().equals(deckName)) {
				deck = item;
			}
		}
		// map.addAttribute("deck", deck);
		session.setAttribute("tags", cardDeckDAO.getAllTags());
		return "modifyDeck";
	}

	@RequestMapping(path = "/home/cardDetails/{cardId}", method = RequestMethod.GET)
	public String cardDetails(@PathVariable("cardId") int cardId, HttpSession session, ModelMap map) {

		Flashcard flashcard = cardDeckDAO.getFlashcardByCardId(cardId);
		map.addAttribute("card", flashcard);

		return "cardDetails";
	}

}
