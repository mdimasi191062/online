<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*"%>
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>

<sec:ChkUserAuth RedirectEnabled="true" VectorName="vectorButton" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"gest_scarti.jsp")%>
</logtag:logData>
<EJB:useHome id="home1" type="com.ejbSTL.GestioneScartiPopolamentoHome" location="GestioneScartiPopolamento" />  
<EJB:useBean id="gestscar" type="com.ejbSTL.GestioneScartiPopolamento" scope="session">
  <EJB:createBean instance="<%=home1.create()%>" />
</EJB:useBean>

<%
//Parametri Ricerca
String ricServizi = Misc.nh(request.getParameter("comboServizi"));
String ricOlo = Misc.nh(request.getParameter("comboOlo"));
String ricScarto = Misc.nh(request.getParameter("comboTipoScarto"));
String ricDataDa = Misc.nh(request.getParameter("txtDataIni"));
String ricDataA = Misc.nh(request.getParameter("txtDataFin"));
String ricRiciclo = Misc.nh(request.getParameter("isRepricing"));
String updateDati = Misc.nh(request.getParameter("AGGIORNA"));
String statoVisibile = Misc.nh(request.getParameter("Visibile"));

//gestione visibile cambia ciclo

if (ricServizi.equals("") && ricOlo.equals("") && ricScarto.equals(""))
{
  if (ricDataDa.equals("") && ricDataDa.equals(""))
    {
     if (statoVisibile.equals("1"))
      {
         out.println("<script type=\"text/javascript\">alert('Selezionare almeno un filtro');</script>");
      }
    statoVisibile = "0";
    }
//    out.println("0 statoVisibileCiclo"+ statoVisibileCiclo);
}
else
{
    statoVisibile = "1";
//    out.println("1 statoVisibileCiclo"+ statoVisibileCiclo + " - ricServizi : " + ricServizi + " - ricOlo : " + ricOlo + " - ricScarto : " + ricScarto);
}

// Lettura del Numero di record per pagina (default 15)
int records_per_page=15;

String strNumRec=null;
strNumRec = request.getParameter("numRec");

if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }

String cod_tipo_contr="";
String des_tipo_contr="";
String checkvalue="";
int index=0;


if (updateDati.equals("S")) {
    boolean ret = gestscar.riproponiScarti(ricServizi,ricScarto,ricOlo,ricDataDa,ricDataA,ricRiciclo);
     statoVisibile = "0";   
}

Vector olo = gestscar.getOlo();
Vector cuaScarti = gestscar.getCausaleScarto();
Vector serviz = gestscar.getServizi();
Vector scarti = gestscar.getScarti(ricServizi,ricScarto,ricOlo,ricDataDa,ricDataA);
%>
<SCRIPT LANGUAGE="JavaScript" SRC="../../elab_attive/js/ElabAttive.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>

var flgCambioParametri = false;

function fntCambioParametri() {
    flgCambioParametri = true;
}

function inizializza(){
  orologio.style.visibility='hidden';
  orologio.style.display='none';
  
  document.formPag.comboServizi.value='<%=ricServizi%>';
  document.formPag.comboOlo.value='<%=ricOlo%>';
  document.formPag.comboTipoScarto.value='<%=ricScarto%>';
  document.formPag.txtDataIni.value='<%=ricDataDa%>';
  document.formPag.txtDataFin.value='<%=ricDataA%>';
  document.formPag.isRepricing.value='<%=ricRiciclo%>';
  <%
    if ( ricRiciclo.equals("S") ) { %>
  document.formPag.isRepricing.checked=true;
  <% 
    } else {
  %>
  document.formPag.isRepricing.checked=false;
  <%
    }
  %>
  document.formPag.AGGIORNA.value='N';
}


  function onRepricing()
  {
   var repricing=document.formPag.isRepricing.checked;
    if(repricing==true)
    {
      document.formPag.isRepricing.value='S';
    }
    else
    {
      document.formPag.isRepricing.value='N';
    }

  }


function onRicercaList(){
  flgCambioParametri = false;
  orologio.style.display='inline';
  maschera.style.display='none';

  document.formPag.submit();
}


function ONCAMBIA_CICLO()
{ 

  var domanda="al prossimo ciclo";

  if ( flgCambioParametri == false ) {
  
      if ( document.formPag.isRepricing.value == "S" ) {
        domanda="all'attuale ciclo";
      }
      
      if (confirm("Sei sicuro di riciclare gli scarti attualmente selezionati " + domanda + " di fatturazione ?")==true)
      {
           
          document.formPag.AGGIORNA.value='S';
          orologio.style.display='inline';
          maschera.style.display='none';
        
          document.formPag.submit();
    
      }
    } else {
        alert("Devi effettuare prima la ricerca con il bottone 'Ricerca'");
    }
}



</SCRIPT>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<title></title>
 <script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
