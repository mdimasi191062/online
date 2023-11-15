<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*" %>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>

<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"visualizza_gestori.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto -->
<EJB:useHome id="home" type="com.ejbSTL.SelectGestoreHome" location="SelectGestore" />
<EJB:useBean id="gestore" type="com.ejbSTL.SelectGestore" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%

  // Controllo se effettuare l'inserimento o no dopo l'apertura del popup
  DB_Gestore gestoreDB;
  String codeGest = Misc.nh(request.getParameter("txtCodGest"));
  String codeAccount = Misc.nh(request.getParameter("txtCodAccount"));
  String descAccount = Misc.nh(request.getParameter("txtDescAccount"));
  
  String strSelected = "";
  
  String bgcolor="";
  // GESTIONE CARICAMENTO VETTORE - INIZIO
  int typeLoad=0;
  Vector accountVector=null;
  
  String strtypeLoad = request.getParameter("hidTypeLoad");
    
  if (strtypeLoad!=null && strtypeLoad!="")
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
  
  System.out.println("typeLoad "+ typeLoad);
  if (typeLoad!=0)
    accountVector = (Vector) session.getAttribute("accountVector");
  else
  {
    accountVector = gestore.findGest(codeGest,codeAccount,descAccount);
    if (accountVector!=null)
      session.setAttribute("accountVector", accountVector);
  }
  // GESTIONE CARICAMENTO VETTORE -FINE

  //memorizza il numero di record totali
  int intRecTotali=accountVector.size();
  System.out.println("intRecTotali "+ intRecTotali);
  //determina il numero di elementi per pagina
  int intRecXPag;
  if(request.getParameter("cboNumRecXPag")==null){
    intRecXPag=5;
  }else{
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
  }
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
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
<TITLE>Seleziona Gestore</TITLE>
<SCRIPT LANGUAGE='Javascript'>
var objForm = null;
function initialize()
{
	objForm = document.frmDati;
}

function submitRicerca(typeLoad)
{
  var stringa="";
  stringa=objForm.txtCodGest.value;
  objForm.txtCodGest.value=stringa.toUpperCase();
  objForm.hidTypeLoad.value = "0";
  objForm.action = "visualizza_gestori.jsp";
  objForm.submit();
}

function setCodeHidden(selCodeGest,selCodeAccount,selDescAccount){ 
  document.frmDati.strCodeGest.value=selCodeGest;
  document.frmDati.strCodeAccount.value=selCodeAccount;
  document.frmDati.strDescAccount.value=selDescAccount;
}

function closePopUp(){
  window.opener.document.frmSearch.txtCodGest.value = document.frmDati.strCodeGest.value;
  window.opener.document.frmSearch.txtCodAccount.value = document.frmDati.strCodeAccount.value;
  window.opener.document.frmSearch.txtDescAccount.value = document.frmDati.strDescAccount.value;
  self.close();
}

</SCRIPT>
</HEAD>
<BODY onload="initialize()">
<form name="frmDati" onsubmit="submitRicerca('0');return false" method="post" action="">
<input type="hidden" name="hidPaginaRichiesta" value="">
<input type="hidden" name="hidTypeLoad" value="">

