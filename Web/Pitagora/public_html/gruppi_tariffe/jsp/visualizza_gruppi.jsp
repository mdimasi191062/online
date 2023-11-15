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
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/Tar" prefix="tar" %>

<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"visualizza_gruppi.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_TipoRelazioni" type="com.ejbSTL.Ent_TipoRelazioniHome" location="Ent_TipoRelazioni" />
<EJB:useBean id="remoteEnt_TipoRelazioni" type="com.ejbSTL.Ent_TipoRelazioni" scope="session">
    <EJB:createBean instance="<%=homeEnt_TipoRelazioni.create()%>" />
</EJB:useBean>

<%
  String codiceaccount="";
  String descaccount="";
  String optsel = "";
  int Code_Relazione = Integer.parseInt(request.getParameter("TipoRelazione")); 
  String strCodeAccount = Misc.nh(request.getParameter("strCodeAccount")); 
  String strCancella = Misc.nh(request.getParameter("Del")); 
  String strDescTipoRelazione = Misc.nh(request.getParameter("DescTipoRelazione")); 
  String strRisposta = "";
  
  if ( strCancella.equals("1") ) {
     String strCodeGruppo = Misc.nh(request.getParameter("strCodeGruppo")); 
     String strCodeAccountEl = Misc.nh(request.getParameter("Account"));

     //Cancellazione dell'account dal Gruppo
     int intRisposta = remoteEnt_TipoRelazioni.eliminaAccountDalGruppo(strCodeAccountEl,strCodeGruppo, Code_Relazione);
  }

  if ( !strCodeAccount.equals("") ) {
    String strCodeGruppo = Misc.nh(request.getParameter("strCodeGruppo")); 
    //inserisci il codice account
    String strAccountPadre = Misc.nh(request.getParameter("accountPadre"));
    int intRisposta = remoteEnt_TipoRelazioni.inserisciAccountInGruppo(strCodeAccount,strCodeGruppo, Code_Relazione, "01/01/1980", "31/12/2030", strAccountPadre);
    if( intRisposta == 0 ){
      strRisposta = "Data Inizio Validità dell'account selezionato non è valida. Si consiglia l'utilizzo di un nuovo Gruppo Tariffario";
    }
    strCodeAccount = "";
  }

  Vector vctTipoRelazioni = remoteEnt_TipoRelazioni.getRelazioni();

  boolean EnableUpd = true;
  boolean EnableDel = true;
  Vector QueryResult=(Vector)pageContext.getAttribute("buttons");

  SecurityInfoTransf appo = (SecurityInfoTransf)QueryResult.elementAt(0);

  if(appo.getCode_op_exec().equals("FITTIZIO")){
    EnableUpd = false;
    EnableDel = false;
  }
  
  String URLParam = "?TipoRelazione=" + Code_Relazione + "&DescTipoRelazione=" +  strDescTipoRelazione;
  
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title>
Visualizzazione Gruppi
</title>
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>validateFunction.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>
</head>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  function ONCHIUDI(){
    window.close();	
  }

  function ONCREAGRUPPO(){
    var URL  = 'crea_gruppo.jsp';
    var URL_Param = '?Code_Relazione=<%=Code_Relazione%>';
    frmDati.action = URL + URL_Param ;
    frmDati.submit();
  }

  function ChangeSel(optrif,codiceaccount,indice)
  {
    frmDati.optSel.value = optrif;
    frmDati.CodAccountSel.value=codiceaccount;
  }

 function eliminaAccount() {
    var URL;
    var UrlParam;
//    alert ('frmDati.CodAccountSel.value');
//    alert (frmDati.CodAccountSel.value);
//    alert ('frmDati.optSel.value');
//    alert (frmDati.optSel.value);
    if ( '' == frmDati.optSel.value ) {
      alert('Occorre selezionare un elemento da eliminare dal Gruppo');
      return;
    }
    UrlParam = '?Del=1' + '&TipoRelazione=<%=Code_Relazione%>' + '&strCodeGruppo=' + frmDati.optSel.value  + '&Account=' + frmDati.CodAccountSel.value ;
    URL = 'visualizza_gruppi.jsp';
    document.frmDati.action = URL + UrlParam;
    document.frmDati.submit();
 }

  function selezionaAccount(gruppo,accountPadre) {
			var URL = '';
      //alert("gruppo ["+gruppo+"]");
      //alert("accountPadre ["+accountPadre+"]");
      frmDati.accountPadre.value = accountPadre;
      URL='visualizza_account.jsp' + '?strCodeGruppo=' + gruppo;
      openCentral(URL,'Account','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
//      document.frmDati.submit();
  }
</SCRIPT>
<body  onfocus=" ControllaFinestra()" onmouseover=" ControllaFinestra()">
    <FORM name="frmDati" id="frmDati" action="" method="post">
    <input type="hidden" name="strCodeAccount" value="">
    <input type="hidden" name="strCodeGruppo" value="">
    <input type="hidden" name="accountPadre" value="">
    <input type="hidden" name="msg" value="<%=strRisposta%>">

		<input type=hidden name="CodAccountSel" value="<%=codiceaccount%>">
		<input type=hidden name="DescAccountSel" value="<%=descaccount%>">
 		<input type=hidden name="optSel" value="<%=optsel%>">
    </FORM>
    <TABLE align="center" width="95%" border="0" cellspacing="0" cellpadding="0" >
      <TR height="35">
        <TD>
          <TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
            <TR>
              <TD align="left">
                <IMG alt="" src="../images/GruppiTariffari.gif" border="0">
              </TD>
              <TD align="right" class="black" nowrap >
                Tipo Relazioni : <SELECT class="text" id="cboTipoRelazione" onchange="location.replace('visualizza_gruppi.jsp?TipoRelazione=' + this.value)">
                <%
                //Caricamento combo relazioni in base al parametro della querystring
                DB_TipoRelazioni lcls_Relazioni = null;
                for (int i = 0;i < vctTipoRelazioni.size();i++){
                  lcls_Relazioni = (DB_TipoRelazioni)vctTipoRelazioni.get(i);
                  %><OPTION value="<%=lcls_Relazioni.getCODE_TIPO_RELAZIONE()%>"><%=lcls_Relazioni.getDESC_TIPO_RELAZIONE()%></OPTION><%
                }%>
                </SELECT>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
      <TR height="20">
        <TD>
          <TABLE width="100%" border="1" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>" rules="rows" frame="box" bordercolor="<%=StaticContext.bgColorHeader%>" height="100%">
            <TR align="center">
              <TD class="white" >
                TIPI DI RELAZIONI TRA ACCOUNT
              </TD>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>"  align="center" width="9%">
                <IMG alt="immagine " src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28">
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
<!-------- inizio caricamento -----------!-->
      <TR> 
  <TD>
      <TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0" name="TabGruppi" id="TabGruppi" >
      <TR height="40">

     <TD>
        <TABLE width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
           <TR>
              <TD class="white" colspan="2">
                 <TABLE width="100%" border="0" cellspacing="0" cellpadding="1" align="center">
                   <TR>
                      <TD>
              <TABLE width="100%" border="0" cellspacing="1" cellpadding="0" name="Tab1" id="Tab1">
              <TR class="rowHeader" align="center" height="20">
              <TD width="15">&nbsp;</TD>
              <TD>Nome Gruppo</TD>
              <TD>Id Gruppo</TD>
              <TD>Tariffa</TD>
              <%--<TD>Data Inizio</TD>
              <TD>Data Fine</TD>--%>
              </TR>
              <% String curClassRow = ""; 
                 String curSubClassRow = ""; 
                 Vector vctGruppi = remoteEnt_TipoRelazioni.getGruppiAccount(Code_Relazione);
               for ( int i = 0 ; i < vctGruppi.size() ; i++ ) { 
                  curClassRow = curClassRow.equals("row1") ? "row2" : "row1";
                  DB_AccountNew recGruppo = (DB_AccountNew) vctGruppi.get(i);
                  String accountPadre = recGruppo.getCODE_ACCOUNT();
                  %>
                  <TR class="<%=curClassRow%>" align="center" height="20">
                    <TD class="textB" align="center" onclick="Expand('GRUPPO+<%=recGruppo.getCODE_ACCOUNT()%>',this)" style="CURSOR: hand">+</TD>
                    <TD align="left"> <%=recGruppo.getDESC_ACCOUNT()%></TD> 
                    <TD align="left"> <%=recGruppo.getCODE_ACCOUNT()%></TD>
                    <TD align="center" nowrap> <%=recGruppo.getDESC_TIPO_FLAG_PROVVISORIA()%></TD>
                  </TR>
                  <TR bgcolor="white" align="center" name="GRUPPO+<%=recGruppo.getCODE_ACCOUNT()%>" id="GRUPPO+<%=recGruppo.getCODE_ACCOUNT()%>" style="DISPLAY: none">
                    <TD colspan="6">
                      <TABLE width="100%" border="0" cellspacing="2" cellpadding="0">
                        <TR>
                          <TD width="15" valign="top"> <IMG alt="immagine" src="<%=StaticContext.PH_COMMON_IMAGES%>l.gif"> </TD>
                          <TD class="text" align="left">
                            <TABLE width="70%" border="0" cellspacing="1" cellpadding="1">
                              <TR align="center">
                                 <TD> </TD>
                                 <TD class="rowHeader" width="50%" align="center" nowrap> Descrizione Account </TD>
                                 <TD class="rowHeader" width="10%" align="center" nowrap> Codice Account </TD>
                                 <TD class="rowHeader" width="20%" align="center" nowrap> Data Inizio </TD>
                                 <TD class="rowHeader" width="20%" align="center" nowrap> Data Fine </TD>
                              </TR>
                              <%
                                Vector vctAccountGruppo = remoteEnt_TipoRelazioni.getAccountXGruppiAccount(Code_Relazione,Integer.parseInt(recGruppo.getCODE_ACCOUNT()));
                                for ( int a = 0; a < vctAccountGruppo.size(); a++ ) {
                                  curSubClassRow = curSubClassRow.equals("row1") ? "row2" : "row1";
                                  DB_AccountNew recAccount = (DB_AccountNew) vctAccountGruppo.get(a);
                                  if(a == 0){
                                    accountPadre = recAccount.getCODE_ACCOUNT();
                                  }
                                %>
                                <TR class="<%=curSubClassRow%>" align="center" height="20">
                                  <TD>
                                  <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio' name='SelAccount<%=i%>' value='<%=recAccount.getDESC_ACCOUNT()%>' onclick=ChangeSel('<%=recGruppo.getCODE_ACCOUNT()%>','<%=recAccount.getCODE_ACCOUNT()%>','<%=a%>')>
                                  </TD>
                                  <TD align="left" align="right"> <%=recAccount.getDESC_ACCOUNT()%></TD> 
                                  <TD align="right" align="right"> <%=recAccount.getCODE_ACCOUNT()%></TD> 
                                  <TD align="right" align="right"> <%=recAccount.getDATA_INIZIO_VALID()%></TD> 
                                  <TD align="right" align="right"> <%=recAccount.getDATA_FINE_VALID()%></TD>
                                </TR>
                              <%}%>
                              <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width="2%">
                              <% if (recGruppo.getTIPO_FLAG_PROVVISORIA().equals("N") ||
                                     recGruppo.getTIPO_FLAG_PROVVISORIA().equals("")){%>
                              <TD class="rowHeader" width="33%" align="left" nowrap valign="top" onclick="selezionaAccount(<%=recGruppo.getCODE_ACCOUNT()%>,<%=accountPadre%>)" style="CURSOR: hand"> <IMG alt="immagine" src="<%=StaticContext.PH_COMMON_IMAGES%>aggiungi.gif"> Aggiungi Account </TD>
                              <TD class="rowHeader" width="33%" align="left" nowrap valign="top" onclick="eliminaAccount(<%=recGruppo.getCODE_ACCOUNT()%>)" style="CURSOR: hand"> <IMG alt="immagine" src="<%=StaticContext.PH_COMMON_IMAGES%>elimina.gif"> Elimina Account </TD>
                              <%}%>
                            </TABLE>
                          </TD>
                        </TR>
                      </TABLE>
                    </TD>
                  </TR>
               <%}%>

      </TR>
      </table> </td> </tr>
      <!-------- fine caricamento -----------!-->
      <TR height="3">
        <TD></TD>
      </TR>
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
    </TABLE>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  cboTipoRelazione.value = '<%=Code_Relazione%>';
  if(frmDati.msg.value != ""){
    alert(frmDati.msg.value);
  }
</SCRIPT>
</body>
</html>
