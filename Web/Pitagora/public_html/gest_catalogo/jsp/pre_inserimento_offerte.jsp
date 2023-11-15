<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*,java.util.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"pre_inserimento_offerte.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  
  String strTitolo = null;
    
  strTitolo="Inserimento Offerta";

  String codiceDB = "";
  String codice_corretto = "";
  Vector vctGruppiOff = null;
  DB_Anag_Class_Off anag_class_off = null;

%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
  Offerte
</title>
</head>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/off_serv.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript">
var msg1="Click per selezionare la data";
var msg2="Click per cancellare la data selezionata";
var codice_db = "<%= codiceDB%>";

function impostaFocus()
{

  for(var i=0;i<document.forms[0].elements.length;i++)
  {
      if(document.forms[0].elements[i].type=="text")
      {      
        document.forms[0].elements[i].focus();
        break;
      }
  }
}   

function ONANNULLA()
{
   resetValue();
}   

function chkData(strData){
			var dataDiOggi = new Date();
      var data = new Date(strData.substring(6,10),strData.substring(3,5)-1,strData.substring(0,2),"23","59","59");
      if(data<dataDiOggi)
				return false;
      return true;
}


function ONCONFERMA()
{
  if(document.frmDati.codice.value.length==0){
    alert('Il Codice è obbligatorio.');
    document.frmDati.codice.focus();
    return;
  }
  if(document.frmDati.descrizione.value.length==0){
    alert("Descrizione è obbligatorio.");
    document.frmDati.descrizione.focus();
    return;
  }
  if (document.frmDati.tipologia_off.value != ""){
    if(document.frmDati.gruppo_classi_off.value==""){
      alert("Classe offerta è obbligatorio.");
      return;
    }
    if(document.frmDati.val_rec.value.length==0){
      alert('Valore % Recessi è obbligatorio.');
      return;
    }  
    if(!CheckNum(document.frmDati.val_rec.value,3,0,false)){
      alert('Valore % Recessi deve essere un numero.');
      document.frmDati.val_rec.focus();
      return;
    }
  }
  
  if(!CheckNum(document.frmDati.codice.value,9,0,false)){
    alert('Codice Offerta deve essere un numero e non deve superare le 9 cifre.');
    document.frmDati.codice.focus();
    return;
  }
  
  if(document.frmDati.dataIni.value.length==0){
    alert('La data inizio validità è obbligatoria.');
    return;
  }
  if(document.frmDati.dataFine.value.length==0){
    alert('La data fine validità è obbligatoria.');
    return;
  }

  opener.frmDati.strCodeOff.value = document.frmDati.codice.value;
  opener.frmDati.strDescOff.value = document.frmDati.descrizione.value;
  opener.frmDati.strDIVOff.value = document.frmDati.dataIni.value;
  opener.frmDati.strDFVOff.value = document.frmDati.dataFine.value;
  opener.frmDati.strTipologiaOff.value = document.frmDati.tipologia_off.value;

  if (document.frmDati.tipologia_off.value == ""){
    opener.frmDati.strClasseOff.value = "";
    opener.frmDati.strValRecOff.value = "";
  }else{
    opener.frmDati.strClasseOff.value = document.frmDati.code_gruppo_class_off.value;
    opener.frmDati.strValRecOff.value = document.frmDati.val_rec.value;
  }

  opener.frmDati.hidTypeLoad.value = "0";
  opener.frmDati.intAggiornamento.value = "1";

  self.close();
  opener.frmDati.submit();
}

function cancelCalendar (obj)
{
  obj.value="";
}

function setCombo(value){
   document.frmDati.code_gruppo_class_off.value = value;
}

function resetValue(){
   document.frmDati.codice.value = document.frmDati.codice_corretto.value;
   document.frmDati.descrizione.value = "";
   document.frmDati.dataIni.value = "";
   document.frmDati.dataFine.value = "31/12/2030";
   document.frmDati.tipologia_off.value = "";
   document.frmDati.code_gruppo_class_off.value = "";
   document.frmDati.gruppo_classi_off.value = "";
   document.frmDati.val_rec.value = "";
}

function ONCHIUDI(){
   window.close();
}


function controllaClassOff(value){
  if(value == ''){
    document.frmDati.gruppo_classi_off.value = '';
    document.frmDati.gruppo_classi_off.disabled = true;
    document.frmDati.val_rec.value = '';
    document.frmDati.val_rec.disabled = true;    
  }else{
    if(document.frmDati.val_rec.disabled){
      document.frmDati.val_rec.value = '';
      document.frmDati.val_rec.disabled = false; 
    }
    if(document.frmDati.gruppo_classi_off.disabled){
      document.frmDati.gruppo_classi_off.value = '';
      document.frmDati.gruppo_classi_off.disabled = false; 
    }
  }
}
</script>

