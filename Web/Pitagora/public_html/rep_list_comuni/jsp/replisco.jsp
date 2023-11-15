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
<%=StaticMessages.getMessage(3006,"replisco.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_Utility" type="com.ejbSTL.Ctr_UtilityHome" location="Ctr_Utility" />
<EJB:useBean id="remoteCtr_Utility" type="com.ejbSTL.Ctr_Utility" scope="session">
    <EJB:createBean instance="<%=homeCtr_Utility.create()%>" />
</EJB:useBean>

<% 

  Vector comuniCluster =null;  
  comuniCluster = remoteCtr_Utility.getcomuniCluster();
  
  Vector codeCluster =null;  
  codeCluster = remoteCtr_Utility.getcodeCluster();
  
  Vector tipoCluster =null;  
  tipoCluster = remoteCtr_Utility.gettipoCluster();
  
  response.addHeader("Pragma", "no-cache"); 
  response.addHeader("Cache-Control", "no-store");
    //---------------------------------------------------------------------------------
    //                                Dichiarazioni
    //---------------------------------------------------------------------------------    

  I5_1COMUNI_CLUSTER_PRICING remote = null;      

    //Se valorizzato ad uno indica che la pagina e richiamata dalla pagina di cancellazione 
    //e bisogna dare un avviso all'utente 
  String bgcolor="";
    //Flag per individuare se una riga é selezionata

  int i=0;
  int j=0;
  int iPagina=0;  

    Vector aRemote2 = null;
    String strtipoCluster =  request.getParameter("strtipoClusterH");
    String strcodeCluster  =  request.getParameter("strcodeClusterH");
    String istatComune  =  request.getParameter("istatComuneH");
    String dataIniVal  =  request.getParameter("dataIniValH");
    if (dataIniVal == null) {dataIniVal = "";}
    String dataFineVal =  request.getParameter("dataFineValH");
    if (dataFineVal == null) {dataFineVal = "";}
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
       aRemote2=remoteCtr_Utility.getcomuniClusterByFilter(strtipoCluster,strcodeCluster,istatComune,dataIniVal,dataFineVal);
    session.setAttribute( "aRemote2", aRemote2);  
    session.setAttribute( "strtipoCluster", strtipoCluster);  
    session.setAttribute( "strcodeCluster", strcodeCluster);  
    session.setAttribute( "istatComune", istatComune);  
    session.setAttribute( "dataIniVal", dataIniVal);  
    session.setAttribute( "dataFineVal", dataFineVal);  
    
    

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

 
  openDialog("stampa_replisco.jsp", 30, 50, " ,scrollbars=1, resizable=1, toolbar=0, status=0, menubar=1");
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

function ripulisci()
{
       document.frmSearch.comboTipoCluster.value = 'null';
       document.frmSearch.comboCodeCluster.value = 'null';
       document.frmSearch.comboComune.value = 'null';
       document.frmSearch.txtDataIni.value = '';
       document.frmSearch.txtDataFin.value = '';
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
     
            for (var i=0;i<document.frmSearch.comboTipoCluster.length;i++) {
                if (document.frmSearch.comboTipoCluster[i].selected) {
                    document.frmSearch.strtipoClusterH.value = document.frmSearch.comboTipoCluster[i].value;
                }
            }
            
            for (var i=0;i<document.frmSearch.comboCodeCluster.length;i++) {
                if (document.frmSearch.comboCodeCluster[i].selected) {
                    document.frmSearch.strcodeClusterH.value = document.frmSearch.comboCodeCluster[i].value;
                }
            }            

            for (var i=0;i<document.frmSearch.comboComune.length;i++) {
                if (document.frmSearch.comboComune[i].selected) {
                    document.frmSearch.istatComuneH.value = document.frmSearch.comboComune[i].value;
                }
            }
            
            document.frmSearch.dataIniValH.value = document.frmSearch.txtDataIni.value;
            document.frmSearch.dataFineValH.value = document.frmSearch.txtDataFin.value;
            
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
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="replisco.jsp">
<input type=hidden name="strtipoClusterH" value="">
<input type=hidden name="strcodeClusterH" value="">
<input type=hidden name="istatComuneH" value="">
<input type=hidden name="dataIniValH" value=" ">
<input type=hidden name="dataFineValH" value=" ">

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
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Report Listini Comuni CC e LIB</td>
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
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr height="35px">
                        <td class="textB">Tipo Report</td>
                        <td class="text" width="25%">
                            <select name="comboTipoReport" width="10px" class="text" >
                            <option value="1" Selected>Comuni Cluster Pricing</option>
                            </select>
                        </td>
                        <td class="textB">Tipo Cluster</td>
                        <td class="text" width="25%">
                            <select name="comboTipoCluster" width="10px" class="text" >
                            <option value="null" Selected></option>
                            <% 
                            Object[] objsTipiCluster=tipoCluster.toArray();
                                for (int k=0;k<tipoCluster.size();k++) {
                                    I5_1COMUNI_CLUSTER_PRICING objTipo=(I5_1COMUNI_CLUSTER_PRICING)objsTipiCluster[k];
                            if (objTipo.getTIPOLOGIA_CLUSTER_COMUNE().equals(strtipoCluster)) {%>
                            
                                    <option selected value="<%=objTipo.getTIPOLOGIA_CLUSTER_COMUNE()%>"><%=objTipo.getTIPOLOGIA_CLUSTER_COMUNE()%></option>
                                    <%}  else { %>    
                                    <option value="<%=objTipo.getTIPOLOGIA_CLUSTER_COMUNE()%>"><%=objTipo.getTIPOLOGIA_CLUSTER_COMUNE()%></option>
                            <%}}  %>                            
                            </select>
                        </td>                        
                     <tr>
                    <tr height="35px">
                        <td class="textB">Code Cluster</td>
                        <td class="text" width="25%">
                            <select name="comboCodeCluster" width="10px" class="text" >
                            <option value="null" Selected></option>
                            <% objsTipiCluster=codeCluster.toArray();
                                for (int k=0;k<codeCluster.size();k++) {
                                    I5_1COMUNI_CLUSTER_PRICING objTipo=(I5_1COMUNI_CLUSTER_PRICING)objsTipiCluster[k];
                            if (objTipo.getCODICE_CLUSTER().equals(strcodeCluster)) {%>
                                    <option selected value="<%=objTipo.getCODICE_CLUSTER()%>"><%=objTipo.getCODICE_CLUSTER()%></option>
                                    <%}  else { %>
                                    <option value="<%=objTipo.getCODICE_CLUSTER()%>"><%=objTipo.getCODICE_CLUSTER()%></option>
                            <%}}  %>                            
                            </select>
                        </td>
                        <td class="textB">Comune</td>
                        <td class="text" width="25%">
                            <select name="comboComune" width="10px" class="text" >
                            <option value="null" Selected></option>
                            <%  objsTipiCluster=comuniCluster.toArray();
                                String comuneIstat = "";
                                for (int k=0;k<comuniCluster.size();k++) {
                                    I5_1COMUNI_CLUSTER_PRICING objTipo=(I5_1COMUNI_CLUSTER_PRICING)objsTipiCluster[k];
                                    comuneIstat = objTipo.getDESCRIZIONE_COMUNE() + " / " + objTipo.getCODICE_ISTAT_COMUNE();
                            if (objTipo.getCODICE_ISTAT_COMUNE().equals(istatComune)) {%>
                                    <option selected value="<%=objTipo.getCODICE_ISTAT_COMUNE()%>"><%=comuneIstat%></option>
                                    <%}  else { %>
                                    <option value="<%=objTipo.getCODICE_ISTAT_COMUNE()%>"><%=comuneIstat%></option>
                            <%}}  %>                            
                            </select>
                        </td>       
                <tr height="35px">
                               <td class="textB" >Data Inizio Validita' Pricing</td>
            <td class="text" >
               <div name="divDataIni" id="divDataIni" class="textB">
                <input type="text" class="text" id="txtDataIni" name="txtDataIni" tipocontrollo="data" label="Data inizio"  size="10" value="<%=dataIniVal%>"  >
                  <a href="javascript:showCalendar('frmSearch.txtDataIni','');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true" ><img name='calendarioDataIni' src="../../common/images/img/cal.gif" border="no"></a>
                  <a href="javascript:cancelCalendar(document.frmSearch.txtDataIni);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_txtDataIni' src="../../common/images/img/images7.gif" border="0"></a>
                  <input type="hidden" id="txtDataIniOld">
                </div>
            </td>
            <td class="textB">Data Fine Validita' Pricing</td>
            <td class="textB">
               <div name="divDataFin" id="divDataFin" class="textB">
                 <INPUT class="text" id="txtDataFin" name="txtDataFin" tipocontrollo="data" label="Data Fine"  size="10" value="<%=dataFineVal%>">
                  <a href="javascript:showCalendar('frmSearch.txtDataFin','');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true" ><img name='calendarioDataFin' src="../../common/images/img/cal.gif" border="no"></a>
                  <a href="javascript:cancelCalendar(document.frmSearch.txtDataFin);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_txtDataFin' src="../../common/images/img/images7.gif" border="0"></a>
                  <input type="hidden" id="txtDataFinOld">
                  </div>
                </td>
            </tr>
                    <tr height="35px">
                      <td width="30%" class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  width="40%" class="text">
                        <select class="text" name="numRec" onchange="submitFrmSearch('1');">
                          <option class="text" value=5>5</option>
                          <option class="text" value=10>10</option>
                          <option class="text" value=20>20</option>
                          <option class="text" value=50>50</option>
                        </select>
                      </td>
                      <td width="20%" rowspan='2' class="textB" valign="center" align="center">
                        <input class="textB" type="button" name="Ripulisci" value="Ripulisci" onclick="ripulisci();">
                        <input class="textB" type="button" name="Esegui" value="Elabora" onclick="submitFrmSearch('0');">

                        <input class="textB" type="hidden" name="txtTypeLoad" value="">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
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
                      <td bgcolor="#FFFFFF" colspan="1" class="textB" align="center">No Record Found</td>
                    </tr>
   <%
  } else {
  %>
                    
                    <tr>
                      <td>
                        <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                        <tr>
                          <td bgcolor='#D5DDF1' class="textB" width="12%">Descrizione Comune</td>
                          <td bgcolor='#D5DDF1' class="textB" width="12%">Codice ISTAT</td>
                          <td bgcolor='#D5DDF1' class="textB" width="12%">Codice Comune</td>
                          <td bgcolor='#D5DDF1' class="textB" width="12%">Servizio</td>                         
                          <td bgcolor='#D5DDF1' class="textB" width="12%">Tipo Cluster</td> 
                          <td bgcolor='#D5DDF1' class="textB" width="12%">Codice Cluster</td> 
                          <td bgcolor='#D5DDF1' class="textB" width="12%">Data Inizio Validità Pricing</td>
                          <td bgcolor='#D5DDF1' class="textB" width="12%">Data Fine Validità pricing</td>
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote2.size()%>">
<pg:param name="txtTypeLoad" value="1"></pg:param>

<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>                        
<%

      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote2.size()) && (j<pagerPageNumber.intValue()*records_per_page));j++)      
      {
         remote = (I5_1COMUNI_CLUSTER_PRICING) aRemote2.elementAt(j);                                                
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";

%>
                        <TR>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDESCRIZIONE_COMUNE() %></TD>                           
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODICE_ISTAT_COMUNE() %></TD>                           
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODICE_COMUNE() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODE_TIPO_CONTR() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getTIPOLOGIA_CLUSTER_COMUNE() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODICE_CLUSTER() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_INIZIO_VALIDITA_PRICING().substring(0,10) %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_FINE_VALIDITA_PRICING().substring(0,10) %></TD>
                           
                        </tr>
                        <tr>
                          <td  bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
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
                          <td colspan='7' bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
                        </tr>
                         <tr>
        <td> &nbsp;
              </td>
              <td> 
        <input class="textB" type="button" name="Esporta" value="Export XLS" onclick="exportCsv('0');">
        </td>
         <td> 
                    <input class="textB" type="button" name="Indietro" value="Indietro" onclick="javascript:history.go(-1)">
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
    <td bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='3'></td>
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
