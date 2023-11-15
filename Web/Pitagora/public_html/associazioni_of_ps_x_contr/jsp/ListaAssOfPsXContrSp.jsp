<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="vec_BOTTONI" />
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
  <%=StaticMessages.getMessage(3007,"Associazione Of Ps per cliente contratto")%>
  <%=StaticMessages.getMessage(3006,"ListaAssOfPsXContrSp.jsp")%>
</logtag:logData>

<%
	response.addHeader("Pragma", "no-cache");
	response.addHeader("Cache-Control", "no-store");

String flag_sys=request.getParameter("hidFlagSys");
if (flag_sys==null) flag_sys=request.getParameter("flag_sys");
if (flag_sys==null) flag_sys=(String)session.getAttribute("flag_sys");
if (flag_sys==null) flag_sys="S";

String cod_tipo_contr=request.getParameter("codiceTipoContratto");
if (cod_tipo_contr==null) cod_tipo_contr    = request.getParameter("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("cod_tipo_contr");

String des_tipo_contr=request.getParameter("hidDescTipoContratto");
if (des_tipo_contr==null) des_tipo_contr=request.getParameter("des_tipo_contr");
if (des_tipo_contr==null) des_tipo_contr=(String)session.getAttribute("des_tipo_contr");

String listaPopola=request.getParameter("listaPopola");

String act = request.getParameter("act");
String codOf=request.getParameter("codOf");
String codPs=request.getParameter("codPs");
String codCOf=request.getParameter("codCOf");
String dataIni=request.getParameter("dataIni");
String dataIniOf=request.getParameter("dataIniOf");
String dataIniOfPs=request.getParameter("dataIniOfPs");
String dataFineOf=request.getParameter("dataFineOf");
String dataFineOfPs=request.getParameter("dataFineOfPs");
String codModal=request.getParameter("codModal");
String codFreq=request.getParameter("codFreq");
String flag=request.getParameter("flag");
String shift=request.getParameter("shift");
String caricaLista = request.getParameter("caricaLista");
String cod_contratto=request.getParameter("cod_contratto");
String contrSelez=request.getParameter("cod_contratto");
String des_contratto=request.getParameter("des_contratto");

// Lettura dell'indice Combo Numero Record
int index=0;
String strIndex=null;

strIndex = request.getParameter("txtnumRec");
// intFunzionalita
String intFunzionalita=request.getParameter("intFunzionalita");
String cod_cluster=request.getParameter("cod_cluster");
String tipo_cluster=request.getParameter("tipo_cluster");
String tipo_funz=request.getParameter("tipo_funz");  
if ( intFunzionalita == null ) { intFunzionalita = tipo_funz; }
Vector clusterTipo_vect=null;

if ((strIndex!=null)&&(!(strIndex.equals(""))))
  {
   Integer tmpindext=new Integer(strIndex);
   index=tmpindext.intValue();
  }


// Lettura del Numero di record per pagina (default 5)
int records_per_page=5;

String strNumRec=null;

strNumRec = request.getParameter("numRec");


if ((strNumRec!=null)&&(!(strNumRec.equals(""))))
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }





// Lettura tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=1 Fare query (default)
// typeLoad=0 Variabile session
int typeLoad=0;
String strtypeLoad = request.getParameter("typeLoad");
if ((strtypeLoad!=null)&&(!(strIndex.equals(""))))
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }

