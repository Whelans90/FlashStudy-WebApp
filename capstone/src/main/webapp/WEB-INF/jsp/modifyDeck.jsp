<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/jsp/header.jsp" />
<c:import url="/WEB-INF/jsp/deckBar.jsp" />

<style>
.error {
	color: #FF0000;
}

.btn-this {
	display: inline;
	width: 80px
}
</style>
<div class="welcomeBody">
	<div class="card body-card">
		<c:choose>
			<c:when test='${requestType=="new"}'>
				<h1 class="card_header text-center">New Deck</h1>
				<c:url value="/home/postDeck" var="submitDeck" />
			</c:when>
			<c:when test='${requestType=="edit"}'>
				<h1 class="card_header text-center">Edit Deck</h1>
				<c:url value="/home/updateDeck?deckId=${deck.deckId}"
					var="submitDeck" />
			</c:when>
		</c:choose>
		<c:if test="${not empty errorMessage}">
			<div class="error">${errorMessage}</div>
		</c:if>
		<hr class="hr">
		<form id="submitDeck" method="POST" action="${submitDeck}"
			class="text-center">


			<div class="form-group">
				<label for="name">Deck Title: </label>
				<c:choose>
					<c:when test='${requestType=="new"}'>

						<input type="text" id="name" name="name" class="form-control" />

					</c:when>
					<c:when test='${requestType=="edit"}'>
						<textarea id="name" name="name" class="form-control" rows="1">${deckName}</textarea>
					</c:when>
				</c:choose>
			</div>

			<div class="form-group">
				<label for="name">Deck Description: </label>
				<c:choose>
					<c:when test='${requestType=="new"}'>

						<textarea id="description" name="description" class="form-control"
							rows="4"></textarea>

					</c:when>
					<c:when test='${requestType=="edit"}'>
						<textarea id="description" name="description" class="form-control"
							rows="4">${deck.description}</textarea>
					</c:when>
				</c:choose>
			</div>

			<br>

			<c:url var="deckName" value="/home/${deck.name}" />
			<a href=""><button type="submit" class="btn btn-this btn-success"
					name="form_btn" value="submit">Save</button></a>
			<button id="cancel_btn" type="button" class="btn btn-this btn-primary"
				name="form_btn" value="cancel">Cancel</button>
		</form>
	</div>
</div>

<script>
	$("#cancel_btn").click(function() {
		window.history.back();
		//alternate option: pass in "go back" path to button
	});

	$('#submitDeck').validate({
		rules : {
			name : {
				required : true,
				minlength : 1
			},
			description : {
				required : true,
				minlength : 1
			}
		}
	});
</script>
