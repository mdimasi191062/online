var IExplorer =document.all?true:false;
var Navigator =document.layers?true:false;
var objForm='document.oggFattForm';
var numeroTariffe=0;
var azzeraOggFatt=true;
classeOf=new Array();
var act;
var codOggFattSel="";
var carCausaleBoolean=false;
var UnitaMisuraDisp=false;
var appoggio;
var attivaCalendario;
var msg1="Click per selezionare la data";
var msg2="Click per cancellare la data selezionata";
var indiceContr=0;
var flagExc="error";

function nascondi(mioLiv)
{
  if (mioLiv=="causale")
  {
     if (IExplorer) 
        document.all["causale"].style.visibility="hidden"; 
  }
  else if (mioLiv=="comboCausale")
  {
    if (IExplorer)
    {
       document.all["comboCausale"].style.visibility="hidden"; 
       Disable(document.oggFattForm.comboCausale);
       Disable(document.oggFattForm.causaleSelez);

    }
    else if (Navigator)
    {
       document.oggFattForm.comboCausale[0].selected=true;
    }
       document.oggFattForm.causaleSelez.value=-1;  
  }
}

function visualizza(mioLiv)
{
 if (mioLiv=="causale")
    document.all["causale"].style.visibility="visible"; 
else if (mioLiv="comboCausale")
  {
    if (IExplorer)
    {
       document.all["comboCausale"].style.visibility="visible"; 
       Enable(document.oggFattForm.comboCausale);
    }
  }
}


function  carContratto()
{
    document.oggFattForm.des_contr.value=document.oggFattForm.des[document.oggFattForm.contratti.selectedIndex].value;
    if (document.oggFattForm.contratti.selectedIndex==0)
    {
        selezione=-1;
    }
    else
    {
          selezione=document.oggFattForm.contratti[document.oggFattForm.contratti.selectedIndex].value;
    }
    
    if (selezione!=-1)
    {
      document.oggFattForm.contrSelez.value=selezione;
      indiceSel=document.oggFattForm.contratti.selectedIndex;
      ONANNULLA();
      Enable(document.oggFattForm.btnPS);
      document.oggFattForm.contratti[indiceSel].selected=true;
    }
    else
    {  
      Disable(document.oggFattForm.btnPS);
      ONANNULLA();
    }
}


function ONANNULLA()
{
    document.oggFattForm.act.value="null";
    document.oggFattForm.oggFattSelez.value=null;
    document.oggFattForm.clasOggFattSelez.value=null;
    document.oggFattForm.causaleSelez.value=null;
    document.oggFattForm.uniMisSelez.value=null;
    document.oggFattForm.cod_PS.value="";
    document.oggFattForm.des_PS.value="";
    document.oggFattForm.comboOggFatt[0].selected=true;
    document.oggFattForm.tipoImpSelez.value=document.oggFattForm.Tipo_Importo[0].value;
   
    document.oggFattForm.desc_tariffa.value="";
    document.oggFattForm.Tipo_Importo[0].checked=true;
    document.oggFattForm.Tipo_Importo[1].checked=false;  
    Disable(document.oggFattForm.comboOggFatt);
    document.oggFattForm.data_ini.value="";             
    Disable(document.oggFattForm.Tipo_Importo[0]);
    Disable(document.oggFattForm.Tipo_Importo[1]);
    Disable(document.oggFattForm.comboUnitaMisura);
    document.oggFattForm.comboUnitaMisura[0].selected=true;
    //viti 27-02-03
    document.oggFattForm.tipoOpzSelez.value="null";
    Disable(document.oggFattForm.comboOpzioniTariffa);
    document.oggFattForm.comboOpzioniTariffa[0].selected=true;
    document.oggFattForm.caricaOpz.value="false";
   
    Disable(document.oggFattForm.desc_tariffa);             
    Disable(document.oggFattForm.importo_tariffa);         
    document.oggFattForm.importo_tariffa.value="";
    nascondi("comboCausale");
    Disable(document.oggFattForm.comboCausale);
    if (IExplorer) nascondi("causale");
    if (attivaCalendario) 
      dis_calendario();
    document.oggFattForm.comboCausale[0].selected=true;
    indiceContr=document.oggFattForm.contratti.selectedIndex; //al ritorno dal PS recupero il Contratto
    document.oggFattForm.contratti[0].selected=true;
    Disable(document.oggFattForm.btnPS);    
}


