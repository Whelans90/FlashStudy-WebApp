<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/jsp/header.jsp" />
<c:import url="/WEB-INF/jsp/deckBar.jsp" />

<style>
.hidden {
	position: absolute;
	visibility: hidden;
	opacity: 0;
}

input[type=checkbox]+label {
	color: #ccc;
	font-style: italic;
}

input[type=checkbox]:checked+label {
	color: #f00;
	font-style: normal;
}

.tag-buttons {
	overflow-y: scroll;
}

.button-size {
	height: 60px;
	width: 200px;
	font-size: 16px;
	box-shadow: 4px 4px 4px grey;
	margin-right: 5px;
	margin-bottom: 5px;
	border-color: black
}

.button-size:hover {
	background-color: #e1e6eb
}

.save-button {
	width: 120px;
}
</style>

<script>
	$(function() {
		$('.button-checkbox')
				.each(
						function() {

							// Settings
							var $widget = $(this), $button = $widget
									.find('button'), $checkbox = $widget
									.find('input:checkbox'), color = $button
									.data('color'), settings = {
								on : {
									icon : 'glyphicon glyphicon-check'
								},
								off : {
									icon : 'glyphicon glyphicon-unchecked'
								}
							};

							// Event Handlers
							$button.on('click', function() {
								$checkbox.prop('checked', !$checkbox
										.is(':checked'));
								$checkbox.triggerHandler('change');
								updateDisplay();
							});
							$checkbox.on('change', function() {
								updateDisplay();
							});

							// Actions
							function updateDisplay() {
								var isChecked = $checkbox.is(':checked');

								// Set the button's state
								$button.data('state', (isChecked) ? "on"
										: "off");

								// Set the button's icon
								$button
										.find('.state-icon')
										.removeClass()
										.addClass(
												'state-icon '
														+ settings[$button
																.data('state')].icon);

								// Update the button's color
								if (isChecked) {
									$button.removeClass('btn-default')
											.addClass(
													'btn-' + color + ' active');
								} else {
									$button.removeClass(
											'btn-' + color + ' active')
											.addClass('btn-default');
								}
							}

							// Initialization
							function init() {

								updateDisplay();

								// Inject the icon if applicable
								if ($button.find('.state-icon').length == 0) {
									$button
											.prepend('<i class="state-icon '
													+ settings[$button
															.data('state')].icon
													+ '"></i> ');
								}
							}
							init();
						});
	});
	

</script>




<div class="welcomeBody">
	<div class="card body-card">
		<h3 class="text-center">Select one or more tags to search by:</h3>
		<hr class="hr">

		<c:url value="/search" var="search" />
		<form name="tagId" action="${search}" method="POST">
			<div class="tag-buttons text-center">

				<c:forEach var="tag" items="${tags}">
					<span class="button-checkbox">
						<button type="button" class="btn btn-lg button-size"
							data-color="success">${tag.name}</button> <input name="tagNames"
						value="${tag.name}" type="checkbox" class="hidden" />
					</span>
				</c:forEach>



			</div>
			<br>

			<div class="text-center">
				<c:url value="" var="searchSubmit" />
				<button type="submit" class="btn btn-outline-success btn-lg">
					<span class="session-btn-text">SEARCH</span>
				</button>
			</div>

		</form>
	</div>

	<c:forEach var="card" items="${searchReturns}">
		<div class="card body-card text-center">

			<span>Tags: <c:forEach var="tag" items="${tagMap}">
					<c:forEach var="cardTag" items="${card.tagIds}">
					${tag.key==cardTag?[tag.value]:""}
				</c:forEach>
				</c:forEach>
			</span>
			<hr class="hr">

			<div>


				<div class="card card-button">
					<div class="card-body card-preview">
						<p>${card.frontText}</p>
					</div>
				</div>


				<div class="card card-button">
					<div class="card-body card-preview">
						<p>${card.backText}</p>
					</div>
				</div>
			</div>
			<br>

			<div class="text-center">
				<c:url var="editCard" value="/home/${card.cardId}/editCard"/>
				<a href="${editCard}"><button class="btn btn-outline-success save-button">+ Save Card</button></a>
			</div>

		</div>
		

		
	</c:forEach>

</div>





<c:import url="/WEB-INF/jsp/footer.jsp" />