<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*" %>
<sec:ChkUserAuth />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"lista_profili.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  I5_6PROF_UTENTE_ROW[] aRemote = null;
  
  String bgcolor="";
  int i=0;
  int j=0;

  String sChecked = "";
  java.util.Collection appoVector=null;
    // Variabile per la memorizzazione delle informazioni dalla variabile collection
  
  String strRicerca = request.getParameter("txtRicerca");
  if (strRicerca==null)
    strRicerca="";

  // questo � il codice selezionato solo nel caso che si richiamino
  // le funzioni di inserimento, modifica o cancellazione 
  //Il campo contiene l'elemento selezionato dall'utente
  String CodSel=request.getParameter("CodSel");

  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  

    //Lettura dell'indice Numero record per pagina della combo per ripristino dopo  ricaricamento
  int index=0;
  String strIndex = request.getParameter("txtnumRec");
  if (strIndex!=null)
  {
    Integer tmpindext=new Integer(strIndex);
    index=tmpindext.intValue();
  }

    //Lettura dell'indice pager.offset
  
  String strPagerOffset = request.getParameter("pager.offset");
  if (strPagerOffset==null)
    strPagerOffset="0";

  int pageroffset = Integer.parseInt(strPagerOffset);

//Lettura del valore Numero record per pagina della combo per visualizzazione risultato (default 5)
  String strNumRec = request.getParameter("numRec");
  if (strNumRec==null)
    strNumRec="5";
  int records_per_page = Integer.parseInt(strNumRec);
  
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">

function ONNUOVO()
{
  esegui(0);
}

function ONAGGIORNA()
{
  esegui(1);
}
function ONCANCELLA()
{
  esegui(2);
}
function ONSTAMPA()
{
  openDialog("stampa_profili.jsp", 800, 500, "","print");
}

function esistonoRighe()
{
  var n = document.frmDati.elements.length;
  for(var i=0;i<n;i++)
  {
    if(document.frmDati.elements[i].type=='radio')
    {
      return true;
    }
  }
  return false;
}

function esegui(operazione)
{
/* operazione vale:
    0 per l'inserimento
    1 per l'aggiornamento
    2 per la cancellazione
*/
   var sParametri= '?txtnumRec=<%=index%>';
    sParametri= sParametri + '&numRec=<%=records_per_page%>';
    sParametri= sParametri + '&pager.offset=<%=strPagerOffset%>';
    sParametri= sParametri + '&txtTypeLoad=1'; 
    sParametri= sParametri + '&operazione=' + operazione;
    sParametri= sParametri + '&txtRicerca=<%=strRicerca%>'; 
    sParametri= sParametri + '&CodSel=' + document.frmDati.CodSel.value;
    openDialog("agg_profilo.jsp" + sParametri, 600, 200, "", "");
}
  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function submitFrmSearch(typeLoad)
{
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.CodSel.value=document.frmDati.CodSel.value;
  document.frmSearch.txtTypeLoad.value=typeLoad;
  document.frmSearch.method="post";
  document.frmSearch.submit();

}  
function setnumRec()
{
  document.frmSearch.numRec.options[<%=index%>].selected=true;

}

function ChangeSel(codice,indice)
{
  document.frmDati.CodSel.value=codice;
}

function deleteData(objs)
{
  obj = eval("document." + objs);
  obj.value="";
}

function selezionaPrimo()
{
  var n = document.frmDati.elements.length;
  var esiste=0;
  var selezionato=false;
  for(i=0;i<n;i++)
  {
    if(document.frmDati.elements[i].type=="radio")
    {
        esiste++;
        if(document.frmDati.elements[i].checked==true)
          selezionato=true;
    }
  }
  
  if(esiste>1 && !selezionato)
  {
      document.frmDati.indice[0].checked=true;
      document.frmDati.CodSel.value=document.frmDati.indice[0].value;
  }
  if(esiste==1 && !selezionato)
  {
      document.frmDati.indice.checked=true;
      document.frmDati.CodSel.value=document.frmDati.indice.value;
  }  
}

function abilitaTasti()
{
  if(!esistonoRighe())
  {
    if(document.frmDati.AGGIORNA)
    {
      Disable(document.frmDati.AGGIORNA);
    }
    if(document.frmDati.STAMPA)
    {
      Disable(document.frmDati.STAMPA);
    }
  }
}
</SCRIPT>

<TITLE>Gestione Utenti</TITLE>
</HEAD>
<BODY onload="">
  <!-- Gestione navigazione-->