<body onLoad="//impostaFocus()">
<form name="frmDati" method="post" action='pre_inserimento_offerte.jsp?operazione=1'>

<EJB:useHome id="home" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="offerte" type="com.ejbSTL.Ent_Catalogo" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<%
  codiceDB = offerte.getCodiceOfferta();
  codice_corretto = codiceDB;
%>
<input type="hidden" name="codiceDB" id="codiceDB" value="<%=codiceDB%>">
<input type="hidden" name="codice_corretto" id="codice_corretto" value="<%=codice_corretto%>">
<input type="hidden" name="code_gruppo_class_off" id="code_gruppo_class_off" value="">

<table align='center' width="95%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="../images/catalogo.gif" alt="" border="0"></td>
  <tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
						<tr>
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;<%= strTitolo %></td>
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
      <table align='center' width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
      <tr>
        <td  class="textB" align="left">Codice:</td>
        <td  class="text" align="left" colspan="2">
          <input type="text" class="text" name="codice" value="<%=codiceDB%>" maxlength="9" size="10" style="margin-left: 1px;">
        </td> 
      </tr>
      <tr>
        <td  class="textB" align="left">Descrizione:</td>
        <td  class="text" align="left" colspan="2">
          <input type="text" class="text" name="descrizione" maxlength="50" size="55" value="">
        </td>                
      </tr>
      <tr>
        <td  class="textB" align="left">Data Inizio Validità:</td>      
        <td  class="text" align="left" colspan="2">
          <input type="text" class="text" size=12 maxlength="12" name="dataIni" title="dataIni" value="01/01/1980" onblur="handleblur('data_ini');" readonly>
          <a href="javascript:cal1.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario' src="../../common/images/img/cal.gif" border="no"></a>
          <a href="javascript:cancelCalendar(document.frmDati.dataIni);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data' src="../../common/images/img/images7.gif" border="0"></a>
        </td>
      </tr>
      <tr>
        <td  class="textB" align="left">Data Fine Validità:</td>      
        <td  class="text" align="left" colspan="2">
          <input type="text" class="text" size=12 maxlength="12" name="dataFine" title="dataFine" value="31/12/2030" onblur="handleblur('data_fine');" readonly>
          <a href="javascript:cal2.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario' src="../../common/images/img/cal.gif" border="no"></a>
          <a href="javascript:cancelCalendar(document.frmDati.dataFine);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data' src="../../common/images/img/images7.gif" border="0"></a>
        </td>
      </tr>
      <tr>
        <td  class="textB" align="left">Tipologia Offerta:</td>      
        <td  class="text" align="left" colspan="2">
           <select class="text" name="tipologia_off" onchange="setCombo(this.value);controllaClassOff(this.value);">
             <option value="">[Selezionare Tipologia Offerta]</option>
             <option value="A">Annuale</option>
             <option value="B">Biennale</option>
             <option value="T">Triennale</option> 
             <option value="P">Pluriennale</option>            
           </select>
        </td>
      </tr>
      <tr>
        <td  class="textB" align="left">Classe offerte:</td>      
        <td  class="text" align="left" colspan="2">
           <select class="text" name="gruppo_classi_off" onchange="setCombo(this.value)">
            <option value="">[Selezionare Classe Offerta]</option>
            <%
            String selected = "";
            vctGruppiOff = offerte.getGruppiOfferte();
            for(int z=0;z<vctGruppiOff.size();z++){
              anag_class_off = (DB_Anag_Class_Off)vctGruppiOff.get(z);
              %>
              <option value="<%=anag_class_off.getCODE_CLASSE_OFFERTA()%>">
                 <%=anag_class_off.getDESC_CLASSE_OFFERTA()%>
              </option>
              <%
            }
            %>           
           </select>
        </td>
      </tr>
      <tr>
        <td  class="textB" align="left">Valore % Recessi:</td>
        <td  class="text" align="left" colspan="2">
          <input type="text" class="text" name="val_rec" value="" maxlength="3" size="5" style="margin-left: 1px;">
        </td>
      </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='10'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
            <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />        
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>
<script language="JavaScript">
       // Calendario Data Inizio Validità
       var cal1 = new calendar1(document.forms['frmDati'].elements['dataIni']);
			 cal1.year_scroll = true;
			 cal1.time_comp = false;
       // Calendario Data Fine Validità       
       var cal2 = new calendar1(document.forms['frmDati'].elements['dataFine']);
			 cal2.year_scroll = true;
			 cal2.time_comp = false;

       controllaClassOff('');
 </script>
</BODY>
</HTML>