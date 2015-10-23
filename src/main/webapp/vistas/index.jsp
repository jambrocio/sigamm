<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:f="http://java.sun.com/jsf/core" xmlns:h="http://java.sun.com/jsf/html">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title></title>
<script type="text/javascript">
var voto_realizado = "Su voto ya fue registrado<br>Gracias por participar";
var acceso_denegado = "Acceso Denegado<br>por ser Personal Directivo";
var elecciones_no_disponibles = "No hay elecciones disponibles.";
$(document).ready(function() {
	
	$.blockUI.defaults.overlayCSS.cursor = 'default';
	
	$("#candidato_container").dialog({
    	autoOpen:false,
        width: 650,
        height: 500,
        modal: false,
        resizable: false
    });
	
	//listarCandidatos();
	
});

function listarCandidatos(){
	
	existeVoto = 0;
	cantidadRegistros = 0;
	divisor = "<table id='tablaCandidatos' border='0' cellpadding='5' cellspacing='5' >";
	$.ajax({
        type: "POST",
        async:false,
        url: "listar-usuarios-eleccion.json",
        cache : false,
        success: function(result){
            
        	divisor += "<tr>";
        	divisor += "<td colspan='4' align='right'>";
        	divisor += "<button type='button' class='btn btn-primary' id='btnVotoBlanco' onclick='votoBlanco();'>";
        	divisor += "<img src='recursos/images/icons/nuevo_24x24.png' alt='Voto en Blanco'/>&nbsp;Voto en Blanco";
        	divisor += "</button>";
        	divisor += "</td>";
        	divisor += "</tr>";
			
        	$.each(result.rows, function(key,val) {
    			
        		cantidadRegistros = cantidadRegistros + 1; 
        		
        		nombreUt = replaceAll(val.nombreUt, " ", "$");
        		nombreRol = replaceAll(val.nombreRol, " ", "$");
        		apellidoPaterno = replaceAll(val.apellidoPaterno, " ", "$");
        		apellidoMaterno = replaceAll(val.apellidoMaterno, " ", "$");
        		nombres = replaceAll(val.nombres, " ", "$");
        		
        		datos = nombres + "$" + apellidoPaterno + "$" + apellidoMaterno;   
        		
        		divisor += "<tr>";
        		divisor += "<td valign='top'>&nbsp;&nbsp;<b>" + (key + 1) + "</b>&nbsp;&nbsp;</td>";
        		divisor += "<td><img id='foto_" + val.dni + "_100' src='recursos/images/nodisponible_250x250.gif' /></td>";
        		divisor += "<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>";
        		divisor += "<td><center><b>CANDIDATO N° " + val.orden + "<br>" + val.nombres + " " + val.apellidoPaterno + " " + val.apellidoMaterno + "</b><br>" + val.nombreRol + "<br>" + val.nombreUt + "</center>";
        		divisor += "<br><br><center>";
        		divisor += "<a href=javascript:mostrarCandidato(";
        		divisor += val.codigoEleccion + ",";
        		divisor += val.orden + ",";
        		divisor += val.codigoUsuario + ",'";
        		divisor += val.dni + "','";
    			divisor += nombreUt + "','";
    			divisor += nombreRol + "','";
    			divisor += datos + "') >";
    			divisor += "Votar - Ver información</a></center></td>";
        		divisor += "</tr>";
        		divisor += "<tr><td colspan=4 valign=middle><hr style='color: #3496C4; background-color: #3496C4; height: 2px;' /></td></tr>";
        		
        		$("#codigoEleccion").val(val.codigoEleccion);
        		
        		existeVoto = val.existeVoto;
    		});
    		
        	divisor += "</table>";
        	$("#candidatos").html(divisor);
        	
        	
			$.each(result.rows, function(key,val) {
    			$("#foto_" + val.dni + "_100").attr("src", "mostrarImagenPersonal/" + val.dni + "_100");
    		});
			
			if(cantidadRegistros == 0){
				
				mensaje = "<table border=0 width='100%'>";
        		mensaje += "<tr><td colspan=2>&nbsp;</td><tr>";
        		mensaje += "<tr>";
        		mensaje += "<td colspan=2>";
        		mensaje += "<b>" + elecciones_no_disponibles + "</b>";
        		mensaje += "</td>";
        		mensaje += "</tr>";
        		mensaje += "<tr><td colspan=2>&nbsp;</td><tr>";
        		mensaje += "</table>";
        		
        		$("#codigoUsuario").val(0);
        		$("#btnVotoBlanco").hide();
        		
        		$("#candidatos").block({ 
        	        message: mensaje, 
        	        centerY: 0, 
        	        css: { top: '100px', left: '', right: '10px', border: '2px solid #3496C4', width: '300px' }
        		
        	    });
        		
			}else{
				
				if(existeVoto == 2){
					
					mensaje = "<table border=0 width='100%'>";
	        		mensaje += "<tr><td colspan=2>&nbsp;</td><tr>";
	        		mensaje += "<tr>";
	        		mensaje += "<td colspan=2>";
	        		mensaje += "<b>" + acceso_denegado + "</b>";
	        		mensaje += "</td>";
	        		mensaje += "</tr>";
	        		mensaje += "<tr><td colspan=2>&nbsp;</td><tr>";
	        		mensaje += "</table>";
	        		
	        		$("#codigoUsuario").val(0);
	        		
	        		$("#candidatos").block({ 
	        	        message: mensaje, 
	        	        centerY: 0, 
	        	        css: { top: '100px', left: '', right: '10px', border: '2px solid #3496C4', width: '300px' }
	        		
	        	    });
				}else if(existeVoto == 1){
					
					mensaje = "<table border=0 width='100%'>";
	        		mensaje += "<tr><td colspan=2>&nbsp;</td><tr>";
	        		mensaje += "<tr>";
	        		mensaje += "<td colspan=2>";
	        		mensaje += "<b>" + voto_realizado + "</b>";
	        		mensaje += "</td>";
	        		mensaje += "</tr>";
	        		mensaje += "<tr><td colspan=2>&nbsp;</td><tr>";
	        		mensaje += "</table>";
	        		
	        		$("#codigoUsuario").val(0);
	        		
	        		$("#candidatos").block({ 
	        	        message: mensaje, 
	        	        centerY: 0, 
	        	        css: { top: '100px', left: '', right: '10px', border: '2px solid #3496C4', width: '300px' }
	        		
	        	    });
				}else{
					
					mensaje = "<table border=0 width='550px' align='center'>";
					mensaje += "<tr><td colspan='2'>&nbsp;&nbsp;</td></tr>";
					mensaje += "<tr><td rowspan='7' width='100px' align='center' valign='top'><img src='recursos/images/icons/exclamation_48x48.png' /></td></tr>";
					mensaje += "<tr><td align='left'><h4>Estimado colaborador :</h4></td></tr>";
					mensaje += "<tr><td colspan='2'>&nbsp;&nbsp;</td></tr>";
					mensaje += "<tr><td align='right'><h4>¡Tienes la opción de votar solo por un candidato!</h4></td></tr>";
					mensaje += "<tr><td colspan='2'>&nbsp;&nbsp;</td></tr>";
					mensaje += "<tr><td align='center'><button type=button class='btn btn-primary' onclick='desbloquear()''><img src='recursos/images/icons/check_16x16.png' />&nbsp;Aceptar</button></td></tr>";
					mensaje += "<tr><td colspan='2'>&nbsp;&nbsp;</td></tr>";
					mensaje += "</table>";
				
					$("#candidatos").block({ 
	        	        message: mensaje, 
	        	        centerY: 0, 
	        	        css: { top: '100px', left: '', right: '10px', border: '2px solid #3496C4', width: '600px' }
	        		
	        	    });
					
				}
			}
				
        }
    });
}

