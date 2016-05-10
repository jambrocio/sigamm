<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="../../recursos/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../recursos/css/estilos.css" type="text/css" />
<link rel="stylesheet" href="../../recursos/css/estilos_impresion.css"
	type="text/css" media="print" />
<link rel="stylesheet" href="../../recursos/css/bootstrap.css" type="text/css" />
<style>

/*@import url(http://fonts.googleapis.com/css?family=Bree+Serif);*/
@import url(http://fonts.googleapis.com/css?family=Courier+New);

body,h1,h2,h3,h4,h5,h6,div {
	/*font-family: 'Bree Serif', serif;*/
	font-family: 'Courier new';
}

tamanio18 {
	font-family: courier new; 
	font-size: 18px;
}

tamanio16 {
	font-family: courier new; 
	font-size: 16px;
}

tamanio14 {
	font-family: courier new; 
	font-size: 14px;
}
</style>
<script>
	$(document).ready(function() 
	{	
		alert(request.getParameter("codigo"));
		$("#codigo").val(request.getParameter("codigo")); 
		
	});
</script>

<title>Insert title here</title>

</head>
<body>

	<div class="container">
		<div class="col-xs-6" id="logo">
			<h1>
				<a href="#"><img alt="" src="../../recursos/images/logo.png" />
					Logo aqui </a>
			</h1>
		</div>
		<div class="col-xs-6 text-right" id="nroFactura">
			<h1>FACTURA</h1>
			<h1>
				<small>Factura #001</small>
			</h1>
		</div>
		<hr id="linea"/>
		<div class="row">
			<div class="col-xs-6">
				<div class="panel panel-default">
					<div class="panel-heading" align="center">
						<font class="tamanio18"><b>ASOCIACION DE COMERCIANTES DEL MERCADO MODELO DE HUARAL</b></font><br>
						<font class="tamanio16">Fundado el 13 de Noviembre de 1996</font><br>
						<font class="tamanio16">R.U.C. 20530606334</font><br>
					</div>
					<div class="panel-body">
						<font class="tamanio16"><p align="center"><b>RECIBO PROVISIONAL Nro.&nbsp;<span id="codigo"></span> </b></p></font><br>
						<font class="tamanio14"><b>FECHA:</b> 30/09/2015</font><br>
						<font class="tamanio14"><b>ASOCIADO:</b> PEREZ CALDERON DE BENITO</font><br>
						<font class="tamanio14"><b>SECTOR:</b> 4</font><br>
						<font class="tamanio14"><b>PUESTO:</b> 72</font><br>
						<font class="tamanio14"><b>GIRO:</b> ABARROTES</font><br>
						<!-- / fin de sección de datos del Cliente  -->
						<table border="1" cellpadding="0" cellspacing="0" width="310px;" class="tamanio14">
							<thead>
								<tr>
									<th><b>CANT</b></th>
									<th><b>DESCRIPCION</b></th>
									<th><b>TOTAL</b></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>&nbsp;</td>
									<td>ESTADO DE CUENTA</td>
									<td class=" text-right ">&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>MES DE SETIEMBRE - 2015</td>
									<td class="text-right">1.00</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td class="text-right">&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td class="text-right">&nbsp;</td>
								</tr>
							</tbody>
						</table>
						<div class="panel panel-info">
							<div class="panel-heading" align="left">
								<font class="tamanio16">SON: Un Sol con cero centimos</font>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- ********************************************************************** -->
			<div class="col-xs-6">
				<div class="panel panel-default">
					<div class="panel-heading" align="center">
						<font class="tamanio18"><b>ASOCIACION DE COMERCIANTES DEL MERCADO MODELO DE HUARAL</b></font><br>
						<font class="tamanio16">Fundado el 13 de Noviembre de 1996</font><br>
						<font class="tamanio16">R.U.C. 20530606334</font><br>
					</div>
					<div class="panel-body">
						<font class="tamanio16"><p align="center"><b>RECIBO PROVISIONAL Nro. 41796</b></p></font><br>
						<font class="tamanio14"><b>FECHA:</b> 30/09/2015</font><br>
						<font class="tamanio14"><b>ASOCIADO:</b> PEREZ CALDERON DE BENITO</font><br>
						<font class="tamanio14"><b>SECTOR:</b> 4</font><br>
						<font class="tamanio14"><b>PUESTO:</b> 72</font><br>
						<font class="tamanio14"><b>GIRO:</b> ABARROTES</font><br>
						<!-- / fin de sección de datos del Cliente  -->
						<table border="1" cellpadding="0" cellspacing="0" width="310px;" class="tamanio14">
							<thead>
								<tr>
									<th><b>CANT</b></th>
									<th><b>DESCRIPCION</b></th>
									<th><b>TOTAL</b></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>&nbsp;</td>
									<td>ESTADO DE CUENTA</td>
									<td class=" text-right ">&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>MES DE SETIEMBRE - 2015</td>
									<td class="text-right">1.00</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td class="text-right">&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td class="text-right">&nbsp;</td>
								</tr>
							</tbody>
						</table>
						<div class="panel panel-info">
							<div class="panel-heading" align="left">
								<font class="tamanio16">SON: Un Sol con cero centimos</font>
							</div>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div> <!-- Fin del Container -->

</body>
</html>