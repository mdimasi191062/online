<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="vec_BOTTONI" />
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3007,"Associazione Of Ps per tipo contratto")%>
<%=StaticMessages.getMessage(3006,"ListaAssOfPsSp.jsp")%>
</logtag:logData>

<%
	response.addHeader("Pragma", "no-cache");
	response.addHeader("Cache-Control", "no-store");

//String cod_tipo_contr=request.getParameter("codiceTipoContratto");
String act = request.getParameter("act");
String codOf=request.getParameter("codOf");
String codPs=request.getParameter("codPs");
String codCOf=request.getParameter("codCOf");
String dataIni=request.getParameter("dataIni");
//lucaString dataIniOf=request.getParameter("dataIniOf");
//lucaString dataFineOf=request.getParameter("dataFineOf");
String dataIniOfPs=request.getParameter("dataIniOf");
String dataFineOfPs=request.getParameter("dataFineOf");

String codModal=request.getParameter("codModal");
String codFreq=request.getParameter("codFreq");
String flag=request.getParameter("flag");
String shift=request.getParameter("shift");
String controlloCanc=request.getParameter("controlloCanc");

// intFunzionalita
String intFunzionalita=request.getParameter("intFunzionalita");
String cod_cluster=request.getParameter("cod_cluster");
String tipo_cluster=request.getParameter("tipo_cluster");
String tipo_funz=request.getParameter("tipo_funz");  
if ( intFunzionalita == null ) { intFunzionalita = tipo_funz; }
Vector clusterTipo_vect=null;

//String appo_index="0";
//String appo_numrec="5";
//String appo_checkvalue="";
String descPs="";
String descOf="";

/*if ((act!=null)&&(act.equals("search"))) 
  {
  appo_index=request.getParameter("txtnumRec");
  appo_numrec=request.getParameter("numRec");
  appo_checkvalue=request.getParameter("disattivi");
  }
else  
  if (act!=null)
     { 
      appo_index=request.getParameter("appo_index");
      appo_numrec=request.getParameter("appo_numrec");
      appo_checkvalue=request.getParameter("appo_checkvalue");
     }*/
//     
/*String appo_codOf=codOf;
String appo_codPs=codPs;
String appo_codModal=codModal;
String appo_dataIni=dataIni;*/

String cod_tipo_contr=request.getParameter("codiceTipoContratto");
if (cod_tipo_contr==null) cod_tipo_contr=request.getParameter("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("codiceTipoContratto");

String des_tipo_contr=request.getParameter("hidDescTipoContratto");
if (des_tipo_contr==null) des_tipo_contr=request.getParameter("des_tipo_contr");
if (des_tipo_contr==null) des_tipo_contr=(String)session.getAttribute("des_tipo_contr");

// Lettura tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=1 Fare query (default)
// typeLoad=0 Variabile session
int typeLoad=0;
String strtypeLoad = request.getParameter("typeLoad");
if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }

// Vettore contenente risultati query
Collection assOfPs=new Vector();
%>
<EJB:useHome id="home" type="com.ejbBMP.AssOfPsBMPHome" location="AssOfPsBMP" />
<EJB:useHome id="homeClus" type="com.ejbBMP.AssOfPsBMPClusHome" location="AssOfPsBMPClus" />
<EJB:useHome id="homeClasseFatt" type="com.ejbSTL.ClasseFattSTLHome" location="ClasseFattSTL" />
<%

  if (typeLoad!=0)
   {
     assOfPs = (Collection) session.getAttribute("assOfPs");
//"Non fatta query"
   }
   else
   {
     if ((request.getParameter("disattivi")!=null)&& (request.getParameter("disattivi").equals("yes")))
     {
          if ("999".equals(intFunzionalita) || "998".equals(intFunzionalita)) {
            if ( cod_cluster != null ) {
                assOfPs = homeClus.findAll(cod_tipo_contr, cod_cluster, tipo_cluster, false);
            }
          } else {
            assOfPs = home.findAll(cod_tipo_contr, false);
          }
     }
     else
     {
        if ("999".equals(intFunzionalita) || "998".equals(intFunzionalita) ) {
          if ( cod_cluster != null ) {
            assOfPs = homeClus.findAll(cod_tipo_contr, cod_cluster, tipo_cluster, true);
          }
        } else {
          assOfPs = home.findAll(cod_tipo_contr, true);
          }
     }
     if (assOfPs!=null)
       session.setAttribute("assOfPs", assOfPs);
   }

  String checkedfiltra="";
  String checkvalue="";

  String disattivi=request.getParameter("disattivi");

  if ((disattivi!=null)&& (disattivi.equals("yes")))
       {
       checkedfiltra="checked";
       checkvalue="yes";
       } 
