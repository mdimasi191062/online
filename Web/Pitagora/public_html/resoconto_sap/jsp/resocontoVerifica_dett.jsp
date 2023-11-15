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
<%@ taglib uri="/webapp/pg" prefix="pg" %>

<sec:ChkUserAuth />

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
  <%=StaticMessages.getMessage(3006,"resocontoVerifica_dett.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttiveHome" location="Ctr_ElabAttive" />
<EJB:useBean id="remoteCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttive" scope="session">
    <EJB:createBean instance="<%=homeCtr_ElabAttive.create()%>" />
</EJB:useBean>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title></title>
</head>
<script src="<%=StaticContext.PH_ELAB_ATT_JS%>ElabAttive.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<body>
<table name="tblLoad" id="tblLoad" align=center width="90%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <Tr>
    <Td align="center" valgn="middle" height="100%" width="100%" class="text">
      <IMG name="imgProgress" id="imgProgress" alt="Elaborazione in corso" src="<%=StaticContext.PH_COMMON_IMAGES%>orologio.gif">
      <Br>
      Elaborazione in corso...
    </Td>
  </Tr>
</table>
<%
  out.flush();
  String strCodeFunz = "RESOCONTO_SAP";
  String strCodeElab = Misc.nh(request.getParameter("CodeElab"));

  DB_ElabBatchResocontoSAP objElabBatch = remoteCtr_ElabAttive.getVerificaElabAttivaResoconto(strCodeFunz,strCodeElab);
  DB_ElabBatchDettaglioResoconto objElabBatchDett = null;
  
  Vector vctElabBatchDett = null;
  vctElabBatchDett = remoteCtr_ElabAttive.getVerificaDettaglioElabAttive("getdettverificaResocontoSap",strCodeElab);


  String strNameFirstPage = "resocontoVerificaDett?CodeElab=" + strCodeElab;
  String strtypeLoad = request.getParameter("hidTypeLoad");
  int intRecXPag = 300;
  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
  
%>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  function ONAGGIORNA(){
    window.location.reload();
  }
  
  function ONCERCA(){
    frmDati.action = 'resocontoVerifica_dett.jsp?CodeElab=<%=strCodeElab%>';
    frmDati.submit();
  }

  function ONANNULLA(){
    location.replace('resocontoVerifica.jsp');
  }
  
  function descErrorResoconto(CodeError){
    openCentral('../../elab_attive/jsp/elab_desc_error.jsp?CodeError=' + CodeError,'DescError','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',400,400);
  }

</SCRIPT>

<form name="frmDati" method="post" action="">
<table name="tblElab" id="tblElab" align=center width="90%" border="0" cellspacing="0" cellpadding="0" height="100%" style="display:none">
<input type="hidden" name="hidTypeLoad" value="">
<tr height="30">
  <td>
  <table width="100%">
    <tr>
      <td><img src="../../elab_attive/images/VerificaElaborazione.GIF" alt="" border="0"></td>
    </tr>
  </table>
  </td>
</tr>
<tr height="20">
  <td>
    <table width="100%" border="0">
      <tr>
        <td class="textB" align="right" width="130">Risultati per pag.:&nbsp;</td>
        <td  class="text" align="left">
        <select class="text" name="cboNumRecXPag" onchange="reloadPage('1','<%=strNameFirstPage%>')">
          <%for(int k = 300;k >= 50; k=k-50){%>
          <option class="text" value="<%=k%>"><%=k%></option>
          <%}%>
        </select>
        </td>
        <TD class="textB" align="right">
          Resoconto Valorizzazione
        </TD>
      </tr>
     </table>
  </td>
</tr>
<tr height="20">
  <td>
    <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">
          Dettaglio verifica elaborazioni
        </td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top" height="50">
  <TD>
    <table width="100%" cellspacing="1" align="center">
        <tr class="rowHeader" height="20" align="center">
            <td >Code Elab.</td>
            <td >Utente</td>
            <td >Data/Ora<BR>Inizio Elaboraz.</td>
            <td >Data/Ora<BR>Fine Elaboraz.</td>
            <td >Tipo lancio</td>
            <td >Stato</td>
        </tr>
           <TR>
            <td  class="row1" align="center" width="40"><%=objElabBatch.getCODE_ELAB()%></td>
            <td  class="row1" align="center"><%=objElabBatch.getCODE_UTENTE()%></td>            
            <td  class="row1" align="center"><%=objElabBatch.getDATA_INIZIO()%></td>
            <td  class="row1" align="center"><%=objElabBatch.getDATA_FINE()%></td>
            <td  class="row1" align="center"><%=objElabBatch.getREWRITE()%></td>
            <td  class="row1" align="center">
            <%
              if(objElabBatch.getCODE_STATO_BATCH().equals("INIT")){
                out.println("Inizializzato");
              }
              else if(objElabBatch.getCODE_STATO_BATCH().equals("RUNN")){
                out.println("In esecuzione");
              }
              else if(objElabBatch.getCODE_STATO_BATCH().equals("DUMP")){
                out.println("Interrotto");
              }
              else if(objElabBatch.getCODE_STATO_BATCH().equals("SUCC")){
                out.println("Terminato");
              }
              else if(objElabBatch.getCODE_STATO_BATCH().equals("CLOS")){
                out.println("In chiusura");
              }
            %>
            </td>
            
         </TR>
    </table>      
  </TD>
</TR>
<TR>
  <TD>
  <HR>
  </TD>
</TR>

<TR valign="top" height="100%" >
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctElabBatchDett.size()%>">
    <table width="100%" cellspacing="1" align="center">
      <%if(vctElabBatchDett.size()!=0){
        objElabBatchDett = (DB_ElabBatchDettaglioResoconto)vctElabBatchDett.get(0);%>
        <tr class="rowHeader" height="20" align="center">
            <td>&nbsp;</td>
            <td>Servizi</td>
            <td>Sistema</td>
            <td>Data inizio</td>
            <td>Data fine</td>
            <td>Stato</td>
            <td>&nbsp;</td>            
        </tr>
      <% 
        String classRow = "row2"; 
        String strOptValue = "";
        //for(int i=0;i<vctElabBatch.size();i++){
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctElabBatchDett.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           objElabBatchDett = (DB_ElabBatchDettaglioResoconto)vctElabBatchDett.get(i);
           strOptValue = objElabBatchDett.getCODE_SERVIZIO();
           %>
           <TR height="20">
            <td  class="<%=classRow%>">
              <input type="radio" name="GestResoconto" id="GestResoconto" value="<%=strOptValue%>" 
              descServ="<%=objElabBatchDett.getDESC_SERVIZIO()%>"
              dataInizio="<%=objElabBatchDett.getDATA_INIZIO()%>"
              dataFine="<%=objElabBatchDett.getDATA_FINE()%>"
              sistema="<%=objElabBatchDett.getTIPO_SISTEMA()%>"
              stato="<%=objElabBatchDett.getCODE_STATO_PROC()%>">
            </td>
            <td class="<%=classRow%>" align="center"><%=objElabBatchDett.getDESC_SERVIZIO()%></td>
            <td class="<%=classRow%>" align="center"><%=objElabBatchDett.getTIPO_SISTEMA()%></td>
            <td class="<%=classRow%>" align="center"><%=objElabBatchDett.getDATA_INIZIO()%></td>
            <td class="<%=classRow%>" align="center"><%=objElabBatchDett.getDATA_FINE()%></td>       
            <td  class="<%=classRow%>" align="center">
            <%
              if(objElabBatchDett.getCODE_STATO_PROC().equals("INIT")){
                out.println("Inizializzato");
              }
              else if(objElabBatchDett.getCODE_STATO_PROC().equals("RUNN")){
                out.println("In esecuzione");
              }
              else if(objElabBatchDett.getCODE_STATO_PROC().equals("DUMP")){
                out.println("Interrotto");
              }
              else if(objElabBatchDett.getCODE_STATO_PROC().equals("SUCC")){
                out.println("Terminato");
              }
              else if(objElabBatchDett.getCODE_STATO_PROC().equals("CLOS")){
                out.println("In chiusura");
              }
            %>
            </td>
            <td class="<%=classRow%>" align="center">
            <%if(!objElabBatchDett.getRETURN_CODE().equals("") && !objElabBatchDett.getRETURN_CODE().equals("0")){%>
            <img src="<%=StaticContext.PH_COMMON_IMAGES%>error.gif" alt="Visualizza errore" onclick="descErrorResoconto('<%=objElabBatchDett.getRETURN_CODE()%>')" style="cursor:hand">
            <%}%>
            </td>
            </TR>
           <%
           }
      }
      else{%>
        <tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
          <td width="8%" height="20" class="textB" align="center">Nessun dato da visualizzare!</td>
        </tr>
      <%}%>
    </table>
  </TD>
<TR>
<tr height="28" class="text">
  <td >
    <pg:index>
       Risultati Pag.
    <pg:prev> 
    <A HREF="javaScript:goPage(''resocontoVerifica.jsp&CodeElab=<%=strCodeElab%>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage(''resocontoVerifica.jsp&CodeElab=<%=strCodeElab%>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage(''resocontoVerifica.jsp&CodeElab=<%=strCodeElab%>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
    </pg:next>
    </pg:index>
    </pg:pager>
  </td>
</tr>
<tr height="28">
  <td >
    <sec:ShowButtons td_class="textB"/>
  </td>
</tr>
</TABLE>
</FORM>
</body>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  frmDati.cboNumRecXPag.value = '<%=intRecXPag%>';
  document.all('tblElab').style.display = '';
  document.all('tblLoad').style.display = 'none';
</SCRIPT>
</html>