function votoBlanco(){
	
	mensaje = "<table border=0 width='100%'>";
	mensaje += "<tr><td colspan=2>&nbsp;</td><tr>";
	mensaje += "<tr>";
	mensaje += "<td colspan=2>";
	mensaje += "<b>¿Esta seguro de realizar voto en blanco?</b>";
	mensaje += "</td>";
	mensaje += "</tr>";
	mensaje += "<tr><td colspan=2>&nbsp;</td><tr>";
	mensaje += "<tr>";
	mensaje += "<td align='right'>";
	mensaje += "<button type='button' class='btn btn-primary' onclick='votarEnBlanco();'>";
	mensaje += "<img src='recursos/images/icons/check_24x24.png' alt='SI'/>&nbsp;SI";
	mensaje += "</button>";
	mensaje += "&nbsp;&nbsp;</td>";
	mensaje += "<td align='left'>&nbsp;&nbsp;";
	mensaje += "<button type='button' class='btn btn-primary' onclick='desbloquear();'>";
	mensaje += "<img src='recursos/images/icons/eliminar_24x24.png' alt='NO'/>&nbsp;NO";
	mensaje += "</button>";
	mensaje += "</td>";
	mensaje += "</tr>";
	mensaje += "<tr><td colspan=2>&nbsp;</td><tr>";
	mensaje += "</table>";
	
	$("#codigoUsuario").val(0);
	
	$("#candidatos").block({ 
        message: mensaje, 
        centerY: 0, 
        css: { top: '100px', left: '', right: '10px', border: '2px solid #3496C4', width: '300px' }
	
    });
	
}; 

function desbloquear(){
	$("#candidatos").unblock();
}

