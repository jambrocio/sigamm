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
	
	$("#lblconcepto").css("color", "black");
	
	$("#lblconcepto-img").hide();
	
}

function nuevoEgreso(){
	
	colorEtiquetas();
	
	/*$("#codigoPuesto").val(0);	
	$("#dniBuscar").val("");	
	$("#dni").val("");
	$("#apePaterno").val("");
	$("#apeMaterno").val("");
	$("#nombres").val("");
	$("#telefono").val("");	
	$("#totalesLetras").html("");
	$("#totales").html("");
	$("#btnAgregar").attr("disabled", false);*/
 
	cargarConceptos();
}

function cargarConceptos(){
	
	var parametros = new Object();
	parametros.rubro = 'E';
	
	$.ajax({
        type: "POST",
        async: false,
        url: "cargar-conceptos.json",
        cache: false,
        data: parametros,
        success: function(result){
        	
        	var optionConceptos = "<option value=0>SELECCIONAR</option>";
        	$.each(result, function(keyM, conceptos) {
        		
        		optionConceptos += "<option value=" + conceptos.codigoConcepto + ">" + conceptos.nombreConcepto + "</option>";
        		
        	});
        	
        	$("#concepto").html(optionConceptos);
    		
        }
    });
	
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
			<button type="button" class="btn btn-primary" onclick="nuevoEgreso()">
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
	<!-- tr>
		<td width="150"><b>EGRESOS...<b/></td>
		<td width="10">:</td>
		<td width="200"><input type="text" id="reciboBuscara" class="form-control" maxlength="8" /></td>
		<td>&nbsp;&nbsp;
			<button class="btn btn-primary" data-toggle="modal" data-target="egreso_modal" onclick="nuevoEgreso()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Nuevo" />&nbsp;Nuevo
			</button>
		</td>
	</tr -->
	<tr>
		<td colspan="7" align="right">&nbsp;</td>
	</tr>
</table>	


<div class="modal fade" id="egreso_modal" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"><span id="tituloRegistro" />Nuevo Egreso</h4>
			</div>
			<div class="modal-body">
				
					<table border="0" style="width: 500px;">
						<tr>
							<td colspan="7" align="right">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="7" align="left">
								<button type="button" class="btn btn-primary" onclick="guardar(1)">
									<img src="recursos/images/icons/guardar_16x16.png" alt="Buscar" />&nbsp;Guardar
								</button>
							</td>
						</tr>
						<tr>
							<td colspan="7"><hr /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lbltipodocumento"><b>TIPO DOCUMENTO (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="tipodocumento" class="form-control" maxlength="20"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblconcepto"><b>CONCEPTO (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><select id="concepto" class="form-control"></select></td>
							<td valign="top"><img id="lblconcepto-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblnro"><b>NRO (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="nro" class="form-control" maxlength="8"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td colspan="6"><b>(*) Campos Obligatorios</b></td>
						</tr>
					</table>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
			</div>
		</div>
		  
	</div>
</div> 
	
</body>
</html>