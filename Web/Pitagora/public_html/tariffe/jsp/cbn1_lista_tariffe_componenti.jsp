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
<%=StaticMessages.getMessage(3006,"cbn1_lista_tariffe_componenti.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Offerte" type="com.ejbSTL.Ent_OfferteHome" location="Ent_Offerte" />
<EJB:useBean id="remoteEnt_Offerte" type="com.ejbSTL.Ent_Offerte" scope="session">
    <EJB:createBean instance="<%=homeEnt_Offerte.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_Componenti" type="com.ejbSTL.Ent_ComponentiHome" location="Ent_Componenti" />
<EJB:useBean id="remoteEnt_Componenti" type="com.ejbSTL.Ent_Componenti" scope="session">
    <EJB:createBean instance="<%=homeEnt_Componenti.create()%>" />
</EJB:useBean>

<%
   int tipo_Tariffa  = 0;
   String appotipoTariffa = Misc.nh(request.getParameter("tipo_tariffa"));
   if (appotipoTariffa.equalsIgnoreCase("1")){
      tipo_Tariffa = Integer.parseInt(request.getParameter("tipo_tariffa"));
  }
  
  int Code_Servizio = Integer.parseInt(request.getParameter("Servizio"));
  int Code_Offerta = Integer.parseInt(request.getParameter("Offerta"));
  int Code_Prodotto = Integer.parseInt(request.getParameter("Prodotto"));
  String Desc_Prodotto = request.getParameter("DescProdotto");
  String Desc_Servizio = request.getParameter("DescServizio");

  String Code_Componente = Misc.nh(request.getParameter("CodeComponente"));
  String Code_Causale = Misc.nh(request.getParameter("CodeCausale"));

  Vector vctOfferte = remoteEnt_Offerte.getOfferte(Code_Servizio,Code_Prodotto);
  Vector vctComponenti = remoteEnt_Componenti.getComponenti(Code_Prodotto);

  boolean EnableUpd = true;
  boolean EnableDel = true;
  Vector QueryResult=(Vector)pageContext.getAttribute("buttons");

  SecurityInfoTransf appo = (SecurityInfoTransf)QueryResult.elementAt(0);

  if(appo.getCode_op_exec().equals("FITTIZIO")){
    EnableUpd = false;
    EnableDel = false;
  }
  
  String URLParam = "?Servizio=" + Code_Servizio + "&Prodotto=" + Code_Prodotto;
  URLParam += "&DescServizio=" + Desc_Servizio + "&DescProdotto=" + Desc_Prodotto;
  URLParam += "&tipo_tariffa=" + tipo_Tariffa ;
  URLParam += "&Offerta=";

  String idTar = "PROD" + String.valueOf(Code_Prodotto) + "COMP" + Code_Componente + "PRAG0";
  
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<%
String  etichetta= "";
if (tipo_Tariffa != 0) { 
   etichetta= "        PER VERIFICA       ";
%>
   <LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style1.css" TYPE="text/css">
<% } %>
<title>
Tariffe Componenti
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
  function ONANNULLA(){
    window.close();	
  }
</SCRIPT>
<body  onfocus=" ControllaFinestra()" onmouseover=" ControllaFinestra()">
    <FORM name="frmDati" id="frmDati" action="" method="post">
      <INPUT type="hidden" name="CodeServizio" id="CodeServizio" value="<%=Code_Servizio%>">
      <INPUT type="hidden" name="DescServizio" id="DescServizio" value="<%=Desc_Servizio%>">
      <INPUT type="hidden" name="CodeProdotto" id="CodeProdotto" value="<%=Code_Prodotto%>">
      <INPUT type="hidden" name="DescProdotto" id="DescProdotto" value="<%=Desc_Prodotto%>">
      <INPUT type="hidden" name="CodeOfferta" id="CodeOfferta">
      <INPUT type="hidden" name="DescOfferta" id="DescOfferta">
      <INPUT type="hidden" name="CodeComponente" id="CodeComponente">
      <INPUT type="hidden" name="DescComponente" id="DescComponente">
      <INPUT type="hidden" name="CodeTariffa" id="CodeTariffa">    
      <INPUT type="hidden" name="tipo_tariffa" id="tipo_tariffa" value="<%=tipo_Tariffa%>">    
      <INPUT type="hidden" name="SourcePage" id="SourcePage" value="cbn1_lista_tariffe_componenti.jsp<%=URLParam%>">
    </FORM>
    <TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
      <TR height="35">
        <TD>
          <TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
            <TR>
              <TD align="left">
                <IMG alt="" src="<%=StaticContext.PH_TARIFFE_IMAGES%>titoloPagina.gif" border="0">
              </TD>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="textB" align="center">
                <U>Prodotto : <%=Desc_Servizio%>-<%=Desc_Prodotto%></U>
              </TD>
              <TD align="right" class="black" nowrap >
                Offerta : <SELECT class="text" id="cboOfferta" onchange="location.replace('cbn1_lista_tariffe_componenti.jsp<%=URLParam%>' + this.value)">
                <%
                //Caricamento combo offerte in base al parametro della querystring
                DB_Offerta lcls_Offerta = null;
                for (int i = 0;i < vctOfferte.size();i++){
                  lcls_Offerta = (DB_Offerta)vctOfferte.get(i);
                  %><OPTION value="<%=lcls_Offerta.getCODE_OFFERTA()%>"><%=lcls_Offerta.getDESC_OFFERTA()%></OPTION><%
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
              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white" width="150" style="CURSOR: hand" onclick="location.replace('cbn1_lista_tariffe_prodotto.jsp<%=URLParam%>' + cboOfferta.value)">
                Prodotto
              </TD>
              <TD bgcolor="<%=StaticContext.bgColorTabellaForm%>" class="blackB" width="150">
                Componente
              </TD>
              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white" width="150" style="CURSOR: hand" onclick="location.replace('cbn1_lista_tariffe_prest_agg.jsp<%=URLParam%>' + cboOfferta.value)">
                Prestazioni Aggiuntive
              </TD>
              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white">
                &nbsp;
              </TD>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%">
                <IMG alt="immagine " src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28">
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
      <TR>
        <TD>
          <TABLE width="100%" height="100%" border="1" cellspacing="0" cellpadding="1" rules="cols" frame="vsides" bordercolor="#0A6B98">
            <TR>
              <!--Frame sinistro-->
              <TD width="15%" valign="top">
                <DIV>
                <TABLE width="100%" border="0" cellspacing="1" cellpadding="0">
                  <TR bgcolor="#0A6B98" align="center">
                    <TD class="white">
                      Componente
                    </TD>
                  </TR>
                  <%
                  //Caricamento dei componenti
                  DB_Componente lcls_Obj = null;
                  String objBgColor = StaticContext.bgColorRigaPariTabella;
                  String idTariffa = "";
                  
                    for (int i = 0;i < vctComponenti.size();i++){
                      if (objBgColor == StaticContext.bgColorRigaPariTabella) objBgColor = StaticContext.bgColorRigaDispariTabella;
                      else objBgColor = StaticContext.bgColorRigaPariTabella; 
                      lcls_Obj = (DB_Componente)vctComponenti.get(i);
                      idTariffa = "TABLE-PROD" + String.valueOf(Code_Prodotto) + "COMP" + lcls_Obj.getCODE_COMPONENTE() + "PRAG0";                      
                      %>
                      <TR bgcolor="<%=objBgColor%>" align="center">
                        <TD class="text" onclick="visualizzaTariffe('<%=idTariffa%>',this)" style="CURSOR: hand" name="menu" id="menu" codeComponente="<%=lcls_Obj.getCODE_COMPONENTE()%>" descComponente="<%=lcls_Obj.getDESC_COMPONENTE()%>">
                          <%=lcls_Obj.getDESC_COMPONENTE()%>
                        </TD>
                      </TR>
                    <%}%>
                 </TABLE>
                 </DIV>
              </TD><!--Frame destro-->
              <TD valign="top">
                <DIV>
                <%  
                  for (int i = 0;i < vctComponenti.size();i++){
                  lcls_Obj = (DB_Componente)vctComponenti.get(i);
                %>                  
                  <tar:TableTar CodeServizio="<%=Code_Servizio%>" CodeProdotto="<%=Code_Prodotto%>" CodeOfferta="<%=Code_Offerta%>" CodeComponente="<%=lcls_Obj.getCODE_COMPONENTE()%>" EnableUPD="<%=EnableUpd%>" EnableDEL="<%=EnableDel%>" ClassRow1="row1" ClassRow2="row2" ClassIntest="rowHeader" ClassRowSpecial="rowSpecial" Caption="<%=lcls_Obj.getDESC_COMPONENTE()%>" tipoTariffa = "<%=tipo_Tariffa%>"/>
                <%}%>
                </DIV>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
      <TR height="3">
        <TD></TD>
      </TR>
      <TR height="30">
        <TD>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
          <tr>
            <td class="redB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center"><%=etichetta%></td> 
            <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
              <sec:ShowButtons td_class="textB"/>
            </td>
            <td class="redB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center"><%=etichetta%></td> 
          </tr>
        </table>
        </TD>
      </TR>
    </TABLE>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  cboOfferta.value = '<%=Code_Offerta%>';
  var CodeComponente = '<%=Code_Componente%>';
  var CodeCausale = '<%=Code_Causale%>';

  if(CodeComponente != ''){
    var menu = document.all('menu');
    for(i=0;i<menu.length;i++){
       if(menu[i].codeComponente == CodeComponente){
          menu[i].onclick();
          break;
       }
    }
    if(CodeCausale != ''){
      CambiaTab('TARPC-<%=idTar%>');
    }
  }

</SCRIPT>
</body>
</html>
