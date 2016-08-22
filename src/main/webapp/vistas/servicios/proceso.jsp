<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Otro</title>
<script>
	$(function() {
		cargarSocios();
	});

	function cargarSocios() {

		var parametros = new Object();

		$.ajax({type : "POST",
				async : false,
				url : "listar-socios.json",
				cache : false,
				data : parametros,
				success : function(result) {
					var optionSocios = "<option value=0>SELECCIONAR</option>";
					$.each(result,function(keyM, socios) {
						optionSocios += "<option value=" + socios.codigo_socio + ">" + socios.NOMBRE_FULL + "</option>";
					});
					$("#socios").html(optionSocios);
				}
			});

	}
</script>
</head>
<body>
	<table border="0" style="width: 1250px;">

		<tr>
			<td width="12px">&nbsp;</td>
			<td><span id="lblsocios" style="font-size: 11px;"><b>ASOCIADOS (*)</b></span></td>
			<td><b>:</b></td>
			<td><select id="socios" class="form-control"></select></td>
			<td valign="top"><img id="lblconcepto-img" src="recursos/images/icons/error_20x20.png" style="display: none;" border="0" data-toggle="popover" /></td>
			<td width="12px">&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
</body>
</html>