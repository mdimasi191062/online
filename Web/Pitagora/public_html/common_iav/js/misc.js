//per gestione calendario
var blnCloseWindow = false;
var message1="Click per selezionare la data selezionata";
var message2="Click per cancellare la data selezionata";
function showMessage (field)
{
	if (field=='seleziona')
		self.status=message1;
	else
		self.status=message2;
}

//ricarica la pagina delle pagine con i paginatori quando si cambia il numero di record per pagina
function reloadPage(p_strTypeLoad,p_strUrl)
{
  document.frmDati.hidTypeLoad.value = p_strTypeLoad;
  document.frmDati.action = p_strUrl;
  document.frmDati.submit();
}

//permette l'esecuzione del prossimo step nelle pagine dei lanci batch
function goNextStep()
{
	document.frmDati.hidTypeLoad.value = 0;
	document.frmDati.hidStep.value = parseInt(document.frmDati.hidStep.value) + 1;
	document.frmDati.submit();	
}

function goPage(p_strUrl)
{
	document.frmDati.hidTypeLoad.value = "1";
	document.frmDati.action = p_strUrl;
	document.frmDati.submit();
}

//gestisce il ritorno della funzione sul popUp della paginazione Account
function handleReturnedValuePPAccount()
{
	switch (dialogWin.state)
	{
		case "CONFERMA":
			ONCONFERMA();
			break;
		case "ANNULLA":
			ONANNULLA();
			break;
	}
}
//apre il popup di paginazione sulle maschere di lancio	
function openPopUpAccount(p_strUrl)
{
    openDialog(strURL, 400, 300,handleReturnedValuePPAccount);
}
//arrotonda alla cifra specificata
function custRound(x,places) {
	// Created 1997 by Brian Risk.  http://members.aol.com/brianrisk
	return (Math.round(x*Math.pow(10,places)))/Math.pow(10,places)
}

//chiude le finestre di popUp dal set interval
function recursiveCloseWindow()
{
	if(blnCloseWindow){
		self.close();
	}
}

function closeWindow()
{
	blnCloseWindow = true;
	self.close();
}


 function openCentral(url,name,attr,width, height)
   {
   var objWinRif = window;

   if(window.parent.length>0){
   	objWinRif = window.top;	
   }
   if (document.all)
      {
      var x = objWinRif.screenLeft;
      var y = objWinRif.screenTop;
      var w = objWinRif.document.body.offsetWidth;
      var h = objWinRif.document.body.offsetHeight;
      }
  else
   {
   var x = objWinRif.screenX;
   var y = objWinRif.screenY;
   var w = objWinRif.outerWidth;
   var h = objWinRif.outerHeight;
   }
  var cntx = x + Math.round((w - width) / 2);
  var cnty = y + Math.round((h - height) / 2);

  attr = 'left=' + cntx + ',top=' + cnty + ',width=' + width + ',height=' + height + ',' + attr;
  objWindows = window.open (url,name,attr);
  return objWindows;
}

function ControllaFinestra()
{
	try{
		if (!objWindows.closed){
			try{ 
				objWindows.focus();
			}
			catch (exception){}
		}
	}
	catch (exception){}
}    
