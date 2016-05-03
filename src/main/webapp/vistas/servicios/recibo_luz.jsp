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
	
	cargarReciboLuzOriginal();
	
	$("#contraba").hide();
	$("#correlativo").val('0');
	/*$("#consumoMesSocio").val('0');
	$("#consumoMesSocioTrabado").val('0');
	$("#totalSocio").text('0');*/
	$('#suspendido').val('0');
	
	limpiar();
	limpiarReciboLuzSocio();
	
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
        monthNames: ['ENERO', 'FEBRERO', 'MARZO', 'ABRIL', 'MAYO', 'JUNIO', 'JULIO', 'AGOSTO', 'SEPTIEMBRE', 'OCTUBRE', 'NOVIEMBRE', 'DICIEMBRE'],
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
        //dateFormat: 'mm-yy',
        dateFormat: 'MM yy',
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
		regional: 'es',
        onClose: function(dateText, inst) {  
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val(); 
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val(); 
            $(this).val($.datepicker.formatDate('MM yy', new Date(year, month, 1)));
            //$(this).val($.datepicker.formatDate('yy-mm', new Date(year, month, 1)));
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
         
	$("#fecVencimiento").datepicker(
            {   
                changeMonth: true,
                changeYear: true,
                numberOfMonths: 1,
                dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
                monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo',
                    'Junio', 'Julio', 'Agosto', 'Septiembre',
                    'Octubre', 'Noviembre', 'Diciembre'],
                monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr',
                    'May', 'Jun', 'Jul', 'Ago',
                    'Sep', 'Oct', 'Nov', 'Dic'] 
            });  

	$("#fecEmision").datepicker(
            {   
                changeMonth: true,
                changeYear: true,
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
/*$(document).ready(function() {

    $('#dialog').modal('show')

});*/




function colorEtiquetas(){
	
	$("#lblpuesto").css("color", "black");
	$("#lblgiroComercial").css("color", "black");
	
	$("#lblpuesto-img").hide();
	$("#lblgiroComercial-img").hide();
	
}

function nuevoRecibos(){
	colorEtiquetas();
	
	$("#periodo").val('');
	$("#fecVencimiento").val('');
	$("#fecEmision").val('');
	$("#costoWats").val(0);
	$("#alumbradoPublico").val(0);
	$("#mantenimiento").val(0);
	$("#estado").val(1);
	$("#repoManCnx").val(0);
	$("#cargoFijo").val(0);
	$("#codigoRecibo").val(0);
	$("#cableadoPrincipal").val(0);
	$("#total").val(0);
}

function guardar(){
	jsonObj = [];
	var ruta = obtenerContexto();
	var parametros = new Object();
	parametros.codigoReciboLuzOriginal = $("#codigoRecibo").val();
	parametros.periodo = $("#periodo").val();
	parametros.fecVencimiento = $("#fecVencimiento").val();
	parametros.fecEmision = $("#fecEmision").val();
	parametros.costoWats = $("#costoWats").val();
	parametros.alumbradoPublico = $("#alumbradoPublico").val();
	parametros.mantenimiento = $("#mantenimiento").val();
	parametros.estado = $("#estado").val();
	parametros.repoManCnx = $("#repoManCnx").val();
	parametros.cargoFijo = $("#cargoFijo").val();
	parametros.totalMesAct = $("#totalmesactual").val();
	parametros.deudaAnterior = $("#deudaanterior").val();
	parametros.cableadoPrincipal = $("#cableadoPrincipal").val();

	$.ajax({
		type: "POST",
	    async:false,
	    url: "grabar-luz-original.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	            
	        if(result.camposObligatorios.length == 0){
                	
            	$('#luz_original_modal').modal('hide');
            	
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
	            
	            cargarReciboLuzOriginal();
	            
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


function cargarReciboLuzOriginal(){
	
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		var opciones = "<center>";
			
			opciones += "<a href=javascript:editarReciboLuzOriginal(";
			opciones += rowObject.codigoReciboLuzOriginal + ",'" + rowObject.periodo.replace(' ','_') + "','" + rowObject.fecVencimiento.replace(' ','_') + "','" + rowObject.fecEmision.replace(/\s/g,"_") + "','" + rowObject.costoWats + "','" + rowObject.alumbradoPublico + "','" + rowObject.mantenimiento + "','" + rowObject.totalMesAct +"','" + rowObject.deudaAnterior +"','" + rowObject.cableadoPrincipal +"') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Recibo Luz'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:eliminarReciboLuzOriginal(";
			opciones += rowObject.codigoReciboLuzOriginal + ",'" + rowObject.periodo.replace(' ','_') + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/eliminar_24x24.png' border='0' title='Eliminar Recibo Luz'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:generarReciboLuzSocio(";
			opciones += rowObject.codigoReciboLuzOriginal + ") >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/reciboLuz_24x24.png' border='0' title='Generar Recibo Luz Socio'/>";
			opciones += "</a>";			
			
			opciones += "&nbsp;&nbsp;";
			
		if (rowObject.estadoAbierto == 0) {			
			opciones += "<a href=javascript:cerrarReciboLuz(";
			opciones += rowObject.codigoReciboLuzOriginal + ") >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/unlock_24x24.png' border='0' title='Cerrar Recibo Luz General'/>";
			opciones += "</a>";
		} else {
			opciones += "<a href=javascript:abrirReciboLuz(";
			opciones += rowObject.codigoReciboLuzOriginal + ") >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/lock_24x24.png' border='0' title='Abrir Recibo Luz General'/>";
			opciones += "</a>";
		}			
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=/sigamm/generarImpresionLuzPDF?codigoRecibo="+rowObject.codigoReciboLuzOriginal+"&periodo="+rowObject.periodo.replace(' ','_')+" target='_blank'>";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/print_24x24.png' border='0' title='Generar Impresión de todos los Recibo de Luz de los Socios'/>";
			opciones += "</a>";
			
			opciones += "</center>";
			
		return opciones;
				
	};
	
	jQuery("#grilla").jqGrid(
	{
		url : 'reporte-recibo-luz-original.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		colNames : ['Periodo', 'FechaEmision', 'FechaVencimiento','Total Mes Actual','Total Mes Anterior','Total', 'Opciones'],
		colModel : [{
			name : 'periodo',
			index: 'periodo',
			sortable:false,
			width: 100,
			align: 'left'
		},{
			name : 'fecEmision',
			index: 'fecEmision',
			sortable:false,
			width: 100,
			align: 'center'
		},{
			name : 'fecVencimiento',
			index: 'fecVencimiento',
			sortable:false,
			width: 150,
			align: 'center'
		},{
			name : 'totalMesAct',
			index: 'totalMesAct',
			sortable:false,
			width: 150,
			align: 'center'
		},{
			name : 'deudaAnterior',
			index: 'deudaAnterior',
			sortable:false,
			width: 150,
			align: 'center'
		},{
			name : 'total',
			index: 'total',
			sortable:false,
			width: 150,
			align: 'center'
		},{					
			name:'codigoReciboLuzOriginal',
			index:'codigoReciboLuzOriginal',
			width:150,
			sortable:false,
			search: false,
			formatter:formatterBotones
		}],								
		rowNum : 20,
		pager : '#pgrilla',
		sortname : 'dni',
		autowidth: true,
		rownumbers: true,
		viewrecords : true,
		sortorder : "codigoReciboLuzOriginal",				
		caption : "Recibo de Luz Original",
		formatoptions: {decimalSeperator : '.'},
		afterInsertRow: function(rowId, data, item){
			//alert(rowId + ' - ' + data + ' - ' + item.periodo);
			var anio = item.periodo.substring(0,4);
			var mes1 = item.periodo.substring(4,6);
			var periodo = null;
			var months = ['ENERO', 'FEBRERO', 'MARZO', 'ABRIL', 'MAYO', 'JUNIO','JULIO', 'AGOSTO', 'SETIEMBRE', 'OCTUBRE', 'NOVIEMBRE', 'DICIEMBRE'];
			for(var j=0;j<months.length;j++){
				if (mes1==j+1)
					periodo=months[j] + ' ' + anio;
			}
			//$("#grilla").setCell(rowId, 'periodo', periodo, '' );
		}


	}).trigger('reloadGrid');
}


function eliminarReciboLuzOriginal(codigoReciboLuzOriginal, periodo){
	//alert("Recibo a Eliminar " + periodo);
	
	var ruta = obtenerContexto();
	mensaje = "Desea eliminar el recibo de luz cuyo periodo es " + periodo.replace('_',' ') + "... ?"; 
	
	$("#mensajeEliminar").html(mensaje);
	
	$('#alerta_modal_eliminar').modal({
		backdrop: 'static',
		keyboard: false
	}).one('click', '#aceptar', function() {
        
		jsonObj = [];
		var parametros = new Object();
		parametros.codigoReciboLuzOriginal = codigoReciboLuzOriginal;
		
		$.ajax({
			type: "POST",
		    async:false,
		    url: "eliminar-recibo-luz.json",
		    cache : false,
		    data: parametros,
		    success: function(result){
		            
		        $('#alerta_modal_eliminar').modal('hide');
	            	
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
	            
	            cargarReciboLuzOriginal();
		            
			}
		});
		
    });
	
}


function editarReciboLuzOriginal(codigoReciboLuzOriginal, periodo, fecVencimiento, fecEmision, costoWats, alumbradoPublico, mantenimiento, totalMesAct, deudaAnterior, cableadoPrincipal ){
	console.log("Editar Recibo Luz - [codigoRecibo] : " + codigoRecibo );
	
	$('#luz_original_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Modificar Recibo Luz");
	
	colorEtiquetas();
	
	$("#codigoRecibo").val(codigoReciboLuzOriginal);
	$("#periodo").val(periodo.replace('_',' '));
	$("#fecVencimiento").val(fecVencimiento.replace(/\_/g," "));
	$("#fecEmision").val(fecEmision.replace(/\_/g," "));
	$("#costoWats").val(costoWats);
	$("#alumbradoPublico").val(alumbradoPublico);
	$("#mantenimiento").val(mantenimiento);
	$("#totalmesactual").val(totalMesAct);
	$("#deudaanterior").val(deudaAnterior);
	$("#cableadoPrincipal").val(cableadoPrincipal);
	
}


function generarReciboLuzSocio(codigoRecibo){
	console.log("Generar Recibo Luz Socios - [codigoReciboLuzOriginal] : " + codigoRecibo);
	
	$("#nroRecibo").text(codigoRecibo);	
	
	$('#recibos_luz_socios_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Generar Recibo Luz Socios");
	
	colorEtiquetas();
	$('#grillaReciboLuz').jqGrid('clearGridData');	
	$("#codigoRecibo").val(codigoRecibo);
	
	//alert("UNO " + codigoReciboLuzOriginal);
	//buscarUsuario();
	cargarReciboLuz($("#nroRecibo").text());
	
}

function cargarReciboLuz(codigo){
	
	jsonObj = [];
	var parametros = new Object();
	parametros.codigoRecibo = codigo;
	
	if(intentos > 0){
		$("#grillaReciboLuz").jqGrid('setGridParam',
		{
			url : 'reporte-recibo-luz-puesto.json',
			datatype : "json",
			postData:parametros,
			page:1
		}).trigger('reloadGrid');
	}else{
		cargarReciboLuzSocio(codigo);
	}
		
}

function cargarReciboLuzSocio(codigoRecibo){
	intentos = 1;
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		var opciones = "<center>";
		
		if (rowObject.pagado != 1) {
			opciones += "<a href=javascript:editarReciboLuzXSocio('";
			opciones += rowObject.codigoReciboOriginal + "','" + rowObject.nroPuesto + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Recibo Luz Socio'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:generarReciboLuzXSocio('";
			opciones += rowObject.codigoSector + "','" + rowObject.nroPuesto + "','" + rowObject.codigoReciboOriginal + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/agregar2_24x24.png' border='0' title='Crear Recibo de Luz por Socio'/>";
			opciones += "</a>";						
			
			if (rowObject.reciboLuzCreado != 0) {
				opciones += "&nbsp;&nbsp;";
				
				opciones += "<a href=javascript:pagarReciboLuzXSocio('";
				opciones += rowObject.codigoReciboOriginal + "','" + rowObject.nroPuesto + "'," + rowObject.codigoSocio + ") >";
				opciones += "<img src='/"+ruta+"/recursos/images/icons/money_activo_24x24.png' border='0' title='PAGAR Recibo de Luz por Socio'/>";
				opciones += "</a>";
				
				opciones += "&nbsp;&nbsp;";
				
				opciones += "<a href=javascript:eliminarReciboLuzXSocio('";
				opciones += rowObject.codigoReciboOriginal + "','" + rowObject.nroPuesto + "'," + rowObject.codigoSocio + ") >";
				opciones += "<img src='/"+ruta+"/recursos/images/icons/eliminar_24x24.png' border='0' title='ELIMINAR Recibo de Luz por Socio'/>";
				opciones += "</a>";
			}
		} else {
			opciones += "<img src='/"+ruta+"/recursos/images/icons/money_inactivo_24x24.png' border='0' title='Recibo de Luz del Socio, PAGADO'/>";
		}	
		return opciones;
		
			opciones += "</center>";
	};

	jsonObj = [];
	var parametros = new Object();
	parametros.codigoRecibo = $("#codigoRecibo").val();
	
	jQuery("#grillaReciboLuz").jqGrid(
	{
		url : 'reporte-recibo-luz-puesto.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		postData: parametros,
		colNames : ['Nombre Usuario', 'Puesto', 'Giro','Anterior','Actual','Total', 'Opciones'],
		colModel : [{
			name : 'nombreFull',
			index: 'nombreFull',
			sortable:false,
			width: 240,
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
			name : 'lecturaInicial',
			index: 'lecturaInicial',
			sortable:false,
			width: 35,
			align: 'center'
		},{
			name : 'lecturaFinal',
			index: 'lecturaFinal',
			sortable:false,
			width: 35,
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
		pager : '#pgrillaReciboLuz',
		sortname : 'codigoPuesto',
		autowidth: true,
		rownumbers: true,
		viewrecords : true,
		sortorder : "codigoPuesto",				
		caption : "Recibo de Luz Socios",
		afterInsertRow: function(rowId, data, item){
			//alert(rowId + ' - ' + data + ' - ' + item.total);
			if ( (item.reciboLuzCreado == 0) && (item.corteLuz == 0 || item.corteLuz == null) ) {
				$("#grillaReciboLuz").setCell(rowId, 'nombreFull', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'nroPuesto', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'nombreGiro', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'lecturaInicial', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'lecturaFinal', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'total', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
			} else if ( (item.reciboLuzCreado == 1) && (item.corteLuz == 1) ) {
				$("#grillaReciboLuz").setCell(rowId, 'nombreFull', '', { 'background-color':'##FF8000','color':'white','font-weight':'bold' });				
				$("#grillaReciboLuz").setCell(rowId, 'nroPuesto', '', { 'background-color':'#FF8000','color':'white','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'lecturaInicial', '', { 'background-color':'#FF8000','color':'white','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'lecturaFinal', '', { 'background-color':'#FF8000','color':'white','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'nombreGiro', '', { 'background-color':'#FF8000','color':'white','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'total', '', { 'background-color':'#FF8000','color':'white','font-weight':'bold' });
			} else if ( (item.reciboLuzCreado == 1) && (item.suspendido == 1) ) {
				$("#grillaReciboLuz").setCell(rowId, 'nombreFull', '', { 'background-color':'#FFBF00','color':'black','font-weight':'bold' });				
				$("#grillaReciboLuz").setCell(rowId, 'nroPuesto', '', { 'background-color':'#FFBF00','color':'black','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'nombreGiro', '', { 'background-color':'#FFBF00','color':'black','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'lecturaInicial', '', { 'background-color':'#FFBF00','color':'black','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'lecturaFinal', '', { 'background-color':'#FFBF00','color':'black','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'total', '', { 'background-color':'#FFBF00','color':'black','font-weight':'bold' });		
			} else {
				$("#grillaReciboLuz").setCell(rowId, 'nombreFull', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'nroPuesto', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'nombreGiro', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'lecturaInicial', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'lecturaFinal', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'total', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
			}

		}

	}).trigger('reloadGrid');
}


function generarReciboLuzXSocio(sector, puesto, original){
		
	$("#sectorSocio").text(sector);
	$("#puestoSocio").text(puesto);									
	$("#reciboOriginal").text(original);
	
	colorEtiquetas();
	
	/*$("#codigoReciboLuzOriginal").val(codigoReciboLuzOriginal);
	buscarUsuario();*/
	$(function() {
		$("#idRecibo").focus();
	});
	
	cargarDatosReciboLuzSocio(sector, puesto, original);
}

function cargarDatosReciboLuzSocio(sector, puesto, original){	

	//alert(codigoPuesto);
	var ruta = obtenerContexto();
	var estadoAbierto;
	
	var parametros = new Object();
	parametros.codigoSector         = sector;
	parametros.nroPuesto            = puesto;
	parametros.codigoReciboOriginal = original;
	
	$.ajax({
        type: "POST",
        async:false,
        url: "buscar-usuario-puesto-giro.json",
        cache : false,
        data: parametros,
        success: function(result){
            console.log(result);
        	//alert("Resultado : [" + result.rows + "]");
        	$.each(result.rows, function(key,val) {
				estadoAbierto = val.estadoAbierto;
			});
        	
        	if (estadoAbierto == 0) {
	        	$.each(result.rows, function(key,val) {
	            	$("#nombreSocio").text(val.nombreFull);
	            	$("#puestoSocio").text(val.nroPuesto);
	            	$("#sectorSocio").text(val.nombreSector);
	            	$("#giroSocio").text(val.nombreGiro);
	            	$("#periodoSocio").text(val.periodoSocio);
	            	$("#alumbradoPublicoSocio").val(val.alumbradoPublico);
	            	$("#servicioMantenimientoSocio").val(val.mantenimiento);
	            	$("#costoWatts").val(val.numCostoWatts);
	            	$("#codigoSocio").val(val.codigoSocio);
	            	$("#reciboLuzCreado").val(val.reciboLuzCreado);
	            	$("#cableadoPrincipalSocio").val(val.cableadoPrincipal);	            	          	
	            	
					if ($("#reciboLuzCreado").val() == 0) {
						
						$('#recibos_luz_por_socio_modal').modal({
							backdrop: 'static',
							keyboard: false
						});
						
					} else {
						
						$.gritter.add({
							// (string | mandatory) the heading of the notification
							title: 'Mensaje',
							// (string | mandatory) the text inside the notification
							text: 'El Recibo de Luz del puesto ' + $("#puestoSocio").text() + ' ya fue creado...!!!',
							// (string | optional) the image to display on the left
							image: "/" + ruta + "/recursos/images/confirm.png",
							// (bool | optional) if you want it to fade out on its own or just sit there
							sticky: false,
							// (int | optional) the time you want it to be alive for before fading out
							time: ''
						});
						
					}

	        	});
        	} else {
        		$.gritter.add({
					// (string | mandatory) the heading of the notification
					title: 'Mensaje',
					// (string | mandatory) the text inside the notification
					text: 'El Recibo de Luz Principal se encuentra CERRADO, por lo tanto, no podrá realzar esta acción',
					// (string | optional) the image to display on the left
					image: "/" + ruta + "/recursos/images/confirm.png",
					// (bool | optional) if you want it to fade out on its own or just sit there
					sticky: false,
					// (int | optional) the time you want it to be alive for before fading out
					time: ''
				});
        	}        	

        	
        }
    });
	
	$("#lecturaInicialSocio").focus();
}


function editarReciboLuzXSocio(original, puesto){
	
	var ruta = obtenerContexto();
	var estadoAbierto;
	mensaje = "Desea editar el recibo del Puesto " + puesto + " ?"; 
	//mensaje = "En cosntrucción " + puesto + " ?";
	
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
		    url: "editar-luz-x-socio.json",
		    cache : false,
		    data: parametros,
		    //dataType: "html",
		    success: function(result){
		    	
		    	//alert(result.records);		    	
			    $('#alerta_modal').modal('hide');
	
			    $.each(result.rows, function(key,val) {
			    	estadoAbierto = val.estadoAbierto;
			    });
			    
		        if (result.records > 0) {
		        	
		        	if (estadoAbierto == 0) {		        	
				        $('#recibos_luz_por_socio_modal').modal({
			        		backdrop: 'static',
			        		keyboard: false
			        	});	        	
	
			        	$.each(result.rows, function(key,val) {		        		
			        		$("#codigoSocio").val(val.codigoSocio);
			            	$("#nombreSocio").text(val.nombreFull);
			            	$("#puestoSocio").text(val.puestoSocio);
			            	$("#sectorSocio").text(val.nombreSector);
			            	$("#giroSocio").text(val.nombreGiro);
			            	$("#periodoSocio").text(val.fecPeriodo);
							$("#idRecibo").val(val.idRecibo);
			            	$("#lecturaInicialSocio").val(val.lecturaInicial);
			        		$("#lecturaFinalSocio").val(val.lecturaFinal);
			        		if (val.trabado == 1){
			        			$("input:checkbox").attr('checked', 'checked');
		        				$("#sintraba").hide();
		        				$("#contraba").show();
		        				$("#consumoMesSocioTrabado").val(val.consumoMes);
			        		} else {
			        			$("input:checkbox").removeAttr('checked');
		        				$("#sintraba").show();
		        				$("#contraba").hide();
		        				$("#consumoMesSocio").html(val.consumoMes);
			        		}		        		
			        		$("#cargoEnergiaSocio").val(val.cargoEnergia);
			        		$("#alumbradoPublicoSocio").val(val.alumbradoPublico);
			        		$("#servicioMantenimientoSocio").val(val.servicioMantenimiento);
			        		$("#deudaAnteriorSocio").val(val.deudaAnterior);
			        		$("#reconexionSocio").val(val.reconexion);
			        		$("#totalSocio").html(val.total);
			        		$("#costoWatts").val(val.costoWatts);
			        		$("#codigoReciboLuzSocio").val(val.correlativo);
			        		$("#igvSocio").val(val.igvCargo);
			        		$("#cableadoPrincipalSocio").val(val.cableadoPrincipal);
			        		
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
			        	});
		        	} else {
		        		$.gritter.add({
							// (string | mandatory) the heading of the notification
							title: 'Mensaje',
							// (string | mandatory) the text inside the notification
							text: 'El Recibo de Luz Principal se encuentra CERRADO, por lo tanto, no podrá realzar esta acción',
							// (string | optional) the image to display on the left
							image: "/" + ruta + "/recursos/images/confirm.png",
							// (bool | optional) if you want it to fade out on its own or just sit there
							sticky: false,
							// (int | optional) the time you want it to be alive for before fading out
							time: ''
						});
		        	}
	        	
	        	} else {
	        		
	        		$.gritter.add({
						// (string | mandatory) the heading of the notification
						title: 'Mensaje',
						// (string | mandatory) the text inside the notification
						text: 'El Recibo de Luz del puesto ' + puesto + ' aún no se ha creado, verifique...',
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


function pagarReciboLuzXSocio(original, puesto, codigoSocio){
	
	var ruta = obtenerContexto();
	mensaje = "Desea dar por PAGADO el recibo de LUZ del Puesto " + puesto + " ?"; 
	
	$("#mensajePagar").html(mensaje);
	
	$('#alerta_modal_pagar').modal({
		backdrop: 'static',
		keyboard: false
	}).one('click', '#aceptar', function() {
        
		jsonObj = [];
		var parametros = new Object();
		parametros.nroPuesto = puesto;
		parametros.codigoRecibo = original;
		parametros.codigoSocio = codigoSocio;
		parametros.pagado = 1;
		$.ajax({
			type: "POST",
		    async:false,
		    url: "pagar-luz-x-socio.json",
		    cache : false,
		    data: parametros,
		    success: function(result){
		    	
		    	//alert(result.records);

			    $('#alerta_modal_pagar').modal('hide');
	
		        if (result.records > 0) {
			        $('#recibos_luz_por_socio_modal').modal({
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
	        	cargarReciboLuzSocio(original);
	            
			}
		});
		
    });

}



function cerrarReciboLuz(codigo){
	var ruta = obtenerContexto();
	mensaje = "Desea CERRAR el recibo de luz de código " + codigo + " ?"; 
	//mensaje = "En cosntrucción " + puesto + " ?";
	
	$("#mensajeCerrar").html(mensaje);
	
	$('#mensaje_modal').modal({
		backdrop: 'static',
		keyboard: false
	}).one('click', '#aceptar', function() {
		jsonObj = [];
		var parametros = new Object();
		parametros.codigoReciboLuzOriginal = codigo;
		
		$.ajax({
			type: "POST",
		    async:false,
		    url: "cerrar-luz-original.json",
		    cache : false,
		    data: parametros,
		    //datatype: "json",
		    success: function(result){
		    	
		    	if(result.camposObligatorios.length == 0){	    	
				    $('#mensaje_modal').modal('hide');
		      		
	        		$.gritter.add({
						// (string | mandatory) the heading of the notification
						title: 'Mensaje',
						// (string | mandatory) the text inside the notification
						text: 'El Recibo de Luz de Código ' + codigo + ' se cerró correctamente, no podrá ingresar recibos para socios en este período',
						// (string | optional) the image to display on the left
						image: "/" + ruta + "/recursos/images/confirm.png",
						// (bool | optional) if you want it to fade out on its own or just sit there
						sticky: false,
						// (int | optional) the time you want it to be alive for before fading out
						time: ''
					});
	
	        		cargarReciboLuzOriginal();
		    	}
		            
			}
		});
	});
}



function abrirReciboLuz(codigo){
	alert("Usted no está autorizado para activar nuevamente este recibo de luz... [" + codigo + "]");
}



function generarImpresión(codigo){
	alert("Generando todos los recibos de impresión de los socios para el código... [" + codigo + "]");
}


function floorFigure(figure, decimals){
    if (!decimals) decimals = 2;
    var d = Math.pow(10,decimals);
    return (parseInt(figure*d)/d).toFixed(decimals);
};


function redondear_dos_decimal(valor) {
	var redondea_valor = 0.00;
	redondea_valor = Math.round(valor * 100) / 100;
   return redondea_valor; 
}



function calculaCampos(valor){
	var valores  = valor;
	var subTotal = 0.00;
	var igv      = 0.00;
	var totalMes = 0.00;
	var total    = 0.00;
	
	if (valores=='O'){
		subTotal =	redondear_dos_decimal( parseFloat($("#repoManCnx").val()) + parseFloat($("#cargoFijo").val())+ parseFloat($("#energActFraPtaTotal").val()) + parseFloat($("#energActHorPtaTotal").val()) + parseFloat($("#energReacTotal").val()) + parseFloat($("#interesCompensatorio").val()) + parseFloat($("#potUsoRedDistTotal").val()) + parseFloat($("#potGenFpTotal").val()) + parseFloat($("#alumbradoPublicoOriginal").val()) );
		if (!isNaN(subTotal))
			$("#subTotalMes").val(subTotal);
		else
			$("#subTotalMes").val(0);
		
		igv = redondear_dos_decimal( parseFloat(subTotal*0.18) );
		if (!isNaN(subTotal))
			$("#igv").val(igv);
		else
			$("#igv").val(0);
		
		totalMes = redondear_dos_decimal( parseFloat(subTotal) + parseFloat(igv) );
		if (!isNaN(totalMes))
			$("#totalMesAct").val(totalMes);
		else
			$("#totalMesAct").val(0);
		
	}else if (valores=='T'){
		/*total =  Math.ceil(parseFloat($("#totalMesAct").val()) + parseFloat($("#aporteLey").val()) + parseFloat($("#deudaAnterior").val()) 
		+ parseFloat($("#recargoMora").val()) + parseFloat($("#redonMesAnt").val()) + parseFloat($("#redonMesAct").val()) 
		+ parseFloat($("#ajustePreRet").val()) + parseFloat($("#igvRefact").val()));*/
		total = redondear_dos_decimal( parseFloat($("#totalMesAct").val()) + parseFloat($("#aporteLey").val()) + parseFloat($("#deudaAnterior").val()) 
				+ parseFloat($("#recargoMora").val()) + parseFloat($("#redonMesAnt").val()) + parseFloat($("#redonMesAct").val()) 
				+ parseFloat($("#ajustePreRet").val()) + parseFloat($("#igvRefact").val()) );
			
		if (!isNaN(total))
			$("#total").val(total);
		else
			$("#total").val(0);
	}

}

function redondeo(numero, decimales)
{
	var flotante = parseFloat(numero);
	var resultado = Math.round(flotante*Math.pow(10,decimales))/Math.pow(10,decimales);
	return resultado;
}

function operaciones(valor){
	var valores = valor;
	var respuesta = 0;
	var cargoEnergia = 0;
	var igvCargoEnergia = 0;
	var totalCargoEnergia = 0;
	//alert(valores);
	
	if (valores=='L'){
		if( $('#sintraba').is(":visible") ){
			respuesta = parseInt($("#lecturaFinalSocio").val()) - parseInt($("#lecturaInicialSocio").val());
			if (!isNaN(respuesta))
				$("#consumoMesSocio").html(respuesta);
			else
				$("#consumoMesSocio").html(0);
		} 


		if( $('#sintraba').is(":visible") ){
			cargoEnergia = redondear_dos_decimal( parseFloat($("#costoWatts").val())*parseFloat($("#consumoMesSocio").html()) );
		} else {
			cargoEnergia = redondear_dos_decimal( parseFloat($("#costoWatts").val())*parseFloat($("#consumoMesSocioTrabado").val()) );
		}
		
//		alert("cargo: " + cargoEnergia);
		$("#cargoEnergiaSocio").val(cargoEnergia);
		totalCargoEnergia = redondear_dos_decimal( cargoEnergia * 1.18 ); // IGV, considerarlo como parámetro
		igvCargoEnergia = redondear_dos_decimal( totalCargoEnergia - cargoEnergia );
		$("#igvSocio").val(igvCargoEnergia);
		
		operaciones('R');
		
	}else if (valores=='R'){
		
		
		//cargoEnergiaSocio, igvSocio, alumbradoPublicoSocio, servicioMantenimientoSocio, deudaAnteriorSocio, reconexionSocio, cableadoPrincipalSocio, totalSocio
		
		respuesta = redondeo( redondear_dos_decimal( parseFloat($("#cargoEnergiaSocio").val()) + parseFloat($("#igvSocio").val()) + parseFloat($("#alumbradoPublicoSocio").val()) + parseFloat($("#servicioMantenimientoSocio").val()) + parseFloat($("#deudaAnteriorSocio").val()) + parseFloat($("#reconexionSocio").val()) + parseFloat($("#cableadoPrincipalSocio").val()) ), 1);
//		alert(respuesta);
		if (!isNaN(respuesta))
			$("#totalSocio").html( respuesta );
		else
			$("#totalSocio").html(0.00);
	}else{
		$("#lecturaInicialSocio").html(0);
		$("#lecturaFinalSocio").html(0);
		$("#consumoMesSocio").html(0.00);
		$("#consumoMesSocioTrabado").val(0.00);
		$("#consumoMesSocioTrabado").hidden();
		$("#cargoEnergiaSocio").html(0.00);
		$("#igvSocio").html(0.00);
		$("#alumbradoPublicoSocio").html(0.00);
		$("#servicioMantenimientoSocio").html(0.00);
		$("#deudaAnteriorSocio").html(0.00);
		$("#reconexionSocio").html(0.00);
		$("#cableadoPrincipalSocio").html(0.00);
		$("#totalSocio").html(0.00);
	}
	
}


function guardarRecibo(){
	
	var ruta = obtenerContexto();
	
	//alert("CORRELATIVO: " + $("#codigoReciboLuzSocio").val() );
	
	var parametros = new Object();
	parametros.codigoSocio = $("#codigoSocio").val();
	parametros.codigoRecibo = $("#nroRecibo").text();
	parametros.idsocio = $("#idRecibo").val();
	parametros.lecturaInicial = $("#lecturaInicialSocio").val();
	parametros.lecturaFinal = $("#lecturaFinalSocio").val();
	if( $('#sintraba').is(":visible") ){
		parametros.consumoMes = $("#consumoMesSocio").html();
		parametros.trabado = 0;
	} else {
		parametros.consumoMes = $("#consumoMesSocioTrabado").val();
		parametros.trabado = 1;
	}
	parametros.cargoEnergia = $("#cargoEnergiaSocio").val();
	parametros.igvSocio = $("#igvSocio").val();
	parametros.alumbradoPublico = $("#alumbradoPublicoSocio").val();
	parametros.servicioMantenimiento = $("#servicioMantenimientoSocio").val();
	parametros.deudaAnterior = $("#deudaAnteriorSocio").val();
	parametros.reconexion = $("#reconexionSocio").val();
	parametros.total = $("#totalSocio").text();
	parametros.correlativo = $("#codigoReciboLuzSocio").val();
	parametros.idRecibo = $("#idRecibo").val();
	parametros.suspendido =  $("#suspendido").val();
	parametros.cableadoPrincipal =  $("#cableadoPrincipalSocio").val();
	parametros.igvCargo =  $("#igvSocio").val();
		
	$.ajax({
		type: "POST",
	    async:false,
	    url: "grabar-luz-x-socio.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	            
	        if(result.camposObligatorios.length == 0){
                	
            	$('#luz_original_modal').modal('hide');
            	
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
	            
	            cargarReciboLuzSocio();
	            limpiarReciboLuzSocio();
	            
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


function limpiarReciboLuzSocio(){
	
	$("#nombreSocio").text('');
	$("#puestoSocio").text('');								
	$("#sectorSocio").text('');
	$("#giroSocio").text('');
	$("#periodoSocio").text('');
	$("#idRecibo").val('');
	$("#lecturaInicialSocio").val('');
	$("#lecturaFinalSocio").val('');
	$("#consumoMesSocio").text('');
	$("#ConsumoMesSocioTrabado").val('');
	$("#cargoEnergiaSocio").val('');
	$("#igvSocio").val('');
	$("#alumbradoPublicoSocio").val('');
	$("#servicioMantenimientoSocio").val('');
	$("#deudaAnteriorSocio").val('');
	$("#reconexionSocio").val('');
	$("#cableadoPrincipalSocio").val('');
	$("#totalSocio").text('');
	$("#codigoReciboLuzSocio").val('0');
	$("#reciboLuzCreado").val('');

}


function buscarReciboLuz(){
	var codigoRecibo = $("#codigoRecibo").val();
	var codigoPuesto = $("#reciboLuzSocioBuscara").val();
	//alert ("RECIBO: " + codigoRecibo + " PUESTO: " + codigoPuesto);
	jsonObj = [];
	var parametros = new Object();
	parametros.codigoRecibo = codigoRecibo;
	parametros.codigoPuesto = codigoPuesto;
	
	if(intentos > 0){
		$("#grillaReciboLuz").jqGrid('setGridParam',
		{
			url : 'reporte-recibo-luz-puesto.json',
			datatype : "json",
			postData:parametros,
			page:1
		}).trigger('reloadGrid');
	}else{
		buscarReciboLuzSocio(codigoRecibo, codigoPuesto);
	}
		
}


function buscarReciboLuzSocio(codigoRecibo, codigoPuesto){
	intentos = 1;
	
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		var opciones = "<center>";
			
			opciones += "<a href=javascript:editarReciboLuzXSocio('";
			opciones += rowObject.codigoReciboOriginal + "','" + rowObject.nroPuesto + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Recibo Luz Socio'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:generarReciboLuzXSocio('";
			opciones += rowObject.codigoSector + "','" + rowObject.nroPuesto + "','" + rowObject.codigoReciboOriginal + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/agregar2_24x24.png' border='0' title='Crear Recibo de Luz por Socio'/>";
			opciones += "</a>";			

			opciones += "</center>";
			
		return opciones;
				
	};

	jsonObj = [];
	var parametros = new Object();
	parametros.codigoRecibo = codigoRecibo;
	parametros.codigoPuesto = codigoPuesto;
	
	alert("Codigo Puesto: " + $("#reciboLuzSocioBuscara").val());
	jQuery("#grillaReciboLuz").jqGrid(
	{
		url : 'reporte-recibo-luz-puesto.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		postData: parametros,
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
			width:110,
			sortable:false,
			search: false,
			formatter:formatterBotones
		}],								
		rowNum : 20,
		pager : '#pgrillaReciboLuz',
		sortname : 'codigoPuesto',
		autowidth: true,
		rownumbers: true,
		viewrecords : true,
		sortorder : "codigoPuesto",				
		caption : "Recibo de Luz Socios",
		afterInsertRow: function(rowId, data, item){
			//alert(rowId + ' - ' + data + ' - ' + item.total);
			if (item.reciboLuzCreado == 0){
				$("#grillaReciboLuz").setCell(rowId, 'nombreFull', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'nroPuesto', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'nombreGiro', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'total', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
			} else {
				$("#grillaReciboLuz").setCell(rowId, 'nombreFull', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'nroPuesto', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'nombreGiro', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'total', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
			}

		}

	}).trigger('reloadGrid');
}


function limpiar(){
	$("#codigoRecibo").val('0');
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

function campoEnter(e,t)
{
	var k=null;
	(e.keyCode) ? k=e.keyCode : k=e.which;
	if(k==13) (!t) ? botonEnter() : t.focus();
}

function botonEnter()
{
	document.forms[0].submit();
	return true;
}

</script>
</head>
<body id="body">
<input type="hidden" id="codigoPuestoSocio" />
<input type="hidden" id="codigoSocio" />
<input type="hidden" id="codigoRecibo" />
<input type="hidden" id="costoWatts" />
<input type="hidden" id="codigoReciboLuzSocio" />
<input type="hidden" id="reciboLuzCreado" />
<input type="hidden" id="suspendido" />
<table border="0" width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td width="150"><b>MES RECIBO LUZ<b/></td>
		<td width="10">:</td>
		<td width="200"><input type="text" id="reciboBuscara" class="form-control" maxlength="8" /></td>
		<td>&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" onclick="cargarReciboLuzOriginal()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
			</button>&nbsp;&nbsp;
			<button class="btn btn-primary" data-toggle="modal" data-target="#luz_original_modal" onclick="nuevoRecibos()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Nuevo" />&nbsp;Nuevo
			</button>
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

<!-- Ventana Modal -->
<div class="modal fade" id="luz_original_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 800px">
		<div class="modal-content">
		
		<div class="modal-header modal-header-primary">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title">Recibo de Luz Original</h4>
		</div>
		
		<div class="modal-body">
			<table border="0" cellpadding="0" cellspacing="0" width="800px">
				<tr>
					<td><label><font size="2"><b>Periodo:</b></font></label></td>
					<td><input type='text' id='periodo' class='text ui-widget-content ui-corner-all' size="10" tabindex="1"/>(mes/año)</td>
					<td>&nbsp;</td>
					<td><label><font size="2"><b>Fecha de Vencimiento:</b></font></label></td>
					<td><input type='text' id='fecVencimiento' class='text ui-widget-content ui-corner-all' size="10" tabindex="2"/>(dia/mes/año)</td>
				</tr>
				<tr>
					<td><label><font size="2"><b>Fecha de Emision:</b></font></label></td>
					<td><input type='text' id='fecEmision' class='text ui-widget-content ui-corner-all' size="10" tabindex="3"/>(dia/mes/año)</td>
					<td>&nbsp;</td>
					<td><label><font size="2"><b>Costo Wats:</b></font></label></td>	
					<td><input type='text' id='costoWats' class='text ui-widget-content ui-corner-all' size="10" value="0" tabindex="4"/></td>
				</tr>
				<tr>
					<td><label><font size="2"><b>Alumbrado Público:</b></font></label></td>
					<td><input type='text' id='alumbradoPublico' class='text ui-widget-content ui-corner-all' size="10" value="0" tabindex="5"/></td>
					<td>&nbsp;</td>
					<!-- td><label><font size="2"><b>Mantenimiento:</b></font></label></td -->	
					<td><label><font size="2"><b>Cargo Fijo:</b></font></label></td>
					<td><input type='text' id='mantenimiento' class='text ui-widget-content ui-corner-all' size="10" value="0" tabindex="6"/></td>
				</tr>
				<tr>
					<td><label><font size="2"><b>Cableado Línea Principal:</b></font></label></td>
					<td><input type='text' id='cableadoPrincipal' class='text ui-widget-content ui-corner-all' size="10" value="0" tabindex="7"/></td>
					<td colspan="3">&nbsp;</td>
				</tr>
				<tr>
					<td><label><font size="2"><b>Total Mes Actual:</b></font></label></td>
					<td><input type='text' id='totalmesactual' class='text ui-widget-content ui-corner-all' size="10" value="0" tabindex="8"/></td>
					<td>&nbsp;</td>
					<td><label><font size="2"><b>Total Mes Anterior:</b></font></label></td>	
					<td><input type='text' id='deudaanterior' class='text ui-widget-content ui-corner-all' size="10" value="0" tabindex="9"/></td>
				</tr>
			</table>

		</div>
		
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="guardar(1)">Grabar</button>
			<button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
		</div>
		
		</div>
	</div>
</div>
 

<!-- Ventana Modal para Recibo Luz Socios -->
<div class="modal fade" id="recibos_luz_socios_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 800px">
		<div class="modal-content">
		
		<div class="modal-header modal-header-primary">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title">Listado de Recibos de Luz de Socios</h4>
		</div>

		<div class="modal-body">
		
			<table border="0" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="4" style="color:red"><b>&nbsp;RECIBO DE LUZ ORIGINAL NRO. <span id="nroRecibo"></span></b></td>
				</tr>
				<tr>
					<td width="150"><b>PUESTO LUZ SOCIOS<b/></td>
					<td width="10">:</td>
					<td width="250"><input type="text" id="reciboLuzSocioBuscara" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
					<td colspan="2">&nbsp;&nbsp;
						<button type="button" class="btn btn-primary" onclick="buscarReciboLuz();">
							<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
						</button>&nbsp;&nbsp;
						<!-- 
						<button class="btn btn-info" onclick="cargarReciboLuzSocio()">
							<img src="recursos/images/icons/buscar_16x16.png" alt="Actualizar" />&nbsp;Actualizar
						</button>
						 -->
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
						<table id="grillaReciboLuz"></table>
						<div id="pgrillaReciboLuz"></div>
					</td>
				</tr>
			</table>	
		
		</div>
		
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="">Grabar</button>
			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="limpiar()">Cerrar</button>
		</div>
		
		</div>
	</div>
</div>


<!-- Ventana Modal Recibo Luz Ppor cada Socio -->
<div class="modal fade" id="recibos_luz_por_socio_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 450px">
		<div class="modal-content">
		
		<div class="modal-header modal-header-primary">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title">Recibos de Luz de Socio</h4>
		</div>

		<div class="modal-body">
		
			<table border="0" width="100%" cellpadding="0" cellspacing="0"></tr>
				<tr>
					<td colspan="4"><b>RECIBO DE LUZ <span id="reciboOriginal"></span><b/></td>
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
								<td><input type='text' id='idRecibo' name='idRecibo' size='10' class='text ui-widget-content ui-corner-all' style="text-align: center;" onKeyDown=""/></td>
							</tr>
							<tr>
								<td><b>Lectura Anterior :</b></td>
								<td><input type='text' id='lecturaInicialSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('L');" style="text-align: center;" onKeyDown=""/></td>
							</tr>
							<tr>
								<td><b>Lectura Actual :</b></td>
								<td><input type='text' id='lecturaFinalSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('L');" style="text-align: center;"/></td>
							</tr>
							<tr>
								<td colspan="2" align="center"><label><input type="checkbox" id="cbox1" value="first_checkbox" onclick="activaManual()"> Medidor Trabado</label></td>
							</tr>
							<tr id="sintraba">
								<td><b>Consumo de Mes :</b></td>
								<td><div id="consumoMesSocio" style="border: 2px solid blue; width: 100px;" align="center"></div></td>
							</tr>
							<tr id="contraba">
								<td><b>Consumo de Mes :</b></td>
								<td><input type='text' id='consumoMesSocioTrabado' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('L');" style="text-align: center;border: 2px solid blue; width: 100px;"/></td>
							</tr>
						</table>		
					</td>
				</tr>
				<tr>
					<td>
						<table border="0" width="100%">
							<tr>
								<td width="40%"><b>Cargo por Energía :</b></td>
								<!-- td><input type='text' id='cargoEnergiaSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('R');" style="text-align: center;" disabled="disabled"/></td -->
								<td><input type='text' id='cargoEnergiaSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('R');" style="text-align: center;"/></td>
							</tr>
							<tr>
								<td><b>IGV :</b></td>
								<td><input type='text' id='igvSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('R');" style="text-align: center;"/></td>
							</tr>
							<tr>
								<td><b>Alumbrado Público :</b></td>
								<td><input type='text' id='alumbradoPublicoSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('R');" style="text-align: center;"/></td>
							</tr>
							<tr>
								<td><b>Cargo Fijo :</b></td>
								<td><input type='text' id='servicioMantenimientoSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('R');" style="text-align: center;"/></td>
							</tr>
							<tr>
								<td><b>Deuda Anterior :</b></td>
								<td><input type='text' id='deudaAnteriorSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('R');" style="text-align: center;"/></td>
							</tr>
							<tr>
								<td><b>Reconexión :</b></td>
								<td><input type='text' id='reconexionSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('R');" style="text-align: center;"/></td>
							</tr>
							<tr>
								<td><b>Cableado Principal :</b></td>
								<td><input type='text' id='cableadoPrincipalSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('R');" style="text-align: center;"/></td>
							</tr>
							<tr>
								<td><b>TOTAL DE LUZ</b></td>
								<td><div id="totalSocio" style="border: 2px solid blue; width: 100px;" align="center"></div></td>
							</tr>
						</table>
						
					</td>
				</tr>
			</table>
		  
		  
		</div>
		
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="guardarRecibo()">Grabar</button>		
			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="limpiarReciboLuzSocio()">Cerrar</button>
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
				<h4 class="modal-title">Editar Recibo Luz</h4>
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


<div class="modal fade" id="mensaje_modal" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Mensaje Recibo Luz</h4>
			</div>
			<div class="modal-body">
					
				<table border="0">
					<tr>
						<td><img src="recursos/images/icons/exclamation_32x32.png" border="0" />&nbsp;<b><span id="mensajeCerrar" /></b></td>
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
				<h4 class="modal-title">Eliminar Recibo Luz</h4>
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


<div class="modal fade" id="alerta_modal_pagar" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Pagar Recibo Luz</h4>
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
</body>
</html>
