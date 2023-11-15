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
<%@ page import="java.text.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>


<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_controller_accordi.jsp")%>
</logtag:logData>
<EJB:useHome id="homeCtr_TariffeNew" type="com.ejbSTL.Ctr_TariffeNewHome" location="Ctr_TariffeNew" />
<EJB:useBean id="remoteCtr_TariffeNew" type="com.ejbSTL.Ctr_TariffeNew" scope="session">
    <EJB:createBean instance="<%=homeCtr_TariffeNew.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_Accordo" type="com.ejbSTL.Ent_AccordoHome" location="Ent_Accordo" />
<EJB:useBean id="remoteEnt_Accordi" type="com.ejbSTL.Ent_Accordo" scope="session">
  <EJB:createBean instance="<%=homeEnt_Accordo.create()%>" />
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


  <%!void popolaTariffa(String ParamName,String ParamImporto,DB_TariffeNew objTariffa,String CodeUtente,HttpServletRequest request,String strRepricing,String strServizioxAccountSelezionato,String strProdottoAccordo)throws Exception{
    //I nomi degli input box devono avere la seguente sintassi
    //TAR-F=CODE_FASCIA-PRF=CODE_PR_FASCIA-S=CODE_SCONTO-PRS=CODE_PR_SCONTO-PRT=CODE_PR_TARIFFA


        
        String pstrDATA_FINE_VALID =Misc.nh(request.getParameter("txtDataFineValiditaTariffa"));
       if (pstrDATA_FINE_VALID.equals("") ){
           pstrDATA_FINE_VALID="31/12/2099";
       }




    objTariffa.setCODE_TARIFFA(Misc.nh(request.getParameter("CodeTariffa")));
    objTariffa.setCODE_SERVIZIO(strServizioxAccountSelezionato);
    if (Misc.nh(request.getParameter("cboOfferta")).equals("")){
       objTariffa.setCODE_OFFERTA("10000");
    }else{
       objTariffa.setCODE_OFFERTA(Misc.nh(request.getParameter("cboOfferta")));
    }
    objTariffa.setCODE_PRODOTTO(strProdottoAccordo);
    objTariffa.setCODE_COMPONENTE("");
    objTariffa.setCODE_PREST_AGG("");
    objTariffa.setCODE_OGGETTO_FATRZ(Misc.nh(request.getParameter("cboOggettoFatturazione")));
    objTariffa.setTIPO_FLAG_ANT_POST(Misc.nh(request.getParameter("optTipoTariffa")));
    objTariffa.setVALO_FREQ_APPL(Misc.nh(request.getParameter("txtFrequenzaCanone")));
    objTariffa.setQNTA_SHIFT_CANONI(Misc.nh(request.getParameter("txtShiftCanone")));
//    objTariffa.setCODE_MODAL_APPL_TARIFFA(Misc.nh(request.getParameter("cboModalitaApplicazione")));
    objTariffa.setCODE_MODAL_APPL_TARIFFA("1");
    objTariffa.setCODE_UNITA_MISURA("");
    objTariffa.setDATA_CREAZ_TARIFFA(Misc.nh(request.getParameter("DataCreazione")));
    objTariffa.setCODE_UTENTE(CodeUtente);
    objTariffa.setTIPO_FLAG_PROVVISORIA("N");
    objTariffa.setCODE_TIPO_ARROTONDAMENTO("");
    objTariffa.setTIPO_FLAG_CONG_REPR("N");
// DIV della tariffa uguale alla DIV dell'accordo
    objTariffa.setDATA_INIZIO_VALID(Misc.nh(request.getParameter("txtDataInizioValidita")));
//    objTariffa.setDATA_FINE_VALID(Misc.nh(request.getParameter("txtDataFineValiditaTariffa")));
      
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
void popolaAccordo(DB_Accordo objAccordo,String CodeUtente,HttpServletRequest request)throws Exception{

 objAccordo.setCODE_ACCORDO(Misc.nh(request.getParameter("txtCodeAccordo")));   
 objAccordo.setDESC_ACCORDO(Misc.nh(request.getParameter("txtDescAccordo")));   
 objAccordo.setCODE_MATERIALE_SAP(Misc.nh(request.getParameter("txtMaterialeSAP")));   


  }
void popolaInventarioProd(DB_InventProd objInventProd,String CodeUtente,HttpServletRequest request,String strServizioxAccountSelezionato,String strProdottoAccordo,String sysDate)throws Exception{
//===========================================================================
// GESTIONE DATE
//le date da valori fittizzi
  String  pstrDATA_FINE_FATRZ =Misc.nh(request.getParameter("txtDataFineFattura"));
  String  pstrDATA_FINE_VALID =Misc.nh(request.getParameter("txtDataFineValidita"));
   if (pstrDATA_FINE_VALID.equals("") ){
       pstrDATA_FINE_VALID="31/12/2099";
   }
   
   if (pstrDATA_FINE_FATRZ.equals("") ){
      pstrDATA_FINE_FATRZ="31/12/2099";
   }
   
 String DIVA = Misc.nh(request.getParameter("txtDataInizioValidita"));
 SimpleDateFormat sdfSource = new SimpleDateFormat("dd/MM/yyyy");       
 Date datesysDate = sdfSource.parse(sysDate);
 Date dateDIVA=sdfSource.parse(DIVA);

// Date datesysDate=new Date(sysDate);
// Date dateDIVA=new Date(DIVA);

  if(datesysDate.compareTo(dateDIVA)>0)
   {
      objInventProd.setDATA_INIZIO_VALID(sysDate);  
      objInventProd.setDATA_INIZIO_FATRZ  (Misc.nh(request.getParameter("txtDataInizioValidita"))); 
      objInventProd.setDATA_INIZIO_FATRB(sysDate);  
 
   }else{
       objInventProd.setDATA_INIZIO_VALID(Misc.nh(request.getParameter("txtDataInizioValidita")));  
       objInventProd.setDATA_INIZIO_FATRZ  (Misc.nh(request.getParameter("txtDataInizioValidita"))); 
       objInventProd.setDATA_INIZIO_FATRB(Misc.nh(request.getParameter("txtDataInizioValidita"))); 
  }

  objInventProd.setDATA_FINE_VALID(pstrDATA_FINE_VALID);   
  objInventProd.setDATA_FINE_FATRB(pstrDATA_FINE_VALID);   
  objInventProd.setDATA_FINE_FATRZ(pstrDATA_FINE_FATRZ);   

  
  

//===========================================================================

 //objInventProd.setCODE_INVENT("");  
 objInventProd.setCODE_INVENT_RIF("");   
 objInventProd.setTIPO_CAUSALE_ATT("1");   
 objInventProd.setTIPO_CAUSALE_CES("");   
 objInventProd.setTIPO_CAUSALE_ATT_HD("");  
 objInventProd.setTIPO_CAUSALE_CES_HD("");  
 objInventProd.setCODE_STATO_ELEM("1");   
 objInventProd.setCODE_ACCOUNT (Misc.nh(request.getParameter("cboAccountDisp")));  
 if (Misc.nh(request.getParameter("cboOfferta")).equals("")){
    objInventProd.setCODE_OFFERTA ("10000");   
 }else{
    objInventProd.setCODE_OFFERTA (Misc.nh(request.getParameter("cboOfferta")));   
 }
 objInventProd.setCODE_SERVIZIO(strServizioxAccountSelezionato);   
 objInventProd.setCODE_PRODOTTO(strProdottoAccordo);   
 objInventProd.setCODE_ISTANZA_PROD("AC/" + Misc.nh(request.getParameter("txtCodeAccordo")) + "/" + Misc.nh(request.getParameter("cboAccountDisp")) );  
 objInventProd.setCODE_ULTIMO_CICLO_FATRZ("");   
 objInventProd.setDATA_FINE_NOL("");   
 objInventProd.setDATA_CESSAZ("");  
 objInventProd.setQNTA_VALO  ("1");  
 objInventProd.setTIPO_FLAG_CONG ("");   
 objInventProd.setCODE_UTENTE_CREAZ  (CodeUtente);  
 objInventProd.setDATA_CREAZ (Misc.nh(request.getParameter("DataCreazione")));  
 objInventProd.setCODE_UTENTE_MODIF  ("");  
 objInventProd.setDATA_MODIF ("");  
 objInventProd.setCODE_UTENTE_CREAZ_HD   ("");   
 objInventProd.setDATA_CREAZ_HD  ("");   
 objInventProd.setCODE_UTENTE_MODIF_HD   ("");   
 objInventProd.setDATA_MODIF_HD  ("");   
 objInventProd.setELAB_VALORIZ   ("");   
 objInventProd.setTIPO_FLAG_MIGRAZIONE   ("");   
 objInventProd.setCODICE_PROGETTO("");
 

  }

  void popolaRegola(String ParamName,String ParamValue,DB_RegolaTariffa objRegolaTariffa)throws Exception{
      Vector pvct_Regola= Misc.split(ParamName,"-");
      objRegolaTariffa.setCODE_REGOLA((String)pvct_Regola.get(1));
      objRegolaTariffa.setPARAMETRO(ParamValue);
  }

void popolaAccordoUpdate(DB_Accordo objAccordo,String CodeUtente,HttpServletRequest request,String Code_Tariffa,String Code_Pr_Tariffa,String strServizioxAccountSelezionato,String strProdottoAccordo,String sysDate)throws Exception{
   
  

 objAccordo.setCODE_UTENTE(CodeUtente);  
 objAccordo.setCODE_ACCORDO(Misc.nh(request.getParameter("txtCodeAccordo")));
  
  if (Misc.nh(request.getParameter("cboOfferta")).equals("")){
    objAccordo.setCODE_OFFERTA("10000");
  }else{
    objAccordo.setCODE_OFFERTA(Misc.nh(request.getParameter("cboOfferta")));
  }
  objAccordo.setDESC_ACCORDO(Misc.nh(request.getParameter("txtDescAccordo")));
  objAccordo.setCODE_SERVIZIO(strServizioxAccountSelezionato);
  objAccordo.setCODE_ACCOUNT(Misc.nh(request.getParameter("cboAccountDisp")));
  objAccordo.setCODE_PRODOTTO(strProdottoAccordo);
  objAccordo.setCODE_ISTANZA_PROD(Misc.nh(request.getParameter( "")));
//===========================================================================
// GESTIONE DATE
             //le date da valori fittizzi
  String  pstrDATA_FINE_FATRZ =Misc.nh(request.getParameter("txtDataFineFattura"));
  String  pstrDATA_FINE_VALID =Misc.nh(request.getParameter("txtDataFineValidita"));
   if (pstrDATA_FINE_VALID.equals("") ){
       pstrDATA_FINE_VALID="31/12/2099";
   }
   
   if (pstrDATA_FINE_FATRZ.equals("") ){
      pstrDATA_FINE_FATRZ="31/12/2099";
   }
   
 String DIVA = Misc.nh(request.getParameter("txtDataInizioValidita"));
 SimpleDateFormat sdfSource = new SimpleDateFormat("dd/MM/yyyy");       
 Date datesysDate = sdfSource.parse(sysDate);
 Date dateDIVA=sdfSource.parse(DIVA);

// Date datesysDate=new Date(sysDate);
// Date dateDIVA=new Date(DIVA);

  if(datesysDate.compareTo(dateDIVA)>0)
   {
      objAccordo.setDATA_INIZIO_VALID(sysDate);  
      objAccordo.setDATA_INIZIO_FATRZ  (Misc.nh(request.getParameter("txtDataInizioValidita"))); 
      objAccordo.setDATA_INIZIO_FATRB(sysDate);  
 
   }else{
     objAccordo.setDATA_INIZIO_VALID(Misc.nh(request.getParameter("txtDataInizioValidita")));  
     objAccordo.setDATA_INIZIO_FATRZ  (Misc.nh(request.getParameter("txtDataInizioValidita"))); 
     objAccordo.setDATA_INIZIO_FATRB(Misc.nh(request.getParameter("txtDataInizioValidita"))); 
  }



  objAccordo.setDATA_FINE_VALID(pstrDATA_FINE_VALID);
  objAccordo.setDATA_FINE_FATRB(pstrDATA_FINE_VALID);
  objAccordo.setDATA_FINE_FATRZ(pstrDATA_FINE_FATRZ);
  objAccordo.setCODE_TARIFFA(Code_Tariffa);
  objAccordo.setCODE_PR_TARIFFA(Code_Pr_Tariffa);
  

  Enumeration enumParam = request.getParameterNames();
  
  String strParamName = "";
  String strParamValue = "";
  String strTipoParam = "";
  while(enumParam.hasMoreElements()){

      strParamName = (String)enumParam.nextElement();
      strParamValue = request.getParameter(strParamName);

      if(strParamName.indexOf('-') > 0){       
        strTipoParam = (String)Misc.split(strParamName,"-").elementAt(0);

        if(strTipoParam.equals("TAR")){
          objAccordo.setIMPT_TARIFFA(CustomNumberFormat.getFromNumberFormat(strParamValue));
          
        }
      }
    }
  //DIV della tariffa uguale DIV dell'accordo
  objAccordo.setDATA_INIZIO_TARIFFA(Misc.nh(request.getParameter("txtDataInizioValidita")));
 // objAccordo.setDATA_FINE_TARIFFA( Misc.nh(request.getParameter("txtDataFineValiditaTariffa")));
  objAccordo.setCODE_OGGETTO_FATRZ(Misc.nh(request.getParameter("cboOggettoFatturazione")));
  objAccordo.setTIPO_FLAG_ANT_POST(Misc.nh(request.getParameter("optTipoTariffa")));
  objAccordo.setVALO_FREQ_APPL(Misc.nh(request.getParameter("txtFrequenzaCanone")));
  objAccordo.setQNTA_SHIFT_CANONI(Misc.nh(request.getParameter("txtShiftCanone")));
//  objAccordo.setCODE_MODAL_APPL_TARIFFA(Misc.nh(request.getParameter("cboModalitaApplicazione")));
  objAccordo.setCODE_MODAL_APPL_TARIFFA("1");
  objAccordo.setCODE_MATERIALE_SAP(Misc.nh(request.getParameter("txtMaterialeSAP")));  

 

  }


%>
  
<%
  out.flush();
  //Mi stacco la sysdate
  Date dt=new Date();
SimpleDateFormat sdf=new java.text.SimpleDateFormat("dd'/'MM'/'yyyy");
String strSysDate = sdf.format(dt);



    int tipo_Tariffa  = 0;
   String appotipoTariffa = Misc.nh(request.getParameter("tipo_tariffa"));
   if (appotipoTariffa.equalsIgnoreCase("1")){
      tipo_Tariffa = Integer.parseInt(request.getParameter("tipo_tariffa"));
  }

  String strOperazione = Misc.nh(request.getParameter("Operazione"));
  String strSource  =  (String) session.getAttribute("SourcePage");
  String strRepricing  =  Misc.nh(request.getParameter("Repricing"));
  String strResponse = "";
  String strResponseDett = "";  
  DB_TariffeNew objTariffa = null;  
  DB_RegolaTariffa objRegolaTariffa = null;
  DB_InventProd objInventProd=null;
  DB_Accordo objAccordo = null;  
  


  String CodeAccordo=  Misc.nh(request.getParameter("txtCodeAccordo"));
  String Code_Tariffa= (String) session.getAttribute("CodeTariffa");
  String Code_Pr_Tariffa= (String) session.getAttribute("PrCodeTariffa");
  String CodeAccount= Misc.nh(request.getParameter("cboAccountDisp"));
  String strServizioxAccountSelezionato = remoteEnt_Accordi.getServizioxAccount(CodeAccount);
  String CodeUtente = ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName();
  String strProdottoAccordo ="";
  Vector pvct_Accordo=new Vector();
 
  if (strOperazione.equals("Ins")){

      Vector pvct_Tariffe=new Vector();
      Vector pvct_Regole=new Vector();
      Vector pvct_TariffeRif=new Vector();    
      Vector pvct_InventarioProd=new Vector();
       try{
         strProdottoAccordo = remoteEnt_Accordi. getSequenceProdottoAccordo();
      }
      catch(Exception e){
        strResponse = "Si è verificato un errore inaspettato. Contattare l'assistenza."; 
        strResponseDett = "(" + Misc.replace(e.getMessage(),"\n","") + ")";          
     }

 //   strSource +=  Misc.nh(request.getParameter("cboTipoCausale"));

    String strParamName = "";
    String strParamValue = "";
    String strTipoParam = "";
    String strOldDate = "";
    //Reperisco il codice utente
  
    //i nomi dei parametri passati che sono dinamici
    Enumeration enumParam = request.getParameterNames();

    while(enumParam.hasMoreElements()){

      strParamName = (String)enumParam.nextElement();
      strParamValue = request.getParameter(strParamName);

      if(strParamName.indexOf('-') > 0){       
        strTipoParam = (String)Misc.split(strParamName,"-").elementAt(0);

        if(strTipoParam.equals("TAR")){
            objTariffa = new DB_TariffeNew();
            popolaTariffa(strParamName,strParamValue,objTariffa,CodeUtente,request,strRepricing,strServizioxAccountSelezionato,strProdottoAccordo);
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
      //Aggiungo oggetto ACCORDO
      if(strParamName.equals("txtCodeAccordo")){
            objAccordo = new DB_Accordo();
            popolaAccordo(objAccordo,CodeUtente,request);
            pvct_Accordo.add(objAccordo);
        }
       //Aggiungo oggetto INVENTARIO PROD
       if(strParamName.equals("cboAccountDisp")){
           objInventProd = new DB_InventProd();
           popolaInventarioProd(objInventProd,CodeUtente,request,strServizioxAccountSelezionato,strProdottoAccordo,strSysDate);
           pvct_InventarioProd.add(objInventProd);
        }
    }

    try{
      strResponse = remoteEnt_Accordi.InsAccordo(pvct_Tariffe,pvct_Regole,pvct_TariffeRif,tipo_Tariffa , pvct_Accordo, pvct_InventarioProd);
    }
    catch(Exception e){
      strResponse = "Si è verificato un errore inaspettato. Contattare l'assistenza."; 
      strResponseDett = "(" + Misc.replace(e.getMessage(),"\n","") + ")";          
   }
    
  }else if(strOperazione.equals("Upd")){
    try{
      strProdottoAccordo= (String) session.getAttribute("ProdottoAccordo");
      objAccordo = new DB_Accordo();
      popolaAccordoUpdate(objAccordo,CodeUtente,request,Code_Tariffa,Code_Pr_Tariffa,strServizioxAccountSelezionato,strProdottoAccordo,strSysDate);
      pvct_Accordo.add(objAccordo);
   
     Vector pvct_Regole=new Vector();
         //i nomi dei parametri passati che sono dinamici
    Enumeration enumParam = request.getParameterNames();
     String strParamName = "";
    String strParamValue = "";
    String strTipoParam = "";
    String strOldDate = ""; 
    while(enumParam.hasMoreElements()){

      strParamName = (String)enumParam.nextElement();
      strParamValue = request.getParameter(strParamName);

      if(strParamName.indexOf('-') > 0){       
        strTipoParam = (String)Misc.split(strParamName,"-").elementAt(0);

       if(strTipoParam.equals("REG")){
            objRegolaTariffa = new DB_RegolaTariffa();
            popolaRegola(strParamName,strParamValue,objRegolaTariffa);
            pvct_Regole.add(objRegolaTariffa);
        }
        
        
        
      }
    }   
 

      
      strResponse = remoteEnt_Accordi.UpdAccordo(objAccordo,pvct_Regole);
    }
    catch(Exception e){
      strResponse = "Si è verificato un errore inaspettato. Contattare l'assistenza."; 
      strResponseDett = "(" + Misc.replace(e.getMessage(),"\n","") + ")";  
    }  
  
  }else if(strOperazione.equals("Eli")){
      objAccordo = new DB_Accordo();
    objAccordo.setCODE_ACCORDO(Misc.nh(request.getParameter("txtCodeAccordo")));
    try{
      remoteEnt_Accordi.EliminaAccordo(objAccordo);
    }
    catch(Exception e){
      strResponse = "Si è verificato un errore inaspettato. Contattare l'assistenza.";  
      strResponseDett = "(" + Misc.replace(e.getMessage(),"\n","") + ")";          
    }
    }else if(strOperazione.equals("Ces")){

    objAccordo = new DB_Accordo();
    objAccordo.setCODE_ACCORDO(Misc.nh(request.getParameter("txtCodeAccordo")));
    objAccordo.setCODE_UTENTE(CodeUtente);  
    //DFV=sysDate
    objAccordo.setDATA_FINE_VALID(strSysDate);
     //DFF=DFVA
    objAccordo.setDATA_FINE_FATRZ(Misc.nh(request.getParameter("txtDataFineValidita" )));  
    try{
     int ret =  remoteEnt_Accordi.cessaAccordo(objAccordo);
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
var opera = '<%=strOperazione%>';
  var Response = '<%=strResponse%>';
  imgProgress.style.display='none';
  var myWin = null;
  if (Response == ''){
    document.all('msg').innerText = 'Operazione effettuata con successo.';
   // alert(opera);
   window.opener.CallParentWindowFunction();
  
  // window.frames['MAIN'].location.reload();

//    if (opera=='Eli'){
//      window.opener.close();
//    }else{
//      window.opener.location.replace('<%=strSource%>','_self');
//    }
    
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