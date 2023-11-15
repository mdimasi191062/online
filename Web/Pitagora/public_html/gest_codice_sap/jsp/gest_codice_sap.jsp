<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
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
<%=StaticMessages.getMessage(3006,"gest_codice_sap.jsp")%>
</logtag:logData>
<EJB:useHome id="home" type="com.ejbSTL.I5_3GEST_SAP_SPHome" location="I5_3GEST_SAP_SP" />  
<EJB:useBean id="gestSap" type="com.ejbSTL.I5_3GEST_SAP_SP" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 

String operazione = Misc.nh(request.getParameter("operazione"));  

I5_3GEST_SAP_SP_ROW[] aRemote = null;

// Lettura del Numero di record per pagina (default 5)
String strNumRec = request.getParameter("numRec");
  if (strNumRec==null)
    strNumRec="5";
int records_per_page = Integer.parseInt(strNumRec);
//if (showmessage)
  //strNumRec=appo_numrec;
//else
 // strNumRec = request.getParameter("numRec");

/*if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }
*/
String code_gest_sap="";
String code_gest="";
String nome_rag_soc_gest="";
String data_inizio_valid="";
String data_fine_valid="";
String checkvalue="";
int index=0;

//Vector codicesap = gestSap.findAll();
Vector codicesap;

if (operazione.equals("1"))
{
    String rch_code_gest_sap = request.getParameter("txtRicCodGestoreSap");
    String rch_code_gest = request.getParameter("txtRicCodGestore");
    String rch_desc_gest = request.getParameter("txtRicDescCodGestore");
    codicesap = gestSap.findOne(rch_code_gest_sap,rch_code_gest,rch_desc_gest);
}
else
{
    codicesap = gestSap.findAll();
} 

%>

<SCRIPT LANGUAGE="JavaScript" SRC="../../elab_attive/js/ElabAttive.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<SCRIPT LANGUAGE='Javascript'>
var flgCambioParametri = false;

function fntCambioParametri() {
    flgCambioParametri = true;
}
function inizializza(){
  orologio.style.visibility='hidden';
  orologio.style.display='none';
}

function click_cmdRicerca()
{ 
    if (( document.formPag.txtRicCodGestoreSap.value == '' ) && (document.formPag.txtRicCodGestore.value=='')&& (document.formPag.txtRicDescCodGestore.value=='')) 
    {
        //alert('per effettuare la ricerca è obbligatorio digitare almeno uno dei campi gestore.');
        //document.formPag.txtCodGestoreSap.focus();
        //return;
        document.formPag.action = "gest_codice_sap.jsp?operazione=2";
        document.formPag.submit();
    }
     else 
    {
        document.formPag.action = "gest_codice_sap.jsp?operazione=1";
        document.formPag.submit();
    }
}

