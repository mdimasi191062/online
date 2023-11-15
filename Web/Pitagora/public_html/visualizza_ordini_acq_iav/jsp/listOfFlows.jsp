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
VisualizzaOrdiniAcqIAV visualizzaOrdiniAcqIav = new VisualizzaOrdiniAcqIAV();

Vector<TypeFlussoIav> listaServizi = visualizzaOrdiniAcqIav.getListaServizi();

Vector<TypeFlussoIav> listaOperatori = visualizzaOrdiniAcqIav.getListaOperatori();

Vector<TypeFlussoIav> listaFlussi = visualizzaOrdiniAcqIav.getListaFlussi();

Vector<ResultRefuseIav> resultFlussi = null;

String paramCode = null;
String startDate = null;
String endDate = null;
String area = null;
String nameCode = null;
String serviziIav = null;
String SelOf=null;
String operatoreIav=null;

String[]  selectedForDownloads = null;
String argsCheck = null;
Boolean loader = false;
String pathZip = null;

String pagePagination=null;

if(request.getParameter("pagePagination") != null){
    pagePagination = request.getParameter("pagePagination");
} else {
    pagePagination = "5";
}

Calendar calendar = Calendar.getInstance();
SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

if(request.getParameter("selCodeFlusso") != null){
    paramCode = request.getParameter("selCodeFlusso");
}

if(request.getParameter("startDate") != null){
    startDate = request.getParameter("startDate");
}else{
    calendar.add(Calendar.MONTH, -1);
    startDate = dateFormat.format(calendar.getTime());

}

if(request.getParameter("operatoreIav") != null){
    operatoreIav = request.getParameter("operatoreIav");
} else {
    operatoreIav = "";
}

if(request.getParameter("serviziIav") != null){
    serviziIav = request.getParameter("serviziIav");
} else {
    serviziIav = "";
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
    area = "INTER";
}


if(request.getParameter("SelOf") != null){
    SelOf = request.getParameter("SelOf");
}


if(request.getParameterValues("checkbox_download") != null && request.getParameter("button").equals("Download")){
    pathZip = null;
    selectedForDownloads = request.getParameterValues("checkbox_download");
    loader = selectedForDownloads.length > 0 ? true : false;
    pathZip = visualizzaOrdiniAcqIav.generateFileCSVFromFluxName( selectedForDownloads, startDate , endDate, paramCode, "INTER");
    System.out.println("PAHT:" + pathZip);
    
    if(pathZip != null && !pathZip.equals("")){
    
    String nameFIle = paramCode + "_" + area + "_" + startDate.replace("/","_") + "_" + endDate.replace("/","_") + ".zip";
    
        System.out.println("nameFIle:" + nameFIle);

    
    response.setContentType("application/zip");   
    response.setHeader("Content-Disposition","attachment; filename=\"" + nameFIle + "\"");   
    
    
     BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
     FileInputStream fis = new FileInputStream(pathZip);

        int len;
        byte[] buf = new byte[1024];

        while ((len = fis.read(buf)) > 0)
        {
            bos.write(buf, 0, len);
        }

        bos.close();
        fis.close();   
        
                    %>
            <script>
                alert("Download eseguito!");
            </script>                       
            <%

        }else{
        
             %>
            <script>
                alert("Errore download!");
            </script>                       
            <%
        
        }
        
        request.removeAttribute("checkbox_download");
        request.removeAttribute("button");
    
}else{
pathZip = null;
argsCheck = null;
}


if(paramCode != null){
        
            nameCode = visualizzaOrdiniAcqIav.getNameFluxFromCode(paramCode);           
            
            if(request.getParameter("button")!=null && request.getParameter("button").equals("Ricerca"))        
            
                resultFlussi = visualizzaOrdiniAcqIav.getResultFromFilter(paramCode, startDate, endDate, "INTER",serviziIav,operatoreIav);
            
            request.removeAttribute("button");
        }





