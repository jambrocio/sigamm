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
$(document).ready(function() 
{	
	$("#fecnac").datepicker({
	    changeMonth: true,
		changeYear: true,
		//showButtonPanel: true,
		dateFormat: 'dd/mm/yy'
	});
	
	$("#fecnacNuevo").datepicker({
	    changeMonth: true,
		changeYear: true,
		//showButtonPanel: true,
		dateFormat: 'dd/mm/yy'
	});
	
	//$( ".selector" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
		
	$('[data-toggle="popover"]').popover({ placement : 'right', trigger: "hover" });
	/*
	$('[data-toggle="popover"]').on('hidden.bs.popover', function(){
        alert("Popover has been completely closed.");
    });
	*/
	
	//$('[data-toggle="popover"]').popover({ trigger: "hover", delay: {show: 50, hide: 400} });
	//$("#popover").popover({ trigger: "hover" });
	//$('body').popover({ selector: '[data-popover]', trigger: 'click hover', placement: 'auto', delay: {show: 50, hide: 400}});
	//$('body').popover({ trigger: 'click hover', delay: {show: 50, hide: 400}});
	
	//$('.popover-show').popover('show');
    //$('.popover-hide').popover('hide');
    //$('.popover-destroy').popover('destroy');
    //$('.popover-toggle').popover('toggle');
    
	cargarUsuarios();
	cargarUnidad();
	
});

function cargarUnidad(){
	
	$.ajax({
        type: "GET",
        async:false,
        url: "listar-unidad.json",
        cache : false,
        success: function(result){
            
        	selectUt = "<option value=0>SELECCIONAR</option>";
    		$.each(result.rows, function(key,val) {
    			selectUt += "<option value=" + val.codigoUnidad + ">" + val.nombreUnidad + "</option>";
    		});
    		
    		$("#unidad").html(selectUt);
            
        }
    });
        	
}

function buscarUnidad(){
	
	var parametros=new Object();
	parametros.codigoEleccion = 1;
	parametros.codigoUnidad = $("#unidad").val();

	$("#grilla").jqGrid('setGridParam',
	{
		url : 'listar-usuarios.json',
		datatype : "json",
		postData:parametros,
		page:1
	}).trigger('reloadGrid');
		
}

