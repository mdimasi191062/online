var isnn,isie
if(navigator.appName=='Microsoft Internet Explorer') //check the browser
{  isie=true }

if(navigator.appName=='Netscape')
{  isnn=true }

function right(e) //to trap right click button 
{
	if (isnn && (e.which == 3 || e.which == 2 ))
	{
		alert("Attenzione, non si hanno i diritti per visualizzare il codice di questa pagina.");
		return false;
	}
	else if (isie && (event.button == 2 || event.button == 3)) 
	{
		alert("Attenzione, non si hanno i diritti per visualizzare il codice di questa pagina.");
		return false;
	}
	return true;
}

function key(k)   
{

	return true; 

	if(isie)
	{
		if(event.keyCode==17 || event.keyCode==18 || event.keyCode==93)
		{
			alert("Attenzione, non si hanno i diritti per visualizzare il codice di questa pagina. EX");
			return false; 
		 }
		 else
			return true; 
	}

	if(isnn)
	{
		alert("Attenzione, non si hanno i diritti per visualizzare il codice di questa pagina. Ne");
		return false; 
	}   
}
/*
if (isnn) window.captureEvents(Event.Keypress);  
if (isnn) window.captureEvents(Event.Click);
if (isnn) window.captureEvents(Event.MOUSEUP);
document.onkeydown=key;  
document.onmousedown=right;
document.onmouseup=right;
//window.document.layers=right;
*/
