<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Cambiar Clave de Usuario</title>
	<link rel="shortcut Icon" href="recursos/images/icons/AYZA-Juntos-32.ico" type="image/x-icon">
	<script language="javascript" src="recursos/js/jquery-1.8.2.min.js"></script>
	<script language="javascript" src="recursos/js/jquery-ui-1.10.4.custom.min.js"></script>
	<link rel="stylesheet" href="recursos/css/redmond/jquery.ui.all.css" type="text/css" />
	<link rel="stylesheet" href="recursos/css/bootstrap.css" type="text/css" />
	<script>
	$(function() {
		$("#dialog").dialog({
			open: function(event, ui) { $(".ui-dialog-titlebar-close").hide(); },
			width:450,
			resizable: false,
		    modal: true
		});
		
		usuario = '${sessionScope.datosSession.usuario}';
		$("#j_username").val(usuario);
	});
	</script>
</head>
<body>
	 
	<div id="dialog" title="Cambio de Clave">
		<form style="margin-top: 1.0em;" action="<c:url value="/j_spring_security_check"/>" method="post">
			<table border="0" cellpadding="5">
				<tr>
					<td rowspan="4">
						<img src="recursos/images/usuarios.png" border="0" />
					</td>
				</tr>
				<tr>
					<td width="30px">&nbsp;</td>
					<td>
						<div class="input-group">
					      <div class="input-group-addon"><img src="recursos/images/icons/correo_16x16.png" border="0" /></div>
					      <input class="form-control" type="text" name="j_username" id="j_username" placeholder="Ingrese su usuario" disabled >
					    </div>
					</td>
					<td width="30px">&nbsp;</td>
				</tr>
				<tr>
					<td width="30px">&nbsp;</td>
					<td>
						<div class="input-group">
					      <div class="input-group-addon"><img src="recursos/images/icons/security_16x16.png" border="0" /></div>
					      <input class="form-control" type="password" name="j_password" id="j_password" placeholder="Ingrese nueva clave">
					    </div>
					</td>
					<td width="30px">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="right">
						<input type="submit" name="aceptar" value="Aceptar" class="btn btn-primary" />
					</td>
					<td width="30px">&nbsp;</td>
				</tr>
			</table>
		</form>
	</div>
	
</body>
</html>