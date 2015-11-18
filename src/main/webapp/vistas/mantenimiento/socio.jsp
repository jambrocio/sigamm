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
	
	$('[data-toggle="popover"]').popover({ placement : 'right', trigger: "hover" });
	
	$("#fecnac").datepicker({
	    changeMonth: true,
		changeYear: true,
		//showButtonPanel: true,
		dateFormat: 'dd/mm/yy'
	});
	
	$("#fecingreso").datepicker({
	    changeMonth: true,
		changeYear: true,
		//showButtonPanel: true,
		dateFormat: 'dd/mm/yy'
	});
	
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
	
	cargarSocios();
	
});

function colorEtiquetas(){
	
	$("#lbldni").css("color", "black");
	$("#lblapepat").css("color", "black");
	$("#lblapemat").css("color", "black");
	$("#lblnombres").css("color", "black");
	$("#lblfecnac").css("color", "black");
	$("#lblfecingreso").css("color", "black");
	$("#lblpuesto").css("color", "black");
	$("#lblpadron").css("color", "black");
	$("#lblgiroComercial").css("color", "black");
	
	$("#lbldni-img").hide();
	$("#lblapepat-img").hide();
	$("#lblapemat-img").hide();
	$("#lblnombres-img").hide();
	$("#lblfecnac-img").hide();
	$("#lblfecingreso-img").hide();
	$("#lblpuesto-img").hide();
	$("#lblpadron-img").hide();
	$("#lblgiroComercial-img").hide();
	
}

function cargarServicios(){
	
	var parametros = new Object();
	parametros.codigoSocio 		= $("#codigoSocio").val();
	
	$.ajax({
        type: "POST",
        async: false,
        url: "cargar-servicios.json",
        cache: false,
        data: parametros,
        success: function(result){
        		
        	var menuOpciones = "<table id='tablaServicios' border=0 width='100%'>";
    		$.each(result, function(keyM, servicio) {
    		    menuOpciones += "<tr><td colspan=3><b>" + servicio.nombreServicio + "</b></td></tr>";
    		    $.each(servicio.detalle,function(keyN, detalle) {
    		    	menuOpciones += "<tr>";
    		    	menuOpciones += "<td>&nbsp;&nbsp;</td>";
    		    	menuOpciones += "<td align='center'><input type='checkbox' id='chk_" + detalle.codigoServicioDetalle + "'></td>";
    		    	menuOpciones += "<td style='display:none'>chk_" + detalle.codigoServicioDetalle + "</td>";
    		    	menuOpciones += "<td style='display:none'>" + detalle.codigoServicioDetalle + "</td>";
    		    	menuOpciones += "<td>&nbsp;&nbsp;";
    		    	menuOpciones += detalle.nombreDetalle;
    		    	menuOpciones += "</td>";
    		    	menuOpciones += "</tr>";
    		    	
    		    });
    		});
    		menuOpciones += "</table>";
    		
    		$("#servicios").html(menuOpciones);
    		
    		$.each(result, function(keyM, servicio) {
    		    $.each(servicio.detalle,function(keyN, detalle) {
    		    	if(detalle.seleccionado == 1){
    		    		$("#chk_" + detalle.codigoServicioDetalle).attr("checked", true);
    		    	}
    		    	
    		    	if(detalle.obligatorio == 1){
    		    		$("#chk_" + detalle.codigoServicioDetalle).attr("disabled", true);
    		    	}
    		    	
    		    });
    		    
    		});
        }
    });
}

