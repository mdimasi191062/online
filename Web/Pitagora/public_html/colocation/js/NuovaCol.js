var objForm='document.account';
var codeUtrSelezBackup="";
var NS4 = (document.layers) ? true : false;
var IE4 = (document.all) ? true : false;



//Nuova gestione delle combo inizio 25/10/02
    function handle_change_utr()
    {
    //abilita tutto
    EnableAllControls(document.account);
    Disable(document.account.data_ini);

     if (document.account.sito.length>1)
         Enable(document.account.sito);
     else    
         Disable(document.account.sito);
    }

    function add_combo_elem(Field,Value, Text)
    {
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
        var len = eval(objForm+'.'+Field+'.length');
        
        for (i=0;len>i;i++)
        {
          if (NS4)
            eval(objForm+'.'+Field+'.options[0]=null');
          else if (IE4)
            eval(objForm+'.'+Field+'.remove(0)');
        }
    }

//Nuova gestione delle combo fine 25/10/02


function changeUTR()
{
  selezione=document.account.utr[document.account.utr.selectedIndex].value;
  if  (selezione!=-1)
  {
    if (codeUtrSelezBackup==selezione)
    {
      document.account.utrSelez.value=codeUtrSelezBackup;
      Enable(document.account.sito);
    }
    else
    {
      Disable(document.account.sito);
      document.account.sito.options[0].selected=true;
      document.account.utrSelez.value=selezione;
      codeUtrSelezBackup=selezione;
      //document.account.desUtrSelez.value=document.account.utr[document.account.utr.selectedIndex].value;

    //disabilita tutto
    DisableAllControls(document.account);
      
     //Modifica nuova gestione combo inizio 25/10/02
         var strURL="NuovaColWf.jsp";
             strURL+="?act=sito";
             strURL+="&utrSelez="+document.account.utrSelez.value;
             strURL+="&oggFattSelez="
             strURL+="&clasOggFattSelez="
             strURL+="&cod_PS="
        openDialog(strURL, 400, 5,handle_change_utr);
     //Modifica nuova gestione combo fine 25/10/02
    }  
   }
   else // (selezione==-1)
   { 
     //salva ultima selezione valida nel caso venga riselezionata dopo [Seleziona Opzione]
     codeUtrSelezBackup=document.account.utrSelez.value;
     document.account.utrSelez.value=-1;
     Disable(document.account.sito);
     document.account.sito[0].selected=true;
     document.account.sitoSelez.value='-1';
   }
}

function changeSito()
{
   selezione=document.account.sito[document.account.sito.selectedIndex].value;
   document.account.sitoSelez.value=selezione;
}

function changeAccount()
{
   selezione=document.account.account[document.account.account.selectedIndex].value;
   document.account.accountSelez1.value=selezione;
}


function showMessage (field)
{
	if (field=='cancella')
		self.status='Click per cancellare la data selezionata';
 	else
    self.status='Click per selezionare una data';  
}

function cancelCalendar ()
{
  document.account.data_ini.value="";
}

var codOggFattSel="";
var carCausaleBoolean=true;
var UnitaMisuraDisp=false;
var appoggio;
var codtarSel="";

function trasformaData(stringa_data)
{
   var nuova_data = stringa_data.substring(10,6) + stringa_data.substring(5,3)
                   + stringa_data.substring(2,0);
   return nuova_data;
}


function ONANNULLA()
{
  //salva ultima selezione valida nel caso venga riselezionata dopo [Seleziona Opzione]
  codeUtrSelezBackup=document.account.utrSelez.value;
  document.account.sito[0].selected=true;
  Disable(document.account.sito);
  document.account.sitoSelez.value='-1';
  document.account.utrSelez.value='-1';
  document.account.accountSelez1.value='-1';
  document.account.utr[0].selected=true;
  document.account.account[0].selected=true;
  document.account.data_ini.value='';
  document.account.imp_tar.value='';
  document.account.imp_cons.value='';  
  document.account.mod_ull.value='';
  document.account.mod_itc.value='';

  if (String(document.account.qta)!="undefined")
  {
    if (document.account.qta.length=="undefined")
       document.account.qta.value='';
      else
      { 
        for(var i=0;document.account.qta.length>i;i++)
        {
           document.account.qta[i].value='';
        }
      }
   }   
}

function ONCONFERMA()
{
  messaggio="";
  data1=trasformaData(document.account.data_ini.value);
  data2=trasformaData(document.account.data_ini_ddmm.value);
  mod_itc_err=CheckNum(document.account.mod_itc.value,3,0,false);
  mod_ull_err=CheckNum(document.account.mod_ull.value,3,0,false); 
  ritorno=CheckNum(document.account.imp_tar.value,16,4,false);
  ritorno2=CheckNum(document.account.imp_cons.value,16,4,false);

  if (document.account.utr[document.account.utr.selectedIndex].value==-1)
  {
     messaggio="Selezionare una U.T.R valida";
     document.account.utr.focus();
  }   
  else if (document.account.sito[document.account.sito.selectedIndex].value==-1)
  {
     messaggio="Selezionare un Sito valido";
     document.account.sito.focus();
  }   
  else if (document.account.account[document.account.account.selectedIndex].value==-1)
  {
     messaggio="Selezionare un Account valido";  
     document.account.account.focus();
  }   
  else 
   controlli();

      
    if (messaggio!="")   
      alert(messaggio);
    else
    {
     var strURL="NuovaColWf.jsp";
     strURL+="?act=insert";
     strURL+="&accountSelez1="+document.account.accountSelez1.value;
     strURL+="&sitoSelez="+document.account.sitoSelez.value;
     strURL+="&data_ini="+document.account.data_ini.value;
     //window.alert(strURL);
     openDialog(strURL, 400, 5, handle_conferma);
    }
}

