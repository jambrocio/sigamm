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
	while (text.toString().indexOf(busca) != -1)
		text = text.toString().replace(busca,reemplaza);
	return text;
}

//Elimina marcadores anteriormente mostrado en google maps
function eliminarMarcadoresGoogleMaps(markersArray){
	for (p in markersArray) {
		markersArray[p].setMap(null);
	}
}
