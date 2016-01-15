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
	cargarEgresos();
});

function inicializaValores(){
	$("#codigoEgreso").val('0');
	$("#codigoEmpresa").val('0');
	$("#nro").val('');
	$("#fecha").val('');
	$("#ruc").val('');
	$("#razonSocial").val('');
	$("#descripcion").val('');
	$("#representante").val('');
	$("#cobrado").val('');
	$("#dni").val('');
	$("#area").val('');
	$("#total").val('');
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
	cargarConceptos();
	cargarCategorias();
}

function cargarConceptos(){
	
	var parametros = new Object();
	parametros.rubro = 'E';
	
	$.ajax({
        type: "POST",
        async: false,
        url: "cargar-conceptos.json",
        cache: false,
        data: parametros,
        success: function(result){
        	
        	//alert(result);
        	$('#egreso_modal').modal({
        		backdrop: 'static',
        		keyboard: false,
        		width: '600px'
        	});
        	
        	var optionConceptos = "<option value=0>SELECCIONAR</option>";
        	$.each(result, function(keyM, conceptos) {
        		
        		optionConceptos += "<option value=" + conceptos.codigoConcepto + ">" + conceptos.nombreConcepto + "</option>";
        		
        	});
        	
        	$("#concepto").html(optionConceptos);
    		
        }
    });
	
}


function cargarCategorias(){
	
	var parametros = new Object();
	parametros.rubro = 'C';
	
	$.ajax({
        type: "POST",
        async: false,
        url: "cargar-conceptos.json",
        cache: false,
        data: parametros,
        success: function(result){
        	
        	//alert(result);
        	$('#egreso_modal').modal({
        		backdrop: 'static',
        		keyboard: false,
        		width: '600px'
        	});
        	
        	var optionCategorias = "<option value=0>SELECCIONAR</option>";
        	$.each(result, function(keyM, categorias) {
        		
        		optionCategorias += "<option value=" + categorias.codigoConcepto + ">" + categorias.nombreConcepto + "</option>";
        		
        	});
        	
        	$("#categoria").html(optionCategorias);
    		
        }
    });
	
}


function validarSiNumero(numero){
	
	//if (!/^([0-9])*$/.test(numero)){
	if (!/^([0-9])*[.]?[0-9]*$/.test(numero)){
		return false;	
	}else{
		return true;
	}
	
}

function limpiarrazonSocial(){
	$("#razonSocial").val('');
}
	
function buscaraRuc(){
	var ruta = obtenerContexto();
	
	jsonObj = [];
	var parametros = new Object();
	parametros.codigoEmpresa = $("#codigoEmpresa").val();
	parametros.ruc = $("#ruc").val();
	parametros.rucNuevo = $("#ruc").val();
	
	$.ajax({
		type: "POST",
	    async:false,
	    url: "buscar-ruc.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	    	    	
	    	if (result==''){
	    		mensaje = "El RUC digitado [" + $("#ruc").val() + "] no se encuentra en la Base de Datos, desea insertarlo ?. ";
	    		mensaje += "Se requiere que ingrese la RAZON SOCIAL de la Empresa...";
	    		
	    		$("#mensajeEmpresa").html(mensaje);
	    		$("#rucNuevo").val($("#ruc").val());
	    		
	    		$('#alerta_modal').modal({
	    			backdrop: 'static',
	    			keyboard: false
	    		}).one('click', '#aceptar', function() {

	    		});
		    	
		    } else {
		    	$.each(result, function(keyM, val) {
		    		$("#codigoEmpresa").val(val.codigoEmpresa);
		    		$("#razonSocial").val(val.razonSocial);		    		
		    	});
			}
	    }
	});
	
}

function buscaraEmpresa(codigoEmpresa){
	console.log("Buscar Empresa - [codigoEmpresa] : " + codigoEmpresa );
	jsonObj = [];
	var paramempresa = new Object();
	paramempresa.codigoEmpresa = parseInt(codigoEmpresa);
	
	//alert("Codigo:" + codigoEmpresa);
	
	$.ajax({
		type: "POST",
	    async:false,
	    url: "buscar-ruc.json",
	    cache : false,
	    data: paramempresa,
	    success: function(result){
	    	    	
	    	$.each(result, function(keyM, val) {
	    		$("#codigoEmpresa").val(val.codigoEmpresa);
	    		$("#ruc").val(val.ruc);
	    		$("#razonSocial").val(val.razonSocial);		    		
	    	});

	    }
	});
	
}
	
