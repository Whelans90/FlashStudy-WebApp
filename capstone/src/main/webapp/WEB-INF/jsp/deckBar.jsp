<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:url var="siteCss" value="/css/site.css" />

<script>
$(document).ready(function() {
	// grab the initial top offset of the navigation 
   	var stickyNavTop = $('#deckBar').offset().top;
   	
   	// our function that decides weather the navigation bar should have "fixed" css position or not.
   	var stickyNav = function(){
	    var scrollTop = $(window).scrollTop(); // our current vertical position from the top
	         
	    // if we've scrolled more than the navigation, change its position to fixed to stick to top,
	    // otherwise change it back to relative
	    if (scrollTop > stickyNavTop) { 
	    	$("#deckBar").removeClass("deckBar-absolute");
	    	$("#deckBar").addClass("deckBar-fixed");
	    } else {
	    	$("#deckBar").removeClass("deckBar-fixed");
	      	$("#deckBar").addClass("deckBar-absolute");
	    }
	};

	stickyNav();
	// and run it again every time you scroll
	$(window).scroll(function() {
		stickyNav();
	});
});

</script>


<aside id="deckBar" class="deckBar-absolute">
	<div class="decks-bar">
		<h3 class="decks-title">Decks</h3>
		<c:url value="/home/newCard" var="newCard"/>
		<c:url value="/home/newDeck" var="newDeck"/>
		<p class="landscape-btn">
			<a href="${newCard}"><button type="button" class="btn btn-outline-success btn-outline-success-bar">+ New Card</button></a>
		</p>
		<p class="landscape-btn">
			<a href="${newDeck}"><button type="button" class="btn btn-outline-success btn-outline-success-bar">+ New Deck</button></a>
		</p>
		<p>
			<a href="${newCard}"><button type="button" class="btn btn-outline-success btn-sm btn-sm-new btn-outline-success-bar">+ New Card</button></a>
		</p>
		<p>
			<a href="${newDeck}"><button type="button" class="btn btn-outline-success btn-sm btn-sm-new btn-outline-success-bar">+ New Deck</button></a>
		</p>
	</div>

	<!-- A Card for each new Deck will populate here from Database -->
	<div class="decks-buttons">
		<c:forEach items="${decks}" var="decks">
			<c:url var="deckCode" value="/home/${decks.name}" />
			
			<a href="${deckCode}"><button type="button" class="btn btn-light btn-light-card btn-lg deck-buttons" role="button">${decks.name}</button></a>
			
		</c:forEach>

	</div>
</aside>
