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
  <%=StaticMessages.getMessage(3006,"elab_scarti.jsp")%>
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
  String strCodeFunz = Misc.nh(request.getParameter("cboElaborazioni"));
  String strCodeElab = Misc.nh(request.getParameter("CodeElab"));
  String strGestAcc  = Misc.nh(request.getParameter("GestAcc"));
  DB_ElabBatch objElabBatch = remoteCtr_ElabAttive.getVerificaElabAttiva(strCodeFunz,strCodeElab);  
  DB_ElabAttive objElabAttiva = remoteCtr_ElabAttive.getElabAttiva(strCodeFunz);

  String strDescAcc				  = Misc.nh(request.getParameter("descAcc"));      
  String strDescGest				= Misc.nh(request.getParameter("descGest"));      
  String strNumElab				  = Misc.nh(request.getParameter("numElab"));      
  String strNumElemScartati	= Misc.nh(request.getParameter("numElemScartati"));      
  String strNumScartati			= Misc.nh(request.getParameter("numScartati"));      
  String strDataInizio			= Misc.nh(request.getParameter("dataInizio"));      
  String strDataFine				= Misc.nh(request.getParameter("dataFine"));      
  String strDataInizioPeriodo=Misc.nh(request.getParameter("dataInizioPeriodo"));  
  String strDataFinePeriodo	= Misc.nh(request.getParameter("dataFinePeriodo"));  
  String strDataDescrizioneCiclo=Misc.nh(request.getParameter("dataDescrizioneCiclo"));  
  

  DB_ScartiNew objScarti = null;
  Vector vctScarti = remoteCtr_ElabAttive.getScartiElabAttive(objElabAttiva.getQUERY_SCARTI(),strGestAcc,strCodeElab);
   
  String strNameFirstPage = "elab_scarti.jsp?" + request.getQueryString(); 
  String strtypeLoad = request.getParameter("hidTypeLoad");
  int intRecXPag = 5;
  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
  
%>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  function ONAGGIORNA(){
    window.location.reload();
  }
  function ONANNULLA(){
    location.replace('elab_dett.jsp?CodeElab=<%=strCodeElab%>&cboElaborazioni=<%=strCodeFunz%>');
  }
  
</SCRIPT>

<form name="frmDati" method="post" action="">
<table name="tblElab" id="tblElab" align=center width="90%" border="0" cellspacing="0" cellpadding="0" height="100%" style="display:none">
<input type="hidden" name="hidTypeLoad" value="">
<tr height="30">
  <td>
  <table width="100%">
    <tr>
      <td><img src="../images/VerificaElaborazione.GIF" alt="" border="0"></td>
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
          <%for(int k = 5;k <= 50; k=k+5){%>
          <option class="text" value="<%=k%>"><%=k%></option>
          <%}%>
        </select>
        </td>
        <TD class="textB" align="right">
          <%=objElabAttiva.getDESC_FUNZ()%>
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
          Scarti elaborazioni
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
            <td >Num.Elementi<BR>Elaborati</td>
            <td >Num.Elementi<BR>Scartati</td>        
            <td >Num.Scarti</td>        
            <td >Tipo lancio</td>
            <td >Stato</td>
        </tr>
           <TR>
            <td  class="row1" align="center" width="40"><%=objElabBatch.getCODE_ELAB()%></td>
            <td  class="row1" align="center"><%=objElabBatch.getCODE_UTENTE()%></td>            
            <td  class="row1" align="center"><%=objElabBatch.getDATA_INIZIO()%></td>
            <td  class="row1" align="center"><%=objElabBatch.getDATA_FINE()%></td>
            <td  class="row1" align="center"><%=objElabBatch.getNUM_ELEM_ELABORATI()%></td>
            <td  class="row1" align="center"><%=objElabBatch.getNUM_ELEM_SCARTATI()%></td>
            <td  class="row1" align="center"><%=objElabBatch.getNUM_SCARTI()%></td>        
            <td  class="row1" align="center">
            <%
              if(objElabBatch.getFLAG_LANCIO_BATCH().equals("O")){
                out.println("On line");
              }
              else{
                out.println("Manuale");
              }
            %>
            </td>
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
    <table width="100%" cellspacing="1" align="center">
        <tr class="rowHeader" height="20" align="center">
            <%if(!strDescGest.equals("")){%>
            <td>Gestore</td>
            <%}%>
            <%if(!strDescAcc.equals("")){%>
            <td>Account</td>
            <%}%>
            <%if(!strDataInizio.equals("")){%>
            <td>Data inizio</td>
            <%}%>
            <%if(!strDataFine.equals("")){%>
            <td>Data fine</td>
            <%}%>
            <%if(!strDataInizioPeriodo.equals("")){%>
            <td>Data inizio periodo</td>
            <%}%>
            <%if(!strDataFinePeriodo.equals("")){%>
            <td>Data fine periodo</td>
            <%}%>
            <%if(!strDataDescrizioneCiclo.equals("")){%>
            <td>Ciclo</td>
            <%}%>
            <td>Num.Elementi<BR>Elaborati</td>
            <td>Num.Elementi<BR>Scartati</td>        
            <td>Num.Scarti</td>        
        </tr>
        <tr height="20" align="center">
            <%if(!strDescGest.equals("")){%>
            <td class="row1" align="center"><%=strDescGest%></td>
            <%}%>
            <%if(!strDescAcc.equals("")){%>
            <td class="row1" align="center"><%=strDescAcc%></td>
            <%}%>
            <%if(!strDataInizio.equals("")){%>
            <td class="row1" align="center"><%=strDataInizio%></td>
            <%}%>
            <%if(!strDataFine.equals("")){%>
            <td class="row1" align="center"><%=strDataFine%></td>
            <%}%>
            <%if(!strDataInizioPeriodo.equals("")){%>
            <td class="row1" align="center"><%=strDataInizioPeriodo%></td>
            <%}%>
            <%if(!strDataFinePeriodo.equals("")){%>
            <td class="row1" align="center"><%=strDataFinePeriodo%></td>
            <%}%>
            <%if(!strDataDescrizioneCiclo.equals("")){%>
            <td class="row1" align="center"><%=strDataDescrizioneCiclo%></td>
            <%}%>
            <td class="row1" align="center"><%=strNumElab%></td>
            <td class="row1" align="center"><%=strNumElemScartati%></td>        
            <td class="row1" align="center"><%=strNumScartati%></td>        
        </tr>
    </TABLE>  
  </TD>