function guardarEmpresa(){
	
	if ( ($("#rucNuevo").val() == null) || ($("#rucNuevo").val() == "") ){
		alert('No ha digitado el número de RUC, verifique...'); //, 'Mensaje Alerta');
		$("#rucNuevo").focus();
		return false;
	}
	var ruc = $("#rucNuevo").val();
	if ( (ruc.length < 11) ){
		alert('La longitud del número de RUC es menor a 11 dígitos, verifique...'); //, 'Mensaje Alerta');
		$("#rucNuevo").focus();
		return false;
	}
	if ( ($("#razonSocialNueva").val() == null) || ($("#razonSocialNueva").val() == "") ){
		alert('No ha digitado la RAZON SOCIAL, verifique...'); //, 'Mensaje Alerta');
		$("#razonSocialNueva").focus();
		return false;
	}
	
	var ruta = obtenerContexto();
	jsonObj = [];
	var parametros = new Object();
	parametros.rucNuevo = $("#rucNuevo").val();
	parametros.razonSocialNueva = $("#razonSocialNueva").val();
	$.ajax({
		type: "POST",
	    async:false,
	    url: "grabar-empresa.json",
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
            //cargarPuestos();
            $("#rucNuevo").val('');
            $("#razonSocialNueva").val('');
            $("#ruc").focus();
            
		}
	});		

}


