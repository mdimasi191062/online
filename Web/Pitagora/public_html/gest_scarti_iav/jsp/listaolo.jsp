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
GestioneScartiIAV gestScatiIAV = new GestioneScartiIAV();

Vector<TypeFlussoIav> listaFlussi = gestScatiIAV.getListaFlussi();
Vector<ResultRefuseIav> resultFlussi = null;
String[]  selectedForDownloads = null;
//JOptionPane opt = new JOptionPane( "Loading!",JOptionPane.INFORMATION_MESSAGE);
/*JOptionPane opt = new JOptionPane( "Loading!", JOptionPane.INFORMATION_MESSAGE, JOptionPane.DEFAULT_OPTION, null, new Object[]{}, null);
JDialog dlg = new JDialog();//opt.createDialog("Error");
dlg.setTitle("Message");
dlg.setModal(true);
dlg.setContentPane(opt);
dlg.setDefaultCloseOperation(JDialog.DO_NOTHING_ON_CLOSE);
dlg.pack();*/

String paramCode = null;
String startDate = null;
String endDate = null;
String area = null;
String nameCode = null;
String SelOf=null;
String argsCheck = null;
Boolean loader = false;
String pathZip = null;
String motivoSc= null;
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

if(request.getParameter("motivoSc") != null){
    motivoSc = request.getParameter("motivoSc");
} else {
    motivoSc = "TUTTI";
}

if(request.getParameter("SelOf") != null){
    SelOf = request.getParameter("SelOf");
}

if(request.getParameterValues("checkbox_download") != null && request.getParameter("button").equals("Download")){
    pathZip = null;
    selectedForDownloads = request.getParameterValues("checkbox_download");
    loader = selectedForDownloads.length > 0 ? true : false;
    pathZip = gestScatiIAV.generateFileCSVFromFluxName( selectedForDownloads, startDate , endDate, paramCode, area);
    
    if(pathZip != null && !pathZip.equals("")){
    
        System.out.println("PAHT:" + pathZip);
        String nameFIle = paramCode + "_" + area + "_SCA_" + startDate.replace("/","_") + "_" + endDate.replace("/","_") + ".zip";
        
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
        
        
            nameCode = gestScatiIAV.getNameFluxFromCode(paramCode);
            
            if(request.getParameter("button")!=null && request.getParameter("button").equals("Ricerca"))      
                resultFlussi = gestScatiIAV.getResultFromFilter(paramCode, startDate, endDate, area, motivoSc);
            
            request.removeAttribute("button");
        }
        
        


/*
if(SelOf!=null)
{

String path=gestScatiIAV.getPathDownload();
System.out.println("SelOf: "+SelOf);
System.out.println("Path: "+path);
gestScatiIAV.downloadUsingStream(path,SelOf);
SelOf=null;

}

else if(paramCode != null){
    nameCode = gestScatiIAV.getNameFluxFromCode(paramCode);
    resultFlussi = gestScatiIAV.getResultFromFilter(paramCode, startDate, endDate, area);
}*/

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
    
   /* var url = "/Web-Pitagora-context-root/gestscartiiav";
    var result = null;
    
    var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
      xmlhttp.onreadystatechange = function() {
      result = xmlhttp.responseText.split(";");
    }
    
    xmlhttp.open('GET', url, true);
    xmlhttp.send(null);*/
    
    var date = "<%=startDate %>";
    var dateEnd = "<%=endDate %>";
    var area = "<%=area %>";

    //alert(area);
    
}

function searchFromSelection(){
    //alert("searchFromSelection");
    var getAllRadioButton = document.getElementsByName("selCodeFlusso");
    alert(getAllRadioButton.length);
    var radioButton_value;
    for(var i = 0; i < getAllRadioButton.length; i++){
        alert(i);
    }
 // alert(getAllRadioButton);
}
</script>
</head>
<body onload="load()">
    
