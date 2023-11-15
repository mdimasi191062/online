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
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
 
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"com_tc.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto -->
<EJB:useHome id="homeEnt_TipiContratto" type="com.ejbSTL.Ent_TipiContrattoHome" location="Ent_TipiContratto" />
<EJB:useBean id="remoteEnt_TipiContratto" type="com.ejbSTL.Ent_TipiContratto" scope="session">
    <EJB:createBean instance="<%=homeEnt_TipiContratto.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_Batch" type="com.ejbSTL.Ent_BatchHome" location="Ent_Batch" />
<EJB:useBean id="remoteEnt_Batch" type="com.ejbSTL.Ent_Batch" scope="session">
    <EJB:createBean instance="<%=homeEnt_Batch.create()%>" />
</EJB:useBean>

<%
  //dichiarazione variabili	
  int i=0;
  int intCount = 0;
  int intAction = -1;
  int intFunzionalita = -1;
  DB_I5_6SysParam objSysParam;
  /*MB Reperisco dal db l'informazione che mi indica se devo abilitare o no le tariffe
    del vecchio jpub */
  Vector vctSysParam = remoteEnt_Batch.getI5_6SysParamValue("TAR");

  if (vctSysParam.size()> 0)
    objSysParam = (DB_I5_6SysParam)vctSysParam.elementAt(0);
  else
    objSysParam = new DB_I5_6SysParam();

  String lstrTitolo = Misc.nh(request.getParameter("strTitolo"));
  String strBgColor="";
  String strDescrizione="";	
  String strChecked = "";
  String strFlagSys = "";
  String strAppoFlag = "C";
  String strAppoFlgForIav = "I";
  String strDestinationPageClassic = Misc.nh(request.getParameter("destinationPageClassic"));
  String strDestinationPageSpecial = Misc.nh(request.getParameter("destinationPageSpecial"));
  String strTCNonAmmessiClassic = Misc.nh(request.getParameter("TCNonAmmessiClassic"));
  String strTCNonAmmessiSpecial = Misc.nh(request.getParameter("TCNonAmmessiSpecial"));
  String strTariffe = Misc.nh(request.getParameter("Tariffe"));
  String strElabAttive = Misc.nh(request.getParameter("ElabAttive"));

  if(request.getParameter("intAction") != null){
    intAction = Integer.parseInt(request.getParameter("intAction"));
  }
  if(request.getParameter("intFunzionalita") != null){
    intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
  }

  String strURL_COM_TC = request.getContextPath() + "/common/jsp/com_tc.jsp";
      strURL_COM_TC += "?strTitolo="+lstrTitolo;
      strURL_COM_TC += "&destinationPageClassic="+strDestinationPageClassic;
      strURL_COM_TC += "&destinationPageSpecial="+strDestinationPageSpecial;
      strURL_COM_TC += "&intAction="+intAction;
      strURL_COM_TC += "&intFunzionalita="+intFunzionalita;
      strURL_COM_TC += "&TCNonAmmessiClassic="+strTCNonAmmessiClassic;
      strURL_COM_TC += "&TCNonAmmessiSpecial="+strTCNonAmmessiSpecial;
  session.setAttribute("URL_COM_TC",strURL_COM_TC); 

%>
<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>Selezione Tipo Contratto</TITLE>
<Script language="JavaScript">
var objForm = null;
function initialize()
{
	objForm = document.frmDati;
}
function ONSELEZIONA()
{
  <%if( (!strTariffe.equals(""))  && (!objSysParam.getCODE_TEXT_VALUE().equals("OLD"))){%>
  if(objForm.hidDescTipoContratto.value == 'CDN'){
    alert('Questa funzionalit� � disponibile dal men� : \"Tariffe (Nuovo)\"');
    return;
  }
  <%}%>

  <%if( (!strElabAttive.equals("")) && (!objSysParam.getCODE_TEXT_VALUE().equals("OLD"))){%>
  if(objForm.hidDescTipoContratto.value == 'CDN'){
    alert('Questa funzionalit� � disponibile dal men� : \"Elab.Attive (Nuovo)\"');
    return;
  }
  <%}%>

	switch(objForm.hidFlagSys.value)
	{
		case "C": //classic
			objForm.action = "<%=request.getContextPath()%>" + objForm.hidDestinationPageClassic.value;
			break;
		case "S": //special
			objForm.action = "<%=request.getContextPath()%>" + objForm.hidDestinationPageSpecial.value;
			break;
	}
    objForm.submit();
}

