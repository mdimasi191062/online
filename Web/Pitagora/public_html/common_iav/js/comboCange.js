	function insertAll(p_strField,Texts,Values)
	{
		var VetValues;
		var VetTexts;
		var objField = eval(p_strField);
		clearAll(objField);
		VetValues=Values.split("|");
		VetTexts=Texts.split("|");
		addOption(objField,"[Seleziona Opzione]","");
		for (i=0;i < VetValues.length;i++)
		{
			addOption(objField,VetTexts[i],VetValues[i]);
		}
		objField.options[0].selected=true;
	} 
	
	function addOption(objField,Text,Value)
	{
    
		var NS4 = (document.layers) ? true : false;
		var IE4 = (document.all) ? true : false;
			
		if (NS4)
		{
			var newOpt  = new Option(Text,Value);
			var selLength =objField.length;
			objField.options[selLength]= newOpt ;
		}
		else if (IE4)
		{
			var newOpt = document.createElement("OPTION");
			newOpt.text=Text;
			newOpt.value=Value;
			objField.add(newOpt);
		}
		return newOpt;

	}
	
	function DelOptionByIndex(Field,p_intIndex)
	{
		Field.options[p_intIndex] = null;
	}
	
	function clearAll(Field)
	{
		var len = Field.length;
		var x=0;
		for (x=0;x<len;x++)
		{
			Field.options[0] = null;
		}
	}
	
	function clearAllSpaces(Field)
	{
		var len = Field.length;
		var x=0;
		for (x=0;x<len;x++)
		{
			if(getComboValueByIndex(Field,x) == "")
			{
				Field.options[x] = null;
			}
		}
	}
	function selectAllComboElements(Field)
	{
		var len = Field.length;
		var x=0;
		for (x=0;x<len;x++)
		{
			Field.options[x].selected = true;
		}
	}
	function selectComboByValue(pobj_Combo, pstr_Value){
		for(i=0;i<pobj_Combo.length;i++){
			if(pobj_Combo.options[i].value==pstr_Value){
				pobj_Combo.options[i].selected=true;
				i=pobj_Combo.length;
			}
		}
	}

  function ResetCombo(cboSource,cboText,cboValue){
    var myOpt = null;
    myOpt = addOption(cboSource,cboText,cboValue);
  }