<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*" %>
<sec:ChkUserAuth />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"lista_utenti.jsp")%>
</logtag:logData>

<%
  String userNameLogin = ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName();
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  I5_6anag_utenteROW[] aRemote = null;
  
  String bgcolor="";
  int i=0;
  int j=0;

  String sChecked = "";
  String msg = Misc.nh(request.getParameter("msg"));
  
  java.util.Collection appoVector=null;
    // Variabile per la memorizzazione delle informazioni dalla variabile collection
  
  String strRicerca = request.getParameter("txtRicerca");
  String strUserPwd = request.getParameter("tipoUser");

  if (strUserPwd==null)
    strUserPwd = "0";
    
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
  if (strIndex!=null && !strIndex.equals("null"))
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


function ONSTAMPA()
{
  openDialog("stampa_utenti.jsp", 800, 500, " ,scrollbars=1, resizable=1, toolbar=0, status=0, menubar=1");
}
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

function ONRIABILITA()
{
  esegui(3);
}

function ONDISCONNETTI()
{
    var sParametri= '?txtnumRec=<%=index%>';
    sParametri= sParametri + '&numRec=<%=records_per_page%>';
    sParametri= sParametri + '&pager.offset=<%=strPagerOffset%>';
    sParametri= sParametri + '&txtTypeLoad=1'; 
    sParametri= sParametri + '&txtRicerca=<%=strRicerca%>';
    sParametri= sParametri + '&CodSel=' + document.frmDati.CodSel.value;
    if (confirm('Si conferma la diconnessione dell\'utente selezionato?')==true)
    {
       document.frmDati.method="POST";
       document.frmDati.action="disconnetti_utente.jsp" + sParametri;
       document.frmDati.submit();
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
    if(document.frmDati.AGGIORNA)
    {
      Disable(document.frmDati.AGGIORNA);
    }
    if(document.frmDati.STAMPA)
    {
      Disable(document.frmDati.STAMPA);
    }
    if(document.frmDati.DISATTIVA)
    {
      Disable(document.frmDati.DISATTIVA);
    }
    if(document.frmDati.DISCONNETTI)
    {
      Disable(document.frmDati.DISCONNETTI);
    }
    if(document.frmDati.RIABILITA)
    {
      Disable(document.frmDati.RIABILITA);
    }  
  }
}

function esegui(operazione)
{
/* operazione vale:
    0 per l'inserimento
    1 per l'aggiornamento
    2 per la cancellazione
    3 per la riabilitazione
*/    
    if(controllaUserNameLogin(document.frmSearch.userNameLogin.value,document.frmDati.CodSel.value,operazione)){
      var sParametri= '?txtnumRec=<%=index%>';
      sParametri= sParametri + '&numRec=<%=records_per_page%>';
      sParametri= sParametri + '&pager.offset=<%=strPagerOffset%>';
      sParametri= sParametri + '&txtTypeLoad=1'; 
      sParametri= sParametri + '&operazione=' + operazione;
      sParametri= sParametri + '&txtRicerca=<%=strRicerca%>';
      sParametri= sParametri + '&tipoUser=<%=strUserPwd%>';      
      sParametri= sParametri + '&CodSel=' + document.frmDati.CodSel.value;
      openDialog("agg_utente.jsp" + sParametri, 800, 450, "", "");
    }else{
      alert("Impossibile cancellare il proprio utente.");
    }
}

