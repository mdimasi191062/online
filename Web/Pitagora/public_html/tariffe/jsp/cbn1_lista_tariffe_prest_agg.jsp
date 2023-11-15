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
<%=StaticMessages.getMessage(3006,"cbn1_lista_tariffe_prest_agg.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Offerte" type="com.ejbSTL.Ent_OfferteHome" location="Ent_Offerte" />
<EJB:useBean id="remoteEnt_Offerte" type="com.ejbSTL.Ent_Offerte" scope="session">
    <EJB:createBean instance="<%=homeEnt_Offerte.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_Componenti" type="com.ejbSTL.Ent_ComponentiHome" location="Ent_Componenti" />
<EJB:useBean id="remoteEnt_Componenti" type="com.ejbSTL.Ent_Componenti" scope="session">
    <EJB:createBean instance="<%=homeEnt_Componenti.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_PrestazioniAggiuntiveNew" type="com.ejbSTL.Ent_PrestazioniAggiuntiveNewHome" location="Ent_PrestazioniAggiuntiveNew" />
<EJB:useBean id="remoteEnt_PrestazioniAggiuntiveNew" type="com.ejbSTL.Ent_PrestazioniAggiuntiveNew" scope="session">
    <EJB:createBean instance="<%=homeEnt_PrestazioniAggiuntiveNew.create()%>" />
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
  Vector vctOfferte = remoteEnt_Offerte.getOfferte(Code_Servizio,Code_Prodotto);
  Vector vctComponenti = remoteEnt_Componenti.getComponenti(Code_Prodotto);
  Vector vctPrestAggProd = null; 
  Vector vctPrestAggComp = null;  
  Vector vctAppComp = new Vector();  
  Vector vctAppPrestAgg = new Vector(); 

  String Code_Componente = Misc.nh(request.getParameter("CodeComponente"));
  String Code_PrestAgg = Misc.nh(request.getParameter("CodePrestAgg"));
  String Code_Causale = Misc.nh(request.getParameter("CodeCausale"));

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

  String idTar = "PROD" + String.valueOf(Code_Prodotto) + "COMP" + (Code_Componente.equals("") ? "0" : Code_Componente)  + "PRAG" + Code_PrestAgg;
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
Tariffe Prestazioni Aggiuntive
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

<body onfocus=" ControllaFinestra()" onmouseover=" ControllaFinestra()">
    <FORM name="frmDati" id="frmDati" action="" method="post">
      <INPUT type="hidden" name="CodeServizio" id="CodeServizio" value="<%=Code_Servizio%>">
      <INPUT type="hidden" name="DescServizio" id="DescServizio" value="<%=Desc_Servizio%>">
      <INPUT type="hidden" name="CodeProdotto" id="CodeProdotto" value="<%=Code_Prodotto%>">
      <INPUT type="hidden" name="DescProdotto" id="DescProdotto" value="<%=Desc_Prodotto%>">
      <INPUT type="hidden" name="CodeOfferta" id="CodeOfferta">
      <INPUT type="hidden" name="DescOfferta" id="DescOfferta">
      <INPUT type="hidden" name="CodeComponente" id="CodeComponente">
      <INPUT type="hidden" name="CodePrestAgg" id="CodePrestAgg">
      <INPUT type="hidden" name="DescComponente" id="DescComponente">
      <INPUT type="hidden" name="DescPrestAgg" id="DescPrestAgg">
      <INPUT type="hidden" name="CodeTariffa" id="CodeTariffa">    
       <INPUT type="hidden" name="tipo_tariffa" id="tipo_tariffa" value="<%=tipo_Tariffa%>">    
      <INPUT type="hidden" name="SourcePage" id="SourcePage" value="cbn1_lista_tariffe_prest_agg.jsp<%=URLParam%>">
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
              <TD align="right" class="black">
                Offerta : <SELECT class="text" id="cboOfferta" onchange="location.replace('cbn1_lista_tariffe_prest_agg.jsp<%=URLParam%>' + this.value)">
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
              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white" width="150" style="CURSOR: hand" onclick="location.replace('cbn1_lista_tariffe_componenti.jsp<%=URLParam%>' + cboOfferta.value)">
                Componente
              </TD>
              <TD bgcolor="<%=StaticContext.bgColorTabellaForm%>" class="blackB" width="150">
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
          <TABLE width="100%" height="100%" border="1" cellspacing="0" cellpadding="1" rules="cols" frame="vsides" bordercolor="<%=StaticContext.bgColorHeader%>">
            <TR>
              <!--Frame sinistro-->
              <TD width="15%" valign="top">
                <DIV>
                <TABLE width="100%" border="0" cellspacing="1" cellpadding="0">
                  <TR bgcolor="#0A6B98" align="center">
                    <TD class="white"  colspan="2">
                      P.a. per Prodotti
                    </TD>
                  </TR>
                  <%
                  //Caricamento delle prestazioni aggiuntive del prodotto
                  vctPrestAggProd = remoteEnt_PrestazioniAggiuntiveNew.getPrestAggProdotto(Code_Prodotto);
                  DB_PrestazioneAggiuntiva lcls_Obj = null;
                  String objBgColor = StaticContext.bgColorRigaPariTabella;
                  String idTariffa="";
                  
                  for (int i = 0;i < vctPrestAggProd.size();i++){
                    if (objBgColor == StaticContext.bgColorRigaPariTabella) objBgColor = StaticContext.bgColorRigaDispariTabella;
                    else objBgColor = StaticContext.bgColorRigaPariTabella; 
                    lcls_Obj = (DB_PrestazioneAggiuntiva)vctPrestAggProd.get(i);
                    idTariffa = "TABLE-PROD" + String.valueOf(Code_Prodotto) + "COMP0PRAG" + lcls_Obj.getCODE_PREST_AGG();                      
                    %>
                    <TR bgcolor="<%=objBgColor%>" align="center">
                      <TD  colspan="2" class="text" onclick="visualizzaTariffe('<%=idTariffa%>',this)" style="CURSOR: hand" name="menu" id="menu" codePrestAgg="<%=lcls_Obj.getCODE_PREST_AGG()%>" descPrestAgg="<%=lcls_Obj.getDESC_PREST_AGG()%>" codeComponente="">
                        <%=lcls_Obj.getDESC_PREST_AGG()%>
                      </TD>
                    </TR>
                  <%}%>
                  <TR>
                    <TD colspan="2">
                      &nbsp;
                    </TD>
                  </TR>
                  <TR bgcolor="#0A6B98" align="center">
                    <TD class="white" colspan="2">
                      P.a. per Componenti
                    </TD>
                  </TR>
                  <%
                  //Caricamento delle prestazioni aggiuntive componenti
                  DB_Componente lcls_Componente = null;
                  String objBgColorComp = StaticContext.bgColorRigaPariTabella;
                  String objBgColorPA = StaticContext.bgColorRigaPariTabella;
                  
                  for (int j=0;j<vctComponenti.size();j++){
                    if (objBgColorComp == StaticContext.bgColorRigaPariTabella) objBgColorComp = StaticContext.bgColorRigaDispariTabella;
                    else objBgColorComp = StaticContext.bgColorRigaPariTabella; 

                    lcls_Componente = (DB_Componente)vctComponenti.get(j);
                    vctPrestAggComp = remoteEnt_PrestazioniAggiuntiveNew.getPrestAggComponente(Integer.parseInt(lcls_Componente.getCODE_COMPONENTE()));

                    if (vctPrestAggComp.size() > 0){
                      
                      %>
                      <TR bgcolor="<%=objBgColorComp%>" align="center">
                        <TD width="10" name="mnu<%=lcls_Componente.getCODE_COMPONENTE()%>" id="mnu<%=lcls_Componente.getCODE_COMPONENTE()%>" class="text" style="CURSOR: hand" align="center" onclick="Expand('<%=lcls_Componente.getCODE_COMPONENTE()%>',this)">
                          +
                        </TD>
                        <TD class="text">
                          <%=lcls_Componente.getDESC_COMPONENTE()%>
                        </TD>
                      </TR>
                      <TR name="<%=lcls_Componente.getCODE_COMPONENTE()%>" id="<%=lcls_Componente.getCODE_COMPONENTE()%>" width="10" style="DISPLAY: none">
                        <TD align="right" valign="top">
                          <IMG alt="immagine" src="<%=StaticContext.PH_COMMON_IMAGES%>l.gif" width="10">
                        </TD>
                        <TD>
                          <TABLE width="100%" border="1" cellspacing="0" cellpadding="1" frame="box" rules="cols" bordercolor="<%=StaticContext.bgColorHeader%>">
                          <%for (int i = 0;i < vctPrestAggComp.size();i++){
                              if (objBgColorPA == StaticContext.bgColorRigaPariTabella) objBgColorPA = StaticContext.bgColorRigaDispariTabella;
                              else objBgColorPA = StaticContext.bgColorRigaPariTabella;
                              lcls_Obj = (DB_PrestazioneAggiuntiva)vctPrestAggComp.get(i);
                              idTariffa = "TABLE-PROD" + String.valueOf(Code_Prodotto) + "COMP" + lcls_Componente.getCODE_COMPONENTE() + "PRAG" + lcls_Obj.getCODE_PREST_AGG();                      
                              vctAppComp.addElement(lcls_Componente);
                              vctAppPrestAgg.addElement(lcls_Obj);
                              %>
                              <TR bgcolor="<%=objBgColorPA%>" align="center">
                                <TD class="text" onclick="visualizzaTariffe('<%=idTariffa%>',this)" style="CURSOR: hand" name="menu" id="menu" codeComponente="<%=lcls_Componente.getCODE_COMPONENTE()%>" descComponente="<%=lcls_Componente.getDESC_COMPONENTE()%>" codePrestAgg="<%=lcls_Obj.getCODE_PREST_AGG()%>" descPrestAgg="<%=lcls_Obj.getDESC_PREST_AGG()%>">
                                  <%=lcls_Obj.getDESC_PREST_AGG()%>
                                </TD>                        
                              </TR>
                          <%}%>
                          </TABLE>
                        </TD>
                     </TR>
                     <%
                    }
                    else{
                      %>
                      <TR bgcolor="<%=objBgColorComp%>" align="center">
                        <TD width="10"></TD>
                        <TD class="text">
                          <%=lcls_Componente.getDESC_COMPONENTE()%>
                        </TD>
                      </TR>
                      <%
                    }
                  }%>
                  </TABLE>
                  </DIV>
              </TD><!--Frame destro-->
              <TD valign="top">
                <DIV>
                <%  
                  for (int i = 0;i < vctPrestAggProd.size();i++){
                  lcls_Obj = (DB_PrestazioneAggiuntiva)vctPrestAggProd.get(i);
                %>                  
                  <tar:TableTar CodeServizio="<%=Code_Servizio%>" CodeProdotto="<%=Code_Prodotto%>" CodeOfferta="<%=Code_Offerta%>" CodePrestAgg="<%=lcls_Obj.getCODE_PREST_AGG()%>" EnableUPD="<%=EnableUpd%>" EnableDEL="<%=EnableDel%>" ClassRow1="row1" ClassRow2="row2" ClassIntest="rowHeader" ClassRowSpecial="rowSpecial" Caption="<%=lcls_Obj.getDESC_PREST_AGG()%>" tipoTariffa = "<%=tipo_Tariffa%>"/>
                <%}
                  String strCaption = "";
                  for (int i = 0;i < vctAppPrestAgg.size();i++){
                    lcls_Componente = (DB_Componente)vctAppComp.get(i);
                    lcls_Obj = (DB_PrestazioneAggiuntiva)vctAppPrestAgg.get(i);
                    strCaption = lcls_Componente.getDESC_COMPONENTE() + " - "  + lcls_Obj.getDESC_PREST_AGG();
                %>                  
                  <tar:TableTar CodeServizio="<%=Code_Servizio%>" CodeProdotto="<%=Code_Prodotto%>" CodeOfferta="<%=Code_Offerta%>" CodeComponente="<%=lcls_Componente.getCODE_COMPONENTE()%>" CodePrestAgg="<%=lcls_Obj.getCODE_PREST_AGG()%>" EnableUPD="<%=EnableUpd%>" EnableDEL="<%=EnableDel%>" ClassRow1="row1" ClassRow2="row2" ClassIntest="rowHeader" ClassRowSpecial="rowSpecial" Caption="<%=strCaption%>" tipoTariffa = "<%=tipo_Tariffa%>"/>
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
  var CodePrestAgg = '<%=Code_PrestAgg%>';
  var CodeCausale = '<%=Code_Causale%>';

  if(CodeComponente != ''){
    document.all('mnu' + CodeComponente).onclick();
  }

  if(CodePrestAgg != ''){
    var menu = document.all('menu');
    for(i=0;i<menu.length;i++){
       if(menu[i].codeComponente == CodeComponente && menu[i].codePrestAgg == CodePrestAgg){
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
