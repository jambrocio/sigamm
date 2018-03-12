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
    
    .tamanioPrinter12
    {
        color:black;
        font-family: Calibri;
		font-size: 12px;    
    }
    
    .tamanioPrinter10
    {
        color:black;
        /*font-family: Calibri;*/
        font-family:Tahoma, Geneva, sans-serif;
		font-size: 10px;    
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
	
	.modal-dialog {
  		width: 600px;
	}
	
	.marca-de-agua {
	    background-image: url("../recursos/images/logo.png");
	    background-repeat: no-repeat;
	    background-position: center;
	    width: 100%;
	    height: auto;
	    margin: auto;
	}
	
	@import url(http://fonts.googleapis.com/css?family=Courier+New);
	body,h1,h2,h3,h4,h5,h6 {
		font-family: 'Bree Serif', serif;
	}
</style>
<script>
$(document).ready(function(){	
	
	$('[data-toggle="popover"]').popover({ placement : 'right', trigger: "hover" });
	$("#btnVisualizacion").hide();
	
	$.datepicker.regional['es'] = {
	        closeText: 'Cerrar',
	        prevText: '<Ant',
	        nextText: 'Sig>',
	        currentText: 'Hoy',
	        monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
	        monthNamesShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],
	        dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
	        dayNamesShort: ['Dom','Lun','Mar','Mié','Juv','Vie','Sáb'],
	        dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
	        weekHeader: 'Sm',
	        dateFormat: 'dd/mm/yy',
	        firstDay: 1,
	        isRTL: false,
	        showMonthAfterYear: false,
	        yearSuffix: ''
	};
	
	$.datepicker.setDefaults($.datepicker.regional['es']);
	
	$("#fechaFacturacion").datepicker({   
		changeMonth: true,
		changeYear: false,
		numberOfMonths: 1,
		dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
		monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo',
			'Junio', 'Julio', 'Agosto', 'Septiembre',
		    'Octubre', 'Noviembre', 'Diciembre'],
		monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr',
			'May', 'Jun', 'Jul', 'Ago',
		    'Sep', 'Oct', 'Nov', 'Dic'] 
	});
	
	/*
	$("#importeVariableExtra").keydown(function(event){
		if(event.shiftKey){
			event.preventDefault();
		}
		if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 46 || event.keyCode == 8) {
			event.preventDefault();
        }
	});
	*/
	
	$("#importeVariableExtra").keyup(function (){
    	this.value = (this.value + '').replace(/[^0-9.]/g, '');
	});
});
function colorEtiquetas(){
	
	$("#lblservicio").css("color", "black");
	//$("#lblcomprobante").css("color", "black");
	$("#lblfechafacturacion").css("color", "black");
	
	$("#lblservicio-img").hide();
	//$("#lblcomprobante-img").hide();
	$("#lblfechafacturacion-img").hide();
	
}
function nuevoCobro(){
	
	$("#facturacionImprimir").hide();
	
	colorEtiquetas();
	
	$("#codigoPuesto").val(0);
	
	$("#dniBuscar").val("");
	$("#puestoBuscar").val("");
	$("#puesto").val("");
	$("#servicio").val(0);
	
	$("#dni").val("");
	$("#apePaterno").val("");
	$("#apeMaterno").val("");
	$("#nombres").val("");
	$("#telefono").val("");
	//$("#comprobante").val("");
	$("#fechaFacturacion").val("");
	
	limpiarTablaDeudas();
	limpiarTablaResultado();
	
	$("#btnBuscar").attr("disabled", false);
	$("#btnAgregar").attr("disabled", false);
	$("#puestoBuscar").attr("disabled", false);
	$("#btnVisualizacion").hide();
	$("#servicio").attr("disabled", false);
	$("#btnGuardar").attr("disabled", false);
	
	$("#codigoFacturacion").val(0);
	$("#txtServicio").val("");
	$("#codigoServicios").val(0);
	$("#txtServicio").typeahead('destroy');
}
function guardar(){
	
	var ruta = obtenerContexto();
	
	jsonObj = [];
	var parametros = new Object();
	parametros.codigoUsuario = $("#codigoUsuario").val();
	//parametros.serie = "0001";
	//parametros.secuencia = "00002";
	parametros.codigoSocio = $("#codigoSocio").val();
	parametros.fechaCreacion = $("#fechaFacturacion").val();
	parametros.serie = $("#comprobante").val();
	parametros.secuencia = $("#comprobante").val();
	
	cantidadItems = 0;
    $("#tabla_resultado tbody tr").each(function (item) {
        var this_row = $(this);
        var numero = $.trim(this_row.find('td:eq(0)').html());
        var codDeuda = $.trim(this_row.find('td:eq(1)').html());
        var desConcepto = $.trim(this_row.find('td:eq(3)').html());
        var monto = $.trim(this_row.find('td:eq(4)').html());
        var codPuesto = $.trim(this_row.find('td:eq(5)').html());
        var codServicio = $.trim(this_row.find('td:eq(7)').html());
        var codServicioDetalle = $.trim(this_row.find('td:eq(8)').html());
        
        if(monto != "Monto" || codPuesto != "Cod.Puesto" || codDeuda != "Cod.Concepto"){
	        objetos = {};
	        objetos.codigoDeudaSocio = codDeuda;
	        objetos.monto = monto;
	        objetos.codigoServicio = codServicio;
	        objetos.codigoServicioDetalle = codServicioDetalle;
	        jsonObj.push(objetos);
	        
	        cantidadItems = cantidadItems + 1;        
        }
        
    });
    
    //console.log("Cantidad de Items : " + cantidadItems);
    if(cantidadItems > 5){
    	
    	$.gritter.add({
			// (string | mandatory) the heading of the notification
			title: 'Mensaje',
			// (string | mandatory) the text inside the notification
			text: "Solo se permite agregar 5 items.",
			// (string | optional) the image to display on the left
			image: "/" + ruta + "/recursos/images/advertencia.png",
			// (bool | optional) if you want it to fade out on its own or just sit there
			sticky: false,
			// (int | optional) the time you want it to be alive for before fading out
			time: ''
		});
    	
    }else{
    	
    	parametros.facturacionDetalle = JSON.stringify(jsonObj);
    	
    	$.ajax({
    		type: "POST",
    	    async:false,
    	    url: "grabar-facturacion.json",
    	    cache : false,
    	    data: parametros,
    	    success: function(result){
    	        
    	    	colorEtiquetas();
    	    	//alert("idFacturacion : " + result.idFacturacion + "\nLenCamposObligatorios : " + result.camposObligatorios.length);
    	    	if(result.camposObligatorios.length == 0){
    	    		
    	    		if(result.idFacturacion > 0){
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
    	    	
    		    	if(result.idFacturacion > 0){
    			    	
    		    		$("#facturacionImprimir").show(); 
    		    		$("#idFacturacion").html(result.idFacturacion);
    		    		
    		    		$("#btnBuscar").attr("disabled", true);
    					$("#btnAgregar").attr("disabled", true);		    	
    					$(".btnEliminar").attr("disabled", true);
    					$("#puestoBuscar").attr("disabled", true);
    					$("#btnGuardar").attr("disabled", true);
    					$("#btnVisualizacion").show();
    					$("#servicio").attr("disabled", true);
    					
    					limpiarTablaFacturacion();
    					limpiarTablaFacturacion2();
    					
    					$("#correlativo").html(result.comprobante);
    					$("#correlativo2").html(result.comprobante);
    					$("#codigoFacturacion").val(result.idFacturacion);
    					
    					dataTabla = "";
    					cantidadLineas = 1;
    					$("#tabla_resultado tbody tr").each(function (item) {
    				        var this_row = $(this);
    				        var numero = $.trim(this_row.find('td:eq(0)').html());
    				        var codDeuda = $.trim(this_row.find('td:eq(1)').html());
    				        var tipoConcepto = $.trim(this_row.find('td:eq(2)').html());
    						var desConcepto = $.trim(this_row.find('td:eq(3)').html());
    				        var monto = $.trim(this_row.find('td:eq(4)').html());
    				        var codPuesto = $.trim(this_row.find('td:eq(5)').html());
    				        
    				        desConcepto = replaceAll(desConcepto, "ENERO", "ENE");
    				        desConcepto = replaceAll(desConcepto, "FEBRERO", "FEB");
    				        desConcepto = replaceAll(desConcepto, "MARZO", "MAR");
    				        desConcepto = replaceAll(desConcepto, "ABRIL", "ABR");
    				        desConcepto = replaceAll(desConcepto, "MAYO", "MAY");
    				        desConcepto = replaceAll(desConcepto, "JUNIO", "JUN");
    				        desConcepto = replaceAll(desConcepto, "JULIO", "JUL");
    				        desConcepto = replaceAll(desConcepto, "AGOSTO", "AGO");
    				        desConcepto = replaceAll(desConcepto, "SEPTIEMBRE", "SET");
    				        desConcepto = replaceAll(desConcepto, "OCTUBRE", "OCT");
    				        desConcepto = replaceAll(desConcepto, "NOVIEMBRE", "NOV");
    				        desConcepto = replaceAll(desConcepto, "DICIEMBRE", "DIC");
    				        
    				        if(monto != "Monto" || codPuesto != "Cod.Puesto" || codDeuda != "Cod.Concepto"){
    				        	
    				        	var importe = monto * 1;
    				        	
    					    	dataTabla += "<tr>";
    					    	dataTabla += "<td align='center'>1</td>";
    					    	dataTabla += "<td class='tamanioPrinter10'><b>" + tipoConcepto + "</b><br>" + desConcepto + "</td>";
    					    	dataTabla += "<td align='right' class='tamanioPrinter10'>S/. " + formatearImporte(importe) + "</td>";
    					    	dataTabla += "</tr>";
    					    	
    				        }
    				        cantidadLineas = cantidadLineas + 1;
    				        
    				    });
    					
    					//console.log("Cantidad de Lineas : " + cantidadLineas);
    					
    					var j = 8 - cantidadLineas; 
    					for (i=0 ;i < j; i++) { 
    						 
    						dataTabla += "<tr>";
    				    	dataTabla += "<td>&nbsp;</td>";
    				    	dataTabla += "<td>&nbsp;</td>";
    				    	dataTabla += "<td>&nbsp;</td>";
    				    	dataTabla += "</tr>";
    				    	
    					}
    					
    					dataTabla1 = dataTabla;
    					dataTabla1 += "<tr>";
    			    	dataTabla1 += "<td>&nbsp;</td>";
    			    	dataTabla1 += "<td class='tamanioPrinter10' ><b>TOTAL</b></td>";
    			    	dataTabla1 += "<td align='right' class='tamanioPrinter10'><b>S/. <span id='totalImpresion'/></b></td>";
    			    	dataTabla1 += "</tr>";
    			    	
    			    	dataTabla2 = dataTabla;
    					dataTabla2 += "<tr>";
    			    	dataTabla2 += "<td>&nbsp;</td>";
    			    	dataTabla2 += "<td class='tamanioPrinter10' ><b>TOTAL</b></td>";
    			    	dataTabla2 += "<td align='right' class='tamanioPrinter10'><b>S/. <span id='totalImpresion2'/></b></td>";
    			    	dataTabla2 += "</tr>";
    			    			    	
    					$('#tablaFacturacionDetalle tbody tr:last').after(dataTabla1);
    					$('#tablaFacturacionDetalle2 tbody tr:last').after(dataTabla2);
    					
    					calculoTotal();
    					
    			    }
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
    
}
function buscarPuesto(){
	
	var f = new Date();
	var fecha = pad(f.getDate(), 2) + "/" + pad((f.getMonth() +1), 2) + "/" + f.getFullYear() + " " + f.getHours() + ":" + f.getMinutes();
	
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
        	//$("#comprobante").val(result.numeroComprobante);
        	
        	$("#printAsociado").html(result.apellidoPaterno + " " + result.apellidoMaterno + ", " + result.nombres);
        	$("#printAsociado2").html(result.apellidoPaterno + " " + result.apellidoMaterno + ", " + result.nombres);
        	$("#printPuesto").html(result.nroPuesto);
        	$("#printPuesto2").html(result.nroPuesto);
        	$("#printGiro").html(result.nombreGiro);
        	$("#printGiro2").html(result.nombreGiro);
        	$("#printSector").html(pad(result.nombreSector, 2));
        	$("#printSector2").html(pad(result.nombreSector, 2));
        	$("#printFecha").html(fecha);
        	$("#printFecha2").html(fecha);
        	//$("#printFecha").html($("#fechaFacturacion").val());
        	$("#txtServicio").val("");
        	$("#codigoServicios").val(0);
        	
        	$("#fechaFacturacion").val(fechaSistema());
        	
        	cargarServicios();
        	
        	limpiarTablaDeudas();
        	limpiarTablaResultado();
        	
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
        	
        	$("#txtServicio").typeahead({
                source: result,
                displayField: 'nombreServicio',
                valueField: 'codigoServicio',
             	scrollBar: true,
                alignWidth: false,
                menu: '<ul class="typeahead dropdown-menu"></ul>',
                item: '<li><a href="#"></a></li>',
                onSelect: displayResult
        	});
        	
        }
    });
}
function displayResult(item) {
    //alert('You selected <strong>' + item.value + '</strong>: <strong>' + item.text + '</strong>');
    $("#codigoServicios").val(item.value);
    $("#tituloServicios").val(item.text);
    
    buscarDeudasCodigoSocio(item.value);
}
function limpiarTablaFacturacion(){
	
	var tabla = document.getElementById("tablaFacturacionDetalle");
	var filasTabla = tabla.rows.length;
	
	for(var i = 0; i < filasTabla; i++) {
		
		if(i > 0){
 			
 			tabla.deleteRow(1);
 			
 		}
 		
 	}
	
}
function limpiarTablaFacturacion2(){
	
	var tabla = document.getElementById("tablaFacturacionDetalle2");
	var filasTabla = tabla.rows.length;
	
	for(var i = 0; i < filasTabla; i++) {
		
		if(i > 0){
 			
 			tabla.deleteRow(1);
 			
 		}
 		
 	}
	
}
function limpiarTablaDeudas(){
	
	var tabla = document.getElementById("tabla_deudas_socio");
	var filasTabla = tabla.rows.length;
	
	for(var i = 0; i < filasTabla; i++) {
		
		if(i > 0){
 			
 			tabla.deleteRow(1);
 			
 		}
 		
 	}
}
function limpiarTablaResultado(){
	
	var tabla = document.getElementById("tabla_resultado");
	var filasTabla = tabla.rows.length;
	
	for(var i = 0; i < filasTabla - 1; i++) {
		
 		if(i > 0){
 			
 			tabla.deleteRow(1);
 			
 		}
 		
 	}
	
	$("#totalesLetras").html("");
	$("#totalLetras").html("");
	$("#totalLetras2").html("");
	$("#totales").html("");
	$("#totalImpresion").html("");
	$("#totalImpresion2").html("");
	
}
/*
function buscarDeudasSocio(){
	
	var ruta = obtenerContexto();
	limpiarTablaDeudas();
	
	var parametros = new Object();
	parametros.codigoSocio = $("#codigoSocio").val();
	parametros.codigoServicioDetalle = $("#servicio").val();
	
	$.ajax({
        type: "POST",
        async: false,
        url: "buscar-deuda-socio-concepto.json",
        cache: false,
        data: parametros,
        success: function(result){
        	
        	$.each(result, function(keyM, serv) {
        		
        		if(serv.flagImporteVariable == 1){
	        		$('#tabla_deudas_socio tbody tr:last').after(
	        				"<tr>" +
	        				"<td style='display:none;'>" + serv.codigoDeudaSocio + "</td>" +
	        				"<td align='center'><input type='checkbox' id='chk_" + serv.codigoDeudaSocio + "'></td>" +
	        	            "<td align='left'>" + serv.fecPeriodo + "</td>" +
	        				"<td align='right' id='importeVariable'>" + serv.importe + "</td>" +
	        				"<td style='display:none;'>" + $("#codigoServicios").val() + "</td>" +
	        				"<td style='display:none;'>" + serv.codigoServicioDetalle + "</td>" +
	        				"<td style='display:none;'>" + $("#tituloServicios").val() + "</td>" +
	        				"<td align='center'><img src='/"+ruta+"/recursos/images/icons/plus_24x24.png' border='0' title='Agregar Importe' onclick='mostrarVentanaImporte();' /></td>" +
	        				"</tr>");
        		}else{
        			$('#tabla_deudas_socio tbody tr:last').after(
	        				"<tr>" +
	        				"<td style='display:none;'>" + serv.codigoDeudaSocio + "</td>" +
	        				"<td align='center'><input type='checkbox' id='chk_" + serv.codigoDeudaSocio + "'></td>" +
	        	            "<td align='left'>" + serv.fecPeriodo + "</td>" +
	        				"<td align='right'>" + serv.importe + "</td>" +
	        				"<td style='display:none;'>" + $("#codigoServicios").val() + "</td>" +
	        				"<td style='display:none;'>" + serv.codigoServicioDetalle + "</td>" +
	        				"<td style='display:none;'>" + $("#tituloServicios").val() + "</td>" +
	        				"<td style='display:none;'></td>" +
	        				"</tr>");
        		}        		
        		
        	});
        	
        }
    });
	
}
*/
function buscarDeudasCodigoSocio(codigoServicio){
	
	var ruta = obtenerContexto();
	limpiarTablaDeudas();
	
	var parametros = new Object();
	parametros.codigoSocio = $("#codigoSocio").val();
	parametros.codigoServicioDetalle = codigoServicio;
	
	$.ajax({
        type: "POST",
        async: false,
        url: "buscar-deuda-socio-concepto.json",
        cache: false,
        data: parametros,
        success: function(result){
        	
        	$.each(result, function(keyM, serv) {
        		
        		if(serv.flagImporteVariable == 1){
	        		$('#tabla_deudas_socio tbody tr:last').after(
	        				"<tr>" +
	        				"<td style='display:none;'>" + serv.codigoDeudaSocio + "</td>" +
	        				"<td align='center'><input type='checkbox' id='chk_" + serv.codigoDeudaSocio + "'></td>" +
	        	            "<td align='left'>" + serv.fecPeriodo + "</td>" +
	        				"<td align='right' id='importeVariable'>" + serv.importe + "</td>" +
	        				"<td style='display:none;'>" + $("#codigoServicios").val() + "</td>" +
	        				"<td style='display:none;'>" + serv.codigoServicioDetalle + "</td>" +
	        				"<td style='display:none;'>" + $("#tituloServicios").val() + "</td>" +
	        				"<td align='center'><img src='/"+ruta+"/recursos/images/icons/plus_24x24.png' border='0' title='Agregar Importe' onclick='mostrarVentanaImporte();' /></td>" +
	        				"</tr>");
        		}else{
        			$('#tabla_deudas_socio tbody tr:last').after(
	        				"<tr>" +
	        				"<td style='display:none;'>" + serv.codigoDeudaSocio + "</td>" +
	        				"<td align='center'><input type='checkbox' id='chk_" + serv.codigoDeudaSocio + "'></td>" +
	        	            "<td align='left'>" + serv.fecPeriodo + "</td>" +
	        				"<td align='right'>" + serv.importe + "</td>" +
	        				"<td style='display:none;'>" + $("#codigoServicios").val() + "</td>" +
	        				"<td style='display:none;'>" + serv.codigoServicioDetalle + "</td>" +
	        				"<td style='display:none;'>" + $("#tituloServicios").val() + "</td>" +
	        				"<td style='display:none;'></td>" +
	        				"</tr>");
        		}        		
        		//console.log("Periodo : " + serv.fecPeriodo + "\nImporte : " + serv.importe);
        		
        	});
        	
        }
    });
	
}
function mostrarVentanaImporte(){
	
	$('#importe_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
}
function agregarImporte(){
	
	importeTemp = $("#importeVariableExtra").val();
	var res = importeTemp.replace(/[^0-9.]/g, '');
	//console.log("importeTemp : " + importeTemp + " - " + isNaN(importeTemp));
	$("#importeVariable").html(res);
	
}
function calculoTotal(){
	
	var total = 0;
    $("#tabla_resultado tbody tr").each(function (item) {
        var this_row = $(this);
        //var monto = $.trim(this_row.find('td:eq(3)').html());
        var monto = $.trim(this_row.find('td:eq(4)').html());
		if(monto != "" && monto != "Monto"){
			//console.log("[" + monto + "]");
			total = parseFloat(total) + parseFloat(monto);
		}
    });
	
	$("#totalesLetras").html(NumeroALetras(total));
	$("#totalLetras").html(NumeroALetras(total));
	$("#totalLetras2").html(NumeroALetras(total));
	$("#totales").html(total.toFixed(2));
	$("#totalImpresion").html(total.toFixed(2));
	$("#totalImpresion2").html(total.toFixed(2));
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
function agregarDeuda(){
	
	var ruta = obtenerContexto();
	codigoPuesto = $("#codigoPuesto").val();
	
	$("#tabla_deudas_socio tbody tr").each(function (item) {
        var this_row 				= $(this);
        var codigoDeuda 			= $.trim(this_row.find('td:eq(0)').html());
        var check 					= $.trim(this_row.find('td:eq(1)').html());
        var concepto 				= $.trim(this_row.find('td:eq(2)').html());
        var importe 				= $.trim(this_row.find('td:eq(3)').html());
        var codigoServicio 			= $.trim(this_row.find('td:eq(4)').html());
        var codigoServicioDetalle	= $.trim(this_row.find('td:eq(5)').html());
        var tituloServicio 			= $.trim(this_row.find('td:eq(6)').html());
        
        if(importe != "Importe"){
	        
        	//console.log("codigoDeuda : " + codigoDeuda + "\nCheck : " + check + "\nConcepto : " + concepto + "\nImporte : " + importe);
        	
        	//Verifica si esta checked
        	if($("#chk_" + codigoDeuda).is(':checked')) {  
            	
        		var existe = 0;
        		$("#tabla_resultado tbody tr").each(function (itemResultado) {
        	        var this_row_resultado = $(this);
        	        var codigoDeudaResultado 	= $.trim(this_row_resultado.find('td:eq(1)').html());
        	        var conceptoResultado 		= $.trim(this_row_resultado.find('td:eq(2)').html());
        	        var descConceptoResultado 	= $.trim(this_row_resultado.find('td:eq(3)').html());
        	        
        	        if(codigoDeuda == codigoDeudaResultado){
        	        	if(concepto == descConceptoResultado){
        	        		existe = existe + 1;	
        	        	}        	        	
        	        }
            	});
        		
        		if(existe == 0){
	        		$('#tabla_resultado tbody tr:last').after(
	        				"<tr>" +
	        	            "<td align='right'>1</td>" + 
	        	            "<td align='center' style='display:none;'>" + codigoDeuda + "</td>" +
	        	            "<td align='left'>" + tituloServicio + "</td>" +
	        				"<td align='left'>" + concepto + "</td>" +
	        				"<td align='right'>" + importe + "</td>" +
	        				"<td align='center' style='display:none;'>" + codigoPuesto + "</td>" +
	        				"<td align='center'>" +
	        				"<button type='button' class='boton btnEliminar' onclick='eliminarFila(this);'>" +
	        					"<img src='/"+ruta+"/recursos/images/icons/eliminar_16x16.png' alt='Eliminar' />" +
	        				"</button></td>" +
	        				"<td align='center' style='display:none' >" + codigoServicio + "</td>" +
	        				"<td align='center' style='display:none' >" + codigoServicioDetalle + "</td>" +
	        				"</tr>");
        		}
        		
        		existe = 0;
        		
        	}
        }
        
    });
	
	calculoTotal();
}
function visualizacion(){
	//$("div#myPrintArea").printArea();
	
	$('#visualizacion_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
}
function imprimir(){
	
	$("div#myPrintArea").printArea();
	
}
function openNewWindowForJasperWithCharts(){
	
	var url  = "/sigamm/imprimirFactura?codigoFacturacion=" + $("#codigoFacturacion").val();
	var strWindowFeatures = "menubar=no,location=no,width=800,height=500";
	window.open(url,"_blank", "location=0,height=500,width=800");
	
}
function openNewWindowForJasperWithChartsOthers(){
	
	var url  = "/sigamm/imprimirFacturaOthers?codigoFacturacion=" + $("#codigoFacturacion").val();
	var strWindowFeatures = "menubar=no,location=no,width=800,height=500";
	window.open(url,"_blank", "location=0,height=500,width=800");
	
}
</script>
</head>
<body id="body">
<input type="hidden" id="codigoFacturacion" />
<input type="hidden" id="codigoServicios" />
<input type="hidden" id="tituloServicios" />
<div class="modal fade" id="visualizacion_modal" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog">
		
		<!-- Modal content-->
		<div class="modal-content" style="width: 1150px; ">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Visualización</h4>
			</div>
			<div class="modal-body">
					
				<div id="myPrintArea">
					<!-- 
					<table border="0" style="width: 1100px; " cellpadding="0" cellspacing="0">
					 -->
					<table border="0" style="width: 1250px; " cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top">
								<table border="0" width="100%" >
									<tr>
										<td width="49%" valign="top">
											<table border="0" width="100%" >
												<tr>
													<td colspan="4" align="center" class="tamanioPrinter12" ><b>ASOCIACIÓN DE COMERCIANTES DEL MERCADO MODELO<BR>DE HUARAL<BR>Fundado el 13 de Noviembre de 1996<BR>R.U.C. 20530606334</b></td>
												</tr>
												<tr>
													<td colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td colspan="4" align="center" class="tamanioPrinter12"><b>RECIBO N° <span id="correlativo" /></b></td>
												</tr>
												<tr>
													<td colspan="4" style="height: 35px; ">&nbsp;</td>
												</tr>
												<tr>
													<td class="tamanioPrinter10" ><b>Asociado (a):</b></td>
													<td class="tamanioPrinter10" width="300px"><span id="printAsociado"/></td>
													<td class="tamanioPrinter10" ><b>Fecha:</b></td>
													<td class="tamanioPrinter10"><span id="printFecha"/></td>
												</tr>
												<tr>
													<td class="tamanioPrinter10" ><b>Nº de Puesto:</b></td>
													<td colspan="3" valign="top">
														<table border="0" width="100%" cellpadding="0" cellspacing="0" id="tablaDatos">
															<tr>
																<td class="tamanioPrinter10" width="70px"><span id="printPuesto"/></td>
																<td class="tamanioPrinter10" style="width: 35px; "><b>Sector:</b></td>
																<td class="tamanioPrinter10" width="70px"><span id="printSector"/></td>
																<td class="tamanioPrinter10" style="width: 35px; "><b>Giro:</b></td>
																<td class="tamanioPrinter10" width="200px"><span id="printGiro"/></td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td colspan="4">
														<table border="1" width="100%" cellspacing="5" cellpadding="5" class="tabla" id="tablaFacturacionDetalle">
															<tr>
																<td width="40px" align="center" class="tamanioPrinter10" ><b>CANT.</b></td>
																<td align="center" class="tamanioPrinter10" ><b>DESCRIPCION</b></td>
																<td width="90px" align="center" class="tamanioPrinter10" ><b>IMPORTE</b></td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td colspan="4" class="tamanioPrinter10"><b>Son: <span id="totalLetras" /></b></td>
												</tr>
											</table>
										</td>
										<td width="2%">&nbsp;&nbsp;&nbsp;&nbsp;</td>
										<!-- SEGUNDA PARTE -->
										<td width="49%" valign="top">
											<table border="0" width="100%" >
												<tr>
													<td colspan="4" align="center" class="tamanioPrinter12" ><b>ASOCIACIÓN DE COMERCIANTES DEL MERCADO MODELO<BR>DE HUARAL<BR>Fundado el 13 de Noviembre de 1996<BR>R.U.C. 20530606334</b></td>
												</tr>
												<tr>
													<td colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td colspan="4" align="center" class="tamanioPrinter12"><b>RECIBO N° <span id="correlativo2" /></b></td>
												</tr>
												<tr>
													<td colspan="4" style="height: 35px; ">&nbsp;</td>
												</tr>
												<tr>
													<td class="tamanioPrinter10" ><b>Asociado (a):</b></td>
													<td class="tamanioPrinter10" width="300px"><span id="printAsociado2"/></td>
													<td class="tamanioPrinter10" ><b>Fecha:</b></td>
													<td class="tamanioPrinter10"><span id="printFecha2"/></td>
												</tr>
												<tr>
													<td class="tamanioPrinter10" ><b>Nº de Puesto:</b></td>
													<td colspan="3" valign="top">
														<table border="0" width="100%" cellpadding="0" cellspacing="0" id="tablaDatos">
															<tr>
																<td class="tamanioPrinter10" width="70px"><span id="printPuesto2"/></td>
																<td class="tamanioPrinter10" style="width: 35px; "><b>Sector:</b></td>
																<td class="tamanioPrinter10" width="70px"><span id="printSector2"/></td>
																<td class="tamanioPrinter10" style="width: 35px; "><b>Giro:</b></td>
																<td class="tamanioPrinter10" width="200px"><span id="printGiro2"/></td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td colspan="4">
														<table border="1" width="100%" cellspacing="5" cellpadding="5" class="tabla" id="tablaFacturacionDetalle2">
															<tr>
																<td width="40px" align="center" class="tamanioPrinter10" ><b>CANT.</b></td>
																<td align="center" class="tamanioPrinter10" ><b>DESCRIPCION</b></td>
																<td width="90px" align="center" class="tamanioPrinter10" ><b>IMPORTE</b></td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td colspan="4" class="tamanioPrinter10"><b>Son: <span id="totalLetras2" /></b></td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
				
			</div>
			<div class="modal-footer">
				
				<button type="button" id="btnImprimir" class="btn btn-primary  pull-left" onclick="imprimir();">
					<img src="recursos/images/icons/print_16x16.png" alt="Imprimir" />&nbsp;Imprimir
				</button>
				
				<button type="button" id="btnCerrar" data-dismiss="modal" class="btn btn-default pull-left">
					Cerrar
				</button>
				
				<!-- 
				<a href="javascript:openNewWindowForJasperWithCharts();">
					<button type="button" class="btn btn-primary">
						<img src="recursos/images/icons/print_16x16.png" alt="Imprimir" />&nbsp;Imprimir
					</button>&nbsp;&nbsp;
				</a>
				 -->
				<!-- 
				<a href="javascript:openNewWindowForJasperWithChartsOthers();">
					<button type="button" class="btn btn-primary">
						<img src="recursos/images/icons/print_16x16.png" alt="Imprimir" />&nbsp;Imprimir Others
					</button>&nbsp;&nbsp;
				</a>
				 -->
				
			</div>
		</div>
		  
	</div>
</div>

<input type="hidden" id="codigoSocio" />
<table border="0" style="width: 900px;">
	<tr>
		<td colspan="9" align="right">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="9" align="left">
			<button type="button" id="btnNuevo" class="btn btn-primary" onclick="nuevoCobro()">
				<img src="recursos/images/icons/nuevo_16x16.png" alt="Nuevo" />&nbsp;Nuevo
			</button>
			&nbsp;
			<button type="button" id="btnGuardar" class="btn btn-primary" onclick="guardar()">
				<img src="recursos/images/icons/guardar_16x16.png" alt="Guardar" />&nbsp;Guardar
			</button>
			&nbsp;
			<button type="button" id="btnVisualizacion" class="btn btn-primary" onclick="visualizacion();">
				<img src="recursos/images/icons/print_16x16.png" alt="Imprimir" />&nbsp;Imprimir
			</button>
		</td>
	</tr>
	<tr>
		<td colspan="9">&nbsp;</td>
	</tr>
	<tr>
		<td width="10px" align="left">&nbsp;</td>
		<td width="120px" align="left"><span id="lblNumeroPuesto"><b>Nro.Puesto</b></span></td>
		<td width="5px">&nbsp;</td>
		<td width="5px" align="left"><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td width="200px"><input type="text" id="puestoBuscar" class="form-control" maxlength="5" /></td>
		<td width="130px" valign="top">&nbsp;&nbsp;
			<button type="button" id="btnBuscar" class="btn btn-primary" onclick="buscarPuesto()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
			</button>
		</td>
		<td colspan="2">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<!-- 
			<span id="facturacionImprimir" style="display:none; font-size:18px;"><font color="red"><b>Código : <span id="idFacturacion"/></span></b></font>
			 -->
		</td>
		
	</tr>
	<tr>
		<td colspan="9"><hr /></td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td width="120px"><span id="lbldni"><b>DNI</b></span></td>
		<td width="5px">&nbsp;</td>
		<td width="5px"><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td width="200px"><input type="text" id="dni" class="form-control" maxlength="8" disabled="disabled"/></td>
		<td width="130px" valign="top">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td><span id="lblapepat"><b>Apellido Paterno</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td><input type="text" id="apePaterno" class="form-control" maxlength="30" disabled="disabled"/></td>
		<td valign="top">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td><span id="lblapemat"><b>Apellido Materno</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td><input type="text" id="apeMaterno" class="form-control" maxlength="30" disabled="disabled"/></td>
		<td valign="top">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td><span id="lblnombres"><b>Nombres</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td><input type="text" id="nombres" class="form-control" maxlength="40" disabled="disabled"/></td>
		<td valign="top">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td><span id="lbltelefono"><b>Telefono</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td><input type="text" id="telefono" class="form-control" maxlength="9" disabled="disabled"/></td>
		<td valign="top">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td><span id="lbltelefono"><b>Puesto</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td><input type="text" id="puesto" class="form-control" maxlength="9" disabled="disabled"/></td>
		<td valign="top">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td><span id="lblservicio"><b>Servicio</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td>
			<!-- 
			<select id="servicio" class="form-control" onchange=buscarDeudasSocio();></select>
			-->
			<input type="text" id="txtServicio" class="col-md-12 form-control" autocomplete="off" />
		</td>
		<td valign="top"><img id="lblservicio-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<!-- 
	<tr>
		<td width="10px">&nbsp;</td>
		<td><span id="lblcomprobante"><b>N° Comprobante</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td><input type="text" id="comprobante" class="form-control" maxlength="11" /></td>
		<td valign="top"><img id="lblcomprobante-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
		<td colspan="2">&nbsp;</td>
	</tr>
	 -->
	<tr>
		<td width="10px">&nbsp;</td>
		<td><span id="lblfechafacturacion"><b>Fecha Facturación</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td><input type="text" id="fechaFacturacion" class="form-control" maxlength="10" /></td>
		<td valign="top"><img id="lblfechafacturacion-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="9">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="9" align="left">
			<button type="button" id="btnAgregar" class="btn btn-primary" onclick="agregarDeuda();">
				<img src="recursos/images/icons/agregar2_16x16.png" alt="Agregar" />&nbsp;Agregar
			</button>
		</td>
	</tr>
	<tr>
		<td colspan="9">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="9">
			<table border="0" width="100%">
				<tr>
					<td valign="top">
						<table border="1" width="100%" id="tabla_deudas_socio" cellspacing="5" cellpadding="5" class="tabla">
							<tr>
								<td align="center" class="tablaCabecera" width="20px" style="display:none;">&nbsp;</td>
								<td align="center" class="tablaCabecera" width="20px">&nbsp;</td>
								<td align="center" class="tablaCabecera">Desc.Concepto</td>
								<td align="center" class="tablaCabecera" width="100px">Importe</td>
								<td align="center" class="tablaCabecera" width="20px" style="display:none;">Cod.Servicio</td>
								<td align="center" class="tablaCabecera" width="20px" style="display:none;">Cod.Servicio Detalle</td>
								<td align="center" class="tablaCabecera" width="20px" style="display:none;">Titulo.Servicio</td>
							</tr>
						</table>
					</td>
					<td>&nbsp;&nbsp;</td>
					<td colspan="7" valign="top">
						<table border="1" width="100%" id="tabla_resultado" cellspacing="5" cellpadding="5" class="tabla" width="50%">
							<tr>
								<td align="center" class="tablaCabecera">Nro</td>
								<td align="center" class="tablaCabecera" style="display:none;">Cod.Concepto</td>
								<td align="center" class="tablaCabecera">Concepto</td>
								<td align="center" class="tablaCabecera">Desc.Concepto</td>
								<td align="center" class="tablaCabecera">Monto</td>
								<td align="center" class="tablaCabecera" style="display:none;">Cod.Puesto</td>
								<td align="center" class="tablaCabecera">Accion</td>
								<td align="center" class="tablaCabecera" style="display:none;">Cod.Servicio</td>
								<td align="center" class="tablaCabecera" style="display:none;">Cod.Servicio Detalle</td>
							</tr>
							<tfoot>
							<tr>
								<td colspan="3" align="left"><b><span id="totalesLetras" /></b></td>
								<td align="right"><b><span id="totales" /></b></td>
								<td align="center"></td>
							</tr>
							</tfoot>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>	

<div class="modal fade" id="importe_modal" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Agregar Importe</h4>
			</div>
			<div class="modal-body">
				
					<table border="0" style="width: 650px;">
						<tr>
							<td colspan="7" align="right">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="7" align="left">
								<button type="button" class="btn btn-primary" onclick="agregarImporte()">
									<img src="recursos/images/icons/guardar_16x16.png" alt="Agregar" />&nbsp;Agregar
								</button>
							</td>
						</tr>
						<tr>
							<td colspan="7" align="right">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblimporteVariableExtra"><b>Importe (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="importeVariableExtra" class="form-control" maxlength="8" style="width: 80px"/></td>
							<td valign="top"><img id="lblimporteVariableExtra-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td colspan="7">&nbsp;</td>
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