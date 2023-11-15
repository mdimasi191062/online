
//funzione di replace di una string
/*function Replace(Expression, Find, Replace)
{
	var temp = Expression;
	var a = 0;

	for (var i = 0; i < Expression.length; i++) 
	{
		a = temp.indexOf(Find);
		if (a == -1)
			break
		else
			temp = temp.substring(0, a) + Replace + temp.substring((a + Find.length));
	}

	return temp;
}*/
function Replace(inputString, fromString, toString) {
   // Goes through the inputString and replaces every occurrence of fromString with toString
   var temp = inputString;
   if (fromString == "") {
      return inputString;
   }
   if (toString.indexOf(fromString) == -1) { // If the string being replaced is not a part of the replacement string (normal situation)
      while (temp.indexOf(fromString) != -1) {
         var toTheLeft = temp.substring(0, temp.indexOf(fromString));
         var toTheRight = temp.substring(temp.indexOf(fromString)+fromString.length, temp.length);
         temp = toTheLeft + toString + toTheRight;
      }
   } else { // String being replaced is part of replacement string (like "+" being replaced with "++") - prevent an infinite loop
      var midStrings = new Array("~", "`", "_", "^", "#");
      var midStringLen = 1;
      var midString = "";
      // Find a string that doesn't exist in the inputString to be used
      // as an "inbetween" string
      while (midString == "") {
         for (var i=0; i < midStrings.length; i++) {
            var tempMidString = "";
            for (var j=0; j < midStringLen; j++) { tempMidString += midStrings[i]; }
            if (fromString.indexOf(tempMidString) == -1) {
               midString = tempMidString;
               i = midStrings.length + 1;
            }
         }
      } // Keep on going until we build an "inbetween" string that doesn't exist
      // Now go through and do two replaces - first, replace the "fromString" with the "inbetween" string
      while (temp.indexOf(fromString) != -1) {
         var toTheLeft = temp.substring(0, temp.indexOf(fromString));
         var toTheRight = temp.substring(temp.indexOf(fromString)+fromString.length, temp.length);
         temp = toTheLeft + midString + toTheRight;
      }
      // Next, replace the "inbetween" string with the "toString"
      while (temp.indexOf(midString) != -1) {
         var toTheLeft = temp.substring(0, temp.indexOf(midString));
         var toTheRight = temp.substring(temp.indexOf(midString)+midString.length, temp.length);
         temp = toTheLeft + toString + toTheRight;
      }
   } // Ends the check to see if the string being replaced is part of the replacement string or not
   return temp; // Send the updated string back to the user
} // Ends the "replaceSubstring" function
//verifica se il numero è un intero
function isInteger(p_strValue)
{
	p_strValue = Replace(p_strValue,",",".");
	if(isNaN(p_strValue))
	{
		return false;
	}
	if(p_strValue.indexOf('.') != -1)
	{
		return false;
	}
	if(p_strValue.indexOf('-') != -1)
	{
		return false;
	}
	return true;
}

//verifica se il numero è un intero ma può essere anche negativo
function isSignedInteger(p_strValue)
{
	p_strValue = Replace(p_strValue,",",".");
	if(isNaN(p_strValue))
	{
		return false;
	}
	if(p_strValue.indexOf('.') != -1)
	{
		return false;
	}
	return true;

}

//verifica se è un numero e restituisce il float 
function convertCurrency(p_strValue)
{	
	var l_retValue = null;
    //sostituisce i punti con stringa vuota
	//p_strValue = Replace(p_strValue,".","");
	if(!checkForValidFormat(p_strValue))
	{
		return 'NaN';
	}
	//sostituisce  l'eventuale virgola con un punto
	p_strValue = Replace(p_strValue,",",".");
	
	if(isNaN(p_strValue))
	{
		return 'NaN';
	}
	l_retValue = parseFloat(p_strValue);
	return l_retValue;
}

//controlla il numero di telefono
function isTelefono (s)

{   var i;
	s = replace(replace(replace(s,".",""),"/",""),"-","")
    if (isEmpty2(s)) 
       if (isInteger.arguments.length == 1) return defaultEmptyOK;
       else return (isInteger.arguments[1] == true);

    // Search through string's characters one by one
    // until we find a non-numeric character.
    // When we do, return false; if we don't, return true.

    for (i = 0; i < s.length; i++)
    {   
        // Check that current character is number.
        var c = s.charAt(i);

        if (!isDigit(c)) return false;
    }

    // All characters are numbers.
    return true;
}

