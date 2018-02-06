function obtenerContexto(){
	
	var contexto;
	var a = location.pathname.split("/");
	if ( a.length > 2 ) { 
		contexto=a[1];
	}
	
	return contexto;
}

function replaceAll(text, busca, reemplaza)
{
	if (text === undefined) {
	    //txt = "x is undefined";
		
		return "";
		
	} else {
	    //txt = "x is defined";
		
		while (text.toString().indexOf(busca) != -1)
			text = text.toString().replace(busca,reemplaza);
		return text;
		
	}
	
}

//Elimina marcadores anteriormente mostrado en google maps
function eliminarMarcadoresGoogleMaps(markersArray){
	for (p in markersArray) {
		markersArray[p].setMap(null);
	}
}

function pad (str, max) {
	  str = str.toString();
	  return str.length < max ? pad("0" + str, max) : str;
}

function formatearImporte (num) {
    return num.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
}

function fechaSistema(){
	var hoy = new Date();
	var dd = hoy.getDate();
	var mm = hoy.getMonth()+1; //hoy es 0!
	var yyyy = hoy.getFullYear();

	if(dd<10) {
	    dd='0'+dd
	} 

	if(mm<10) {
	    mm='0'+mm
	} 

	hoy = dd+'/'+mm+'/'+yyyy;
	return hoy;
}