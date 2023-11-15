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
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"dettaglioEstrazioniCA.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_TipiContratto" type="com.ejbSTL.Ent_TipiContrattoHome" location="Ent_TipiContratto" />
<EJB:useBean id="remoteEnt_TipiContratto" type="com.ejbSTL.Ent_TipiContratto" scope="session">
    <EJB:createBean instance="<%=homeEnt_TipiContratto.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEstrazioniConfSTL" type="com.ejbSTL.EstrazioniConfSTLHome" location="EstrazioniConf" />
<EJB:useBean id="remoteEstrazioniConfSTL" type="com.ejbSTL.EstrazioniConfSTL" scope="session">
    <EJB:createBean instance="<%=homeEstrazioniConfSTL.create()%>" />
</EJB:useBean>

<% 
  response.addHeader("Pragma", "no-cache"); 
  response.addHeader("Cache-Control", "no-store");
    //---------------------------------------------------------------------------------
    //                                Dichiarazioni
    //---------------------------------------------------------------------------------    

  ClassDettaglioConsAttive remote = null;       
    //Se valorizzato ad uno indica che la pagina e richiamata dalla pagina di cancellazione 
    //e bisogna dare un avviso all'utente 
  String bErrore = null;
  String bgcolor="";
    //Flag per individuare se una riga é selezionata
  boolean bCheck = false;
  int i=0;
  int j=0;
  int iPagina=0;  
  int records_per_page=5;
  int index=0;
  String strIndex = request.getParameter("txtnumRec2");
  if (strIndex!=null && !"".equals(strIndex))
  {
    Integer tmpindext=new Integer(strIndex);
    index=tmpindext.intValue();
  }
  String strNumRec = request.getParameter("numRec");
  if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }  

    // This is the variable we will store all records in.

  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");        
    Vector aDettConsAtt = null;
 

    String strCodeServizio = Misc.nh(request.getParameter("Servizio"));
        String strDescServizio = Misc.nh(request.getParameter("DescServizio"));
    String strMeseCompetenza = Misc.nh(request.getParameter("MeseAnnoComp"));
    String strCodeAccount = Misc.nh(request.getParameter("Operatore"));
        String strDescAccount = Misc.nh(request.getParameter("DescOperatore"));
    String strCodeProdotto =  Misc.nh(request.getParameter("Prodotto"));
        String strDescProdotto =  Misc.nh(request.getParameter("DescProdotto"));
    String strDataCompDa =  Misc.nh(request.getParameter("strDataCompDa"));
    String strDataCompA =  Misc.nh(request.getParameter("strDataCompA"));

  int typeLoad=0;
  String strtypeLoad = request.getParameter("txtTypeLoad");
  if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
  if (typeLoad!=0)
  {
    aDettConsAtt = (Vector)session.getAttribute("aDettConsAtt");
  }
  else
  {
    aDettConsAtt=remoteEstrazioniConfSTL.getDettaglioEstrazioniConsistenzeAttive(strCodeServizio,strCodeAccount,strCodeProdotto,strMeseCompetenza,strDataCompDa, strDataCompA);
    session.setAttribute( "aDettConsAtt", aDettConsAtt);  
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

  /*var codServizio = "<%=strCodeServizio %>";
  var codAccount =  "<%=strCodeAccount %>";
  var dataInizio = "<%=strDataCompDa %>";
  var dataFine = "<%=strDataCompA %>";
  var flagFunzione = typeExport;
  var codeProdotto = "<%=strCodeProdotto %>";
  var meseCompetenza = "<%=strMeseCompetenza %>";
    
  carica = function(dati){gestisciMessaggio(dati[0].messaggio);};
  errore = function(dati){gestisciMessaggio(dati[0].messaggio);};  
  var asyncFunz= function(){ handler_generico(http,carica,errore);};
  
  var sendMessage='codeFunz=40&id_funz=2&codServizio='+codServizio+'&codAccount='+codAccount+'&dataInizio='+dataInizio+'&dataFine='+dataFine+'&flagFunzione='+flagFunzione+'&codeProdotto='+codeProdotto+'&meseCompetenza='+meseCompetenza;
  
  chiamaRichiesta(sendMessage,'ExportCsvConsAttive',asyncFunz);*/
 
  //openDialog("stampa_dettaglioEstrazioniCA.jsp?DescServizio=<%=java.net.URLEncoder.encode(strDescServizio,com.utl.StaticContext.ENCCharset)%>&DescAccount=<%=java.net.URLEncoder.encode(strDescAccount,com.utl.StaticContext.ENCCharset)%>&DescProdotto=<%=java.net.URLEncoder.encode(strDescProdotto,com.utl.StaticContext.ENCCharset)%>", 30, 50, " ,scrollbars=1, resizable=1, toolbar=0, status=0, menubar=1");
    openDialog("stampa_dettaglioEstrazioniCA.jsp?DescServizio=<%=strDescServizio%>&DescAccount=<%=strDescAccount%>&DescProdotto=<%=strDescProdotto%>", 30, 50, " ,scrollbars=1, resizable=1, toolbar=0, status=0, menubar=1");
}