//ammette solo acuni caratteri
function AllowOnly(Expression,strInput)
{
	Expression = Expression.toLowerCase();
	Expression = Replace(Expression, 'a..z', 'abcdefghijklmnopqrstuvwxyz');
	Expression = Replace(Expression, '0..9', '0123456789');
	Expression = Replace(Expression, '|', '');

	/*var ch = String.fromCharCode(strInput);
	var ch = ch.toLowerCase();*/
	var ch = strInput.toLowerCase();
	//alert("ch:" + ch)
	Expression = Expression.toLowerCase();
	var a = Expression.indexOf(ch);
	if (a == -1) 
		return false;
	return true;
}

//controlla che sia una e-mail
function IsEmail(Expression)
{
	if (Expression == null)
		return (false);

	var supported = 0;
	if (window.RegExp)
	{
		var tempStr = "a";
		var tempReg = new RegExp(tempStr);
		if (tempReg.test(tempStr)) supported = 1;
	}
	if (!supported) 
		return (Expression.indexOf(".") > 2) && (Expression.indexOf("@") > 0);
	var r1 = new RegExp("(@.*@)|(\\.\\.)|(@\\.)|(^\\.)");
	var r2 = new RegExp("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$");
	return (!r1.test(Expression) && r2.test(Expression));
}

//controlla le date
function validateDATE(fieldVal)
{
  // Begin
  // Checks for the following valid date formats:
  // DD/MM/YYYY  DD-MM-YYYY
  // Also separates date into month, day, and year variables
  var datePat = /^(\d{1,2})(\/)(\d{1,2})\2(\d{4})$/;
  
  /*
  ^^^^ Information about this string ^^^^
  Ignore first and last '/' it is code for RegExp
  Anything between () will be matched and remembered for later use
  
  ^ matches first input
  $ matches last input
  \ means that the next char after the '\' has a special meaning
  \2 means same thing as second operation in this case its : (\/|-)
  d means digit, it matches a number from 0 to 9
  {n,m] = matches at least N and at most M occurences. N & M are assumed to be positive
  */
  
  var matchArray = fieldVal.match(datePat); // is the format ok?
  if (matchArray == null) 
  {
    errMsg ='Date is not in a valid format.\nUse the DD/MM/YYYY format'
    isError=true
    return false;
  }
  month = matchArray[3]; // parse date into variables
  day = matchArray[1];
  year = matchArray[4];
  if (month < 1 || month > 12)  // check month range
  { 
    errMsg ='Month must be between 1 and 12.'
    isError=true
    return false;
  }
  if (day < 1 || day > 31) 
  {
    errMsg ='Day must be between 1 and 31.'
    isError=true
    return false;
  }
  if ((month==4 || month==6 || month==9 || month==11) && day==31) 
  {
    errMsg ="Month "+month+" doesn't have 31 days!"
    isError=true
    return false
  }
  if (month == 2)  // check for february 29th
  {
    var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
    if (day>29 || (day==29 && !isleap)) {
    errMsg = "February " + year + " doesn't have " + day + " days!";
    isError=true
    return false;
  }
}
return true;  // date is valid
}