// Vettore contenente risultati query
Collection assOfPs  =null;

  %>
  <EJB:useHome id="homeAssOfPsXContr" type="com.ejbBMP.AssOfPsXContrBMPHome" location="AssOfPsXContrBMP" />
  <EJB:useHome id="homeContratto" type="com.ejbSTL.ContrattoSTLHome" location="ContrattoSTL" />
  <EJB:useBean id="remoteContratto" type="com.ejbSTL.ContrattoSTL" value="<%=homeContratto.create()%>" scope="page"></EJB:useBean>
  <EJB:useHome id="homeClus" type="com.ejbBMP.AssOfPsXContrBMPClusHome" location="AssOfPsXContrBMPClus" />
  <EJB:useHome id="homeClasseFatt" type="com.ejbSTL.ClasseFattSTLHome" location="ClasseFattSTL" />
  <%

  if (typeLoad!=0)
   {
     assOfPs = (Collection) session.getAttribute("assOfPs");
     
//     "Non fatta query"
   }
   else
   {
      if ((caricaLista!=null)&& (caricaLista.equals("true")))
      {
         if ((request.getParameter("disattivi")!=null)&& (request.getParameter("disattivi").equals("yes")))
         {
          if ("999".equals(intFunzionalita) || "998".equals(intFunzionalita)) {
              assOfPs = homeClus.findAll(cod_tipo_contr,cod_contratto,cod_cluster,tipo_cluster,false);
          } else {
              assOfPs = homeAssOfPsXContr.findAll(cod_tipo_contr,cod_contratto,false);
          }    
         }
         else
         {
          if ("999".equals(intFunzionalita) || "998".equals(intFunzionalita) ) {
              assOfPs = homeClus.findAll(cod_tipo_contr,cod_contratto,cod_cluster,tipo_cluster,true);
          } else {
              assOfPs = homeAssOfPsXContr.findAll(cod_tipo_contr,cod_contratto,true);
          }    
         }
         if (assOfPs!=null)
           session.setAttribute("assOfPs", assOfPs);
      }
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
      AssOfPsXContrBMPPK pk = new AssOfPsXContrBMPPK();
      pk.setCodeTipoContr(cod_contratto);
      pk.setCodeOf(codOf);
      pk.setCodePs(codPs);
      pk.setCodeCOf(codCOf);
      pk.setDataIniOf(dataIniOf);
      pk.setDataIniOfPs(dataIniOfPs);
      pk.setDataFineOf(dataFineOf);
      pk.setDataFineOfPs(dataFineOfPs);
      pk.setCodeModal(codModal);
      pk.setDescFreq(codFreq);
      pk.setFlagSys(flag);
      

      if (act.equals("visualizza"))
      {
          if ("999".equals(intFunzionalita) || "998".equals(intFunzionalita)) {
	          request.getSession().setAttribute("cod_tipo_contr",cod_tipo_contr);
	          request.getSession().setAttribute("des_tipo_contr",des_tipo_contr);
	          if (dataFineOf.equals("null"))
	            dataFineOf="";
	          response.sendRedirect(request.getContextPath()+"/associazioni_of_ps_x_contr/jsp/GestAssOfPsXContrSp.jsp?act="+act
	                  +"&disattivi="+disattivi
	                  +"&flag_sys="+flag_sys
	                  +"&des_tipo_contr="+des_tipo_contr
	                  +"&cod_contratto="+cod_contratto
	                  +"&cod_tipo_contr="+cod_tipo_contr
	                  +"&codOf="+codOf+"&codCOf="+codCOf
	                  +"&codPs="+codPs+"&codModal="+codModal
	                  +"&codFreq="+codFreq+"&flag="+flag+"&shift="+shift
	                  +"&dataIniOfPs="+dataIniOfPs+"&dataIniOf="+dataIniOf+"&dataFineOf="+dataFineOf+"&dataFineOfPs="+dataFineOfPs
	                  +"&cod_cluster="+cod_cluster
	                  +"&tipo_cluster="+tipo_cluster
	                  +"&tipo_funz="+tipo_funz);

		  } else {      	
//          "************visua*********"

	
	
	          request.getSession().setAttribute("cod_tipo_contr",cod_tipo_contr);
	          request.getSession().setAttribute("des_tipo_contr",des_tipo_contr);
	          if (dataFineOf.equals("null"))
	            dataFineOf="";
	          response.sendRedirect(request.getContextPath()+"/associazioni_of_ps_x_contr/jsp/GestAssOfPsXContrSp.jsp?act="+act
	                  +"&disattivi="+disattivi
	                  +"&flag_sys="+flag_sys
	                  +"&des_tipo_contr="+des_tipo_contr
	                  +"&cod_contratto="+cod_contratto
	                  +"&cod_tipo_contr="+cod_tipo_contr
	                  +"&codOf="+codOf+"&codCOf="+codCOf
	                  +"&codPs="+codPs+"&codModal="+codModal
	                  +"&codFreq="+codFreq+"&flag="+flag+"&shift="+shift
	                  +"&dataIniOfPs="+dataIniOfPs+"&dataIniOf="+dataIniOf+"&dataFineOf="+dataFineOf+"&dataFineOfPs="+dataFineOfPs);
         }
      }

} //if(act!=null)
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
var codPs="";
var codCOf="";
var dataIniOfPs="";
var dataIniOf="";
var dataFineOf="";
var dataFineOfPs="";
var codModal="";
var codFreq="";
var tipoFlag="";
var shift="";
var act="";

