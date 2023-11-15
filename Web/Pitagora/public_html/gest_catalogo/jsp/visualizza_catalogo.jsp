<!-- import delle librerie necessarie -->
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

<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"visualizza_catalogo.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Catalogo" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="remoteEnt_Catalogo" type="com.ejbSTL.Ent_Catalogo" scope="session">
    <EJB:createBean instance="<%=homeEnt_Catalogo.create()%>" />
</EJB:useBean>
<%
   DataFormat dataOdierna = new DataFormat();
   String strCodeComponente = remoteEnt_Catalogo.getCodiceComponente();
%>
<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>
</TITLE>
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>XML.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">

  var objXmlPreOff = null;
  var objXmlPreServ = null;
  var objXmlPreCaratt = null;
  var valCboPreOfferte = '';
  var valCboPreServizi = '';

  var objWindows = null;

  function Initialize() {

    objXmlPreServ    = CreaObjXML();
    objXmlPreOff     = CreaObjXML();
    objXmlPreCaratt  = CreaObjXML();

    objXmlPreServ.loadXML('<MAIN><%=remoteEnt_Catalogo.getPreServiziXml()%></MAIN>');
    objXmlPreOff.loadXML ('<MAIN><%=remoteEnt_Catalogo.getPreOfferteXml()%></MAIN>');

    CaricaComboDaXML(frmDati.cboPreServizi,objXmlPreServ.documentElement.selectNodes('SERVIZIO'));

	}

  function change_cboPreServizi(){                                                                                                                                               
    if (valCboPreServizi!=frmDati.cboPreServizi.value){

      valCboPreServizi=frmDati.cboPreServizi.value;

      if(frmDati.cboPreServizi.value!=''){
        var objNodes = objXmlPreOff.documentElement.selectNodes('OFFERTA[SERVIZIO=' + frmDati.cboPreServizi.value + ']');
        CaricaComboDaXML(frmDati.cboPreOfferte,objNodes);
      }
      else{
        ClearCombo(frmDati.cboPreOfferte);
      }
      valCboPreOfferte = '';
    }
  }

  function change_cboPreOfferte(){

      if (valCboPreOfferte!=frmDati.cboPreOfferte.value){
        valCboPreOfferte=frmDati.cboPreOfferte.value;
      }


//      for(j=0; j<document.forms.length; j++) {
//        for(k=0; k<document.forms[j].elements.length; k++) {
//            alert('j['+j+']['+k+']');
//            alert(document.forms[j].elements[k].name);
//        }
//      }

//      alert(valCboPreServizi);
//      alert(valCboPreOfferte);

      if (( valCboPreServizi == 1 ) && ( valCboPreOfferte == 1 ) ){
        document.all('CAT-SERV1OFF1PROD1').style.display='';
        document.all('CAT-SERV1OFF1PROD2').style.display='';
        document.all('CAT-SERV1OFF1PROD3').style.display='';
        document.all('CAT-SERV1OFF1PROD4').style.display='';
        document.all('CAT-SERV1OFF1PROD9').style.display='';
        document.all('CAT-SERV1OFF1PROD10').style.display='';
        document.all('CAT-SERV1OFF1PROD11').style.display='';
        document.all('CAT-SERV1OFF1PROD12').style.display='';
        document.all('CAT-SERV1OFF1PROD16').style.display='';
        document.all('CAT-SERV1OFF1PROD17').style.display='';
        document.all('CAT-SERV1OFF1PROD54').style.display='';
        }
      else {
        document.all('CAT-SERV1OFF1PROD1').style.display='none';
        document.all('CAT-SERV1OFF1PROD2').style.display='none';
        document.all('CAT-SERV1OFF1PROD3').style.display='none';
        document.all('CAT-SERV1OFF1PROD4').style.display='none';
        document.all('CAT-SERV1OFF1PROD9').style.display='none';
        document.all('CAT-SERV1OFF1PROD10').style.display='none';
        document.all('CAT-SERV1OFF1PROD11').style.display='none';
        document.all('CAT-SERV1OFF1PROD12').style.display='none';
        document.all('CAT-SERV1OFF1PROD16').style.display='none';
        document.all('CAT-SERV1OFF1PROD17').style.display='none';
        document.all('CAT-SERV1OFF1PROD54').style.display='none';
      }
  }

</script>

</HEAD>
<BODY onload="Initialize();" onfocus="ControllaFinestra()" onmouseover=" ControllaFinestra()">