function guardar(){
	var ruta = obtenerContexto();
	jsonObj = [];
	var parametros = new Object();
	parametros.codigoEgreso = parseInt( $("#codigoEgreso").val() );
	parametros.codigoEmpresa = parseInt( $("#codigoEmpresa").val() );
	parametros.tipoDocumento = parseInt( $("#concepto").val() );
	parametros.numeroDocumento = $("#nro").val();
	parametros.fecha = $("#fecha").val();
	parametros.ruc = $("#ruc").val();
	parametros.detalle = $("#descripcion").val();
	parametros.tipoCategoria = parseInt( $("#categoria").val() );
	parametros.representante = $("#representante").val();
	parametros.cobrado = $("#cobrado").val();
	parametros.dni = $("#dni").val();
	parametros.area = $("#area").val();
	parametros.total = parseFloat($("#total").val());
	
	$.ajax({
		type: "POST",
	    async:false,
	    url: "grabar-egreso.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	            
	        if(result.camposObligatorios.length == 0){
                	
            	$('#egreso_modal').modal('hide');
            	
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
	            
	            cargarEgresos();
	            
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


function cargarEgresos(){
	
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		var opciones = "<center>";
			
			opciones += "<a href=javascript:editarEgresos(";
			opciones += rowObject.codigoEgreso + "," + rowObject.tipoDocumento + ",'" + rowObject.numeroDocumento + "','" + rowObject.fecha.replace(/\s/g,"_") + "'," + rowObject.codigoEmpresa + ",'" + rowObject.detalle.replace(/\s/g,"_") + "'," + rowObject.tipoCategoria + ",'" + rowObject.representante.replace(/\s/g,"_") + "'," + rowObject.total + ",'" + rowObject.cobrado.replace(/\s/g,"_") + "','" + rowObject.dni + "','" + rowObject.area.replace(/\s/g,"_") + "')>";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Egreso'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:eliminarEgreso(";
			opciones += rowObject.codigoEgreso + ") >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/eliminar_24x24.png' border='0' title='Eliminar Egreso'/>";
			opciones += "</a>";			
			
			opciones += "</center>";
			
		return opciones;
				
	};
	
	jQuery("#grilla").jqGrid(
	{
		url : 'reporte-egreso.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		colNames : ['Codigo', 'Tipo Documento', 'Número Documento', 'Fecha','Empresa','Representante','Total', 'Opciones'],
		colModel : [{
			name : 'codigoEgreso',
			index: 'codigoEgreso',
			sortable:false,
			width: 90,
			align: 'center'
		},{
			name : 'nombreDocumento',
			index: 'nombreDocumento',
			sortable:false,
			width: 150,
			align: 'left'
		},{
			name : 'numeroDocumento',
			index: 'numeroDocumento',
			sortable:false,
			width: 150,
			align: 'left'
		},{
			name : 'fecha',
			index: 'fecha',
			sortable:false,
			width: 100,
			align: 'center'
		},{
			name : 'razonSocial',
			index: 'razonSocial',
			sortable:false,
			width: 250,
			align: 'center'
		},{
			name : 'representante',
			index: 'representante',
			sortable:false,
			width: 350,
			align: 'center'
		},{
			name : 'total',
			index: 'total',
			sortable:false,
			width: 100,
			align: 'center'
		},{					
			name:'codigoEgreso',
			index:'codigoEgreso',
			width:200,
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
		sortorder : "codigoEgreso",				
		caption : "Egreso"
		
	}).trigger('reloadGrid');
}


function editarEgresos(codigoEgreso, tipoDocumento, numeroDocumento, fecha, codigoEmpresa, detalle, tipoCategoria, representante, total, cobrado, dni, area){
	console.log("Editar Egreso - [codigoEgreso] : " + codigoEgreso );
	console.log("Editar Egreso - [codigoEmpresa] : " + codigoEmpresa );
	//alert("Codigo Egreso: " + codigoEgreso + "\n Tipo Documento: " + tipoDocumento + "\n numero Documento: " + numeroDocumento + "\n Fecha: " + fecha + "\n Codigo Empresa: " + codigoEmpresa + "\n Detalle: " + detalle + "\n TipoCategoria: " + tipoCategoria + "\n Representante: " + representante + "\n Total: " + total + "\n Cobrado: " + cobrado + "\n Dni: " + dni + "\n Area: " + area);
	
	$('#egreso_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	cargarConceptos();
	cargarCategorias();
	$("#tituloRegistro").html("Modificar Datos - Egreso");
	colorEtiquetas();
	
	$("#codigoEmpresa").val(codigoEmpresa);
	$('#concepto option[value="' +tipoDocumento+ '"]').attr("selected", "selected");
	$("#nro").val(numeroDocumento);
	$("#fecha").val(fecha.replace(/\_/g," "));
	$("#codigoEgreso").val(codigoEgreso);
	buscaraEmpresa(codigoEmpresa);
	$("#descripcion").val(detalle.replace(/\_/g," "));
	$('#categoria option[value="' +tipoCategoria+ '"]').attr("selected", "selected");
	$("#representante").val(representante.replace(/\_/g," "));
	$("#cobrado").val(cobrado.replace(/\_/g," "));
	$("#dni").val(dni);
	$("#area").val(area.replace(/\_/g," "));
	$("#total").val(total);
}


function eliminarEgreso(codigoEgreso){
	//alert("Recibo a Eliminar " + periodo);
	
	var ruta = obtenerContexto();
	mensaje = "Desea eliminar el egreso cuyo código es  " + codigoEgreso + "... ?"; 
	
	$("#mensajeEliminar").html(mensaje);
	
	$('#alerta_eliminar_modal').modal({
		backdrop: 'static',
		keyboard: false
	}).one('click', '#aceptar', function() {
        
		jsonObj = [];
		var parametros = new Object();
		parametros.codigoEgreso = codigoEgreso;
			
		$.ajax({
			type: "POST",
		    async:false,
		    url: "eliminar-egreso.json",
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
	            
	            cargarEgresos();
		            
			}
		});
		
    });
	
}
</script>
</head>
<body id="body">
<input type="hidden" id="codigoEgreso" />
<input type="hidden" id="codigoEmpresa" />
<table border="0" style="width: 1100px;">
	<tr>
		<td colspan="7" align="right">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="7" align="left">
			<button type="button" class="btn btn-primary" onclick="nuevoEgreso()">
				<img src="recursos/images/icons/nuevo_16x16.png" alt="Nuevo" />&nbsp;Nuevo
			</button>
			&nbsp;
			<!-- button type="button" class="btn btn-primary" onclick="guardar()">
				<img src="recursos/images/icons/guardar_16x16.png" alt="Buscar" />&nbsp;Guardar
			</button>
			&nbsp;
			<button type="button" class="btn btn-primary">
				<img src="recursos/images/icons/reservar2_16x16.png" alt="Reservar" />&nbsp;Reservar
			</button -->
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


<div class="modal fade" id="egreso_modal" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog" style="width: 700px">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"><span id="tituloRegistro" />Nuevo Egreso</h4>
			</div>
			<div class="modal-body">
				
					<table border="0" style="width: 650px;" >
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
							<td><span id="lblconcepto" style="font-size: 11px;"><b>CONCEPTO (*)</b></span></td>
							<td><b>:</b></td>
							<td><select id="concepto" class="form-control"></select></td>
							<td valign="top"><img id="lblconcepto-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
							<td width="12px">&nbsp;</td>
							<td><span id="lblnro" style="font-size: 11px;"><b>NRO (*)</b></span></td>
							<td><b>:</b></td>
							<td><input type="text" id="nro" class="form-control" maxlength="20"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="12px">&nbsp;</td>
							<td><span id="lblfecha" style="font-size: 11px;"><b>FECHA (*)</b></span></td>
							<td><b>:</b></td>
							<td><input type="text" id="fecha" class="form-control" maxlength="20"/></td>
							<td valign="top">&nbsp;</td>
							<td width="12px">&nbsp;</td>
							<td><span id="lblruc" style="font-size: 11px;"><b>RUC (*)</b></span></td>
							<td><b>:</b></td>
							<td><input type="text" id="ruc" class="form-control" maxlength="11" onblur="buscaraRuc();" onchange="limpiarrazonSocial();"/></td>
							<td valign="top">&nbsp;</td>
							<!--  value="20537575531" -->
						</tr>
						<tr>
							<td width="12px">&nbsp;</td>
							<td><span id="lblrazonSocial" style="font-size: 11px;"><b>RAZON SOCIAL (*)</b></span></td>
							<td><b>:</b></td>
							<td colspan="6"><input type="text" id="razonSocial" class="form-control" maxlength="200"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="12px">&nbsp;</td>
							<td><span id="lbldescripcion" style="font-size: 11px;"><b>DESCRIPCION (*)</b></span></td>
							<td><b>:</b></td>
							<td colspan="6"><textarea rows="4" cols="50" id="descripcion" class="form-control" maxlength="4000" style="text-transform: uppercase;"></textarea></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="12px">&nbsp;</td>
							<td><span id="lblcategoria" style="font-size: 11px;"><b>CATEGORIA (*)</b></span></td>
							<td><b>:</b></td>
							<td><select id="categoria" class="form-control"></select></td>
							<td valign="top"><img id="lblcategoria-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
							<td colspan="5" valign="top">&nbsp;</td>
						<tr>
							<td width="12px">&nbsp;</td>
							<td><span id="lblrepresentante" style="font-size: 11px;"><b>REPRESENTANTE (*)</b></span></td>
							<td><b>:</b></td>
							<td colspan="6"><input type="text" id="representante" class="form-control" maxlength="500" style="text-transform: uppercase;"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="12px">&nbsp;</td>
							<td><span id="lblcobrado" style="font-size: 11px;"><b>COBRADO POR</b></span></td>
							<td><b>:</b></td>
							<td colspan="6"><input type="text" id="cobrado" class="form-control" maxlength="500" style="text-transform: uppercase;"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="12px">&nbsp;</td>
							<td><span id="lbldni" style="font-size: 11px;"><b>DNI</b></span></td>
							<td><b>:</b></td>
							<td><input type="text" id="dni" class="form-control" maxlength="8"/></td>
							<td valign="top">&nbsp;</td>
							<td width="12px">&nbsp;</td>
							<td><span id="lblarea" style="font-size: 11px;"><b>AREA</b></span></td>
							<td><b>:</b></td>
							<td><input type="text" id="area" class="form-control" maxlength="50" style="text-transform: uppercase;"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="12px">&nbsp;</td>
							<td><span id="lbltotal" style="font-size: 11px;"><b>TOTAL (*)</b></span></td>
							<td><b>:</b></td>
							<td><input type="text" id="total" class="form-control" maxlength="20"/></td>
							<td valign="top">&nbsp;</td>
							<td width="12px">&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
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


<div class="modal fade" id="alerta_modal" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Guardar Empresa</h4>
			</div>
			<div class="modal-body">
					
				<table border="0">
					<tr>
						<td colspan="3"><img src="recursos/images/icons/exclamation_32x32.png" border="0" />&nbsp;<b><span id="mensajeEmpresa" /></b></td>
					</tr>
					<tr style="height: 30px">&nbsp;</tr>
					<tr>
						<td colspan="3" align="left">
							<button type="button" class="btn btn-primary" onclick="guardarEmpresa(1)">
								<img src="recursos/images/icons/guardar_16x16.png" alt="Buscar" />&nbsp;Guardar
							</button>
						</td>
					</tr>
					<tr style="height: 30px">&nbsp;</tr>
					<tr>
						<td><span id="lblrucNuevo" style="font-size: 11px;"><b>RUC (*)</b></span></td>
						<td><b>:</b></td>
						<td><input type="text" id="rucNuevo" class="form-control" maxlength="11"/></td>
					</tr>	
					<tr>
						<td><span id="lblrazonSocialNueva" style="font-size: 11px;"><b>RAZON SOCIAL (*)</b></span></td>
						<td><b>:</b></td>
						<td><input type="text" id="razonSocialNueva" class="form-control" maxlength="200" style="text-transform: uppercase;" /></td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<!-- button type="button" class="btn btn-default" id="aceptar">Si</button -->
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