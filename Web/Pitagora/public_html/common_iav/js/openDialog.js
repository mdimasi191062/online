var Nav4 = ((navigator.appName == "Netscape") && (parseInt(navigator.appVersion) == 4))

// One object tracks the current modal dialog opened from this window.
var dialogWin = new Object()

//modifiche fabio del 27-04-2004 - inizio
var dialogWin2 = new Object()
//modifiche fabio del 27-04-2004 - fine

function openDialog(url, width, height, returnFunc, args)
{
	
	if (!dialogWin.win || (dialogWin.win && dialogWin.win.closed))
	{
		//proprietà che indica uno stato da utilizzare successivamente
		dialogWin.state = "";
		dialogWin.returnFunc = returnFunc;
		dialogWin.returnedValue = "";
		dialogWin.returnedValue1 = "";
		dialogWin.returnedValue2 = "";
		dialogWin.returnedValue3 = "";
		dialogWin.returnedValue4 = "";
		dialogWin.returnedValue5 = "";
		dialogWin.args = args;
		dialogWin.url = url;
		dialogWin.width = width;
		dialogWin.height = height;
		dialogWin.name = "popUp";//Stesso nome per aprire la pagina sempre nello stesso popup //(new Date()).getSeconds().toString()

		if (Nav4)
		{
			dialogWin.left = window.screenX + ((window.outerWidth - dialogWin.width) / 2)
			dialogWin.top = window.screenY +  ((window.outerHeight - dialogWin.height) / 2)
			if (String(args)!="print")
				var attr = "screenX=" + dialogWin.left +  ",screenY=" + dialogWin.top + ",status=yes,resizable=yes,scrollbars=yes,width=" + dialogWin.width + ",height=" + dialogWin.height
			else
				if (String(args)!="resize")
					var attr = "screenX=" + dialogWin.left +  ",screenY=" + dialogWin.top + ",status=yes,resizable=yes,scrollbars=yes,width=" + dialogWin.width + ",height=" + dialogWin.height
				else
					var attr = "screenX=" + dialogWin.left +  ",screenY=" + dialogWin.top + ",status=yes,resizable=no,scrollbars=yes,width=" + dialogWin.width + ",height=" + dialogWin.height+",menubar=yes,toolbar=no"
		}
		else
		{
			dialogWin.left = (screen.width - dialogWin.width) / 2 ;
			dialogWin.top = (screen.height - dialogWin.height) / 2;
			if (String(args)!="print")
				var attr = "left=" + dialogWin.left + ",top=" + dialogWin.top + ",status=yes,resizable=yes,scrollbars=yes,width=" + dialogWin.width + ",height=" + dialogWin.height
			else
        var attr = "left=" + dialogWin.left +  ",top=" + dialogWin.top + ",status=yes,resizable=yes,scrollbars=yes,width=" + dialogWin.width + ",height=" + dialogWin.height+",menubar=yes,toolbar=no"
		}
		dialogWin.url = applyEscapeToURL(dialogWin.url);
		dialogWin.win=window.open(dialogWin.url, dialogWin.name, attr)
		dialogWin.win.focus()

	}
	else
	{
		dialogWin.win.focus()
	}
}




