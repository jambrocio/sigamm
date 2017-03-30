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
</style>
<script>
$(document).ready(function(){
	
	$('[data-toggle="popover"]').popover({ placement : 'right', trigger: "hover" });
	
	$("#btnGrabar").attr("disabled", true);
	listarUsuarios();
	buscarMenuUsuario();
	
});

function listarUsuarios(){
	
	$.ajax({
		type: "GET",
	    async:false,
	    url: "listar-usuarios.json",
	    cache : false,
	    //data: parametros,
	    success: function(result){
	    	
	    	var menuOpciones = "<option value = '0' selected>SELECCIONAR</option>";
			$.each(result,function(keyM, opciones) {
			    
			    menuOpciones += "<option value='" + opciones.codigoUsuario + "'>" + opciones.apellidoPaterno + " " + opciones.apellidoMaterno + ", " + opciones.nombres + "</td></tr>";
			    
			});
			
			$("#usuarios").html(menuOpciones);       	
		}
	});
}

function buscarMenuUsuario(){
	
	jsonObj = [];
	var parametros = new Object();
	
	parametros.codigoUsuario = $("#usuarios").val();
		
	$.ajax({
		type: "POST",
	    async:false,
	    url: "buscar-menu-usuario.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	    	
	    	var cantidad = 0;
	    	var menuOpciones = "<table border='0' width='100%'>";
			$.each(result,function(keyM, menu) {
				cantidad = cantidad + 1;
			    //console.log("Titulo Menu [" + keyM + "] : " + menu.tituloMenu);
			    menuOpciones += "<tr><td><img src='recursos/images/icons/next_32x32.png'></td><td colspan='2'>" + menu.tituloMenu + "</td></tr>";
			    menuOpciones += "<tr><td colspan='3'>&nbsp;</td></tr>";
			    menuOpciones += "<tr><td width='5%'>&nbsp;</td><td colspan='2'>";
			    $.each(menu.niveles,function(keyN, niveles) {
			    	//console.log("Titulo SubMenu [" + keyN + "] : " + niveles.tituloSubMenu);
			    	menuOpciones += "<table id='tabla_resultado_" + cantidad + "' border='0' width='100%'><tr>";
			    	menuOpciones += "<td width='5%'>&nbsp;</td>";
			    	if(niveles.nivelAsignado == 1){
			    		menuOpciones += "<td align='center' width='5%'><input type='checkbox' id='chkSubMenu_" + niveles.codigoSubMenu + "' checked /></td>";
			    	}else{
			    		menuOpciones += "<td align='center' width='5%'><input type='checkbox' id='chkSubMenu_" + niveles.codigoSubMenu + "' /></td>";
			    	}
			    	menuOpciones += "<td>" + niveles.tituloSubMenu + "</td>";
			    	menuOpciones += "<td style='display:none;'>" + niveles.codigoSubMenu + "</td>";
			    	menuOpciones += "</tr></table>";
			    	
			    });
			    menuOpciones += "</td></tr>";
			    menuOpciones += "<tr><td colspan='3'>&nbsp;</td></tr>";
			});
			
			menuOpciones += "</table>";
			
			$("#txtcantidad").val(cantidad);
			
			//console.log("[" + menuOpciones + "]");
         	$("#menus").html(menuOpciones);       	
		}
	});
}

function seleccionarBusqueda(){
	
	codUsuario = $("#usuarios").val();
	
	if(codUsuario == 0){
		$("#btnGrabar").attr("disabled", true);
	}else{
		$("#btnGrabar").attr("disabled", false);
	}
	
	buscarMenuUsuario();
}

function grabarMenuUsuario(){
	
	var ruta = obtenerContexto();
	jsonObj = [];
	var parametros = new Object();
	
	var cantidad = $("#txtcantidad").val();
	for (i = 1; i <= cantidad; i++) { 
	    
		//alert("Cantidad : " + i);
	    
	    $("#tabla_resultado_" + i + " tbody tr").each(function (item) {
	        var this_row = $(this);
	        var tituloSubMenu = $.trim(this_row.find('td:eq(2)').html());
	        var codigoSubMenu = $.trim(this_row.find('td:eq(3)').html());
	        
	        isChecked = "0";
	        if($("#chkSubMenu_" + codigoSubMenu).is(':checked')) {
	        	isChecked = "1";
	        }
	        
	        objetos = {};
	        objetos.codigoSubMenu = codigoSubMenu;
	        objetos.isChecked = isChecked;
	        objetos.codigoUsuario = $("#usuarios").val();
	        jsonObj.push(objetos);
	        
	        //alert("[" + i + "] : " + tituloSubMenu + " - " + codigoSubMenu + " - " + isChecked);
	        
	    });
	}
	
	parametros.menuDetalle = JSON.stringify(jsonObj);
	
	$.ajax({
		type: "POST",
	    async:false,
	    url: "grabar-menu-usuario.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	    	
	    	if(result.retorno = '00'){
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
		}
	});
	
	buscarMenuUsuario();
}
</script>
</head>
<body id="body">
<input type="hidden" id="txtcantidad" value="0" />
<table border="0" width="100%">
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td width="90"><b>Usuario<b/></td>
		<td width="10">:</td>
		<td width="200"><select id="usuarios" class="form-control" onchange="seleccionarBusqueda();"/></td>
		<td>&nbsp;&nbsp;
			<button type="button" id="btnGrabar" class="btn btn-primary" onclick="grabarMenuUsuario();">
			<img src='recursos/images/icons/guardar_16x16.png' alt='Grabar' />&nbsp;Grabar
			</button>
			
		</td>
	</tr>
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4">
			<table id="menus" width='100%'></table>
		</td>
	</tr>
</table>	
 
<div id="dialog-confirm" title="Mensaje">
	<br>
  	<p><b><span id="mensajeAlerta" /></b></p>
</div>

</body>
</html>