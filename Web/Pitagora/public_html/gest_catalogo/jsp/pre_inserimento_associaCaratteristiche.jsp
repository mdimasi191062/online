<!-- import delle librerie necessarie -->
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
<%@ page import="com.utl.*" %>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"pre_inserimento_associaCaratteristiche.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto -->
<EJB:useHome id="home" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="remote_EntCatalogo" type="com.ejbSTL.Ent_Catalogo" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
  //PARAMETRI DI INPUT DELLA PAGINA+++++++++++++++++++++++++++++++++
  String parametri     = Misc.nh(request.getParameter("elementi"));
  String tipo          = Misc.nh(request.getParameter("tipo"));  
  String prodottoRif   = Misc.nh(request.getParameter("ProdottoRif"));
  String componenteRif = Misc.nh(request.getParameter("ComponenteRif"));

%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<script src="<%=StaticContext.PH_COMMON_JS%>XML.js" type="text/javascript"></script>
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
<script src="<%=StaticContext.PH_TARIFFE_JS%>ListaTariffeSp.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<TITLE>Associazione Caratteristiche</TITLE>

<SCRIPT LANGUAGE='Javascript'>

var objWindows  = null;
var objForm = null;


function Initialize() {
  objForm = document.frmDati;
}

function ONSALVA()
{
  if(controllaCampiForm()){
    /*document.frmDati.action = 'pre_inserimento_associaCaratteristiche.jsp';
    document.frmDati.submit();*/
    salvaCaratteristiche();
  }else{
    alert('Selezionare tutte le caratteristiche.');
  }
}

function controllaCampiForm(){
  var elementi = document.frmDati.elementi.value;
  var elementiToken = elementi.split("|");
  var check = false;
  var parametriRitorno = '';
  var col = false;
  var trasm = false;
  
  for(var i = 0;i<elementiToken.length;i++){

    check=false;
    separatore = '$';
    separatoreRitorno = '|';
    elementoConcatenato = '';
    colocato = 'chkColocato_'+elementiToken[i];
    trasmissivo = 'chkFlusso_'+elementiToken[i];
    combo = false;
    col = false;
    trasm = false;
    paramRitorno = false;
    
    if(elementiToken[i] != '' && elementiToken[i] != null){
      /* CONCATENO IL NOME ELEMENTO */
      elementoConcatenato = elementiToken[i] + separatore;

      for(j=0; j<document.forms.length; j++) {
        for(k=0; k<document.forms[j].elements.length; k++) {
          /* COMBO CARATTERISTICA */
          if ( elementiToken[i] == document.forms[j].elements[k].name ) {
            if (document.forms[j].elements[k].value != '' &&
                document.forms[j].elements[k].value != null &&
                document.forms[j].elements[k].value != undefined)
            {
              /*aggiungo la caratteristica*/
              elementoConcatenato = elementoConcatenato + document.forms[j].elements[k].value + separatore;
              combo = true;
            }else{
              check=true;
              return false;
            }
          }

          /* COLOCATO */
          if ( colocato == document.forms[j].elements[k].name ) {
            elementoConcatenato = elementoConcatenato + document.forms[j].elements[k].checked + separatore;
            col = true;
          }

          /* TRASMISSIVO */
          if ( trasmissivo == document.forms[j].elements[k].name ) {
            elementoConcatenato = elementoConcatenato + document.forms[j].elements[k].checked + separatore;
            trasm = true;
          }

          /* PARAMETRI RITORNO */
          if(elementoConcatenato != '' && combo && col && trasm && paramRitorno == false){
            if (parametriRitorno == ''){
              parametriRitorno = elementoConcatenato + separatoreRitorno;
            }else{
              parametriRitorno = parametriRitorno + elementoConcatenato + separatoreRitorno;
            }
            paramRitorno = true;
          }
        }
      }
    }
  }
  document.frmDati.parametriRitorno.value = parametriRitorno;
  return true;
}


function CancelMe()
{
  self.close();
  return false;
}

function ONAGGIUNGI() {
  var URL = '';
  URL='pre_inserimento_caratteristiche.jsp';
  openCentral(URL,'Caratteristiche','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',900,500);
}

function ONCHIUDI (){
  window.close();
}

function ONRITORNO(messaggio){
  var o = new Object();
  o.ritorno = messaggio;
  window.returnValue = o;
  window.close();
}

function salvaCaratteristiche()
{
  carica = function(dati){ONRITORNO(dati[0].messaggio)};
  /*errore = function(dati){gestisciMessaggio(dati[0].messaggio);};*/
  errore = function(dati){ONRITORNO(dati[0].messaggio);};  
  asyncFunz=  function(){ handler_generico(http,carica,errore);};
  chiamaRichiesta('elementi='+document.frmDati.parametriRitorno.value+'&tipo='+document.frmDati.tipo.value+'&ComponenteRif='+document.frmDati.componenteRif.value+'&ProdottoRif='+document.frmDati.prodottoRif.value,'salvaCaratteristicheCatalogo',asyncFunz);
}

