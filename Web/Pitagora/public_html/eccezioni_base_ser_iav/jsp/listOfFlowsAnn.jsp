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
AnnEccezioniBaseServizioIAV annEccBaseSerIAV = new AnnEccezioniBaseServizioIAV();

Vector<TypeFlussoIav> listaFlussi = annEccBaseSerIAV.getListaFlussi();
Vector<TypeFlussoIav> listaServizi = annEccBaseSerIAV.getListaServizi();
Vector<TypeFlussoIav> listaFonti = annEccBaseSerIAV.getListaFonti();
Vector<TypeFlussoIav> listaClassTec = annEccBaseSerIAV.getListaClassTec();
Vector<TypeFlussoIav> listaOperatori = annEccBaseSerIAV.getListaOperatori();

Vector<ResultRefuseIav> resultFlussi = null;
Vector<ResultEccezioniIav> resultEccezioni = null;


String paramCode = null;
String startDate = null;
String endDate = null;
String area = null;
String nameCode = null;

Boolean editedRow= null;

String classTecIav = null;
String tipologiaIav = null;
String fontiIav = null;
String serviziIav = null;
String ambitoIav = null;
String SelOf = null;
String checkBoxes=null;
String inputData=null;
String operatoreIav=null;

Boolean regoleCess=false;
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

