<%@ page contentType="text/html;charset=windows-1252"%>
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.rmi.PortableRemoteObject" %>
<%@ page import="java.rmi.RemoteException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.ejb.*" %>
<%@ page import="com.utl.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%--<%@ taglib uri="/webapp/sec" prefix="sec" %>--%>
<%@ taglib uri="/webapp/pg" prefix="pg" %>

<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"ProdottiDettaglio.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Catalogo" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="remoteEnt_Catalogo" type="com.ejbSTL.Ent_Catalogo" scope="session">
    <EJB:createBean instance="<%=homeEnt_Catalogo.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_Catalogo" type="com.ejbSTL.Ctr_CatalogoHome" location="Ctr_Catalogo" />
<EJB:useBean id="remoteCtr_Catalogo" type="com.ejbSTL.Ctr_Catalogo" scope="session">
    <EJB:createBean instance="<%=homeCtr_Catalogo.create()%>" />
</EJB:useBean>

<%
  /* PARAMETRI PASSATI */
  String strNodo = (String)session.getAttribute("strNodo");

  
  String strCodeOfferta  = Misc.nh((String)session.getAttribute("strCodeOfferta"));
  String strCodeServizio = Misc.nh((String)session.getAttribute("strCodeServizio"));
  String strCodeProdotto = Misc.nh((String)session.getAttribute("strCodeProdotto"));

  DB_TempoNoleggio dbTempoNoleggio = new DB_TempoNoleggio();
  if(!strCodeProdotto.equals("")){
    Vector vct_TempoNol = remoteEnt_Catalogo.getTempoNol(strCodeOfferta,strCodeServizio,strCodeProdotto);
    dbTempoNoleggio = (DB_TempoNoleggio)vct_TempoNol.get(0);
  }
  
%>


<HTML>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<script src="<%=StaticContext.PH_COMMON_JS%>XML.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>validateFunction.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>ListaTariffeSp.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<script language="Javascript">

var objWindows  = null;
var elementiCheck = '';
var param = '';
  
var objXmlModalNoleg = null;
var valCboModalNoleg = '';


//alert('prodotto ['+<%=strCodeProdotto%>+']');


function Initialize() {
  objXmlModalNoleg  = CreaObjXML();
  objXmlModalNoleg.loadXML ('<MAIN><%=remoteCtr_Catalogo.getModalitaApplicazioneNoleggioXml()%></MAIN>');
  CaricaComboDaXML(frmDatiDett.cboModalNoleg,objXmlModalNoleg.documentElement.selectNodes('NOLEGGIO'));
}

