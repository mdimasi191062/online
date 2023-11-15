/* richiede quattro parametri:
1) il valore da testare, obbligatorio;
2) il numero massimo di cifre, opzionale (default 50);
3) il numero di decimali, opzionale (default 0);
4) booleano negativo sì o no, opzionale (default true)
Se il numero è decimale, impostando 2) e 3) si decide
anche la lunghezza massima della parte intera.
Restituisce true o false a seconda che siano o meno rispettati
i criteri impostati
*/
function CheckNum()
{
  var ie = (document.all)? true:false;
  var n =arguments.length;
  if(n<1 || n>4 )
  {
    alert("CheckNum:errore nel passaggio dei parametri.");
  }
  var valore=PuntoInVirgola(arguments[0]);
  var numMaxDigit = 50;
  var numMaxDec=0;
  var isNegativo=true;
  if(n>1)
  {
    numMaxDigit = arguments[1];
  }

  if(n>2)
  {
    numMaxDec = arguments[2];
  }
  if(n==4)
  {
    isNegativo = arguments[3];  
  }
  if(isNegativo)
  {
    if(valore.charAt(0)=="-")
      valore=valore.substr(1);
  }
	var pos = valore.search(",");
	var appo;
	//se trovo una virgola
	if(pos>-1) 
	{
		if(valore.length > numMaxDigit + 1)
		{
	 		return false;
		}
    var strAppo = valore.substring(0,pos);
    if(strAppo.length > numMaxDigit - numMaxDec)
    {
      return false;
    }
		if(valore.length > numMaxDigit + 1)
		{
	 		return false;
		}	
	    	if (numMaxDec>0)
	    	{
    			appo = valore.substr(pos + 1);
    			if (appo.search(",")>-1)
    			{
    				return false;
    			}
    			else
    			{
	    		    	if (appo.length > numMaxDec)
	    		    	{
	    		        	return false;
	    		    	}
    			}
		}
		else
		{
			return false;   
		}
	}
	else
	{
		if(valore.length > numMaxDigit - numMaxDec)
		{
	 		return false;
		}
	}
			       		
	var appo = "1234567890,";
  /*utilizzo questo artificio poichè con alcuni browser
    il metodo search non riconosce il .     */
  if(ie)
    valore = valore.replace('.','!');
	for (var i=0;i<valore.length;i++)
	{
		if (appo.indexOf(valore.charAt(i))==-1)
		{
			return false;
		}
	}
	if(valore.length>1)
	{
		if (valore.substring(0,2)=="00")
		{
			return false;
		}
	}
	
	return true;
}

function ControlloRange(campo,limiteRange) {
	var s = VirgolaInPunto(TogliPunti(campo.value));		
	var ns4;
		//Se esiste elimino la percentuale
	if (s.indexOf("%")!=-1) 
	{
		s= s.replace("%","");
	}
	ns4 = (document.layers)? true:false;
	if (s>limiteRange)
	{
		alert('Il valore numerico inserito é troppo elevato');
		if (ns4==true) 
		{
			campo.value="";
			return(false);
		} 
		else 
		{
			campo.focus();
			return(false);
		}
	}		
	return(true);
}
function GestioneNumerico(campo,n,limiteRange) {
	var ns4;
	ns4 = (document.layers)? true:false;
	if (n==1) {
		if (!CampoNumericoConVirgola(campo)) {
			return(false);
		} else {
			if (campo.value!="") {
				//campo.value = FormattaCampoConVirgola(campo.value);
			} else {
				campo.value = "";
			};	
		}
	} else if (n==2) {
		if (!CampoNumericoIntero(campo)) {
			alert("Campo numerico errato");
			return(false);
		} else {
			if (campo.value!="") {
				//campo.value = FormattaCampoIntero(campo.value);
			} else {
				campo.value = "";
			};			
		}
	} else if (n==3) {
		if (!CampoPercentuale(campo)) {
			alert("Campo numerico errato");			
			return(false);
		} else {
			if (campo.value!="") {
				//campo.value = FormattaCampoPercentuale(campo.value);
			} else {
				campo.value = "";
			};			
		}
	}
	return(ControlloRange(campo,limiteRange));
}



function CampoNumericoConVirgola(campo) {

	var s = TogliPunti(campo.value);
	var l = s.length;
	var n = 0;
	var p = 0;
	var nm = 0;
	var pm = 0;
	var ret = true;
	for (var i=0;i<l;i++) {
		if (s.charAt(i) == ",") {
			p = i+1;
			n++;
		} else if (s.charAt(i) == "-") {
			pm = i+1;
			nm++;
		} else {
			if (IndiceIn(s.charAt(i),"0123456789")==-1) {
				ret = false;
			}
		}
	}
	if (l>0) {
		if ( (nm>1) || (pm>1) ) {
			ret=false;
		}
		if ( (n>1) || (p==1) || (p==l) ) {
			ret=false;
		}
	}
	return ret;
}

function CampoNumericoIntero(campo) {
	var s = TogliPunti(campo.value);
	var l = s.length;
	var nm = 0;
	var pm = 0;
	var ret = true;
	for (var i=0;i<l;i++) {
		if (s.charAt(i) == "-") {
			pm = i+1;
			nm++;
		} else {
			if (IndiceIn(s.charAt(i),"0123456789")==-1) {
				ret = false;
			}
		}
	}
	if (l>0) {
		if ( (nm>1) || (pm>1) ) {
			ret=false;
		}
	}
	return ret;
}

