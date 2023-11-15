<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.rmi.*,com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Collection" %>
<%@ page import="javax.ejb.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  RedirectEnabled="true" VectorName="vectorButton" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"repdecomm.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_Repdecomm" type="com.ejbSTL.Ctr_RepdecommHome" location="Ctr_Repdecomm" />
<EJB:useBean id="remoteCtr_Repdecomm" type="com.ejbSTL.Ctr_Repdecomm" scope="session">
    <EJB:createBean instance="<%=homeCtr_Repdecomm.create()%>" />
</EJB:useBean>

<% 

  Vector listaFile =null;  
  listaFile = remoteCtr_Repdecomm.getlistaFile();
  
  Vector listaOAO =null;  
  listaOAO = remoteCtr_Repdecomm.getlistaOAO();
 
  response.addHeader("Pragma", "no-cache"); 
  response.addHeader("Cache-Control", "no-store");
    //---------------------------------------------------------------------------------
    //                                Dichiarazioni
    //---------------------------------------------------------------------------------    

  I5_5DECO_ACCESSI_NOW_JPUB  remote = null;      

    //Se valorizzato ad uno indica che la pagina e richiamata dalla pagina di cancellazione 
    //e bisogna dare un avviso all'utente 
  String bgcolor="";
    //Flag per individuare se una riga é selezionata

  int i=0;
  int j=0;
  int iPagina=0;  

    Vector aRemote2 = null;
    String strlistaOAO  =  request.getParameter("strlistaOAOH");
    String strFilename  =  request.getParameter("strFilenameH");

  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
 
    //Lettura dell'indice Numero record per pagina della combo per ripristino dopo  ricaricamento
  int index=0;
  String strIndex = request.getParameter("txtnumRec");
  if (strIndex!=null && !"".equals(strIndex))
  {
    Integer tmpindext=new Integer(strIndex);
    index=tmpindext.intValue();
  }

//Lettura del valore Numero record per pagina della combo per visualizzazione risultato (default 5)
  int records_per_page=5;
  String strNumRec = request.getParameter("numRec");
  if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }  

//Lettura del valore tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=1 Fare query (default)
// typeLoad=0 Variabile session

  int typeLoad=0;
  String strtypeLoad = request.getParameter("txtTypeLoad");
  if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
  if (typeLoad!=0)
  {
    aRemote2 = (Vector)session.getAttribute("aRemote2");
  }
  else
  {
      
    /*if ( strCodeServizio != null && !"".equals(strCodeServizio)) 
        aRemote2=remoteEstrazioniConfSTL.getEstrazioniConsistenzeAttive(strCodeServizio,strDataCompDa,strDataCompA,strCodeAccount,strCodeProdotto);
      */  
       aRemote2=remoteCtr_Repdecomm.getlistaFileByFilter(strlistaOAO,strFilename);
    session.setAttribute( "aRemote2", aRemote2);  
    session.setAttribute( "strlistaOAO", strlistaOAO);  
    session.setAttribute( "strFilename", strFilename); 
    

  }
  //------------------------------------------------------------------------------
  //Fine Standard Ricerca
  //------------------------------------------------------------------------------  



%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
  <script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript">

function exportCsv(typeExport){

 
  openDialog("stampa_repdecomm.jsp", 30, 50, " ,scrollbars=1, resizable=1, toolbar=0, status=0, menubar=1");
}


	
function enableEsporta() {

<%
if ( aRemote2 != null && aRemote2.size() > 0 ) {
%>
    Enable(frmSearch.Esporta);
<% } else { %>
        Disable(frmSearch.Esporta);
<%   } %>

}
function abilitaVis()
{
       Enable(frmSearch.Esegui);
}
function ripulisci()
{
       Disable(frmSearch.Esegui);
       document.frmSearch.comboListaOAO.value = '-1';
       document.frmSearch.strFilenameH.value = '-1';
       document.frmSearch.comboListaFile.value = '-1';
       document.frmSearch.strlistaOAOH.value = '-1';
       document.frmSearch.txtTypeLoad.value='0';
       document.frmSearch.submit();
}
  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function submitFrmSearch(typeLoad)
{

    
            document.frmSearch.txtTypeLoad.value=typeLoad;
            orologio.style.visibility='visible';
            orologio.style.display='inline'  
      
            maschera.style.visibility='hidden';
            maschera.style.display='none'  
     

           
            
            for (var i=0;i<document.frmSearch.comboListaFile.length;i++) {
                if (document.frmSearch.comboListaFile[i].selected) {
                    document.frmSearch.strFilenameH.value = document.frmSearch.comboListaFile[i].value;
                }
            }
            
            for (var i=0;i<document.frmSearch.comboListaOAO.length;i++) {
                if (document.frmSearch.comboListaOAO[i].selected) {
                    document.frmSearch.strlistaOAOH.value = document.frmSearch.comboListaOAO[i].value;
                }
            }            

           
            document.frmSearch.submit();
         
}  