function abilitaCampiResidui()
{
catturaSelezione();
document.oggFattForm.causaleSelez.value=document.oggFattForm.comboCausale[document.oggFattForm.comboCausale.selectedIndex].value;
 if (document.oggFattForm.comboCausale[document.oggFattForm.comboCausale.selectedIndex].value == -1)
 {
   document.oggFattForm.desc_tariffa.value="";
   document.oggFattForm.data_ini.value="";
     if (attivaCalendario)
        dis_calendario();
     Disable(document.oggFattForm.desc_tariffa);              
     document.oggFattForm.importo_tariffa.value="";
     Disable(document.oggFattForm.importo_tariffa);         
     Disable(document.oggFattForm.Tipo_Importo[0]);
     Disable(document.oggFattForm.Tipo_Importo[1]);
     Disable(document.oggFattForm.comboUnitaMisura);              
     document.oggFattForm.comboUnitaMisura[0].selected=true;
//viti 27-02-03
     Disable(document.oggFattForm.comboOpzioniTariffa);
     document.oggFattForm.comboOpzioniTariffa[0].selected=true;
 }
 else
 {
    if (!attivaCalendario)
      abi_calendario();
    Enable(document.oggFattForm.desc_tariffa);             
    Enable(document.oggFattForm.importo_tariffa);             
    Enable(document.oggFattForm.comboOggFatt);             
    Enable(document.oggFattForm.comboCausale);    
    //viti 27-02-03
   Disable(document.oggFattForm.comboOpzioniTariffa);
   document.oggFattForm.comboOpzioniTariffa[0].selected=true;    

    if (selezione!=2)
             {
               document.oggFattForm.Tipo_Importo[0].checked=true;
               document.oggFattForm.tipoImpSelez.value=document.oggFattForm.Tipo_Importo[0].value;
               Disable(document.oggFattForm.Tipo_Importo[0]);
               Disable(document.oggFattForm.Tipo_Importo[1]);
                        
             }
    else
            {
                Enable(document.oggFattForm.Tipo_Importo[0]);
                Enable(document.oggFattForm.Tipo_Importo[1]);
             }
 }
}
//viti 27-02-03
function change_opzTariffa()
{
  document.oggFattForm.tipoOpzSelez.value=document.oggFattForm.comboOpzioniTariffa[document.oggFattForm.comboOpzioniTariffa.selectedIndex].value;
  if (document.oggFattForm.tipoOpzSelez.value==-1)
      document.oggFattForm.tipoOpzSelez.value=null;
}

function catturaItemUnitaMisura()
{
  document.oggFattForm.uniMisSelez.value=document.oggFattForm.comboUnitaMisura[document.oggFattForm.comboUnitaMisura.selectedIndex].value;
  if (document.oggFattForm.uniMisSelez.value==-1)
      document.oggFattForm.uniMisSelez.value=null;
}

function disattivaComboUnitaMisura()
{
  document.oggFattForm.comboUnitaMisura[0].selected=true;
  document.oggFattForm.tipoImpSelez.value=document.oggFattForm.Tipo_Importo[0].value;
  document.oggFattForm.uniMisSelez.value=null; 

  Disable(document.oggFattForm.comboUnitaMisura);           
}