<form name="frmDati" method="post" action="">
<TABLE align="center" width="95%" border="0" cellspacing="0" cellpadding="0" >
      <TR height="35">
        <TD>
          <TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
            <TR>
              <TD align="left">
                <IMG alt="" src="../images/catalogo.gif" border="0">
              </TD>
            </TR>
          </table>
        </td>
      </tr>
      <TR height="20">
        <TD>
          <TABLE width="100%" border="1" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>" rules="rows" frame="box" bordercolor="<%=StaticContext.bgColorHeader%>" height="100%">
            <TR align="center">
              <TD class="white" >
                VISUALIZZAZIONE CATALOGO
              </TD>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>"  align="center" width="9%">
                <IMG alt="immagine " src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28">
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
<tr height="35">
  <td>
    <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
      <tr>
        <td>
         <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
          <tr>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"> Servizio / Offerta </td>
            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
          </tr>
         </table>
        </td>
      </tr>
    </table>
  </td>
</tr>      
<tr>
  <td>
    <table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
      <tr>
        <td width="25%" class="textB" align="right">Servizio&nbsp;&nbsp;</td>
        <td >
          <select class="text" title="Servizi" name="cboPreServizi" onchange="change_cboPreServizi();" >
             <option class="text"  value="">[Seleziona Servizio]</option>
          </select>
        </td>
      </tr>
      <tr>
        <td width="25%" class="textB" align="right">Offerta&nbsp;&nbsp;</td>
        <td >
          <select class="text" title="Offerte" name="cboPreOfferte" onchange="change_cboPreOfferte();" >
             <option class="text"  value="">[Seleziona Offerte]</option>
          </select>
        </td>
      </tr>
    </table>
  </td>
</tr>
<tr>
  <td>
    <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
      <tr>
        <td>
         <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
          <tr>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Catalogo</td>
            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
          </tr>
         </table>
        </td>
      </tr>
    </table>
  </td>
</tr>
<tr>
  <td>
    <table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
         <TR class="rowHeader" align="center" height="20">
             <TD width="15">&nbsp;</TD>
             <TD align="left">Descrizione Prodotto</TD>
          </TR>
      <TR>
          <TD colspan="2">
         <% String curClassRow = ""; 
            String curSubClassRow = ""; 
            Vector vctPreCatalogo = remoteEnt_Catalogo.getPreCatalogo();
               for ( int i = 0 ; i + 2 < vctPreCatalogo.size() ; i++ ) { 
                  curClassRow = curClassRow.equals("row1") ? "row2" : "row1";
                  DB_PreCatalogo recPreCatalogo = (DB_PreCatalogo) vctPreCatalogo.get(i);
                  DB_PreCatalogo recPreCatalogo2 = (DB_PreCatalogo) vctPreCatalogo.get(i+1);
                  %>
                  <TABLE width="100%" border="0" cellspacing="1" cellpadding="0" 
                    name="CAT-SERV<%=recPreCatalogo.getCODE_SERVIZIO()%>OFF<%=recPreCatalogo.getCODE_OFFERTA()%>PROD<%=recPreCatalogo.getCODE_PRODOTTO()%>" 
                      id="CAT-SERV<%=recPreCatalogo.getCODE_SERVIZIO()%>OFF<%=recPreCatalogo.getCODE_OFFERTA()%>PROD<%=recPreCatalogo.getCODE_PRODOTTO()%>"
                     style="display:none">
                      <TR class="<%=curClassRow%>" align="center" height="20">
                        <TD class="textB" align="center" onclick="Expand('CAT+SERV<%=recPreCatalogo.getCODE_SERVIZIO()%>OFF<%=recPreCatalogo.getCODE_OFFERTA()%>PROD<%=recPreCatalogo.getCODE_PRODOTTO()%>',this)" style="CURSOR: hand">+</TD>
                        <TD align="left"> <%=recPreCatalogo.getDESC_PRODOTTO()%> </TD>
                      </TR>
                      <TR bgcolor="white" align="center" 
                        name="CAT+SERV<%=recPreCatalogo.getCODE_SERVIZIO()%>OFF<%=recPreCatalogo.getCODE_OFFERTA()%>PROD<%=recPreCatalogo.getCODE_PRODOTTO()%>" 
                          id="CAT+SERV<%=recPreCatalogo.getCODE_SERVIZIO()%>OFF<%=recPreCatalogo.getCODE_OFFERTA()%>PROD<%=recPreCatalogo.getCODE_PRODOTTO()%>"
                       style="display:none">
                          <TD colspan="2">
                            <TABLE width="100%" border="0" cellspacing="2" cellpadding="0">
                              <TR>
                                  <TD width="15" valign="top">
                                     <IMG alt="immagine" src="../../common/images/body/l.gif">
                                  </TD>
                                  <TD class="text" align="left">
                                     <TABLE width="70%" border="0" cellspacing="1" cellpadding="1">
                                        <TR align="center">
                                            <TD class="rowHeader" width="50%" align="center" nowrap>
                                               Descrizione Componente
                                            </TD>
                                            <TD class="rowHeader" width="50%" align="center" nowrap>
                                               Descrizione Prestazione
                                            </TD>
                                        </TR>
                                        <TR class="row2" align="center">
                                           <TD align="left" nowrap>
                                           <%=recPreCatalogo.getDESC_COMPONENTE()%>
                                           </TD>
                                           <TD align="left" nowrap>
                                           <%=recPreCatalogo.getDESC_PRESTAZIONE()%>
                                           </TD>
                                        </TR>
                                        <% for ( int a = i + 1; ( i + 1 < vctPreCatalogo.size()) && (a + 1 < vctPreCatalogo.size()) && (recPreCatalogo2.getCODE_PRODOTTO().equals(recPreCatalogo.getCODE_PRODOTTO() )); a++) {  %>
                                            <TR class="row2" align="center">
                                               <TD align="left" nowrap>
                                               <%=recPreCatalogo2.getDESC_COMPONENTE()%>
                                               </TD>
                                               <TD align="left" nowrap>
                                               <%=recPreCatalogo2.getDESC_PRESTAZIONE()%>
                                               </TD>
                                            </TR>
                                        <% i = i + 1;
                                           if ( a + 1 < vctPreCatalogo.size()) recPreCatalogo2 = (DB_PreCatalogo) vctPreCatalogo.get(a);
                                        }%>
                                     </TABLE>
                                  </TD>
                              </TR>
                            </TABLE>
                          </TD>
                       </TR>
                  </table>
              <%}%>
