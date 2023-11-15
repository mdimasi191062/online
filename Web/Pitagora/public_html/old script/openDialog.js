var Nav4 = ((navigator.appName == "Netscape") && (parseInt(navigator.appVersion) == 4))

// One object tracks the current modal dialog opened from this window.
var dialogWin = new Object()

function openDialog(url, width, height, returnFunc, args)
{
	if (!dialogWin.win || (dialogWin.win && dialogWin.win.closed))
	{
		dialogWin.returnFunc = returnFunc
		dialogWin.returnedValue = "";
		dialogWin.returnedValue1 = "";
		dialogWin.args = args
		dialogWin.url = url
		dialogWin.width = width
		dialogWin.height = height
		dialogWin.name = (new Date()).getSeconds().toString()

		if (Nav4)
		{
			dialogWin.left = window.screenX + ((window.outerWidth - dialogWin.width) / 2);
			dialogWin.top = window.screenY +  ((window.outerHeight - dialogWin.height) / 2);
			var attr = ",scrollbars=yes,resizable=yes,screenX=" + dialogWin.left +  ",screenY=" + dialogWin.top + ",width=" + dialogWin.width + ",height=" + dialogWin.height+", toolbar=0, status=1, menubar=1, scrollbars=1";
		
		}
		else
		{
			dialogWin.left = (screen.width - dialogWin.width) / 2 ;
			dialogWin.top = (screen.height - dialogWin.height) / 2;
			var attr = "resizable=1, left=" + dialogWin.left + ", top=" + dialogWin.top + ", width=" + dialogWin.width + ", height=" + dialogWin.height+", toolbar=0, status=1, menubar=0, scrollbars=1, location=0";
		}
		dialogWin.win=window.open(dialogWin.url, dialogWin.name, attr)
		dialogWin.win.focus()

	}
	else
	{
		dialogWin.win.focus()
	}
}

function Disable(objElement)
{
	objElement.disabled = true;
}

function Enable(objElement)
{
	objElement.disabled = false;
}
