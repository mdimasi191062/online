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
EccezioniBaseOperatoreIAV eccezioniBaseOpeIav = new EccezioniBaseOperatoreIAV();

Vector<TypeFlussoIav> listaFlussi = eccezioniBaseOpeIav.getListaFlussi();

Vector<TypeFlussoIav> listaServizi = eccezioniBaseOpeIav.getListaServizi();
Vector<TypeFlussoIav> listaOperatori = eccezioniBaseOpeIav.getListaOperatori();

Vector<ResultRefuseIav> resultFlussi = null;

String paramCode = null;

String startDate = null;
String endDate = null;
String startDate2 = null;
String endDate2 = null;
String motivazioneBlocco = null;
String note = null;
String serviziIav = null;
String operatoreIav = null;
String ambitoIav = null;

String area = null;
String nameCode = null;

Boolean insertRow= null;

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
    endDate ="";
}

if(request.getParameter("startDate2") != null){
    startDate2 = request.getParameter("startDate2");
}else{
    Calendar cal = Calendar.getInstance();       
    cal.add( Calendar.DATE, 1 ); 
    startDate2 = dateFormat.format(cal.getTime());

}

if(request.getParameter("endDate2") != null){
    endDate2 = request.getParameter("endDate2");
}else{
    endDate2 ="";
}

if(request.getParameter("note") != null){
    note = request.getParameter("note");
}else
note="";

if(request.getParameter("motivazioneBlocco") != null){
    motivazioneBlocco = request.getParameter("motivazioneBlocco");
}else
motivazioneBlocco="";

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

if(request.getParameter("ambitoIav") != null){
    ambitoIav = request.getParameter("ambitoIav");
} else {
    ambitoIav = "Assurance";
}

