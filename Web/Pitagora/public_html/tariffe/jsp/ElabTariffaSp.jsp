<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="BOTTONI" />
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"ElabTariffaSp.jsp")%>
</logtag:logData>

<%
//Valeria inizio 02-10-02
//istruzioni per il tasto back
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");
//Valeria fine 02-10-02

//INIZIO_1

//dati passati dal pannello chiamante: inizio
  //System.out.println("2 --> des_PS "+request.getParameter("des_PS"));
  String des_PS = request.getParameter("des_PS");
  //System.out.println("2' --> des_PS "+des_PS); 
  if (des_PS==null) des_PS=request.getParameter("des_PS");
  //System.out.println("2' --> des_PS "+des_PS);  
  if (des_PS==null) des_PS=(String)session.getAttribute("des_PS");
  //System.out.println("2' --> des_PS "+des_PS);  
  if (des_PS==null) des_PS=request.getParameter("des_PS_1");
  //System.out.println("2' --> des_PS "+des_PS);  
  

  //System.out.println("3 -----> cod_PS "+request.getParameter("cod_PS"));  
  //System.out.println("3'' -----> cod_PS "+request.getParameter("cod_PS"));  
  String cod_PS = request.getParameter("cod_PS");
  if (cod_PS==null) cod_PS=request.getParameter("cod_PS");
  if (cod_PS==null) cod_PS=(String)session.getAttribute("cod_PS");
  //System.out.println("3''' -----> cod_PS "+cod_PS);    


  String caricaCausale = request.getParameter("caricaCausale");
  if (caricaCausale==null) caricaCausale=(String)session.getAttribute("caricaCausale");
// //System.out.println("100 -----> caricaCausale "+caricaCausale);    

  String descr_causale = request.getParameter("descr_causale");
  if (descr_causale==null) descr_causale=(String)session.getAttribute("descr_causale");
// //System.out.println("101 -----> descr_causale "+descr_causale);    
  
  

  String cod_of = request.getParameter("oggFattSelez");
  if (cod_of==null) cod_of=request.getParameter("cod_of");
  if (cod_of==null) cod_of=(String)session.getAttribute("cod_of");
// //System.out.println("4 -----> cod_of "+request.getParameter("cod_of"));    

 /*per indicare la modalita' di chiamata del pannello: 
 "visualizza" --> "VIS" 
 "cancella" --> "CAN"
 "disattiva" --> "DIS" 
 "aggiorna" --> "AGG"
 */
  String tipo_pannello = request.getParameter("tipo_pannello");
  if (tipo_pannello==null) tipo_pannello=request.getParameter("tipo_pannello");
  if (tipo_pannello==null) tipo_pannello=(String)session.getAttribute("tipo_pannello");
// //System.out.println("4 -----> tipo_pannello "+request.getParameter("tipo_pannello"));    

  String cod_tar = request.getParameter("cod_tar");
  if (cod_tar==null) cod_tar=request.getParameter("cod_tar");
  if (cod_tar==null) cod_tar=(String)session.getAttribute("cod_tar");
// //System.out.println("5 -----> cod_tar "+request.getParameter("cod_tar"));      

  String prog_tar = request.getParameter("prog_tar");
  if (prog_tar==null) prog_tar=request.getParameter("prog_tar");
  if (prog_tar==null) prog_tar=(String)session.getAttribute("prog_tar");
// //System.out.println("8 -----> prog_tar "+request.getParameter("prog_tar"));        

  /*PROVA*/
  String act = request.getParameter("act");
  if (act==null) act=request.getParameter("act");
//if (act==null) act=(String)session.getAttribute("act"); //06-03-03
//  if (act==null) act = "avvio";
// //System.out.println("30 -----> act "+request.getParameter("act"));        
// //System.out.println("31 -----> act "+(String)session.getAttribute("act"));    
  

 String des_tipo_contr = request.getParameter("des_tipo_contr");
  if (des_tipo_contr==null) des_tipo_contr=request.getParameter("des_tipo_contr");
  if (des_tipo_contr==null) des_tipo_contr=(String)session.getAttribute("des_tipo_contr");
// //System.out.println("14 -----> des_tipo_contr "+request.getParameter("des_tipo_contr"));          
// //System.out.println("14' -----> des_tipo_contr "+des_tipo_contr);          

  String cod_tipo_contr = request.getParameter("cod_tipo_contr");
  if (cod_tipo_contr==null) cod_tipo_contr=request.getParameter("cod_tipo_contr");
  if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("cod_tipo_contr");
// //System.out.println("9 -----> cod_tipo_contr "+request.getParameter("cod_tipo_contr"));          

//Valeria inizio 07-10-02 
  String caricaLista = request.getParameter("caricaLista");
  if (caricaLista==null) caricaLista = (String)session.getAttribute("caricaLista");
//Valeria fine 07-10-02   

// //System.out.println("20 --> hidFlagSys "+request.getParameter("hidFlagSys"));
  String hidFlagSys = request.getParameter("hidFlagSys");
// //System.out.println("1) hidFlagSys "+hidFlagSys);  
  if (hidFlagSys==null) hidFlagSys=request.getParameter("hidFlagSys");
// //System.out.println("2) hidFlagSys "+hidFlagSys);  
  if (hidFlagSys==null) hidFlagSys=(String)session.getAttribute("hidFlagSys");
// //System.out.println("3) hidFlagSys "+hidFlagSys);  
  if (hidFlagSys==null) hidFlagSys=request.getParameter("hidFlagSys");
// //System.out.println("4)hidFlagSys "+hidFlagSys);

    //SIMULAZIONE (sara' passato dal cbiamante)
    //hidFlagSys = new String("S");

// //System.out.println("hidFlagSys "+hidFlagSys);

  

//Valeria inizio 30-09-02  
//ho ripristinato queste righe di codice: il cod_tipo_caus mi viene passato dal chiamante
// (ListaTariffeSp)
/*non dovrebbe servire perchè il cod_tipo_caus viene caricato da TARIFFA_DETTAGLIO e 
utilizzato poi da CAUS_FAT_LEGGI_DET*/
//-07-03-03
  String cod_tipo_caus = request.getParameter("causaleSelez");
  /*if (cod_tipo_caus==null) cod_tipo_caus=request.getParameter("cod_tipo_caus");
  if (cod_tipo_caus==null) cod_tipo_caus=(String)session.getAttribute("cod_tipo_caus");*/
// //System.out.println("7 -----> cod_tipo_caus "+request.getParameter("cod_tipo_caus"));      
//Valeria fine 30-09-02    

//System.out.println(">>>>>>>>>>>>>>>>asdasdasdas>>>>>>sefdfsefef>>>>> "+cod_tipo_caus);

//dati passati dal pannello chiamante: fine

