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
EccezioniBaseServizioIAV eccezioniBaseSerIav = new EccezioniBaseServizioIAV();

Vector<TypeFlussoIav> listaFlussi = eccezioniBaseSerIav.getListaFlussi();

Vector<TypeFlussoIav> listaServizi = eccezioniBaseSerIav.getListaServizi();
Vector<TypeFlussoIav> listaFonti = eccezioniBaseSerIav.getListaFonti();
Vector<TypeFlussoIav> listaClassTec = eccezioniBaseSerIav.getListaClassTec();
Vector<TypeFlussoIav> listaOperatori = eccezioniBaseSerIav.getListaOperatori();

Vector<ResultRefuseIav> resultFlussi = null;

String paramCode = null;

String startDate = null;
String endDate = null;
String startDate2 = null;
String endDate2 = null;

String motivazioneBlocco = null;
String note = null;

String serviziIav = null;
String classTecIav = null;
String tipologiaIav = null;
String fonteIav = null;
String ambitoIav = null;
String operatoreIav=null;

String area = null;
String nameCode = null;
Boolean insertRow= null;

Calendar calendar = Calendar.getInstance();
SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
SimpleDateFormat dateFormatTime = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

if(request.getParameter("selCodeFlusso") != null){
    paramCode = request.getParameter("selCodeFlusso");
}