function change_cluster() {
<%
  if ("999".equals(intFunzionalita) || "998".equals(intFunzionalita)) {
%>
    if (document.frmSearch.contrattoCombo.selectedIndex >=1 && document.frmSearch.oggCluster.selectedIndex >=1){

    //if ( frmSearch.oggCluster.selectedIndex >= 1 ) {
        var str = frmSearch.oggCluster.options[frmSearch.oggCluster.selectedIndex].value;
        var res = str.split("||");
        document.frmSearch.cod_cluster.value=res[0];
        document.frmSearch.tipo_cluster.value=res[1];
        Enable(document.frmSearch.Esegui);
        
    } else {
        document.frmSearch.cod_cluster.value=null;
        document.frmSearch.tipo_cluster.value=null;
        document.frmSearch.listaPopola.value='false';
        Disable(document.frmSearch.Esegui);
    }
    document.frmSearch.tipo_funz.value="<%=intFunzionalita%>";

<% } %>
}

function caricatoContratto()
 { 

     Enable(document.frmSearch.Esegui);
     document.frmSearch.cod_contratto.value=document.frmSearch.contrattoCombo[document.frmSearch.contrattoCombo.selectedIndex].value;
     document.frmSearch.des_contratto.value=document.frmSearch.contrattoCombo[document.frmSearch.contrattoCombo.selectedIndex].text;
  
<% 
  if ("999".equals(intFunzionalita) || "998".equals(intFunzionalita) ) {
%>
     if (document.frmSearch.contrattoCombo.selectedIndex==0 || document.frmSearch.oggCluster.selectedIndex==0)
<% } else { %>
     if (document.frmSearch.contrattoCombo.selectedIndex==0)
<% } %>
     {
       selezione=-1;
       document.frmSearch.listaPopola.value='false';
     }
     else
     {
         selezione=document.frmSearch.contrattoCombo[document.frmSearch.contrattoCombo.selectedIndex].value;
     }

     if (selezione!=-1)
     { 
       Enable(document.frmSearch.Esegui);
     }
     else
     {  
       Disable(document.frmSearch.Esegui);
       //document.frmSearch.contrSelez.value=selezione; 
       //document.frmSearch.submit();
      }
     document.frmSearch.contrSelez.value=selezione; 

<% 
  if (! "999".equals(intFunzionalita) && ! "998".equals(intFunzionalita)) {
%> 
     if (document.frmSearch.caricaLista.value=="true")
     {
         document.frmSearch.caricaLista.value="false";
         document.frmSearch.submit();
     } 
<% } %>
 }



function ChangeSel(codiceOf,codicePs,codiceClasseOf,dataInizioOf,dataInizioOfPs,dataFineOf,dataFineOfPs,
                   codiceModal,codiceFreq,tipoFlag,shift,cod_cluster,tipo_cluster,tipo_funz)
{
document.ListaAssOfPsXContrSp.codOf.value=codiceOf;
document.ListaAssOfPsXContrSp.codPs.value=codicePs;
document.ListaAssOfPsXContrSp.codCOf.value=codiceClasseOf;
if(dataInizioOf==null)
  document.ListaAssOfPsXContrSp.dataIniOf.value="";
else
  document.ListaAssOfPsXContrSp.dataIniOf.value=dataInizioOf;

document.ListaAssOfPsXContrSp.dataIniOfPs.value=dataInizioOfPs;

if(dataFineOf==null)
  document.ListaAssOfPsXContrSp.dataFineOf.value="";
else
  document.ListaAssOfPsXContrSp.dataFineOf.value=dataFineOf;

if(dataFineOfPs==null)
  document.ListaAssOfPsXContrSp.dataFineOfPs.value="";
else
  document.ListaAssOfPsXContrSp.dataFineOfPs.value=dataFineOfPs;

document.ListaAssOfPsXContrSp.codModal.value=codiceModal;
document.ListaAssOfPsXContrSp.codFreq.value=codiceFreq;
document.ListaAssOfPsXContrSp.flag.value=tipoFlag;
document.ListaAssOfPsXContrSp.shift.value=shift;
document.ListaAssOfPsXContrSp.cod_contratto.value=document.frmSearch.contrSelez.value;
document.ListaAssOfPsXContrSp.cod_cluster.value=cod_cluster;
document.ListaAssOfPsXContrSp.tipo_cluster.value=tipo_cluster;
document.ListaAssOfPsXContrSp.tipo_funz.value="<%=intFunzionalita%>";  
}


