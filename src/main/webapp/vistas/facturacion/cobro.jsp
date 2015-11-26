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
	
	$('[data-toggle="popover"]').popover({ placement : 'right', trigger: "hover" });
	
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

function guardar(){
	
	var ruta = obtenerContexto();
	
	jsonObj = [];
	var parametros = new Object();
	parametros.codigoUsuario = $("#codigoUsuario").val();
	parametros.serie = "0001";
	parametros.secuencia = "00002";
	
    $("#tabla_resultado tbody tr").each(function (item) {
        var this_row = $(this);
        var numero = $.trim(this_row.find('td:eq(0)').html());
        var codConcepto = $.trim(this_row.find('td:eq(1)').html());
        var desConcepto = $.trim(this_row.find('td:eq(2)').html());
        var monto = $.trim(this_row.find('td:eq(3)').html());
        var codPuesto = $.trim(this_row.find('td:eq(4)').html());
		
        if(monto != "Monto" || codPuesto != "Cod.Puesto" || codConcepto != "Cod.Concepto"){
	        objetos = {};
	        objetos.codigoPuesto = codPuesto;
	        objetos.codigoConcepto = codConcepto;
	        objetos.monto = monto;
	        jsonObj.push(objetos);
        }
        
    });
    
    parametros.facturacionDetalle = JSON.stringify(jsonObj);
	
	$.ajax({
		type: "POST",
	    async:false,
	    url: "grabar-facturacion.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	        
	    	//alert("idFacturacion : " + result.idFacturacion + "\nLenCamposObligatorios : " + result.camposObligatorios.length);
	    	
	    	$.gritter.add({
				// (string | mandatory) the heading of the notification
				title: 'Mensaje',
				// (string | mandatory) the text inside the notification
				text: result.mensaje,
				// (string | optional) the image to display on the left
				image: "/" + ruta + "/recursos/images/confirm.png",
				// (bool | optional) if you want it to fade out on its own or just sit there
				sticky: false,
				// (int | optional) the time you want it to be alive for before fading out
				time: ''
			});
	    	
	    	if(result.idFacturacion > 0){
		    	
				$("#btnAgregar").attr("disabled", true);		    	
				$(".btnEliminar").attr("disabled", true);
					
		    }
	    	
		}
	});
}

function buscarPuesto(){
	
	puesto = $("#puestoBuscar").val();
	
	var parametros = new Object();
	parametros.nroPuesto = puesto;
	
	$.ajax({
        type: "POST",
        async:false,
        url: "buscar-socio-puesto.json",
        cache : false,
        data: parametros,
        success: function(result){
            
        	$("#dni").val(result.dni);
        	$("#apePaterno").val(result.apellidoPaterno);
        	$("#apeMaterno").val(result.apellidoMaterno);
        	$("#nombres").val(result.nombres);
        	$("#telefono").val(result.telefono);
        	$("#codigoSocio").val(result.codigoSocio);
        	$("#puesto").val(result.nroPuesto);
        	
        	cargarServicios();
        	
        }
    });
}


function cargarServicios(){
	
	var parametros = new Object();
	parametros.codigoSocio = $("#codigoSocio").val();
	
	$.ajax({
        type: "POST",
        async: false,
        url: "cargar-servicios.json",
        cache: false,
        data: parametros,
        success: function(result){
        	
        	var optionServicios = "<option value=0>SELECCIONAR</option>";
        	$.each(result, function(keyM, serv) {
        		
        		optionServicios += "<option value=" + serv.codigoServicio + ">" + serv.nombreServicio + "</option>";
        		
        	});
        	
        	$("#servicio").html(optionServicios);
    		
        }
    });
	
}


