<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.usr.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page import="com.utl.*, com.usr.*" %>
<%@ page contentType="application/vnd.ms-excel" %>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"scartiPerContrViewer.jsp")%>
</logtag:logData>
<%
//response.addHeader("Pragma", "no-cache");
//response.addHeader("Cache-Control", "no-store");

String codeTipoContratto = request.getParameter("codeTipoContratto");
if (codeTipoContratto==null) codeTipoContratto=(String)session.getAttribute("codeTipoContratto");
if (codeTipoContratto==null) codeTipoContratto=request.getParameter("codeTipoContratto");

String descTipoContratto = request.getParameter("descTipoContratto");
if (descTipoContratto==null) descTipoContratto=(String)session.getAttribute("descTipoContratto");
if (descTipoContratto==null) descTipoContratto=request.getParameter("descTipoContratto");

String codeContratto = request.getParameter("codeContratto");
if (codeContratto==null) codeContratto=(String)session.getAttribute("codeContratto");

String descContratto = request.getParameter("descContratto");
if (descContratto==null) descContratto=(String)session.getAttribute("descContratto");
if (descContratto==null) descContratto=request.getParameter("descContratto");



descTipoContratto = descTipoContratto.replace('~',' ');
descContratto = descContratto.replace('~',' ');
descContratto = descContratto.replace((char)39,' ');

Collection ListaScarti = (Collection) session.getAttribute("ListaScarti"); //per il caricamento della lista degli stati elab batch


%>

<EJB:useHome id="home" type="com.ejbSTL.GestioneScartiPopolamentoHome" location="GestioneScartiPopolamento" />
<EJB:useBean id="remote_GestioneScartiPopolamento" type="com.ejbSTL.GestioneScartiPopolamento" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<TITLE>Stampa Lista Scarti</TITLE>
</HEAD>
<%
    ListaScarti = remote_GestioneScartiPopolamento.getListaScartiXOlo(codeTipoContratto,codeContratto);
%>
<BODY>
<form name="frmTariffe">
    <table align=center width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
         <td width="40%" class="textB" align="left">&nbsp;Descrizione Tipo Contratto:&nbsp;<%=descTipoContratto.replace('~',' ')%>
         </td>   
         <td width="40%" class="textB" align="left">&nbsp;Olo:&nbsp;<%=descContratto.replace('~',' ')%>
         </td>   
         <td width="40%" class="textB" align="left">&nbsp;CODE_CONTR:&nbsp;<%=codeContratto%>
         </td>       
         <td width="40%" class="textB" align="left">&nbsp;Numero Righe di Scarto:&nbsp;<%=ListaScarti.size() + ""%>
         </td>            
         <td width="10%" class="text" align="left">&nbsp;
         </td>   
      </tr>
    </table>
      <tr>
         <td class="textB" align="left">&nbsp;
         </td>   
      </tr>
    <table align=center width="100%" border="0" cellspacing="0" cellpadding="0">

         <td width="10%">CODE_RIF</td>           
         <td width="10%">CODE_SCARTO</td>   
         <td width="10%">DESC_SCARTO</td>   
         <td width="10%">DATA_SCARTO</td>   
         <td width="10%">DATA_CHIUSURA_SCARTO</td>   
         <td width="10%">STATO_SCARTO</td>   
         <td width="10%">DESC_ID_RISORSA</td>   
         <td width="10%">CODE_TIPO_CONTR</td>   
         <td width="10%">CODE_CONTR</td>   
         <td width="10%">CODE_TRACCIATO</td>   
         <td width="10%">CODE_DETT_SCARTO</td>   
         <td width="10%">CHIAVE_PITA_JPUB</td>   
         
<%
Float  IMPORTO;
String ImptTar = "";
                  String bgcolor="";
                  //Caricamento lista Excel
                  if ((ListaScarti==null)||(ListaScarti.size()==0))
                  {
                  out.println("No Record Found");
                  }
                  else
                  {
                  Object[] objs=ListaScarti.toArray();
                      for(int i=0;i<ListaScarti.size();i++)
                      {
                       I5_5SCARTI_VALORIZZAZIONE obj=(I5_5SCARTI_VALORIZZAZIONE)objs[i];                                           
%>  
                        <TR>                      
                           <TD><%=Misc.nh(obj.getCODE_ITRF_FAT_XDSL_XML_RIF())%></TD>
                           <TD><%=Misc.nh(obj.getCODE_SCARTO())%></TD>      
                           <TD><%=Misc.nh(obj.getDESC_SCARTO())%></TD>
                           <TD><%=obj.getDATA_SCARTO() == null ? "" : obj.getDATA_SCARTO().toString()%></TD>
                           <TD><%=obj.getDATA_CHIUSURA_SCARTO() == null ? "" : obj.getDATA_CHIUSURA_SCARTO().toString()%></TD>
                           <TD><%=Misc.nh(obj.getSTATO_SCARTO())%></TD>                           
                           <TD><%=Misc.nh(obj.getDESC_ID_RISORSA())%></TD>
                           <TD><%=Misc.nh(obj.getCODE_TIPO_CONTR())%></TD>
                           <TD><%=Misc.nh(obj.getCODE_CONTR())%></TD>                           
                           <TD><%=Misc.nh(obj.getCODE_TRACCIATO())%></TD>
                           <TD><%=Misc.nh(obj.getCODE_DETT_SCARTO())%></TD>
                           <TD><%=Misc.nh(obj.getCHIAVE_PITA_JPUB())%></TD>                                                      
                        </tr>
<%
                      }             
                  }
%>
</table>
<p>
ATTENZIONE: i dati contenuti nel sistema sono classificati Telecom Italia - Confidenziale e sono soggetti ai vincoli imposti dalla Delibera 152/02/CONS.</br>
Nel trattare i dati l'operatore deve attenersi alle disposizioni contenute nel Codice di Comportamento per la riservatezza dei dati relativi alla Clientela degli OLO, nonche' a tutte le normative di sicurezza vigenti in Azienda.
</p>
</form>
</BODY>
</HTML>

