var isnn,isie

if(navigator.appName=='Microsoft Internet Explorer') //check the browser
{
 isie=true;
}

if(navigator.appName=='Netscape')
{
 isnn=true; 
}

function nascondi(oggetto)
{
  
	if  (oggetto!="undefined" && oggetto!=null)
  {
    if (isie)
    {
    oggetto.style.visibility="hidden";
    Disable(oggetto);
    }
    else if (isnn)
    {    
        
        oggetto.visibility="hidden";
    }
   }
}

function visualizza(oggetto)
{
  
	if  (oggetto!="undefinef" && oggetto!=null)
  {
    if (isie)
    {
     oggetto.style.visibility="visible";
     Enable(oggetto);
    }
    else
    if (isnn)
    {    
         oggetto.style.visibility="show";
         
    }
  }
}

function abilitaCampiResidui()
{
     if (document.oggFattForm.comboOggFatt.selectedIndex==0)
        selezione=-1;
     else
       selezione=document.oggFattForm.ccof[document.oggFattForm.comboOggFatt.selectedIndex-1].value;
  
//28-02-03 inizio aggiunta la gestione della combo Tipo Opzione
entra=false;
if (document.oggFattForm.caricaCausale.value=="true")
{
  if (document.oggFattForm.comboCausale[document.oggFattForm.comboCausale.selectedIndex].value == -1)
      entra=true;
}
else
if (document.oggFattForm.caricaOpzione.value=="true")
{
  if (document.oggFattForm.comboOpzioneTariffa[document.oggFattForm.comboOpzioneTariffa.selectedIndex].value == -1)
      entra=true;
}
      
 if (entra) 
 //if (document.oggFattForm.comboCausale[document.oggFattForm.comboCausale.selectedIndex].value == -1 && document.oggFattForm.comboOpzioneTariffa[document.oggFattForm.comboOpzioneTariffa.selectedIndex].value == -1)
 {
    Disable(document.oggFattForm.POPOLALISTA);
    document.oggFattForm.caricaLista.value="false";

    if (document.oggFattForm.caricaCausale.value=="true")
       document.oggFattForm.causaleSelez.value=document.oggFattForm.comboCausale[document.oggFattForm.comboCausale.selectedIndex].value;
    if (document.oggFattForm.caricaOpzione.value=="true")
       document.oggFattForm.opzioneSelez.value=document.oggFattForm.comboOpzioneTariffa[document.oggFattForm.comboOpzioneTariffa.selectedIndex].value;
    
    Enable(document.oggFattForm.des_PS);
    Enable(document.oggFattForm.comboOggFatt);
    document.oggFattForm.oggFattSelez.value=document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value
    document.oggFattForm.clasOggFattSelez.value=selezione;
    document.oggFattForm.submit();
 }
 else
 {        
          if (document.oggFattForm.caricaCausale.value=="true")
          {
              document.oggFattForm.descr_causale.value=document.oggFattForm.comboCausale[document.oggFattForm.comboCausale.selectedIndex].name;
              document.oggFattForm.causaleSelez.value=document.oggFattForm.comboCausale[document.oggFattForm.comboCausale.selectedIndex].value;
          }    
          if (document.oggFattForm.caricaOpzione.value=="true")
          {
              document.oggFattForm.descr_opzione.value=document.oggFattForm.comboOpzioneTariffa[document.oggFattForm.comboOpzioneTariffa.selectedIndex].name;
              document.oggFattForm.opzioneSelez.value=document.oggFattForm.comboOpzioneTariffa[document.oggFattForm.comboOpzioneTariffa.selectedIndex].value;
          }    
//modifica opzioni 28-02-03 fine
          
          Disable(document.oggFattForm.POPOLALISTA);
          document.oggFattForm.caricaLista.value="false";
         
          Enable(document.oggFattForm.des_PS);
          Enable(document.oggFattForm.comboOggFatt);
          document.oggFattForm.oggFattSelez.value=document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value
          document.oggFattForm.clasOggFattSelez.value=selezione;
          document.oggFattForm.submit();
 }
}

