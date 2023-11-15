<%@ page contentType="text/html" %>
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
<%@ page import="com.usr.*"%>
<%@ page import="java.sql.Clob" %>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
  <%=StaticMessages.getMessage(3006,"tmlrisorsaMsg.jsp")%>
</logtag:logData>


<EJB:useHome id="homeCtr_Utility" type="com.ejbSTL.Ctr_UtilityHome" location="Ctr_Utility" />
<EJB:useBean id="remoteCtr_Utility" type="com.ejbSTL.Ctr_Utility" scope="session">
    <EJB:createBean instance="<%=homeCtr_Utility.create()%>" />
</EJB:useBean>
<%
  String codeInvent = Misc.nh(request.getParameter("codeInvent"));
  //mlRisorsaDett vcttmlrisorsaDett = null;
  //vcttmlrisorsaDett = remoteCtr_Utility.getTmlRisorsaDett(IdRisorsa);
  TmlRisorsaDett  elem=new TmlRisorsaDett();
  elem=remoteCtr_Utility.getTmlRisorsaDett(codeInvent);
  /*String o_code_num_td = elem.geto_code_num_td();
  String o_stato_risorsa = elem.geto_stato_risorsa();
  String o_code_lotto = elem.geto_code_lotto();
  String o_flag_trasporto = elem.geto_flag_trasporto();
  String o_id_accesso = elem.geto_id_accesso();
  String o_tecnologia_fibra = elem.geto_tecnologia_fibra();
  String o_flag_qualifica = elem.geto_flag_qualifica();
  String o_flag_test2 = elem.geto_flag_test2();
  String o_tipo_cluster = elem.geto_tipo_cluster();
  String o_code_cluster = elem.geto_code_cluster();
  String o_codice_interfaccia = elem.geto_codice_interfaccia();
  String o_id_ord_crmws = elem.geto_id_ord_crmws();*/
  String o_messaggio = elem.geto_messaggio();
  %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title></title>
<script language="Javascript" type="text/javascript" src="../edit_area/edit_area_full.js"></script>
    <script language="Javascript" type="text/javascript">
        // initialisation
        editAreaLoader.init({
            id: "example_1"    // id of the textarea to transform       
            ,start_highlight: true    // if start with highlight
            ,allow_resize: "both"
            ,allow_toggle: true
            ,word_wrap: true
            ,language: "en"
            ,syntax: "xml"  
            ,toolbar: "select_font"
           
        });
</SCRIPT>        
<SCRIPT LANGUAGE="JavaScript">
	var objForm = null;
	function initialize(){
  	objForm = document.frmDati;
		//impostazione delle propriet? di default per tutti gli oggetti della form
		setDefaultProp(objForm);
  }

</SCRIPT>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
</head>
<BODY>
<table width="100%">
<tr>
<td width=5%></td>
<td width=95%><img src="../images/TimeLineRisorsa.gif" alt="" border="0">
</td>
</tr>
</table>
<textarea  id="example_1" style="height: 350px; width: 100%;" name="test_1">
    <%=o_messaggio%>
    </textarea>
    
</body>
</html>