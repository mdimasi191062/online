<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.usr.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*,java.util.regex.Pattern" %>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="BOTTONI" />
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3007,"Ribaltamento Listino")%>
<%=StaticMessages.getMessage(3006,"RibListinoSp.jsp")%>
</logtag:logData>
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");
String  code_ute = ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName();

String i_code_tipo_contr = null;
String i_code_cluster = null;
String i_tipo_cluster = null;
String i_code_tipo_contr_sel = null;
String i_code_cluster_sel = null;
String i_tipo_cluster_sel = null;

//INIZIO Parametri passati dal chiamante
String descTipoContratto=request.getParameter("hidDescTipoContratto");
if (descTipoContratto==null) descTipoContratto=request.getParameter("descTipoContratto");
if (descTipoContratto==null) descTipoContratto=(String)session.getAttribute("hidDescTipoContratto");
//System.out.println("descTipoContratto: "+descTipoContratto);

String codeTipoContratto=request.getParameter("codeTipoContratto");
if (codeTipoContratto==null) codeTipoContratto=request.getParameter("codiceTipoContratto");
if (codeTipoContratto==null) codeTipoContratto=(String)session.getAttribute("codiceTipoContratto");
//System.out.println("codeTipoContratto: "+codeTipoContratto);

//040203-INIZIO
String flagTipoContr=request.getParameter("flagTipoContr");
if (flagTipoContr==null) flagTipoContr=request.getParameter("flagTipoContr");
if (flagTipoContr==null) flagTipoContr=(String)session.getAttribute("flagTipoContr");
if (flagTipoContr!=null && flagTipoContr.equals("null")) flagTipoContr=null;
//040203-FINE

String codeContratto=request.getParameter("codeContratto");
if (codeContratto==null) codeContratto=request.getParameter("codeContratto");
if (codeContratto==null) codeContratto=(String)session.getAttribute("codeContratto");
if (codeContratto!=null && codeContratto.equals("null")) codeContratto=null;
//System.out.println("codeContratto: "+codeContratto);

String codeContrattoCluster=request.getParameter("codeContrattoCluster");
if (codeContrattoCluster==null) codeContrattoCluster=request.getParameter("codeContrattoCluster");
if (codeContrattoCluster==null) codeContrattoCluster=(String)session.getAttribute("codeContrattoCluster");
if (codeContrattoCluster!=null && codeContrattoCluster.equals("null")) codeContrattoCluster=null;
//System.out.println("codeContrattoCluster: "+codeContrattoCluster);

String descContratto=request.getParameter("descContratto");
if (descContratto==null) descContratto=request.getParameter("descContratto");
if (descContratto==null) descContratto=(String)session.getAttribute("descContratto");
//String descContratto=(String)session.getAttribute("descContratto");
if (descContratto!=null && descContratto.equals("null")) descContratto=null;
//System.out.println("descContratto: "+descContratto);

String progTariffa=(String)session.getAttribute("progTariffa");
if (progTariffa==null) progTariffa=request.getParameter("progTariffa");
if (progTariffa==null) progTariffa=(String)session.getAttribute("progTariffa");
if (progTariffa!=null && progTariffa.equals("null")) progTariffa=null;
//System.out.println("progTariffa: "+progTariffa);

//Listino selezionato
String selListino   = request.getParameter("selListino");
if (selListino==null) selListino=request.getParameter("selListino");
if (selListino==null) selListino=(String)session.getAttribute("selListino");
if (selListino!=null && selListino.equals("null")) selListino=null;
//System.out.println("selListino: "+selListino);

if ( selListino != null && selListino.indexOf("||") >= 0 ) {
      String[] loc_data = selListino.split(Pattern.quote( "||" ) );
      //selListino = loc_data[0];
      i_code_tipo_contr_sel = loc_data[3];
      i_code_cluster_sel = loc_data[1].trim();
      i_tipo_cluster_sel = loc_data[2].trim();
}


//codice listino
String codeListino  = request.getParameter("codeListino");
if (codeListino==null) codeListino=request.getParameter("codeListino");
if (codeListino==null) codeListino=(String)session.getAttribute("codeListino");
if (codeListino!=null && codeListino.equals("null")) codeListino=null;
//System.out.println("codeListino: "+codeListino);

if ( codeListino != null && codeListino.indexOf("||") >= 0 ) {
      String[] loc_data = codeListino.split(Pattern.quote( "||" ) );
      //codeListino = loc_data[0];
      i_code_tipo_contr = loc_data[3];
      i_code_cluster = loc_data[1].trim();
      i_tipo_cluster = loc_data[2].trim();
}

//Listini di destinazione selezionato
String selDest   = request.getParameter("selDest");
if (selDest==null) selDest=request.getParameter("selDest");
if (selDest==null) selDest=(String)session.getAttribute("selDest");
if (selDest!=null && selDest.equals("null")) selDest=null;
//System.out.println("selDest: "+selDest);


//codice Tariffa 
String codeTariffa  = request.getParameter("codeTariffa");
if (codeTariffa==null) codeTariffa=request.getParameter("codeTariffa");
if (codeTariffa==null) codeTariffa=(String)session.getAttribute("codeTariffa");
if (codeTariffa!=null && codeTariffa.equals("null")) codeTariffa=null;
//System.out.println("codeTariffa: "+codeTariffa);

//descrizione Tariffa 
String descTariffa  = request.getParameter("descTariffa");
if (descTariffa==null) descTariffa=request.getParameter("descTariffa");
if (descTariffa==null) descTariffa=(String)session.getAttribute("descTariffa");
if (descTariffa!=null && descTariffa.equals("null")) descTariffa=null;
//System.out.println("descTariffa: "+descTariffa);

//codice listino di Destinazione
String codeListDest  = request.getParameter("codeListDest");
if (codeListDest==null) codeListDest=request.getParameter("codeListDest");
if (codeListDest==null) codeListDest=(String)session.getAttribute("codeListDest");
if (codeListDest!=null && codeListDest.equals("null")) codeListDest=null;
//System.out.println("codeListDest: "+codeListDest);
if ("x".equals(codeListDest)) { codeListDest = ""; }

//numero account ver fatt
String numFatt  = request.getParameter("numFatt");
if (numFatt==null) numFatt=request.getParameter("numFatt");
if (numFatt==null) numFatt=(String)session.getAttribute("numFatt");
if (numFatt!=null && numFatt.equals("null")) numFatt=null;
//System.out.println("numFatt: "+numFatt);


String numElab  = request.getParameter("numElab");
if (numElab==null) numElab=request.getParameter("numElab");
if (numElab==null) numElab=(String)session.getAttribute("numElab");
if (numElab!=null && numElab.equals("null")) numElab=null;
//System.out.println("numElab: "+numElab);


String act=request.getParameter("act");
if (act==null) act=request.getParameter("act");
if (act==null) act=(String)session.getAttribute("act");
if (act!=null && act.equals("null")) act=null;
//System.out.println("act: "+act);

String messaggio_alert=(String)session.getAttribute("messaggio_alert");

//040203-inizio
String act_1=request.getParameter("act_1");
if (act_1==null) act_1=request.getParameter("act_1");
if (act_1==null) act_1=(String)session.getAttribute("act_1");
if (act_1!=null && act_1.equals("null")) act_1=null;
//040203-fine

String Tar = request.getParameter("Tar");
if (Tar==null) Tar=request.getParameter("Tar");
if (Tar==null) Tar=(String)session.getAttribute("Tar");
if (Tar!=null && Tar.equals("null")) Tar=null;
//System.out.println("Tar: "+Tar);

String button = request.getParameter("button");
if (button==null) button=request.getParameter("button");
if (button==null) button=(String)session.getAttribute("button");
if (button!=null && button.equals("null")) button=null;
//System.out.println("button: "+button);

String numTar = request.getParameter("numTar");
if (numTar==null) numTar=request.getParameter("numTar");
if (numTar==null) numTar=(String)session.getAttribute("numTar");
if (numTar!=null && numTar.equals("null")) numTar=null;
//System.out.println("numTar: "+numTar);

String flgIns = request.getParameter("flgIns");
if (flgIns==null) flgIns=request.getParameter("flgIns");
if (flgIns==null) flgIns=(String)session.getAttribute("flgIns");
if (flgIns!=null && flgIns.equals("null")) flgIns=null;
//System.out.println("flgIns: "+flgIns);

String flgCancTariffe_ins = request.getParameter("flgCancTariffe_ins");
if (flgCancTariffe_ins==null) flgCancTariffe_ins=request.getParameter("flgCancTariffe_ins");
if (flgCancTariffe_ins==null) flgCancTariffe_ins=(String)session.getAttribute("flgCancTariffe_ins");
if (flgCancTariffe_ins!=null && flgCancTariffe_ins.equals("null")) flgCancTariffe_ins=null;
//System.out.println("flgCancTariffe_ins: "+flgCancTariffe_ins);


String numTar_ins = request.getParameter("numTar_ins");
if (numTar_ins==null) numTar_ins=request.getParameter("numTar_ins");
if (numTar_ins==null) numTar_ins=(String)session.getAttribute("numTar_ins");
if (numTar_ins!=null && numTar_ins.equals("null")) numTar_ins=null;
//System.out.println("numTar_ins: "+numTar_ins);


//codice listino Listino
String codeListinoListino  = request.getParameter("codeListinoListino");
if (codeListinoListino==null) codeListinoListino=request.getParameter("codeListinoListino");
if (codeListinoListino==null) codeListinoListino=(String)session.getAttribute("codeListinoListino");
if (codeListinoListino!=null && codeListinoListino.equals("null")) codeListinoListino=null;

//codeClusterListino
String codeClusterListino  = request.getParameter("codeClusterListino");
if (codeClusterListino==null) codeClusterListino=request.getParameter("codeClusterListino");
if (codeClusterListino==null) codeClusterListino=(String)session.getAttribute("codeClusterListino");
if (codeClusterListino!=null && codeClusterListino.equals("null")) codeClusterListino=null;

//tipoClusterListino
String tipoClusterListino  = request.getParameter("tipoClusterListino");
if (tipoClusterListino==null) tipoClusterListino=request.getParameter("tipoClusterListino");
if (tipoClusterListino==null) tipoClusterListino=(String)session.getAttribute("tipoClusterListino");
if (tipoClusterListino!=null && tipoClusterListino.equals("null")) tipoClusterListino=null;

//codeTipoContrListino
String codeTipoContrListino  = request.getParameter("codeTipoContrListino");
if (codeTipoContrListino==null) codeTipoContrListino=request.getParameter("codeTipoContrListino");
if (codeTipoContrListino==null) codeTipoContrListino=(String)session.getAttribute("codeTipoContrListino");
if (codeTipoContrListino!=null && codeTipoContrListino.equals("null")) codeTipoContrListino=null;