//modifiche fabio del 27-04-2004 - inizio
function openDialog2 (url, width, height, returnFunc, args)
{
	
	if (!dialogWin2.win || (dialogWin2.win && dialogWin2.win.closed))
	{
		//proprietà che indica uno stato da utilizzare successivamente
		dialogWin2.state = "";
		dialogWin2.returnFunc = returnFunc;
		dialogWin2.returnedValue = "";
		dialogWin2.returnedValue1 = "";
		dialogWin2.returnedValue2 = "";
		dialogWin2.returnedValue3 = "";
		dialogWin2.returnedValue4 = "";
		dialogWin2.returnedValue5 = "";
		dialogWin2.args = args;
		dialogWin2.url = url;
		dialogWin2.width = width;
		dialogWin2.height = height;
		dialogWin2.name = "popUp2";//Stesso nome per aprire la pagina sempre nello stesso popup //(new Date()).getSeconds().toString()

		if (Nav4)
		{
			dialogWin2.left = window.screenX + ((window.outerWidth - dialogWin2.width) / 2)
			dialogWin2.top = window.screenY +  ((window.outerHeight - dialogWin2.height) / 2)
			if (String(args)!="print")
				var attr = "screenX=" + dialogWin2.left +  ",screenY=" + dialogWin2.top + ",status=yes,resizable=yes,scrollbars=yes,width=" + dialogWin2.width + ",height=" + dialogWin2.height
			else
				if (String(args)!="resize")
					var attr = "screenX=" + dialogWin2.left +  ",screenY=" + dialogWin2.top + ",status=yes,resizable=yes,scrollbars=yes,width=" + dialogWin2.width + ",height=" + dialogWin2.height
				else
					var attr = "screenX=" + dialogWin2.left +  ",screenY=" + dialogWin2.top + ",status=yes,resizable=no,scrollbars=yes,width=" + dialogWin2.width + ",height=" + dialogWin2.height+",menubar=yes,toolbar=no"
		}
		else
		{
			dialogWin2.left = (screen.width - dialogWin2.width) / 2 ;
			dialogWin2.top = (screen.height - dialogWin2.height) / 2;
			if (String(args)!="print")
				var attr = "left=" + dialogWin2.left + ",top=" + dialogWin2.top + ",status=yes,resizable=yes,scrollbars=yes,width=" + dialogWin2.width + ",height=" + dialogWin2.height
			else
				var attr = "left=" + dialogWin2.left +  ",top=" + dialogWin2.top + ",status=yes,resizable=no,scrollbars=yes,width=" + dialogWin2.width + ",height=" + dialogWin2.height+",menubar=yes,toolbar=no"
		}
		dialogWin2.url = applyEscapeToURL(dialogWin2.url);
		dialogWin2.win=window.open(dialogWin2.url, dialogWin2.name, attr)
		dialogWin2.win.focus()

	}
	else
	{
		dialogWin2.win.focus()
	}
}
//modifiche fabio del 27-04-2004 - fine




function applyEscapeToURL(pstrQueryString)
{	
	var lstr_FinalURL="";
	var larr_URL = pstrQueryString.split("?");
	if(larr_URL.length>1)
	{
		//se c'è querystring
		var lstr_QueryString=larr_URL[1];
		
		var larr_Parametri=lstr_QueryString.split("&");
		
		lstr_FinalURL = pstrQueryString.split("?")[0];
		
		for(i=0;i<larr_Parametri.length;i++)
		{
		
			var larr_par = larr_Parametri[i].split("=");
			
			var strAppoNomeParametro = larr_par[0];
			
			var strAppoValoreParametro = larr_Parametri[i].substring(strAppoNomeParametro.length+1,larr_Parametri[i].length)
			
			
			if(i==0)
			{
				lstr_FinalURL+="?"+strAppoNomeParametro+"="+escape(strAppoValoreParametro);
			}
			else
			{
				lstr_FinalURL+="&"+strAppoNomeParametro+"="+escape(strAppoValoreParametro);
			}
		}
	}
	else
	{
	//non c'è querystring
		lstr_FinalURL=pstrQueryString;
	}
	return lstr_FinalURL
}

function resize(width, height)
{
	
	var left=0;
	var top=0;

	if (Nav4)
	{
		left = opener.window.screenX + ((opener.window.outerWidth - width) / 2)
		top = opener.window.screenY +  ((opener.window.outerHeight - height) / 2)
	}
	else
	{
		left = (screen.width - width) / 2 ;
		top = (screen.height - height) / 2;
	}
	parent.window.resizeTo(width,height);
	parent.window.moveTo(left,top);
}