boolean showmessage=false;
if(act!=null)
{
      // Creazione oggetto
      /*GestAssOfPsBMPPK pk = new GestAssOfPsBMPPK();
      pk.setCodeOf(codOf);
      pk.setCodePs(codPs);
      pk.setCodeCOf(codCOf);
      pk.setDataIni(dataIni);
      pk.setDataIniOfPs(dataIniOfPs);
      pk.setDataFineOfPs(dataFineOfPs);
      pk.setCodModalAppl(codModal);
      pk.setCodFreq(codFreq);
      pk.setFlag(flag);
      pk.setShift(shift);*/

      if (act.equals("visualizza"))
      {
      
        if ( "999".equals(intFunzionalita) || "998".equals(intFunzionalita)) {
        
//      "************visua*********"
          request.getSession().setAttribute("cod_tipo_contr",cod_tipo_contr);
          request.getSession().setAttribute("des_tipo_contr",des_tipo_contr);
          response.sendRedirect("GestAssOfPsSp.jsp?act="+act
                  +"&disattivi="+disattivi
                  +"&codOf="+codOf+"&codCOf="+codCOf
                  +"&codPs="+codPs+"&codModal="+codModal
                  +"&codFreq="+codFreq+"&flag="+flag+"&shift="+shift
                  +"&dataIni="+dataIni+"&dataIniOf="+dataIniOfPs+"&dataFineOf="+dataFineOfPs
                  +"&cod_cluster="+cod_cluster
                  +"&tipo_cluster="+tipo_cluster
                  +"&tipo_funz="+tipo_funz);
         
        } else {
      
//      "************visua*********"
          request.getSession().setAttribute("cod_tipo_contr",cod_tipo_contr);
          request.getSession().setAttribute("des_tipo_contr",des_tipo_contr);
          response.sendRedirect("GestAssOfPsSp.jsp?act="+act
                  +"&disattivi="+disattivi
                  +"&codOf="+codOf+"&codCOf="+codCOf
                  +"&codPs="+codPs+"&codModal="+codModal
                  +"&codFreq="+codFreq+"&flag="+flag+"&shift="+shift
                  +"&dataIni="+dataIni+"&dataIniOf="+dataIniOfPs+"&dataFineOf="+dataFineOfPs);
        }
      }

      //if((act.equals("disattiva"))||(act.equals("cancella")))
      //{
//        "************canc*********"
          //showmessage=false;
          //if(remoteGestAss.getNumTariffe()>0)
          //{
            //showmessage = true;
            //messaggio 'sono presenti tariffe per la associazione selezionata'
          //}
          /*else
          {
            request.getSession().setAttribute("cod_tipo_contr",cod_tipo_contr);
            request.getSession().setAttribute("des_tipo_contr",des_tipo_contr);
            response.sendRedirect(request.getContextPath()+"/associazioni_of_ps/jsp/GestAssOfPsSp.jsp?act="+act
                  +"&disattivi="+disattivi
                  +"&codOf="+codOf+"&codCOf="+codCOf
                  +"&codPs="+codPs+"&codModal="+codModal
                  +"&codFreq="+codFreq+"&flag="+flag+"&shift="+shift
                  +"&dataIni="+dataIni+"&dataIniOfPs="+dataIniOf+"&dataFineOfPs="+dataFineOf);
          }
      }//disattiva o cancella*/
} //if(act!=null)