<!--          
            <TABLE width="100%" border="0" cellspacing="1" cellpadding="0" name="CAT-SERV1OFF1PROD1" id="CAT-SERV1OFF1PROD1"  style="display:none">
              <TR class="rowHeader" align="center" height="20">
                <TD width="15">&nbsp;</TD>
                <TD align="left">Descrizione Prodotto</TD>
              </TR>
              <TR class="row1" align="center" height="20">
                <TD class="textB" align="center" onclick="Expand('CAT+SERV1OFF1PROD1COMP2PRAG0+1850-1',this)" style="CURSOR: hand">+</TD>
                <TD align="left">2 Mbits </TD>
              </TR>
              <TR bgcolor="white" align="center" name="CAT+SERV1OFF1PROD1COMP2PRAG0+1850-1" id="CAT+SERV1OFF1PROD1COMP2PRAG0+1850-1" style="DISPLAY: none">
                  <TD colspan="2">
                      <TABLE width="100%" border="0" cellspacing="2" cellpadding="0">
                          <TR>
                              <TD width="15" valign="top">
                                 <IMG alt="immagine" src="../../common/images/body/l.gif">
                              </TD>
                              <TD class="text" align="left">
                                 <TABLE width="70%" border="0" cellspacing="1" cellpadding="1">
                                    <TR align="center">
                                        <TD class="rowHeader" width="50%" align="center" nowrap>
                                           Descrizione Componente
                                        </TD>
                                    </TR>
                                    <TR class="row2" align="center">
                                       <TD align="left" nowrap>
                                       FLUSSO 2 Mbit/s
                                       </TD>
                                    </TR>
                                    <TR class="row1" align="center">
                                       <TD align="left" nowrap>
                                       TERMINAZIONE 2 Mbit/s
                                       </TD>
                                    </TR>
                                    <TR class="row2" align="center">
                                       <TD align="left" nowrap>
                                       TERMINAZIONE 2Mbit/s Colocata
                                       </TD>
                                    </TR>
                                    <TR class="row1" align="center">
                                       <TD align="left" nowrap>
                                       TERMINAZIONE 2Mbit/s Pianificata
                                       </TD>
                                    </TR>
                                    <TR class="row2" align="center">
                                       <TD align="left" nowrap>
                                       TERMINAZIONE 2 Mbit/s OLO-CLIENTE FINALE
                                       </TD>
                                    </TR>
                                 </TABLE>
                              </TD>
                          </TR>
                      </TABLE>
                  </TD>
              </TR>
            </TABLE>
            !-->
          </td>
        </TR>
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
</form>
</BODY>
</HTML>