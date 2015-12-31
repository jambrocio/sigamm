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
	
	.tablaCabecera{
		background-color: #428bca;
		color:white;
        /*font-family:Tahoma, Geneva, sans-serif;*/
        /*font-size:12px;*/
        font-weight: bold;
	}
</style>

<script>
$(document).ready(function(){	
	
	$('[data-toggle="popover"]').popover({ placement : 'right', trigger: "hover" });
	
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
         
	$("#fecha").datepicker(
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


function colorEtiquetas(){
	
	$("#lblconcepto").css("color", "black");
	
	$("#lblconcepto-img").hide();
	
}

function nuevoEgreso(){
	
	colorEtiquetas();
	
	/*$("#codigoPuesto").val(0);	
	$("#dniBuscar").val("");	
	$("#dni").val("");
	$("#apePaterno").val("");
	$("#apeMaterno").val("");
	$("#nombres").val("");
	$("#telefono").val("");	
	$("#totalesLetras").html("");
	$("#totales").html("");
	$("#btnAgregar").attr("disabled", false);*/
 
	cargarConceptos();
}

function cargarConceptos(){
	
	var parametros = new Object();
	parametros.rubro = 'E';
	
	$.ajax({
        type: "POST",
        async: false,
        url: "cargar-conceptos.json",
        cache: false,
        data: parametros,
        success: function(result){
        	
        	//alert(result);
        	$('#egreso_modal').modal({
        		backdrop: 'static',
        		keyboard: false,
        		width: '600px'
        	});
        	
        	var optionConceptos = "<option value=0>SELECCIONAR</option>";
        	$.each(result, function(keyM, conceptos) {
        		
        		optionConceptos += "<option value=" + conceptos.codigoConcepto + ">" + conceptos.nombreConcepto + "</option>";
        		
        	});
        	
        	$("#concepto").html(optionConceptos);
    		
        }
    });
	
}

function validarSiNumero(numero){
	
	//if (!/^([0-9])*$/.test(numero)){
	if (!/^([0-9])*[.]?[0-9]*$/.test(numero)){
		return false;	
	}else{
		return true;
	}
	
}

function buscaraRuc(){
	var ruta = obtenerContexto();
	
	jsonObj = [];
	var parametros = new Object();
	parametros.ruc = $("#ruc").val();
	
	$.ajax({
		type: "POST",
	    async:false,
	    url: "buscar-ruc.json",
	    cache : false,
	    data: parametros,
	    success: function(result){
	           
	    	alert(result);
	    	
	        /*if(result.camposObligatorios.length == 0){

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

	            
			}else{
                	
            	colorEtiquetas();
            	fila = "";
            	$.each(result.camposObligatorios, function(id, obj){
                        
                	$("#" + obj.nombreCampo).css("color", "red");
                    $("#" + obj.nombreCampo + "-img").show();
                    $("#" + obj.nombreCampo + "-img").attr("data-content", obj.descripcion);
                        
				});
                	
			}*/
                
		}
	});
	
	
}
	
function guardar(){
	
	var ruta = obtenerContexto();

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

</script>
</head>
<body id="body">
<input type="hidden" id="codigoSocio" />
<table border="0" style="width: 600px;">
	<tr>
		<td colspan="7" align="right">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="7" align="left">
			<button type="button" class="btn btn-primary" onclick="nuevoEgreso()">
				<img src="recursos/images/icons/nuevo_16x16.png" alt="Nuevo" />&nbsp;Nuevo
			</button>
			&nbsp;
			<button type="button" class="btn btn-primary" onclick="guardar()">
				<img src="recursos/images/icons/guardar_16x16.png" alt="Buscar" />&nbsp;Guardar
			</button>
			&nbsp;
			<button type="button" class="btn btn-primary">
				<img src="recursos/images/icons/reservar2_16x16.png" alt="Reservar" />&nbsp;Reservar
			</button>
		</td>
	</tr>
	<!-- tr>
		<td width="150"><b>EGRESOS...<b/></td>
		<td width="10">:</td>
		<td width="200"><input type="text" id="reciboBuscara" class="form-control" maxlength="8" /></td>
		<td>&nbsp;&nbsp;
			<button class="btn btn-primary" data-toggle="modal" data-target="egreso_modal" onclick="nuevoEgreso()">
				<img src="recursos/images/icons/buscar_16x16.png" alt="Nuevo" />&nbsp;Nuevo
			</button>
		</td>
	</tr -->
	<tr>
		<td colspan="7" align="right">&nbsp;</td>
	</tr>
</table>	


<div class="modal fade" id="egreso_modal" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog" style="width: 700px">
		
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"><span id="tituloRegistro" />Nuevo Egreso</h4>
			</div>
			<div class="modal-body">
				
					<table border="0" style="width: 650px;" >
						<tr>
							<td colspan="10" align="right">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="10" align="left">
								<button type="button" class="btn btn-primary" onclick="guardar(1)">
									<img src="recursos/images/icons/guardar_16x16.png" alt="Buscar" />&nbsp;Guardar
								</button>
							</td>
						</tr>
						<tr>
							<td colspan="10"><hr /></td>
						</tr>
						<tr>
							<td width="12px">&nbsp;</td>
							<td><span id="lblconcepto" style="font-size: 11px;"><b>CONCEPTO (*)</b></span></td>
							<td><b>:</b></td>
							<td><select id="concepto" class="form-control"></select></td>
							<td valign="top"><img id="lblconcepto-img" src="recursos/images/icons/error_20x20.png" style="display:none;" border="0" data-toggle="popover" /></td>
							<td width="12px">&nbsp;</td>
							<td><span id="lblnro" style="font-size: 11px;"><b>NRO (*)</b></span></td>
							<td><b>:</b></td>
							<td><input type="text" id="nro" class="form-control" maxlength="8"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="12px">&nbsp;</td>
							<td><span id="lblfecha" style="font-size: 11px;"><b>FECHA (*)</b></span></td>
							<td><b>:</b></td>
							<td><input type="text" id="fecha" class="form-control" maxlength="20"/></td>
							<td valign="top">&nbsp;</td>
							<td width="12px">&nbsp;</td>
							<td><span id="lblruc" style="font-size: 11px;"><b>RUC (*)</b></span></td>
							<td><b>:</b></td>
							<td><input type="text" id="ruc" class="form-control" maxlength="8" onblur="buscaraRuc()"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="12px">&nbsp;</td>
							<td><span id="lblrazonsocial" style="font-size: 11px;"><b>RAZON SOCIAL (*)</b></span></td>
							<td><b>:</b></td>
							<td colspan="6"><input type="text" id="razonsocial" class="form-control" maxlength="20"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="12px">&nbsp;</td>
							<td><span id="lbldescripcion" style="font-size: 11px;"><b>DESCRIPCION (*)</b></span></td>
							<td><b>:</b></td>
							<td colspan="6"><input type="text" id="descripcion" class="form-control" maxlength="20"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="12px">&nbsp;</td>
							<td><span id="lblrepresentante" style="font-size: 11px;"><b>REPRESENTANTE (*)</b></span></td>
							<td><b>:</b></td>
							<td colspan="6"><input type="text" id="representante" class="form-control" maxlength="20"/></td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="12px">&nbsp;</td>
							<td><span id="lbltotal" style="font-size: 11px;"><b>TOTAL (*)</b></span></td>
							<td><b>:</b></td>
							<td><input type="text" id="total" class="form-control" maxlength="20"/></td>
							<td valign="top">&nbsp;</td>
							<td width="12px">&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td width="12px">&nbsp;</td>
							<td colspan="9" style="font-size: 11px;"><b>(*) Campos Obligatorios</b></td>
						</tr>
					</table>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="guardar()">Grabar</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
			</div>
		</div>
		  
	</div>
</div> 
	
</body>
</html>