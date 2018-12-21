<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/jsp/header.jsp" />
<c:import url="/WEB-INF/jsp/deckBar.jsp" />



<div class="welcomeBody">
<div class="card body-card">
<div class="text-center">
	<h1>Choose Your Deck</h1>
	<p>Select one of the decks below to begin your study session.</p>
	<hr class="hr">
	<c:forEach items="${decks}" var="deck">
		<c:url value="/studysession/${deck.name}" var="studyDeck">
			<c:param name="sessionType" value="${sessionType}"/>
		</c:url>
		<a href="${studyDeck}"><div class="card card-button">
		<div class="card-body card-preview text-center">${deck.name}</div>
		</div></a>
	</c:forEach>
	</div>
</div>
</div>
<c:import url="/WEB-INF/jsp/footer.jsp" />