function setnumRec()
{
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
}


  //------------------------------------------------------------------------------
  //Fine Gestione Standard Ricerca
  //------------------------------------------------------------------------------  

function inizializza(){
  orologio.style.visibility='hidden';
  orologio.style.display='none'  
}

</SCRIPT>


<TITLE>Selezione Fascia</TITLE>

</HEAD>
<BODY onload="setnumRec();inizializza();" onfocus="enableEsporta();" >


<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div name="orologio" id="orologio">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div name="maschera" id="maschera" style="visibility:display;display:inline">
  <!-- Gestione navigazione-->
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="repdecomm.jsp">

<input type=hidden name="strlistaOAOH" value="">
<input type=hidden name="strFilenameH" value="">

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloSpecial.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
        <tr>
            <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Report Decommissioning</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
                  </tr>
              </table>
            </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Filtri di Ricerca</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td bgcolor="#CFDBE9">
                  <table width="500" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr height="35px">
                        <td class="textB"  align="left">Lista File</td>
                        <td class="text"  align="left">
                            <select name="comboListaFile" width="10px" class="text"  onchange="abilitaVis();">
                            <option value="-1" Selected></option>
                            <% 
                            Object[] objslistaFile=listaFile.toArray();
                                for (int k=0;k<listaFile.size();k++) {
                                    I5_5DECO_ACCESSI_NOW_JPUB  objTipo=(I5_5DECO_ACCESSI_NOW_JPUB )objslistaFile[k];
                            if (objTipo.getFILE_NAME().equals(strFilename)) {%>
                            
                                    <option selected value="<%=objTipo.getFILE_NAME()%>"><%=objTipo.getFILE_NAME()%></option>
                                    <%}  else { %>    
                                    <option value="<%=objTipo.getFILE_NAME()%>"><%=objTipo.getFILE_NAME()%></option>
                            <%}}  %>
                            </select>
                        </td>
                    </tr>
                        <tr height="35px">
                        <td class="textB" align="left">Lista OAO</td>
                        <td class="text"  align="left">
                            <select name="comboListaOAO" width="10px" class="text" onchange="abilitaVis();">
                            <option value="-1" Selected></option>
                            <% 
                            Object[] objslistaOAO=listaOAO.toArray();
                                for (int k=0;k<listaOAO.size();k++) {
                                    I5_5DECO_ACCESSI_NOW_JPUB  objTipo=(I5_5DECO_ACCESSI_NOW_JPUB )objslistaOAO[k];
                            if (objTipo.getCODICE_OAO().equals(strlistaOAO)) {%>
                            
                                    <option selected value="<%=objTipo.getCODICE_OAO()%>"><%=objTipo.getCODICE_OAO()%></option>
                                    <%}  else { %>    
                                    <option value="<%=objTipo.getCODICE_OAO()%>"><%=objTipo.getCODICE_OAO()%></option>
                            <%}}  %>                            
                            </select>
                        </td>                        
                    </tr>
                    <tr height="35px">
                      <td  rowspan='2' class="textB" align="left">
                        <input class="textB" type="button" name="Ripulisci" value="Annulla" onclick="ripulisci();">
                        <input class="textB" type="button" name="Esegui" disabled value="Visualizza" onclick="submitFrmSearch('0');">

                        <input class="textB" type="hidden" name="txtTypeLoad" value="">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                      </td>
                    </tr>
                    <tr height="35px">
                      
                    </tr>
                    <tr height="35px">
                      <td  class="textB" align="left">Risultati per pag.:&nbsp;</td>
                      <td   class="text" align="left">
                        <select class="text" name="numRec" onchange="submitFrmSearch('1');">
                          <option class="text" value=5>5</option>
                          <option class="text" value=10>10</option>
                          <option class="text" value=20>20</option>
                          <option class="text" value=50>50</option>
                        </select>
                      </td>
                      </tr>
                       
                    <tr height="35px">
                      
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
					</td>
        </tr>
        <tr>
          <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
        </tr>
</form>
  <!-- Gestione navigazione-->
