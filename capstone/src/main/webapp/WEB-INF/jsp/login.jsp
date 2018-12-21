<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<c:import url="/WEB-INF/jsp/header.jsp" />



<script type="text/javascript">
 	$(document).ready(function () {
	
		$("form").validate({
			
			rules : {
				userName : {
					required : true,
					minlength : 2,
					maxlength : 20
				},
				password : {
					required : true
				}
			},
			messages : {			
				userName : {
					
					required : "User Name cannot be blank"
				},
				password : {
					required : "Password cannot be blank"
				}
			}, 
			errorClass : "error"
		});
	});
 	

 	
 	
 	
 	
	// Example starter JavaScript for disabling form submissions if there are invalid fields
	(function() {
	  'use strict';
	  window.addEventListener('load', function() {
	    // Fetch all the forms we want to apply custom Bootstrap validation styles to
	    var forms = document.getElementsByClassName('needs-validation');
	    // Loop over them and prevent submission
	    var validation = Array.prototype.filter.call(forms, function(form) {
	      form.addEventListener('submit', function(event) {
	        if (form.checkValidity() === false) {
	          event.preventDefault();
	          event.stopPropagation();
	        }
	        form.classList.add('was-validated');
	      }, false);
	    });
	  }, false);
	})();
	

</script>
<style>
.login-buttons {
	width: 225px
}
.error {
	color: red;
}
</style>

<div class="text-center">
<div class="card body-card">
<h1>Log In</h1>
<hr class="hr">
<div class="row">
	<div class="col-sm-4"></div>
	<div class="col-sm-4">
		<c:url var="formAction" value="/login" />
		<form method="POST" action="${formAction}" class="needs-validation" novalidate>
		<input type="hidden" name="destination" value="${param.destination}"/>
		<input type="hidden" name="CSRF_TOKEN" value="${CSRF_TOKEN}"/>
			<c:if test="${not empty confirmation}">
				<tr>
					<c:forEach var="message" items="${confirmation}">
					<div class="alert alert-success" role="alert">
	  					<strong>Registration Was Successful!</strong>
								${message}
					</div>
					</c:forEach>
				</tr>			
			</c:if>
			<c:if test="${not empty errorMessages}">
					<tr>
						<c:forEach var="message" items="${errorMessages}">
						<div class="alert alert-danger" role="alert">
							${message}
						</div>
						</c:forEach>
					</tr>
				</c:if>
			<div class="form-group">
				<label for="userName">User Name: </label>
				<input type="text" id="userName" name="userName" value = "${userName}" placeHolder="User Name" class="form-control" required/>
				     <div class="valid-feedback">
       					
     				 </div>
				     <div class="invalid-feedback">
       					
     				 </div>
			</div>
			<div class="form-group">
				<label for="password">Password: </label>
				<input type="password" id="password" name="password" placeHolder="Password" class="form-control" required/>
				     <div class="valid-feedback">
       					
     				 </div>
				     <div class="invalid-feedback">
       					
     				 </div>
			</div>
			<br>
			<button id="login" type="submit" class="btn btn-success login-buttons">Log In</button>
			<br>
			<br>
	
		</form>
		<a href="users/new"><button class="btn btn-light login-buttons">Not Registered? Sign Up</button></a>
	</div>
	<div class="col-sm-4"></div>
	</div>
</div>
</div>

