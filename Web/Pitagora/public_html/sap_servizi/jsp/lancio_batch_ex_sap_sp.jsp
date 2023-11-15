
<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"lancio_batch_ex_sap_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggiHome" location="Ent_AnagraficaMessaggi" />
<EJB:useBean id="remoteEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggi" scope="session">
    <EJB:createBean instance="<%=homeEnt_AnagraficaMessaggi.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_ExportPerSap" type="com.ejbSTL.Ent_ExportPerSapHome" location="Ent_ExportPerSap" />
<EJB:useBean id="remoteEnt_ExportPerSap" type="com.ejbSTL.Ent_ExportPerSap" scope="session">
    <EJB:createBean instance="<%=homeEnt_ExportPerSap.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_TipiContratto" type="com.ejbSTL.Ent_TipiContrattoHome" location="Ent_TipiContratto" />
<EJB:useBean id="remoteEnt_TipiContratto" type="com.ejbSTL.Ent_TipiContratto" scope="session">
    <EJB:createBean instance="<%=homeEnt_TipiContratto.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_Batch" type="com.ejbSTL.Ent_BatchHome" location="Ent_Batch" />
<EJB:useBean id="remoteEnt_Batch" type="com.ejbSTL.Ent_Batch" scope="session">
    <EJB:createBean instance="<%=homeEnt_Batch.create()%>" />
</EJB:useBean>


<%
	String strTipoBatch = "";
  String strRewrite = "";
  String strDescrizione="";	
  String strTitoloTipoBatch = "";
  String strConTestate = "";
	String strSenzaTestate = "";
	String strDataInizioCiclo = "";
	String strDataFineCiclo = "";
	String strDataFinePeriodo = "";
  String isRepricing="";
  String isRewrite="";
  String isFatturaManuale="";
	Vector vctDate = new Vector();

  int i=0;
  int intCount = 0;
  int intAction = -1;
  int intFunzionalita = -1;
  

  Integer intCountTabella;
  //######################
  //controllo sul popolamento
  intCountTabella = (Integer)remoteEnt_ExportPerSap.countTestCsvSap();
 
	//######################
	//prime due date
	vctDate = (Vector)remoteEnt_ExportPerSap.getDateCicloFattSap();
	if(vctDate.size() > 0){
		DB_ExportPerSap objDB_ExportPerSap = (DB_ExportPerSap)vctDate.elementAt(0);
		strDataInizioCiclo = (String)objDB_ExportPerSap.getDATA_INIZIO_CICLO_FATRZ();
		strDataFineCiclo = (String)objDB_ExportPerSap.getDATA_FINE_CICLO_FATRZ();
		//strDataFinePeriodo = (String)objDB_ExportPerSap.getDATA_FINE_PERIODO();
	}
	//terza data
	vctDate = (Vector)remoteEnt_ExportPerSap.getDataFinePeriodoSap();
	if(vctDate.size() > 0){
		strSenzaTestate = "";
		DB_ExportPerSap objDB_ExportPerSap = (DB_ExportPerSap)vctDate.elementAt(0);
		strDataFinePeriodo = (String)Misc.nh(objDB_ExportPerSap.getDATA_FINE_PERIODO());
	}
	
	strTipoBatch = request.getParameter("TipoBatch");

  if(strTipoBatch.equals("XDSL"))
     strTitoloTipoBatch = "XDSL";
  else
     strTitoloTipoBatch = "Regolamentati";

  System.out.println("Rewrite ["+request.getParameter("Rewrite")+"]");
  if(request.getParameter("Rewrite") != null)
     strRewrite = request.getParameter("Rewrite");

  String strBgColor="";
  String strChecked = "";
  String strFlagSys = "";
  String strAppoFlag = "C";
     
%>

