<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.usr.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page import="com.utl.*, com.usr.*" %>
<%@ page contentType="application/vnd.ms-excel" %>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"TariffaListinoSp.jsp")%>
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

String Storico = request.getParameter("Storico");
if (Storico==null) Storico=(String)session.getAttribute("Storico");
if (Storico==null) Storico=request.getParameter("Storico");

descTipoContratto = descTipoContratto.replace('~',' ');
descContratto = descContratto.replace('~',' ');
descContratto = descContratto.replace((char)39,' ');

Collection TariffaListino = (Collection) session.getAttribute("TariffaListino"); //per il caricamento della lista degli stati elab batch
if (Storico.equals("0"))
out.println("LISTA TARIFFE");
else
out.println("LISTA TARIFFE - Storico");
%>
<EJB:useHome id="home" type="com.ejbBMP.TariffaBMPHome" location="TariffaBMP" />
<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<TITLE>Stampa Lista tariffe</TITLE>
</HEAD>

<%
if ( codeContratto.equals("0") || codeContratto.substring(0,3).equals("0||") )
    TariffaListino = home.findTariffaListinoUnico(codeTipoContratto,Storico);
else
   //if (!codeContratto.equals("0"))
    if ( codeContratto != null && codeContratto.indexOf("||") >= 0 && !codeContratto.substring(0,3).equals("0||")) {
        TariffaListino = home.findTariffaListinoPersClus(codeTipoContratto,codeContratto, Storico);
     } else
       TariffaListino = home.findTariffaListinoPers(codeTipoContratto,codeContratto,Storico);
%>
<BODY>
<form name="frmTariffe">
    <table align=center width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
         <td width="40%" class="textB" align="left">&nbsp;Descrizione Tipo Contratto:&nbsp;<%=descTipoContratto.replace('~',' ')%>
         </td>   
         <td width="40%" class="textB" align="left">&nbsp;Listino:&nbsp;<%=descContratto.replace('~',' ')%>
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
         <td width="10%">&nbsp;Prod./Servizio:&nbsp;</td>   
         <td width="10%">&nbsp;Ogg. di Fatturazione:&nbsp;</td>   
         <td width="10%">&nbsp;Causale:&nbsp;</td> 
         <td width="10%">&nbsp;Tipo Opzione:&nbsp;</td> <!--140203-->
         <td width="8%">&nbsp;Min. Classe di Sconto:&nbsp;</td>   
         <td width="8%">&nbsp;Max Classe di Sconto:&nbsp;</td>   
         <td width="10%">&nbsp;Desc. Tariffa:&nbsp;</td>   
         <td width="10%">&nbsp;Impt. Tariffa:&nbsp;</td>   
         <td width="5%">&nbsp;Tipo Importo:&nbsp;</td>   
         <td width="5%">&nbsp;Unit� di Misura:&nbsp;</td>   
         <td width="8%">&nbsp;Data Inizio Tariffa:&nbsp;</td>   
         <td width="8%">&nbsp;Data Fine Tariffa:&nbsp;</td>   
         <td width="8%">&nbsp;Data Creazione Tariffa:&nbsp;</td>   
<%
Float  IMPORTO;
String ImptTar = "";
                  String bgcolor="";
                  //Caricamento lista Excel
                  if ((TariffaListino==null)||(TariffaListino.size()==0))
                  {
                  out.println("No Record Found");
                  }
                  else
                  {
                  Object[] objs=TariffaListino.toArray();
                      for(int i=0;i<TariffaListino.size();i++)
                      {
                       TariffaBMP obj=(TariffaBMP)objs[i];
                       String ImpMinSps = obj.getImpMinSps().toString();
                       IMPORTO = new Float(obj.getImpTar().floatValue());
                       //ImptTar = CustomNumberFormat.setToNumberFormat(IMPORTO.toString());
                       ImptTar = IMPORTO.toString().replace('.',',');
                       String ImpMaxSps = obj.getImpMaxSps().toString();
                       if (ImpMinSps != null && ImpMinSps.equalsIgnoreCase("0.0"))
                           ImpMinSps = "0";
                       else 
                           //MMM 24/10/02 ImpMinSps = CustomNumberFormat.setToCurrencyFormat(obj.getImpMinSps().toString(),4);
                           ImpMinSps = CustomNumberFormat.setToNumberFormat(obj.getImpMinSps().toString(),4,false,true);
                       if (ImpMaxSps != null && ImpMaxSps.equalsIgnoreCase("0.0"))
                           ImpMaxSps = "0";
                       else 
                           //MMM 24/10/02 ImpMaxSps = CustomNumberFormat.setToCurrencyFormat(obj.getImpMaxSps().toString(),4);
                           ImpMaxSps = CustomNumberFormat.setToNumberFormat(obj.getImpMaxSps().toString(),4,false,true);

%>
                        <TR>
                           <TD><%=obj.getDescEsP().toString()%></TD>
                           <TD><%=obj.getDescOf().toString()%></TD>      
                           <TD><%=obj.getDescTipoCaus().toString()%></TD>
                           <TD><%=obj.getDescTipoOpz().toString()%></TD><!--140203-->
                           <TD><%=ImpMinSps%></TD>
                           <TD><%=ImpMaxSps%></TD>      
                           <TD><%=obj.getDescTar().toString()%></TD>
                           <TD><%=ImptTar%></TD>
                           <TD><%=obj.getFlgMat().toString()%></TD>      
                           <TD><%=obj.getDescUM().toString()%></TD>
                           <TD><%=obj.getDataIniTar().toString()%></TD>
                           <TD><%=obj.getDataFineTar().toString()%></TD>
                           <TD><%=obj.getDataCreazTar().toString()%></TD>
                        </tr>
<%
//System.out.println("desc "+obj.getDescTipoOpz());
//System.out.println("code "+obj.getCodTipoOpz());
                      }             
                  }
%>
</table>
</form>
</BODY>
</HTML>
