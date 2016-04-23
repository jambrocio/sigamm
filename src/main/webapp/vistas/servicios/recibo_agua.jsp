<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:f="http://java.sun.com/jsf/core" xmlns:h="http://java.sun.com/jsf/html">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<style type="text/css">
	.texto {
		background-color:rgb(189,252,152);
		color:rgb(0,0,0);
	}
	
</style>
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

/* SLIDE ONE */
	.slideOne {
	    width: 50px;
	    height: 10px;
	    background: #333;
	    margin: 20px auto;
	
	    -webkit-border-radius: 50px;
	    -moz-border-radius: 50px;
	    border-radius: 50px;
	    position: relative;
	
	    -webkit-box-shadow: inset 0px 1px 1px rgba(0,0,0,0.5), 0px 1px 0px rgba(255,255,255,0.2);
	    -moz-box-shadow: inset 0px 1px 1px rgba(0,0,0,0.5), 0px 1px 0px rgba(255,255,255,0.2);
	    box-shadow: inset 0px 1px 1px rgba(0,0,0,0.5), 0px 1px 0px rgba(255,255,255,0.2);
	}

/* CHECKBOX */	
	/*body {
	  font-family: 'Lily Script One', cursive;
	  background-color: #c0392b;
	  margin: 50px;
	}*/
	
	a {
	  color: white;
	  text-shadow: #34495e 2px 2px 1px;
	}

	/*fieldset {
  		border: 2px solid white;
  		border-radius: 6px;
	}
	
	legend {
	  color: #fff;
	  text-shadow: #34495e 2px 2px 1px;
	  padding: 0 4px;
	  font-size: 20px;
	  text-align: right;
	}*/
	
	label.check {
	  display: block;
	  cursor: pointer;
	  line-height: 36px;
	  padding-left: 26px;
	  font-size: 28px;
	  color: #e74c3c;
	  text-shadow: #2c3e50 2px 2px 1px;
	  transition: .3s;
	  background: url('https://dl.dropboxusercontent.com/u/3522/check_off.png') left center no-repeat;
	}
	
	label.check input {
	  position: absolute;
	  left: -9999px;
	}
	
	label.check.c_on {
	  background: url('https://dl.dropboxusercontent.com/u/3522/check_on.png')  left center no-repeat;
	  /*color: #fff;*/
	  color: #e74c3c;
	  text-shadow: #34495e 2px 2px 1px;
	}
</style>
<script>
var intentos = 0;


$(document).ready(function(){
	
	cargarNuevo();
	cargarReciboAgua();
	$("#contraba").hide();
	$("#correlativo").val('0');
	$("#consumoMesSocio").val('0');
	$("#consumoMesSocioTrabado").val('0');
	$("#alcantarilladoSocio").val('0');
	$("#totalSocio").text('0');
	$('#suspendido').val('0');
	
	var input = document.querySelectorAll("label.check input");

	if(input !== null) {
	  [].forEach.call(input, function(el) {
	  
	    if(el.checked) {
	      el.parentNode.classList.add('c_on');
	    } 
	  
	    el.addEventListener("click", function(event) {	    	
	      	event.preventDefault();	      
 	      	el.parentNode.classList.toggle('c_on');
	    }, false);
	  });
	}
	
	
	$( '#suspendidoSocio' ).on( 'click', function() {
	    if( $("#seleccionador").attr("class") == 'check c_on' ){
	    	//alert("El checkbox con valor " + $('#suspendidoSocio').val() + " ha sido seleccionado");
	    	$('#consumoMesSocio').attr('disabled','-1');
	    	$('#consumoMesSocioTrabado').attr('disabled','-1');
	    	$('#alcantarilladoSocio').attr('disabled','-1');
	    	$('#mantenimientoSocio').attr('disabled','-1');
	    	$('#deudaAnteriorSocio').attr('disabled','-1');
	    	$('#totalSocio').val('0.0');
	    	$('#totalSocio').attr('disabled','-1');
	    	$('#suspendido').val('1');
	    	
	    } else {
	    	//alert("El checkbox con valor " + $('#suspendidoSocio').val() + " ha sido DEseleccionado");
	    	$('#consumoMesSocio').removeAttr('disabled');
	    	$('#consumoMesSocioTrabado').removeAttr('disabled');
	    	$('#alcantarilladoSocio').removeAttr('disabled');
	    	$('#mantenimientoSocio').removeAttr('disabled');
	    	$('#deudaAnteriorSocio').removeAttr('disabled');
	    	$('#totalSocio').removeAttr('disabled');
	    	$('#suspendido').val('0');
	    }
	});
});

$(function($){
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
});