//imposta il fuoco
function setFocus(p_objCurrent)
{
	if(!p_objCurrent.disabled)
		p_objCurrent.focus();
}
//assegna le proprieta agli oggetti
function setObjProp(p_objCurrent, p_strOptions)
{
	//creo un array di parametri impostati
	var strArrayOptions = p_strOptions.split("|");
	var strArrSingleValue;
	var strParameterName;
	var strParameterValue;
	//assegna valore di default
	/*p_objCurrent.label = "";
	p_objCurrent.tipocontrollo = "";
	p_objCurrent.maxnumericvalue = "";
	p_objCurrent.minnumericvalue = "";
	p_objCurrent.maxstringlength = "";
	p_objCurrent.minstringlength = "";
	p_objCurrent.caratteriammessi = "";
	p_objCurrent.obbligatorio = "";*/
	for(var i=0;i < strArrayOptions.length;i++)
	{
		strArrSingleValue = strArrayOptions[i].split("=");
		//reperisco nome e valore del parametro
		strParameterName = strArrSingleValue[0].toLowerCase();
		strParameterValue = strArrSingleValue[1].toLowerCase();
		//assegna la proprieta corrente all'oggetto
		switch (strParameterName)
		{
				case "label":
					p_objCurrent.label = strParameterValue;
					break;
				case "tipocontrollo":
					p_objCurrent.tipocontrollo = strParameterValue;
					if(strParameterValue == "data"){
						p_objCurrent.onblur = handleDataBlur;
						p_objCurrent.maxLength = 10;
					}
					break;
				case "maxnumericvalue":
					p_objCurrent.maxnumericvalue = strParameterValue;
					break;
				case "minnumericvalue":
					p_objCurrent.minnumericvalue = strParameterValue;
					break;
				case "maxstringlength":
					p_objCurrent.maxstringlength = strParameterValue;
					break;
				case "minstringlength":
					p_objCurrent.minstringlength = strParameterValue;
					break;
				case "caratteriammessi":
					p_objCurrent.caratteriammessi = strParameterValue;
					break;
				case "obbligatorio":
					p_objCurrent.obbligatorio = strParameterValue;
					break;
				case "maschera":
					p_objCurrent.maschera = strParameterValue;
					break;
				case "disabilitato":
					if (strParameterValue=="si"){
						Disable(p_objCurrent);
					}else{
						Enable(p_objCurrent);
					}
					break;
		}
	}
}

function setDefaultProp(objForm)
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
		objCurrent.label = "";
		objCurrent.tipocontrollo = "";
		objCurrent.maxnumericvalue = "";
		objCurrent.minnumericvalue = "";
		objCurrent.maxstringlength = "";
		objCurrent.minstringlength = "";
		objCurrent.caratteriammessi = "";
		objCurrent.obbligatorio = "";
		objCurrent.maschera = "";
		objCurrent.disabled = false;
	}
}

//ritorna il separatore dei decimali
function getDecimalSeparator(p_strValue)
{
	var strDecimaSep = "";
	if(p_strValue.indexOf(".")!=-1){
		strDecimaSep = ".";
	}else{
		if(p_strValue.indexOf(",")!=-1){
			strDecimaSep = ",";
			
		}else{
			//è un numero intero
			strDecimaSep = "";
		}
	}
	
	return strDecimaSep;
}

function getNumIntegerDigit(p_strValue)
{
	var intTemp = 0;
	var strDecimalSeparator = getDecimalSeparator(p_strValue);
	if(strDecimalSeparator == ""){
		//numero intero
		intTemp = p_strValue.length;
	}else{
		//numero decimale
		var strArray = p_strValue.split(strDecimalSeparator);
		intTemp = strArray[0].length;
	}
	return intTemp;
}

function getNumDecimalDigit(p_strValue)
{
	var intTemp = 0;
	var strDecimalSeparator = getDecimalSeparator(p_strValue);
	if(strDecimalSeparator == ""){
		//numero intero
		intTemp = 0;
	}else{
		//numero decimale
		var strArray = p_strValue.split(strDecimalSeparator);
		intTemp = strArray[1].length;
	}
	return intTemp;
}