<html>
<head>
	<title></title>
	<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
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
	<SCRIPT LANGUAGE='Javascript'>
	var objForm = null;
	function initialize(){
  	objForm = document.frmDati;
		//impostazione delle propriet� di default per tutti gli oggetti della form
		setDefaultProp(objForm);
    //selRadio(0);
	}
  function onRepricing()
  {
   var repricing=document.frmDati.isRepricing.checked;
    if(repricing==true)
    {

      document.frmDati.isRepricing.value='R';
      document.frmDati.isFatturaManuale.checked=false;
    }
    else
    {

      document.frmDati.isRepricing.value='V';
    }

  }
  
  function onFatturaManuale()
  {
   var fattMan=document.frmDati.isFatturaManuale.checked;
    if(fattMan==true)
    {

      document.frmDati.isFatturaManuale.value='M';
      document.frmDati.isRepricing.checked=false;
    }
    else
    {

      document.frmDati.isRepricing.value='V';
    }

  }
  
	function onRewrite()
  {

   var rewrite=document.frmDati.isRewrite.checked;
    if(rewrite==true)
    {
        
      tabellaDate.style.visibility="hidden";
      tabellaDate.style.display="none";
      document.frmDati.isRewrite.value='R';
    }
    else
    {

      tabellaDate.style.visibility="visible";
      tabellaDate.style.display="inline";
      document.frmDati.isRewrite.value='N';
    }
  }
  
	function ONLANCIOBATCH(){

		if(validazioneCampi(objForm)){

      if(document.frmDati.isRewrite.value== "N"){
        if(controlloDate()){
          EnableAllControls(objForm);
          objForm.action = "lancio_batch_ex_sap_2_sp.jsp";
          objForm.submit();
        }
      }else{
        EnableAllControls(objForm);
        objForm.action = "lancio_batch_ex_sap_2_sp.jsp";
        objForm.submit();
      }
		}
	}

  function selRadio(intIndice){
    objForm.hidCodTipoContratto.value = eval('objForm.hidCodContr'+intIndice+'.value');
  }

  function controlloDate(){
  var strTipoBatch=objForm.TipoBatch.value;
    if(objForm.hidCodTipoContratto.value != "")
    {
      var dataInizioCiclo = objForm.txtDataInizioCiclo.value;
      var dataFineCiclo = objForm.txtDataFineCiclo.value;
      var dataFinePeriodo;
      var isRepricing='N';
      if(strTipoBatch=="XDSL")
      {
        isRepricing= objForm.isRepricing.value;
      }
      if(isRepricing!='R' )
      {
      
        if(strTipoBatch!="XDSL")
        {
          dataFinePeriodo = objForm.txtDataFinePeriodo.value;
        }
      if(dataInizioCiclo != "")
      {
        if(dataFineCiclo != "")
        {
          if(strTipoBatch!="XDSL")
          {
            if(dataFinePeriodo != "")
            {
              //controllo data fine ciclo;
              if(controlloFineCiclo(dataFineCiclo,dataFinePeriodo))
              {
                //controllo data inizio ciclo
                if(controlloInizioCiclo(dataInizioCiclo,dataFinePeriodo))
                {
                 return true;
                }
                else
                {
                 alert("Attenzione!! La Data Fine Periodo deve essere conpresa nella Data Inizio Ciclo/Data Fine Ciclo.");
                 return false;
                }
              }
              else
              {
               alert("Attenzione!! La Data Fine Periodo deve essere conpresa tra Data Inizio Ciclo e Data Fine Ciclo.");
               return false;
              }
            }
            else
            {
              alert("Attenzione!! La Data Fine Periodo � obbligatoria.");
              return false;
            }
          }
          else
          {
            return true;
          }
        }
        else
        {
          alert("Attenzione!! La Data Fine Ciclo � obbligatoria.");
          return false;
        }
      }else
      {
         alert("Attenzione!! La Data Inizio Ciclo � obbligatoria.");
         return false;
      }
    }
    else
     {


     return true;
    }
    }
    else
    {
      alert("Attenzione!! Selezionare il Tipo Contratto.");
      return false;
    }

}
  function controlloFineCiclo(dataFineCiclo,dataFinePeriodo){
    var tokensDB = dataFineCiclo.split("/");
    var annoDB = tokensDB[2];
    var meseDB = tokensDB[1];
    var giornoDB = tokensDB[0];

    var tokensIns = dataFinePeriodo.split("/");
    var annoIns   = tokensIns[2];
    var meseIns   = tokensIns[1];
    var giornoIns = tokensIns[0];

    if(eval(annoIns) > eval(annoDB)){
      return false;
    }else if(eval(annoIns) < eval(annoDB)){
      return true;
    }else{
      if(eval(meseIns) > eval(meseDB)){
         return false;
      }else if(eval(meseIns) < eval(meseDB)){
         return true;
      }else{
         if(eval(giornoIns) > eval(giornoDB)){
           return false;
         }else{
           return true;
         }
      }
    }
  }

	function controlloInizioCiclo(dataInizioCiclo,dataFinePeriodo){
    var tokensDB = dataInizioCiclo.split("/");
    var annoDB = tokensDB[2];
    var meseDB = tokensDB[1];
    var giornoDB = tokensDB[0];

    var tokensIns = dataFinePeriodo.split("/");
    var annoIns   = tokensIns[2];
    var meseIns   = tokensIns[1];
    var giornoIns = tokensIns[0];

    if(eval(annoIns) < eval(annoDB)){
      return false;
    }else if(eval(annoIns) > eval(annoDB)){
      return true;
    }else{
      if(eval(meseIns) < eval(meseDB)){
         return false;
      }else if(eval(meseIns) > eval(meseDB)){
         return true;
      }else{
         if(eval(giornoIns) < eval(giornoDB)){
           return false;
         }else{
           return true;
         }
      }
    }
  }

  function pulisciDate(){
    objForm.txtDataInizioCiclo.value = '';
    objForm.txtDataFineCiclo.value = '';
    if(objForm.TipoBatch.value!="XDSL")
      objForm.txtDataFinePeriodo.value = '';    
  }
  
	</SCRIPT>
