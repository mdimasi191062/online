function gotoPage(pobjForm,pintPageRichiesta,pstrURL,pintTypeLoad){
	pobjForm.hidPaginaRichiesta.value = pintPageRichiesta;
	if(pintTypeLoad==undefined){
		pobjForm.hidTypeLoad.value = "1";
	}else{
		pobjForm.hidTypeLoad.value = pintTypeLoad;
	}
	pobjForm.action=pstrURL;
	pobjForm.submit();
}