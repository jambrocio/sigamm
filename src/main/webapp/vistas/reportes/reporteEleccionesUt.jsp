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
</style>
<script>
$(document).ready(function() 
{
   	cargarUt();
	cargarRegistros();
    
});

function cargarUt(){
	
	$.ajax({
        type: "GET",
        async:false,
        url: "listar-ut.json",
        cache : false,
        success: function(result){
            
        	selectUt = "<option value=0>SELECCIONAR</option>";
    		$.each(result.rows, function(key,val) {
    			selectUt += "<option value=" + val.codigoUt + ">" + val.nombreUt + "</option>";
    		});
    		
    		$("#unidadTerritorial").html(selectUt);
            
        }
    });
        	
}

function buscarUnidad(){
	
	var parametros=new Object();
	parametros.codigoEleccion = 1;
	parametros.codigoUt = $("#unidadTerritorial").val();

	$("#grilla").jqGrid('setGridParam',
	{
		url : 'listar-elecciones-ut.json',
		datatype : "json",
		postData:parametros,
		page:1
	}).trigger('reloadGrid');
}

function cargarRegistros(){
	
	var ruta = obtenerContexto();
	var parametros=new Object();
	parametros.codigoEleccion = 1;
	parametros.codigoUt = $("#unidadTerritorial").val();
	
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		voto = rowObject.voto;
		
		var opciones = "<center>";
		
		if(voto == 1){
			opciones += "<img src='/"+ruta+"/recursos/images/icons/check_16x16.png' border='0' title=''/>";
		}else{
		opciones += "<img src='/"+ruta+"/recursos/images/icons/nuevo_16x16.png' border='0' title=''/>";
		}
		
		opciones += "</center>";
			
		return opciones;
				
	};
	
	jQuery("#grilla").jqGrid(
	{
		url : "listar-elecciones-ut.json",
		postData:parametros,
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		colNames : ['Usuario', 'DNI', 'Nombres', 'Unidad Territorial', 'Cargo', 'Voto'],
		colModel : [{
			name : 'usuario',
			index: 'usuario',
			sortable:true,
			width: 80,
			align: 'left'						
		},{
			name : 'dni',
			index: 'dni',
			sortable:true,
			width: 100,
			align: 'center'
		},{
			name : 'nombres',
			index: 'nombres',
			sortable:true,
			width: 80,
			align: 'left'
		},{
			name : 'nombreUt',
			index: 'nombreUt',
			sortable:true,
			width: 80,
			align: 'left'
		},{
			name : 'nombreRol',
			index: 'nombreRol',
			sortable:true,
			width: 80,
			align: 'left'
		},{
			name : 'voto',
			index: 'voto',
			width: 80,
			align: 'right',
			sortable:false,
			search: false,
			formatter:formatterBotones
		}],								
		rowNum : 30,
		pager : '#pgrilla',
		sortname : 'id',
		autowidth: true,
		rownumbers: true,
		viewrecords : true,
		sortorder : "dni",				
		caption : "Elecciones por Unidad Territorial"
		
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
		<td width="150"><b>Unidad Territorial<b/></td>
		<td width="10">:</td>
		<td width="200"><select id="unidadTerritorial" class="form-control" /></td>
		<td>&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" onclick="buscarUnidad()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
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
</body>
</html>