// Lettura dell'indice Combo Numero Record
int index=0;
String strIndex=null;
//if (showmessage)
  //strIndex=appo_index;
//else
  strIndex = request.getParameter("txtnumRec");

if (strIndex!=null)
  {
   Integer tmpindext=new Integer(strIndex);
   index=tmpindext.intValue();
  }

// Lettura del Numero di record per pagina (default 5)
int records_per_page=5;

String strNumRec=null;
//if (showmessage)
  //strNumRec=appo_numrec;
//else
  strNumRec = request.getParameter("numRec");

if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }

%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Lista Associazioni Oggetti di Fatturazione - Prodotti e Servizi
</TITLE>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>
var codOf="";
var descOf="";
var descCOf="";
//var dataFineOf="";

var codPs="";
var codCOf="";
var dataIni="";
var dataIniOf="";
var dataFineOf="";
var codModal="";
var codFreq="";
var tipoFlag="";
var shift="";
var numTariffe=0;
var act="";


function change_cluster() {

<%   if ( "999".equals(intFunzionalita) || "998".equals(intFunzionalita) ) { %>
    if ( frmSearch.oggCluster.selectedIndex >= 1 ) {
        var str = frmSearch.oggCluster.options[frmSearch.oggCluster.selectedIndex].value;
        var res = str.split("||");
        document.frmSearch.cod_cluster.value=res[0];
        document.frmSearch.tipo_cluster.value=res[1];
        Enable(document.frmSearch.esegui);
    } else {
        document.frmSearch.cod_cluster.value=null;
        document.frmSearch.tipo_cluster.value=null;
        Disable(document.frmSearch.esegui);
    }
    document.frmSearch.tipo_funz.value="<%=intFunzionalita%>";
<% } %>
}

function ChangeSel(codiceOf,codicePs,codiceClasseOf,dataInizio,dataInizioOf,dataFineOf,
                   codiceModal,codiceFreq,tipoFlag,shift,intFunzionalita,cod_cluster,tipo_cluster,tipo_funz)
{

document.ListaAssOfPsSp.codOf.value=codiceOf;
document.ListaAssOfPsSp.codPs.value=codicePs;
document.ListaAssOfPsSp.codCOf.value=codiceClasseOf;
if(dataInizio==null)
  document.ListaAssOfPsSp.dataIni.value="";
else
  document.ListaAssOfPsSp.dataIni.value=dataInizio;

document.ListaAssOfPsSp.dataIniOf.value=dataInizioOf;

if(dataFineOf==null)
  document.ListaAssOfPsSp.dataFineOf.value="";
else
  document.ListaAssOfPsSp.dataFineOf.value=dataFineOf;

document.ListaAssOfPsSp.codModal.value=codiceModal;
document.ListaAssOfPsSp.codFreq.value=codiceFreq;
document.ListaAssOfPsSp.flag.value=tipoFlag;
document.ListaAssOfPsSp.shift.value=shift;

document.ListaAssOfPsSp.cod_cluster.value=cod_cluster;
document.ListaAssOfPsSp.tipo_cluster.value=tipo_cluster;
document.ListaAssOfPsSp.tipo_funz.value=intFunzionalita;  

/*
window.alert('codOf='+document.ListaAssOfPsSp.codOf.value
      +'\rcodPs='+document.ListaAssOfPsSp.codPs.value
      +'\rcodCOf='+document.ListaAssOfPsSp.codCOf.value
      +'\rdataIni='+document.ListaAssOfPsSp.dataIni.value
      +'\rdataIniOf='+document.ListaAssOfPsSp.dataIniOf.value
      +'\rdataFineOf='+document.ListaAssOfPsSp.dataFineOf.value
      +'\rcodModal='+document.ListaAssOfPsSp.codModal.value
      +'\rcodFreq='+document.ListaAssOfPsSp.codFreq.value
      +'\rtipoFlag='+document.ListaAssOfPsSp.flag.value
      +'\rshift='+document.ListaAssOfPsSp.shift.value);
*/
}


