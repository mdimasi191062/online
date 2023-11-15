<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*,java.util.Vector" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"lista_associazioni.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  String bgcolor="";
  int i=0;
  int j=0;
  String CODE_PROF_UTENTE=null;
  String CODE_FUNZ=null;
  String CODE_OP_ELEM=null;
  String DESC_OP_ELEM=null;  
  
  String sChecked = "";
  java.util.Vector appoVector=null;

  // Variabile per la memorizzazione delle informazioni dalla variabile collection
  I5_6MEM_FUNZ_PROF_OP_EL_ROW[] aRemote = null;

  //Il campo contiene l'elemento selezionato dall'utente
  String CodSel=request.getParameter("CodSel");
  String selCODE_PROF_UTENTE=null;
  // Codice Profilo Utente
  String strCODE_PROF_UTENTE = request.getParameter("CODE_PROF_UTENTE");
  if (strCODE_PROF_UTENTE==null)
    strCODE_PROF_UTENTE="";
  // Codice Funzione
  String strCODE_FUNZ = request.getParameter("CODE_FUNZ");
  if (strCODE_FUNZ==null)
    strCODE_FUNZ="";
  // Codice Operazione
  String strCODE_OP_ELEM = request.getParameter("CODE_OP_ELEM");
  if (strCODE_OP_ELEM==null)
    strCODE_OP_ELEM="";

  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
    //Lettura dell'indice Numero record per pagina della combo per ripristino dopo  ricaricamento
  int index=0;
  String strIndex = request.getParameter("txtnumRec");
  if (strIndex!=null)
  {
    if(!strIndex.equals(""))
    {
      Integer tmpindext=new Integer(strIndex);
      index=tmpindext.intValue();
    }
  }
// Lettura dell'Indice Profilo per la combo Profilo Utente 
  int ind_prof_utente=0;
  String strInd_prof_utente = request.getParameter("txtProfUtente");
  if (strInd_prof_utente!=null)
  {
    if(!strInd_prof_utente.equals(""))
    {
      Integer tmpind_prof_utente=new Integer(strInd_prof_utente);
      ind_prof_utente=tmpind_prof_utente.intValue();
    }
  }
// Lettura dell'Indice Funzione per la combo Funzioni
  int ind_funz=0;
  String strInd_funz = request.getParameter("txtFunz");
  if (strInd_funz!=null)
  {
    if(!strInd_funz.equals(""))
    {
      Integer tmpind_funz=new Integer(strInd_funz);
      ind_funz=tmpind_funz.intValue();
    }
  }  
