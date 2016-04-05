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
	
	cargarServicios();
	
});

function colorEtiquetas(){
	
	$("#lblcboServicio").css("color", "black");
	$("#lblcboServicioDetalle").css("color", "black");
	$("#lblresponsable").css("color", "black");
	$("#lbldniAsociado").css("color", "black");
	$("#lblnombresAsociado").css("color", "black");
	
	$("#lblcboServicio").hide();
	$("#lblcboServicioDetalle").hide();
	$("#lblresponsable").hide();
	$("#lbldniAsociado").hide();
	$("#lblnombresAsociado").hide();
		
}

function nuevoOtroServicio(){
	
	$('#socio_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Otros Servicios");
	
	colorEtiquetas();
	
	$("#codigoSocio").val(0);
	
	$("#inicio").val("");
	$("#fin").val("");
	$("#responsable").val("");
	$("#dniAsociado").val("");
	$("#nombresAsociado").val("");
	
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

function cargarServicios(){
	
	$.ajax({
        type: "POST",
        async: false,
        url: "cargar-otros-servicios.json",
        cache: false,
        success: function(result){
        	
        	var optionServicios = "<option value=0>SELECCIONAR</option>";
        	$.each(result, function(keyM, serv) {
        		
        		optionServicios += "<option value=" + serv.codigoServicio + ">" + serv.nombreServicio + "</option>";
        		
        	});
        	
        	$("#cboServicio").html(optionServicios);
    		
        }
    });
	
}

function cargarServiciosDetalle(){
	
	var parametros = new Object();
	parametros.codigoServicio = $("#cboServicio").val();
	
	$.ajax({
        type: "POST",
        async: false,
        url: "cargar-otros-servicios-detalle.json",
        cache: false,
        data: parametros,
        success: function(result){
        	
        	var optionServicios = "<option value=0>SELECCIONAR</option>";
        	$.each(result, function(keyM, serv) {
        		
        		optionServicios += "<option value=" + serv.codigoServicioDetalle + ">" + serv.nombreDetalle + "</option>";
        		
        	});
        	
        	$("#cboServicioDetalle").html(optionServicios);
    		
        }
    });
	
}
</script>
</head>
<body id="body">
<input type="hidden" id="codigoSocio" />
<input type="hidden" id="codigoGiro" />
<table border="0" width="100%">
	<tr>
		<td colspan="7">&nbsp;</td>
	</tr>
	<tr>
		<td width="150"><b>DNI<b/></td>
		<td width="10">:</td>
		<td width="100"><input type="text" id="dniBuscara" class="form-control" maxlength="8" /></td>
		<td>&nbsp;&nbsp;</td>
		<td width="150"><b>NOMBRE<b/></td>
		<td width="10">:</td>
		<td width="250"><input type="text" id="nombreBuscara" class="form-control" maxlength="150" /></td>		
	</tr>
	<tr><td colspan="7">&nbsp;</td></tr>
	<tr>
		<td colspan=7>&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" onclick="buscarSocio()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
			</button>&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" onclick="nuevoOtroServicio()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Nuevo" />&nbsp;Nuevo
			</button>
			<button type="button" class="btn btn-primary">
				<img src="recursos/images/icons/excel_16x16.png" alt="Exportar a Excel" />&nbsp;<a href="/sigamm/reporteSociosExcel" style="color:white">Exportar</a>
			</button>
		</td>
	</tr>
	<tr>
		<td colspan="7">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="7">
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
							<td><span id="lbldni"><b>Servicio (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><select id="cboServicio" class="form-control" onchange="cargarServiciosDetalle();" /></td>
							<td valign="top"><img id="lblcboServicio-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblapepat"><b>Detalle (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><select id="cboServicioDetalle" class="form-control" /></td>
							<td valign="top"><img id="lblcboServicioDetalle-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblfecnac"><b>Responsable (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="responsable" class="form-control" maxlength="100"/></td>
							<td valign="top"><img id="lblresponsable-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblfecingreso"><b>DNI Asociado (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="dniAsociado" class="form-control" maxlength="8"/></td>
							<td valign="top"><img id="lbldniAsociado-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lbltelefono"><b>Nombres Asociado</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="nombresAsociado" class="form-control" maxlength="100" /></td>
							<td valign="top"><img id="lblnombresAsociado-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblapemat"><b>Inicio (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="inicio" class="form-control" maxlength="30" /></td>
							<td valign="top"><img id="lblinicio-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblnombres"><b>Fin (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="fin" class="form-control" maxlength="40" /></td>
							<td valign="top"><img id="lblfin-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
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
				<h4 class="modal-title">Eliminar Otros Servicios</h4>
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