function submitFrmSearch(typeLoad)
  {
    change_cluster();
    
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.typeLoad.value=typeLoad;
  document.frmSearch.submit();
}


function setInitialValue()
{
     <% if ( "999".equals(intFunzionalita) || "998".equals(intFunzionalita) ) { %>
        Disable(document.frmSearch.esegui);
    <% } %>

//messaggi();

<% //if (showmessage)
   //{
%>
     //eval('document.frmSearch.numRec.options[<%//=appo_index%>].selected=true');
<% //}
  //else
    //{
%>   
  //Setta il numero di record  
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
<% //} %>
}

/*function messaggi()
{
//window.alert('sono in function messaggi');
<%
    //if (showmessage)
    //{%>
     //window.alert("Operazione non consentita: \rsono presenti tariffe per l'associazione selezionata");
  <%//}
%>
}*/


/*function SubmitMe(selection)
{
  if (selection.value=="Nuovo")
    document.ListaAssOfPsSp.act.value="nuovo";
  if (selection.value=="Cancella")
    document.ListaAssOfPsSp.act.value="cancella";
  if (selection.value=="Visualizza")
    document.ListaAssOfPsSp.act.value="visualizza";
  if (selection.value=="Disattiva")
    document.ListaAssOfPsSp.act.value="disattiva";    
  document.ListaAssOfPsSp.action="AssOggettoFattPs.jsp";
  document.ListaAssOfPsSp.submit();  
  return false; 
}*/

/*function CancelMe()
{
  self.close();
	return false;
}*/


function handleReturnedInsAss()
{
}



var NumTariffeTrovate=0;
function contaTariffe()
{
/*
----3-----
*/
}


/*function ONCANCELLA()
{
    document.ListaAssOfPsSp.act.value="cancella";
    document.ListaAssOfPsSp.submit();  
}*/


function ONVISUALIZZA()
{
    document.ListaAssOfPsSp.act.value="visualizza";
    document.ListaAssOfPsSp.submit();  
    return false; 
}


//function ONDISATTIVA()
//{
    //document.ListaAssOfPsSp.act.value="disattiva";
    //document.ListaAssOfPsSp.submit();  
//}

function ONCANCELLA()
{
  act="cancella";
  DisattCanc();
}

function ONDISATTIVA()
{
  act="disattiva";
  DisattCanc();
}


function DisattCanc()
{
           var strURL="ListaAssOfPsWfSp.jsp";
                strURL+="?act="+act;
                strURL+="&codOf="+document.ListaAssOfPsSp.codOf.value;
                strURL+="&codPs="+document.ListaAssOfPsSp.codPs.value;
                strURL+="&codCOf="+document.ListaAssOfPsSp.codCOf.value;
                strURL+="&dataIniOf="+document.ListaAssOfPsSp.dataIni.value;
                strURL+="&dataIniOfPs="+document.ListaAssOfPsSp.dataIniOf.value;
                strURL+="&dataFineOfPs="+document.ListaAssOfPsSp.dataFineOf.value;
                strURL+="&codModal="+document.ListaAssOfPsSp.codModal.value;
                strURL+="&codFreq="+document.ListaAssOfPsSp.codFreq.value;
                strURL+="&flag="+document.ListaAssOfPsSp.flag.value;
                strURL+="&shift="+document.ListaAssOfPsSp.shift.value;
                //alert(strURL);
            openDialog(strURL, 400, 5,handle_DisattCanc);
}

function handle_DisattCanc()
{
          if(numTariffe>0)
          {
            alert("sono presenti tariffe per l'associazione selezionata");
          }
          else
          {
           //if (document.ListaAssOfPsSp.dataFineOf.value=="null")
               //document.ListaAssOfPsSp.dataFineOf.value="";
           document.ListaAssOfPsSp.act.value=act;
           document.ListaAssOfPsSp.action="GestAssOfPsSp.jsp";
           document.ListaAssOfPsSp.submit();  
          }

}

</SCRIPT>


</HEAD>
<BODY onload="setInitialValue();" >