function nuevoSocio(){
	
	$('#socio_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Nuevo Socio");
	
	colorEtiquetas();
	
	$("#codigoSocio").val(0);
	$("#codigoGiro").val(0);
	
	$("#puesto").val("");
	$("#giroComercial").val("");
	
	$("#dni").val("");
	$("#apePaterno").val("");
	$("#apeMaterno").val("");
	$("#nombres").val("");
	$("#telefono").val("");
	$("#celular").val("");
	$("#puesto").val("");
	$("#padron").val("");
	$("#fecnac").val("");
	$("#fecingreso").val("");
	
	cargarServicios();
}

function guardar(){
	
	var ruta = obtenerContexto();
			
	jsonObj = [];
	var parametros = new Object();
	parametros.codigoGiro 		= $("#codigoGiro").val();
	parametros.nroPuesto 		= $("#puesto").val();
	parametros.codigoSocio 		= $("#codigoSocio").val();
	parametros.dni 				= $("#dni").val();
	parametros.apellidoPaterno 	= $("#apePaterno").val();
	parametros.apellidoMaterno 	= $("#apeMaterno").val();
	parametros.nombres 			= $("#nombres").val();
	parametros.fechaNacimiento 	= $("#fecnac").val();
	parametros.fechaIngreso 	= $("#fecingreso").val();
	parametros.padron 			= $("#padron").val();
	parametros.telefono 		= $("#telefono").val();
	parametros.celular 			= $("#celular").val();
	parametros.correo 			= "";
	
	$("#tablaServicios tr").each(function (item) {
        var this_row = $(this);
        var nombreCheck = $.trim(this_row.find('td:eq(2)').html());
        var codigoDetalle = $.trim(this_row.find('td:eq(3)').html());
        
        if(nombreCheck != ""){
        	
        	//console.log("nombreCheck : [" + nombreCheck + "] - codigoDetalle : " + codigoDetalle);
        	
        	if($("#" + nombreCheck).is(':checked')){  
                //console.log("Está activado");
                
                objetos = {};
                objetos.codigoServicioDetalle = codigoDetalle;
                jsonObj.push(objetos);
                
            }   
        	
        }
        
    });
	
	parametros.listaDetalle = JSON.stringify(jsonObj);
	
	$.ajax({
		type: "POST",
	    async:false,
	    url: "grabar-socio.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	            
	        if(result.camposObligatorios.length == 0){
                
	        	imagen = "";
	        	if(result.codigoRetorno == "00"){
            		$('#socio_modal').modal('hide');
            		imagen = "ok";
            		cargarSocios();
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

function buscarSocioEdicion(){
	
	var parametros = new Object();
	parametros.codigoSocio = $("#codigoSocio").val();
	
	$.ajax({
        type: "POST",
        async:false,
        url: "buscar-socio.json",
        cache : false,
        data: parametros,
        success: function(result){
            $("#dni").val(result.dni);
        	$("#apePaterno").val(result.apellidoPaterno);
        	$("#apeMaterno").val(result.apellidoMaterno);
        	$("#nombres").val(result.nombres);
        	$("#telefono").val(result.telefono);
        	$("#celular").val(result.celular);
        	$("#puesto").val(result.nroPuesto);
        	$("#padron").val(result.padron);
        	$("#fecnac").val(result.fechaNacimiento);
        	$("#fecingreso").val(result.fechaIngreso);
        }
    });
}

function editarSocio(codigoSocio, nroPuesto, codigoGiro, dni, nombreGiro){
	//console.log("Editar Puesto - [codigoPuesto] : " + codigoPuesto + ", [nroPuesto] : " + nroPuesto + ", [codigoUsuario] : " + codigoUsuario + ", [codigoGiro] : " + codigoGiro + ", [nombreGiro] : " + nombreGiro);
	
	$('#socio_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Modificar Socio");
	
	colorEtiquetas();
	
	$("#codigoSocio").val(codigoSocio);
	$("#codigoGiro").val(codigoGiro);
	
	$("#puesto").val(nroPuesto);
	$("#giroComercial").val(nombreGiro);
	
	buscarSocioEdicion();
	//cargarSocios();
	
	cargarServicios();
	
}

function eliminarSocio(codigoSocio, nombre, nroPuesto){
	
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
		parametros.codigoSocio = codigoSocio;
			
		$.ajax({
			type: "POST",
		    async:false,
		    url: "eliminar-socio.json",
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
	            
	            cargarSocios();
		            
			}
		});
		
    });

}

function cargarSocios(){
	
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		nombreGiro = replaceAll(rowObject.nombreGiro, " ", "#");
		nombre = replaceAll(nombreFull, " ", "#");
		var opciones = "<center>";
			
			opciones += "<a href=javascript:editarSocio(";
			opciones += rowObject.codigoSocio + ",'";
			opciones += rowObject.nroPuesto + "',";
			opciones += rowObject.codigoGiro + ",'";
			opciones += rowObject.dni + "','";
			opciones += nombreGiro + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Usuario'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:eliminarSocio(";
			opciones += rowObject.codigoSocio + ",'";
			opciones += nombre + "','";
			opciones += rowObject.nroPuesto + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/eliminar_24x24.png' border='0' title='Eliminar Puesto'/>";
			opciones += "</a>";
			
			opciones += "</center>";
			
		return opciones;
				
	};
	
	jQuery("#grilla").jqGrid(
	{
		url : 'reporte-socios.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		colNames : ['DNI', 'Nombres', 'Giro', 'Fec.Ingreso', 'Padron', 'Puesto', 'Opciones'],
		colModel : [{
			name : 'dni',
			index: 'dni',
			sortable:false,
			width: 90,
			align: 'center'
		},{
			name : 'nombreFull',
			index: 'nombreFull',
			sortable:false,
			width: 100,
			align: 'left'
		},{
			name : 'nombreGiro',
			index: 'nombreGiro',
			sortable:false,
			width: 100,
			align: 'left'
		},{
			name : 'fechaIngreso',
			index: 'fechaIngreso',
			sortable:false,
			width: 100,
			align: 'center'
		},{
			name : 'padron',
			index: 'padron',
			sortable:false,
			width: 100,
			align: 'center'
		},{
			name : 'nroPuesto',
			index: 'nroPuesto',
			sortable:false,
			width: 150,
			align: 'center'
		},{					
			name:'codigoSocio',
			index:'codigoSocio',
			width:100,
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
		sortorder : "dni",				
		caption : "Socios"				

	}).trigger('reloadGrid');
}

function buscarSocio(){
	
	var parametros=new Object();
	parametros.dni = $("#dniBuscara").val();

	$("#grilla").jqGrid('setGridParam',
	{
		url : 'reporte-socios.json',
		datatype : "json",
		postData:parametros,
		page:1
	}).trigger('reloadGrid');
		
}

</script>
</head>
<body id="body">
<input type="hidden" id="codigoSocio" />
<input type="hidden" id="codigoGiro" />
<table border="0" width="100%">
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td width="150"><b>DNI<b/></td>
		<td width="10">:</td>
		<td width="200"><input type="text" id="dniBuscara" class="form-control" maxlength="8" /></td>
		<td>&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" onclick="buscarSocio()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
			</button>&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" onclick="nuevoSocio()">
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

<div class="modal fade" id="socio_modal" role="dialog" data-keyboard="false" data-backdrop="static">
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
								<button type="button" class="btn btn-primary" onclick="guardar()">
									<img src="recursos/images/icons/guardar_16x16.png" alt="Buscar" />&nbsp;Guardar
								</button>
							</td>
						</tr>
						<tr>
							<td colspan="7" align="right">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lbldni"><b>DNI (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="dni" class="form-control" maxlength="8" /></td>
							<td valign="top"><img id="lbldni-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblapepat"><b>Apellido Paterno (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="apePaterno" class="form-control" maxlength="30" /></td>
							<td valign="top"><img id="lblapepat-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblapemat"><b>Apellido Materno (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="apeMaterno" class="form-control" maxlength="30" /></td>
							<td valign="top"><img id="lblapemat-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblnombres"><b>Nombres (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="nombres" class="form-control" maxlength="40" /></td>
							<td valign="top"><img id="lblnombres-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblfecnac"><b>Fecha de Nacimiento (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="fecnac" class="form-control" maxlength="10"/></td>
							<td valign="top"><img id="lblfecnac-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblfecingreso"><b>Fecha de Ingreso (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="fecingreso" class="form-control" maxlength="10"/></td>
							<td valign="top"><img id="lblfecingreso-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lbltelefono"><b>Telefono</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="telefono" class="form-control" maxlength="9" /></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblCelular"><b>Celular</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="celular" class="form-control" maxlength="9" /></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblgiroComercial"><b>Giro Comercial (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="giroComercial" class="form-control" /></td>
							<td valign="top"><img id="lblgiroComercial-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblpuesto"><b>Puesto (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="puesto" class="form-control" maxlength="4" /></td>
							<td valign="top"><img id="lblpuesto-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblpadron"><b>Padrón (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="padron" class="form-control" maxlength="4" /></td>
							<td valign="top"><img id="lblpadron-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><b>Servicios</b></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td colspan="3">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="7">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="4">&nbsp;</td>
							<td colspan="3">
								<div id="servicios" />
							</td>
						</tr>
						<tr>
							<td colspan="7">&nbsp;</td>
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
	
</body>
</html>