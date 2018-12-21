<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/jsp/header.jsp" />

<script>



$(function() {
	
	if(document.readyState === 'complete') {
		$("#card").prop("hidden", false);
	}
		

		$("#card").flip({
			trigger : 'click'
		});
		
		$("#card").on('flip:done', function(){
			$("#radioContainer").prop("hidden", false);
			$("#submit_btn").prop("hidden", false);
			$("#card").off('.flip');
		});
	
		$('#answer').validate({
			rules : {
				isCorrect : {
					required : true
				}
			},
			messages : {
				isCorrect : {
					required : "Please choose an answer"
				}
			},
			errorPlacement : function(error, element) {
				error.prependTo(element.parents('#radioContainer'));
			}
		});//END OF VALIDATE
	});
</script>
<script
	src="https://cdn.rawgit.com/nnattawat/flip/master/dist/jquery.flip.min.js"></script>



<div class="card body-card">
	<div class="text-center">
		<h1>Study Session: ${deck.name}</h1>
		<hr class="hr">
		<h3>Progress: ${currVal + 1} of ${sessionLength}</h3>
		<br>

		<div id="card" class="card-det" hidden>
			<div class="front">

				<div class="card card-view" id="frontText">
					<div class="card-body card-view-text">
						<h2 class="card-title">
							<span>${card.frontText}</span>
						</h2>
					</div>
				</div>

			</div>
			<div class="back">

				<div class="card card-view" id="backText">
					<div class="card-body card-view-text">
						<h2 class="card-title">
							<span>${card.backText}</span>
						</h2>
					</div>
				</div>

			</div>
		</div>

		<p>(Click Card to Flip)</p>

		<c:url value="/studysession/${deck.name}" var="submitSession" />
		<form id="answer" method="POST" action="${submitSession}">
			<div id="radioContainer" hidden>
				<input type="radio" name="isCorrect" value="true">
				&nbsp;Correct &nbsp;&nbsp;&nbsp;&nbsp; <input type="radio"
					name="isCorrect" value="false"> &nbsp;Incorrect
			</div>
			<br>
			<button id="submit_btn" type="submit" class="btn btn-outline-success session-btn"
				style="margin-left: 5px; margin-bottom: 5px" hidden>SUBMIT</button>
			<br>
			<c:url value="/studysession/score" var="endSession" />
			<a href="${endSession}"><button type="button"
					class="btn btn-outline-danger session-btn">END SESSION</button></a>

		</form>
	</div>
</div>

<c:import url="/WEB-INF/jsp/footer.jsp" />