function caricaCausaleTipoOpz()
{ 
    document.oggFattForm.caricaOpzione.value="false"; //27-02-03


    document.oggFattForm.caricaLista.value="false";
    Disable(document.oggFattForm.POPOLALISTA);
    //da qui
     if (document.oggFattForm.comboOggFatt.selectedIndex==0)
     {
        selezione=-1;
     }
     else
     {
       selezione=document.oggFattForm.ccof[document.oggFattForm.comboOggFatt.selectedIndex-1].value;
     }
    //a qui
    document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value 

// Modifica per Shared Access cod_tipo_contr = 17
    if ((document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value==-1) ||
       ((document.oggFattForm.oggFattSelez.value==document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value) && 
        ((document.oggFattForm.cod_tipo_contr.value==9 || document.oggFattForm.cod_tipo_contr.value==17 || document.oggFattForm.cod_tipo_contr.value==23 || document.oggFattForm.cod_tipo_contr.value==37) && (selezione==5 || selezione==6 || selezione==8))))
    {   
       
        nascondi(document.oggFattForm.comboCausale);
        if (document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value==-1)
         { 

              document.oggFattForm.causaleSelez.value="-1";
              document.oggFattForm.opzioneSelez.value="-1"; //28/02/03
              document.oggFattForm.caricaLista.value="false";
              Disable(document.oggFattForm.POPOLALISTA);
              Enable(document.oggFattForm.des_PS);
              Enable(document.oggFattForm.comboOggFatt);
              document.oggFattForm.clasOggFattSelez.value=selezione;
              nascondi(document.oggFattForm.comboCausale);
              //nascondi(document.oggFattForm.causale);
              document.oggFattForm.caricaCausale.value="false";
              
              if (isnn) 
              {
                document.oggFattForm.oggFattSelez.value=document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value
                document.oggFattForm.caricaCausale.value="false";
                document.oggFattForm.submit();
              }
              
         }
          if (document.oggFattForm.oggFattSelez.value==document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value) 
         {
              document.oggFattForm.comboCausale[0].selected=true;
              visualizza(document.oggFattForm.comboCausale);
              //visualizza(document.oggFattForm.causale);
         }// if (document.oggFattForm.oggFattSelez.value==document.oggFattForm.comboOggFatt.value) 
         
    }//primo if 
    else  
    {
      //qui
      document.oggFattForm.causaleSelez.value="-1";
      document.oggFattForm.opzioneSelez.value="-1"; //28/02/03
      
      Enable(document.oggFattForm.POPOLALISTA);
      //selezione=document.oggFattForm.prova[document.oggFattForm.comboOggFatt.selectedIndex].value;
      //da qui
         if (document.oggFattForm.comboOggFatt.selectedIndex==0)
         {
           selezione=-1;
             
         }
         else
         {
           selezione=document.oggFattForm.ccof[document.oggFattForm.comboOggFatt.selectedIndex-1].value;
         }
    //a qui
    
// Modifica per Shared Access cod_tipo_contr = 17    
    if ((document.oggFattForm.cod_tipo_contr.value==9 || document.oggFattForm.cod_tipo_contr.value==17 || document.oggFattForm.cod_tipo_contr.value==23 || document.oggFattForm.cod_tipo_contr.value==37) && (selezione==5 || selezione==6 || selezione==8))
    {
        Disable(document.oggFattForm.POPOLALISTA);
        carCausaleBoolean=true;
        document.oggFattForm.oggFattSelez.value=document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value
        document.oggFattForm.clasOggFattSelez.value=selezione;
        Enable(document.oggFattForm.des_PS);
        document.oggFattForm.caricaCausale.value="true"; 
        document.oggFattForm.submit();
    }
    else        // cod_tipo_contr.value!=9||
    {
      carCausaleBoolean=false;
       
      if (selezione!=-1)
      {
            document.oggFattForm.caricaLista.value="false";
            carCausaleBoolean=true;
            document.oggFattForm.oggFattSelez.value=document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value
            document.oggFattForm.clasOggFattSelez.value=selezione;
            Enable(document.oggFattForm.des_PS);
            document.oggFattForm.caricaCausale.value="false"; 
            Enable(document.oggFattForm.comboOggFatt);
            nascondi(document.oggFattForm.comboCausale);
            //nascondi(document.oggFattForm.causale);
            document.oggFattForm.submit();
           
       }//if (selezione!=-1)
    }//else selezione cod ogg = 9
  }//else primo if
  
  if (document.oggFattForm.comboOggFatt.value==-1)
  {
    document.oggFattForm.oggFattSelez.value=document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value
    document.oggFattForm.submit();
  }
  
}

function check_form()
{
 

if (document.oggFattForm.des_PS.value=="")
  {
  window.alert("Selezionare un P/S");
   return false;
  }
 
if (document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value==-1)
  {
  window.alert("Selezionare un Oggetto di fatturazione");
  document.oggFattForm.comboOggFatt.focus();
  return false;
  }

if (document.oggFattForm.caricaCausale.value=="true")
{
  if (document.oggFattForm.comboCausale[document.oggFattForm.comboCausale.selectedIndex].value==-1)
    {
     window.alert("Selezionare una Causale");
     //modifica opzioni 18-02-03 inizio
     //document.OggettoFattSp.desc.focus();
     document.oggFattForm.comboCausale.focus();
     //modifica opzioni 18-02-03 fine
     return false;
    }
}    

//modifica opzioni 18-02-03 inizio
if (document.oggFattForm.caricaOpzione.value=="true")
{
  if (document.oggFattForm.comboOpzioneTariffa[document.oggFattForm.comboOpzioneTariffa.selectedIndex].value==-1)
    {
     window.alert("Selezionare un Tipo Opzione");
     document.oggFattForm.comboOpzioneTariffa.focus();
     return false;
    }
}    
//modifica opzioni 18-02-03 fine





return true;
}



