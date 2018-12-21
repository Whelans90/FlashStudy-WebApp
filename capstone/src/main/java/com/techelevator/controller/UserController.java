package com.techelevator.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.techelevator.model.CardDeck;
import com.techelevator.model.CardDeckDAO;
import com.techelevator.model.JDBCCardDeckDAO;
import com.techelevator.model.JDBCUserDAO;
import com.techelevator.model.User;
import com.techelevator.model.UserDAO;

@Controller
public class UserController {

	private UserDAO userDAO;
	private CardDeckDAO cardDeckDAO;

	@Autowired
	public UserController(UserDAO userDAO, CardDeckDAO cardDeckDAO) {
		this.userDAO = userDAO;
		this.cardDeckDAO = cardDeckDAO;
	}

	@RequestMapping(path = "/users/new", method = RequestMethod.GET)
	public String displayNewUserForm(ModelMap modelHolder) {
		if (!modelHolder.containsAttribute("user")) {
			modelHolder.addAttribute("user", new User());
		}
		return "newUser";
	}

	@RequestMapping(path = "/users", method = RequestMethod.POST)
	public String createUser(@Valid @ModelAttribute User user, BindingResult result, RedirectAttributes flash,
			@RequestParam String email, @RequestParam String userName, @RequestParam String password, ModelMap map) {
		if (result.hasErrors()) {
			flash.addFlashAttribute("user", user);
			flash.addFlashAttribute(BindingResult.MODEL_KEY_PREFIX + "user", result);
			return "redirect:/users/new";
		}
		
		List<String> loginMessage = new ArrayList<String>();
		loginMessage.add("Please Login Below");
		flash.addFlashAttribute("confirmation", loginMessage);
		flash.addFlashAttribute("userName", userName);
		userDAO.saveUser(email, userName, password);
		return "redirect:/";
	}


}
