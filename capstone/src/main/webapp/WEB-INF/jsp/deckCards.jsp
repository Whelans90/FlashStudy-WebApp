<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/jsp/header.jsp" />
<c:import url="/WEB-INF/jsp/deckBar.jsp" />


<div class="welcomeBody">
<div class="card body-card">
<div class="text-center">
	<h1>${deck.name}</h1>
	<p>${deck.description}</p>
	<hr class="hr">
	</div>
	<div style="text-align: center">
	
	<c:forEach items="${flashcards}" var="cards">
		<c:url value="/home/cardDetails/${cards.cardId}" var="cardDetails">
			<%-- <c:param name="deckId" value="${deck.deckId}"/> --%>
		</c:url>
		
		<div class="card card-button" id="frontText">
		<a href="${cardDetails}">
			<div class="card-body card-preview">
					<p>${cards.frontText}</p>
			</div></a>
		</div>
	</c:forEach>

</div>
</div>
</div>



