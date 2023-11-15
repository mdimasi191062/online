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
<%=StaticMessages.getMessage(3006,"inibsapsp.jsp")%>
</logtag:logData>
<EJB:useHome id="home" type="com.ejbSTL.I5_2INIBIZIONE_INVIO_SAPHome" location="I5_2INIBIZIONE_INVIO_SAP" />  
<EJB:useBean id="inibSap" type="com.ejbSTL.I5_2INIBIZIONE_INVIO_SAP" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%


//alf
I5_2INIBIZIONE_INVIO_SAP_ROW rowMod = new I5_2INIBIZIONE_INVIO_SAP_ROW();



//alf
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 

String operazione = Misc.nh(request.getParameter("operazione"));  

I5_2INIBIZIONE_INVIO_SAP_ROW[] aRemote = null;

// Lettura del Numero di record per pagina (default 5)
String strNumRec = request.getParameter("numRec");
  if (strNumRec==null)
    strNumRec="5";
int records_per_page = Integer.parseInt(strNumRec);

String code_gest_sap="";
String code_gest="";
String nome_rag_soc_gest="";
String data_inizio_valid="";
String data_fine_valid="";
String checkvalue="";
int index=0;
boolean rispMod = false;
//Vector codicesap = gestSap.findAll();
Vector codicesap=null;



if (operazione.equals("1"))
{
    String rch_desc_gest = request.getParameter("txtRicDescCodAccount");
    codicesap = inibSap.findGestore(rch_desc_gest,"S");
}
else
    if (operazione.equals("D"))
    {
        int idRegola = Integer.parseInt(request.getParameter("txtIdRegola"));
        rispMod = inibSap.eliminaInibSap(idRegola);
        codicesap = inibSap.findAllGestore("S");
    }
    else
        if (operazione.equals("C"))
        {
            int idRegola = Integer.parseInt(request.getParameter("txtIdRegola"));
            rispMod = inibSap.chiudiInibSap(idRegola);
            codicesap = inibSap.findAllGestore("S");
        }
            else
                if (operazione.equals("M"))
                {
                    int idRegola = Integer.parseInt(request.getParameter("txtIdRegola"));
                    rowMod.setID_REGOLA(idRegola);
                    rowMod.setFLAG_SAP(request.getParameter("txtFlagSap"));
                    rowMod.setFLAG_RESOCONTO_SAP(request.getParameter("txtFlagResSap"));
                    rowMod.setNOTE(request.getParameter("txtNote"));
                    rowMod.setNOTE_RESOCONTO_SAP(request.getParameter("txtNoteResSap"));
                    rowMod.setDATA_FINE_VALID(request.getParameter("txtDataFin"));
                    rowMod.setTIPO_DOC(request.getParameter("txtTipoDoc"));
                    rispMod = inibSap.modifyInibSap(rowMod);
                    codicesap = inibSap.findAllGestore("S");
                }
                else
                {
                    codicesap = inibSap.findAllGestore("S");
                } 

%>

<SCRIPT LANGUAGE="JavaScript" SRC="../../elab_attive/js/ElabAttive.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js" type="text/javascript"></SCRIPT>
<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
<script src="../../jquery.min.js" type="text/javascript"></script>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<SCRIPT LANGUAGE='Javascript'>
function cancelCalendar1(){

document.getElementById("txtDataIni").value = "";

}

function cancelCalendar2(){

document.getElementById("txtDataFin").value = "";

}
var flgCambioParametri = false;

function fntCambioParametri() {
    flgCambioParametri = true;
}
function inizializza(){
  orologio.style.visibility='hidden';
  orologio.style.display='none';
}

function changeFlagSap(){
        
    
    if (document.formPag.txtFlagSap.value=="SI")
    {
        document.formPag.txtFlagResSap.disabled = true;
    }
    else
    {
        document.formPag.txtFlagResSap.disabled = false;
    }
    if (document.formPag.txtFlagSap.value=="NO")
    {
        document.formPag.txtTipoDoc.disabled = false;
    }
    else
    {
        document.formPag.txtTipoDoc.disabled = true;
        document.formPag.txtTipoDoc.value = '';
    }
}