function change_cboModalNoleg(){

  frmDatiDett.RinnovoNoleggio.value = '';
  frmDatiDett.TempoPreavviso.value = '';
  frmDatiDett.PrimoNoleggio.value = '';    
  frmDatiDett.dataFineNoleggio.value = '';
  frmDatiDett.chkEuribor.checked = false;
  frmDatiDett.chkSpesaComplessiva.checked = false; 
    
  if (valCboModalNoleg!=frmDatiDett.cboModalNoleg.value){
    valCboModalNoleg=frmDatiDett.cboModalNoleg.value;
    
    if ( 1 == frmDatiDett.cboModalNoleg.value ) {
        Enable ( frmDatiDett.RinnovoNoleggio );
        Enable ( frmDatiDett.TempoPreavviso );
        Enable ( frmDatiDett.PrimoNoleggio );
        Enable ( frmDatiDett.chkEuribor );
        Enable ( frmDatiDett.chkSpesaComplessiva );
        Disable ( frmDatiDett.dataFineNoleggio );
          
        if(!frmDatiDett.calendario.disabled)
          DisableLink ( document.links[0], frmDatiDett.calendario);
        if(!frmDatiDett.cancella_data.disabled)
          DisableLink ( document.links[1], frmDatiDett.cancella_data);
        Disable ( frmDatiDett.calendario );
        Disable ( frmDatiDett.cancella_data );    
    } 
    else if (
      ( 2 ==  frmDatiDett.cboModalNoleg.value )
      ||
      ( 3 ==  frmDatiDett.cboModalNoleg.value ) 
      ||
      ( 6 ==  frmDatiDett.cboModalNoleg.value )
      ){
        Disable ( frmDatiDett.RinnovoNoleggio );
        Disable ( frmDatiDett.TempoPreavviso );
        Disable ( frmDatiDett.PrimoNoleggio );
        Disable ( frmDatiDett.dataFineNoleggio );
        Enable ( frmDatiDett.chkEuribor );
        Enable ( frmDatiDett.chkSpesaComplessiva );
          
        if(!frmDatiDett.calendario.disabled){
          DisableLink ( document.links[0], frmDatiDett.calendario);
        }
        if(!frmDatiDett.cancella_data.disabled)
          DisableLink ( document.links[1], frmDatiDett.cancella_data);
        Disable ( frmDatiDett.calendario );
        Disable ( frmDatiDett.cancella_data );
    } 
    else if ( (4 ==  frmDatiDett.cboModalNoleg.value)  ||
      ( 7 ==  frmDatiDett.cboModalNoleg.value ) ) {
      //MoS Aggiunta 7 ==  frmDatiDett.cboModalNoleg.value
        Disable ( frmDatiDett.RinnovoNoleggio );
        Disable ( frmDatiDett.TempoPreavviso );
        Enable ( frmDatiDett.PrimoNoleggio );
        Disable ( frmDatiDett.dataFineNoleggio );
        Enable ( frmDatiDett.chkEuribor );
        Enable ( frmDatiDett.chkSpesaComplessiva );
          
        if(!frmDatiDett.calendario.disabled)
          DisableLink ( document.links[0], frmDatiDett.calendario);
        if(!frmDatiDett.cancella_data.disabled)
          DisableLink ( document.links[1], frmDatiDett.cancella_data);
        Disable ( frmDatiDett.calendario );
        Disable ( frmDatiDett.cancella_data );      
    } 
    else if ( 5 == frmDatiDett.cboModalNoleg.value ) {
        Disable ( frmDatiDett.RinnovoNoleggio );
        Enable ( frmDatiDett.TempoPreavviso );
        Disable ( frmDatiDett.PrimoNoleggio );
        Enable ( frmDatiDett.dataFineNoleggio );
        Enable ( frmDatiDett.chkEuribor );
        Enable ( frmDatiDett.chkSpesaComplessiva );
          
        if(frmDatiDett.calendario.disabled)
          EnableLink ( document.links[0], frmDatiDett.calendario);
        if(frmDatiDett.cancella_data.disabled)
          EnableLink ( document.links[1], frmDatiDett.cancella_data);
        Enable ( frmDatiDett.calendario );
        Enable ( frmDatiDett.cancella_data );

        frmDatiDett.TempoPreavviso.value = '30';
        frmDatiDett.TempoPreavviso.readOnly = false;     
    } 
    else if ( 9 == frmDatiDett.cboModalNoleg.value ) {
    	Disable ( frmDatiDett.RinnovoNoleggio );
    	Disable ( frmDatiDett.TempoPreavviso );
    	Disable ( frmDatiDett.PrimoNoleggio );
        Enable ( frmDatiDett.dataFineNoleggio );
        Disable ( frmDatiDett.chkEuribor );
        Disable ( frmDatiDett.chkSpesaComplessiva );
          
        if(frmDatiDett.calendario.disabled)
          EnableLink ( document.links[0], frmDatiDett.calendario);
        if(frmDatiDett.cancella_data.disabled)
          EnableLink ( document.links[1], frmDatiDett.cancella_data);
        Enable ( frmDatiDett.calendario );
        Enable ( frmDatiDett.cancella_data );
    }     
    else {
        Disable ( frmDatiDett.RinnovoNoleggio );
        Disable ( frmDatiDett.TempoPreavviso );
        Disable ( frmDatiDett.PrimoNoleggio );
        Disable ( frmDatiDett.dataFineNoleggio );
        Disable ( frmDatiDett.chkEuribor );
        Disable ( frmDatiDett.chkSpesaComplessiva );
          
        if(!frmDatiDett.calendario.disabled)
          DisableLink ( document.links[0], frmDatiDett.calendario);
        if(!frmDatiDett.cancella_data.disabled)
          DisableLink ( document.links[1], frmDatiDett.cancella_data);
        Disable ( frmDatiDett.calendario );
        Disable ( frmDatiDett.cancella_data );          
    }       
  }
  else {
    Disable ( frmDatiDett.RinnovoNoleggio );
    Disable ( frmDatiDett.TempoPreavviso );
    Disable ( frmDatiDett.PrimoNoleggio );
    Disable ( frmDatiDett.dataFineNoleggio );
    Disable ( frmDatiDett.chkEuribor );
    Disable ( frmDatiDett.chkSpesaComplessiva );
          
    if(!frmDatiDett.calendario.disabled)
      DisableLink ( document.links[0], frmDatiDett.calendario);
    if(!frmDatiDett.cancella_data.disabled)
      DisableLink ( document.links[1], frmDatiDett.cancella_data);
    Disable ( frmDatiDett.calendario );
    Disable ( frmDatiDett.cancella_data );
  }
}

