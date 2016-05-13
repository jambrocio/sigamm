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
			opciones += rowObject.codigoPuesto + ",'";
			opciones += rowObject.nroPuesto + "',";
			opciones += rowObject.codigoUsuario  + ",";
			opciones += rowObject.codigoGiro + ",'";
			opciones += rowObject.dni + "','";
			opciones += nombreGiro + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Conceptos'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:eliminarConcepto(";
			opciones += rowObject.codigoPuesto + ",'";
			opciones += nombre + "','";
			opciones += rowObject.nroPuesto + "') >";
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
		colNames : ['CODIGO', 'DESCRIPCION', 'ESTADO', 'CONCEPTO', 'OPCIONES'],
		colModel : [{
			name : 'codigoConcepto',
			index: 'codigoConcepto',
			sortable:false,
			width: 90,
			align: 'center'
		},{
			name : 'nombreConcepto',
			index: 'nombreConcepto',
			sortable:false,
			width: 100,
			align: 'left'
		},{
			name : 'estado',
			index: 'estado',
			sortable:false,
			width: 100,
			align: 'left'
		},{
			name : 'concepto',
			index: 'concepto',
			sortable:false,
			width: 150,
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
		sortname : 'codigoConcepto',
		autowidth: true,
		rownumbers: true,
		viewrecords : true,
		sortorder : "codigoConcepto",
		caption : "Conceptos"

	}).trigger('reloadGrid');
}

</script>
</head>
<body id="body">
<table border="0" width="100%">
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td width="150"><b>DESCRIPCION<b/></td>
		<td width="10">:</td>
		<td width="200"><input type="text" id="descripcionBuscara" class="form-control" maxlength="8" /></td>
		<td>&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" onclick="buscarPuesto()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
			</button>&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" onclick="nuevoUsuario()">
				<img src="recursos/images/icons/nuevo_16x16.png" alt="Nuevo" />&nbsp;Nuevo
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
							<td><span id="lbldni"><b>DNI</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="dniBuscar" class="form-control" maxlength="8" /></td>
							<td valign="top">&nbsp;&nbsp;
								<button type="button" class="btn btn-primary" onclick="buscarUsuario()">
									<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
								</button>
							</td>
						</tr>
						<tr>
							<td colspan="7"><hr /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblusuario"><b>Usuario</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="userid" class="form-control" maxlength="20" disabled="disabled"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lbldni"><b>DNI</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="dni" class="form-control" maxlength="8" disabled="disabled"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblapepat"><b>Apellido Paterno</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="apePaterno" class="form-control" maxlength="30" disabled="disabled"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblapemat"><b>Apellido Materno</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="apeMaterno" class="form-control" maxlength="30" disabled="disabled"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblnombres"><b>Nombres</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="nombres" class="form-control" maxlength="40" disabled="disabled"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lbltelefono"><b>Telefono</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="telefono" class="form-control" maxlength="9" disabled="disabled"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lbltelefono"><b>Giro Comercial (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="giroComercial" class="form-control" /></td>
							<td valign="top"><img id="lblgiroComercial-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lbltelefono"><b>Puesto (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="puesto" class="form-control" maxlength="4" /></td>
							<td valign="top"><img id="lblpuesto-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
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