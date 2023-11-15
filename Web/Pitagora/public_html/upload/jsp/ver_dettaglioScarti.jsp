<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.usr.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="BOTTONI" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"ver_dettaglioScarti.jsp")%>
</logtag:logData>
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");
String codeElab=request.getParameter("codeElab");
if (codeElab==null) codeElab=(String)session.getAttribute("codeElab");

String flagSys=request.getParameter("flagSys");
if (flagSys==null) flagSys=(String)session.getAttribute("flagSys");

String action=request.getParameter("act");
String title="";

Collection ScartiImportFile; //per il caricamento della lista degli account per i quali non esistono PS venduti

%>

<EJB:useHome id="homeStatiElabBatch" type="com.ejbSTL.StatiElabBatchSTLHome" location="StatiElabBatchSTL" /> 
<EJB:useBean id="remoteStatiElabBatch" type="com.ejbSTL.StatiElabBatchSTL" value="<%=homeStatiElabBatch.create()%>" scope="session"></EJB:useBean>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Scarti Import File
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>
IExplorer =document.all?true:false;
Navigator =document.layers?true:false;

function ONANNULLA()
{
  self.close();
}
</SCRIPT>
</HEAD>
<BODY>
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="get" action="ScartiImportFileSp.jsp">
  <tr>
    <td>
      <table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="../images/upload.gif" alt="" border="0">
          </td>
        </tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
  	<td>
      <table align=center width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dettaglio Errore</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan='6' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
              </tr>
              <input type="hidden" name=act id=act value="popolalista">
              <input type="hidden" name=codeElab     id=codeElab    value= <%=codeElab%>>
              <%
                ScartiImportFile = remoteStatiElabBatch.getElencoScartiImportFile(codeElab);
              %>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class='textB'>&nbsp&nbsp&nbsp;</td>
                <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Messagio Errore</td>
              </tr>
              <%
                String bgcolor="";
                Object[] objs=ScartiImportFile.toArray();
                //Lista Batch 
                if ((ScartiImportFile!=null)&&(ScartiImportFile.size()!=0)){
                  // Visualizzo elementi
                  I5_6ELAB_UPL_FILES_ROW obj=(I5_6ELAB_UPL_FILES_ROW)objs[0];
                  bgcolor=StaticContext.bgColorRigaPariTabella;


                  if (!obj.getDESC_ERROR().equals("NULL")){

                  %>
                  <tr>
                    <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;</td>
                    <%
                    String msg = obj.getDESC_ERROR() + " alla riga " + obj.getNUM_RIGA_ELAB();
                    %>
                    <td bgcolor='<%=bgcolor%>' class='text'><%=msg%></td>
                  </tr>
                  <%
                  }
                  %>
                <%
                }
                %>
                <tr>
                  <td colspan='6' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                </tr>
            </table>
          </td>
        </tr>
      <input class="textB" type="hidden" name=num_rec id=num_rec value="<%=ScartiImportFile.size()%>">
    </table>   
<tr> 
   <td>
      <table width="90%" align=center border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>">
         <tr>
            <td colspan='1' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
         </tr>
         <tr> 
           <td>
             <sec:ShowButtons VectorName="BOTTONI" /> 
           </td>  
          </tr>
      </table>       
   </td>  
</tr>
</form>
</BODY>
</HTML>
