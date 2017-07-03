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
	
	.tablaCabecera{
		background-color: #428bca;
		color:white;
        /*font-family:Tahoma, Geneva, sans-serif;*/
        /*font-size:12px;*/
        font-weight: bold;
	}
	
	.boton {
		background:none;
	  	border:0;
	  	margin:0;
	  	padding:0;
	  	outline:0 none;
	}
	
	.modal-dialog {
  		width: 680px;
	}
</style>
<script>
$(document).ready(function(){	
	
	$('[data-toggle="popover"]').popover({ placement : 'right', trigger: "hover" });
	
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
    
	$.ajax({
        type: "POST",
        async: false,
        url: "listar-socios.json",
        cache: false,
        success: function(result){
        	
        	$("#responsable").autocomplete(result, {
                formatItem: function(item) {
                    return item.nombreFull;
                },
                width: 460,
                scroll: true,
                matchContains: true,
                minChars: 0//cuando se presiona el boton de flecha hacia abajo se muestra toda la lista
            }).result(function(event, item) {
            	
            	$("#codigoSocio").val(item.codigoSocio);
            	
            });
        	
        }
    });
	
	cargarBanios();
	cargarServicios();
	cargarServiciosOtros();
	
	$("#cboBanios").attr("disabled", true);
	
	$("#fecha").datepicker(
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

function colorEtiquetas(){
	
	$("#lblcboServicio").css("color", "black");
	$("#lblcboServicioDetalle").css("color", "black");
	$("#lblresponsable").css("color", "black");
	$("#lbldniAsociado").css("color", "black");
	$("#lblnombresAsociado").css("color", "black");
	
	$("#lblcboServicio").hide();
	$("#lblcboServicioDetalle").hide();
	$("#lblresponsable").hide();
	$("#lbldniAsociado").hide();
	$("#lblnombresAsociado").hide();
		
}

function nuevoOtroServicio(){
	
	$('#socio_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Otros Servicios");
	
	colorEtiquetas();
	
	$("#codigoSocio").val(0);
	$("#codigoServicioOtros").val(0);
	
	$("#inicio").val("");
	$("#fin").val("");
	$("#responsable").val("");
	$("#dniAsociado").val("");
	$("#nombresAsociado").val("");
	
	$("#rangosInicio").val("");
    $("#rangosFin").val("");
    $("#observacion").val("");
    $("#fecha").val("");
    $("#importeSobrante").val("0");
    $("#cboBanios").val(0);
    $("#cboBanios").attr("disabled", true);
	
	cargarServicios();
}

function guardar(){
	
	var ruta = obtenerContexto();
			
	jsonObj = [];
	var parametros = new Object();
	
	parametros.codigoSocio 			= $("#codigoSocio").val();
	parametros.codigoServicio		= $("#cboServicio").val();
	parametros.dniResponsable 		= $("#dniAsociado").val();
	parametros.nombreResponsable 	= $("#nombresAsociado").val();
	parametros.importeSobrante 		= $("#importeSobrante").val();
	parametros.observacion	 		= $("#observacion").val();
	parametros.fecha		 		= $("#fecha").val();
	parametros.codigoServicioOtros	= $("#codigoServicioOtros").val();
	
	$("#tabla_otros tbody tr").each(function (item) {
		var this_row = $(this);
        codServicioDetalle = $.trim(this_row.find('td:eq(0)').html());
        nomServicioDetalle = $.trim(this_row.find('td:eq(1)').html());
        codBanios = $.trim(this_row.find('td:eq(2)').html());
        nomBanios = $.trim(this_row.find('td:eq(3)').html());
        ranInicio = $.trim(this_row.find('td:eq(5)').html());
        ranFin = $.trim(this_row.find('td:eq(6)').html());
        importe = $.trim(this_row.find('td:eq(7)').html());
        
        //[{"codigoServicioDetalle":"Codigo Detalle","codigoBanio":"Codigo Baños","rangoInicio":"Rango","rangoFin":"Importe"},{"codigoServicioDetalle":"6","codigoBanio":"0","rangoInicio":"1234 - 1254","rangoFin":"0"},{"codigoServicioDetalle":"9","codigoBanio":"0","rangoInicio":"1234 - 1254","rangoFin":"0"}]
        
        if(codServicioDetalle != "Codigo Detalle"){
	        objetos = {};
	        objetos.codigoServicioDetalle = codServicioDetalle;
	        objetos.codigoBanio = codBanios;
	        objetos.rangoInicio = ranInicio;
	        objetos.rangoFin = ranFin;
	        jsonObj.push(objetos);
        }	       
        
	});
	
	parametros.servicioOtrosDetalle = JSON.stringify(jsonObj);
	
	$.ajax({
		type: "POST",
	    async:false,
	    url: "grabar-servicio-otros.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	        
	        if(result.camposObligatorios.length == 0){
                
	        	imagen = "";
	        	if(result.codigoRetorno == "00"){
            		$('#socio_modal').modal('hide');
            		imagen = "ok";
	        	}else{
	        		imagen = "advertencia";
	        	}
	        	
	            $.gritter.add({
					// (string | mandatory) the heading of the notification
					title: 'Mensaje',
					// (string | mandatory) the text inside the notification
					text: result.mensaje,
					// (string | optional) the image to display on the left
					image: "/" + ruta + "/recursos/images/" + imagen + ".png",
					// (bool | optional) if you want it to fade out on its own or just sit there
					sticky: false,
					// (int | optional) the time you want it to be alive for before fading out
					time: ''
				});
	            
	            cargarServiciosOtros();
	            limpiarTablaOtros();
	            calculoTotal();
	            cargarServiciosDetalle();
	            
	            $("#rangosInicio").val("");
	            $("#rangosFin").val("");
	            $("#observacion").val("");
	            $("#fecha").val("");
	            $("#importeSobrante").val("0");
	            $("#cboBanios").val(0);
	            $("#cboBanios").attr("disabled", true);
			}else{
                	
            	colorEtiquetas();
            	fila = "";
            	/*
            	$.each(result.camposObligatorios, function(id, obj){
                        
                	$("#" + obj.nombreCampo).css("color", "red");
                    $("#" + obj.nombreCampo + "-img").show();
                    $("#" + obj.nombreCampo + "-img").attr("data-content", obj.descripcion);
                        
				});
                */	
			}
                
		}
	});
	
}

function cargarServicios(){
	
	$.ajax({
        type: "POST",
        async: false,
        url: "cargar-otros-servicios.json",
        cache: false,
        success: function(result){
        	
        	var optionServicios = "<option value=0>SELECCIONAR</option>";
        	$.each(result, function(keyM, serv) {
        		
        		optionServicios += "<option value=" + serv.codigoServicio + ">" + serv.nombreServicio + "</option>";
        		
        	});
        	
        	$("#cboServicio").html(optionServicios);
    		
        }
    });
	
}

function cargarServiciosDetalle(){
	
	var codigoServicio = $("#cboServicio").val();
	var parametros = new Object();
	parametros.codigoServicio = codigoServicio;
	
	$.ajax({
        type: "POST",
        async: false,
        url: "cargar-otros-servicios-detalle.json",
        cache: false,
        data: parametros,
        success: function(result){
        	
        	var optionServicios = "<option value=0>SELECCIONAR</option>";
        	$.each(result, function(keyM, serv) {
        		
        		optionServicios += "<option value=" + serv.codigoServicioDetalle + ">" + serv.nombreDetalle + "</option>";
        		
        	});
        	
        	$("#cboServicioDetalle").html(optionServicios);
    		
        }
    });
	
	if(codigoServicio == 7){
		$("#cboBanios").attr("disabled", false);
	}else{
		$("#cboBanios").attr("disabled", true);
	}
	
	$("#rangosInicio").val("");
	$("#rangosFin").val("");
	
	limpiarTablaOtros();
	
}

function cargarBanios(){
	
	$.ajax({
        type: "POST",
        async: false,
        url: "cargar-banios.json",
        cache: false,
        success: function(result){
        	
        	var option = "<option value=0>SELECCIONAR</option>";
        	$.each(result, function(keyM, serv) {
        		
        		option += "<option value=" + serv.codigoBanio + ">" + serv.nombreBanio + "</option>";
        		
        	});
        	
        	$("#cboBanios").html(option);
    		
        }
    });
	
}

function agregarDetalleServicio(){
	
	var ruta = obtenerContexto();
	
	codigoServicio = $("#cboServicio").val();
	codigoServicioDetalle = $("#cboServicioDetalle").val();
	nombreServicioDetalle = $("#cboServicioDetalle option:selected").html();
	codigoBanios = $("#cboBanios").val();
	nombreBanios = $("#cboBanios option:selected").html();
	rangoInicio = $("#rangosInicio").val();
	rangoFin = $("#rangosFin").val();
	
	inicioImporte = nombreServicioDetalle.indexOf(" - ");
	montoImporte = nombreServicioDetalle.substring(inicioImporte + 3);
	total = (rangoFin - rangoInicio + 1) * montoImporte;
	
	//alert("Importe : [" + montoImporte + "] - Total : [" + total + "]");
	
	if(codigoBanios == 0){
		nombreBanios = "";
	}
	
	cantidadErrores = 0;
	//Si codigo de servicio es BANIO = 7
	if(codigoServicio == 7){
		
		if(codigoServicioDetalle == 0){
			cantidadErrores = 1;
		}else{
			if(rangoInicio == ""){
				cantidadErrores = 1;
			}
			
			if(rangoFin == ""){
				cantidadErrores = 1;
			}
		}
	}else{
		if(codigoServicio == 0){
			cantidadErrores = 1;
		}else{
			if(rangoInicio == ""){
				cantidadErrores = 1;
			}
			
			if(rangoFin == ""){
				cantidadErrores = 1;
			}
		}
	}
	
	$("#tabla_otros tbody tr").each(function (item) {
        var this_row = $(this);
        codServicioDetalle = $.trim(this_row.find('td:eq(0)').html());
        nomServicioDetalle = $.trim(this_row.find('td:eq(1)').html());
        codBanios = $.trim(this_row.find('td:eq(2)').html());
        nomBanios = $.trim(this_row.find('td:eq(3)').html());
        ranInicio = $.trim(this_row.find('td:eq(5)').html());
        ranFin = $.trim(this_row.find('td:eq(6)').html());
        importe = $.trim(this_row.find('td:eq(7)').html());
        
        if(codServicioDetalle == codigoServicioDetalle){
        	cantidadErrores == 1;
        }
        
	});
	
	if(cantidadErrores == 0){
		$('#tabla_otros tbody tr:last').after(
			"<tr>" +
	           	"<td align='center' style='display:none;'>" + codigoServicioDetalle + "</td>" + 
	           	"<td align='left'>" + nombreServicioDetalle + "</td>" +
	           	"<td align='center' style='display:none;'>" + codigoBanios + "</td>" +
				"<td align='left'>" + nombreBanios + "</td>" +
				"<td align='center'>" + rangoInicio + " - " + rangoFin + "</td>" +
				"<td align='center' style='display:none;'>" + rangoInicio + "</td>" +
				"<td align='center' style='display:none;'>" + rangoFin + "</td>" +
				"<td align='right'>" + formatearImporte(total) + "</td>" +
				"<td align='center'>" +
				"<button type='button' class='boton btnEliminar' onclick='eliminarFila(this);'>" +
					"<img src='/"+ruta+"/recursos/images/icons/eliminar_16x16.png' alt='Eliminar' />" +
				"</button></td>" +
			"</tr>");
		
		calculoTotal();
		
	}
}

function eliminarFila(t){

	var td = t.parentNode;
    var tr = td.parentNode;
    var table = tr.parentNode;
	table.removeChild(tr);
	
	calculoTotal();
}

function limpiarTablaOtros(){
	
	var tabla = document.getElementById("tabla_otros");
	var filasTabla = tabla.rows.length;
	
	for(var i = 0; i < filasTabla - 1; i++) {
		
 		if(i > 0){
 			
 			tabla.deleteRow(1);
 			
 		}
 		
 	}
}

function editarOtrosServicios(codigoServicioOtros){
	
	nuevoOtroServicio();
	
	var ruta = obtenerContexto();
	var parametros = new Object();
	parametros.codigoServicioOtros = codigoServicioOtros;
	
	$("#codigoServicioOtros").val(codigoServicioOtros);
	
	$.ajax({
        type: "POST",
        async:false,
        url: "buscar-servicioOtrosCabecera.json",
        cache : false,
        data: parametros,
        success: function(result){
            
        	$("#dniAsociado").val(result.dniResponsable);
        	$("#nombresAsociado").val(result.nombreResponsable);
        	$("#importeSobrante").val(result.importeSobrante);
        	$("#fecha").val(result.fecha);
        	$("#observacion").val(result.observacion);
        	$("#cboServicio").val(result.codigoServicio);
        	$("#codigoSocio").val(result.codigoSocio);
        	$("#responsable").val(result.nombreFull);
        	cargarServiciosDetalle();
        	
        }
    });
	
	$.ajax({
        type: "POST",
        async:false,
        url: "buscar-servicioOtrosDetalle.json",
        cache : false,
        data: parametros,
        success: function(result){
            
        	var option = "<option value=0>SELECCIONAR</option>";
        	$.each(result, function(keyM, serv) {
        		
        		option += "<option value=" + serv.codigoBanio + ">" + serv.nombreBanio + "</option>";
        		
        		var codigoServicioDetalle = serv.codigoServicioDetalle;
        		var nombreDetalle = serv.nombreDetalle;
        		var codigoBanio = serv.codigoBanio;
        		var nombreBanio = serv.nombreBanio;
        		var rango = serv.rango;
        		var rangoInicio = serv.rangoInicio; 
        		var rangoFin = serv.rangoFin;
        		var importe = serv.importe;
        		
        		$('#tabla_otros tbody tr:last').after(
      				"<tr>" +
      		           	"<td align='center' style='display:none;'>" + codigoServicioDetalle + "</td>" + 
      		           	"<td align='left'>" + nombreDetalle + "</td>" +
      		           	"<td align='center' style='display:none;'>" + codigoBanio + "</td>" +
      					"<td align='left'>" + nombreBanio + "</td>" +
      					"<td align='center'>" + rango + "</td>" +
      					"<td align='center' style='display:none;'>" + rangoInicio + "</td>" +
      					"<td align='center' style='display:none;'>" + rangoFin + "</td>" +
      					"<td align='right'>" + importe + "</td>" +
      					"<td align='center'>" +
      					"<button type='button' class='boton btnEliminar' onclick='eliminarFila(this);'>" +
      						"<img src='/"+ruta+"/recursos/images/icons/eliminar_16x16.png' alt='Eliminar' />" +
      					"</button></td>" +
      				"</tr>");
        		
        	});
        	
        	calculoTotal();
        	
        }
    });
	
}

function eliminarOtrosServicios(codigoServicioOtros){
	
	var ruta = obtenerContexto();
	mensaje = "Desea eliminar Otros Servicios con codigo : " + codigoServicioOtros + " ?"; 
	
	$("#mensajeEliminar").html(mensaje);
	
	$('#alerta_modal').modal({
		backdrop: 'static',
		keyboard: false
	}).one('click', '#aceptar', function() {
        
		jsonObj = [];
		var parametros = new Object();
		parametros.codigoServicioOtros = codigoServicioOtros;
			
		$.ajax({
			type: "POST",
		    async:false,
		    url: "eliminar-servicio-otros.json",
		    cache : false,
		    data: parametros,
		    success: function(result){
		            
		        $('#alerta_modal').modal('hide');
	            	
	            $.gritter.add({
					title: 'Mensaje',
					text: result.mensaje,
					image: "/" + ruta + "/recursos/images/confirm.png",
					sticky: false,
					time: ''
				});
	            
	            cargarServiciosOtros();
		            
			}
		});
		
    });
	
}

function cargarServiciosOtros(){
	
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		nombreGiro = replaceAll(rowObject.nombreGiro, " ", "#");
		nombre = replaceAll(nombreFull, " ", "#");
		var opciones = "<center>";
			
			if(rowObject.estado == 1){
				opciones += "<a href=javascript:editarOtrosServicios(";
				opciones += rowObject.codigoServOtrosAlt + ") >";
				opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Otros Servicios'/>";
				opciones += "</a>";
				
				opciones += "&nbsp;&nbsp;";
			
				opciones += "<a href=javascript:eliminarOtrosServicios(";
				opciones += rowObject.codigoServOtrosAlt + ") >";
				opciones += "<img src='/"+ruta+"/recursos/images/icons/eliminar_24x24.png' border='0' title='Eliminar Otros Servicios'/>";
				opciones += "</a>";
			}
			
			opciones += "</center>";
			
		return opciones;
				
	};
	
	jQuery("#grilla").jqGrid(
	{
		url : 'reporte-servicios-otros.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		colNames : ['Código','Servicio', 'Asociado', 'DNI', 'Responsable', 'Importe', 'F.Registro', 'Opciones'],
		colModel : [{
			name : 'codigoServOtrosAlt',
			index: 'codigoServOtrosAlt',
			sortable:true,
			width: 50,
			align: 'left'						
		},{
			name : 'nombreServicio',
			index: 'nombreServicio',
			sortable:true,
			width: 100,
			align: 'left'						
		},{
			name : 'asociado',
			index: 'asociado',
			sortable:true,
			width: 200,
			align: 'left'						
		},{
			name : 'dniResponsable',
			index: 'dniResponsable',
			sortable:false,
			width: 90,
			align: 'center'
		},{
			name : 'nombreResponsable',
			index: 'nombreResponsable',
			sortable:false,
			width: 200,
			align: 'left'
		},{
			name : 'importeTotal',
			index: 'importeTotal',
			sortable:false,
			width: 180,
			align: 'center'
		},{
			name : 'fechaRegistro',
			index: 'fechaRegistro',
			sortable:false,
			width: 100,
			align: 'right'
		},{					
			name:'codigoServicioOtros',
			index:'codigoServicioOtros',
			width:100,
			sortable:false,
			search: false,
			formatter:formatterBotones
		}],								
		rowNum : 20,
		//rowList : [ 20, 30, 40 ],
		pager : '#pgrilla',
		sortname : 'codigoServicioOtros',
		autowidth: true,
		rownumbers: true,
		viewrecords : true,
		sortorder : "codigoServicioOtros",				
		caption : "Servicios Otros",				
		
		afterInsertRow: function(rowId, data, item){
			//alert(rowId + ' - ' + data + ' - ' + item.total);
			if (item.estado == 2){
				$("#grilla").setCell(rowId, 'codigoServOtrosAlt', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grilla").setCell(rowId, 'nombreServicio', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grilla").setCell(rowId, 'asociado', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grilla").setCell(rowId, 'dniResponsable', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grilla").setCell(rowId, 'nombreResponsable', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grilla").setCell(rowId, 'importeTotal', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grilla").setCell(rowId, 'fechaRegistro', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
			}

		},
		
		multiselect: false,
		subGrid: true,
		subGridRowExpanded: function(subgrid_id, row_id) {
			// we pass two parameters
			// subgrid_id is a id of the div tag created whitin a table data
			// the id of this elemenet is a combination of the "sg_" + id of the row
			// the row_id is the id of the row
			// If we wan to pass additinal parameters to the url we can use
			// a method getRowData(row_id) - which returns associative array in type name-value
			// here we can easy construct the flowing
			
			var data = $("#grilla").getRowData(row_id);
			var busqueda = data.codigoServOtrosAlt;
			
			var subgrid_table_id, pager_id;
			subgrid_table_id = subgrid_id+"_t";
			pager_id = "p_"+subgrid_table_id;
			$("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");
			jQuery("#"+subgrid_table_id).jqGrid({
				url:"reporte-servicios-otros-detalle.json?codigoServicioOtros=" + busqueda,
				datatype : "json",
				mtype: 'POST',
				colNames: ['Detalle', 'Rangos','Importe', 'Observación'],
				colModel: [{
					name:"nombreDetalle",
					index:"nombreDetalle",
					width:300,key:true
				},{
					name:"rangos",
					index:"rangos",
					width:130,
					align: 'center'
				},{
					name:"importeTotal",
					index:"importeTotal",
					width:130,
					align: 'right'
				},{
					name:"observacion",
					index:"observacion",
					align: 'left'
				}],
			   	rowNum:20,
			   	pager: pager_id,
			   	sortname: 'num',
			    sortorder: "asc",
			    height: '100%'
			});
			//jQuery("#"+subgrid_table_id).jqGrid('navGrid',"#"+pager_id,{edit:false,add:false,del:false})
			
			//alert("Row_id : " + row_id + " - codigoServicioOtros : " + data.codigoServicio);
		}/*,
		subGridRowColapsed: function(subgrid_id, row_id) {
			// this function is called before removing the data
			//var subgrid_table_id;
			//subgrid_table_id = subgrid_id+"_t";
			//jQuery("#"+subgrid_table_id).remove();
		}*/
    	
	}).trigger('reloadGrid');
}

function calculoTotal(){
	
	var total = 0;
	/*
    $("#tabla_resultado tbody tr").each(function (item) {
        var this_row = $(this);
        //var monto = $.trim(this_row.find('td:eq(3)').html());
        var monto = $.trim(this_row.find('td:eq(4)').html());
		if(monto != "" && monto != "Monto"){
			//console.log("[" + monto + "]");
			total = parseFloat(total) + parseFloat(monto);
		}
    });
    */
    $("#tabla_otros tbody tr").each(function (item) {
        var this_row = $(this);
        codServicioDetalle = $.trim(this_row.find('td:eq(0)').html());
        nomServicioDetalle = $.trim(this_row.find('td:eq(1)').html());
        codBanios = $.trim(this_row.find('td:eq(2)').html());
        nomBanios = $.trim(this_row.find('td:eq(3)').html());
        ranInicio = $.trim(this_row.find('td:eq(5)').html());
        ranFin = $.trim(this_row.find('td:eq(6)').html());
        importe = $.trim(this_row.find('td:eq(7)').html());
        
        if(codServicioDetalle != "Codigo Detalle"){
        	//total = total + importe;
        	total = parseFloat(total) + parseFloat(importe);
        	
        	//console.log("Importe : " + importe);
        	//console.log("Total : " + total);
        }
	});
	
	$("#totales").html(formatearImporte(total));
}

function mostrarIreport(){
	var url  = "/sigamm/iOtrosServicios";
	window.open(url,"_blank", "menubar=no,location=0,height=500,width=800");
}

</script>
</head>
<body id="body">
<input type="hidden" id="codigoSocio" />
<input type="hidden" id="codigoServicioOtros" />
<table border="0" width="100%">
	<tr>
		<td colspan="7">&nbsp;</td>
	</tr>
	<tr>
		<td colspan=7>&nbsp;&nbsp;
			<button type="button" class="btn btn-primary">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
			</button>&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" onclick="nuevoOtroServicio()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Nuevo" />&nbsp;Nuevo
			</button>
			<button type="button" class="btn btn-primary" onclick="mostrarIreport()">
				<img src="recursos/images/icons/pdf_16x16.png" alt="Reporte Otros Servicios" />&nbsp;Generar PDF
			</button>
		</td>
	</tr>
	<tr>
		<td colspan="7">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="7">
			<table id="grilla"></table>
			<div id="pgrilla"></div>
		</td>
	</tr>
</table>	

<div class="modal fade" id="socio_modal" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"><span id="tituloRegistro" /></h4>
			</div>
			<div class="modal-body">
				
					<table border="0" style="width: 650px;">
						<tr>
							<td colspan="7" align="right">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="7" align="left">
								<button type="button" class="btn btn-primary" onclick="guardar()">
									<img src="recursos/images/icons/guardar_16x16.png" alt="Guardar" />&nbsp;Guardar
								</button>
							</td>
						</tr>
						<tr>
							<td colspan="7" align="right">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lbldni"><b>Servicio (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><select id="cboServicio" class="form-control" onchange="cargarServiciosDetalle();" /></td>
							<td valign="top"><img id="lblcboServicio-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblfecnac"><b>Asociado (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="responsable" class="form-control" maxlength="100"/></td>
							<td valign="top"><img id="lblresponsable-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblfecingreso"><b>DNI Responsable (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="dniAsociado" class="form-control" maxlength="8"/></td>
							<td valign="top"><img id="lbldniAsociado-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lbltelefono"><b>Nombres Responsable</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="nombresAsociado" class="form-control" maxlength="100" /></td>
							<td valign="top"><img id="lblnombresAsociado-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lbltelefono"><b>Fecha</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="fecha" class="form-control" maxlength="10" style="width:100px" /></td>
							<td valign="top"><img id="lblfecha-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td colspan="7"><hr align=center size=2 width=100% /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblapepat"><b>Detalle (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><select id="cboServicioDetalle" class="form-control" /></td>
							<td valign="top"><img id="lblcboServicioDetalle-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblapemat"><b>Baños (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><select id="cboBanios" class="form-control" /></td>
							<td valign="top"><img id="lblcboBanios-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblnombres"><b>Rangos (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td>
								<table border="0">
									<tr>
										<td><input type="text" id="rangosInicio" class="form-control" maxlength="10" style="width:100px" /></td>
										<td>&nbsp;-&nbsp;</td>
										<td><input type="text" id="rangosFin" class="form-control" maxlength="10" style="width:100px" /></td>
										<td>&nbsp;&nbsp;</td>
										<td>
											<button type="button" id="btnAgregar" class="btn btn-primary" onclick="agregarDetalleServicio();">
												<img src="recursos/images/icons/agregar2_16x16.png" alt="Agregar" />&nbsp;Agregar
											</button>
										</td>
									</tr>
								</table>
							</td>
							<td valign="top"><img id="lblrangos-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td colspan="7"><hr align=center size=2 width=100% /></td>
						</tr>
						<tr>
							<td colspan="7">
								<table border="1" width="100%" id="tabla_otros" cellspacing="5" cellpadding="5" class="tabla">
									<tbody>
										<tr>
											<td align="center" class="tablaCabecera" width="20px" style="display:none;">Codigo Detalle</td>
											<td align="center" class="tablaCabecera">Detalle</td>
											<td align="center" class="tablaCabecera" width="20px" style="display:none;">Codigo Baños</td>
											<td align="center" class="tablaCabecera">Baños</td>
											<td align="center" class="tablaCabecera">Rango</td>
											<td align="center" class="tablaCabecera" width="20px" style="display:none;">Rango Inicio</td>
											<td align="center" class="tablaCabecera" width="20px" style="display:none;">Rango Fin</td>
											<td align="center" class="tablaCabecera" width="100px">Importe</td>
											<td align="center" class="tablaCabecera" width="20px">Acciones</td>
										</tr>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="2">&nbsp;</td>
											<td align="center"><b>Total :</b></td>
											<td align="right"><b><span id="totales" /></b></td>
											<td align="center"></td>
										</tr>
									</tfoot>
								</table>
							</td>
						</tr>
						<tr>
							<td colspan="7">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="7" valign="top">
								<table border="0" width="100%" cellpadding="0" cellspacing="0">
									<tr>
										<td width="50%">&nbsp;</td>
										<td align="right" valign="middle"><b>Importe Sobrante</b>&nbsp;&nbsp;</td>
										<td valign="middle">&nbsp;:&nbsp;</td>
										<td valign="middle"><input type="text" id="importeSobrante" class="form-control" maxlength="9" style="width:100px"/></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td colspan="7">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblobservacion"><b>Observación</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><textarea class="form-control" rows="5" id="observacion" maxlength="100"></textarea></td>
							<td valign="top"><img id="lblobservacion-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
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
 
<div class="modal fade" id="alerta_modal" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Eliminar Otros Servicios</h4>
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