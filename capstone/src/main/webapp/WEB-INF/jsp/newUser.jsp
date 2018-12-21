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
				email : {
					email : true,
					required : true
				},
				password : {
					required : true,
					minlength : 10,
					strongpassword : true,
				},
				confirmPassword : {
					required : true,		
					equalTo : "#password"  
				}
			},
			 messages : {		
				userName : {
					required : "Please enter a username",
					minlength : "Username must be between 2-20 characters",
					maxlength : "Username must be between 2-20 characters"
				},
				email : {
					required : "Please enter a valid email address"
					
				},
				password: {
					required : "Please enter a password",
					minlength: "Password is too short, please make it at least 10 characters"
				},
				confirmPassword : {
					required : "Please re-type your password",
					equalTo : "Passwords do not match"
				}
			}, 
			errorClass : "error"
		});
	});
	
	//strongpassword method
	$.validator.addMethod("strongpassword", function(value, element) {
	    return value.match(/[A-Z]/) && value.match(/[a-z]/) && value.match(/\d/);  //check for one capital letter, one lower case letter, one num
	}, "Please enter a strong password (one capital, one lower case, and one number");
	
	
	
	
	
	
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
<h1>Sign Up</h1>
<hr class="hr">
<c:url var="formAction" value="/users" />
<form method="POST" action="${formAction}" class="needs-validation" novalidate>
<input type="hidden" name="CSRF_TOKEN" value="${CSRF_TOKEN}"/>
	<div class="row">
		<div class="col-sm-4"></div>
		<div class="col-sm-4">
			<div class="form-group">
				<label for="userName">User Name: </label>
				<input type="text" id="userName" name="userName" placeHolder="User Name" class="form-control" maxlength="20" minlength="2" required/>
				     <div class="valid-feedback">
       					
     				 </div>
				     <div class="invalid-feedback">
       					
     				 </div>
			</div>
			<div class="form-group">
				<label for="email">Email Address: </label>
				<input type="email" id="email" name="email" placeHolder="Email Address" class="form-control" required/>
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
			<div class="form-group">
				<label for="confirmPassword">Confirm Password: </label>
				<input type="password" id="confirmPassword" name="confirmPassword" placeHolder="Re-Type Password" class="form-control" required/>	
				 <div class="valid-feedback">
       				
     			</div>
				 <div class="invalid-feedback">
       			
     			 </div>			
			
			</div>
			<br>
			<button type="submit" class="btn btn-success login-buttons">Create User</button>
		</div>
		<div class="col-sm-4"></div>
	</div>
</form>
	<br>
		<a href="/capstone/"><button class="btn btn-light login-buttons">Already Registered? Log In</button></a>
		</div>
		</div>