//valida i campi in base alle proprietà assegnate agli oggetti
function validazioneCampi(objForm)
{
	//dichiarazione variabili
	var strObbligatorio = '';
	var strLabel = '';
	var strTipoControllo = '';
	var strMaxNumericValue = '';
	var strMinNumericValue = '';
	var strMaxStringLength = '';
	var strMinStringLength = '';
	var strCaratteriAmmessi = '';
	var strMaschera = '';
	var strDecimalSeparator = "";
	var blnControlla = false;
	var objCollectionInput = null;
	var intNumMaxIntegerDigit = 0;
	var intNumMaxDecimalDigit = 0;
	
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
					
			//reperisco le opzioni specificate per il campo
			if((objCollectionInput[i].type.toUpperCase() == "TEXT" 
			|| objCollectionInput[i].type.toUpperCase() == "SELECT-ONE" 
			|| objCollectionInput[i].type.toUpperCase() == "PASSWORD"
			|| objCollectionInput[i].type.toUpperCase() == "TEXTAREA"))
			{
				
				//pulisco le opzioni del controllo precedente
				strObbligatorio = '';
				strLabel = '';
				strTipoControllo = '';
				strMaxNumericValue = '';
				strMinNumericValue = '';
				strMaxStringLength = '';
				strMinStringLength = '';
				strCaratteriAmmessi = '';
				strMaschera = '';
				blnControlla = false;
				//catturo le opzioni per l'elemento corrente
				if(objCollectionInput[i].obbligatorio!=null && objCollectionInput[i].obbligatorio!=undefined)
				strObbligatorio = objCollectionInput[i].obbligatorio.toUpperCase();
				if(objCollectionInput[i].label != null)
				strLabel = objCollectionInput[i].label.toUpperCase();
				if (objCollectionInput[i].type.toUpperCase() != "SELECT-ONE"){
				if(objCollectionInput[i].tipocontrollo != null)
				strTipoControllo = objCollectionInput[i].tipocontrollo.toUpperCase();
				if(objCollectionInput[i].maxnumericvalue != null)
				strMaxNumericValue = objCollectionInput[i].maxnumericvalue.toUpperCase();
				if(objCollectionInput[i].minnumericvalue != null)
				strMinNumericValue = objCollectionInput[i].minnumericvalue.toUpperCase();
				if(objCollectionInput[i].maxstringlength != null)
				strMaxStringLength = objCollectionInput[i].maxstringlength.toUpperCase();
				if(objCollectionInput[i].minstringlength != null)
				strMinStringLength = objCollectionInput[i].minstringlength.toUpperCase();
				if(objCollectionInput[i].caratteriammessi != null)
				strCaratteriAmmessi = objCollectionInput[i].caratteriammessi.toUpperCase();
				if(objCollectionInput[i].maschera_2 != null)
				strMaschera = objCollectionInput[i].maschera_2.toUpperCase();
				}
			}
		
		//verifico che il tipo degli elementi e text e che non siano disabilitati
		if((objCollectionInput[i].type.toUpperCase() == "TEXT" 
		|| objCollectionInput[i].type.toUpperCase() == "PASSWORD"
		|| objCollectionInput[i].type.toUpperCase() == "TEXTAREA"))// && objCollectionInput[i].disabled == false)
		{
				//inizio dei controlli
				//verifica se l'inserimento del campo corrente è obbligatorio
				
				if(strObbligatorio == "SI" && objCollectionInput[i].disabled == false && objCollectionInput[i].style.visibility != 'hidden')
				{
					if(objCollectionInput[i].value == "")
					{
						alert("Il campo '" + strLabel + "' e' obbligatorio!");
						// do il fuoco all'oggetto corrente
						setFocus(objCollectionInput[i]);
						return false;
					}
					else
					{
						// è stato inserito bisogna controllarlo
						if(strTipoControllo != "")
						{
							blnControlla = true;
						}
					} 
				}
				else
				{
					//non è obbligatorio ma è stato inserito >>> bisogna controllarlo
					if(objCollectionInput[i].value != "")
					{
						if(strTipoControllo != "")
						{
							blnControlla = true;
						}
					}
				}
				
				
				// se il flag è stato impostato a true iniziano i controlli
				if(blnControlla)
				{
					//controlla la lunghezza massima della stringa
				
						if(strMaxStringLength != "")
						{
							if(convertCurrency(strMaxStringLength)== "NaN")
							{  
								alert("Il valore di 'MaxStringLength' specificato per il controllo '" + objCollectionInput[i].name +  "' non è valido!");
								return false;
							}
							else
							{
								if(objCollectionInput[i].value.length > eval(strMaxStringLength))
								{
									alert("Il numero massimo di caratteri consentito nel campo '" + strLabel + "' e' " + strMaxStringLength )
									setFocus(objCollectionInput[i]);
									return false;
								}
							}
						}
						//controlla la lunghezza minima della stringa
						if(strMinStringLength != "")
						{
							if(convertCurrency(strMinStringLength)== "NaN")
							{  
								alert("Il valore di 'MinStringLength' specificato per il controllo '" + objCollectionInput[i].name +  "' non è valido!");
								return false;
							}
							else
							{
								if(objCollectionInput[i].value.length < eval(strMinStringLength))
								{
									alert("Il numero minimo di caratteri consentito nel campo '" + strLabel + "' e' " + strMinStringLength )
									setFocus(objCollectionInput[i]);
									return false;
								}
							}
						}
						
						//controlla il valore massimo numerico consentito (se specificato)
			
						if(strMaxNumericValue != '')
						{
							if(convertCurrency(strMaxNumericValue)== "NaN")
							{  
								alert("Il valore di 'MaxNumericValue' specificato per il controllo '" + objCollectionInput[i].name +  "' non e' valido!");
								return false;
							}
							else
							{
								//controlla che il valore inserito non sia superiore a quello massimo specificato
								if(convertCurrency(objCollectionInput[i].value) > convertCurrency(strMaxNumericValue))
								{
									alert("Il valore del campo '" + strLabel + "' non puo' essere superiore di " + strMaxNumericValue )
									setFocus(objCollectionInput[i]);
									return false;
								}
								
							}
						}
						//controlla il valore minimo numerico consentito (se specificato)
						if(strMinNumericValue != '')
						{
							if(convertCurrency(strMinNumericValue)== "NaN")
							{  
								alert("Il valore di 'MinNumericValue' specificato per il controllo '" + objCollectionInput[i].name +  "' non e' valido!");
								return false;
							}
							else
							{
							
								//controlla che il valore inserito non sia inferiore a quello minimo specificato
								if(convertCurrency(objCollectionInput[i].value) < convertCurrency(strMinNumericValue))
								{
									alert("Il valore del campo '" + strLabel + "' non puo' essere inferiore di " + strMinNumericValue )
									setFocus(objCollectionInput[i]);
									return false;
								}
								
							}
						}
						//controlla il massimo numero di cifre intere e decimali ammesse
						if(strMaschera != ''){
							intNumMaxIntegerDigit = getNumIntegerDigit(strMaschera);
							intNumMaxDecimalDigit = getNumDecimalDigit(strMaschera);
							if(getNumIntegerDigit(objCollectionInput[i].value) > intNumMaxIntegerDigit){
								alert("Il numero di cifre intere inserito nel campo '" + strLabel + "' e' superiore a " + intNumMaxIntegerDigit )
								setFocus(objCollectionInput[i]);
								return false;
							}
							
							if(getNumDecimalDigit(objCollectionInput[i].value) > intNumMaxDecimalDigit){
								alert("Il numero di cifre decimali inserito nel campo '" + strLabel + "' e' superiore a " + intNumMaxDecimalDigit )
								setFocus(objCollectionInput[i]);
								return false;
							}	
						}
						
					
					switch (strTipoControllo)
						{
							case "DATA":
								if(!validateDATE(objCollectionInput[i].value))
								{
									alert("Il campo '" + strLabel  + "' contiene un valore (" + strTipoControllo + ") non valido!");
									setFocus(objCollectionInput[i]);
									return false;
								}
								break;
							case "IMPORTO":
								//formattazione del numero secondo le regional options
								//impostate sulla macchina client!
								if(convertCurrency(objCollectionInput[i].value) == "NaN" || findMeno(objCollectionInput[i].value))
								{
									alert("Il campo '" + strLabel  + "' contiene un valore (" + strTipoControllo + ") non valido!");
									setFocus(objCollectionInput[i]);
									return false;
								}else{
									
								}
								//objCollectionInput[i].value = formatNumero(objCollectionInput[i].value);
								break;
							case "IMPORTOLIBERO":
								//formattazione del numero secondo le regional options
								//impostate sulla macchina client!
								
								if(convertCurrency(objCollectionInput[i].value) == "NaN")
								{
									alert("Il campo '" + strLabel  + "' contiene un valore (" + strTipoControllo + ") non valido!");
									setFocus(objCollectionInput[i]);
									return false;
								}
								objCollectionInput[i].value = objCollectionInput[i].value;
								break;
							case "INTERO":
								 
								if(!isInteger(objCollectionInput[i].value))
								{
									alert("Il campo '" + strLabel  + "' contiene un valore (" + strTipoControllo + ") non valido!");
									setFocus(objCollectionInput[i]);
									return false;
								}
								break;	
							case "TELEFONO"://come INTERO solo che sono ammessi  . / -
								 
								if(!isTelefono(objCollectionInput[i].value))
								{
									alert("Il campo '" + strLabel  + "' contiene un valore (" + strTipoControllo + ") non valido!");
									setFocus(objCollectionInput[i]);
									return false;
								}
								break;	
								
							case "INTERONEGATIVO":
								if(!isSignedInteger(objCollectionInput[i].value))
								{
									alert("Il campo '" + strLabel  + "' contiene un valore (" + strTipoControllo + ") non valido!");
									setFocus(objCollectionInput[i]);
									return false;
								}
								break;
							case "EMAIL":
								if(!IsEmail(objCollectionInput[i].value))
								{
									alert("Il campo '" + strLabel  + "' contiene un (" + strTipoControllo + ") non valido!");
									setFocus(objCollectionInput[i]);
									return false;
								}
								break;	
							case "CARATTERIAMMESSI":
								if(!AllowOnly(strCaratteriAmmessi,objCollectionInput[i].value))
								{  
									alert("Il campo '" + strLabel  + "' contiene un (" + strTipoControllo + ") non valido!\n Caratteri ammessi: " + strCaratteriAmmessi);									
									setFocus(objCollectionInput[i]);
									return false;
								}
								break;	
							 default :
					      		alert("La funzione 'validazioneCampi' ha ricevuto il tipoControllo'" + strTipoControllo + "' che non e' stato gestito!");
								return false;
								break;
						}
						
				}
		}
		
		//controllo di validita per le combo box
		//alert(objCollectionInput[i].style.visibility);
		if(objCollectionInput[i].type.toUpperCase() == "SELECT-ONE" && objCollectionInput[i].style.visibility != 'hidden')// && objCollectionInput[i].disabled == false)
		{
			//inizio dei controlli
			//verifica se l'inserimento del campo corrente è obbligatorio
			if(strObbligatorio == "SI")
			{
				if(objCollectionInput[i].selectedIndex == 0)
				{
					alert("E' necessario selezionare una opzione dal Combo Box:'" + strLabel + "'!");
					setFocus(objCollectionInput[i]);
					return false;
				}
			}
		}
	//chiude il ciclo for	
	}
	//sono stati passati tutti i controlli
	return true;
}
function checkContinua()
{
	var blnContinua = window.confirm("Continuare con l'operazione Richiesta?");
	return blnContinua;
}