//selDestCluster
String selDestCluster   = request.getParameter("selDestCluster");
if (selDestCluster==null) selDestCluster=request.getParameter("selDestCluster");
if (selDestCluster==null) selDestCluster=(String)session.getAttribute("selDestCluster");
if (selDestCluster!=null && selDestCluster.equals("null")) selDestCluster=null;
//System.out.println("selDestCluster: "+selDestCluster);

//codice listino di Destinazione
String codeListDestCluster  = request.getParameter("codeListDestCluster");
if (codeListDestCluster==null) codeListDestCluster=request.getParameter("codeListDestCluster");
if (codeListDestCluster==null) codeListDestCluster=(String)session.getAttribute("codeListDestCluster");
if (codeListDestCluster!=null && codeListDestCluster.equals("null")) codeListDestCluster=null;
//System.out.println("codeListDestCluster: "+codeListDestCluster);
if ("x".equals(codeListDestCluster)) { codeListDestCluster = ""; }


String selProdottoCluster = request.getParameter("selProdottoCluster");
if (selProdottoCluster==null) selProdottoCluster=request.getParameter("selProdottoCluster");
if (selProdottoCluster==null) selProdottoCluster=(String)session.getAttribute("selProdottoCluster");
if (selProdottoCluster!=null && selProdottoCluster.equals("null")) selProdottoCluster=null;

String codeListProdottoCluster = request.getParameter("codeListProdottoCluster");
if (codeListProdottoCluster==null) codeListProdottoCluster=request.getParameter("codeListProdottoCluster");
if (codeListProdottoCluster==null) codeListProdottoCluster=(String)session.getAttribute("codeListProdottoCluster");
if (codeListProdottoCluster!=null && codeListProdottoCluster.equals("null")) codeListProdottoCluster=null;

String Insert = request.getParameter("Insert");
if (Insert!=null && Insert.equals("null")) Insert=null;
//System.out.println("Insert: "+Insert);

Collection Listini = (Collection) session.getAttribute("Listini"); //per il caricamento della lista Combo
Collection Tariffe = (Collection) session.getAttribute("Tariffe"); //per il caricamento della lista delle Tariffe
Collection Tariffe_copia = (Collection) session.getAttribute("Tariffe_copia"); //per il caricamento della lista delle Tariffe  
Collection Tariffe_ins = (Collection) session.getAttribute("Tariffe_ins"); //per il caricamento della lista delle Tariffe  
boolean resetta=false;

if (act == null) 
{
    codeListino = "";
    codeListinoListino = "";
    codeListDest = "";
    act = "A";
    flgIns = "NOINS";
    /* La prima volta che viene richiamata la pagina */
    flgCancTariffe_ins = "SI";
    act = "B";
//    codeListino="19";
//    selListino ="19";
}

BatchElem  datiBatch=null;//040203

//dal pannello chiamato
Collection Tariffe_ins_appo = (Collection) session.getAttribute("Tariffe_ins_appo"); //per il caricamento della lista delle Tariffe  
Collection Tariffe_appo = (Collection) session.getAttribute("Tariffe_appo"); //per il caricamento della lista delle Tariffe  
//System.out.println("inizio Tariffe: "+Tariffe);
//System.out.println("inizio Tariffe_ins: "+Tariffe_ins);
//System.out.println("inizio Tariffe_ins_appo: "+Tariffe_ins_appo);
//System.out.println("inizio Tariffe_appo: "+Tariffe_appo);

//FINE

// Lettura dell'indice Combo Numero Record
int index = 0;
String strIndex = request.getParameter("txtnumRec");

//System.out.println(strIndex);

if (strIndex!=null)
  {
   Integer tmpindext=new Integer(strIndex);
   index=tmpindext.intValue();
  }
// Lettura del Numero di record per pagina (default 5)
int records_per_page=5;
String strNumRec = request.getParameter("numRec");
if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }

// Lettura tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=1 Fare query (default)
// typeLoad=0 Variabile session
int typeLoad = 0;
String strtypeLoad = request.getParameter("typeLoad");
if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }

String strComboListino = request.getParameter("comboListino");
String strComboDestination = request.getParameter("comboDestination");
String strComboCluster = request.getParameter("comboCluster");
String strComboProdottiCluster = request.getParameter("comboProdottiCluster");

if (strComboListino != null && strComboListino != "")
{
 String tmpComboListino = strComboListino;
 if (!strComboListino.equals("-1"))
      selListino = strComboListino;
 else
      selListino = "";
}

if (strComboDestination != null && strComboDestination != "")
{
 String tmpComboDestination = strComboDestination;
 if (!strComboDestination.equals("-1"))
      selDest = strComboDestination;
 else
      selDest = "x";
}

if (strComboCluster != null && strComboCluster != "")
{
 String tmpComboCluster = strComboCluster;
 if (!strComboCluster.equals("-1"))
      selDestCluster = strComboCluster;
 else
      selDestCluster = "x";
}

if (strComboProdottiCluster != null && strComboProdottiCluster != "")
{
 String tmpComboProdottiCluster = strComboProdottiCluster;
 if (!strComboProdottiCluster.equals("-1"))
      selProdottoCluster = strComboProdottiCluster;
 else
      selProdottoCluster = "";
}


%>
<EJB:useHome id="homeTariffa" type="com.ejbBMP.TariffaBMPHome" location="TariffaBMP" />
<EJB:useHome id="homeDatiCli" type="com.ejbBMP.DatiCliBMPHome" location="DatiCliBMP" />

<EJB:useHome id="homeBatch" type="com.ejbSTL.BatchSTLHome" location="BatchSTL" />
<EJB:useBean id="remoteBatch" type="com.ejbSTL.BatchSTL" value="<%=homeBatch.create()%>" scope="session"></EJB:useBean>

<%
if (typeLoad==0)
   {
    datiBatch=remoteBatch.getCodeFunzFlag(codeTipoContratto,"VN",null,"S");
     if (datiBatch!=null) 
         flagTipoContr=  (new Integer(datiBatch.getFlagTipoContr())).toString();  ;
    }
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE> Ribaltamento Listino </TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
  <script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<SCRIPT LANGUAGE='Javascript'>
IExplorer = document.all?true:false;
Navigator = document.layers?true:false;

var SelCodeTariffa = "";
var SelProgTariffa = "";
var Insert = "";

/*function submitFrmSearch(typeLoad)
{
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.typeLoad.value=typeLoad;
  submitME();
}*/

function submitFrmSearch(typeLoad)
{
    if ((document.frmSearch.selListino.value!=-1) && (document.frmSearch.selListino.value!="null") && (document.frmSearch.Tar.value=="1") )
    {
      document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
      document.frmSearch.typeLoad.value=typeLoad;
      //document.frmSearch.submit();
      submitME();
    }  
    else
    {
      alert("Popolare la Lista Tariffe");
      document.frmSearch.numRec.selectedIndex=0;
    }  
}


function submitME()
{

  orologio.style.visibility='visible';
  orologio.style.display='inline';

  maschera.style.visibility='hidden';
  maschera.style.display='none';

  document.frmSearch.submit();
}

 function setInitialValue()
 {
  Disable(document.frmSearch.INSERISCI_SEL); 
 
  if ( 2 >document.frmSearch.comboListini.length )
    Disable(document.frmSearch.comboListini);
  if (  2 >  document.frmSearch.comboDestination.length)
    Disable(document.frmSearch.comboDestination);
  if (  2 >  document.frmSearch.comboCluster.length)
    Disable(document.frmSearch.comboCluster);
  if (  2 >  document.frmSearch.comboProdottiCluster.length)
    Disable(document.frmSearch.comboProdottiCluster);
  
    
  if (document.frmSearch.act.value=="null"||
      document.frmSearch.act.value=="")
      document.frmSearch.act.value="A";

  //Setta il numero di record  
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
  
  //Setta il primo elemento della lista
  if (String(document.frmSearch.SelCodeTariffa)!="undefined")
  {
    if (document.frmSearch.SelCodeTariffa.lenght=="undefined")
    {
      //document.frmSearch.SelCodeTariffa.checked=true; 
    }
    else
    {
      /*if (document.frmSearch.SelCodeTariffa[1])
      {
         document.frmSearch.SelCodeTariffa[0].checked=true;
         SelCodeTariffa = document.frmSearch.SelCodeTariffa[0].value;
         SelProgTariffa = document.frmSearch.SelProgTariffa[0].value;
         document.frmSearch.codeTariffa.value = document.frmSearch.SelCodeTariffa[0].value;
         document.frmSearch.progTariffa.value = document.frmSearch.SelProgTariffa[0].value;
      }
      else   
      {
         SelCodeTariffa = document.frmSearch.SelCodeTariffa.value;
         SelProgTariffa = document.frmSearch.SelProgTariffa.value; 
         document.frmSearch.codeTariffa.value = document.frmSearch.SelCodeTariffa.value;         
         document.frmSearch.progTariffa.value = document.frmSearch.SelProgTariffa.value; 
      }*/
    }
  }

   if (document.frmSearch.comboListini[document.frmSearch.comboListini.selectedIndex].value==-1)
   {
       Disable(document.frmSearch.comboDestination);
       Disable(document.frmSearch.comboCluster);
       Disable(document.frmSearch.comboProdottiCluster);
       
       document.frmSearch.comboDestination[document.frmSearch.comboDestination.selectedIndex].value = -1;
       document.frmSearch.comboCluster[document.frmSearch.comboCluster.selectedIndex].value = -1;
       document.frmSearch.comboProdottiCluster[document.frmSearch.comboProdottiCluster.selectedIndex].value = -1;
       document.frmSearch.selDest.value = "x";
       document.frmSearch.selDestCluster.value = "x";
       document.frmSearch.selProdottoCluster.value = "";
       document.frmSearch.flgIns.value = "NOINS";
   }
   else
   {
       Enable(document.frmSearch.comboDestination);
       Enable(document.frmSearch.comboCluster);
       Enable(document.frmSearch.comboProdottiCluster);
   }

   //Disabilito i bottoni
   if (document.frmSearch.Tar.value == null || 
       document.frmSearch.Tar.value == "0" ||
       document.frmSearch.Tar.value == "null")
   {
       Disable(document.frmSearch.INSERISCI_SEL); 
       Disable(document.frmSearch.INSERISCI_TUTTI); 
       Disable(document.frmSearch.RIEPILOGO); 
   }
   else
      if (document.frmSearch.Tar.value == "1")
      {
          //Enable(document.frmSearch.INSERISCI_SEL); 
          Enable(document.frmSearch.INSERISCI_TUTTI); 
          
      }

    //bottone CONFERMA
      if ( document.frmSearch.comboListini[document.frmSearch.comboListini.selectedIndex].value != -1 &&
           ( document.frmSearch.comboDestination[document.frmSearch.comboDestination.selectedIndex].value != -1 || document.frmSearch.comboCluster[document.frmSearch.comboCluster.selectedIndex].value != -1)
           &&
//           document.frmSearch.numFatt.value == 0 &&
           document.frmSearch.numTar_ins.value != 0)
      {     
           Enable(document.frmSearch.CONFERMA);
      }
      else
      {
           Disable(document.frmSearch.CONFERMA);           
      }
      
    //bottone RIEPILOGO
                  
      if (document.frmSearch.numTar.value == "0")    
      {
          Disable(document.frmSearch.INSERISCI_SEL);
          Disable(document.frmSearch.INSERISCI_TUTTI);
          Disable(document.frmSearch.RIEPILOGO); 
      }

      if (document.frmSearch.numTar_ins.value == "null" || document.frmSearch.numTar_ins.value == "0") 
      {    
          Disable(document.frmSearch.RIEPILOGO);
      }    
      else if (document.frmSearch.numTar_ins.value > "0" )
               Enable(document.frmSearch.RIEPILOGO);  
               
      
      if (document.frmSearch.comboListini.value != null && document.frmSearch.comboListini.value != -1)
      {
          document.frmSearch.selListino.value = document.frmSearch.comboListini[document.frmSearch.comboListini.selectedIndex].value;
          document.frmSearch.codeListino.value = document.frmSearch.comboListini[document.frmSearch.comboListini.selectedIndex].value;
      }

      if (document.frmSearch.comboDestination.value != null && document.frmSearch.comboDestination.value != -1)
      {
          document.frmSearch.selDest.value = document.frmSearch.comboDestination[document.frmSearch.comboDestination.selectedIndex].value;
          document.frmSearch.codeListDest.value = document.frmSearch.comboDestination[document.frmSearch.comboDestination.selectedIndex].value;       
      }

      if (document.frmSearch.comboCluster.value != null && document.frmSearch.comboCluster.value != -1)
      {
          document.frmSearch.selDestCluster.value = document.frmSearch.comboCluster[document.frmSearch.comboCluster.selectedIndex].value;
          document.frmSearch.codeListDestCluster.value = document.frmSearch.comboCluster[document.frmSearch.comboCluster.selectedIndex].value;       
      }

      //se il numFatt è diverso da 0 imposta la combo con [Seleziona Opzione]
//      if (document.frmSearch.numFatt.value != null &&
//          document.frmSearch.numFatt.value != "null" && 
//          document.frmSearch.numFatt.value != "0")
//      {
//          document.frmSearch.comboDestination.value = -1;
//          document.frmSearch.comboDestination[document.frmSearch.comboDestination.selectedIndex].value = -1;
//          document.frmSearch.selDest.value = document.frmSearch.comboDestination[document.frmSearch.comboDestination.selectedIndex].value;
//      }

      if (document.frmSearch.act.value != "CONFERMA_ELIM" )
          document.frmSearch.act.value = "B";
      if (document.frmSearch.numTar.value == "0")    
          document.frmSearch.act.value = "C";      

        document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;

 }
 
