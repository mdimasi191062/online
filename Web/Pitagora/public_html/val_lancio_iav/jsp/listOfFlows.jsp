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
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,java.lang.*,java.text.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*,com.filter.*" %>

<%
VisualizzaAcqIAV visualizzaAcqIav = new VisualizzaAcqIAV();

Vector<TypeFlussoIav> listaFlussi = visualizzaAcqIav.getListaFlussi();
Vector<ResultRefuseIav> resultFlussi = null;

String paramCode = null;
String startDate = null;
String endDate = null;
String area = null;
String nameCode = null;

Calendar calendar = Calendar.getInstance();
SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

if(request.getParameter("selCodeFlusso") != null){
    paramCode = request.getParameter("selCodeFlusso");
}

if(request.getParameter("startDate") != null){
    startDate = request.getParameter("startDate");
}else{
    startDate = dateFormat.format(calendar.getTime());

}

if(request.getParameter("endDate") != null){
    endDate = request.getParameter("endDate");
}else{
    calendar.add(Calendar.MONTH, 1);
    endDate =dateFormat.format(calendar.getTime());
}

if(request.getParameter("area") != null){
    area = request.getParameter("area");
} else {
    area = "STAG";
}

if(paramCode != null){
    nameCode = visualizzaAcqIav.getNameFluxFromCode(paramCode);
    resultFlussi = visualizzaAcqIav.getResultFromFilter(paramCode, startDate, endDate, area);
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
function load(){
    

    
    var date = "<%=startDate %>";
    var dateEnd = "<%=endDate %>";
        var area = "<%=area %>";

    //alert(area);
    
}

function searchFromSelection(){
    alert("searchFromSelection");
    var getAllRadioButton = document.getElementsByName("selCodeFlusso");
    alert(getAllRadioButton.length);
    var radioButton_value;
    for(var i = 0; i < getAllRadioButton.length; i++){
        alert(i);
    }
  alert(getAllRadioButton);
}
</script>
</head>
<body onload="load()">


<form name="frmSearch" method="GET" action="listOfFlows.jsp">
  <% if(paramCode == null){ %>
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
              <TD bgcolor="#0a6b98" class="white">Visualizza Acquisiti</TD>
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
          
          for(int i = 0; i < listaFlussi.size(); i++){
          
          TypeFlussoIav obj=(TypeFlussoIav)listaFlussi.get(i);
          
                if ((i%2)==0){
                    bgcolor=StaticContext.bgColorRigaPariTabella;
                } else {
                    bgcolor=StaticContext.bgColorRigaDispariTabella;
                }
                             
          %>
               <tr> 
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'> 
                            <% if(paramCode == listaFlussi.get(i).toString()){ %>
                              <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name='selCodeFlusso' checked="checked" value="<%=listaFlussi.get(i).toString()%>">
                            <% } else { %>
                                <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name='selCodeFlusso' value="<%=obj.getType()%>">
                            <% } %>
                            </td>
                            <td bgcolor='<%=StaticContext.bgColorCellaBianca%>' class='text'><%=obj.getDescr()%></td>
                    </tr>
              <%
                }
              %> 
          </table>
          </td>
          </tr>
              <tr height="28">
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
  <tr>
    <td class="textB" bgcolor="#D5DDF1" align="center"
>
        <input class="textB" type="submit" name="SELEZIONA" value="Seleziona" >
    </td>
  </tr>
</table>

        </td>
      </tr>
      
</TABLE>

<% } %>
  
  <% if(paramCode != null){ %>
  
  <input type="hidden" name="selCodeFlusso" value="<%=paramCode%>" />
  
  <table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  
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
              <TD bgcolor="#0a6b98" class="white">Visualizza Acquisiti</TD>
              <TD bgcolor="#ffffff" class="white" align="center" width="9%">
                <IMG alt="tre" src="../../common/images/body/tre.gif" width="28"/>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
  
  <tr>
    <td bgcolor="#ffffff"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr> 
  
  <tr>
    <td>
	    <table  width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0a6b98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0a6b98">
                    <tr>
                      <td bgcolor="#0a6b98" class="white" valign="top" width="91%">&nbsp;</td>
                      <td bgcolor="#ffffff" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
                <tr>
                 <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#cfdbe9">
                        <tr>
                            <td width="70%" class="textB" align="left" >&nbsp;Tipologia Flusso:&nbsp;
                                  <input size=50 class="text" type="text" align="right"  value="<%=nameCode%>" readonly/></td>
                        </tr>
                  </table>
                 </td> 
                    </tr>
                       <tr height="3%"></tr>
        <tr>
                 <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#cfdbe9">
                        <tr>
                            <td width="50%" class="textB" align="left" >&nbsp;Data Acquisizione da:&nbsp;
                                 <input type="hidden" id=data_ini_tmp value= "06/10/2019"> 
                                  <input size=10 class="text" type="text" align="right" id="startDate" name="startDate"  value="<%=startDate%>"></td>
                                  <td size=5> &nbsp;    <a href="javascript:showCalendar('frmSearch.startDate','');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img src="../../common/images/body/calendario.gif" border="0" valign="Bottom" alt="Click per selezionare una data"  WIDTH="24" HEIGHT="24"></a></td>
                                  <td size=5>  &nbsp;   <a href="javascript:cancelCalendar1();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_fine' src="../../common/images/body/cancella.gif" border="0" valign="Bottom" WIDTH="24" HEIGHT="24"></a>&nbsp;</td> 
                            
                            <td width="50%" class="textB" align="left" >&nbsp;Data Acquisizione a:&nbsp;
                                  <input size=10 class="text" type="text" align="right" id="endDate" name="endDate" value="<%=endDate%>"></td>
                                  <td size=5> &nbsp;    <a href="javascript:showCalendar('frmSearch.endDate','');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img src="../../common/images/body/calendario.gif" border="0" valign="Bottom" alt="Click per selezionare una data"  WIDTH="24" HEIGHT="24"></a></td>
                                  <td size=5>  &nbsp;   <a href="javascript:cancelCalendar1();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_fine' src="../../common/images/body/cancella.gif" border="0" valign="Bottom" WIDTH="24" HEIGHT="24"></a>&nbsp;</td> 
                        </tr>
                  </table>
                 </td> 
                    </tr>
                    <tr height="3%"></tr>
                    <tr>
            <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#cfdbe9">
                        <tr>
                           <td width="30%" class="textB" align="Left">&nbsp;Area Acquisizione:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                           <td width="30%" class="text" align="Left">                             
                           
                               <select class="text" title="combo Utenti" name="area">
                               <!-- <option value="-1">[Seleziona Opzione]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                   -->
                                   <option value="STAG">Staging</option>
                                   <option value="INTER">Interfaccia</option>
                              </select>
                              
                            <!-- </select> -->
                          </td>   
                           <td width="30%" class="text" align="Center">Risultati per pag.:&nbsp;
                                <select class="text" name="numRec" onchange="submitFrmSearch('1');">
                                  <option class="text" value=5>5</option>
                                  <option class="text" value=10>10</option>
                                  <option class="text" value=20>20</option>
                                  <option class="text" value=50>50</option>
                                </select>
                           </td>
                               <td width="10%"  class="textB" bgcolor="#D5DDF1" align="right">
                                 <input class="textB" type="submit" name="SEARCH" value="Ricerca">
                                </td>
                        </tr>
                  </table>
                 </td> 
                 </tr>
                </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#cfdbe9">
                    <tr>
                       <td bgcolor="#cfdbe9"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
                    </tr>
                    <tr>
                       <td bgcolor="#cfdbe9"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
                    </tr>
                    <tr>
                      <td>   
                         <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
  <tr>

            </tr>
        </table>

                      </td>   
                    </tr>
                  </table>
                </td>
              </tr>
       			</td>
          </tr>
          <tr>
   <td colspan='2' bgcolor="#ffffff"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
</tr>

<tr>
  <td>
    <table  width="100%" border="0" cellspacing="0" cellpadding="1" align='center'>
      <tr>
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0a6b98">
            <tr>
              <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#0a6b98">
                  <tr>
                     <td bgcolor="#0a6b98" class="white" valign="top" width="100%">&nbsp;</td>
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
      <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan='7' bgcolor="#ffffff"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>

            
            <tr> 
              <td bgcolor="#ffffff" class='white'>&nbsp;</td>
              <td bgcolor='#D5DDF1' class="textB" width="25%">Nome Flusso</td>
                  <td bgcolor='#D5DDF1' class="textB" width="25%">Record Acquisiti</td>
                  <td bgcolor='#D5DDF1' class="textB" width="25%">Record Scartati</td>
                  <td bgcolor='#D5DDF1' class="textB" width="25%">Area Acquisizione</td>
            </tr>
            
               <pg:pager maxPageItems="10" maxIndexPages="10" totalItemCount="<%=resultFlussi.size()%>">
                <pg:param name="typeLoad" value="1"></pg:param>
                
                <%
                String bgcolor="";
                String checked;  
                boolean  caricaDesc=true;
                %>
            
              <%
              
              Integer records_per_page = 10;
              
                for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<resultFlussi.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++){
                
                ResultRefuseIav obj = (ResultRefuseIav)resultFlussi.get(i);
                
                  if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;
                
                %>
                <tr>
                <td bgcolor="<%=bgcolor%>" width='2%'>
                        <input bgcolor='<%=bgcolor%>'  type='hidden'  name='SelOf' >
                </td>
                <td><%=obj.getNameFlow()%></td>
                 <td><%=obj.getCountOK()%></td>
                  <td><%=obj.getCountKO()%></td>
                  <% if(area.equals("STAG")){ %>    
                                     <td>Staging</td>

                  <%} else { %>
                                     <td>Interfaccia</td>
                  <% } %>
                </tr>
                <%
                }
                %>
                
                    <tr>
                      <td colspan='9' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="3" height='2'></td>
                    </tr>
                
                  <pg:index>
                          <tr>
                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="9" class="text" align="center">
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
            
            </table>
            </td>
            </tr>
            <tr> 
   <td>
      <table width="90%" align=center border="0" cellspacing="0" cellpadding="0" bgcolor="#0a6b98">
         <tr>
            <td colspan='1' bgcolor="#ffffff"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
         </tr>
         <tr> 
           <td>
             <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
  <tr>
    <td bgcolor="#ffffff" class="textB" align="right">
        <% if(resultFlussi.size() > 0){ %>
        <input class="textB" type="button" name="DOWNLOAD" value="Download" onClick="ONDOWNLOAD();">
        <% } %>
    </td>
  </tr>
  </table>
 
           </td>  
          </tr>
      </table>       
   </td>  
</tr>
</table>
 <% } %>
  
  </form>
</body>
</html>
