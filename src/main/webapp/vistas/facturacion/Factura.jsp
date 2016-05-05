<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
.media print {
	color: #000 !important;
	text-shadow: none !important;
	background: transparent !important;
	box-shadow: none !important;
}

.table {
	border-collapse: collapse !important;
}

.table-bordered th,.table-bordered td {
	border: 1px solid #ddd !important;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">content here</div>
		<!-- /row -->
	</div>
	<pre>
	 <!-- /container -->
</pre>
	<div class="col-xs-6">
		<h1>
			<a href=" "><img alt="" src="logo.png" /> Logo aquí </a>
		</h1>
	</div>
	<div class="col-xs-6 text-right">
		<h1>FACTURA</h1>
		<h1>
			<small>Factura #001</small>
		</h1>
	</div>
	<hr />

	<pre>Sección siguiente
	</pre>
	<div class="row">
		<div class="col-xs-5">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4>
						De: <a href="#">Su Nombre</a>
					</h4>
				</div>
				<div class="panel-body">Dirección detalles más detalles</div>
			</div>
		</div>
		<div class="col-xs-5 col-xs-offset-2 text-right">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4>
						Para : <a href="#">Nombre del Cliente</a>
					</h4>
				</div>
				<div class="panel-body">Dirección detalles más detalles</div>
			</div>
		</div>
	</div>
	<pre>
		<!-- / fin de sección de datos del Cliente  -->
Detalles de la factura aquí

</body>
</html>