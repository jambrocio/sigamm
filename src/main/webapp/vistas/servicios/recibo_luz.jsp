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
var intentos = 0;
$(document).ready(function(){	
	
	cargarReciboLuzOriginal();
	$("#contraba").hide();
	limpiar();
	limpiarReciboLuzSocio();
	
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
         
	$("#fecVencimiento").datepicker(
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

	$("#fecEmision").datepicker(
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

	//alert("Nuevo Recibo Original");
	colorEtiquetas();
	
	$("#periodo").val('');
	$("#fecVencimiento").val('');
	$("#fecEmision").val('');
	$("#costoWats").val(0);
	$("#alumbradoPublico").val(0);
	$("#mantenimiento").val(0);
	$("#estado").val(0);
	$("#repoManCnx").val(0);
	$("#cargoFijo").val(0);
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
	$("#interesCompensatorio").val(0);
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
	$("#subTotalMes").val(0);
	$("#alumbradoPublicoOriginal").val(0);
	$("#igv").val(0);
	$("#totalMesAct").val(0);
	$("#aporteLey").val(0);
	$("#deudaAnterior").val(0);
	$("#recargoMora").val(0);
	$("#redonMesAnt").val(0);
	$("#redonMesAct").val(0);
	$("#ajustePreRet").val(0);
	$("#igvRefact").val(0);
	$("#total").val(0);
}

function guardar(){
	
	var ruta = obtenerContexto();

	//alert("periodo: "+$('#periodo').val() + "\nVencimiento: " + $('#fecvencimiento').val() + "\nEmision: " + $('#fecemision').val() + "\nCostoWats: " + $('#costowats').val() + "\nEstado: " + $('#estado').val());
	//alert("Reposicion: "+$('#repomancnx').val() + "\nCargoFijo: " + $('#cargofijo').val() + "\nAlumbradoPublico: " + $('#alumpublic').val() + "\nSubTotalMes: " + $('#subtotalmes').val() + "\nIgv: " + $('#igv').val());
	
	jsonObj = [];
	var parametros = new Object();
	parametros.periodo = $("#periodo").val();
	parametros.fecVencimiento = $("#fecVencimiento").val();
	parametros.fecEmision = $("#fecEmision").val();
	parametros.costoWats = $("#costoWats").val();
	parametros.alumbradoPublico = $("#alumbradoPublico").val();
	parametros.mantenimiento = $("#mantenimiento").val();
	parametros.estado = $("#estado").val();
	parametros.repoManCnx = $("#repoManCnx").val();
	parametros.cargoFijo = $("#cargoFijo").val();
	parametros.subTotalMes = $("#subTotalMes").val();
	parametros.igv = $("#igv").val();
	parametros.totalMesAct = $("#totalMesAct").val();
	parametros.aporteLey = $("#aporteLey").val();
	parametros.deudaAnterior = $("#deudaAnterior").val();
	parametros.recargoMora = $("#recargoMora").val();
	parametros.redonMesAnt = $("#redonMesAnt").val();
	parametros.redonMesAct = $("#redonMesAct").val();
	parametros.interesCompensatorio = $("#interesCompensatorio").val();	
	
	parametros.energActFraPtaActual = $("#energActFraPtaActual").val();
	parametros.energActFraPtaAnteri = $("#energActFraPtaAnteri").val();
	parametros.energActFraPtaDifer = $("#energActFraPtaDifer").val();
	parametros.energActFraPtaFactor = $("#energActFraPtaFactor").val();
	parametros.energActFraPtaConsu = $("#energActFraPtaConsu").val();
	parametros.energActFraPtaConfa = $("#energActFraPtaConfa").val();
	parametros.energActFraPtaPreuni = $("#energActFraPtaPreuni").val();
	parametros.energActFraPtaTotal = $("#energActFraPtaTotal").val();
	parametros.energActHorPtaActu = $("#energActHorPtaActu").val();
	parametros.energActHorPtaAnt = $("#energActHorPtaAnt").val();
	parametros.energActHorPtaDif = $("#energActHorPtaDif").val();
	parametros.energActHorPtaFac = $("#energActHorPtaFac").val();
	parametros.energActHorPtaCons = $("#energActHorPtaCons").val();
	parametros.energActHorPtaConfac = $("#energActHorPtaConfac").val();
	parametros.energActHorPtaPreuni = $("#energActHorPtaPreuni").val();
	parametros.energActHorPtaTotal = $("#energActHorPtaTotal").val();
	parametros.energReacInicial = $("#energReacInicial").val();
	parametros.energReacAnteri = $("#energReacAnteri").val();
	parametros.energReacDifere = $("#energReacDifere").val();
	parametros.energReacFactor = $("#energReacFactor").val();
	parametros.energReacConsu = $("#energReacConsu").val();
	parametros.energReacFaccons = $("#energReacFaccons").val();
	parametros.energReacPreuni = $("#energReacPreuni").val();
	parametros.energReacTotal = $("#energReacTotal").val();
	
	parametros.potenciaFpIni = $("#potenciaFpIni").val();
	parametros.potenciaFpAnte = $("#potenciaFpAnte").val();
	parametros.potenciaFpDif = $("#potenciaFpDif").val();
	parametros.potenciaFpFac = $("#potenciaFpFac").val();
	parametros.potenciaFpCons = $("#potenciaFpCons").val();
	parametros.potenciaHpAct = $("#potenciaHpAct").val();
	parametros.potenciaHpAnt = $("#potenciaHpAnt").val();
	parametros.potenciaHpDif = $("#potenciaHpDif").val();
	parametros.potenciaHpFac = $("#potenciaHpFac").val();
	parametros.potenciaHpCons = $("#potenciaHpCons").val();
	parametros.potUsoRedDistConfac = $("#potUsoRedDistConfac").val();
	parametros.potUsoRedDistPreuni = $("#potUsoRedDistPreuni").val();
	parametros.potUsoRedDistTotal = $("#potUsoRedDistTotal").val();
	parametros.potGenFpConfac = $("#potGenFpConfac").val();
	parametros.potGenFpPreuni = $("#potGenFpPreuni").val();
	parametros.potGenFpTotal = $("#potGenFpTotal").val();
	parametros.alumbradoPublicoOriginal = $("#alumbradoPublicoOriginal").val();
	parametros.ajustePrecioRetroactivo = $("#ajustePreRet").val(0);
	parametros.igvRefact = $("#igvRefact").val(0);
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
			opciones += rowObject.codigoOrgReciboLuz + ") >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Recibo Luz'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:eliminarReciboLuzOriginal(";
			opciones += rowObject.codigoOrgReciboLuz + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/eliminar_24x24.png' border='0' title='Eliminar Recibo Luz'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:generarReciboLuzSocio(";
			opciones += rowObject.codigoReciboLuzOriginal + ") >";
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
		colNames : ['CodigoRecibo', 'Periodo', 'FechaEmision', 'FechaVencimiento','Total Mes Actual','Total Mes Anterior','Total', 'Opciones'],
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
			name : 'deudaAnterior',
			index: 'deudaAnterior',
			sortable:false,
			width: 150,
			align: 'center'
		},{
			name : 'total',
			index: 'total',
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
		caption : "Recibo de Luz Original",
		formatoptions: {decimalSeperator : '.'},
		afterInsertRow: function(rowId, data, item){
			//alert(rowId + ' - ' + data + ' - ' + item.periodo);
			var anio = item.periodo.substring(0,4);
			var mes1 = item.periodo.substring(4,6);
			var periodo = null;
			var months = ['ENERO', 'FEBRERO', 'MARZO', 'ABRIL', 'MAYO', 'JUNIO','JULIO', 'AGOSTO', 'SETIEMBRE', 'OCTUBRE', 'NOVIEMBRE', 'DICIEMBRE'];
			for(var j=0;j<months.length;j++){
				if (mes1==j+1)
					periodo=months[j] + ' ' + anio;
			}
			//$("#grilla").setCell(rowId, 'periodo', periodo, '' );
		}


	}).trigger('reloadGrid');
}


function generarReciboLuzSocio(codigoRecibo){
	console.log("Generar Recibo Luz Socios - [codigoReciboLuzOriginal] : " + codigoRecibo);
	
	$("#nroRecibo").text(codigoRecibo);	
	
	$('#recibos_luz_socios_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Generar Recibo Luz Socios");
	
	colorEtiquetas();
	$('#grillaReciboLuz').jqGrid('clearGridData');	
	$("#codigoRecibo").val(codigoRecibo);
	
	//alert("UNO " + codigoReciboLuzOriginal);
	//buscarUsuario();
	cargarReciboLuz($("#nroRecibo").text());
	
}

function cargarReciboLuz(codigo){
	
	jsonObj = [];
	var parametros = new Object();
	parametros.codigoRecibo = codigo;
	
	if(intentos > 0){
		$("#grillaReciboLuz").jqGrid('setGridParam',
		{
			url : 'reporte-recibo-luz-puesto.json',
			datatype : "json",
			postData:parametros,
			page:1
		}).trigger('reloadGrid');
	}else{
		cargarReciboLuzSocio(codigo);
	}
		
}

function cargarReciboLuzSocio(codigoRecibo){
	intentos = 1;
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		var opciones = "<center>";
			
			opciones += "<a href=javascript:editarReciboLuzXSocio('";
			opciones += rowObject.codigoReciboOriginal + "','" + rowObject.nroPuesto + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Recibo Luz Socio'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:generarReciboLuzXSocio('";
			opciones += rowObject.codigoSector + "','" + rowObject.nroPuesto + "','" + rowObject.codigoReciboOriginal + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/agregar2_24x24.png' border='0' title='Crear Recibo de Luz por Socio'/>";
			opciones += "</a>";			

			opciones += "</center>";
			
		return opciones;
				
	};

	jsonObj = [];
	var parametros = new Object();
	parametros.codigoRecibo = $("#codigoRecibo").val();
	
	jQuery("#grillaReciboLuz").jqGrid(
	{
		url : 'reporte-recibo-luz-puesto.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		postData: parametros,
		colNames : ['Nombre Usuario', 'Puesto', 'Giro','Total', 'Opciones'],
		colModel : [{
			name : 'nombreFull',
			index: 'nombreFull',
			sortable:false,
			width: 320,
			align: 'left'
		},{
			name : 'nroPuesto',
			index: 'nroPuesto',
			sortable:false,
			width: 50,
			align: 'center'
		},{
			name : 'nombreGiro',
			index: 'nombreGiro',
			sortable:false,
			width: 150,
			align: 'center'
		},{
			name : 'total',
			index: 'total',
			sortable:false,
			width: 80,
			align: 'center'
		},{					
			name:'opciones',
			index:'opciones',
			width:110,
			sortable:false,
			search: false,
			formatter:formatterBotones
		}],								
		rowNum : 20,
		pager : '#pgrillaReciboLuz',
		sortname : 'codigoPuesto',
		autowidth: true,
		rownumbers: true,
		viewrecords : true,
		sortorder : "codigoPuesto",				
		caption : "Recibo de Luz Socios",
		afterInsertRow: function(rowId, data, item){
			//alert(rowId + ' - ' + data + ' - ' + item.total);
			if (item.reciboLuzCreado == 0){
				$("#grillaReciboLuz").setCell(rowId, 'nombreFull', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'nroPuesto', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'nombreGiro', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'total', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
			} else {
				$("#grillaReciboLuz").setCell(rowId, 'nombreFull', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'nroPuesto', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'nombreGiro', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'total', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
			}

		}

	}).trigger('reloadGrid');
}


function generarReciboLuzXSocio(sector, puesto, original){
		
	$("#sectorSocio").text(sector);
	$("#puestoSocio").text(puesto);									
	$("#reciboOriginal").text(original);
	
	colorEtiquetas();
	
	/*$("#codigoReciboLuzOriginal").val(codigoReciboLuzOriginal);
	buscarUsuario();*/
	$(function() {
		$("#idRecibo").focus();
	});
	
	cargarDatosReciboLuzSocio(sector, puesto, original);
}

function cargarDatosReciboLuzSocio(sector, puesto, original){	

	//alert(codigoPuesto);
	var ruta = obtenerContexto();
	
	var parametros = new Object();
	parametros.codigoSector         = sector;
	parametros.nroPuesto            = puesto;
	parametros.codigoReciboOriginal = original;
	
	$.ajax({
        type: "POST",
        async:false,
        url: "buscar-usuario-puesto-giro.json",
        cache : false,
        data: parametros,
        success: function(result){
            console.log(result);
        	//alert("Resultado : [" + result.rows + "]");
        	
        	$.each(result.rows, function(key,val) {
            	$("#nombreSocio").text(val.nombreFull);
            	$("#puestoSocio").text(val.nroPuesto);
            	$("#sectorSocio").text(val.nombreSector);
            	$("#giroSocio").text(val.nombreGiro);
            	$("#periodoSocio").text(val.periodoSocio);
            	$("#alumbradoPublicoSocio").val(val.alumbradoPublico);
            	$("#servicioMantenimientoSocio").val(val.mantenimiento);
            	$("#costoWatts").val(val.numCostoWatts);
            	$("#codigoSocio").val(val.codigoSocio);
            	$("#reciboLuzCreado").val(val.reciboLuzCreado);
            	          	
            	
				if ($("#reciboLuzCreado").val() == 0) {
					
					$('#recibos_luz_por_socio_modal').modal({
						backdrop: 'static',
						keyboard: false
					});
					
				} else {
					
					$.gritter.add({
						// (string | mandatory) the heading of the notification
						title: 'Mensaje',
						// (string | mandatory) the text inside the notification
						text: 'El Recibo de Luz del puesto ' + $("#puestoSocio").text() + ' ya fue creado...!!!',
						// (string | optional) the image to display on the left
						image: "/" + ruta + "/recursos/images/confirm.png",
						// (bool | optional) if you want it to fade out on its own or just sit there
						sticky: false,
						// (int | optional) the time you want it to be alive for before fading out
						time: ''
					});
					
				}
					
					
					
               		
                	
            	
        	});
        	

        	
        }
    });
	
	$("#lecturaInicialSocio").focus();
}


function editarReciboLuzXSocio(original, puesto){
	
	var ruta = obtenerContexto();
	mensaje = "Desea editar el recibo del Puesto " + puesto + " ?"; 
	//mensaje = "En cosntrucción " + puesto + " ?";
	
	$("#mensajeEditar").html(mensaje);
	
	$('#alerta_modal').modal({
		backdrop: 'static',
		keyboard: false
	}).one('click', '#aceptar', function() {
        
		jsonObj = [];
		var parametros = new Object();
		parametros.puestoSocio = puesto;
		parametros.codigoRecibo = original;
			
		$.ajax({
			type: "POST",
		    async:false,
		    url: "editar-luz-x-socio.json",
		    cache : false,
		    data: parametros,
		    //dataType: "html",
		    success: function(result){
		    	
		    	//alert(result.records);
		    	
			    $('#alerta_modal').modal('hide');
	
		        if (result.records > 0) {
			        $('#recibos_luz_por_socio_modal').modal({
		        		backdrop: 'static',
		        		keyboard: false
		        	});	        	

		        	$.each(result.rows, function(key,val) {		        		
		        		$("#codigoSocio").val(val.codigoSocio);
		            	$("#nombreSocio").text(val.nombreFull);
		            	$("#puestoSocio").text(val.puestoSocio);
		            	$("#sectorSocio").text(val.nombreSector);
		            	$("#giroSocio").text(val.nombreGiro);
		            	$("#periodoSocio").text(val.fecPeriodo);
						$("#idRecibo").val(val.idRecibo);
		            	$("#lecturaInicialSocio").val(val.lecturaInicial);
		        		$("#lecturaFinalSocio").val(val.lecturaFinal);
		        		if (val.trabado == 1){
		        			$("input:checkbox").attr('checked', 'checked');
	        				$("#sintraba").hide();
	        				$("#contraba").show();
	        				$("#consumoMesSocioTrabado").val(val.consumoMes);
		        		} else {
		        			$("input:checkbox").removeAttr('checked');
	        				$("#sintraba").show();
	        				$("#contraba").hide();
	        				$("#consumoMesSocio").html(val.consumoMes);
		        		}		        		
		        		$("#cargoEnergiaSocio").val(val.cargoEnergia);
		        		$("#alumbradoPublicoSocio").val(val.alumbradoPublico);
		        		$("#servicioMantenimientoSocio").val(val.servicioMantenimiento);
		        		$("#deudaAnteriorSocio").val(val.deudaAnterior);
		        		$("#reconexionSocio").val(val.reconexion);
		        		$("#totalSocio").html(val.total);
		        		$("#costoWatts").val(val.costoWatts);
		        		$("#codigoReciboLuzSocio").val(val.correlativo);
		            	
		        	});
	        	
	        	} else {
	        		
	        		$.gritter.add({
						// (string | mandatory) the heading of the notification
						title: 'Mensaje',
						// (string | mandatory) the text inside the notification
						text: 'El Recibo de Luz del puesto ' + puesto + ' aún no se ha creado, verifique...',
						// (string | optional) the image to display on the left
						image: "/" + ruta + "/recursos/images/confirm.png",
						// (bool | optional) if you want it to fade out on its own or just sit there
						sticky: false,
						// (int | optional) the time you want it to be alive for before fading out
						time: ''
					});
	        	};
	            //cargarPuestos();
		            
			}
		});
		
    });

}


function floorFigure(figure, decimals){
    if (!decimals) decimals = 2;
    var d = Math.pow(10,decimals);
    return (parseInt(figure*d)/d).toFixed(decimals);
};


function redondear_dos_decimal(valor) {
	var redondea_valor = 0.00;
	redondea_valor = Math.round(valor * 100) / 100;
   return redondea_valor; 
}



function calculaCampos(valor){
	var valores  = valor;
	var subTotal = 0.00;
	var igv      = 0.00;
	var totalMes = 0.00;
	var total    = 0.00;
	
	if (valores=='O'){
		subTotal =	redondear_dos_decimal( parseFloat($("#repoManCnx").val()) + parseFloat($("#cargoFijo").val())+ parseFloat($("#energActFraPtaTotal").val()) + parseFloat($("#energActHorPtaTotal").val()) + parseFloat($("#energReacTotal").val()) + parseFloat($("#interesCompensatorio").val()) + parseFloat($("#potUsoRedDistTotal").val()) + parseFloat($("#potGenFpTotal").val()) + parseFloat($("#alumbradoPublicoOriginal").val()) );
		if (!isNaN(subTotal))
			$("#subTotalMes").val(subTotal);
		else
			$("#subTotalMes").val(0);
		
		igv = redondear_dos_decimal( parseFloat(subTotal*0.18) );
		if (!isNaN(subTotal))
			$("#igv").val(igv);
		else
			$("#igv").val(0);
		
		totalMes = redondear_dos_decimal( parseFloat(subTotal) + parseFloat(igv) );
		if (!isNaN(totalMes))
			$("#totalMesAct").val(totalMes);
		else
			$("#totalMesAct").val(0);
		
	}else if (valores=='T'){
		/*total =  Math.ceil(parseFloat($("#totalMesAct").val()) + parseFloat($("#aporteLey").val()) + parseFloat($("#deudaAnterior").val()) 
		+ parseFloat($("#recargoMora").val()) + parseFloat($("#redonMesAnt").val()) + parseFloat($("#redonMesAct").val()) 
		+ parseFloat($("#ajustePreRet").val()) + parseFloat($("#igvRefact").val()));*/
		total = redondear_dos_decimal( parseFloat($("#totalMesAct").val()) + parseFloat($("#aporteLey").val()) + parseFloat($("#deudaAnterior").val()) 
				+ parseFloat($("#recargoMora").val()) + parseFloat($("#redonMesAnt").val()) + parseFloat($("#redonMesAct").val()) 
				+ parseFloat($("#ajustePreRet").val()) + parseFloat($("#igvRefact").val()) );
			
		if (!isNaN(total))
			$("#total").val(total);
		else
			$("#total").val(0);
	}

}

function operaciones(valor){
	var valores = valor;
	var respuesta;
	var cargoEnergia;
	//alert(valores);
	
	if (valores=='L'){
		if( $('#sintraba').is(":visible") ){
			respuesta = parseInt($("#lecturaFinalSocio").val()) - parseInt($("#lecturaInicialSocio").val());
			if (!isNaN(respuesta))
				$("#consumoMesSocio").html(respuesta);
			else
				$("#consumoMesSocio").html(0);
		} 


		if( $('#sintraba').is(":visible") ){
			cargoEnergia = redondear_dos_decimal( parseFloat($("#costoWatts").val())*parseFloat($("#consumoMesSocio").html()) );
		} else {
			cargoEnergia = redondear_dos_decimal( parseFloat($("#costoWatts").val())*parseFloat($("#consumoMesSocioTrabado").val()) );
		}
		
//		alert("cargo: " + cargoEnergia);
		$("#cargoEnergiaSocio").val(cargoEnergia);
		operaciones('R');
		
	}else if (valores=='R'){
		respuesta = redondear_dos_decimal( parseFloat($("#cargoEnergiaSocio").val()) + parseFloat($("#alumbradoPublicoSocio").val()) + parseFloat($("#servicioMantenimientoSocio").val()) + parseFloat($("#deudaAnteriorSocio").val()) + parseFloat($("#reconexionSocio").val()) );
//		alert(respuesta);
		if (!isNaN(respuesta))
			$("#totalSocio").html(respuesta);
		else
			$("#totalSocio").html(0.00);
	}else{
		$("#lecturaInicialSocio").html(0);
		$("#lecturaFinalSocio").html(0);
		$("#consumoMesSocio").html(0.00);
		$("#consumoMesSocioTrabado").val(0.00);
		$("#consumoMesSocioTrabado").hidden();
		$("#cargoEnergiaSocio").html(0.00);
		$("#alumbradoPublicoSocio").html(0.00);
		$("#servicioMantenimientoSocio").html(0.00);
		$("#deudaAnteriorSocio").html(0.00);
		$("#reconexionSocio").html(0.00);
		$("#totalSocio").html(0.00);
	}
	
}


function guardarRecibo(){
	
	var ruta = obtenerContexto();
	
	//alert("CORRELATIVO: " + $("#codigoReciboLuzSocio").val() );
	
	var parametros = new Object();
	parametros.codigoSocio = $("#codigoSocio").val();
	parametros.codigoRecibo = $("#nroRecibo").text();
	parametros.idsocio = $("#idRecibo").val();
	parametros.lecturaInicial = $("#lecturaInicialSocio").val();
	parametros.lecturaFinal = $("#lecturaFinalSocio").val();
	if( $('#sintraba').is(":visible") ){
		parametros.consumoMes = $("#consumoMesSocio").html();
		parametros.trabado = 0;
	} else {
		parametros.consumoMes = $("#consumoMesSocioTrabado").val();
		parametros.trabado = 1;
	}
	parametros.cargoEnergia = $("#cargoEnergiaSocio").val();
	parametros.alumbradoPublico = $("#alumbradoPublicoSocio").val();
	parametros.servicioMantenimiento = $("#servicioMantenimientoSocio").val();
	parametros.deudaAnterior = $("#deudaAnteriorSocio").val();
	parametros.reconexion = $("#reconexionSocio").val();
	parametros.total = $("#totalSocio").text();
	parametros.correlativo = $("#codigoReciboLuzSocio").val();
	parametros.idRecibo = $("#idRecibo").val();
		
	$.ajax({
		type: "POST",
	    async:false,
	    url: "grabar-luz-x-socio.json",
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
	            
	            cargarReciboLuzSocio();
	            limpiarReciboLuzSocio();
	            
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


function limpiarReciboLuzSocio(){
	
	$("#nombreSocio").text('');
	$("#puestoSocio").text('');								
	$("#sectorSocio").text('');
	$("#giroSocio").text('');
	$("#periodoSocio").text('');
	$("#idRecibo").val('');
	$("#lecturaInicialSocio").val('');
	$("#lecturaFinalSocio").val('');
	$("#consumoMesSocio").text('');
	$("#ConsumoMesSocioTrabado").val('');
	$("#cargoEnergiaSocio").val('');
	$("#alumbradoPublicoSocio").val('');
	$("#servicioMantenimientoSocio").val('');
	$("#deudaAnteriorSocio").val('');
	$("#reconexionSocio").val('');
	$("#totalSocio").text('');
	$("#codigoReciboLuzSocio").val('0');
	$("#reciboLuzCreado").val('');

}


function buscarReciboLuz(){
	var codigoRecibo = $("#codigoRecibo").val();
	var codigoPuesto = $("#reciboLuzSocioBuscara").val();
	//alert ("RECIBO: " + codigoRecibo + " PUESTO: " + codigoPuesto);
	jsonObj = [];
	var parametros = new Object();
	parametros.codigoRecibo = codigoRecibo;
	parametros.codigoPuesto = codigoPuesto;
	
	if(intentos > 0){
		$("#grillaReciboLuz").jqGrid('setGridParam',
		{
			url : 'reporte-recibo-luz-puesto.json',
			datatype : "json",
			postData:parametros,
			page:1
		}).trigger('reloadGrid');
	}else{
		buscarReciboLuzSocio(codigoRecibo, codigoPuesto);
	}
		
}


function buscarReciboLuzSocio(codigoRecibo, codigoPuesto){
	intentos = 1;
	
	var ruta = obtenerContexto();
	var formatterBotones = function(cellVal,options,rowObject)
	{	
		var opciones = "<center>";
			
			opciones += "<a href=javascript:editarReciboLuzXSocio('";
			opciones += rowObject.codigoReciboOriginal + "','" + rowObject.nroPuesto + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/edit_24x24.png' border='0' title='Editar Recibo Luz Socio'/>";
			opciones += "</a>";
			
			opciones += "&nbsp;&nbsp;";
			
			opciones += "<a href=javascript:generarReciboLuzXSocio('";
			opciones += rowObject.codigoSector + "','" + rowObject.nroPuesto + "','" + rowObject.codigoReciboOriginal + "') >";
			opciones += "<img src='/"+ruta+"/recursos/images/icons/agregar2_24x24.png' border='0' title='Crear Recibo de Luz por Socio'/>";
			opciones += "</a>";			

			opciones += "</center>";
			
		return opciones;
				
	};

	jsonObj = [];
	var parametros = new Object();
	parametros.codigoRecibo = codigoRecibo;
	parametros.codigoPuesto = codigoPuesto;
	
	alert("Codigo Puesto: " + $("#reciboLuzSocioBuscara").val());
	jQuery("#grillaReciboLuz").jqGrid(
	{
		url : 'reporte-recibo-luz-puesto.json',
		datatype : "json",
		mtype: 'POST',
		height: 'auto',
		width: 'auto',
		postData: parametros,
		colNames : ['Nombre Usuario', 'Puesto', 'Giro','Total', 'Opciones'],
		colModel : [{
			name : 'nombreFull',
			index: 'nombreFull',
			sortable:false,
			width: 320,
			align: 'left'
		},{
			name : 'nroPuesto',
			index: 'nroPuesto',
			sortable:false,
			width: 50,
			align: 'center'
		},{
			name : 'nombreGiro',
			index: 'nombreGiro',
			sortable:false,
			width: 150,
			align: 'center'
		},{
			name : 'total',
			index: 'total',
			sortable:false,
			width: 80,
			align: 'center'
		},{					
			name:'opciones',
			index:'opciones',
			width:110,
			sortable:false,
			search: false,
			formatter:formatterBotones
		}],								
		rowNum : 20,
		pager : '#pgrillaReciboLuz',
		sortname : 'codigoPuesto',
		autowidth: true,
		rownumbers: true,
		viewrecords : true,
		sortorder : "codigoPuesto",				
		caption : "Recibo de Luz Socios",
		afterInsertRow: function(rowId, data, item){
			//alert(rowId + ' - ' + data + ' - ' + item.total);
			if (item.reciboLuzCreado == 0){
				$("#grillaReciboLuz").setCell(rowId, 'nombreFull', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'nroPuesto', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'nombreGiro', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'total', '', { 'background-color':'#F5A9A9','color':'white','font-weight':'bold' });
			} else {
				$("#grillaReciboLuz").setCell(rowId, 'nombreFull', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'nroPuesto', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'nombreGiro', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
				$("#grillaReciboLuz").setCell(rowId, 'total', '', { 'background-color':'#A9F5A9','color':'black','font-weight':'bold' });
			}

		}

	}).trigger('reloadGrid');
}


function limpiar(){
	$("#codigoRecibo").val('0');
}

function activaManual(){
	if( $('#sintraba').is(":visible") ){
		$('#sintraba').hide();
		$('#contraba').show();
	} else {
		$('#sintraba').show();
		$('#contraba').hide();
	}
}

function campoEnter(e,t)
{
	var k=null;
	(e.keyCode) ? k=e.keyCode : k=e.which;
	if(k==13) (!t) ? botonEnter() : t.focus();
}

function botonEnter()
{
	document.forms[0].submit();
	return true;
}

</script>
</head>
<body id="body">
<input type="hidden" id="codigoPuestoSocio" />
<input type="hidden" id="codigoSocio" />
<input type="hidden" id="codigoRecibo" />
<input type="hidden" id="costoWatts" />
<input type="hidden" id="codigoReciboLuzSocio" />
<input type="hidden" id="reciboLuzCreado" />
<table border="0" width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td width="150"><b>MES RECIBO LUZ<b/></td>
		<td width="10">:</td>
		<td width="200"><input type="text" id="reciboBuscara" class="form-control" maxlength="8" /></td>
		<td>&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" onclick="cargarReciboLuzOriginal()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
			</button>&nbsp;&nbsp;
			<button class="btn btn-primary" data-toggle="modal" data-target="#luz_original_modal" onclick="nuevoRecibos()">
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
					<td><input type='text' id='periodo' class='text ui-widget-content ui-corner-all' size="10" tabindex="1"/>(mes/año)</td>
					<td>&nbsp;</td>
					<td><label><font size="2"><b>Fecha de Vencimiento:</b></font></label></td>
					<td><input type='text' id='fecVencimiento' class='text ui-widget-content ui-corner-all' size="10" tabindex="2"/>(dia/mes/año)</td>
				</tr>
				<tr>
					<td><label><font size="2"><b>Fecha de Emision:</b></font></label></td>
					<td><input type='text' id='fecEmision' class='text ui-widget-content ui-corner-all' size="10" tabindex="3"/>(dia/mes/año)</td>
					<td>&nbsp;</td>
					<td><label><font size="2"><b>Costo Wats:</b></font></label></td>	
					<td><input type='text' id='costoWats' class='text ui-widget-content ui-corner-all' size="10" value="0" tabindex="4"/></td>
				</tr>
				<tr>
					<td><label><font size="2"><b>Alumbrado Público:</b></font></label></td>
					<td><input type='text' id='alumbradoPublico' class='text ui-widget-content ui-corner-all' size="10" value="0" tabindex="5"/></td>
					<td>&nbsp;</td>
					<td><label><font size="2"><b>Mantenimiento:</b></font></label></td>	
					<td><input type='text' id='mantenimiento' class='text ui-widget-content ui-corner-all' size="10" value="0" tabindex="6"/></td>
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
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='repoManCnx' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos('O')"tabindex="6"/></td>
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
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='cargoFijo' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos('O')" tabindex="7"/></td>
				</tr>
				<tr>
					<td><font size="1">Energ. Activa Fuera Punta (kwh)</font></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energActFraPtaActual' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="8"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energActFraPtaAnteri' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="9"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energActFraPtaDifer' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="10"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energActFraPtaFactor' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="11"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energActFraPtaConsu' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="12"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energActFraPtaConfa' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="13"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energActFraPtaPreuni' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="14"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energActFraPtaTotal' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos('O')" tabindex="15"/></td>
				</tr>
				<tr>
					<td><font size="1">Energ. Activa Horas Punta (kwh)</font></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energActHorPtaActu' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="16"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energActHorPtaAnt' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="17"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energActHorPtaDif' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="18"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energActHorPtaFac' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="19"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energActHorPtaCons' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="20"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energActHorPtaConfac' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="21"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energActHorPtaPreuni' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="22"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energActHorPtaTotal' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos('O')" tabindex="23"/></td>
				</tr>
				<tr>
					<td><font size="1">Energía Reactiva (kVARh)</font></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energReacInicial' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="24"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energReacAnteri' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="25"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energReacDifere' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="26"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energReacFactor' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="27"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energReacConsu' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="28"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energReacFaccons' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="29"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energReacPreuni' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="30"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='energReacTotal' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos('O')" tabindex="31"/></td>
				</tr>
				<tr>
					<td><font size="1">Interés Compensatorio</font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaActIntCon' id='lecturaActIntCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntIntCon' id='lecturaAntIntCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaIntCon' id='DiferenciaIntCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorIntCon' id='FactorIntCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosIntCon' id='ConsumosIntCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsFactIntCon' id='ConsFactIntCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='PrecUnitIntCon' id='PrecUnitIntCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='interesCompensatorio' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos('O')" tabindex="32"/></td>
				</tr>
				<tr>
					<td><font size="1">Potencia FP (KW)</font></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciaFpIni' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="33"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciaFpAnte' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="34"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciaFpDif' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="35"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciaFpFac' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="36"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciaFpCons' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="37"/></td>
					<td align="center">&nbsp;<!-- input type='text' name='ConsFactPotFP' id='ConsFactPotFP' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' name='PrecUnitPotFP' id='PrecUnitPotFP' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' name='ImporTotalPotFP' id='ImporTotalPotFP' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
				</tr>
				<tr>
					<td><font size="1">Potencia HP (KW)</font></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciaHpAct' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="38"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciaHpAnt' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="39"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciaHpDif' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="40"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciaHpFac' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="41"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potenciaHpCons' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="42"/></td>
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
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potUsoRedDistConfac' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="43"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potUsoRedDistPreuni' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="44"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potUsoRedDistTotal' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos('O')" tabindex="45"/></td>
				</tr>
				<tr>
					<td><font size="1">Potencia de Generación FP (KW)</font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ledturaActPotGen' id='lecturaActPotGen' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntPotGen' id='lecturaAntPotGen' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaPotGen' id='DiferenciaPotGen' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorPotGen' id='FactorPotGen' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosPotGen' id='ConsumosPotGen' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potGenFpConfac' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="46"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potGenFpPreuni' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" tabindex="47"/></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='potGenFpTotal' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos('O')" tabindex="48"/></td>
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
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='alumbradoPublicoOriginal' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos('O')" tabindex="49"/></td>
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
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='subTotalMes' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" readonly="readonly" tabindex="50"/></td>
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
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='totalMesAct' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" readonly="readonly" tabindex="52"/></td>
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
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='aporteLey' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos('T')" tabindex="53"/></td>
				</tr>
				<tr>
					<td><font size="1">Deuda Anterior</font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaActCuoCon' id='lecturaActCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntCuoCon' id='lecturaAntCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaCuoCon' id='DiferenciaCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorCuoCon' id='FactorCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosCuoCon' id='ConsumosCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsFactCuoCon' id='ConsFactCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='PrecUnitCuoCon' id='PrecUnitCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='deudaAnterior' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos('T')" tabindex="54"/></td>
				</tr>
				<tr>
					<td><font size="1">Recargo por Mora</font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaActCuoCon' id='lecturaActCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntCuoCon' id='lecturaAntCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaCuoCon' id='DiferenciaCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorCuoCon' id='FactorCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosCuoCon' id='ConsumosCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsFactCuoCon' id='ConsFactCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='PrecUnitCuoCon' id='PrecUnitCuoCon' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='recargoMora' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos('T')" tabindex="55"/></td>
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
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='redonMesAnt' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos('T')" tabindex="56"/></td>
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
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='redonMesAct' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos('T')" tabindex="57"/></td>
				</tr>
				<tr>
					<td><font size="1">AJUSTE PRECIO RETRACTIVO</font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaActRedAct' id='lecturaActRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntRedAct' id='lecturaAntRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaRedAct' id='DiferenciaRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorRedAct' id='FactorRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosRedAct' id='ConsumosRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsFactRedAct' id='ConsFactRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='PrecUnitRedAct' id='PrecUnitRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='ajustePreRet' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos('T')" tabindex="58"/></td>
				</tr>
				<tr>
					<td><font size="1">IGV 18% Refact.</font></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaActRedAct' id='lecturaActRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='lecturaAntRedAct' id='lecturaAntRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='DiferenciaRedAct' id='DiferenciaRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='FactorRedAct' id='FactorRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsumosRedAct' id='ConsumosRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='ConsFactRedAct' id='ConsFactRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align="center">&nbsp;<!-- input type='text' class='texto' style='font-family:verdana;font-size:8px;' name='PrecUnitRedAct' id='PrecUnitRedAct' class='text ui-widget-content ui-corner-all' size="10" maxlength="10" /--></td>
					<td align='center'><input type='text' class='texto' style='font-family:verdana;font-size:8px;' id='igvRefact' class='text ui-widget-content ui-corner-all' size='10' maxlength='10' value="0" onChange="calculaCampos('T')" tabindex="59"/></td>
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
					<td align="center"><input type='text' name='total' class='texto' style='font-family:verdana;font-size:8px;' id='total' size="10" value="0" readonly="readonly" tabindex="60"/></td>
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
					<td colspan="4" style="color:red"><b>&nbsp;RECIBO DE LUZ ORIGINAL NRO. <span id="nroRecibo"></span></b></td>
				</tr>
				<tr>
					<td width="150"><b>PUESTO LUZ SOCIOS<b/></td>
					<td width="10">:</td>
					<td width="250"><input type="text" id="reciboLuzSocioBuscara" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
					<td>&nbsp;&nbsp;
						<button type="button" class="btn btn-primary" onclick="buscarReciboLuz();">
							<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
						</button>&nbsp;&nbsp;
						<!-- 
						<button class="btn btn-info" onclick="cargarReciboLuzSocio()">
							<img src="recursos/images/icons/buscar_16x16.png" alt="Actualizar" />&nbsp;Actualizar
						</button>
						 -->
					</td>
				</tr>
				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="4">
						<table id="grillaReciboLuz"></table>
						<div id="pgrillaReciboLuz"></div>
					</td>
				</tr>
			</table>	
		
		</div>
		
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="">Grabar</button>
			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="limpiar()">Cerrar</button>
		</div>
		
		</div>
	</div>
</div>


<!-- Ventana Modal Recibo Luz Ppor cada Socio -->
<div class="modal fade" id="recibos_luz_por_socio_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 450px">
		<div class="modal-content">
		
		<div class="modal-header modal-header-primary">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title">Recibos de Luz de Socio</h4>
		</div>

		<div class="modal-body">
		
			<table border="0" width="100%" cellpadding="0" cellspacing="0"></tr>
				<tr>
					<td colspan="4"><b>RECIBO DE LUZ <span id="reciboOriginal"></span><b/></td>
				</tr>
				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
			</table>
			<table border="1" width="100%">
				<tr>
					<td>
						<table border="0" width="100%">
							<tr>
								<td width="40%"><b>ASOCIADO (A) :</b></td>
								<td><div id="nombreSocio" style="color: blue; font-size:11px;" align="left"></div></td>
							</tr>
							<tr>
								<td><b>Nº PUESTO :</b></td>
								<td>
									<div id="puestoSocio" style="color: blue; width: 90px;" align="left"></div>								
								</td>
							</tr>
							<tr>
								<td><b>SECTOR :</b></td>
								<td><div id="sectorSocio" style="color: blue; width: 100px; font-size:11px;" align="left"></div></td>
							</tr>
							<tr>
								<td><b>GIRO :</b></td>
								<td><div id="giroSocio" style="color: blue; font-size:11px;" align="left"></div></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table border="0" width="100%">
							<tr>
								<td width="40%"><b>Periodo :</b></td>
								<td><div id="periodoSocio" style="color: blue; font-size:11px; width: 150px;" align="left"></div></td>
							</tr>
							<tr>
								<td><b>ID :</b></td>
								<td><input type='text' id='idRecibo' name='idRecibo' size='10' class='text ui-widget-content ui-corner-all' style="text-align: center;" onKeyDown="campoEnter(event,this.form.lecturaInicialSocio);"/></td>
							</tr>
							<tr>
								<td><b>Lectura Anterior :</b></td>
								<td><input type='text' id='lecturaInicialSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('L');" style="text-align: center;" onKeyDown="campoEnter(event,this.form.lecturaFinalSocio);"/></td>
							</tr>
							<tr>
								<td><b>Lectura Actual :</b></td>
								<td><input type='text' id='lecturaFinalSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('L');" style="text-align: center;"/></td>
							</tr>
							<tr>
								<td colspan="2" align="center"><label><input type="checkbox" id="cbox1" value="first_checkbox" onclick="activaManual()"> Medidor Trabado</label></td>
							</tr>
							<tr id="sintraba">
								<td><b>Consumo de Mes :</b></td>
								<td><div id="consumoMesSocio" style="border: 2px solid blue; width: 100px;" align="center"></div></td>
							</tr>
							<tr id="contraba">
								<td><b>Consumo de Mes :</b></td>
								<td><input type='text' id='consumoMesSocioTrabado' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('L');" style="text-align: center;border: 2px solid blue; width: 100px;"/></td>
							</tr>
						</table>		
					</td>
				</tr>
				<tr>
					<td>
						<table border="0" width="100%">
							<tr>
								<td width="40%"><b>Cargo por Energía :</b></td>
								<td><input type='text' id='cargoEnergiaSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('R');" style="text-align: center;" disabled="disabled"/></td>
							</tr>
							<tr>
								<td><b>Alumbrado Público :</b></td>
								<td><input type='text' id='alumbradoPublicoSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('R');" style="text-align: center;" disabled="disabled"/></td>
							</tr>
							<tr>
								<td><b>Mantenimiento :</b></td>
								<td><input type='text' id='servicioMantenimientoSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('R');" style="text-align: center;" disabled="disabled"/></td>
							</tr>
							<tr>
								<td><b>Deuda Anterior :</b></td>
								<td><input type='text' id='deudaAnteriorSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('R');" style="text-align: center;"/></td>
							</tr>
							<tr>
								<td><b>Reconexión :</b></td>
								<td><input type='text' id='reconexionSocio' size='10' class='text ui-widget-content ui-corner-all' onblur="operaciones('R');" style="text-align: center;"/></td>
							</tr>
							<tr>
								<td><b>TOTAL DE LUZ</b></td>
								<td><div id="totalSocio" style="border: 2px solid blue; width: 100px;" align="center"></div></td>
							</tr>
						</table>
						
					</td>
				</tr>
			</table>
		  
		  
		</div>
		
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="guardarRecibo()">Grabar</button>		
			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="limpiarReciboLuzSocio()">Cerrar</button>
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
				<h4 class="modal-title">Editar Recibo Luz</h4>
			</div>
			<div class="modal-body">
					
				<table border="0">
					<tr>
						<td><img src="recursos/images/icons/exclamation_32x32.png" border="0" />&nbsp;<b><span id="mensajeEditar" /></b></td>
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
