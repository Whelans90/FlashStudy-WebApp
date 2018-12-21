<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/jsp/header.jsp" />
<c:import url="/WEB-INF/jsp/deckBar.jsp" />

<script src="https://cdn.rawgit.com/nnattawat/flip/master/dist/jquery.flip.min.js"></script>
<style>

</style>
<div class="welcomeBody">
<div class="card body-card text-center">
<c:url value="/home/${card.cardId}/editCard" var="editCard"/>

	<h1>Card Details</h1>
	<hr class="hr">
	<div style="display: inline">
	<button type="button" class="btn-light btn-sm" id="cancel_btn"><img src="https://img.icons8.com/material-rounded/24/000000/circled-left.png" style="height: 15px">&nbsp;Back</button>
	<a href="${editCard}"><button class="btn-sm btn-light"><img src="https://img.icons8.com/material-rounded/24/000000/edit.png" style="height: 15px">&nbsp;Edit Card</button></a>
</div>
<br>
	
	<div id="card" class="card-det"> 
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
</div>
</div>
<script>

$(function() {
	$("#card").flip({
		  trigger: 'click'
		});
});

$("#cancel_btn").click(function() {
	window.history.back();
	//alternate option: pass in "go back" path to button
});

</script>

<c:import url="/WEB-INF/jsp/footer.jsp" />