function mostrarCandidato(codigoEleccion, orden, codigoUsuario, dni, ut, rol, datos){
	
	$("#candidato_container").dialog("open");
	$("#foto_candidato").attr("src", "mostrarImagenPersonal/" + dni + "_250");
	$("#ut").html(replaceAll(ut, "$", " "));
	$("#rol").html(replaceAll(rol, "$", " "));
	$("#nombres").html(replaceAll(datos, "$", " "));
	$("#codigoUsuario").val(codigoUsuario);
	$("#orden").html("CANDIDATO N° " + orden);
}

function voto(){
	
	var parametros = new Object();
	parametros.codigoUsuario = $("#codigoUsuario").val();
	parametros.codigoEleccion = $("#codigoEleccion").val();
	
	$.ajax({
        type: "POST",
        async:false,
        url: "grabar-voto.json",
        cache : false,
        data: parametros,
        success: function(result){
            
        	//alert("Retorno : " + result.retorno);
        	console.log("Retorno : [" + result.retorno + "]");
        	
        	if(result.retorno == "00"){
        		
        		$("#candidato_container").dialog("close");
        		
        		mensaje = "<table border=0 width='100%'>";
        		mensaje += "<tr><td colspan=2>&nbsp;</td><tr>";
        		mensaje += "<tr>";
        		mensaje += "<td colspan=2>";
        		mensaje += "<b>" + voto_realizado + "</b>";
        		mensaje += "</td>";
        		mensaje += "</tr>";
        		mensaje += "<tr><td colspan=2>&nbsp;</td><tr>";
        		mensaje += "</table>";
        		
        		$("#codigoUsuario").val(0);
        		
        		$("#candidatos").block({ 
        	        message: mensaje, 
        	        centerY: 0, 
        	        css: { top: '100px', left: '', right: '10px', border: '2px solid #3496C4', width: '300px' }
        		
        	    });
        		
        		$("html, body").animate({ scrollTop: 0 }, "slow");
        		
        	}
        }        
    });
	
}; 

function votarEnBlanco(){
	
	var parametros = new Object();
	parametros.codigoUsuario = $("#codigoUsuario").val();
	parametros.codigoEleccion = $("#codigoEleccion").val();
	
	$.ajax({
        type: "POST",
        async:false,
        url: "grabar-voto-blanco.json",
        cache : false,
        data: parametros,
        success: function(result){
            
			console.log("Retorno : [" + result.retorno + "]");
        	
        	if(result.retorno == "00"){
        		
        		desbloquear();
        		
        		mensaje = "<table border=0 width='100%'>";
        		mensaje += "<tr><td colspan=2>&nbsp;</td><tr>";
        		mensaje += "<tr>";
        		mensaje += "<td colspan=2>";
        		mensaje += "<b>" + voto_realizado + "</b>";
        		mensaje += "</td>";
        		mensaje += "</tr>";
        		mensaje += "<tr><td colspan=2>&nbsp;</td><tr>";
        		mensaje += "</table>";
        		
        		$("#codigoUsuario").val(0);
        		
        		$("#candidatos").block({ 
        	        message: mensaje, 
        	        centerY: 0, 
        	        css: { top: '100px', left: '', right: '10px', border: '2px solid #3496C4', width: '300px' }
        		
        	    });
        		
        		$("html, body").animate({ scrollTop: 0 }, "slow");
        		 
        	}
        }        
    });
	
};

function cerrar(){
	
	$("#candidato_container").dialog("close");
	
}

</script>
</head>
<body>
<input type="hidden" id="codigoUsuario" />
<input type="hidden" id="codigoEleccion" />
<div id="candidatos" />

<div id="candidato_container" title="Candidato">
	<table border="0" align="left" cellpadding="5" cellspacing="5" width="100%">
		<tr>
			<td colspan="2">&nbsp;</td>
			<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn btn-primary" onclick="voto()">
					<img src="recursos/images/icons/ok_24x24.png" alt="Votar" />&nbsp;Votar
				</button>
				<button type="button" class="btn btn-primary" onclick="cerrar()">
					<img src="recursos/images/icons/eliminar_24x24.png" alt="Cerrar" />&nbsp;Cerrar
				</button>
				<br/>
			</td>
		</tr>
		<tr>
			<td>
				<img id="foto_candidato" src="recursos/images/icons/guardar_16x16.png" />
			</td>
			<td>&nbsp;&nbsp;</td>
			<td valign="top">
				<br />&nbsp;&nbsp;
				<table border="0" cellpadding="15" cellspacing="15" align="center">
					<tr>
						<td align="center"><span id="orden" /></td>
					</tr>
					<tr>
						<td align="center"><span id="nombres" /></td>
					</tr>
					<tr>
						<td align="center"><span id="rol" /></td>
					</tr>
					<tr>
						<td align="center"><span id="ut" /></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>

</body>
</html>