function StampaDati()
{
alert(
           "CODE_TARIFFA,"+          
           "\rCODE_PR_TARIFFA,"+
           "\r***CODE_FASCIA :null"+
           "\r***CODE_PR_FASCIA: null"+
           "\rCODE_UNITA_MISURA :"+document.oggFattForm.uniMisSelez.value+
           "\rCODE_UTENTE :" +document.oggFattForm.codUt.value+
           "\rDATA_INIZIO_VALID_OF_PS, "+ 
           "\rCODE_OGG_FATRZ :"+document.oggFattForm.oggFattSelez.value+  
           "\rDATA_INIZIO_VALID_OF :"+   
           "\rCODE_PS :"+document.oggFattForm.cod_PS.value+
           "\rDATA_INIZIO_TARIFFA :"+ document.oggFattForm.data_ini.value+   
           "\r***DATA_FINE_TARIFFA : null"+
           "\rDESC_TARIFFA :"+document.oggFattForm.desc_tariffa.value+
           "\r***TIPO_FLAG_CONG_REPR : N"+
           "\r***DATA_CREAZ_TARIFFA : DATA DI SISTEMA"+  
           "\rIMPT_TARIFFA  :" +document.oggFattForm.importo_tariffa.value+
           "\rTIPO_FLAG_MODAL_APPL_TARIFFA :"+document.oggFattForm.tipoImpSelez.value+
           "\r***TIPO_FLAG_PROVVISORIA : N"+
           "\r***DATA_CREAZ_MODIF :DATA DI SISTEMA" +  
           "\r***CODE_TIPO_CAUS : 1"+
           "\rCODE_CLAS_SCONTO,  "+
           "\rCODE_PR_CLAS_SCONTO, "+
           "\r***CODE_TIPO_OFF :01"+   
           "\rCODE_TIPO_CAUS_FAT :"+document.oggFattForm.causaleSelez.value);
           //"\rCODE_TIPO_OPZIONE :"+document.oggFattForm.tipoOpzSelez.value);
           //viti 27-02-03
}


function catturaSelezione()
{
if (document.oggFattForm.comboOggFatt.selectedIndex==0)
     selezione=-1;
else
     selezione=classeOf[document.oggFattForm.comboOggFatt.selectedIndex-1];
}

function handleblur(ogg)
{
}


function cancelLink ()
{
  return false;
}

function cancelCalendar ()
{
  document.oggFattForm.data_ini.value="";
}

function showMessage (field)
{
    if (field=='seleziona1')
		self.status=msg1;
 	else
 		self.status=msg2;
}

function disableLink (link)
{
  if (link.onclick)
    link.oldOnClick = link.onclick;
  link.onclick = cancelLink;
  if (link.style)
    link.style.cursor = 'default';
}

function enableLink (link)
{
  link.onclick = link.oldOnClick ? link.oldOnClick : null;
  if (link.style)
    link.style.cursor = document.all ? 'hand' : 'pointer';
}

function dis_calendario()
{
     attivaCalendario=false;
     DisableLink(document.links[0],document.oggFattForm.calendario);
     DisableLink(document.links[1],document.oggFattForm.cancella_data);
     msg1=message1;
     msg2=message2;
}

function abi_calendario()
{
      attivaCalendario=true;
      EnableLink(document.links[0],document.oggFattForm.calendario);
      EnableLink(document.links[1],document.oggFattForm.cancella_data);
      msg1=message1;
      msg2=message2;
}

function handle_change_radioImporto()
{
  Enable(document.oggFattForm.comboUnitaMisura); 
}

function handle_change_oggFatturazione()
{
  Enable(document.oggFattForm.comboCausale); 
  if (IExplorer) 
  {
    visualizza("causale");
    visualizza("comboCausale");
  }  
}


function handle_change_Opz()
{
  if (flagExc=="no_opzione" || flagExc=="opzione")
  {
       if (!attivaCalendario)
          abi_calendario();
       document.oggFattForm.oggFattSelez.value=document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value;
       document.oggFattForm.clasOggFattSelez.value=selezione;
       Enable(document.oggFattForm.desc_tariffa);                
       Enable(document.oggFattForm.importo_tariffa);
       Enable(document.oggFattForm.Tipo_Importo[0]);
       Enable(document.oggFattForm.Tipo_Importo[1]);
       Enable(document.oggFattForm.comboOggFatt);   
       Disable(document.oggFattForm.comboUnitaMisura);
       document.oggFattForm.comboUnitaMisura[0].selected=true;
       nascondi("comboCausale");
       Disable(document.oggFattForm.comboCausale);
       if (IExplorer) nascondi("causale");  
       if (selezione!=2)
            {
               document.oggFattForm.Tipo_Importo[0].checked=true;
               document.oggFattForm.tipoImpSelez.value=document.oggFattForm.Tipo_Importo[0].value;
               Disable(document.oggFattForm.Tipo_Importo[0]);
               Disable(document.oggFattForm.Tipo_Importo[1]);
             }
             else
            {
                Enable(document.oggFattForm.Tipo_Importo[0]);
                Enable(document.oggFattForm.Tipo_Importo[1]);
             }
      }
}