<!--    Costruisco il form contenente i criteri di ricerca e la gestione della paginazione  -->
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="get" action="ListaAssOfPsSp.jsp">
<input type="hidden" name="act" value="search">
<input type="hidden" name="cod_cluster" id="cod_cluster" value= <%=cod_cluster%>>
<input type="hidden" name="tipo_cluster" id="tipo_cluster" value= <%=tipo_cluster%>>
<input type="hidden" name="tipo_funz" id="tipo_funz" value= <%=tipo_funz%>>   

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista Associazioni Oggetti di Fatturazione - Prodotti e Servizi</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="Images/pixel.gif" width="1" height='3'></td>
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
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Filtro di Ricerca</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>">
                    <tr>
                      <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="Images/pixel.gif" width="1" height='2'></td>
                    </tr>

                      <td width="25%" class="textB" align="right">Tipo Contratto:&nbsp;</td>
                      <td width="25%" class="text"><%=des_tipo_contr%></td>
                   <% if ( "999".equals(intFunzionalita) || "998".equals(intFunzionalita) ) { %>
                      
                        <td width="25%" class="textB" align="right">
                        <span class="textB">Cluster:&nbsp;
                        <select class="text" name="oggCluster" onchange='change_cluster();'>
                          <option value="-1">[Seleziona Opzione]<%=com.utl.Utility.getSpazi(30)%></option>
                          <%
                            ClasseFattSTL remoteClasseFatt= homeClasseFatt.create();
                           clusterTipo_vect= remoteClasseFatt.getClusterTipoContr(cod_tipo_contr);
                           if ((clusterTipo_vect!=null)&&(clusterTipo_vect.size()!=0))
                              for(Enumeration e=clusterTipo_vect.elements();e.hasMoreElements();)
                                {
                                   ClusterTipoContrElem elem=(ClusterTipoContrElem)e.nextElement();
                                   
                                   String selClus = "";
                                   if ( elem.getCodeClusterOf().equals(cod_cluster) &&  elem.getTipoClusterOf().equals(tipo_cluster) ) {
                                    selClus = "selected";
                                   }
                                   
                                 %>
                                  <option value="<%=elem.getCodeClusterOf()%>||<%=elem.getTipoClusterOf()%>" <%=selClus%> ><%=elem.getDescClusterOf()%></option>
                                 <%
                                }
                          %>
                          </select>
                          </span>
                        </td>                      
                    <% } else { %>
                        <td width="50%" class="textB" align="right">&nbsp;</td>
                    <% } %>

                     
                    <tr>
                      <td width="50%" class="textB" align="right">Mostra associazioni disattive:&nbsp;</td>
                      <td  width="20%" class="text">
                         <input type=checkbox name=disattivi value="yes" <%=checkedfiltra%>
                         <% //if (showmessage) if (appo_checkvalue.equals("yes")) out.print("checked");%>>
                      </td>
                      <!--td><input type=checkbox name=disattivi value="yes" <%=checkedfiltra%>><font class="normal">Mostra gli oggetti di fatturazione disattivi</font></td>
                      <td><input class="textB" type="button" name="filtra" value="Filtra" onclick="return filtra_submit();" ></td-->

                      <td width="30%" rowspan='2' class="textB" valign="center" align="center">
                        <input class="textB" type="button" name="esegui" value="Popola lista" onclick="submitFrmSearch('0');">
                        <input class="textB" type="hidden" name="cod_tipo_contr" value="<%=cod_tipo_contr%>">
                        <input class="textB" type="hidden" name="des_tipo_contr" value="<%=des_tipo_contr%>">
                        <input class="textB" type="hidden" name="typeLoad" value="">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                      </td>
                    </tr>
                    <tr>
                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <select class="text" name="numRec" onchange="submitFrmSearch('1');">
                          <option class="text" value=5>5</option>
                          <option class="text" value=10>10</option>
                          <option class="text" value=20>20</option>
                          <option class="text" value=50>50</option>
                        </select>
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
      </table>
    </td>
  </tr>

</table>
   
