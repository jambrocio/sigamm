<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:f="http://java.sun.com/jsf/core" xmlns:h="http://java.sun.com/jsf/html">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title></title>
<style>
    .gBubble
    {
        color:black;
        font-family:Tahoma, Geneva, sans-serif;
        font-size:12px;    
    }
    
    .modal-header-primary {
		color:#fff;
		padding:9px 15px;
		border-bottom:1px solid #eee;
		background-color: #428bca;
		-webkit-border-top-left-radius: 5px;
		-webkit-border-top-right-radius: 5px;
		-moz-border-radius-topleft: 5px;
		-moz-border-radius-topright: 5px;
		 border-top-left-radius: 5px;
		 border-top-right-radius: 5px;
	}
	.boton {
		background:none;
	  	border:0;
	  	margin:0;
	  	padding:0;
	  	outline:0 none;
	}
	
	.tablaCabecera{
		background-color: #428bca;
		color:white;
        /*font-family:Tahoma, Geneva, sans-serif;*/
        /*font-size:12px;*/
        font-weight: bold;
	}
</style>

<script>
$(document).ready(function(){	
	
	//$('[data-toggle="popover"]').popover({ placement : 'right', trigger: "hover" });
	
});

function colorEtiquetas(){
	
	$("#lblservicio").css("color", "black");
	
	$("#lblservicio-img").hide();
	
}

function nuevoCobro(){
	
	colorEtiquetas();
	
	$("#codigoPuesto").val(0);
	
	$("#dniBuscar").val("");
	
	$("#dni").val("");
	$("#apePaterno").val("");
	$("#apeMaterno").val("");
	$("#nombres").val("");
	$("#telefono").val("");
	
	$("#btnBuscar").attr("disabled", false);
	
	var tabla = document.getElementById("tabla_resultado");
	var filasTabla = tabla.rows.length;
	
	for(var i = 0; i < filasTabla - 1; i++) {
		
 		if(i > 0){
 			
 			tabla.deleteRow(1);
 			
 		}
 		
 	}
	
	$("#totalesLetras").html("");
	$("#totales").html("");
	$("#btnAgregar").attr("disabled", false);
 	
}


function validarSiNumero(numero){
	
	//if (!/^([0-9])*$/.test(numero)){
	if (!/^([0-9])*[.]?[0-9]*$/.test(numero)){
		return false;	
	}else{
		return true;
	}
	
}
	
</script>
</head>
<body id="body">
<input type="hidden" id="codigoSocio" />
<table border="0" style="width: 500px;">
	<tr>
		<td colspan="7" align="right">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="7" align="left">
			<button type="button" class="btn btn-primary" onclick="nuevoCobro()">
				<img src="recursos/images/icons/nuevo_16x16.png" alt="Nuevo" />&nbsp;Nuevo
			</button>
			&nbsp;
			<button type="button" class="btn btn-primary" onclick="guardar()">
				<img src="recursos/images/icons/guardar_16x16.png" alt="Buscar" />&nbsp;Guardar
			</button>
			&nbsp;
			<button type="button" class="btn btn-primary">
				<img src="recursos/images/icons/reservar2_16x16.png" alt="Reservar" />&nbsp;Reservar
			</button>
		</td>
	</tr>
	<tr>
		<td colspan="7" align="right">&nbsp;</td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td><span id="lblNumeroPuesto"><b>Nro.Puesto</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td><input type="text" id="puestoBuscar" class="form-control" maxlength="4" /></td>
		<td valign="top">&nbsp;&nbsp;
			<button type="button" id="btnBuscar" class="btn btn-primary" onclick="buscarPuesto()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
			</button>
		</td>
	</tr>
</table>	
	
</body>
</html>