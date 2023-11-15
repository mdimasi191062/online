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
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/Tar" prefix="tar" %>

<sec:ChkUserAuth isModal="true"/>
 
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_select_tariffa_rif.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_TariffeNew" type="com.ejbSTL.Ent_TariffeNewHome" location="Ent_TariffeNew" />
<EJB:useBean id="remoteEnt_TariffeNew" type="com.ejbSTL.Ent_TariffeNew" scope="session">
    <EJB:createBean instance="<%=homeEnt_TariffeNew.create()%>" />
</EJB:useBean>

<%
   int tipo_Tariffa  = 0;
   String appotipoTariffa = Misc.nh(request.getParameter("tipo_tariffa"));
   if (appotipoTariffa.equalsIgnoreCase("1")){
      tipo_Tariffa = Integer.parseInt(request.getParameter("tipo_tariffa"));
  }
  
   int Code_Servizio = Integer.parseInt(request.getParameter("CodeServizio"));
   int Code_Offerta = Integer.parseInt(request.getParameter("CodeOfferta"));
   int Code_Prodotto = Integer.parseInt(request.getParameter("CodeProdotto"));
   String Code_Componente = Misc.nh(request.getParameter("CodeComponente"));
   String Code_PrestAgg = Misc.nh(request.getParameter("CodePrestAgg"));
   String Code_Classe = Misc.nh(request.getParameter("CodeClasse"));
   String Code_Fascia = Misc.nh(request.getParameter("CodeFascia"));
   Code_Componente = Code_Componente.equals("") ? "0" : Code_Componente;
   Code_PrestAgg = Code_PrestAgg.equals("") ? "0" : Code_PrestAgg;
   Code_Classe = Code_Classe.equals("") ? "0" : Code_Classe;
   Code_Fascia = Code_Fascia.equals("") ? "0" : Code_Fascia;   
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<%if (tipo_Tariffa != 0) { %>
   <LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style1.css" TYPE="text/css">
<% } %>
<title>
tariffa di riferimento per tariffa percentuale
</title>
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>
</head>
<body>
<title>
Seleziona tariffa di riferimento per tariffa percentuale
</title>
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>
</head>
<body>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  var colorRow = 'row2';
  var winOpener = null;
  var tblTariffeRif = null;
  winOpener = window.opener;
  tblTariffeRif = winOpener.document.all('tblTariffeRiferimento');

  function  selectCheck(){
    var valTariffaRif = "";
    var arrCheck = document.all('CodeTariffa');    

    for (i=1;i<tblTariffeRif.rows.length;i++){
      valTariffaRif = winOpener.document.all('TARRIF-' + i).value;
      if(arrCheck.length != undefined){       
        for(z=0;z<arrCheck.length;z++){
          if(arrCheck[z].value == valTariffaRif){
              arrCheck[z].checked=true;
              break;
          }
        }
  	  }
      else{
        if(arrCheck.value == valTariffaRif){
          arrCheck.checked=true;
          break;
        }
      }
    }    
  }
  
  function ONSELEZIONA(){
    var myOpt = null;
    var i=0;
    var z=0;

    if(document.all('CodeTariffa')==null)
      return;
      
    if(document.all('CodeTariffa').length != undefined){    
    
	    for(i=0;i<document.all('CodeTariffa').length;i++){
	      myOpt = document.all('CodeTariffa')[i];
	      if(myOpt.checked==true){
	        break;
	      }
	    }
	    
	    if(i==document.all('CodeTariffa').length){
	      alert('Occorre selzionare almeno una tariffa.');
	      return;
	    }
    }
    else{
    	if(document.all('CodeTariffa').checked!=true){
	      alert('Occorre selzionare almeno una tariffa.');
	      return;
    	}
    }

    for (i=tblTariffeRif.rows.length;i>1;i--){
      tblTariffeRif.deleteRow(i-1);  
    }

    if(document.all('CodeTariffa').length != undefined){       
	    for(i=0;i<document.all('CodeTariffa').length;i++){
	      myOpt = document.all('CodeTariffa')[i];
	      if(myOpt.checked==true){
	        z++;
	        caricaTabellaTariffeRif(myOpt,tblTariffeRif,z);
	      }
	    }
    }
    else{
    	caricaTabellaTariffeRif(document.all('CodeTariffa'),tblTariffeRif,1);
    }
    window.close();
  }

</SCRIPT>

    <TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
      <TR height="20">
        <TD>
          <TABLE  height="100%" width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <TR align="center">
              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white">
                Seleziona tariffa di riferimento per tariffa percentuale
              </TD>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%">
                <IMG alt=tre src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width=28>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
      <TR bgcolor="<%=StaticContext.bgColorCellaBianca%>">
        <TD align="center" valign="center">
          <DIV>
          <tar:TableTar CodeServizio="<%=Code_Servizio%>" CodeOfferta="<%=Code_Offerta%>" CodeProdotto="<%=Code_Prodotto%>" CodeComponente="<%=Code_Componente%>" CodePrestAgg="<%=Code_PrestAgg%>" CodeClasse="<%=Code_Classe%>" CodeFascia="<%=Code_Fascia%>"  ClassRow1="row1" ClassRow2="row2" ClassIntest="rowHeader" tipoTariffa="<%=tipo_Tariffa%>"/>
          </DIV>
        </TD>
      </TR>
      <TR height="20" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
        <TD>
          <TABLE align="center" width="100%" border="0">
            <TR>
              <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="left">
                <sec:ShowButtons td_class="textB"/>
              </td>
            </TR>
          </TABLE>
        </TD>
      </TR>
    </TABLE>
</body>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  selectCheck();
</SCRIPT>
</html>