</form>
<form  name="ListaAssOfPsSp" id="ListaAssOfPsSp" method="get" action='ListaAssOfPsSp.jsp'>
<input type="hidden" name=cod_tipo_contr id=cod_tipo_contr value="<%=cod_tipo_contr%>">
<input type="hidden" name=des_tipo_contr id=des_tipo_contr value="<%=des_tipo_contr%>">
<input type="hidden" name=controlloCanc id=controlloCanc value="<%=controlloCanc%>">
<input type="hidden" name="disattivi"  id="disattivi"  value="<%=disattivi%>"> 

<input type="hidden" name=act id=act value="">
  <table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="90%" align="center" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Risultato di ricerca</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
              </tr>
<%
    if ((assOfPs==null)||(assOfPs.size()==0))
    {
%>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="5" class="textB" align="center">No Record Found</td>
              </tr>
<%
    }
    else
    {
     %>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white">&nbsp;</td>
                <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>P/S</td>
                <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Oggetto di Fatturazione</td>
                <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Data Inizio</td>
                <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>&nbsp;&nbsp;Data Fine</td>
              </tr>
<%
     }
%>
                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=assOfPs==null?0:assOfPs.size()%>">
                <pg:param name="typeLoad" value="1"></pg:param>
                <pg:param name="cod_tipo_contr" value="<%=cod_tipo_contr%>"></pg:param>
                <pg:param name="des_tipo_contr" value="<%=des_tipo_contr%>"></pg:param>
                <pg:param name="disattivi" value="<%=checkvalue%>"></pg:param>
                <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
                <pg:param name="intFunzionalita" value="<%=intFunzionalita%>"></pg:param>
                <pg:param name="cod_cluster" value="<%=cod_cluster%>"></pg:param>
                <pg:param name="tipo_cluster" value="<%=tipo_cluster%>"></pg:param>
                <pg:param name="tipo_funz" value="<%=tipo_funz%>"></pg:param>


                <%
                String bgcolor="";
                String checked;  
                Object[] objs=assOfPs.toArray();
                boolean  caricaDesc=true;
%>
                <input type="hidden" name=Nrec id=Nrec value="<%=assOfPs.size()%>">