function ChangeSel(SelCodeTariffa,SelProgTariffa)
{
  /*document.frmSearch.SelCodeTariffa.value = SelCodeTariffa;
  document.frmSearch.SelProgTariffa.value = SelProgTariffa;
  document.frmSearch.codeTariffa.value = SelCodeTariffa;
  document.frmSearch.progTariffa.value = SelProgTariffa;
  */
    Disable(document.frmSearch.INSERISCI_SEL);
    if(document.frmSearch.SelCodeTariffa.length==null){
         if(document.frmSearch.SelCodeTariffa.checked){
            Enable(document.frmSearch.INSERISCI_SEL);
         }
    } else {
           for (i=0 ; i < document.frmSearch.SelCodeTariffa.length ; i++){
             if(document.frmSearch.SelCodeTariffa[i].checked){
                Enable(document.frmSearch.INSERISCI_SEL);
             }
           }
    }
  
  //window.alert("SelDescTariffa: "+document.frmSearch.descTariffa.value);
}

function change_cboListinoPartenza() {
 if (document.frmSearch.comboListini[document.frmSearch.comboListini.selectedIndex].value == -1) {
   //alert ( 'disabilito');
          Disable(document.frmSearch.comboDestination);
          Disable(document.frmSearch.comboCluster);
          Disable(document.frmSearch.comboProdottiCluster);
 } else {
   //alert ( 'abilito' );
        Enable(document.frmSearch.comboDestination);
        Enable(document.frmSearch.comboCluster);
        Enable(document.frmSearch.comboProdottiCluster);
 }

alert('valore '+document.frmSearch.comboListini[document.frmSearch.comboListini.selectedIndex].value);
   document.frmSearch.selListino.value=document.frmSearch.comboListini[document.frmSearch.comboListini.selectedIndex].value;
   document.frmSearch.codeListino.value=document.frmSearch.comboListini[document.frmSearch.comboListini.selectedIndex].value;   

}

function scegliListino()
{

   document.frmSearch.comboDestination.value = -1;
   document.frmSearch.comboDestination[document.frmSearch.comboDestination.selectedIndex].value = -1;
   document.frmSearch.selDest.value = document.frmSearch.comboDestination[document.frmSearch.comboDestination.selectedIndex].value;
   document.frmSearch.codeListDest.value =  document.frmSearch.comboDestination[document.frmSearch.comboDestination.selectedIndex].value;

   document.frmSearch.comboCluster.value = -1;
   document.frmSearch.comboCluster[document.frmSearch.comboCluster.selectedIndex].value = -1;
   document.frmSearch.selDestCluster.value = document.frmSearch.comboCluster[document.frmSearch.comboCluster.selectedIndex].value;
   document.frmSearch.codeListDestCluster.value =  document.frmSearch.comboCluster[document.frmSearch.comboCluster.selectedIndex].value;

   document.frmSearch.comboProdottiCluster.value = -1;
   document.frmSearch.comboProdottiCluster[document.frmSearch.comboProdottiCluster.selectedIndex].value = -1;
   document.frmSearch.selProdottoCluster.value = document.frmSearch.comboProdottiCluster[document.frmSearch.comboProdottiCluster.selectedIndex].value;
   document.frmSearch.codeListProdottoCluster.value =  document.frmSearch.comboProdottiCluster[document.frmSearch.comboProdottiCluster.selectedIndex].value;

   if (document.frmSearch.comboListini[document.frmSearch.comboListini.selectedIndex].value == -1)
   {
       document.frmSearch.act.value = "A";
       document.frmSearch.Tar.value = "0";
            
   }
   else
   {
       document.frmSearch.act.value = "B";
       document.frmSearch.flgCancTariffe_ins.value = "SI";
   }    
   document.frmSearch.selListino.value=document.frmSearch.comboListini[document.frmSearch.comboListini.selectedIndex].value;
   document.frmSearch.codeListino.value=document.frmSearch.comboListini[document.frmSearch.comboListini.selectedIndex].value;   
   
     var str = document.frmSearch.selListino.value;
     if ( str.indexOf("||") >= 0  && str.length >= 4) {
         var res = str.split("||");
         document.frmSearch.codeClusterListino.value = res[1];
         document.frmSearch.tipoClusterListino.value = res[2];
         document.frmSearch.codeTipoContrListino.value = res[3];
         document.frmSearch.codeListinoListino.value = res[0];
     }
     
   //document.frmSearch.submit();
   submitME();
}

function scegliListDest()
{

/*PAS*/document.frmSearch.flgCancTariffe_ins.value = "SI";

  document.frmSearch.act_1.value = document.frmSearch.act.value; //040202
//  document.frmSearch.act.value = "LISTINO_DEST";
  document.frmSearch.act.value = "B";
  document.frmSearch.selDest.value=document.frmSearch.comboDestination[document.frmSearch.comboDestination.selectedIndex].value;
  document.frmSearch.codeListDest.value=document.frmSearch.comboDestination[document.frmSearch.comboDestination.selectedIndex].value;   
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
   if (document.frmSearch.selDest.value != null && document.frmSearch.selDest.value != ""){
       //document.frmSearch.submit();
       submitME();
    }
}

function scegliListClus()
{

/*PAS*/document.frmSearch.flgCancTariffe_ins.value = "SI";

  document.frmSearch.act_1.value = document.frmSearch.act.value;
  document.frmSearch.act.value = "B";
  document.frmSearch.selDestCluster.value=document.frmSearch.comboCluster[document.frmSearch.comboCluster.selectedIndex].value;
  document.frmSearch.codeListDestCluster.value=document.frmSearch.comboCluster[document.frmSearch.comboCluster.selectedIndex].value;   
   if (document.frmSearch.selDestCluster.value != null && document.frmSearch.selDestCluster.value != "") {
       //document.frmSearch.submit();
       submitME();
    }
}

