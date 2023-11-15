	function insertAll(Field,Texts,Values)
	{
		var VetValues;
		var VetTexts;
		clearAll(Field);
		VetValues=Values.split("|");
		VetTexts=Texts.split("|");
		addOption(Field,"-------------------------","-1");
			
		for (i=0;i<VetValues.length;i++)
			addOption(Field,VetTexts[i],VetValues[i]);
		eval('document.ListaTariffe.'+Field+'.options[0].selected=true');

	}
	function addOption(Field,Text,Value)
	{

		var NS4 = (document.layers) ? true : false;
		var IE4 = (document.all) ? true : false;
			
		if (NS4)
		{
			var newOpt  = new Option(Text,Value);
			var selLength = eval('document.ListaTariffe.'+Field+'.length');
			eval('document.ListaTariffe.'+Field+'.options[selLength]= newOpt') ;
		}
		else if (IE4)
		{
			var newOpt = document.createElement("OPTION");
			newOpt.text=Text;
			newOpt.value=Value;
			eval('document.ListaTariffe.'+Field+'.add(newOpt)');
		}

	}

	function clearAll(Field)
	{
		var NS4 = (document.layers) ? true : false;
		var IE4 = (document.all) ? true : false;
		
		var len = eval('document.ListaTariffe.'+Field+'.length');
		var NS4 = (document.layers) ? true : false;
		var IE4 = (document.all) ? true : false;
			
		for (i=0;i<len;i++)
		{
			if (NS4)
				eval('document.ListaTariffe.'+Field+'.options[0]=null');
			else if (IE4)
				eval('document.ListaTariffe.'+Field+'.remove(0)');
		}
	}
