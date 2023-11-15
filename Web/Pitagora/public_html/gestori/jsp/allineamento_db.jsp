<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.utl.*,com.usr.*,java.util.Vector" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth />
<%
clsInfoUser InfoUser = (clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
%>
<logtag:logData id="<%= InfoUser.getUserName() %>">
<%=StaticMessages.getMessage(3006,"allineamento_db.jsp")%>
</logtag:logData>

<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  String bgcolor="";
  int i=0;
  int j=0;
  final String COD_STATO_BATCH_DUMP="DUMP";
  final String COD_STATO_BATCH_SUCC="SUCC";
  final String COD_STATO_BATCH_RUN="RUNN";  
  final String COD_STATO_BATCH_INIT="INIT";   
  //Variabili per la visualizzazione della Lista 'Elenco Tabelle'
  String DETT_CODE_TEST_ALL=null;
  String CODE_DETT_ALL=null;
  String NOME_TABELLA_BILL=null;
  String TIPO_FLAG_REFRESH=null;

  //Variabili per la valorizzazione della combo
  String CODE_TEST_ALL = null;
  String sChecked = "";
  java.util.Vector appoVector=null;

  // Variabile per la memorizzazione delle informazioni dalla variabile collection
  I5_6DETT_ALL_DB_ROW[] aRemote = null;

  //Il campo contiene l'elemento selezionato dall'utente
  String CodSel=request.getParameter("CodSel");

  // Codice Testata
  String strCODE_TEST_ALL = request.getParameter("CODE_TEST_ALL");

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
// Lettura dell'Indice per la combo di Testata 
  int ind_test_all=0;
  String strInd_test_all = request.getParameter("txtCodeTestata");
  if (strInd_test_all!=null)
  {
    if(!strInd_test_all.equals(""))
    {
      Integer tmpind_test_all=new Integer(strInd_test_all);
      ind_test_all=tmpind_test_all.intValue();
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
<META HTTP-EQUIV="Refresh" CONTENT="300">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">

function ONLANCIOBATCH()
{
  if (confirm('Si conferma il lancio del batch?')==true)
  {
    var sParametri='';
    sParametri= '?txtnumRec=<%=index%>';
    sParametri= sParametri + '&txtCodeTestata=<%=ind_test_all%>';
    sParametri= sParametri + '&numRec=<%=records_per_page%>';
    sParametri= sParametri + '&txtTypeLoad=0'; 
    sParametri= sParametri + '&CodSel=' + document.frmDati.CodSel.value;
    sParametri= sParametri + '&strUrl=lancio_batch_allineamento.jsp';
    sParametri= sParametri + '&strMessaggio=<%=response.encodeURL("Lancio batch allineamento db")%>';
    window.location.href="flag_lancio.jsp"+sParametri;
  }
}
function ONREFRESH()
{
  var sParametri='';
  sParametri= '?txtnumRec=<%=index%>';
  sParametri= sParametri + '&txtCodeTestata=<%=ind_test_all%>';
  sParametri= sParametri + '&numRec=<%=records_per_page%>';
  sParametri= sParametri + '&txtTypeLoad=0'; 
  sParametri= sParametri + '&CodSel=' + document.frmDati.CodSel.value;
  //document.frmDati.LANCIOBATCH ? Enable(document.frmDati.LANCIOBATCH) : null;  
  window.location.href="allineamento_db.jsp"+sParametri;
}
function ONVISUALIZZA()
{
    sParametri= '?indiceErrore=' + document.frmDati.indiceErrore.value;
    openDialog("visualizza_errore.jsp" + sParametri, 550, 400, "", "");
}
  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function submitFrmSearch(typeLoad)
{
  Enable(document.frmSearch.CODE_TEST_ALL);
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.txtCodeTestata.value=document.frmSearch.CODE_TEST_ALL.selectedIndex;  
  document.frmSearch.CodSel.value=document.frmDati.CodSel.value;
  document.frmSearch.txtTypeLoad.value=typeLoad;
  document.frmSearch.submit();
}  
function setnumRec()
{
  document.frmSearch.numRec.options[<%=index%>].selected=true;
  document.frmSearch.CODE_TEST_ALL.options.length>0 ?document.frmSearch.CODE_TEST_ALL.options[<%=ind_test_all%>].selected=true:null;  
}

function ChangeSel(codice)
{
  document.frmDati.txtCODE_TEST_ALL.value=codice;
}

function deleteData(objs)
{
  obj = eval("document." + objs);
  obj.value="";
}

function impostaErrore(errore)
{
  document.frmDati.indiceErrore.value=errore;
  if(errore.length>0)
  {
    document.frmDati.VISUALIZZA ? Enable(document.frmDati.VISUALIZZA):null
  }
  else
  {
    document.frmDati.VISUALIZZA ? Disable(document.frmDati.VISUALIZZA):null
  }
  

}

function impostaStato()
{
  var nuovi = document.frmSearch.NUOVI_GESTORI.value * 1;
  if(document.frmSearch.STATO_ELAB.value=='<%=COD_STATO_BATCH_RUN%>' 
    || document.frmSearch.STATO_ELAB.value=='<%=COD_STATO_BATCH_INIT%>' 
    || nuovi > 0
    || <%= ! InfoUser.getAdminIndicator().equals(StaticContext.ADMIN_INDICATOR)%> )
  {
    document.frmDati.LANCIOBATCH ? Disable(document.frmDati.LANCIOBATCH) : null;
  }

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
      document.frmDati.rdErrore[0].click();
  }
  if(esiste==1 && !selezionato)
  {
      document.frmDati.rdErrore.click();  
  }  
  if(esiste==0)
    Disable(document.frmDati.VISUALIZZA);
}
</SCRIPT>

<TITLE>FATTURAZIONE NON TRAFFICO</TITLE>
</HEAD>
<BODY onload="">
  <!-- Gestione navigazione-->
<EJB:useHome id="home" type="com.ejbSTL.I5_6DETT_ALL_DBejbHome" location="I5_6DETT_ALL_DBejb" />  
<EJB:useBean id="allinea" type="com.ejbSTL.I5_6DETT_ALL_DBejb" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>



<EJB:useHome id="home2" type="com.ejbSTL.I5_3GEST_TLCejbHome" location="I5_3GEST_TLCejb" />  
<EJB:useBean id="tlc" type="com.ejbSTL.I5_3GEST_TLCejb" scope="session">
  <EJB:createBean instance="<%=home2.create()%>" />
</EJB:useBean>

<%
//Carico le intestazioni del combo

  I5_6TEST_ALL_DB_ROW[] bRemote = null;              
  int y=0;
  Vector appoVector2 = allinea.findAllTestata();
  if (!(appoVector2==null || appoVector2.size()==0))  {
    bRemote = (I5_6TEST_ALL_DB_ROW[])appoVector2.toArray(new I5_6TEST_ALL_DB_ROW[1]);
    if (strCODE_TEST_ALL==null){
      strCODE_TEST_ALL=bRemote[0].getCODE_TEST_ALL();
    }
  }else{    
    strCODE_TEST_ALL="";
  }
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
    aRemote = (I5_6DETT_ALL_DB_ROW[]) session.getAttribute("aRemote");
  }
  else
  {   
    appoVector = allinea.findAllDettaglio(strCODE_TEST_ALL);
    if (!(appoVector==null || appoVector.size()==0)) 
    {
      aRemote = (I5_6DETT_ALL_DB_ROW[])appoVector.toArray(new I5_6DETT_ALL_DB_ROW[1]);
      session.setAttribute( "aRemote", aRemote);
    }  
    else
    {
      session.setAttribute("aRemote", null);
    } 
  } 
  // verifico se ci sono nuovi gestori da allineare
  Vector nuoviVector = tlc.findAllNuovi();
  
%>

<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="allineamento_db.jsp">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/allineamentodb.gif" alt="" border="0"></td>
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Allineamento DB</td>
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
              <td >
                <table width="100%" border="0" bgcolor="#0A6B98" cellpadding="0" align="center">
                <tr>
                    <td >

                  <table width="100%" border="0" cellspacing="0" bgcolor="#CFDBE9" align="center">
                          <%  
                                 I5_6TEST_ALL_DB_ROW riga = allinea.loadLastRunning();
                                 String appoDATA_ELAB  = "";                                  
                                 String appoDESC_STATO_ELAB ="";
                                 String appoSTATO_ELAB ="";                                                                                                     
                                 if (riga!=null)
                                 {
                                     appoDATA_ELAB  = riga.getDATA_ELAB();                                  
                                     appoDESC_STATO_ELAB = riga.getDESC_STATO_ELAB();                                                                    
                                 }
                                 clsApplication objApplication = (clsApplication)    application.getAttribute(StaticContext.ACTION_INDICATOR);   ;
                                 if (objApplication ==null){
                                   appoSTATO_ELAB=COD_STATO_BATCH_SUCC;
                                 }else{                                   
                                   riga = allinea.loadTesto(objApplication.getDataLancioAllineamntoDB());
                                   if (riga!=null)
                                   {
                                       appoSTATO_ELAB = riga.getSTATO_ELAB();                                                                                                         
                                        // Se l'elaborazione é andato a buon fine elimino la sessione
                                       /*if (appoSTATO_ELAB.equals(COD_STATO_BATCH_SUCC)){
                                        application.removeAttribute(StaticContext.ACTION_INDICATOR);
                                        
                                       }*/ 
                                   }else{
                                        //Il ribes non ha ancora scritto setto lo stato ad init
                                      appoSTATO_ELAB = COD_STATO_BATCH_INIT;              
                                   }
                                }
                          %>
                      <TD bgcolor="#CFDBE9" align="center" class='textB'>Ultimo Aggiornamento DB:</TD>
                      <TD bgcolor="#CFDBE9" class='textB'><%= appoDATA_ELAB %>
                      <input type="hidden" name="STATO_ELAB" value="<%=appoSTATO_ELAB%>">
                      <input type="hidden" name="NUOVI_GESTORI" value="<%=nuoviVector.size()%>">
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


            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98" > <!--bgcolor="#0A6B98"-->
              <!--<tr bgcolor="#CFDBE9"-->
              <tr>
                <td>               
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr>
                      <td width="20%" class="textB" align="right">Elaborazioni Batch:&nbsp;</td>
                      <td  width="25%" class="text" align="left">
                          <select class="text" name="CODE_TEST_ALL" onChange="submitFrmSearch('0');">
                              <%  
                                if (!(appoVector2==null || appoVector2.size()==0))
                                {
                                for(y=0;y<bRemote.length;y++)
                                {
                                  String strAppo = bRemote[y].getCODE_TEST_ALL();
                                  String strDATA_ELAB = bRemote[y].getDATA_ELAB();                                  
                                  String strSTATO_ELAB = bRemote[y].getSTATO_ELAB();                                                                    
                                  String selezionato="";
                                  if(CODE_TEST_ALL!=null)
                                  {
                                    if(CODE_TEST_ALL.equals(strAppo))
                                      selezionato="selected";
                                  }
                              %>
                              <option  <%=selezionato%> value="<%=strAppo%>"><%=strAppo%>-<%=strDATA_ELAB%>-<%=strSTATO_ELAB%></option>
                              <%}}%>
                          </select>
                            <input type="hidden" name="CodSel" value="<%=strCODE_TEST_ALL%>">
                            <input type="hidden" name="txtTypeLoad" value="">
                            <input type="hidden" name="txtnumRec" value="">
                            <input type="hidden" name="txtCodeTestata" value="">
                            <input class="textB" type="hidden" name="txtnumPag" value="1">                            
                        </td>
                     </tr>     
                     <tr>
                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text" align="left">
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
<form name="frmDati" method="post" action='allineamento_db.jsp'>
<input type="hidden" name="txtCODE_TEST_ALL">
<input type="hidden" name="indiceErrore">
        <tr>
          <td>
            <table border="0" width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Elenco Tabelle</td>
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
                          <td bgcolor='white' width="0%">&nbsp;</td>
                          <td bgcolor='#D5DDF1' class="textB" width="70%">Tabella</td>
                          <td bgcolor='#D5DDF1' class="textB" width="30%">Stato</td>
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote.length%>">
<pg:param name="typeLoad" value="1"></pg:param>
<pg:param name="CodSel" value="<%=strCODE_TEST_ALL%>"></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
<pg:param name="txtCodeTestata" value="<%=ind_test_all%>"></pg:param>

<%

      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote.length) && (j<pagerPageNumber.intValue()*records_per_page));j++)
      {
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";
         DETT_CODE_TEST_ALL = aRemote[j].getCODE_TEST_ALL();   
         CODE_DETT_ALL = aRemote[j].getCODE_DETT_ALL();   
         NOME_TABELLA_BILL = aRemote[j].getNOME_TABELLA_BILL();
         TIPO_FLAG_REFRESH = aRemote[j].getTIPO_FLAG_REFRESH();
         String TEXT_MSG_ERR = aRemote[j].getTEXT_MSG_ERR();

%>

                        <TR>
                           <TD bgcolor='white'>
                              <input type="radio" name="rdErrore" value="<%=j%>" onclick="impostaErrore('<%if(TEXT_MSG_ERR!=null){out.print(j);}%>')">
                           </TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%=NOME_TABELLA_BILL%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%=TIPO_FLAG_REFRESH %></TD>            
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
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF">
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <td class="textB" bgcolor="#D5DDF1" align="center" colspan="5">
          <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
	        </td>
            <input type="hidden" name="CodSel" value="<%= strCODE_TEST_ALL %>" >          
	      </tr>
	    </table>
    </td>
  </tr>
  </tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>  
  <tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <td class="textB" bgcolor="#D5DDF1" align="center" colspan="5">
            La pagina si aggiornerà automaticamente dopo 5 minuti
	        </td>
	      </tr>
	    </table>
    </td>
  </tr>  
</table>
</form>
<SCRIPT LANGUAGE="JavaScript">
  impostaStato();
  setnumRec();
  selezionaPrimo();
</SCRIPT>
</BODY>
</HTML>