function scegliProdottoClus()
{
  document.frmSearch.act_1.value = document.frmSearch.act.value;
  //document.frmSearch.act.value = "B";
/*PAS*/document.frmSearch.act.value = "REFRESH";
  document.frmSearch.selProdottoCluster.value=document.frmSearch.comboProdottiCluster[document.frmSearch.comboProdottiCluster.selectedIndex].value;
  document.frmSearch.codeListProdottoCluster.value=document.frmSearch.comboProdottiCluster[document.frmSearch.comboProdottiCluster.selectedIndex].value;   
   if (document.frmSearch.selProdottoCluster.value != null && document.frmSearch.selProdottoCluster.value != "") {
       //document.frmSearch.submit();
       submitME();
    }
}


 function ONINSERISCI_SEL()
 {
   document.frmSearch.act.value = "INSERISCI_SEL";
   document.frmSearch.Insert.value = "SEL";
   if ((document.frmSearch.Tar.value == "0" ||
        document.frmSearch.Tar.value == "null")||
       (document.frmSearch.numTar.value == "0" ||
        document.frmSearch.numTar.value == "null"))
        alert("Nessuna tariffa presente");      
   else
   {
       if (document.frmSearch.numTar.value=="1")
           document.frmSearch.numRec.selectedIndex=0;   
       //SPLIT CHECKBOX
       //document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
       if(document.frmSearch.SelCodeTariffa.length==null){
            document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
            document.frmSearch.codeTariffa.value = document.frmSearch.SelCodeTariffa.value;
       } else {
           document.frmSearch.codeTariffa.value = "";
           for (i=0 ; i < document.frmSearch.SelCodeTariffa.length ; i++){
             if(document.frmSearch.SelCodeTariffa[i].checked){
                document.frmSearch.txtnumRec.value = document.frmSearch.numRec.selectedIndex;
                document.frmSearch.codeTariffa.value = document.frmSearch.SelCodeTariffa[i].value + ";" + document.frmSearch.codeTariffa.value;
             }
           }
       }
       //FINR SPLIT CHECKBOX
       document.frmSearch.flgIns.value="INS";    
       //document.frmSearch.submit();  
       submitME();
   }
 }

 function ONINSERISCI_TUTTI()
 {
    document.frmSearch.act.value = "INSERISCI_TUTTI";
    document.frmSearch.Insert.value = "TUTTI";
    if ((document.frmSearch.Tar.value == "0" ||
         document.frmSearch.Tar.value == "null")||
        (document.frmSearch.numTar.value == "0" ||
         document.frmSearch.numTar.value == "null"))
         alert("Nessuna tariffa presente");
    else
    {
document.frmSearch.numRec.selectedIndex=0;   
document.frmSearch.txtnumRec.value=0;
document.frmSearch.Tar.value=0;
       document.frmSearch.flgIns.value="INS";
       //document.frmSearch.submit();
       submitME();
    }
 }

 function ONRIEPILOGO()
 {
  if ((document.frmSearch.numTar_ins.value == "0" ||
       document.frmSearch.numTar_ins.value == "null")||
       document.frmSearch.flgIns.value == "NOINS")
  {
       alert("Nessuna tariffa selezionata");
  }
  else
     {
      document.frmSearch.act.value = "RIEPILOGO";    
      descTipoContratto = document.frmSearch.descTipoContratto.value;
      
      // questo è il codice 
      
      descContratto =document.frmSearch.comboListini.options[document.frmSearch.comboListini.selectedIndex].text;
      Insert = document.frmSearch.Insert.value;
      var EliminaTariffeSp = "../../ribaltamento_listino/jsp/EliminaTariffeSp.jsp?Insert="+Insert+"&descTipoContratto="+descTipoContratto+"&descContratto="+descContratto;
      openDialog(EliminaTariffeSp, 780, 480, handleReturnedValuePS);
      handleReturnedValuePS();
     }
 }

 function handleReturnedValuePS()
 {
   if (document.frmSearch.act.value == "CONFERMA_ELIM")
       submitME();
 }

 function ONCONFERMA()
 {
     if (document.frmSearch.comboListini[document.frmSearch.comboListini.selectedIndex].value == -1)
         alert('Selezionare un listino di origine');           
     else
        if (document.frmSearch.comboDestination[document.frmSearch.comboDestination.selectedIndex].value == -1 && document.frmSearch.comboCluster[document.frmSearch.comboCluster.selectedIndex].value == -1)
            alert('Selezionare un listino di destinazione');           
        else
              if (document.frmSearch.numTar_ins.value == "0")
                  alert('Nessuna tariffa inserita');
              else
              {
                if (confirm("Si conferma il ribaltamento del listino ?"))
                  {
                         document.frmSearch.act.value = "CONFERMA";
                         document.frmSearch.action = '<%=request.getContextPath()%>/servlet/ListinoCntl';
                         //document.frmSearch.submit();
                         submitME();
                 }
              }
 }

 function ONANNULLA()
 {
    /*document.frmSearch.act.value = "null";
    document.frmSearch.Tar.value = "0";
    document.frmSearch.codeListino.value = "";
    document.frmSearch.selListino.value = "";
    document.frmSearch.codeListDest.value = "x";
    document.frmSearch.numTar_ins.value = "0";
    document.frmSearch.numFatt.value = "0";
    document.frmSearch.txtnumRec.value="0";*/

document.frmSearch.txtnumRec.value="0";
document.frmSearch.codeContratto.value="null";
document.frmSearch.codeContrattoCluster.value="null";
document.frmSearch.descContratto.value="null";
document.frmSearch.progTariffa.value="null";
document.frmSearch.selListino.value="null";
document.frmSearch.codeListino.value="null";
document.frmSearch.selDest.value="null";
document.frmSearch.codeTariffa.value="null";
document.frmSearch.descTariffa.value="null";
document.frmSearch.codeListDest.value="null";
document.frmSearch.numFatt.value="null";
document.frmSearch.numElab.value="null";
document.frmSearch.act.value="null";
document.frmSearch.act_1.value="null"; //040203
document.frmSearch.Tar.value="null";
document.frmSearch.button.value="null";
document.frmSearch.numTar.value="null";
document.frmSearch.flgIns.value="null";
document.frmSearch.flgCancTariffe_ins.value="null";
document.frmSearch.numTar_ins.value="null";
document.frmSearch.Insert.value="null";

document.frmSearch.selDestCluster.value="null";
document.frmSearch.codeListDestCluster.value="null";
    
    submitME();
 }


</SCRIPT>
</HEAD>
<BODY onload="setInitialValue();">

<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div name="orologio" id="orologio" style="visibility:hidden;display:none">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div name="maschera" id="maschera" style="visibility:display;display:inline">

<%

boolean flg_ListinoStandard=false;
boolean flg_ListinoContr=false;
boolean flg_ListinoCluster=false;
boolean flg_ListinoClusterPers=false;

