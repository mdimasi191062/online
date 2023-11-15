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
<%=StaticMessages.getMessage(3006,"pre_inserimento_AssOffServ.jsp")%>
</logtag:logData>

<EJB:useHome id="home" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="assOffServ" type="com.ejbSTL.Ent_Catalogo" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<% //Controllo la fase di inserimento
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  String esito = "";
  String messaggio = "";
  DB_Offerta offServ;
  int operazione = 0;
  if(request.getParameter("operazione") == null)
     operazione = 0;
  else
    operazione = Integer.parseInt(request.getParameter("operazione"));

  if(operazione != 0){
    String codice_servizio = Misc.nh(request.getParameter("PreServizi"));
    String codice_offerta = Misc.nh(request.getParameter("PreOfferte"));
    String dataIni = Misc.nh(request.getParameter("DataIni"));
    String dataFine = Misc.nh(request.getParameter("DataFine"));
    String app_fre_cicli_cs_STR = Misc.nh(request.getParameter("FreCicliCS"));
    
    String strCodeOff = Misc.nh(request.getParameter("strCodeOff"));
    String strCodeServ = Misc.nh(request.getParameter("strCodeServ"));

    int app_fre_cicli_cs = 0;
    if(app_fre_cicli_cs_STR.equals("")){
      app_fre_cicli_cs = 0;
    }else{
      app_fre_cicli_cs = Integer.parseInt(request.getParameter("FreCicliCS"));
    }
    offServ = new DB_Offerta();
    offServ.setCODE_SERVIZIO(codice_servizio);
    offServ.setCODE_OFFERTA(codice_offerta);
    offServ.setDATA_INIZIO_VALID(dataIni);
    offServ.setDATA_FINE_VALID(dataFine);
    
    //INSERIMENTO
    if (operazione == 1){
      esito = assOffServ.insAssociazione(offServ,app_fre_cicli_cs);
      if(esito.equals("")){
        messaggio = "Inserimento nuova Associativa Offerta/Servizio effettuata correttamente.";
      }else{
        messaggio = esito;
      }
    }
    //AGGIORNAMENTO
    else if (operazione == 2){
      esito = assOffServ.aggiorna_associazione(offServ,app_fre_cicli_cs);
      if(esito.equals("")){
        messaggio = "Aggiornamento Associativa Offerta/Servizio effettuata correttamente.";
      }else{
        messaggio = esito;
      }
    }
    //CANCELLAZIONE
    else if (operazione == 3){
      esito = assOffServ.delAssociazione(strCodeOff,strCodeServ);
      if(esito.equals("")){
        messaggio = "Cancellazione Associativa Offerta/Servizio effettuata correttamente.";
      }else{
        messaggio = esito;
      }
    }
  }

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title>
Associazioni Offerte/Servizi
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
function ONAGGIUNGI(){
  document.frmDati.action = 'pre_inserimento_AssOffServIns.jsp';
  document.frmDati.submit();
}

function ONAGGIORNA(){
  document.frmDati.action = 'pre_aggiornamento_AssOffServ.jsp';
  document.frmDati.submit();
}

function setCodeHidden(obj){

  var app = 'tipo_sistema_mittente_'+obj.value;
  for(j=0; j<document.forms.length; j++) {
    for(k=0; k<document.forms[j].elements.length; k++) {
      if ( app == document.forms[j].elements[k].name ) {
        var app_value = document.forms[j].elements[k].value;
        if (app_value != '' && app_value != null && app_value != 'null'){
          Disable(document.frmDati.AGGIORNA);
          Disable(document.frmDati.CANCELLA);
          break;
        }else{
          Enable(document.frmDati.AGGIORNA);
          Enable(document.frmDati.CANCELLA);
          break;
        }
      }
    }
  }
  document.frmDati.strCodeOffServ.value=obj.value;
}

function ONCANCELLA() {
  if(confirm("Attenzione!!! Si vuole procedere con l'eleminazione dell'associativa Servizio/Offerta?")){
    var app = document.frmDati.strCodeOffServ.value;
    var tokensInizio = app.split("|");
    var code_servizio   = tokensInizio[0];
    var code_offerta   = tokensInizio[1];

    document.frmDati.strCodeOff.value=code_offerta;
    document.frmDati.strCodeServ.value=code_servizio;
    
    document.frmDati.operazione.value = '3';
    document.frmDati.action = 'pre_inserimento_AssOffServ.jsp';
    document.frmDati.submit();
  }
}

</SCRIPT>

