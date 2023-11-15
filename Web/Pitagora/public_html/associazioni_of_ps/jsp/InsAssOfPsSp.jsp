<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*,,com.usr.*,java.text.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="vec_BOTTONI" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3007,"Associazione Of Ps per tipo contratto")%>
<%=StaticMessages.getMessage(3006,"InsAssOfPsSp.jsp")%>
</logtag:logData>
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

// cod_tipo_contr
String cod_tipo_contr=request.getParameter("codiceTipoContratto");
if (cod_tipo_contr==null) cod_tipo_contr    = request.getParameter("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("cod_tipo_contr");

// des_tipo_contr
String des_tipo_contr=request.getParameter("hidDescTipoContratto");
if (des_tipo_contr==null) des_tipo_contr=request.getParameter("des_tipo_contr");
if (des_tipo_contr==null) des_tipo_contr=(String)session.getAttribute("des_tipo_contr");

// flag_sys
String flag_sys=request.getParameter("hidFlagSys");
if (flag_sys==null) flag_sys=request.getParameter("flag_sys");
if (flag_sys==null) flag_sys=(String)session.getAttribute("flag_sys");

// intFunzionalita
String intFunzionalita=request.getParameter("intFunzionalita");

// act
String act = request.getParameter("act");

// Data
String data_ini_mmdd=com.utl.Utility.getDateMMDDYYYY();
// Codice Utente
clsInfoUser strUserName         = (clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
String codiceUtente             = strUserName.getUserName();
// Dichiarazione variabili
Vector contrVect=null;
Vector classFatt_vect=null;
//PASQUALE
Vector clusterTipo_vect=null;
String s_cod_ps=request.getParameter("cod_PS");
String s_desc_ps=request.getParameter("des_PS");
if(s_desc_ps==null)
  s_desc_ps="";
  
  
  
String cod_cluster=request.getParameter("cod_cluster");
String tipo_cluster=request.getParameter("tipo_cluster");
String tipo_funz=request.getParameter("tipo_funz");  

%>

    <EJB:useHome id="homeClasseFatt" type="com.ejbSTL.ClasseFattSTLHome" location="ClasseFattSTL" />
    <EJB:useHome id="homeOggFatt" type="com.ejbBMP.OggFattBMPHome" location="OggFattBMP" />
    <%
    ClasseFattSTL remoteClasseFatt= homeClasseFatt.create();
    classFatt_vect=remoteClasseFatt.getCfsTipoContr(cod_tipo_contr);
    //session.setAttribute("flg_ClassFatt","true");

//PASQUALE
    if ( "999".equals(intFunzionalita) || "998".equals(intFunzionalita) ) {
        clusterTipo_vect= remoteClasseFatt.getClusterTipoContr(cod_tipo_contr);
    }

if ((act==null)||(act.equalsIgnoreCase("Nuovo")))
  {
    // imposto nella session a null l'oggetto (vector) che contiene le classi
    // di fatturazione
    session.setAttribute("flg_ClassFatt","false");
    session.setAttribute("flg_ModAppl","false");
  }
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE> Nuova Associazione OF/PS</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/InsAssOfPsSp.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript">

function handle_conferma()
{
 //window.alert(">>> handle_conferma");

 
 if (objForm.msg.value=="")
  {
    if (window.confirm("Confermi inserimento associazione Of/Ps ?"))
      {
      EnableAllControls(objForm);
      //window.alert(objForm.act.value);

<%     if ( "999".equals(intFunzionalita) || "998".equals(intFunzionalita)) { %>       
       //PASQUALE
     var str = objForm.oggCluster.options[objForm.oggCluster.selectedIndex].value;
     var res = str.split("||");
     objForm.cod_cluster.value=res[0];
     objForm.tipo_cluster.value=res[1];
     objForm.tipo_funz.value="<%=intFunzionalita%>";
<% } %>       
      objForm.action='<%=request.getContextPath()%>/servlet/GestAssOfPsCntl';
      objForm.submit();
      }
  }  
 else
  {
  window.alert(objForm.msg.value);
  objForm.msg.value="";
  }
 
}

function change_cluster() {
}

function ONCONFERMA()
{
  //window.alert(">>> ONCONFERMA");
  var freqAppl ='';
  var modalAppl = '';
  var shift ='';
  var modalApplPror = '';
  
<% if ( "999".equals(intFunzionalita) || "998".equals(intFunzionalita) ) { %> 
    if (objForm.oggCluster.options[objForm.oggCluster.selectedIndex].value==-1)
    {
    window.alert("Selezionare il cluster dell'oggetto di fatturazione");
    return false;
    }
<% } %>

  if (objForm.des_PS.value=="")
    {
    window.alert("Selezionare il Prodotto/Servizio");
    return false;
    }

  if (objForm.oggFattCombo.options[objForm.oggFattCombo.selectedIndex].value==-1)
    {
    window.alert("Selezionare la classe dell'oggetto di fatturazione");
    return false;
    }

  if (objForm.descFattCombo.options[objForm.descFattCombo.selectedIndex].value==-1)
    {
    window.alert("Selezionare la descrizione dell'oggetto di fatturazione");
    return false;
    }

//  if (objForm.freqCombo.options[objForm.freqCombo.selectedIndex].value==-1)
//    {
//    window.alert("Selezionare la frequenza");
//    return false;
//    }

  var txt_classe=objForm.oggFattCombo.options[objForm.oggFattCombo.selectedIndex].text;
  // canone
  if ((txt_classe.indexOf("Canone")!=-1)||
      (txt_classe.indexOf("CANONE")!=-1)||
      (txt_classe.indexOf("canone")!=-1))
    {
      freqAppl = 2;
      objForm.freqCombo.value = freqAppl;
      modalAppl = 'A';
      objForm.modApplCombo.value = modalAppl;
      modalApplPror = objForm.modApplProrCombo.options[objForm.modApplProrCombo.selectedIndex].value

      if (modalAppl==-1)
        {
        window.alert("Selezionare modalità applicazione");
        return false;
        }

      if (objForm.modApplProrCombo.options[objForm.modApplProrCombo.selectedIndex].value==-1)
        {
        window.alert("Selezionare modalità applicazione prorata");
        return false;
        }
      
    } else {
    freqAppl = 1;
    objForm.freqCombo.value = freqAppl;
    objForm.modApplCombo.value = modalAppl;
    }

//alert('objForm.freqCombo.value ' + objForm.freqCombo.value);
 if ( '1' == modalAppl)
    if ((objForm.shift.value=='')||
        (isNaN(parseInt(objForm.shift.value)))||
        (0>parseInt(objForm.shift.value)))
      {
       window.alert("Il campo shift deve essere impostato ed essere un numerico maggiore di 0");
       return false;
      }

if (objForm.data_ini.value=="")
  {
  window.alert("Imposta la data inizio validità");
  return false;
  }


     var strURL="InsAssOfPsWfSp.jsp";
     strURL+="?act=conferma";
     strURL+="&cod_tipo_contr="+"<%=cod_tipo_contr%>";
     strURL+="&cod_ps="+objForm.cod_PS.value;
     strURL+="&cod_cof="+objForm.oggFattCombo.options[objForm.oggFattCombo.selectedIndex].value;
     strURL+="&cod_of="+objForm.descFattCombo.options[objForm.descFattCombo.selectedIndex].value;
     strURL+="&cod_freq="+freqAppl;
     strURL+="&mod_appl="+modalAppl;
     strURL+="&mod_appl_pr="+modalApplPror;
     strURL+="&shift="+objForm.shift.value;
     strURL+="&data_ini="+objForm.data_ini.value;
     strURL+="&data_fine="+objForm.data_fine.value;
     strURL+="&flag_sys="+"<%=flag_sys%>";

<%     if ( "999".equals(intFunzionalita) || "998".equals(intFunzionalita) ) { %>
//PASQUALE
     var str = objForm.oggCluster.options[objForm.oggCluster.selectedIndex].value;
     var res = str.split("||");
     strURL+="&cod_cluster="+res[0];
     strURL+="&tipo_cluster="+res[1];
     strURL+="&tipo_funz="+"<%=intFunzionalita%>";
     //strURL+="&txt_classe="+txt_classe;
<% } %>        
// window.alert(strURL);
 openDialog(strURL, 400, 5, handle_conferma);

}



function ONANNULLA()
{
//window.alert(">>> ONANNULLA");
// objForm.cmb_contratto.selectedIndex=0;
//    Enable(InsAssOfPsSp.btnPS);
 clear_all_contratto();
}

function clear_partial()
{
//    document.all('fntmodApplCombo').innerText ="";
    clear_all_combo("freqCombo");
    add_combo_elem("freqCombo","-1","[Seleziona Opzione]                              ");
    objForm.freqCombo.selectedIndex=0;
    Disable(objForm.freqCombo);

    clear_all_combo("modApplProrCombo");
    add_combo_elem("modApplProrCombo","-1","[Seleziona Opzione]                              ");
    objForm.modApplProrCombo.selectedIndex=0;
    Disable(objForm.modApplProrCombo);

    clear_all_combo("modApplCombo");
    add_combo_elem("modApplCombo","-1","[Seleziona Opzione]                              ");
    objForm.modApplCombo.selectedIndex=0;
    Disable(objForm.modApplCombo);

if (attivaCalendario)
    {
      dis_calendario_INI();
      dis_calendario_FINE();
    }
  objForm.shift.value=""
  Disable(objForm.shift);
  objForm.data_ini.value=""
  objForm.data_fine.value=""
}


function change_classe()
{
  objForm.descFattCombo.selectedIndex=0;
  Disable(objForm.descFattCombo);
  clear_partial();
  var canone = '&canone=';

 var txt_classe=objForm.oggFattCombo.options[objForm.oggFattCombo.selectedIndex].text;
// alert ( 'txt_classe = ' + txt_classe);
   if ((txt_classe.indexOf("Canone")!=-1)||
           (txt_classe.indexOf("CANONE")!=-1)||
           (txt_classe.indexOf("canone")!=-1)) {
//    alert('se canone');
    objForm.txtFrequenza.value = 'MENSILE';
    objForm.txtAnticipato.value = 'ANTICIPATO';
    objForm.shift.value="1";
    Enable(objForm.modApplProrCombo);
    Enable(objForm.shift);
    canone +=  'S';
  }
  else {
//          alert('se contributo');
          objForm.txtFrequenza.value = 'UNA TANTUM';
          objForm.txtAnticipato.value = '';
          objForm.shift.value='0';
          clear_all_combo("modApplProrCombo");
          Disable(objForm.freqCombo);
          Disable(objForm.shift);
          Disable(objForm.modApplProrCombo);
          canone +=  'N';
  }

//  alert('cambio');
//  alert(objForm.freqCombo.options[objForm.freqCombo.selectedIndex].value);
//  alert(objForm.freqCombo.options[objForm.freqCombo.selectedIndex].value);
//  alert(objForm.oggFattCombo.options[objForm.oggFattCombo.selectedIndex].value);

// window.alert(">>> change_classe");
 if (objForm.oggFattCombo.options[objForm.oggFattCombo.selectedIndex].value!=-1)
  {
  var strURL="InsAssOfPsWfSp.jsp";
        strURL+="?act=classe";
        strURL+="&cod_tipo_contr="+"<%=cod_tipo_contr%>";
        strURL+="&cod_cof="+objForm.oggFattCombo.options[objForm.oggFattCombo.selectedIndex].value;
        strURL+="&flag_sys="+"<%=flag_sys%>";
        strURL+=canone;

<%     if ( "999".equals(intFunzionalita) || "998".equals(intFunzionalita)) { %>
//PASQUALE
         var str = objForm.oggCluster.options[objForm.oggCluster.selectedIndex].value;
         var res = str.split("||");
         strURL+="&cod_cluster="+res[0];
         strURL+="&tipo_cluster="+res[1];
         strURL+="&tipo_funz="+"<%=intFunzionalita%>";
<% } %>
  //window.alert(strURL);
    
  openDialog(strURL, 400, 5,handle_change_classe);
       
  }
 else
  {
  //objForm.descFattCombo.selectedIndex=0;
  //Disable(objForm.descFattCombo);
  //clear_partial();



  //objForm.freqCombo.selectedIndex=0;
  //Disable(objForm.freqCombo);
  //objForm.modApplProrCombo.selectedIndex=0;
  //Disable(objForm.modApplProrCombo);
  //objForm.modApplCombo.selectedIndex=0;
  //Disable(objForm.modApplCombo);
  //Disable(objForm.CONFERMA);
   
  }

        /*EnableLink (document.links[0],objForm.calendar_ini);
        EnableLink (document.links[1],objForm.cancel_ini); 
        EnableLink (document.links[2],objForm.calendar_fine);
        EnableLink (document.links[3],objForm.cancel_fine); */

        if (!attivaCalendario)
        {
                abi_calendario_INI();
                abi_calendario_FINE();
        }        
        //Enable(objForm.CONFERMA);
}


function change_descr()
{
//window.alert(">>> change_descr");
clear_partial();
 if (objForm.descFattCombo.options[objForm.descFattCombo.selectedIndex].value!=-1)
    {
       var txt_classe=objForm.oggFattCombo.options[objForm.oggFattCombo.selectedIndex].text;
       // contributo
       if ((txt_classe.indexOf("Contributo")!=-1)||
           (txt_classe.indexOf("CONTRIBUTO")!=-1)||
           (txt_classe.indexOf("contributo")!=-1))
          {
          // una tantum=1
          clear_all_combo("freqCombo");
          add_combo_elem("freqCombo","1", "UNA TANTUM");

          objForm.freqCombo.selectedIndex=0;
          Disable(objForm.freqCombo);
          Disable(objForm.modApplProrCombo);
          objForm.modApplProrCombo.selectedIndex=0;
          Disable(objForm.modApplCombo);
          objForm.modApplCombo.selectedIndex=0;

          Disable(objForm.shift);

          }
       else
          {

//          window.alert(">>> Canone");
//      alert('strURL ' + strURL );
//            alert('txt_classe ' + txt_classe );
          if ((txt_classe.indexOf("Canone")!=-1)||
           (txt_classe.indexOf("CANONE")!=-1)||
           (txt_classe.indexOf("canone")!=-1))
            strURL+="&canone=S";
          else
            strURL+="&canone=N";
//      alert('strURL ' + strURL );
          //window.alert(strURL);  
            
          openDialog(strURL, 400, 5,handle_change_descr);
          }

       
        /*EnableLink (document.links[0],objForm.calendar_ini);
        EnableLink (document.links[1],objForm.cancel_ini); 
        EnableLink (document.links[2],objForm.calendar_fine);
        EnableLink (document.links[3],objForm.cancel_fine); */

        if (!attivaCalendario)
        {
                abi_calendario_INI();
                abi_calendario_FINE();
        }        
        //Enable(objForm.CONFERMA);
     }
  else
    { 
         // clear_partial();
    }
}

function change_mod_app()
{
  var selezione=objForm.modApplCombo.options[objForm.modApplCombo.selectedIndex].value;
  if (selezione=="P" || selezione=="-1")
    {
        objForm.shift.value="";
        Disable(objForm.shift);
    }
  else if (selezione=="A")
       {
          //objForm.shift.value="";
          Enable(objForm.shift);
       }
}





function selezionaPs()
{
  app_cod_Ps=objForm.cod_PS.value;
  var strURL="../../tariffe/jsp/ProdServSp.jsp?cod_tipo_contr="+"<%=cod_tipo_contr%>"+"&des_tipo_contr="+"<%=des_tipo_contr%>"+"&chiamante="+"<%="InsAssOfPsSp"%>";
  openDialog(strURL, 750, 400, handleReturnedValuePS);
}

function ripristinaPs()
{
<%
if((act!=null)&&(act.equalsIgnoreCase("nuovo2")))
{
%>
objForm.cod_PS.value=<%=s_cod_ps%>;
//window.alert('desc_ps =<%=s_desc_ps%>');
// window.alert('cod_ps =<%=s_cod_ps%>');
handleReturnedValuePS();
<%
}
%>
}

function onLoadCluster() {
    document.getElementById("oggCluster").disabled = false;
}

</SCRIPT>

</HEAD>

<% if ( "999".equals(intFunzionalita) || "998".equals(intFunzionalita) ) { %>
<BODY onload="on_load();onLoadCluster();">
<% } else { %>
<BODY onload="on_load();">
<%}%>

<form name="InsAssOfPsSp" method="get" action=''>
<input type="hidden" name="cod_utente" id="cod_utente" value="<%=codiceUtente%>">
<input type="hidden" name="msg" id=msg value=""> 
<input type="hidden" name="act" id=act  value= <%=act%>>
<input type="hidden" name="cod_tipo_contr" id="cod_tipo_contr" value= <%=cod_tipo_contr%>>
<input type="hidden" name="des_tipo_contr" id="des_tipo_contr" value= <%=des_tipo_contr%>>

<input type="hidden" name="cod_PS" id="cod_PS" value="">
<input type="hidden" name="flag_sys" id="flag_sys" value= <%=flag_sys%>>

<input type="hidden" name="cod_cluster" id="cod_cluster" value= <%=cod_cluster%>>
<input type="hidden" name="tipo_cluster" id="tipo_cluster" value= <%=tipo_cluster%>>
<input type="hidden" name="tipo_funz" id="tipo_funz" value= <%=tipo_funz%>>

<table align='center' width="90%" border="0" cellspacing="0" cellpadding="0">

  <tr>
    <td><img src="../images/titoloPagina.gif" alt="" border="0"></td>
  </tr>

  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>

  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
						<tr>
						  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Nuovo Oggetto di Fatturazione P/S</td>
						  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
						</tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>

  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>

  <tr>
   <td>
    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
     <tr>
			<td>
       <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">

       <tr>
         <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
           <tr>
            <td width="91%" bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top">&nbsp;Prodotto/Servizio&nbsp;</td>
            <td width=" 9%" bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center"><img src="../../common/images/body/quad_blu.gif"></td>
           </tr>
          </table>
         </td>
        </tr>


        <tr>
         <td>

          <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
          <tr> 
          <!-- Tipo contratto -->
            <td width="25%" class="textB" align="right">&nbsp Tipo contratto:&nbsp;</td>
            <td width="55%" class="text" align="left">&nbsp;<%=des_tipo_contr%> </td>
            <td width="20%">&nbsp;</td>
           </tr>

          <!-- Combo Contratti -->
<% if ( "999".equals(intFunzionalita) || "998".equals(intFunzionalita) ) { %>
          <tr> 
            <td width="25%" class="textB" align="right">&nbsp;Cluster:&nbsp;&nbsp;</td>
            <td  class="text" align="left">
              &nbsp;<select class="text" name="oggCluster" onchange='change_cluster();'>
              <option value="-1">[Seleziona Opzione]<%=com.utl.Utility.getSpazi(30)%></option>
              <%
               if ((clusterTipo_vect!=null)&&(clusterTipo_vect.size()!=0))
                  for(Enumeration e=clusterTipo_vect.elements();e.hasMoreElements();)
                    {
                       ClusterTipoContrElem elem=(ClusterTipoContrElem)e.nextElement();
                     %>
                      <option value="<%=elem.getCodeClusterOf()%>||<%=elem.getTipoClusterOf()%>"><%=elem.getDescClusterOf()%></option>
                     <%
                    }
              %>
              </select>
            </td>
           </tr>
<% } %>

          <tr> <!-- Prodotto/Servizio -->
            <td width="25%" class="textB" align="right">&nbsp;Prodotto/Servizio:&nbsp;&nbsp;</td>
            <td  class="text" align="left">
              &nbsp;<input type="text" class="text" name="des_PS" id="des_PS" size=40 value="<%=s_desc_ps%>"></td>
              <td  class="text" align="left">&nbsp;<input class="text" type="button" name="btnPS" align="left" valign="bottom" value="..." onClick="selezionaPs();">
            </td>
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

 <!-- inizio Form applicazione --> 
 <tr>
   <td>
    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
 
     <tr>
			<td>
       <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">

        <tr> <!-- titolo-->
         <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
           <tr>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Oggetto di Fatturazione</td>
            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
           </tr>
          </table>
         </td>
        </tr>

        <tr>
         <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">

           <COL span="1" width="30%">
           <COL span="1" width="70%">


           <!-- combo classe di fatturazione -->
           <tr>
            <td width="25%" class="textB" align="right">&nbsp Classe:&nbsp;</td>
  	        <td width="55%" class="text"> &nbsp 
              <select class="text" name="oggFattCombo" onchange='change_classe();'>
              <option value="-1">[Seleziona Opzione]</option>
              <%
               if ((classFatt_vect!=null)&&(classFatt_vect.size()!=0))
                  for(Enumeration e=classFatt_vect.elements();e.hasMoreElements();)
                    {
                       ClasseFattElem elem=(ClasseFattElem)e.nextElement();
                     %>
                      <option value="<%=elem.getCodeClasseOf()%>"><%=elem.getDescClasseOf()%></option>
                     <%
                    }
              %>
              </select>    
            </td>
            <td width="20%">&nbsp;</td> 
           </tr>


           <!-- combo Descrizione -->
           <tr>
            <td width="25%" class="textB" align="right">&nbsp Descrizione:&nbsp;</td>
            <td width="55%" class="text"> &nbsp
             <select class="text" title="Descrizione Oggetto di Fatturazione" name="descFattCombo" onchange=''>
             <option value="-1">[Seleziona Opzione]<%=com.utl.Utility.getSpazi(30)%></option>
             <option value="-2">&nbsp;</option>
             <option value="-3">&nbsp;</option>
             <option value="-4">&nbsp;</option>
             <option value="-5">&nbsp;</option>
             <option value="-6">&nbsp;</option>
             <option value="-7">&nbsp;</option>
             <option value="-8">&nbsp;</option>
             <option value="-9">&nbsp;</option>
             <option value="-10">&nbsp;</option>
             </select>    
            </td>
            <td width="20%">&nbsp;</td> 
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
 <!-- Fine form applicazione -->

  <tr>
  <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>

 <!-- Inizio form modalità -->


  <tr>
   <td>
    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
     <tr>
			<td>
       <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">

        <tr> <!-- titolo-->
         <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
           <tr>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Modalità Applicazione</td>
            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
           </tr>
          </table>
         </td>
        </tr>

        <tr>
         <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">

           <COL span="1" width="30%">
           <COL span="1" width="70%">

           <!-- Frequenza --> 
           <tr> 
            <td class="textB" width="25%" align="right">&nbsp Frequenza:&nbsp;</td>
            <td align="left" width="55%" class="text" style="display:none">&nbsp;
             <select class="text"  title="Frequenza" name="freqCombo">
              <option value="-1">[Seleziona Opzione]<%=com.utl.Utility.getSpazi(30)%></option>
             </select>
            </td>
            <td class="textB"> 
               <input class="text" name="txtFrequenza" type="text" size="20" maxlength="2" value="" >
            </td>
            <td width="20%">&nbsp;</td>
           </tr>


          <!-- Modalita appl.ne -->
          <tr> 
            <td class="textB" width="25%" align="right">&nbsp Modalità appl.ne:&nbsp;</td>
            <td class="text" width="55%" style="display:none">&nbsp
             <select class="text" name="modApplCombo" onchange='change_mod_app();'>
               <option value="-1">[Seleziona Opzione]<%=com.utl.Utility.getSpazi(30)%></option>
             </select>
            </td>
            <td class="textB" > 
            <input class="text" name="txtAnticipato" type="text" size="20" maxlength="2" value="" >
            </td>
            <td width="20%">&nbsp;</td>
           </tr>

          <tr><!-- Modalita appl.ne prorata -->
            <td class="textB" width="25%" align="right">Modalità appl.ne prorata:</td>
            <td align="left" width="55%" class="text">&nbsp
             <select class="text" name="modApplProrCombo">
              <option value="-1">[Seleziona Opzione]<%=com.utl.Utility.getSpazi(30)%></option>
              <option value="-2">&nbsp;</option>
              <option value="-3">&nbsp;</option>
              <option value="-4">&nbsp;</option>
              <option value="-5">&nbsp;</option>
              <option value="-6">&nbsp;</option>
              <option value="-7">&nbsp;</option>
              <option value="-8">&nbsp;</option>
              <option value="-9">&nbsp;</option>
              <option value="-10">&nbsp;</option>
             </select>
            </td>
            <td width="20%">&nbsp;</td>
         	 </tr>

           <tr><!-- Shift canoni -->
            <td class="textB" align="right">&nbsp Shift canoni:&nbsp;</td>
            <td class="text">&nbsp
            <input class="text" name="shift" type="text" size="2" maxlength="2" value="" > 
            </td>
            <td width="20%">&nbsp;</td>
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

  <!-- Fine modalità applicazione -->   

  <tr>
   <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>

  <!-- Inizio form validità -->  
   <tr>
   <td>
    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
     <tr>
			<td>
       <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">

        <tr> 
         <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
           <tr>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Validità</td>
            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
           </tr>
          </table>
         </td>
        </tr>

        <tr>
         <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">

           <COL span="1" width="25%">
           <COL span="1" width="25%">
           <COL span="1" width="25%">
           <COL span="1" width="25%">

          	<tr>
             <td></td>
             <td></td>
             <td></td>
             <td></td>
          	</tr>


           <tr> 

            <td class="textB" align="left">&nbsp;Data inizio validità:&nbsp;</td>

           <td   align="center" class="text">
                                 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                                  <tr align="center">
                                     <td  align="right"  class="text"> &nbsp; 
                                     <input title="Data inizio" type="text" class="text" size="10" name="data_ini" value="" onblur="handleblur('data_ini');"> </td>
                                     <td  align="left" class="text" size="5"> &nbsp;
                                        <a href="javascript:showCalendar('InsAssOfPsSp.data_ini','<%=data_ini_mmdd%>');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img width=24 name='calendar_ini' src="../../common/images/body/calendario.gif" border="no"></a></td>
                                       <td  align="left" class="text" size="5"> <a href="javascript:cancelCalendarIni();" onMouseOver="javascript:showMessage('seleziona3'); return true;" onMouseOut="status='';return true"><img width=24 name='cancel_ini' src="../../common/images/body/cancella.gif" border="0"></a> 
                                         </td>
                                    </tr>      
                                   </table>
                                  </td>

            <td class="textB" align="left">&nbsp;Data fine validità:&nbsp;</td>

           <td   align="center" class="text">
                                 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                                  <tr align="center">
                                     <td  align="right"  class="text"> &nbsp; 
                                     <input title="Data fine" type="text" class="text" size="10" name="data_fine" value="" onblur="handleblur('data_fine');"> </td>
                                     <td  align="left" class="text" size="5"> &nbsp;
                                        <a href="javascript:showCalendar('InsAssOfPsSp.data_fine','<%=data_ini_mmdd%>');" onMouseOver="javascript:showMessage('seleziona2'); return true;" onMouseOut="status='';return true"><img width=24 name='calendar_fine' src="../../common/images/body/calendario.gif" border="no"></a></td>
                                       <td  align="left" class="text" size="5"> <a href="javascript:cancelCalendarFine();" onMouseOver="javascript:showMessage('seleziona4'); return true;" onMouseOut="status='';return true"><img width=24 name='cancel_fine' src="../../common/images/body/cancella.gif" border="0"></a> 
                                         </td>
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
    </table>
   </td>
  </tr>
  <tr>
   <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>

  <tr>
   <td>
    <sec:ShowButtons VectorName="vec_BOTTONI" />
   </td>
  </tr>

 </table>

</form>
</BODY>
</HTML>
