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
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<sec:ChkUserAuth isModal="true"/>
<EJB:useHome id="homeEnt_Scarti" type="com.ejbSTL.Ent_ScartiHome" location="Ent_Scarti" />
<EJB:useBean id="remoteEnt_Scarti" type="com.ejbSTL.Ent_Scarti" scope="session">
    <EJB:createBean instance="<%=homeEnt_Scarti.create()%>" />
</EJB:useBean>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_scarti_cl.jsp")%>
</logtag:logData>
<%	
	String strCodeElabPerScarti = Misc.nh(request.getParameter("hidCodeElab"));
	String strCodeAccountPerScarti = Misc.nh(request.getParameter("hidCodeAccountPerScarti"));
	String strCodeFunz = Misc.nh(request.getParameter("hidCodeFunz"));
	String strCodeTestSpesaCompl = Misc.nh(request.getParameter("hidCodeTestSpesaCompl"));
	
	String strCodiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
	String strDescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));
	String strDescAccount = Misc.nh(request.getParameter("hidDescAccount"));
	String strOggetto = "";
	String strCodice = "";
	int intAction;
	int intFunzionalita;
	if(request.getParameter("intAction") == null){
	  intAction = StaticContext.LIST;
	}else{
	  intAction = Integer.parseInt(request.getParameter("intAction"));
	}
	if(request.getParameter("intFunzionalita") == null){
		intFunzionalita = StaticContext.FN_TARIFFA;
	}else{
		intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
	}
//paginatore
int intRecXPag = 0;
int intRecTotali = 0;
if(request.getParameter("cboNumRecXPag")==null)
	intRecXPag=0;
else
	intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
String strtypeLoad = request.getParameter("hidTypeLoad");
String strSelected = "";
int i=0;

%>
<html>
<title>SCARTI</title>
<head>
	<link rel="STYLESHEET" type="text/css" HREF="<%=StaticContext.PH_CSS%>Style.css">
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
        function initialize()
        {
			objForm = document.frmDati;
			//impostazione delle propriet� di default per tutti gli oggetti della form
			setDefaultProp(objForm);
			if(objForm.chkScarto == null){
				Disable(objForm.CONFERMA);
			}
        }
		function ONCONFERMA(){
			if(checkContinua())
      {
        window.alert(objForm.chkScarto);
				preparePageFields()
				objForm.action="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>cbn1_scarti_2_cl.jsp";
				//objForm.submit();
			}
		}
    function ONANNULLA(){	
			self.close();
		}
		function preparePageFields()
		{
			var strAppo = "";
			var i = 0;
			if(objForm.chkScarto.length==null)
      {
				strAppo = objForm.chkScarto.value + "=" + valueChecked(objForm.chkScarto.checked);
			}
      else
      {
				for(i=0;i<objForm.chkScarto.length;i++)
				{
					if(strAppo != "")
          {
						strAppo +=  "|" + objForm.chkScarto[i].value + "=" + valueChecked(objForm.chkScarto[i].checked);
					}
          else
          {
						strAppo += objForm.chkScarto[i].value + "=" + valueChecked(objForm.chkScarto[i].checked);
					}
				}
			}
			objForm.hidViewState.value = strAppo;
		}
		function valueChecked(pstrCheck){
			if(pstrCheck==true){
				return "S";
			}else{
				return "N";
			}
		}
	 </SCRIPT>
</head>
<body onload="initialize()">
<form name="frmDati" method="post" action=''>
<input type="hidden" name="intAction" value="<%=intAction%>">
<input type="hidden" name="hidDescTipoContratto" value="<%=strDescTipoContratto%>">
<input type="hidden" name="intFunzionalita" value="<%=intFunzionalita%>">
<input type="hidden" name="hidViewState" value="">
<input type="hidden" name="hidCodeAccountPerScarti" value="">
<input type="hidden" name="hidTypeLoad" value="">


<input type="hidden" name="hidCodeAccountPerScarti" value="<%=strCodeAccountPerScarti%>">
<input type="hidden" name="hidCodeFunz" value="<%=strCodeFunz%>">
<input type="hidden" name="hidCodeTestSpesaCompl" value="<%=strCodeTestSpesaCompl%>">
<input type="hidden" name="codiceTipoContratto" value="<%=strCodiceTipoContratto%>">
<input type="hidden" name="hidDescTipoContratto" value="<%=strDescTipoContratto%>">
<input type="hidden" name="hidDescAccount" value="<%=strDescAccount%>">






    <table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src="<%=StaticContext.PH_VALORIZZAZIONEATTIVA_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
      </tr>
      <tr>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
      </tr>
      <tr>
      <tr>
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <tr>
              <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Visualizzazione scarti</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
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
          <table width="90%" border="0" cellspacing="0" cellpadding="1" align='center'>
            <tr>
              <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>">
                        <tr>
                          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Riepilogo Scarti</td>
                          <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                        <tr>
                          <td width="15%" height="30" align="left" class="textB">Account</td>
                          <td width="40%" height="30" align="left" class="text"><%=strDescAccount%></td>
                          <td width="25%" height="30" align="left" class="textB">Risultati per pag.:&nbsp;</td>
                          <td width="25%" height="30" align="left" class="text">
                            <select class="text" name="cboNumRecXPag" onchange="reloadPage('1','cbn1_scarti_cl.jsp');">
