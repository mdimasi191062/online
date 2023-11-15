<%@ page contentType="text/html;charset=windows-1252"%>
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.rmi.PortableRemoteObject" %>
<%@ page import="java.rmi.RemoteException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.ejb.*" %>
<%@ page import="com.utl.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>

<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
  <%=StaticMessages.getMessage(3006,"crea_gruppo.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttiveHome" location="Ctr_ElabAttive" />
<EJB:useBean id="remoteCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttive" scope="session">
    <EJB:createBean instance="<%=homeCtr_ElabAttive.create()%>" />
</EJB:useBean>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">

<title></title>
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>XML.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>ListaTariffeSp.js" type="text/javascript"></script>
</head>
<BODY  onLoad="Initialize()" onfocus="ControllaFinestra()" onmouseover=" ControllaFinestra()">
<%
 String strCodeRelazione = Misc.nh(request.getParameter("Code_Relazione"));
 String Inserisci = Misc.nh(request.getParameter("Ins"));
 DataFormat dataOdierna = new DataFormat();

 if ( Inserisci.equals("1") ) {
  String strDescGruppo = Misc.nh(request.getParameter("strDescGruppoAccount"));
  String strDataInizioValid = Misc.nh(request.getParameter("strInizioValid"));
  String strCodeAccount = Misc.nh(request.getParameter("strCodeAccount"));
  int intEsito = remoteCtr_ElabAttive.insGruppoAccount(strDescGruppo,strDataInizioValid, strCodeAccount, strCodeRelazione);
 }

%>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  var objWindows = null;
  var GruppoCreato ;
  
  function Initialize () {
    frmDati.strDescGruppoAccount.focus();
    nascondi(frmDati.orologio);
    <%if ( Inserisci.equals("1") ) {%>
      visualizza (frmDati.orologio);
      nascondi(frmDati.CREAGRUPPO);
      nascondi(frmDati.cmdAccount);
      nascondi(frmDati.imgCalendar);
      nascondi(frmDati.imgCancel);
      nascondi(frmDati.strDescAccount);
      nascondi(frmDati.strInizioValid);
      document.all('DescGruppo').innerText ="Creazione del Gruppo di Account in Corso..";
      document.all('DescValid').innerText ="";
      document.all('strAccount').innerText ="";
      nascondi(frmDati.strDescGruppoAccount);
      nascondi(frmDati.DescValid);
      frmDati.action = 'visualizza_gruppi.jsp?TipoRelazione=<%=strCodeRelazione%>';
      frmDati.submit();
    <%}%>
  }


function ConfrontoData(sData1,sData2)
{

	/** impostazione data 1 (ovvero data più bassa)
	Dato che l'applet mi ritorna l'anno con due cifre inserisco decido che gli anno 
	che siano maggiori di 31 siano 1931
	**/
	var sErrDataMaggiore='La data di inizio validità deve essere minore o uguale alla data di fine validità'
	var giorno1=0;
	var mese1=0;
	var anno1=0;
	var giorno2=0;
	var mese2=0;
	var anno2=0;
	
	//Controllo il giorno della data iniziale
	giorno1=sData1.substring(0,2);
	//Controllo il mese della data iniziale
	mese1=sData1.substring(3,5);
	//Controllo l'anno della data iniziale
	anno1=sData1.substring(6);
	
	
	if (anno1.length==2) 
	{
		if (anno1<31)
		{
			anno1='20' + anno
		}
		else
		{
			anno1='19' + anno
		}
	}
	
	/** impostazione data 2 (ovvero data più recente)
	Dato che l'applet mi ritorna l'anno con due cifre inserisco decido che gli anno 
	che siano maggiori di 31 siano 1931
	**/
		
	
	//Controllo il giorno della data finale
	giorno2=sData2.substring(0,2);
	//Controllo il mese della data finale
	mese2=sData2.substring(3,5);
	//Controllo l'anno della data finale
	anno2=sData2.substring(6);
	
	
	if (anno2.length==2) 
	{
		if (anno2<31)
		{
			anno2='20' + anno
		}
		else
		{
			anno2='19' + anno
		}
	}
	
	// controllo se la data iniziale è maggiore di quella finale

	if (parseInt(anno2)<parseInt(anno1))
	{
		alert(sErrDataMaggiore);
		return(false);			
	}
	else
	{
		if (parseInt(anno2)==parseInt(anno1))
		{
			if (parseInt(mese2)<parseInt(mese1))
			{
				alert(sErrDataMaggiore);
				return(false);			
			}
			else
			{
				if (parseInt(mese2)==parseInt(mese1))
				{				
					if (parseInt(giorno2) < parseInt(giorno1))
					{
						alert(sErrDataMaggiore);
						return(false);
					}				
				}
			}
		}
	}
	return(true);
}


  function ONCREAGRUPPO(){

    var strDataFine = '31/12/2030';
    
    if ( '' == frmDati.strDescGruppoAccount.value ) {
        alert('Attenzione! è necessario specificare il nome del Gruppo di Account');
        return;
    } 
    if ( '' == frmDati.strInizioValid.value ) {
        alert('Attenzione! è necessario specificare la data di inizio validità del Gruppo di Account');
        return;
    } 

    if ( '' == frmDati.strDescAccount.value ) {
        alert('Attenzione! è necessario selezionare un account per creare un Gruppo di Account');
        return;
    } 

    var a =ConfrontoData(frmDati.strInizioValid.value,strDataFine);

//    alert(a);
    if (a) {
      GruppoCreato = 1;
      var URL  = 'crea_gruppo.jsp';
      var URL_Param = '?Code_Relazione=<%=strCodeRelazione%>' + '&Ins=1';
      frmDati.action = URL + URL_Param ;
      frmDati.submit();
    }
  }

  function selezionaAccount() {
			var URL = '';

      URL='visualizza_account.jsp' + '?strCodeGruppo=-1' ;
      openCentral(URL,'Account','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
//      document.frmDati.submit();
  }
  
</SCRIPT>
<FORM name="frmDati" id="frmDati" action="" method="post">
<input type=hidden name="strCodeGruppo"  value="-1">
<input type=hidden name="strCodeAccount" value="">

  <table align=center width="80%" border="0" cellspacing="0" cellpadding="0" align='center'>
    <tr height="30">
      <td>
        <table width="100%">
          <tr>
            <td>
              <IMG alt="" src="../images/GruppiTariffari.gif" border="0">
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <TR height="20">
      <TD>
        <TABLE width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align='center'>
          <TR align="center">
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" align="left" valign="top" width="91%"> Crea Gruppo Account </td>
            <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%">
              <IMG alt="tre" src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"/>
            </TD>
          </TR>
        </TABLE>
      </TD>
    </TR>
    <%--<TR height="20">
      <TD>
        <TABLE width="90%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align="center">
          <TR align="center">
            <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white"/>
            <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%">
              <IMG alt="tre" src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"/>
            </TD>
          </TR>
        </TABLE>
      </TD>
    </TR>--%>
    <tr>
      <td>
        <table align="center" width="100%"  border="0" cellspacing="0" cellpadding="0">
          <TR>
            <TD class="text"> 
              <FONT id="DescGruppo" name="DescGruppo" nowrap> Descrizione Gruppo Account: </FONT> 
            </TD>
            <TD>
              <INPUT class="text" id="strDescGruppoAccount" name="strDescGruppoAccount"  obbligatorio="si"  label="Descrizione Gruppo Account" Update="false" size="80">
            </TD>
          </tr>
          <tr>
            <td class="text">
              <FONT id="strAccount" name="strAccount" nowrap> Seleziona L'account </FONT>          
            </td>
            <TD>
              <INPUT class="text" id="strDescAccount" name="strDescAccount" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Account" Update="false" size="35">
              <input class="text" title="Selezione Account" type="button" maxlength="30" name="cmdAccount" value="..." onClick="selezionaAccount();">
            </TD>
          </tr>
          <TR>
            <TD class="text">
              <FONT id="DescValid" name="DescValid" nowrap> Data Inizio Validità Gruppo:</FONT> 
            </TD>
            <TD>
              <INPUT class="text" id="strInizioValid" name="strInizioValid" readonly obbligatorio="si" tipocontrollo="data" label="Data Fine Validita" Update="false" size="10" value="">
              <%--<INPUT class="text" id="strInizioValid" name="strInizioValid" readonly obbligatorio="si" tipocontrollo="data" label="Data Fine Validita" Update="false" size="10" value="<%=dataOdierna.getDate()%>">
              <a href="javascript:showCalendar('frmDati.strInizioValid','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendar" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
              <a href="javascript:clearField(frmDati.strInizioValid);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancel" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>--%>
            </TD>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td align="center">
        <img   id="orologio" name ="orologio" src="../../common/images/body/orologio.gif" width="60" height="50" alt="" border="0">
      </td>
    </tr>
    <TR height="30">
      <TD>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
          <tr>
            <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
              <sec:ShowButtons td_class="textB"/>
            </td>
          </tr>
        </table>
      </TD>
    </TR>
  </table>
</form>
<SCRIPT>
</SCRIPT>
</body>
</html>