// Lettura dell'Indice Operazione per la combo Operazioni
  int ind_oper=0;
  String strInd_oper = request.getParameter("txtOper");
  if (strInd_oper!=null)
  {
    if(!strInd_oper.equals(""))
    {
      Integer tmpind_oper=new Integer(strInd_oper);
      ind_oper=tmpind_oper.intValue();
    }
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
function ONSTAMPA()
{
  openDialog("stampa_associazione.jsp", 800, 500, "","print");
}

function ONNUOVO()
{
  gestOperazione(0);
}

function ONAGGIORNA()
{
  gestOperazione(1);
}
function ONCANCELLA()
{
  gestOperazione(2);
}
function gestOperazione(operazione){
  var sParametri='';
  sParametri= '?txtnumRec=<%=index%>';
  sParametri= sParametri + '&numRec=<%=records_per_page%>';
  sParametri= sParametri + '&txtTypeLoad=0'; 
  sParametri= sParametri + '&operazione=' + operazione;
  if (operazione!=0){
    sParametri= sParametri + '&txtCODE_PROF_UTENTE=' + document.frmDati.txtCODE_PROF_UTENTE.value;
    sParametri= sParametri + '&txtCODE_FUNZ=' + document.frmDati.txtCODE_FUNZ.value;
    sParametri= sParametri + '&txtCODE_OP_ELEM=' + document.frmDati.txtCODE_OP_ELEM.value;
  }  
  openDialog("ins_associazione.jsp" + sParametri, 600, 250);
}

  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function submitFrmSearch(typeLoad)
{
  Enable(document.frmSearch.CODE_PROF_UTENTE);
  Enable(document.frmSearch.CODE_FUNZ);
  Enable(document.frmSearch.CODE_OP_ELEM);
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.txtProfUtente.value=document.frmSearch.CODE_PROF_UTENTE.selectedIndex;  
  document.frmSearch.txtFunz.value=document.frmSearch.CODE_FUNZ.selectedIndex;    
  document.frmSearch.txtOper.value=document.frmSearch.CODE_OP_ELEM.selectedIndex;      
  document.frmSearch.CodSel.value=document.frmDati.CodSel.value;
  document.frmSearch.txtTypeLoad.value=typeLoad;
  document.frmSearch.submit();
}  
function setnumRec()
{
  document.frmSearch.numRec.options[<%=index%>].selected=true;
  document.frmSearch.CODE_PROF_UTENTE.options[<%=ind_prof_utente%>].selected=true;  
  document.frmSearch.CODE_FUNZ.options[<%=ind_funz%>].selected=true;    
  document.frmSearch.CODE_OP_ELEM.options[<%=ind_oper%>].selected=true;      
}

function ChangeSel(profilo,funzione,operazione)
{
  document.frmDati.txtCODE_PROF_UTENTE.value=profilo;
  document.frmDati.txtCODE_FUNZ.value=funzione;
  document.frmDati.txtCODE_OP_ELEM.value=operazione;
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
      document.frmDati.indice[0].click();
  }
  if(esiste==1 && !selezionato)
  {
      document.frmDati.indice.click();
  }  
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
function abilitaTasti()
{
  if(!esistonoRighe())
  {
    if(document.frmDati.ELIMINA)
    {
      Disable(document.frmDati.ELIMINA);
    }
    if(document.frmDati.STAMPA)
    {
      Disable(document.frmDati.STAMPA);
    }
   
  }
}
</SCRIPT>

<TITLE>FATTURAZIONE NON TRAFFICO</TITLE>
</HEAD>
<BODY>
  <!-- Gestione navigazione-->
<EJB:useHome id="home" type="com.ejbSTL.I5_6MEM_FUNZ_PROF_OP_ELHome" location="I5_6MEM_FUNZ_PROF_OP_EL" />  
<EJB:useBean id="associa" type="com.ejbSTL.I5_6MEM_FUNZ_PROF_OP_EL" scope="session">
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

  I5_6PROF_UTENTE_ROW[] bRemote = null;              
  I5_6ANAG_FUNZ_ROW[] cRemote = null;              
  I5_6OP_ELEM_ROW[] dRemote = null;              

  if (typeLoad!=0)
  {
    aRemote = (I5_6MEM_FUNZ_PROF_OP_EL_ROW[]) session.getAttribute("aRemote");
    bRemote = (I5_6PROF_UTENTE_ROW[]) session.getAttribute("bRemote");
    cRemote = (I5_6ANAG_FUNZ_ROW[]) session.getAttribute("cRemote");
    dRemote = (I5_6OP_ELEM_ROW[]) session.getAttribute("dRemote");
  }
  else
  {   
    appoVector = associa.findAllAssociazione(strCODE_PROF_UTENTE,strCODE_FUNZ,strCODE_OP_ELEM);
    Vector appoVector2 = associa.findAllProfili();
    bRemote = (I5_6PROF_UTENTE_ROW[])appoVector2.toArray(new I5_6PROF_UTENTE_ROW[1]);
    session.setAttribute( "bRemote", bRemote);
    Vector appoVector3 = associa.findAllFunzioni();
    cRemote = (I5_6ANAG_FUNZ_ROW[])appoVector3.toArray(new I5_6ANAG_FUNZ_ROW[1]);
    session.setAttribute( "cRemote", cRemote);
    Vector appoVector4 = associa.findAllOperazioni();
    dRemote = (I5_6OP_ELEM_ROW[])appoVector4.toArray(new I5_6OP_ELEM_ROW[1]);
    session.setAttribute( "dRemote", dRemote);
    
    if (!(appoVector==null || appoVector.size()==0)) 
    {
      aRemote = (I5_6MEM_FUNZ_PROF_OP_EL_ROW[])appoVector.toArray(new I5_6MEM_FUNZ_PROF_OP_EL_ROW[1]);
      session.setAttribute( "aRemote", aRemote);
    } 
    else
    {
      session.setAttribute("aRemote", null);
    }     
  } 


%>

<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="lista_associazioni.jsp">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/assproffunzopelem.gif" alt="" border="0"></td>
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Associazione Profilo - Funzione - Op. Elementare </td>
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
                            <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp; Filtro di Ricerca</td>
                            <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                          </tr>
                          </table>                        
                      </td>
                  </tr>             
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr>
                      <td colspan='5' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                  </table>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr>
                      <td width="20%" class="textB" align="right">Profili:&nbsp;</td>
                      <td  colspan="2" width="25%" class="text" align="left">
                          <select class="text" name="CODE_PROF_UTENTE">
                              <option></option>                                                        
                              <%  
                                int y=0;
                                for(y=0;y<bRemote.length;y++)
                                {
                                  String strAppo = bRemote[y].getCODE_PROF_UTENTE();
                                  String strDESC_PROF_UTENTE = bRemote[y].getDESC_PROF_UTENTE();                                  
                                  String selezionato="";
                                  if (y==(ind_prof_utente-1)){                       
                                      selezionato="selected";
                                      strCODE_PROF_UTENTE=strAppo;
                                  }
                              %>
                              <option  <%=selezionato%> value="<%=strAppo%>"><%=strAppo%></option>
                              <%}%>
                          </select>
                     </tr>     
                     <tr>
                     </td>
                      <td width="10%" class="textB" align="right">Funzioni:&nbsp;</td>
                      <td  colspan="2" width="25%" class="text" align="left">
                          <select class="text"name="CODE_FUNZ">
                              <option></option>                              
                              <%  
                                int z=0;
                                for(z=0;z<cRemote.length;z++)
                                {
                                  String strAppo = cRemote[z].getCODE_FUNZ();
                                  String strDESC_FUNZ = cRemote[z].getDESC_FUNZ();
                                  String selezionato="";
                                  if (z==(ind_funz-1)){                       
                                      selezionato="selected";
                                      strCODE_FUNZ=strAppo;
                                  }
                              %>
                              <option <%=selezionato%> value="<%=strAppo%>"><%=strAppo%></option>
                              <%}%>
                          </select>
                     </td>
                     </tr>
                     <tr>
                      <td width="10%" class="textB" align="right">Operazioni:&nbsp;</td>
                      <td  width="25%" class="text">
                          <select class="text"name="CODE_OP_ELEM">
                              <option></option>                              
                              <%  
                                int w=0;
                                for(w=0;w<dRemote.length;w++)
                                {
                                  String strAppo = dRemote[w].getCODE_OP_ELEM();
                                  String strDESC_OP_ELEM = dRemote[w].getDESC_OP_ELEM();                                  
                                  String selezionato="";
                                  if (w==(ind_oper-1)){                       
                                      selezionato="selected";
                                      strCODE_OP_ELEM=strAppo;
                                  }
                              %>
                              <option <%=selezionato%> value="<%=strAppo%>"><%=strDESC_OP_ELEM%></option>
                              <%}%>
                          </select>
                     </td>
                      <td width="10%" rowspan='2' class="textB" valign="right" align="center">
                        <input class="textB" type="button" name="Esegui" value="Popola" onclick="submitFrmSearch('0');">                    
                        <input type="hidden" name="CodSel" value="<%=strCODE_PROF_UTENTE%>">                     
                        <input type="hidden" name="txtTypeLoad" value="">
                        <input type="hidden" name="txtnumRec" value="">
                        <input type="hidden" name="txtProfUtente" value="">
                        <input type="hidden" name="txtFunz" value="">                        
                        <input type="hidden" name="txtOper" value="">                                                
                        <input class="textB" type="hidden" name="txtnumPag" value="1">                        
                      </td>
                     </tr>
                     <tr>
                      <td width="10%" class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <select class="text" name="numRec" onchange="submitFrmSearch('1');">
                          <option class="text" value=5>5</option>
                          <option class="text" value=10>10</option>
                          <option class="text" value=20>20</option>
                          <option class="text" value=50>50</option>
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
<form name="frmDati" method="post" action='del_associazione.jsp'>
<input type="hidden" name="txtCODE_PROF_UTENTE">
<input type="hidden" name="txtCODE_FUNZ">
<input type="hidden" name="txtCODE_OP_ELEM">
        <tr>
          <td>
            <table border="0" width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Lista Associazioni</td>
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
                          <td bgcolor='white' width="0%" >&nbsp;</td>      
                          <td bgcolor='#D5DDF1' class="textB" width="30%">Profili</td>
                          <td bgcolor='#D5DDF1' class="textB" width="40%">Funzioni</td>
                          <td bgcolor='#D5DDF1' class="textB" width="30%">Operazioni Elementari</td>
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote.length%>">
<pg:param name="txtTypeLoad" value="1"></pg:param>
<pg:param name="CodSel" value="<%=CodSel%>"></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="txtProfUtente" value="<%=ind_prof_utente%>"></pg:param>
<pg:param name="txtFunz" value="<%=ind_funz%>"></pg:param>
<pg:param name="txtOper" value="<%=ind_oper%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>  

<%

      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote.length) && (j<pagerPageNumber.intValue()*records_per_page));j++)
      {
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";
         CODE_PROF_UTENTE = aRemote[j].getCODE_PROF_UTENTE();   
         CODE_FUNZ = aRemote[j].getCODE_FUNZ();
         CODE_OP_ELEM = aRemote[j].getCODE_OP_ELEM();
         DESC_OP_ELEM = aRemote[j].getDESC_OP_ELEM();
         if (CodSel!=null)
         {
             if (CodSel.equals(Integer.toString(j)))
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
                              <input type="radio" name="indice" <%=sChecked%> value="<%=j%>" onClick="ChangeSel('<%= CODE_PROF_UTENTE %>','<%= CODE_FUNZ %>','<%= CODE_OP_ELEM %>')" >
                           </td>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= CODE_PROF_UTENTE %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= CODE_FUNZ %></TD>            
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= DESC_OP_ELEM %></TD>                                 
                        </tr>
                        <tr>
                          <td colspan='4' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                        </tr>

<%
          i+=1;
        }
%>

                        <tr>
                          <td colspan='4' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="3" height='2'></td>
                        </tr>
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


                        </table>
                      </td>
                    </tr>        
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
<SCRIPT LANGUAGE="JavaScript">
    setnumRec();
    selezionaPrimo();
    abilitaTasti();
    
</SCRIPT>
</BODY>
</HTML>