function add_combo_elem(Field,Value, Text)
{
var NS4 = (document.layers) ? true : false;
var IE4 = (document.all) ? true : false
if (NS4)
		{
			var newOpt  = new Option(Text,Value);
			var selLength = eval(objForm+'.'+Field+'.length');
			eval(objForm+'.'+Field+'.options[selLength]= newOpt') ;
		}
		else if (IE4)
		{
			var newOpt = document.createElement("OPTION");
			newOpt.text=Text;
			newOpt.value=Value;
			eval(objForm+'.'+Field+'.add(newOpt)');
		}
}

function clear_all_combo(Field)
	{
		var NS4 = (document.layers) ? true : false;
		var IE4 = (document.all) ? true : false;
		var len = eval(objForm+'.'+Field+'.length');
		var NS4 = (document.layers) ? true : false;
		var IE4 = (document.all) ? true : false;
		for (i=0;len>i;i++)
		{
			if (NS4)
				eval(objForm+'.'+Field+'.options[0]=null');
			else if (IE4)
				eval(objForm+'.'+Field+'.remove(0)');
		}
	}


function change_oggFatturazione()
{
  document.oggFattForm.desc_tariffa.value= document.oggFattForm.comboOggFatt.options[document.oggFattForm.comboOggFatt.selectedIndex].text.toUpperCase() ;
    document.oggFattForm.uniMisSelez.value=null;
    //viti 
    document.oggFattForm.caricaOpz.value="false";
    document.oggFattForm.tipoOpzSelez.value=null;
    catturaSelezione();

// Modifica per Shared Access cod_tipo_contr = 17    
    
    if ((document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value==-1) ||
        ((document.oggFattForm.oggFattSelez.value==document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value) && 
        ((document.oggFattForm.cod_tipo_contr.value==9 || document.oggFattForm.cod_tipo_contr.value==17 || document.oggFattForm.cod_tipo_contr.value==37) && (selezione==5 || selezione==6 || selezione==8))))
    {
        nascondi("comboCausale");
        Disable(document.oggFattForm.comboCausale);
        if (IExplorer) nascondi("causale");
        document.oggFattForm.Tipo_Importo[0].checked=true;
        Disable(document.oggFattForm.Tipo_Importo[0]);
        document.oggFattForm.tipoImpSelez.value=document.oggFattForm.Tipo_Importo[0].value;
        document.oggFattForm.Tipo_Importo[1].checked=false;
        Disable(document.oggFattForm.Tipo_Importo[1]);         
        document.oggFattForm.comboUnitaMisura[0].selected=true;
        Disable(document.oggFattForm.comboUnitaMisura);         
        //viti
        document.oggFattForm.comboOpzioniTariffa[0].selected=true;
        Disable(document.oggFattForm.comboOpzioniTariffa);         
        document.oggFattForm.desc_tariffa.value="";
        Disable(document.oggFattForm.desc_tariffa);                 
        document.oggFattForm.data_ini.value="";
        document.oggFattForm.importo_tariffa.value="";
        Disable(document.oggFattForm.importo_tariffa); 
        if (attivaCalendario)
                dis_calendario();
        if (document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value==-1)
        { 
             
            carCausaleBoolean=false;
        }
         if (document.oggFattForm.oggFattSelez.value==document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value) 
         {
           visualizza("comboCausale");
           if (IExplorer) visualizza("causale");
           carCausaleBoolean=true;
           Enable(document.oggFattForm.comboCausale);
           document.oggFattForm.comboCausale[0].selected=true;
           if (selezione!=2)
            {
               document.oggFattForm.Tipo_Importo[0].checked=true;
               document.oggFattForm.tipoImpSelez.value=document.oggFattForm.Tipo_Importo[0].value;
               Disable(document.oggFattForm.Tipo_Importo[0]);
               Disable(document.oggFattForm.Tipo_Importo[1]);
             }
             else
            {
                Enable(document.oggFattForm.Tipo_Importo[0]);
                Enable(document.oggFattForm.Tipo_Importo[1]);
                document.oggFattForm.Tipo_Importo[0].checked=true;
                document.oggFattForm.tipoImpSelez.value=document.oggFattForm.Tipo_Importo[0].value;
             }
         }
    }
    else
    {

// Modifica per Shared Access cod_tipo_contr = 17    	
    if ((document.oggFattForm.cod_tipo_contr.value==9 || document.oggFattForm.cod_tipo_contr.value==17 || document.oggFattForm.cod_tipo_contr.value==37) && (selezione==5 || selezione==6 || selezione==8))
    {
         //inserici il controllo per verificare se l'hai già caricato
         carCausaleBoolean=true;
         document.oggFattForm.oggFattSelez.value=document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value;
         document.oggFattForm.clasOggFattSelez.value=selezione;
        //viti
         document.oggFattForm.comboOpzioniTariffa[0].selected=true;
         Disable(document.oggFattForm.comboOpzioniTariffa);   
         document.oggFattForm.desc_tariffa.value="";
         Disable(document.oggFattForm.desc_tariffa);        
         document.oggFattForm.data_ini.value="";                  
         document.oggFattForm.importo_tariffa.value="";
         Disable(document.oggFattForm.importo_tariffa);          
         Disable(document.oggFattForm.Tipo_Importo[0]);
         Disable(document.oggFattForm.Tipo_Importo[1]);
         document.oggFattForm.Tipo_Importo[0].checked=true;
         Disable(document.oggFattForm.comboUnitaMisura);
         if (attivaCalendario)
                dis_calendario();
         document.oggFattForm.comboUnitaMisura[0].selected=true;
    var strURL="TariffaXContrWfSp.jsp";
        strURL+="?act=causale";
        strURL+="&cod_tipo_contr="+document.oggFattForm.cod_tipo_contr.value;
        strURL+="&oggFattSelez="+document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value;
        strURL+="&clasOggFattSelez="+selezione;
        strURL+="&contrSelez="+document.oggFattForm.contratti[document.oggFattForm.contratti.selectedIndex].value;
        strURL+="&cod_PS="+document.oggFattForm.cod_PS.value;
        openDialog(strURL, 400, 5,handle_change_oggFatturazione);
    }
    else
    {
      carCausaleBoolean=false;
      Disable(document.oggFattForm.comboUnitaMisura); 
      document.oggFattForm.comboUnitaMisura[0].selected=true;
      if (selezione!=-1)
      {
       //viti
        var strURL="TariffaXContrWfSp.jsp";
        strURL+="?act=opz";
        strURL+="&cod_tipo_contr="+document.oggFattForm.cod_tipo_contr.value;
        strURL+="&oggFattSelez="+document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value;
        strURL+="&clasOggFattSelez="+selezione;
        strURL+="&contrSelez="+document.oggFattForm.contratti[document.oggFattForm.contratti.selectedIndex].value;
        strURL+="&cod_PS="+document.oggFattForm.cod_PS.value;
        openDialog(strURL,400, 5,handle_change_Opz);
      }   
   }
  }
}