function submitFrmSearch(typeLoad)
{
  document.frmSearch.txtnumRec2.value=document.frmSearch.numRec.selectedIndex;

  document.frmSearch.txtTypeLoad.value=typeLoad;
  document.frmSearch.submit();
} 

function setnumRec()
{
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
}

function ChangeSel(codice,indice)
{
}

function inizializza(){
  orologio.style.visibility='hidden';
  orologio.style.display='none'  
}

</SCRIPT>


<TITLE>Dettaglio Consistenze Attive</TITLE>

</HEAD>
<BODY onload="setnumRec();inizializza();">


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
<form name="frmSearch" onsubmit="" method="post" action="">
<input type=hidden name="Servizio" value="<%=strCodeServizio%>">
<input type=hidden name="DescServizio" value="<%=strDescServizio%>">
<input type=hidden name="MeseAnnoComp" value="<%=strMeseCompetenza%>">
<input type=hidden name="Operatore" value="<%=strCodeAccount%>">
<input type=hidden name="DescOperatore" value="<%=strDescAccount%>">
<input type=hidden name="Prodotto" value="<%=strCodeProdotto%>">
<input type=hidden name="DescProdotto" value="<%=strDescProdotto%>">
<input type=hidden name="strDataCompDa" value="<%=strDataCompDa%>">
<input type=hidden name="strDataCompA" value="<%=strDataCompA%>">

