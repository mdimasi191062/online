<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"lista_gestori.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");


  String bgcolor="";
  int i=0;
  int j=0;
  int k=0;


  String sChecked = "";
  java.util.Collection appoVector=null;
    // Variabile per la memorizzazione delle informazioni dalla variabile collection
  I5_3GEST_TLC_ROW[] aRemote = null;
  I5_3GEST_TLC_ROW[] bRemote = null;
  String strRicerca = request.getParameter("txtRicerca");
  if (strRicerca==null)
    strRicerca="";

  // questo è il codice selezionato solo nel caso che si richiamino
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
function esistonoRigheNG()
{
  var n = document.frmNuoviGestori.elements.length;
  for(var i=0;i<n;i++)
  {
    if(document.frmNuoviGestori.elements[i].type=='radio')
    {
      return true;
    }
  }
  return false;
}


function abilitaTasti()
{
  if(!esistonoRighe())
  {
    if(document.frmDati.DETTAGLIO)
    {
      Disable(document.frmDati.DETTAGLIO);
    }
    if(document.frmDati.AGGIORNA)
    {
      Disable(document.frmDati.AGGIORNA);
    }
    if(document.frmDati.STAMPA)
    {
      Disable(document.frmDati.STAMPA);
    }   
  }

  if(!esistonoRigheNG() || !esistonoRighe())
  {
    
    if(document.frmNuoviGestori.ASSOCIA)
    {
      Disable(document.frmNuoviGestori.ASSOCIA);
    }
  }
  if(!esistonoRigheNG())
  {
    if(document.frmNuoviGestori.INSERISCI)
    {
      Disable(document.frmNuoviGestori.INSERISCI);
    }
  }

}

function ONSTAMPA()
{
  openDialog("stampa_gestori.jsp", 800, 500, "","print");
}

function ONDETTAGLIO()
{
  if(esistonoRighe())
  {
    var sParametri= '?txtnumRec=<%=index%>';
    sParametri= sParametri + '&numRec=<%=records_per_page%>';
    sParametri= sParametri + '&pager.offset=<%=strPagerOffset%>';
    sParametri= sParametri + '&txtTypeLoad=1'; 
    sParametri= sParametri + '&txtRicerca=<%=strRicerca%>'; 
    sParametri= sParametri + '&CodSel=' + document.frmDati.CodSel.value;
    sParametri= sParametri + '&Operazione=1';
    openDialog("agg_gestore.jsp" + sParametri, 800, 480);
  }
}

function ONAGGIORNA()
{
  if(esistonoRighe())
  {
    var sParametri= '?txtnumRec=<%=index%>';
    sParametri= sParametri + '&numRec=<%=records_per_page%>';
    sParametri= sParametri + '&pager.offset=<%=strPagerOffset%>';
    sParametri= sParametri + '&txtTypeLoad=1'; 
    sParametri= sParametri + '&txtRicerca=<%=strRicerca%>'; 
    sParametri= sParametri + '&CodSel=' + document.frmDati.CodSel.value;
    sParametri= sParametri + '&Operazione=0';
    openDialog("agg_gestore.jsp" + sParametri, 800, 480);
  }
}

function ONASSOCIA()
{
  if(esistonoRigheNG() && esistonoRighe())
  {
    if (confirm('Si conferma l\'associazione del nuovo gestore selezionato \n con il gestore normalizzato selezionato?')==true)
    {
      var sParametri= '?txtnumRec=<%=index%>';
      sParametri= sParametri + '&numRec=<%=records_per_page%>';
      sParametri= sParametri + '&pager.offset=<%=strPagerOffset%>';
      sParametri= sParametri + '&txtTypeLoad=1'; 
      sParametri= sParametri + '&CodSel=' + document.frmDati.CodSel.value;
      sParametri= sParametri + '&CODE_GEST_ORIG=' + document.frmNuoviGestori.CODE_GEST_ORIG.value;
      sParametri= sParametri + '&FLAG_SYS=' + document.frmNuoviGestori.FLAG_SYS.value;
      sParametri= sParametri + '&txtRicerca=<%=strRicerca%>';
      window.location.href="associa_gestore.jsp" + sParametri; 
    }
  }
}


