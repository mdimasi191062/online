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
<sec:ChkUserAuth isModal="true"/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_controller_tariffe.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_TariffeNew" type="com.ejbSTL.Ctr_TariffeNewHome" location="Ctr_TariffeNew" />
<EJB:useBean id="remoteCtr_TariffeNew" type="com.ejbSTL.Ctr_TariffeNew" scope="session">
    <EJB:createBean instance="<%=homeCtr_TariffeNew.create()%>" />
</EJB:useBean>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title>
Elaborazione in corso...
</title>
</head>
<body>
    <TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
      <TR height="20">
        <TD>
          <TABLE width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <TR align="center">
              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white">
                &nbsp;
              </TD>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="middle" width="9%">
                <IMG alt=tre src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width=28>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
      <TR bgcolor="<%=StaticContext.bgColorCellaBianca%>">
        <TD align="center" valign="middle">
          <IMG name="imgProgress" id="imgProgress" alt="Elaborazione in corso" src="<%=StaticContext.PH_COMMON_IMAGES%>orologio.gif">
          <BR>
          <FONT class="textMsg" id="msg" name="msg">
          Elaborazione in corso...
          </FONT><BR><BR>
          <FONT class="textMsgDett" id="msgDett" name="msgDett">
          </FONT>
        </TD>
      </TR>
      <TR height="20" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
        <TD>
          <TABLE align="center" width="100%" border="0">
            <TR>
              <td class="text" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
                <INPUT TYPE="button" td_class="textB" value="Chiudi" onclick="window.close()">
              </td>
            </TR>
          </TABLE>
        </TD>
      </TR>
    </TABLE>


  <%!void popolaTariffa(String ParamName,String ParamImporto,DB_TariffeNew objTariffa,String CodeUtente,HttpServletRequest request,String strRepricing)throws Exception{
    //I nomi degli input box devono avere la seguente sintassi
    //TAR-F=CODE_FASCIA-PRF=CODE_PR_FASCIA-S=CODE_SCONTO-PRS=CODE_PR_SCONTO-PRT=CODE_PR_TARIFFA

    objTariffa.setCODE_TARIFFA(Misc.nh(request.getParameter("Tariffa")));
    objTariffa.setCODE_SERVIZIO(Misc.nh(request.getParameter("Servizio")));
    objTariffa.setCODE_OFFERTA(Misc.nh(request.getParameter("Offerta")));
    if(!Misc.nh(request.getParameter("chkAllObj")).equals("on"))
    objTariffa.setCODE_PRODOTTO(Misc.nh(request.getParameter("Prodotto")));
/*  martino 08-03-2004 INIZIO */   
    if(!Misc.nh(request.getParameter("chkAllCompo")).equals("on"))
    objTariffa.setCODE_COMPONENTE(Misc.nh(request.getParameter("Componente")));
/*  martino 08-03-2004 FINE  */     
    objTariffa.setCODE_PREST_AGG(Misc.nh(request.getParameter("PrestAgg")));
    objTariffa.setCODE_OGGETTO_FATRZ(Misc.nh(request.getParameter("cboOggettoFatturazione")));
    objTariffa.setTIPO_FLAG_ANT_POST(Misc.nh(request.getParameter("optTipoTariffa")));
    objTariffa.setVALO_FREQ_APPL(Misc.nh(request.getParameter("txtFrequenzaCanone")));
    objTariffa.setQNTA_SHIFT_CANONI(Misc.nh(request.getParameter("txtShiftCanone")));
    objTariffa.setDATA_INIZIO_VALID(Misc.nh(request.getParameter("txtDataInizioValidita")));
    objTariffa.setCODE_MODAL_APPL_TARIFFA(Misc.nh(request.getParameter("cboModalitaApplicazione")));
    objTariffa.setCODE_TIPO_CAUSALE(Misc.nh(request.getParameter("cboTipoCausale")));
    objTariffa.setCODE_UNITA_MISURA(Misc.nh(request.getParameter("cboUnitaMisura")));
    objTariffa.setDATA_CREAZ_TARIFFA(Misc.nh(request.getParameter("DataCreazione")));
    objTariffa.setCODE_UTENTE(CodeUtente);
    objTariffa.setTIPO_FLAG_PROVVISORIA("N");
    objTariffa.setCODE_TIPO_ARROTONDAMENTO(Misc.nh(request.getParameter("cboTipoArrotondamento")));
    objTariffa.setDESC_LISTINO_APPLICATO(Misc.replace(String.valueOf( Misc.nh(request.getParameter("taListAppl"))).trim(),"'","''"));
    
    
    if(strRepricing.equals("S"))
      objTariffa.setTIPO_FLAG_CONG_REPR("R");
    else
      objTariffa.setTIPO_FLAG_CONG_REPR("N");
      
    Vector vctParams = Misc.split(ParamName,"-");
    Vector vctParam_Value = null;
    String strParamName = "";
    String strParamValue = "";
    
    for(int i=1;i < vctParams.size();i++){
      if(((String)vctParams.get(i)).indexOf("=")>0){
        vctParam_Value = Misc.split((String)vctParams.get(i),"=");
        strParamName = (String)vctParam_Value.get(0);
        strParamValue = (String)vctParam_Value.get(1);
      }

      if(strParamName.equals("F")){
        objTariffa.setCODE_FASCIA(strParamValue); 
      }
      else if(strParamName.equals("PRF")){
        objTariffa.setCODE_PR_FASCIA(strParamValue);       
      }
      else if(strParamName.equals("S")){
        objTariffa.setCODE_CLAS_SCONTO(strParamValue);       
      }
      else if(strParamName.equals("PRS")){
        objTariffa.setCODE_PR_CLAS_SCONTO(strParamValue);       
      }
      else if(strParamName.equals("PRT")){
        objTariffa.setCODE_PR_TARIFFA(strParamValue);       
      }
    }  

    objTariffa.setIMPT_TARIFFA(CustomNumberFormat.getFromNumberFormat(ParamImporto));
  }

  void popolaRegola(String ParamName,String ParamValue,DB_RegolaTariffa objRegolaTariffa)throws Exception{
      Vector pvct_Regola= Misc.split(ParamName,"-");
      objRegolaTariffa.setCODE_REGOLA((String)pvct_Regola.get(1));
      objRegolaTariffa.setPARAMETRO(ParamValue);
  }


