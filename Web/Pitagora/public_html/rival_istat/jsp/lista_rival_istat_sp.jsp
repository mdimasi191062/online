<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.utl.*,com.usr.*,,java.util.Vector" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"lista_rival_istat_sp.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
    //---------------------------------------------------------------------------------
    //                                Dichiarazioni
    //---------------------------------------------------------------------------------    
    //Se valorizzato ad uno indica che la pagina e richiamata dalla pagina di cancellazione 
    //e bisogna dare un avviso all'utente 
  String bErrore = null;
  String bgcolor="";
    //Flag per individuare se una riga é selezionata
  boolean bCheck = false;
  int i=0;
  int j=0;
     //Il campo contiene l'elemento selezionato dall'utente
  String selANNO=null;
  String sChecked="checked";
    // This is the variable we will store all records in.
    // Collection collection=null;
  Vector indiciVector = null;
    // Variabile per la memorizzazione delle informazioni dalla variabile collection
  IndiceIstat[] aRemote = null;
  String anno = null;
  Float indice_istat = null;
  IndiceIstat indiceIstat =  null;
  bErrore = request.getParameter("bErrore");
  if (bErrore!=null)
    selANNO=(String) session.getAttribute("anno");
  else 
    selANNO=request.getParameter("CodSel");
  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  

    //eventuale Filtro di ricerca
  String strCodRicerca= request.getParameter("txtCodRicerca");

    //Lettura dell'indice Numero record per pagina della combo per ripristino dopo  ricaricamento
  int index=0;
  String strIndex = request.getParameter("txtnumRec");
  if (strIndex!=null)
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
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
function ONSTAMPA()
{
  openDialog("stampa_istat_sp.jsp", 800, 600, "","print");  
}
function ONNUOVO()
{
  var sParametri='';
  sParametri= '?txtnumRec=<%=index%>';
  sParametri= sParametri + '&numRec=<%=records_per_page%>';
  sParametri= sParametri + '&txtTypeLoad=1'; 
<%
  if (!(strCodRicerca==null))
  {
%>
    sParametri= sParametri + '&txtCodRicerca=<%=strCodRicerca%>'; 
    sParametri= sParametri + '&ANNO=' + document.frmSearch.CodSel.value;    
<%
  }
%>     
  sParametri= sParametri + '&strProvenienza=0';
  openDialog("cbn1_ins_rival_istat_sp.jsp" + sParametri , 600, 400);    
}

function ONELIMINA()
{
  if (confirm('Si conferma la cancellazione Indice Istat selezionato ?')==true)
    {
    var sParametri='';
    sParametri= '?txtnumRec=<%=index%>';
    sParametri= sParametri + '&numRec=<%=records_per_page%>';
    sParametri= sParametri + '&txtTypeLoad=1'; 
<%
  if (!(strCodRicerca==null)){
%>
    sParametri= sParametri + '&txtCodRicerca=<%=strCodRicerca%>'; 
<%
  }
%>    
    window.document.frmDati.method="POST";
    window.document.frmDati.action="cbn1_canc_rival_istat_sp.jsp" + sParametri;
    window.document.frmDati.submit();    
  }
  return(false);
}

  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function submitFrmSearch(typeLoad)
{
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.CodSel.value=document.frmSearch.CodSel.value;
  document.frmSearch.txtTypeLoad.value=typeLoad;
  document.frmSearch.submit();
}  
function setnumRec()
{
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true');

}

function ChangeSel(codice,indice)
{
  document.frmSearch.CodSel.value=codice;
}
  //------------------------------------------------------------------------------
  //Fine Gestione Standard Ricerca
  //------------------------------------------------------------------------------  

</SCRIPT>


<TITLE> Lista Indice Istat</TITLE>
</HEAD>
<BODY onLoad="setnumRec();">

<EJB:useHome id="home" type="com.ejbSTL.ISTATHome" location="ISTAT"/>
<EJB:useBean id="remote_ISTAT" type="com.ejbSTL.ISTAT" scope="session">
<EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
  if (typeLoad!=0)
  {
    aRemote = (IndiceIstat[]) session.getAttribute("aRemote");
  }
  else
  {
    indiciVector = remote_ISTAT.ElencoIndici(strCodRicerca);    
    if (!(indiciVector==null || indiciVector.size()==0)) 
    {
      aRemote = (IndiceIstat[]) indiciVector.toArray( new IndiceIstat[1]);
      session.setAttribute( "aRemote", aRemote);
    }
    else
      session.setAttribute( "aRemote", null);    
  }
  //------------------------------------------------------------------------------
  //Fine Standard Ricerca
  //------------------------------------------------------------------------------  
%>
  <!-- Gestione navigazione-->
    <table align="center" width="90%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src="../images/rivalutazioneistat.gif" alt="" border="0"></td>
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
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Lista Istat</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
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
                          <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Filtro di Ricerca</td>
                          <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
  <form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="lista_rival_istat_sp.jsp">                  
                  <tr>                  
                    <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                        <tr>
                          <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                        </tr>
                        <tr>
                          <td width="40%" class="textB" align="right">Anno Indice Istat:&nbsp;</td>
                          <td  width="40%" class="text">