function agregarConcepto(){
	/*	
	var ruta = obtenerContexto();
	codigoConcepto = $("#codigoConcepto").val();
	descripcionConcepto = $("#concepto").val();
	codigoPuesto = $("#codigoPuesto").val();
	monto = $("#monto").val();
	
	if(codigoPuesto == 0){
		
		colorEtiquetas();
		
		$("#lblpuesto").css("color", "red");
        $("#lblpuesto-img").show();
        $("#lblpuesto-img").attr("data-content", "Seleccione un Puesto.");
        
	}else if(codigoConcepto == 0){
		
		colorEtiquetas();
		
		$("#lblconcepto").css("color", "red");
        $("#lblconcepto-img").show();
        $("#lblconcepto-img").attr("data-content", "Seleccione un Concepto.");
        
	}else if(monto == ""){
		
		colorEtiquetas();
		
        $("#lblmonto").css("color", "red");
        $("#lblmonto-img").show();
        $("#lblmonto-img").attr("data-content", "Ingrese un monto valido.");
        
	}else{
		if(validarSiNumero(monto)){
			
			colorEtiquetas();
			
			$('#tabla_resultado tbody tr:last').after(
				"<tr>" +
	            "<td align='right'>1</td>" + 
	            "<td align='center' style='display:none;'>" + codigoConcepto + "</td>" +
				"<td align='left'>" + descripcionConcepto + "</td>" +
				"<td align='right'>" + monto + "</td>" +
				"<td align='center' style='display:none;'>" + codigoPuesto + "</td>" +
				"<td align='center'>" +
				"<button type='button' class='boton btnEliminar' onclick='eliminarFila(this);'>" +
					"<img src='/"+ruta+"/recursos/images/icons/eliminar_16x16.png' alt='Eliminar' />" +
				"</button></td>" +
				"</tr>");
			
		}else{
			
			colorEtiquetas();
			
			$("#lblmonto").css("color", "red");
            $("#lblmonto-img").show();
            $("#lblmonto-img").attr("data-content", "Ingrese un monto valido.");
            
		}
	}
	
	calculoTotal();
	*/
}


function calculoTotal(){
	
	var total = 0;
    $("#tabla_resultado tbody tr").each(function (item) {
        var this_row = $(this);
        var monto = $.trim(this_row.find('td:eq(3)').html());
		if(monto != "" && monto != "Monto"){
			//console.log("[" + monto + "]");
			total = parseFloat(total) + parseFloat(monto);
		}
    });
	
	$("#totalesLetras").html(NumeroALetras(total));
	$("#totales").html(total.toFixed(2));
}

function eliminarFila(t){

	var td = t.parentNode;
    var tr = td.parentNode;
    var table = tr.parentNode;
	table.removeChild(tr);
	calculoTotal();
	
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
	<tr>
		<td colspan="7"><hr /></td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td><span id="lbldni"><b>DNI</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td><input type="text" id="dni" class="form-control" maxlength="8" disabled="disabled"/></td>
		<td valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td><span id="lblapepat"><b>Apellido Paterno</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td><input type="text" id="apePaterno" class="form-control" maxlength="30" disabled="disabled"/></td>
		<td valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td><span id="lblapemat"><b>Apellido Materno</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td><input type="text" id="apeMaterno" class="form-control" maxlength="30" disabled="disabled"/></td>
		<td valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td><span id="lblnombres"><b>Nombres</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td><input type="text" id="nombres" class="form-control" maxlength="40" disabled="disabled"/></td>
		<td valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td><span id="lbltelefono"><b>Telefono</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td><input type="text" id="telefono" class="form-control" maxlength="9" disabled="disabled"/></td>
		<td valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td><span id="lbltelefono"><b>Puesto</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td><input type="text" id="puesto" class="form-control" maxlength="9" disabled="disabled"/></td>
		<td valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td><span id="lblservicio"><b>Servicio</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td><select id="servicio" class="form-control"></select></td>
		<td valign="top"><img id="lblservicio-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td>&nbsp;</td>
		<td width="5px">&nbsp;</td>
		<td>&nbsp;</td>
		<td width="5px">&nbsp;</td>
		<td>
			<button type="button" id="btnAgregar" class="btn btn-primary">
				<img src="recursos/images/icons/agregar2_16x16.png" alt="Agregar" />&nbsp;Agregar
			</button>
		</td>
		<td valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="7">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="7">
			<table border="1" width="100%" id="tabla_resultado" cellspacing="5" cellpadding="5" class="tabla" width="50%">
				<tr>
					<td align="center" class="tablaCabecera">Nro</td>
					<td align="center" class="tablaCabecera" style="display:none;">Cod.Concepto</td>
					<td align="center" class="tablaCabecera">Desc.Concepto</td>
					<td align="center" class="tablaCabecera">Monto</td>
					<td align="center" class="tablaCabecera" style="display:none;">Cod.Puesto</td>
					<td align="center" class="tablaCabecera">Accion</td>
				</tr>
				<tfoot>
				<tr>
					<td colspan="2" align="left"><b><span id="totalesLetras" /></b></td>
					<td align="right"><b><span id="totales" /></b></td>
					<td align="center"></td>
				</tr>
				</tfoot>
			</table>
		</td>
	</tr>
</table>	
	
</body>
</html>