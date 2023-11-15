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
<%@ page import="com.ejbSTL.Ent_TipiCausale"%>
<%@ page import="com.ejbSTL.Ent_TipiCausaleHome"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.utl.*" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_Tipo_Causale_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="home" type="com.ejbSTL.Ent_TipiCausaleHome" location="Ent_TipiCausale" />
<EJB:useBean id="remoteEnt_TipiCausale" type="com.ejbSTL.Ent_TipiCausale" scope="session">
    <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<%
    int intAction;
    System.out.println("QUERYSTRING: " + request.getQueryString());
    if(request.getParameter("intAction") == null){
        intAction = StaticContext.LIST;
    }else{
        intAction = Integer.parseInt(request.getParameter("intAction"));
    }
    int intFunzionalita;
	if(request.getParameter("intFunzionalita") == null){
		intFunzionalita = StaticContext.FN_TARIFFA;
	}else{
		intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
	}
    String strCodeTipoContratto = Misc.nh(request.getParameter("CodeTipoContratto"));
	String strCodeCliente = Misc.nh(request.getParameter("CodeCliente"));
	String strCodeContr = Misc.nh(request.getParameter("CodeContr"));
	String strCodePs = Misc.nh(request.getParameter("CodePs"));
	String strCodePrestAgg = Misc.nh(request.getParameter("CodePrestAgg"));
	String strCodeOggFatt = Misc.nh(request.getParameter("CodeOggFatt"));
    
    Vector lvct_TipiCausali = remoteEnt_TipiCausale.getTipiCausale(intAction,
                                                                  intFunzionalita,
                                                                  strCodePs,
                                                                  strCodeCliente,
                                                                  strCodeContr,
                                                                  strCodePrestAgg,
                                                                  strCodeTipoContratto,
																  strCodeOggFatt);
  %>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
	<TITLE>Selezione Tipo Causale</TITLE>
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
	var objForm;
	function initialize(){
		objForm = document.frmDati;
	}
	function click_cmdConferma(){
		if (opener && !opener.closed) 
		{
			
			var lstr_CodeTipiCausali="";
			var lstr_DescrizioniTipiCausali="";
		    if(objForm.chkTipoCausale.length==null){
		        if (objForm.chkTipoCausale.checked)
		        {
		          lstr_CodeTipiCausali=objForm.chkTipoCausale.value.split("|")[0];
				  lstr_DescrizioniTipiCausali=objForm.chkTipoCausale.value.split("|")[1];
		        }
		    }else{
		        for(i=0;i < objForm.chkTipoCausale.length; i++){
		            if(objForm.chkTipoCausale[i].checked){
						if(lstr_CodeTipiCausali==""){
		                	lstr_CodeTipiCausali=objForm.chkTipoCausale[i].value.split("|")[0];
							lstr_DescrizioniTipiCausali=objForm.chkTipoCausale[i].value.split("|")[1];
						}else{
							lstr_CodeTipiCausali+="*"+objForm.chkTipoCausale[i].value.split("|")[0];
							lstr_DescrizioniTipiCausali+=" - "+objForm.chkTipoCausale[i].value.split("|")[1];
						}
		            }
		        }
		    }
		
		  	if(lstr_CodeTipiCausali==""){
		  	  	window.alert("Attenzione!\n Bisogna selezionare almeno un tipo causale");
			}
		  	else{
		  		opener.dialogWin.returnedValue=lstr_CodeTipiCausali;
				opener.dialogWin.returnedValue1=lstr_DescrizioniTipiCausali;
				opener.dialogWin.returnFunc();
				self.close();
		  	}
		    
			
		}
		else{ 
			alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
			self.close();
		}
	  	
	}
	function click_cmdAnnulla(){
		if (opener && !opener.closed) 
		{
						
		}
		else{ 
			alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
		}
	  	self.close();
	}
	</SCRIPT>
</HEAD>
<BODY onload="initialize();">
<form name="frmDati" method="post">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
        <tr>
            <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Selezione Tipo Causale per Tipologia di Contratto</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
                  </tr>
              </table>
            </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="80%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
            <td>
				
            	<table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                <tr>
                    <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                        <tr>
                          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Tipo Causale</td>
                          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
				  <tr>
                    <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	                    <tr>
	                      <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
	                    </tr>
	                <% if ((lvct_TipiCausali==null)||(lvct_TipiCausali.size()==0)){%>
	                          <tr>
	                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="3" class="textB" align="center">No Record Found</td>
	                          </tr>
	                <%}else{
							String bgcolor="";
	                      	for (int i=0;i<lvct_TipiCausali.size(); i++){
		                        DB_TipoCausale lobj_TipoCausale=new DB_TipoCausale();
		                        lobj_TipoCausale=(DB_TipoCausale)lvct_TipiCausali.elementAt(i);
		                        if ((i%2)==0){
		                          bgcolor=StaticContext.bgColorRigaDispariTabella;
		                        }else{
		                          bgcolor=StaticContext.bgColorRigaPariTabella;
		                        } 
		                        %>	
								<%String strDescrizione="";%>						
								<%if(lobj_TipoCausale.getCODE_TIPO_CAUS().equals("5")){%>
									<%strDescrizione="AMPLIAMENTO";%>
								<%}else{%>
									<%strDescrizione=lobj_TipoCausale.getDESC_TIPO_CAUS();%>
								<%}%>
		                        <tr>
		                          <td width='2%' bgcolor="<%=StaticContext.bgColorCellaBianca%>">
		                            <input bgcolor="<%=StaticContext.bgColorCellaBianca%>" type='checkbox' name='chkTipoCausale' value='<%=lobj_TipoCausale.getCODE_TIPO_CAUS()%>|<%=strDescrizione%>'>
		                          </td>
								  <td bgcolor='<%=bgcolor%>' class='text'><%=strDescrizione%></td>
		                        </tr>
	                     	<%}%>
						<%}%>
	                    <tr>
	                      <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
	                    </tr>
	                  </table>
					 </td>
					</tr>
				</table>
                </td>
              </tr>
            </table>
		</td>
	</tr>
	<tr>
  	<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	     <tr>
            <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
          </tr>
		  <tr>
     		<td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center" colspan="5">
				<input type="button" class="textB" name="cmdConferma" value="Conferma" onClick="click_cmdConferma();">
				<input type="button" class="textB" name="cmdAnnulla" value="Annulla" onClick = "click_cmdAnnulla();">
	        </td>
	      </tr>
	    </table>
	</td>
  </tr>
</table>
</form>
</BODY>
</HTML>