<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:f="http://java.sun.com/jsf/core" xmlns:h="http://java.sun.com/jsf/html">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<style type="text/css">
	.texto {
		background-color:rgb(189,252,152);
		color:rgb(0,0,0);
	}
	
</style>
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
$(function() {
	$("#periodo").datepicker({
        //dateFormat: 'mm-yy',
        dateFormat: 'MM yy',
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
		regional: 'es',
        onClose: function(dateText, inst) {  
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val(); 
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val(); 
            $(this).val($.datepicker.formatDate('MM yy', new Date(year, month, 1)));
            //$(this).val($.datepicker.formatDate('yy-mm', new Date(year, month, 1)));
        }
    });  
	
	
	$("#periodo").focus(function () {
        $(".ui-datepicker-calendar").hide();
        $("#ui-datepicker-div").position({
            my: "center top",
            at: "center bottom",
            of: $(this)
        });    
    });
         
	$("#fecvencimiento").datepicker(
            {   
                changeMonth: true,
                changeYear: false,
                numberOfMonths: 1,
                dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
                monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo',
                    'Junio', 'Julio', 'Agosto', 'Septiembre',
                    'Octubre', 'Noviembre', 'Diciembre'],
                monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr',
                    'May', 'Jun', 'Jul', 'Ago',
                    'Sep', 'Oct', 'Nov', 'Dic'] 
            });  

	$("#fecemision").datepicker(
            {   
                changeMonth: true,
                changeYear: false,
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
/*$(document).ready(function() {

    $('#dialog').modal('show')

});*/


function colorEtiquetas(){
	
	$("#lblpuesto").css("color", "black");
	$("#lblgiroComercial").css("color", "black");
	
	$("#lblpuesto-img").hide();
	$("#lblgiroComercial-img").hide();
	
}

function nuevoRecibos(){
	
/*	$('#puesto_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Nuevo Recibo de Luz");
*/	
	colorEtiquetas();
	
	$("#periodo").val('');
	$("#fecVencimiento").val('');
	$("#fecEmision").val('');
	$("#costoWats").val(0);
	$("#estado").val(0);
	$("#repomancnx").val(0);
	$("#cargofijo").val(0);
	$("#energActFraPtaActual").val(0);
	$("#energActFraPtaAnteri").val(0);
	$("#energActFraPtaDifer").val(0);
	$("#energActFraPtaFactor").val(0);
	$("#energActFraPtaConsu").val(0);
	$("#energActFraPtaConfa").val(0);
	$("#energActFraPtaPreuni").val(0);
	$("#energActFraPtaTotal").val(0);
	$("#energActHorPtaActu").val(0);
	$("#energActHorPtaAnt").val(0);
	$("#energActHorPtaDif").val(0);
	$("#energActHorPtaFac").val(0);
	$("#energActHorPtaCons").val(0);
	$("#energActHorPtaConfac").val(0);
	$("#energActHorPtaPreuni").val(0);
	$("#energActHorPtaTotal").val(0);
	$("#energReacInicial").val(0);
	$("#energReacAnteri").val(0);
	$("#energReacDifere").val(0);
	$("#energReacFactor").val(0);
	$("#energReacConsu").val(0);
	$("#energReacFaccons").val(0);
	$("#energReacPreuni").val(0);
	$("#energReacTotal").val(0);
	$("#interesConvenio").val(0);
	$("#potenciaFpIni").val(0);
	$("#potenciaFpAnte").val(0);
	$("#potenciaFpDif").val(0);
	$("#potenciaFpFac").val(0);
	$("#potenciaFpCons").val(0);
	$("#potenciaHpAct").val(0);
	$("#potenciaHpAnt").val(0);
	$("#potenciaHpDif").val(0);
	$("#potenciaHpFac").val(0);
	$("#potenciaHpCons").val(0);
	$("#potUsoRedDistConfac").val(0);
	$("#potUsoRedDistPreuni").val(0);
	$("#potUsoRedDistTotal").val(0);
	$("#potGenFpConfac").val(0);
	$("#potGenFpPreuni").val(0);
	$("#potGenFpTotal").val(0);
	$("#alumPublic").val(0);
	$("#subTotalMes").val(0);
	$("#igv").val(0);
	$("#totalMesAct").val(0);
	$("#aporteLey").val(0);
	$("#cuotaConv").val(0);
	$("#redonMesAnt").val(0);
	$("#redonMesAct").val(0);
	$("#total").val(0);
}

function guardar(){
	
	var ruta = obtenerContexto();

	//alert("Periodo: "+$('#periodo').val() + "\nVencimiento: " + $('#fecvencimiento').val() + "\nEmision: " + $('#fecemision').val() + "\nCostoWats: " + $('#costowats').val() + "\nEstado: " + $('#estado').val());
	//alert("Reposicion: "+$('#repomancnx').val() + "\nCargoFijo: " + $('#cargofijo').val() + "\nAlumbradoPublico: " + $('#alumpublic').val() + "\nSubTotalMes: " + $('#subtotalmes').val() + "\nIgv: " + $('#igv').val());
	
	jsonObj = [];
	var parametros = new Object();
	parametros.periodo = $("#periodo").val();
	parametros.fecVencimiento = $("#fecvencimiento").val();
	parametros.fecEmision = $("#fecemision").val();
	parametros.costoWats = $("#costowats").val();
	parametros.estado = $("#estado").val();
	parametros.repoManCnx = $("#repomancnx").val();
	parametros.cargoFijo = $("#cargofijo").val();
	parametros.alumPublic = $("#alumpublic").val();
	parametros.subTotalMes = $("#subtotalmes").val();
	parametros.igv = $("#igv").val();
	parametros.totalMesAct = $("#totalmesact").val();
	parametros.aporteLey = $("#aporteley").val();
	parametros.cuotaConv = $("#cuotaconv").val();
	parametros.redonMesAnt = $("#redonmesant").val();
	parametros.redonMesAct = $("#redonmesact").val();
	parametros.interesConv = $("#interesconvenio").val();	
	
	parametros.energActFraPtaActual = $("#energactfraptaactual").val();
	parametros.energActFraPtaAnteri = $("#energactfraptaanteri").val();
	parametros.energActFraPtaDifer = $("#energactfraptadifer").val();
	parametros.energActFraPtaFactor = $("#energactfraptafactor").val();
	parametros.energActFraPtaConsu = $("#energactfraptaconsu").val();
	parametros.energActFraPtaConfa = $("#energactfraptaconfa").val();
	parametros.energActFraPtaPreuni = $("#energactfraptapreuni").val();
	parametros.energActFraPtaTotal = $("#energactfraptatotal").val();
	parametros.energActHorPtaActu = $("#energacthorptaactu").val();
	parametros.energActHorPtaAnt = $("#energacthorptaant").val();
	parametros.energActHorPtaDif = $("#energacthorptadif").val();
	parametros.energActHorPtaFac = $("#energacthorptafac").val();
	parametros.energActHorPtaCons = $("#energacthorptacons").val();
	parametros.energActHorPtaConfac = $("#energacthorptaconfac").val();
	parametros.energActHorPtaPreuni = $("#energacthorptapreuni").val();
	parametros.energActHorPtaTotal = $("#energacthorptatotal").val();
	parametros.energReacInicial = $("#energreacinicial").val();
	parametros.energReacAnteri = $("#energreacanteri").val();
	parametros.energReacDifere = $("#energreacdifere").val();
	parametros.energReacFactor = $("#energreacfactor").val();
	parametros.energReacConsu = $("#energreacconsu").val();
	parametros.energReacFaccons = $("#energreacfaccons").val();
	parametros.energReacPreuni = $("#energreacpreuni").val();
	parametros.energReacTotal = $("#energreactotal").val();
	
	parametros.potenciaFpIni = $("#potenciafpini").val();
	parametros.potenciaFpAnte = $("#potenciafpante").val();
	parametros.potenciaFpDif = $("#potenciafpdif").val();
	parametros.potenciaFpFac = $("#potenciafpfac").val();
	parametros.potenciaFpCons = $("#potenciafpcons").val();
	parametros.potenciaHpAct = $("#potenciahpact").val();
	parametros.potenciaHpAnt = $("#potenciahpant").val();
	parametros.potenciaHpDif = $("#potenciahpdif").val();
	parametros.potenciaHpFac = $("#potenciahpfac").val();
	parametros.potenciaHpCons = $("#potenciahpcons").val();
	parametros.potUsoRedDistConfac = $("#potusoreddistconfac").val();
	parametros.potUsoRedDistPreuni = $("#potusoreddistpreuni").val();
	parametros.potUsoRedDistTotal = $("#potusoreddisttotal").val();
	parametros.potGenFpConfac = $("#potgenfpconfac").val();
	parametros.potGenFpPreuni = $("#potgenfppreuni").val();
	parametros.potGenFpTotal = $("#potgenfptotal").val();

	parametros.total = $("#total").val();

		
	$.ajax({
		type: "POST",
	    async:false,
	    url: "grabar-luz-original.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	            
	        if(result.camposObligatorios.length == 0){
                	
            	$('#luz_original_modal').modal('hide');
            	
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
	            
	            cargarReciboLuzOriginal();
	            
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


function cargarReciboLuzOriginal(){
	
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		var opciones = "<center>";
			
			opciones += "<a href=javascript:editarReciboLuzOriginal(";
			opciones += rowObject.codigoOrgReciboLuz + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Usuario'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:eliminarReciboLuzOriginal(";
			opciones += rowObject.codigoOrgReciboLuz + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/eliminar_24x24.png' border='0' title='Eliminar Puesto'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:generarReciboLuzSocio('";
			opciones += rowObject.codigoReciboLuzOriginal + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/reciboLuz_24x24.png' border='0' title='Generar Recibo Luz Socio'/>";
			opciones += "</a>";			
			
			opciones += "</center>";
			
		return opciones;
				
	};
	
	jQuery("#grilla").jqGrid(
	{
		url : 'reporte-recibo-luz-original.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		colNames : ['CodigoRecibo', 'Periodo', 'FechaEmision', 'FechaVencimiento','Total', 'Opciones'],
		colModel : [{
			name : 'codigoReciboLuzOriginal',
			index: 'codigoReciboLuzOriginal',
			sortable:false,
			width: 90,
			align: 'center'
		},{
			name : 'periodo',
			index: 'periodo',
			sortable:false,
			width: 100,
			align: 'left'
		},{
			name : 'fecEmision',
			index: 'fecEmision',
			sortable:false,
			width: 100,
			align: 'left'
		},{
			name : 'fecVencimiento',
			index: 'fecVencimiento',
			sortable:false,
			width: 150,
			align: 'center'
		},{
			name : 'totalMesAct',
			index: 'totalMesAct',
			sortable:false,
			width: 150,
			align: 'center'
		},{					
			name:'codigoReciboLuzOriginal',
			index:'codigoReciboLuzOriginal',
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
		sortorder : "codigoReciboLuzOriginal",				
		caption : "Recibo de Luz Original"				

	}).trigger('reloadGrid');
}


function generarReciboLuzSocio(codigoReciboLuzOriginal){
	console.log("Generar Recibo Luz Socios - [codigoReciboLuzOriginal] : " + codigoReciboLuzOriginal);
	
	$('#recibos_luz_socios_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Generar Recibo Luz Socios");
	
	colorEtiquetas();
	
	$("#codigoReciboLuzOriginal").val(codigoReciboLuzOriginal);
	
	buscarUsuario();
	cargarReciboLuzSocio();
	
}

function cargarReciboLuzSocio(){
	
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		var opciones = "<center>";
			
			opciones += "<a href=javascript:editarReciboLuzSocio(";
			opciones += rowObject.codigoOrgReciboLuz + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Recibo Luz Socio'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:eliminarReciboLuzSocio(";
			opciones += rowObject.codigoOrgReciboLuz + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/eliminar_24x24.png' border='0' title='Eliminar Recibo Luz Socio'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:generarReciboLuzSocio('";
			opciones += rowObject.codigoReciboLuzOriginal + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/agregar2_24x24.png' border='0' title='Crear Recibo Luz Socio'/>";
			opciones += "</a>";			
			
			opciones += "</center>";
			
		return opciones;
				
	};
	
	jQuery("#grillaLuzSocio").jqGrid(
	{
		url : 'reporte-recibo-luz-puesto.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		colNames : ['Código Puesto', 'Código Usuario', 'Nro. Puesto', 'Giro','Puesto', 'Opciones'],
		colModel : [{
			name : 'codigoPuesto',
			index: 'codigoPuesto',
			sortable:false,
			width: 90,
			align: 'center'
		},{
			name : 'codigoUsuario',
			index: 'codigoUsuario',
			sortable:false,
			width: 100,
			align: 'left'
		},{
			name : 'nroPuesto',
			index: 'nroPuesto',
			sortable:false,
			width: 100,
			align: 'left'
		},{
			name : 'codigoGiro',
			index: 'codigoGiro',
			sortable:false,
			width: 150,
			align: 'center'
		},{
			name : 'reciboLuz',
			index: 'reciboLuz',
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
		pager : '#grillaLuzSocio',
		sortname : 'codigoPuesto',
		autowidth: true,
		rownumbers: true,
		viewrecords : true,
		sortorder : "codigoPuesto",				
		caption : "Recibo de Luz Socios"				

	}).trigger('reloadGrid');
}
</script>
</head>
<body id="body">
	<input type="hidden" id="codigoReciboLuz" />
	<input type="hidden" name="metodo" />
	
	<input type="hidden" id="periodox"/>
	<input type='hidden' id='fecvencimientox'/>
	<input type='hidden' id='fecemisionx'/>	
	<input type="hidden" id="costoWatsx"/>
	<input type="hidden" id="estadox"/>

<table border="0" width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td width="150"><b>MES RECIBO LUZ<b/></td>
		<td width="10">:</td>
		<td width="200"><input type="text" id="reciboBuscara" class="form-control" maxlength="8" /></td>
		<td>&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" onclick="buscarRecibo()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
			</button>&nbsp;&nbsp;
			<!-- button type="button" class="btn btn-primary" onclick="nuevoRecibo()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Nuevo" />&nbsp;Nuevo
			</button -->
			<button class="btn btn-primary" data-toggle="modal" data-target="#luz_original_modal" onclick="nuevoRecibos()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Nuevo" />&nbsp;Nuevo
			</button>
			<button class="btn btn-primary" onclick="cargarReciboLuzOriginal()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Actualizar" />&nbsp;Actualizar
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

<!-- Ventana Modal -->
<div class="modal fade" id="luz_original_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 800px">
		<div class="modal-content">
		
		<div class="modal-header modal-header-primary">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title">Recibo de Luz Original</h4>
		</div>
		
		<div class="modal-body">
			<table border="0" cellpadding="0" cellspacing="0" width="800px">
				<tr>
					<td><label><font size="2"><b>Periodo:</b></font></label></td>
					<td><input type='text' id='periodo' class='text ui-widget-content ui-corner-all' size="10" tabindex="1"/>(mes/dia/año)</td>
					<td>&nbsp;</td>
					<td><label><font size="2"><b>Fecha de Vencimiento:</b></font></label></td>
					<td><input type='text' id='fecvencimiento' class='text ui-widget-content ui-corner-all' size="10" tabindex="2"/>(mes/dia/año)</td>
				</tr>
				<tr>
					<td><label><font size="2"><b>Fecha de Emision:</b></font></label></td>
					<td><input type='text' id='fecemision' class='text ui-widget-content ui-corner-all' size="10" tabindex="3"/>(mes/dia/año)</td>
					<td>&nbsp;</td>
					<td><label><font size="2"><b>Costo Wats:</b></font></label></td>	
					<td><input type='text' id='costowats' class='text ui-widget-content ui-corner-all' size="10" value="0" tabindex="4"/></td>
				</tr>
				<tr>
					<td><label><font size="2"><b>Estado:</b></font></label></td>	
					<td><input type="checkbox" id='estado' class='text ui-widget-content ui-corner-all' tabindex="5"/></td>			
				</tr>
			</table>

			<table border="1" cellpadding="0" cellspacing="0">
				<tr>
					<td align="center" width="220px"><font size="1"><b>Energía y Demanda</b></font></td>
					<td align="center" width="70px"><font size="1"><b>Lectura<br>Actual</b></font></td>
					<td align="center" width="70px"><font size="1"><b>Lectura<br>Anterior</b></font></td>
					<td align="center" width="70px"><font size="1"><b>Diferencia</b></font></td>
					<td align="center" width="70px"><font size="1"><b>Factor</b></font></td>
					<td align="center" width="70px"><font size="1"><b>Consumos</b></font></td>
					<td align="center" width="80px"><font size="1"><b>Consumos A<br>Facturar</b></font></td>
					<td align="center" width="70px"><font size="1"><b>Precio<br>Unitario</b></font></td>
					<td align="center" width="70px"><font size="1"><b>Importe<br>Total</b></font></td>
				</tr>
				<tr>
					<td><font size="1">Reposic. y Mant. de Conex</font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaActRepMan' id='lecturaActRepMan' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntRepMan' id='lecturaAntRepMan' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaRepMan' id='DiferenciaRepMan' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorRepMan' id='FactorRepMan' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosRepMan' id='ConsumosRepMan' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsFactRepMan' id='ConsFactRepMan' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='PrecUnitRepMan' id='PrecUnitRepMan' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='repomancnx' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos()" tabindex="6"/></td>
				</tr>
				<tr>
					<td><font size="1">Cargo Fijo</font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaActCarFij' id='lecturaActCarFij' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntCarFij' id='lecturaAntCarFij' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaCarFij' id='DiferenciaCarFij' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorCarFij' id='FactorCarFij' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosCarFij' id='ConsumosCarFij' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsFactCarFij' id='ConsFactCarFij' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='PrecUnitCarFij' id='PrecUnitCarFij' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='cargofijo' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos()" tabindex="7"/></td>
				</tr>
				<tr>
					<td><font size="1">Energ. Activa Fuera Punta (kwh)</font></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energactfraptaactual' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="8"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energactfraptaanteri' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="9"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energactfraptadifer' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="10"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energactfraptafactor' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="11"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energactfraptaconsu' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="12"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energactfraptaconfa' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="13"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energactfraptapreuni' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="14"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energactfraptatotal' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos()" tabindex="15"/></td>
				</tr>
				<tr>
					<td><font size="1">Energ. Activa Horas Punta (kwh)</font></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energacthorptaactu' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="16"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energacthorptaant' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="17"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energacthorptadif' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="18"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energacthorptafac' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="19"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energacthorptacons' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="20"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energacthorptaconfac' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="21"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energacthorptapreuni' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="22"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energacthorptatotal' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos()" tabindex="23"/></td>
				</tr>
				<tr>
					<td><font size="1">Energía Reactiva (kVARh)</font></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energreacinicial' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="24"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energreacanteri' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="25"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energreacdifere' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="26"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energreacfactor' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="27"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energreacconsu' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="28"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energreacfaccons' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="29"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energreacpreuni' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="30"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energreactotal' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos()" tabindex="31"/></td>
				</tr>
				<tr>
					<td><font size="1">Interés Convenio</font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaActIntCon' id='lecturaActIntCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntIntCon' id='lecturaAntIntCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaIntCon' id='DiferenciaIntCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorIntCon' id='FactorIntCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosIntCon' id='ConsumosIntCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsFactIntCon' id='ConsFactIntCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='PrecUnitIntCon' id='PrecUnitIntCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='interesconvenio' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos()" tabindex="32"/></td>
				</tr>
				<tr>
					<td><font size="1">Potencia FP (KW)</font></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciafpini' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="33"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciafpante' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="34"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciafpdif' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="35"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciafpfac' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="36"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciafpcons' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="37"/></td>
					<td align="center">&nbsp;<!-- input type='text' name='ConsFactPotFP' id='ConsFactPotFP' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' name='PrecUnitPotFP' id='PrecUnitPotFP' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' name='ImporTotalPotFP' id='ImporTotalPotFP' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
				</tr>
				<tr>
					<td><font size="1">Potencia HP (KW)</font></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciahpact' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="38"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciahpant' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="39"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciahpdif' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="40"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciahpfac' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="41"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciahpcons' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="42"/></td>
					<td align="center">&nbsp;<!-- input type='text' name='ConsFactPotHP' id='ConsFactPotHP' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' name='PrecUnitPotHP' id='PrecUnitPotHP' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' name='ImporTotalPotHP' id='ImporTotalPotHP' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
				</tr>
				<tr>
					<td><font size="1">Pot. Uso Redes Distrib. F (KW)</font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaActPotDis' id='lecturaActPotDis' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntPotDis' id='lecturaAntPotDis' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaPotDis' id='DiferenciaPotDis' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorPotDis' id='FactorPotDis' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosPotDis' id='ConsumosPotDis' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potusoreddistconfac' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="43"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potusoreddistpreuni' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="44"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potusoreddisttotal' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos()" tabindex="45"/></td>
				</tr>
				<tr>
					<td><font size="1">Potencia de Generación FP (KW)</font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ledturaActPotGen' id='lecturaActPotGen' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntPotGen' id='lecturaAntPotGen' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaPotGen' id='DiferenciaPotGen' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorPotGen' id='FactorPotGen' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosPotGen' id='ConsumosPotGen' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potgenfpconfac' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="46"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potgenfppreuni' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="47"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potgenfptotal' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos()" tabindex="48"/></td>
				</tr>
				<tr>
					<td><font size="1">Alumbrado Público</font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaActAluPub' id='lecturaActAluPub' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntAluPub' id='lecturaAntAluPub' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaAluPub' id='DiferenciaAluPub' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorAluPub' id='FactorAluPub' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosAluPub' id='ConsumosAluPub' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsFactAluPub' id='ConsFactAluPub' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='PrecUnitAluPub' id='PrecUnitAluPub' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='alumpublic' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos()" tabindex="49"/></td>
				</tr>
				<tr>
					<td><font size="1"><b>SUBTOTAL Mes Actual</b></font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaActSubTot' id='lecturaActSubTot' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntSubTot' id='lecturaAntSubTot' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaSubTot' id='DiferenciaSubTot' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorSubTot' id='FactorSubTot' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosSubTot' id='ConsumosSubTot' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsFactSubTot' id='ConsFactSubTot' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='PrecUnitSubTot' id='PrecUnitSubTot' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='subtotalmes' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" readonly="readonly" tabindex="50"/></td>
				</tr>
				<tr>
					<td><font size="1">I.G.V.</font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaActIGV' id='lecturaActIGV' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntIGV' id='lecturaAntIGV' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaIGV' id='DiferenciaIGV' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorIGV' id='FactorIGV' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosIGV' id='ConsumosIGV' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsFactIGV' id='ConsFactIGV' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='PrecUnitIGV' id='PrecUnitIGV' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='igv' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" readonly="readonly" tabindex="51"/></td>
				</tr>
				<tr>
					<td><font size="1"><b>TOTAL Mes Actual</b></font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaActTotMes' id='lecturaActTotMes' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntTotMes' id='lecturaAntTotMes' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaTotMes' id='DiferenciaTotMes' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorTotMes' id='FactorTotMes' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosTotMes' id='ConsumosTotMes' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsFactTotMes' id='ConsFactTotMes' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='PrecUnitTotMes' id='PrecUnitTotMes' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='totalmesact' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" readonly="readonly" tabindex="52"/></td>
				</tr>
				<tr>
					<td><font size="1">Aporte Ley Nº 28749</font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaActApoLey' id='lecturaActApoLey' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntApoLey' id='lecturaAntApoLey' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaApoLey' id='DiferenciaApoLey' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorApoLey' id='FactorApoLey' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosApoLey' id='ConsumosApoLey' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsFactApoLey' id='ConsFactApoLey' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='PrecUnitApoLey' id='PrecUnitApoLey' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='aporteley' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos()" tabindex="53"/></td>
				</tr>
				<tr>
					<td><font size="1">Cuota Convenio (10 cuotas)</font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaActCuoCon' id='lecturaActCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntCuoCon' id='lecturaAntCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaCuoCon' id='DiferenciaCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorCuoCon' id='FactorCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosCuoCon' id='ConsumosCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsFactCuoCon' id='ConsFactCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='PrecUnitCuoCon' id='PrecUnitCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='cuotaconv' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos()" tabindex="54"/></td>
				</tr>
				<tr>
					<td><font size="1">Redondeo Mes Anterior</font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaActRedAnt' id='lecturaActRedAnt' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntRedAnt' id='lecturaAntRedAnt' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaRedAnt' id='DiferenciaRedAnt' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorRedAnt' id='FactorRedAnt' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosRedAnt' id='ConsumosRedAnt' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsFactRedAnt' id='ConsFactRedAnt' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='PrecUnitRedAnt' id='PrecUnitRedAnt' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='redonmesant' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos()" tabindex="55"/></td>
				</tr>
				<tr>
					<td><font size="1">Redondeo Mes Actual</font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaActRedAct' id='lecturaActRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntRedAct' id='lecturaAntRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaRedAct' id='DiferenciaRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorRedAct' id='FactorRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosRedAct' id='ConsumosRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsFactRedAct' id='ConsFactRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='PrecUnitRedAct' id='PrecUnitRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='redonmesact' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos()" tabindex="56"/></td>
				</tr>
				<tr>
					<td><label>Total:</label></td>
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>	
					<td align="center"><input type='text' name='total' class='texto' style='font-family:verdana;font-size:8px;' id='total' size="10" value="0" readonly="readonly" tabindex="57"/></td>
				</tr>
			</table>
		</div>
		
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="guardar()">Grabar</button>
			<button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
		</div>
		
		</div>
	</div>
</div>
 

<!-- Ventana Modal para Recibo Luz Socios -->
<div class="modal fade" id="recibos_luz_socios_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 800px">
		<div class="modal-content">
		
		<div class="modal-header modal-header-primary">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title">Listado de Recibos de Luz de Socios</h4>
		</div>

		<div class="modal-body">
		
			<table border="0" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
				<tr>
					<td width="150"><b>RECIBO LUZ SOCIOS<b/></td>
					<td width="10">:</td>
					<td width="200"><input type="text" id="reciboLuzSocioBuscara" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
					<td>&nbsp;&nbsp;
						<button type="button" class="btn btn-primary" onclick="buscarReciboLuzSocio()">
							<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
						</button>&nbsp;&nbsp;
						<button class="btn btn-info" onclick="cargarReciboLuzSocio()">
							<img src="recursos/images/icons/buscar_16x16.png" alt="Actualizar" />&nbsp;Actualizar
						</button>
					</td>
				</tr>
				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="4">
						<table id="grillaLuzSocio"></table>
						<div id="pgrillaLuzSocio"></div>
					</td>
				</tr>
			</table>	
		
		</div>
		
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="">Grabar</button>
			<button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
		</div>
		
		</div>
	</div>
</div>

</body>
</html>