function controllaUserNameLogin(usernameLogin,userNameSelected,operazione){
    if(operazione != 2 || operazione != 3)
       return true;
    if (usernameLogin == userNameSelected)
       return false;
    else
       return true;
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

function setTipoUser(tipoUser){
  if (tipoUser == '0'){
    document.frmSearch.txtRadio0.checked = true;
    document.frmSearch.txtRadio1.checked = false;
    document.frmSearch.tipoUser.value = "0";
  }else{
    document.frmSearch.txtRadio1.checked = true;
    document.frmSearch.txtRadio0.checked = false;
    document.frmSearch.tipoUser.value = "1";
  }
  submitFrmSearch('0');
}

function setTipoUserStart(){
  document.frmSearch.txtRadio0.checked = true;
  document.frmSearch.txtRadio1.checked = false;
  document.frmSearch.tipoUser.value = "0";
}

function setCheckBox(){
  if(esistonoRighe()){
    if(document.frmSearch.tipoUser.value == '0'){
      document.frmSearch.txtRadio0.checked = true;
      document.frmSearch.txtRadio1.checked = false;
      Enable ( frmDati.NUOVO );
      Enable ( frmDati.AGGIORNA );
      Enable ( frmDati.STAMPA );
      Enable ( frmDati.CANCELLA );
      Disable ( frmDati.RIABILITA );
    }else{
      document.frmSearch.txtRadio0.checked = false;
      document.frmSearch.txtRadio1.checked = true;
      document.frmDati.NUOVO.dasable = true;    
      Disable ( frmDati.NUOVO );
      Disable ( frmDati.AGGIORNA );
      Enable ( frmDati.STAMPA );
      Disable ( frmDati.CANCELLA );
      Enable ( frmDati.RIABILITA );
    }
  }else{
    Disable ( frmDati.AGGIORNA );
    Disable ( frmDati.STAMPA );
    Disable ( frmDati.CANCELLA );
    Disable ( frmDati.RIABILITA );
    if(document.frmSearch.tipoUser.value == '0'){
      document.frmSearch.txtRadio0.checked = true;
      document.frmSearch.txtRadio1.checked = false;
      Enable ( frmDati.NUOVO );
    }else{
      document.frmSearch.txtRadio0.checked = false;
      document.frmSearch.txtRadio1.checked = true;
      Disable ( frmDati.NUOVO );
    }
    
  }
}


</SCRIPT>

<TITLE>Gestione Utenti</TITLE>
</HEAD>
<BODY onload="">
  <!-- Gestione navigazione-->
<EJB:useHome id="home" type="com.ejbSTL.I5_6ANAG_UTENTEejbHome" location="I5_6ANAG_UTENTEejb" />
<EJB:useBean id="utenti" type="com.ejbSTL.I5_6ANAG_UTENTEejb" scope="session">
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
    aRemote = (I5_6anag_utenteROW[]) session.getAttribute("aRemote");
  }
  else
  {   
    if ((CodSel != null && CodSel != "") && (strRicerca == null || strRicerca == "") )
      appoVector = utenti.find(CodSel,strUserPwd);
    else
      appoVector = utenti.find(strRicerca,strUserPwd);
      
    if (!(appoVector==null || appoVector.size()==0)) 
    {
      aRemote = (I5_6anag_utenteROW[])appoVector.toArray(new I5_6anag_utenteROW[1]);
      session.setAttribute( "aRemote", aRemote);
    }
    else
    {
      session.setAttribute("aRemote", null);
    }   
  } 


%>

<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="lista_utenti.jsp">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/gestutenti.gif" alt="" border="0"></td>
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Gestione Anagrafica Utenti</td>
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
                    <tr>
                      <td width="20%" class="textB" align="right">Codice Utente:</td>
                      <td  width="25%" class="text">
                        <input class="text" type='text' name='txtRicerca'  size='11' <%if (strRicerca==null){%>><%}else{%>value='<%=strRicerca%>' ><%}%>
                      </td>                    
                      <td width="10%" rowspan='2' class="textB" valign="right" align="right">
                        <input class="textB" type="button" name="Esegui" value="Popola" onclick="submitFrmSearch('0');">                    
                        <input type="hidden" name="CodSel" value="">                     
                        <input type="hidden" name="txtTypeLoad" value="">
                        <input type="hidden" name="txtnumRec" value="">
                        <input type="hidden" name="userNameLogin" value="<%=userNameLogin%>">
                        <input type="hidden" name="tipoUser" value="<%=strUserPwd%>">
                      </td>
                      <td>&nbsp;</td>
           					  <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td class="textB" align="right">Utenti Abilitati:</td>
                      <td  width="10%" class="text">
                        <input type='radio' name='txtRadio0' value='0' onclick='setTipoUser(this.value);'>
                      </td>
                    </tr>
                    <tr>
                      <td class="textB" align="right">Utenti Disabilitati:</td>
                      <td  width="10%" class="text">
                        <input type='radio' name='txtRadio1' value='1' onclick='setTipoUser(this.value);'>
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
          <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
