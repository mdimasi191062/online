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
  <%=StaticMessages.getMessage(3006,"elab_ver.jsp")%>
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
<body onfocus=" ControllaFinestra()" onmouseover="ControllaFinestra()">
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  function cboElaborazioniChange(obj){
    window.location.replace('elab_ver.jsp?CodeFunz=' + obj.value);
  }

  function ONAGGIORNA(){
    window.location.reload();
  }

  function ONSELEZIONA(){
      var i;
      if(document.all('CodeElab').length!=null && document.all('CodeElab').length!=undefined){
        for(i=0;i<document.all('CodeElab').length;i++){
          if(document.all('CodeElab')[i].checked==true)
            break;
        }
        if(i==document.all('CodeElab').length){
          alert('Occorre selezionare un\'elaborazione.');
          return;
        }
      }
      else{
        if(document.all('CodeElab').checked!=true){
          alert('Occorre selezionare un\'elaborazione.');
          return;
        }
      }
      frmDati.action = 'elab_dett.jsp';
      frmDati.submit();
  }
  
</SCRIPT>
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
  String strCodeFunz = Misc.nh(request.getParameter("CodeFunz"));
  Vector vctElabBatch = remoteCtr_ElabAttive.getVerificaElabAttive(strCodeFunz);
  DB_ElabBatch objElabBatch = null;
  DB_ElabAttive objElabAttiva = null;
  Vector vctElabAttive = remoteCtr_ElabAttive.getElabAttive();
  String strNameFirstPage = "elab_ver.jsp?CodeFunz=" + strCodeFunz;
  String strtypeLoad = request.getParameter("hidTypeLoad");
  int intRecXPag = 300;
  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
  
%>
<form name="frmDati" method="post" action="">
<table name="tblElab" id="tblElab" align=center width="90%" border="0" cellspacing="0" cellpadding="0" height="100%" style="display:none">
<input type="hidden" name="hidTypeLoad" value="">
<tr height="30">
  <td>
  <table width="100%">
    <tr>
      <td><img src="../images/VerificaElaborazione.GIF" alt="" border="0"></td>
      <td align="right">
          <Select name="cboElaborazioni" id="cboElaborazioni" class="text" onchange="cboElaborazioniChange(this);">
            <%
              for(int i=0;i<vctElabAttive.size();i++){
                objElabAttiva = (DB_ElabAttive)vctElabAttive.get(i);
                %>
                <option value="<%=objElabAttiva.getCODE_FUNZ()%>"><%=objElabAttiva.getDESC_FUNZ()%></option>
                <%
              }
            %>
          </Select>
      </td>
    </tr>
  </table>
  </td>
</tr>
<tr height="20">
  <td>
    <table>
      <tr>
        <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
        <td  class="text">
        <select class="text" name="cboNumRecXPag" onchange="reloadPage('1','<%=strNameFirstPage%>')">
          <%for(int k = 300;k >= 50; k=k-50){%>
          <option class="text" value="<%=k%>"><%=k%></option>
          <%}%>
        </select>
        </td>
      </tr>
     </table>
  </td>
</tr>
<tr height="20">
  <td>
    <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">
          Verifica elaborazioni
        </td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctElabBatch.size()%>">
    <table width="100%" cellspacing="1" align="center">
      <%if(vctElabBatch.size()!=0){%>
        <tr class="rowHeader" height="20" align="center">
            <td width="10" class="textB" >&nbsp;</td>
            <td >Code Elab.</td>
            <td >Utente</td>
            <td >Data/Ora<BR>Inizio Elaboraz.</td>
            <td >Data/Ora<BR>Fine Elaboraz.</td>
            <td >Num.Elementi<BR>Elaborati</td>
            <td >Num.Elementi<BR>Scartati</td>        
            <td >Num.Scarti</td>        
            <td >Tipo lancio</td>
            <td >Stato</td>
            <td >&nbsp;</td>
        </tr>
      <% 
        String classRow = "row2"; 
        //for(int i=0;i<vctElabBatch.size();i++){
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctElabBatch.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           objElabBatch = (DB_ElabBatch)vctElabBatch.get(i);
           %>
           <TR>
            <td  class="<%=classRow%>">
              <input type="radio" name="CodeElab" value="<%=objElabBatch.getCODE_ELAB()%>">                
            </td>
            <td  class="<%=classRow%>" align="center" width="40"><%=objElabBatch.getCODE_ELAB()%></td>
            <td  class="<%=classRow%>" align="center"><%=objElabBatch.getCODE_UTENTE()%></td>            
            <td  class="<%=classRow%>" align="center"><%=objElabBatch.getDATA_INIZIO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objElabBatch.getDATA_FINE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objElabBatch.getNUM_ELEM_ELABORATI()%></td>
            <td  class="<%=classRow%>" align="center"><%=objElabBatch.getNUM_ELEM_SCARTATI()%></td>
            <td  class="<%=classRow%>" align="center"><%=objElabBatch.getNUM_SCARTI()%></td>        
            <td  class="<%=classRow%>" align="center">
            <%
              if(objElabBatch.getFLAG_LANCIO_BATCH().equals("O")){
                out.println("On line");
              }
              /* QS 20-12-2007: Aggiunta per export GECOM */
              else if (objElabBatch.getFLAG_LANCIO_BATCH().equals("G")){
                out.println("On line - Gecom");
              }
              else{
                out.println("Manuale");
              }
            %>
            </td>
            <td  class="<%=classRow%>" align="center">
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
            <td class="<%=classRow%>" align="center">
            <%if(!objElabBatch.getRETURN_CODE().equals("") && !objElabBatch.getRETURN_CODE().equals("0")){%>
            <img src="<%=StaticContext.PH_COMMON_IMAGES%>error.gif" alt="Visualizza errore" onclick="descError('<%=objElabBatch.getRETURN_CODE()%>')" style="cursor:hand">
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
    <A HREF="javaScript:goPage('<%= pageUrl %>&CodeFunz=<%=strCodeFunz%>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage('<%= pageUrl %>&CodeFunz=<%=strCodeFunz%>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage('<%= pageUrl %>&CodeFunz=<%=strCodeFunz%>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
    </pg:next>
    </pg:index>
    </pg:pager>
  </td>
</tr>
<tr height="28">
  <%
  if (strCodeFunz.equals("ALL_PREINVE") ||
      strCodeFunz.equals("EXPORT_MENSILE") ||
      strCodeFunz.equals("EXPORT_SWN_REPR") ||
      strCodeFunz.equals("EXPORT_SWN_VAL") ||
      strCodeFunz.equals("ELABORAZIONE_PREINVENTARIO") ||
      strCodeFunz.equals("ALL_PREINVE_OD") ||
      strCodeFunz.equals("ALL_PRE_CATALOGO") ||
      strCodeFunz.equals(StaticContext.RIBES_J2_CONSUNTIVO_SAP) ||
      strCodeFunz.equals(StaticContext.RIBES_J2_EXPORT_REPRICING)
      ){
  %>
  <td >
    <sec:ShowButtons td_class="textB" force_singleButton="AGGIORNA"/>
  </td>
  <%
  } else {
  %>
  <td >
    <sec:ShowButtons td_class="textB"/>
  </td>
  <%
  }
  %>
</tr>
</TABLE>
</FORM>
</body>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  frmDati.cboElaborazioni.value = '<%=strCodeFunz%>';
  frmDati.cboNumRecXPag.value = '<%=intRecXPag%>';
  document.all('tblElab').style.display = '';
  document.all('tblLoad').style.display = 'none';
</SCRIPT>
</html>