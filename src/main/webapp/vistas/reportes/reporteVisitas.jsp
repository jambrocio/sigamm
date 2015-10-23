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
var map;
var coords = new Object();
var markersArray = [];

coords.lat = -15.249518332780694;
coords.lng = -70.04982824393497;

nroFoto = 0;
minFoto = 1;
maxFoto = 4;
nombreFoto = "";

$(document).ready(function() 
{
	$("#map_container").dialog({
    	autoOpen:false,
        width: 750,
        height: 650,
        modal: true,
        resizable: false,
        resizeStop: function(event, ui) {google.maps.event.trigger(map, 'resize')  },
        open: function(event, ui) {google.maps.event.trigger(map, 'resize'); }      
    });  
	
	$("#fotos_container").dialog({
    	autoOpen:false,
        width: 800,
        height: 750,
        modal: true,
        resizable: false
    });
	
    initialize();
    //plotPoint(coords.lat,coords.lng,'Mall of America','<span class="gBubble"><b>Mall of America</b><br>60 East Brodway<br>Bloomington, MN 55425</span>');
   
    cargarRegistros();
    
});

function plotPoint(srcLat, srcLon, title, popUpContent, markerIcon)
{
	var myLatlng = new google.maps.LatLng(srcLat, srcLon);            
    var marker = new google.maps.Marker({
    	position: myLatlng, 
        map: map, 
        title:title,
        icon: markerIcon
	});
    markersArray.push(marker);
    var infowindow = new google.maps.InfoWindow({
    	content: popUpContent
	});
    /*
    google.maps.event.addListener(marker, 'click', function() {
    	infowindow.open(map,marker);
	});
    */
    
    infowindow.open(map,marker);
}

