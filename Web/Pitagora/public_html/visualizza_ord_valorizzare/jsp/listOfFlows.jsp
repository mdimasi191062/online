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
VisualizzaOrdinidaValIAV visOrdValIAV = new VisualizzaOrdinidaValIAV();

//Vector<TypeFlussoIav> listaFlussi = visOrdValIAV.getListaFlussi();
//Vector<TypeFlussoIav> listaServizi = visOrdValIAV.getListaServizi();
Vector<TypeFlussoIav> listaOperatori = visOrdValIAV.getListaOperatori();
//Vector<TypeFlussoIav> listaFatrz=null;


//Vector<ResultRefuseIav> resultFlussi = null;
//Vector<ResultEccezioniIav> resultEccezioni = null;
Vector<ResultInventIav> resultInvent = null;

Boolean editedRow= null;

//String paramCode = null;
String startDate = null;
String endDate = null;
String area = null;
String nameCode = null;
String SelOf = null;

String serviziIav = null;
String operatoreIav = null;
String ambitoIav = null;
String fatturazioneIav = null;
String periodoIav = null;
String pathZip=null;
String statoOrdiniIav=null;

String[]  selectedForDownloads = null;
String argsCheck = null;
Boolean loader = false;

String pagePagination=null;

if(request.getParameter("pagePagination") != null){
    pagePagination = request.getParameter("pagePagination");
} else {
    pagePagination = "5";
}

Calendar calendar = Calendar.getInstance();
SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

/*if(request.getParameter("selCodeFlusso") != null){
    paramCode = request.getParameter("selCodeFlusso");
}*/


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

if(request.getParameter("fatturazioneIav") != null){
    fatturazioneIav = request.getParameter("fatturazioneIav");
} else {
    fatturazioneIav = "";
}

if(request.getParameter("ambitoIav") != null){
    ambitoIav = request.getParameter("ambitoIav");
} else {
    ambitoIav = "";
}

if(request.getParameter("statoOrdiniIav") != null){
    statoOrdiniIav = request.getParameter("statoOrdiniIav");
} else {
    statoOrdiniIav = "";
}

if(request.getParameter("SelOf") != null){
    SelOf = request.getParameter("SelOf");
}

System.out.println("SelOf: "+SelOf);

System.out.println("ambitoIav: "+ambitoIav);
System.out.println("operatoreIav: "+operatoreIav);
System.out.println("statoOrdiniIav: "+statoOrdiniIav);

