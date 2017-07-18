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
	
	$("#fechaVencimiento").datepicker({   
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
	
	cargarProcesos();
	
});

function eliminarServicioDetalle(codigoProcesamiento){
	
	var ruta = obtenerContexto();
	mensaje = "Desea eliminar el servicio con codigo : " + codigoProcesamiento + " ?"; 
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
    	        	cargarProcesos();
    	        	
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

function cargarProcesos(){
	
	var ruta = obtenerContexto();
	var formatterCuota = function(cellVal,options,rowObject){	
		codigoProcesamiento = rowObject.codigoProcesamiento;
		flagCuota = rowObject.flagCuotaAdministrativa;
		periodo = rowObject.periodo;
		descPeriodo = replaceAll(rowObject.descripcionPeriodo, " ", "#");
		var opciones = "<center>";
			if(flagCuota == 1){
				opciones += "<img src='/"+ruta+"/recursos/images/icons/check_16x16.png' border='0' title='Cuota Administrativa procesada'/>";
			}else{
				opciones += "<a href=\"javascript:procesarCuotaAdministrativa('" + periodo + "', '" + descPeriodo + "'); \">";
				opciones += "<img src='/"+ruta+"/recursos/images/icons/procesar_24x24.png' border='0' title='Procesar Cuota Administrativa'/>";
				opciones += "</a>";
			}
			
		opciones += "</center>";
		
		return opciones;
				
	};
	
	var formatterVigilancia = function(cellVal,options,rowObject){	
		codigoProcesamiento = rowObject.codigoProcesamiento;
		flagVigilancia = rowObject.flagVigilancia;
		periodo = rowObject.periodo;
		descPeriodo = replaceAll(rowObject.descripcionPeriodo, " ", "#");
		var opciones = "<center>";
			if(flagVigilancia == 1){
				opciones += "<img src='/"+ruta+"/recursos/images/icons/check_16x16.png' border='0' title='Vigilancia procesada'/>";
			}else{
				opciones += "<a href=\"javascript:procesarVigilancia('" + periodo + "', '" + descPeriodo + "'); \">";
				opciones += "<img src='/"+ruta+"/recursos/images/icons/procesar_24x24.png' border='0' title='Procesar Vigilancia'/>";
				opciones += "</a>";
			}
			
		opciones += "</center>";
		
		return opciones;
				
	};
	
	var formatterImpresion = function(cellVal,options,rowObject){	
		codigoProcesamiento = rowObject.codigoProcesamiento;
		flagVigilancia = rowObject.flagVigilancia;
		periodo = rowObject.periodo;
		descPeriodo = replaceAll(rowObject.descripcionPeriodo, " ", "#");
		var opciones = "<center>";
			if(flagVigilancia == 0){
				opciones += "<img src='/"+ruta+"/recursos/images/icons/stop_16x16.png' border='0' title='Impresión pendiente'/>";
			}else{
				opciones += "<a href=\"generarImpresionVigilanciaPDF?periodo=" + periodo + "\">";
				opciones += "<img src='/"+ruta+"/recursos/images/icons/print_24x24.png' border='0' title='Procesar Impresión'/>";
				opciones += "</a>";
			}
			
		opciones += "</center>";
		
		return opciones;
				
	};
	
	var formatterBotones = function(cellVal,options,rowObject){	
		codigoProcesamiento = rowObject.codigoProcesamiento;
		var opciones = "<center>";
			
			opciones += "<a href=\"javascript:eliminarProcesamiento(" + codigoProcesamiento + "); \">";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/eliminar_24x24.png' border='0' title='Eliminar Proceso'/>";
			opciones += "</a>";
			
		opciones += "</center>";
		
		//console.log(opciones);
			
		return opciones;
				
	};
	
	jQuery("#grilla").jqGrid(
	{
		url : 'reporte-procesos.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		colNames : ['Código', 'Periodo', 'Fec.Vencimiento', 'Cuota Administrativa', 'Vigilancia', 'Impresión', 'Opciones'],
		colModel : [{
			name : 'codigoProcesamiento',
			index: 'codigoProcesamiento',
			sortable:true,
			width: 50,
			align: 'right'						
		},{
			name : 'descripcionPeriodo',
			index: 'descripcionPeriodo',
			sortable:true,
			width: 300,
			align: 'left'						
		},{
			name : 'fechaVencimiento',
			index: 'fechaVencimiento',
			sortable:false,
			width: 100,
			align: 'center'
		},{					
			name:'flagCuotaAdministrativa',
			index:'flagCuotaAdministrativa',
			width:100,
			sortable:false,
			search: false,
			formatter:formatterCuota
		},{					
			name:'flagVigilancia',
			index:'flagVigilancia',
			width:100,
			sortable:false,
			search: false,
			formatter:formatterVigilancia
		},{					
			name:'flagImpresion',
			index:'flagImpresion',
			width:100,
			sortable:false,
			search: false,
			formatter:formatterImpresion
		},{					
			name:'codigoProcesamiento',
			index:'codigoProcesamiento',
			width:100,
			sortable:false,
			search: false,
			formatter:formatterBotones
		}],								
		rowNum : 20,
		//rowList : [ 20, 30, 40 ],
		pager : '#pgrilla',
		sortname : 'periodo',
		autowidth: true,
		rownumbers: true,
		viewrecords : true
		
	}).trigger('reloadGrid');
}

function procesarCuotaAdministrativa(periodo, descPeriodo){
	
	var ruta = obtenerContexto();
	descPeriodo = replaceAll(descPeriodo, "#", " ");
	mensaje = "Desea procesar la cuota administrativa del mes de " + descPeriodo + " ?"; 
	
	$("#mensajeProcesar").html(mensaje);
	$('#alerta_modal').modal({
		backdrop: 'static',
		keyboard: false
	}).one('click', '#aceptar', function() {
		
		jsonObj = [];
		var parametros = new Object();
		parametros.periodo = periodo;
					
		$.ajax({
			type: "POST",
		    async:false,
		    url: "procesar-cuota-administrativa.json",
		    cache : false,
		    data: parametros,
		    success: function(result){
		            
		        imagen = "";
		        if(result.indicador == "00"){
		        	$('#alerta_modal').modal('hide');
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
		            
	            cargarProcesos();
		            
			}
		});
		
    });
}

function procesarVigilancia(periodo, descPeriodo){
	
	var ruta = obtenerContexto();
	descPeriodo = replaceAll(descPeriodo, "#", " ");
	mensaje = "Desea procesar la vigilancia del mes de " + descPeriodo + " ?"; 
	
	$("#mensajeProcesar").html(mensaje);
	$('#alerta_modal').modal({
		backdrop: 'static',
		keyboard: false
	}).one('click', '#aceptar', function() {
		
		jsonObj = [];
		var parametros = new Object();
		parametros.periodo = periodo;
					
		$.ajax({
			type: "POST",
		    async:false,
		    url: "procesar-vigilancia.json",
		    cache : false,
		    data: parametros,
		    success: function(result){
		            
		        imagen = "";
		        if(result.indicador == "00"){
		        	$('#alerta_modal').modal('hide');
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
		            
	            cargarProcesos();
		            
			}
		});
		
    });
}

function nuevoProceso(){
	
	$('#proceso_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#periodo").val("");
	$("#fechaVencimiento").val("");
	$("#tituloRegistro").html("Nuevo Registro");
	
	colorEtiquetas();
}

function colorEtiquetas(){
	
	$("#lblperiodo").css("color", "black");
	$("#lblfechavencimiento").css("color", "black");
	
	$("#lblperiodo-img").hide();
	$("#lblfechavencimiento-img").hide();

}

function grabarProceso(){
	
	var ruta = obtenerContexto();
	jsonObj = [];
	var parametros = new Object();
	parametros.periodo = $("#periodo").val();
	parametros.fechaVencimiento = $("#fechaVencimiento").val();
	
	$.ajax({
		type: "POST",
	    async:false,
	    url: "grabar-proceso.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	            
	        imagen = "";
	        if(result.camposObligatorios.length == 0){
		        if(result.indicador == "00"){
		        	$('#proceso_modal').modal('hide');
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
		            
	            cargarProcesos();
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

function eliminarProcesamiento(codigoProcesamiento) {
	
	var ruta = obtenerContexto();
	mensaje = "Desea eliminar el registro cuyo código es  " + codigoProcesamiento + "... ?"; 
	
	$("#mensajeEliminar").html(mensaje);
	
	$('#alerta_eliminar_modal').modal({
		backdrop: 'static',
		keyboard: false
	}).one('click', '#aceptar', function() {
        
		jsonObj = [];
		var parametros = new Object();
		parametros.codigoProcesamiento = codigoProcesamiento;
			
		$.ajax({
			type: "POST",
		    async:false,
		    url: "eliminar-procesamiento.json",
		    cache : false,
		    data: parametros,
		    success: function(result){
		            
		        $('#alerta_eliminar_modal').modal('hide');
	            	
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
	            
	            cargarProcesos();
		            
			}
		});
		
    });
	
}


</script>
</head>
<body id="body">
<table border="0" width="100%">
	<tr>
		<td colspan="6">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="6">&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" onclick="nuevoProceso();">
				<img src="recursos/images/icons/nuevo_16x16.png" alt="Nuevo Proceso" />&nbsp;Nuevo
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

<div class="modal fade" id="proceso_modal" role="dialog" data-keyboard="false" data-backdrop="static">
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
								<button type="button" class="btn btn-primary" onclick="grabarProceso()">
									<img src="recursos/images/icons/guardar_16x16.png" alt="Guardar" />&nbsp;Guardar
								</button>
							</td>
						</tr>
						<tr>
							<td colspan="7" align="right">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblperiodo"><b>Periodo (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="periodo" class="form-control" maxlength="10" readonly="readonly" /></td>
							<td valign="top"><img id="lblperiodo-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
							
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblfechavencimiento"><b>Fecha Vencimiento (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="fechaVencimiento" class="form-control" maxlength="10" readonly="readonly" /></td>
							<td valign="top"><img id="lblfechavencimiento-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
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
				<h4 class="modal-title">Procesar Información</h4>
			</div>
			<div class="modal-body">
					
				<table border="0">
					<tr>
						<td><img src="recursos/images/icons/exclamation_32x32.png" border="0" />&nbsp;<b><span id="mensajeProcesar" /></b></td>
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


<div class="modal fade" id="alerta_eliminar_modal" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Eliminar Egreso</h4>
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