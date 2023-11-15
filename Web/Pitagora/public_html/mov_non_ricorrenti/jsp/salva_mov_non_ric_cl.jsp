<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbBMP.*,com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"salva_mov_non_ric_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
    /*'Individua se la pagina é in stato inserimento oppure in modifica 
     Vero siamo in modifica 
     Falso siamo in inserimento 
     Viene regolata in base al parametro Modifica Se valorizato*/
  boolean Modifica = false;  
    /* se vero indica che uno dei controlli ha avuto esito negativo
       viene effettuato una redirect non deve continuare la costruzione della pagina*/
  boolean errore =false;
  String strMessaggioFunz = null;
  I5_2MOV_NON_RICEJB remotoejb=null;
      //Codice dell' elemento che deve essere modificato in caso di modifica
  String selCODE_MOVIM=null;
  clsInfoUser aUserInfo =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
  String code_utente = aUserInfo.getUserName();
  
  if (request.getParameter("Modifica")!=null){
    selCODE_MOVIM=request.getParameter("selCODE_MOVIM");
    Modifica=true;
  }

  String codeaccount = request.getParameter("txtCodeAccount"); 
  String codeistanza = request.getParameter("txtCodeIstanza");
  String code_invent = null;
  if (codeistanza==null)
  {
     codeistanza="";
  }
  String strQueryString = request.getQueryString();
  strQueryString=strQueryString + "&Ricarica=1";
  String mese = request.getParameter("numMese"); 
  String anno = request.getParameter("txtAnno");
  String flag_sys = "C";
  String code_account = request.getParameter("txtCodeAccount");
  String code_ogg_fatrz = request.getParameter("txtCodeOggetto");
  String data_oggetto = request.getParameter("txtDataOggetto");
  String desc_mov = request.getParameter("txtDescrizione");
  String importo = request.getParameter("txtImporto");

  String data_fatt = request.getParameter("txtDataFatt");
  java.util.Date data_fatrz = null;
  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
  data_fatrz = df.parse(data_fatt);
  String num_dest = request.getParameter("numDest");
  String tipo_flag_ncf = null; 
  String tipo_flag_da = null; 
  if(num_dest.equals("0")) 
  {
     tipo_flag_ncf = "F";
     tipo_flag_da = "C";
  }
  if(num_dest.equals("1")) 
  {
     tipo_flag_ncf = "F";
     tipo_flag_da = "D";
  }
  if(num_dest.equals("2")) 
  {
     tipo_flag_ncf = "N";
     tipo_flag_da = "C";
  }
  int data_mese = 0;
  int data_anno = 0;
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<TITLE>
</TITLE>
</HEAD>
<BODY>
<EJB:useHome id="home" type="com.ejbSTL.FILTRO_MOV_NON_RICEJBHome" location="FILTRO_MOV_NON_RICEJB" />
<EJB:useBean id="remoto_FILTRO_MOV_NON_RICEJB" type="com.ejbSTL.FILTRO_MOV_NON_RICEJB" scope="session">
<EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
  if (!codeistanza.equals(""))
  {
     code_invent = remoto_FILTRO_MOV_NON_RICEJB.FindIst(codeistanza, codeaccount);
     if (code_invent==null)
     {
        strMessaggioFunz = "Il codice istanza P/S non risulta presente nell'inventario";
        response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset) + "&" + strQueryString);           
        errore=true;
     }
  }
  if (!errore){
    if(num_dest.equals("2"))  
    {
       data_mese = Integer.parseInt(mese);
       data_anno = Integer.parseInt(anno);
       if(remoto_FILTRO_MOV_NON_RICEJB.FindTemp(data_mese, data_anno, codeaccount)==0)
       {
          strMessaggioFunz = "Non esiste fattura per l'account per il periodo selezionato";
          response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset) + "&" + strQueryString);           
          errore=true;          
       }
    }
  }    
  if (!errore){
%>
<EJB:useHome id="homeejb" type="com.ejbBMP.I5_2MOV_NON_RICEJBHome" location="I5_2MOV_NON_RICEJB" />
<%     
    if (Modifica){
%>
<EJB:useHome id="homeI5_2PARAM_VALORIZ_CL" type="com.ejbSTL.I5_2PARAM_VALORIZ_CLHome" location="I5_2PARAM_VALORIZ_CL" />
<EJB:useBean id="remoteI5_2PARAM_VALORIZ_CL" type="com.ejbSTL.I5_2PARAM_VALORIZ_CL" scope="session">
  <EJB:createBean instance="<%=homeI5_2PARAM_VALORIZ_CL.create()%>" />
</EJB:useBean>
<%    
      if (remoteI5_2PARAM_VALORIZ_CL.checkBatch()>0){
        strMessaggioFunz = "Attenzione!Impossibile proseguire a causa della presenza di elaborazioni batch in corso";
        response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset) + "&" + strQueryString);               
      }else{                  
        remotoejb = homeejb.findByPrimaryKey (selCODE_MOVIM);              
        remotoejb.setEseguiStore(true);
        remotoejb.setCode_utente(code_utente);
        remotoejb.setCode_Ogg_Fatrz(code_ogg_fatrz);
        remotoejb.setDATA_INIZIO_VALID_OF(df.parse(data_oggetto));
        if (!codeistanza.equals("")){        
          remotoejb.setCode_invent(code_invent);
        }  
        remotoejb.setDesc_mov(desc_mov);     
        remotoejb.setImpt_Mov_Non_Ric(new java.math.BigDecimal(importo.replace(',','.')));
        remotoejb.setData_fatrb(data_fatrz);   
        remotoejb.setTipo_Flag_Nota_Cred_Fattura(tipo_flag_ncf);
        remotoejb.setTipo_Flag_Dare_Avere(tipo_flag_da);
        remotoejb.setData_mm(mese);          
        remotoejb.setData_aa(anno);                  
        remotoejb.setEseguiStore(false);
      }    
    }else{              
      remotoejb = homeejb.create (flag_sys, code_account, data_oggetto, code_ogg_fatrz, code_utente, code_invent, desc_mov, new java.math.BigDecimal(importo.replace(',','.')), data_fatt, mese, anno, tipo_flag_ncf, tipo_flag_da);
    }      
%>
</BODY>
<SCRIPT language="javascript">
window.location.href="cbn1_lista_mnr_cl.jsp?txtTypeLoad=0";

</SCRIPT>
</HTML>
<%
  }
%>