<EJB:useHome id="home" type="com.ejbSTL.I5_6PROF_UTENTEejbHome" location="I5_6PROF_UTENTEejb" />
<EJB:useBean id="profili" type="com.ejbSTL.I5_6PROF_UTENTEejb" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
//Lettura del valore tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=0 Fare query (default)
// typeLoad=1 Variabile session

  int typeLoad=0;
  String strtypeLoad = request.getParameter("txtTypeLoad");
  if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }

  if (typeLoad!=0)
  {
    aRemote = (I5_6PROF_UTENTE_ROW[]) session.getAttribute("aRemote");
  }
  else
  {   
    appoVector = profili.FindAll(strRicerca);
    if (!(appoVector==null || appoVector.size()==0)) 
    {
      aRemote = (I5_6PROF_UTENTE_ROW[])appoVector.toArray(new I5_6PROF_UTENTE_ROW[1]);
      session.setAttribute( "aRemote", aRemote);
    }
    else
    {
      session.setAttribute("aRemote", null);
    }    
  } 


%>

<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="lista_profili.jsp">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/gestprofutenti.gif" alt="" border="0"></td>
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Gestione Profili Utente</td>
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
   <!-- A ON-->	    
   <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
					<td>
            <!-- B ON-->
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                    <tr>
                      <td >
                          <!-- C ON-->
                          <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                          <tr>
                            <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp; Filtro di Ricerca</td>
                            <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                          </tr>
                          <!-- C OFF-->
                          </table>
                      </td>
                    </tr>

              <tr>
                <td>
                  <!-- D ON-->
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr>
                      <td colspan='4' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td width="20%" class="textB" align="right">Codice Profilo:</td>
                      <td  width="25%" class="text">
                                            <input class="text" type='text' name='txtRicerca'  size='11'
                        <%if (strRicerca==null){%>><%}else{%>value='<%=strRicerca%>' ><%}%>
                     </td>
                      <td width="10%" class="textB" valign="right" align="right">
                        <input class="textB" type="button" name="Esegui" value="Popola" onclick="submitFrmSearch('0');">                    
                        <input type="hidden" name="CodSel" value="">                     
                        <input type="hidden" name="txtTypeLoad" value="">
                        <input type="hidden" name="txtnumRec" value="">
                        <!--<input type="hidden" name="txtnumPag" value="1"> 
                        <input type="hidden" name="pager.offset" value="<%//=pageroffset%>">-->
                        
                      </td>
         					  <td>&nbsp;</td>
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
                  <!-- D OFF-->
                  </table>
                </td>
              </tr>
            <!-- B OFF-->  
            </table>
					</td>
        </tr>
        <tr>
          <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
</form>
  <!-- Gestione navigazione-->
<form name="frmDati" method="post" action='lista_profili.jsp'>
        <tr>
          <td>
            <table border="0" width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Lista Profili</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td colspan='1' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
  <% 
  if ((aRemote==null)||(aRemote.length==0))  
  
  {
    %>
                    <tr>
                      <td bgcolor="#FFFFFF" colspan="1" class="textB" align="center">Nessun Record Trovato</td>
                    </tr>
   <%
  } else {
  %>
                    
                    <tr>
                      <td>
                        <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                        <tr>
                          <td bgcolor='white' width="0%" >&nbsp;</td>      
                          <td bgcolor='#D5DDF1' class="textB" width="40%" >Codice Profilo</td>
                          <td bgcolor='#D5DDF1' class="textB" width="60%">Descrizione Profilo</td>
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote.length%>">
<pg:param name="txtTypeLoad" value="1"></pg:param>
<pg:param name="CodSel" value="<%=CodSel%>"></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="txtRicerca" value="<%=strRicerca%>"></pg:param>
<!--<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>-->

<%
  String            CODE_PROF_UTENTE =null;
  String            DESC_PROF_UTENTE =null;


  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote.length) && (j<pagerPageNumber.intValue()*records_per_page));j++)
      {
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";

        CODE_PROF_UTENTE = aRemote[j].getCODE_PROF_UTENTE();
        DESC_PROF_UTENTE = aRemote[j].getDESC_PROF_UTENTE();
         if (CodSel!=null)
         {
             if (CodSel.equals(CODE_PROF_UTENTE))
             {
                  sChecked="checked";
             }
             else
             {
                  sChecked="";
             }
          }
%>
                        <TR>
                           <td bgcolor='white'>
                              <input type="radio" name="indice" <%=sChecked%> value="<%=CODE_PROF_UTENTE%>" onClick="ChangeSel('<%=CODE_PROF_UTENTE%>','0')" >
                           </td>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%=CODE_PROF_UTENTE%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%=DESC_PROF_UTENTE%></TD>
                        </tr>
                        <tr>
                          <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                        </tr>

<%
          i+=1;
        }
%>

                        <tr>
                          <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="3" height='2'></td>
                        </tr>
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
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <td class="textB" bgcolor="#D5DDF1" align="center" colspan="5">
            <input type="hidden" name="CodSel" value="<%= CodSel %>" >
            <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
	        </td>
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>
<SCRIPT LANGUAGE="JavaScript">
    setnumRec();
    selezionaPrimo();
    abilitaTasti();
</SCRIPT>
</BODY>
</HTML>