<form name="frmDati" method="post" action='cbn1_dis_fascia_cl.jsp'>
        <tr>
          <td>
            <table border="0" width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Lista</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td colspan='1' bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
                    </tr>
  <% 
  if ((aRemote2==null)||(aRemote2.size()==0)){
    %>
                    <tr>
                      <td  width="100%" bgcolor="#FFFFFF" colspan="3" class="textB" align="center">No Record Found</td>
                    </tr>
   <%
  } else {
  %>
                    
                    <tr>
                      <td>
                        <table valign="top"  width="100%" border="0" cellspacing="2" cellpadding="1" bgcolor="#CFDBE9">
                        <tr>
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">File Name</td>
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Codice <br> OAO</td>
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">ID Ordine OAO Cess</td>
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Id Risorsa Cess</td>                         
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Data DRO Cess</td> 
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Data Des Cess</td> 
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Tipo Contr Cess</td>
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Codice Contr Cess</td>
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Tipo Ordine Cess</td>
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Data NDC CNT Cess</td>
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Codice NDC CNT Cess</td>
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Id Ordine OAO Att</td>
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Id Risorsa Att</td>
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Data Dro Att</td>
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Data Des Att</td>
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Tipo Contr Att</td>
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Codice Contr Att</td>
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Tipo Ordine Att</td>                          
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Data Ndc CAN Att</td>                                                    
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Codice Ndc CAN Att</td>                                                                             
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Data Ndc CNT Att</td>   
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Codice Ndc CNT Att</td>
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Esito Elab</td>                                                                              
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Descr Scarto</td>                                                                              
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Data Elab</td>                                                                                                        
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Flag Canoni</td>                                                                                                                                  
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Flag Contributi</td>                                                                                                                                  
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Code Invent Old</td>                           
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Code Ps Old</td>                           
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Code Tariffa Canone Old</td>                           
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Code Pr Tariffa Canone Old</td>                           
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Tipo Tariffa Canone Old</td>  
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Code Tariffa Contrib Old</td>                            
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Code Pr Tariffa Contrib Old</td>                                                      
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Tipo Tariffa Contrib Old</td>                                                      
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Code Invent New</td>                                                      
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Code Ps New</td>                                                                                
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Code Tariffa Canone New</td> 
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Code Pr Tariffa Canone New</td> 
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Tipo Tariffa Canone New</td>                           
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Code Tariffa Contrib New</td> 
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Code Pr Tariffa Contrib New</td> 
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Tipo Tariffa Contrib New</td>                                                  
                          <td valign="top" bgcolor='#D5DDF1' class="textB" width="12%">Deco</td>      
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote2.size()%>">
<pg:param name="txtTypeLoad" value="1"></pg:param>

<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>                        
<%

      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote2.size()) && (j<pagerPageNumber.intValue()*records_per_page));j++)      
      {
         remote = (I5_5DECO_ACCESSI_NOW_JPUB ) aRemote2.elementAt(j);                                                
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";

%>
                        <TR>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getFILE_NAME() %></TD>                           
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODICE_OAO() %></TD>                           
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getID_ORDINE_OAO_CESS() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getID_RISORSA_CESSE() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_DRO_CESSE() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_DES_CESS() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getTIPO_CONTR_CESS() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODICE_CONTR_CESSE() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getTIPO_ORDINE_CESSE() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_NDC_CNT_CESS() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODICE_NDC_CNT_CESS() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getID_ORDINE_OAO_ATT() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getID_RISORSA_ATT() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_DRO_ATT() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_DES_ATT() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getTIPO_CONTR_ATT() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODICE_CONTR_ATT() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getTIPO_ORDINE_ATT() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_NDC_CAN_ATT() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODICE_NDC_CAN_ATT() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_NDC_CNT_ATT() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODICE_NDC_CNT_ATT() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getESITO_ELAB() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDESCR_SCARTO() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_ELAB() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getFLAG_CANONI() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getFLAG_CONTRIBUTI() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODE_INVENT_OLD() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODE_PS_OLD() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODE_TARIFFA_CANONE_OLD() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODE_PR_TARIFFA_CANONE_OLD() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getTIPO_TARIFFA_CANONE_OLD() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODE_TARIFFA_CONTRIB_OLD() %></TD>       
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODE_PR_TARIFFA_CONTRIB_OLD() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getTIPO_TARIFFA_CONTRIB_OLD() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODE_INVENT_NEW() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODE_PS_NEW() %></TD>                                 
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODE_TARIFFA_CANONE_NEW() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODE_PR_TARIFFA_CANONE_NEW() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getTIPO_TARIFFA_CANONE_NEW() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODE_TARIFFA_CONTRIB_NEW() %></TD>                                               
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODE_PR_TARIFFA_CONTRIB_NEW() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getTIPO_TARIFFA_CONTRIB_NEW() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDECO() %></TD>
                        </tr>
<%
          i+=1;
        }
%>        
<pg:index>
                        <tr>
                          <td bgcolor="#FFFFFF" colspan="27" class="text" align="center">
                          Risultati Pag.
                          <pg:prev> 
                            <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
                          </pg:prev>
<pg:pages>
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
                            <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
<%
    } 
%>
</pg:pages>
                          <pg:next>
                            <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
                          </pg:next>
                          </td>
                        </tr>
</pg:index>
</pg:pager>
<%
}
%>
                         <tr>
        <td> &nbsp;
              </td>
              <td> 
        <input class="textB" type="button" name="Esporta" value="Export XLS" onclick="exportCsv('0');">
        </td>
              <td> &nbsp;
              </td>
                    </tr>
                        </table>
                      </td>
                    </tr>        
                   
                  </table>
                </td>
              </tr>
              
            </table>
					</td>
        </tr>
        
      </table>
    </td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
              <td> &nbsp;
              </td>
              <td>
            <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
                    
                    </td>
                                  <td>&nbsp;
              </td>
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>
</div>
</BODY>
<script>
var http=getHTTPObject();
</script>
</HTML>