function ONINSERISCI()
{
  if(esistonoRigheNG())
  {
    var sParametri= '?txtnumRec=<%=index%>';
    sParametri= sParametri + '&numRec=<%=records_per_page%>';
    sParametri= sParametri + '&pager.offset=<%=strPagerOffset%>';
    sParametri= sParametri + '&txtTypeLoad=1'; 
    sParametri= sParametri + '&txtRicerca=<%=strRicerca%>'; 
    sParametri= sParametri + '&CodSel=' + document.frmDati.CodSel.value;
    sParametri= sParametri + '&CODE_GEST_ORIG=' + document.frmNuoviGestori.CODE_GEST_ORIG.value;
    sParametri= sParametri + '&FLAG_SYS=' + document.frmNuoviGestori.FLAG_SYS.value;
    openDialog("inserisci_codice_gestore.jsp" + sParametri, 400, 200);
  }
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

function ChangeSelNG(codice,flagsys)
{
  document.frmNuoviGestori.CODE_GEST_ORIG.value=codice;
  document.frmNuoviGestori.FLAG_SYS.value=flagsys;  
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

function selezionaPrimoNuovi()
{
  var n = document.frmNuoviGestori.elements.length;
  var esiste=0;
  var selezionato=false;
  for(i=0;i<n;i++)
  {
    if(document.frmNuoviGestori.elements[i].type=="radio")
    {
        esiste++;
        if(document.frmNuoviGestori.elements[i].checked==true)
          selezionato=true;
    }
  }
  
  if(esiste>1 && !selezionato)
  {
      document.frmNuoviGestori.indice[0].click();
  }
  if(esiste==1 && !selezionato)
  {
      document.frmNuoviGestori.indice.click();
  }  
}
</SCRIPT>

<TITLE>FATTURAZIONE NON TRAFFICO</TITLE>
</HEAD>
<BODY onload="">
  <!-- Gestione navigazione-->
<EJB:useHome id="home" type="com.ejbSTL.I5_3GEST_TLCejbHome" location="I5_3GEST_TLCejb" />  
<EJB:useBean id="gestori" type="com.ejbSTL.I5_3GEST_TLCejb" scope="session">
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
    aRemote = (I5_3GEST_TLC_ROW[]) session.getAttribute("aRemote");
  }
  else
  {   
     appoVector = gestori.findAllNorm(strRicerca);

    if (!(appoVector==null || appoVector.size()==0)) 
    {
      aRemote = (I5_3GEST_TLC_ROW[])appoVector.toArray(new I5_3GEST_TLC_ROW[1]);
      session.setAttribute( "aRemote", aRemote);
    }
    else
    {
      session.setAttribute("aRemote", null);
    }  

  } 

%>

<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="lista_gestori.jsp">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/gestgestnorm.gif" alt="" border="0"></td>
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Gestione Gestori Normalizzati</td>
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
	    <table width="90%" border="0" cellspacing="0" cellpadding="1" align='center'>
                   <tr>
                      <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
				<tr>
					<td>
                          <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                          <tr>
                            <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp; Filtro di Ricerca</td>
                            <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                          </tr>
                          </table>                        
					</td>
				</tr>
      </table>                          
                      </td>
                  </tr>       
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr>
                      <td colspan='5' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>

                    <tr>
                      <td width="20%" class="textB" align="right">Ragione Sociale:</td>
                      <td  width="25%" class="text">
                                            <input class="text" type='text' name='txtRicerca'  size='11'
                        <%if (strRicerca==null){%>><%}else{%>value='<%=strRicerca%>' ><%}%>
                     </td>
                      <td width="10%" rowspan='2' class="textB" valign="right" align="right">
                        <input class="textB" type="button" name="Esegui" value="Popola" onclick="submitFrmSearch('0');">                    
                        <input type="hidden" name="CodSel" value="">                     
                        <input type="hidden" name="txtTypeLoad" value="">
                        <input type="hidden" name="txtnumRec" value="">
                        <!--<input type="hidden" name="txtnumPag" value="1"> 
                        <input type="hidden" name="pager.offset" value="<%//=pageroffset%>">-->
                        
                      </td>
                                         <td>&nbsp;</td>
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
<form name="frmDati" method="post" action='lista_gestori.jsp'>
        <tr>
          <td>
            <table border="0" width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Lista Gestori Normalizzati</td>
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
  } else {
  %>
                    
                    <tr>
                      <td>
                        <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                        <tr>
                          <td bgcolor='white'  width="0%" >&nbsp;</td>      
                          <td bgcolor='#D5DDF1' class="textB" width="5%">Codice</td>
                          <td bgcolor='#D5DDF1' class="textB" width="5%">Tipologia<br>Operatore</td>
                          <td bgcolor='#D5DDF1' class="textB" width="5%">Tipo<br>Gestore</td>
                          <td bgcolor='#D5DDF1' class="textB" width="45%">Ragione<br>Sociale</td>
                          <td bgcolor='#D5DDF1' class="textB" width="15%">Sigla</td>
                          <td bgcolor='#D5DDF1' class="textB" width="15%">Partita<br>Iva</td>                          
                          <td bgcolor='#D5DDF1' class="textB" width="5%">Classic</td>
                          <td bgcolor='#D5DDF1' class="textB" width="5%">Special</td>                          
                       </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote.length%>">
<pg:param name="typeLoad" value="1"></pg:param>
<pg:param name="CodSel" value="<%=CodSel%>"></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="txtRicerca" value="<%=strRicerca%>"></pg:param>
<!--<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>-->

<%
    String CODE_GEST=null;
    String CODE_TIPOL_OPERATORE=null;
    String CODE_TIPO_GEST=null;
    String NOME_RAG_SOC_GEST=null;
    String NOME_GEST_SIGLA=null;
    String CODE_PARTITA_IVA=null;
    String FLAG_CLASSIC=null;
    String FLAG_SPECIAL=null;


      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote.length) && (j<pagerPageNumber.intValue()*records_per_page));j++)
      {
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";

          CODE_GEST=aRemote[j].getCODE_GEST();
          CODE_TIPOL_OPERATORE=aRemote[j].getCODE_TIPOL_OPERATORE();
          CODE_TIPO_GEST=aRemote[j].getCODE_TIPO_GEST();
          NOME_RAG_SOC_GEST=aRemote[j].getNOME_RAG_SOC_GEST();
          NOME_GEST_SIGLA=aRemote[j].getNOME_GEST_SIGLA();
          CODE_PARTITA_IVA=aRemote[j].getCODE_PARTITA_IVA();
          FLAG_CLASSIC=aRemote[j].getFLAG_CLASSIC();
          FLAG_SPECIAL=aRemote[j].getFLAG_SPECIAL();
         if (CodSel!=null)
         {
             if (CodSel.equals(CODE_GEST))
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
                              <input type="radio" name="indice" <%=sChecked%> value="<%=CODE_GEST%>" onClick="ChangeSel('<%=CODE_GEST%>','0')" >
                           </td>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%if(CODE_GEST!=null){out.println(CODE_GEST);}else{out.println("&nbsp;");}%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%if(CODE_TIPOL_OPERATORE!=null){out.println(CODE_TIPOL_OPERATORE);}else{out.println("&nbsp;");}%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%if(CODE_TIPO_GEST!=null){out.println(CODE_TIPO_GEST);}else{out.println("&nbsp;");}%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%if(NOME_RAG_SOC_GEST!=null){out.println(NOME_RAG_SOC_GEST);}else{out.println("&nbsp;");}%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%if(NOME_GEST_SIGLA!=null){out.println(NOME_GEST_SIGLA);}else{out.println("&nbsp;");}%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%if(CODE_PARTITA_IVA!=null){out.println(CODE_PARTITA_IVA);}else{out.println("&nbsp;");}%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%if(FLAG_CLASSIC!=null){out.println(FLAG_CLASSIC);}else{out.println("&nbsp;");}%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%if(FLAG_SPECIAL!=null){out.println(FLAG_SPECIAL);}else{out.println("&nbsp;");}%></TD>
                        </tr>
                        <tr>
                          <td colspan='9' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                        </tr>

<%
          i+=1;
        }
%>

                        <tr>
                          <td colspan='9' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="3" height='2'></td>
                        </tr>
<pg:index>
                        <tr>
                          <td bgcolor="#FFFFFF" colspan="9" class="text" align="center">
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

	        </td>
          <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>
<%
     appoVector = null;
     appoVector = gestori.findAllNuovi();
     if (!(appoVector==null || appoVector.size()==0)) 
     {
       bRemote = (I5_3GEST_TLC_ROW[])appoVector.toArray(new I5_3GEST_TLC_ROW[1]);
     }
   
%>
<form name="frmNuoviGestori">

            <table border="0" width="81%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98" align="center">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Lista Nuovi Gestori Classic/Special</td>
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
  if ((bRemote==null)||(bRemote.length==0))  
  
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
                          <td bgcolor='white' class="textB" width="0%">&nbsp;</td>      
                          <td bgcolor='#D5DDF1' class="textB" width="5%">Codice</td>
                          <td bgcolor='#D5DDF1' class="textB" width="10%">Tipologia<br>Operatore</td>
                          <td bgcolor='#D5DDF1' class="textB" width="5%">Tipo<br>Gestore</td>
                          <td bgcolor='#D5DDF1' class="textB" width="40%">Ragione<br>Sociale</td>
                          <td bgcolor='#D5DDF1' class="textB" width="15%">Sigla</td>
                          <td bgcolor='#D5DDF1' class="textB" width="15%" >Partita<br>Iva</td>                          
                          <td bgcolor='#D5DDF1' class="textB" width="10%">Provenienza</td>
                       </tr>

<%
    String CODE_GEST=null;
    String CODE_TIPOL_OPERATORE=null;
    String CODE_TIPO_GEST=null;
    String NOME_RAG_SOC_GEST=null;
    String NOME_GEST_SIGLA=null;
    String CODE_PARTITA_IVA=null;
    String FLAG_SYS=null;
    i=0;
      //Scrittura dati su lista
      for(k=0;k<6 && k<bRemote.length;k++)
      {
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";

          CODE_GEST=bRemote[k].getCODE_GEST();
          CODE_TIPOL_OPERATORE=bRemote[k].getCODE_TIPOL_OPERATORE();
          CODE_TIPO_GEST=bRemote[k].getCODE_TIPO_GEST();
          NOME_RAG_SOC_GEST=bRemote[k].getNOME_RAG_SOC_GEST();
          NOME_GEST_SIGLA=bRemote[k].getNOME_GEST_SIGLA();
          CODE_PARTITA_IVA=bRemote[k].getCODE_PARTITA_IVA();
          FLAG_SYS=bRemote[k].getFLAG_SYS();
 
%>
                        <TR>
                           <td bgcolor='white'>
                              <input type="radio" name="indice"  value="<%=CODE_GEST%>" onClick="ChangeSelNG('<%=CODE_GEST%>','<%=FLAG_SYS%>')" >
                           </td>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%if(CODE_GEST!=null){out.println(CODE_GEST);}else{out.println("&nbsp;");}%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%if(CODE_TIPOL_OPERATORE!=null){out.println(CODE_TIPOL_OPERATORE);}else{out.println("&nbsp;");}%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%if(CODE_TIPO_GEST!=null){out.println(CODE_TIPO_GEST);}else{out.println("&nbsp;");}%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%if(NOME_RAG_SOC_GEST!=null){out.println(NOME_RAG_SOC_GEST);}else{out.println("&nbsp;");}%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%if(NOME_GEST_SIGLA!=null){out.println(NOME_GEST_SIGLA);}else{out.println("&nbsp;");}%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%if(CODE_PARTITA_IVA!=null){out.println(CODE_PARTITA_IVA);}else{out.println("&nbsp;");}%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%if(FLAG_SYS!=null){out.println(FLAG_SYS);}else{out.println("&nbsp;");}%></TD>
                        </tr>
                        <tr>
                          <td colspan='8' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                        </tr>

<%
          i+=1;
        }
    }
%>
                        </table>
                      </td>
                    </tr>        
                  </table>
                </td>
              </tr>
            </table>
  </tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='1'></td>
  </tr>
  <tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <td class="textB" bgcolor="#D5DDF1" align="center" colspan="5">
            <input type="hidden" name="CODE_GEST_ORIG">
            <input type="hidden" name="FLAG_SYS">
            <input class="textB" type="button" name="INSERISCI" value="Inserisci" onClick="ONINSERISCI();">
            <input class="textB" type="button" name="ASSOCIA" value="Associa" onClick="ONASSOCIA();">
	        </td>
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>









                    
<SCRIPT LANGUAGE="JavaScript">
    setnumRec();
    abilitaTasti();
    selezionaPrimo();
    selezionaPrimoNuovi();
</SCRIPT>
</BODY>
</HTML>
