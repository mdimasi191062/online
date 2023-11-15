	function updVS(pstr_objViewState, pstr_Etichetta, pstr_Valore){
			var lstr_GlobalString=pstr_objViewState.value;
			var lstr_OutputString="";
			var lbln_Esito=true;
			if(lstr_GlobalString!=""){
				var lArr_GlobalString = lstr_GlobalString.split("|");
				for(i=0;i<lArr_GlobalString.length;i++){
					var lArr_Elemento = lArr_GlobalString[i].split("=");
					//check dell'etichetta dell'array con quella da aggiornare
					if(lArr_Elemento[0]==pstr_Etichetta){
						lArr_Elemento[1]=pstr_Valore;
						lbln_Esito=false;
					}
					if(lstr_OutputString==""){
						lstr_OutputString=lArr_Elemento[0]+"="+lArr_Elemento[1];
					}else{
						lstr_OutputString+="|"+lArr_Elemento[0]+"="+lArr_Elemento[1];
					}
				}
			}
			if(lbln_Esito){
				if(lstr_OutputString==""){
					lstr_OutputString=pstr_Etichetta+"="+pstr_Valore;
				}else{
					lstr_OutputString+="|"+pstr_Etichetta+"="+pstr_Valore;
				}
			}
			pstr_objViewState.value=lstr_OutputString;
		}

function delVS(pstr_objViewState, pstr_Etichetta){
	var lstr_GlobalString=pstr_objViewState.value;
	var lstr_OutputString="";
	var lbln_Esito=true;
	var lArr_GlobalString = lstr_GlobalString.split("|");
	for(i=0;i<lArr_GlobalString.length;i++){
		var lArr_Elemento = lArr_GlobalString[i].split("=");
		//check dell'etichetta dell'array con quella da eliminare
		if(lArr_Elemento[0]!=pstr_Etichetta){
			lbln_Esito=false;
			if(lstr_OutputString==""){
				lstr_OutputString=lArr_Elemento[0]+"="+lArr_Elemento[1];
			}else{
				lstr_OutputString+="|"+lArr_Elemento[0]+"="+lArr_Elemento[1];
			}
		}else{
			lbln_Esito=true;//trovata etichetta da cancellare
		}
	}
	if(lbln_Esito){
		pstr_objViewState.value=lstr_OutputString;
	}else{//se esito false cioè non è stata trovata nessuna etichetta da cancellare
		//alert("non è stata trovata nessuna etichetta da cancellare")
	}
}

function getVS(pstr_objViewState, pstr_Etichetta){
	var lstr_GlobalString=pstr_objViewState.value;
	var lstr_OutputString="";
	var lbln_Esito=false;
	var lArr_GlobalString = lstr_GlobalString.split("|");
	for(i=0;i<lArr_GlobalString.length;i++){
		var lArr_Elemento = lArr_GlobalString[i].split("=");
		//check dell'etichetta dell'array con quella da eliminare
		if(lArr_Elemento[0]==pstr_Etichetta){
			lbln_Esito=true;
			lstr_OutputString=lArr_Elemento[1];
		}
	}
	if(lbln_Esito){
		return lstr_OutputString;
	}else{//se esito false cioè non è stata trovata nessuna etichetta
		return "missing";
	}
}