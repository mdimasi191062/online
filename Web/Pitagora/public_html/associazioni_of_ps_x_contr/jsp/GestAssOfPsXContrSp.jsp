<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"GestAssOfPsXContrSp.jsp")%>
</logtag:logData>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="BOTTONI" />
<%
	response.addHeader("Pragma", "no-cache");
	response.addHeader("Cache-Control", "no-store");

String cod_tipo_contr=request.getParameter("codiceTipoContratto");
if (cod_tipo_contr==null) cod_tipo_contr    = request.getParameter("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("codiceTipoContratto");

String des_tipo_contr=request.getParameter("hidDescTipoContratto");
if (des_tipo_contr==null) des_tipo_contr=request.getParameter("des_tipo_contr");
if (des_tipo_contr==null) des_tipo_contr=(String)session.getAttribute("des_tipo_contr");

//String code_contr=request.getParameter("cod_contratto");
String cod_contratto=request.getParameter("cod_contratto");

String disattivi=request.getParameter("disattivi");
if (disattivi==null) disattivi=request.getParameter("disattivi");
if (disattivi==null) disattivi=(String)session.getAttribute("disattivi");

String action=request.getParameter("act");
String codPs=request.getParameter("codPs");
String codCOf=request.getParameter("codCOf");
String codOf=request.getParameter("codOf");
String codModal=request.getParameter("codModal");
String codFreq=request.getParameter("codFreq");
String shift=request.getParameter("shift");
String flag=request.getParameter("flag");
String flag_sys=request.getParameter("flag_sys");
String dataIniOfPs=request.getParameter("dataIniOfPs");
String dataIniOf=request.getParameter("dataIniOf");
String dataFineOf=request.getParameter("dataFineOf");
String dataFineOfPs=request.getParameter("dataFineOfPs");

String desContrattoCmb=request.getParameter("contrattoCombo");

String dataFineAppoggio=request.getParameter("dataFineOf");
if (dataFineAppoggio==null)
  dataFineAppoggio="";
  String data_ini_mmdd=Utility.getDateMMDDYYYY();
  String data_oggi=Utility.getDateDDMMYYYY();


String intFunzionalita=request.getParameter("intFunzionalita");
String cod_cluster=request.getParameter("cod_cluster");
String tipo_cluster=request.getParameter("tipo_cluster");
String tipo_funz=request.getParameter("tipo_funz");  
if ( intFunzionalita == null ) { intFunzionalita = tipo_funz; }
Vector clusterTipo_vect=null;

String descOf="";
String descPs="";
String descCOf="";
String descFreq="";
String descModalAppl="";

      // Creazione oggetto
      AssOfPsXContrBMPPK pk = new AssOfPsXContrBMPPK();
      pk.setCodeTipoContr(cod_tipo_contr);
//      pk.setCodeContr(code_contr);
      pk.setCodeContr(cod_contratto);
      pk.setCodeOf(codOf);
      pk.setCodePs(codPs);
      pk.setCodeCOf(codCOf);
//      pk.setDataIni(dataIni);
      pk.setDataIniOf(dataIniOf);
      pk.setDataIniOfPs(dataIniOfPs);
      pk.setDataFineOf(dataFineOf);
      pk.setDataFineOfPs(dataFineOfPs);
      pk.setCodeModal(codModal);
      pk.setCodeFreq(codFreq);
      pk.setFlagSys(flag_sys); 

      AssOfPsXContrBMPClusPK pk2 = new AssOfPsXContrBMPClusPK();
      pk2.setCodeTipoContr(cod_tipo_contr);
//      pk2.setCodeContr(code_contr);
      pk2.setCodeContr(cod_contratto);
      pk2.setCodeOf(codOf);
      pk2.setCodePs(codPs);
      pk2.setCodeCOf(codCOf);
//      pk2.setDataIni(dataIni);
      pk2.setDataIniOf(dataIniOf);
      pk2.setDataIniOfPs(dataIniOfPs);
      pk2.setDataFineOf(dataFineOf);
      pk2.setDataFineOfPs(dataFineOfPs);
      pk2.setCodeModal(codModal);
      pk2.setCodeFreq(codFreq);
      pk2.setFlagSys(flag_sys); 
      pk2.setCodeCluster(cod_cluster);
      pk2.setTipoCluster(tipo_cluster);
      pk2.setCodeTipoContr(cod_tipo_contr);
      if ( "999".equals(intFunzionalita) || "998".equals(intFunzionalita) ) { %>
      <EJB:useHome id="homeClasseFatt" type="com.ejbSTL.ClasseFattSTLHome" location="ClasseFattSTL" />
      <EJB:useHome id="homeAssClus" type="com.ejbBMP.AssOfPsXContrBMPClusHome" location="AssOfPsXContrBMPClus" />
      <EJB:useBean id="remoteAssClus" type="com.ejbBMP.AssOfPsXContrBMPClus" value="<%=homeAssClus.findByPrimaryKey(pk2)%>" scope="session"></EJB:useBean>
      <%
            
            ClasseFattSTL remoteClasseFatt= homeClasseFatt.create();
            clusterTipo_vect= remoteClasseFatt.getClusterTipoContr(cod_tipo_contr);

	

      descOf=remoteAssClus.getDescOf();


      descCOf=remoteAssClus.getDescCOf();

      descPs=remoteAssClus.getDescPs();


      if (remoteAssClus.getDescFreq()==null)
        descFreq="";
      else
        descFreq=remoteAssClus.getDescFreq();


      if (remoteAssClus.getDescModal()==null)
        descModalAppl="";
      else
        descModalAppl=remoteAssClus.getDescModal();

      desContrattoCmb = remoteAssClus.getDescContr();
      dataFineOf = remoteAssClus.getDataFineOf();

      } else {%>


%>
      <EJB:useHome id="homeAss" type="com.ejbBMP.AssOfPsXContrBMPHome" location="AssOfPsXContrBMP" />
      <EJB:useBean id="remoteAss" type="com.ejbBMP.AssOfPsXContrBMP" value="<%=homeAss.findByPrimaryKey(pk)%>" scope="session"></EJB:useBean>
<%
	
      descOf=remoteAss.getDescOf();

      descCOf=remoteAss.getDescCOf();

      
      descPs=remoteAss.getDescPs();

      if (remoteAss.getDescFreq()==null)
        descFreq="";
      else
        descFreq=remoteAss.getDescFreq();

      if (remoteAss.getDescModal()==null)
        descModalAppl="";
      else
        descModalAppl=remoteAss.getDescModal();

      /*  if (remoteAss.getTipoFlgAP()==null)
          flag="X";
        else
      flag=remoteAss.getTipoFlgAP();*/

     //0210300900
     //desContrattoCmb = "( " +remoteAss.getDescContr()+")";
     desContrattoCmb = remoteAss.getDescContr();

         dataFineOf = remoteAss.getDataFineOf();
//      dataFineOfPs = remoteAss.getDataFineOfPs(); non lo legge il bmp per cui la ottengo come parametro di input

    }
%>
         <EJB:useHome id="homeContr" type="com.ejbSTL.AssOfPsXContrSTLHome" location="AssOfPsXContrSTL" />
         <EJB:useBean id="remoteContr" type="com.ejbSTL.AssOfPsXContrSTL" value="<%=homeContr.create()%>" scope="page"></EJB:useBean>
<%

      String dataMin="";
      int numIdentiche=0;
      
      if ( "999".equals(intFunzionalita) || "998".equals(intFunzionalita) ) { 
            numIdentiche=remoteContr.check_esiste_clus(cod_tipo_contr,cod_contratto,codOf,codPs,cod_cluster,tipo_cluster,cod_tipo_contr);
            dataMin=remoteContr.getMinDataIniCorrClus(cod_tipo_contr,cod_contratto,dataIniOfPs,codOf,codPs,cod_cluster,tipo_cluster);
        
      } else {
        //int numIdentiche=remoteContr.check_esiste(cod_tipo_contr,code_contr,codOf,codPs);
        numIdentiche=remoteContr.check_esiste(cod_tipo_contr,cod_contratto,codOf,codPs);
        //String dataMin=remoteContr.getMinDataIniCorr(cod_tipo_contr,code_contr,dataIniOfPs,codOf,codPs);
        dataMin=remoteContr.getMinDataIniCorr(cod_tipo_contr,cod_contratto,dataIniOfPs,codOf,codPs);
      }
      String title="";
      if ((action!=null)&&(action.equalsIgnoreCase("cancella")))
        {
          title="Cancellazione Associazione OF/PS";
        }

      if (action.equalsIgnoreCase("disattiva"))
        {
          title="Disattivazione Associazione OF/PS";
        }

      if (action.equalsIgnoreCase("visualizza"))
        {
          title="Visualizzazione Associazione OF/PS";
        }
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE> Gestione Oggetto di Fatturazione P/S </TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
<%
/*
        code_of=request.getParameter("SelOf");
        // ricavo i campi che devono essere visualizzati
        GestAssOfPsSpBMPPK pk = new GestAssOfPsSpBMPPK();
        pk.setCodeOf(code_of);
*/      
      %>
<!--    2   -->
      <%
/*
        codePs=remoteAss.getCodePs();
        codCOf=remoteAss.getCodeCOf();
        desc_of=remoteAss.getDescOggFatt();
        dataFineOf=remoteAss.getDataFine();
        flg_tipo_assB=remoteAss.getTipoFlgAssocB();
*/
%>


var msg1="Click per selezionare la data";
var msg2="Click per cancellare la data selezionata";


var dataFineStartOf="<%=dataFineOf%>";
var dataFineStartOfPs="<%=dataFineOfPs%>";

IExplorer =document.all?true:false;
Navigator =document.layers?true:false;

function disabilitato()
{
  if (Navigator)
  {
    document.GestAssOfPsXContrSp.CONFERMA.focus();
    window.alert("campo protetto");
  }
}

function ONANNULLA()
{
  //ripristina la data_fine di partenza
  if (document.GestAssOfPsXContrSp.act.value!="null" && document.GestAssOfPsXContrSp.act.value=="CANCELLA")
    history.back();
  else
  document.GestAssOfPsXContrSp.dataFineOfPs.value=dataFineStartOfPs;
}

function  confermaDisatt()
{
if (confirm("Si conferma la disattivazione dell'associazione?"))
    {
      document.GestAssOfPsXContrSp.act.value="DISATTIVA";
      Enable(document.GestAssOfPsXContrSp.dataFineOfPs);
      document.GestAssOfPsXContrSp.action='<%=request.getContextPath()%>/servlet/GestAssOfPsXContrCntl';
      document.GestAssOfPsXContrSp.submit();
    }  
}

function ONCONFERMA()
{
  if (document.GestAssOfPsXContrSp.act.value!="null" && document.GestAssOfPsXContrSp.act.value=="VISUALIZZA")
  {
    document.GestAssOfPsXContrSp.act.value="";
    document.GestAssOfPsXContrSp.action='<%=request.getContextPath()%>/associazioni_of_ps/jsp/ListaAssOfPsSp.jsp';
    document.GestAssOfPsXContrSp.submit();  
  }//visualizza

  else if (document.GestAssOfPsXContrSp.act.value!="null" && document.GestAssOfPsXContrSp.act.value=="CANCELLA")
  {
//  window.alert('....cancella...');
    if (confirm("Si conferma la cancellazione dell'associazione?"))
    {
      document.GestAssOfPsXContrSp.act.value="cancella";
      document.GestAssOfPsXContrSp.action='<%=request.getContextPath()%>/servlet/GestAssOfPsXContrCntl';
      document.GestAssOfPsXContrSp.submit();  
    }//conferma
  }//cancella

  else if (document.GestAssOfPsXContrSp.act.value!="null" && document.GestAssOfPsXContrSp.act.value=="DISATTIVA")
  {
    if (document.GestAssOfPsXContrSp.dataFineOfPs.value=="null" || document.GestAssOfPsXContrSp.dataFineOfPs.value=="")
    {
      window.alert("data fine validit� obbligatoria");
    }
    else
    {
        var appo_dataFineOfPs = document.GestAssOfPsXContrSp.dataFineOfPs.value.substring(6,10)
                              + document.GestAssOfPsXContrSp.dataFineOfPs.value.substring(3,5)
                              + document.GestAssOfPsXContrSp.dataFineOfPs.value.substring(0,2);
        var appo_dataIniOfPs = document.GestAssOfPsXContrSp.dataIniOfPs.value.substring(6,10)
                             + document.GestAssOfPsXContrSp.dataIniOfPs.value.substring(3,5)
                             + document.GestAssOfPsXContrSp.dataIniOfPs.value.substring(0,2);
        var appo_data_oggi = document.GestAssOfPsXContrSp.data_oggi.value.substring(6,10)
                           + document.GestAssOfPsXContrSp.data_oggi.value.substring(3,5)
                           + document.GestAssOfPsXContrSp.data_oggi.value.substring(0,2);

        var  appo_dataFineStartOf="";
        if (dataFineStartOf!="")
        {
          appo_dataFineStartOf = dataFineStartOf.substring(6,10) + dataFineStartOf.substring(3,5) + dataFineStartOf.substring(0,2);
        }
                           
        var appo_dataFineStartOfPs="";
        if (dataFineStartOfPs!="")
        {
          appo_dataFineStartOfPs = dataFineStartOfPs.substring(6,10) + dataFineStartOfPs.substring(3,5) + dataFineStartOfPs.substring(0,2);
        }

        var appo_dataMin="";
        if (document.GestAssOfPsXContrSp.dataMin.value!="")
        {
          appo_dataMin = document.GestAssOfPsXContrSp.dataMin.value.substring(6,10)
                       + document.GestAssOfPsXContrSp.dataMin.value.substring(3,5)
                       + document.GestAssOfPsXContrSp.dataMin.value.substring(0,2);
        }


        if (!(appo_dataFineOfPs > appo_dataIniOfPs))
        {
           window.alert("La data fine validit� deve essere maggiore della data inizio");
        }
        else if (!(appo_dataFineOfPs >= appo_data_oggi))
        {
           window.alert("La data fine validit� deve essere maggiore o uguale alla data odierna");
        }
        else if((appo_dataFineStartOf!="") && (appo_dataFineOfPs > appo_dataFineStartOf))
        {
           window.alert("La data fine validit� deve essere minore o uguale della data fine validit� dell'oggetto di fatturazione");
        }
        //Se l'associazione � gi� stata disattivata si prosegue con i contolli        
        else if  (appo_dataFineStartOfPs!="")
             {
               //Se esiste pi� di un'associazione si prosegue con i controlli
               if (document.GestAssOfPsXContrSp.numIdentiche.value>1)
               {
                   //if((appo_dataFineStartOfPs!="") && (appo_dataMin!="") && (appo_dataFineOfPs >= appo_dataMin))
                   if((appo_dataMin!="") && (appo_dataFineOfPs >= appo_dataMin))
                   {
                        window.alert("La data fine validit� deve essere minore della minima data inizio validit�");
                   }
                   else
                   {
                        confermaDisatt();
                   }
               }
               else
                   {
                     confermaDisatt();
                   }

             }//else if
             else
             {
                confermaDisatt();
             }
    }//else
  }//else if   
}//function  



function cancelCalendarFine()
{
  document.GestAssOfPsXContrSp.dataFineOfPs.value="";
}



function showMessage (field)
{
	if (field=='seleziona1')
		self.status=msg1;
	else
    if (field=='seleziona2')
  		self.status=msg2;
}

</SCRIPT>

</HEAD>
<BODY onload="">

<%
String act="VISUALIZZA";
if (action.equalsIgnoreCase("DISATTIVA"))
  act="DISATTIVA";
if (action.equalsIgnoreCase("CANCELLA"))
  act="CANCELLA";
%>
<form name="GestAssOfPsXContrSp" id="GestAssOfPsXContrSp" method="get"  action='GestAssOfPsXContrSp.jsp'>
<input type="hidden" name="codPs"    id="codPs"  value=<%=codPs%>>
<input type="hidden" name="codCOf"   id="codCOf" value=<%=codCOf%>>
<input type="hidden" name="codOf"    id="codOf"  value=<%=codOf%>>
<input type="hidden" name="codFreq"   id="codFreq" value=<%=codFreq%>>
<input type="hidden" name="codModal"  id="codModal"  value=<%=codModal%>>
<!--input type="hidden" name="codeContr"  id="codeContr"  value=<%//=code_contr%>-->
<input type="hidden" name="cod_contratto"  id="cod_contratto"  value=<%=cod_contratto%>>

<input type="hidden" name="cod_tipo_contr"  id="cod_tipo_contr"  value=<%=cod_tipo_contr%>>
<input type="hidden" name="des_tipo_contr"  id="des_tipo_contr"  value=<%=des_tipo_contr%>>
<input type="hidden" name="flag"      id="flag"  value=S>
<input type="hidden" name="shift"     id="shift"  value=<%=shift%>>
<input type="hidden" name="act"       id="act"    value="<%=act%>">
<input type="hidden" name="dataIniOfPs"    id="dataIniOfPs"    value=<%=dataIniOfPs%>>
<input type="hidden" name="dataIniOf"  id="dataIniOf"  value=<%=dataIniOf%>>
<input type="hidden" name="data_oggi"  id="data_oggi"  value=<%=data_oggi%>>
 <input type="hidden" name="numIdentiche"  id="numIdentiche"  value="<%=numIdentiche%>"> 
 <input type="hidden" name="dataMin"  id="dataMin"  value=""> 

 <input type="hidden" name="disattivi"  id="disattivi"  value="<%=disattivi%>"> 
 

<input type="hidden" name="cod_cluster"  id="cod_cluster"  value="<%=cod_cluster%>">
<input type="hidden" name="tipo_cluster"  id="tipo_cluster"  value="<%=tipo_cluster%>">
<input type="hidden" name="tipo_funz"  id="tipo_funz"  value="<%=intFunzionalita%>">

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
						  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;<%=title%></td>
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
    <table align='center' width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
 <!--inizio FORM Oggetto di Fatturazione-->
     <tr>
			<td>
       <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">

     <!-- titolo-->
        <tr>
         <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
           <tr>
            <td width="91%" bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top">&nbsp;Prodotto/Servizio</td>
            <td width=" 9%" bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center"><img src="../../common/images/body/quad_blu.gif"></td>
           </tr>
          </table>
         </td>
        </tr>
  
      <!-- corpo -->
        <tr>
         <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">

           <tr> <!-- Tipo contratto -->
            <td width="25%" class="textB" align="right">&nbsp Tipo contratto:&nbsp;</td>
            <td width="55%" class="text" align="left">&nbsp;<%=des_tipo_contr%></td>
            <td width="20%">&nbsp;</td>
           </tr>


           <tr> <!-- Contratto -->
            <td width="25%" class="textB" align="right">&nbsp Contratto:&nbsp;</td>
            <td width="55%" class="text" align="left">&nbsp;<%=desContrattoCmb%></td>
            <td width="20%">&nbsp;</td>
           </tr>

 <% if ( "999".equals(intFunzionalita) || "998".equals(intFunzionalita) ) { 
                String descCluster ="";
               if ((clusterTipo_vect!=null)&&(clusterTipo_vect.size()!=0))
                  for(Enumeration e=clusterTipo_vect.elements();e.hasMoreElements();)
                    {
                       ClusterTipoContrElem elem=(ClusterTipoContrElem)e.nextElement();
                       if ( elem.getCodeClusterOf().equals(cod_cluster) && elem.getTipoClusterOf().equals(tipo_cluster)) {
                        descCluster = elem.getDescClusterOf();
                        break;
                       }
                    }
        %>
 
           <tr> <!-- Cluster -->
            <td width="25%" class="textB" align="right">&nbsp;Cluster:&nbsp;</td>
            <td width="55%" class="text" align="left">&nbsp;<%=descCluster%></td>
            <td width="20%">&nbsp;</td>
           </tr>
<% } %>

           <tr> <!-- Prodotto/Servizio -->
            <td width="25%" class="textB" align="right">&nbsp;Prodotto/Servizio:&nbsp;</td>
            <td width="55%" class="text" align="left">&nbsp;<%=descPs%></td>
            <td width="20%">&nbsp;</td>
           </tr>
          </table>
				 </td>
        </tr>
      <!-- corpo -->

       </table>
      </td>
     </tr>
<!-- fine FORM Prodotto/Servizio -->

    </table>
   </td>
  </tr>


  <tr>
   <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>




  <tr>
   <td>
       <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
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
     <!-- corpo -->
        <tr>
         <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">


           <tr> <!-- Classe -->
            <td width="25%" class="textB" align="right">&nbsp Classe:&nbsp;</td>
            <td width="55%" class="text" align="left">&nbsp;<%=descCOf%></td>
            <td width="20%">&nbsp;</td>
           </tr>


           <tr> <!-- Descrizione -->
            <td width="25%" class="textB" align="right">&nbsp Descrizione:&nbsp;</td>
            <td width="55%" class="text" align="left">&nbsp;<%=descOf%></td>
            <td width="20%">&nbsp;</td>
           </tr>


          </table>
				 </td>
        </tr>
     <!-- corpo -->

       </table>
   </td>
  </tr>






  <tr>
   <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>




  <tr>
   <td>
    <table align='center' width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
 <!--inizio FORM Modalita Applicazione-->
     <tr>
			<td>
       <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">

        <tr> <!-- titolo-->
         <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
           <tr>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Modalit� Applicazione</td>
            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
           </tr>
          </table>
         </td>
        </tr>

     <!-- corpo -->
        <tr>
         <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">

           <tr> <!-- Frequenza -->
            <td width="25%" class="textB" align="right">&nbsp Frequenza:&nbsp;</td>
            <td width="55%" class="text" align="left">&nbsp;<%=descFreq%></td>
            </td>
            <td width="20%">&nbsp;</td>
           </tr>

           <tr> <!-- Modalita appl.ne -->
            <td width="25%" class="textB" align="right">&nbsp Modalita appl.ne:&nbsp;</td>
<%
if (flag!= null && flag.equals("A"))
  {%>
            <td width="55%" class="text" align="left">&nbsp;Anticipato </td>
<%}
else if (flag!= null  && flag.equals("P"))
  {%>
            <td width="55%" class="text" align="left">&nbsp;Posticipato </td>
<%}
else //X oppure null
  {%>
            <td width="55%" class="text" align="left">&nbsp;</td>
<%}%>

            <td width="20%">&nbsp;</td>
           </tr>


           <tr><!-- Modalita appl.ne prorata -->
            <td width="25%" class="textB" align="right">&nbsp Modalita appl.ne prorata:&nbsp;</td>
            <td width="55%" class="text" align="left">&nbsp;<%=descModalAppl%></td>
           </td>
            <td width="20%">&nbsp;</td>
         	 </tr>

           <tr><!-- Shift canoni -->
            <td width="25%" class="textB" align="right">&nbsp Shift canoni:&nbsp;</td>
            <td width="55%" class="text" align="left">&nbsp;<%=shift%> </td>
            <td width="20%">&nbsp;</td>
           </tr>

          </table>
				 </td>
        </tr>
     <!-- corpo -->

       </table>
      </td>
     </tr>
  <!--fine FORM Modalita Applicazione-->
    </table>
   </td>
  </tr>



  <tr>
   <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>




  <tr>
   <td>
    <table align='center' width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
 <!--inizio FORM Validita-->
     <tr>
			<td>
       <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">

        <tr> <!-- titolo-->
         <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
           <tr>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Validit�</td>
            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
           </tr>
          </table>
         </td>
        </tr>

    <!-- corpo -->
        <tr>
         <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">

           <COL span="1" width="25%">
           <COL span="1" width="15%">
           <COL span="1" width="25%">
           <COL span="1" width="15%">
           <COL span="1" width="20%">

          	<tr>
             <td></td>
             <td></td>
             <td></td>
             <td></td>
             <td></td>
          	</tr>


           <tr> 
     <!-- LABEL Data inizio validita -->
            <td class="textB" align="right">&nbsp;Data inizio validit�:&nbsp;</td>
            <td class="text" align="left">&nbsp;<%=dataIniOfPs%> </td>
            </td>

     <!-- LABEL Data fine validita -->
            <td class="textB" align="right">&nbsp;Data fine validit�:&nbsp;</td>

<%if ((action!=null)&&(action.equalsIgnoreCase("disattiva")))
  {%>
            <td align="left">
              <input class="text" title="Data fine" type="hidden" size="10" maxlength="10" name="dataFineOf"  value="<%=dataFineOf%>">
              <input class="text" title="Data fine" type="text" size="10" maxlength="10" name="dataFineOfPs"  value="<%=dataFineOfPs%>">
              <Script language='javascript' >  Disable(document.GestAssOfPsXContrSp.dataFineOfPs) </Script>
            </td>
            <td align="left">
               <a href="javascript:showCalendar('GestAssOfPsXContrSp.dataFineOfPs', '<%=data_ini_mmdd%>');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true">
                <img name='calendar_fine'  src="../../common/images/body/calendario.gif" border="no"></a>
               <a href="javascript:cancelCalendarFine();" onMouseOver="javascript:showMessage('seleziona2'); return true;" onMouseOut="status='';return true">
                <img name='cancel_fine'   src="../../common/images/body/cancella.gif" border="0"></a>

            </td>
<%}
else
  {%>
            <td class="text" align="left">&nbsp;<%=dataFineOfPs%> </td>
            <td></td>
<%}%>
           </tr> 


          </table>
         </td>
        </tr>
    <!-- corpo -->
       </table>
      </td>
     </tr>
 <!--fine FORM Validita-->
    </table>
   </td>
  </tr>
  <tr>
   <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>

  <tr>
   <td>
<%
//            if ((action.equalsIgnoreCase("visualizza")) || (action.equalsIgnoreCase("cancella")))
           if (action.equalsIgnoreCase("cancella")) 
            {
%>
              <sec:ShowButtons VectorName="BOTTONI" />
<%
            }
            else if (action.equalsIgnoreCase("disattiva"))
            {
%>
              <sec:ShowButtons PageName="GESTASS_DIS" />    
<%
            }
%>
    </td>
  </tr>
</table> 
</form>
</BODY>
</HTML>