function checkForValidFormat(p_strValue)
{
	var intStrLength = p_strValue.length;
	var intCount = 0;
	for (j=0;j<intStrLength;j++)
	{
		if(p_strValue.substring(j,j+1) == "." || p_strValue.substring(j,j+1) == "," )
		{
			intCount = intCount + 1;
		}
	}
	if(intCount > 1 || p_strValue.substring(intStrLength-1,intStrLength) == "," || p_strValue.substring(intStrLength-1,intStrLength) == ".")
	{
		return false;
	}
	else
	{
		return true;
	}
}

//trasforma una data in un intero
function dateToInt(p_strDate)
{
	if(validateDATE(p_strDate)){
		var strSplitValue = p_strDate.split("/");
		if(strSplitValue[0].length==1){
			strSplitValue[0]="0"+strSplitValue[0];
		}
		if(strSplitValue[1].length==1){
			strSplitValue[1]="0"+strSplitValue[1];
		}
		return parseInt(strSplitValue[2]+strSplitValue[1]+strSplitValue[0]);
	}else{
		alert("Data Errata!\n - function dateToInt() - \n"+p_strDate);
		return;
	}
}
function handleDataBlur()
{
	if(this.value != "")
	{
		if(!validateDATE(this.value))
		{
			//this.blur();
			//alert("Data non valida!!");
			//this.blur();
			//top.frame[0].focus();
			//setFocus(this);
		}
	}
}

function findMeno(p_strValue)
{
	if(p_strValue.indexOf("-") != -1)
	{
		return true;
	}else{
		return false;
	}
	
}

/*confronto tra date nel fomato dd/mm/yyyy*/
function chkDataInizioFine(strDataInizio, strDataFine){
  var dataInizio = new Date(strDataInizio.substring(6,10),strDataInizio.substring(3,5)-1,strDataInizio.substring(0,2));
  var dataFine   = new Date(strDataFine.substring(6,10),strDataFine.substring(3,5)-1,strDataFine.substring(0,2));
	if(dataFine<dataInizio)
    return false;
  return true;
}