function ONSELEZIONA(){

  Enable ( frmDatiDett.RinnovoNoleggio );
  Enable ( frmDatiDett.TempoPreavviso );
  Enable ( frmDatiDett.PrimoNoleggio );
  Enable ( frmDatiDett.dataFineNoleggio );
  Enable ( frmDatiDett.chkEuribor );
  Enable ( frmDatiDett.chkSpesaComplessiva );
        
  parent.frmDati.cboModalNoleg.value = document.frmDatiDett.cboModalNoleg.value;
  parent.frmDati.PrimoNoleggio.value = document.frmDatiDett.PrimoNoleggio.value;
  parent.frmDati.RinnovoNoleggio.value = document.frmDatiDett.RinnovoNoleggio.value;
  parent.frmDati.TempoPreavviso.value = document.frmDatiDett.TempoPreavviso.value;
  parent.frmDati.chkSpesaComplessiva.value = document.frmDatiDett.chkSpesaComplessiva.checked;
  parent.frmDati.chkEuribor.value = document.frmDatiDett.chkEuribor.checked;
  parent.frmDati.dataFineNoleggio.value = document.frmDatiDett.dataFineNoleggio.value;
  if(document.frmDatiDett.cboModalNoleg.value != '')
    return true;
  else
    return false;
}