%>
  
<%
  out.flush();
  
    int tipo_Tariffa  = 0;
   String appotipoTariffa = Misc.nh(request.getParameter("tipo_tariffa"));
   if (appotipoTariffa.equalsIgnoreCase("1")){
      tipo_Tariffa = Integer.parseInt(request.getParameter("tipo_tariffa"));
  }

  String strOperazione = Misc.nh(request.getParameter("Operazione"));
  String strSource  =  Misc.nh(request.getParameter("SourcePage"));
  String strRepricing  =  Misc.nh(request.getParameter("Repricing"));
  String strResponse = "";
  String strResponseDett = "";  
  DB_TariffeNew objTariffa = null;  
  DB_RegolaTariffa objRegolaTariffa = null;

  if (strOperazione.equals("InsUpd")){

    Vector pvct_Tariffe=new Vector();
    Vector pvct_Regole=new Vector();
    Vector pvct_TariffeRif=new Vector();    
 
    strSource +=  Misc.nh(request.getParameter("cboTipoCausale"));

    String strParamName = "";
    String strParamValue = "";
    String strTipoParam = "";
    String strOldDate = "";
    //Reperisco il codice utente
    String CodeUtente = ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName();
    //i nomi dei parametri passati che sono dinamici
    Enumeration enumParam = request.getParameterNames();

    while(enumParam.hasMoreElements()){

      strParamName = (String)enumParam.nextElement();
      strParamValue = request.getParameter(strParamName);

      if(strParamName.indexOf('-') > 0){       
        strTipoParam = (String)Misc.split(strParamName,"-").elementAt(0);

        if(strTipoParam.equals("TAR")){
            objTariffa = new DB_TariffeNew();
            popolaTariffa(strParamName,strParamValue,objTariffa,CodeUtente,request,strRepricing);
            pvct_Tariffe.add(objTariffa);
        }
        else if(strTipoParam.equals("REG")){
            objRegolaTariffa = new DB_RegolaTariffa();
            popolaRegola(strParamName,strParamValue,objRegolaTariffa);
            pvct_Regole.add(objRegolaTariffa);
        }
        else if(strTipoParam.equals("TARRIF")){
            pvct_TariffeRif.add(strParamValue);
        }
      }
    }

    try{
      strResponse = remoteCtr_TariffeNew.InsUpdTariffa(pvct_Tariffe,pvct_Regole,pvct_TariffeRif,tipo_Tariffa);
    }
    catch(Exception e){
      strResponse = "Si è verificato un errore inaspettato. Contattare l'assistenza."; 
      strResponseDett = "(" + Misc.replace(e.getMessage(),"\n","") + ")";          
   }
    
  }
  else if(strOperazione.equals("Del")){
    objTariffa = new DB_TariffeNew();
    objTariffa.setCODE_TARIFFA(Misc.nh(request.getParameter("CodeTariffa")));
    try{
      strResponse = remoteCtr_TariffeNew.DeleteTariffa(objTariffa,tipo_Tariffa);
    }
    catch(Exception e){
      strResponse = "Si è verificato un errore inaspettato. Contattare l'assistenza.";  
      strResponseDett = "(" + Misc.replace(e.getMessage(),"\n","") + ")";          
    }
  }

  strResponse = Misc.nh(strResponse);
  strResponse = Misc.replace(strResponse,"'","\\'");
  strResponseDett = Misc.nh(strResponseDett);
  strResponseDett = Misc.replace(strResponseDett,"'","\\'");

%>
<script language="javascript">
  var Response = '<%=strResponse%>';
  imgProgress.style.display='none';
  var myWin = null;
  if (Response == ''){
    document.all('msg').innerText = 'Operazione effettuata con successo.';
    window.opener.location.replace('<%=strSource%>','_self');
    //myWin = window.opener.open('<%=strSource%>','_self');
  }
  else{
    document.all('msg').style.color ='red';
    document.all('msg').innerHTML = Response;
    document.all('msgDett').innerHTML = '<%=strResponseDett%>';
  }

</script>
</body>
</html>