function CampoPercentuale(campo) {
	var s = TogliPunti(campo.value);
	var l = s.length;
	var n = 0;
	var p = 0;
	var np = 0;
	var pp = 0;
	var nm = 0;
	var pm = 0;
	var ret = true;
	for (var i=0;i<l;i++) {
		if (s.charAt(i) == ",") {
			p = i+1;
			n++;
		} else if (s.charAt(i) == "-") {
			pm = i+1;
			nm++;
		} else if (s.charAt(i) == "%") {
			pp = i+1;
			np++;
		} else {
			if (IndiceIn(s.charAt(i),"0123456789")==-1) {
				ret = false;
			}
		}
	}
	if (l>0) {
		if ( (np>1) || (np==l) ) {
			ret=false;
		}
		if ( (nm>1) || (pm>1) ) {
			ret=false;
		}
		if ( (n>1) || (p==1) || (p==l) ) {
			ret=false;
		}
	}
	return ret;
}

function FormattaCampoConVirgola(s) {
	var s = TogliPunti(s);
	var l = s.length;
	var ret = "";
	var s1 = "";
	var s2 = "";
	var meno = false;
	if (l==0) {
		s1 = "0";
		s2 = "000";
	} else {
//		var n = parseFloat(VirgolaInPunto(s));
//		s0 = new String(PuntoInVirgola(n));
		s0 = new String(s);
		if (s0.substring(0,1) == "-") {
			meno = true;
			s0 = s0.substring(1);
		}
		l = s0.length;
		var i = IndiceIn(",",s0);
		if (i==-1) {
			s1 = StringaConPuntiMigliaia(s0);
//			s2 = "000";
		} else {
			if (i==0) {
				s1 = "0";
			} else {
				s1 = StringaConPuntiMigliaia(s0.substring(0,i));
			}
				//Limito il numero di decimali a 10 unità
			s2 = s0.substring(i+1,i+10);			
		}
		if (meno) {
			s1 = "-" + s1;
		}
		if (i==-1) {
			ret = s1;
		} else {
			ret = s1 + "," + s2;
		}
	}
	return ret;
}

function FormattaCampoIntero(s) {
	var s = TogliPunti(s);
	var l = s.length;
	var ret = "";
	var s1 = "";
	var meno = false;
	if (l==0) {
		s1 = "0";
	} else {
//		var n = parseInt(s);
//		s0 = new String(n);
		s0 = new String(s);
		if (s0.substring(0,1) == "-") {
			meno = true;
			s0 = s0.substring(1);
		}
		l = s0.length;
		s1 = StringaConPuntiMigliaia(s0);
		if (meno) {
			s1 = "-" + s1;
		}
	}
	ret = s1;
	return ret;
}

function FormattaCampoPercentuale(s) {
	var s = TogliPunti(s);
	var l = s.length;
	var ret = "";
	var s1 = "";
	var s2 = "";

//Se esiste elimino la percentuale
	if (s.indexOf("%")!=-1) 
	{
		s= s.replace("%","");
	}

	if (l==0) {
		s1 = "0";
		s2 = "00";
	} else {
//		var n = parseFloat(VirgolaInPunto(s));
//		s0 = new String(PuntoInVirgola(n));
		s0 = new String(s);
		l = s0.length;
		var i = IndiceIn(",",s0);
		if (i==-1) {
				//Controlliamo se é stato inserito il campo %
			var i = IndiceIn("%",s0);
			if (i==-1) 
			{
				s1 = StringaConPuntiMigliaia(s0);
			}	
			else
			{
				s1 = StringaConPuntiMigliaia(s0.substring(0,i));
			}
			s2 = "00";
		} else {
			if (i==0) {
				s1 = "0";
			} else {
				s1 = StringaConPuntiMigliaia(s0.substring(0,i));
			}
			s2 = Pad(s0.substring(i+1),"0",2);
		}
	}
	ret = s1 + "," + s2 + "%";
	return ret;
}

function StringaConPuntiMigliaia(s) {
	var ret = "";
	var l = s.length;
	for (i=(l-1),j=0;i>=0;i--,j++) {
		if ( ((j%3) == 0) && (j>=2) ) {
			ret = "." + ret;
		}
		ret = s.charAt(i) + ret;
	}
	return ret;
}

function Pad(s,c,n) {
	var ret = "";
	var l = s.length;
	var i;
	if (l>n) {
		ret = s.substring(0,n);
	} else {
		ret = s;
		for (i=l;i<n;i++) {
			ret = ret + c;
		}
	}
	return ret;
}

function VirgolaInPunto(s) {
	var l = s.length;
	var c;
	var ret="";
	for (var i=0;i<l;i++) {
		c = s.charAt(i);
		if (c == ",") {
			c = ".";
		}
		ret += c;
	}
	return ret;
}

function PuntoInVirgola(n) {
	var s = new String(n);
	var l = s.length;
	var c;
	var ret="";
	for (var i=0;i<l;i++) {
		c = s.charAt(i);
		if (c == ".") {
			c = ",";
		}
		ret += c;
	}
	return ret;
}
function IndiceIn(c,s) {
	var ret = -1;
	var l = s.length;
	for (var i=0;i<l;i++) {
		if (s.charAt(i) == c) {
			ret = i;
		}
	}
	return ret;
}

function TogliPunti(s) {
	var l = s.length;
	var ret = "";
	for (var i=0;i<l;i++) {
		if (s.charAt(i) != ".") {
			ret = ret + s.charAt(i);
		}
	}
	return ret;
}

function NSDisabled(campo) {
	campo.blur();
}


