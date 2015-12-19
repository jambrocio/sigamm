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

</style>
<script>
$(document).ready(function(){
	
	cargarNuevo();
	cargarReciboAgua();
	
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
			opciones += rowObject.codigoRecibo + ",'" + rowObject.periodo.replace(' ','_') + "','" + rowObject.lecturaInicial + "','" + rowObject.lecturaFinal + "','" + rowObject.monto + "') >";
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
		colNames : ['Codigo Recibo', 'Periodo', 'Lectura Inicial', 'Lectura Final','Monto','Opciones'],
		colModel : [{
			name : 'codigoRecibo',
			index: 'codigoRecibo',
			sortable:false,
			width: 50,
			align: 'center'
		},{
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
			width:80,
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

function editarReciboAgua(codigoRecibo, periodo, lecturaInicial, lecturaFinal, monto){
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


function cargarReciboAguaSocio(codigoRecibo){
	
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		var opciones = "<center>";
			
			opciones += "<a href=javascript:editarReciboAguaXSocio('";
			opciones += rowObject.codigoReciboAgua + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Recibo Agua Socio'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:generarReciboAguaXSocio('";
			opciones += rowObject.codigoReciboAgua + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/agregar2_24x24.png' border='0' title='Crear Recibo de Agua por Socio'/>";
			opciones += "</a>";			

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
		colNames : ['Recibo', 'Sector', 'Nombre Usuario', 'Puesto', 'Giro','Recibo Luz','Total', 'Opciones'],
		colModel : [{
			name : 'codigoReciboOriginal',
			index: 'codigoReciboOriginal',
			sortable:false,
			width: 50,
			align: 'center'
		},{
			name : 'codigoSector',
			index: 'codigoSector',
			sortable:false,
			width: 70,
			align: 'center'
		},{
			name : 'nombreFull',
			index: 'nombreFull',
			sortable:false,
			width: 140,
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
			name : 'reciboLuzCreado',
			index: 'reciboLuzCreado',
			sortable:false,
			width: 80,
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
			if (item.reciboLuzCreado == 0)
				$("#grillaReciboLuz").setCell(rowId, 'reciboLuzCreado', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });				
			else
				$("#grillaReciboLuz").setCell(rowId, 'reciboLuzCreado', '', { 'background-color':'#A9F5A9','color':'white','font-weight':'bold' });

		}


	}).trigger('reloadGrid');
}

</script>
</head>
<body id="body">
<input type="hidden" id="codigorecibo" />
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


<!-- Ventana Modal para Recibo Agua Socios -->
<div class="modal fade" id="recibos_agua_socios_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 800px">
		<div class="modal-content">
		
		<div class="modal-header modal-header-primary">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title">Listado de Recibos de Agua de Socios</h4>
		</div>

		<div class="modal-body">
		
			<table border="0" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="4" style="color:red"><b>&nbsp;RECIBO DE AGUA ORIGINAL NRO. <span id="nroRecibo"></span></b></td>
				</tr>
				<tr>
					<td width="150"><b>RECIBO AGUA SOCIOS<b/></td>
					<td width="10">:</td>
					<td width="250"><input type="text" id="reciboLuzSocioBuscara" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
					<td>&nbsp;&nbsp;
						<button type="button" class="btn btn-primary" onclick="cargarReciboLuzSocio()">
							<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
						</button>&nbsp;&nbsp;
					</td>
				</tr>
				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="4">
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

</body>
</html>
