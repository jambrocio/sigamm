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

$(document).ready(function() 
{	
    //initialize();
    //plotPoint(coords.lat,coords.lng,'Mall of America','<span class="gBubble"><b>Mall of America</b><br>60 East Brodway<br>Bloomington, MN 55425</span>');
   
    //cargarRegistros();   
});

$(function($){
    $.datepicker.regional['es'] = {
        closeText: 'Cerrar',
        prevText: '<Ant',
        nextText: 'Sig>',
        currentText: 'Hoy',
        monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
        monthNamesShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],
        dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
        dayNamesShort: ['Dom','Lun','Mar','Mié','Juv','Vie','Sáb'],
        dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
        weekHeader: 'Sm',
        dateFormat: 'dd/mm/yy',
        firstDay: 1,
        isRTL: false,
        showMonthAfterYear: false,
        yearSuffix: ''
    };
    $.datepicker.setDefaults($.datepicker.regional['es']);
});

$(function() {
    
	$("#fechainicial").datepicker(
    {   
        changeMonth: true,
        changeYear: true,
        numberOfMonths: 1,
        dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
        monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo',
            'Junio', 'Julio', 'Agosto', 'Septiembre',
            'Octubre', 'Noviembre', 'Diciembre'],
        monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr',
            'May', 'Jun', 'Jul', 'Ago',
            'Sep', 'Oct', 'Nov', 'Dic'] 
    });  

	$("#fechafinal").datepicker(
    {   
        changeMonth: true,
        changeYear: true,
        numberOfMonths: 1,
        dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
        monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo',
            'Junio', 'Julio', 'Agosto', 'Septiembre',
            'Octubre', 'Noviembre', 'Diciembre'],
        monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr',
            'May', 'Jun', 'Jul', 'Ago',
            'Sep', 'Oct', 'Nov', 'Dic'] 
    }); 
	
 
});

function openNewWindowForJasperWithCharts(){
	var numeroPuesto = $("#numeropuesto").val();
	var fechaInicial = $("#fechainicial").val();
	var url  = "/sigamm/recibosEstadoCuenta?numeroPuesto="+numeroPuesto+"&fechaInicial="+fechaInicial;
	var strWindowFeatures = "menubar=no,location=no,width=800,height=500";
	window.open(url,"_blank", "location=0,height=500,width=800");
}

</script>
</head>
<body id="body">

	<table border="0" align="center" class="centrar">
		<tr>
			<td>
				<div class="panel panel-primary">
					<div class="panel-heading">Estado de Cuenta General</div>
					<div class="panel-body">
					<form style="margin-top: 1.0em;" method="get">
						<table border="0" cellpadding="5">
							<tr>
								<td rowspan="5">
									<img src="recursos/images/estado_cuenta.png" border="0" />
								</td>
							</tr>
							<tr>
								<td width="30px">&nbsp;</td>
								<td>
									<div class="input-group">
								      <div class="input-group-addon"><img src="recursos/images/icons/reservar2_16x16.png" border="0" /></div>
								      <input class="form-control" type="text" id="numeropuesto" placeholder="Ingrese número de puesto">
								    </div>
								</td>
								<td width="30px">&nbsp;</td>
							</tr>
							<tr>
								<td width="30px">&nbsp;</td>
								<td>
									<div class="input-group">
								      <div class="input-group-addon"><img src="recursos/images/icons/calendar_16x16.png" border="0" /></div>
								      <input class="form-control" type="text" id="fechainicial" placeholder="Ingrese la fecha inicial">
								    </div>
								</td>
								<td width="30px">&nbsp;</td>
							</tr>
							<!--tr>
								<td width="30px">&nbsp;</td>
								<td>
									<div class="input-group">
								      <div class="input-group-addon"><img src="recursos/images/icons/calendar_16x16.png" border="0" /></div>
								      <input class="form-control" type="text" id="fechafinal" placeholder="Ingrese la fecha final">
								    </div>
								</td>
								<td width="30px">&nbsp;</td>
							</tr-->
							<tr>
								<td>&nbsp;</td>
								<td align="right">
									<button type="button" class="btn btn-primary" onclick="openNewWindowForJasperWithCharts()">Aceptar</button>
								</td>
								<td width="30px">&nbsp;</td>
							</tr>
						</table>
					</form>
					</div>
				</div>
			</td>
		</tr>
	</table>

</body>
</html>