boolean flg_Gestore=false;
boolean flg_Cluster=false;
boolean flg_ClusterPers=false;

   if (typeLoad!=0)
   {
     Tariffe = (Collection) session.getAttribute("Tariffe");
     Tariffe_copia = (Collection) session.getAttribute("Tariffe_copia");
   }
   else
   {
       if (/*codeListino*/ codeListinoListino != null &&
          (act != null && (act.equalsIgnoreCase("A")||
                           act.equalsIgnoreCase("B")||
                           act.equalsIgnoreCase("REFRESH"))))
       {
       
          flg_ListinoStandard    = false;
          flg_ListinoContr       = false;
          flg_ListinoCluster     = false;
          flg_ListinoClusterPers = false;
          String[] loc_scelta = codeListino.split(Pattern.quote( "||" ) );
          if (codeListinoListino.equals("0"))                                                                 flg_ListinoStandard = true;
          if (!codeListinoListino.equals("0") && !codeListino.equals("") &&
              codeListino.indexOf("||") >= 0 && loc_scelta.length > 0 && loc_scelta[1].trim().equals(""))     flg_ListinoContr = true;
          if (codeListinoListino.equals("") && !codeListino.equals("") && codeListino.indexOf("||") == 0 )    flg_ListinoCluster = true;
          if (!codeListinoListino.equals("0") && !codeListino.equals("") && codeListino.indexOf("||") > 0 && 
              !loc_scelta[0].equals("") && !loc_scelta[1].equals(""))                                         flg_ListinoClusterPers = true;
          
          
          if( flg_ListinoStandard || flg_ListinoContr || flg_ListinoCluster || flg_ListinoClusterPers ) {
          
            flg_Gestore = false;
            if ((codeListDest != null ) && ( !codeListDest.equals("") ) && ( !codeListDest.equals("x") ) && (!codeListDest.equals("-1"))) {
                flg_Gestore = true;
            }
            
            flg_Cluster = false;
            if ((codeListDestCluster != null ) && ( !codeListDestCluster.equals("") ) && ( !codeListDestCluster.equals("x") ) && (!codeListDestCluster.equals("-1")) && codeListDestCluster.substring(0,2).equals("||")) {
                flg_Cluster = true;
            }
            
            flg_ClusterPers = false;
            if ((codeListDestCluster != null ) && ( !codeListDestCluster.equals("") ) && ( !codeListDestCluster.equals("x") ) && (!codeListDestCluster.equals("-1")) && !codeListDestCluster.substring(0,2).equals("||")) {
                flg_ClusterPers = true;
            }
            
            if (flg_ListinoStandard) {

                    // CASO STANDARD : GESTORE SI , CLUSTER NO
                    if ( flg_Gestore == true && flg_Cluster == false && flg_ClusterPers == false ) {
                        if ( !"54".equals(i_code_tipo_contr) && !"55".equals(i_code_tipo_contr) && !"56".equals(i_code_tipo_contr) ) {
                            Tariffe = homeTariffa.findTariffaUnicoXRib(codeTipoContratto, codeListDest);
                        } else {
                            Tariffe = new Vector();
                            %>
                               <SCRIPT LANGUAGE='Javascript'>alert("Combinazione non consentita");</SCRIPT> 
                            <%
                        }
                    
                    // CASO STANDARD : GESTORE NO , CLUSTER SI         SOLO CLUSTER
                    } else if ( flg_Gestore == false && flg_Cluster == true && flg_ClusterPers == false ) {
                        //Tariffe = homeTariffa.findTariffaUnicoXRib(codeTipoContratto);
                        String[] loc_data2 = codeListDestCluster.split(Pattern.quote( "||" ) );
                        Tariffe = homeTariffa.findTariffaUnicoXRib(codeTipoContratto, "",loc_data2[1],loc_data2[2],selProdottoCluster);
                    
                    // CASO STANDARD : GESTORE NO , CLUSTER PERSONALIZZATO SI    
                    } else if ( flg_Gestore == false && flg_Cluster == false && flg_ClusterPers == true ) {
                        //Tariffe = new Vector(); // NON CONSENTITO
                        String[] loc_data2 = codeListDestCluster.split(Pattern.quote( "||" ) );
                        Tariffe = homeTariffa.findTariffaUnicoXRib(codeTipoContratto, loc_data2[0],loc_data2[1],loc_data2[2],selProdottoCluster);
                    
                    // CASO STANDARD : GESTORE SI , CLUSTER PERSONALIZZATO SI    
                    } else if ( flg_Gestore == true && flg_Cluster == false && flg_ClusterPers == true ) {
                        /*//Tariffe = homeTariffa.findTariffaUnicoXRib(codeTipoContratto, codeListDest);
                        String[] loc_data2 = codeListDestCluster.split(Pattern.quote( "||" ) );
                        Tariffe = homeTariffa.findTariffaUnicoXRib(codeTipoContratto, codeListDest,loc_data2[1],loc_data2[2]);*/
                        Tariffe = new Vector();
                        %>
                           <SCRIPT LANGUAGE='Javascript'>alert("Combinazione non consentita");</SCRIPT> 
                        <%
                        
                    // CASO STANDARD : GESTORE SI , CLUSTER SI     // GESTORE + CLUSTER 
                    } else if ( flg_Gestore == true && flg_Cluster == true && flg_ClusterPers == false ) {
                        String[] loc_data2 = codeListDestCluster.split(Pattern.quote( "||" ) );
                        Tariffe = homeTariffa.findTariffaUnicoXRib(codeTipoContratto, codeListDest,loc_data2[1],loc_data2[2],selProdottoCluster);
    
                    } else {
                        Tariffe = new Vector();
                    }
              
             
          } else if (flg_ListinoContr) {
                // CASO LISTINO GENERALE : GESTORE SI, CLUSTER NO
                if ( flg_Gestore == true && flg_Cluster == false && flg_ClusterPers == false ) {                   
                    String[] loc_data = codeListino.split(Pattern.quote( "||" ) );
                    Tariffe = homeTariffa.findTariffaPersXRib(codeTipoContratto, /*codeListino*/ loc_data[0], codeListDest);
                   
                // CASO LISTINO GENERALE : GESTORE NO, CLUSTER SI
                } else if ( flg_Gestore == false && flg_Cluster == true && flg_ClusterPers == false ) {
                    //String[] loc_data = codeListino.split(Pattern.quote( "||" ) );
                    //Tariffe = homeTariffa.findTariffaPersXRib(codeTipoContratto, loc_data[0], null);
                        Tariffe = new Vector();
                        %>
                           <SCRIPT LANGUAGE='Javascript'>alert("Combinazione non consentita");</SCRIPT> 
                        <%                
                // CASO STANDARD : GESTORE NO , CLUSTER PERSONALIZZATO SI    
                } else if ( flg_Gestore == false && flg_Cluster == false && flg_ClusterPers == true ) {
                //    /*String[] loc_data = codeListino.split(Pattern.quote( "||" ) );
                //    String[] loc_data_dest = codeListDestCluster.split(Pattern.quote( "||" ) );
                //    Tariffe = homeTariffa.findTariffaPersXRib(codeTipoContratto, loc_data[0], loc_data_dest[0]);*/
                //    Tariffe = new Vector(); // NON CONSENTITO  mail del 12/02/2020  Raffaele 
                    String[] loc_data = codeListino.split(Pattern.quote( "||" ) );
                    String[] loc_data2 = codeListDestCluster.split(Pattern.quote( "||" ) );
                    Tariffe = homeTariffa.findTariffaPersXRibNClus(codeTipoContratto, loc_data[0], loc_data2[0], loc_data2[1],loc_data2[2],selProdottoCluster);

                // CASO STANDARD : GESTORE SI , CLUSTER PERSONALIZZATO SI    
                } else if ( flg_Gestore == true && flg_Cluster == false && flg_ClusterPers == true ) {
                    //String[] loc_data = codeListino.split(Pattern.quote( "||" ) );
                    //Tariffe = homeTariffa.findTariffaPersXRib(codeTipoContratto, loc_data[0], codeListDest);
                    Tariffe = new Vector();
                        %>
                           <SCRIPT LANGUAGE='Javascript'>alert("Combinazione non consentita");</SCRIPT> 
                        <%  
                // CASO STANDARD : GESTORE SI , CLUSTER SI    
                } else if ( flg_Gestore == true && flg_Cluster == true && flg_ClusterPers == false ) {
                    //Tariffe = new Vector(); // NON CONSENTITO
                    String[] loc_data = codeListino.split(Pattern.quote( "||" ) );
                    String[] loc_data2 = codeListDestCluster.split(Pattern.quote( "||" ) );
                    Tariffe = homeTariffa.findTariffaPersXRibNClus(codeTipoContratto, loc_data[0], codeListDest, loc_data2[1],loc_data2[2],selProdottoCluster);

                } else if ( flg_Gestore == false && flg_Cluster == true && flg_ClusterPers == false ) {
                        Tariffe = new Vector();
                        %>
                           <SCRIPT LANGUAGE='Javascript'>alert("Combinazione non consentita");</SCRIPT> 
                        <%

                } else {
                    Tariffe = new Vector();
                } 
                

          } else if (flg_ListinoCluster) {
                
                // CASO CLUSTER : GESTORE SI , CLUSTER PERSONALIZZATO SI 
                if ( flg_Gestore == true && flg_Cluster == false && flg_ClusterPers == true ) {
                    /*String[] loc_data = codeListino.split(Pattern.quote( "||" ) );
                    String[] loc_data2 = codeListDestCluster.split(Pattern.quote( "||" ) );
                    Tariffe = homeTariffa.findTariffaPersXRibClus(codeTipoContratto, loc_data[0], codeListDest, i_code_cluster, i_tipo_cluster,loc_data2[1],loc_data2[2]);*/
                        Tariffe = new Vector();
                        %>
                           <SCRIPT LANGUAGE='Javascript'>alert("Combinazione non consentita");</SCRIPT> 
                        <%
               
                // CASO CLUSTER : GESTORE SI , CLUSTER NO PERSONALIZZATO NO 
               } else if ( flg_Gestore == true && flg_Cluster == false && flg_ClusterPers == false ) {
                    /*String[] loc_data = codeListino.split(Pattern.quote( "||" ) );
                    Tariffe = homeTariffa.findTariffaPersXRibClus(codeTipoContratto, loc_data[0], codeListDest, i_code_cluster, i_tipo_cluster,loc_data[1],loc_data[2]);*/
                    Tariffe = new Vector(); // NON CONSENTITO  mail del 12/02/2020  Raffaele 
                        %>
                           <SCRIPT LANGUAGE='Javascript'>alert("Combinazione non consentita");</SCRIPT> 
                        <%
                        
                 // CASO CLUSTER : GESTORE SI , CLUSTER SI    
                } else if ( flg_Gestore == true && flg_Cluster == true && flg_ClusterPers == false ) {
                    //Tariffe = new Vector();
                    String[] loc_data = codeListino.split(Pattern.quote( "||" ) );
                    String[] loc_data2 = codeListDestCluster.split(Pattern.quote( "||" ) );
                    Tariffe = homeTariffa.findTariffaPersXRibClus(codeTipoContratto, loc_data[0], codeListDest, i_code_cluster, i_tipo_cluster,loc_data2[1],loc_data2[2],selProdottoCluster);
              
                // CASO CLUSTER : GESTORE NO , CLUSTER SI    
                } else if ( flg_Gestore == false && flg_Cluster == true && flg_ClusterPers == false ) {
                          
                    String[] loc_data = codeListino.split(Pattern.quote( "||" ) );
                    String[] loc_data2 = codeListDestCluster.split(Pattern.quote( "||" ) );
                    Tariffe = homeTariffa.findTariffaPersXRibClus(codeTipoContratto, loc_data[0], loc_data2[0], i_code_cluster, i_tipo_cluster,loc_data2[1],loc_data2[2],selProdottoCluster);

                // CASO CLUSTER : GESTORE NO , CLUSTER PERSONALIZZATO SI 
                } else if ( flg_Gestore == false && flg_Cluster == false && flg_ClusterPers == true ) {
                    String[] loc_data = codeListino.split(Pattern.quote( "||" ) );
                    String[] loc_data2 = codeListDestCluster.split(Pattern.quote( "||" ) );
                    Tariffe = homeTariffa.findTariffaPersXRibClus(codeTipoContratto, loc_data[0], loc_data2[0], i_code_cluster, i_tipo_cluster,loc_data2[1],loc_data2[2],selProdottoCluster);

               
                } else {
                    Tariffe = new Vector();
                }           
 
          } else if (flg_ListinoClusterPers) {
          
                 // CASO CLUSTER : GESTORE SI , CLUSTER NO    
                if ( flg_Gestore == true && flg_Cluster == false && flg_ClusterPers == false ) {

                    /*String[] loc_data = codeListino.split(Pattern.quote( "||" ) );
                    Tariffe = homeTariffa.findTariffaPersXRibClus(codeTipoContratto, loc_data[0], codeListDest, i_code_cluster, i_tipo_cluster,loc_data[1],loc_data[2]);*/
                    Tariffe = new Vector(); // NON CONSENTITO  mail del 12/02/2020  Raffaele 
                        %>
                           <SCRIPT LANGUAGE='Javascript'>alert("Combinazione non consentita");</SCRIPT> 
                        <%
                // CASO CLUSTER : GESTORE SI , CLUSTER SI
                } else if ( flg_Gestore == true && flg_Cluster == true && flg_ClusterPers == false ) {
                    //Tariffe = new Vector();
                    String[] loc_data = codeListino.split(Pattern.quote( "||" ) );
                    String[] loc_data2 = codeListDestCluster.split(Pattern.quote( "||" ) );
                    Tariffe = homeTariffa.findTariffaPersXRibClus(codeTipoContratto, loc_data[0], codeListDest, i_code_cluster, i_tipo_cluster,loc_data2[1],loc_data2[2],selProdottoCluster);

                        
                // CASO CLUSTER : GESTORE NO , CLUSTER SI
                } else if ( flg_Gestore == false && flg_Cluster == true && flg_ClusterPers == false ) {
                          
                    /*String[] loc_data = codeListino.split(Pattern.quote( "||" ) );
                    String[] loc_data2 = codeListDestCluster.split(Pattern.quote( "||" ) );
                    Tariffe = homeTariffa.findTariffaPersXRibClus(codeTipoContratto, loc_data[0], loc_data2[0], i_code_cluster, i_tipo_cluster,loc_data2[1],loc_data2[2]);*/
                    Tariffe = new Vector(); // NON CONSENTITO  mail del 12/02/2020  Raffaele 
                        %>
                           <SCRIPT LANGUAGE='Javascript'>alert("Combinazione non consentita");</SCRIPT> 
                        <%
                // CASO CLUSTER : GESTORE NO , CLUSTER PERSONALIZZATO SI
                } else if ( flg_Gestore == false && flg_Cluster == false && flg_ClusterPers == true ) {
                          
                    String[] loc_data = codeListino.split(Pattern.quote( "||" ) );
                    String[] loc_data2 = codeListDestCluster.split(Pattern.quote( "||" ) );
                    Tariffe = homeTariffa.findTariffaPersXRibClus(codeTipoContratto, loc_data[0], loc_data2[0], i_code_cluster, i_tipo_cluster,loc_data2[1],loc_data2[2],selProdottoCluster);
 

                // CASO CLUSTER : GESTORE SI , CLUSTER PERSONALIZZATO SI
                } else if ( flg_Gestore == true && flg_Cluster == false && flg_ClusterPers == true ) {
                          
                    /*String[] loc_data = codeListino.split(Pattern.quote( "||" ) );
                    String[] loc_data2 = codeListDestCluster.split(Pattern.quote( "||" ) );
                    Tariffe = homeTariffa.findTariffaPersXRibClus(codeTipoContratto, loc_data[0], codeListDest, i_code_cluster, i_tipo_cluster,loc_data2[1],loc_data2[2]);*/
                     Tariffe = new Vector(); // NON CONSENTITO  mail del 12/02/2020  Raffaele 
                        %>
                           <SCRIPT LANGUAGE='Javascript'>alert("Combinazione non consentita");</SCRIPT> 
                        <%
                          
                } else {
                    Tariffe = new Vector();
                }           

               
            } else {
              Tariffe = new Vector();
            }

          } 
          else
          {
                 if(!act.equalsIgnoreCase("CONFERMA_ELIM") &&
                    !act.equalsIgnoreCase("CONFERMA")&&
                    !act.equalsIgnoreCase("RIEPILOGO"))
                 {
                 Tariffe = new Vector();
                 Tariffe_copia = new Vector();
                 }
          }
           //Tariffe_ins = new Vector();
           //Tariffe_ins_appo = new Vector();
           //System.out.println("EEE Tariffe_ins: "+Tariffe_ins.size());
           //System.out.println("EEE Tariffe_ins: "+Tariffe_ins_appo.size());
       }        
       
       if (Tariffe!=null)
           session.setAttribute("Tariffe", Tariffe);
       if (Tariffe_copia!=null)
           session.setAttribute("Tariffe_copia", Tariffe_copia);
       
        if (flgCancTariffe_ins != null && flgCancTariffe_ins.equals("SI"))
        {
            Tariffe_ins = new Vector();
            Tariffe_ins.clear();
            session.setAttribute("Tariffe_ins", Tariffe_ins);
            //System.out.println("GGGG Tariffe_ins.size: "+Tariffe_ins.size());
            flgCancTariffe_ins = "NO";
        }
   }

   if (act != null && act.equalsIgnoreCase("REFRESH"))
   {
   act="B";
   Object[] objs_ins = Tariffe_ins.toArray();
   Object[] objs = Tariffe.toArray();
   ClassTariffeElem elem=new  ClassTariffeElem();
   ClassTariffeElem elem2=new  ClassTariffeElem();
   String codTarIns = "";
   String progTarIns = "";
   String codTarIns2 = "";
   String progTarIns2 = "";
    for (int x=0;x<objs_ins.length;x++){
        

              elem.setProgTar(((TariffaBMP)objs_ins[x]).getProgTar());  
              elem.setCodTar(((TariffaBMP)objs_ins[x]).getCodTar());  
              codTarIns = elem.getCodTar();
              progTarIns = elem.getProgTar();
              
              for (int y=0;y<objs.length;y++){

                  elem2.setProgTar(((TariffaBMP)objs[y]).getProgTar());  
                  elem2.setCodTar(((TariffaBMP)objs[y]).getCodTar());  
                  codTarIns2 = elem2.getCodTar();
                  progTarIns2 = elem2.getProgTar();   
                  
                  
                if (codTarIns.equals(codTarIns2) && 
                  progTarIns.equals(progTarIns2))
                   {
                    Tariffe.remove(objs[y]);
                  }

              }
      }
   }

   if (act != null && act.equalsIgnoreCase("INSERISCI_SEL"))
   {
        if (Tariffe_ins == null)
        {
            Tariffe_ins = new Vector();
        }
        if (Tariffe != null)
        {
            Object[] objs_ins = Tariffe.toArray();
            int numTarZ = Tariffe.size();
            String codTarIns = "";
            String progTarIns = "";
            
            //Modifica CHECKBOX
            String[] tariffaSplit = codeTariffa.split(";");
            //
            for(int i=0;i < numTarZ;i++)
            {
              
              ClassTariffeElem elem=new  ClassTariffeElem();
              elem.setProgTar(((TariffaBMP)objs_ins[i]).getProgTar());  
              elem.setCodTar(((TariffaBMP)objs_ins[i]).getCodTar());  
              codTarIns = elem.getCodTar();
              progTarIns = elem.getProgTar();
              
              //Modifica CHECKBOX
              /*if (codeTariffa.equals(codTarIns) && 
                  progTariffa.equals(progTarIns))
              {*/
              for (int x=0;x<tariffaSplit.length;x++){
                  String locSplit = tariffaSplit[x];
                  String[] re1 = locSplit.split(":");
                  if (re1[0].equals(codTarIns) && 
                      re1[1].equals(progTarIns))
                  {
               //
                    Tariffe_ins.add(objs_ins[i]);
                    Tariffe.remove(objs_ins[i]);
                  }
              }
            }
            session.setAttribute("Tariffe_ins", Tariffe_ins);
        } 
   }
 
   if (act != null && act.equalsIgnoreCase("INSERISCI_TUTTI"))
   {
        if (Tariffe != null)
        {
            Object[] objs=Tariffe.toArray();
            int numTarX = Tariffe.size();
            for(int i=0;i< numTarX;i++)
            {
                Tariffe.remove(objs[i]);
                Tariffe_ins.add(objs[i]);
                if (Tariffe_copia == null) Tariffe_copia = new Vector();
                Tariffe_copia.add(objs[i]);     
           }
        }

         Integer num = new Integer(Tariffe.size());
         numTar = num.toString();
         int numB = Tariffe_copia.size();
        if (numTar != null &&
            numTar.equals("0") && numB != 0)
            button = "ABILITATO";
        else
           if (numTar != null &&
               numTar.equals("0") && numB == 0)
               button = "DISABILITATO";

        session.setAttribute("Tariffe", Tariffe);
        session.setAttribute("Tariffe_copia", Tariffe_copia); 
        session.setAttribute("Tariffe_ins", Tariffe_ins);     
   }

   if (act != null && act.equalsIgnoreCase("LISTINO_DEST"))
   {
            
            DatiCliBMP numFattLisUn = homeDatiCli.findNumFattLisUn(flagTipoContr, codeListDest);
            numFatt = numFattLisUn.getNumFattLisUn().toString();
            if (numFattLisUn != null &&
                !numFattLisUn.getNumFattLisUn().toString().equals("0"))
            {
            %><SCRIPT LANGUAGE='Javascript'>
                window.alert("Contratto fatturato con listino unico. Non è possibile acquisire il listino personalizzato.");
            </SCRIPT><%
            resetta=true;
            }
            act = act_1;//040203
   }

   if (act != null && act.equalsIgnoreCase("CONFERMA_ELIM"))
   {
        if (Tariffe_ins_appo != null && Tariffe_appo != null)
        {
            Tariffe_ins = (Collection) session.getAttribute("Tariffe_ins_appo");
            
            Object[] objsIns = Tariffe_appo.toArray();
            for(int i=0;i < Tariffe_appo.size();i++)
            {
            
              Tariffe.add(objsIns[i]);
            }

            session.setAttribute("Tariffe_ins", Tariffe_ins);
            session.setAttribute("Tariffe", Tariffe);
            Insert = "SEL";
        }
        act = "B";
   }

         Integer numZ = new Integer(Tariffe.size());
         numTar = numZ.toString();

         Integer numTarZ_ins = new Integer(Tariffe_ins.size());
         numTar_ins = numTarZ_ins.toString();

   if (((act != null && act.equalsIgnoreCase("CONFERMA")) || messaggio_alert != null))
   {
         if (numFatt != null && !numFatt.equalsIgnoreCase("0")) 
         {
            %><SCRIPT LANGUAGE='Javascript'>
             alert("Contratto fatturato con listino unico. Non è possibile acquisire il listino personalizzato.")
            </SCRIPT><%
           
         }
         else {
            if (numElab != null && !numElab.equalsIgnoreCase("0"))
            {
              %><SCRIPT LANGUAGE='Javascript'>
               alert('ci sono elaborazioni BATCH in esecuzione, il salvataggio non sarà effettuato');
              </SCRIPT><%
              
            }
        }
        request.getSession().setAttribute("messaggio_alert",null);
   }
