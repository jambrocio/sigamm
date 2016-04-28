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
	
	cargarPuestos();
	montoTotalDiario();
});

function colorEtiquetas(){
	
	$("#lblpuesto").css("color", "black");
	$("#lblgiroComercial").css("color", "black");
	
	$("#lblpuesto-img").hide();
	$("#lblgiroComercial-img").hide();
	
}

function nuevoUsuario(){
	
	$('#puesto_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Nuevo Puesto");
	
	colorEtiquetas();
	
	$("#codigoPuesto").val(0);
	$("#codigoUsuario").val(0);
	$("#codigoGiro").val(0);
	
	$("#dniBuscar").val("");
	$("#puesto").val("");
	$("#giroComercial").val("");
	
	$("#dni").val("");
	$("#userid").val("");
	$("#apePaterno").val("");
	$("#apeMaterno").val("");
	$("#nombres").val("");
	$("#telefono").val("");
	
}

function guardar(){
	
	var ruta = obtenerContexto();
			
	jsonObj = [];
	var parametros = new Object();
	parametros.codigoUsuario = $("#codigoUsuario").val();
	parametros.codigoGiro = $("#codigoGiro").val();
	parametros.nroPuesto = $("#puesto").val();
	parametros.codigoPuesto = $("#codigoPuesto").val();
		
	$.ajax({
		type: "POST",
	    async:false,
	    url: "grabar-puesto.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	            
	        if(result.camposObligatorios.length == 0){
                	
            	$('#puesto_modal').modal('hide');
            	
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
	            
	            cargarPuestos();
	            
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

function editarPuesto(codigoPuesto, nroPuesto, codigoUsuario, codigoGiro, dni, nombreGiro){
	console.log("Editar Puesto - [codigoPuesto] : " + codigoPuesto + ", [nroPuesto] : " + nroPuesto + ", [codigoUsuario] : " + codigoUsuario + ", [codigoGiro] : " + codigoGiro + ", [nombreGiro] : " + nombreGiro);
	
	$('#puesto_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Modificar Puesto");
	
	colorEtiquetas();
	
	$("#codigoPuesto").val(codigoPuesto);
	$("#codigoUsuario").val(codigoUsuario);
	$("#codigoGiro").val(codigoGiro);
	
	$("#dniBuscar").val(dni);
	$("#puesto").val(nroPuesto);
	$("#giroComercial").val(nombreGiro);
	
	buscarUsuario();
	cargarPuestos();
	
}

function eliminarPuesto(codigoPuesto, nombre, nroPuesto){
	
	//console.log("Eliminar Puesto - [codigoPuesto] : " + codigoPuesto);
	//cargarPuestos();
	var ruta = obtenerContexto();
	mensaje = "Desea eliminar el puesto " + nroPuesto + "\n del usuario " + replaceAll(nombre, "#", " ") + " ?"; 
	
	$("#mensajeEliminar").html(mensaje);
	
	$('#alerta_modal').modal({
		backdrop: 'static',
		keyboard: false
	}).one('click', '#aceptar', function() {
        
		jsonObj = [];
		var parametros = new Object();
		parametros.codigoPuesto = codigoPuesto;
			
		$.ajax({
			type: "POST",
		    async:false,
		    url: "eliminar-puesto.json",
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
	            
	            cargarPuestos();
		            
			}
		});
		
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
        		
        		dataTabla += "<tr>" +
		           	"<td align='center'></td>" + 
  		           	"<td align='left' class='tamanioPrinter12'><b>" + nombreDetalle + "</b><br>" + fecPeriodo + "</td>" +
  		           	"<td align='right' class='tamanioPrinter12'>S/. " + currencyFormat(monto) + "</td>" +
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

function calculoTotal(){
	
	var total = 0;
    $("#tablaFacturacionDetalle tbody tr").each(function (item) {
        var this_row = $(this);
        //var monto = $.trim(this_row.find('td:eq(3)').html());
        var monto = $.trim(this_row.find('td:eq(3)').html());
		if(monto != "" && monto != "IMPORTE OCULTO"){
			//console.log("[" + monto + "]");
			total = parseFloat(total) + parseFloat(monto);
		}
    });
	
    $("#totalImpresion").html(total.toFixed(2));
	$("#totalLetras").html(NumeroALetras(total));
	
}

function cargarPuestos(){
	
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		nombreGiro = replaceAll(rowObject.nombreGiro, " ", "#");
		nombre = replaceAll(nombreFull, " ", "#");
		var opciones = "<center>";
			
			opciones += "<a href=javascript:visualizar(";
			opciones += rowObject.codigoFacturacionCab + ") >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/print_24x24.png' border='0' title='Ver Comprobante'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:eliminarFactura(";
			opciones += rowObject.codigoPuesto + ",'";
			opciones += nombre + "','";
			opciones += rowObject.nroPuesto + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/eliminar_24x24.png' border='0' title='Eliminar Puesto'/>";
			opciones += "</a>";
			
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
		colNames : ['Puesto', 'DNI', 'Ap.Paterno', 'Ap.Materno', 'Nombres', 'Servicio', 'Descripción', 'Monto', 'Opciones'],
		colModel : [{
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
			name : 'nombreDetalle',
			index: 'nombreDetalle',
			sortable:false,
			width: 200,
			align: 'center'
		},{
			name : 'fecPeriodo',
			index: 'fecPeriodo',
			sortable:false,
			width: 300,
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
		caption : "Facturación"				

	}).trigger('reloadGrid');
}

function currencyFormat (num) {
    return num.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
}

function buscarPuesto(){
	
	var parametros=new Object();
	parametros.dni = $("#dniBuscara").val();

	$("#grilla").jqGrid('setGridParam',
	{
		url : 'reporte-facturacion.json',
		datatype : "json",
		postData:parametros,
		page:1
	}).trigger('reloadGrid');
		
}

function montoTotalDiario(){
	
	$.ajax({
        type: "POST",
        async:false,
        url: "monto-total-diario.json",
        cache : false,
        success: function(result){
            console.log();
        	//alert("Resultado : [" + result + "]");
        	total = parseFloat(result.monto);
            $("#totalFacturacion").html(currencyFormat(total));
        }
    });
}

</script>
</head>
<body id="body">
<input type="hidden" id="codigoPuesto" />
<input type="hidden" id="codigoUsuario" />
<input type="hidden" id="codigoGiro" />
<table border="0" width="100%">
	<tr>
		<td colspan="6">&nbsp;</td>
	</tr>
	<tr>
		<td width="150"><b>DNI<b/></td>
		<td width="10">:</td>
		<td width="200"><input type="text" id="dniBuscara" class="form-control" maxlength="8" /></td>
		<td>&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" onclick="buscarPuesto()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
			</button>&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" class="boton btnNuevo">
				<a href="<c:url value="/cobro"/>">&nbsp;Nuevo</a>
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

<div class="modal fade" id="puesto_modal" role="dialog" data-keyboard="false" data-backdrop="static">
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
				<h4 class="modal-title">Eliminar Puesto</h4>
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

</body>
</html>