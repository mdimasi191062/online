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
<%@ page import="org.apache.log4j.extras.*" %>
<%@ page import="com.utl.*" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
  <%=StaticMessages.getMessage(3006,"tmlrisorsaDett.jsp")%>
</logtag:logData>


<EJB:useHome id="homeCtr_Utility" type="com.ejbSTL.Ctr_UtilityHome" location="Ctr_Utility" />
<EJB:useBean id="remoteCtr_Utility" type="com.ejbSTL.Ctr_Utility" scope="session">
    <EJB:createBean instance="<%=homeCtr_Utility.create()%>" />
</EJB:useBean>
<%
  String codeInvent = Misc.nh(request.getParameter("codeInvent"));
//  String idRisorsa = Misc.nh(request.getParameter("idRisorsa"));
  Vector vctTimeLineScarti = new Vector();  
  vctTimeLineScarti = remoteCtr_Utility.getTimeLineScarti(codeInvent);  
  //mlRisorsaDett vcttmlrisorsaDett = null;
  //vcttmlrisorsaDett = remoteCtr_Utility.getTmlRisorsaDett(IdRisorsa);
  TmlRisorsaDett  elem=new TmlRisorsaDett();
  elem=remoteCtr_Utility.getTmlRisorsaDett(codeInvent);
  boolean vuoto = false;
  String o_code_istanza_ps ="";
  String o_code_num_td = "";
  String o_stato_risorsa = "";
  String o_code_lotto = "";
  String o_flag_trasporto = "";
  String o_id_accesso = "";
  String o_tecnologia_fibra = "";
  String o_flag_qualifica = "";
  String o_flag_test2 = "";
  String o_tipo_cluster = "";
  String o_code_cluster = "";
  String o_codice_interfaccia = "";
  String o_id_ord_crmws = "";
  String o_messaggio = "";
  String o_code_clli ="";
  String o_code_doc ="";  
  String o_code_ogg_fatrz = "";
  String o_code_promozione = "";
  String o_codice_progetto = "";
  String o_code_pr_tariffa = "";
  String o_code_riga = "";
  String o_code_tariffa = "";
  String o_data_da = "";
  String o_data_a = "";
  String o_data_dro = "";  
  String o_data_inizio_fatrz = "";
  Double o_impt_riga = 0.0;  
  
  String o_code_clliNC ="";
  String o_code_docNC ="";  
  String o_code_ogg_fatrzNC = "";
  String o_code_promozioneNC = "";
  String o_codice_progettoNC = "";
  String o_code_pr_tariffaNC = "";
  String o_code_rigaNC = "";
  String o_code_tariffaNC = "";
  String o_data_daNC = "";
  String o_data_aNC = "";
  String o_data_inizio_fatrzNC = "";
  Double o_impt_rigaNC = 0.0;  
  if (elem!=null) {
    o_code_istanza_ps = elem.geto_code_istanza_ps();
    o_code_num_td = elem.geto_code_num_td();
    o_stato_risorsa = elem.geto_stato_risorsa();
    o_code_lotto = elem.geto_code_lotto();
    o_flag_trasporto = elem.geto_flag_trasporto();
    o_id_accesso = elem.geto_id_accesso();
    o_tecnologia_fibra = elem.geto_tecnologia_fibra();
    o_flag_qualifica = elem.geto_flag_qualifica();
    o_flag_test2 = elem.geto_flag_test2();
    o_tipo_cluster = elem.geto_tipo_cluster();
    o_code_cluster = elem.geto_code_cluster();
    o_codice_interfaccia = elem.geto_codice_interfaccia();
    o_id_ord_crmws = elem.geto_id_ord_crmws();
    o_messaggio = elem.geto_messaggio();
  }
  else
  { vuoto = true;}
  //ultima fattura
  TmlRisorsaDett  elemFatt=new TmlRisorsaDett();
  elemFatt=remoteCtr_Utility.getTmlUltFatt(codeInvent);
  boolean vuotoUltFatt = false;
  if (elemFatt!=null) {
    o_code_clli = elemFatt.geto_code_clli();
    o_code_doc = elemFatt.geto_code_doc();    
    o_codice_progetto = elemFatt.geto_codice_progetto();
    o_code_ogg_fatrz = elemFatt.geto_code_ogg_fatrz();
    o_code_promozione = elemFatt.geto_code_promozione();
    o_code_pr_tariffa = elemFatt.geto_code_pr_tariffa();
    o_code_riga = elemFatt.geto_code_riga();
    o_code_tariffa = elemFatt.geto_code_tariffa();
    o_data_da = elemFatt.geto_data_da();
    o_data_a = elemFatt.geto_data_a();
    o_data_inizio_fatrz = elemFatt.geto_data_inizio_fatrz();
    o_impt_riga = elemFatt.geto_impt_riga();
  }
  else
  { vuotoUltFatt = true;}
  
  TmlRisorsaDett  elemNC=new TmlRisorsaDett();
  elemNC=remoteCtr_Utility.getTmlUltNC(codeInvent);
  boolean vuotoUltNC = false;
  if (elemNC!=null) {
    o_code_clliNC = elemNC.geto_code_clli();
    o_code_docNC = elemNC.geto_code_doc();    
    o_codice_progettoNC = elemNC.geto_codice_progetto();
    o_code_ogg_fatrzNC = elemNC.geto_code_ogg_fatrz();
    o_code_promozioneNC = elemNC.geto_code_promozione();
    o_code_pr_tariffaNC = elemNC.geto_code_pr_tariffa();
    o_code_rigaNC = elemNC.geto_code_riga();
    o_code_tariffaNC = elemNC.geto_code_tariffa();
    o_data_daNC = elemNC.geto_data_da();
    o_data_aNC = elemNC.geto_data_a();
    o_data_inizio_fatrzNC = elemNC.geto_data_inizio_fatrz();
    o_impt_rigaNC = elemNC.geto_impt_riga();
  }
  else
  { vuotoUltNC = true;}
  %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title></title>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/inputValue.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/comboCange.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../elab_attive/js/ElabAttive.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	var objForm = null;
	function initialize(){
  	objForm = document.frmDati;
		//impostazione delle propriet? di default per tutti gli oggetti della form
		setDefaultProp(objForm);
  }
   function apriMessaggio(codeInvent)
  {
    //alert("Xml: "+document.frmDati.msgHid.value);
    window.open("tmlrisorsaMsg.jsp?codeInvent="+codeInvent); 
    /*frmDati.action = 'tmlrisorsaMsg.jsp' + codeInvent;
    frmDati.submit();*/
  }

