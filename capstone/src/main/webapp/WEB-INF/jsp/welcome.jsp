<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/jsp/header.jsp" />
<c:import url="/WEB-INF/jsp/deckBar.jsp" />




<div class="welcomeBody">
<div class="card body-card">
	<h1 style="text-align: center">${welcomeHeader}</h1>
	<hr class="hr">
	<c:if test="${not empty errorMessages}">
		<tr>
			<c:forEach var="message" items="${errorMessages}">
			<div class="alert alert-danger" role="alert">
				${message}
			</div>
			</c:forEach>
		</tr>
</c:if>
	<p>${message1}</p>
	<p>${message2}</p>
	<c:if test="${not empty cards}">
	<br>
	<div class="session-button-cont">
	<c:url value="/studysession/choosedeck" var="chooseDeck">
		<c:param name="sessionType" value="standard"/>
	</c:url>
	<c:url value="/studysession/choosedeck" var="chooseDeckRandom">
		<c:param name="sessionType" value="random"/>
	</c:url>
	
	<p>
	<a href="${chooseDeck}"><button type="button" class="btn btn-success btn-lg session-button"><span class="session-btn-text">ORDERED STUDY SESSION</span></button></a>
	</p>
	<p>
	<a href="${chooseDeckRandom}"><button type="button" class="btn btn-success btn-lg session-button"><span class="session-btn-text">RANDOMIZED STUDY SESSION</span></button></a>
	</p>
	</div>
	</c:if>
	</div>
</div>

<c:import url="/WEB-INF/jsp/footer.jsp" />