$(function() {
	$("#periodo").datepicker({
        dateFormat: 'MM yy',
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
		regional: 'es',
        onClose: function(dateText, inst) {  
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val(); 
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val(); 
            $(this).val($.datepicker.formatDate('MM yy', new Date(year, month, 1)));
        }
    });  
	
	
	$("#periodo").focus(function () {
        $(".ui-datepicker-calendar").hide();
        $("#ui-datepicker-div").position({
            my: "center top",
            at: "center bottom",
            of: $(this)
        });    
    });
	
	$("#fechacorte").datepicker(
    {   
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
	
	$("#fechavencimiento").datepicker(
    {   
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
});


function cargarNuevo(){
	
	$("#tituloRegistro").html("Nuevo Recibo Agua");
	
	colorEtiquetas();
	
	$("#codigorecibo").val('0');
	$("#periodo").val('');
	$("#lecturainicial").val('0');
	$("#lecturafinal").val('0');
	$("#monto").val('0.0');
}

function cargarReciboAgua(){
	
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		var opciones = "<center>";
			
			opciones += "<a href=javascript:editarReciboAgua(";
			opciones += rowObject.codigoRecibo + ",'" + rowObject.periodo.replace(' ','_') + "','" + rowObject.lecturaInicial + "','" + rowObject.lecturaFinal + "','" + rowObject.monto + "','" + rowObject.fechaCorte.replace(/\s/g,"_") + "','" + rowObject.fechaVencimiento.replace(/\s/g,"_") + "','" + rowObject.observaciones + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Recibo Agua'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:eliminarReciboAgua(";
			opciones += rowObject.codigoRecibo + ",'" + rowObject.periodo.replace(' ','_') + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/eliminar_24x24.png' border='0' title='Eliminar Recibo Agua'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:generarReciboAguaSocio(";
			opciones += rowObject.codigoRecibo + ") >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/water_24x24.png' border='0' title='Generar Recibo Agua para cada Socio'/>";
			opciones += "</a>";			
			
			opciones += "&nbsp;&nbsp;";
			
			if (rowObject.estadoAbierto == 0) {			
				opciones += "<a href=javascript:cerrarReciboAgua(";
				opciones += rowObject.codigoRecibo + ") >";
				opciones += "<img src='/"+ruta+"/recursos/images/icons/unlock_24x24.png' border='0' title='Cerrar Recibo Agua General'/>";
				opciones += "</a>";
			} else {
				opciones += "<a href=javascript:abrirReciboAgua(";
				opciones += rowObject.codigoRecibo + ") >";
				opciones += "<img src='/"+ruta+"/recursos/images/icons/lock_24x24.png' border='0' title='Abrir Recibo Agua General'/>";
				opciones += "</a>";
			}			
				
				opciones += "&nbsp;&nbsp;";
				
				/*opciones += "<a href=javascript:generarImpresionPDF(";
				opciones += rowObject.codigoRecibo + ") >";
				opciones += "<img src='/"+ruta+"/recursos/images/icons/print_24x24.png' border='0' title='Generar Impresión de todos los Recibo de Agua de los Socios'/>";
				opciones += "</a>";*/
				
				opciones += "<a href=/sigamm/generarImpresionAguaPDF?codigoRecibo="+rowObject.codigoRecibo+"&periodo="+rowObject.periodo.replace(' ','_')+" target='_blank'>";
				opciones += "<img src='/"+ruta+"/recursos/images/icons/print_24x24.png' border='0' title='Generar Impresión de todos los Recibo de Agua de los Socios'/>";
				opciones += "</a>";
				
				opciones += "</center>";
			
		return opciones;
				
	};
	
	jsonObj = [];
	var parametros = new Object();
	parametros.codigoServicio = 2;
	parametros.estado = 1;
	
	jQuery("#grilla").jqGrid(
	{
		url : 'reporte-recibo-agua.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		postData: parametros,
		//colNames : ['Codigo Recibo', 'Periodo', 'Lectura Inicial', 'Lectura Final','Monto','Opciones'],
		colNames : ['Periodo', 'Lectura Inicial', 'Lectura Final','Monto','Opciones'],
		colModel : [/*{
			name : 'codigoRecibo',
			index: 'codigoRecibo',
			sortable:false,
			width: 50,
			align: 'center'
		},*/{
			name : 'periodo',
			index: 'periodo',
			sortable:false,
			width: 100,
			align: 'center'
		},{
			name : 'lecturaInicial',
			index: 'lecturaInicial',
			sortable:false,
			width: 50,
			align: 'center'
		},{
			name : 'lecturaFinal',
			index: 'lecturaFinal',
			sortable:false,
			width: 50,
			align: 'center'
		},{
			name : 'monto',
			index: 'monto',
			sortable:false,
			width: 100,
			align: 'center'
		},{					
			name:'codigoRecibo',
			index:'codigoRecibo',
			width:120,
			sortable:false,
			search: false,
			formatter:formatterBotones
		}],								
		rowNum : 20,
		pager : '#pgrilla',
		sortname : 'codigoRecibo',
		autowidth: true,
		rownumbers: true,
		viewrecords : true,
		sortorder : "codigoRecibo",				
		caption : "Recibo de Agua"

	}).trigger('reloadGrid');
	
}

function colorEtiquetas(){
	
	$("#lblperiodo").css("color", "black");
	$("#lbllecturainicial").css("color", "black");
	$("#lbllecturafinal").css("color", "black");
	$("#lblmonto").css("color", "black");
	
	$("#lblperiodo-img").hide();
	$("#lbllecturainicial-img").hide();
	$("#lbllecturafinal-img").hide();
	$("#lblmonto-img").hide();
	
}

function guardar(){
	
	var ruta = obtenerContexto();
			
	jsonObj = [];
	var parametros = new Object();
	parametros.codigoRecibo = $("#codigorecibo").val();
	parametros.periodo = $("#periodo").val();
	parametros.lecturaInicial = $("#lecturainicial").val();
	parametros.lecturaFinal = $("#lecturafinal").val();
	parametros.monto = $("#monto").val();
	parametros.fechaCorte = $("#fechacorte").val();
	parametros.fechaVencimiento = $("#fechavencimiento").val();
	parametros.observaciones = $("#observaciones").val();
	
	$.ajax({
		type: "POST",
	    async:false,
	    url: "grabar-recibo-agua.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	            
	        if(result.camposObligatorios.length == 0){
                	
            	$('#recibo_modal').modal('hide');
            	
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
	            
	            cargarReciboAgua();
	            
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

function editarReciboAgua(codigoRecibo, periodo, lecturaInicial, lecturaFinal, monto, fechaCorte, fechaVencimiento, observaciones){
	console.log("Editar Recibo Agua - [codigoRecibo] : " + codigoRecibo );
	
	$('#recibo_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Modificar Recibo Agua");
	
	colorEtiquetas();
	
	$("#codigorecibo").val(codigoRecibo);
	$("#periodo").val(periodo.replace('_',' '));
	$("#lecturainicial").val(lecturaInicial);
	$("#lecturafinal").val(lecturaFinal);
	$("#monto").val(monto);
	$("#fechacorte").val(fechaCorte.replace(/\_/g," "));
	$("#fechavencimiento").val(fechaVencimiento.replace(/\_/g," "));
	if (observaciones == "null") observaciones = "";
	$("#observaciones").val(observaciones);
	
}

function eliminarReciboAgua(codigoRecibo, periodo){
	//alert("Recibo a Eliminar " + periodo);
	
	var ruta = obtenerContexto();
	mensaje = "Desea eliminar el recibo de agua cuyo periodo es " + periodo.replace('_',' ') + "... ?"; 
	
	$("#mensajeEliminar").html(mensaje);
	
	$('#alerta_modal').modal({
		backdrop: 'static',
		keyboard: false
	}).one('click', '#aceptar', function() {
        
		jsonObj = [];
		var parametros = new Object();
		parametros.codigoRecibo = codigoRecibo;
		
		$.ajax({
			type: "POST",
		    async:false,
		    url: "eliminar-recibo-agua.json",
		    cache : false,
		    data: parametros,
		    success: function(result){
		            
		        $('#alerta_modal').modal('hide');
	            	
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
	            
	            cargarReciboAgua();
		            
			}
		});
		
    });
	
}

function generarReciboAguaSocio(codigoRecibo){
	console.log("Generar Recibo Agua Socios - [codigoReciboAgua] : " + codigoRecibo);
	
	$("#nroRecibo").text(codigoRecibo);	
	
	$('#recibos_agua_socios_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Generar Recibo Agua para Socios");
	
	colorEtiquetas();
	
	$("#codigoReciboAgua").val(codigoRecibo);
	
	cargarReciboAguaSocio(codigoRecibo);
}


function cargarReciboAguaSocio(codigo){
	
	jsonObj = [];
	var parametros = new Object();
	parametros.codigoRecibo = codigo;
	
	if(intentos > 0){
		$("#grillaReciboAgua").jqGrid('setGridParam',
		{
			url : 'reporte-recibo-agua-socio.json',
			datatype : "json",
			postData:parametros,
			page:1
		}).trigger('reloadGrid');
	}else{
		cargarReciboAguaSocio1(codigo);
	}
		
}


function cargarReciboAguaSocio1(codigoRecibo){
	intentos = 1;
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		var opciones = "<center>";		

		if (rowObject.pagado != 1) {			
			opciones += "<a href=javascript:editarReciboAguaXSocio('";
			opciones += opciones += rowObject.codigoReciboAgua + "','" + rowObject.nroPuesto + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Recibo Agua Socio'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:generarReciboAguaXSocio('";
			opciones += rowObject.codigoSector + "','" + rowObject.nroPuesto + "','" + rowObject.codigoReciboAgua + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/agregar2_24x24.png' border='0' title='Crear Recibo de Agua por Socio'/>";
			opciones += "</a>";			
 
			if (rowObject.reciboAguaCreado != 0) {
				opciones += "&nbsp;&nbsp;";
				
				opciones += "<a href=javascript:pagarReciboAguaXSocio('";
				opciones += rowObject.codigoReciboAgua + "','" + rowObject.nroPuesto + "'," + rowObject.codigoSocio + ") >";
				opciones += "<img src='/"+ruta+"/recursos/images/icons/money_activo_24x24.png' border='0' title='PAGAR Recibo de Agua por Socio'/>";
				opciones += "</a>";
				
				opciones += "&nbsp;&nbsp;";
				
				opciones += "<a href=javascript:eliminarReciboAguaXSocio('";
				opciones += rowObject.codigoReciboAgua + "','" + rowObject.nroPuesto + "'," + rowObject.codigoSocio + ") >";
				opciones += "<img src='/"+ruta+"/recursos/images/icons/eliminar_24x24.png' border='0' title='ELIMINAR Recibo de Agua por Socio'/>";
				opciones += "</a>";
			}
		} else {
			opciones += "<img src='/"+ruta+"/recursos/images/icons/money_inactivo_24x24.png' border='0' title='Recibo de Agua del Socio, PAGADO'/>";
		}
			
			opciones += "</center>";
			
		return opciones;
				
	};

	jsonObj = [];
	var valores = new Object();
	valores.codigoRecibo = codigoRecibo;
	
	jQuery("#grillaReciboAgua").jqGrid(
	{
		url : 'reporte-recibo-agua-socio.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		postData: valores,
		colNames : ['Nombre Usuario', 'Puesto', 'Giro','Total', 'Opciones'],
		colModel : [{
			name : 'nombreFull',
			index: 'nombreFull',
			sortable:false,
			width: 320,
			align: 'left'
		},{
			name : 'nroPuesto',
			index: 'nroPuesto',
			sortable:false,
			width: 50,
			align: 'center'
		},{
			name : 'nombreGiro',
			index: 'nombreGiro',
			sortable:false,
			width: 150,
			align: 'center'
		},{
			name : 'total',
			index: 'total',
			sortable:false,
			width: 80,
			align: 'center'
		},{					
			name:'opciones',
			index:'opciones',
			width:150,
			sortable:false,
			search: false,
			formatter:formatterBotones
		}],								
		rowNum : 20,
		pager : '#pgrillaReciboAgua',
		sortname : 'codigoRecibo',
		autowidth: true,
		rownumbers: true,
		viewrecords : true,
		sortorder : "codigoRecibo",				
		caption : "Recibo de Agua Socios",
		afterInsertRow: function(rowId, data, item){
			//alert(rowId + ' - ' + data + ' - ' + item.pagado);
			if ( (item.reciboAguaCreado == 0) && (item.corteAgua == 0 || item.corteAgua == null) ) {
				$("#grillaReciboAgua").setCell(rowId, 'nombreFull', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });				
				$("#grillaReciboAgua").setCell(rowId, 'nroPuesto', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grillaReciboAgua").setCell(rowId, 'nombreGiro', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grillaReciboAgua").setCell(rowId, 'total', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
			} else if ( (item.reciboAguaCreado == 1) && (item.corteAgua == 1) ) {
				$("#grillaReciboAgua").setCell(rowId, 'nombreFull', '', { 'background-color':'##FF8000','color':'white','font-weight':'bold' });				
				$("#grillaReciboAgua").setCell(rowId, 'nroPuesto', '', { 'background-color':'#FF8000','color':'white','font-weight':'bold' });
				$("#grillaReciboAgua").setCell(rowId, 'nombreGiro', '', { 'background-color':'#FF8000','color':'white','font-weight':'bold' });
				$("#grillaReciboAgua").setCell(rowId, 'total', '', { 'background-color':'#FF8000','color':'white','font-weight':'bold' });				
			} else if ( (item.reciboAguaCreado == 1) && (item.suspendido == 1) ) {
				$("#grillaReciboAgua").setCell(rowId, 'nombreFull', '', { 'background-color':'#FFBF00','color':'black','font-weight':'bold' });				
				$("#grillaReciboAgua").setCell(rowId, 'nroPuesto', '', { 'background-color':'#FFBF00','color':'black','font-weight':'bold' });
				$("#grillaReciboAgua").setCell(rowId, 'nombreGiro', '', { 'background-color':'#FFBF00','color':'black','font-weight':'bold' });
				$("#grillaReciboAgua").setCell(rowId, 'total', '', { 'background-color':'#FFBF00','color':'black','font-weight':'bold' });		
			} else {
				$("#grillaReciboAgua").setCell(rowId, 'nombreFull', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
				$("#grillaReciboAgua").setCell(rowId, 'nroPuesto', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
				$("#grillaReciboAgua").setCell(rowId, 'nombreGiro', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
				$("#grillaReciboAgua").setCell(rowId, 'total', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
			}

		}


	}).trigger('reloadGrid');
}


function editarReciboAguaXSocio(original, puesto){
	
	var ruta = obtenerContexto();
	mensaje = "Desea editar el recibo de agua del Puesto " + puesto + " ?"; 
	
	$("#mensajeEditar").html(mensaje);
	
	$('#alerta_modal').modal({
		backdrop: 'static',
		keyboard: false
	}).one('click', '#aceptar', function() {
        
		jsonObj = [];
		var parametros = new Object();
		parametros.puestoSocio = puesto;
		parametros.codigoRecibo = original;
		$.ajax({
			type: "POST",
		    async:false,
		    url: "editar-agua-x-socio.json",
		    cache : false,
		    data: parametros,
		    success: function(result){
		    	
		    	//alert(result.records);

			    $('#alerta_modal').modal('hide');
	
		        if (result.records > 0) {
			        $('#recibos_agua_por_socio_modal').modal({
		        		backdrop: 'static',
		        		keyboard: false
		        	});	        	

		        	$.each(result.rows, function(key,val) {		        		
		        		$("#nombreSocio").text(val.nombreFull);
		        		$("#puestoSocio").text(val.nroPuesto);
		            	$("#sectorSocio").text(val.nombreSector);
		            	$("#giroSocio").text(val.nombreGiro);
		            	$("#periodoSocio").text(val.periodoSocio);
		            	$("#idRecibo").val(val.idRecibo);
		            	$("#codigoSocio").val(val.codigoSocio);
		            	$("#reciboAguaCreado").val(val.reciboAguaCreado);            	          	
		            	$("#codigoServicioDetalle").val(val.codigoServicioDetalle);
		            	$("#alcantarilladoSocio").val(val.alcantarillado);
		            	$("#totalSocio").text(val.total);
		            	$("#correlativo").val(val.correlativo);
		            	$("#mantenimientoSocio").val(val.servicioMantenimiento);
		            	$("#deudaAnteriorSocio").val(val.deudaAnterior);
		            	
		            	$("#nropuesto").text(val.nroPuesto);
		            	$("#codigorecibo").text(val.codigoRecibo);
		            	
		            	/*alert(val.codigoServicioDetalle);
		            	alert(val.total);*/
		            	if (val.suspendido==1){
		            		$("#seleccionador").attr("class","check c_on");
			    	    	$('#consumoMesSocio').attr('disabled','-1');
			    	    	$('#consumoMesSocioTrabado').attr('disabled','-1');
			    	    	$('#alcantarilladoSocio').attr('disabled','-1');
			    	    	$('#mantenimientoSocio').attr('disabled','-1');
			    	    	$('#deudaAnteriorSocio').attr('disabled','-1');
			    	    	$('#totalSocio').val('0.0');
			    	    	$('#totalSocio').attr('disabled','-1');
			    	    	$('#suspendido').val('1');
		            	}else{
		            		$("#seleccionador").attr("class","check");
			    	    	$('#consumoMesSocio').removeAttr('disabled');
			    	    	$('#consumoMesSocioTrabado').removeAttr('disabled');
			    	    	$('#alcantarilladoSocio').removeAttr('disabled');
			    	    	$('#mantenimientoSocio').removeAttr('disabled');
			    	    	$('#deudaAnteriorSocio').removeAttr('disabled');
			    	    	$('#totalSocio').removeAttr('disabled');
			    	    	$('#suspendido').val('0');
		            	}
		            	if (val.corteAgua==1){
		            		$("#cboxCorteAguaSocio").prop("checked", "checked");
		            	}else{
		            		$("#cboxCorteAguaSocio").prop("checked", "");
		            	}
		            	if (val.codigoServicioDetalle==2) {
		            		if( $('#sintraba').is(":visible") ){
		            			$('#sintraba').hide();
		            			$('#contraba').show();
		            			$('#alcantarillado').hide();
		            			$('#consumoMesSocioTrabado').val(val.consumoMes);
		            		} else {
		            			$('#sintraba').show();
		            			$('#contraba').hide();
		            			$('#alcantarillado').hide();
		            			$('#consumoMesSocio').val(val.consumoMes);
		            		}
		            	} else if (val.codigoServicioDetalle==3) {
		            		if( $('#sintraba').is(":visible") ){
		            			$('#sintraba').hide();
		            			$('#contraba').hide();
		            			$('#alcantarillado').show();
		            			$("#alcantarilladoSocio").val(val.alcantarillado);
		            		} else {
		            			$('#sintraba').hide();
		            			$('#contraba').hide();
		            			$('#alcantarillado').show();
		            			$("#alcantarilladoSocio").val(val.alcantarillado);
		            		}
		            	} else if (val.codigoServicioDetalle==5) {
		            		if( $('#sintraba').is(":visible") ){
		            			$('#sintraba').hide();
		            			$('#contraba').show();
		            			$('#alcantarillado').show();		            			
		            			$('#consumoMesSocioTrabado').val(val.consumoMes);
		            			$("#alcantarilladoSocio").val(val.alcantarillado);
		            		} else {
		            			$('#sintraba').show();
		            			$('#contraba').hide();
		            			$('#alcantarillado').show();
		            			$('#consumoMesSocio').val(val.consumoMes);
		            			$("#alcantarilladoSocio").val(val.alcantarillado);
		            		}
		            	}
		            	
		        	});
	        	
	        	} else {
	        		
	        		$.gritter.add({
						// (string | mandatory) the heading of the notification
						title: 'Mensaje',
						// (string | mandatory) the text inside the notification
						text: 'El Recibo de Agua del puesto ' + puesto + ' aún no se ha creado, verifique...',
						// (string | optional) the image to display on the left
						image: "/" + ruta + "/recursos/images/confirm.png",
						// (bool | optional) if you want it to fade out on its own or just sit there
						sticky: false,
						// (int | optional) the time you want it to be alive for before fading out
						time: ''
					});
	        	};
	            //cargarPuestos();
	            
		            
			}
		});
		
    });

}


function pagarReciboAguaXSocio(original, puesto, codigoSocio){
	
	var ruta = obtenerContexto();
	mensaje = "Desea dar por PAGADO el recibo de agua del Puesto " + puesto + " ?"; 
	
	$("#mensajePagar").html(mensaje);
	
	$('#alerta_modal_pagar').modal({
		backdrop: 'static',
		keyboard: false
	}).one('click', '#aceptar', function() {
        
		jsonObj = [];
		var parametros = new Object();
		parametros.nroPuesto = puesto;
		parametros.codigoReciboAgua = original;
		parametros.codigoSocio = codigoSocio;
		parametros.pagado = 1;
		$.ajax({
			type: "POST",
		    async:false,
		    url: "pagar-agua-x-socio.json",
		    cache : false,
		    data: parametros,
		    success: function(result){
		    	
		    	//alert(result.records);

			    $('#alerta_modal_pagar').modal('hide');
	
		        if (result.records > 0) {
			        $('#recibos_agua_por_socio_modal').modal({
		        		backdrop: 'static',
		        		keyboard: false
		        	});	        	
		         
	        	
	        	} else {
	        		
	        		$.gritter.add({
						// (string | mandatory) the heading of the notification
						title: 'Mensaje',
						// (string | mandatory) the text inside the notification
						text: 'El Recibo de Agua del puesto ' + puesto + ' se ha PAGADO satisfactoriamente, verifique...',
						// (string | optional) the image to display on the left
						image: "/" + ruta + "/recursos/images/confirm.png",
						// (bool | optional) if you want it to fade out on its own or just sit there
						sticky: false,
						// (int | optional) the time you want it to be alive for before fading out
						time: ''
					});
	        	};
	        	cargarReciboAguaSocio(original);
	            
			}
		});
		
    });

}


function eliminarReciboAguaXSocio(original, puesto, codigoSocio){
	
	var ruta = obtenerContexto();
	mensaje = "Esta seguro de ELIMINAR el recibo de agua del Puesto " + puesto + " ?"; 
	
	$("#mensajeEliminar").html(mensaje);
	
	$('#alerta_modal_eliminar').modal({
		backdrop: 'static',
		keyboard: false
	}).one('click', '#aceptar', function() {
        
		jsonObj = [];
		var parametros = new Object();
		parametros.nroPuesto = puesto;
		parametros.codigoReciboAgua = original;
		parametros.codigoSocio = codigoSocio;
		parametros.pagado = 1;
		$.ajax({
			type: "POST",
		    async:false,
		    url: "eliminar-agua-x-socio.json",
		    cache : false,
		    data: parametros,
		    success: function(result){
		    	
		    	//alert(result.records);

			    $('#alerta_modal_eliminar').modal('hide');
	
		        if (result.records > 0) {
			        $('#recibos_agua_por_socio_modal').modal({
		        		backdrop: 'static',
		        		keyboard: false
		        	});	        	
		         
	        	
	        	} else {
	        		
	        		$.gritter.add({
						// (string | mandatory) the heading of the notification
						title: 'Mensaje',
						// (string | mandatory) the text inside the notification
						text: 'El Recibo de Agua del puesto ' + puesto + ' se ha ELIMINADO satisfactoriamente, verifique...',
						// (string | optional) the image to display on the left
						image: "/" + ruta + "/recursos/images/confirm.png",
						// (bool | optional) if you want it to fade out on its own or just sit there
						sticky: false,
						// (int | optional) the time you want it to be alive for before fading out
						time: ''
					});
	        	};
	        	cargarReciboAguaSocio(original);
	            
			}
		});
		
    });

}


function generarReciboAguaXSocio(sector, puesto, codigoRecibo){

	//alert("Sector: " + sector + "\nPuesto: " + puesto + "\nCodigoRecibo: " + codigoRecibo);
	limpiarReciboAguaSocio();
	$("#sectorSocio").text(sector);
	$("#puestoSocio").text(puesto);									
	$("#reciboOriginal").text(codigoRecibo);
	$("#correlativo").val('0');
	$("#consumoMesSocio").val('0');
	$("#consumoMesSocioTrabado").val('0');
	$("#alcantarilladoSocio").val('0');
	$("#mantenimientoSocio").val('0');
	$("#deudaAnteriorSocio").val('0');
	$("#totalSocio").text('0');
	$('#suspendido').val('0');
	
	colorEtiquetas();
	cargarDatosReciboAguaSocio(sector, puesto, codigoRecibo);
}


function cargarDatosReciboAguaSocio(sector, puesto, codigoRecibo){
	
	//alert("Sector: " + sector + "\nPuesto: " + puesto + "\nCodigoRecibo: " + codigoRecibo);
	var ruta = obtenerContexto();	
	var parametros = new Object();
	parametros.codigoSector         = sector;
	parametros.nroPuesto            = puesto;
	parametros.codigoReciboOriginal = codigoRecibo;
	parametros.consumomes           = parseFloat('0');
	
	$.ajax({
        type: "POST",
        async:false,
        url: "buscar-usuario-puesto-giro-agua.json",
        cache : false,
        data: parametros,
        success: function(result){
            console.log(result);
        	//alert("Resultado : [" + result.rows + "]");
        	limpiarReciboAguaSocio();
        	$.each(result.rows, function(key,val) {
            	$("#nombreSocio").text(val.nombreFull);
            	$("#puestoSocio").text(val.nroPuesto);
            	$("#sectorSocio").text(val.nombreSector);
            	$("#giroSocio").text(val.nombreGiro);
            	$("#periodoSocio").text(val.periodoSocio);
            	$("#codigoSocio").val(val.codigoSocio);
            	$("#reciboAguaCreado").val(val.reciboAguaCreado);            	          	
            	$("#codigoServicioDetalle").val(val.codigoServicioDetalle);
            	$("#mantenimientoSocio").val(val.servicioMantenimiento);
            	$('#consumoMesSocio').val(val.consumoMes);
            	$('#consumoMesSocioTrabado').val(val.consumoMes);
            	$('#correlativo').val(val.correlativo);
            	$('#deudaAnteriorSocio').val(val.deudaAnterior);
            	
            	if (val.codigoServicioDetalle==2) {
            		if( $('#sintraba').is(":visible") ){
            			$('#sintraba').hide();
            			$('#contraba').show();
            			$('#alcantarillado').hide();
            			
            		} else {
            			$('#sintraba').show();
            			$('#contraba').hide();
            			$('#alcantarillado').hide();
            		}
            	} else if (val.codigoServicioDetalle==3) {
            		if( $('#sintraba').is(":visible") ){
            			$('#sintraba').hide();
            			$('#contraba').hide();
            			$('#alcantarillado').show();
            		} else {
            			$('#sintraba').hide();
            			$('#contraba').hide();
            			$('#alcantarillado').show();
            		}
            	} else if (val.codigoServicioDetalle==5) {
            		if( $('#sintraba').is(":visible") ){
            			$('#sintraba').hide();
            			$('#contraba').show();
            			$('#alcantarillado').show();
            		} else {
            			$('#sintraba').show();
            			$('#contraba').hide();
            			$('#alcantarillado').show();
            		}
            	}
            	
				if ($("#reciboAguaCreado").val() == 0) {
					
					$('#recibos_agua_por_socio_modal').modal({
						backdrop: 'static',
						keyboard: false
					});
					
				} else {
					
					$.gritter.add({
						// (string | mandatory) the heading of the notification
						title: 'Mensaje',
						// (string | mandatory) the text inside the notification
						text: 'El Recibo de Agua del puesto ' + $("#puestoSocio").text() + ' ya fue creado...!!!',
						// (string | optional) the image to display on the left
						image: "/" + ruta + "/recursos/images/confirm.png",
						// (bool | optional) if you want it to fade out on its own or just sit there
						sticky: false,
						// (int | optional) the time you want it to be alive for before fading out
						time: ''
					});
					
				}
            	
        	});
        	
        }
    });
	
	$("#lecturaInicialSocio").focus();
}

function activaManual(){
	if( $('#sintraba').is(":visible") ){
		$('#sintraba').hide();
		$('#contraba').show();
	} else {
		$('#sintraba').show();
		$('#contraba').hide();
	}
}

function operaciones(){
	var consumomessocio = 0;
	var consumomessociotrabado = 0;
	var alcantarillado = 0;
	var mantenimiento = 0;
	var deudaanteriorsocio = 0;
	var total = 0;
	consumomessocio = parseFloat($('#consumoMesSocio').val());
	consumomessociotrabado = parseFloat($('#consumoMesSocioTrabado').val());
	alcantarilladosocio = parseFloat($('#alcantarilladoSocio').val());
	deudaanteriorsocio = parseFloat($('#deudaAnteriorSocio').val());
	mantenimientosocio = parseFloat($('#mantenimientoSocio').val());	
	if( $('#sintraba').is(":visible") ){
		if ( isNaN(consumomessocio) ) consumomessocio = 0;
		if ( isNaN(alcantarilladosocio) ) alcantarilladosocio = 0;
		//alert("ConsumoMesSocio: " + consumomessocio + "\nAlcantarilladoSocio: " + alcantarilladosocio + "\nDeudaAnterior: "+deudaanteriorsocio+"\nMantenimiento: "+mantenimientosocio);
		total = consumomessocio + alcantarilladosocio + mantenimientosocio + deudaanteriorsocio;

	} else {
		if ( isNaN(consumomessociotrabado) ) consumomessociotrabado = 0;
		if ( isNaN(alcantarillado) ) alcantarillado = 0;
		//alert("ConsumoMesSocio: " + consumomessociotrabado + "\nAlcantarilladoSocio: " + alcantarilladosocio + "\nDeudaAnterior: "+deudaanteriorsocio+"\nMantenimiento: "+mantenimientosocio);		
		total = consumomessociotrabado + alcantarilladosocio + mantenimientosocio + deudaanteriorsocio;
		
	}
	//alert("TOTAL [" + total + "]");
	$('#totalSocio').text(redondear_dos_decimal(total));	
}

function redondear_dos_decimal(valor) {
	var redondea_valor = 0.00;
	redondea_valor = Math.round(valor * 100) / 100;
   return redondea_valor; 
}


function guardarRecibo(){
	
	var ruta = obtenerContexto();
	//alert("CORRELATIVO: " + $("#codigoReciboLuzSocio").val() );
	var parametros = new Object();
	parametros.idRecibo = $("#idRecibo").val();
	parametros.codigoSocio = $("#codigoSocio").val();
	parametros.codigoReciboAgua = $("#nroRecibo").text();
	parametros.lecturaInicial = 0;
	parametros.lecturaFinal = 0;
	if (document.getElementById('cboxCorteAguaSocio').checked == true){
		parametros.corteAgua = 1;
	} else {
		parametros.corteAgua = 0;
	}	
	parametros.codigoServicioDetalle = $("#codigoServicioDetalle").val();
	parametros.deudaAnterior = $("#deudaAnteriorSocio").val();
	
	//alert("ServicioDetalle: " + $("#codigoServicioDetalle").val());
	
	if( $('#sintraba').is(":visible") ){
		//alert("1");
		parametros.consumoMes = parseFloat($("#consumoMesSocio").val());
		parametros.trabado = 0;
	} else {
		//alert("2");
		parametros.consumoMes = parseFloat($("#consumoMesSocioTrabado").val());
		parametros.trabado = 1;
	}
	parametros.alcantarillado = parseFloat($("#alcantarilladoSocio").val());
	parametros.servicioMantenimiento = parseFloat($("#mantenimientoSocio").val());
	parametros.reconexion = 0;
	parametros.total = $("#totalSocio").text();
	parametros.correlativo = $("#correlativo").val();
	parametros.suspendido =  $("#suspendido").val();
		
	$.ajax({
		type: "POST",
	    async:false,
	    url: "grabar-agua-x-socio.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	            
	        if(result.camposObligatorios.length == 0){
                	
            	$('#recibos_agua_por_socio_modal').modal('hide');
            	
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
	            
	            cargarReciboAguaSocio1();
	            limpiarReciboAguaSocio();
	            
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


function limpiarReciboAguaSocio(){
	$("#nombreSocio").text('');
	$("#puestoSocio").text('');
	$("#sectorSocio").text('');
	$("#giroSocio").text('');
	$("#periodoSocio").text('');
	$("#idRecibo").val('');
	$("#consumoMesSocio").val('0');
	$("#consumoMesSocioTrabado").val('0');
	$("#alcantarilladoSocio").val('0');
	$("#mantenimientoSocio").val('0');
	$("#deudaAnteriorSocio").val('0');
	$("#totalSocio").text('0');
}


function buscarReciboAguaPuesto(){
	var codigoReciboAgua = $("#codigoReciboAgua").val();
	var puestoSocio = $("#reciboAguaSocioBuscara").val();
	//alert ("RECIBO: " + codigoReciboAgua + " PUESTO: " + puestoSocio);
	jsonObj = [];
	var parametros = new Object();
	parametros.codigoReciboAgua = codigoReciboAgua;
	parametros.nroPuesto = puestoSocio;
	//alert("INTENTOS: " + intentos);
	if(intentos > 0){
		$("#grillaReciboAgua").jqGrid('setGridParam',
		{
			url : 'reporte-recibo-agua-puesto.json',
			datatype : "json",
			postData:parametros,
			page:1
		}).trigger('reloadGrid');
	}else{
		//buscarReciboAguaSocio(codigoRecibo, codigoPuesto);
	}
		
}


function generarImpresionPDF(codigoRecibo){
	
	var ruta = obtenerContexto();
			
	jsonObj = [];
	var parametros = new Object();
	parametros.codigoRecibo = codigoRecibo;

	$.ajax({
		type: "POST",
	    async:false,
	    url: "generarPDF",
	    cache : false,
	    data: parametros,
	    success: function(result){
	            
	        if(result.camposObligatorios.length == 0){
                	
            	$('#recibo_modal').modal('hide');
            	
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
	            
	            cargarReciboAgua();
	            
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

function exportarAguaSocio(){
	var codigo = $("#nroRecibo").text();
	window.open('/sigamm/reporteAguaSocioExcel?codigoAguaOriginal='+codigo, 'Descarga', '1', '1');
	
}

</script>
</head>
<body id="body">
<input type="hidden" id="codigorecibo" />
<input type="hidden" id="nropuesto" />
<input type="hidden" id="codigoReciboAgua" />
<input type="hidden" id="codigoSocio" />
<input type="hidden" id="codigoServicioDetalle" />
<input type="hidden" id="correlativo" />
<input type="hidden" id="reciboAguaCreado" />
<input type="hidden" id="suspendido" />
<table border="0" width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td width="150"><b>RECIBO AGUA<b/></td>
		<td width="10">:</td>
		<td width="200"><input type="text" id="reciboBuscara" class="form-control" maxlength="8" /></td>
		<td>&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" onclick="cargarReciboAgua()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
			</button>&nbsp;&nbsp;
			<!-- button type="button" class="btn btn-primary" onclick="nuevoRecibo()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Nuevo" />&nbsp;Nuevo
			</button -->
			<button class="btn btn-primary" data-toggle="modal" data-target="#recibo_modal" onclick="cargarNuevo()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Nuevo" />&nbsp;Nuevo
			</button>
			<!-- button class="btn btn-primary" data-toggle="modal" data-target="#recibo_modal">
				<a href=/sigamm/generarFacturacionPrueba>
					<img src="recursos/images/icons/buscar_16x16.png" alt="Nuevo" />&nbsp;FACTURACION PRUEBA
				</a>
			</button -->
			
		</td>
	</tr>
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4">
			<table id="grilla"></table>
			<div id="pgrilla"></div>
		</td>
	</tr>
</table>	



<div class="modal fade" id="recibo_modal" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"><span id="tituloRegistro" />Nuevo Recibo</h4>
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
							<td><span id="lblperiodo"><b>PERIODO (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="periodo" class="form-control" maxlength="20"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lbllecturainicial"><b>LECTURA INICIAL (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="lecturainicial" class="form-control" maxlength="8"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lbllecturafinal"><b>LECTURA FINAL (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="lecturafinal" class="form-control" maxlength="8"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblmonto"><b>MONTO (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="monto" class="form-control" maxlength="20"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblfechacorte"><b>FECHA CORTE (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="fechacorte" class="form-control" maxlength="20"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblfechavencimiento"><b>FECHA VENCIMIENTO (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="fechavencimiento" class="form-control" maxlength="20"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblobservaciones"><b>OBSERVACIONES</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="observaciones" class="form-control" maxlength="2000"/></td>
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


<!-- Ventana Modal para Recibo Agua Socios -->
<div class="modal fade" id="recibos_agua_socios_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 800px">
		<div class="modal-content">
		
		<div class="modal-header modal-header-primary">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title">Listado de Recibos de Agua de Socios</h4>
		</div>

		<div class="modal-body">
		
			<table border="0" width="400px" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="5" style="color:red"><b>&nbsp;RECIBO DE AGUA ORIGINAL NRO. <span id="nroRecibo"></span></b></td>
				</tr>
				<tr>
					<td><b>RECIBO AGUA SOCIOS<b/></td>
					<td>:</td>
					<td><input type="text" id="reciboAguaSocioBuscara" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
					<td colspan="2">
						<button type="button" class="btn btn-primary" onclick="buscarReciboAguaPuesto()">
							<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
						</button>&nbsp;&nbsp;
						<button type="button" class="btn btn-primary">
							<img src="recursos/images/icons/excel_16x16.png" alt="Exportar a Excel" />&nbsp;<a href="#" style="color:white" onclick="exportarAguaSocio()">Exportar</a>
						</button>					
					</td>
				</tr>
				<tr>
					<td colspan="4">&nbsp;</td>
					<td><b>LEYENDA:</b></td>
				</tr>
				<tr>
					<td colspan="3">&nbsp;</td>
					<td bgcolor="#FFBF00">SUSPENDIDO</td>
					<td bgcolor="#A9F5A9">CREADO</td>
				</tr>
				<tr>
					<td colspan="3">&nbsp;</td>
					<td bgcolor="#FF8000">CORTADO</td>
					<td bgcolor="#F5A9A9">NO CREADO</td>
				</tr>
				<tr>
					<td colspan="5">
						<table id="grillaReciboAgua"></table>
						<div id="pgrillaReciboAgua"></div>
					</td>
				</tr>
			</table>	
		
		</div>
		
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="">Grabar</button>
			<button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
		</div>
		
		</div>
	</div>
</div>

<!-- Ventana Modal Recibo Luz Ppor cada Socio -->
<div class="modal fade" id="recibos_agua_por_socio_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 450px">
		<div class="modal-content">
		
		<div class="modal-header modal-header-primary">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title">Recibos de Agua de Socio</h4>
		</div>

		<div class="modal-body">
		
			<table border="0" width="100%" cellpadding="0" cellspacing="0"></tr>
				<tr>
					<td colspan="4"><b>RECIBO DE AGUA <span id="reciboOriginal"></span><b/></td>
				</tr>
				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
			</table>
			<table border="1" width="100%">
				<tr>
					<td align="center">
						<label id="seleccionador" class="check">
							<input type="checkbox" id="suspendidoSocio" name="suspendidoSocio" >Servicio Suspendido</input>
						</label>
					</td>
				</tr>
				<tr>
					<td>
						<table border="0" width="100%">
							<tr>
								<td width="40%"><b>ASOCIADO (A) :</b></td>
								<td><div id="nombreSocio" style="color: blue; font-size:11px;" align="left"></div></td>
							</tr>
							<tr>
								<td><b>Nº PUESTO :</b></td>
								<td>
									<div id="puestoSocio" style="color: blue; width: 90px;" align="left"></div>								
								</td>
							</tr>
							<tr>
								<td><b>SECTOR :</b></td>
								<td><div id="sectorSocio" style="color: blue; width: 100px; font-size:11px;" align="left"></div></td>
							</tr>
							<tr>
								<td><b>GIRO :</b></td>
								<td><div id="giroSocio" style="color: blue; font-size:11px;" align="left"></div></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table border="0" width="100%">
							<tr>
								<td width="40%"><b>Periodo :</b></td>
								<td><div id="periodoSocio" style="color: blue; font-size:11px; width: 150px;" align="left"></div></td>
							</tr>
							<tr>
								<td><b>ID :</b></td>
								<td><input type='text' id='idRecibo' name='idRecibo' size='10' class='text ui-widget-content ui-corner-all' style="text-align: center;"/></td>
							</tr>
							<!-- tr>
								<td><b>Lectura Anterior :</b></td>
								<td><input type='text' id='lecturaInicialSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('L');" style="text-align: center;" onKeyDown="campoEnter(event,this.form.lecturaFinalSocio);"/></td>
							</tr>
							<tr>
								<td><b>Lectura Actual :</b></td>
								<td><input type='text' id='lecturaFinalSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('L');" style="text-align: center;"/></td>
							</tr-->
							<tr>
								<td colspan="2" align="center"><label><input type="checkbox" id="cbox1" value="first_checkbox" onclick="activaManual()"> Medidor Trabado</label></td>
							</tr>
							<tr id="sintraba" style="display:none">
								<td><b>Consumo de Agua :</b></td>
								<!-- td><div id="consumoMesSocio" style="border: 2px solid blue; width: 100px;" align="center"></div></td -->
								<td><input type='text' id='consumoMesSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones();" style="text-align: center;border: 2px solid blue; width: 100px;"/></td>
							</tr>
							<tr id="contraba" style="display:none">
								<td><b>Consumo de Agua :</b></td>
								<td><input type='text' id='consumoMesSocioTrabado' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones();" style="text-align: center;border: 2px solid blue; width: 100px;"/></td>
							</tr>
							<tr id="alcantarillado" style="display:none">
								<td><b>Alcantarillado :</b></td>
								<td><input type='text' id='alcantarilladoSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones();" style="text-align: center;"/></td>
							</tr>
							<tr>
								<td><b>Mantenimiento :</b></td>
								<td><input type='text' id='mantenimientoSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones();" style="text-align: center;"/></td>
							</tr>
							<tr>
								<td><b>Deuda Anterior :</b></td>
								<td><input type='text' id='deudaAnteriorSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones();" style="text-align: center;"/></td>
							</tr>
							<tr>
								<td><b>TOTAL DE AGUA</b></td>
								<td><div id="totalSocio" style="border: 2px solid blue; width: 100px;" align="center"></div></td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									<font color="red" style="text-decoration: blink;"><label><input type="checkbox" id="cboxCorteAguaSocio" value="first_checkbox" id="slideOne"> CORTE DEL AGUA </label></font>
								</td>
							</tr>							
						</table>		
					</td>
				</tr>
			</table>
		  
		  
		</div>
		
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="guardarRecibo()">Grabar</button>		
			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="">Cerrar</button>
			<!-- button type="button" class="btn btn-primary" data-dismiss="modal" onclick="limpiarReciboAguaSocio()">Cerrar</button -->
		</div>
		
		</div>
	</div>
</div>

<div class="modal fade" id="alerta_modal" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Editar Recibo Agua</h4>
			</div>
			<div class="modal-body">
					
				<table border="0">
					<tr>
						<td><img src="recursos/images/icons/exclamation_32x32.png" border="0" />&nbsp;<b><span id="mensajeEditar" /></b></td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" id="aceptar">Si</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
			</div>
		</div>
		  
	</div>
</div>

<div class="modal fade" id="alerta_modal_pagar" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Pagar Recibo Agua</h4>
			</div>
			<div class="modal-body">
					
				<table border="0">
					<tr>
						<td><img src="recursos/images/icons/exclamation_32x32.png" border="0" />&nbsp;<b><span id="mensajePagar" /></b></td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" id="aceptar">Si</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
			</div>
		</div>
		  
	</div>
</div>

<div class="modal fade" id="alerta_modal_eliminar" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Eliminar Recibo Agua</h4>
			</div>
			<div class="modal-body">
					
				<table border="0">
					<tr>
						<td><img src="recursos/images/icons/exclamation_32x32.png" border="0" />&nbsp;<b><span id="mensajeEliminar" /></b></td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" id="aceptar">Si</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
			</div>
		</div>
		  
	</div>
</div>
</body>
</html>
