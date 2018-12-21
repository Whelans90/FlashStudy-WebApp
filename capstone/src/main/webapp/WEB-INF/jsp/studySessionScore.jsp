<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/jsp/header.jsp" />

<div class="card body-card">
<div class="text-center">
	<h1>Study Session Completed!</h1>
	<hr class="hr">
	
	<div><h4>You got ${correctTotal} right & ${wrongTotal} wrong, out of ${currVal} attempted!</h4></div>
	<br/><br/>	
	
	<c:url var="homePageHref" value="/home/" />
	<a href="${homePageHref}"><button type="button" class="btn btn-success btn-lg session-button">RETURN HOME</button></a>
	
	
</div>
</div>


<c:import url="/WEB-INF/jsp/footer.jsp" />