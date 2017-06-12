<?xml version="1.0" encoding="UTF-8" ?>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:f="http://java.sun.com/jsf/core" xmlns:h="http://java.sun.com/jsf/html">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="recursos/css/estilos_impresion.css"	type="text/css" media="print" />
<title></title>
<style>

	#mdialTamanio{
      width: 550px !important;
    }
    
	tamanio18 {
		font-family: courier new; 
		font-size: 18px;
	}
	
	tamanio16 {
		font-family: courier new; 
		font-size: 16px;
	}
	
	tamanio14 {
		font-family: courier new; 
		font-size: 14px;
	}

	tamanio12 {
		font-family: courier new; 
		font-size: 12px;
	}
	
    .gBubble
    {
        color:black;
        font-family:Tahoma, Geneva, sans-serif;
        font-size:12px;    
    }
	
	.tamanioPrinter14
    {
        color:black;
        font-family: Calibri;
		font-size: 14px;    
    }
    
    .tamanioPrinter12
    {
        color:black;
        font-family: Calibri;
		font-size: 12px;    
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
</style>
<script>
$(document).ready(function(){		
	
	$.ajax({
        type: "POST",
        async: false,
        url: "listar-giro-comercial.json",
        cache: false,
        success: function(result){
        	
        	$("#giroComercial").autocomplete(result, {
                formatItem: function(item) {
                    return item.nombreGiro;
                },
                width: 460,
                scroll: true,
                matchContains: true,
                minChars: 0//cuando se presiona el boton de flecha hacia abajo se muestra toda la lista
            }).result(function(event, item) {
            	
            	$("#codigoGiro").val(item.codigoGiro);
            	
            });
        	
        }
    });
	
	cargarFacturacion();
	montoTotalDiario();
});



function colorEtiquetas(){
	
	$("#lblpuesto").css("color", "black");
	$("#lblgiroComercial").css("color", "black");
	
	$("#lblpuesto-img").hide();
	$("#lblgiroComercial-img").hide();
	
}

function buscarUsuario(){
	
	dni = $("#dniBuscar").val();
	
	var parametros = new Object();
	parametros.dni = dni;
	
	$.ajax({
        type: "POST",
        async:false,
        url: "buscar-usuario.json",
        cache : false,
        data: parametros,
        success: function(result){
            //console.log(result.userid);
        	//alert("Resultado : [" + result.codigo + "]");
        	$("#userid").val(result.userid);
        	$("#dni").val(result.dni);
        	$("#apePaterno").val(result.apellidoPaterno);
        	$("#apeMaterno").val(result.apellidoMaterno);
        	$("#nombres").val(result.nombres);
        	$("#telefono").val(result.telefono);
        	$("#codigoUsuario").val(result.codigoUsuario);
        }
    });
}

function limpiarTablaFacturacion(){
	
	var tabla = document.getElementById("tablaFacturacionDetalle");
	var filasTabla = tabla.rows.length;
	
	for(var i = 0; i < filasTabla; i++) {
		
		if(i > 0){
 			
 			tabla.deleteRow(1);
 			
 		}
 		
 	}
	
}

function visualizar(codigoFacturacionCab){
	
	limpiarTablaFacturacion();
	
	var ruta = obtenerContexto();
	var parametros = new Object();
	parametros.codigoFacturacionCab = codigoFacturacionCab;
	
	$.ajax({
        type: "POST",
        async:false,
        url: "buscar-facturacionCabecera.json",
        cache : false,
        data: parametros,
        success: function(result){
            
        	$("#printFecha").html(result.fechaCreacion);
        	$("#printAsociado").html(result.nombresFull);
        	$("#printSector").html(result.nombreSector);
        	$("#printPuesto").html(result.nroPuesto);
        	$("#printGiro").html(result.nombreGiro);
        	$("#correlativo").html(result.comprobante);
        }
    });
	
	$.ajax({
        type: "POST",
        async:false,
        url: "buscar-facturacionDetalle.json",
        cache : false,
        data: parametros,
        success: function(result){
            
        	dataTabla = "";
        	cantidadLineas = 1;
        	$.each(result, function(keyM, serv) {
        		
        		var nombreDetalle = serv.nombreDetalle;
        		var monto = parseInt(serv.monto);
        		var fecPeriodo = serv.fecPeriodo;
        		
        		//console.log("Monto : " + monto);
        		
        		dataTabla += "<tr>" +
		           	"<td align='center'></td>" + 
  		           	"<td align='left' class='tamanioPrinter12'><b>" + nombreDetalle + "</b><br>" + fecPeriodo + "</td>" +
  		           	"<td align='right' class='tamanioPrinter12'>S/. " + formatearImporte(monto) + "</td>" +
  		          	"<td align='right' class='tamanioPrinter12' style='display:none;'>" + monto + "</td>" +
  				"</tr>";
  				
  				cantidadLineas = cantidadLineas + 1;
  				
        	});
        	
        	var j = 8 - cantidadLineas; 
			for (i=0 ;i < j; i++) { 
				 
				dataTabla += "<tr>";
		    	dataTabla += "<td>&nbsp;</td>";
		    	dataTabla += "<td>&nbsp;</td>";
		    	dataTabla += "<td>&nbsp;</td>";
		    	dataTabla += "<td style='display:none;'></td>";
		    	dataTabla += "</tr>";
		    	//console.log("Linea : " + i);
			}
			
			dataTabla1 = dataTabla;
			dataTabla1 += "<tr>";
	    	dataTabla1 += "<td>&nbsp;</td>";
	    	dataTabla1 += "<td class='tamanioPrinter12'><b>TOTAL</b></td>";
	    	dataTabla1 += "<td align='right' class='tamanioPrinter12'><b>S/. <span id='totalImpresion'/></b></td>";
	    	dataTabla1 += "<td style='display:none;'></td>";
	    	dataTabla1 += "</tr>";
	    	
	    	dataTabla2 = dataTabla;
	    	dataTabla2 += "<tr>";
	    	dataTabla2 += "<td>&nbsp;</td>";
	    	dataTabla2 += "<td class='tamanioPrinter12'><b>TOTAL</b></td>";
	    	dataTabla2 += "<td align='right' class='tamanioPrinter12'><b>S/. <span id='totalImpresion2'/></b></td>";
	    	dataTabla2 += "<td style='display:none;'></td>";
	    	dataTabla2 += "</tr>";
	    			    	
			$('#tablaFacturacionDetalle tbody tr:last').after(dataTabla1);
			
        	calculoTotal();
        	
        }
    });
	
	$('#visualizacion_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
}


function imprimir(codigoFacturacionCab){
	$("#correlativo1").html(codigoFacturacionCab);
	
	limpiarTablaFacturacion();
	
	var ruta = obtenerContexto();
	var parametros = new Object();
	parametros.codigoFacturacionCab = codigoFacturacionCab;
	
	$.ajax({
        type: "POST",
        async:false,
        url: "buscar-facturacionCabecera.json",
        cache : false,
        data: parametros,
        success: function(result){
        	$("#printFecha1").html(result.fechaCreacion);
        	$("#printAsociado1").html(result.nombresFull);
        	$("#printSector1").html(result.nombreSector);
        	$("#printPuesto1").html(result.nroPuesto);
        	$("#printGiro1").html(result.nombreGiro);        		
        }
    });
	
	$.ajax({
        type: "POST",
        async:false,
        url: "buscar-facturacionDetalle.json",
        cache : false,
        data: parametros,
        success: function(result){
            
        	dataTabla = "";
        	dataTabla1 = "";
        	dataTabla2 = "";
        	$("#tablaFacturacionDetalle1").val("");
        	cantidadLineas = 1;
        	$.each(result, function(keyM, serv) {
        		
        		var nombreDetalle = serv.nombreDetalle;
        		var monto = parseFloat(serv.monto);
        		var fecPeriodo = serv.fecPeriodo;
        		
        		dataTabla += "<tr>" +
		           	"<td align='center'></td>" + 
  		           	"<td align='left'><font class='tamanio12'><b>" + nombreDetalle + "</b></font><br><font class='tamanio12'>" + fecPeriodo + "</font></td>" +
  		           	"<td align='right'><font class='tamanio12'>S/. " + formatearImporte(monto) + "</font></td>" +
  		          	"<td align='right' style='display:none;'>" + monto + "</td>" +
  				"</tr>";
  				
  				cantidadLineas = cantidadLineas + 1;
  				
        	});
        	
        	var j = 7 - cantidadLineas; 
			for (i=0; i < j; i++) { 
				 
				dataTabla += "<tr>";
		    	dataTabla += "<td>&nbsp;</td>";
		    	dataTabla += "<td>&nbsp;</td>";
		    	dataTabla += "<td>&nbsp;</td>";
		    	dataTabla += "<td style='display:none;'></td>";
		    	dataTabla += "</tr>";
		    	
		    	//console.log("Linea : " + i);
			}
			
			dataTabla1 = dataTabla;
			dataTabla1 += "<tr>";
	    	dataTabla1 += "<td>&nbsp;</td>";
	    	dataTabla1 += "<td><font class='tamanio12'><b>TOTAL</b></font></td>";
	    	dataTabla1 += "<td align='right'><font class='tamanio12'><b>S/. <span id='totalImpresion1'/></b></font></td>";
	    	dataTabla1 += "<td style='display:none;'></td>";
	    	dataTabla1 += "</tr>";
	    	
	    	dataTabla2 = dataTabla;
	    	dataTabla2 += "<tr>";
	    	dataTabla2 += "<td>&nbsp;</td>";
	    	dataTabla2 += "<td><font class='tamanio12'><b>TOTAL</b></font></td>";
	    	dataTabla2 += "<td align='right'><font class='tamanio12'><b>S/. <span id='totalImpresion2'/></b></font></td>";
	    	dataTabla2 += "<td style='display:none;'></td>";
	    	dataTabla2 += "</tr>";
	    			    	
			$('#tablaFacturacionDetalle1 tbody tr:last').after(dataTabla1);
			
        	calculoTotal();
        	
        }
    });
	
	$('#visualizacion_modal_1').modal({
		backdrop: 'static',
		keyboard: false
	});
	
}


function calculoTotal(){
	
	var total = 0;
	var total1 = 0;
	var total2 = 0;
    $("#tablaFacturacionDetalle tbody tr").each(function (item) {
        var this_row = $(this);
        var monto = $.trim(this_row.find('td:eq(3)').html());
		if(monto != "" && monto != "IMPORTE OCULTO"){
			total = parseFloat(total) + parseFloat(monto);
		}
    });
    $("#tablaFacturacionDetalle1 tbody tr").each(function (item) {
        var this_row = $(this);
        var monto = $.trim(this_row.find('td:eq(3)').html());
		if(monto != "" && monto != "IMPORTE OCULTO"){
			total1 = parseFloat(total1) + parseFloat(monto);
		}
    });
    
    $("#totalImpresion").html(total.toFixed(2));
    $("#totalImpresion1").html(total1.toFixed(2));
    $("#totalLetras").html(NumeroALetras(total));
	$("#totalLetras1").html(NumeroALetras(total1));
	
}

function grabarAnulacionFacturacion(){
	
	var ruta = obtenerContexto();
	
	jsonObj = [];
	var parametros = new Object();
	parametros.codigoFacturacionCab = $("#codigoFacturacionCab").val();
	parametros.observacion = $("#observacion").val();
		
	$.ajax({
		type: "POST",
	    async:false,
	    url: "anular-facturacion.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	            
	        imagen = "";
	        if(result.indicador == "00"){
            	$('#anular_facturacion_modal').modal('hide');
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
	            
            cargarFacturacion();
	            
		}
	});
	
}

function anularFactura(codigoFacturacionCab){
	
	mensaje = "Desea Anular la factura con codigo : " + codigoFacturacionCab + " ?"; 
	
	$("#codigoFacturacionCab").val(0);
	$("#mensajeEliminar").html(mensaje);
	
	
	$('#alerta_modal').modal({
		backdrop: 'static',
		keyboard: false
	}).one('click', '#aceptar', function() {
		
		$('#alerta_modal').modal('hide');
		
		$('#anular_facturacion_modal').modal({
			backdrop: 'static',
			keyboard: false
		});
		
		$("#mensajeAnularFacturacion").html("Código de Facturación : " + codigoFacturacionCab);
		
		$("#codigoFacturacionCab").val(codigoFacturacionCab);
		
    });
	
}

function cargarFacturacion(){
	
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		nombreGiro = replaceAll(rowObject.nombreGiro, " ", "#");
		nombre = replaceAll(nombreFull, " ", "#");
		var opciones = "<center>";
			
			if(rowObject.estado == 1){
				opciones += "<a href=javascript:visualizar(";
				opciones += rowObject.codigoFacturacionCab + ") >";
				opciones += "<img src='/"+ruta+"/recursos/images/icons/print_24x24.png' border='0' title='Ver Comprobante'/>";
				opciones += "</a>";
				
				opciones += "&nbsp;&nbsp;";
				/*
				opciones += "<a href=javascript:imprimir(";
				opciones += rowObject.codigoFacturacionCab + ") >";
				opciones += "<img src='/"+ruta+"/recursos/images/icons/impresion_24x24.png' border='0' title='Imprimir Comprobante'/>";
				opciones += "</a>";
				
				opciones += "&nbsp;&nbsp;";
				*/
				opciones += "<a href=javascript:anularFactura(";
				opciones += rowObject.codigoFacturacionCab + ") >";
				opciones += "<img src='/"+ruta+"/recursos/images/icons/tacho_24x24.png' border='0' title='Anular Factura'/>";
				opciones += "</a>";
			}
			
			opciones += "</center>";
			
		return opciones;
				
	};
	
	jQuery("#grilla").jqGrid(
	{
		url : 'reporte-facturacion.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		colNames : ['Código', 'Puesto', 'DNI', 'Ap.Paterno', 'Ap.Materno', 'Nombres', 'Nro.Comprobante', 'Fecha', 'Monto', 'Opciones'],
		colModel : [{
			name : 'codigoFactCabAlt',
			index: 'codigoFactCabAlt',
			sortable:true,
			width: 100,
			align: 'right'						
		},{
			name : 'nroPuesto',
			index: 'nroPuesto',
			sortable:true,
			width: 100,
			align: 'right'						
		},{
			name : 'dni',
			index: 'dni',
			sortable:false,
			width: 90,
			align: 'center'
		},{
			name : 'apellidoPaterno',
			index: 'apellidoPaterno',
			sortable:false,
			width: 100,
			align: 'left'
		},{
			name : 'apellidoMaterno',
			index: 'apellidoMaterno',
			sortable:false,
			width: 100,
			align: 'left'
		},{
			name : 'nombres',
			index: 'nombres',
			sortable:false,
			width: 150,
			align: 'left'
		},{
			name : 'comprobante',
			index: 'comprobante',
			sortable:false,
			width: 200,
			align: 'center'
		},{
			name : 'fechaCreacion',
			index: 'fechaCreacion',
			sortable:false,
			width: 200,
			align: 'center'
		},{
			name : 'monto',
			index: 'monto',
			sortable:false,
			width: 100,
			align: 'right'
		},{					
			name:'codigoFacturacionCab',
			index:'codigoFacturacionCab',
			width:100,
			sortable:false,
			search: false,
			formatter:formatterBotones
		}],								
		rowNum : 20,
		//rowList : [ 20, 30, 40 ],
		pager : '#pgrilla',
		sortname : 'codigoFacturacionCab',
		autowidth: true,
		rownumbers: true,
		viewrecords : true,
		sortorder : "codigoFacturacionCab",				
		caption : "Facturación",			
		
		afterInsertRow: function(rowId, data, item){
			//alert(rowId + ' - ' + data + ' - ' + item.total);
			if (item.estado == 2){
				$("#grilla").setCell(rowId, 'codigoFactCabAlt', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grilla").setCell(rowId, 'nroPuesto', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grilla").setCell(rowId, 'dni', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grilla").setCell(rowId, 'apellidoPaterno', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grilla").setCell(rowId, 'apellidoMaterno', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grilla").setCell(rowId, 'nombres', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grilla").setCell(rowId, 'comprobante', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grilla").setCell(rowId, 'fechaCreacion', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grilla").setCell(rowId, 'monto', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
			}

		},
	
		multiselect: false,
		subGrid: true,
		subGridRowExpanded: function(subgrid_id, row_id) {
			// we pass two parameters
			// subgrid_id is a id of the div tag created whitin a table data
			// the id of this elemenet is a combination of the "sg_" + id of the row
			// the row_id is the id of the row
			// If we wan to pass additinal parameters to the url we can use
			// a method getRowData(row_id) - which returns associative array in type name-value
			// here we can easy construct the flowing
			
			var data = $("#grilla").getRowData(row_id);
			var busqueda = data.codigoFactCabAlt;
			
			var subgrid_table_id, pager_id;
			subgrid_table_id = subgrid_id+"_t";
			pager_id = "p_"+subgrid_table_id;
			$("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");
			jQuery("#"+subgrid_table_id).jqGrid({
				url:"reporte-facturacion-detalle.json?codigoFacturacionCab=" + busqueda,
				datatype : "json",
				mtype: 'POST',
				colNames: ['Detalle', 'Periodo', 'Importe'],
				colModel: [{
					name:"nombreDetalle",
					index:"nombreDetalle",
					width:300,
					align: 'left',
					key:true
				},{
					name:"fecPeriodo",
					index:"fecPeriodo",
					width:250,
					align: 'left'
				},{
					name:"monto",
					index:"monto",
					width:130,
					align: 'right'
				}],
			   	rowNum:20,
			   	pager: pager_id,
			   	sortname: 'num',
			    sortorder: "asc",
			    height: '100%'
			});
		}
	}).trigger('reloadGrid');
}

function montoTotalDiario(){
	
	$.ajax({
        type: "POST",
        async:false,
        url: "monto-total-diario.json",
        cache : false,
        success: function(result){
            //console.log("monto : " + result.monto);
        	//alert("Resultado : [" + result + "]");
        	//total = parseFloat(result.monto);
            $("#totalFacturacion").html(result.monto);
        }
    });
}

function mostrarIreport(){
	var url  = "/sigamm/iFacturacionDiario";
	window.open(url,"_blank", "menubar=no,location=0,height=500,width=800");
}


function imprime(){
	$("div#datosImprimir").printArea();
}

function cerrar(){
	$('#visualizacion_modal_1').modal('hide');
	location.reload();
	
}

</script>
</head>
<body id="body">
<input type="hidden" id="codigoUsuario" />
<input type="hidden" id="codigoGiro" />
<input type="hidden" id="codigoFacturacionCab" />

<table border="0" width="100%">
	<tr>
		<td colspan="6">&nbsp;</td>
	</tr>
	<tr>
		<td width="150"><b>Nro.Puesto<b/></td>
		<td width="10">:</td>
		<td width="200"><input type="text" id="nroPuesto" class="form-control" maxlength="5" /></td>
		<td>&nbsp;&nbsp;
			<button type="button" class="btn btn-primary">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
			</button>&nbsp;&nbsp;
			
			<a href="<c:url value="/cobro"/>">
				<button type="button" class="btn btn-primary">
					<img src="recursos/images/icons/nuevo_16x16.png" alt="Nuevo" />&nbsp;Nuevo
				</button>&nbsp;&nbsp;
			</a>
			
			<button type="button" class="btn btn-primary" onclick="mostrarIreport()">
				<img src="recursos/images/icons/pdf_16x16.png" alt="Reporte Facturación Diario" />&nbsp;Generar PDF
			</button>
			
		</td>
		<td width="80">&nbsp;</td>
		<td width="80">&nbsp;</td>
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
	<tr>
		<td colspan="4">&nbsp;</td>
		<td><b>Total :</b></td>
		<td align="right"><b><span id="totalFacturacion"></span></b></td>
	</tr>
</table>	
 
<div class="modal fade" id="alerta_modal" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Anular Factura</h4>
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

<div class="modal fade" id="anular_facturacion_modal" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Anular Factura</h4>
			</div>
			<div class="modal-body">
					
				<table border="0">
					<tr>
						<td colspan="3"><b><span id="mensajeAnularFacturacion" /></b></td>
					</tr>
					<tr>
						<td colspan="3">&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>Observación</b></td>
						<td valign="top"><b>:</b></td>
						<td>
							<textarea rows="4" cols="50" id="observacion" class="form-control" maxlength="500" style="text-transform: uppercase;"></textarea>
						</td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" onclick="grabarAnulacionFacturacion()">
					<img src="recursos/images/icons/guardar_16x16.png" alt="Guardar" />&nbsp;Guardar
				</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
			</div>
		</div>
		  
	</div>
</div>

<div class="modal fade" id="visualizacion_modal" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Visualización</h4>
			</div>
			<div class="modal-body">
					
				<div id="myPrintArea">
					<table border="0" width="100%">
						<tr>
							<td width="48%" valign="top">
								<div class="marca-de-agua"> 
								<table border="0" width="100%" >
									<tr>
										<td colspan="3" align="center" class="tamanioPrinter14"><b>ASOCIACIÓN DE COMERCIANTES DEL MERCADO MODELO<BR>DE HUARAL<BR>Fundado el 13 de Noviembre de 1996<BR>R.U.C. 20530606334</b></td>
									</tr>
									<tr>
										<td colspan="3">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="3" align="center" class="tamanioPrinter14"><b>RECIBO PROVISIONAL N° <span id="correlativo" /></b></td>
									</tr>
									<tr>
										<td colspan="3">&nbsp;</td>
									</tr>
									<tr>
										<td width="100px" class="tamanioPrinter12"><b>FECHA</b></td>
										<td class="tamanioPrinter12"><b>:</b></td>
										<td class="tamanioPrinter12"><span id="printFecha"/></td>
									</tr>
									<tr>
										<td class="tamanioPrinter12"><b>ASOCIADO</b></td>
										<td class="tamanioPrinter12"><b>:</b></td>
										<td class="tamanioPrinter12"><span id="printAsociado"/></td>
									</tr>
									<tr>
										<td class="tamanioPrinter12"><b>SECTOR</b></td>
										<td class="tamanioPrinter12"><b>:</b></td>
										<td class="tamanioPrinter12"><span id="printSector"/></td>
									</tr>
									<tr>
										<td class="tamanioPrinter12"><b>PUESTO</b></td>
										<td class="tamanioPrinter12"><b>:</b></td>
										<td class="tamanioPrinter12"><span id="printPuesto"/></td>
									</tr>
									<tr>
										<td class="tamanioPrinter12"><b>GIRO</b></td>
										<td class="tamanioPrinter12"><b>:</b></td>
										<td class="tamanioPrinter12"><span id="printGiro"/></td>
									</tr>
									<tr>
										<td colspan="3">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="3">
											<table border="1" width="100%" cellspacing="5" cellpadding="5" class="tabla" id="tablaFacturacionDetalle">
												<tr>
													<td width="80px" align="center" class="tamanioPrinter12"><b>CANT.</b></td>
													<td align="center" class="tamanioPrinter12"><b>DESCRIPCION</b></td>
													<td width="100px" align="center" class="tamanioPrinter12"><b>IMPORTE</b></td>
													<td width="100px" align="center" class="tamanioPrinter12" style="display:none;">IMPORTE OCULTO</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td colspan="3">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="3" class="tamanioPrinter12"><b>SON : <span id="totalLetras" /></b></td>
									</tr>
								</table>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				
			</div>
		</div>
		  
	</div>
</div>


<div class="modal fade" id="visualizacion_modal_1" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog">	
		<!-- Modal content-->
	<div class="modal-content" id="mdialTamanio">
		<div class="row" id="datosImprimir">
			<div class="col-xs-12">
				<div class="panel panel-default">
					<div class="panel-heading" align="center" id="noMostrar">
						<font class="tamanio18"><b>ASOCIACION DE COMERCIANTES DEL MERCADO MODELO DE HUARAL</b></font><br>
						<font class="tamanio16">Fundado el 13 de Noviembre de 1996</font><br/>
						<font class="tamanio16">R.U.C. 20530606334</font><br/>
					</div>
					<div class="panel-body">
						<font class="tamanio16"><p align="center"><b>RECIBO PROVISIONAL Nro.&nbsp;<span id="correlativo1" /></b></p></font><br/>
						<font class="tamanio14">
							<table border="1" cellspacing="0" cellpadding="0">
								<tr>
									<td style="width: 110px; "><b>Asociado (a):</b></td>
									<td style="width: 300px; "><span id="printAsociado1"/></td>
									<td style="width: 15px; "><b>Fecha:</b></td>
									<td><span id="printFecha1"/></td>
								</tr>
								<tr>
									<td style="width: 110px; "><b>Nº de Puesto:</b></td>
									<td colspan="3">
										<table border="1" cellpadding="0" cellspacing="0">
											<tr>
												<td style="width: 50px; "><span id="printPuesto1"/></td>
												<td style="width: 35px; "><b>Sector:</b></td>
												<td style="width: 50px; "><span id="printSector1"/></td>
												<td style="width: 35px; "><b>Giro:</b></td>
												<td><span id="printGiro1"/></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</font>
						
						<!-- / fin de secciÃ³n de datos del Cliente  -->
						<table border="1" cellpadding="0" cellspacing="0" width="330px;" class="tamanio14" id= "tablaFacturacionDetalle1">
							<tr>
								<th><b>CANT</b></th>
								<th><b>DESCRIPCION</b></th>
								<th><b>TOTAL</b></th>
							</tr>
						</table>
						<div class="panel panel-info">
							<div class="panel-heading" align="left">
								<font class="tamanio14">Son : <span id="totalLetras1" /></font>
							</div>
						</div>
					</div>
				</div>
			</div>
			
		</div>
		<div class="modal-footer" id="botonImprime">
			<button type="button" id="btnImprimir" class="btn btn-primary" onclick="imprime();">
				<img src="recursos/images/icons/print_16x16.png" alt="Imprimir" />&nbsp;Imprimir
			</button>
			<button type="button" class="btn btn-default" onclick="cerrar();">
				<img src="recursos/images/icons/boxclosed_16x16.png" alt="Cerrar" />&nbsp;Cerrar
			</button>
		</div>
	</div> <!-- Fin del Container -->
		  
	</div>
</div>
</body>
</html>