function click_SelCodeGest(v1,v2,v3,v4,v5,v6)
{ 
    //var sysdata = new Date();
    
    var dataStr = '<%= formatter.format(new Date())%>';
    //var dataStr = sysdata.toISOString().split('T')[0];
    //alert ("dataStr " + dataStr);
    //alert ("sysdata " + sysdata);
    //alert ("v3 " + v3);
    //alert ("v4 " + v4);
    if (v3 > dataStr || (v4 != null && v4 < dataStr))
    { 
        alert("Riga non modificabile perchè non in corso validità");
        
    }
    else
    {
        document.formPag.txtCodGestoreSap.value = v1;
        document.formPag.txtCodGestoreSap.disabled = 'true';
        document.formPag.txtCodGestore.value = v2;
        document.formPag.txtCodGestore.disabled = 'true';
        document.formPag.txtDataIni.value = v5;
        document.formPag.txtDataIni.disabled = 'true';
        DisableLink(document.links[0],document.formPag.calendarioDataIni);
        DisableLink(document.links[1],document.formPag.cancella_txtDataIni);
        document.formPag.txtDataFin.value = v6;
        document.formPag.cmdAggiungi.disabled = 'true';
        document.getElementById("cmdModifica").disabled = false;
    }
}
function click_cmdModifica()
{ 


    var dataStr = '<%= formatter.format(new Date())%>';
    //alert('dataStr ' + dataStr);
    //alert('txtDataFin ' + document.formPag.txtDataFin.value);
    var FormtxtDataFin = document.formPag.txtDataFin.value;
    if (FormtxtDataFin != null) 
    {
        FormtxtDataFin = document.formPag.txtDataFin.value.substring(6,10) + '-' + document.formPag.txtDataFin.value.substring(3,5) + '-' + document.formPag.txtDataFin.value.substring(0,2);
    }

    

    if (confirm("Procedere con l'aggiornamento del Codice Sap?")==true)
    {
       //window.document.frmSearch.submit();
      
      var sParametri='';
      sParametri= '?operazione=0';
      sParametri= sParametri + '&txtCodGestoreSap='+encodeURI(document.formPag.txtCodGestoreSap.value);
      sParametri= sParametri + '&txtCodGestore='+encodeURI(document.formPag.txtCodGestore.value);
      sParametri= sParametri + '&txtDataIni='+encodeURI(document.formPag.txtDataIni.value); 
      sParametri= sParametri + '&txtDataFin='+encodeURI(document.formPag.txtDataFin.value);

      openDialog("modifica_codice_sap.jsp" + sParametri, 600, 320);   
    }
    document.formPag.action = "gest_codice_sap.jsp?operazione=2";
    document.formPag.submit();
}
function ONAGGIUNGI()
{ 

if ( document.formPag.txtCodGestoreSap.value == '' ) {
        alert('Il Codice Gestore Sap è obbligatorio.');
        document.formPag.txtCodGestoreSap.focus();
        return;
    }

    if (document.formPag.txtCodGestore.value=='')
    {
        alert('Il Codice Gestore è obbligatorio.');
        document.formPag.txtCodGestore.focus();
        return;
    }

    if ( document.formPag.txtDataIni.value == '' ) {
        alert('La Data di inizio validità è obbligatoria.');
        document.formPag.txtDataIni.focus();
        return;
    }
    

    if (confirm("Procedere con l'inserimento del Codice Sap?")==true)
    {
       //window.document.frmSearch.submit();
      
      var sParametri='';
      sParametri= '?operazione=0';
      sParametri= sParametri + '&txtCodGestoreSap='+encodeURI(document.formPag.txtCodGestoreSap.value);
      sParametri= sParametri + '&txtCodGestore='+encodeURI(document.formPag.txtCodGestore.value);
      sParametri= sParametri + '&txtDataIni='+encodeURI(document.formPag.txtDataIni.value); 
      sParametri= sParametri + '&txtDataFin='+encodeURI(document.formPag.txtDataFin.value);

      openDialog("salva_codice_sap.jsp" + sParametri, 600, 320);   
    }
    document.formPag.action = "gest_codice_sap.jsp?operazione=2";
    document.formPag.submit();
}


