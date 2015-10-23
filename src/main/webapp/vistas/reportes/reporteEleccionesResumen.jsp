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
   
    cargarRegistros();
    
});

function cargarRegistros(){
	
	var ruta = obtenerContexto();
	jQuery("#grilla").jqGrid(
	{
		url : 'listar-resumen-elecciones.json',
		//postData: {"codigoBuscar":codigoBuscar,"descripcionBuscar":descripcionBuscar},
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		colNames : ['Nro.', 'Unidad Territorial', 'Personal', 'Votos', 'Votos Blanco', 'Finalizados', 'Pendientes', '% Avance'],
		colModel : [{
			name : 'codigoUt',
			index: 'codigoUt',
			sortable:true,
			width: 80,
			align: 'right'						
		},{
			name : 'nombreUt',
			index: 'nombreUt',
			sortable:true,
			width: 100,
			align: 'left'
		},{
			name : 'cantidadPersonal',
			index: 'cantidadPersonal',
			sortable:true,
			width: 80,
			align: 'right'
		},{
			name : 'cantidadVotos',
			index: 'cantidadVotos',
			sortable:true,
			width: 80,
			align: 'right'
		},{
			name : 'cantidadVotosBlanco',
			index: 'cantidadVotosBlanco',
			sortable:true,
			width: 80,
			align: 'right'
		},{
			name : 'cantidadFinalizados',
			index: 'cantidadFinalizados',
			sortable:true,
			width: 80,
			align: 'right'
		},{
			name : 'cantidadPendientes',
			index: 'cantidadPendientes',
			sortable:true,
			width: 80,
			align: 'right'
		},{
			name : 'porcentajeAvance',
			index: 'porcentajeAvance',
			sortable:true,
			width: 80,
			align: 'right'
		}],								
		rowNum : 30,
		pager : '#pgrilla',
		sortname : 'id',
		autowidth: true,
		rownumbers: true,
		viewrecords : true,
		sortorder : "dni",				
		caption : "Avance de Elecciones por Unidad Territorial",
		footerrow: true,
        loadComplete: function () {
        	 
        	var $grid = $('#grilla');
            var cantPersonal = $grid.jqGrid('getCol', 'cantidadPersonal', false, 'sum');
            var cantVotos = $grid.jqGrid('getCol', 'cantidadVotos', false, 'sum');
            var cantVotosBlancos = $grid.jqGrid('getCol', 'cantidadVotosBlanco', false, 'sum');
            
            var cantFinalizados = $grid.jqGrid('getCol', 'cantidadFinalizados', false, 'sum');
            var cantPendientes = $grid.jqGrid('getCol', 'cantidadPendientes', false, 'sum');
            var porcentaje = ((cantFinalizados * 100) / cantPersonal);
            porcentaje = porcentaje.toFixed(2);
            	
			$grid.jqGrid('footerData','set', {nombreUt: '<b>TOTAL</b>', 
				cantidadPersonal: '<b>' + cantPersonal + '</b>', 
				cantidadVotos: '<b>' + cantVotos + '</b>', 
				cantidadVotosBlanco: '<b>' + cantVotosBlancos + '</b>',
				cantidadFinalizados: '<b>' + cantFinalizados + '</b>',
				cantidadPendientes: '<b>' + cantPendientes + '</b>',
				porcentajeAvance: '<b>' + porcentaje + ' %</b>'
			});
		}
		
	}).trigger('reloadGrid');
}

</script>
</head>
<body id="body">
	
<table border="0" width="100%">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
			<table id="grilla"></table>
			<div id="pgrilla"></div>
		</td>
	</tr>
</table>
</body>
</html>