</SCRIPT>

</head>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<BODY onload = "initialize();">
<table width="100%">
<td width=5%></td>
<td width=95%><img src="../images/TimeLineRisorsa.gif" alt="" border="0">
</td>
</table>
<form name="frmDati" method="post" action="">
<input type="hidden" name="hidTypeLoad" value="">
<table name="tblElab" id="tblElab" align=center width="90%" border="0" cellspacing="0" cellpadding="0" height="100%" >
<tr height="20">
  <td>
    <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Dettaglio TimeLine della Risorsa</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  
    <table width="100%" cellspacing="1" align="center">
    <% if (!vuoto) {%>
        <tr class="rowHeader" height="20" align="center">
            <td >Identificativo Risorsa</td>
            <td >Stato Risorsa</td>      
            <td >Code Num TD</td>      
            <td >Code Lotto</td>      
            <td >Flag Trasporto</td>
            <td >ID Accesso</td>                  
            <td >Tecnologia Fibra</td>      
            <td >Flag Qualifica</td>
            <td >Flag Test2</td>
            <td >Tipo Cluster</td>
            <td >Code Cluster</td>
            <td >Codice Interfaccia</td>
            <td >Id Ord Crmws</td>
<%out.flush();%>
        </tr>
           <TR>
            <td  class="row1" align="center"><%=o_code_istanza_ps%></td>  
            <td  class="row1" align="center"><%=o_stato_risorsa%></td>  
            <td  class="row1" align="center"><%=o_code_num_td%></td>  
            <td  class="row1" align="center" ><a href="tmlrisorsa.jsp?operazione=2&txtIdRisorsa=<%=o_code_lotto%>"> <%=o_code_lotto%></a></td> 
            <td  class="row1" align="center"><%=o_flag_trasporto%></td> 
            <td  class="row1" align="center"><%=o_id_accesso%></td> 
            <td  class="row1" align="center"><%=o_tecnologia_fibra%></td> 
            <td  class="row1" align="center"><%=o_flag_qualifica%></td> 
            <td  class="row1" align="center"><%=o_flag_test2%></td>
            <td  class="row1" align="center"><%=o_tipo_cluster%></td>
            <td  class="row1" align="center"><%=o_code_cluster%></td>
            <td  class="row1" align="center"><%=o_codice_interfaccia%></td>   
            <td  class="row1" align="center" ><%=o_id_ord_crmws%>
            <% 
                if (o_messaggio==null||o_messaggio.equals("null")) { %>
                    
            <% } else { %>
                    <input class="textB" title="Dettaglio" type="button" maxlength="30" name="cmdDettaglio" bgcolor="<%=StaticContext.bgColorFooter%>" value="..." onClick="apriMessaggio('<%=codeInvent%>');">
            <% } %>
            </td>  
            </TR>
            <% } else { %>
            <tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
          <td width="8%" height="20" class="textB" align="center">Risorsa non presente in interfaccia per il seguente codice inventario <%=codeInvent%></td>
        </tr>
      <%}%>
    </table>
  </TD>
