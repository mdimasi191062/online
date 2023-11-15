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

<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"ComponentiDettaglio.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Catalogo" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="remoteEnt_Catalogo" type="com.ejbSTL.Ent_Catalogo" scope="session">
    <EJB:createBean instance="<%=homeEnt_Catalogo.create()%>" />
</EJB:useBean>

<%
   String strCodeOfferta    = Misc.nh(request.getParameter("Offerta"));
   String strCodeServizio   = Misc.nh(request.getParameter("Servizio"));
   String strCodeProdotto   = Misc.nh(request.getParameter("Prodotto"));
   String strCodeComponente = Misc.nh(request.getParameter("Componente"));
   String Elemento = "C";

   Vector vct_Info = remoteEnt_Catalogo.getVisualizzaInfo( Elemento,  strCodeOfferta,  strCodeServizio,  strCodeProdotto,  strCodeComponente , "" );
   DB_VisualizzaInfo info_Compo = (DB_VisualizzaInfo)vct_Info.get(0);
   String strSpesaComplessiva =  info_Compo.getFLAG_SPESA().equals("S") ? "Partecipa" : "Non Partecipa";
%>

<HTML>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title>Componenti Dettaglio</title>
</head>
<body>
 <table ALIGN=center>
      <tr>
         <td bgcolor="#0a6b98" class="white" valign="top" width="91%"> Componente Dati Dettaglio</td>
      </tr>
 </table>
 <TABLE ALIGN=center BORDER=10 CELLPADDING=5 CELLSPACING=5 WIDTH=200 HEIGHT=9>
         <tr>
            <TD class="textB" > Offerta:  
              <INPUT class="text" id="Offerta" name="Offerta" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Offerta" Update="false" size="25" value="<%=info_Compo.getDESC_OFFERTA()%>">
            </TD>
        </tr>
        <tr>
            <TD class="textB" > Servizio: 
              <INPUT class="text" id="Servizio" name="Servizio" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Servizio" Update="false" size="20" value="<%=info_Compo.getDESC_SERVIZIO()%>">
            </TD>
        </tr>
        <%--<tr>
            <TD  class="textB" > La Componente <%=info_Compo.getDATO_ESERCIZIO().equals("N")?"non":""%> è in esercizio </TD>
        </tr>--%>
       <tr>
            <TD class="textB" > <%=info_Compo.getDESC_MODAL_APPLICAB_NOLEG()%>
            </TD>
        </tr>
        <tr>
            <TD class="textB" > Tempo Primo Noleggio (mm):
              <INPUT class="text" id="PrimoNoleggio" name="PrimoNoleggio" readonly obbligatorio="si" tipocontrollo="intero" label="Primo Noleggio" Update="false" size="10" value="<%=info_Compo.getPRIMO_NOL()%>">
            </TD>
        </tr>
        <tr>
           <TD class="textB" > Tempo Rinnovo Noleggio (mm):
              <INPUT class="text" id="RinnovoNoleggio" name="RinnovoNoleggio" readonly obbligatorio="si" tipocontrollo="intero" label="Rinnovo Noleggio" Update="false" size="10" value="<%=info_Compo.getRINNOVO_NOL()%>">
            </TD>
        </tr>
        <tr>
            <TD class="textB" > Tempo Preavviso (gg):
              <INPUT class="text" id="TempoPreavviso" name="TempoPreavviso" readonly obbligatorio="si" tipocontrollo="intero" label="Tempo Preavviso" Update="false" size="10" value="<%=info_Compo.getTEMPO_PREAVVISO()%>">
            </TD>
        </tr>
        <tr>
          <TD class="textB" > Data Fine Noleggio: 
            <INPUT class="text" id="DataFineNoleggio" name="DataFineNoleggio" readonly obbligatorio="si" tipocontrollo="intero" label="Tempo Preavviso" Update="false" size="10" value="<%=info_Compo.getDATA_FINE_NOL()%>">
          </TD>
        </tr>
        <tr>
            <TD class="textB" > Elemento Trasmissivo:
              <INPUT class="text" id="TempoPreavviso" name="TempoPreavviso" readonly obbligatorio="si" tipocontrollo="intero" label="Tempo Preavviso" Update="false" size="10" value="<%=info_Compo.getTRASMISSIVO()%>">
            </TD>
        </tr>
        <tr>
            <TD class="textB" > Elemento Colocato:
              <INPUT class="text" id="TempoPreavviso" name="TempoPreavviso" readonly obbligatorio="si" tipocontrollo="intero" label="Tempo Preavviso" Update="false" size="10" value="<%=info_Compo.getCOLOCATA()%>">
            </TD>
        </tr>
</TABLE> 
</body>
</HTML>