function change_cboModalNoleg_first(){
  if (valCboModalNoleg!=frmDatiDett.cboModalNoleg.value){
    valCboModalNoleg=frmDatiDett.cboModalNoleg.value;
    
    if ( 1 == frmDatiDett.cboModalNoleg.value ) {
        Enable ( frmDatiDett.RinnovoNoleggio );
        Enable ( frmDatiDett.TempoPreavviso );
        Enable ( frmDatiDett.PrimoNoleggio );
        Enable ( frmDatiDett.chkEuribor );
        Enable ( frmDatiDett.chkSpesaComplessiva );
        Disable ( frmDatiDett.dataFineNoleggio );
          
        if(!frmDatiDett.calendario.disabled)
          DisableLink ( document.links[0], frmDatiDett.calendario);
        if(!frmDatiDett.cancella_data.disabled)
          DisableLink ( document.links[1], frmDatiDett.cancella_data);
        Disable ( frmDatiDett.calendario );
        Disable ( frmDatiDett.cancella_data );   
    } 
    else if (
      ( 2 ==  frmDatiDett.cboModalNoleg.value )
      ||
      ( 3 ==  frmDatiDett.cboModalNoleg.value ) 
      ||
      ( 6 ==  frmDatiDett.cboModalNoleg.value )       
      ){
        Disable ( frmDatiDett.RinnovoNoleggio );
        Disable ( frmDatiDett.TempoPreavviso );
        Disable ( frmDatiDett.PrimoNoleggio );
        Disable ( frmDatiDett.dataFineNoleggio );
        Enable ( frmDatiDett.chkEuribor );
        Enable ( frmDatiDett.chkSpesaComplessiva );
          
        if(!frmDatiDett.calendario.disabled){
          DisableLink ( document.links[0], frmDatiDett.calendario);
        }
        if(!frmDatiDett.cancella_data.disabled)
          DisableLink ( document.links[1], frmDatiDett.cancella_data);
        Disable ( frmDatiDett.calendario );
        Disable ( frmDatiDett.cancella_data );
    } 
    else if ( 4 ==  frmDatiDett.cboModalNoleg.value ) {
        Disable ( frmDatiDett.RinnovoNoleggio );
        Disable ( frmDatiDett.TempoPreavviso );
        Enable ( frmDatiDett.PrimoNoleggio );
        Disable ( frmDatiDett.dataFineNoleggio );
        Enable ( frmDatiDett.chkEuribor );
        Enable ( frmDatiDett.chkSpesaComplessiva );
          
        if(!frmDatiDett.calendario.disabled)
          DisableLink ( document.links[0], frmDatiDett.calendario);
        if(!frmDatiDett.cancella_data.disabled)
          DisableLink ( document.links[1], frmDatiDett.cancella_data);
        Disable ( frmDatiDett.calendario );
        Disable ( frmDatiDett.cancella_data );
    } 
    else if ( 5 == frmDatiDett.cboModalNoleg.value ) {
        Disable ( frmDatiDett.RinnovoNoleggio );
        Enable ( frmDatiDett.TempoPreavviso );
        Disable ( frmDatiDett.PrimoNoleggio );
        Enable ( frmDatiDett.dataFineNoleggio );
        Enable ( frmDatiDett.chkEuribor );
        Enable ( frmDatiDett.chkSpesaComplessiva );
          
        if(frmDatiDett.calendario.disabled)
          EnableLink ( document.links[0], frmDatiDett.calendario);
        if(frmDatiDett.cancella_data.disabled)
          EnableLink ( document.links[1], frmDatiDett.cancella_data);
        Enable ( frmDatiDett.calendario );
        Enable ( frmDatiDett.cancella_data );

        frmDatiDett.TempoPreavviso.value = '30';
        frmDatiDett.TempoPreavviso.readOnly = false;        
    } 
    else {
        Disable ( frmDatiDett.RinnovoNoleggio );
        Disable ( frmDatiDett.TempoPreavviso );
        Disable ( frmDatiDett.PrimoNoleggio );
        Disable ( frmDatiDett.dataFineNoleggio );
        Disable ( frmDatiDett.chkEuribor );
        Disable ( frmDatiDett.chkSpesaComplessiva );
          
        if(!frmDatiDett.calendario.disabled)
          DisableLink ( document.links[0], frmDatiDett.calendario);
        if(!frmDatiDett.cancella_data.disabled)
          DisableLink ( document.links[1], frmDatiDett.cancella_data);
        Disable ( frmDatiDett.calendario );
        Disable ( frmDatiDett.cancella_data );        
    }
  }else {
    Disable ( frmDatiDett.RinnovoNoleggio );
    Disable ( frmDatiDett.TempoPreavviso );
    Disable ( frmDatiDett.PrimoNoleggio );
    Disable ( frmDatiDett.dataFineNoleggio );
    Disable ( frmDatiDett.chkEuribor );
    Disable ( frmDatiDett.chkSpesaComplessiva );
          
    if(!frmDatiDett.calendario.disabled)
      DisableLink ( document.links[0], frmDatiDett.calendario);
    if(!frmDatiDett.cancella_data.disabled)
      DisableLink ( document.links[1], frmDatiDett.cancella_data);
    Disable ( frmDatiDett.calendario );
    Disable ( frmDatiDett.cancella_data );

    frmDatiDett.chkEuribor.checked = false;
    frmDatiDett.chkSpesaComplessiva.checked = false;  
  }
}


</script>
<title>Prodotti Dettaglio</title>
</head>
<body>
<form name = "frmDatiDett" method="post">
<input type="hidden" name="RepCaratt" id="RepCaratt" value="N">
<input type="hidden" name="ModApplNol" value="<%=dbTempoNoleggio.getCODE_MODAL_APPLICAB_NOLEG()%>">

