<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*,com.strutturaWeb.View.*" %>
<sec:ChkUserAuth RedirectEnabled="false" VectorName="vectorButton" />
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"LancioValAttivaSp.jsp")%>
</logtag:logData>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Lancio Repricing
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/LancioValAttivaSp.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<!-- NUOVO CALENDARIO -->
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<!-- NUOVO CALENDARIO -->

</HEAD>
<BODY>

<form name="lancioVAForm" method="post" action="LancioValAttivaSp.jsp">   

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloPagina.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="2"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lancio Batch Repricing&nbsp;  </td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>
  <tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
        
                </table>
                </td>
              </tr>
            </table>
					</td>
        </tr>
        <tr>
        <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
<!-- CARICO LISTA ACCOUNT -->
      <tr>
  	   <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
         <tr>
          <td>
           <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <tr>
             <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dati Cliente</td>
             <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
            </tr>
           </table>
          </td>
         </tr>
         <tr>
          <td>
           <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="2"></td>
            </tr>
            <tr>
             <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="#cfdbe9">
		 	          <tr>
           				<td <td colspan='2'>&nbsp;</td>
                </tr>
               <tr> 
                  <td class="textB" valign="top" width="30%">&nbsp;Account</td>
           				<td class="text" align="left" width="70%">

                    <Select name="comboAccount" size="7" style="width: 80%;" width="400px" class="text">
                    <%
                        ViewAccounts vw=(ViewAccounts)request.getAttribute("View");
                        for(int i=0;i<vw.getNumeroAccount();i++)
                        {
%>
                        <option label="<%=vw.getNomeAccount(i)%>" value="<%=vw.getCodeParam(i)%>" />
<%
                        }
                    %>
                    </select>

                   </td>
               </tr>
                <tr>
           				<td colspan='2'>&nbsp;</td>
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
       <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
      </tr>
<!-- INSERISCO ISTRUZIONI PER LA 2 LISTA  -->
      <tr>
  	   <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
         <tr>
          <td>
           <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <tr>
             <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Riepilogo</td>
             <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
            </tr>
           </table>
          </td>
         </tr>
         <tr>
          <td>
           <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
            <tr>
               <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="2"></td>
            </tr>
            <tr>
             <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="#cfdbe9">
                <tr>
           				<td <td colspan='2'>&nbsp;</td>
                </tr>
                <tr>
                  <td class="textB" valign="top" width="30%">&nbsp;Account</td>
           				<td class="text" align="left" width="70%">
                     <Select name="comboRiepilogoAccount" size="7" width="400px" style="width: 80%;" class="text"></select>
                 </td>
               </tr>
               <tr>
                   
                   
               </tr>
               <tr>
           				<td <td colspan='2'>&nbsp;</td>
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
       <td colspan=5 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../image/pixel.gif" width="1" height='3'></td>
      </tr>
     
      <tr>
       <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
      </tr>
 </table>
  
</table>
    </td>
   </tr>
 </form>


</BODY>
</HTML>

