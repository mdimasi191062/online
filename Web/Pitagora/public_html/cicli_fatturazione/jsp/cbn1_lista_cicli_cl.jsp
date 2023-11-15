<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.utl.*,com.usr.*,java.util.Collection" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_lista_cicli_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  boolean bCheck = false;
  String bgcolor="";
  int i=0;
  int j=0;
     //Il campo contiene l'elemento selezionato dall'utente 
  String selCODE_CICLO_FATRZ =null;
  String sChecked="checked";
     // This is the variable we will store all records in.
  Collection collection=null;
  I5_2ANAG_CICLI_FATRZ_ROW[] aRemote = null;
  selCODE_CICLO_FATRZ =request.getParameter("CodSel");
 
  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------   
 
  //eventuale Filtro di ricerca
  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");  
  java.util.Date strDataRicercaDa = null;
  java.util.Date strDataRicercaA = null;
  String  txtDataRicercaDa = request.getParameter("txtDataRicercaDa");
  String  txtDataRicercaA = request.getParameter("txtDataRicercaA");  
  if ((txtDataRicercaDa !=null) && (txtDataRicercaDa.length()>0)) {
    strDataRicercaDa = df.parse(request.getParameter("txtDataRicercaDa"));
  }else{txtDataRicercaDa="";}  
  if ((txtDataRicercaA !=null) && (txtDataRicercaA.length()>0)) {
    strDataRicercaA = df.parse(request.getParameter("txtDataRicercaA"));
  }{txtDataRicercaA="";}    
  
  //Lettura dell'indice Numero record per pagina della combo per ripristino dopo ricaricamento
  int index=0;
  String strIndex = request.getParameter("txtnumRec");
  if (strIndex!=null)
  {
    Integer tmpindext=new Integer(strIndex);
    index=tmpindext.intValue();
  }
 
  //Lettura del valore Numero record per pagina della cisualizzazione risultato (default 5)
  int records_per_page=5;
  String strNumRec = request.getParameter("numRec");
  if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }
  
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Lista cicli di fatturazione</title>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<script language="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<script language="JavaScript">
<!--da qui gestione calendarietto-->
var message1="Click per selezionare la data selezionata";
var message2="Click per cancellare la data selezionata";
function cancelCalendar (objCalendar)
{
   objCalendar.value="";
}

function cancelLink ()
{
  return false;
}

function disableLink (link)
{
  if (link.onclick)
    link.oldOnClick = link.onclick;
  link.onclick = cancelLink;
  if (link.style)
    link.style.cursor = 'default';
}

function enableLink (link)
{
  link.onclick = link.oldOnClick ? link.oldOnClick : null;
  if (link.style)
    link.style.cursor = document.all ? 'hand' : 'pointer';
}
function showMessage (field)
{
	if (field=='seleziona')
		self.status=message1;
	else
		self.status=message2;
}

<!--fino a qui-->



function ONSTAMPA()
{
  openDialog("stampa_ciclo.jsp", 800, 600, "", "print");    
}
function ONNUOVO()
{    
  var sParametri='';
  sParametri= '?txtnumRec=<%=index%>';
  sParametri= sParametri + '&numRec=<%=records_per_page%>';
  sParametri= sParametri + '&txtDataRicercaDa=<%=txtDataRicercaDa%>'; 
  sParametri= sParametri + '&txtDataRicercaA=<%=txtDataRicercaA%>'; 
  sParametri= sParametri + '&modo=0'; 
  openDialog("cbn1_agg_ciclo_cl.jsp" + sParametri, 600, 300, "", "");      
}
function ONAGGIORNA()
{    
  var sParametri='';
  sParametri= '?txtnumRec=<%=index%>';
  sParametri= sParametri + '&numRec=<%=records_per_page%>';
  sParametri= sParametri + '&txtDataRicercaDa=<%=txtDataRicercaDa%>'; 
  sParametri= sParametri + '&txtDataRicercaA=<%=txtDataRicercaA%>'; 
  sParametri= sParametri + '&modo=1'; 
  sParametri= sParametri + '&CodSel=' + window.document.frmDati.CodSel.value;  
  openDialog("cbn1_agg_ciclo_cl.jsp" + sParametri, 600, 300);        
}

