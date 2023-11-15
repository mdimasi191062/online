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
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,java.lang.*,java.text.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*,com.filter.*,com.service.*, com.model.*" %>
<%
    
    String selectedCode = null;
    
    IavService iavService = new IavService();
    
    Vector<TypologyDataMaxIAV> listType = new Vector<TypologyDataMaxIAV>();
    
    if(selectedCode != null){
    }
    else
    {
    
    selectedCode = null;
    try{
    
//     listType = null;//iavService.getAllTypologyDataMaxIAV();
    
    }catch(Exception e) {
    
    }
   
    
    }
    
%>

<html>
<head>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
         <script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<script>
<script>
</script>
</head>
<body>
<form name="frmSearch" method="GET" action="listTypology.jsp" style="position: relative;">
<TABLE width="90%" height="100%" border="0" cellspacing="0" cellpadding="1" align="center">
      <tr height="30">
        <td>
          <table width="100%">
            <tr>
              <td>
                <img src="../images/titoloPagina.gif" alt="" border="0"/>
              </td>
            </tr>
          </table>
        </td>
        <td/>
      </tr>
      <TR height="20">
        <TD>
          <TABLE width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#0a6b98">
            <TR align="left">
              <TD bgcolor="#0a6b98" class="white">Visualizza</TD>
              <TD bgcolor="#ffffff" class="white" align="center" width="9%">
                <IMG alt="tre" src="../../common/images/body/tre.gif" width="28"/>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
        <TR height="20">
        <TD>
          <TABLE width="90%" border="0" cellspacing="1" cellpadding="1" bgcolor="#0a6b98" align="center">
            <TR align="center">
              <TD bgcolor="#0a6b98" class="white"/>
              <TD bgcolor="#ffffff" class="white" align="center" width="9%">
                <IMG alt="tre" src="../../common/images/body/quad_blu.gif"/>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
      
       <TR>
        <TD valign="top">
          <TABLE width="90%" border="0" cellspacing="0" cellpadding="2" align="center" >
                    <%
          String bgcolor = "";
          //Object[] obj = listaFlussi;
          
          for(int i = 0; i < listType.size(); i++){
          
          TypologyDataMaxIAV obj=(TypologyDataMaxIAV)listType.get(i);
          
                if ((i%2)==0){
                    bgcolor=StaticContext.bgColorRigaPariTabella;
                } else {
                    bgcolor=StaticContext.bgColorRigaDispariTabella;
                }
                             
          %>
               <tr> 
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'> 
                            <% if(selectedCode == listType.get(i).toString()){ %>
                              <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name='selectedCode' checked="checked" value="<%=listType.get(i).toString()%>">
                            <% } else { %>
                                <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name='selectedCode' value="<%=obj.getDataMax()%>">
                            <% } %>
                            </td>
                <td bgcolor='<%=StaticContext.bgColorCellaBianca%>' class='text'><%=obj.getTypologyName()%></td>
</tr>
              <%
                }
              %> 
          </table>
          
          <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
          <tr>
            <td class="textB" bgcolor="#D5DDF1" align="center">
                <input class="textB" type="submit" name="LANCIA" value="Lancia" >
            </td>
          </tr>
        </table>
          
          </td>
          </tr>
      
</TABLE>
</body>
</html>

