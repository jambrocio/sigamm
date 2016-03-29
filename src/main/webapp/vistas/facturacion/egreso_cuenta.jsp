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
</style>

<script>
$(document).ready(function(){	
	
	$('[data-toggle="popover"]').popover({ placement : 'right', trigger: "hover" });
	//jAlert("Actualidad jQuery", "Actualidad jQuery");
	inicializaValores();	
});

function inicializaValores(){
	$("#monto").val('0');
	$("#fecha").val('');
	$("#representante").val('');
	cargarOperacionesBancarias();
	cargarTipoOperacion();
}


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

	$("#fechainicio").datepicker(
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
	
	$("#fechatermino").datepicker(
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
	
	$("#lblrucNuevo").css("color", "black");
	$("#lblrazonSocialNueva").css("color", "black");
	
	$("#lblrucNuevo-img").hide();
	$("#lblrazonSocialNueva-img").hide();
	
}


function nuevoEgreso(){
	
	colorEtiquetas();
 	inicializaValores();
}


function cargarOperacionesBancarias(){
	
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		var opciones = "<center>";
			
			opciones += "<a href=javascript:editarOpeban(";
			opciones += rowObject.id + ")>";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Operaciones Bancarias'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:eliminarOpeban(";
			opciones += rowObject.id + ") >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/eliminar_24x24.png' border='0' title='Eliminar Operaciones Bancarias'/>";
			opciones += "</a>";			
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:anularOpeban(";
			opciones += rowObject.id + ") >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/tacho_24x24.png' border='0' title='Anular Operaciones Bancarias'/>";
			opciones += "</a>";
			
			opciones += "</center>";
			
		return opciones;
				
	};
	
	jQuery("#grilla").jqGrid(
	{
		url : 'reporte-operaciones-bancarias.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		colNames : ['Estado','Tipo Operación', 'Monto', 'Fecha','Responsable', 'Opciones'],
		colModel : [{
			name : 'estado',
			index: 'estado',
			sortable:false,
			width: 90,
			align: 'center'
		},{
			name : 'tipoOperacion',
			index: 'tipoOperacion',
			sortable:true,
			width: 150,
			align: 'center'
		},{
			name : 'monto',
			index: 'monto',
			sortable:false,
			width: 150,
			align: 'center',
			formatter: 'number'
		},{
			name : 'fecha',
			index: 'fecha',
			sortable:false,
			width: 100,
			align: 'center'
		},{
			name : 'responsable',
			index: 'responsable',
			sortable:false,
			width: 380,
			align: 'Left'
		},{					
			name:'id',
			index:'id',
			width: 120,
			sortable:false,
			search: false,
			formatter:formatterBotones
		}],								
		rowNum : 20,
		pager : '#pgrilla',
		sortname : 'id',
		autowidth: true,
		rownumbers: true,
		viewrecords : true,
		sortorder : "id",				
		caption : "Egreso - Operaciones Bancarias",
		formatter : {
		     integer : {thousandsSeparator: ",", defaultValue: '0'},
		     number : {decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2, defaultValue: '0.00'},
		     currency : {decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2, prefix: "", suffix:"", defaultValue: '0.00'}
		},
		afterInsertRow: function(rowId, data, item){
			//alert(rowId + ' - ' + data + ' - ' + item.total);
			if (item.estado == 1){
				$("#grilla").setCell(rowId, 'estado', 'ACEPTADO', { 'color':'green','font-weight':'bold' });
			} else if (item.estado == 2) {
				$("#grilla").setCell(rowId, 'estado', 'ANULADO', { 'color':'red','font-weight':'bold' });
			}

			if (item.tipoOperacion == 'D'){
				$("#grilla").setCell(rowId, 'tipoOperacion', 'DEPOSITO', { 'color':'blue','font-weight':'bold' });
			} else if (item.tipoOperacion == 'R') {
				$("#grilla").setCell(rowId, 'tipoOperacion', 'RETIRO', { 'color':'red','font-weight':'bold' });
			}
		}
		
	}).trigger('reloadGrid');
}

function colorEtiquetas(){
	
	$("#lblrucNuevo").css("color", "black");
	$("#lblrazonSocialNueva").css("color", "black");
	
	$("#lblrucNuevo-img").hide();
	$("#lblrazonSocialNueva-img").hide();
	
}

function nuevaOperacionBancaria(){
	
	colorEtiquetas();
 	inicializaValores();
	cargarCuentasBancarias();
	cargarTipoOperacion();
}


function cargarCuentasBancarias(){
	
	var parametros = new Object();
	
	$.ajax({
        type: "POST",
        async: false,
        url: "cargar-cuentas-bancarias.json",
        cache: false,
        data: parametros,
        success: function(result){
        	
        	//alert(result);
        	$('#operaciones_bancarias_modal').modal({
        		backdrop: 'static',
        		keyboard: false,
        		width: '600px'
        	});
        	
        	var optionCuentasBancarias = "<option value=0>SELECCIONAR</option>";
        	$.each(result, function(keyM, cuentas) {
        		
        		optionCuentasBancarias += "<option value=" + cuentas.id + ">" + cuentas.numeroCuenta + "</option>";
        		
        	});
        	
        	$("#cuentas").html(optionCuentasBancarias);
    		
        }
    });
	
}

function cargarTipoOperacion(){
	
	var optionTipoOperacion = "<option value=0>SELECCIONAR</option>";
	optionTipoOperacion += "<option value=D>DEPOSITO</option>";
	optionTipoOperacion += "<option value=R>RETIRO</option>";
			
	$("#tipooperacion").html(optionTipoOperacion);
	
}

function guardar(){
	var ruta = obtenerContexto();
	jsonObj = [];
	var parametros = new Object();
	parametros.tipoOperacion = $("#tipooperacion").val();
	parametros.monto = $("#monto").val();
	parametros.fecha = $("#fecha").val();
	parametros.responsable = $("#representante").val();
	parametros.interes = $("#interes").val();
	
	$.ajax({
		type: "POST",
	    async:false,
	    url: "grabar-operacion-bancaria.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	            
	        if(result.camposObligatorios.length == 0){
                	
            	$('#operaciones_bancarias_modal').modal('hide');
            	
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
	            
	            cargarOperacionesBancarias();
	            
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
<body id="body">
<input type="hidden" id="id" />
<table border="0" style="width: 1100px;">
	<tr>
		<td colspan="7" align="right">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="7" align="left">
			<button type="button" class="btn btn-primary" onclick="nuevaOperacionBancaria()">
				<img src="recursos/images/icons/nuevo_16x16.png" alt="Nuevo" />&nbsp;Nuevo
			</button>
			<button type="button" class="btn btn-primary">
				<img src="recursos/images/icons/excel_16x16.png" alt="Exportar a Excel" />&nbsp;<a href="/sigamm/reporteOpebanExcel" style="color:white">Exportar</a>
			</button>
		</td>
	</tr>
	<tr>
		<td colspan="7" align="right">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="7">
			<table id="grilla"></table>
			<div id="pgrilla"></div>
		</td>
	</tr>
</table>	


<div class="modal fade" id="operaciones_bancarias_modal" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog" style="width: 750px">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"><span id="tituloRegistro" />Nueva Operación Bancaria</h4>
			</div>
			<div class="modal-body">
				
					<table border="0" style="width: 700px;" >
						<tr>
							<td colspan="10" align="right">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="10" align="left">
								<button type="button" class="btn btn-primary" onclick="guardar(1)">
									<img src="recursos/images/icons/guardar_16x16.png" alt="Buscar" />&nbsp;Guardar
								</button>
							</td>
						</tr>
						<tr>
							<td colspan="10"><hr /></td>
						</tr>
						<tr>
							<td width="12px">&nbsp;</td>
							<td><span id="lblcuentas" style="font-size: 11px;"><b>CUENTAS (*)</b></span></td>
							<td><b>:</b></td>
							<td><select id="cuentas" class="form-control"></select></td>
							<td valign="top"><img id="lblcuentas-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
							<td width="12px">&nbsp;</td>
							<td><span id="lbltipooperacion" style="font-size: 11px;"><b>TIPO OPERACIÓN (*)</b></span></td>
							<td><b>:</b></td>
							<td><select id="tipooperacion" class="form-control"></select></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="12px">&nbsp;</td>
							<td><span id="lblmonto" style="font-size: 11px;"><b>MONTO (*)</b></span></td>
							<td><b>:</b></td>
							<td><input type="text" id="monto" class="form-control" maxlength="20"/></td>
							<td>&nbsp;</td>
							<td width="12px">&nbsp;</td>
							<td><span id="lblfecha" style="font-size: 11px;"><b>FECHA (*)</b></span></td>
							<td><b>:</b></td>
							<td><input type="text" id="fecha" class="form-control" maxlength="20"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="12px">&nbsp;</td>
							<td><span id="lblrepresentante" style="font-size: 11px;"><b>REPRESENTANTE (*)</b></span></td>
							<td><b>:</b></td>
							<td colspan="7"><input type="text" id="representante" class="form-control" maxlength="200" style="text-transform: uppercase;"/></td>
						</tr>
						<tr>
							<td width="12px">&nbsp;</td>
							<td colspan="9" style="font-size: 11px;"><b>(*) Campos Obligatorios</b></td>
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