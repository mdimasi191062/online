var objForm;

var app_cod_Ps;
var class_fatt_index=1;
var attivaCalendario=true;

var msg1="Click per selezionare la data";
var msg2="Click per selezionare la data";
var msg3="Click per cancellare la data selezionata";
var msg4="Click per cancellare la data selezionata";

function on_load()
{
//window.alert(">>> on_load");

  objForm=document.InsAssOfPsSp;



  DisableAllControls(objForm);
  Enable(objForm.btnPS);

if (attivaCalendario)
    {
      dis_calendario_INI();
      dis_calendario_FINE();
    }

  Enable(objForm.CONFERMA);
  Enable(objForm.ANNULLA);
ripristinaPs();

}





function showMessage (field)
{
	if (field=='seleziona1')
		self.status=msg1;
	else
    if (field=='seleziona2')
  		self.status=msg2;
	else
    if (field=='seleziona3')
  		self.status=msg3;
  	else
  		self.status=msg4;
}

function cancelCalendarIni()
{
  document.InsAssOfPsSp.data_ini.value="";
}

function cancelCalendarFine()
{
  document.InsAssOfPsSp.data_fine.value="";
}



function imposta_altro()
{
//window.alert(">>> imposta_altro");
objForm.freqCombo.selectedIndex=0;
Enable(objForm.freqCombo);
Disable(objForm.modApplProrCombo);
objForm.modApplProrCombo.selectedIndex=0;
Disable(objForm.modApplCombo);
objForm.modApplCombo.selectedIndex=0;
objForm.shift.value="";
Disable(objForm.shift);

}

function imposta_modalita_appl(trovato,codeFreq,codeModal,flgAP,shift)
{
if (trovato=="false")
  {
  Enable(objForm.freqCombo);
  objForm.freqCombo.selectedIndex=0;
  Enable(objForm.modApplProrCombo);
  objForm.modApplProrCombo.selectedIndex=0;
  Enable(objForm.modApplCombo);
  objForm.modApplCombo.selectedIndex=0;
  //Enable(objForm.shift);
  }
else
  {
  //window.alert(">>> Associazione trovata");
  objForm.freqCombo.selectedIndex=0;
  objForm.modApplProrCombo.selectedIndex=0;
  objForm.modApplCombo.selectedIndex=0;
  

  // Selezione occorrenza combo frequenza
  var len=objForm.freqCombo.length;
  if (codeFreq!="null")
    for(k=0;k<len;k++)
      {
      if (objForm.freqCombo.options[k].value==codeFreq)
         { 
         objForm.freqCombo.selectedIndex=k;
         break;
         }
      }
  Disable(objForm.freqCombo);

  // Selezione occorrenza combo modalità applicazione Prorata
  len=objForm.modApplProrCombo.length;
  if (codeModal!="null")
    for(k=0;k<len;k++)
      {
      if (objForm.modApplProrCombo.options[k].value==codeModal)
         { 
         objForm.modApplProrCombo.selectedIndex=k;
         break;
         }
      }
  Disable(objForm.modApplProrCombo);
     
  // Selezione occorrenza combo modalità applicazione
  len=objForm.modApplCombo.length;
  if (flgAP!="null")
    for(k=0;k<len;k++)
      {
      if (objForm.modApplCombo.options[k].value==flgAP)
         { 
         objForm.modApplCombo.selectedIndex=k;
         break;
         }
      }
  Disable(objForm.modApplCombo);
 
  if (shift!="null")
     objForm.shift.value=shift; 
  Disable(objForm.shift);
  
  }

}


function clear_all_contratto()
{
//alert("clear_all_contratto");
    objForm.des_PS.value="";
    objForm.cod_PS.value="";
//    Disable(objForm.btnPS);
    Enable(objForm.btnPS);
    objForm.oggFattCombo.selectedIndex=0;
    objForm.descFattCombo.selectedIndex=0;
    Disable(objForm.oggFattCombo);
    Disable(objForm.descFattCombo);
    objForm.descFattCombo.selectedIndex=0;
    Disable(objForm.descFattCombo);
    clear_partial();
}