%>
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="get" action="RibListinoSp.jsp">
<input type="hidden" name="codeTipoContratto" id=codeTipoContratto value= "<%=codeTipoContratto%>"> 
<input type="hidden" name="descTipoContratto" id=descTipoContratto value= "<%=descTipoContratto%>">
<input type="hidden" name="flagTipoContr" id=flagTipoContr value= "<%=flagTipoContr%>"> <!--040203-->
<input type="hidden" name="codeContratto"     id=codeContratto     value= "<%=codeContratto%>"> 
<input type="hidden" name="codeContrattoCluster"     id=codeContrattoCluster     value= "<%=codeContrattoCluster%>"> 
<input type="hidden" name="descContratto"     id=descContratto     value= "<%=descContratto%>"> 
<input type="hidden" name="progTariffa"       id=progTariffa       value= "<%=progTariffa%>"> 
<input type="hidden" name="selDest"     id=selDest    value= "<%=selDest%>"> 
<input type="hidden" name="selListino"  id=selListino value= "<%=selListino%>"> 
<input type="hidden" name="codeListino" id=codeListino value= "<%=codeListino%>">  
<input type="hidden" name="codeTariffa" id=codeTariffa value= "<%=codeTariffa%>"> 
<input type="hidden" name="descTariffa" id=descTariffa value= "<%=descTariffa%>"> 
<input type="hidden" name="codeListDest" id=codeListDest value= "<%=codeListDest%>"> 
<input type="hidden" name="act"      id=act      value= "<%=act%>"> 
<input type="hidden" name="act_1"      id=act_1      value= "<%=act_1%>"> <!--040203--> 
<input type="hidden" name="Tar"         id=Tar         value= "<%=Tar%>">
<input type="hidden" name="button"      id=button      value= "<%=button%>">
<input type="hidden" name="numFatt"     id=numFatt     value= "<%=numFatt%>">
<input type="hidden" name="numElab"     id=numElab     value= "<%=numElab%>">
<input type="hidden" name="numTar"      id=numTar      value= "<%=numTar%>">
<input type="hidden" name="numTar_ins"  id=numTar_ins  value= "<%=numTar_ins%>">
<input type="hidden" name="flgIns"      id=flgIns      value= "<%=flgIns%>">
<input type="hidden" name="Insert"      id=Insert      value= "<%=Insert%>">
<input type="hidden" name="flgCancTariffe_ins" id=flgCancTariffe_ins value= "<%=flgCancTariffe_ins%>">


<input type="hidden" name="codeClusterListino" id=codeClusterListino value= "<%=codeClusterListino%>"> 
<input type="hidden" name="tipoClusterListino" id=tipoClusterListino value= "<%=tipoClusterListino%>"> 
<input type="hidden" name="codeTipoContrListino" id=codeTipoContrListino value= "<%=codeTipoContrListino%>"> 
<input type="hidden" name="codeListinoListino" id=codeListinoListino value= "<%=codeListinoListino%>">
<input type="hidden" name="selDestCluster"     id=selDestCluster    value= "<%=selDestCluster%>"> 
<input type="hidden" name="selProdottoCluster" id=selProdottoCluster value="<%=selProdottoCluster%>">
<input type="hidden" name="codeListDestCluster" id=codeListDestCluster value= "<%=codeListDestCluster%>"> 
<input type="hidden" name="codeListProdottoCluster" id=codeListProdottoCluster value= "<%=codeListProdottoCluster%>"> 