function attivaComboUnitaMisura()
{
  document.oggFattForm.tipoImpSelez.value=document.oggFattForm.Tipo_Importo[1].value;
  if (UnitaMisuraDisp)
  {
     Enable(document.oggFattForm.comboUnitaMisura);              
  }
  else
  {
       UnitaMisuraDisp=true;
       document.oggFattForm.oggFattSelez.value=document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value;
       document.oggFattForm.clasOggFattSelez.value=selezione;
       var strURL="TariffaXContrWfSp.jsp";
       strURL+="?act=unitaMisura";
       openDialog(strURL, 400, 5,handle_change_radioImporto);
  }   
}

function handleReturnedValuePS()
{
      cod_PS_appoggio=document.oggFattForm.cod_PS.value;
      des_PS_appoggio=document.oggFattForm.des_PS.value;
      ONANNULLA();
      document.oggFattForm.cod_PS.value=cod_PS_appoggio;
      document.oggFattForm.des_PS.value=des_PS_appoggio;
      if (numeroTariffe>0)
      {
       document.oggFattForm.contratti[indiceContr].selected=true;
       Enable(document.oggFattForm.btnPS);    
       Enable(document.oggFattForm.comboOggFatt); 
       }
 }


function selezionaPs()
{
  appoggio=document.oggFattForm.cod_PS.value;
  var cod_tipo_contr=document.oggFattForm.cod_tipo_contr.value;
  var des_tipo_contr=document.oggFattForm.des_tipo_contr.value;
  var des_contr=document.oggFattForm.des_contr.value;
  var cod_contr=document.oggFattForm.contrSelez.value
  var chiamante="TariffaXContrSp";
  var stringa="../../tariffe_x_contr/jsp/ProdServXContrSp.jsp?cod_tipo_contr="+cod_tipo_contr+"&cod_contr="+cod_contr+"&des_tipo_contr="+des_tipo_contr+"&des_contr="+des_contr+"&chiamante="+chiamante;
  openDialog(stringa, 650, 400, handleReturnedValuePS);
}