//dati che vengono generati nel pannello e ripassati allo stesso alla pressione di un bottone: inizio
  String importo_tariffa = request.getParameter("importo_tariffa"); 
  if (importo_tariffa==null) importo_tariffa=request.getParameter("importo_tariffa");
  if (importo_tariffa==null) importo_tariffa=(String)session.getAttribute("importo_tariffa");
  //if (importo_tariffa!=null) importo_tariffa=importo_tariffa.replace('.',',');  
  //System.out.println("26 -----> importo_tariffa "+request.getParameter("importo_tariffa"));                  

  String descrizione_tariffa = request.getParameter("descrizione_tariffa"); 
  if (descrizione_tariffa==null) descrizione_tariffa=request.getParameter("descrizione_tariffa");
  if (descrizione_tariffa==null) descrizione_tariffa=(String)session.getAttribute("descrizione_tariffa");
// //System.out.println("26 -----> descrizione_tariffa "+request.getParameter("descrizione_tariffa"));                  

  String data_fine_tariffa = request.getParameter("data_fine_tariffa"); 
  if (data_fine_tariffa==null) data_fine_tariffa=request.getParameter("data_fine_tariffa");
  if (data_fine_tariffa==null) data_fine_tariffa=(String)session.getAttribute("data_fine_tariffa");
// //System.out.println("13 -----> data_fine_tariffa "+request.getParameter("data_fine_tariffa"));                  
  //questa è la data fine tariffa che deve essere inserita dall'utente e passata al pannello quando si
  //preme "disattiva": 

  String data_inizio_tariffa = request.getParameter("data_inizio_tariffa"); 
  if (data_inizio_tariffa==null) data_inizio_tariffa=request.getParameter("data_inizio_tariffa");
  if (data_inizio_tariffa==null) data_inizio_tariffa=(String)session.getAttribute("data_inizio_tariffa");
// //System.out.println("16 -----> data_inizio_tariffa "+request.getParameter("data_inizio_tariffa"));                  
  //questa è la data fine tariffa che deve essere inserita dall'utente e passata al pannello quando si
  //preme "aggiorna": 

  String min_clas_sconto = request.getParameter("min_clas_sconto"); 
  if (min_clas_sconto==null) min_clas_sconto=request.getParameter("min_clas_sconto");
  if (min_clas_sconto==null) min_clas_sconto=(String)session.getAttribute("min_clas_sconto");
// //System.out.println("40 -----> min_clas_sconto "+request.getParameter("min_clas_sconto"));                  
  min_clas_sconto = "";
  //minimo classe di sconto che per ora non viene gestito, nè letto da DB: per questo l'ho posto a ""

  String max_clas_sconto = request.getParameter("max_clas_sconto"); 
  if (max_clas_sconto==null) max_clas_sconto=request.getParameter("max_clas_sconto");
  if (max_clas_sconto==null) max_clas_sconto=(String)session.getAttribute("max_clas_sconto");
// //System.out.println("41 -----> max_clas_sconto "+request.getParameter("max_clas_sconto"));                  
  max_clas_sconto = "";
  //massimo classe di sconto che per ora non viene gestito, nè letto da DB: per questo l'ho posto a ""
  
//dati che vengono generati nel pannello e ripassati allo stesso alla pressione di un bottone: fine  


//dati da passare alla Servlet quando viene premuto "Disattiva"/"Aggiorna": inizio

  //per il bottone "Aggiorna": nome dell'utente
  String nome_utente = ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName();


  //per la stored TARIFFA_DETTAGLIO e ASSOC_OFPS_DISATTIVA
  String data_ini_val_of = request.getParameter("data_ini_val_of");
  if (data_ini_val_of==null) data_ini_val_of=request.getParameter("data_ini_val_of");
  if (data_ini_val_of==null) data_ini_val_of=(String)session.getAttribute("data_ini_val_of");
// //System.out.println("10 -----> data_ini_val_of "+request.getParameter("data_ini_val_of"));            


  //per la stored TARIFFA_DETTAGLIO e ASSOC_OFPS_DISATTIVA
  String data_ini_val_ass_ofps = request.getParameter("data_ini_val_ass_ofps");
  if (data_ini_val_ass_ofps==null) data_ini_val_ass_ofps=request.getParameter("data_ini_val_ass_ofps");
  if (data_ini_val_ass_ofps==null) data_ini_val_ass_ofps=(String)session.getAttribute("data_ini_val_ass_ofps");
// //System.out.println("11 -----> data_ini_val_ass_ofps "+request.getParameter("data_ini_val_ass_ofps"));              
//dati da passare alla Servlet quando viene premuto "Disattiva": fine  

//modifica opzioni 18-02-03 inizio
  String caricaOpzione = request.getParameter("caricaOpzione");
  if (caricaOpzione==null) caricaOpzione=(String)session.getAttribute("caricaOpzione");

  String opzioneSelez = request.getParameter("opzioneSelez");
  if (opzioneSelez==null) opzioneSelez=(String)session.getAttribute("opzioneSelez");

  String descr_opzione = request.getParameter("descr_opzione");
  if (descr_opzione==null) descr_opzione=(String)session.getAttribute("descr_opzione");

//modifica opzioni 18-02-03 fine




//variabili interne al pannello: inizio
  boolean stato_radio_fisso = false;
  boolean stato_radio_variabile = false;
  boolean apri_pannello = false; //per verificare la possibilità di aprire il pannello
  Integer num_tar_disattive=new Integer(0);
  Integer num_tar_provvisor=new Integer(0);  
  String data_inizio_mmdd =  Utility.getDateMMDDYYYY();
  String data_fine_mmdd =  Utility.getDateMMDDYYYY();  
  
  
//variabili interne al pannello: fine  




//variabili per le stored: inizio

  Integer num_tariffe; //per la stored TARIFFA_VER_ES_ATTIVE
  String code_classe_of;      //per la stored OGGETTO_FATT_LEGGI_DETTAGLIO
  String max_data_fine_tariffa; //per la stored TARIFFA_MAX_DATA_FINE  

//variabili per le stored: fine  

%>
<%
  String titolo; //per il titolo del pannello

  if (tipo_pannello.equalsIgnoreCase("VIS"))
    titolo = "Visualizzazione tariffa";
  else if (tipo_pannello.equalsIgnoreCase("DIS"))
    titolo = "Disattivazione tariffa";
  else if (tipo_pannello.equalsIgnoreCase("CAN"))
    titolo = "Cancellazione tariffa";
  else //tipo_pannello = AGG
    titolo = "Aggiornamento tariffa";  

//   //System.out.println("titolo -->"+titolo);
%>
<EJB:useHome id="homeTariffa" type="com.ejbBMP.TariffaBMPHome" location="TariffaBMP" />
<EJB:useHome id="homeOggFatt" type="com.ejbBMP.OggFattBMPHome" location="OggFattBMP" />

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
<%=titolo%>
</TITLE>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>
//per la gestione del browser IExplorer / Netscape Navigator
IExplorer =document.all?true:false;  
Navigator =document.layers?true:false;

var message1="Click per selezionare la data";
var message3="Click per cancellare la data selezionata";
var jswid = "";
var  importo_tariffaStart="";
var  descrizione_tariffaStart="";
var  data_inizio_tariffaStart="";