if(request.getParameterValues("checkbox_download") != null && request.getParameter("button").equals("Download")){
    pathZip = null;
    selectedForDownloads = request.getParameterValues("checkbox_download");
    loader = selectedForDownloads.length > 0 ? true : false;
    
    //pathZip = visOrdValIAV.generateFileCSVFromFluxName( selectedForDownloads, operatoreIav, serviziIav, fatturazioneIav);
    pathZip = visOrdValIAV.generateFileCSVFromFluxName2( selectedForDownloads, operatoreIav, ambitoIav, statoOrdiniIav);    
    
    if(pathZip != null && !pathZip.equals("")){
    
    System.out.println("PAHT:" + pathZip);
    //String nameFIle = operatoreIav + "_" + serviziIav + "_" + fatturazioneIav.replace("/","_") +".zip";
    
    String nameFIle = "Estrazione_Eventi_Acquisiti.zip";

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
        //if(paramCode != null){
        
            if(request.getParameter("button")!=null && request.getParameter("button").equals("Ricerca")){        
                    //resultInvent = visOrdValIAV.getResultFromFilter(operatoreIav, serviziIav, fatturazioneIav);
                    //listaFatrz = visOrdValIAV.getFatrzCycle(serviziIav,operatoreIav);
                    resultInvent = visOrdValIAV.getResultFromFilter2(operatoreIav, ambitoIav, statoOrdiniIav);
                }
            else if(request.getParameter("button")!=null && request.getParameter("button").equals("Fatrz")){                   
                    
                    //listaFatrz = visOrdValIAV.getFatrzCycle(serviziIav,operatoreIav);
                }
            
            request.removeAttribute("button");
        //}
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

function caricato() {
   orologio.style.visibility='hidden';
   orologio.style.display='none';
   maschera.style.display='block';
   maschera.style.visibility='visible';
}

function carica() {
   maschera.style.visibility='hidden';
   maschera.style.display='none';
   orologio.style.display='block';
   orologio.style.visibility='visible';
}

</script>

</head>
<body onLoad="caricato();">

<div name="orologio" id="orologio"  style="visibility:visible;display:block">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div name="maschera" id="maschera" style="overflow:hidden" >
<form id="myForm" name="frmSearch" method="GET" action="listOfFlows.jsp">
  
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
              <TD bgcolor="#0a6b98" class="white">Visualizza Eventi Acquisiti</TD>
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
                    <td width="5%" class="textB" align="Left"></td>
                    <td width="15%" class="textB" align="Left">Ambito</td>
                    <td width="45%" class="text" align="Left">                             
                       <select style="display:block;" class="text" title="Ambito Iav" id="ambitoIav" name="ambitoIav">
                            <option value='%' class='text'>TUTTI</option>
                            <option value='ASS%'    <%= (ambitoIav.equals("ASS%")?"selected":"") %> class='text'>Assurance</option>
                            <option value='IFV_BTS' <%= (ambitoIav.equals("IFV_BTS")?"selected":"") %> class='text'>Provisioning BTS</option>
                            <option value='IFV_ULL' <%= (ambitoIav.equals("IFV_ULL")?"selected":"") %> class='text'>Provisioning ULL</option>
                            <option value='IFV_WLR' <%= (ambitoIav.equals("IFV_WLR")?"selected":"") %> class='text'>Provisioning WLR</option>
                            <option value='IFV_PRO' <%= (ambitoIav.equals("IFV_PRO")?"selected":"") %> class='text'>Provisioning Opera</option>
                      </select></td>
                      <td width="25%" class="text" align="Left"></td>
                      <td width="10%" class="text" align="Left"></td>
                </tr>
                <tr><td colspan="5"></td></tr>
                <tr>
                    <td width="5%" class="textB" align="Left"></td>
                    <td width="15%" class="textB" align="Left">Codice Operatore:</td>
                    <td width="45%" class="text" align="Left">                    
                       <select onchange="onChangeOpe()" class="text" title="operatore iav" id="operatoreIav" name="operatoreIav">
                       <option value="%">TUTTI</option>
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
                       </select></td>
                      <td width="25%" class="text" align="Left"></td>
                      <td width="10%" class="text" align="Left"></td>
                </tr>
                <tr><td colspan="5"></td></tr>
                <tr>
                    <td width="5%" class="textB" align="Left"></td>
                    <td width="15%" class="textB" align="Left">Stato Ordini di Lavoro:</td>
                    <td width="45%" class="text" align="Left">                             
                       <select class="text" title="stato ordini iav" id="statoOrdiniIav" name="statoOrdiniIav">
                           <option value="'0','P','1','Z'" <%= (statoOrdiniIav.equals("'0','P','1','Z'")?"selected":"")%>  >TUTTI</option>
                           <option value="'0','P'" <%=(statoOrdiniIav.equals("'0','P'")?"selected":"")%> >Acquisiti</option>
                           <option value="'1'" <%=(statoOrdiniIav.equals("'1'")?"selected":"")%> >Popolati</option>
                           <option value="'Z'" <%=(statoOrdiniIav.equals("'Z'")?"selected":"")%> >Scartati</option>
                        </select></td>
                    <td width="25%" class="text" align="Center">Risultati per pag.:&nbsp;
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
                             <input id="searchBtn" class="textB" type="submit" value="Ricerca" name="button" onclick="carica();" disabled>
                             <!--input style="display:none;" id="fatrzBtn" class="textB" type="submit" value="Fatrz" name="button"-->
                            </td>
                        </tr>
                        <tr><td colspan="5"></td></tr>

                  </table>
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
              <th bgcolor='#D5DDF1' class="textB" width="1%"></th>
              <th bgcolor='#D5DDF1' class="textB" width="22%" align="left">Ambito</th>
              <th bgcolor='#D5DDF1' class="textB" width="22%">Data Min Ordine</th>
              <th bgcolor='#D5DDF1' class="textB" width="22%">Data Max Ordine</th>
              <th bgcolor='#D5DDF1' class="textB" width="22%">Numero Ordini</th>
            </tr>
            </thead>
            
           <% if(resultInvent != null){ %>
            
                <tbody id="tBody">
                
                <%
                String bgcolor="";
                String checked;  
                boolean  caricaDesc=true;
                %>
            
              <%
              
                for (int i=0;i<resultInvent.size();i++){
                
                ResultInventIav obj = (ResultInventIav)resultInvent.get(i);
                
                  if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;
                
                %>
                <tr style="text-align:center;" bgcolor="<%=bgcolor%>">
                <td bgcolor="<%=bgcolor%>" width='1%'>
                        <input bgcolor='<%=bgcolor%>'  type='hidden'  value="" name='SelOf' >
                       <input class="textB"  type='checkbox'  onclick="onChangeChecked()" value="<%=obj.getFlowName()%>" name="checkbox_download" >
                </td>
                 <td width="22%" class="textB" align="left"><%=obj.getFlowName()%></td>
                 <td width="22%" class="textB"><%=obj.getCODE_LOTTO()%></td>
                 <td width="22%" class="textB"><%=obj.getCODE_ISTANZA_OLD()%></td>
                 <td width="22%" class="textB"><%=obj.getID_TRASPORTO()%></td>
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

 <span style="margin-left:65px;">
            <input style="display:none;" type="submit" id="downloadFile" name="button" value="Download" onclick="downloadFiles()"/>
</span>
  </form>
  </div>
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

function onChangeOpe(){
  
    //document.getElementById("fatrzBtn").click();
    //document.getElementById("fatturazioneIav").style.display = "block";

}

function checkStateRicercaBtn(){
  
    if($('#ambitoIav').val()==null)
            $("#searchBtn").attr("disabled",true) 
    else
            $("#searchBtn").attr("disabled",false) 

}

checkStateRicercaBtn();


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