</tr>
<tr height="20">
  <td>
    <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Dettaglio Ultima Fattura</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>

    <table width="100%" cellspacing="1" align="center">
    <% if (!vuotoUltFatt) {%>
        <tr class="rowHeader" height="20" align="center">
            <td >Code Riga</td>
            <td >Code DOC</td>      
            <td >Oggetto Fatturazione</td>
            <td >Codice Cliente</td>
            <td >Codice Progetto</td>      
            <td >Code Tariffa</td>            
            <td >Code PR Tariffa</td>             
            <td >Codice Promozione</td>                  
            <td >Data DA</td>
            <td >Data A</td>
            <td >Importo Riga</td>            
            <td >Data Inizio Fatturazione</td>

<%out.flush();%>
        </tr>
           <TR>
            <td  class="row1" align="center"><%=o_code_riga%></td>           
            <td  class="row1" align="center"><%=o_code_doc%></td> 
            <td  class="row1" align="center"><%=o_code_ogg_fatrz%></td> 
            <td  class="row1" align="center"><%=o_code_clli%></td>  
            <td  class="row1" align="center"><%=o_codice_progetto%></td>  
            <td  class="row1" align="center"><%=o_code_tariffa%></td>
            <td  class="row1" align="center"><%=o_code_pr_tariffa%></td> 
            <td  class="row1" align="center"><%=o_code_promozione%></td> 
            <td  class="row1" align="center"><%=o_data_da%></td>
            <td  class="row1" align="center"><%=o_data_a%></td>
            <td  class="row1" align="center"><%=o_impt_riga%></td>  
            <td  class="row1" align="center"><%=o_data_inizio_fatrz%></td>               
            </TR>
            <% } else { %>
            <tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
          <td width="8%" height="20" class="textB" align="center">Dati fattura non presenti per codice inventario <%=codeInvent%></td>
        </tr>
      <%}%>
    </table>
  </TD>
</tr>
<tr height="20">
  <td>
    <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Dettaglio Ultima Nota di Credito</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>

    <table width="100%" cellspacing="1" align="center">
    <% if (!vuotoUltNC) {%>
        <tr class="rowHeader" height="20" align="center">
            <td >Code Riga</td>
            <td >Code DOC</td>      
            <td >Oggetto Fatturazione</td>
            <td >Codice Cliente</td>
            <td >Codice Progetto</td>      
            <td >Code Tariffa</td>            
            <td >Code PR Tariffa</td>             
            <td >Codice Promozione</td>                  
            <td >Data DA</td>
            <td >Data A</td>
            <td >Importo Riga</td>            
            <td >Data Inizio Fatturazione</td>

<%out.flush();%>
        </tr>
           <TR>
            <td  class="row1" align="center"><%=o_code_rigaNC%></td>           
            <td  class="row1" align="center"><%=o_code_docNC%></td> 
            <td  class="row1" align="center"><%=o_code_ogg_fatrzNC%></td> 
            <td  class="row1" align="center"><%=o_code_clliNC%></td>  
            <td  class="row1" align="center"><%=o_codice_progettoNC%></td>  
            <td  class="row1" align="center"><%=o_code_tariffaNC%></td>
            <td  class="row1" align="center"><%=o_code_pr_tariffaNC%></td> 
            <td  class="row1" align="center"><%=o_code_promozioneNC%></td> 
            <td  class="row1" align="center"><%=o_data_daNC%></td>
            <td  class="row1" align="center"><%=o_data_aNC%></td>
            <td  class="row1" align="center"><%=o_impt_rigaNC%></td>  
            <td  class="row1" align="center"><%=o_data_inizio_fatrzNC%></td>               
            </TR>
            <% } else { %>
            <tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
          <td width="8%" height="20" class="textB" align="center">Dati Nota di Credito non presenti per codice inventario <%=codeInvent%></td>
        </tr>
      <%}%>
    </table>
  </TD>
</tr>
<tr height="20">
  <td>
    <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Dettaglio Scarti da recuperare</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	
    <table width="100%" cellspacing="1" align="center">
      <%if(vctTimeLineScarti.size()!=0){%>
        <tr class="rowHeader" height="20" align="center">
            <td >Codice Interfaccia</td>      
            <td >Data DRO</td>      
            <td >Tipo Cluster</td>      
            <td >Code Cluster</td>            
            <td >Teconologia Fibra</td>      
            <td >Flag Qualifica</td>
            <td >Id Ord Crmws</td>
            <td >Code Num TD</td>
            <td >Code Lotto</td>
            <td >Flag Trasporto</td>
            <td >Id Accesso</td>
            <td >Flag Test2</td>
        </tr>
      <% 
  out.flush();
     String classRow = "row2"; 
        for(int i=0;i < vctTimeLineScarti.size();i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           DB_TimeLineScart objUtility = (DB_TimeLineScart)vctTimeLineScarti.get(i);
           %>
           <TR>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_ITRF_FAT_XDSL()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_DRO()%></td>  
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTIPO_CLUSTER()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_CLUSTER()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTECNOLOGIA_FIBRA()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getFLAG_QUALIFICA()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getID_ORD_CRMWS()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_NUM_TD()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_LOTTO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getFLAG_TRASPORTO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getID_ACCESSO()%></td>            
            <td  class="<%=classRow%>" align="center"><%=objUtility.getFLAG_TEST2()%></td>            
            </TR>
           <%
           }
      }
      else{%>
        <tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
          <td width="8%" height="20" class="textB" align="center">Nessun dato da visualizzare!</td>
        </tr>
      <%}%>
    </table>
  </TD>
</tr>
</TABLE>
</FORM>
</body>
</html>