<%
if (strCodRicerca==null)
{
%>
                            <input class="text" type='text' name='txtCodRicerca'  size='20'>                        
<%                        
}
else
{
%>
                            <input class="text" type='text' name='txtCodRicerca' value='<%=strCodRicerca%>' size='20'>                        
<%                        
}
%>
                          </td>
                          <td width="20%" rowspan='2' class="textB" valign="center" align="center">
                            <input class="textB" type="button" name="Esegui" value="Popola" onclick="submitFrmSearch('0');">
<% 
if (selANNO!=null)
{
%>
                            <input class="textB" type="hidden" name="CodSel" value="<%=selANNO%>">
<%
}
else
{
%>
                            <input class="textB" type="hidden" name="CodSel" value="">
<%
}  
%>
                            <input class="textB" type="hidden" name="txtTypeLoad" value="">
                            <input class="textB" type="hidden" name="txtnumRec" value="">
                            <input class="textB" type="hidden" name="txtnumPag" value="1">
                          </td>
                        </tr>
                        <tr>
                          <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                          <td  class="text">
                            <select class="text" name="numRec" onchange="submitFrmSearch('1');">
                              <option class="text" value="5">5</option> <option class="text" value="10">10</option>
                              <option class="text" value="20">20</option> <option class="text" value="50">50</option>
                            </select>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
            </tr>
</form>
  <!-- Gestione navigazione-->
<form name="frmDati" method="post" action='lista_rival_istat_sp.jsp'>
            <tr>
              <td>
                <table border="0" width="100%" align = "center" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                        <tr>
                          <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Lista Indici Istat</td>
                          <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                        </tr>
<% 
if ((aRemote==null)||(aRemote.length==0))  
{
%>
                        <tr>
                          <td bgcolor="#FFFFFF" class="textB" align="center">Nessun Record Trovato</td>
                        </tr>
<%
} 
else 
{
%>
                        <tr>
                          <td>
                            <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                            <tr>
                              <td bgcolor='white' width="0%" >&nbsp;</td>      
                              <td bgcolor='#D5DDF1' width="50%" class="textB" >Anno</td>
                              <td bgcolor='#D5DDF1' width="50%" class="textB" >Indice Istat</td>
                            </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote.length%>">
<pg:param name="typeLoad" value="1"></pg:param>
<pg:param name="CodSel" value=""></pg:param>
<pg:param name="txtCodRicerca" value="<%=strCodRicerca%>"></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>                        
<%
      //Scrittura dati su lista
    for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote.length) && (j<pagerPageNumber.intValue()*records_per_page));j++) 
    {
      indiceIstat = new IndiceIstat();
      indiceIstat = (IndiceIstat) aRemote[j];                                                
      if ((i%2)==0)
        bgcolor="#EBF0F0";
      else
        bgcolor="#CFDBE9";    
      anno = indiceIstat.getAnno();
      indice_istat =indiceIstat.getIndice();
      if (selANNO!=null)
      {
        if(anno.equals(selANNO))
        {
          selANNO=anno;
          sChecked="checked";
          bCheck=true;
        }
        else
          sChecked="";
      }
      else 
      {   
        if (i==0) 
        {
          sChecked="checked";
          selANNO=anno;
          bCheck=true;              
        }
        else
          sChecked="";
      }  
%>
                            <TR>
                               <td bgcolor='white'>
                                  <input type="radio" name="txtANNO" value="<%=anno %>" <%=sChecked%> onclick=ChangeSel('<%=anno%>','<%=i%>')>
                               </td>
                               <TD bgcolor='<%=bgcolor%>' class='text'><%=anno%></TD>
                                  <input type="hidden" name="txtINDICE_ISTAT" value=<%=indice_istat%>-">
                               <TD bgcolor='<%=bgcolor%>' class='text'><%= indice_istat.toString().replace('.',',') %></TD>            
                            </tr>                   
                            <tr>
                              <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                            </tr>

<%
          i+=1;
        }
%>
                            <tr>
                              <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                            </tr>
<!--*****************-->
<pg:index>
                            <tr>
                              <td bgcolor="#FFFFFF" colspan="3" class="text" align="center">
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
        <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
      </tr>
      <tr>
        <td>
<sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />	        
        </td>
      </tr>
</table>
  </form>
<script language="javascript">
<% 
if ((aRemote==null)||(aRemote.length==0)) 
{ 
%>
    document.frmDati.ELIMINA?Disable(document.frmDati.ELIMINA):null;
    document.frmDati.STAMPA?Disable(document.frmDati.STAMPA):null;    
<%
}
else
{
  if (!bCheck)
  {
    if (i==1)
    {
%>
      document.frmDati.txtANNO.checked=true;
<%    
    }
    else
    {    
%>
      document.frmDati.txtANNO[0].checked=true;
<% 
    }
  }
}  
%>
</script>
</BODY>
</HTML>