function selRadio(intIndice){
	objForm.hidDescTipoContratto.value = eval('objForm.hidDescrizione'+intIndice+'.value');
	objForm.hidFlagSys.value = eval('objForm.hidFlag'+intIndice+'.value');
}
</Script>
</HEAD>
<BODY onload="initialize()">
<form name="frmDati" method="post" action=''>
<input type="hidden" name="intAction" value="<%=intAction%>">
<input type="hidden" name="intFunzionalita" value="<%=intFunzionalita%>">
<input type="hidden" name="hidDestinationPageClassic" value="<%=strDestinationPageClassic%>">
<input type="hidden" name="hidDestinationPageSpecial" value="<%=strDestinationPageSpecial%>">
<!-- Immagine Titolo -->
<table align="center" width="90%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td align="left"><img src="../../<%=lstrTitolo%>" alt="" border="0"></td>
  <tr>
</table>
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <%if(!lstrTitolo.equals("")){%>
  
  <%}%>
 
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
	            <tr>
	              <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Selezione Tipo Contratto</td>
	              <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
	            </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="75%" border="0" cellspacing="0" cellpadding="0" align='center'>
<%  Vector lvct_TipiContratto = (Vector)remoteEnt_TipiContratto.getTipiContratto(strTCNonAmmessiClassic,strTCNonAmmessiSpecial); %>
      
      				<tr>
          <td bgcolor='<%=StaticContext.bgColorHeader%>' class='white' colspan="2" >
						<table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
							<tr>
								<td>
								 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
									<tr>
									  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Interventi a Vuoto</td>
									  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
									</tr>
								 </table>
								</td>
							</tr>
						</table>
		            </td>
	        	</tr>
    <% if(lvct_TipiContratto != null) {
            for(i=0;i < lvct_TipiContratto.size();i++)
      {
        DB_TipiContratto objDBTipoContratto = new DB_TipiContratto();
        objDBTipoContratto=(DB_TipiContratto)lvct_TipiContratto.elementAt(i);
		
        if ((i%2)==0){
          strBgColor=StaticContext.bgColorRigaDispariTabella;
        }else{
          strBgColor=StaticContext.bgColorRigaPariTabella;
		}  
           if(objDBTipoContratto.getDESC_TIPO_CONTR().contains("_I")){
           
           String descTMP = objDBTipoContratto.getDESC_TIPO_CONTR().replace("_I"," ");
           
        %>
        
                  <tr>
            <td width='2%'>
				<%if (i==0){
					strDescrizione = objDBTipoContratto.getDESC_TIPO_CONTR();
					strFlagSys = objDBTipoContratto.getFLAG_SYS();
					strChecked = "checked";
				  }else{
				  	strChecked = "";
				  }%>
	              <input type='radio' <%=strChecked%> name='codiceTipoContratto' value='<%=objDBTipoContratto.getCODE_TIPO_CONTR()%>' onclick=selRadio('<%=i%>')>
				  <input type='hidden' name='hidDescrizione<%=i%>' value='<%=descTMP%>'>
				  <input type='hidden' name='hidFlag<%=i%>' value='<%=objDBTipoContratto.getFLAG_SYS()%>'>
            </td>
            <td bgcolor='<%=strBgColor%>' class='text'><%=descTMP%></td>
          </tr>
        
        <%} } }%>
        </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          	<td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
                <sec:ShowButtons td_class="textB"/>
				<input type="hidden" name="hidDescTipoContratto" value="<%=strDescrizione%>">
				<input type="hidden" name="hidFlagSys" value="<%=strFlagSys%>">
	        </td>
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>
</BODY>
</HTML>