function initialize() 
{      

    var latlng = new google.maps.LatLng(coords.lat, coords.lng);
    var myOptions = {
      zoom: 5,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
   map = new google.maps.Map(document.getElementById("map_canvas"),  myOptions);                         
}        

function mostrarMapa(codigo, latitud, longitud, dni, observacion, tipoRegistro){
	
	eliminarMarcadoresGoogleMaps(markersArray);
	
	documentoIdentidad = "DNI : " + dni;
	obs = replaceAll(observacion, "#", " ");
	descripcionRegistro = replaceAll(tipoRegistro, "#", " ");
	
	$("#map_container").dialog("open");
	map.setCenter(new google.maps.LatLng(latitud, longitud), 5);
	
	plotPoint(latitud, longitud, documentoIdentidad,'<span class="gBubble"><b>' + descripcionRegistro + '</b><br><b>' + documentoIdentidad + '</b><br>' + obs + '</span>');
	
}

function mostrarFotos(dni, fecha)
{
	$("#fotos").rotate(0);
	nroFoto = 1;
		
	nombreFoto = dni + "__" + replaceAll(replaceAll(fecha, ":", "_"),"/", "_");
	
	$("#fotos_container").dialog("open");
	$("#fotos").attr("src", "mostrarImagen/" + nroFoto + "/" + nombreFoto);
	$("#mensajeFoto").html("Foto " + nroFoto);
	
}

function siguiente(){
	
	$("#fotos").rotate(0);
	if(nroFoto < maxFoto){
		nroFoto = nroFoto + 1;
		$("#fotos").attr("src", "mostrarImagen/" + nroFoto + "/" + nombreFoto);
		$("#mensajeFoto").html("Foto " + nroFoto);
	}
} 

function anterior(){
	
	$("#fotos").rotate(0);
	if(nroFoto > minFoto){
		nroFoto = nroFoto - 1;
		$("#fotos").attr("src", "mostrarImagen/" + nroFoto + "/" + nombreFoto);
		$("#mensajeFoto").html("Foto " + nroFoto);
	}
	
}

function rotar(){
	
	$("#fotos").rotate(90);
	
}

function cargarRegistros(){
	
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{
		observacion = replaceAll(rowObject.observacion, " ", "#");
		tipoRegistro = replaceAll(rowObject.descripcionRegistro, " ", "#");
		fechaRegistro = replaceAll(rowObject.fechaRegistro, " ", "_");
		var opciones = "<center>";
			
			opciones += "<a href=javascript:mostrarMapa(";
			opciones += rowObject.id + ",";
			opciones += rowObject.latitud  + ",";
			opciones += rowObject.longitud  + ",'";
			opciones += rowObject.dni  + "','";
			opciones += observacion  + "','";
			opciones += tipoRegistro + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/mapa_24x24.png' border='0' title='Mostrar Mapa'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;<a href=javascript:mostrarFotos('";
			opciones += rowObject.dni  + "','";
			opciones += fechaRegistro + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/fotos_24x24.png' border='0' title='Mostrar Foto'/>";
			opciones += "</a></center>";
			
		return opciones;
	};
	
	jQuery("#grilla").jqGrid(
	{
		url : 'listar-registros.json',
		//postData: {"codigoBuscar":codigoBuscar,"descripcionBuscar":descripcionBuscar},
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		colNames : ['Unidad Territorial', 'Dni', 'Ap.Paterno', 'Ap.Materno', 'Nombre', 'Condición', 'Operador', 'Fecha Registro', 'Tipo Registro', 'Observación', 'Opciones'],
		colModel : [{
			name : 'nombreUt',
			index: 'nombreUt',
			sortable:true,
			width: 200,
			align: 'left'						
		},{
			name : 'dni',
			index: 'dni',
			sortable:true,
			width: 100,
			align: 'center'
		},{
			name : 'apPaterno',
			index: 'apPaterno',
			sortable:false,
			width: 100,
			align: 'left'
		},{
			name : 'apMaterno',
			index: 'apMaterno',
			sortable:false,
			width: 100,
			align: 'left'
		},{
			name : 'nombre',
			index: 'nombre',
			sortable:false,
			width: 100,
			align: 'left'
		},{
			name : 'condicion',
			index: 'condicion',
			sortable:false,
			width: 200,
			align: 'left'
		},{
			name : 'codigoOperador',
			index: 'codigoOperador',
			sortable:false,
			width: 100,
			align: 'center'
		},{
			name : 'fechaRegistro',
			index: 'fechaRegistro',
			sortable:false,
			width: 150,
			align: 'center'
		},{
			name : 'descripcionRegistro',
			index: 'descripcionRegistro',
			sortable:false,
			width: 150,
			align: 'center'
		},{
			name : 'observacion',
			index: 'observacion',
			sortable:false,
			width: 400,
			align: 'left'
		},{					
			name:'id',
			index:'id',
			width:100,
			sortable:false,
			search: false,
			formatter:formatterBotones
		}],								
		rowNum : 20,
		//rowList : [ 20, 30, 40 ],
		pager : '#pgrilla',
		sortname : 'id',
		autowidth: true,
		rownumbers: true,
		viewrecords : true,
		sortorder : "dni",				
		caption : "Registros"				

	}).trigger('reloadGrid');
}

</script>
</head>
<body id="body">
	
<table border="0" width="100%">
	<tr>
		<td align="right">
			<button type="button" class="btn btn-primary" onclick="cargarRegistros()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
			</button>
			
			<button type="button" class="btn btn-primary">
				<img src="recursos/images/icons/excel_16x16.png" alt="Exportar a Excel" />&nbsp;<a href="<%=request.getContextPath()%>/reporteVisitasExcel" style="color:white">Exportar</a>
			</button>
		</td>
	</tr>
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

<div id="map_container" title="Ubicación">    
    <div id="map_canvas" style="width: 680px; height: 580px;"></div>
</div>
<div id="fotos_container" title="Fotos">
	<table border="0" align="center">
		<tr>
			<td colspan="3" align="left"><b><span id="mensajeFoto" /></b></td>
		</tr>
		<tr>
			<td colspan="3" align="left"><a href="javascript:rotar();"><img src="recursos/images/rotar_48x48.png" alt="Rotar" /></a></td>
		</tr>
		<tr>
			<td>
				<a href="javascript:anterior();"><img src="recursos/images/izquierda_48x48.png" alt="Anterior" /></a>
			</td>
			<td>
				<img id="fotos" />
			</td>
			<td>
				<a href="javascript:siguiente();"><img src="recursos/images/derecha_48x48.png" alt="Siguiente" /></a>
			</td>
		</tr>
	</table>	
</div>

</body>
</html>