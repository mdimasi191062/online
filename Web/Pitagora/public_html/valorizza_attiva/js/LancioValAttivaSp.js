function handleblur(ogg)
{
}

function cancelLink ()
{
  return false;
}

function cancelCalendar (obj)
{
  obj.value="";
}

function showMessage (field)
{
  if (field=='seleziona1')
		self.status=msg1;
 	else
 		self.status=msg2;
}

function dis_calendario()
{
     attivaCalendario=false;
     DisableLink(document.links[0],document.lancioVAForm.calendario);
     DisableLink(document.links[1],document.lancioVAForm.cancella_data);
     msg1=message1;
     msg2=message2;
}

function abi_calendario()
{
     attivaCalendario=true;
     EnableLink(document.links[0],document.lancioVAForm.calendario);
     EnableLink(document.links[1],document.lancioVAForm.cancella_data);
     msg1=message1;
     msg2=message2;
}

function f_calendarioSched(obj)
{
  if(obj.checked){
    attivaCalendarioSched=true;
    document.lancioVAForm.dataSched.value="";
    EnableLink(document.links[2],document.lancioVAForm.calendarioSched);
    EnableLink(document.links[3],document.lancioVAForm.cancella_dataSched);
    msg1=message1;
    msg2=message2;
    document.lancioVAForm.LANCIOBATCH.value = "Schedula Batch";
  }else{
    attivaCalendarioSched=false;
    document.lancioVAForm.dataSched.value="";
    DisableLink(document.links[2],document.lancioVAForm.calendarioSched);
    DisableLink(document.links[3],document.lancioVAForm.cancella_dataSched);
    msg1=message1;
    msg2=message2;
    document.lancioVAForm.LANCIOBATCH.value = "Lancio Batch";    
  }
}

function convertiData(data)
{
    var appo_data = data.substring(6,10) + data.substring(3,5) + data.substring(0,2);
    return appo_data;
}

function ONINSERISCI_SEL()
{
    document.lancioVAForm.comboRiepilogoAccount.focus();
    if (document.lancioVAForm.comboAccount.selectedIndex>-1)
    {
          testo=document.lancioVAForm.comboAccount.options[document.lancioVAForm.comboAccount.selectedIndex].text;
          valore=document.lancioVAForm.comboAccount.options[document.lancioVAForm.comboAccount.selectedIndex].value;
          seloption=new Option(testo, valore);
          document.lancioVAForm.comboRiepilogoAccount.options[document.lancioVAForm.comboRiepilogoAccount.length] = seloption;
          document.lancioVAForm.comboAccount.options[document.lancioVAForm.comboAccount.selectedIndex] = null;	
          DisabilitaBotton();
          if (document.lancioVAForm.comboRiepilogoAccount.length==0)
             document.lancioVAForm.comboAccount[0].selected ="true";
     }
    else
      window.alert("Attenzione! Selezionare prima un account da Dati Cliente.");
}

function ONINSERISCI_TUTTI()
{
    document.lancioVAForm.comboRiepilogoAccount.focus();
    for (i=0;document.lancioVAForm.comboAccount.length>i;i++) 
    {
      testo=document.lancioVAForm.comboAccount.options[i].text;
  	  valore=document.lancioVAForm.comboAccount.options[i].value;
      seloption=new Option(testo, valore);
  	  document.lancioVAForm.comboRiepilogoAccount.options[document.lancioVAForm.comboRiepilogoAccount.length] = seloption;
    }
    for (i=document.lancioVAForm.comboAccount.length;i>=0;i--) 
        document.lancioVAForm.comboAccount.options[i] = null;	
    DisabilitaBotton();
}