<table align=center width="95%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloPaginaCA.GIF" alt="" border="0"></td>
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
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Dettaglio Consistenze Attive</td>
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
	    <table width="95%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Testata</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr>
                      <td colspan='6' bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
                    </tr>
                      <tr>
                        <td width="15%" class="textB" align="right">Servizio:&nbsp;</td>
                        <td width="15%" class="text"><%=strDescServizio%>
                            <INPUT type="hidden" class="text" id="txtTipoContr" name="txtTipoContr" readonly label="TipoContr" Update="false" size="13" value="<%=strCodeServizio%>">
                            <INPUT type="hidden" class="text" id="txtDescTipoContr" name="txtDescTipoContr" readonly label="Descrizione TipoContr" Update="false" size="35" value="<%=strDescServizio%>">
                         </td>
                        <td width="5%" class="textB"></td>
                        <td width="15%" class="textB" align="right">Operatore:&nbsp;</td>
                        <td width="20%" class="text"><%=strDescAccount%>
                            <INPUT type="hidden" class="text" id="txtCodeAccount" name="txtCodeAccount" readonly label="Codice Account" Update="false" size="13" value="<%=strCodeAccount%>">
                            <INPUT type="hidden"class="text" id="txtDescAccount" name="txtDescAccount" readonly label="Descrizione Account" Update="false" size="35" value="<%=strDescAccount%>">
                        </td>
                        <td width="5%" class="textB"></td>
                      </tr>
        
                      <tr>
                        <td width="15%" class="textB" align="right">Prodotto:&nbsp;</td>
                        <td width="15%" class="text"><%=strDescProdotto%>
                              <INPUT type="hidden" class="text" id="txtCodeProdotto" name="txtCodeProdotto" readonly label="Codice Prodotto" Update="false" size="13" value="<%=strCodeProdotto%>">
                              <INPUT type="hidden" class="text" id="txtDescProdotto" name="txtDescProdotto" readonly label="Descrizione Prodotto" Update="false" size="35" value="<%=strDescProdotto%>">
                        </td>
                        <td width="5%" class="textB"></td>
                        <td width="15%" class="textB" align="right">Mese di Competenza:&nbsp;</td>
                        <td width="20%" class="text"><%=strMeseCompetenza%>
                                <input type='hidden' name='txtMeseCompetenza' value='<%=strMeseCompetenza%>' class="text" readonly="">
                        </td>
                        <td width="5%" class="textB"></td>
                    </tr>             

                   <tr>
                      <td class="textB" colspan="3"></td>
                      <td width="15%" class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td width="15%" class="text">
                        <input class="textB" type="hidden" name="txtTypeLoad" value="">
                        <input class="textB" type="hidden" name="txtnumRec2" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                        <select class="text" name="numRec" onchange="submitFrmSearch('1');">
                          <option class="text" value=5>5</option>
                          <option class="text" value=10>10</option>
                          <option class="text" value=20>20</option>
                          <option class="text" value=50>50</option>
                        </select>
                      </td>
                      <td width="5%" class="textB"><input class="textB" type="button" name="Esporta" value="Esporta" onclick="exportCsv('1');"></td>
                    </tr>


                   </table>
                </td>
              </tr>
            </table>
	</td>
        </tr>
        <tr>
          <td colspan='6' bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
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
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Dettaglio</td>
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
  if ((aDettConsAtt==null)||(aDettConsAtt.size()==0)){
    %>
                    <tr>
                      <td bgcolor="#FFFFFF" colspan="1" class="textB" align="center">No Record Found</td>
                    </tr>
   <%
  } else {
  %>
                    
                    <tr>
                      <td>
                        <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                        <tr>
                          <td bgcolor='#D5DDF1' class="textB" width="23%">Identificativo Risorsa</td>
                          <td bgcolor='#D5DDF1' class="textB" width="11%">Data ricezione ordine</td>
                          <td bgcolor='#D5DDF1' class="textB" width="11%">Data inizio fatturazione</td>
                          <td bgcolor='#D5DDF1' class="textB" width="11%">Data fine fatturazione</td>                         
                          <td bgcolor='#D5DDF1' class="textB" width="11%">Data cessazione</td> 
                          <td bgcolor='#D5DDF1' class="textB" width="11%">Data inizio validit&agrave;</td>
                          <td bgcolor='#D5DDF1' class="textB" width="11%">Data fine validit&agrave;</td> 
                          <td bgcolor='#D5DDF1' class="textB" width="11%">Data variazione</td>
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aDettConsAtt.size()%>">
<pg:param name="txtTypeLoad" value="1"></pg:param>
<pg:param name="Servizio" value="<%=strCodeServizio%>"></pg:param>
<pg:param name="MeseAnnoComp" value="<%=strMeseCompetenza%>"></pg:param>
<pg:param name="Operatore" value="<%=strCodeAccount%>"></pg:param>
<pg:param name="Prodotto" value="<%=strCodeProdotto%>"></pg:param>
<pg:param name="DescOperatore" value="<%=strDescAccount%>"></pg:param>
<pg:param name="DescProdotto" value="<%=strDescProdotto%>"></pg:param>
<pg:param name="DescServizio" value="<%=strDescServizio%>"></pg:param>
<pg:param name="strDataCompDa" value="<%=strDataCompDa%>"></pg:param>
<pg:param name="strDataCompA" value="<%=strDataCompA%>"></pg:param>

<pg:param name="txtnumRec2" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>                        
<%

      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aDettConsAtt.size()) && (j<pagerPageNumber.intValue()*records_per_page));j++)      
      {
         remote = (ClassDettaglioConsAttive) aDettConsAtt.elementAt(j);                                                
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";

%>
                        <TR>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODE_ISTANZA_PS() %></TD>                           
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_DRO() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_INIZIO_FATRZ() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_FINE_FATRZ() %></TD>                           
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_CESS() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_INIZIO_VALID() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_FINE_VALID() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_VARIAZ() %></TD>
                        </tr>
                        <tr>
                          <td colspan='8' bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
                        </tr>

<%
          i+=1;
        }
%>        
<pg:index>
                        <tr>
                          <td bgcolor="#FFFFFF" colspan="8" class="text" align="center">
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
                          <td colspan='8' bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
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
    <td bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='3'></td>
  </tr>
</table>
</form>
</div>
</BODY>
<script>
var http=getHTTPObject();
</script>
</HTML>