</TR>
<TR>
  <TD>
  <HR>
  </TD>
</TR>
<TR valign="top" height="100%" >
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctScarti.size()%>">
    <DIV>
    <table width="100%" cellspacing="1" align="center">
      <%if(vctScarti.size()!=0){%>
        <tr class="rowHeader" height="20" align="center">
            <td>Codice scarto</td>
            <td>Descrizione scarto</td>
            <td>Data creazione/modifica</td>
            <td>Codice istanza prodotto</td>
            <td>Codice istanza componente</td>
            <td>Codice istanza prest.agg.</td>
        </tr>
      <% 
        String classRow = "row2"; 
        //for(int i=0;i<vctElabBatch.size();i++){
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctScarti.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           objScarti = (DB_ScartiNew)vctScarti.get(i);
           %>
           <TR height="20">
            <td class="<%=classRow%>" align="center"><%=objScarti.getCODE_TIPO_SCARTO()%></td>
            <td class="<%=classRow%>" align="center">
            <%=objScarti.getDESC_TIPO_SCARTO()%>
            <%if (!objScarti.getCODE_TIPO_SCARTO_NON_TROVATO().equals("0") && !objScarti.getCODE_TIPO_SCARTO_NON_TROVATO().equals("")){%>
            (<%=objScarti.getCODE_TIPO_SCARTO_NON_TROVATO()%>)
            <%}%>
            </td>
            <td class="<%=classRow%>" align="center"><%=objScarti.getDATA_CREAZ_MODIF()%></td>
            <td class="<%=classRow%>" align="center"><%=objScarti.getCODE_ISTANZA_PROD()%></td>
            <td class="<%=classRow%>" align="center"><%=objScarti.getCODE_ISTANZA_COMPO()%></td>
            <td class="<%=classRow%>" align="center"><%=objScarti.getCODE_ISTANZA_PREST_AGG()%></td>
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
    </DIV>
  </TD>
<TR>
<tr height="28" class="text">
  <td >
    <pg:index>
       Risultati Pag.
    <pg:prev> 
    <A HREF="javaScript:goPage('<%= pageUrl %>&<%=request.getQueryString()%>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage('<%= pageUrl %>&<%=request.getQueryString()%>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage('<%= pageUrl %>&<%=request.getQueryString()%>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
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