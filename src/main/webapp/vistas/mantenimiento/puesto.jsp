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

function cargarPuestos(){
	
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		nombreGiro = replaceAll(rowObject.nombreGiro, " ", "#");
		nombre = replaceAll(nombreFull, " ", "#");
		var opciones = "<center>";
			
			opciones += "<a href=javascript:editarPuesto(";
			opciones += rowObject.codigoPuesto + ",'";
			opciones += rowObject.nroPuesto + "',";
			opciones += rowObject.codigoUsuario  + ",";
			opciones += rowObject.codigoGiro + ",'";
			opciones += rowObject.dni + "','";
			opciones += nombreGiro + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Usuario'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:eliminarPuesto(";
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
		url : 'reporte-puestos.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		colNames : ['DNI', 'Nombres', 'Giro', 'Puesto', 'Opciones'],
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
			name : 'nroPuesto',
			index: 'nroPuesto',
			sortable:false,
			width: 150,
			align: 'center'
		},{					
			name:'codigoPuesto',
			index:'codigoPuesto',
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
		caption : "Puestos"				

	}).trigger('reloadGrid');
}

function buscarPuesto(){
	
	var parametros=new Object();
	parametros.dni = $("#dniBuscara").val();

	$("#grilla").jqGrid('setGridParam',
	{
		url : 'reporte-puestos.json',
		datatype : "json",
		postData:parametros,
		page:1
	}).trigger('reloadGrid');
		
}

</script>
</head>
<body id="body">
<input type="hidden" id="codigoPuesto" />
<input type="hidden" id="codigoUsuario" />
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
	
</body>
</html>