function ChangeSel(codicePromo,descPromo,tipoPromo,valore,stored)
{

    document.formPag.txtCodPromo.value=codicePromo;
    document.formPag.txtDescPromo.value=descPromo;
    
    document.formPag.comboTipoPromo.value=tipoPromo;

    if (document.formPag.comboTipoPromo.value >= 2 ) {  
        document.formPag.txtValore.value=valore.replace('.',',');
    } else {
        document.formPag.txtValore.value=parseInt(valore, 10);
    }
    document.formPag.comboStoredProcedure.value=stored;

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
<form name="formPag" method="post">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloPagina.gif" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
        <tr>
        <td>
          <table width="95%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"></td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif"></td>
              </tr>
          </table>
        </td>
      </tr>
      </table>
      <br>
      <table width="90%" border="0" cellspacing="0" cellpadding="4" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr HEIGHT='35px'>
            <td class="textB" width="10%" >Codice Gestore Sap</td>
            <td class="text"  width="10%"><input type='text' name='txtRicCodGestoreSap' value='' class="text" maxlength=10 size=10></td>
            <td class="textB" width="10%">Codice Gestore</td>
            <td class="text"  width="10%"><input type='text' name='txtRicCodGestore' value='' class="text" maxlength=3 size=10 style="margin-left: 1px;text-transform:uppercase" onblur="this.value=this.value.toUpperCase();"></td>
            <td class="textB" width="10%">Descrizione Gestore</td>
            <td class="text"  width="30%"><input type='text' name='txtRicDescCodGestore' value='' class="text" maxlength=50 size=50 style="margin-left: 1px;text-transform:uppercase" onblur="this.value=this.value.toUpperCase();"></td>
            <td class="textB" width="10%" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <select class="text" name="numRec" onchange="click_cmdRicerca();">
                          <option class="text" value=5>5</option>
                          <option class="text" value=10>10</option>
                          <option class="text" value=20>20</option>
                          <option class="text" value=50>50</option>
                        </select>
                      </td>
             <td class="textB" width="10%" align="right">
                <input class="textB" title="Ricerca" type="button" maxlength="30" name="cmdRicerca" bgcolor="<%=StaticContext.bgColorFooter%>" value="Ricerca" onClick="click_cmdRicerca();">
             </td>
         </tr>
      </table>
      <br>
      <table width="90%" border="0" cellspacing="0" cellpadding="4" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr HEIGHT='35px'>
            <td class="textB" width="20%">Codice Gestore Sap</td>
            <td class="text" width="25%" ><input type='text' name='txtCodGestoreSap' value='' class="text" maxlength=10 size=10></td>
            <td class="textB" width="10%">Codice Gestore</td>
            <td class="text" width="50%"><input type='text' name='txtCodGestore' value='' class="text" maxlength=3 size=10 style="margin-left: 1px;text-transform:uppercase" onblur="this.value=this.value.toUpperCase();"></td>
            <td class="textB" bgcolor="<%=StaticContext.bgColorFooter%>" align="center">
                <input class="textB" title="Aggiungi" type="button" maxlength="30" name="cmdAggiungi" bgcolor="<%=StaticContext.bgColorFooter%>" value="Aggiungi" onClick="ONAGGIUNGI();">      
            </td>
        
         </tr>
        <tr HEIGHT='15px'>
            <td class="textB" width="20%"></td>
            <td class="text" width="25%"></td>
            <td class="textB" width="10%"></td>
            <td class="text" width="50%"></td>
        </tr>
 
        <tr HEIGHT='35px'>
           <td class="textB" >Data Inizio Validità</td>
            <td class="text" >
               <div name="divDataIni" id="divDataIni" class="textB">
                <input type="text" class="text" id="txtDataIni" name="txtDataIni" readonly obbligatorio="si" tipocontrollo="data" label="Data inizio" value="" size="10" Update="false">
                  <a href="javascript:showCalendar('formPag.txtDataIni','');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true" ><img name='calendarioDataIni' src="../../common/images/img/cal.gif" border="no"></a>
                  <a href="javascript:cancelCalendar(document.formPag.txtDataIni);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_txtDataIni' src="../../common/images/img/images7.gif" border="0"></a>
                  <input type="hidden" id="txtDataIniOld">
                </div>
            </td>
            <td class="textB">Data Fine Validità</td>
            <td class="textB">
               <div name="divDataFin" id="divDataFin" class="textB">
                 <INPUT class="text" id="txtDataFin" name="txtDataFin" readonly  tipocontrollo="data" label="Data Fine" value="" size="10" Update="false" >
                  <a href="javascript:showCalendar('formPag.txtDataFin','');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true" ><img name='calendarioDataFin' src="../../common/images/img/cal.gif" border="no"></a>
                  <a href="javascript:cancelCalendar(document.formPag.txtDataFin);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_txtDataFin' src="../../common/images/img/images7.gif" border="0"></a>
                  <input type="hidden" id="txtDataFinOld">
                  </div>
                </td>
            <td class="textB">
               <input class="textB" title="Modifica" type="button" maxlength="30" id="cmdModifica" name="cmdModifica" bgcolor="<%=StaticContext.bgColorFooter%>" disabled="true" value="Modifica" onClick="click_cmdModifica();">      
            </td>   
            </tr>
       
        <tr HEIGHT='15px'>
            <td class="textB" width="20%"></td>
            <td class="text" width="25%"></td>
            <td class="textB" width="10%"></td>
            <td class="text" width="50%"></td>
        </tr>
       <tr>
        <td rowSpan="1" colSpan="6">
          <table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Risultati Codici Gestore Sap</td>
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
          <td bgcolor='#D5DDF1' class="textB" width="2%"> </td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Codice Gestore Sap</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Codice Gestore</td>
          <td bgcolor='#D5DDF1' class="textB" width="30%">Descrizione Gestore</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Data Inizio Validita</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Data Fine Validita</td>
        </tr>

                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=codicesap.size()%>">
                <pg:param name="typeLoad" value="1"></pg:param>
                <pg:param name="code_gest_sap" value="<%=code_gest_sap%>"></pg:param>
                <pg:param name="code_gest" value="<%=code_gest%>"></pg:param>
                <pg:param name="nome_rag_soc_gest" value="<%=nome_rag_soc_gest%>"></pg:param>
                <pg:param name="data_inizio_valid" value="<%=data_inizio_valid%>"></pg:param>
                <pg:param name="data_fine_valid" value="<%=data_fine_valid%>"></pg:param>
                <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<%
                String bgcolor="";
                String checked;  
                Object[] objs=codicesap.toArray();
                boolean  caricaDesc=true;
%>
                <input type="hidden" name=Nrec id=Nrec value="<%=codicesap.size()%>">
<%

                for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<codicesap.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                   {
                    I5_3GEST_SAP_SP_ROW obj=(I5_3GEST_SAP_SP_ROW)objs[i];
                    
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;
                        String OutDataInizioValidita = obj.getDATA_INIZIO_VALID();
                        String FormOutDataInizioValidita = OutDataInizioValidita;
                        if (OutDataInizioValidita != null) 
                        {
                            OutDataInizioValidita = OutDataInizioValidita.substring(0,10);
                            FormOutDataInizioValidita = OutDataInizioValidita.substring(8,10) + '/' + OutDataInizioValidita.substring(5,7) + '/' + OutDataInizioValidita.substring(0,4);
                        }
                    
                        String OutDataFineValidita = obj.getDATA_FINE_VALID();
                        String FormOutDataFineValidita = OutDataFineValidita;
                        if (OutDataFineValidita != null)
                        {
                            OutDataFineValidita = OutDataFineValidita.substring(0,10);
                            FormOutDataFineValidita = OutDataFineValidita.substring(8,10) + '/' + OutDataFineValidita.substring(5,7) + '/' + OutDataFineValidita.substring(0,4);
                        } else
                        {
                            FormOutDataFineValidita = "";
                        }
                        
                        
                        
                   %>
                       <tr>
                        <td bgcolor='<%=bgcolor%>' class='text'>
                                <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name='selCodeGest'  value="<%=obj.getCODE_GEST_SAP()%>" onClick="click_SelCodeGest('<%=obj.getCODE_GEST_SAP()%>','<%=obj.getCODE_GEST()%>','<%=OutDataInizioValidita%>','<%=OutDataFineValidita%>','<%=FormOutDataInizioValidita%>','<%=FormOutDataFineValidita%>' );">
                        </td>
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getCODE_GEST_SAP()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getCODE_GEST()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getNOME_RAG_SOC_GEST()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=FormOutDataInizioValidita%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=FormOutDataFineValidita%></td>
<!--
                        <td bgcolor="<%=bgcolor%>" class="text"><%//=obj.getDATA_INIZIO_VALID().substring(0,10)%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%//=obj.getDATA_FINE_VALID().substring(0,10)%></td>
-->
</tr>
                <%    
                    }
                %>
                    <tr>
                      <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="3" height='2'></td>
                    </tr>

                <pg:index>
                          <tr>
                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="5" class="text" align="center">
                                Risultati Pag.
                          <pg:prev> 
                                <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[<< Prev]</A>
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
                                  <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
                                <%
                                  } 
                                %>
                                
                          </pg:pages>

                          <pg:next>
                                 <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[Next >>]</A>
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
</form>

</div>



</body>
<script>
var http=getHTTPObject();
</script>
</html>
