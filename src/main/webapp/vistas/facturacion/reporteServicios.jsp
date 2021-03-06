<?xml version="1.0" encoding="UTF-8" ?>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	$.datepicker.setDefaults($.datepicker.regional['es']);
	
	$("#periodo").datepicker({
		dateFormat: 'MM yy',
		changeMonth: true,
		changeYear: false,
		numberOfMonths: 1,
		dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
		monthNames: ['ENERO', 'FEBRERO', 'MARZO', 'ABRIL', 'MAYO',
			'JUNIO', 'JULIO', 'AGOSTO', 'SEPTIEMBRE',
		    'OCTUBRE', 'NOVIEMBRE', 'DICIEMBRE'],
		monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr',
			'May', 'Jun', 'Jul', 'Ago',
		    'Sep', 'Oct', 'Nov', 'Dic'] 
	});
	
	cargarServicios();
		
});

function colorEtiquetas(){
	
	$("#lblnombre").css("color", "black");
	$("#lblimporte").css("color", "black");
	$("#lblperiodo").css("color", "black");
	
	$("#lblnombre-img").hide();
	$("#lblimporte-img").hide();
	$("#lblperiodo-img").hide();
		
}

function nuevoServicioDetalle(){
	
	$('#servicio_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Nuevo Servicio");
	
	$("#codigo").html("<b>0</b>");
	$("#nombre").val("");
	$("#importe").val("");
	$("#importeVariableNo").prop("checked", true);
	$("#importe").prop("disabled", false);
	
	colorEtiquetas();
	
	$("#codigoServicio").val(0);
	$("#codigoServicioDetalle").val(0);
	
	$("#opcionPeriodo").hide();
	$("#periodo").val("");
	$("#generarCobroNo").prop("checked", true);
}

function editarServicioDetalle(codigoServicio, codigoServicioDetalle, nombreServicioDetalle, importe, flagImporteVariable, flagGenerarCobro, periodo){
	
	$('#servicio_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Editar Servicio");
	
	$("#codigo").html("<b>" + codigoServicioDetalle + "</b>");
	$("#nombre").val(replaceAll(nombreServicioDetalle, "#", " "));
	if(flagImporteVariable == 1){
		$("#importeVariableSi").prop("checked", true);
		$("#importe").val(0);
		$("#importe").prop("disabled", true);
	}else{
		$("#importeVariableNo").prop("checked", true);
		$("#importe").val(importe);
		$("#importe").prop("disabled", false);
	}
	
	//console.log("flagGenerarCobro : [" + flagGenerarCobro + "]");
	
	if(flagGenerarCobro == 1){
		//console.log("flagGenerarCobro SI : [" + flagGenerarCobro + "]");
		$("#generarCobroSi").prop("checked", true);
		$("#periodo").val(replaceAll(periodo, "#", " "));
		$("#opcionPeriodo").show();
		$("#opcionImporte").hide();
	}else{
		//console.log("flagGenerarCobro NO : [" + flagGenerarCobro + "]");
		$("#generarCobroNo").prop("checked", true);
		$("#periodo").val("");
		$("#opcionPeriodo").hide();
		$("#opcionImporte").show();
	}
	
	$("#codigoServicio").val(codigoServicio);
	$("#codigoServicioDetalle").val(codigoServicioDetalle);
	
}

function eliminarServicioDetalle(codigoServicio, codigoServicioDetalle, nombreServicioDetalle, importe){
	
	var ruta = obtenerContexto();
	mensaje = "Desea eliminar el servicio con codigo : " + codigoServicioDetalle + " ?"; 
	$("#mensajeEliminar").html(mensaje);
	
	$('#alerta_modal').modal({
		backdrop: 'static',
		keyboard: false
	}).one('click', '#aceptar', function() {
		
		jsonObj = [];
		var parametros = new Object();
		
		parametros.codigoServicio			= codigoServicio;
		parametros.codigoServicioDetalle 	= codigoServicioDetalle;
		parametros.nombreDetalle 			= nombreServicioDetalle;
		parametros.importe 					= importe;
		
		$.ajax({
			type: "POST",
		    async:false,
		    url: "eliminar-servicio.json",
		    cache : false,
		    data: parametros,
		    success: function(result){
		        
	        	imagen = "";
	        	if(result.codigoRetorno == "00"){
            		$('#alerta_modal').modal('hide');
            		imagen = "ok";
            		
            		$("#codigoServicio").val(0);
    	        	$("#codigoServicioDetalle").val(0);
    	        	$("#nombre").val("");
    	        	$("#importe").val("");
    	        	
    	        	colorEtiquetas();
    	        	cargarServicios();
    	        	
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
		            
				
	                
			}
		});
		
	});
	
}

function cargarServicios(){
	
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		codigoServicio 			= rowObject.codigoServicio;
		codigoServicioDetalle 	= rowObject.codigoServicioDetalle;
		nombreDetalle 			= replaceAll(rowObject.nombreDetalle, " ", "#");
		importe 				= rowObject.importe;
		importeVariable 		= rowObject.flagImporteVariable;
		periodo 				= replaceAll(rowObject.periodo, " ", "#");
		generarCobro			= rowObject.flagGenerarCobro;
		mensajeGenerarCobro		= rowObject.mensajeFlagGenerarCobro;
		var opciones = "<center>";
			
			opciones += "<a href=\"javascript:editarServicioDetalle(" + codigoServicio + ", " + codigoServicioDetalle + ", '" + nombreDetalle + "', " + importe + ", " + importeVariable + ", " + generarCobro + ",'" + periodo + "'); \">";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Servicio'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=\"javascript:eliminarServicioDetalle(" + codigoServicio + ", " + codigoServicioDetalle + ", '" + nombreDetalle + "', " + importe + "); \">";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/eliminar_24x24.png' border='0' title='Eliminar Servicio'/>";
			opciones += "</a>";
			
		opciones += "</center>";
		
		//console.log(opciones);
			
		return opciones;
				
	};
	
	jQuery("#grilla").jqGrid(
	{
		url : 'reporte-servicios.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		colNames : ['Código', 'Nombre', 'Importe', 'Importe variable', 'Cobro por unica vez', 'Opciones'],
		colModel : [{
			name : 'codigoServicioDetalle',
			index: 'codigoServicioDetalle',
			sortable:true,
			width: 50,
			align: 'right'						
		},{
			name : 'nombreDetalle',
			index: 'nombreDetalle',
			sortable:true,
			width: 300,
			align: 'left'						
		},{
			name : 'importe',
			index: 'importe',
			sortable:false,
			width: 100,
			align: 'right'
		},{
			name : 'mensajeFlagImporteVariable',
			index: 'mensajeFlagImporteVariable',
			sortable:false,
			width: 100,
			align: 'center'
		},{
			name : 'mensajeFlagGenerarCobro',
			index: 'mensajeFlagGenerarCobro',
			sortable:false,
			width: 100,
			align: 'center'
		},{					
			name:'codigoServicioDetalle',
			index:'codigoServicioDetalle',
			width:100,
			sortable:false,
			search: false,
			formatter:formatterBotones
		}],								
		rowNum : 20,
		//rowList : [ 20, 30, 40 ],
		pager : '#pgrilla',
		sortname : 'nombreDetalle',
		autowidth: true,
		rownumbers: true,
		viewrecords : true
		
	}).trigger('reloadGrid');
}

function guardar(){
	
	var ruta = obtenerContexto();
	
	jsonObj = [];
	var parametros = new Object();
	
	parametros.codigoServicio			= $("#codigoServicio").val();
	parametros.codigoServicioDetalle 	= $("#codigoServicioDetalle").val();
	parametros.nombreDetalle 			= $("#nombre").val();
	parametros.importe 					= $("#importe").val();
	parametros.flagImporteVariable 		= $(":input[name=importeVariable]:checked").val();
	parametros.flagGenerarCobro 		= $(":input[name=generarCobro]:checked").val();
	parametros.periodo 					= $("#periodo").val();
	
	//console.log("importeVariable : " + $(":input[name=importeVariable]:checked").val());
	
	$.ajax({
		type: "POST",
	    async:false,
	    url: "grabar-servicio.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	        
	        if(result.camposObligatorios.length == 0){
                
	        	imagen = "";
	        	if(result.codigoRetorno == "00"){
            		$('#servicio_modal').modal('hide');
            		imagen = "ok";
            		
            		$("#codigoServicio").val(0);
    	        	$("#codigoServicioDetalle").val(0);
    	        	$("#nombre").val("");
    	        	$("#importe").val("");
    	        	
    	        	colorEtiquetas();
    	        	cargarServicios();
    	        	
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
	            
			}else{
                	
            	$.each(result.camposObligatorios, function(id, obj){
                        
                	$("#" + obj.nombreCampo).css("color", "red");
                    $("#" + obj.nombreCampo + "-img").show();
                    $("#" + obj.nombreCampo + "-img").prop("data-content", obj.descripcion);
                        
				});
                	
			}
                
		}
	});

}

function mostrarIreport(){
	var url  = "/sigamm/iFacturacionDiario";
	window.open(url,"_blank", "menubar=no,location=0,height=500,width=800");
}

function cambiarImporte(){
	importeVariable = $(":input[name=importeVariable]:checked").val();
	if(importeVariable == 1){
		$("#importe").val(0);
		$("#importe").prop("disabled", true);
	}else{
		$("#importe").val("");
		$("#importe").prop("disabled", false);
	}
}

function ocultarFecha(){
	generarCobro = $(":input[name=generarCobro]:checked").val();
	if(generarCobro == 1){
		$("#opcionPeriodo").show();
		$("#opcionImporte").hide();
		$("#importeVariableNo").prop("checked", true);
		$("#importeVariableSi").prop("disabled", true);
		$("#importe").val("");
		$("#importe").prop("disabled", false);
	}else{
		$("#opcionPeriodo").hide();
		$("#opcionImporte").show();
		$("#importeVariableSi").prop("disabled", false);
		$("#importeVariableNo").prop("checked", true);
		$("#importe").val("");
	}
	$("#periodo").val("");
}

</script>
</head>
<body id="body">
<input type="hidden" id="codigoServicio">
<input type="hidden" id="codigoServicioDetalle">
<table border="0" width="100%">
	<tr>
		<td colspan="6">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="6">&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" onclick="nuevoServicioDetalle();">
				<img src="recursos/images/icons/nuevo_16x16.png" alt="Nuevo Servicio" />&nbsp;Nuevo
			</button>
		</td>
	</tr>
	<tr>
		<td colspan="6">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="6">
			<table id="grilla"></table>
			<div id="pgrilla"></div>
		</td>
	</tr>
	<tr>
		<td colspan="6">&nbsp;</td>
	</tr>
</table>

<div class="modal fade" id="servicio_modal" role="dialog" data-keyboard="false" data-backdrop="static">
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
							<td><span id="lblcodigo"><b>Código</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><div id="codigo"></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblnombre"><b>Nombre (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="nombre" class="form-control" maxlength="150"/></td>
							<td valign="top"><img id="lblnombre-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblGenerarCobro"><b>Generar cobro por unica vez</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td>
								<input type="radio" name="generarCobro" id="generarCobroSi" value="1" onclick="ocultarFecha();">&nbsp;Si&nbsp;&nbsp;
  								<input type="radio" name="generarCobro" id="generarCobroNo" value="0" checked="checked" onclick="ocultarFecha();">&nbsp;No
							</td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr id="opcionPeriodo" style="display:none; ">
							<td width="10px">&nbsp;</td>
							<td><span id="lblperiodo"><b>Periodo (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="periodo" class="form-control" maxlength="8" style="width: 180px" readonly /></td>
							<td valign="top"><img id="lblperiodo-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr id="opcionImporte">
							<td width="10px">&nbsp;</td>
							<td><span id="lblimporteVariable"><b>Importe variable</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td>
								<input type="radio" name="importeVariable" id="importeVariableSi" value="1" onclick="cambiarImporte();">&nbsp;Si&nbsp;&nbsp;
  								<input type="radio" name="importeVariable" id="importeVariableNo" value="0" checked="checked" onclick="cambiarImporte();">&nbsp;No
							</td>
							<td valign="top"><img id="lblimporteVariable-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblimporte"><b>Importe (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="importe" class="form-control" maxlength="8" style="width: 80px"/></td>
							<td valign="top"><img id="lblimporte-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
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
				<h4 class="modal-title">Eliminar Servicios</h4>
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