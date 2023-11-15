function SettaFuoco(nomeform,nomecampo)
	{
	document.forms[nomeform].elements[nomecampo].focus();
	}

function SetDivPos(key)
{
	var availableHeight = document.body.offsetHeight;
	var availableWidth = document.body.offsetWidth;

	if ((typeof(divLista) != 'undefined') && (typeof(document.all.tableLista) != 'undefined')){
		divLista.style.posTop = key;
		divLista.style.posWidth = document.all.tableLista.offsetWidth+17;
		divLista.style.posLeft = (document.body.offsetWidth-divLista.style.posWidth)/2;
		divLista.style.posHeight = document.body.offsetHeight - divLista.style.posTop - 80;
	}
}

function SetDivPos2(key)
{
	
	var availableHeight = document.body.offsetHeight;
	var availableWidth = document.body.offsetWidth;
	
	
	if ((typeof(divLista2) != 'undefined') && (typeof(document.all.tableLista2) != 'undefined')){	
		divLista2.style.posTop = key;
		divLista2.style.posWidth = document.all.tableLista2.offsetWidth+17;
		divLista2.style.posLeft = (document.body.offsetWidth-divLista2.style.posWidth)/2;
		divLista2.style.posHeight = document.body.offsetHeight - divLista2.style.posTop - 80; 
	}
}

function SetDivPos3(key)
{
	
	var availableHeight = document.body.offsetHeight;
	var availableWidth = document.body.offsetWidth;
	
	
	if ((typeof(divLista3) != 'undefined') && (typeof(document.all.tableLista3) != 'undefined')){	
		divLista3.style.posTop = key;
		divLista3.style.posWidth = document.all.tableLista3.offsetWidth+17;
		divLista3.style.posLeft = (document.body.offsetWidth-divLista3.style.posWidth)/2;
		divLista3.style.posHeight = document.body.offsetHeight - divLista3.style.posTop - 80; 
	}
}

function OpenWindow (pstr_Titolo, pstr_Parametri){
var llng_WWidth = 650;
var llng_WHeight = 425;
var	llng_WLeft = (screen.availWidth - llng_WWidth) / 2;
var llng_WTop = (screen.availHeight - llng_WHeight) / 2;


finestra = window.open ('..\\Pages\\'+pstr_Titolo+'.asp'+pstr_Parametri,
	pstr_Titolo,'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no'+
	',left='+llng_WLeft+
	',top='+llng_WTop+
	',width='+llng_WWidth+
	',height='+llng_WHeight);
}

function OpenWindow2 (pstr_Titolo, pstr_Parametri){
var llng_WWidth = 650;
var llng_WHeight = 425;
var	llng_WLeft = (screen.availWidth - llng_WWidth) / 2;
var llng_WTop = (screen.availHeight - llng_WHeight) / 2;

finestra = window.open ('..\\Pagine\\'+pstr_Titolo+'.asp'+pstr_Parametri,
	pstr_Titolo,'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no'+
	',left='+llng_WLeft+
	',top='+llng_WTop+
	',width='+llng_WWidth+
	',height='+llng_WHeight);
}

function ControllaFinestra()
{
	try
	{
		if (!finestra.closed)
		{
			try { 
				  finestra.focus();
				}
				catch (exception) 
				{
				}
		}
		
	}
	catch (exception) 
	{
	}
}


function OpenWindowAsp (pstr_Titolo, pstr_Parametri){
var llng_WWidth = 650;
var llng_WHeight = 425;
var	llng_WLeft = (screen.availWidth - llng_WWidth) / 2;
var llng_WTop = (screen.availHeight - llng_WHeight) / 2;

finestra = window.open ('..\\Asp\\'+pstr_Titolo+'.asp'+pstr_Parametri,
	pstr_Titolo,
	'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no'+
	',left='+llng_WLeft+
	',top='+llng_WTop+
	',width='+llng_WWidth+
	',height='+llng_WHeight);
}

function ComaReplace(str)
{
	if (str!= "")
	{
	strRep=str.split(",").join("$").split("'").join("ç")
	}
	else
	{
	strRep=str
	}
  return strRep		
}