function ONELIMINA()
{
  if (confirm('Si conferma la cancellazione del ciclo di fatturazione selezionato?')==true){
    var sParametri='';
    sParametri= '?txtnumRec=<%=index%>';
    sParametri= sParametri + '&numRec=<%=records_per_page%>';
    sParametri= sParametri + '&txtDataRicercaDa=<%=txtDataRicercaDa%>'; 
    sParametri= sParametri + '&txtDataRicercaA=<%=txtDataRicercaA%>'; 
    window.document.frmDati.action=window.document.frmDati.action + sParametri;
    window.document.frmDati.submit();
  }
  return(false);
}
  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function chkDataRange(strDataDa,strDataA){
			var dataDa = new Date(strDataDa.substring(6,10),strDataDa.substring(3,5)-1,strDataDa.substring(0,2));
			var dataA = new Date(strDataA.substring(6,10),strDataA.substring(3,5)-1,strDataA.substring(0,2));
			if(dataDa>dataA)
				return false;
      return true;
}

function impData(strData){
			var appo = strData.substring(3,5) + "/" + strData.substring(0,2) + "/" + strData.substring(6,10);
      return appo;
}

function submitFrmSearch(typeLoad)
{
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.CodSel.value=document.frmDati.CodSel.value;
  document.frmSearch.txtTypeLoad.value=typeLoad;
  if(document.frmSearch.txtDataRicercaDa.value.length>0 && document.frmSearch.txtDataRicercaA.value.length>0)
  {
   if(!chkDataRange(document.frmSearch.txtDataRicercaDa.value,document.frmSearch.txtDataRicercaA.value)){
      alert("La 'data creazione a' deve essere maggiore della 'data creazione da'!");
      return(false);
   }  
  }
  Enable(document.frmSearch.txtDataRicercaDa);
  Enable(document.frmSearch.txtDataRicercaA);
  document.frmSearch.submit();
}  
function setnumRec()
{
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
}  

function ChangeSel(codice,indice)
{
  document.frmDati.CodSel.value=codice;
  document.frmSearch.CodSel.value=codice;  
//  document.frmDati.RagSel.value=eval('document.frmOlo.SelClienti[indice].value');
}
  //------------------------------------------------------------------------------
  //Fine Gestione Standard Ricerca
  //------------------------------------------------------------------------------  

