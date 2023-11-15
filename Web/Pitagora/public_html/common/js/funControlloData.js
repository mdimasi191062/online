function isDate(data){
	var NS4 = (document.layers) ? true : false;
	var IE4 = (document.all) ? true : false;
	if (IE4){
		var lungData;	
		var I;
		var sep;

		lungData = data.length;
		
		// verifico che ci siano due separatori e prendo i valori tra i separatori
		sep = 0;
    giorno = "";
		mese = "";
		anno = "";
		for (I=0; I <=lungData - 1 ; I++) {
			if (data.charAt(I) == "/") {
				sep = sep + 1;				
			}
			else {
        if ("0123456789".indexOf(data.charAt(I))==-1){
    			alert("Inserire una data valida. es: gg/mm/aaaa");
        	return false;	
        }
				if (sep == 0)
					giorno = giorno + data.charAt(I);
				if (sep == 1)
					mese = mese + data.charAt(I);
				if (sep == 2)
					anno = anno + data.charAt(I);

			}
		}
		if (sep != 2){
			alert("Inserire una data valida. es: gg/mm/aaaa");
			return false;	
		}
		else {
			if ((giorno > 31) || (giorno == "") || (giorno.length >2)) {
				alert("il giorno non è valido");
				return false;	
			}
		
			if ((mese > 12) || (mese == "") || (mese.length >2) ) {
				alert("il mese non è valido");
				return false;	
			}
			if (((anno < 1995) || (anno > 2029) ) && (anno.length == 4) ) {
				alert("l'anno non è valido");
				return false;	
			}
			if ( (anno.length != 2 ) && (anno.length != 4) ) {
				alert("l'anno non è valido");
				return false;	
			}


		}			

	}else{	
	var lungData;	
		var I;
		var sep;
		
		giorno=data.substring(0,2);
		mese=data.substring(3,5);
		anno=data.substring(6);

			if ((giorno > 31) || (giorno == "")) {
				alert("il giorno non è valido");
				return false;	
			}
		
			if ((mese > 12) || (mese == "")) {
				alert("il mese non è valido");
				return false;	
			}
	}		
	// controllo se l'anno è bisestile
	if (!isBisestile(anno) && ((mese == 2) && (giorno >= 29))) {		
		alert("L'anno non è bisestile");
		return false;
	}
	
	// controllo se i giorni nel mese sono validi
	if ((mese == 11 || mese == 4 || mese == 6 || mese == 9) && giorno > 30) {
		alert("Il mese è di 30 giorni");
		return false;
	}

	if (mese == 2 && giorno > 29) {			 
		alert("Il mese è di 28 giorni");
		return false;
	}
	
	
	return true;
}
	
	function isBisestile(anno){
		var resto1;
		var resto2;
		var resto3;

		resto1=0;
		resto2=0;
		resto3=0;

		resto1 = anno%4;
		resto2 = anno%100;
		resto3 = anno%400;
						
		if (resto1 == 0 && (resto2 != 0 || resto3 == 0))
			return true;
		else
			return false;
	}
function ControlloData(sData,sFlag)
{

	/**
	Dato che l'applet mi ritorna l'anno con due cifre inserisco decido che gli anno 
	che siano maggiori di 31 siano 1931
	**/
		
	var sErrDataMaggiore='La data di inizio validità deve essere maggiore o uguale alla data odierna'
	var giorno=0;
	var mese=0;
	var anno=0;
	
	if (!isDate(sData,'iniziale')) return(false);
	//Controllo il giorno
	giorno=sData.substring(0,2);
	//Controllo il mese
	mese=sData.substring(3,5);
	//Controllo l'anno
	anno=sData.substring(6);
	
	
	if (anno.length==2) 
	{
		if (anno<31)
		{
			anno='20' + anno
		}
		else
		{
			anno='19' + anno
		}
	}
	
	// controllo se la data se é maggiore di oggi
	if (sFlag==0)
        {
	<%
  int strAnno=Calendar.getInstance().get(Calendar.YEAR);
  int strMese=Calendar.getInstance().get(Calendar.MONTH);
  int strGiorno=Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
	%>
	if (parseInt(anno,10)<<%=strAnno%>)
	{
		alert(sErrDataMaggiore);
		return(false);			
	}
	else
	{
		if (parseInt(anno,10)==<%=strAnno%>)
		{
			if (parseInt(mese,10)<<%=strMese%>)
			{
				alert(sErrDataMaggiore);
				return(false);			
			}
			else
			{
				if (parseInt(mese,10)==<%=strMese%>)
				{				
					if (parseInt(giorno,10) < <%=strGiorno%>)
					{
						alert(sErrDataMaggiore);
						return(false);
					}				
				}
			}
		}
	}
	}
	return(true);
}
function ConfrontoData(sData1,sData2)
{

	/** impostazione data 1 (ovvero data più bassa)
	Dato che l'applet mi ritorna l'anno con due cifre inserisco decido che gli anno 
	che siano maggiori di 31 siano 1931
	**/
		
	var sErrDataMaggiore='La data di inizio validità deve essere minore o uguale alla data di fine validità'
	var giorno1=0;
	var mese1=0;
	var anno1=0;
	var giorno2=0;
	var mese2=0;
	var anno2=0;
	
	if (!isDate(sData1,'iniziale')) return(false);
	//Controllo il giorno della data iniziale
	giorno1=sData1.substring(0,2);
	//Controllo il mese della data iniziale
	mese1=sData1.substring(3,5);
	//Controllo l'anno della data iniziale
	anno1=sData1.substring(6);
	
	
	if (anno1.length==2) 
	{
		if (anno1<31)
		{
			anno1='20' + anno
		}
		else
		{
			anno1='19' + anno
		}
	}
	
	/** impostazione data 2 (ovvero data più recente)
	Dato che l'applet mi ritorna l'anno con due cifre inserisco decido che gli anno 
	che siano maggiori di 31 siano 1931
	**/
		
	
	if (!isDate(sData2,'finale')) return(false);
	//Controllo il giorno della data finale
	giorno2=sData2.substring(0,2);
	//Controllo il mese della data finale
	mese2=sData2.substring(3,5);
	//Controllo l'anno della data finale
	anno2=sData2.substring(6);
	
	
	if (anno2.length==2) 
	{
		if (anno2<31)
		{
			anno2='20' + anno
		}
		else
		{
			anno2='19' + anno
		}
	}
	
	// controllo se la data iniziale è maggiore di quella finale

	if (parseInt(anno2)<parseInt(anno1))
	{
		alert(sErrDataMaggiore);
		return(false);			
	}
	else
	{
		if (parseInt(anno2)==parseInt(anno1))
		{
			if (parseInt(mese2)<parseInt(mese1))
			{
				alert(sErrDataMaggiore);
				return(false);			
			}
			else
			{
				if (parseInt(mese2)==parseInt(mese1))
				{				
					if (parseInt(giorno2) < parseInt(giorno1))
					{
						alert(sErrDataMaggiore);
						return(false);
					}				
				}
			}
		}
	}
	return(true);
}