function clear_contratto_change()
{
    objForm.des_PS.value="";
    objForm.cod_PS.value="";
    Enable(objForm.btnPS);
    objForm.oggFattCombo.selectedIndex=0;
    objForm.descFattCombo.selectedIndex=0;
    Disable(objForm.oggFattCombo);
    Disable(objForm.descFattCombo);

    objForm.descFattCombo.selectedIndex=0;
    Disable(objForm.descFattCombo);

    objForm.freqCombo.selectedIndex=0;
    Disable(objForm.freqCombo);

    objForm.modApplProrCombo.selectedIndex=0;
    Disable(objForm.modApplProrCombo);

    objForm.modApplCombo.selectedIndex=0;
    Disable(objForm.modApplCombo);

    objForm.shift.value=""
    Disable(objForm.shift);

    objForm.data_ini.value=""
    objForm.data_fine.value=""

    if (attivaCalendario)
    {
      dis_calendario_INI();
      dis_calendario_FINE();
    }
}


function dis_calendario_INI()
{
     attivaCalendario=false;
     DisableLink(document.links[0],objForm.calendar_ini);
     DisableLink(document.links[1],objForm.cancel_ini);
     msg1=message1;
     msg2=message2;
}

function abi_calendario_INI()
{
      attivaCalendario=true;
      EnableLink(document.links[0],objForm.calendar_ini);
      EnableLink(document.links[1],objForm.cancel_ini);
      msg1=message1;
      msg2=message2;
}

function dis_calendario_FINE()
{
     attivaCalendario=false;
     DisableLink(document.links[2],objForm.calendar_fine);
     DisableLink(document.links[3],objForm.cancel_fine);
     msg3=message1;
     msg4=message2;
}

function abi_calendario_FINE()
{
      attivaCalendario=true;
      EnableLink(document.links[2],objForm.calendar_fine);
      EnableLink(document.links[3],objForm.cancel_fine);
      msg3=message1;
      msg4=message2;
}


function handle_change_classe()
{
 objForm.descFattCombo.selectedIndex=0;
 //Enable(objForm.descFattCombo);
}

function handle_change_descr()
{
//window.alert(">>> handle_change_descr");
 
}


function handleReturnedValuePS()
{
 //window.alert(">>> handleReturnedValuePS");
 if (objForm.cod_PS.value==app_cod_Ps)
  {
  //window.alert(">>> Ps non modificato");
  }
 else
  {
   //window.alert(">>> Ps modificato e/o selezionato");
   objForm.oggFattCombo.selectedIndex=0;
   objForm.descFattCombo.selectedIndex=0;
   cod_PS_appoggio=objForm.cod_PS.value;
   des_PS_appoggio=objForm.des_PS.value;
   ONANNULLA();
   objForm.cod_PS.value=cod_PS_appoggio;
   objForm.des_PS.value=des_PS_appoggio;
   //if (numeroTariffe>0)
       Enable(objForm.oggFattCombo);
  }
}


function add_combo_elem(Field,Value, Text)
{
//window.alert(">>> add_cmb_classe_fatt");
var NS4 = (document.layers) ? true : false;
var IE4 = (document.all) ? true : false

if (NS4)
		{
			var newOpt  = new Option(Text,Value);
			var selLength = eval('objForm.'+Field+'.length');
			eval('objForm.'+Field+'.options[selLength]= newOpt') ;
		}
		else if (IE4)
		{
			var newOpt = document.createElement("OPTION");
			newOpt.text=Text;
			newOpt.value=Value;
			eval('objForm.'+Field+'.add(newOpt)');
		}
}


function clear_all_combo(Field)
	{
		var NS4 = (document.layers) ? true : false;
		var IE4 = (document.all) ? true : false;
		
		var len = eval('objForm.'+Field+'.length');
		var NS4 = (document.layers) ? true : false;
		var IE4 = (document.all) ? true : false;
			
		for (i=0;i<len;i++)
		{
			if (NS4)
				eval('objForm.'+Field+'.options[0]=null');
			else if (IE4)
				eval('objForm.'+Field+'.remove(0)');
		}
	}

function set_message(str)
{
 //window.alert(">>> set_message");
 objForm.msg.value=str;
}