<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloPagina.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Ribaltamento Listino</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="1" align='center' bgcolor="<%=StaticContext.bgColorHeader%>"> 
        <tr>
					<td>
             <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Seleziona Listino</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </td>
</tr>
<tr> 
    <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
</tr>
<tr>
 	 <td>
	    <table  width="90%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                    <tr>
                       <td width="20%" class="textB" align="left">&nbsp;Tipo contratto:&nbsp;
                       </td>   
                       <td width="60%" class="text" align="left"> <%=descTipoContratto%>
                       </td>   
                       <td width="20%" class="text" align="left">&nbsp;
                       </td>   
                    </tr>
                  </table>
                </td>
              </tr>
<!--inizio combo Listino -->
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                        <tr>
                             <td width="20%" class="textB" align="Right">&nbsp;</td>
                             <td width="10%" class="textB" align="Right">&nbsp;Listino:&nbsp;</td>
                             <td width="70%" class="text" align="Right">
                                  <%
                                    Listini = homeTariffa.findListiniClus(codeTipoContratto);
                                    session.setAttribute("Listini",Listini);
                                    if ((Listini!=null)&&(Listini.size()!=0))
                                    {
                                      System.out.println("Listini:"+Listini.size());
                                      // Visualizzo elementi
                                         %>
                                         <select class="text" title="combo Listini" name="comboListini" onchange="scegliListino();">
                                         <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(20)%></option>
                                         <%
                                         Object[] objs=Listini.toArray();
                                         if (selListino != null)
                                             codeListino = selListino;
                                         for(int i=0;i<Listini.size();i++)
                                         {
                                        
                                          ClassTariffeElem elem2=new  ClassTariffeElem();
                                          elem2.setCodContr(((TariffaBMP)objs[i]).getCodContr());  
                                          elem2.setDescContr(((TariffaBMP)objs[i]).getDescContr());  

                                          String selectListino="";
                                          String descList="";
                                          if (codeListino.equals(elem2.getCodContr()))
                                          {
                                              selectListino="selected";
                                              descContratto = elem2.getDescContr();
                                              session.setAttribute("descContratto", descContratto);
                                          }   
                                          %>
                                          <option value="<%=elem2.getCodContr()%>" <%=selectListino%>><%=elem2.getDescContr()%></option>
                                          <%
                                          }
                                       %> 
                                       </select>
                                       &nbsp;
                                       <%   
                                      }
                                      else
                                      {
                                      // Visualizzo solo [Seleziona Opzione]
                                      %>
                                         <select class="text" title="combo Listini" name="comboListini" onchange="scegliListino();">
                                         <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(20)%></option>
                                         </select>
                                         &nbsp;
                                      <%
                                      }
                                      %>
                              </td> 
                           </tr>
                        </table>
                      </td>
                    </tr> 
<!-- fine combo Listino --> 
                    <tr>
                      <td>
                            <td class="textB" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>" align="Left">&nbsp;</td>
                      </td>
                    </tr>
                    <tr> 
                        <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
                    </tr>
<!--inizio combo Dati di Destinazione -->
                    <tr> 
                        <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                            <tr>
                               <td>
                                 <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>">
                                   <tr>
                                      <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dati di destinazione Gestore</td>
                                      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                                   </tr>
                                 </table>               
                               </td>
                            </tr>
                         </table>
                       </td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                          <tr> 
                             <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                          </tr>
                          <tr>
                              <td width="60%" class="text" align="left">&nbsp;</td>   
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">

                            <tr>
                                 <td class="textB" align="Left">&nbsp;Listino:</td>
                                 <td class="text" align="Left">
                                      <%
                                        Collection Destination = null;
//                                        if (selListino == null || selListino.equals("") || selListino.equals("-1"))
                                            Destination = homeTariffa.findListDest(codeTipoContratto);
                                        if ((Destination!=null)&&(Destination.size()!=0))
                                        {
                                          // Visualizzo elementi
                                             %>
                                             <select class="text" title="combo Destination" name="comboDestination" onchange="scegliListDest();">
                                             <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(70)%></option>
                                             <%
                                             Object[] objs=Destination.toArray();
                                             if (selDest != null)
                                                 codeListDest = selDest;
                                             else
                                                 codeListDest = "x";
                                             for(int i=0;i<Destination.size();i++)
                                             {
                                              
                                                ClassTariffeElem elem=new  ClassTariffeElem();
                                                elem.setCodContr(((TariffaBMP)objs[i]).getCodContr());  
                                                elem.setDescContr(((TariffaBMP)objs[i]).getDescContr());  
                                              
                                              String selectDest="";
                                              if (codeListDest.equals(elem.getCodContr()) && (!resetta) )
                                                  selectDest="selected";
                                              %>
                                              <option value="<%=elem.getCodContr()%>" <%=selectDest%>><%=elem.getDescContr()%></option>
                                              <%
                                             }
                                        %> 
                                          </select>
                                        <%   
                                        }
                                        else
                                        {
                                          // Visualizzo solo [Seleziona Opzione]
                                        %>
                                             <select class="text" title="combo Destination" name="comboDestination">
                                             <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(75)%></option>
                                             </select>         
                                        <%
                                        }
                                        %>
                                  </td>   
                               </tr>
                        </table>
                      </td>
                    </tr>  
<!--fine combo Dati di Destinazione -->


                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                            <tr>
                               <td>
                                 <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>">
                                   <tr>
                                      <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dati di destinazione Cluster</td>
                                      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                                   </tr>
                                 </table>               
                               </td>
                            </tr>
                         </table>
                       </td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                          <tr> 
                             <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                          </tr>
                          <tr>
                              <td width="60%" class="text" align="left">&nbsp;</td>   
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">

                            <tr>
                                 <td class="textB" align="Left">&nbsp;Listino:</td>
                                 <td class="text" align="Left">
                                      <%
                                        Collection Cluster = null;
//                                        if (selListino == null || selListino.equals("") || selListino.equals("-1"))
                                            Cluster = homeTariffa.findListDestClus(codeTipoContratto);
                                        if ((Cluster!=null)&&(Cluster.size()!=0))
                                        {
                                          // Visualizzo elementi
                                             %>
                                             <select class="text" title="combo Cluster" name="comboCluster" onchange="scegliListClus();">
                                             <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(70)%></option>
                                             <%
                                             Object[] objs=Cluster.toArray();
                                             if (selDestCluster != null)
                                                 codeListDestCluster = selDestCluster;
                                             else
                                                 codeListDestCluster = "x";
                                             for(int i=0;i<Cluster.size();i++)
                                             {
                                              
                                                ClassTariffeElem elem=new  ClassTariffeElem();
                                                elem.setCodContr(((TariffaBMP)objs[i]).getCodContr());  
                                                elem.setDescContr(((TariffaBMP)objs[i]).getDescContr());  
                                              
                                              String selectDestCluster="";
                                              if (codeListDestCluster.equals(elem.getCodContr()) && (!resetta) )
                                                  selectDestCluster="selected";
                                              %>
                                              <option value="<%=elem.getCodContr()%>" <%=selectDestCluster%>><%=elem.getDescContr()%></option>
                                              <%
                                             }
                                        %> 
                                          </select>
                                        <%   
                                        }
                                        else
                                        {
                                          // Visualizzo solo [Seleziona Opzione]
                                        %>
                                             <select class="text" title="combo Cluster" name="comboCluster">
                                             <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(75)%></option>
                                             </select>         
                                        <%
                                        }
                                        %>
                                  </td>   
                               </tr>
                             <tr>
                                 <td class="textB" align="Left">&nbsp;</td>
                                 <td class="text" align="Left">&nbsp;</td>
                             </tr>
                            <tr>
                                 <td class="textB" align="Left">&nbsp;Prodotto:</td>
                                 <td class="text" align="Left">
                                <%
                                        Collection prodottoCluster = null;
//                                        if (selListino == null || selListino.equals("") || selListino.equals("-1"))
                                            prodottoCluster = homeTariffa.findProdottiClus(codeTipoContratto);
                                        if ((prodottoCluster!=null)&&(prodottoCluster.size()!=0))
                                        {
                                          // Visualizzo elementi
                                             %>
                                             <select class="text" title="combo Prodotti Cluster" name="comboProdottiCluster" onchange="scegliProdottoClus();">
                                             <option value="-1">Tutti<%=Utility.getSpazi(20)%></option>
                                            <%
                                             Object[] objs=prodottoCluster.toArray();
                                             if (selProdottoCluster != null)
                                                 codeListProdottoCluster = selProdottoCluster;
                                             else
                                                 codeListProdottoCluster = "";
                                             for(int i=0;i<prodottoCluster.size();i++)
                                             {
                                              
                                                ClassTariffeElem elem=new  ClassTariffeElem();
                                                elem.setCodContr(((TariffaBMP)objs[i]).getDescContr());  
                                                elem.setDescContr(((TariffaBMP)objs[i]).getDescContr());  
                                              
                                              String selectProdottoCluster="";
                                              if (codeListProdottoCluster.equals(elem.getDescContr()) && (!resetta) )
                                                  selectProdottoCluster="selected";
                                              %>
                                              <option value="<%=elem.getDescContr()%>" <%=selectProdottoCluster%>><%=elem.getDescContr()%></option>
                                              <%
                                             }
                                        %> 
                                          </select>
                                        <%   
                                        }
                                        else
                                        {
                                          // Visualizzo solo [Seleziona Opzione]
                                        %>
                                             <select class="text" title="combo Prodotti Cluster" name="comboProdottiCluster">
                                             <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(75)%></option>
                                             </select>         
                                        <%
                                        }
                                        %>
                                  </td>   
                               </tr>
                        </table>
                      </td>
                    </tr>  


<!--inizio lista tariffe-->
                    </tr>
                    <tr>
                       <td> 
                         <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                            <tr>
                               <td>
                                 <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>">
                                   <tr>
                                      <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista tariffe</td>
                                      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                                   </tr>
                                 </table>               
                               </td>
                            </tr>
                         </table>
                       </td>
                    </tr>
<!--inizio risultati per pag-->
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                                <input class="textB" type="hidden" name="txtnumPag" value="1">
                                <input class="textB" type="hidden" name="typeLoad" value="0">
                                <input class="textB" type="hidden" name="txtnumRec" value="0">
                             <tr>
                              <td width="25%">&nbsp;</td>
                                <td class="textB" width="25%" align="right">Risultati per pag.:</td>
                                <td class="text" width="25%" align="left">
                                  <select class="text" name="numRec"  onchange="submitFrmSearch('1');">
                                    <option class="text" value=5>5</option>
                                    <option class="text" value=10>10</option>
                                    <option class="text" value=20>20</option>
                                    <option class="text" value=50>50</option>
                                  </select>
                                </td>
                                <td width="25%">&nbsp;</td>
                              </tr>
                        </table>
                      </td>
                    </tr>