function setInitialValue()
{
	//window.alert("ACT --> "+document.ElabTariffaSp.act.value);       
<%
  if  (act!=null)
  {
    if (act.equalsIgnoreCase("no_batch"))
    {
%>
	     window.alert("Attenzione! Impossibile proseguire a causa della presenza di elaborazioni batch in corso");
<%  
       act = null;
%>
       document.ElabTariffaSp.act.value="";
	     //window.alert("ACT --> "+document.ElabTariffaSp.act.value);
<%       
    }
    else if (act.equalsIgnoreCase("no_data"))
    {
%>
	     window.alert("Attenzione! Data inizio validità non valida o tariffa già in utilizzo");
<%  
       act = null;
%>
       document.ElabTariffaSp.act.value="";
	     //window.alert("ACT --> "+document.ElabTariffaSp.act.value);
<%       
    }
    else if (act.equalsIgnoreCase("no_provv"))
    {
%>
	     window.alert("Attenzione! Data inizio validità non valida o tariffa già in utilizzo");
<%  
       act = null;
%>
       document.ElabTariffaSp.act.value="";
	     //window.alert("ACT --> "+document.ElabTariffaSp.act.value);
<%       
    }else{
       System.out.println("NESSUN ERRORE");
    }
  }
//  else  //System.out.println("act è null");
%>  
}

function trasformaData(stringa_data)
{
  var nuova_data = stringa_data.substring(10,6) + stringa_data.substring(5,3)
                   + stringa_data.substring(2,0);
   return nuova_data;
}

function CancelMe()
{
  self.close();
	return false;
}

function ONCANCELLA()
{
  if (confirm("Si conferma la cancellazione della tariffa?"))
  {
   //07-03-03-inizio
   Enable(document.ElabTariffaSp.importo_tariffa); 
   Enable(document.ElabTariffaSp.data_inizio_tariffa); 
   Enable(document.ElabTariffaSp.descrizione_tariffa);                
   Enable(document.ElabTariffaSp.data_ini_val_of);
   Enable(document.ElabTariffaSp.data_ini_val_ass_ofps);
   Enable(document.ElabTariffaSp.nome_utente);
   //07-03-03-fine

  
    document.ElabTariffaSp.act.value = "cancella";
    Enable(document.ElabTariffaSp.cod_tar);
    Enable(document.ElabTariffaSp.prog_tar);
    Enable(document.ElabTariffaSp.act);
    //aggiunta gestione di cod_tipo_caus
    Enable(document.ElabTariffaSp.cod_tipo_caus);    
    Enable(document.ElabTariffaSp.des_tipo_contr);        
    Enable(document.ElabTariffaSp.des_PS); 
    Enable(document.ElabTariffaSp.hidFlagSys);     
    Enable(document.ElabTariffaSp.caricaCausale);                                     
    Enable(document.ElabTariffaSp.caricaLista);   
    Enable(document.ElabTariffaSp.tipo_importo);                                         
    
    //modifiche opzioni 18-02-03 inizio
    Enable(document.ElabTariffaSp.caricaOpzione);   
    Enable(document.ElabTariffaSp.opzioneSelez);   
    //modifiche opzioni 18-02-03 fine

    document.ElabTariffaSp.action='<%=request.getContextPath()%>/servlet/TariffaCntl';
    document.ElabTariffaSp.submit();
  }
}

function controllaDataXAggiorna()
{ 
  var data_ok = true;
  
  if (document.ElabTariffaSp.data_inizio_tariffa.value!=null && document.ElabTariffaSp.data_inizio_tariffa.value!=""){
    /*if (document.ElabTariffaSp.data_inizio_tariffa.value.substring(2,0)=="01") //(2)
    {*/
      //prendo la max tra data_of e data_ofps (5)
      data_of = trasformaData(document.ElabTariffaSp.data_ini_val_of.value);
      data_ofps = trasformaData(document.ElabTariffaSp.data_ini_val_ass_ofps.value);
      //window.alert("data_inizio_tariffa --> "+document.ElabTariffaSp.data_inizio_tariffa.value);
      data_ini = trasformaData(document.ElabTariffaSp.data_inizio_tariffa.value);

      var data_max;
      if (data_of >= data_ofps)
        data_max = data_of;
      else
        data_max = data_ofps;

      if (data_ini >= data_max)              
      {
        //elaborazione possibile
        data_ok = true;
      }
      else
      {
        window.alert("Attenzione! Data inizio validità non valida.");
        data_ok = false;        
      }
    /*}
    else
    {
      window.alert("Attenzione! La data inizio deve decorrere dal primo giorno del mese.");
      data_ok = false;
    }*/
  }
  else
  {
    window.alert("Attenzione! Data inizio tariffa obbligatoria.")
    data_ok = false;
  }
  return data_ok;
}


function controllaImportoXAggiorna()
{
  importo_ok = true;
  if (document.ElabTariffaSp.importo_tariffa.value!=null && document.ElabTariffaSp.importo_tariffa.value!="")
  {
       ritorno=CheckNum(document.ElabTariffaSp.importo_tariffa.value,16,4,false);              
       if (ritorno)
       {
         importo_ok = true;
       }
       else
       {
          window.alert("Attenzione! Formato dell'importo errato"); 
          importo_ok = false;
       }
  }
  else 
  {
    window.alert("Attenzione! Importo tariffa obbligatorio.");
    importo_ok = false;
  }
  return importo_ok;
}

function ONANNULLA()
{
  //ripristina la situazione iniziale
  document.ElabTariffaSp.importo_tariffa.value=importo_tariffaStart;
  document.ElabTariffaSp.descrizione_tariffa.value=descrizione_tariffaStart;
  document.ElabTariffaSp.data_inizio_tariffa.value=data_inizio_tariffaStart;
 }


function ONAGGIORNA()
{
     if (document.ElabTariffaSp.descrizione_tariffa.value!=null && document.ElabTariffaSp.descrizione_tariffa.value!="")
     {
        if (controllaImportoXAggiorna()==true && controllaDataXAggiorna()==true)
        {
             if (confirm("Si conferma l'aggiornamento della tariffa?"))
             {
               Enable(document.ElabTariffaSp.importo_tariffa); 
               Enable(document.ElabTariffaSp.data_inizio_tariffa); 
               Enable(document.ElabTariffaSp.descrizione_tariffa);                
               document.ElabTariffaSp.act.value="aggiorna";
               document.ElabTariffaSp.action="ElabTariffaSp.jsp";
               Enable(document.ElabTariffaSp.act);
               Enable(document.ElabTariffaSp.data_ini_val_of);
               Enable(document.ElabTariffaSp.data_ini_val_ass_ofps);
               Enable(document.ElabTariffaSp.cod_tar);
               Enable(document.ElabTariffaSp.nome_utente);
               Enable(document.ElabTariffaSp.cod_tipo_caus);
               Enable(document.ElabTariffaSp.des_tipo_contr);
               Enable(document.ElabTariffaSp.des_PS);
               Enable(document.ElabTariffaSp.hidFlagSys);
               Enable(document.ElabTariffaSp.caricaCausale);

              //modifiche opzioni 18-02-03 inizio
               Enable(document.ElabTariffaSp.caricaOpzione);
               Enable(document.ElabTariffaSp.opzioneSelez);              
              //modifiche opzioni 18-02-03 fine 
              
               Enable(document.ElabTariffaSp.caricaLista);
               Enable(document.ElabTariffaSp.tipo_importo);
               document.ElabTariffaSp.action='<%=request.getContextPath()%>/servlet/TariffaCntl';
               document.ElabTariffaSp.submit();
             }
        }
     }
     else 
     {
          window.alert("Attenzione! Descrizione tariffa obbligatoria.");
     }
}



