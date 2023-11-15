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
  if (document.contratto.comboOggFatt.selectedIndex==0)
    selezione=-1;
  else
    selezione=document.contratto.ccof[document.contratto.comboOggFatt.selectedIndex-1].value;

//28-02-03 inizio aggiunta la gestione della combo Tipo Opzione
entra=false;
if (document.contratto.caricaCausale.value=="true")
{
   if (document.contratto.comboCausale[document.contratto.comboCausale.selectedIndex].value == -1)
      entra=true;
}
else
if (document.contratto.caricaOpzione.value=="true")
{
  if (document.contratto.comboOpzioneTariffa[document.contratto.comboOpzioneTariffa.selectedIndex].value == -1)
      entra=true;
}
      
 if (entra) 
 {
    if (document.contratto.caricaCausale.value=="true")
    {
       document.contratto.causaleSelez.value=document.contratto.comboCausale[document.contratto.comboCausale.selectedIndex].value;
       if (document.contratto.comboCausale.selectedIndex==0)  
           Disable(document.contratto.POPOLALISTA);
       else  
           Enable(document.contratto.POPOLALISTA);

    }   
    if (document.contratto.caricaOpzione.value=="true")
    {
       document.contratto.opzioneSelez.value=document.contratto.comboOpzioneTariffa[document.contratto.comboOpzioneTariffa.selectedIndex].value;
       if (document.contratto.comboOpzioneTariffa.selectedIndex==0)  
           Disable(document.contratto.POPOLALISTA);
       else  
           Enable(document.contratto.POPOLALISTA);
    }
       

    document.contratto.oggFattSelez.value=document.contratto.comboOggFatt[document.contratto.comboOggFatt.selectedIndex].value
    document.contratto.clasOggFattSelez.value=selezione;

    if (document.contratto.caricaLista.value=="true")  
    {
      Enable(document.contratto.des_PS);
      Enable(document.contratto.comboOggFatt);
      document.contratto.caricaLista.value="false";
      document.contratto.submit();
    }  
 }
 else
 {        
          if (document.contratto.caricaCausale.value=="true")
          {
             descr_causale=document.contratto.comboCausale[document.contratto.comboCausale.selectedIndex].name;
             document.contratto.descr_causale.value=descr_causale;
             document.contratto.causaleSelez.value=document.contratto.comboCausale[document.contratto.comboCausale.selectedIndex].value;
             if (document.contratto.comboCausale.selectedIndex==0)  
               Disable(document.contratto.POPOLALISTA);
             else  
                Enable(document.contratto.POPOLALISTA);
          }    
          if (document.contratto.caricaOpzione.value=="true")
          {
             descr_opzione=document.contratto.comboOpzioneTariffa[document.contratto.comboOpzioneTariffa.selectedIndex].name;
             document.contratto.descr_opzione.value=descr_opzione;
             document.contratto.opzioneSelez.value=document.contratto.comboOpzioneTariffa[document.contratto.comboOpzioneTariffa.selectedIndex].value;
             if (document.contratto.comboOpzioneTariffa.selectedIndex==0)  
               Disable(document.contratto.POPOLALISTA);
             else  
                Enable(document.contratto.POPOLALISTA);
          }    
//modifica opzioni 28-02-03 fine
          document.contratto.oggFattSelez.value=document.contratto.comboOggFatt[document.contratto.comboOggFatt.selectedIndex].value
          document.contratto.clasOggFattSelez.value=selezione;
                    
          if (document.contratto.caricaLista.value=="true")  
          {
            Enable(document.contratto.des_PS);
            Enable(document.contratto.comboOggFatt);
            document.contratto.caricaLista.value="false";
            document.contratto.submit();
          }  
 }
}


