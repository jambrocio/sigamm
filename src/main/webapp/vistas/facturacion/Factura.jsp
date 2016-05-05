<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>

/*@import url(http://fonts.googleapis.com/css?family=Bree+Serif);*/
@import url(http://fonts.googleapis.com/css?family=Courier+New);

body,h1,h2,h3,h4,h5,h6 {
	font-family: 'Bree Serif', serif;
}

/* Estilo de impresión */	
	/*#contenido {float:right; margin:10px auto; width:500px;}*/
</style>

</head>

<body>
	<div class="container">
		<div class="col-xs-6" id="logo">
			<h1>
				<a href=" "><img alt="" src="logo.png" /> Logo aquí </a>
			</h1>
		</div>
		<div class="col-xs-6 text-right" id="Titulo">
			<h1>FACTURA</h1>
			<h1>
				<small>Factura #001</small>
			</h1>
		</div>
		<hr />
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
		<!-- / fin de sección de datos del Cliente  -->
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>
						<h4>Servicio</h4>
					</th>
					<th>
						<h4>Descripción</h4>
					</th>
					<th>
						<h4>Hrs / Cantidad</h4>
					</th>
					<th>
						<h4>Tarifa / Precio</h4>
					</th>
					<th>
						<h4>Sub-Total</h4>
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>Artículo</td>
					<td><a href="#"> Título de su artículo aquí </a></td>
					<td class=" text-right ">-</td>
					<td class=" text-right ">200.00 €</td>
					<td class=" text-right ">200.00 €</td>
				</tr>
				<tr>
					<td>Plantilla de diseño</td>
					<td><a href="#"> Detalles del proyecto aquí </a></td>
					<td class="text-right">10</td>
					<td class="text-right ">75.00 €</td>
					<td class="text-right ">750.00 €</td>
				</tr>
				<tr>
					<td>Desarrollo</td>
					<td><a href="#"> Plugin WordPress </a></td>
					<td class="text-right ">5</td>
					<td class="text-right">50.00 €</td>
					<td class="text-right">250.00 €</td>
				</tr>
			</tbody>
		</table>
		<div class="row text-right">
			<div class="col-xs-3 col-xs-offset-7">
				<strong> Sub Total: Impuestos (IVA 21%): Total: </strong>
			</div>
			<div class="col-xs-2">
				<strong> 1,200.00 € 252.00 € 1,452.00 € </strong>
			</div>
		</div>
		<div class="panel panel-info">
			<div class="panel-heading">
				<h4>Datos bancarios</h4>
			</div>
			<div class="panel-body">Su nombre Nombre del banco SWIFT:
				------- Número de cuenta: 12345678 IBAN: ------</div>
		</div>
		<div class="span7">
			<div class="panel panel-info">
				<div class="panel-heading">
					<h4>Datos de contacto</h4>
				</div>
				<div class=" panel-body ">
					Email: usted@ejemplo.com Móvil: +92123456789 Twitter: <a
						href="https://twitter.com/suTwitter">@suTwitter</a> |Suweb: <a
						href="http://www.suweb.com/author/usted"> http: //www.
						suweb.com/author/usted / </a>
					<h4>
						<small> El pago debe ser por transferencia bancaria</small>
					</h4>
				</div>
			</div>
		</div>
	</div>
</body>
</html>