function DisabilitaBotton()
{
  if(document.lancioVAForm.comboRiepilogoAccount.length!=0)
    {
    Enable(document.lancioVAForm.LANCIOBATCH);
    Enable(document.lancioVAForm.ELIMINA);
    Enable(document.lancioVAForm.soloPopolamento);
    Enable(document.lancioVAForm.generaReport);
    Enable(document.lancioVAForm.paralPopolamento);
    if(document.lancioVAForm.codeFunzBatch.value=="21")
    {
         Enable(document.lancioVAForm.soloScarti);
    }
    Enable(document.lancioVAForm.schedulazione);
        
    if (!attivaCalendario) abi_calendario();
    if(document.lancioVAForm.comboRiepilogoAccount.length==0){
      if (attivaCalendarioSched) f_calendarioSched(document.lancioVAForm.schedulazione);
    }
    }
  else
  {
    Disable(document.lancioVAForm.LANCIOBATCH);
    Disable(document.lancioVAForm.ELIMINA);
    Disable(document.lancioVAForm.soloPopolamento);
    Disable(document.lancioVAForm.soloScarti);
    Disable(document.lancioVAForm.generaReport);
    Disable(document.lancioVAForm.paralPopolamento);
    Disable(document.lancioVAForm.schedulazione);
    document.lancioVAForm.soloPopolamento.checked=false;
    document.lancioVAForm.paralPopolamento.checked=false;
    document.lancioVAForm.soloScarti.checked=false;
    document.lancioVAForm.soloPopolamento.value="N";
    document.lancioVAForm.soloScarti.value="0";
    document.lancioVAForm.generaReport.value="0";
    document.lancioVAForm.dataFineA.value="";
    document.lancioVAForm.schedulazione.checked=false;
    document.lancioVAForm.schedulazione.value="N";
    document.lancioVAForm.dataSched.value="";
    if (attivaCalendario) dis_calendario();
    if (attivaCalendarioSched) f_calendarioSched(document.lancioVAForm.schedulazione);
  }
  if(document.lancioVAForm.comboAccount.length==0) 
  {
    Disable(document.lancioVAForm.INSERISCI_SEL);
    Disable(document.lancioVAForm.INSERISCI_TUTTI);
  }
  else
  {
    Enable(document.lancioVAForm.INSERISCI_SEL);
    Enable(document.lancioVAForm.INSERISCI_TUTTI);
  }
}

function ONELIMINA()
{
    document.lancioVAForm.comboAccount.focus();
    if (document.lancioVAForm.comboRiepilogoAccount.selectedIndex>-1)
    {
        testo=document.lancioVAForm.comboRiepilogoAccount.options[document.lancioVAForm.comboRiepilogoAccount.selectedIndex].text;
        valore=document.lancioVAForm.comboRiepilogoAccount.options[document.lancioVAForm.comboRiepilogoAccount.selectedIndex].value;
        seloption=new Option(testo,valore);
        document.lancioVAForm.comboAccount.options[document.lancioVAForm.comboAccount.length] = seloption;
        document.lancioVAForm.comboRiepilogoAccount.options[document.lancioVAForm.comboRiepilogoAccount.selectedIndex] = null;
        DisabilitaBotton();
        document.lancioVAForm.comboAccount[document.lancioVAForm.comboAccount.length-1].selected=true;
    }
    else
      window.alert("Attenzione! Selezionare prima un account dal riepilogo.");
}

function clear()
{
     document.lancioVAForm.ciclo.value="";
     document.lancioVAForm.dataFineA.value="";
     document.lancioVAForm.dataSched.value="";
     document.lancioVAForm.comboAccount.length=0;
     document.lancioVAForm.comboRiepilogoAccount.length=0;
     Disable(document.lancioVAForm.ciclo);
     if (document.lancioVAForm.comboCicloF.length==1)
          Disable(document.lancioVAForm.comboCicloF);
     if (document.lancioVAForm.ciclo.value=="")
          Disable(document.lancioVAForm.CAMBIA_CICLO);
     DisabilitaBotton();
     if (attivaCalendario)
         dis_calendario();
}

function carPeriodi()
{
 var selezione=document.lancioVAForm.comboCicloF[document.lancioVAForm.comboCicloF.selectedIndex].value;
 clear();
 if (selezione!=-1)
 {
   var strURL="LancioValAttivaWfSp.jsp";
       strURL+="?act=caricaTutto";
       strURL+="&resize=false";
       strURL+="&comboCicloFattSelez="+document.lancioVAForm.comboCicloF[document.lancioVAForm.comboCicloF.selectedIndex].value;
       strURL+="&cod_tipo_contr="+document.lancioVAForm.cod_tipo_contr.value;
       openDialog(strURL, 400, 5,handle_change_ciclo);
 }  
}
