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
function colorEtiquetas(){
	
	$("#lblpuesto").css("color", "black");
	$("#lblgiroComercial").css("color", "black");
	
	$("#lblpuesto-img").hide();
	$("#lblgiroComercial-img").hide();
	
}

function nuevoRecibo(){
	
	$('#puesto_modal').modal({
		backdrop: 'static',
		keyboard: false
	});
	
	$("#tituloRegistro").html("Nuevo Recibo de Luz");
	
	colorEtiquetas();
	
	$("#txtLecturaInih").val(0);
	$("#txtLecturaFinh").val(0);
	$("#txtConsumomesh").val(0);
	$("#txtCagofijoh").val(0);
	
	$("#txtAlupublich").val(0);
	$("#txtCargoenerh").val(0);
	$("#txtSubTotalMesh").val(0);
	$("#txtIgvh").val(0);
	$("#txtTotalMesh").val(0);
	$("#txtUsoEquipoh").val(0);
	$("#txtServmantoh").val(0);
	$("#txtAporteleyh").val(0);
	$("#txtRecargoh").val(0);
	$("#txtRedondeoh").val(0);
	$("#txtDeudaAnth").val(0);
	$("#txtCagofijoh").val(0);
	$("#txtCagofijoh").val(0);
	$("#txtCagofijoh").val(0);
	$("#txtCagofijoh").val(0);
	$("#txtCagofijoh").val(0);
	
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
</script>
</head>
<body id="body">
	<input type="hidden" id="codigoReciboLuz" />
	<input type="hidden" name="metodo" />
	
	<input type="hidden" name="descripanulada" id="descripanulada"/>
	<input type="hidden" name="tipodocumento" id="tipodocumento" value="R"/>
	
	<input type="hidden" name="codigoModi" id="codigoModi"/>
	<input type="hidden" name="lecturaInix" id="lecturaInix"/>
	<input type="hidden" name="lecturaFinx" id="lecturaFinx"/>
	<input type="hidden" name="montox" id="montox"/>
	<input type="hidden" name="costoWatsx" id="costoWatsx"/>
	<input type="hidden" name="periodox" id="periodox"/>
	<input type="hidden" name="estadox" id="estadox"/>

	<input type='hidden' name='repomancnxx' id='repomancnxx'/>
	<input type='hidden' name='cargofijox' id='cargofijox'/>
	<input type='hidden' name='alumpublicx' id='alumpublicx'/>
	<input type='hidden' name='subtotalmesx' id='subtotalmesx'/>
	<input type='hidden' name='igvx' id='igvx'/>
	<input type='hidden' name='totalmesactx' id='totalmesactx'/>
	<input type='hidden' name='aporteleyx' id='aporteleyx'/>
	<input type='hidden' name='cuotaconvx' id='cuotaconvx'/>
	<input type='hidden' name='redonmesactx' id='redonmesactx'/>
	<input type='hidden' name='redonmesantx' id='redonmesantx'/>
	<input type='hidden' name='interesconveniox' id='interesconveniox'/>
	<input type='hidden' name='energactfraptaactualx' id='energactfraptaactualx'/>
	<input type='hidden' name='energactfraptaanterix' id='energactfraptaanterix'/>
	<input type='hidden' name='energactfraptadiferx' id='energactfraptadiferx'/>
	<input type='hidden' name='energactfraptafactorx' id='energactfraptafactorx'/>
	<input type='hidden' name='energactfraptaconsux' id='energactfraptaconsux'/>
	<input type='hidden' name='energactfraptaconfax' id='energactfraptaconfax'/>
	<input type='hidden' name='energactfraptapreunix' id='energactfraptapreunix'/>
	<input type='hidden' name='energactfraptatotalx' id='energactfraptatotalx'/>
	<input type='hidden' name='energacthorptaactux' id='energacthorptaactux'/>
	<input type='hidden' name='energacthorptaantx' id='energacthorptaantx'/>
	<input type='hidden' name='energacthorptadifx' id='energacthorptadifx'/>
	<input type='hidden' name='energacthorptafacx' id='energacthorptafacx'/>
	<input type='hidden' name='energacthorptaconsx' id='energacthorptaconsx'/>
	<input type='hidden' name='energacthorptaconfacx' id='energacthorptaconfacx'/>
	<input type='hidden' name='energacthorptapreunix' id='energacthorptapreunix'/>
	<input type='hidden' name='energacthorptatotalx' id='energacthorptatotalx'/>
	<input type='hidden' name='energreacinicialx' id='energreacinicialx'/>
	<input type='hidden' name='energreacanterix' id='energreacanterix'/>
	<input type='hidden' name='energreacdiferex' id='energreacdiferex'/>
	<input type='hidden' name='energreacfactorx' id='energreacfactorx'/>
	<input type='hidden' name='energreacconsux' id='energreacconsux'/>
	<input type='hidden' name='energreacfacconsx' id='energreacfacconsx'/>
	<input type='hidden' name='energreacpreunix' id='energreacpreunix'/>
	<input type='hidden' name='energreactotalx' id='energreactotalx'/>
	<input type='hidden' name='potenciafpinix' id='potenciafpinix'/>
	<input type='hidden' name='potenciafpantex' id='potenciafpantex'/>
	<input type='hidden' name='potenciafpdifx' id='potenciafpdifx'/>
	<input type='hidden' name='potenciafpfacx' id='potenciafpfacx'/>
	<input type='hidden' name='potenciafpconsx' id='potenciafpconsx'/>
	<input type='hidden' name='potenciahpactx' id='potenciahpactx'/>
	<input type='hidden' name='potenciahpantx' id='potenciahpantx'/>
	<input type='hidden' name='potenciahpdifx' id='potenciahpdifx'/>
	<input type='hidden' name='potenciahpfacx' id='potenciahpfacx'/>
	<input type='hidden' name='potenciahpconsx' id='potenciahpconsx'/>
	<input type='hidden' name='potusoreddistconfacx' id='potusoreddistconfacx'/>
	<input type='hidden' name='potusoreddistpreunix' id='potusoreddistpreunix'/>
	<input type='hidden' name='potusoreddisttotalx' id='potusoreddisttotalx'/>
	<input type='hidden' name='potgenfpconfacx' id='potgenfpconfacx'/>
	<input type='hidden' name='potgenfppreunix' id='potgenfppreunix'/>
	<input type='hidden' name='potgenfptotalx' id='potgenfptotalx'/>
	
	<input type='hidden' name='fecvencimiento' id='fecvencimiento'/>
	<input type='hidden' name='fecemision' id='fecemision'/>


<table border="0" width="100%">
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
			<button type="button" class="btn btn-primary" onclick="nuevoRecibo()">
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
							<td colspan="13" align="right">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="13" align="left">
								<button type="button" class="btn btn-primary" onclick="guardar(1)">
									<img src="recursos/images/icons/guardar_16x16.png" alt="Buscar" />&nbsp;Guardar
								</button>
							</td>
						</tr>
						<tr>
							<td colspan="13" align="right">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><span id="lblrecibo" style="width: 130px"><b>FECHA RECIBO</b></span></td>
							<td width="3px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="3px">&nbsp;</td>
							<td><input type="text" id="dniBuscar" class="form-control" maxlength="8" /></td>
							<td valign="top" colspan="7">&nbsp;&nbsp;
								<button type="button" class="btn btn-primary" onclick="buscarUsuario()">
									<img src="recursos/images/icons/buscar_16x16.png" alt="Buscar" />&nbsp;Buscar
								</button>
							</td>
						</tr>
						<tr>
							<td colspan="13">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><label style="width: 150px">Lectura Inicial</label></td>
							<td width="3px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="3px">&nbsp;</td>
							<td><input type='text' name='txtLecturaInih' id='txtLecturaInih' class='text ui-widget-content ui-corner-all' size="10" tabindex="1" onchange="calculaConsumoMes(this,txtLecturaFinh)"/></td>
							<td width="50px">&nbsp;</td>
							<td><label style="width: 150px">Lectura Final</label></td>
							<td width="3px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="3px">&nbsp;</td>
							<td><input type='text' name='txtLecturaFinh' id='txtLecturaFinh' class='text ui-widget-content ui-corner-all'  size="10"  tabindex="2" onchange="calculaConsumoMes(txtLecturaInih,this)"/></td>
							<td width="10px">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><label style="width: 150px">Consumo del Mes</label></td>
							<td width="3px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="3px">&nbsp;</td>
							<td><input type='text' name='txtConsumomesh' id='txtConsumomesh' class='text ui-widget-content ui-corner-all' size="10" readonly="readonly"tabindex="3" /></td>
							<td width="50px">&nbsp;</td>
							<td><label style="width: 150px">Cargo Fijo</label></td>
							<td width="3px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="3px">&nbsp;</td>
							<td><input type='text' name='txtCagofijoh' id='txtCagofijoh' class='text ui-widget-content ui-corner-all' size="10" onchange="calculaTotalMes()" tabindex="4"/></td>
							<td width="10px">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><label style="width: 150px">Alumbrado Público</label></td>
							<td width="3px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="3px">&nbsp;</td>
							<td><input type='text' name='txtAlupublich' id='txtAlupublich' class='text ui-widget-content ui-corner-all' size="10" onchange="calculaTotalMes()" tabindex="5"/></td>
							<td width="50px">&nbsp;</td>
							<td><label style="width: 150px">Cargo Por Energia</label></td>
							<td width="3px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="3px">&nbsp;</td>
							<td><input type='text' name='txtCargoenerh' id='txtCargoenerh' class='text ui-widget-content ui-corner-all' size="10" readonly="readonly" tabindex="6" /></td>
							<td width="10px">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><label style="width: 150px">Sub Total del Mes</label></td>
							<td width="3px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="3px">&nbsp;</td>
							<td><input type='text' name='txtSubTotalMesh' id='txtSubTotalMesh' class='text ui-widget-content ui-corner-all' size="10" readonly="readonly" tabindex="7"/></td>
							<td width="50px">&nbsp;</td>
							<td><label style="width: 150px">Igv</label></td>
							<td width="3px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="3px">&nbsp;</td>
							<td><input type='text' name='txtIgvh' id='txtIgvh' class='text ui-widget-content ui-corner-all' size="10" readonly="readonly"tabindex="8"/></td>
							<td width="10px">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><label style="width: 150px">Sub Total del Mes</label></td>
							<td width="3px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="3px">&nbsp;</td>
							<td><input type='text' name='txtTotalMesh' id='txtTotalMesh' class='text ui-widget-content ui-corner-all' size="10" readonly="readonly" tabindex="9"/></td>
							<td width="50px">&nbsp;</td>
							<td><label style="width: 150px">Igv</label></td>
							<td width="3px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="3px">&nbsp;</td>
							<td><input type='text' name='txtUsoEquipoh' id='txtUsoEquipoh' class='text ui-widget-content ui-corner-all' size="10" onchange="calculaTotal()" tabindex="10"/></td>
							<td width="10px">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><label style="width: 150px">Repos.,Mant.y Serv.Tec.</label></td>
							<td width="3px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="3px">&nbsp;</td>
							<td><input type='text' name='txtServmantoh' id='txtServmantoh' class='text ui-widget-content ui-corner-all' size="10" onchange="calculaTotal()" tabindex="11"/></td>
							<td width="50px">&nbsp;</td>
							<td><label style="width: 150px">Aporte Ley 284449</label></td>
							<td width="3px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="3px">&nbsp;</td>
							<td><input type='text' name='txtAporteleyh' id='txtAporteleyh' class='text ui-widget-content ui-corner-all' size="10" onchange="calculaTotal()" tabindex="12"/></td>
							<td width="10px">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><label style="width: 150px">Recargo</label></td>
							<td width="3px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="3px">&nbsp;</td>
							<td><input type='text' name='txtRecargoh' id='txtRecargoh' class='text ui-widget-content ui-corner-all' size="10" onchange="calculaTotal()" tabindex="13"/></td>
							<td width="50px">&nbsp;</td>
							<td><label style="width: 150px">Redondeo del Mes</label></td>
							<td width="3px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="3px">&nbsp;</td>
							<td><input type='text' name='txtRedondeoh' id='txtRedondeoh' class='text ui-widget-content ui-corner-all' size="10" onchange="calculaTotal()" tabindex="14"/></td>
							<td width="10px">&nbsp;</td>
						</tr>
						<tr>
							<td width="10px">&nbsp;</td>
							<td><label style="width: 150px">Deuda Anterior</label></td>
							<td width="3px">&nbsp;</td>
							<td><b>:</b></td>
							<td width="3px">&nbsp;</td>
							<td><input type='text' name='txtDeudaAnth' id='txtDeudaAnth' class='text ui-widget-content ui-corner-all' size="10" onchange="calculaTotal()" style="color:red; font-style: bold" tabindex="15"/></td>
							<td colspan="7">&nbsp;</td>
						</tr>
								<!--tr>
									<td><label><b>Total:</b></label></td>
									<td colspan="3"><input type='text' name='txtTotalh' id='txtTotalh' class='text ui-widget-content ui-corner-all' size="10" readonly tabindex="16"/></td>
								</tr>
								<tr>
									<td><button name="btngrabar" id="btngrabar" onclick="grabar();" tabindex="17">Grabar</button></td>
									<td><button name="btncerrar" id="btncerrar" onclick="cerrarPop();" tabindex="18">Cancelar</button></td>
									<td><button name="btnpagar" id="btnpagar" onclick="pagar();" tabindex="19">Pagar</button></td>
								</tr-->
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

</body>
</html>