if(paramCode != null){
  
    /*System.out.println(note);
    System.out.println(motivazioneBlocco);
    
    System.out.println(ambitoIav);
    System.out.println(operatoreIav);
    System.out.println(serviziIav);*/
    
    System.out.println(startDate);
    System.out.println(endDate);
    System.out.println(startDate2);
    System.out.println(endDate2);
    
if(startDate.equals("") || startDate2.equals("") || motivazioneBlocco.equals("")){
//JOptionPane.showMessageDialog(null, "Warning: Mancano alcune date!", "InfoWindow", JOptionPane.WARNING_MESSAGE);
                                  %>
                                        
                                        <script>
                                        
                                        alert("Date di inizio e motivazione blocco, sono obbligatori!");
                                        
                                        </script>
                                        
                                        <%
}else{
    insertRow = eccezioniBaseOpeIav.insertDataFromInput(startDate, endDate, startDate2, endDate2, ambitoIav, serviziIav, operatoreIav, note, motivazioneBlocco);  
    
    if(insertRow==false)
    {
                                         %>
                                        <script>                                    
                                        alert("Errore Generico");
                                        </script>                                      
                                        <%
    }else{
    
                                        %>
                                        <script>                                    
                                        alert("Inserimento concluso con successo!");
                                        </script>                                      
                                        <%
    
    }
    insertRow=null;
    
}


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

</head>

<script>



function onChangeAmbito(val)
{

    var num_option=document.getElementById('serviziIav').options.length;
        
    if(val=="Provisioning")
    {
       document.getElementById('assurancelist').style.display='none';
       document.getElementById('provisioninglist').style.display='block';
    }
    else
    {
       document.getElementById('assurancelist').style.display='block';
       document.getElementById('provisioninglist').style.display='none';
     }
}

//onChangeAmbito( $("#ambitoIav").val() );

</script>

<body onload="onChangeAmbito('Assurance')">

<script>

function cancelCalendar2 ()
{
  document.frmSearch.endData2.value="";
}

</script>

<form name="frmSearch" method="GET" action="listOfFlows.jsp">
  
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
              <TD bgcolor="#0a6b98" class="white">Inserimento Eccezioni su Base Operatore</TD>
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
                  <table width="50%" border="0" cellspacing="0" cellpadding="0" bgcolor="#cfdbe9">
                  
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
                                   
                              </select>
                              
                            <!-- </select> -->
                          </td>
                          <td width="25%" class="textB" align="Left"></td>
                          <td width="25%" class="textB" align="Left"></td>
                        </tr>
                        <tr height="3%"></tr>
                        <tr>
                           <td width="25%" class="textB" align="Left">&nbsp;Codice Servizio:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                           
                           <td width="25%" class="text" align="Left">                             
<div id="provisioninglist" name="provisioninglist">
                               <select class="text" title="servizi iav" id="serviziIav" name="serviziIav">
                               <!--<option value="">TUTTI</option>-->
                               <!-- <option value="-1">[Seleziona Opzione]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                   -->
                                   <!--<option value="STAG">Staging</option>-->

                                  <%
                                  
                                  TypeFlussoIav objSer; 
                                  
                                  for(int i = 0; i < listaServizi.size(); i++){
                                  
                                  objSer=(TypeFlussoIav)listaServizi.get(i);
                                  if (objSer.getDescr().indexOf("Provisioning")>=0) {
                                  %>
                                  
                                  <option value='<%=objSer.getType()%>' class='text'><%=objSer.getType()%>-<%=objSer.getDescr()%></option>
                                  
                                  <%
                                        }
                                  }
                                   %>                                  
                              </select>
</div>                              
<div id="assurancelist" name="assurancelist">
                               <select class="text" title="servizi iav" id="serviziIav" name="serviziIav">
                               <!--<option value="">TUTTI</option>-->
                               <!-- <option value="-1">[Seleziona Opzione]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                   -->
                                   <!--<option value="STAG">Staging</option>-->

                                  <%
                                  
                                  //TypeFlussoIav objSer; 
                                  
                                  for(int i = 0; i < listaServizi.size(); i++){
                                  
                                  objSer=(TypeFlussoIav)listaServizi.get(i);
                                  if (objSer.getDescr().indexOf("Assurance")>=0) {
                                  %>
                                  
                                  <option value='<%=objSer.getType()%>' class='text'><%=objSer.getType()%>-<%=objSer.getDescr()%></option>
                                  
                                  <%
                                        }
                                  }
                                   %>                                  
                              </select>
</div>                              
                            <!-- </select> -->
                          </td>   
                          <td width="25%" class="textB" align="Left"></td>
                          <td width="25%" class="textB" align="Left"></td>
                          </tr>
                          <tr>
                           <td width="25%" class="textB" align="Left">&nbsp;Codice Operatore:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                           
                          <td width="25%" class="text" align="Left">                             
                           
                               <select class="text" title="operatore iav" id="operatoreIav" name="operatoreIav">
                               <!-- <option value="-1">[Seleziona Opzione]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                   -->
                                   <!--<option value="STAG">Staging</option>-->

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
                       <tr height="3%"></tr>
                       <tr height="3%"></tr>
        <tr>
                 <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#cfdbe9">
                        <tr>
                            <td width="50%" class="textB" align="left" >&nbsp;Data Competenza da:&nbsp;
                                 <input type="hidden" id=data_ini_tmp value= "06/10/2019"> 
                                  <input size=10 class="text" type="text" align="right" id="startDate" name="startDate"  value="<%=startDate%>"></td>
                                  <td size=5> &nbsp;    <a href="javascript:showCalendar('frmSearch.startDate','');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img src="../../common/images/body/calendario.gif" border="0" valign="Bottom" alt="Click per selezionare una data"  WIDTH="24" HEIGHT="24"></a></td>
                                  <td size=5>  &nbsp;   <a href="javascript:cancelCalendar1();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_fine' src="../../common/images/body/cancella.gif" border="0" valign="Bottom" WIDTH="24" HEIGHT="24"></a>&nbsp;</td> 
                            
                            <td width="50%" class="textB" align="left" >&nbsp;Data Competenza a:&nbsp;
                                  <input size=10 class="text" type="text" align="right" id="endDate" name="endDate" value="<%=endDate%>"></td>
                                  <td size=5> &nbsp;    <a href="javascript:showCalendar('frmSearch.endDate','');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img src="../../common/images/body/calendario.gif" border="0" valign="Bottom" alt="Click per selezionare una data"  WIDTH="24" HEIGHT="24"></a></td>
                                  <td size=5>  &nbsp;   <a href="javascript:cancelCalendar2();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_fine' src="../../common/images/body/cancella.gif" border="0" valign="Bottom" WIDTH="24" HEIGHT="24"></a>&nbsp;</td> 
                        </tr>
                  </table>
                 </td> 
                    </tr>
                    <tr height="3%"></tr>
                <tr>
                 <td colspan="2">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#cfdbe9">
                        <tr>
                            <td width="50%" class="textB" align="left" >&nbsp;Motivazione del blocco:&nbsp;&nbsp;&nbsp;

                            </td>
                            <td width="50%" class="textB" align="left" >
                                      <textarea id="motivazioneBlocco" name="motivazioneBlocco" rows="4" cols="80"></textarea>
                            </td>
                        </tr>
                  </table>
                 </td> 
                    </tr>
                    <tr height="3%"></tr>
                <tr>
                 <td colspan="2">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#cfdbe9">
                        <tr>
                            <td width="50%" class="textB" align="left" >&nbsp;Note:&nbsp;&nbsp;&nbsp;
                            </td>
                            <td width="50%" class="textB" align="left" >
                                      <textarea id="note" name="note" rows="4" cols="80" required></textarea>
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
                            <td width="50%" class="textB" align="left" >&nbsp;Data Inizio Validita Regola:&nbsp;
                                 <input type="hidden" id=data_ini_tmp value= "06/10/2019"> 
                                  <input size=10 class="text" type="text" align="right" id="startDate2" name="startDate2"  value="<%=startDate2%>"></td>
                                  <td size=5> &nbsp;    <a href="javascript:showCalendar('frmSearch.startDate2','');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img src="../../common/images/body/calendario.gif" border="0" valign="Bottom" alt="Click per selezionare una data"  WIDTH="24" HEIGHT="24"></a></td>
                                  <td size=5>  &nbsp;   <a href="javascript:cancelCalendar3();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_fine' src="../../common/images/body/cancella.gif" border="0" valign="Bottom" WIDTH="24" HEIGHT="24"></a>&nbsp;</td> 
                            
                            <td width="50%" class="textB" align="left" >&nbsp;Data Fine Validita Regola&nbsp;
                                  <input size=10 class="text" type="text" align="right" id="endDate2" name="endDate2" value="<%=endDate2%>"></td>
                                  <td size=5> &nbsp;    <a href="javascript:showCalendar('frmSearch.endDate2','');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img src="../../common/images/body/calendario.gif" border="0" valign="Bottom" alt="Click per selezionare una data"  WIDTH="24" HEIGHT="24"></a></td>
                                  <td size=5>  &nbsp;   <a href="javascript:cancelCalendar4();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_fine' src="../../common/images/body/cancella.gif" border="0" valign="Bottom" WIDTH="24" HEIGHT="24"></a>&nbsp;</td> 
                        </tr>
                  </table>
                 </td> 
                    </tr>
                    <tr>

                      </tr>
                    

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
    <input class="textB" type="submit" onclick="return prepareInsertRif();" name="SEARCH" value="Inserisci">  
</span>

  </form>     
  <!--<input class="textB" type="button" name="INSERT" value="Insert" onclick="ONDINSERT();"> -->

               
</body>
<script>

function cancelCalendar1(){

document.getElementById("startDate").value = "";

}

function cancelCalendar2(){

document.getElementById("endDate").value = "";

}

function cancelCalendar3(){

document.getElementById("startDate2").value = "";

}

function cancelCalendar4(){

document.getElementById("endDate2").value = "";

}



function prepareInsertRif (){

//alert("Inserisco l'eccezione!");

var result=false;

var dataStart=document.getElementById("startDate").value;
var dataEnd=document.getElementById("endDate").value;

var parts = dataStart.split("/");
var dtS = new Date(parseInt(parts[2], 10),
                  parseInt(parts[1], 10) - 1,
                  parseInt(parts[0], 10));
                  
var parts2 = dataEnd.split("/");
var dtE = new Date(parseInt(parts2[2], 10),
                  parseInt(parts2[1], 10) - 1,
                  parseInt(parts2[0], 10));

var d1 = Date.parse(dtS);
var d2 = Date.parse(dtE);
//var today = new Date();

if (isNaN(d1) == false){

    //if(d1 >= today){
    
            if(dataEnd!=""){
                    
                    if (isNaN(d2) == false){

                        if (d2 < d1){ 
                            alert ("Data di fine Competenza minore di quella di inizio!");
                        }
                        else{
                            result=prepareInsertVal();
                        }
                                         
                    }else{
                        alert ("Formato data di fine Competenza non valida! (dd/MM/yyyy)");
                        cancelCalendar4();
                    }
            
            }else{
                result=prepareInsertVal();
            }
            
    
    
    //}else{
        //alert ("Data di inizio Riferimento inferiore alla data di sistema!");
    //}


}else{
    alert ("Formato data di inizio Competenza non valida! (dd/MM/yyyy)");
    cancelCalendar3();
    
}

return result;

}


function prepareInsertVal (){

var result=false;

var dataStart=document.getElementById("startDate2").value;
var dataEnd=document.getElementById("endDate2").value;

var parts = dataStart.split("/");
var dtS = new Date(parseInt(parts[2], 10),
                  parseInt(parts[1], 10) - 1,
                  parseInt(parts[0], 10));
                  
var parts2 = dataEnd.split("/");
var dtE = new Date(parseInt(parts2[2], 10),
                  parseInt(parts2[1], 10) - 1,
                  parseInt(parts2[0], 10));

var d1 = Date.parse(dtS);
var d2 = Date.parse(dtE);

var today = new Date();

if (isNaN(d1) == false){

    if(d1 >= today){
    
            if(dataEnd!=""){
                    
                    if (isNaN(d2) == false){
                               
                        if (d2 < d1){ 
                            alert ("Data di fine Validità Regola maggiore di quella di inizio!");
                        }
                        else{
                            result=true;
                        }
                                         
                    }else{
                        alert ("Formato data di fine Validità Regola non valida! (dd/MM/yyyy)");
                        cancelCalendar4();
                    }
            
            }else{
                result=true;
            }
            
    
    
    }else{
        alert ("Data di inizio Validità Regola inferiore alla data di sistema!");
    }


}else{
    alert ("Formato data di inizio Validità  Regola non valida! (dd/MM/yyyy)");
    cancelCalendar3();
    
}

return result;

}


/*

    if (isNaN(d1) == false && isNaN(d2) == false) {
    
        if (d2 < d1) 
            alert ("Data di fine Validità maggiore della data di inizio!");
        else
            result=true;
    
    }else
        alert ("Formato data validità non corretto!");


return result;
}

*/

</script>
</html>
