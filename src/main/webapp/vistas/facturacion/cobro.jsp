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
        url: "listar-concepto.json",
        cache: false,
        success: function(result){
        	
        	$("#concepto").autocomplete(result, {
                formatItem: function(item) {
                    return item.nombreConcepto;
                },
                width: 460,
                scroll: true,
                matchContains: true,
                minChars: 0//cuando se presiona el boton de flecha hacia abajo se muestra toda la lista
            }).result(function(event, item) {
            	
            	$("#codigoConcepto").val(item.codigoConcepto);
            	
            });
        	
        }
    });
	
});

function buscarUsuarioXDni(){
	
	dni = $("#dniBuscar").val();
	
	var parametros = new Object();
	parametros.dni = dni;
	
	$.ajax({
        type: "POST",
        async:false,
        url: "reporte-puestos.json",
        cache : false,
        data: parametros,
        success: function(result){
            select = "";
        	$.each(result.rows, function(id, obj){
                
                select += "<option value=" + obj.codigoPuesto + " >" + obj.nroPuesto + "</option>"; 
                       
			});
			
			$("#puesto").html(select);
			
        }
    });
}

function colorEtiquetas(){
	
	$("#lblpuesto").css("color", "black");
	$("#lblgiroComercial").css("color", "black");
	
	$("#lblpuesto-img").hide();
	$("#lblgiroComercial-img").hide();
	
}

function nuevoCobro(){
	
	colorEtiquetas();
	
	$("#codigoPuesto").val(0);
	$("#codigoUsuario").val(0);
	$("#codigoConcepto").val(0);
	
	$("#dniBuscar").val("");
	$("#concepto").val("");
	$("#monto").val("");
	
	$("#dni").val("");
	$("#userid").val("");
	$("#apePaterno").val("");
	$("#apeMaterno").val("");
	$("#nombres").val("");
	$("#telefono").val("");
	
	$("#btnBuscar").attr("disabled", false);
	
	buscarUsuarioXDni();
}

function guardar(){
	
	var ruta = obtenerContexto();
			
	jsonObj = [];
	var parametros = new Object();
	parametros.codigoUsuario = $("#codigoUsuario").val();
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
	            
	            //cargarPuestos();
	            
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
        	
        	buscarUsuarioXDni();
        	
        	$("#btnBuscar").attr("disabled", true);
        	
        }
    });
}

function agregarConcepto(){
	
	var ruta = obtenerContexto();
	codigoConcepto = $("#codigoConcepto").val();
	descripcionConcepto = $("#concepto").val();
	monto = $("#monto").val();
	
	if(monto == ""){
		alert("Debe agregar un nombre.")
	}else{
		$('#tabla_resultado tbody tr:last').after(
			"<tr>" +
            "<td align='right'>1</td>" + 
            "<td align='center'>" + codigoConcepto + "</td>" +
			"<td align='left'>" + descripcionConcepto + "</td>" +
			"<td align='right'>" + monto + "</td>" +
			"<td align='center'>" +
			"<button type='button' class='boton' onclick='eliminarFila(this);'>" +
				"<img src='/"+ruta+"/recursos/images/icons/eliminar_24x24.png' alt='Eliminar' />" +
			"</button></td>" +
			"</tr>");
			
		$("#monto").val("");
		$("#concepto").val("");
		$("#codigoConcepto").val("0");
	}
	
	calculoTotal();
}

function calculoTotal(){
	
	var total = 0;
    $("#tabla_resultado tbody tr").each(function (item) {
        var this_row = $(this);
        var monto = $.trim(this_row.find('td:eq(3)').html());
		if(monto != "" && monto != "Monto"){
			console.log("[" + monto + "]");
			total = parseFloat(total) + parseFloat(monto);
		}
    });
	
	$("#totalesLetras").html(NumeroALetras(total));
	$("#totales").html(total);
}

function eliminarFila(t){

	var td = t.parentNode;
    var tr = td.parentNode;
    var table = tr.parentNode;
	table.removeChild(tr);
	calculoTotal();
	
}
</script>
</head>
<body id="body">
<input type="hidden" id="codigoPuesto" />
<input type="hidden" id="codigoUsuario" />
<input type="hidden" id="codigoConcepto" />
<table border="0" style="width: 500px;">
	<tr>
		<td colspan="7" align="right">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="7" align="left">
			<button type="button" class="btn btn-primary" onclick="nuevoCobro()">
				<img src="recursos/images/icons/nuevo_16x16.png" alt="Nuevo" />&nbsp;Nuevo
			</button>
			&nbsp;
			<button type="button" class="btn btn-primary" onclick="guardar(1)">
				<img src="recursos/images/icons/guardar_16x16.png" alt="Buscar" />&nbsp;Guardar
			</button>
			&nbsp;
			<button type="button" class="btn btn-primary">
				<img src="recursos/images/icons/guardar_16x16.png" alt="Reservar" />&nbsp;Reservar
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
			<button type="button" id="btnBuscar" class="btn btn-primary" onclick="buscarUsuario()">
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
		<td><span id="lbltelefono"><b>Puesto</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td><select id="puesto" class="form-control" /></td>
		<td valign="top"><img id="lblpuesto-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td><span id="lblconcepto"><b>Concepto</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td><input type="text" id="concepto" class="form-control" maxlength="4" /></td>
		<td valign="top"><img id="lblconcepto-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td><span id="lblmonto"><b>Monto</b></span></td>
		<td width="5px">&nbsp;</td>
		<td><b>:</b></td>
		<td width="5px">&nbsp;</td>
		<td><input type="text" id="monto" class="form-control" maxlength="4" /></td>
		<td valign="top"><img id="lblmonto-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
	</tr>
	<tr>
		<td width="10px">&nbsp;</td>
		<td>&nbsp;</td>
		<td width="5px">&nbsp;</td>
		<td>&nbsp;</td>
		<td width="5px">&nbsp;</td>
		<td>
			<button type="button" class="btn btn-primary" onclick="agregarConcepto()">
				<img src="recursos/images/icons/guardar_16x16.png" alt="Agregar" />&nbsp;Agregar
			</button>
		</td>
		<td valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="7">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="7">
			<table border="1" width="100%" id="tabla_resultado" cellspacing="1" cellpadding="1" class="tabla" width="50%">
				<tr>
					<td align="center">Nro</td>
					<td align="center">Cod.Concepto</td>
					<td align="center">Desc.Concepto</td>
					<td align="center">Monto</td>
					<td align="center">Accion</td>
				</tr>
				<tfoot>
				<tr>
					<td colspan="3" align="left"><b><span id="totalesLetras" /></b></td>
					<td align="right"><b><span id="totales" /></b></td>
					<td align="center"></td>
				</tr>
				</tfoot>
			</table>
		</td>
	</tr>
</table>	
	
</body>
</html>