function handle_insert()
{
if  (act=="reset")
{
  alert('Salvataggio effettuato con successso.');
  cod_PS_appoggio=document.oggFattForm.cod_PS.value;
  des_PS_appoggio=document.oggFattForm.des_PS.value;
  ONANNULLA();
  document.oggFattForm.cod_PS.value=cod_PS_appoggio;
  document.oggFattForm.des_PS.value=des_PS_appoggio;
  document.oggFattForm.contratti[indiceContr].selected=true; //11-03-03

   if (document.oggFattForm.contratti.selectedIndex==0)  //12-03-03
      Disable(document.oggFattForm.btnPS);    
    else
      Enable(document.oggFattForm.btnPS);    
}

if  (act=="refresh")
 {
        alert('Salvataggio effettuato con successso.');
        document.oggFattForm.Tipo_Importo[0].checked=true;
        Disable(document.oggFattForm.Tipo_Importo[0]);
        document.oggFattForm.Tipo_Importo[1].checked=false;
        Disable(document.oggFattForm.Tipo_Importo[1]);
        document.oggFattForm.comboUnitaMisura[0].selected=true;
        Disable(document.oggFattForm.comboUnitaMisura);                 
        document.oggFattForm.desc_tariffa.value="";
        Disable(document.oggFattForm.desc_tariffa);
        //viti
        document.oggFattForm.comboOpzioniTariffa[0].selected=true;
        Disable(document.oggFattForm.comboOpzioniTariffa);   
        document.oggFattForm.data_ini.value="";
        if (attivaCalendario)
          dis_calendario();
        document.oggFattForm.importo_tariffa.value="";
        Disable(document.oggFattForm.importo_tariffa);                 
 }
 else if (act=="no_data_0")
 {
    alert('La data inizio validità tariffa deve essere maggiore o uguale\rdella data inizio validità  dell\'Oggetto di fatturazione.');
    document.oggFattForm.data_ini.value="";
 }
 else if (act=="no_data_1")
 {
    alert('La data inizio validità tariffa deve essere maggiore o uguale\rdella data inizio validità dell\'OF/PS.');
    document.oggFattForm.data_ini.value="";
 }
 else if (act=="no_data_2")
 {
   alert('date di confronto non disponibili');
 }
 else if (act=="no_batch")
 {
  alert('ci sono elaborazioni BATCH in esecuzione, il salvataggio non sarà effettuato') ;
 } 
  act="";
 }