function ONDISATTIVA()
{
   Disable(document.ElabTariffaSp.data_fine_tariffa);
   if (document.ElabTariffaSp.data_fine_tariffa.value!=null && document.ElabTariffaSp.data_fine_tariffa.value!="")
   {
      //controllo che data_inizio_tariffa sia minore di data_fine_tariffa
      if (document.ElabTariffaSp.data_inizio_tariffa_dis.value!=null && document.ElabTariffaSp.data_inizio_tariffa_dis.value!="")
      {
          data1 = trasformaData(document.ElabTariffaSp.data_inizio_tariffa_dis.value);
          data2 = trasformaData(document.ElabTariffaSp.data_fine_tariffa.value);
          if (data1 >= data2) 
          {
                window.alert("Attenzione! Data inizio tariffa maggiore o uguale a Data fine tariffa");
          }
          else
          {
            if (confirm("Si conferma la disattivazione della tariffa?"))
            {
              //elaborazione possibile
              document.ElabTariffaSp.act.value="disattiva";
              document.ElabTariffaSp.action="ElabTariffaSp.jsp";
              Enable(document.ElabTariffaSp.act);
              Enable(document.ElabTariffaSp.cod_tar);
              Enable(document.ElabTariffaSp.prog_tar);
              Enable(document.ElabTariffaSp.cod_tipo_caus);   
              Enable(document.ElabTariffaSp.des_tipo_contr);                 
              Enable(document.ElabTariffaSp.des_PS);     
              Enable(document.ElabTariffaSp.hidFlagSys);                   
              Enable(document.ElabTariffaSp.caricaLista);             
              Enable(document.ElabTariffaSp.tipo_importo);                                                        
              Enable(document.ElabTariffaSp.data_fine_tariffa);
              Enable(document.ElabTariffaSp.cod_PS);
              Enable(document.ElabTariffaSp.cod_of);
              Enable(document.ElabTariffaSp.data_ini_val_of);
              Enable(document.ElabTariffaSp.data_ini_val_ass_ofps);

              //modifica opzioni 18-02-03 inizio
              Enable(document.ElabTariffaSp.opzioneSelez);   
              //modifica opzioni 18-02-03 fine

              document.ElabTariffaSp.action='<%=request.getContextPath()%>/servlet/TariffaCntl';
              document.ElabTariffaSp.submit();
            }
          }
      }

   }
   else
   {
      window.alert("Attenzione! Data fine tariffa obbligatoria");
   }

   return false; 
}

function showMessage (field)
{
	if (field=='seleziona1')
		self.status=message1;
	else
    if (field=='seleziona2')
  		self.status=message2;
  	else
  		self.status=message3;
}

function cancelLink ()
{
  return false;
}