function submitFrmSearch(typeLoad)
{
    change_cluster();

    //if ((document.frmSearch.contrSelez.value!=-1) && (document.frmSearch.contrSelez.value!="null") && (document.frmSearch.listaPopola.value=="true") )
   if(document.frmSearch.caricaLista.value!="null" && document.frmSearch.caricaLista.value=="true")
    {
      document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
      document.frmSearch.typeLoad.value=typeLoad;
      document.frmSearch.submit();
    }  
    else
    {
      alert("Pololare la lista dopo aver selezionato un contratto");
      document.frmSearch.numRec.selectedIndex=0;
    }  
}

function setInitialValue()
{
if (document.frmSearch.contrattoCombo.selectedIndex==0)
   Disable(document.frmSearch.Esegui);
else
    Enable(document.frmSearch.Esegui);

//if((document.frmSearch.contrSelez.value!='-1') && (document.frmSearch.contrSelez.value!='null'))
//   Enable(document.frmSearch.Esegui);
eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
}

function SubmitMe(selection)
{
  if (selection.value=="Nuovo")
    document.frmSearch.act.value="nuovo";
  if (selection.value=="Cancella")
    document.frmSearch.act.value="cancella";
  if (selection.value=="Visualizza")
    document.frmSearch.act.value="visualizza";
  if (selection.value=="Disattiva")
    document.frmSearch.act.value="disattiva";    
  document.ListaAssOfPsXContrSp.action="AssOggettoFattPs.jsp";
  document.ListaAssOfPsXContrSp.submit();  
  return false; 
}

function CancelMe()
{
  self.close();
	return false;
}


function handleReturnedInsAss()
{
}

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


function ONVISUALIZZA()
{
    document.ListaAssOfPsXContrSp.act.value="visualizza";
    document.ListaAssOfPsXContrSp.submit(); 
}

function DisattCanc()
{
           var strURL="ListaAssOfPsXContrWfSp.jsp";
                strURL+="?act="+act;
                strURL+="&cod_contratto="+document.ListaAssOfPsXContrSp.contrSelez.value;
                strURL+="&codOf="+document.ListaAssOfPsXContrSp.codOf.value;
                strURL+="&codPs="+document.ListaAssOfPsXContrSp.codPs.value;
                strURL+="&dataIniOf="+document.ListaAssOfPsXContrSp.dataIniOf.value;
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
           if (document.ListaAssOfPsXContrSp.dataFineOf.value=="null")
               document.ListaAssOfPsXContrSp.dataFineOf.value="";
           document.ListaAssOfPsXContrSp.act.value=act;
           document.ListaAssOfPsXContrSp.cod_contratto.value=document.ListaAssOfPsXContrSp.contrSelez.value;
           document.ListaAssOfPsXContrSp.flag_sys.value="<%=flag_sys%>";
           document.ListaAssOfPsXContrSp.action="GestAssOfPsXContrSp.jsp";
           document.ListaAssOfPsXContrSp.submit();  
          }

}

</SCRIPT>


