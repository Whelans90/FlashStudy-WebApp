<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/jsp/header.jsp" />
<c:import url="/WEB-INF/jsp/deckBar.jsp" />

<style>
.card_header {
	text-align: center;
}

form {
	overflow: auto
}

.card-edit {
	width: 350px;
	height: 220px;
	background-color: lightgrey;
	display: inline-block;
	text-align: center;
	padding-top: 40px;
	margin-bottom: 10px
}

.card_label {
	display: block;
}

.cardField {
	resize: none;
}

.btn-this {
	display: inline;
	width: 80px
}

.error {
	color: #FF0000;
}

</style>


<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/bootstrap-select.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.css" />

<div class="welcomeBody">
	<div class="card body-card">
		<c:choose>
			<c:when test='${requestType=="new"}'>
				<h1 class="card_header">New Card</h1>
				<c:url value="/home/postCard" var="submitCard" />
			</c:when>
			<c:when test='${requestType=="edit"}'>
				<h1 class="card_header">Edit Card</h1>
				<c:url value="/home/updateCard?cardId=${cardId}" var="submitCard" />
			</c:when>
		</c:choose>
		<c:if test="${not empty errorMessage}">
			<div class="error">${errorMessage}</div>
		</c:if>
		<hr class="hr">
		<form id="submitCard" method="POST" action="${submitCard}">

			<div class="container text-center">
				<div class="card card-edit cardFront">
					<label for="frontText" class="card_label">Front Text</label>
					<c:choose>
						<c:when test='${requestType=="new"}'>
							<textarea rows="4" cols="30" id="frontText" name="frontText"
								class="cardField"></textarea>
						</c:when>
						<c:when test='${requestType=="edit"}'>
							<textarea rows="4" cols="30" id="frontText" name="frontText"
								class="cardField">${card.frontText}</textarea>
						</c:when>
					</c:choose>
				</div>
				<div class="card card-edit cardBack">
					<label for="backText" class="card_label">Back Text</label>
					<c:choose>
						<c:when test='${requestType=="new"}'>
							<textarea rows="4" cols="30" id="backText" name="backText"
								class="cardField"></textarea>
						</c:when>
						<c:when test='${requestType=="edit"}'>
							<textarea rows="4" cols="30" id="backText" name="backText"
								class="cardField">${card.backText}</textarea>
						</c:when>
					</c:choose>
				</div>
			</div>
			<br>

			<div style="text-align: center">

				<label >Search Tags:</label> <select
					class="selectpicker" id="tagText" name="tagId" multiple>
					<c:forEach var="tag" items="${tags}">
						<option value="${tag.tagId}"
							${card.tagIds.contains(tag.tagId)?"selected":""}>${tag.name}</option>
					</c:forEach>
				</select> <br> <br>
				<c:choose>
					<c:when test='${requestType=="new"}'>
						<label class="card_label">Decks:</label>
						<select id="deckSelect" name="deckId" multiple>
							<c:forEach var="deck" items="${decks}">
								<option value="${deck.deckId}">${deck.name}</option>
							</c:forEach>
						</select>
					</c:when>
					<c:when test='${requestType=="edit"}'>
						<label class="card_label">Decks:</label>
						<select id="deckSelect" name="deckId" multiple>
							<c:forEach var="deck" items="${decks}">
								<option value="${deck.deckId}"
									${allDecks.contains(deck.deckId)?"selected":""}>${deck.name}</option>
							</c:forEach>
						</select>
					</c:when>
				</c:choose>
			</div>
			<br>
			<div style="text-align: center">
				<a href=""><button type="submit"
						class="btn btn-this btn-success" name="form_btn" value="submit">Save</button></a>
				<button id="cancel_btn" type="button"
					class="btn btn-this btn-primary" name="form_btn" value="cancel">Cancel</button>
			</div>
			<br>
			
		</form>
		<c:choose>
	<c:when test='${requestType=="new"}'>
		
	</c:when>
	<c:when test='${requestType=="edit"}'>
		<c:url var="delete" value="/home/deleteCard/${card.cardId}"/>
		<form method="POST" action="${delete}">
		<p class="text-center">
			<button class="btn btn-sm btn-outline-danger">&#x2716; Remove Card From System</button>
		</p>
		</form>
	</c:when>
</c:choose>
	</div>
</div>

<script>
	$("#cancel_btn").click(function() {
		window.history.back();
		//alternate option: pass in "go back" path to button
	});

	$('select').selectpicker();

	$('#submitCard').validate({
		rules : {
			frontText : {
				required : true,
				minlength : 1
			},
			backText : {
				required : true,
				minlength : 1
			},
			deckId : {
				required : true
			}
		}
	});
</script>

<c:import url="/WEB-INF/jsp/footer.jsp" />