function ONCONFERMA()
{
  messaggio="";
  if (document.oggFattForm.contratti[document.oggFattForm.contratti.selectedIndex].value==-1) 
     {
      messaggio=messaggio+"Contratto non inserito";
      if (document.oggFattForm.contratti.length>1)
          document.oggFattForm.contratti.focus();
      }
  else if (document.oggFattForm.cod_PS.value=="" || document.oggFattForm.cod_PS.value=="null")
      {
         messaggio="Prodotto/Servizio non inserito";
         document.oggFattForm.btnPS.focus();
      }   
   else if (document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value==-1) 
      {     
      messaggio="Oggetto di Fatturazione non selezionato";
      document.oggFattForm.comboOggFatt.focus();
      }
   else if ((document.oggFattForm.comboCausale[document.oggFattForm.comboCausale.selectedIndex].value==-1) && (carCausaleBoolean)) 
      {
      messaggio="Causale non selezionata";
      document.oggFattForm.comboCausale.focus();
      }
   else if (document.oggFattForm.desc_tariffa.value=="")
      {  
      messaggio="Descrizione Tariffa non inserita";
      document.oggFattForm.desc_tariffa.focus();
      }
   else if (document.oggFattForm.data_ini.value=="")
      messaggio="Data inizio validità non inserita";
   /*else if (document.oggFattForm.data_ini.value.substring(0,2) != "01")
      messaggio="La data di inizio validità deve\rdecorrere dal primo giorno del mese";*/
      //viti
    else if ((document.oggFattForm.caricaOpz.value!=null && document.oggFattForm.caricaOpz.value=="true") && (document.oggFattForm.tipoOpzSelez.value==-1 || document.oggFattForm.tipoOpzSelez.value=="null"))
       {  
      messaggio="Opzione Tariffa non inserita";
      document.oggFattForm.comboOpzioniTariffa.focus();
      }      
   else if (document.oggFattForm.importo_tariffa.value=="")
      {
      messaggio="Importo Tariffa non inserito";
      document.oggFattForm.importo_tariffa.focus();
      }
   else if (!CheckNum(document.oggFattForm.importo_tariffa.value,16,4,false))
       {
           messaggio="Importo errato";
           document.oggFattForm.importo_tariffa.focus();
       }    
   if (messaggio!="") 
       alert(messaggio);
   else
       {
          if (confirm("Si conferma l'inserimento della tariffa?"))
          {
            document.oggFattForm.act.value="insert";
            //StampaDati();
            var strURL="TariffaXContrWfSp.jsp";
                strURL+="?act=insert";
                strURL+="&contrSelez="+document.oggFattForm.contratti[document.oggFattForm.contratti.selectedIndex].value;
                strURL+="&cod_tipo_contr="+document.oggFattForm.cod_tipo_contr.value;
                strURL+="&clasOggFattSelez="+selezione;
                strURL+="&codUM="+document.oggFattForm.uniMisSelez.value;
                strURL+="&codUt="+document.oggFattForm.codUt.value;
                strURL+="&oggFattSelez="+document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value;
                strURL+="&cod_PS="+document.oggFattForm.cod_PS.value;
                strURL+="&data_ini="+document.oggFattForm.data_ini.value;
                strURL+="&descTar="+document.oggFattForm.desc_tariffa.value;
                strURL+="&impTar="+document.oggFattForm.importo_tariffa.value;
                strURL+="&flgMat="+document.oggFattForm.tipoImpSelez.value;
                strURL+="&causFatt="+document.oggFattForm.comboCausale[document.oggFattForm.comboCausale.selectedIndex].value;
                strURL+="&opzioneSelez="+document.oggFattForm.tipoOpzSelez.value;
            openDialog(strURL, 400, 5,handle_insert);
          }//if
       }//else   
}

function setInitialValue()
{
 if (document.oggFattForm.contratti.length<2)
    Disable(document.oggFattForm.contratti);
 Disable(document.oggFattForm.btnPS);
 Disable(document.oggFattForm.des_PS);
 Disable(document.oggFattForm.comboOggFatt);
 Disable(document.oggFattForm.comboCausale); 
 //viti
  Disable(document.oggFattForm.comboOpzioniTariffa); 
 if (IExplorer) nascondi("causale");
     nascondi("comboCausale");
 document.oggFattForm.Tipo_Importo[0].checked=true;
 Disable(document.oggFattForm.Tipo_Importo[0]);              
 Disable(document.oggFattForm.Tipo_Importo[1]);               
 Disable(document.oggFattForm.comboUnitaMisura);
 dis_calendario();
 Disable(document.oggFattForm.desc_tariffa);
 Disable(document.oggFattForm.data_ini);
 Disable(document.oggFattForm.importo_tariffa);
}
