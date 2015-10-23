<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Autenticacion de Usuario</title>
	<script language="javascript" src="recursos/js/jquery-1.8.2.min.js"></script>
	<script language="javascript" src="recursos/js/jquery-ui-1.10.4.custom.min.js"></script>
	<link rel="stylesheet" href="recursos/css/redmond/jquery.ui.all.css" type="text/css" />
	<link rel="stylesheet" href="recursos/css/bootstrap.css" type="text/css" />
	<script>
	$(function() {
		$("#dialog").dialog({
			open: function(event, ui) { $(".ui-dialog-titlebar-close").hide(); },
			width:1050,
			height:450,
			resizable: false,
		    modal: true
		});
	});
	</script>
</head>
<body>
	 
	<div id="dialog" title="">
		<form style="margin-top: 1.0em;" action="<c:url value="/login"/>" method="post">
			<center>
				<img src="recursos/images/error404.jpg" border="0" />
				<br><br>
				<input type="submit" name="aceptar" value="Ir a Página Inicial" class="btn btn-primary" />
			</center>
		</form>
	</div>
	
</body>
</html>