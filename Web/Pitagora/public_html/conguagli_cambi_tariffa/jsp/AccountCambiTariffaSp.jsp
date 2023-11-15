<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"AccountCambiTariffaSp.jsp")%>
</logtag:logData>
<sec:ChkUserAuth/>
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

String des_tipo_contr=request.getParameter("hidDescTipoContratto");
if (des_tipo_contr==null) des_tipo_contr=request.getParameter("des_tipo_contr");
if (des_tipo_contr==null) des_tipo_contr=(String)session.getAttribute("des_tipo_contr");

String cod_tipo_contr=request.getParameter("codiceTipoContratto");
if (cod_tipo_contr==null) cod_tipo_contr=request.getParameter("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("cod_tipo_contr");
Vector lvct_AccountPagina = (Vector) session.getAttribute("lvct_AccountPagina");
String strMessage = Misc.nh(request.getParameter("strMessage"));
String strViewType = Misc.nh(request.getParameter("strViewType"));



// Lettura del Numero di record per pagina (default 5)
int records_per_page=5;
String strNumRec = request.getParameter("numRec");
if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }
  // Lettura dell'indice Combo Numero Record
int index=0;
String strIndex = request.getParameter("txtnumRec");
if (strIndex!=null && !strIndex.equals(""))
  {
   Integer tmpindext=new Integer(strIndex);
   index=tmpindext.intValue();
  }
int typeLoad=0;
// Lettura tipo caricamento per fare query o utilizzare variabili Session
// Vettore contenente risultati query
Collection oggAccount=null;

String strtypeLoad = request.getParameter("typeLoad");
if (strtypeLoad!=null && !strtypeLoad.equals(""))
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
%>

<EJB:useHome id="homeAccount2Lst" type="com.ejbBMP.DoppioListinoBMPHome" location="DoppioListinoBMP" />

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Lista Account
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>

function submitAccountForm(typeLoad)
{
  document.AccountForm.typeLoad.value=typeLoad;
  document.AccountForm.txtnumRec.value=document.AccountForm.numRec.selectedIndex;
  document.AccountForm.submit();
}

function ONANNULLA()
{
			if (opener && !opener.closed) 
			{
				opener.dialogWin.state = "ANNULLA";
	            opener.dialogWin.returnFunc();
				self.close();
			}
			else
			{ 
				alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
				self.close();
			}
		}
    
		function ONCONFERMA(){
			if (opener && !opener.closed) 
			{
				opener.dialogWin.state = "CONFERMA";
        opener.dialogWin.returnFunc();
				self.close();
			}
			else
			{ 
				alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
				self.close();
			}
		}


function setInitialValue()
{
//Setta il numero di record  
eval('document.AccountForm.numRec.options[<%=index%>].selected=true');
}

</SCRIPT>
</HEAD>
<BODY onload="setInitialValue();">
<form name="AccountForm" method="get" action="AccountCambiTariffaSp.jsp">
                        <input class="textB" type="hidden" name="cod_tipo_contr" value="<%=cod_tipo_contr%>">
                        <input class="textB" type="hidden" name="des_tipo_contr" value="<%=des_tipo_contr%>">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                        <input class="textB" type="hidden" name="typeLoad" value="<%=typeLoad%>">
                        <input type="hidden" name = "strMessage" value="<%=strMessage%>">
                    
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloPagina.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Verifica repricing :  <%=des_tipo_contr%></td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table  width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista account</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>">
                    <tr>
                      <td colspan=2 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td class="textB" colspan =2 align="center"><%=strMessage%>?</td>
                    </tr>
                    <tr>
                      <td colspan =2>&nbsp;</td>
                    </tr>
                    <tr>
                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <select class="text" name="numRec" onchange="submitAccountForm('1');">
                          <option class="text" value=5>5</option>
                          <option class="text" value=10>10</option>
                          <option class="text" value=20>20</option>
                          <option class="text" value=50>50</option>
                        </select>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
					</td>
        </tr>

			</td>
		</tr>
  </table>
          <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
        
  <tr>
  	<td>
      <table align=center width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
      <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Risultati della ricerca</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>

        <tr>
          <td>
            <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan=2 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
              </tr>
<%
    if ((lvct_AccountPagina==null)||(lvct_AccountPagina.size()==0))
    {%>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan=2 class="textB" align="center">No Record Found</td>
              </tr>
   <%}
    else
    {%>
         <tr>
               <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white">&nbsp;</td>
               <td bgcolor="<%=StaticContext.bgColorFooter%>" class='textB'>Account</td>
              </tr>
  <%}%>

                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=lvct_AccountPagina.size()%>">
                <pg:param name="cod_tipo_contr" value="<%=cod_tipo_contr%>"></pg:param>
                <pg:param name="des_tipo_contr" value="<%=des_tipo_contr%>"></pg:param>
                <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                <pg:param name="typeLoad" value="1"></pg:param>
                <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
                <pg:param name="strMessage" value="<%=strMessage%>"></pg:param>
                <%
                String bgcolor="";
                for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<lvct_AccountPagina.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                {
            			DB_Account lobj_Account=new DB_Account();
            			lobj_Account=(DB_Account)lvct_AccountPagina.elementAt(i);
             			if ((i%2)==0){
              				bgcolor=StaticContext.bgColorRigaPariTabella;
            			}else{
                      bgcolor=StaticContext.bgColorRigaDispariTabella;
              		}%>		
           			<!--tr-->
           				<!--td bgcolor='<%//=bgcolor%>' class='text'-->
              					<%//if(strViewType.equals("")){%>
              						<%//=lobj_Account.getCODE_ACCOUNT()%>
            					<%//}else{%>
            						<%//=lobj_Account.getCODE_GEST()%>
             					<%//}%>
              		<!--/td-->
                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'> &nbsp;  </td>  
           				<td bgcolor='<%=bgcolor%>' class='text'>
           					<%if(strViewType.equals("")){%>
          						<%=lobj_Account.getDESC_ACCOUNT()%>
         					<%}else{%>
				          	<%=lobj_Account.getNOME_RAG_SOC_GEST()%>
         				<%}%>
        				</td>
       			</tr>
    		<%}%>
                <tr>
                      <td colspan=2 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="3" height='2'></td>
                    </tr>

                <pg:index>
                          <tr>
                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan=2 class="text" align="center">
                                Risultati Pag.
                          <pg:prev> 
                                <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[<< Prev]</A>
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
                                  <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
                                <%
                                  } 
                                %>
                                
                          </pg:pages>

                          <pg:next>
                                 <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[Next >>]</A>
                          </pg:next>

                            </td>
                          </tr>

                </pg:index>

                </pg:pager>

                <tr>
                  <td colspan=2 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                </tr>
        
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td >
       <sec:ShowButtons td_class="textB"/>
    </td>
  </tr>
</TABLE>   
</form>

</BODY>
</HTML>
