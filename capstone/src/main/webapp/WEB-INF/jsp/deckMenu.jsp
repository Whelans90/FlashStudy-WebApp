<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/jsp/header.jsp" />
<c:import url="/WEB-INF/jsp/deckBar.jsp" />

<div class="welcomeBody">
	<div class="card body-card">

		<div class="text-center">
			<h1>${deck.name}</h1>
			<p>${deck.description}</p>
			<hr class="hr">
			<c:if test="${not empty cards}">
			<p>
				<c:url var="deckCode" value="/home/${deck.name}/cards" />
				<a href="${deckCode}"><button type="button"
						class="btn btn-success btn-lg session-button">VIEW/EDIT
						CARDS</button></a>
			</p>
</c:if>
			<p>
				<a href="newCard"><button type="button"
						class="btn btn-success btn-lg session-button">ADD NEW
						CARD</button></a>
			</p>

			<p>
				<c:url var="editDeck" value="/home/${deck.name}/editDeck" />
				<a href="${editDeck}"><button type="button"
						class="btn btn-success btn-lg session-button">EDIT DECK</button></a>
			</p>
<c:if test="${not empty cards}">
			<p>
				<c:url var="studySession" value="/studysession/${deck.name}">
					<c:param name="sessionType" value="standard"/>
				</c:url>
				<a href="${studySession}"><button type="button"
						class="btn btn-success btn-lg session-button">ORDERED STUDY
						SESSION</button></a>
			</p>

			<p>
				<c:url value="/studysession/${deckName}" var="randomSession">
					<c:param name="sessionType" value="random"/>
				</c:url>
			<a href="${randomSession}"><button type="button"
						class="btn btn-success btn-lg session-button">
						<span class="session-btn-text">RANDOMIZED STUDY SESSION</span>
					</button></a> 
			</p>
</c:if>
		</div>



	</div>
</div>