<BODY>
<FORM name="frmDati" id="frmDati" action="" method="post">
<input type="hidden" name="messaggio" id="messaggio" value="<%=messaggio%>">
<input type="hidden" name="strCodeOffServ" id="strCodeOffServ" value="">
<input type="hidden" name="strCodeOff" id="strCodeOff" value="">
<input type="hidden" name="strCodeServ" id="strCodeServ" value="">
<input type="hidden" name="operazione" id="operazione" value="">
  <TABLE align="center" width="95%" border="0" cellspacing="0" cellpadding="0" >
    <TR height="35">
      <TD>
        <TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
          <TR>
            <TD align="left">
              <IMG alt="" src="../images/catalogo.gif" border="0">
            </TD>
            <TD align="right" class="black" nowrap >&nbsp;</TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
      <TR height="20">
        <TD>
          <TABLE width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>" rules="rows" frame="box" bordercolor="<%=StaticContext.bgColorHeader%>" height="100%">
            <TR align="center">
              <TD class="white" >
                ASSOCIAZIONI OFFERTE/SERVIZI
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
                                <TD>Servizi</TD>
                              </TR>
                              <% 
                              String curClassRow = "";
                              String curSubClass_Row = "";
                              String curSubClassRow = "";
                              String curSubClassRow_new = "";
                              String app_servizio = "";
                              int finale = 0;
                              int giro = 0;
                              Vector vctServizi = assOffServ.getAssOffServ();
                              for ( int i = 0 ; i < vctServizi.size() ; i++ ) {

                                DB_CAT_off_x_serv recAssOffServ = (DB_CAT_off_x_serv) vctServizi.get(i);
                                curClassRow = curClassRow.equals("row1") ? "row2" : "row1";
                                
                              %>
                              <TR class="<%=curClassRow%>" align="center" height="20">
                                <TD class="textB" align="center" onclick="Expand('SERVIZIO+<%=recAssOffServ.getCODE_SERVIZIO()%>',this)" style="CURSOR: hand">+</TD>
                                <TD align="left"> <%=recAssOffServ.getDESC_SERVIZIO()%></TD>
                              </TR>
                              <TR bgcolor="white" align="center" name="SERVIZIO+<%=recAssOffServ.getCODE_SERVIZIO()%>" id="SERVIZIO+<%=recAssOffServ.getCODE_SERVIZIO()%>" style="DISPLAY: none">
                                <TD width="15" valign="top"> <IMG alt="immagine" src="<%=StaticContext.PH_COMMON_IMAGES%>l.gif"> </TD>
                                <TD class="text" align="left">
                                  <TABLE width="35%" border="0" cellspacing="1" cellpadding="1">
                                    <TR align="center">
                                      <TD class="rowHeader" width="45%" align="center" nowrap colspan="2"> Offerte Associate </TD>
                                    </TR>
                                    <%
                                    Vector vctOffServ = assOffServ.getAssOffServ_codiceServizio(recAssOffServ.getCODE_SERVIZIO());
                                    for ( int a = 0; a < vctOffServ.size(); a++ ) {
                                      //curSubClassRow = curSubClassRow.equals("row1") ? "row2" : "row1";
                                      DB_CAT_off_x_serv recAccount = (DB_CAT_off_x_serv) vctOffServ.get(a);

                                      if(recAccount.getTIPO_SISTEMA_MITTENTE() != null && recAccount.getTIPO_SISTEMA_MITTENTE().equals("S")){
                                         curSubClassRow = curSubClassRow.equals("row1") ? "row2" : "row1";
                                         curSubClass_Row = curSubClassRow;
                                        
                                      }else{
                                        curSubClassRow_new = curSubClassRow.equals("row1") ? "row2_new" :  "row1_new";
                                        curSubClassRow = curSubClassRow.equals("row1") ? "row2" :  "row1";  
                                        curSubClass_Row = curSubClassRow_new;
                                      }
                                    %>
                                    <%
                                    String codeOffServ = recAssOffServ.getCODE_SERVIZIO() +"|"+ recAccount.getCODE_OFFERTA();
                                    %>
                                    <TR class="<%=curSubClass_Row%>" align="center" height="20">
                                      <TD width="5%" align="center">
                                        <input type="radio" name="CodeOffServ" value="<%=codeOffServ%>" onClick="setCodeHidden(this);">
                                        <input type="hidden" name="tipo_sistema_mittente_<%=codeOffServ%>" value="<%=recAccount.getTIPO_SISTEMA_MITTENTE()%>">
                                      </TD>
                                      <TD width="95%" align="left"><%=recAccount.getDESC_OFFERTA()%></TD>
                                    </TR>
                                    <%}%>
                                  </TABLE>
                                </TD>
                              </TR>
                              <%}%>
                            </table> 
                          </td> 
                        </tr>
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
</FORM>
<script language="JavaScript">
if(document.frmDati.messaggio.value != "") {
  alert("<%=messaggio%>");
}

Disable(document.frmDati.AGGIORNA);
Disable(document.frmDati.CANCELLA);
  
</script>

</body>
</html>