<form name="frmSearch" method="GET" action="listaolo.jsp" style="position: relative;">
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
              <TD bgcolor="#0a6b98" class="white">Visualizza Scarti</TD>
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
              <TD bgcolor="#0a6b98" class="white">Visualizza Scarti</TD>
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
                           <td width="30%" class="textB" align="Left">&nbsp;Area Acquisizione:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                           <td width="30%" class="text" align="Left">                             
                           
                               <select onchange="setMotivazioneBlocco(this.value)" class="text" title="combo Utenti" id="selArea" name="area">
                               <!-- <option value="-1">[Seleziona Opzione]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                   -->
                                    <% if("STAG".equals(area)){ %>
                                   
                                   <option value="STAG" selected>Staging</option>
                                    
                                    <% } else { %>
                                    
                                   <option value="STAG">Staging</option>
                                   
                                   <% } %>
                                   
                                    <% if("INTER".equals(area)){ %>
                                   
                                   <option value="INTER" selected>Interfaccia</option>
                                    
                                    <% } else { %>
                                    
                                   <option value="INTER">Interfaccia</option>
                                   
                                   <% } %>
                                   
                                    <% if("FLUSSI".equals(area)){ %>
                                   
                                   <option value="FLUSSI" selected>Flussi</option>
                                    
                                    <% } else { %>
                                    
                                   <option value="FLUSSI">Flussi</option>
                                   
                                   <% } %>
                                   
                              </select>
                              
                            <!-- </select> -->
                          </td>   
                          </tr>
                          </table>
                          </td>
                          </tr>
                          <tr height="3%"></tr>
                          
                                      <tr>
            <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#cfdbe9">
                        <tr>
                           <td width="30%" class="textB" align="Left">&nbsp;Motivo Scarto:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                           <td width="30%" class="text" align="Left">                             
                           
                               <select class="text" title="" id="motivoSc" name="motivoSc">
                               <!-- <option value="-1">[Seleziona Opzione]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                   -->
                                   
                                   <% if("ECC".equals(motivoSc)){ %>
                                   
                                   <option value="ECC" selected>Eccezioni</option>
                                   <option value="TUTTI">Tutti</option>
                                    
                                    <% } else { %>
                                    
                                   <option value="ECC">Eccezioni</option>
                                   <option value="TUTTI" selected>Tutti</option>
                                   
                                   <% } %>
                                    
                              </select>
                              
                            <!-- </select> -->
                          </td> 
                          </tr>
                          </table>
                </td>
                </tr>
                <tr height="3%"></tr>
                    
                 <tr>
            <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#cfdbe9">
                        <tr>         
                          
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
      <table class="paginated" width="100%" id="tabRow" align='center' border="0" cellspacing="0" cellpadding="0">

            <thead>
            <tr> 
                <th bgcolor="#ffffff" class='white'>&nbsp;</th>
                <th bgcolor='#D5DDF1' class="textB" width="20%">Nome Flusso</th>
                <th bgcolor='#D5DDF1' class="textB" width="20%">Record Acquisiti</th>
                <th bgcolor='#D5DDF1' class="textB" width="20%">Record Scartati</th>
                <th bgcolor='#D5DDF1' class="textB" width="20%">Area Acquisizione</th>
                  <% if("FLUSSI".equals(area)){ %>
                     <th bgcolor='#D5DDF1' class="textB" width="20%">Motivo Scarto</th>
                  <% } %>
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
              
                //Integer records_per_page = 10;
              
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
                        <% if(obj.getCountKO().equals("0")){ %>                        
                        <input class="checkClass" type='checkbox' disabled='disabled'>
                        <% }else{ %>
                         <input class="checkClass"  type='checkbox'  onclick="onChangeChecked()" value="<%=obj.getNameFlow()%>" name="checkbox_download" >
                        <% }%>                     
                </td>
                <td class="textB"><%=obj.getNameFlow()%></td>
                 <td class="textB"><%=obj.getCountOK()%></td>
                  <td class="textB"><%=obj.getCountKO()%></td>
                  <% if(area.equals("STAG")){ %>    
                                     <td class="textB">Staging</td>

                  <%} else if (area.equals("INTER")){ %>
                                     <td class="textB">Interfaccia</td>
                  <% } else {  %>
                    <td class="textB">Flussi</td>
                  <% } %>
                  
                  <% if("FLUSSI".equals(area)){ %>
                    <td class="textB"><%=obj.getMotivoScarti()%></td>
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



<!--<tr id="loader" style="display:none;position:absolute;top:0px;left:350px;">
<td>
<table>
<tr>
<td>
<h1 style="color:#0a6b98;">Download in corso...</h1>
<img src="../../loader.gif" />
</td>  
</tr>
</table>       
</td>  
</tr>-->

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


function changeArea(){

var val = document.getElementById("selArea").value;

    if(val=="FLUSSI"){
        $('.checkClass').hide();
        $('#downloadFile').hide(); 
    }

}

function downloadFiles(){
    
    //$("#loader").show();
    alert('Download file in corso...');
    /*var checkBoxChecked = [];
    for (var i = 0; i < $('[name="checkbox"]:checked').length; page++) {
        alert(i);
    }*/
}

function setMotivazioneBlocco(val){

    if(val=="STAG" || val=="FLUSSI")
    {      
        $('#motivoSc').val('TUTTI');
        document.getElementById("motivoSc").disabled = true;       
    }else {   
        document.getElementById("motivoSc").disabled = false;
    }

}

//var x = document.getElementById("selArea").selectedIndex;
setMotivazioneBlocco(document.getElementById("selArea").value);

function run(){

changeArea();

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

                                    $('<button class="pg-goto"></button>').text(' � First ').unbind('click');
				    $('<button class="pg-goto"></button>').text(' � First ').bind('click', function () {
				      currentPage = 0;
				      $table.trigger('repaginate');
				    }).appendTo(pager);

                                    $('<button class="pg-goto"> � Prev </button>').unbind('click');
				    $('<button class="pg-goto"> � Prev </button>').bind('click', function () {
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
                                  

                                    $('<button class="pg-goto"> Next � </button>').unbind('click');
				    $('<button class="pg-goto"> Next � </button>').bind('click', function () {
				      if (currentPage < pages - 1)
				      currentPage++;
				      $table.trigger('repaginate');
				    }).appendTo(pager);
                                    $('<button class="pg-goto"> Last � </button>').bind('click');
				    $('<button class="pg-goto"> Last � </button>').bind('click', function () {
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