</HEAD>
<BODY onload="setInitialValue();" >
<!--    Costruisco il form contenente i criteri di ricerca e la gestione della paginazione  -->
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="get" action="ListaAssOfPsXContrSp.jsp">
<input type="hidden" name="listaPopola" id="listaPopola" value="<%=listaPopola%>">
<input type="hidden" name="act" id="act" value="<%=act%>">
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
                      <td colspan='4' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="Images/pixel.gif" width="1" height='2'></td>
                    </tr>

                    <tr>
                      <td width="40%" class="textB" align="right">Tipo Contratto:&nbsp;</td>
                      <td width="20%" class="text"><%=des_tipo_contr%></td>
                      <td width="20%" class="textB" align="right">Contratto:&nbsp;</td>
                      <td width="20%" class="text">

                       <%
                         Vector classFatts1=remoteContratto.getContrAssOfPsCluster(cod_tipo_contr,flag_sys);
                         if ((classFatts1!=null)&&(classFatts1.size()!=0))
                         {
                          // Visualizzo elementi%>
                            <select class="text" title="Contratto" name="contrattoCombo" onchange='caricatoContratto();'>
                            <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(25)%></option>
                            <%
                             for(Enumeration e = classFatts1.elements();e.hasMoreElements();)
                             {
                                ContrattoElem elem=new ContrattoElem();
                                elem=(ContrattoElem)e.nextElement();
                                String sel="";
                               
                                if (contrSelez!=null && contrSelez.equals(elem.getCodeContratto()))
                                {
                                  sel="selected";
                                }%>
                                <option value="<%=elem.getCodeContratto()%>" <%=sel%>><%=elem.getDescContratto()%></option>
                           <%}%>
                          </select>
                       <% 
                          }
                          else
                          {
                              // Visualizzo solo [Seleziona Opzione] %>
                              <select class="text" name="contrattoCombo">
                               <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(25)%></option>
                              </select>
                              <SCRIPT LANGUAGE="JavaScript">   Disable(document.frmSearch.contrattoCombo) </SCRIPT>
                        <%}%>
                      </td>
                    </tr>

                    <tr>
                      <td width="25%" class="textB" align="right">Mostra associazioni disattive:&nbsp;</td>
                      <td  width="25%" class="text">
                         <input type=checkbox name=disattivi value="yes" <%=checkedfiltra%>>
                      </td>

<% 
  if ("999".equals(intFunzionalita) || "998".equals(intFunzionalita)) {
%>                                     
                      <td  width="25%" rowspan='1' class="textB" align="right">Cluster:&nbsp;</td>
                      <td width="25%" rowspan='1' class="textB" valign="center" align="center">
                        <span class="text" align="left">
                        <select class="text" name="oggCluster" onchange='change_cluster();' align="left">
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
<% } else { %>

                      <td  width="25%" rowspan='1' class="textB" align="right">&nbsp;</td>
                      <td width="25%" rowspan='1' class="textB" valign="center" align="center">
<% } %>
                        <input class="textB" type="button" name="Esegui"          id="Esegui"          value="Popola lista" onclick="document.frmSearch.listaPopola.value='true';document.frmSearch.caricaLista.value='true';submitFrmSearch('0');">
                        <input class="textB" type="hidden" name="cod_tipo_contr"  id="cod_tipo_contr"  value="<%=cod_tipo_contr%>">
                        <input class="textB" type="hidden" name="des_tipo_contr"  id="des_tipo_contr"  value="<%=des_tipo_contr%>">
                        <input class="textB" type="hidden" name="cod_contratto"   id="cod_contratto"   value="<%=cod_contratto%>">
                        <input class="textB" type="hidden" name="contrSelez"      id="contrSelez"      value="<%=contrSelez%>">
                        <input class="textB" type="hidden" name="des_contratto"   id="des_contratto"   value="<%=des_contratto%>">
                        <input class="textB" type="hidden" name="flag_sys"        id="flag_sys"        value="<%=flag_sys%>">
                        <input class="textB" type="hidden" name="typeLoad"        id="typeLoad"        value="">
                        <input class="textB" type="hidden" name="txtnumRec"       id="txtnumRec"       value="">
                        <input class="textB" type="hidden" name="txtnumPag"       id="txtnumPag"       value="1">
                       <input class="textB" type="hidden" name="caricaLista"        id="caricaLista"        value="<%=caricaLista%>">
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

<form  name="ListaAssOfPsXContrSp" id="ListaAssOfPsXContrSp" method="get" action='ListaAssOfPsXContrSp.jsp'>

 <table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <input type="hidden" name=act id=act value="<%=act%>">
    <input class="textB" type="hidden" name="contrSelez"      id="contrSelez"      value="<%=contrSelez%>">
    <input class="textB" type="hidden" name="cod_tipo_contr"  id="cod_tipo_contr"  value="<%=cod_tipo_contr%>">
    <input class="textB" type="hidden" name="des_tipo_contr"  id="des_tipo_contr"  value="<%=des_tipo_contr%>">
    <input class="textB" type="hidden" name="flag_sys"        id="flag_sys"        value="<%=flag_sys%>">
    <input type="hidden" name="disattivi"  id="disattivi"  value="<%=disattivi%>"> 
   