<%
if (intRecXPag==0)
  strSelected = "selected";
else
strSelected = "";
%>
                              <option selected class="text" value="0">Tutti</option>
<%
for(int k = 5;k <= 50; k=k+5)
{
  if(k==intRecXPag)
    strSelected = "selected";
  else
  strSelected = "";
%>
                              <option <%=strSelected%> class="text" value="<%=k%>"><%=k%></option>
<%
}
%>
                            </select>
                          </td>
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
                <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
                  <tr>
                    <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                        <tr>
                          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Riepilogo Scarti</td>
                          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <table width="100%" border="0" cellspacing="1" cellpadding="1" align="center">
                        <tr bgcolor="<%=StaticContext.bgColorFooter%>">
                          <td>&nbsp;</td>
                          <td class="textB">Tipo</td>
                          <td class="textB">Motivo</td>
                          <td class="textB">Oggetto</td>
                          <td class="textB">Codice</td>
                        </tr>
<%
String strChecked = "";
String strBgColor = StaticContext.bgColorRigaDispariTabella;
Vector lvct_Scarti = null;
// carico il vettore
int typeLoad=0;
if (strtypeLoad!=null)
{
  Integer tmptypeLoad=new Integer(strtypeLoad);
  typeLoad=tmptypeLoad.intValue();
}
if (typeLoad!=0)
  lvct_Scarti = (Vector) session.getAttribute("lvct_Scarti");
else
{
  lvct_Scarti = (Vector)remoteEnt_Scarti.getScarti(intAction,
                                                   strCodeAccountPerScarti,
                                                   strCodeFunz,
                                                   strCodeTestSpesaCompl,
                                                   strCodeElabPerScarti);
  if (lvct_Scarti!=null)
    session.setAttribute("lvct_Scarti", lvct_Scarti);
}

intRecTotali = lvct_Scarti.size();


if ((lvct_Scarti==null)||(lvct_Scarti.size()==0))
{
%>
                        <tr>
                          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="5" class="text" align="center">Nessuno Scarto Presente!</td>
                        </tr>

<%
}
else
{
  int numRec=0;
  if (intRecXPag==0)
    numRec=intRecTotali;
  else
    numRec=intRecXPag;
  
%>
<pg:pager maxPageItems="<%=numRec%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
<%
  for(i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < intRecTotali) && (i < pagerPageNumber.intValue()*numRec));i++)	
//  for(int i=0;i < lvct_Scarti.size();i++)
  {
    DB_Scarti objScarto = new DB_Scarti();
    objScarto=(DB_Scarti)lvct_Scarti.elementAt(i);
    if ((i%2)==0)
        strBgColor=StaticContext.bgColorRigaDispariTabella;
    else
        strBgColor=StaticContext.bgColorRigaPariTabella;
    strChecked="";
    if(objScarto.getTIPO_FLAG_STATO_SCARTO().equalsIgnoreCase("S"))
      strChecked = "checked";
    else
    strChecked = "";
						
    strOggetto = "ACCOUNT";
    strCodice = objScarto.getCODE_ACCOUNT();
    if(!objScarto.getCODE_MOV_NON_RIC().equals(""))
    {
      strOggetto = "Movimento non ricorrente";
      strOggetto =objScarto.getCODE_MOV_NON_RIC();
    }
    if(!objScarto.getCODE_INVENT().equals(""))
    {
      strOggetto = "Codice TD";
      strCodice = objScarto.getCODE_ISTANZA_PS();
    }
%>
                        <tr bgcolor="<%=strBgColor%>">
                          <td class="text">
            								<input type="checkbox" name="chkScarto" value="<%=objScarto.getCODE_SCARTO()%>" <%=strChecked%>>
                          </td>
                          <td class="text" align="center"><%=objScarto.getTIPO_FLAG_TIPO_SCARTO()%></td>
                          <td class="text"><%=objScarto.getDESC_MOTIVO_SCARTO()%></td>
                          <td class="text" nowrap><%=strOggetto%></td>
                          <td class="text" nowrap><%=strCodice%></td>
                        </tr>
<%
  }
%>
<pg:index>
                        </tr>
                        <tr>
                          <td colspan="5" class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
                            Risultati Pag.
<pg:prev> 
                            <A HREF="javaScript:goPage('<%= pageUrl %>')"  onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
</pg:prev>
<pg:pages>
<%
if (pageNumber == pagerPageNumber)
{
%>
                            <b><%= pageNumber %></b>&nbsp;
<%
}
else
{
%>
                            <A HREF="javaScript:goPage('<%= pageUrl %>')"  onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
<%
}
%>
</pg:pages>
<pg:next>
                            <A HREF="javaScript:goPage('<%= pageUrl %>')"  onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
</pg:next>
                          </td>
                        </tr>
</pg:index>
</pg:pager>
<%
}
%>
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
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
      </tr>
    </table>
<!-- pulsantiera-->
 <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
   <tr>
  	 <td>
      <sec:ShowButtons/>
     </td>
   </tr>
 </table>	
</form>

</body>
</html>