function cancelCalendar ()
{
  if (document.ElabTariffaSp.tipo_pannello.value=="DIS")
  {
    document.ElabTariffaSp.data_fine_tariffa.value="";
  }
  else if (document.ElabTariffaSp.tipo_pannello.value=="AGG")
  {
    document.ElabTariffaSp.data_inizio_tariffa.value="";
  }
  else return;
  return;
    
  
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

function mess_disabilita(oggetto, controllo)
{
 if (Navigator)
 {
  if (oggetto=="fisso") //cliccato su fisso
  {
    document.ElabTariffaSp.rd_variabile.focus();
    if (document.ElabTariffaSp.rd_variabile.checked == false) //ho cliccato su rd_fisso che era gia' true
    {
      document.ElabTariffaSp.rd_variabile.checked = false;
      document.ElabTariffaSp.rd_fisso.checked = true;
    }
    else
    {
      document.ElabTariffaSp.rd_variabile.checked = true;
      document.ElabTariffaSp.rd_fisso.checked = false;
    }
  }
  else //cliccato su variabile
  {
    document.ElabTariffaSp.rd_fisso.focus();
    
    if (document.ElabTariffaSp.rd_fisso.checked == false) //ho cliccato su rd_variabile che era gia' true
    {
      document.ElabTariffaSp.rd_variabile.checked = true;
      document.ElabTariffaSp.rd_fisso.checked = false;
    }
    else
    {
      document.ElabTariffaSp.rd_variabile.checked = false;
      document.ElabTariffaSp.rd_fisso.checked = true;
    }
  }
  window.alert("radio button non selezionabile");    
  }
}

function disabilita(oggetto)
{ 
    mess_disabilita(oggetto, true);
}


</SCRIPT>

</HEAD>
<BODY onload="setInitialValue();">
<!--Valeria inizio 02-10-02 : modificato metodo da post a get -->
<form name="ElabTariffaSp" id="ElabTariffaSp" method="get" onsubmit="return check_form();" action='<%=request.getContextPath()%>/servlet/TariffaCntl'>
<input type="hidden" name=act id=act value="<%=act%>">

<%
  //INIZIO_2
  OggFattBMPPK pkOggFatt = new OggFattBMPPK();
  TariffaBMPPK pkTariffa = new TariffaBMPPK();  
  //variabili per il pannello: inizio
  String desc_classe_of=new String();          //descrizione oggetto di fatturazione (vedere se serve inizializzarla)
  String desc_UM = new String();               //unita di misura (vedere se serve inizializzarla)
//  String codeClasseOf;          //manca la tipologia oggetto di fatturazione
  String desc_tipo_caus = new String();        //descrizione della causale (vedere se serve inizializzarla)
  //Valeria inizio 12-02-03
  String desc_tipo_opzione = new String();        //descrizione della causale (vedere se serve inizializzarla)
  //Valeria fine 12-02-03
  String tipo_importo = new String();          //tipo_importo (vedere se serve inizializzarla)
  String code_clas_sconto = new String();      //codice classe di sconto (vedere se serve inizializzarla)
  Integer num_elab_trovate; //numero elaborazioni trovate
//Valeria inizio 30-09-02
//riga commentata perchè il dato viene acquisito dal chiamante
  //String cod_tipo_caus= new String(); //codice tipo causale
//Valeria fine 30-09-02  
  //variabili per il pannello: fine  

   pkOggFatt.setCodeOf(cod_of); //setto il valore per chiamare OGGETTO_FATT_LEGGI_DETTAGLIO
 
%>


<%
  //imposto le date a seconda del tipo di pannello
 
  //inizializzo le date
  if (tipo_pannello.equalsIgnoreCase("DIS"))
    data_fine_tariffa=Utility.getDateDDMMYYYY();     //inizializzo la data fine validita' (abilitata)
  else if (tipo_pannello.equalsIgnoreCase("AGG"))
    data_inizio_tariffa=Utility.getDateDDMMYYYY(); //inizializzo la data inizio validita' (abilitata)

  /*se tipo_pannello= disattiva (DIS), aggiorna (AGG), cancella (CAN), devo verificare che 
  il pannello possa essere aperto*/

  if (tipo_pannello.equalsIgnoreCase("DIS") || tipo_pannello.equalsIgnoreCase("CAN") || tipo_pannello.equalsIgnoreCase("AGG"))
  {

  //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>"+cod_tar+" "+prog_tar);
%>  
    <!--chiamo TARIFFA_VER_DISATTIVA-->
    <EJB:useBean id="remote_14" type="com.ejbBMP.TariffaBMP" value="<%=homeTariffa.findTariffaVerDisattiva(cod_tar, prog_tar)%>" scope="session"></EJB:useBean>
<%
      num_tar_disattive = remote_14.getNumTarDisattive();

      //SIMULAZIONE
      //num_tar_disattive = new Integer(0);
     
      if (num_tar_disattive.intValue()!=0)
        apri_pannello = true;
        
      if (apri_pannello==true && (tipo_pannello.equalsIgnoreCase("DIS") || tipo_pannello.equalsIgnoreCase("CAN")))
      {
%>      
        <!--chiamo TARIFFA_VER_PROVV-->
        <EJB:useBean id="remote_15" type="com.ejbBMP.TariffaBMP" value="<%=homeTariffa.findTariffaVerProvv(cod_tar, prog_tar)%>" scope="session"></EJB:useBean>
<%
          num_tar_provvisor = remote_15.getNumTarProvvisor();

          //SIMULAZIONE
          //num_tar_provvisor = new Integer(0);

          if (tipo_pannello.equalsIgnoreCase("DIS"))
          {
            if (num_tar_provvisor.intValue()==0)
              apri_pannello = true;
           else
              apri_pannello = false;
          }

          if (tipo_pannello.equalsIgnoreCase("CAN"))
          {
            if (num_tar_provvisor.intValue()!=0)
              apri_pannello = true;
           else
              apri_pannello = false;
          }
      }
  }
  else //tipo_pannello = "VIS"
    apri_pannello = true;
%>  

  <!--carico il pannello, solo se apri_pannello == true -->

<%
  if (apri_pannello) //IF_APRI_PANNELLO
  {
%>
  

    <!--chiamo UNITA_MISURA_DETT-->
    <EJB:useBean id="remote_11" type="com.ejbBMP.TariffaBMP" value="<%=homeTariffa.findUnitaMisuraDettXTar(cod_tar, prog_tar)%>" scope="session"></EJB:useBean>
<%
    desc_UM = remote_11.getDescUM();
    //se il campo è null, lo imposto a "" per non mostrare null sul pannello
    if (desc_UM==null)
      desc_UM = "";
    
    pkOggFatt.setFlagSys(hidFlagSys);
%>
    <!--chiamo OGGETTO_FATT_LEGGI_DETTAGLIO-->
    <EJB:useBean id="remote_21" type="com.ejbBMP.OggFattBMP" value="<%=homeOggFatt.findByPrimaryKey(pkOggFatt)%>" scope="session"></EJB:useBean>
<%
//    desc_classe_of = remote_21.getDescClasseOf();
    desc_classe_of = remote_21.getDescOggFatt();
    code_classe_of = remote_21.getCodeCOf();
%>            

    <!--chiamo TARIFFA_DETTAGLIO-->
<%
    pkTariffa.setCodTar(cod_tar);
    pkTariffa.setProgTar(prog_tar);    

%>
    <EJB:useBean id="remote_13" type="com.ejbBMP.TariffaBMP" value="<%=homeTariffa.findByPrimaryKey(pkTariffa)%>" scope="session"></EJB:useBean>
<%

     tipo_importo = remote_13.getFlgMat();
     code_clas_sconto = remote_13.getCodClSc();
     data_inizio_tariffa = remote_13.getDataIniTar();
     data_fine_tariffa = remote_13.getDataFineTar();
     descrizione_tariffa = remote_13.getDescTar();
     importo_tariffa = remote_13.getImpTar().toString();   
     //Valeria inizio 12-02-03
     //per visualizzare il desc_tipo_opzione
     if (remote_13.getDescTipoOpz()!=null)
         desc_tipo_opzione = remote_13.getDescTipoOpz().toString();   
     //Valeria fine 12-02-03
     
     data_ini_val_of = remote_13.getDataIniValOf();          
     data_ini_val_ass_ofps = remote_13.getDataIniValAssOfPs();  

     if (remote_13.getCausFatt()!=null)
         cod_tipo_caus = remote_13.getCausFatt(); //07-03-03

     //imposto i campi eventualmente null a "" per non mostrare null sul pannello
     if (data_fine_tariffa==null)
      data_fine_tariffa = "";
     if (code_clas_sconto==null)
      code_clas_sconto = "";
     if (importo_tariffa==null)
      importo_tariffa = "";

      
     if ((code_classe_of.equalsIgnoreCase("5") || code_classe_of.equalsIgnoreCase("6") || code_classe_of.equalsIgnoreCase("8")) &&  cod_tipo_contr.equalsIgnoreCase("9")) 
     {
%>
       <!--chiamo CAUS_FATT_LEGGI_DETT-->
       <EJB:useBean id="remote_12" type="com.ejbBMP.TariffaBMP" value="<%=homeTariffa.findCausFattLeggiDett(cod_tipo_caus)%>" scope="session"></EJB:useBean>
<%    
        desc_tipo_caus = remote_12.getDescTipoCaus();

     }
     else
     {
          desc_tipo_caus = null; // la pongo a null per le verifiche successive
     }

      if (tipo_pannello.equalsIgnoreCase("AGG"))
      {
%>
         <!--chiamo OGGETTO_FATT_MAX_DATAINI_OF-->
         <EJB:useBean id="remote_22" type="com.ejbBMP.OggFattBMP" value="<%=homeOggFatt.findOggFattMaxDataIni(cod_of)%>" scope="session"></EJB:useBean>
<%
         data_ini_val_ass_ofps = remote_22.getDataIni();   
      }
  } //ENDIF_APRI_PANNELLO            
%>
  <table align=center width="90%" border="0" cellspacing="0" cellpadding="0"> <!--TABELLA_1-->
    <tr>
      <td><img src="../images/titoloPagina.gif" alt="" border="0"></td>    
    </tr>
    <tr>
      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>    
    </tr>
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>"> <!--TABELLA_2-->
          <tr>
            <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>"> <!--TABELLA_3-->
                <tr>
                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;<%=titolo%></td>
                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
                </tr>
             </table> <!--FINE_TABELLA_3-->
            </td>
          </tr>
        </table> <!--FINE_TABELLA_2-->
      </td>
    </tr>
    <tr>
      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="Images/pixel.gif" width="1" height='3'></td>
    </tr>

    <!--faccio il confronto per sapere se aprire il pannello con i dati o mostrare il messaggio-->
<%
    if (!apri_pannello) //IF_APRI_PANNELLO=FALSE
    {
      for (int i=0; i<4; i++)
      {
%>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="Images/pixel.gif" width="1" height='3'></td>
        </tr>
        <tr>
<%        
      }
    
      String AGG_dis = "Non e' possibile aggiornare la tariffa perche' e' stata gia' disattivata";
      String CAN_dis = "Non e' possibile cancellare la tariffa perche' e' stata gia' disattivata";      
      String DIS_dis = "Non e' possibile disattivare la tariffa perche' e' stata gia' disattivata";            
      
      String DIS_util = "Non e' possibile disattivare una tariffa non utilizzata";
      String CAN_util = "Non e' possibile cancellare una tariffa utilizzata";      
      
      String str_nonutil = " e non utilizzata";      
     
      if (tipo_pannello.equalsIgnoreCase("AGG")) //qui di sicuro num_tar_disattive==0, quindi non lo verifico
      { //1
%>
        <td class="textB" bgcolor="<%=StaticContext.bgColorTabellaForm%>" align="center" width="50%">
        &nbsp;<%=AGG_dis%>
        </td>
<%        
      }  //1_FINE
      else if (tipo_pannello.equalsIgnoreCase("CAN"))
      {//2
        if (num_tar_disattive.intValue()==0)
        {//3
%>
                <td class="textB" bgcolor="<%=StaticContext.bgColorTabellaForm%>" align="center" width="50%">
                &nbsp;<%=CAN_dis%>
                </td>
<%
        }//3_fine
        else
        {//3else
%>
              <td class="textB" bgcolor="<%=StaticContext.bgColorTabellaForm%>" align="center" width="50%">
              &nbsp;<%=CAN_util%>
              </td>
<%
        }//3else_fine
     }//2_fine
      else // if (tipo_pannello.equalsIgnoreCase("DIS"))
      {//4
        if (num_tar_disattive.intValue()==0)
        {//5
%>
                <td class="textB" bgcolor="<%=StaticContext.bgColorTabellaForm%>" align="center" width="50%">
                &nbsp;<%=DIS_dis%>
                </td>
<%
        }//5_fine
        else
        {//5else
%>
              <td class="textB" bgcolor="<%=StaticContext.bgColorTabellaForm%>" align="center" width="50%">
              &nbsp;<%=DIS_util%>
              </td>
<%
        }//5else_fine
     }//4_fine
%>  
    <tr>
    </table> <!--TABELLA_1_FINE per apri_pannello = false-->
<%       
    }//ENDIF_APRI_PANNELLO=FALSE
    else //ELSE_APRI_PANNELLO=FALSE (qui è true)
    {
%>
    <tr>
      <td>
        <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center"> <!--TABELLA_4-->
          <tr>
            <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>"> <!--TABELLA_5-->
                <tr>
                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Oggetto di Fatturazione</td>
                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                </tr>
              </table> <!--FINE_TABELLA_5-->
            </td>   
          </tr>
        </table> <!--FINE_TABELLA_4-->
      </td>
    </tr>
    <tr>
      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="Images/pixel.gif" width="1" height='3'></td>
    </tr>


      <tr>
        <td>
          <table width="90%" border="0" cellspacing="0" cellpadding="1" align='center' > <!--TABELLA_6-->
            <tr>
             <td>
               <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaForm%>"> <!--TABELLA_7-->
                 <tr>
                   <td class="textB" align="left" width="50%">&nbsp;Tipo Contratto</td>
                   <td class="textb" align="left" width="50%">&nbsp;P/S</td>
                 </tr>
                 <tr>
                  <td class="text"  align="left" width="50%">
                  &nbsp;<%=des_tipo_contr%>&nbsp;
                  </td>
                  <td class="text" align="left" width="50%">
                  &nbsp;<%=des_PS%>&nbsp;
                  </td>
                </tr>
                <tr>
                  <td class="textB" align="left" width="50%">&nbsp;Oggetto di fatturazione</td>
<%
                  //Valeria: vedere se è giusto
//                 //System.out.println("ENTRO NELL'IF ---- desc_tipo_caus  "+ desc_tipo_caus);
                 //26-02-03
                  if ( desc_tipo_caus==null || (desc_tipo_caus!=null && (desc_tipo_caus.equalsIgnoreCase("null") || (desc_tipo_caus.equalsIgnoreCase(""))))) 
                  {
                     //se desc_tipo_opzione non è nullo, lo visualizzo
                     if (desc_tipo_opzione==null || (desc_tipo_opzione!=null && (desc_tipo_opzione.equalsIgnoreCase("null") || (desc_tipo_opzione.equalsIgnoreCase(""))))) 
                     {
                     %>
                      <td class="textB" align="left" width="50%">&nbsp;</td>                                       
                   <%}
                     else
                     {%>
                      <td class="textB" align="left" width="50%">&nbsp;Tipo opzione</td>          
                   <%}
                     //Valeria fine 12-02-03                                          
                  }
                  else
                    //27-02-03if (!desc_tipo_caus.equalsIgnoreCase(""))
                  {%>                
                      <td class="textB" align="left" width="50%">&nbsp;Causale</td>
                <%}%>                    
                  </tr>
                  <tr>
                    <td class="text" width="50%">
                    &nbsp;<%=desc_classe_of%>&nbsp;
                    </td>
<%
                    //Valeria: vedere se è giusto
                    //27-02-03if (desc_tipo_caus==null)
                  if ( desc_tipo_caus==null || (desc_tipo_caus!=null && (desc_tipo_caus.equalsIgnoreCase("null") || (desc_tipo_caus.equalsIgnoreCase(""))))) 
                  {
                     //se desc_tipo_opzione non è nullo, lo visualizzo
                     if (desc_tipo_opzione==null || (desc_tipo_opzione!=null && (desc_tipo_opzione.equalsIgnoreCase("null") || (desc_tipo_opzione.equalsIgnoreCase(""))))) 
                     {
                      //Valeria fine 12-02-03                      
%>                      
                          <td class="textB" align="left" width="50%">&nbsp;</td>
<%
                        }
                        else
                        {
%>
                         <td class="text" width="50%"> &nbsp;<%=desc_tipo_opzione%>&nbsp; </td>
<%
                        }
                    }
                    else 
                    //27-02-03 if (!desc_tipo_caus.equalsIgnoreCase(""))
                    {
                       //GI_14
//                      //System.out.println("desc_tipo_caus NON VUOTO____2");
%>                
                       <td class="text" width="50%"> &nbsp;<%=desc_tipo_caus%>&nbsp; </td>
<%
                       //GI_14_FINE
                    }
%>                    
                  </tr>
                </table> <!--FINE_TABELLA_7-->
              </td>
            </tr>
          </table> <!--FINE_TABELLA_6-->
        </td>
      </tr>
        
      <tr>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="Images/pixel.gif" width="1" height='3'></td>
      </tr>
      <tr>
        <td>
           <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center"> <!--TABELLA_8-->
            <tr>
              <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>"> <!--TABELLA_9-->
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Tariffa</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                </table> <!--FINE_TABELLA_9-->
              </td>   
            </tr>
          </table> <!--FINE_TABELLA_8-->
        </td>
      </tr>

      <tr>
       <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="Images/pixel.gif" width="1" height='3'></td>
      </tr>
      <tr>
        <td>
        <table width="90%" border="0" cellspacing="0" cellpadding="1" align='center' > <!--TABELLA_10-->
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaForm%>"> <!--TABELLA_11-->
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" align='center'> <!--TABELLA_12-->
                    <tr>
                      <td class="textB" align="left" width="17%">&nbsp;Tipo importo</td> 
                      <td class="textB" width="15%">
<%
                      if (tipo_importo.equalsIgnoreCase("F"))
                      {
                        stato_radio_fisso = true;
                        stato_radio_variabile = false;
                      }
                      else
                      {
                        stato_radio_fisso = false;
                        stato_radio_variabile = true;                        
                      }
%>
                          <input type="radio" name="rd_fisso" value = "FISSO">&nbsp;Fisso
                        </td> <!--onClick="disabilita('fisso');"  onblur="handleblur('rd_fisso');"-->
                        <td class="textB" width="23%"> 
                          <input type="radio" name="rd_variabile" value = "VARIABILE"  >&nbsp;Variabile 
                        </td> <!--onClick="disabilita('variabile');" onblur="handleblur('rd_variabile');"-->

                        <SCRIPT LANGUAGE='Javascript'>
                        //window.alert("stato radio fisso all'avvio del pannello --> "+"<%=stato_radio_fisso%>");
                        //window.alert("stato radio variabile all'avvio del pannello --> "+"<%=stato_radio_variabile%>");                        

                        document.ElabTariffaSp.rd_fisso.checked = <%=stato_radio_fisso%>;
                        document.ElabTariffaSp.rd_variabile.checked = <%=stato_radio_variabile%>;

                        Disable(document.ElabTariffaSp.rd_variabile);
                        Disable(document.ElabTariffaSp.rd_fisso);                        
                        </SCRIPT>
                        

                      <td class="textB" align="left" width="15%">&nbsp;Unita di misura
                      </td>
                      <td class="text" width="25%">
                      <%=desc_UM%>&nbsp;                         
                      </td>
                    </tr>
                  </table> <!--FINE_TABELLA_12-->
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" align='center'> <!--TABELLA_13-->
                    <tr>
                      <td class="textB" align="left" width="25%">&nbsp;Codice classe di sconto
                      </td>
                      <td class="textB" width="25%">
                      <%=code_clas_sconto%>&nbsp;                                                  
                      </td>
                      <td width="25%">
                      </td>
                      <td width="25%">
                      </td>
                    </tr>
                    <tr>
                      <td class="textB" align="left" width="25%">&nbsp;Minimo classe di Sconto
                      </td>
                      <td class="textB" width="25%">
                      <%=min_clas_sconto%>&nbsp;
                      </td>
                      <td class="textB" align="left" width="24%">&nbsp;Massimo classe di Sconto
                      </td>
                      <td class="textB" width="23%">
                      <%=max_clas_sconto%>&nbsp;
                      </td>
                    </tr>
                  </table> <!--FINE_TABELLA_13-->
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" align='center'> <!--TABELLA_14-->
                    <tr>
                      <td class="textB" align="left" width="20%">&nbsp;Descrizione tariffa
                      </td>
<%
                      if (tipo_pannello.equalsIgnoreCase("AGG")) //il campo e' texfield abilitato
                      {
%>
                        <td class="textB" width="80%"> <!--width="65%"-->
                          <input class="text" type="text" name="descrizione_tariffa" size="60%" maxlength="255" style="margin-left" 
                          value= "<%=descrizione_tariffa%>" enabled >&nbsp;   
                        </td>  
<%                                    
                      }
                      else //il campo è una label
                      {
%>
                          <td class="text" align="left" width="80%">
                          <input type="hidden" name=descrizione_tariffa id=descrizione_tariffa value=<%=descrizione_tariffa%>><!--07-03-03-->
                          <%=descrizione_tariffa%>&nbsp;                          
                          </td>                          
<%
                      }  
%>

                    </tr> 
                  </table> <!--FINE_TABELLA_14-->
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" align='center'> <!--TABELLA_15-->
<%
                  String wid;
                  if (tipo_pannello.equalsIgnoreCase("AGG"))
                    wid = "17%";
                  else 
                    wid = "13%";
%>
                    <tr>
                      <td class="textB" align="left" width="<%=wid%>">&nbsp;Importo tariffa
                      </td>
<%
                      if (tipo_pannello.equalsIgnoreCase("AGG")) //il campo e' textfield abilitato
                      {
                        /*if (importo_tariffa!=null)
                          importo_tariffa = importo_tariffa.replace('.',',');*/
%>                                  
                        <td class="textNumber" width="10%">
                          <input class="text" type="text" name="importo_tariffa" size="11" maxlength = "18" style="margin-left" 
                          value= "<%=CustomNumberFormat.setToNumberFormat(importo_tariffa,4,false,false)%>" enabled >&nbsp;
                        </td> 
                        <!--MMM 24/10/02 CustomNumberFormat.getFromNumberFormat(importo_tariffa).replace('.',',')-->
                        <!--value= "<%/*=CustomNumberFormat.setToCurrencyFormat(importo_tariffa,4)*/%>"-->
<%
                      }
                      else //il campo è una label 
                      {
%> 
                           <!--MMM 24/10/02 CustomNumberFormat.setToCurrencyFormat(importo_tariffa,4)-->   
                          <td class="text" align="left" width="10%">
                          <% String importo_tariffa_a=CustomNumberFormat.setToNumberFormat(importo_tariffa,4,false,true);%>
                          <%=importo_tariffa_a%>&nbsp;                          
                          <input type="hidden" name=importo_tariffa id=importo_tariffa value=<%=importo_tariffa%>><!--07-03-03-->
                          </td>                          
                        
<%
                      }
                      if (tipo_pannello.equalsIgnoreCase("AGG"))
                        wid = "20%";
                      else 
                        wid = "16%";

%>                                  
                      <td class="textB" align="left" width="<%=wid%>">&nbsp;Data inizio validità
                      </td> 
<%
                      if (tipo_pannello.equalsIgnoreCase("AGG")) //solo in questo caso la data inizio validita è abilitata
                      {
%>
                        <td class="textB" width="12%">
                          <input class="text" type="text" name="data_inizio_tariffa" value="<%=data_inizio_tariffa%>" size="10" 
                          maxlength="10" style="margin-left" >&nbsp;
                        </td>
                        <!--onblur="handleblur('data_inizio_tariffa');"-->
                        
                        <SCRIPT LANGUAGE='Javascript'>
                        Disable(document.ElabTariffaSp.data_inizio_tariffa);
                        </SCRIPT>

                        <td width=50%>  

                          <a href="javascript:showCalendar('ElabTariffaSp.data_inizio_tariffa','<%=data_inizio_mmdd%>');" 
                          onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true">
                          <img name='calendar_ini' src="../../common/images/body/calendario.gif" border="no"></a>                                    

                          <a href="javascript:cancelCalendar();" onMouseOver="javascript:showMessage('cancella'); return true;" 
                          onMouseOut="status='';return true"><img name='cancel_fine' src="../../common/images/body/cancella.gif" 
                          border="0"></a>   


                          

                        </td>
<%
                      }
                      else //la data inizio tariffa è mostrata come label
                      {
%>
                          <td class="text" align="left" width="9%">
                          <input type="hidden" name=data_inizio_tariffa id=data_inizio_tariffa value=<%=data_inizio_tariffa%>> <!--07-03-03-->
                          <%=data_inizio_tariffa%>&nbsp;                          
                          </td>                          
<%
                      }
//                     //System.out.println("data_fine_tariffa____1 --> "+data_fine_tariffa);
                      if (tipo_pannello.equalsIgnoreCase("DIS")) //solo in questo caso si mostra la data fine validita come editabile
                      {
%>                                  
                        <td class="textB" align="left" width="15%">&nbsp;Data fine validità
                        </td>

                        <td class="textB" width="9%">
                          <input class="text" type="text" name="data_fine_tariffa" value="<%=data_fine_tariffa%>" size="10" 
                          maxlength="10" style="margin-left"  >&nbsp;
                        </td>
                        <!--onblur="handleblur('data_fine_tariffa');"-->
                        
                        <SCRIPT LANGUAGE='Javascript'>
                        Disable(document.ElabTariffaSp.data_fine_tariffa);
                        </SCRIPT>
                        

                        <td width=50%>  

                          <a href="javascript:showCalendar('ElabTariffaSp.data_fine_tariffa','<%=data_fine_mmdd%>');" 
                          onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true">
                          <img name='calendar_ini' src="../../common/images/body/calendario.gif" border="no"></a>                                    

                          <a href="javascript:cancelCalendar();" onMouseOver="javascript:showMessage('cancella'); return true;" 
                          onMouseOut="status='';return true"><img name='cancel_fine' src="../../common/images/body/cancella.gif" 
                          border="0"></a>   

                        </td>
<%                                  
                      }
                      //Valeria inizio 17-10-02
                      else if (tipo_pannello.equalsIgnoreCase("VIS") || tipo_pannello.equalsIgnoreCase("CAN"))
                      {
                        if (data_fine_tariffa!=null && !data_fine_tariffa.equalsIgnoreCase(""))
                        {
%>
                          <td class="textB" align="left" width="16%">&nbsp;Data fine validità
                          </td> 

                          <td class="text" align="left" width="15%">
                          <%=data_fine_tariffa%>&nbsp;                          
                          </td>                          
<%                        
                        }
                        else
                        {
%>
                          <td width="31%">
<%
                        }
                      }
                      //Valeria fine 17-10-02                      
                      else
                      {
%>                                  
                        <td width="31%">
<%
                      }
%>                                  
                    </tr> 
                  </table> <!--FINE_TABELLA_15-->
                </td>
              </tr>
            </table> <!--FINE_TABELLA_11-->
          </td>
        </table> <!--FINE_TABELLA_10-->
        </td>
      </tr>
      <tr>
        <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
      </tr>
        <input type="hidden" name=cod_tipo_contr id=cod_tipo_contr value=<%=cod_tipo_contr%>>
        <!--input type="hidden" name=act id=act value="<%//=act%>"-->
        <input type="hidden" name=cod_tar id=cod_tar value="<%=cod_tar%>">
        <input type="hidden" name=prog_tar id=prog_tar value="<%=prog_tar%>">        
        <input type="hidden" name=tipo_pannello id=tipo_pannello value="<%=tipo_pannello%>">        
        <input type="hidden" name=cod_PS id=cod_PS value="<%=cod_PS%>">                
        <input type="hidden" name=cod_of id=cod_of value="<%=cod_of%>">  
        <input type="hidden" name=data_ini_val_of id=data_ini_val_of value="<%=data_ini_val_of%>">  
        <input type="hidden" name=data_ini_val_ass_ofps id=data_ini_val_ass_ofps value="<%=data_ini_val_ass_ofps%>">  
        <input type="hidden" name=nome_utente id=nome_utente value="<%=nome_utente%>">          
        <input type="hidden" name=data_inizio_tariffa_dis id=data_inizio_tariffa_dis value="<%=data_inizio_tariffa%>">                        
        <input type="hidden" name=cod_tipo_caus id=cod_tipo_caus value="<%=cod_tipo_caus%>">                                
        <input type="hidden" name=des_tipo_contr id=des_tipo_contr value="<%=des_tipo_contr%>">                                        
        <input type="hidden" name=des_PS   id= des_PS   value="<%=des_PS%>"> 
        <input type="hidden" name=hidFlagSys id=hidFlagSys value="<%=hidFlagSys%>">                                                
        <input type="hidden" name=caricaCausale id=caricaCausale value="<%=caricaCausale%>">     
        <input type="hidden" name=caricaLista id=caricaLista value="<%=caricaLista%>">          
        <input type="hidden" name=tipo_importo id=tipo_importo value="<%=tipo_importo%>">                  

<!--modifica opzioni 18-02-03 inizio-->                
        <input type="hidden" name=caricaOpzione id=caricaOpzione value="<%=caricaOpzione%>">     
        <input type="hidden" name=opzioneSelez id=opzioneSelez value="<%=opzioneSelez%>">     
<!--modifica opzioni 18-02-03 fine-->                
        

        
       
        
     </table>  <!--TABELLA_1_FINE-->
     <table width="90%" border="0" cellspacing="0" cellpadding="1" align='center' >
      <tr>
        <td>
<%
            if (tipo_pannello.equalsIgnoreCase("DIS"))
            {
%>
              <sec:ShowButtons VectorName="BOTTONI" />
<%
            }
            else if (tipo_pannello.equalsIgnoreCase("AGG"))
            {
%>
              <sec:ShowButtons PageName="ELABTARIFFASP_AGG" />    
               <Script language='javascript'>
                importo_tariffaStart="<%=importo_tariffa%>";
                if (importo_tariffaStart=="null") 
                   importo_tariffaStart="";
                else
                   importo_tariffaStart="<%=CustomNumberFormat.setToNumberFormat(importo_tariffa,4,false,false)%>";
                descrizione_tariffaStart="<%=descrizione_tariffa%>";
                if (descrizione_tariffaStart=="null") descrizione_tariffaStart="";
                data_inizio_tariffaStart="<%=data_inizio_tariffa%>";
                if (data_inizio_tariffaStart=="null") data_inizio_tariffaStart="";
                </Script>

<%
            }
            else if (tipo_pannello.equalsIgnoreCase("CAN"))
            {
%>
              <sec:ShowButtons PageName="ELABTARIFFASP_CAN" />                
<%
            }
%>

        </td>
      </tr>
    </table>
<%
    }//ENDELSE_APRI_PANNELLO=FALSE (qui è true) 
%>  
    
</form>

</BODY>
</HTML>
