function cancelLink ()
{
  	return false;
}
//disabilita i link
function DisableLink (p_objLink,p_objImg)
{
	  var strAppoImgPath = "";
	  strAppoImgPath = new String(p_objImg.src);
	  
	  strAppoImgPath = strAppoImgPath.replace(".gif","_dis.gif");

	  p_objImg.src = strAppoImgPath;
	  
	  message1="Link disabilitato";
	  message2="Link disabilitato";
	  if (p_objLink.onclick){
	    p_objLink.oldOnClick = p_objLink.onclick;
	  }
	  p_objLink.onclick = cancelLink;
	  if (p_objLink.style){
	    p_objLink.style.cursor = 'default';
	  }
}
//abilita i link
function EnableLink (p_objLink,p_objImg)
{
	  var strAppoImgPath = "";
	  strAppoImgPath = new String(p_objImg.src);
	  
	  strAppoImgPath = strAppoImgPath.replace("_dis.gif",".gif");

	  p_objImg.src = strAppoImgPath;
	  
	  message1="Click per selezionare la data selezionata";
	  message2="Click per cancellare la data selezionata";
	  p_objLink.onclick = p_objLink.oldOnClick ? p_objLink.oldOnClick : p_objLink;
	  if (p_objLink.style){
	    p_objLink.style.cursor = document.all ? 'hand' : 'pointer';
	  }
}


function Disable(objElement)
{
	if(objElement != null){
		objElement.disabled = true;
		objElement.onfocus = handleDisabled;
	}
}

function Enable(objElement)
{
	if(objElement != null){
		objElement.disabled = false;
	}
}

function handleDisabled()
{
	p_objCurrent = this;
	if(p_objCurrent.disabled == true)
	{
		p_objCurrent.blur();
		alert("Controllo disabilitato!");
	}
}

//disabilita tutti i controlli di un form
function DisableAllControls(objForm)
{
	var Nav4 = ((navigator.appName == "Netscape") && (parseInt(navigator.appVersion) == 4));
	var objCollectionInput;
	var objCurrent; 
	//impostazione collezione degli elementi di input
	if(Nav4) // netscape 
	{
		 objCollectionInput = objForm;
	}
	else // explorer
	{
		 objCollectionInput = objForm.elements;
	}
	//ciclo sugli elementi di input della form
	for (i=0 ; i < objCollectionInput.length;i++)
	{
		//non disabilito i campi nascosti!!!
		if(objCollectionInput[i].type.toUpperCase() != "HIDDEN"){
			objCurrent = objCollectionInput[i];
			Disable(objCurrent);
		}
	}
}
//abilita tutti i controlli di un form
function EnableAllControls(objForm)
{
	var Nav4 = ((navigator.appName == "Netscape") && (parseInt(navigator.appVersion) == 4));
	var objCollectionInput;
	var objCurrent;
	//impostazione collezione degli elementi di input
	if(Nav4) // netscape 
	{
		 objCollectionInput = objForm;
	}
	else // explorer
	{
		 objCollectionInput = objForm.elements;
	}
	//ciclo sugli elementi di input della form
	for (i=0 ; i < objCollectionInput.length;i++)
	{
		objCurrent = objCollectionInput[i];
		Enable(objCurrent);
	}
}