<!--fine risultati per pag-->
                    <tr> 
                      <td> 
                        <table align=center width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                          <tr> 
                            <td> 
                              <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td colspan='8' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                                </tr>
<%
      if (act != null && (act.equalsIgnoreCase("B") || 
                             act.equalsIgnoreCase("CONFERMA") || 
                             act.equalsIgnoreCase("CONFERMA_ELIM") || 
                             act.equalsIgnoreCase("INSERISCI_SEL") || 
                             act.equalsIgnoreCase("LISTINO_DEST") ||
                             act.equalsIgnoreCase("RIEPILOGO") ||
                             act.equalsIgnoreCase("REFRESH") ))
      {   
        
         Integer numG = new Integer(Tariffe.size());
         numTar = numG.toString();

          if ((Tariffe==null)||(Tariffe.size()==0))
          {
%>
                                <SCRIPT LANGUAGE='Javascript'> document.frmSearch.Tar.value = "0";</SCRIPT>
                                <tr> 
                                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="8" class="textB" align="center"></td>
                                </tr>
<%
          }
          else
          {
%>
                                <SCRIPT LANGUAGE='Javascript'> document.frmSearch.Tar.value = "1";</SCRIPT>
                                <tr> 
                                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class='white'>&nbsp;</td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Prodotto/Servizio </td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Ogg.di Fatt. </td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Causale </td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Tipo Opzione</td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Importo </td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Data inizio </td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Data fine </td>
                                </tr>
                                   <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=Tariffe.size()%>">
                                   <pg:param name="codeTipoContratto" value="<%=codeTipoContratto%>"></pg:param> 
                                   <pg:param name="descTipoContratto" value="<%=descTipoContratto%>"></pg:param> 
                                   <pg:param name="flagTipoContr" value="<%=flagTipoContr%>"></pg:param> 
                                   <pg:param name="codeContratto" value="<%=codeContratto%>"></pg:param> 
                                   <pg:param name="descContratto" value="<%=descContratto%>"></pg:param>             
                                   <pg:param name="Tar" value="<%=Tar%>"></pg:param>                            
                                   <pg:param name="typeLoad" value="1"></pg:param> 
                                   <pg:param name="txtnumRec" value="<%=index%>"></pg:param> 
                                   <pg:param name="numRec" value="<%=strNumRec%>"></pg:param> 
                                   <pg:param name="selListino" value="<%=selListino%>"></pg:param> 
                                   <pg:param name="codeListino" value="<%=codeListino%>"></pg:param> 
                                   <pg:param name="codeTariffa" value="<%=codeTariffa%>"></pg:param> 
                                   <pg:param name="progTariffa" value="<%=progTariffa%>"></pg:param> 
                                   <pg:param name="act" value="<%=act%>"></pg:param> 
                                   <pg:param name="act_1" value="<%=act_1%>"></pg:param> <!--040203-->

                                   <pg:param name="selDest" value="<%=selDest%>"></pg:param> 
                                   <pg:param name="codeListDest" value="<%=codeListDest%>"></pg:param>                                    
                                   <pg:param name="flgIns" value="<%=flgIns%>"></pg:param>                                    
                                   <pg:param name="Insert" value="<%=Insert%>"></pg:param>    
                                   <pg:param name="codeContrattoCluster" value="<%=codeContrattoCluster%>"></pg:param>
                                   <pg:param name="selDestCluster" value="<%=selDestCluster%>"></pg:param>
                                   <pg:param name="selProdottoCluster" value="<%=selProdottoCluster%>"></pg:param>
                                   <pg:param name="codeListinoListino" value="<%=codeListinoListino%>"></pg:param>
                                   <pg:param name="codeClusterListino" value="<%=codeClusterListino%>"></pg:param>
                                   <pg:param name="tipoClusterListino" value="<%=tipoClusterListino%>"></pg:param>
                                   <pg:param name="codeTipoContrListino" value="<%=codeTipoContrListino%>"></pg:param>
                                   <pg:param name="codeListDestCluster" value="<%=codeListDestCluster%>"></pg:param>
                                   <pg:param name="codeListProdottoCluster" value="<%=codeListProdottoCluster%>"></pg:param>
                                   
                                   
                                    
                                   <%
                                         String bgcolor="";
                                         String checked;  
                                         Object[] objs=Tariffe.toArray();
                                         //Lista Tariffe 
                                            // Visualizzo elementi
                                            for(int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<Tariffe.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                                            {
                                         
                                                ClassTariffeElem elem3=new  ClassTariffeElem();
                                                elem3.setImpTar(((TariffaBMP)objs[i]).getImpTar());
                                                elem3.setProgTar(((TariffaBMP)objs[i]).getProgTar());  
                                                elem3.setCodTar(((TariffaBMP)objs[i]).getCodTar());  
                                                elem3.setCodOf(((TariffaBMP)objs[i]).getCodOf());  
                                                elem3.setDescOf(((TariffaBMP)objs[i]).getDescOf());
                                                elem3.setDescEsP(((TariffaBMP)objs[i]).getDescEsP());  
                                                elem3.setDescTipoCaus(((TariffaBMP)objs[i]).getDescTipoCaus());
                                                 
                                                elem3.setDescTipoOpz(((TariffaBMP)objs[i]).getDescTipoOpz());
                                                elem3.setDataIniTar(((TariffaBMP)objs[i]).getDataIniTar());
                                                elem3.setDataFineTar(((TariffaBMP)objs[i]).getDataFineTar());  
                                                
                                                elem3.setCodTipoCaus(((TariffaBMP)objs[i]).getCodTipoCaus());
                                                
                                                 if ((i%2)==0)
                                                     bgcolor=StaticContext.bgColorRigaPariTabella;
                                                 else
                                                     bgcolor=StaticContext.bgColorRigaDispariTabella;
                                    %>
                                             <tr> 
                                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'> 
                                                  <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='checkbox'  name='SelCodeTariffa' value='<%=elem3.getCodTar()%>:<%=elem3.getProgTar()%>' onClick="ChangeSel('<%=elem3.getCodTar()%>','<%=elem3.getProgTar()%>')">
                                                  <input type='hidden'  name='SelProgTariffa' value='<%=elem3.getProgTar()%>'>                                                
                                                </td>
                                                <td bgcolor='<%=bgcolor%>' class='text' width="23%"><%=elem3.getDescEsP()%></td>
                                                <td bgcolor="<%=bgcolor%>" class='text' width="15%"><%=elem3.getDescOf()%></td>
                                    <%  
                                               if (elem3.getDescTipoCaus().trim().equals(""))
                                               { 
                                    %>
                                                <td bgcolor="<%=bgcolor%>" class='text' width="13%">&nbsp;</td>
                                    <%    
                                               } 
                                               else
                                               {
                                    %>
                                                <td bgcolor='<%=bgcolor%>' class='text' width="13%"><%=elem3.getDescTipoCaus()%></td>
                                    <%    
                                               }
                                               if (elem3.getDescTipoOpz().trim().equals(""))
                                               { 
                                    %>
                                                <td bgcolor="<%=bgcolor%>" class='text' width="11%">&nbsp;</td>
                                    <%    
                                               } 
                                               else
                                               {
                                    %>
                                                <td bgcolor='<%=bgcolor%>' class='text' width="11%"><%=elem3.getDescTipoOpz()%></td>
                                    <%    
                                               }
                                    %>
                                                <td bgcolor="<%=bgcolor%>" class='text' width="12%"><%=CustomNumberFormat.setToCurrencyFormat(elem3.getImpTar().toString(),4)%></td>
                                    <%  
                                               if (elem3.getDataIniTar().trim().equals(""))
                                               { 
                                    %>
                                                <td bgcolor="<%=bgcolor%>" class='text' width="13%">&nbsp;</td>
                                    <%    
                                               } 
                                               else
                                               {
                                    %>
                                                <td bgcolor="<%=bgcolor%>" class='text' width="13%"><%=elem3.getDataIniTar()%></td>
                                    <%    
                                               }
                                               if (elem3.getDataFineTar().trim().equals(""))
                                               { 
                                    %>
                                                <td bgcolor="<%=bgcolor%>" class='text' width="13%">&nbsp;</td>
                                    <%    
                                               } 
                                               else
                                               {
                                    %>
                                                <td bgcolor='<%=bgcolor%>' class='text' width="13%"><%=elem3.getDataFineTar()%></td>
                                             </tr>
                                    <%    
                                               }
                                            }
                                        
                                    %>
                                   <pg:index> 
                                      <tr> 
                                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="8" class="text" align="center"> Risultati Pag. 
                                          <pg:prev> 
                                          <a href="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[<< 
                                          Prev]</a> 
                                          </pg:prev> <pg:pages> 
                                    <% 
                                                    if (pageNumber == pagerPageNumber) 
                                                      {
                                    %>
                                          <b><%= pageNumber %></b>&nbsp; 
                                    <% 
                                                      }
                                                   else
                                                      {
                                    %>
                                          <a href="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true"><%= pageNumber %></a>&nbsp; 
                                    <%
                                                      } 
                                    %>
                                          </pg:pages> 
                                          <pg:next> 
                                          <a href="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[Next 
                                          >>]
                                          </a> 
                                          </pg:next> 
                                          </td>
                                      </tr>
                                    </pg:index> 
                                  </pg:pager> 
                                    <%
                                    }//chiusura del for
                               
          }//chiusura if
          %>
                                  </td>
                                </tr>
                              </table>
                            </td> 
                          </tr>
                        </table> 
                      </td>
                    </tr> 
                    <!--fine lista tariffe-->
                    <tr>
                      <td>
                         <tr>
                            <td class="textB" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>" align="Left">&nbsp;
                             <sec:ShowButtons PageName="RIBLISTINO1" />
                            </td>
                         </tr>  
                      </td>
                    </tr>
                    <tr>
                      <td>
                         <tr>
                            <td class="textB" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>" align="Left">&nbsp;</td>
                         </tr>  
                      </td>
                    </tr>
                    <tr>
                      <td>
                         <tr>
                            <td class="textB" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>" align="Left">&nbsp;</td>
                         </tr>  
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                          <tr>
                             <td colspan='2' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="3" height='2'></td>
                          </tr> 
                        </table>
                      </td>
                    </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td colspan='2' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="3" height='2'></td>
        </tr>
            <!--</tr>-->
    </table>
  </td>
</tr>
<tr> 
     <td>  
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'> 
            <tr> <td colspan=5>  <sec:ShowButtons VectorName="BOTTONI" />  </td> </tr>
        </table> 
     </td>
  </tr>

  </table>
 </FORM>
 </div>
</BODY>
</HTML>