</head>
<body onload = "initialize()">
	<form name="frmDati" method="post" action="">
  <input type="hidden" name="TipoBatch" value="<%= strTipoBatch %>">
  <input type="hidden" name="TitoloTipoBatch" value="<%= strTitoloTipoBatch %>">
  <input type="hidden" name="hidCodTipoContratto" value="">
  <input type="hidden" name="Rewrite" value="<%= strRewrite %>">
		<!-- Immagine Titolo -->
		<table align="center" width="90%"  border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td align="left"><img src="<%=StaticContext.PH_EXPORT_PER_SAP_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
		  <tr>
		</table>
    	<!-- tabella intestazione -->
	  <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lancio Batch Export per Sap - <b><%= strTitoloTipoBatch %></b></td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
					</tr>
				  </table>
				</td>
			</tr>
	  </table>
    <table width="85%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
		 	<tr>
				<td height="30" class="textB">&nbsp;</td>
			</tr>
      <tr>
    <td>
	    <table width="75%" border="0" cellspacing="0" cellpadding="0" align='center'>
<%  Vector lvct_TipiContratto = (Vector)remoteEnt_TipiContratto.getTipiContrattoPS();
    if (lvct_TipiContratto!=null)
    {
        DB_TipiContratto objDBTipoContratto = new DB_TipiContratto();
        objDBTipoContratto=(DB_TipiContratto)lvct_TipiContratto.elementAt(0);
    	int y = 0;	
      for(i=0;i < lvct_TipiContratto.size();i++)
      {
        objDBTipoContratto = new DB_TipiContratto();
        objDBTipoContratto=(DB_TipiContratto)lvct_TipiContratto.elementAt(i);
		
        if ((y%2)==0){
          strBgColor=StaticContext.bgColorRigaDispariTabella;
        }else{
          strBgColor=StaticContext.bgColorRigaPariTabella;
		}
		/*if(!strAppoFlag.equalsIgnoreCase(objDBTipoContratto.getFLAG_SYS()))
		{*/
			if(intCount == 0){%>
				<tr>
          <td bgcolor='<%=StaticContext.bgColorHeader%>' class='white' colspan="2" >
						<table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
							<tr>
								<td>
								 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
									<tr>
									  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Special</td>
									  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
									</tr>
								 </table>
								</td>
							</tr>
						</table>
		            </td>
	        	</tr>
			<%}%>
	  <%	intCount = 1;
	   //}
          /*if(strTipoBatch.equals("XDSL")){*/
             /*if (objDBTipoContratto.getTIPO_SPECIAL().equals("X")){*/%>
	        <tr>
            <td width='2%'>
				<%
          /*if (i==0){
					strDescrizione = objDBTipoContratto.getDESC_TIPO_CONTR();
					strFlagSys = objDBTipoContratto.getFLAG_SYS();
					//strChecked = "checked";
          strChecked = "";
				  }else{
				  	strChecked = "";
				  }*/
          strDescrizione = objDBTipoContratto.getDESC_TIPO_CONTR();
          String profilo = ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserProfile();
          if (
                (
                    (strDescrizione.startsWith("Assurance") || strDescrizione.startsWith("Provisioning"))
                     && (profilo.equals("IAV")
                     )
             ||  (!profilo.equals("IAV"))
                )
             )
          {
          %>
          <input type='radio' <%=strChecked%> name='codiceTipoContratto' value='<%=objDBTipoContratto.getCODE_TIPO_CONTR()%>' onclick=selRadio('<%=i%>');pulisciDate()>
                                  <input type='hidden' name='hidCodContr<%=i%>' value='<%=objDBTipoContratto.getCODE_TIPO_CONTR()%>'>
            </td>
            <td bgcolor='<%=strBgColor%>' class='text'><%=objDBTipoContratto.getDESC_TIPO_CONTR()%></td>
          </tr>
                <%       y++;
             /*}*/
          /*}*/
          }
        }
        if ((y%2)==0){
          strBgColor=StaticContext.bgColorRigaDispariTabella;
        }else{
          strBgColor=StaticContext.bgColorRigaPariTabella;
        }
        %>
        <tr>
        <td width='2%'>
        <input type='radio' <%=strChecked%> name='codiceTipoContratto' value='99' onclick=selRadio('<%=i%>');pulisciDate()>
				<input type='hidden' name='hidCodContr<%=i%>' value='99'>
        </td>
        <td bgcolor='<%=strBgColor%>' class='text'>Tutti</td>
        </tr>
        <%
      }%>
        </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../images/body/pixel.gif" width="1" height='3'></td>
  </tr>

		<tr>
			<td align="center">

				<table width="80%" border="0">
					<tr>
						<td align="center" colspan="2">
            <div id="tabellaDate" name="tabellaDate">
							<table>
                <%if((strTipoBatch.equals("XDSL"))||(strRewrite.equals(""))){%>
								<tr>
									<td class="textB">Data Inizio Ciclo</td>
                  <td class="text">
										<input type='text' name='txtDataInizioCiclo' obbligatorio="si" value='' class="text" readonly>
                    <%--<input type='text' name='txtDataInizioCiclo' obbligatorio="si" value='<%=strDataInizioCiclo%>' class="text" readonly>--%>
                    <a href="javascript:showCalendar('frmDati.txtDataInizioCiclo','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar1' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
										<a href="javascript:clearField(objForm.txtDataInizioCiclo);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel1'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
									</td>
								</tr>
                <tr>
									<td class="textB">Data Fine Ciclo</td>
                  <td class="text">
										<input type='text' name='txtDataFineCiclo' obbligatorio="si" value='' class="text" readonly>
										<%--<input type='text' name='txtDataFineCiclo' obbligatorio="si" value='<%=strDataFineCiclo%>' class="text" readonly>--%>
										<a href="javascript:showCalendar('frmDati.txtDataFineCiclo','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar2' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
										<a href="javascript:clearField(objForm.txtDataFineCiclo);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel2'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
									</td>
                </tr>

				</table>
        </div>
			</td>
		</tr>
    <tr>
      <td align="center">
          <table>
                <tr>

                    <%  if(strTipoBatch.equals("XDSL")) {%>
                      <td class="textB">Repricing:</td>
                      
                        <%} else {%>
                      <td class="textB">Data Fine Periodo</td>
                       <%}%>
                      <td class="text">
                      <%if(strTipoBatch.equals("XDSL")) {%>
                      <input type='checkbox' name='isRepricing'  value='R' onclick="onRepricing();"/>
                      <%} else {%>
                  	<input type='text' name='txtDataFinePeriodo' obbligatorio="si" value='' class="text" readonly="">
										<a href="javascript:showCalendar('frmDati.txtDataFinePeriodo','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar3' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
										<a href="javascript:clearField(objForm.txtDataFinePeriodo);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel3'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
                    <%}%>
									</td>
    
								</tr>
                <tr>
                  
                     <%  if(strTipoBatch.equals("XDSL")) {%>
                    <td class="textB">Fattura/NC Manuale:</td>
                        <%}%>
                  <td class="textB">
                    <%if(strTipoBatch.equals("XDSL")) {%>
                    <input type='checkbox' name='isFatturaManuale'  value='M' onclick="onFatturaManuale();"/>
                    <%}%>
                  </td>
                
                </tr>
                <tr>
                  <%if(strTipoBatch.equals("XDSL")) {%>
                  <td class="textB">Rewrite:</td>
                 
                  <td class="text">
                      <input type='checkbox' name='isRewrite' id='isRewrite' value='N' onclick="onRewrite();"/>      						
                  </td>
                    <%}%>
                </tr>
							</table>
						</td>
					</tr>
          <%}%>
</table>
</td>
</tr>
		<tr>
			<td colspan="2" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
		</tr>
	</table>

	<!--PULSANTIERA-->
	<table width="80%" border="0" cellspacing="0" cellpadding="0" align='center'>
		<tr>
			<td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
		</tr>
	</table>
	<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
	  <tr>
	    <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
	         <sec:ShowButtons td_class="textB"/>
	    </td>
	  </tr>
	</table>
	</form>
</body>
</html>