</SCRIPT>
<TITLE>Selezione Tipo Ciclo</TITLE>
</HEAD>
<BODY onload="setnumRec();">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/ciclidifatt.gif" alt="" border="0"></td>
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Lista ciclo di fatturazione</td>
                <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='3'></td>
  </tr>
  <!-- Gestione navigazione-->
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="cbn1_lista_cicli_cl.jsp">
 
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
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Filtro di ricerca</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr>
                      <td colspan='5' bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td width="20%" class="textB" align="right">Data creazione da:</td>
                      <td  class="text" align="right">                                                    
                        <table>
                        <tr>
                          <td>
                          <% if (strDataRicercaDa==null) {%>
                            <input  type="text" name="txtDataRicercaDa" maxlength="10" size="10" class="text" onfocus='javascript:blur();'>
                          <%}else{%>
                            <input type="text" name="txtDataRicercaDa" value="<%=txtDataRicercaDa%>" class="text" maxlength="10" size="10" onfocus='javascript:blur();'>
                          <%}%>
                          </td>        
                          <td>
                           <a name="acalendar_txtDataRicercaDa" href="javascript:if(frmSearch.txtDataRicercaDa.value.length==0){showCalendar('frmSearch.txtDataRicercaDa','sysdate')}else{showCalendar('frmSearch.txtDataRicercaDa',impData(frmSearch.txtDataRicercaDa.value))};" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='calendar_txtDataRicercaDa' src="../../common/images/body/calendario.gif" border="no"></a>
                          </td>        
                          <td>         
                           <a name="acancel_txtDataRicercaDa"  href="javascript:cancelCalendar(window.document.frmSearch.txtDataRicercaDa);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_txtDataRicercaDa' src="../../common/images/body/cancella.gif" border="0"></a>
                          </td>        
                        </tr>
                        </table>
                      </td>                         
                      <td width="20%" class="textB" align="right">Data creazione a:</td>

                      <td  class="text" align="right">                                                    
                        <table>
                        <tr>
                          <td>
                          <% if (strDataRicercaA==null) {%>
                            <input class="text" type="text" name="txtDataRicercaA" maxlength="10" size="10" onfocus='javascript:blur();'>
                          <%}else{%>
                            <input class="text" type="text" name="txtDataRicercaA" value="<%=txtDataRicercaA%>" maxlength="10" size="10" onfocus='javascript:blur();'>
                          <%}%>
                          </td>        
                          <td>
                           <a name="acalendar_txtDataRicercaA" href="javascript:if(frmSearch.txtDataRicercaA.value.length==0){showCalendar('frmSearch.txtDataRicercaA','sysdate')}else{showCalendar('frmSearch.txtDataRicercaA',impData(frmSearch.txtDataRicercaA.value))};" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='calendar_txtDataRicercaA' src="../../common/images/body/calendario.gif" border="no"></a>
                          </td>        
                          <td>         
                           <a name="acancel_txtDataRicercaA"  href="javascript:cancelCalendar(window.document.frmSearch.txtDataRicercaA);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_txtDataRicercaA' src="../../common/images/body/cancella.gif" border="0"></a>
                          </td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>

                        </table>
                      </td>                         
                      <td width="10%" rowspan='2' class="textB" valign="center" align="center">
                        <input class="textB" type="button" name="Esegui" value="Popola" onclick="submitFrmSearch('0');">
                        <input class="textB" type="hidden" name="CodSel" value="<%=selCODE_CICLO_FATRZ%>"> 
                        <input class="textB" type="hidden" name="txtTypeLoad" value="">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                      </td>
                    </tr>
                    <tr>
                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <select class="text" name="numRec" onchange="submitFrmSearch('1');">
                          <option class="text" value=5>5</option>
                          <option class="text" value=10>10</option>
                          <option class="text" value=20>20</option>
                          <option class="text" value=50>50</option>
                        </select>
                      </td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>

                    </tr>
                  </table>
                </td>
              </tr>
            </table>
					</td>
        </tr>
        <tr>
          <td colspan='5' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
</form>
<form name="frmDati" method="post" action="cancella_ciclo_cl.jsp">
<EJB:useHome id="home" type="com.ejbSTL.I5_2ANAG_CICLI_FATRZEJBHome" location="I5_2ANAG_CICLI_FATRZEJB" />
<EJB:useBean id="ciclo" type="com.ejbSTL.I5_2ANAG_CICLI_FATRZEJB" scope="session" >
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<%
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
    aRemote = (I5_2ANAG_CICLI_FATRZ_ROW[]) session.getAttribute("aRemote");
  }
  else
  {
    collection = ciclo.findAll(strDataRicercaDa, strDataRicercaA);      
    if (!(collection==null || collection.size()==0)) {
      aRemote = (I5_2ANAG_CICLI_FATRZ_ROW[]) collection.toArray( new I5_2ANAG_CICLI_FATRZ_ROW[1]);
      session.setAttribute( "aRemote", aRemote);
    } else {
      session.setAttribute( "aRemote", null);
    }
  }
