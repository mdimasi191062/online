function getRadioButtonIndex(p_objRadio)
{
	//un solo radio
	if(p_objRadio.length==null)
	{
		if(p_objRadio.checked == true)
		{
			return -1;
		}
	}
	else
	{
		//piu di un radio
		for(i=0;i < p_objRadio.length;i++)
		{
			if(p_objRadio[i].checked == true)
			{
				return i;
			}
		}
	}
}

//disabilita tutti i radio di una collezione
function DisableRadio(p_objRadio,p_blnEnable)
{
	//un solo radio
	if(p_objRadio.length==null)
	{
		p_objRadio.disabled == p_blnEnable;
	}
	else
	{
		//piu di un radio
		for(i=0;i < p_objRadio.length;i++)
		{
			p_objRadio[i].disabled == p_blnEnable;
		}
	}
}
//reperisce il valore del radio button selezionato
function getRadioButtonValue(p_objRadio)
{
	//un solo radio
	if(p_objRadio.length==null)
	{
		if(p_objRadio.checked == true)
		{
			return p_objRadio.value;
		}
	}
	else
	{
		//piu di un radio
		for(i=0;i < p_objRadio.length;i++)
		{
			if(p_objRadio[i].checked == true)
			{
				return p_objRadio[i].value;
			}
		}
	}
}

//setta il valore del radio button selezionato
function setRadioButtonValue(p_objRadio,p_strValue)
{
	//un solo radio
	if(p_objRadio.length==null)
	{
		if(p_objRadio.checked == true)
		{
			p_objRadio.value = p_strValue;
		}
	}
	else
	{
		//piu di un radio
		for(i=0;i < p_objRadio.length;i++)
		{
			if(p_objRadio[i].checked == true)
			{
				p_objRadio[i].value = p_strValue;
			}
		}
	}
}
//reperisce il valore del comboBox		
function getComboValue(p_objCombo)
{
	return p_objCombo.options[p_objCombo.selectedIndex].value;
}

//reperisce il valore del comboBox		
function getComboValueByIndex(p_objCombo,p_intIndex)
{
	return p_objCombo.options[p_intIndex].value;
}

//reperisce il testo del comboBox		
function getComboText(p_objCombo)
{
	return p_objCombo.options[p_objCombo.selectedIndex].text;
}

//reperisce il testo del comboBox		
function getComboTextByIndex(p_objCombo,p_intIndex)
{
	return p_objCombo.options[p_intIndex].text;
}

//reperisce l'indice del comboBox		
function getComboIndex(p_objCombo)
{
	return p_objCombo.selectedIndex;
}

//seleziona il primo elemento della combo
function setFirstCboElement(p_objCombo)
{
	p_objCombo.selectedIndex=0;
}

function getComboCount(p_objCombo){
	return p_objCombo.length;
}

function clearField(p_objField)
{
	if(p_objField.type == "SELECT-ONE")
	{	
		setFirstCboElement(p_objField);
	}
	
	p_objField.value = "";
}
//pulisce i campi di un form
function clearAllFields(objForm)
{
	var objCollectionInput = null;
	var Nav4 = ((navigator.appName == "Netscape") && (parseInt(navigator.appVersion) == 4));
	
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
		if((objCollectionInput[i].type.toUpperCase() == "TEXT" 
			|| objCollectionInput[i].type.toUpperCase() == "SELECT-ONE" 
			|| objCollectionInput[i].type.toUpperCase() == "PASSWORD"
			|| objCollectionInput[i].type.toUpperCase() == "TEXTAREA"))
			{
				if(objCollectionInput[i].type.toUpperCase() == "SELECT-ONE"){	
					setFirstCboElement(objCollectionInput[i]);
				}else{
					objCollectionInput[i].value = "";
				}
			}
	}
	
}