function setInitialValue()
{
   Disable(document.account.data_ini);
}


function controlli()
{
  if (document.account.data_ini.value=="")
     messaggio="Data consegna non inserita";
  else if (data1>data2)
     messaggio="Data consegna sito deve essere antecedente o uguale alla data odierna"; 
  
//***************controlli numero moduli***********************
  else if ((document.account.mod_ull.value=="")&&(document.account.mod_itc.value==""))
  {
    messaggio="Numero moduli ULL e/o numero moduli ITC non inserito";
    document.account.mod_ull.focus();
  }  
  else if ((!mod_itc_err)||(!mod_ull_err))
     {
       if (!mod_ull_err) 
       {
          messaggio="Numero moduli ULL errato";
          document.account.mod_ull.focus();
       }   
       else if (!mod_itc_err) 
       {
          messaggio="Numero moduli ITC errato";
          document.account.mod_itc.focus();
       }
     }
  else if((document.account.mod_ull.value=='0')||(document.account.mod_itc.value=='0'))
    messaggio="Il numero moduli deve essere maggiore di 0\r";
//****************************************************************

//******************* controlli importi **************************      
  else if (document.account.imp_tar.value=="")
  {
    messaggio="Importo Annuale Fitto non inserito";
    document.account.imp_tar.focus();
  }  
  else if ((!ritorno)||(!ritorno2))
     {
       if (!ritorno)
       {
         messaggio="Importo Annuale Fitto errato";
         document.account.imp_tar.focus();
       }  
       else if (!ritorno2)
       {
          messaggio="Importo Annuale Consulenza errato";
          document.account.imp_cons.focus();
       }
     }
  else if ((0>=document.account.imp_tar.value)&&(document.account.imp_tar.value!=''))
       {
         messaggio="L'importo Annuale Fitto deve essere maggiore di zero";
         document.account.imp_tar.focus();
       }  
  else if ((0>=document.account.imp_cons.value)&&(document.account.imp_cons.value!=''))
       {
         messaggio="L'importo Annuale Consulenza deve essere maggiore di zero";
         document.account.imp_cons.focus();
       }  
//************************************************************
 else
 {
          //inizio obbligatorietà
          if ((document.account.qta[0].value=='')&&(document.account.qta[1].value=='')) //obbligatorietà
              {
                  messaggio="Verificare che sia inserita una quantità per \r";
                  messaggio=messaggio+"'"+document.account.descPs[0].value+"'\r o per\r '"+document.account.descPs[1].value+"'"+"\r";
              }   
          else if ((document.account.qta[2].value=='')&&(document.account.qta[3].value=='')) //obbligatorietà
              {
                  messaggio="Verificare che sia inserita una quantità per \r";
                  messaggio=messaggio+"'"+document.account.descPs[2].value+"'\r o per\r '"+document.account.descPs[3].value+"'";
              }   
          else if ((document.account.qta[0].value!='')&&(document.account.qta[1].value!=''))
               {
                  messaggio="Inserire una sola quantità relativa a : \r";
                  messaggio=messaggio+"'"+document.account.descPs[0].value+"'\r e \r '"+document.account.descPs[1].value+"'";
               }   
          else if ((document.account.qta[2].value!='')&&(document.account.qta[3].value!=''))
               {
                  messaggio="Inserire una sola quantità relativa a : \r";
                  messaggio=messaggio+"'"+document.account.descPs[2].value+"'\r e \r '"+document.account.descPs[3].value+"'";
               }
          else
          {
             for(var i=4;document.account.qta.length>i;i++) //obbligatorietà
             {
                if (document.account.qta[i].value=='')
                {
                    messaggio="Verificare che sia inserita la quantità per '"+document.account.descPs[i].value+"'";
                    break;
                }    
              }//for 
          }//else    
         //fine obbligatorietà

         if (messaggio =="")  //formato numerico
         {
            messaggio1="";
            vuoto="";
            for(var i=0;document.account.qta.length>i;i++)
            {
             if (document.account.codePs[i].value!="8021") //Non è Punti di Segnalazione 
             {
               if (! CheckNum(document.account.qta[i].value,8,3,false))  
               {
                   vuoto="trovato";
                   messaggio1="'"+document.account.descPs[i].value+"'"; 
                   break;
               }    
             }
             else
             {
                 if (! CheckNum(document.account.qta[i].value,5,0,false))  
                 {
                     messaggio1="'"+document.account.descPs[i].value+"'"; 
                     vuoto="trovato";
                 }    
             }
            }//for
            if (vuoto =="trovato")
                  messaggio="Formato numerico non corretto o quantità minore di zero per :\r"+messaggio1; 
         }//if  //formato numerico

         if (messaggio=="")  //verifica che tutte le quantità siano maggiori di zero
         {
            for(var i=0;document.account.qta.length>i;i++) 
            {
              if (0>document.account.qta[i].value  || document.account.qta[i].value=="0") 
              //if ( document.account.qta[i].value!="" && eval(document.account.qta[i].value) <=0)  //non funziona se metto la virgola invece del punto
              {
                  messaggio="Verificare che la quantità relativa a \r'"+document.account.descPs[i].value+"'\rsia maggiore di zero"
                  break;
              }    
             }//for
         }//if    
 }//else
}