<%
//if ((cod_contratto!=null) && (!cod_contratto.equals("-1")))
if(caricaLista!=null && caricaLista.equals("true"))
{
%>
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
                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=assOfPs.size()%>">
                 <pg:param name="typeLoad" value="1"></pg:param>
                 <pg:param name="cod_tipo_contr" value="<%=cod_tipo_contr%>"></pg:param>
                 <pg:param name="des_tipo_contr" value="<%=des_tipo_contr%>"></pg:param>
                 <pg:param name="cod_contratto" value="<%=contrSelez%>"></pg:param>
                 <pg:param name="contrSelez" value="<%=contrSelez%>"></pg:param>   
                 <pg:param name="flag_sys" value="<%=flag_sys%>"></pg:param>
                 <pg:param name="disattivi" value="<%=checkvalue%>"></pg:param>
                 <pg:param name="act" value="<%=act%>"></pg:param>
                 
                 <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                 <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
                 <pg:param name="caricaLista" value="<%=caricaLista%>"></pg:param>
                 <pg:param name="listaPopola" value="true"></pg:param>
                
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
                 
                  String obj_getCodeContr = "";
                  String obj_getCodeOf = "";
                  String obj_getCodePs = "";
                  String obj_getCodeCOf = "";
                  String obj_getDataIniOf = "";
                  String obj_getDataIniOfPs = "";
                  String obj_getDataFineOf = "";
                  String obj_getDataFineOfPs = "";
                  String obj_getCodeModal = "";
                  String obj_getCodeFreq = "";
                  String obj_getTipoFlgAP = "";
                  String obj_getQntaShiftCanoni = "";
                  String obj_getDescPs = "";
                  String obj_getDescOf = "";
                  
                 for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<assOfPs.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                 {
                    if ( "999".equals(intFunzionalita) || "998".equals(intFunzionalita)) {
                        AssOfPsXContrBMPClus obj1=(AssOfPsXContrBMPClus)objs[i];
                        
                        obj_getCodeContr = obj1.getCodeContr();
                        obj_getCodeOf = obj1.getCodeOf();
                        obj_getCodePs = obj1.getCodePs();
                        obj_getCodeCOf = obj1.getCodeCOf();
                        obj_getDataIniOf = obj1.getDataIniOf();
                        obj_getDataIniOfPs = obj1.getDataIniOfPs();
                        obj_getDataFineOf = obj1.getDataFineOf();
                        obj_getDataFineOfPs = obj1.getDataFineOfPs();
                        obj_getCodeModal = obj1.getCodeModal();
                        obj_getCodeFreq = obj1.getCodeFreq();
                        obj_getTipoFlgAP = obj1.getTipoFlgAP();
                        obj_getQntaShiftCanoni = String.valueOf(obj1.getQntaShiftCanoni());
                        obj_getDescPs = obj1.getDescPs();
                        obj_getDescOf = obj1.getDescOf();
                    } else {
                        AssOfPsXContrBMP obj=(AssOfPsXContrBMP)objs[i];
             
                        obj_getCodeContr = obj.getCodeContr();
                        obj_getCodeOf = obj.getCodeOf();
                        obj_getCodePs = obj.getCodePs();
                        obj_getCodeCOf = obj.getCodeCOf();
                        obj_getDataIniOf = obj.getDataIniOf();
                        obj_getDataIniOfPs = obj.getDataIniOfPs();
                        obj_getDataFineOf = obj.getDataFineOf();
                        obj_getDataFineOfPs = obj.getDataFineOfPs();
                        obj_getCodeModal = obj.getCodeModal();
                        obj_getCodeFreq = obj.getCodeFreq();
                        obj_getTipoFlgAP = obj.getTipoFlgAP();
                        obj_getQntaShiftCanoni = String.valueOf(obj.getQntaShiftCanoni());
                        obj_getDescPs = obj.getDescPs();
                        obj_getDescOf = obj.getDescOf();
                    }
                    
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;%>
                  <%if(flg_first)
                    {%>
                      <input type="hidden" name=flag_sys       id=flag_sys       value="<%=flag_sys%>">
                      <input type="hidden" name=tipo_contratto id=tipo_contratto value="<%=cod_tipo_contr%>">
                      <input type="hidden" name=cod_contratto id=cod_contratto   value="<%=cod_contratto%>">
                      <input type="hidden" name=codOf         id=codOf           value="<%=obj_getCodeOf%>">
                      <input type="hidden" name=codPs         id=codPs           value="<%=obj_getCodePs%>">
                      <input type="hidden" name=codCOf        id=codCOf          value="<%=obj_getCodeCOf%>">
                      <input type="hidden" name=dataIniOf     id=dataIniOf       value="<%=obj_getDataIniOf%>">
                      <input type="hidden" name=dataIniOfPs   id=dataIniOfPs     value="<%=obj_getDataIniOfPs%>">
                      <input type="hidden" name=dataFineOf    id=dataFineOf      value="<%=obj_getDataFineOf%>">
                      <input type="hidden" name=dataFineOfPs  id=dataFineOfPs    value="<%=obj_getDataFineOfPs%>">
                      <input type="hidden" name=codModal      id=codModal        value="<%=obj_getCodeModal%>">
                      <input type="hidden" name=codFreq       id=codFreq         value="<%=obj_getCodeFreq%>">
                      <input type="hidden" name=flag          id=flag            value="<%=obj_getTipoFlgAP%>">
                      <input type="hidden" name=shift         id=shift           value="<%=obj_getQntaShiftCanoni%>">
                      <input type="hidden" name=appo_index    id=appo_index      value=<%=%>>
                      <input type="hidden" name=appo_numrec   id=appo_numrec     value=<%=%>>
                      <input type="hidden" name=appo_checkvalue id=appo_checkvalue value=<%=%>>
                        <input type="hidden" name="cod_cluster" id="cod_cluster" value= <%=cod_cluster%>>
                        <input type="hidden" name="tipo_cluster" id="tipo_cluster" value= <%=tipo_cluster%>>
                        <input type="hidden" name="tipo_funz" id="tipo_funz" value= <%=tipo_funz%>>      
                                             
                  <%}%>
                       <tr>
                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>
                           <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name='SelOf' value='<%=obj_getCodeOf%>' <%if (flg_first) {out.print("checked");flg_first=false;} %>
                              onclick="ChangeSel('<%=obj_getCodeOf%>',
                                                 '<%=obj_getCodePs%>',
                                                 '<%=obj_getCodeCOf%>',
                                                 '<%=obj_getDataIniOf%>',
                                                 '<%=obj_getDataIniOfPs%>',
                                                 '<%=obj_getDataFineOf%>',
                                                 '<%=obj_getDataFineOfPs%>',
                                                 '<%=obj_getCodeModal%>',
                                                 '<%=obj_getCodeFreq%>',
                                                 '<%=obj_getTipoFlgAP%>',
                                                 '<%=obj_getQntaShiftCanoni%>',
                                                 '<%=cod_cluster%>',
                                                 '<%=tipo_cluster%>',
                                                 '<%=tipo_funz%>')">
                       </td>
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj_getDescPs%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj_getDescOf%></td>
<%
                        if (obj_getDataIniOfPs==null)
                        {
%>                        
                          <td bgcolor="<%=bgcolor%>" class="text">&nbsp;</td>
<%
                        }
                        else
                        {
%>                        
                          <td bgcolor="<%=bgcolor%>" class="text"><%=obj_getDataIniOfPs%></td>
<%
                        }
%>
                        
                        
<%
                        if (obj_getDataFineOfPs==null || obj_getDataFineOfPs.equals(""))
                        {
%>                        
                          <td bgcolor="<%=bgcolor%>" class="text">&nbsp;</td>
<%
                        }
                        else
                        {
%>                        

                          <td bgcolor="<%=bgcolor%>" class="text"><%=obj_getDataFineOfPs%></td>
<%
                        }
%>




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
<%
 }//if su carica lista
%>
    </td>
  </tr>
</table>
  
  <tr>
    <td colspan=5 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="1" height='3'></td>
  </tr>

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan=5>
<%  
    if ((assOfPs!=null)&&(assOfPs.size()!=0))
        {
%>
          <sec:ShowButtons VectorName="vec_BOTTONI" />
<%
        }
%>
    </td>
  </tr>
</table>



</form>

</BODY>
</HTML>
