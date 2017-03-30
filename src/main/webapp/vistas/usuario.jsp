<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:f="http://java.sun.com/jsf/core" xmlns:h="http://java.sun.com/jsf/html">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title></title>
<style>
.centrar {
    /*
    width:300px;
    height:300px;
    background-color:#d9d9d9;
    */
    position:fixed;
    margin-left:-150px; /* half of width */
    margin-top:-150px;  /* half of height */
    top:50%;
    left:50%;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	
	$('[data-toggle="popover"]').popover({ placement : 'right', trigger: "hover" });
	
});

function colorEtiquetas(){
	
	$("#lblclaveActual").css("color", "black");
	$("#lblnuevaClave").css("color", "black");
	$("#lblnuevaClaveRepetir").css("color", "black");
	
	$("#lblclaveActual-img").hide();
	$("#lblnuevaClave-img").hide();
	$("#lblnuevaClaveRepetir-img").hide();
	
}

function actualizarClave(){
	
	var ruta = obtenerContexto();
	
	jsonObj = [];
	var parametros = new Object();
	parametros.claveActual 			= $("#claveActual").val();
	parametros.nuevaClave 			= $("#nuevaClave").val();
	parametros.nuevaClaveRepetir 	= $("#nuevaClaveRepetir").val();
	
	$.ajax({
		type: "POST",
	    async:false,
	    url: "grabar-cambiar-clave.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	        
	    	colorEtiquetas();
	    	if(result.camposObligatorios.length == 0){
	    		
	    		if(result.codigo > 0){
	    			rutaImagen = "/" + ruta + "/recursos/images/confirm.png";
	    		}else{
	    			rutaImagen = "/" + ruta + "/recursos/images/advertencia.png";
	    		}
	    		
		    	$.gritter.add({
					// (string | mandatory) the heading of the notification
					title: 'Mensaje',
					// (string | mandatory) the text inside the notification
					text: result.mensaje,
					// (string | optional) the image to display on the left
					image: rutaImagen,
					// (bool | optional) if you want it to fade out on its own or just sit there
					sticky: false,
					// (int | optional) the time you want it to be alive for before fading out
					time: ''
				});
	    	
	    	}else{
	    		
	    		colorEtiquetas();
            	fila = "";
            	$.each(result.camposObligatorios, function(id, obj){
                    $("#" + obj.nombreCampo).css("color", "red");
                    $("#" + obj.nombreCampo + "-img").show();
                    $("#" + obj.nombreCampo + "-img").attr("data-content", obj.descripcion);
                    
                });
            	
	    	}
		}
	});
	
}
</script>
</head>
<body>
<table border="0" align="center" class="centrar">
	<tr>
		<td><span id="lblclaveActual"><b>Clave Actual</b></span></td>
	</tr>
	<tr>
		<td colspan="2">
			<div class="input-group">
		    	<div class="input-group-addon"><img src="recursos/images/icons/security_16x16.png" border="0" /></div>
		    	<input class="form-control" type="password" name="claveActual" id="claveActual" placeholder="Ingrese clave actual" />
		    </div><br />
		</td>
		<td valign="top"><img id="lblclaveActual-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
	</tr>
	<tr>
		<td><span id="lblnuevaClave"><b>Nueva Clave</b></span></td>
	</tr>
	<tr>
		<td colspan="2">
			<div class="input-group">
		    	<div class="input-group-addon"><img src="recursos/images/icons/security_16x16.png" border="0" /></div>
		    	<input class="form-control" type="password" name="nuevaClave" id="nuevaClave" placeholder="Ingrese nueva clave" />
		    </div><br />
		</td>
		<td valign="top"><img id="lblnuevaClave-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
	</tr>
	<tr>
		<td><span id="lblnuevaClaveRepetir"><b>Nueva Clave (Repetir)</b></span></td>
	</tr>
	<tr>
		<td colspan="2">
			<div class="input-group">
		    	<div class="input-group-addon"><img src="recursos/images/icons/security_16x16.png" border="0" /></div>
		    	<input class="form-control" type="password" name="nuevaClaveRepetir" id="nuevaClaveRepetir" placeholder="Repetir nueva clave" />
		    </div><br />
		</td>
		<td valign="top"><img id="lblnuevaClaveRepetir-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
	</tr>
	<tr>
		<td colspan="2" align="right">
			<input id="aceptar" value="Aceptar" class="btn btn-primary" onclick="actualizarClave();" />
		</td>
	</tr>
</table>
</body>
</html>