function carContratto()
{
  document.contratto.des_contr.value=document.contratto.des[document.contratto.contratti.selectedIndex].value;
  
//da qui
     if (document.contratto.contratti.selectedIndex==0)
     {
        
        selezione=-1;
     }
     else
     {
          selezione=document.contratto.contratti[document.contratto.contratti.selectedIndex].value;
     }
    //a qui

    if (selezione!=-1)
    {
      Enable(document.contratto.btnPS);
      document.contratto.contrSelez.value=selezione;
//
        
        document.contratto.oggFattSelez.value="";
        document.contratto.caricaCausale.value="false";
        document.contratto.cod_PS.value='';
        document.contratto.des_PS.value='';
        document.contratto.caricaLista.value="false";
        Enable(document.contratto.cod_tipo_contr);
        Enable(document.contratto.cod_PS);
        Enable(document.contratto.des_PS);
        //alert("da qui");

        document.contratto.caricaLista.value="false";
        carCausaleBoolean=true;
        
        document.contratto.submit();
     
    }
    else
    {  
        document.contratto.contrSelez.value=selezione; 
        document.contratto.oggFattSelez.value="";
        document.contratto.caricaCausale.value="false";
        document.contratto.cod_PS.value='';
        document.contratto.des_PS.value='';
        document.contratto.caricaLista.value="false";
        Enable(document.contratto.cod_tipo_contr);
        Enable(document.contratto.cod_PS);
        Enable(document.contratto.des_PS);
        Disable(document.contratto.btnPS);

        document.contratto.caricaLista.value="false";
        carCausaleBoolean=true;
        
        document.contratto.submit();
         
      
    }
      

}


