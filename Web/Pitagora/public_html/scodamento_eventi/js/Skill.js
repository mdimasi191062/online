function Cambia (varNumTab) {
	
	varNumTab.style.display="";
	var i;
	
	for (i=1;i<3;i++) {
	
		var OtherTab = eval("document.all.Tab" + i);
		if (OtherTab != varNumTab) {
			OtherTab.style.display="none";	
		}	
	}
}