if(request.getParameter("inputData") != null){
    inputData = request.getParameter("inputData");
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

if(request.getParameter("tipologiaIav") != null){
    tipologiaIav = request.getParameter("tipologiaIav");
} else {
    tipologiaIav = "TUTTI";
}

if(request.getParameter("fonteIav") != null){
    fontiIav = request.getParameter("fonteIav");
} else {
    fontiIav = "TUTTI";
}
    
if(request.getParameter("classTecIav") != null){
    classTecIav = request.getParameter("classTecIav");
} else {
    classTecIav = "TUTTI";
}

if(request.getParameter("operatoreIav") != null){
    operatoreIav = request.getParameter("operatoreIav");
} else {
    operatoreIav = "TUTTI";
}

if(request.getParameterValues("checkBoxes") != null){
    //checkBoxes = request.getParameterValues("checkBoxes");
} else {
    checkBoxes = "";
}


if(request.getParameter("selServizioIav") != null){
    serviziIav = request.getParameter("selServizioIav");
} else {
    serviziIav = "TUTTI";
}

if(request.getParameter("ambitoIav") != null){
    ambitoIav = request.getParameter("ambitoIav");
} else {
    ambitoIav = "TUTTI";
}

if(request.getParameter("SelOf") != null){
    SelOf = request.getParameter("SelOf");
}


if(request.getParameter("regoleCess") != null && request.getParameter("regoleCess").equals("regoleCess")){ 
    regoleCess = true;
} else {
    regoleCess = false;
}


if (request.getParameter("button") != null && request.getParameter("button").equals("Modifica")) {

            String[] s = request.getParameterValues("checkBoxes");
            System.out.println(s[0]);

            String input = inputData;
        
        if ((input != null) && (input.length() > 0)) {
        
                    boolean res=annEccBaseSerIAV.isValid(input);
                    
                        if (res==true){
                        
                            Date date1=new SimpleDateFormat("dd/MM/yyyy").parse(input);
                            Date today=new Date();
                            
                            if(date1.compareTo(today)>0){
                                 editedRow = annEccBaseSerIAV.alterTableSer(s, input);      
                                 %>
                                 <script>
                                 alert("Data Fine Validità impostata correttamente!");
                                 </script>
                                 <%
                            }
                            else
                            {
                                 %>
                                 <script>
                                 alert("Data Inserita Inferiore alla Data di Sistema!");
                                 </script>
                                 <%
                            }
                            resultEccezioni = annEccBaseSerIAV.getResultFromFilterSer(ambitoIav, serviziIav, classTecIav, fontiIav, tipologiaIav,regoleCess,operatoreIav);                    
                        }
                        else
                        {
                            %>
                            <script>
                            alert("Formato Data Errato!");
                            </script>
                            <%
                            resultEccezioni = annEccBaseSerIAV.getResultFromFilterSer(ambitoIav, serviziIav, classTecIav, fontiIav, tipologiaIav,regoleCess,operatoreIav);
                        }
                }
                else
                {
                                // String redirectURL = "listOfFlowsAnn.jsp";
                                // response.sendRedirect(redirectURL);                               
                                resultEccezioni = annEccBaseSerIAV.getResultFromFilterSer(ambitoIav, serviziIav, classTecIav, fontiIav, tipologiaIav,regoleCess,operatoreIav);
                }
                
                request.removeAttribute("button");
                request.removeAttribute("checkBoxes");
                
            
        } else if (request.getParameter("button") != null) {
        
            resultEccezioni = annEccBaseSerIAV.getResultFromFilterSer(ambitoIav, serviziIav, classTecIav, fontiIav, tipologiaIav,regoleCess,operatoreIav);
            request.removeAttribute("button");
            
        } else if(paramCode != null){
                
                if(request.getParameter("button")!=null && request.getParameter("button").equals("Ricerca"))   
                    resultEccezioni = annEccBaseSerIAV.getResultFromFilterSer(ambitoIav, serviziIav, classTecIav, fontiIav, tipologiaIav,regoleCess,operatoreIav);
                    
                request.removeAttribute("button");
        }else{       
            resultEccezioni = annEccBaseSerIAV.getResultFromFilterSer(ambitoIav, serviziIav, classTecIav, fontiIav, tipologiaIav,regoleCess,operatoreIav);
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

function selServizio()
{
    document.getElementById('selServizioIav').value = document.getElementById('serviziIav').value;
}

function selServizio1()
{
    document.getElementById('selServizioIav').value = document.getElementById('serviziIav1').value;
}

function load(){
    

    
    var date = "<%=startDate %>";
    var dateEnd = "<%=endDate %>";
        var area = "<%=area %>";

    //alert(area);
    
}


</script>
</head>
<body onload="load()">


<form name="frmSearch" method="POST" action="listOfFlowsAnn.jsp">
  
  <input type="hidden" name="selCodeFlusso" value="<%=paramCode%>" />
  <input type="hidden" id="inputData" name="inputData" value="" />
  <input type="hidden" name="selServizioIav" value="<%=serviziIav%>" />  
  
  <table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  
        <tr height="30">
        <td>
          <table width="100%">
            <tr>
              <td>
                <img src="../images/titoloPaginaAnn.gif" alt="" border="0"/>
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
              <TD bgcolor="#0a6b98" class="white">Gestione Eccezioni su base Servizio/Operatore</TD>
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
                           <td width="25%" class="textB" align="Left">&nbsp;Ambito:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td width="25%" class="text" align="Left">                             
                           
                              <select class="text" title="ambito Iav" id="ambitoIav" onchange="onChangeAmbito(this.value);" name="ambitoIav">
                               <!-- <option value="-1">[Seleziona Opzione]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                   -->
                                  <% if("Assurance".equals(ambitoIav)){ %>
                                   
                                   <option value="Assurance" selected>Assurance</option>
                                    
                                    <% } else { %>
                                    
                                   <option value="Assurance">Assurance</option>
                                   
                                   <% } %>
                                   
                                    <% if("Provisioning".equals(ambitoIav)){ %>
                                   
                                   <option value="Provisioning" selected>Provisioning</option>
                                    
                                    <% } else { %>
                                    
                                   <option value="Provisioning">Provisioning</option>
                                   
                                   <% } %>   
                                    <% if("TUTTI".equals(ambitoIav)){ %>
                                   
                                   <option value="TUTTI" selected>TUTTI</option>
                                    
                                    <% } else { %>
                                    
                                   <option value="TUTTI">TUTTI</option>
                                   
                                   <% } %>   
                              </select>

                            <!-- </select> -->
                          </td>
                          <td width="25%" class="textB" align="Left">&nbsp;Codice Servizio:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                          <td width="25%" class="text" align="Left">                             
                           
   <div id="provisioninglist" name="provisioninglist">
                               <select class="text" title="servizi iav" id="serviziIav" name="serviziIav" onchange="selServizio();">
                                <option value="TUTTI">TUTTI</option>
                                  <%
                                  
                                  TypeFlussoIav objSer; 
                                  
                                  for(int i = 0; i < listaServizi.size(); i++){
                                  
                                  objSer=(TypeFlussoIav)listaServizi.get(i);
                                  String sChecked="";
                                  if (objSer.getDescr().indexOf("Provisioning")>=0) {
                                  
                                    if (objSer.getType().equals(serviziIav)){
                                        sChecked="Selected";
                                    }else{  
                                        sChecked="";                                    
                                    }
                                  %>
                                  
                                  <option value='<%=objSer.getType()%>' <%=sChecked%> class='text'><%=objSer.getType()%>-<%=objSer.getDescr()%></option>
                                  
                                  <%
                                        }
                                  }
                                   %>                                  
                              </select>
</div>                              
<div id="assurancelist" name="assurancelist">
                               <select class="text" title="servizi iav" id="serviziIav1" name="serviziIav1" onchange="selServizio1();">
                               <option value="">TUTTI</option>
                               <!-- <option value="-1">[Seleziona Opzione]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                   -->
                                   <!--<option value="STAG">Staging</option>-->

                                  <%
                                  
                                  //TypeFlussoIav objSer; 
                                  String sChecked="";
                                  for(int i = 0; i < listaServizi.size(); i++){
                                  
                                  objSer=(TypeFlussoIav)listaServizi.get(i);
                                  if (objSer.getDescr().indexOf("Assurance")>=0) {
                                    if (objSer.getType().equals(serviziIav)){
                                        sChecked="Selected";
                                    }else{  
                                        sChecked="";                                    
                                    }
                                  %>
                                  
                                  <option value='<%=objSer.getType()%>' <%=sChecked%> class='text'><%=objSer.getType()%>-<%=objSer.getDescr()%></option>
                                  
                                  <%
                                        }
                                  }
                                   %>                                  
                              </select>
</div>
   <div id="tuttilist" name="tuttilist">
                               <select class="text" title="servizi iav" id="serviziIav" name="serviziIav">
                               <option value="">TUTTI</option>
                              </select>
</div>                              
                              
                            <!-- </select> -->
                          </td>   
                        </tr>
                  </table>
                 </td> 
                    </tr>
<tr>
                 <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#cfdbe9">
                        <tr>
                           <td width="25%" class="textB" align="Left">&nbsp;Codice Fonte:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td width="25%" class="text" align="Left">                             
                           
                               <select class="text" title="fonte iav" id="fonteIav" name="fonteIav">
                               <option value="TUTTI">TUTTI</option>
                               <!-- <option value="-1">[Seleziona Opzione]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                   -->
                                   <!--<option value="STAG">Staging</option>-->

                                  <%
                                  
                                  TypeFlussoIav objFon; 
                                  
                                  for(int i = 0; i < listaFonti.size(); i++){
                                  
                                  objFon=(TypeFlussoIav)listaFonti.get(i);
                                  
                                    if(objFon.getType().equals(fontiIav)){
                                          
                                          %>

                                          <option selected value='<%=objFon.getType()%>' class='text'><%=objFon.getDescr()%></option>
                                          
                                          <%
                                          }else{
                                          %>
                                          <option value='<%=objFon.getType()%>' class='text'><%=objFon.getDescr()%></option>
                                          
                                          <%
                                            }                                 
           
                                        }
                                   %>                                  
                              </select>

                            <!-- </select> -->
                          </td>
                          <td width="25%" class="textB" align="Left">&nbsp;Classificazione Tecnica:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                          <td width="25%" class="text" align="Left">                             
                           
                               <select class="text" title="classtecnica iav" id="classtecnicaIav" name="classTecIav">
                               <option value="TUTTI">TUTTI</option>
                               <!-- <option value="-1">[Seleziona Opzione]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                   -->
                                   <!--<option value="STAG">Staging</option>-->

                                  <%
                                  
                                  TypeFlussoIav objClassTec; 
                                  
                                  for(int i = 0; i < listaClassTec.size(); i++){
                                  
                                  objClassTec=(TypeFlussoIav)listaClassTec.get(i);
                                  
                                     if(objClassTec.getType().equals(classTecIav)){
                                          
                                          %>

                                          <option selected value='<%=objClassTec.getType()%>' class='text'><%=objClassTec.getDescr()%></option>
                                          
                                          <%
                                          }else{
                                          %>
                                          <option value='<%=objClassTec.getType()%>' class='text'><%=objClassTec.getDescr()%></option>
                                          
                                          <%
                                            }                                         

                                        }
                                   %>                                  
                              </select>
                              
                            <!-- </select> -->
                          </td>   
                        </tr>
                  </table>
                 </td> 
                    </tr>
                    <tr>
            <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#cfdbe9">
                                       
                        <tr>
                           <td width="30%" class="textB" align="Left">&nbsp;Tipologia:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>                         
                           <td width="30%" class="text" align="Left">                             
                           
                               <select class="text" title="tipologia iav" id="tipologiaIav" name="tipologiaIav">
                               
                               <% if("On Field".equals(tipologiaIav)){ %>
                                   
                                   <option value="On Field" selected>On Field</option>
                                    
                                    <% } else { %>
                                    
                                   <option value="On Field">On Field</option>
                                   
                                   <% } %>
                                   
                                    <% if("On Call".equals(tipologiaIav)){ %>
                                   
                                   <option value="On Call" selected>On Call</option>
                                    
                                    <% } else { %>
                                    
                                   <option value="On Call">On Call</option>
                                   
                                   <% } %>   
                                    <% if("TUTTI".equals(tipologiaIav)){ %>
                                   
                                   <option value="TUTTI" selected>TUTTI</option>
                                    
                                    <% } else { %>
                                    
                                   <option value="TUTTI">TUTTI</option>
                                   
                                   <% } %>   
                              </select>
                              
                            <!-- </select> -->
                          </td>   
                       <tr height="3%"></tr>
                       <tr height="3%"></tr>
                       
                                                 <tr>
                           <td width="30%" class="textB" align="Left">&nbsp;Codice Operatore:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                           
                           <td width="30%" class="text" align="Left">                             
                           
                               <select class="text" title="operatore iav" id="operatoreIav" name="operatoreIav">
                               <% if(!operatoreIav.equals("")) { %>  <option value="<%=operatoreIav%>"><%=operatoreIav%></option> <% } %>
                               <option value="">TUTTI</option>
                                  <%
                                  
                                  TypeFlussoIav objOpe; 
                                  
                                  for(int i = 0; i < listaOperatori.size(); i++){
                                  
                                  objOpe=(TypeFlussoIav)listaOperatori.get(i);
           
                                  %>
                                  
                                  <option value='<%=objOpe.getType()%>' class='text'><%=objOpe.getType()%>-<%=objOpe.getDescr()%></option>
                                  
                                  <%
                                        }
                                   %>                                  
                              </select>
                              
                            <!-- </select> -->
                          </td>   
                          <td width="25%" class="textB" align="Left"></td>
                          <td width="25%" class="textB" align="Left"></td>                          
                          
                                                         <tr>
                 <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#cfdbe9">
                        <tr>
                           <td width="30%" class="textB" align="Left">&nbsp;Anche Regole Cessate:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td width="30%" class="text" align="Left">     
                            
                                   <% if(regoleCess==true){ %>
                                   
                                    <input checked type="checkbox" name="regoleCess" value="regoleCess">
                                    
                                    <% } else { %>
                                    
                                   <input type="checkbox" name="regoleCess" value="regoleCess">
                                   
                                   <% } %>   
                           
                               
                              <td width="30%" class="text" align="Left"></td>
                              <td width="30%" class="text" align="Left"></td>
                            <!-- </select> -->
                          </td>      
                        </tr>
                        </table>
                        </td>
                        </tr>
                          
                          
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
      <table class="paginated" style="width:100%;" align='center' border="0" cellspacing="0" cellpadding="0">

            <thead>
            <tr> 
              <th width="5%" bgcolor="#ffffff" class='white'>&nbsp;</th>
              <th class="textB" bgcolor='#D5DDF1' width="8%">Data Comp. Da</th>
              <th class="textB" bgcolor='#D5DDF1' width="8%">Data Comp. A</th>
              <th class="textB" bgcolor='#D5DDF1' width="8%">Data Inizio Val</th>
              <th class="textB" bgcolor='#D5DDF1' width="8%">Data Fine Val</th>
              <th class="textB" bgcolor='#D5DDF1' width="8%">Desc Utente</th>
              <th class="textB" bgcolor='#D5DDF1' width="8%">Cod. Servizio</th>
              <th class="textB" bgcolor='#D5DDF1' width="8%">Class. Tecnica</th>
              <th class="textB" bgcolor='#D5DDF1' width="8%">Cod. Fonte</th>
              <th class="textB" bgcolor='#D5DDF1' width="8%">Ambito</th>
              <th class="textB" bgcolor='#D5DDF1' width="8%">Tipologia</th>
              <th class="textB" bgcolor='#D5DDF1' width="8%">Operatore</th>
            </tr>
            </thead>
            
            <% if(resultEccezioni != null){ %>
            
                <%
                String bgcolor="";
                String checked;  
                boolean  caricaDesc=true;
                %>
                
            <tbody id="tBody">
            
              <%
              
              //Integer records_per_page = 10;
              
                for (int i=0;i<resultEccezioni.size();i++){
                
                ResultEccezioniIav obj = (ResultEccezioniIav)resultEccezioni.get(i);//qui
                
                  if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;
                        
                
                %>
                
                <tr style="text-align:center;" id="<%=obj.getCodice()%>" bgcolor="<%=bgcolor%>">
                <td bgcolor="<%=bgcolor%>" width='5%'>
                        <input bgcolor='<%=bgcolor%>'  type='hidden'  value="<%=obj.getCodice()%>" name="SelOf" >
                        <% SimpleDateFormat sdformat = new SimpleDateFormat("dd/MM/yyyy");
                        Date today=sdformat.parse(sdformat.format(new Date()));
                           //Date fineVal= new Date(obj.getDataFineVal().indexOf(0,2),obj.getDataFineVal().indexOf(3,2),obj.getDataFineVal().indexOf(6,4));
                           Date fineVal=today;
                           if(obj.getDataFineVal() != null && (obj.getDataFineVal().length() > 1)) { 
                                fineVal=new SimpleDateFormat("dd/MM/yyyy").parse(obj.getDataFineVal());
                                }
                        if((obj.getDataFineVal() != null && obj.getDataFineVal().contains("/") && (obj.getDataFineVal().length() > 1)) && fineVal.compareTo(today)<0){ %>                        
                        <input type='checkbox' disabled='disabled'>
                        <% }else{ %>
                        <input type='checkbox' onclick="onChangeChecked(event)" value="<%=obj.getCodice()%>" name="checkBoxes">
                        <% }%>
                </td>
                 <td class="textB" width="8%"><%=obj.getDataRifDa()%></td>
                 <td class="textB" width="8%"><%=obj.getDataRifA()%></td>
                 <td class="textB" width="8%"><%=obj.getDataInizioVal()%></td>
                 <td class="textB" width="8%"><%=obj.getDataFineVal()%></td>
                 <td class="textB" width="8%"><%=obj.getDescUtente()%></td>
                 <td class="textB" width="8%"><%=obj.getServizioIav()%></td>
                 <td class="textB" width="8%"><%=obj.getClassTecnica()%></td>
                 <td class="textB" width="8%"><%=obj.getCodiceFonte()%></td>
                 <td class="textB" width="8%"><%=obj.getAmbito()%></td>
                 <td class="textB" width="8%"><%=obj.getTipologiaIav()%></td>
                 <td class="textB" width="8%"><%=obj.getNomeOlo()%></td>
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
            <input id="btn1" style="display:none;" class="textB" onclick="return prepareEditData()" type="submit" value="Modifica" name="button">
</span>
  
  </form>
</body>

<script>

function prepareEditData(){

var result=false;

var fromdate = new Date();
var dd = fromdate.getDate()+1;
var mm = fromdate.getMonth()+1; //January is 0!
var yyyy = fromdate.getFullYear();
            if(dd < 10)
            {
	            dd = '0'+ dd;
            }
            if(mm < 10)
            {
	            mm = '0' + mm;
            }
            var fromdate1 = dd+'/'+mm+'/'+yyyy;

var data = prompt("Inserisci data di fine regola (dd/MM/yyyy)",fromdate1);

if (data != null) {


        $("#inputData").val(data);
        result=true;


}else{
        alert("Data non inserita");       
    }


return result;
}

function onChangeChecked(e){

    e.cancelBubble=true;

    
    if ($('input[name="checkBoxes"]:checked').length>0) {        
        document.getElementById("btn1").style.display = "block";
    }
    else{   
        document.getElementById("btn1").style.display = "none";
    }

}


function buildModal(classTecnica,codiceFonte,ambito,servizioIav,tipologiaIav)
{

alert("Class Tecnica: "+ classTecnica +"\nCodice Fonte: "+ codiceFonte +"\nAmbito: "+ ambito+"\nServizio Iav: "+ $("#serviziIav option[value='"+servizioIav+"']").text()+"\nTipologia: "+ tipologiaIav);

return false;
}

</script>

<script>



function onChangeAmbito(val)
{

    var num_option=document.getElementById('serviziIav').options.length;
        
    if(val=="Provisioning")
    {
       document.getElementById('assurancelist').style.display='none';
       document.getElementById('provisioninglist').style.display='block';
       document.getElementById('tuttilist').style.display='none';
       
       selServizio();
    }
    else if(val=="Assurance")
    {
       document.getElementById('assurancelist').style.display='block';
       document.getElementById('provisioninglist').style.display='none';
       document.getElementById('tuttilist').style.display='none';
       
       selServizio1();
     } else      
    if(val=="TUTTI")
    {
       document.getElementById('assurancelist').style.display='none';
       document.getElementById('provisioninglist').style.display='none';
       document.getElementById('tuttilist').style.display='block';
       
       document.getElementById('selServizioIav').value = 'TUTTI';
/*
        document.getElementById("serviziIav").selectedIndex = "0";
        document.getElementById("serviziIav").disabled = true;
    }else{
            document.getElementById("serviziIav").disabled = false;
*/
     }

}


onChangeAmbito( $("#ambitoIav").val() );

</script>

<script>

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