<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:f="http://java.sun.com/jsf/core" xmlns:h="http://java.sun.com/jsf/html">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title></title>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#candidato_container").dialog({
    	autoOpen:false,
        width: 650,
        height: 500,
        modal: false,
        resizable: false
    });
	
	listarCandidatos();
	
});

function listarCandidatos(){
	
	existeVoto = 0;
	cantidadRegistros = 0;
	divisor = "<table id='tablaCandidatos' border='0' cellpadding='5' cellspacing='5' >";
	$.ajax({
        type: "POST",
        async:false,
        url: "listar-resultado-elecciones.json",
        cache : false,
        success: function(result){
            
        	divisor += "<tr>";
        	divisor += "<td colspan='3' align='right'>";
        	divisor += "<button type='button' class='btn btn-primary'>";
        	divisor += "<img src='recursos/images/icons/pdf_32x32.png' alt='Exportar a PDF' />&nbsp;<a href='<%=request.getContextPath()%>/generarPdf' target='_blank' style='color:white'>Exportar PDF</a>";
        	divisor += "</button>";
        	divisor += "</td>";
        	divisor += "</tr>";
        	divisor += "<tr><td colspan=4 valign=middle><hr style='color: #3496C4; background-color: #3496C4; height: 2px;' /></td></tr>";
        	
        	$.each(result.rows, function(key,val) {
    			
        		cantidadRegistros = cantidadRegistros + 1; 
        		
        		nombreUt = replaceAll(val.nombreUt, " ", "$");
        		nombreRol = replaceAll(val.nombreRol, " ", "$");
        		apellidoPaterno = replaceAll(val.apellidoPaterno, " ", "$");
        		apellidoMaterno = replaceAll(val.apellidoMaterno, " ", "$");
        		nombres = replaceAll(val.nombres, " ", "$");
        		
        		datos = nombres;   
        		
        		divisor += "<tr>";
        		divisor += "<td valign='top'>&nbsp;&nbsp;<b>" + (key + 1) + "</b>&nbsp;&nbsp;</td>";
        		divisor += "<td valign='top'><img id='foto_" + val.dni + "_100' src='recursos/images/nodisponible_250x250.gif' /></td>";
        		divisor += "<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>";
        		divisor += "<td><center><b>CANDIDATO N° " + val.orden + "<br>" + val.nombres + "</b><br>" + val.nombreRol + "<br>" + val.nombreUt + "<br><b><font color='red'>Votos : " + val.cantidadVotos + "</font></b></center>";
        		divisor += "<br><br><center>";
        		divisor += "<a href=javascript:mostrarCandidato(";
        		divisor += val.codigoEleccion + ",";
        		divisor += val.orden + ",";
        		divisor += val.cantidadVotos + ",";
        		divisor += val.codigoUsuario + ",'";
        		divisor += val.dni + "','";
    			divisor += nombreUt + "','";
    			divisor += nombreRol + "','";
    			divisor += datos + "') >";
    			divisor += "Ver información</a></center></td>";
        		divisor += "</tr>";
        		divisor += "<tr><td colspan=4 valign=middle><hr style='color: #3496C4; background-color: #3496C4; height: 2px;' /></td></tr>";
        		
        		existeVoto = val.existeVoto;
    		});
    		
        	divisor += "</table>";
        	$("#candidatos").html(divisor);
        	
        	
			$.each(result.rows, function(key,val) {
    			$("#foto_" + val.dni + "_100").attr("src", "mostrarImagenPersonal/" + val.dni + "_100");
    		});
				
        }
    });
}

function mostrarCandidato(codigoEleccion, orden, votos, codigoUsuario, dni, ut, rol, datos){
	
	$("#candidato_container").dialog("open");
	$("#foto_candidato").attr("src", "mostrarImagenPersonal/" + dni + "_250");
	$("#orden").html("CANDIDATO N° " + orden);
	$("#votos").html("<font color='red'>Votos : " + votos + "</font>");
	$("#ut").html(replaceAll(ut, "$", " "));
	$("#rol").html(replaceAll(rol, "$", " "));
	$("#nombres").html(replaceAll(datos, "$", " "));
	
}

</script>
</head>
<body>
<div id="candidatos" />

<div id="candidato_container" title="Candidato">
	<br/>
	<table border="0" align="left" cellpadding="5" cellspacing="5" width="100%">
		<tr>
			<td>
				<img id="foto_candidato" src="recursos/images/icons/guardar_16x16.png" />
			</td>
			<td>&nbsp;&nbsp;</td>
			<td valign="top">
				<br />&nbsp;&nbsp;
				<table border="0" cellpadding="15" cellspacing="15" align="center">
					<tr>
						<td align="center"><span id="orden" /></td>
					</tr>
					<tr>
						<td align="center"><span id="nombres" /></td>
					</tr>
					<tr>
						<td align="center"><span id="rol" /></td>
					</tr>
					<tr>
						<td align="center"><span id="ut" /></td>
					</tr>
					<tr>
						<td align="center"><span id="votos" /></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>

</body>
</html>