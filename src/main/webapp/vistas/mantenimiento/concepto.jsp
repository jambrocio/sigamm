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
	$('#codigoConcepto').val(0);	
	cargarConceptos();
	
});

function colorEtiquetas(){
	
	$("#lblpuesto").css("color", "black");
	$("#lblgiroComercial").css("color", "black");
	
	$("#lblpuesto-img").hide();
	$("#lblgiroComercial-img").hide();
	
}

function cargarConceptos(){
	
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		nombreGiro = replaceAll(rowObject.nombreGiro, " ", "#");
		nombre = replaceAll(nombreFull, " ", "#");
		var opciones = "<center>";
			
			opciones += "<a href=javascript:editarConcepto(";
			opciones += rowObject.codigoConcepto + ",'";
			opciones += rowObject.nombreConcepto.replace(/\s/g,"_") + "','";
			opciones += rowObject.rubro + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Conceptos'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:eliminarConcepto(";
			opciones += rowObject.codigoConcepto + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/eliminar_24x24.png' border='0' title='Eliminar Conceptos'/>";
			opciones += "</a>";
			
			opciones += "</center>";
			
		return opciones;
				
	};
	
	jQuery("#grilla").jqGrid(
	{
		url : 'reporte-conceptos.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		//colNames : ['CODIGO', 'DESCRIPCION', 'ESTADO', 'CONCEPTO', 'OPCIONES'],
		colNames : ['DESCRIPCION', 'ESTADO', 'CONCEPTO', 'OPCIONES'],
		colModel : [/*{
			name : 'codigoConcepto',
			index: 'codigoConcepto',
			sortable:false,
			width: 90,
			align: 'center'
		},*/{
			name : 'nombreConcepto',
			index: 'nombreConcepto',
			sortable:false,
			width: 150,
			align: 'left'
		},{
			name : 'estado',
			index: 'estado',
			sortable:false,
			width: 50,
			align: 'center'
		},{
			name : 'rubro',
			index: 'rubro',
			sortable:false,
			width: 100,
			align: 'center'
		},{					
			name:'codigoConcepto',
			index:'codigoConcepto',
			width:100,
			sortable:false,
			search: false,
			formatter:formatterBotones
		}],								
		rowNum : 20,
		pager : '#pgrilla',
		sortname : 'nombreConcepto',
		autowidth: true,
		rownumbers: true,
		viewrecords : true,
		sortorder : "nombreConcepto",
		caption : "Conceptos / Categorías",
		afterInsertRow: function(rowId, data, item){
			//alert(rowId + ' - ' + data + ' - ' + item.estado);
			if ( (item.estado == 1) ) 
				$("#grilla").setCell(rowId, 'estado', 'ACTIVO', '');
			else
				$("#grilla").setCell(rowId, 'estado', 'INACTIVO', '');
			
			if ( (item.rubro == "C") )
				$("#grilla").setCell(rowId, 'rubro', 'CATEGORÍA EGRESO', '');
			else if ( (item.rubro == "E") )
				$("#grilla").setCell(rowId, 'rubro', 'TIPO DOCUMENTO', '');
		}

	}).trigger('reloadGrid');
}

function colorEtiquetas(){
	
	$("#lblnombreConcepto").css("color", "black");
	$("#lblrubro").css("color", "black");
	
	$("#lblnombreConcepto-img").hide();
	$("#lblrubro-img").hide();
	
}

function cargarNuevo(){
	
	$("#tituloRegistro").html("Nuevo Concepto / Categoría");
	
	colorEtiquetas();
	
	$("#nombreConcepto").val('');
	$("#rubro").val('');
}


function guardar(){
	var ruta = obtenerContexto();
	jsonObj = [];
	var parametros = new Object();
	parametros.codigoConcepto = $("#codigoConcepto").val();
	parametros.nombreConcepto = $("#nombreConcepto").val();
	parametros.rubro = $("#rubro").val();

	
	$.ajax({
		type: "POST",
	    async:false,
	    url: "grabar-concepto.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	            
	        if(result.camposObligatorios.length == 0){
                	
            	$('#concepto_modal').modal('hide');
            	
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
	            
	            cargarConceptos();
	            
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


function editarConcepto(codigoConcepto, nombreConcepto, rubro){

	$('#concepto_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Modificar Concepto / Categoría");
	colorEtiquetas();
	
	$("#codigoConcepto").val(parseInt(codigoConcepto));
	$("#nombreConcepto").val(nombreConcepto.replace(/\_/g," "));
	$('#rubro option[value="' +rubro+ '"]').attr("selected", "selected");
}

</script>
</head>
<body id="body">
<input type="hidden" id="codigoConcepto" />
<table border="0" width="100%">
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td width="150"><b>DESCRIPCION<b/></td>
		<td width="10">:</td>
		<td width="200"><input type="text" id="descripcionBuscara" class="form-control" maxlength="8" /></td>
		<td>&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" onclick="buscar()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
			</button>&nbsp;&nbsp;
			<button class="btn btn-primary" data-toggle="modal" data-target="#concepto_modal" onclick="cargarNuevo()">
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

<div class="modal fade" id="concepto_modal" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"><span id="tituloRegistro" /></h4>
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
							<td colspan="7" align="right">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblnombreConcepto"><b>Nombre Concepto (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="nombreConcepto" class="form-control" maxlength="200" style="text-transform: uppercase;"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblrubro"><b>Rubro (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td>
								<select id="rubro" class="form-control">
									<option value=0 selected="selected">SELECCIONAR</option>
									<option value='C'>CATEGORÍA EGRESO</option>
									<option value='E'>TIPO DOCUMENTO</option>
								</select>
							</td>
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
				<h4 class="modal-title">Eliminar Concepto</h4>
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