<TABLE ALIGN=center BORDER=4 CELLPADDING=4 CELLSPACING=4 WIDTH=80% HEIGHT=10>
  <tr>
    <td class="text" nowrap>Modalità Applicazione Noleggio:</td>
    <td colspan="5">
      <select class="text" title="Noleggio" name="cboModalNoleg" onchange="change_cboModalNoleg();" >
        <option class="text"  value="">[Seleziona Modalità Applicazione Noleggio]</option>
      </select>
    </td>
  </tr>
  <tr>
    <TD class="text" nowrap> 
      <font id="DescPrimoNoleggio" name="DescPrimoNoleggio"> 
        Tempo Primo Noleggio (mm):
      </font>
    </td>
    <td>
      <INPUT type="text" class="text" name="PrimoNoleggio" style="text-align:right;" id="PrimoNoleggio" size="10" maxlength=3  value="<%=dbTempoNoleggio.getVALORE_PRIMO_NOLEGGIO()%>">
    </TD>
    <TD class="text" nowrap> 
      <font id="DescRinnovoNoleggio" name="DescRinnovoNoleggio">
        Tempo Rinnovo Noleggio (mm):
      </font>
    </td>
    <td>
      <INPUT type="text" class="text" style="text-align:right;" id="RinnovoNoleggio" name="RinnovoNoleggio" label="Rinnovo Noleggio" size="10" maxlength=9 value="<%=dbTempoNoleggio.getVALORE_RINNOVO_NOLEGGIO()%>">
    </TD>
    <TD class="text" nowrap> 
      <font id="DescTempoPreavviso" name="DescTempoPreavviso">
        Tempo Preavviso (gg):
      </font>
    </td>
    <td colspan="3">
      <INPUT type="text" class="text" style="text-align:right;" id="TempoPreavviso" name="TempoPreavviso" label="Tempo Preavviso" size="10" maxlength=9 value="<%=dbTempoNoleggio.getVALORE_TEMPO_PREAVVISO()%>">
    </TD>
  </tr>
  <tr>
    <td class="text" nowrap>
      <FONT id="DescSpesa" name="DescSpesa">
        Partecipa al Calcolo di Spesa complessiva:
      </FONT>
    </td>
    <td>
      <input type="checkbox" class="text" value="Y" name="chkSpesaComplessiva">
    </td>
    <td class="text" nowrap>
      <FONT id="DescEuribor" name="DescEuribor">
        Applicazione Euribor:
      </font>
    </td>
    <td>
      <input type="checkbox" class="text" value="Y" name="chkEuribor">
    </td>
    <TD class="text" nowrap> 
      <font id="DescDataFineNoleggio" name="DescDataFineNoleggio">
        Data Fine Noleggio :
      </font>
    </td>
    <td  class="text" align="left" colspan="3" nowrap="nowrap">
       <input type="text" class="text" size=12 maxlength="12" name="dataFineNoleggio" id="dataFineNoleggio" title="dataFineNoleggio" value="<%=dbTempoNoleggio.getDATA_FINE_NOL()%>" readonly> <!--onblur="handleblur('dataFineNoleggio');-->
       <a href="javascript:cal1.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario' src="../../common/images/img/cal.gif" border="no"></a>
       <a href="javascript:cancelCalendar(document.frmDatiDett.dataFineNoleggio);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data' src="../../common/images/img/images7.gif" border="0"></a>
    </td>
  </tr>
      <input type="hidden" value="N" name="chkReplicaCaratteristiche">

</TABLE>
</form>
</body>
<script language="JavaScript">
  // Calendario Data Inizio Validità
  var cal1 = new calendar1(document.forms['frmDatiDett'].elements['dataFineNoleggio']);
  cal1.year_scroll = true;
  cal1.time_comp = false;
  Initialize();
  document.frmDatiDett.cboModalNoleg.value = document.frmDatiDett.ModApplNol.value;
  change_cboModalNoleg_first();
 </script>
</HTML>