</form>
  <!-- Gestione navigazione-->
<form name="frmDati" method="post" action='lista_utenti.jsp'>
        <tr>
          <td>
            <table border="0" width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Lista Utenti</td>
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
                          <td bgcolor='#D5DDF1' class="textB" width="20%" >Utente</td>
                          <td bgcolor='#D5DDF1' class="textB" width="10%" >Profilo</td>
                          <td bgcolor='#D5DDF1' class="textB" width="20%" >Nome</td>
                          <td bgcolor='#D5DDF1' class="textB" width="15%" >Inizio<br>Validità<br>Utente</td>
                          <td bgcolor='#D5DDF1' class="textB" width="15%" >Fine<br>Validità<br>Utente</td>
                          <td bgcolor='#D5DDF1' class="textB" width="15%" >Ultimo<br>Accesso<br>Utente</td>
                       </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote.length%>">
<pg:param name="txtTypeLoad" value="1"></pg:param>
<pg:param name="CodSel" value="<%=CodSel%>"></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="txtRicerca" value="<%=strRicerca%>"></pg:param>
<pg:param name="tipoUser" value="<%=strUserPwd%>"></pg:param>


<!--<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>-->

<%

  String            CODE_UTENTE      =null;
  String            CODE_PROF_UTENTE =null;
  String            NOME_COGN_UTENTE =null;
  String            DATE_END         =null;
  String            FLAG_ADMIN_IND   =null;
  String            DATA_LOGIN       = null;
  String            DATA_START       = null;

  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote.length) && (j<pagerPageNumber.intValue()*records_per_page));j++)
      {
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";

        CODE_UTENTE      = aRemote[j].getCode_utente();
        CODE_PROF_UTENTE = aRemote[j].getCode_prof_utente();
        NOME_COGN_UTENTE = aRemote[j].getNome_cogn_utente();
        DATE_END         = aRemote[j].getData_end_char();
        DATA_LOGIN       = aRemote[j].getData_login();
        DATA_START       = aRemote[j].getData_start_char();
        FLAG_ADMIN_IND   = aRemote[j].getFlag_admin_ind();

        if(DATA_START == null){
            DATA_START = "";
        }

        if(DATE_END == null){
            DATE_END = "";
        }

        if(DATA_LOGIN == null){
            DATA_LOGIN = "";
        }

         if (CodSel!=null)
         {
             if (CodSel.equals(CODE_UTENTE))
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
                              <input type="radio" name="indice" <%=sChecked%> value="<%=CODE_UTENTE%>" onClick="ChangeSel('<%=CODE_UTENTE%>','0')" >
                           </td>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%=CODE_UTENTE%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%=CODE_PROF_UTENTE%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%=NOME_COGN_UTENTE%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%=DATA_START%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%=DATE_END%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%=DATA_LOGIN%></TD>
                        </tr>
                        <tr>
                          <td colspan='7' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                        </tr>

<%
          i+=1;
        }
%>

                        <tr>
                          <td colspan='7' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="3" height='2'></td>
                        </tr>
<pg:index>
                        <tr>
                          <td bgcolor="#FFFFFF" colspan="7" class="text" align="center">
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
            <input type="hidden" name="CodSel" value="<%= CodSel %>" >     
	      </tr>
<sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />            
	    </table>
    </td>
  </tr>
</table>
</form>

<SCRIPT LANGUAGE="JavaScript">
    setnumRec();
    selezionaPrimo();
    abilitaTasti();
    if("<%=msg%>" != "OK" && "<%=msg%>" != "")
      alert('<%=msg%>');
    if("<%=strUserPwd%>" == "")
      setTipoUserStart();
    setCheckBox();
</SCRIPT>

</BODY>
</HTML>