function caricaCausaleTipoOpz()
{ 
    document.contratto.caricaOpzione.value="false"; //27-02-03

    document.contratto.caricaLista.value="false";
    Disable(document.contratto.POPOLALISTA);
    //da qui
     if (document.contratto.comboOggFatt.selectedIndex==0)
     {
        selezione=-1;
        
     }
     else
     {
       selezione=document.contratto.ccof[document.contratto.comboOggFatt.selectedIndex-1].value;
       
     }
    //a qui
    document.contratto.comboOggFatt[document.contratto.comboOggFatt.selectedIndex].value 
    
// Modifica per Shared Access cod_tipo_contr = 17
    if ((document.contratto.comboOggFatt[document.contratto.comboOggFatt.selectedIndex].value==-1) ||
       ((document.contratto.oggFattSelez.value==document.contratto.comboOggFatt[document.contratto.comboOggFatt.selectedIndex].value) && 
        ((document.contratto.cod_contratto.value==9 || document.contratto.cod_contratto.value==17 || document.contratto.cod_contratto.value==37) && (selezione==5 || selezione==6 || selezione==8))))
    {   
       
        nascondi(document.contratto.comboCausale);
        if (document.contratto.comboOggFatt[document.contratto.comboOggFatt.selectedIndex].value==-1)
         { 

              document.contratto.causaleSelez.value="-1";
              document.contratto.opzioneSelez.value="-1"; //03/03/03
              document.contratto.caricaLista.value="false";
              Disable(document.contratto.POPOLALISTA);
              Enable(document.contratto.des_PS);
              Enable(document.contratto.comboOggFatt);
              document.contratto.clasOggFattSelez.value=selezione;
              nascondi(document.contratto.comboCausale);
              //nascondi(document.contratto.causale);
              document.contratto.caricaCausale.value="false";
              
              if (isnn) 
              {
                document.contratto.oggFattSelez.value=document.contratto.comboOggFatt[document.contratto.comboOggFatt.selectedIndex].value
                document.contratto.caricaCausale.value="false";
                document.contratto.submit();
              }
              
         }
          if (document.contratto.oggFattSelez.value==document.contratto.comboOggFatt[document.contratto.comboOggFatt.selectedIndex].value) 
         {
              document.contratto.comboCausale[0].selected=true;
              visualizza(document.contratto.comboCausale);
              //visualizza(document.contratto.causale);
         }// if (document.contratto.oggFattSelez.value==document.contratto.comboOggFatt.value) 
         
    }//primo if 
    else  
    {
      //qui
      document.contratto.causaleSelez.value="-1";
      document.contratto.opzioneSelez.value="-1"; //03/03/03
      document.contratto.caricaCausale.value="true";
      
      Enable(document.contratto.POPOLALISTA);
      //selezione=document.contratto.prova[document.contratto.comboOggFatt.selectedIndex].value;
      //da qui
         if (document.contratto.comboOggFatt.selectedIndex==0)
         {
           selezione=-1;
             
         }
         else
         {
           selezione=document.contratto.ccof[document.contratto.comboOggFatt.selectedIndex-1].value;
         }
    //a qui

// Modifica per Shared Access cod_tipo_contr = 17     
    if ((document.contratto.cod_tipo_contr.value==9 || document.contratto.cod_tipo_contr.value==17 || document.contratto.cod_tipo_contr.value==37) && (selezione==5 || selezione==6 || selezione==8))
    {
        
        Disable(document.contratto.POPOLALISTA);
        carCausaleBoolean=true;
        document.contratto.oggFattSelez.value=document.contratto.comboOggFatt[document.contratto.comboOggFatt.selectedIndex].value
        document.contratto.clasOggFattSelez.value=selezione;
        Enable(document.contratto.des_PS);
        document.contratto.caricaCausale.value="true"; 
        document.contratto.submit();
    }
    else        // cod_contratto.value!=9||
    {
      carCausaleBoolean=false;
       
      if (selezione!=-1)
      {
            
            document.contratto.caricaLista.value="false";
            carCausaleBoolean=true;
            document.contratto.oggFattSelez.value=document.contratto.comboOggFatt[document.contratto.comboOggFatt.selectedIndex].value
            document.contratto.clasOggFattSelez.value=selezione;
            Enable(document.contratto.des_PS);
            document.contratto.caricaCausale.value="false"; 
            Enable(document.contratto.comboOggFatt);
            nascondi(document.contratto.comboCausale);
            //nascondi(document.contratto.causale);
            document.contratto.submit();
           
       }//if (selezione!=-1)
    }//else selezione cod ogg = 9
  }//else primo if
  
  if (document.contratto.comboOggFatt.value==-1)
  {
    document.contratto.oggFattSelez.value=document.contratto.comboOggFatt[document.contratto.comboOggFatt.selectedIndex].value
    document.contratto.submit();
  }
  
}

function check_form()
{
if (document.contratto.contratti[document.contratto.contratti.selectedIndex].value==-1)
  {
  window.alert("Selezionare un contratto");
   return false;
  }

 

if (document.contratto.des_PS.value=="")
  {
  window.alert("Selezionare un P/S");
   return false;
  }
 
if (document.contratto.comboOggFatt[document.contratto.comboOggFatt.selectedIndex].value==-1)
  {
  window.alert("Selezionare un Oggetto di fatturazione");
  document.contratto.comboOggFatt.focus();
  return false;
  }

if (document.contratto.caricaCausale.value=="true")
{
  if (document.contratto.comboCausale[document.contratto.comboCausale.selectedIndex].value==-1)
    {
     window.alert("Selezionare una Causale");
     //modifica opzioni 18-02-03 inizio
     //document.OggettoFattSp.desc.focus();
     document.contratto.comboCausale.focus();
     //modifica opzioni 18-02-03 fine
     return false;
    }
}    

//modifica opzioni 28-02-03 inizio
if (document.contratto.caricaOpzione.value=="true")
{
  if (document.contratto.comboOpzioneTariffa[document.contratto.comboOpzioneTariffa.selectedIndex].value==-1)
    {
     window.alert("Selezionare un Tipo Opzione");
     document.contratto.comboOpzioneTariffa.focus();
     return false;
    }
}    
//modifica opzioni 28-02-03 fine


return true;
}