<%
                boolean flg_first=true;
                for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<assOfPs.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                   {
                    //AssOfPsBMP obj=(AssOfPsBMP)objs[i];
                    AssOfPsBMP obj;
                    AssOfPsBMPClus obj1;
                    if ( "999".equals(intFunzionalita) || "998".equals(intFunzionalita) ) {
                       obj1 = (AssOfPsBMPClus)objs[i];
                       
                          codOf=obj1.getCodeOf();
                          codPs=obj1.getCodePs();
                          codCOf=obj1.getCodeCOf();
                          dataIni=obj1.getDataIniOf();
                          dataIniOfPs=obj1.getDataIniAssOf();
                          dataFineOfPs=obj1.getDataFineAssOf();
                          codModal=obj1.getCodeModal();
                          codFreq=obj1.getCodeFreq();
                          flag=obj1.getTipoFlgAssocB();
                          shift=String.valueOf(obj1.getQntaShiftCanoni());
                          descPs=obj1.getDescPs();
                          descOf=obj1.getDescOf();
                          cod_cluster=obj1.getCodeCluster();
                          tipo_cluster=obj1.getTipoCluster();
                          tipo_funz=intFunzionalita;
                          
                    } else {
                       obj=(AssOfPsBMP)objs[i];
                       
                          codOf=obj.getCodeOf();
                          codPs=obj.getCodePs();
                          codCOf=obj.getCodeCOf();
                          dataIni=obj.getDataIniOf();
                          dataIniOfPs=obj.getDataIniAssOf();
                          dataFineOfPs=obj.getDataFineAssOf();
                          codModal=obj.getCodeModal();
                          codFreq=obj.getCodeFreq();
                          flag=obj.getTipoFlgAssocB();
                          shift=String.valueOf(obj.getQntaShiftCanoni());
                          descPs=obj.getDescPs();
                          descOf=obj.getDescOf();
                          cod_cluster="";
                          tipo_cluster="";
                          tipo_funz="";                          
                    }
                    
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;


                        
                    if(flg_first)
                    {%>
                      <input type="hidden" name=codOf           id=codOf           value="<%=codOf%>">
                      <input type="hidden" name=codPs           id=codPs           value="<%=codPs%>">
                      <input type="hidden" name=codCOf          id=codCOf          value="<%=codCOf%>">
                      <input type="hidden" name=dataIni         id=dataIni         value="<%=dataIni%>">
                      <input type="hidden" name=dataIniOf       id=dataIniOf       value="<%=dataIniOfPs%>">
                      <input type="hidden" name=dataFineOf      id=dataFineOf      value="<%=dataFineOfPs%>">
                      <input type="hidden" name=codModal        id=codModal        value="<%=codModal%>">
                      <input type="hidden" name=codFreq         id=codFreq         value="<%=codFreq%>">
                      <input type="hidden" name=flag            id=flag            value="<%=flag%>">
                      <input type="hidden" name=shift           id=shift           value="<%=shift%>">
                                              
                        <input type="hidden" name="cod_cluster" id="cod_cluster" value= <%=cod_cluster%>>
                        <input type="hidden" name="tipo_cluster" id="tipo_cluster" value= <%=tipo_cluster%>>
                        <input type="hidden" name="tipo_funz" id="tipo_funz" value= <%=tipo_funz%>>      
                        
                      <!--input type="hidden" name=appo_index      id=appo_index      value="<%//=appo_index%>"-->
                      <!--input type="hidden" name=appo_numrec     id=appo_numrec     value="<%//=appo_numrec%>"-->
                      <!--input type="hidden" name=appo_checkvalue id=appo_checkvalue value="<%//=appo_checkvalue%>"-->
                  <%}%>
                       <tr>
                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>
                        <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name='SelOf' value='<%=codOf%>' <% if (flg_first) {out.print("checked");flg_first=false;}%>
                           
                              onclick="ChangeSel('<%=codOf%>',
                                                 '<%=codPs%>',
                                                 '<%=codCOf%>',
                                                 '<%=dataIni%>',
                                                 '<%=dataIniOfPs%>',
                                                 '<%=dataFineOfPs%>',
                                                 '<%=codModal%>',
                                                 '<%=codFreq%>',
                                                 '<%=flag%>',
                                                 '<%=shift%>',
                                                 '<%=intFunzionalita%>',
                                                 '<%=cod_cluster%>',
                                                 '<%=tipo_cluster%>',
                                                 '<%=tipo_funz%>')">
                       </td>
                        <td bgcolor='<%=bgcolor%>' class='text'><%=descPs%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=descOf%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=dataIniOfPs%></td>

                       <%
                         //per il primo check automatico nella inizializzazione della lista

                    if (dataFineOfPs.equals("null") || dataFineOfPs.equals(""))
                    {
%>
                        <td bgcolor="<%=bgcolor%>" class="text">&nbsp;</td>
<%                  }else
                    {
%>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=dataFineOfPs%></td>
                  <%}%>
            
                      </tr>
                <%    
                    }
                %>
                    <tr>
                      <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="3" height='2'></td>
                    </tr>

                <pg:index>
                          <tr>
                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="5" class="text" align="center">
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

                <tr>
                  <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="Images/pixel.gif" width="1" height='2'></td>
                </tr>
        
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

        <tr>
          <td colspan=5 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="1" height='3'></td>
        </tr>

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td colspan=5>
            <sec:ShowButtons VectorName="vec_BOTTONI" />
            <%
             if ((assOfPs==null)||(assOfPs.size()==0))
              {%>
              <Script language='javascript'> 
                    Disable(document.ListaAssOfPsSp.DISATTIVA);
                    Disable(document.ListaAssOfPsSp.VISUALIZZA);
                    Disable(document.ListaAssOfPsSp.CANCELLA);
              </Script>
             <%}%>  
          </td>
        </tr>
</table>

</form>

</BODY>
</HTML>