if(request.getParameter("operatoreIav") != null){
    operatoreIav = request.getParameter("operatoreIav");
} else {
    operatoreIav = "";
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
    startDate2 = dateFormatTime.format(cal.getTime());

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

if(request.getParameter("selServizioIav") != null){
    serviziIav = request.getParameter("selServizioIav");
} else {
    serviziIav = "";
}

if(request.getParameter("ambitoIav") != null){
    ambitoIav = request.getParameter("ambitoIav");
} else {
    ambitoIav = "Assurance";
}

if(request.getParameter("tipologiaIav") != null){
    tipologiaIav = request.getParameter("tipologiaIav");
} else {
    //tipologiaIav = "On Field";
    tipologiaIav = "";
}

if(request.getParameter("fonteIav") != null){
    fonteIav = request.getParameter("fonteIav");
} else {
    fonteIav = "";
}
    
if(request.getParameter("classTecIav") != null){
    classTecIav = request.getParameter("classTecIav");
} else {
    classTecIav = "";
}



if(paramCode != null)
{
  
    System.out.println(note);
    System.out.println(motivazioneBlocco);
    System.out.println(ambitoIav);
    System.out.println(classTecIav);
    System.out.println(serviziIav);
    System.out.println(operatoreIav);
    System.out.println(fonteIav);
    System.out.println(tipologiaIav);
    
     if(startDate.equals("") || startDate2.equals("") || motivazioneBlocco.equals(""))
     {
         %>
         <script>
         alert("Date di inizio e motivazione blocco, sono obbligatori!");
         </script>
         <%
     }
     else
     { 
         insertRow = eccezioniBaseSerIav.insertDataFromInput(startDate, endDate, startDate2, endDate2, ambitoIav, serviziIav, fonteIav, tipologiaIav, classTecIav, note, motivazioneBlocco,operatoreIav);  
         if(insertRow==false)
         {
             %>
             <script>                                    
             alert("Eccezione gia' presente in Base Dati");
             </script>                                      
             <%
         }else
         {
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
        <script language="JavaScript" src="../../common/js/calendar1.js"></script>

</head>
<script>

function selServizio()
{
    document.getElementById('selServizioIav').value = document.getElementById('serviziIav').value;
}

function selServizio1()
{
    document.getElementById('selServizioIav').value = document.getElementById('serviziIav1').value;
}

function onChangeAmbito(val)
{

    //var num_option=document.getElementById('serviziIav').options.length;
        
    if(val=="Provisioning")
    {
        document.getElementById("classtecnicaIav").selectedIndex = "0";
        document.getElementById("fonteIav").selectedIndex = "0";
        
        document.getElementById("classtecnicaIav").disabled = true;
        document.getElementById("fonteIav").disabled = true;

        document.getElementById('assurancelist').style.display='none';
        document.getElementById('provisioninglist').style.display='block';
        
        selServizio();
        
        //for(a=0;a<num_option;a++)
        //{
        //    //alert("Servizio Iav: "+ document.getElementById('serviziIav').options[a].text);
        //    if(document.getElementById('serviziIav').options[a].text.indexOf('Assurance')>0 )
        //    {
	//	document.getElementById('serviziIav').options[a].style.visibility='hidden';
        //    }
        //    else
        //    {
        //        document.getElementById('serviziIav').options[a].style.display='block';
        //    }
        //}    
    }
    else
    {
        document.getElementById("classtecnicaIav").disabled = false;
        if(document.getElementById("fonteIav")!=null) document.getElementById("fonteIav").disabled = false;

	document.getElementById('assurancelist').style.display='block';
        document.getElementById('provisioninglist').style.display='none';
        
        selServizio1();
         
        //    for(a=0;a<num_option;a++)
        //    {
        //        //alert("Servizio Iav: "+ document.getElementById('serviziIav').options[a].text);
        //        if(document.getElementById('serviziIav').options[a].text.indexOf('Provisioning')>0 )
        //        {
        //            document.getElementById('serviziIav').options[a].style.display='none';
        //        }    
        //        else
        //        {
        //            document.getElementById('serviziIav').options[a].style.display='block';
        //        }                           
        //    } 
    }
}

//onChangeAmbito( $("#ambitoIav").val() );

</script>

<body onload="onChangeAmbito('<%=ambitoIav%>')">


<form name="frmSearch" method="GET" action="listOfFlows.jsp">
  
  <input type="hidden" name="selCodeFlusso" value="<%=paramCode%>" />
  <input type="hidden" name="selServizioIav" value="<%=serviziIav%>" />
  
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
              <TD bgcolor="#0a6b98" class="white">Inserimento Eccezioni su Base Servizio/Operatore</TD>
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
                            <td width="75%" class="text" align="Left">                             
                           
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
                        </tr>
                        <tr height="3%"></tr>
                        <tr>
                           <td width="25%" class="textB" align="Left">&nbsp;Codice Servizio:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                           
                           <td width="75%" class="text" align="Left">                             
                           
                           <div id="provisioninglist" name="provisioninglist">
                               <select class="text" title="servizi iav" id="serviziIav" name="serviziIav" onchange="selServizio();">
                               <option value="TUTTI">TUTTI</option>
                               <!-- <option value="-1">[Seleziona Opzione]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                   -->
                                   <!--<option value="STAG">Staging</option>-->

                                  <%
                                  
                                TypeFlussoIav objSer; 
                                String select1 = "";
                                for(int i = 0; i < listaServizi.size(); i++){
                                  
                                  objSer=(TypeFlussoIav)listaServizi.get(i);
                                  select1 = "";
                                  if ( serviziIav.equals( objSer.getType() )) {
                                    select1="selected";
                                  }
                                  

                                  if (objSer.getDescr().indexOf("Provisioning")>=0) {
                                  %>
                                  <option value='<%=objSer.getType()%>' <%=select1%> class='text'><%=objSer.getType()%>-<%=objSer.getDescr()%></option>
                                  <%
                                        }
                                  }
                                   %>                                  
                              </select>
</div>                              
<div id="assurancelist" name="assurancelist">
                               <select class="text" title="servizi iav" id="serviziIav1" name="serviziIav1" onchange="selServizio1();">
                               <option value="TUTTI">TUTTI</option>
                               <!-- <option value="-1">[Seleziona Opzione]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                   -->
                                   <!--<option value="STAG">Staging</option>-->

                                  <%
                                  
                                  //TypeFlussoIav objSer; 
                                  String select2 = "";
                                  for(int i = 0; i < listaServizi.size(); i++){
                                  
                                  objSer=(TypeFlussoIav)listaServizi.get(i);
                                  
                                  select2 = "";
                                  if ( serviziIav.equals( objSer.getType() )) {
                                    select2="selected";
                                  }
                                  if (objSer.getDescr().indexOf("Assurance")>=0) {
                                  %>
                                          <option value='<%=objSer.getType()%>' <%=select2%> class='text'><%=objSer.getType()%>-<%=objSer.getDescr()%></option>
                                          <%
                                            }
           
                                        }
                                   %>                                  
                              </select>
                              </div>
                            <!-- </select> -->
                          </td>   
                          </tr>
                          
                          <tr>
                           <td width="25%" class="textB" align="Left">&nbsp;Codice Fonte:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                           
                           <td width="75%" class="text" align="Left">                             
                           
                               <select class="text" title="fonte iav" id="fonteIav" name="fonteIav">
                               <option value="">TUTTI</option>
                               <!-- <option value="-1">[Seleziona Opzione]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                   -->
                                   <!--<option value="STAG">Staging</option>-->

                                  <%
                                  
                                  TypeFlussoIav objFon; 
                                  
                                  for(int i = 0; i < listaFonti.size(); i++){
                                  
                                  objFon=(TypeFlussoIav)listaFonti.get(i);
                                  
                                    if(objFon.getType().equals(fonteIav)){
                                          
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

                          </tr>
                          
                          <tr>
                           <td width="25%" class="textB" align="Left">&nbsp;Classificazione Tecnica:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                           
                           <td width="75%" class="text" align="Left">                             
                           
                               <select class="text" title="classtecnica iav" id="classtecnicaIav" name="classTecIav">
                               <option value="">TUTTI</option>
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
                          
                          <tr>
                           <td width="25%" class="textB" align="Left">&nbsp;Tipologia:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                           
                          <td width="75%" class="text" align="Left">                             
                           
                               <select class="text" title="tipologia iav" id="tipologiaIav" name="tipologiaIav">
                               <option value="">TUTTI</option>
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
                              </select>
                              
                            <!-- </select> -->
                          </td>   

                       <tr height="3%"></tr>
                       <tr height="3%"></tr>
                       
                                                 <tr>
                           <td width="25%" class="textB" align="Left">&nbsp;Codice Operatore:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                           
                           <td width="75%" class="text" align="Left">                             
                           
                               <select class="text" title="operatore iav" id="operatoreIav" name="operatoreIav">
                               <option value="">TUTTI</option>
                               <!-- <option value="-1">[Seleziona Opzione]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                   -->
                                   <!--<option value="STAG">Staging</option>-->

                                  <%
                                  
                                  TypeFlussoIav objOpe; 
                                  String select3 = "";
                                  for(int i = 0; i < listaOperatori.size(); i++){
                                  
                                  objOpe=(TypeFlussoIav)listaOperatori.get(i);
                                  select3="";
                                  if ( operatoreIav.equals(objOpe.getType())) {
                                    select3="selected";
                                  }
                                  %>
                                  <option value='<%=objOpe.getType()%>' <%=select3%> class='text'><%=objOpe.getType()%>-<%=objOpe.getDescr()%></option>
                                  <%
                                        }
                                   %>                                  
                              </select>
                              
                            <!-- </select> -->
                          </td>   

                          </tr>
                          <tr height="3%"></tr>
                           <tr height="3%"></tr>
                       
        <tr>

                            <td width="25%" class="textB" align="left" >&nbsp;Data Competenza da:&nbsp;</td>
                            <td width="75%" class="text" align="Left">
                                <table width="100%">
                                <tr>
                                  <td><input type="hidden" id=data_ini_tmp value= "06/10/2019"> 
                                  <input size=10 readonly class="text" type="text" align="right" id="startDate" name="startDate"  value="<%=startDate%>"></td>
                                  <td size=5><a href="javascript:showCalendar('frmSearch.startDate','');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img src="../../common/images/body/calendario.gif" border="0" valign="Bottom" alt="Click per selezionare una data"  WIDTH="24" HEIGHT="24"></a></td>
                                  <td size=5><a href="javascript:cancelCalendar1();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_fine' src="../../common/images/body/cancella.gif" border="0" valign="Bottom" WIDTH="24" HEIGHT="24"></a>&nbsp;</td> 
                                  <td width="90%"></td>
                                </tr>
                                </table>
                            </td>
            </tr>
            <tr>
                            <td width="25%" class="textB" align="left" >&nbsp;Data Competenza a:&nbsp;</td>
                            <td width="75%" class="text" align="Left">
                                <table width="100%">
                                <tr>
                                  <td><input size=10 readonly class="text" type="text" align="right" id="endDate" name="endDate" value="<%=endDate%>"></td>
                                  <td size=5><a href="javascript:showCalendar('frmSearch.endDate','');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img src="../../common/images/body/calendario.gif" border="0" valign="Bottom" alt="Click per selezionare una data"  WIDTH="24" HEIGHT="24"></a></td>
                                  <td size=5><a href="javascript:cancelCalendar2();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_fine' src="../../common/images/body/cancella.gif" border="0" valign="Bottom" WIDTH="24" HEIGHT="24"></a>&nbsp;</td> 
                                  <td width="90%"></td>
                                </tr>
                                </table>
                        </tr>
                  </table>
                 </td> 
                    </tr>
                    <tr height="3%"></tr>
                <tr>
                 <td colspan="2">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#cfdbe9">
                        <tr>
                            <td width="25%" class="textB" align="left" >&nbsp;Motivazione del blocco:&nbsp;&nbsp;&nbsp;

                            </td>
                            <td width="75%" class="textB" align="left" >
                                      <textarea id="motivazioneBlocco" name="motivazioneBlocco" rows="4" cols="80"><%=motivazioneBlocco%></textarea>
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
                            <td width="25%" class="textB" align="left" >&nbsp;Note:&nbsp;&nbsp;&nbsp;
                            </td>
                            <td width="75%" class="textB" align="left" >
                                      <textarea id="note" name="note" rows="4" cols="80"><%=note%></textarea>
                            </td>
                        </tr>
                  </table>
                 </td> 
                    </tr>
                    <tr height="3%"></tr>
                
                            <tr>
                 <td>
                  <table width="100%" cellspacing="0" cellpadding="0" bgcolor="#cfdbe9">
                        <tr>
                            <td width="25%" class="textB" align="left" >&nbsp;Data Inizio Validita Regola:&nbsp;</td>
                            <td width="75%">
                                <table width="100%">
                                    <tr>
                                      <td>
                                        <input type="hidden" id=data_ini_tmp value= "06/10/2019"> 
                                        <input size=25 readonly class="text" type="text" align="right" id="startDate2" name="startDate2"  value="<%=startDate2%>"></input></td>
                                        <td size=5><a href="javascript:cal1.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img src="../../common/images/body/calendario.gif" border="0" valign="Bottom" alt="Click per selezionare una data"  WIDTH="24" HEIGHT="24"></a></td>
                                        <td size=5><a href="javascript:cancelCalendar3();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_fine' src="../../common/images/body/cancella.gif" border="0" valign="Bottom" WIDTH="24" HEIGHT="24"></a></td> 
                                        <td width="90%"></td>
                                    </tr>
                                </table>
                            </tr>
                            <tr>
                            <td width="25%" class="textB" align="left" >&nbsp;Data Fine Validita Regola:&nbsp;
                            <td width="75%">
                                <table width="100%">
                                    <tr>
                                      <td><input size=25 readonly class="text" type="text" align="right" id="endDate2" name="endDate2" value="<%=endDate2%>"></input></td>
                                      <td size=5><a href="javascript:cal2.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img src="../../common/images/body/calendario.gif" border="0" valign="Bottom" alt="Click per selezionare una data"  WIDTH="24" HEIGHT="24"></a></td>
                                      <td size=5><a href="javascript:cancelCalendar4();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_fine' src="../../common/images/body/cancella.gif" border="0" valign="Bottom" WIDTH="24" HEIGHT="24"></a>&nbsp;</td> 
                                      <td width="90%"></td>
                                    </tr>
                                </table>
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

<table width="100%">
<tr><td align="center">
    <input class="textB" type="submit" onclick="return prepareInsertRif();" name="SEARCH" value="Inserisci">  
</td></tr></table>

  </form>                         
                 
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



var datastart2 = dataStart.substring(6,10) + dataStart.substring(3,5) + dataStart.substring(0,2) + dataStart.substring(11,13) + dataStart.substring(14,16) + dataStart.substring(17,19);
var dataend2 = dataEnd.substring(6,10) + dataEnd.substring(3,5) + dataEnd.substring(0,2) + dataEnd.substring(11,13) + dataEnd.substring(14,16) + dataEnd.substring(17,19);


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



var mese = today.getMonth() + 1;

var todayChar = (today.getDate() < 10 ? '0' : '') + today.getDate() + "/" + (today.getMonth() < 10 ? '0' : '')  + today.getMonth() + "/" + today.getFullYear() + " " +  (today.getHours() < 10 ? '0' : '') + today.getHours()  + ":" +  (today.getMinutes() < 10 ? '0' : '') + today.getMinutes() + ":" +  (today.getSeconds() < 10 ? '0' : '') + today.getSeconds();
var todayChar2 = today.getFullYear() + (mese < 10 ? '0' : '')  + mese + (today.getDate() < 10 ? '0' : '') + today.getDate() + (today.getHours() < 10 ? '0' : '') + today.getHours()  + (today.getMinutes() < 10 ? '0' : '') + today.getMinutes() + (today.getSeconds() < 10 ? '0' : '') + today.getSeconds();


var partsToday = todayChar.split("/");
var dtToday = new Date(parseInt(partsToday[2], 10),
                  parseInt(partsToday[1], 10) - 1,
                  parseInt(partsToday[0], 10));

today = Date.parse(dtToday);





if (isNaN(d1) == false){

    if(datastart2 >= todayChar2){
    
            if(dataEnd!=""){
                    
                    if (isNaN(d2) == false){
                               
                        if (dataend2 < datastart2){ 

                            alert ("Data di fine Validita' Regola minore di quella di inizio!");
                        }
                        else{
                            result=true;
                        }
                                         
                    }else{
                        alert ("Formato data di fine Validita' Regola non valida! (dd/MM/yyyy)");
                        cancelCalendar4();
                    }
            
            }else{
                result=true;
            }
            
    
    
    }else{
        alert ("Data di inizio Validita' Regola inferiore alla data di sistema!");
    }


}else{
    alert ("Formato data di inizio Validita'  Regola non valida! (dd/MM/yyyy)");
    cancelCalendar3();
    
}

return result;

}

</script>
<script language="JavaScript">
       // Calendario Data Inizio Validit?
       var cal1 = new calendar1(document.forms['frmSearch'].elements['startDate2']);
			 cal1.year_scroll = true;
			 cal1.time_comp = true;
       // Calendario Data Fine Validit?       
       var cal2 = new calendar1(document.forms['frmSearch'].elements['endDate2']);
			 cal2.year_scroll = true;
			 cal2.time_comp = true;
</script>
</html>