%>

<html>
<head>

<style>

span.pg-selected {
color: #fff;
font-size: 15px;
background: #0a6b98;
padding: 2px 4px 2px 4px;
}

span.pg-normal {
color: #0a6b98;
font-size: 15px;
cursor: pointer;
background: #ffffff;
padding: 2px 4px 2px 4px;
}

.pager .pg-goto {background: #0a6b98; color: #fff; margin: 0 2px; padding: 3px; border-radius: 3px;}


</style>

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
        <script src="../../jquery.min.js" type="text/javascript"></script>
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
              <TD bgcolor="#0a6b98" class="white">Visualizza Ordini Acquisiti</TD>
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
          
         <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
          <tr>
            <td class="textB" bgcolor="#D5DDF1" align="center">
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
              <TD bgcolor="#0a6b98" class="white">Visualizza Ordini Acquisiti</TD>
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
                                  <td size=5>  &nbsp;   <a href="javascript:cancelCalendar2();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_fine' src="../../common/images/body/cancella.gif" border="0" valign="Bottom" WIDTH="24" HEIGHT="24"></a>&nbsp;</td> 
                        </tr>
                  </table>
                 </td> 
                    </tr>
                    <tr height="3%"></tr>
                    <tr>
            <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#cfdbe9">
                  
                        <tr>
                           <td width="30%" class="textB" align="Left">&nbsp;Servizi IAV:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td width="30%" class="text" align="Left">                             
                           
                               <select class="text" title="servizi iav" name="serviziIav">
                               <!-- <option value="-1">[Seleziona Opzione]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                   -->
                                   <!--<option value="STAG">Staging</option>-->

                                  <%
                                  
                                  TypeFlussoIav objSer; 
                                  
                                  for(int i = 0; i < listaServizi.size(); i++){
                                  
                                           objSer=(TypeFlussoIav)listaServizi.get(i);
                                           
                                          if(objSer.getType().equals(serviziIav)){
                                          
                                          %>

                                          <option selected value='<%=objSer.getType()%>' class='text'><%=objSer.getType()%>-<%=objSer.getDescr()%></option>
                                          
                                          <%
                                          }else{
                                          %>
                                          
                                          <option value='<%=objSer.getType()%>' class='text'><%=objSer.getType()%>-<%=objSer.getDescr()%></option>
                                          
                                          <%
                                            }}
                                   %>                                  
                              </select>
                              
                            <!-- </select> -->
                          </td>      
                        </tr>
                        <tr height="3%"></tr>
                        <tr>
                           <td width="30%" class="textB" align="Left">&nbsp;Codice Operatore:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                           
                           <td width="30%" class="text" align="Left">                             
                           
                             <select class="text" title="operatore iav" id="operatoreIav" name="operatoreIav">
                               <!-- <option value="-1">[Seleziona Opzione]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                   -->
                                   <!--<option value="STAG">Staging</option>-->

                                  <%
                                  
                                  TypeFlussoIav objOpe; 
                                  
                                  for(int i = 0; i < listaOperatori.size(); i++){
                                  
                                          objOpe=(TypeFlussoIav)listaOperatori.get(i);
                                           
                                          if(objOpe.getType().equals(operatoreIav)){
                                          
                                          %>

                                          <option selected value='<%=objOpe.getType()%>' class='text'><%=objOpe.getType()%>-<%=objOpe.getDescr()%></option>
                                          
                                          <%
                                          }else{
                                          %>
                                          
                                          <option value='<%=objOpe.getType()%>' class='text'><%=objOpe.getType()%>-<%=objOpe.getDescr()%></option>
                                          
                                          <%
                                            }}
                                   %>                                  
                              </select>
                              
                            <!-- </select> -->
                          </td>   
                           <td width="30%" class="text" align="Center">Risultati per pag.:&nbsp;
                                <select name="pagePagination" class="text" id="pageRecords" onchange="run();">
                                   
                                   <% if("5".equals(pagePagination)){ %>                                 
                                   <option value="5" selected>5</option>                                   
                                    <% } else { %>              
                                   <option value="5">5</option>                                
                                   <% } %>
                                   
                                   <% if("10".equals(pagePagination)){ %>                                 
                                   <option value="10" selected>10</option>                                   
                                    <% } else { %>              
                                   <option value="10">10</option>                                
                                   <% } %>
                                   
                                     <% if("20".equals(pagePagination)){ %>                                 
                                   <option value="20" selected>20</option>                                   
                                    <% } else { %>              
                                   <option value="20">20</option>                                
                                   <% } %>
                                   
                                    <% if("50".equals(pagePagination)){ %>                                 
                                   <option value="50" selected>50</option>                                   
                                    <% } else { %>              
                                   <option value="50">50</option>                                
                                   <% } %>
                                  
                                </select>
                           </td>
                               <td width="10%"  class="textB" bgcolor="#D5DDF1" align="right">
                                 <input class="textB" type="submit" value="Ricerca" name="button">
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
      <table class="paginated" width="100%" align='center' border="0" cellspacing="0" cellpadding="0">


            <thead>
            <tr> 
              <th bgcolor="#ffffff" class='white'>&nbsp;</th>
              <th bgcolor='#D5DDF1' class="textB" width="33%">Nome Flusso</th>
              <th bgcolor='#D5DDF1' class="textB" width="33%">Record Acquisiti</th>
              <th style="display:none;" bgcolor='#D5DDF1' class="textB" width="25%">Record Scartati</th>
              <th bgcolor='#D5DDF1' class="textB" width="33%">Area Acquisizione</th>
            </tr>
            </thead>
            
            <% if(resultFlussi != null){ %>
            
                <tbody id="tBody">
                
                <%
                String bgcolor="";
                String checked;  
                boolean  caricaDesc=true;
                %>
            
              <%
              
                for (int i=0;i<resultFlussi.size();i++){
                
                ResultRefuseIav obj = (ResultRefuseIav)resultFlussi.get(i);
                
                  if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;
                
                %>
                 <tr style="text-align:center;" bgcolor="<%=bgcolor%>">
                <td bgcolor="<%=bgcolor%>" width='2%'>
                        <input bgcolor='<%=bgcolor%>'  type='hidden'  value="<%=obj.getNameFile()%>" name='SelOf' >                       
                        <% if(obj.getCountOK().equals("0")){ %>                        
                        <input type='checkbox' disabled='disabled'>
                        <% }else{ %>
                         <input class="textB"  type='checkbox'  onclick="onChangeChecked()" value="<%=obj.getNameFlow()%>" name="checkbox_download" >
                        <% }%>
                </td>
                <td class="textB"><%=obj.getNameFlow()%></td>
                 <td class="textB"><%=obj.getCountOK()%></td>
                  <td class="textB" style="display:none;" ><%=obj.getCountKO()%></td>
                  <% if(area.equals("STAG")){ %>    
                                     <td class="textB">Staging</td>

                  <%} else { %>
                                     <td class="textB">Interfaccia</td>
                  <% } %>
                </tr>
                <%
                }
                %>
                </tbody>
                      
                <% } %>
            
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
  <span style="margin-left:65px;">
            <input style="display:none;" type="submit" id="downloadFile" name="button" value="Download" onclick="downloadFiles()"/>
</span>
  
  </form>
</body>
<script>

function onChangeChecked(){

    if ($('input[name="checkbox_download"]:checked').length>0) {  
        $('#downloadFile').show();       
    }
    else{   
        $('#downloadFile').hide();   
    }

}
</script>


<script>

function cancelCalendar1(){

document.getElementById("startDate").value = "";

}

function cancelCalendar2(){

document.getElementById("endDate").value = "";

}

</script>

<script>

function downloadFiles(){
    alert('Download file in corso...');
    //var checkBoxChecked = [];
    //for (var i = 0; i < $('[name="checkbox"]:checked').length; page++) {
        //alert(i);
    //}
}

function run(){


$( ".pager" ).remove();
$( ".pg-selected" ).remove();
$( ".pg-normal" ).remove();

var recordsNum=$("#pageRecords").val();


$('table.paginated').each(function () {
				  
                                    $( ".pager" ).remove();
                                    $( ".pg-selected" ).remove();
                                    $( ".pg-normal" ).remove();
                                  
                                  var $table = $(this);
				  var itemsPerPage = recordsNum;
				  var currentPage = 0;
				  var pages = Math.ceil($table.find("tr:not(:has(th))").length / itemsPerPage);
                                  
                                  $table.unbind('repaginate');                               
				  $table.bind('repaginate', function () {
				    if (pages > 1) {
				    var pager;
				    if ($table.next().hasClass("pager"))
				      pager = $table.next().empty();  else
				    pager = $('<div class="pager" style="padding-top: 20px; direction:ltr; " align="center"></div>');

                                    $('<button class="pg-goto"></button>').text(' « First ').unbind('click');
				    $('<button class="pg-goto"></button>').text(' « First ').bind('click', function () {
				      currentPage = 0;
				      $table.trigger('repaginate');
				    }).appendTo(pager);

                                    $('<button class="pg-goto"> « Prev </button>').unbind('click');
				    $('<button class="pg-goto"> « Prev </button>').bind('click', function () {
				      if (currentPage > 0)
				        currentPage--;
				      $table.trigger('repaginate');
				    }).appendTo(pager);

				    var startPager = currentPage > 2 ? currentPage - 2 : 0;
				    var endPager = startPager > 0 ? currentPage + 3 : 5;
				    if (endPager > pages) {
				      endPager = pages;
				      startPager = pages - 5;    if (startPager < 0)
				        startPager = 0;
				    }

                                    var numTot=0;
                                    numTot=$('table.paginated > tbody > tr').length;
                                    if(recordsNum < numTot ){
                                        for (var page = startPager; page < endPager; page++) {
                                          $('<span style="cursor:pointer;" id="pg' + page + '" class="' + (page == currentPage ? 'pg-selected' : 'pg-normal') + '"></span>').text(page + 1).unbind('click');
                                          $('<span style="cursor:pointer;" id="pg' + page + '" class="' + (page == currentPage ? 'pg-selected' : 'pg-normal') + '"></span>').text(page + 1).bind('click', {
                                              newPage: page
                                            }, function (event) {
                                              currentPage = event.data['newPage'];
                                              $table.trigger('repaginate');
                                          }).appendTo(pager);
                                        }
                                    }
                                  

                                    $('<button class="pg-goto"> Next » </button>').unbind('click');
				    $('<button class="pg-goto"> Next » </button>').bind('click', function () {
				      if (currentPage < pages - 1)
				      currentPage++;
				      $table.trigger('repaginate');
				    }).appendTo(pager);
                                    $('<button class="pg-goto"> Last » </button>').bind('click');
				    $('<button class="pg-goto"> Last » </button>').bind('click', function () {
				      currentPage = pages - 1;
				      $table.trigger('repaginate');
				    }).appendTo(pager);

				    if (!$table.next().hasClass("pager"))
				      pager.insertAfter($table);
				      //pager.insertBefore($table);
				    	
				  }// end $table.bind('repaginate', function () { ...

				  $table.find(
				  'tbody tr:not(:has(th))').hide().slice(currentPage * itemsPerPage, (currentPage + 1) * itemsPerPage).show();
				  });

				  $table.trigger('repaginate');
				});

}

var elementExists = document.getElementById("tBody");
if(elementExists!=null){
    run();  
}

</script>


</html>