%>
<tr>
          <td>
            <table border="0" width="100%" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Cicli di fatturazione selezionati</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='2'></td>
                    </tr>
  <% 
  if ((aRemote==null)||(aRemote.length==0))  
  
  {
    %>
                    <tr>
                      <td bgcolor="#FFFFFF" class="textB" align="center">No Record Found</td>
                    </tr>
   <%
  } else {
  %>
                    
                    <tr>
                      <td>
                        <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                        <tr>
                          <td bgcolor='white' width="0%" >&nbsp;</td>      
                          <td bgcolor='#D5DDF1' class="textB" width="60%">Descrizione ciclo</td>
                          <td bgcolor='#D5DDF1' class="textB" width="20%">Data creazione</td>
                          <td bgcolor='#D5DDF1' class="textB" width="20%">Giorni inizio ciclo</td>
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote.length%>">
<pg:param name="txtTypeLoad" value="1"></pg:param>
<pg:param name="CodSel" value="<%=selCODE_CICLO_FATRZ%>"></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param> 
<pg:param name="txtDataRicercaDa" value="<%=txtDataRicercaDa%>"></pg:param> 
<pg:param name="txtDataRicercaA" value="<%=txtDataRicercaA%>"></pg:param> 

<%

      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote.length) && (j<pagerPageNumber.intValue()*records_per_page));j++)                              
      {
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";
         String CODE_CICLO_FATRZ          = aRemote[j].getCODE_CICLO_FATRZ();                                                    
         String DESC_CICLO_FATRZ          = aRemote[j].getDESC_CICLO_FATRZ();
         int VALO_GG_INIZIO_CICLO         = aRemote[j].getVALO_GG_INIZIO_CICLO();
         java.util.Date DATA_CREAZ_CICLO  = aRemote[j].getDATA_CREAZ_CICLO(); 
         sChecked="";
         if (selCODE_CICLO_FATRZ!=null){
            if(CODE_CICLO_FATRZ.equals(selCODE_CICLO_FATRZ)){
              sChecked="checked";
              bCheck=true;
            }  
         }  else {   
            if (i==0) {
              sChecked="checked";
              bCheck=true;              
              selCODE_CICLO_FATRZ=CODE_CICLO_FATRZ;
            }
         }  

%>
                        <TR>
                           <td bgcolor='white'>
                              <input type="radio" name="CODE_CICLO_FATRZ" value="<%= CODE_CICLO_FATRZ %>" <%=sChecked%> onclick=ChangeSel('<%=CODE_CICLO_FATRZ%>','<%=i%>')>
                           </td>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= DESC_CICLO_FATRZ %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= df.format(DATA_CREAZ_CICLO) %></TD>      
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= VALO_GG_INIZIO_CICLO %></TD>
                        </tr>
                        <tr>
                          <td colspan='4' bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='2'></td>
                        </tr>

<%
          i+=1;
        }
%>
<pg:index>
                        <tr>
                          <td bgcolor="#FFFFFF" colspan="4" class="text" align="center">
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

                        <tr>
                          <td colspan='4' bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='2'></td>
                        </tr>
                        </table>
<%
}
%>
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
    <td colspan='3' bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='2'></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
      <input type="hidden" name="CodSel" value="<%= selCODE_CICLO_FATRZ %>" >              
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />        
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>
<script language="javascript">
  Disable(document.frmSearch.txtDataRicercaDa);
  Disable(document.frmSearch.txtDataRicercaA);
<% 
if ((aRemote==null)||(aRemote.length==0)) { 
%>
    Disable(document.frmDati.ELIMINA);
    Disable(document.frmDati.STAMPA);
    Disable(document.frmDati.AGGIORNA);    
<%
}else{
  if (!bCheck){
    if (i==1){
%>
    document.frmDati.CODE_CICLO_FATRZ.checked=true;
    document.frmDati.CodSel.value=document.frmDati.CODE_CICLO_FATRZ.value;
<%    
    }else{    
%>
    document.frmDati.CODE_CICLO_FATRZ[0].checked=true;
    document.frmDati.CodSel.value=document.frmDati.CODE_CICLO_FATRZ[0].value;
<% 
    }
  }
}  
%>
</script>
</BODY>
</HTML>