</head>
<body onload="inizializza();">
<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div name="orologio" id="orologio">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div name="maschera" id="maschera" style="visibility:display;display:inline">
<form name="formPag" method="post" action="gest_scarti.jsp">
 <table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloPagina.gif" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
        <tr>
        <td>
          <table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"></td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif"></td>
              </tr>
          </table>
        </td>
      </tr>
      </table>
      <br>
      <table width=90% border="0" cellspacing="0" cellpadding="4" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
<tr>
<td width="5%"></td>
<td width="90%" align="center">
      <table width="90%" border="0" cellspacing="0" cellpadding="4" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr HEIGHT='35px'>
            <td class="textB" width="20%" align="right">Codice Servizio </td>
            <td class="text" width="25%">
                            <select name="comboServizi" width="10px" class="text" onchange="fntCambioParametri();">
                    <option value="" Selected>Selezionare il Servizio</option>
                    <%
                        Object[] objsServizi=serviz.toArray();
                        for (int i=0;i<serviz.size();i++) {
                            DB_TipiContratto objServizio=(DB_TipiContratto)objsServizi[i];
                    %>
                        <option value="<%=objServizio.getCODE_TIPO_CONTR()%>"><%=objServizio.getCODE_TIPO_CONTR()%> - <%=objServizio.getDESC_TIPO_CONTR()%></option>
                    <%
                        }
                    %>
                </select>
            </td>
            <td class="textB" width="50%" align="right" colspan="2">
                <table width="100%" border="0" cellspacing="0" >
                <td class="textB" width="17%" >OLO </td>
                <td class="text" width="83%"> 
            
                <select name="comboOlo" width="10px" class="text" onchange="fntCambioParametri();">
                    <option value="" Selected>Selezionare l'OLO</option>
                    <%
                        Object[] objsOlo=olo.toArray();
                        for (int i=0;i<olo.size();i++) {
                            I5_1CONTR objOlo=(I5_1CONTR)objsOlo[i];
                    %>
                        <option value="<%=objOlo.getCODE_CONTR()%>"><%=objOlo.getCODE_CONTR()%> - <%=objOlo.getCODE_GEST()%> (<%=objOlo.getDESC_CONTR()%>)</option>
                    <%
                        }
                    %>
                </select>
                </td>
 
                </table>
               
        </tr>
        <tr HEIGHT='15px'>
            <td class="textB"></td>
            <td class="text"></td>
            <td class="textB"></td>
            <td class="text"></td>
        </tr>
        <tr height="50px">
            <td class="textB" align="right">Causale Scarto</td>
            <td class="text">
                <select name="comboTipoScarto" width="10px" class="text" onchange="fntCambioParametri();">
                    <option value="" Selected>Selezionare Causale Scarto</option>
                    <%
                        Object[] objsScarti=cuaScarti.toArray();
                        for (int i=0;i<cuaScarti.size();i++) {
                            I5_5ANAG_SCARTI objScarto=(I5_5ANAG_SCARTI)objsScarti[i];
                    %>
                        <option value="<%=objScarto.getCODE_DETT_SCARTO()%>"><%=objScarto.getCODE_DETT_SCARTO()%> - <%=objScarto.getDESC_SCARTO()%></option>
                    <%
                        }
                    %>
                </select>
            </td>
            <td class="textB" align="right">
                <table width="100%">
                <td class="textB">Data Da</td>
                <td>
                               <div name="divDataIni" id="divDataIni" class="textB">
                <input type="text" class="text" id="txtDataIni" name="txtDataIni" readonly obbligatorio="si" tipocontrollo="data" label="Data inizio" value="" size="10" Update="false">
                  <a name="calDIV" id="calDIV "href="javascript:fntCambioParametri();showCalendar('formPag.txtDataIni','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendar" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
                  <a name="cancDIV" id="cancDIV" href="javascript:fntCambioParametri();clearField(formPag.txtDataIni);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancel" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
                  <input type="hidden" id="txtDataIniOld">
                </div>
                </td>
                </table>
 
            </td>
            <td class="textB">
                 <table width="100%">
                <td class="textB">a</td>
                <td>          
               <div name="divDataFin" id="divDataFin" class="textB">
                 <INPUT class="text" id="txtDataFin" name="txtDataFin" readonly  tipocontrollo="data" label="Data Fine" value="" size="10" Update="false" >
                  <a  name="calDFV" id="calDFV" href="javascript:fntCambioParametri();showCalendar('formPag.txtDataFin','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendar" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
                  <a name="cancDFV" id="cancDFV"  href="javascript:fntCambioParametri();clearField(formPag.txtDataFin);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancel" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
                  <input type="hidden" id="txtDataFinOld">
                  </div>
                </td>
                    </table>       
           
            </td>
        </tr>
        <tr HEIGHT='15px'>
            <td class="textB" ></td>
            <td class="text"></td>
            <td class="textB"></td>
            <td class="text"></td>
        </tr>
        <!--tr height="35px">
            <td class="textB" width="20%">Tipologia Scarto</td>
            <td class="text" width="25%">
                <select name="comboStoredProcedure" width="10px" class="text" onchange="">
                    <option value="0" Selected>Selezionare Tipologia Scarto</option>
                    < %
                        Object[] objsStored=storedPromozioni.toArray();
                        for (int i=0;i<storedPromozioni.size();i++) {
                            I5_2PROMOZIONI_ROW objStored=(I5_2PROMOZIONI_ROW)objsStored[i];
                    % >
                        <option value="< % = objStored.getSTORED_PROCEDURE() % >">< % = objStored.getSTORED_PROCEDURE() % ></option>
                    < %
                        }
                    % >
                </select>
            </td>
            <td class="textB" width="10%">&nbsp;</td>
            <td class="textB" width="50%">&nbsp;</td>
        </tr-->
        <tr HEIGHT='15px'>
            <td class="text" width="100%" colSpan="2"></td>
            <td class="text" width="100%" colSpan="2"><input type="button" class="textB" Value="Ricerca" onclick="onRicercaList();"/></td>
        </tr>

        </table>
        </td>
        <td width="5%"></td>
        </tr>