</SCRIPT>

</HEAD>
<BODY>

<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div name="orologio" id="orologio"  style="visibility:hidden;display:none">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div name="maschera" id="maschera">
<form name="frmDati" method="post" action="">
<input type="hidden" name="elementi" id="elementi" value="<%=parametri%>">
<input type="hidden" name="tipo" id="tipo" value="<%=tipo%>">
<input type="hidden" name="prodottoRif" id="prodottoRif" value="<%=prodottoRif%>">
<input type="hidden" name="componenteRif" id="componenteRif" value="<%=componenteRif%>">
<input type="hidden" name="elementiConcatenati" id="elementiConcatenati" value="">
<input type="hidden" name="parametriRitorno" id="parametriRitorno" value="">

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/catalogo.gif" alt="" border="0"></td>
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
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Elementi privi associazione caratteristiche</td>
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
  
</table>

<table align=center width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
          <td colspan='6' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                          <tr>
                            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Associa Caratteristiche</td>
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td colspan='6' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                          </tr>
                          <%

                          int i=0;
                          int j=0;
                          String descrizioneElemento="";
                          String descaccount="";
                          String bgcolor="";
                          String elemento = "";
                          
                          if(tipo.equals("PRODOTTO"))
                            elemento = "Prodotto";
                          else if(tipo.equals("COMPONENTE"))
                            elemento = "Componente";
                          else
                            elemento = "Prestazione";
                          %>
                          <tr>
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="textB" nowrap>&nbsp;</td>
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" nowrap><%=elemento%>&nbsp;</td>
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" nowrap>Caratteristica&nbsp;</td>                            
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" nowrap>Colocata&nbsp;</td>
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" nowrap>Trasmissiva&nbsp;</td>
                          </tr>

                          <%
                          String strSingoloEmento = "";
                          StringTokenizer strElemento = new StringTokenizer( parametri, "|" );                          
                          bgcolor=StaticContext.bgColorRigaPariTabella;
                          do {
                            strSingoloEmento = strElemento.nextToken();
                            descrizioneElemento = "";
                            System.out.println("strSingoloElemento ["+strSingoloEmento+"]");
                            /* determina descrizione elemento */
                            if(tipo.equals("PRODOTTO"))
                              descrizioneElemento = remote_EntCatalogo.getDescProdotto(strSingoloEmento);
                            else if(tipo.equals("COMPONENTE"))
                              descrizioneElemento = remote_EntCatalogo.getDescComponente(strSingoloEmento);
                            else
                              descrizioneElemento = remote_EntCatalogo.getDescPrestazione(strSingoloEmento);
                            %>

                            <tr>
                              <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width="2%">&nbsp;</td>
                              <td bgcolor='<%=bgcolor%>' class='text'><%=descrizioneElemento%>&nbsp;</td>
                              <td bgcolor='<%=bgcolor%>'>
                                <select class="text" name="<%=strSingoloEmento%>">
                                  <option></option>
                                  <%  
                                  DB_PreCaratteristiche myelement=new DB_PreCaratteristiche();
                                  
                                  Vector caratteristicheVector = remote_EntCatalogo.getPreCaratteristiche();
                                  for(int y=0; y<caratteristicheVector.size(); y++)
                                  {
                                    myelement = (DB_PreCaratteristiche)caratteristicheVector.elementAt(y);  
                                    %>
                                    <option value="<%=myelement.getCODE_CARATT()%>"><%=myelement.getDESC_CARATT()%></option>
                                    <%
                                  }
                                  %>
                                </select>
                              </td>
                              <td bgcolor='<%=bgcolor%>'>
                                <input type="checkbox" value="Y" name="chkFlusso_<%=strSingoloEmento%>">&nbsp;
                              </td>                            
                              <td bgcolor='<%=bgcolor%>'>
                                <input type="checkbox" value="Y" name="chkColocato_<%=strSingoloEmento%>">&nbsp;
                              </td>
                            </tr>
                            <tr>
                              <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                            </tr>
                            



                            <%
                            if (bgcolor.equals(StaticContext.bgColorRigaPariTabella))
                              bgcolor=StaticContext.bgColorRigaDispariTabella;
                            else
                              bgcolor=StaticContext.bgColorRigaPariTabella;
                              
                          } while ( strElemento.hasMoreElements() ); 

                          %>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td colspan='4' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
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
  <tr>
    <td>
	    <table width="80%" border="1" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
	      </tr>
	    </table>
    </td>
  </tr>
</table>

<script>
var http=getHTTPObject();
</script>

</form>
</div>

</BODY>
</HTML>