function click_cmdAccount(){
      var URL = '';
      document.formPag.txtDescAccount.value = "";
      document.formPag.txtAcronimoAccount.value = "";
      var URLParam = '?CodAccountSel='+formPag.txtAcronimoAccount.value+ '&DescAccountSel=' + encodeURI(formPag.txtDescAccount.value)// +formPag.txtDescAccount.value;
      URL='sel_account_Inib_Sap.jsp' + URLParam;
      openCentral(URL,'Account','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
}
function click_cmdRicerca()
{ 
    if (document.formPag.txtRicDescCodAccount.value=='')
    {
        document.formPag.action = "inibsapsp.jsp?operazione=2";
        document.formPag.submit();
    }
     else 
    {
        document.formPag.action = "inibsapsp.jsp?operazione=1";
        document.formPag.submit();
    }
}

function click_SelCodeGest(v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13)
{ 
     EnableLink(document.links[0],document.formPag.imgCalendar1);
     EnableLink(document.links[1],document.formPag.cancelIni);
     EnableLink(document.links[2],document.formPag.imgCalendar2);
     EnableLink(document.links[3],document.formPag.cancelFin);
    //var dataStr = '<%= formatter.format(new Date())%>';2021-03-25 17:47:24
    var data = new Date();
    
    var dataStr = data.getFullYear() + "-" + ("0" + (data.getMonth() +1)).slice(-2) + "-" + ("0" + data.getDate()).slice(-2) + " " + ("0" + data.getHours()).slice(-2) + ":" + ("0" + data.getMinutes()).slice(-2) + ":" + ("0" + data.getSeconds()).slice(-2);
    if (v3 > dataStr || (v4 != null && v4 < dataStr))
    { 
        alert("Riga non modificabile perchè non in corso validità");
        document.formPag.txtDescAccount.value = "";
         document.formPag.txtAcronimoAccount.value = "";
         document.formPag.txtDataIni.value = "";
         document.formPag.txtDataFin.value = "";
         document.formPag.txtFlagSap.value = "";
         document.formPag.txtFlagResSap.value = "";
         document.formPag.txtNoteResSap.value = "";
         document.formPag.txtNote.value = "";
         document.formPag.txtTipoDoc.value = "";
         document.formPag.cmdAggiungi.disabled = false;
         document.getElementById("cmdModifica").disabled = true;
         document.getElementById("cmdChiudi").disabled = true;
         document.getElementById("cmdElimina").disabled = true;
        document.getElementById("selCodeGest").checked = false;
    }
    else
        if (v12=="N")
            { 
                alert("Riga non modificabile perchè non attiva");
                document.formPag.txtDescAccount.value = "";
                 document.formPag.txtAcronimoAccount.value = "";
                 document.formPag.txtDataIni.value = "";
                 document.formPag.txtDataFin.value = "";
                 document.formPag.txtFlagSap.value = "";
                 document.formPag.txtFlagResSap.value = "";
                 document.formPag.txtNoteResSap.value = "";
                 document.formPag.txtNote.value = "";
                 document.formPag.txtTipoDoc.value = "";
                 document.formPag.cmdAggiungi.disabled = false;
                 document.getElementById("cmdModifica").disabled = true;
                 document.getElementById("cmdChiudi").disabled = true;
                 document.getElementById("cmdElimina").disabled = true;
                document.getElementById("selCodeGest").checked = false;
            }
            else
            {
                document.formPag.txtDescAccount.value = v1;
                document.formPag.txtDescAccount.disabled = 'true';
                document.formPag.txtAcronimoAccount.value = v2;
                document.formPag.txtAcronimoAccount.disabled = 'true';
                document.formPag.txtDataIni.value = v5;
                document.formPag.txtDataIni.disabled = 'true';
                document.formPag.txtDataFin.value = v6;
                document.formPag.txtFlagSap.value = v7;
                document.formPag.txtFlagResSap.value = v8;
                document.formPag.txtNoteResSap.value = v9;
                document.formPag.txtNote.value = v10;
                document.formPag.txtIdRegola.value = v11;
                document.formPag.txtTipoDoc.value = v13;
                DisableLink(document.links[0],document.formPag.imgCalendar1);
                DisableLink(document.links[1],document.formPag.cancelIni);
                document.formPag.cmdAggiungi.disabled = 'true';
                document.getElementById("cmdModifica").disabled = false;
                document.getElementById("cmdChiudi").disabled = false;
                document.getElementById("cmdElimina").disabled = false;
                if (document.formPag.txtFlagSap.value=="SI")
                {
                    document.formPag.txtFlagResSap.disabled = true;
                }
                else
                {
                    document.formPag.txtFlagResSap.disabled = false;
                }
                if (document.formPag.txtFlagSap.value=="NO")
                {
                    document.formPag.txtTipoDoc.disabled = false;
                }
                else
                {
                    document.formPag.txtTipoDoc.disabled = true;
                }
            }
}


function Reset()
{ 
     document.formPag.txtDescAccount.value = "";
     document.formPag.txtAcronimoAccount.value = "";
     document.formPag.txtDataIni.value = "";
     document.formPag.txtDataFin.value = "";
     document.formPag.txtFlagSap.value = "";
     document.formPag.txtFlagResSap.value = "";
     document.formPag.txtNoteResSap.value = "";
     document.formPag.txtNote.value = "";
     document.formPag.txtTipoDoc.value = "";
     document.formPag.cmdAggiungi.disabled = false;
     EnableLink(document.links[0],document.formPag.imgCalendar1);
     EnableLink(document.links[1],document.formPag.cancelIni);
     EnableLink(document.links[2],document.formPag.imgCalendar2);
     EnableLink(document.links[3],document.formPag.cancelFin);
     document.getElementById("cmdModifica").disabled = true;
     document.getElementById("cmdChiudi").disabled = true;
     document.getElementById("cmdElimina").disabled = true;
     document.getElementById("selCodeGest").checked = false;
}
function click_cmdModifica()
{ 

    if ((document.formPag.txtFlagSap.value=="NO")&& ( document.formPag.txtTipoDoc.value == ''))
    {
        alert(" il Tipo doc e' obbligatorio per Flag_Sap uguale NO");
    }
    else
    {
        document.getElementById("cmdAggiungi").disabled = true;
       
    
        if (confirm("Procedere con l'aggiornamento della regola ?")==true)
        {
            document.formPag.action = "inibsapsp.jsp?operazione=M";
            document.formPag.submit();
        }
    }
}

function click_cmdElimina()
{ 

    document.getElementById("cmdAggiungi").disabled = true;
    

    if (confirm("Procedere con l'eliminazione della regola selezionata?")==true)
    {
        document.formPag.action = "inibsapsp.jsp?operazione=D";
        document.formPag.submit();
    }

}

function click_cmdChiudiReg()
{ 

    document.getElementById("cmdAggiungi").disabled = true;
    

    if (confirm("Procedere con la chiusura della regola selezionata?")==true)
    {
        document.formPag.action = "inibsapsp.jsp?operazione=C";
        document.formPag.submit();
    }

}

function ONAGGIUNGI()
{ 

    if ( document.formPag.txtDescAccount.value == '' ) {
        alert('Il Codice Account Sap è obbligatorio.');
        document.formPag.txtDescAccount.focus();
        return;
    }

    if ( document.formPag.txtDataIni.value == '' ) {
        alert('La Data di inizio validità è obbligatoria.');
        document.formPag.txtDataIni.focus();
        return;
    }
    
    if ( document.formPag.txtFlagSap.value == '' ) {
        alert('Il Flag Sap è obbligatorio.');
        document.formPag.txtFlagSap.focus();
        return;
    }    
    
    if (( document.formPag.txtFlagSap.value == 'NO' ) && ( document.formPag.txtTipoDoc.value == '' )) {
        alert('Il Tipo Doc è obbligatorio.');
        document.formPag.txtTipoDoc.focus();
        return;
    }    

    if (confirm("Procedere con l'inserimento della Regola?")==true)
    {
       //window.document.formPag.submit();
      
      var sParametri='';
      sParametri= '?operazione=0';
      sParametri= sParametri + '&txtCodeAccount='+encodeURI(document.formPag.txtCodeAccount.value);
      sParametri= sParametri + '&txtAcronimoAccount='+encodeURI(document.formPag.txtAcronimoAccount.value);
      sParametri= sParametri + '&txtDataIni='+encodeURI(document.formPag.txtDataIni.value); 
      sParametri= sParametri + '&txtDataFin='+encodeURI(document.formPag.txtDataFin.value);
      sParametri= sParametri + '&txtFlagSap='+encodeURI(document.formPag.txtFlagSap.value);
      sParametri= sParametri + '&txtFlagResSap='+encodeURI(document.formPag.txtFlagResSap.value);
      sParametri= sParametri + '&txtNoteResSap='+encodeURI(document.formPag.txtNoteResSap.value);
      sParametri= sParametri + '&txtNote='+encodeURI(document.formPag.txtNote.value);
      sParametri= sParametri + '&txtTipoDoc='+encodeURI(document.formPag.txtTipoDoc.value);

      openDialog("salva_inib_sap.jsp" + sParametri, 600, 320);   
    }
    document.formPag.action = "inibsapsp.jsp?operazione=2";
    document.formPag.submit();
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
    <td><img src="../images/InibSapSp.gif" border="0"></td>
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
            <td class="textB" width="10%">Descrizione Account</td>
            <td class="text"  width="30%"><input type='text' name='txtRicDescCodAccount' value='' class="text" maxlength=30 size=30 style="margin-left: 1px;text-transform:uppercase" onblur="this.value=this.value.toUpperCase();"></td>
            <td class="textB" width="10%">
                <input class="textB" title="Ricerca Regola" type="button" maxlength="30" name="cmdRicerca" bgcolor="<%=StaticContext.bgColorFooter%>" value="Ricerca Regola" onClick="click_cmdRicerca();">
             </td>
            <td class="textB" width="10%"></td>
            <td class="textB" width="10%" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <select class="text" name="numRec" onchange="click_cmdRicerca();">
                          <option class="text" value=5>5</option>
                          <option class="text" value=10>10</option>
                          <option class="text" value=20>20</option>
                          <option class="text" value=50>50</option>
                        </select>
                      </td>
             
         </tr>
      </table>
      <br>
      <table width="90%" border="0" cellspacing="0" cellpadding="4" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr HEIGHT='35px'>
            <td class="textB" width="20%">Account</td>
            <td class="text" width="20%" ><input type='text' name='txtDescAccount' value='' class="text" maxlength=30 size=30>
            <INPUT type="hidden" class="text" id="txtCodeAccount" name="txtCodeAccount" disabled readonly obbligatorio="si" tipocontrollo="intero" label="Codice Account" Update="false" size="13" >
            <INPUT type="hidden" class="text" id="txtIdRegola" name="txtIdRegola"  >
            <input  class="text" title="Selezione Account" type="button" maxlength="30" name="cmdAccount" value="..." onClick="click_cmdAccount();">
                            <a style="VERTICAL-ALIGN: text-bottom" href="javascript:clearField(formPag.txtCodeAccount);clearField(formPag.txtDescAccount);" onMouseOut="status='';return true"><img name='imgCancel1'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
            </td>
            <td class="textB" width="20%">Acronimo Account</td>
            <td class="text" width="20%"><input disabled type='text' name='txtAcronimoAccount' value='' class="text" maxlength=3 size=10 style="margin-left: 1px;text-transform:uppercase" onblur="this.value=this.value.toUpperCase();"></td>
            <td class="textB" width="20%">
                <input class="textB" title="Aggiungi" type="button" maxlength="30" name="cmdAggiungi" bgcolor="<%=StaticContext.bgColorFooter%>" value="Aggiungi" onClick="ONAGGIUNGI();">      
            </td>
        
         </tr>
        <tr HEIGHT='15px'>
            <td class="textB" width="20%"></td>
            <td class="text" width="20%"></td>
            <td class="textB" width="20%"></td>
            <td class="textB" width="20%"></td>
            <td class="textB" width="20%"></td>
        </tr>
 
        <tr HEIGHT='35px'>
           <td class="textB" width="20%">Data Inizio Validita'</td>
            <td class="text" width="20%" >
               <div name="divDataIni" id="divDataIni" class="textB">
                <input type="text" class="text" id="txtDataIni" name="txtDataIni" readonly obbligatorio="si" tipocontrollo="data" label="Data inizio" value="" size="20" Update="false">
                  <a href="javascript:cal1.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img src="../../common/images/body/calendario.gif" border="0" valign="Bottom" alt="Click per selezionare una data" name="imgCalendar1" WIDTH="20" HEIGHT="20"></a>
                 <a href="javascript:cancelCalendar1();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancelIni' src="../../common/images/body/cancella.gif" border="0" valign="Bottom" WIDTH="20" HEIGHT="20"></a>
                  <input type="hidden" id="txtDataIniOld">
                </div>
            </td>
            <td class="textB" width="20%">Data Fine Validita'</td>
            <td class="textB" width="20%">
               <div name="divDataFin" id="divDataFin" class="textB">
                 <INPUT class="text" id="txtDataFin" name="txtDataFin"   tipocontrollo="data" label="Data Fine" value="" size="20" Update="false" >
                 <a href="javascript:cal2.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img src="../../common/images/body/calendario.gif" border="0" valign="Bottom" alt="Click per selezionare una data" name="imgCalendar2" WIDTH="20" HEIGHT="20"></a>
                 <a href="javascript:cancelCalendar2();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancelFin' src="../../common/images/body/cancella.gif" border="0" valign="Bottom" WIDTH="20" HEIGHT="20"></a>
                  <input type="hidden" id="txtDataFinOld">
                  </div>
                </td>
            <td class="textB" width="20%">
               <input class="textB" title="Modifica" type="button" maxlength="30" id="cmdModifica" name="cmdModifica" bgcolor="<%=StaticContext.bgColorFooter%>" disabled="true" value="Modifica" onClick="click_cmdModifica();">  
               &nbsp;&nbsp;&nbsp;&nbsp;
               <input class="textB" title="Elimina" type="button" maxlength="30" id="cmdElimina" name="cmdElimina" bgcolor="<%=StaticContext.bgColorFooter%>" disabled="true" value="Elimina" onClick="click_cmdElimina();">      
            </td>   
            </tr>
       
        <tr HEIGHT='15px'>
            <td class="textB" width="20%"></td>
            <td class="text" width="20%"></td>
            <td class="textB" width="20%"></td>
            <td class="textB" width="20%"></td>
            <td class="textB" width="20%"></td>
        </tr>
        <tr HEIGHT='35px'>
            <td class="textB" width="20%">Flag Sap</td>
            <td class="textB" width="20%">
            <select class="text" name="txtFlagSap" onchange="changeFlagSap();">
                          <option class="text" selected value=""></option>
                          <option class="text" value="SI">SI</option>
                          <option class="text" value="NO">NO</option>
                          <option class="text" value="I">I</option>
            </select>
            </td>
            <td class="textB" width="20%">Flag Resoconto Sap</td>
            <td class="text" width="20%">
            <select disabled class="text" name="txtFlagResSap" >
                          <option class="text" selected value="SI">SI</option>
                          <option class="text" value="NO">NO</option>
            </select>
            </td>
            <td class="textB" width="20%">
                <input class="textB" title="Chiudi" type="button" maxlength="30" id="cmdChiudi" name="cmdChiudi" disabled bgcolor="<%=StaticContext.bgColorFooter%>" value="Chiudi Regola" onClick="click_cmdChiudiReg();">      
            </td>
        
         </tr>
        <tr HEIGHT='15px'>
            <td class="textB" width="20%"></td>
            <td class="text" width="20%"></td>
            <td class="textB" width="20%"></td>
            <td class="textB" width="20%"></td>
            <td class="textB" width="20%"></td>
        </tr>
        <tr HEIGHT='35px'>
            
            <td class="textB" width="20%">Note</td>
            <td class="text" width="20%"><input type='text' name='txtNote' value='' class="text" maxlength=10 size=10 style="margin-left: 1px;text-transform:uppercase" onblur="this.value=this.value.toUpperCase();"></td>
            <td class="textB" width="20%">Note Resoconto Sap</td>
            <td class="text" width="20%" ><input type='text' name='txtNoteResSap' value='' class="text" maxlength=10 size=10></td>
            <td class="textB" width="20%">
                <input class="textB" title="Reset" type="button" maxlength="30" name="cmdReset" bgcolor="<%=StaticContext.bgColorFooter%>" value="Pulisci Campi" onClick="Reset();">      
            </td>
        
         </tr>
         <tr HEIGHT='35px'>
            
            <td class="textB" width="20%">Tipologia Documento</td>
            <td class="text" width="20%">
                <select disabled class="text" name="txtTipoDoc" onchange="changeTipoDoc();" >
                          <option class="text" selected value=""></option>
                          <option class="text" value="Fattura">Fattura</option>
                          <option class="text" value="Nota di Credito">Nota di Credito</option>
                          <option class="text" value="Entrambe">Entrambe</option>
            </select>
            </td>
        
         </tr>
        <tr HEIGHT='15px'>
            <td class="textB" width="20%"></td>
            <td class="text" width="20%"></td>
            <td class="textB" width="20%"></td>
            <td class="textB" width="20%"></td>
            <td class="textB" width="20%"></td>
        </tr>
       <tr>
        <td rowSpan="1" colSpan="6">
          <table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Risultati Codici Account Sap</td>
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
          <td bgcolor='#D5DDF1' class="textB" width="10%">Account</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Acronimo Account</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Data Inizio Validita'</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Data Fine Validita'</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Flag SAP</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Flag Resoconto SAP</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Note Resoconto SAP</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Note</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Attiva</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Tipo Doc</td>
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
                    I5_2INIBIZIONE_INVIO_SAP_ROW obj=(I5_2INIBIZIONE_INVIO_SAP_ROW)objs[i];
                    
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;
                        String OutDataInizioValidita = obj.getDATA_INIZIO_VALID();
                        String FormOutDataInizioValidita = OutDataInizioValidita;
                        if (OutDataInizioValidita != null) 
                        {
                            //OutDataInizioValidita = OutDataInizioValidita.substring(0,10);
                            //FormOutDataInizioValidita = OutDataInizioValidita.substring(8,10) + '/' + OutDataInizioValidita.substring(5,7) + '/' + OutDataInizioValidita.substring(0,4);
                            FormOutDataInizioValidita = OutDataInizioValidita.substring(0,19);
                        }
                    
                        String OutDataFineValidita = obj.getDATA_FINE_VALID();
                        String FormOutDataFineValidita = OutDataFineValidita;
                        if (OutDataFineValidita != null)
                        {
                            //OutDataFineValidita = OutDataFineValidita.substring(0,10);
                            //FormOutDataFineValidita = OutDataFineValidita.substring(8,10) + '/' + OutDataFineValidita.substring(5,7) + '/' + OutDataFineValidita.substring(0,4);
                            FormOutDataFineValidita = OutDataFineValidita.substring(0,19);
                        } else
                        {
                            FormOutDataFineValidita = "";
                        }
                        
                        
                        
                   %>
                       <tr>
                        <td bgcolor='<%=bgcolor%>' class='text'>
                                <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name='selCodeGest'  id='selCodeGest'  value="<%=obj.getCODE_ACCOUNT()%>" onClick="click_SelCodeGest('<%=obj.getDESC_ACCOUNT()%>','<%=obj.getCODE_GEST()%>','<%=OutDataInizioValidita%>','<%=OutDataFineValidita%>','<%=FormOutDataInizioValidita%>','<%=FormOutDataFineValidita%>','<%=obj.getFLAG_SAP()%>','<%=obj.getFLAG_RESOCONTO_SAP()%>','<%=obj.getNOTE_RESOCONTO_SAP()%>','<%=obj.getNOTE()%>','<%=obj.getID_REGOLA()%>','<%=obj.getFLAG_ATTIVA()%>','<%=obj.getTIPO_DOC()%>' );">
                        </td>
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getDESC_ACCOUNT()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getCODE_GEST()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=FormOutDataInizioValidita%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=FormOutDataFineValidita%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getFLAG_SAP()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getFLAG_RESOCONTO_SAP()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getNOTE_RESOCONTO_SAP()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getNOTE()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=(obj.getFLAG_ATTIVA().equals("S") ? "SI" : "NO")%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getTIPO_DOC()%></td>

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
<script language="JavaScript">
       // Calendario Data Inizio Validit?
       var cal2 = new calendar1(document.forms['formPag'].elements['txtDataFin']);
			 cal2.year_scroll = true;
			 cal2.time_comp = true;
       // Calendario Data Fine Validit?       
       var cal1 = new calendar1(document.forms['formPag'].elements['txtDataIni']);
			 cal1.year_scroll = true;
			 cal1.time_comp = true;
</script>
</html>