<%

if (statoVisibile.equals("1"))
  {

%>

<tr>
        <td rowSpan="1" colSpan="6">
          <table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Risultati Scarti</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
              </tr>
          </table>
        </td>
        </tr>
      </table>

    </td>
    </tr>
     <tr>
    <td>
<table width="90%" align='center' width="100%" border="0" cellspacing="0" cellpadding="6" bgcolor="#CFDBE9">
        <tr>
          <td bgcolor='#D5DDF1' class="textB" width="0%" >&nbsp;</td>      
          <td bgcolor='#D5DDF1' class="textB" width="10%">Codice Itrf Fat</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Code Rich</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Desc Id Ris</td>
          <td bgcolor='#D5DDF1' class="textB" width="5%">Code Tipo Contr</td>
          <td bgcolor='#D5DDF1' class="textB" width="5%">Code Contr</td>          
          <td bgcolor='#D5DDF1' class="textB" width="5%">Code Scarto</td> 
          <td bgcolor='#D5DDF1' class="textB" width="5%">Data Acq Chius</td> 
          <td bgcolor='#D5DDF1' class="textB" width="50%">Desc Scarto</td> 
        </tr>

                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=scarti.size()%>">
                <pg:param name="typeLoad" value="1"></pg:param>
                <pg:param name="cod_tipo_contr" value="<%=cod_tipo_contr%>"></pg:param>
                <pg:param name="des_tipo_contr" value="<%=des_tipo_contr%>"></pg:param>
                <pg:param name="disattivi" value="<%=checkvalue%>"></pg:param>
                <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
<%
                String bgcolor="";
                String checked;  
                Object[] objs=scarti.toArray();
                boolean  caricaDesc=true;
%>
                <input type="hidden" name=Nrec id=Nrec value="<%=scarti.size()%>">
<%

                for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<scarti.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                   {

                    ListaScartiPopolamento_ROW obj=(ListaScartiPopolamento_ROW)objs[i];
                    
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;
                        
                   %>
                       <tr>
                        <td bgcolor="<%=bgcolor%>" width='2%'>
                        <input bgcolor='<%=bgcolor%>'  type='hidden'  name='SelOf' >
                       </td>
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getCODE_ITRF_FAT()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getCODE_RICH()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getDESC_ID_RISORSA()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getCODE_TIPO_CONTR()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getCODE_CONTR()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getCODE_SCARTO()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getDATA_ACQ_CHIUS()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getDESC_SCARTO()%></td>
                      </tr>
                <%    
                    }
                %>
                    <tr>
                      <td colspan='9' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="3" height='2'></td>
                    </tr>

                <pg:index>
                          <tr>
                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="9" class="text" align="center">
                                Risultati Pag.
                          <pg:prev> 
                                <A HREF="<%= pageUrl %>&Visibile=1" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[<< Prev]</A>
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
                                  <A HREF="<%= pageUrl %>&Visibile=1" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
                                <%
                                  } 
                                %>
                                
                          </pg:pages>

                          <pg:next>
                                 <A HREF="<%= pageUrl %>&Visibile=1" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[Next >>]</A>
                          </pg:next>

                            </td>
                          </tr>

                </pg:index>

                </pg:pager>
          </table>
    </td>
    </tr>
</table>
<br>

<%if  (scarti.size() != 0)
  {
%>
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
   <tr>
     <td class="textB" bgcolor="<%=StaticContext.bgColorFooter%>" align="center">
        <sec:ShowButtons VectorName="vectorButton" />
        <input type='checkbox' name='isRepricing'  value='N' onclick="onRepricing();"/>Riciclo su fatturazione corrente
        <input name='AGGIORNA' type="hidden" value="N"/>
    </td>
  </tr>
</table>
<%
  }
}
%>
<input type="hidden" name="Visibile" id="Visibile" value="1">
</form>
</div>

</body>
<script>
var http=getHTTPObject();
</script>
</html>