<input type="hidden" name="strCodeGest" value="">
<input type="hidden" name="strCodeAccount" value="">
<input type="hidden" name="strDescAccount" value="">

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                      <tr>
                          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Filtro di Ricerca</td>
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
                    <tr style="height:25px;">
                      <td width="40%" class="textB" align="right">Codice Gestore:&nbsp;</td>
                      <%
                      if(codeGest.equals("%"))
                        codeGest = "";
                      %>
                      <td width="40%" class="text"><input class="text" type='text' name='txtCodGest' value='<%=codeGest%>' size='25'></td>
                      
                      <td width="20%" rowspan='2' class="textB" valign="center" align="center">
                        <input type="button" class="textB" name="Ricerca" value="Ricerca" onclick="submitRicerca('0');">
                      </td>
                    </tr>
                    <tr style="height:25px;">
                      <td width="40%" class="textB" align="right">Codice Account:&nbsp;</td>
                      <%
                      if(codeAccount.equals("%"))
                        codeAccount = "";
                      %>
                      <td width="40%" class="text"><input class="text" type='text' name='txtCodAccount' value='<%=codeAccount%>' size='25'></td>
                      
                      <td width="20%" rowspan='2' class="textB" valign="center" align="center">
                        &nbsp;
                      </td>
                    </tr>
                    <tr style="height:25px;">
                      <td width="40%" class="textB" align="right">Descrizione Account:&nbsp;</td>
                      <%
                      if(descAccount.equals("%"))
                        descAccount = "";
                      %>
                      <td width="40%" class="text"><input class="text" type='text' name='txtDescAccount' value='<%=descAccount%>' size='25'></td>
                      <td width="20%" rowspan='2' class="textB" valign="center" align="center">
                        &nbsp;
                      </td>
                    </tr>
                    <tr style="height:25px;">
                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <select class="text" name="cboNumRecXPag" onchange="submitRicerca('1');">
                        <%
                          for(int k = 5;k <= 30; k=k+5){
                            if(k==intRecXPag){
                              strSelected = "selected";
                            }else{
                              strSelected = "";
                            }
                         %>
                            <option <%=strSelected%> class="text" value="<%=k%>"><%=k%></option>
                        <%
                        }
                        %>
                        </select>
                      </td>
                      <td> &nbsp; </td>
                    </tr>
                    <tr>
                      <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                    </tr>
                    
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td colspan='6' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                          <tr>
                            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Gestori Selezionati</td>
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td colspan='6' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                          </tr>
                          <%
                          int i=0;
                          int j=0;
                         
                          if ((accountVector==null)||(accountVector.size()==0))
                          {
                          %>
                          <tr>
                              <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="3" class="textB" align="center">No Record Found</td>
                          </tr>
                          <%
                          }
                          else
                          {
                          %>
                          <tr>
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;</td>
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Codice Gestore</td>
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Codice Account </td>
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Descrizione Account </td>
                          </tr>
                          <pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
                          
                          <pg:param name="txtTypeLoad" value="1"></pg:param>
                          <pg:param name="cboNumRecXPag" value="<%=intRecXPag%>"></pg:param>
                          <pg:param name="txtCodGest" value="<%=codeGest%>"></pg:param>
                          <pg:param name="txtCodAccount" value="<%=codeAccount%>"></pg:param> 
                          <pg:param name="txtDescAccount" value="<%=descAccount%>"></pg:param> 
                          <%
                          //SimpleDateFormat datafmt = new SimpleDateFormat ("dd'/'MM'/'yyyy");

                          String classRow = "row1";
                          String curClassRow = "";
                          String curSubClass_Row = "";
                          String curSubClassRow = "";
                          String curSubClassRow_new = "";
                          
                          for(j=((pagerPageNumber.intValue()-1)*intRecXPag);((j < intRecTotali) && (j < pagerPageNumber.intValue()*intRecXPag));j++)	
                          {
                            DB_Gestore myelement=new DB_Gestore();
                            myelement=(DB_Gestore)accountVector.elementAt(j);

                           if ((i%2)==0)
                              bgcolor="#EBF0F0";
                           else
                              bgcolor="#CFDBE9";
                          %>
                            
                          <tr>
                            <td class='text'>
                              <input type="radio" name="CodeGestore" value="<%=myelement.getCODE_GEST()%>" onClick="setCodeHidden('<%= myelement.getCODE_GEST()%>','<%= myelement.getCODE_ACCOUNT() %>','<%= myelement.getDESC_ACCOUNT() %>');">
                            </td>
                            
                            <td bgcolor='<%=bgcolor%>' class='text'><%=myelement.getCODE_GEST()%></td>
                            <td bgcolor='<%=bgcolor%>' class='text'><%=myelement.getCODE_ACCOUNT()%></td>
                            <td bgcolor='<%=bgcolor%>' class='text'><%=myelement.getDESC_ACCOUNT()%></td>
                          </tr>
                          <tr>
                            <td colspan='6' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                          </tr>
                          <%
                            i+=1;
                          }
                          %>
                          <tr>
                            <td colspan="6" class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
                              <!--paginatore-->
                              <pg:index>
                                Risultati Pag.
                                <pg:prev> 
                                  <A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
                                </pg:prev>
                                <pg:pages>
                                  <%
                                  if (pageNumber == pagerPageNumber){
                                  %>
                                    <b><%= pageNumber %></b>&nbsp;
                                  <%
                                  }else{
                                  %>
                                    <A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
                                  <%
                                  }
                                  %>
                                </pg:pages>
                                <pg:next>
                                  <A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
                                </pg:next>
                              </pg:index>
                              </pg:pager>
                            </td>
                          </tr>
                          <%
                          }
                          %>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td colspan='6' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td colspan='6'><center><input type="button" title="Seleziona" value="Seleziona" onclick="javascript:closePopUp();" ></center></td>
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
  
</table>
<%
  if ((accountVector==null)||(accountVector.size()==0))
  {
%>
    <script>
   //   Disable(document.frmDati.Seleziona);
    </script>
<%
  }
%>

</form>

</BODY>
</HTML>