function editarUsuario(codigoUsuario, userid, dni, apePaterno, apeMaterno, nombres, codigoRol, codigoUnidad, estado, correo, telefono, serie, fecnac){
	
	$('#usuario_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Editar Usuario");
	
	$("#editarUsuario").show();
	$("#nuevoUsuario").hide();
	
	colorEtiquetas();
	
	$("#userid").html(userid);
	$("#dni").val(dni);
	$("#apePaterno").val(replaceAll(apePaterno, "#", " "));
	$("#apeMaterno").val(replaceAll(apeMaterno, "#", " "));
	$("#nombres").val(replaceAll(nombres, "#", " "));
	$("#fecnac").val(fecnac);
	
	$("#estado").val(estado);
	$("#correo").val(correo);
	$("#telefono").val(telefono);
	$("#serie").val(serie);
	
	listarUnidad();
	$("#unidadTerritoral").val(codigoUnidad);
	
	listarRol();
    $("#rol").val(codigoRol);
	
	$("#codigoUsuario").val(codigoUsuario);
	
	$("#estado").attr("disabled", false);
	
}

function colorEtiquetas(){
	
	$("#lblusuario").css("color", "black");
	$("#lbldni").css("color", "black");
	$("#lblapepat").css("color", "black");
	$("#lblapemat").css("color", "black");
	$("#lblnombres").css("color", "black");
	$("#lblfecnac").css("color", "black");
	$("#lblcorreo").css("color", "black");
	$("#lblut").css("color", "black");
	$("#lblrol").css("color", "black");
	
	$("#lblusuario-img").hide();
	$("#lbldni-img").hide();
	$("#lblapepat-img").hide();
	$("#lblapemat-img").hide();
	$("#lblnombres-img").hide();
	$("#lblfecnac-img").hide();
	$("#lblcorreo-img").hide();
	$("#lblut-img").hide();
	$("#lblrol-img").hide();
}

function nuevoUsuario(){
	
	$('#usuario_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Nuevo Usuario");
	
	$("#editarUsuario").hide();
	$("#nuevoUsuario").show();
	
	colorEtiquetas();
	
	$("#codigoUsuario").val(0);
	
	$("#useridNuevo").val("");
	$("#dni").val("");
	$("#apePaterno").val("");
	$("#apeMaterno").val("");
	$("#nombres").val("");
	$("#fecnac").val("");
	$("#correo").val("");
	$("#telefono").val("");
	$("#serie").val("");
	
	$("#estado").val("ACTIVO");
	$("#estado").attr("disabled", true); 
	
	listarUnidad();
	
	//listarRol();
    
}

function cargarUsuarios(){
	
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		userid = rowObject.userid;
		apePaterno = replaceAll(rowObject.apellidoPaterno, " ", "#");
		apeMaterno = replaceAll(rowObject.apellidoMaterno, " ", "#");
		nombres = replaceAll(rowObject.nombres, " ", "#");
		serie = rowObject.serie;
		serie = replaceAll(serie.trim(), " ", "#");
		if(rowObject.dni == null || rowObject.dni == ""){
			dni = "";
		}else{
			dni = rowObject.dni; 
		}
		
		if(rowObject.telefono == null || rowObject.telefono == ""){
			telefono = "";
		}else{
			telefono = rowObject.telefono; 
		}
		
		if(rowObject.correo == null || rowObject.correo == ""){
			correo = "";
		}else{
			correo = rowObject.correo; 
		}
		
		var opciones = "<center>";
			
			opciones += "<a href=javascript:editarUsuario(";
			opciones += rowObject.codigoUsuario + ",'";
			opciones += userid + "','";
			opciones += dni  + "','";
			opciones += apePaterno  + "','";
			opciones += apeMaterno  + "','";
			opciones += nombres  + "',";
			opciones += rowObject.codigoRol  + ",";
			opciones += rowObject.codigoUnidad  + ",'";
			opciones += rowObject.estado + "','";
			opciones += correo + "','";
			opciones += telefono + "','";
			opciones += serie  + "','";			
			opciones += rowObject.fechaNacimiento + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Usuario'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:resetearUsuario(";
			opciones += rowObject.codigoUsuario + ",'";
			opciones += userid + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/reset_24x24.png' border='0' title='Resetear Clave'/>";
			opciones += "</a>";
			
			opciones += "</center>";
			
		return opciones;
				
	};
	
	jQuery("#grilla").jqGrid(
	{
		url : 'listar-usuarios.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		colNames : ['Usuario', 'DNI', 'Ap.Paterno', 'Ap.Materno', 'Nombres', 'Fecha Nacimiento', 'Telefono', 'Correo', 'Unidad', 'Rol', 'Serie', 'Estado', 'Opciones'],
		colModel : [{
			name : 'userid',
			index: 'userid',
			sortable:true,
			width: 100,
			align: 'left'						
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
			name : 'fechaNacimiento',
			index: 'fechaNacimiento',
			sortable:false,
			width: 110,
			align: 'center'
		},{
			name : 'telefono',
			index: 'telefono',
			sortable:false,
			width: 90,
			align: 'center'
		},{
			name : 'correo',
			index: 'correo',
			sortable:false,
			width: 250,
			align: 'left'
		},{
			name : 'nombreUnidad',
			index: 'nombreUnidad',
			sortable:false,
			width: 200,
			align: 'center'
		},{
			name : 'nombreRol',
			index: 'nombreRol',
			sortable:false,
			width: 200,
			align: 'center'
		},{
			name : 'serie',
			index: 'serie',
			sortable:false,
			width: 100,
			align: 'center'
		},{
			name : 'estado',
			index: 'estado',
			sortable:false,
			width: 100,
			align: 'center'
		},{					
			name:'codigoUsuario',
			index:'codigoUsuario',
			width:100,
			sortable:false,
			search: false,
			formatter:formatterBotones
		}],								
		rowNum : 20,
		//rowList : [ 20, 30, 40 ],
		pager : '#pgrilla',
		sortname : 'userid',
		autowidth: true,
		rownumbers: true,
		viewrecords : true,
		sortorder : "userid",				
		caption : "Usuarios"				

	}).trigger('reloadGrid');
}

function listarRol(){
	
	ut = $("#unidadTerritoral").val();
	
	$.ajax({
        type: "POST",
        async:false,
        url: "listar-rol.json?codigoUnidad=" + ut,
        cache : false,
        success: function(result){
            
        	selectRol = "<option value=0>SELECCIONAR</option>";
    		$.each(result.rows, function(key,val) {
    			selectRol += "<option value=" + val.codigoRol + ">" + val.nombreRol + "</option>";
    		});
    		
    		$("#rol").html(selectRol);
            
        }
    });
}

function listarUnidad(){
	
	$.ajax({
        type: "GET",
        async:false,
        url: "listar-unidad.json",
        cache : false,
        success: function(result){
            
        	selectUt = "<option value=0>SELECCIONAR</option>";
    		$.each(result.rows, function(key,val) {
    			selectUt += "<option value=" + val.codigoUnidad + ">" + val.nombreUnidad + "</option>";
    		});
    		
    		$("#unidadTerritoral").html(selectUt);
            
        }
    });
	
}

function guardar(tipoRegistro){
	
	var ruta = obtenerContexto();
			
	jsonObj = [];
	var parametros = new Object();
	if(tipoRegistro == 1){
		
		parametros.tipoRegistro = 1;
		parametros.codigoUsuario = $("#codigoUsuario").val();
		parametros.userid = $("#useridNuevo").val();
		parametros.apellidoPaterno = $("#apePaterno").val();
		parametros.apellidoMaterno = $("#apeMaterno").val();
		parametros.nombres = $("#nombres").val();
		parametros.fechaNacimiento = $("#fecnac").val();
		parametros.codigoRol = $("#rol").val();
		parametros.codigoUnidad = $("#unidadTerritoral").val();
		parametros.estado = $("#estado").val();
		parametros.telefono = $("#telefono").val();
		parametros.correo = $("#correo").val();
		parametros.dni = $("#dni").val();
		parametros.serie = $("#serie").val();
		
		if(parametros.codigoUsuario == 0){
			mensaje = "Se registro satisfactoriamente el usuario.";
		}else{
			mensaje = "Se modifico satisfactoriamente el usuario.";
		}
		
		
		$.ajax({
	        type: "POST",
	        async:false,
	        url: "grabar-usuario.json",
	        cache : false,
	        data: parametros,
	        success: function(result){
	            
	        	//alert("idUsuario : " + result.idUsuario + "\nLenCamposObligatorios : " + result.camposObligatorios.length);
                
                if(result.camposObligatorios.length == 0){
                	
                	$('#usuario_modal').modal('hide');
                	
	            	cargarUsuarios();
	            	
	            	$.gritter.add({
						// (string | mandatory) the heading of the notification
						title: 'Mensaje',
						// (string | mandatory) the text inside the notification
						text: mensaje,
						// (string | optional) the image to display on the left
						image: "/" + ruta + "/recursos/images/confirm.png",
						// (bool | optional) if you want it to fade out on its own or just sit there
						sticky: false,
						// (int | optional) the time you want it to be alive for before fading out
						time: ''
					});
                }else{
                	
                	colorEtiquetas();
                	fila = "";
                	$.each(result.camposObligatorios, function(id, obj){
                        //alert("id : " + id +  "\nnombreCampo : " + obj.nombreCampo + "\nDescripcion : " + obj.descripcion);
                        /*
                        fila += "<tr>";
                        fila += "<td valign='top'>" + obj.nombreCampo + "</td>"
                        fila += "<td>" + ":" + "</td>"
                        fila += "<td>" + obj.descripcion + "</td>"
                        fila += "</tr>";
                        fila += "<tr><td colspan=3>";
                        fila += "<hr align=center size=2 width=100% />";
                        fila += "</td></tr>";
                        */
                        //$("#" + obj.nombreCampo + "-img").popover({ placement : 'top', trigger: "hover" });
                      	//$('[data-toggle="popover"]').popover({ placement : 'top', trigger: "hover" });
                        $("#" + obj.nombreCampo).css("color", "red");
                        $("#" + obj.nombreCampo + "-img").show();
                        $("#" + obj.nombreCampo + "-img").attr("data-content", obj.descripcion);
                        
                    });
                	
				}
                
	        }
	    });
	}
}

function resetearUsuario(codigo, userid){
	
	mensaje = "Desea Resetear la clave del usuario " + userid + " ?";
	$("#mensajeAlerta").html(mensaje);
	
	$("#dialog-confirm").dialog({
		resizable: false,
	    height:250,
	    modal: true,
	    buttons: {
	    	"Si": function() {
	        	//$(this).dialog( "close" );
	        	resetear(codigo, userid);
			},
	        "No": function() {
	        	$(this).dialog( "close" );
			}
		}
	});
	
}

function resetear(codigo, userid){
	
	var ruta = obtenerContexto();
	
	var parametros = new Object();
	parametros.codigoUsuario = codigo;
	
	$.ajax({
        type: "POST",
        async:false,
        url: "resetear-clave.json",
        cache : false,
        data: parametros,
        success: function(result){
            //console.log(result.codigo);
        	//alert("Resultado : [" + result.codigo + "]");
        	if(result.codigo == "00"){
        		
        		$.gritter.add({
					// (string | mandatory) the heading of the notification
					title: 'Mensaje',
					// (string | mandatory) the text inside the notification
					text: "Se reseteo la clave del usuario " + userid + " con exito.",
					// (string | optional) the image to display on the left
					image: "/" + ruta + "/recursos/images/confirm.png",
					// (bool | optional) if you want it to fade out on its own or just sit there
					sticky: false,
					// (int | optional) the time you want it to be alive for before fading out
					time: ''
				});
        	}else{
        		
        		$.gritter.add({
					// (string | mandatory) the heading of the notification
					title: 'Mensaje',
					// (string | mandatory) the text inside the notification
					text: "Se produjo un error al resetear la clave del usuario " + userid,
					// (string | optional) the image to display on the left
					image: "/" + ruta + "/recursos/images/confirm.png",
					// (bool | optional) if you want it to fade out on its own or just sit there
					sticky: false,
					// (int | optional) the time you want it to be alive for before fading out
					time: ''
				});
        		
        	}
        }
    });
	
	$("#dialog-confirm").dialog("close");
}

</script>
</head>
<body id="body">
<input type="hidden" id="codigoUsuario">	
<table border="0" width="100%">
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td width="150"><b>Unidad<b/></td>
		<td width="10">:</td>
		<td width="200"><select id="unidad" class="form-control" /></td>
		<td>&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" onclick="buscarUnidad()">
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

<div class="modal fade" id="usuario_modal" role="dialog" data-keyboard="false" data-backdrop="static">
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
							<td><span id="lblusuario"><b>Usuario (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td>
								<div id="editarUsuario">
									<b><span id="userid" /></b>
								</div>
								<div id="nuevoUsuario">
									<input type="text" id="useridNuevo" class="form-control" maxlength="20" />
								</div>
							</td>
							<td valign="top"><img id="lblusuario-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
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
							<td><span id="lblcorreo"><b>Correo (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="correo" class="form-control" maxlength="30"/></td>
							<td valign="top"><img id="lblcorreo-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lbltelefono"><b>Telefono</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="telefono" class="form-control" maxlength="9"/></td>
							<td valign="top"><img id="lbltelefono-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblut"><b>Unidad (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><select id="unidadTerritoral" class="form-control" onchange="listarRol();" /></td>
							<td valign="top"><img id="lblut-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblrol"><b>Rol (*)</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><select id="rol" class="form-control" /></td>
							<td valign="top"><img id="lblrol-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><b>Estado</b></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td>
								<select id="estado" class="form-control">
									<option value="ACTIVO">ACTIVO</option>
									<option value="INACTIVO">INACTIVO</option>
								</select>
							</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblserie"><b>Nro.Serie</b></span></td>
							<td width="5px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="5px">&nbsp;</td>
							<td><input type="text" id="serie" class="form-control" maxlength="4" /></td>
							<td valign="top"><img id="lblserie-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
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
 
<div id="dialog-confirm" title="Mensaje">
	<br>
  	<p><b><span id="mensajeAlerta" /></b></p>
</div>

</body>
</html>