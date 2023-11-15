<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.utl.*,com.usr.*" %>
<sec:ChkUserAuth />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_lista_euribor_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  

  String bgcolor="";
  int i=0;
  int j=0;

  Float  VALO_EURIBOR;
  String sChecked = "";
  java.util.Vector appoVector=null;
    // Variabile per la memorizzazione delle informazioni dalla variabile collection
  I5_2PARAM_VALORIZ_CL_ROW[] aRemote = null;
  String strDataDa = request.getParameter("txtDataDa");
  if (strDataDa==null)
    strDataDa="";
  String strDataA = request.getParameter("txtDataA");
  if (strDataA==null)
    strDataA="";

  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
  java.util.Date DATA_INIZIO_CICLO_FATRZ = null;
  java.util.Date DATA_FINE_CICLO_FATRZ = null;
  
  if(strDataDa!=null)
  {
    if (!strDataDa.equals(""))
      DATA_INIZIO_CICLO_FATRZ = df.parse(strDataDa);
  }


  
  if(strDataA != null)
  {
    if (!strDataA.equals(""))
    DATA_FINE_CICLO_FATRZ = df.parse(strDataA); 
  }
  // questo è il codice selezionato solo nel caso che si richiamino
  // le funzioni di inserimento, modifica o cancellazione (in questo caso l'indice dell'array)
  //Il campo contiene l'elemento selezionato dall'utente
  String CodSel=request.getParameter("CodSel");

  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  

    //Lettura dell'indice Numero record per pagina della combo per ripristino dopo  ricaricamento
  int index=0;
  String strIndex = request.getParameter("txtnumRec");
  if (strIndex!=null)
  {
    Integer tmpindext=new Integer(strIndex);
    index=tmpindext.intValue();
  }

    //Lettura dell'indice pager.offset
  
  String strPagerOffset = request.getParameter("pager.offset");
  if (strPagerOffset==null)
    strPagerOffset="0";

  int pageroffset = Integer.parseInt(strPagerOffset);

//Lettura del valore Numero record per pagina della combo per visualizzazione risultato (default 5)
  String strNumRec = request.getParameter("numRec");
  if (strNumRec==null)
    strNumRec="5";
  int records_per_page = Integer.parseInt(strNumRec);
  
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">

function ONSTAMPA()
{
  openDialog("stampa_euribor.jsp", 800, 500, "","print");
}
function ONNUOVO()
{
  esegui(0);
}

function ONAGGIORNA()
{
  esegui(1);
}

function ONELIMINA()
{
  esegui(2);
}

function esegui(operazione)
{
/* operazione vale:
    0 per l'inserimento
    1 per l'aggiornamento
    2 per l'eliminazione
*/

 var sParametri='';
  sParametri= '?txtnumRec=<%=index%>';
  sParametri= sParametri + '&numRec=<%=records_per_page%>';
  sParametri= sParametri + '&pager.offset=<%=strPagerOffset%>';
  sParametri= sParametri + '&txtTypeLoad=1'; 
  sParametri= sParametri + '&operazione=' + operazione;
  sParametri= sParametri + '&txtDataDa=<%=strDataDa%>'; 
  sParametri= sParametri + '&txtDataA=<%=strDataA%>';   
  sParametri= sParametri + '&CodSel=' + document.frmDati.CodSel.value;
  openDialog("cbn1_agg_euribor_cl.jsp" + sParametri, 600, 270);


}
  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function submitFrmSearch(typeLoad)
{
  var strDataa = document.frmSearch.txtDataA.value;
  var strDatada= document.frmSearch.txtDataDa.value;
  if(strDataa.length!=0 && strDatada.length!=0)
  {
    if(!chkDataRange(document.frmSearch.txtDataDa.value,document.frmSearch.txtDataA.value))
    {    
      alert("La 'data a' deve essere maggiore della 'data da'.");
      return
    }
  }
    document.frmSearch.txtDataDa.disabled = false;
    document.frmSearch.txtDataA.disabled = false;
    document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
    document.frmSearch.CodSel.value=document.frmDati.CodSel.value;
    document.frmSearch.txtTypeLoad.value=typeLoad;
    document.frmSearch.submit();
}  

function setnumRec()
{
  document.frmSearch.numRec.options[<%=index%>].selected=true;

}

function ChangeSel(codice,indice)
{
  document.frmDati.CodSel.value=codice;
}

function deleteData(objs)
{
  obj = eval("document." + objs);
  obj.value="";
}
function chkDataRange(strDataDa,strDataA){
			var dataDa = new Date(strDataDa.substring(6,10),strDataDa.substring(3,5)-1,strDataDa.substring(0,2));
			var dataA = new Date(strDataA.substring(6,10),strDataA.substring(3,5)-1,strDataA.substring(0,2));
			if(dataDa>dataA)
				return false;
      return true;
}


function selezionaPrimo()
{
  var n = document.frmDati.elements.length;
  var esiste=0;
  var selezionato=false;
  for(i=0;i<n;i++)
  {
    if(document.frmDati.elements[i].type=="radio")
    {
        esiste++;
        if(document.frmDati.elements[i].checked==true)
          selezionato=true;
    }
  }
  if(esiste>1 && !selezionato)
  {
      document.frmDati.indice[0].checked=true;
      document.frmDati.CodSel.value=document.frmDati.indice[0].value;
  }
  if(esiste==1 && !selezionato)
  {
      document.frmDati.indice.checked=true;
      document.frmDati.CodSel.value=document.frmDati.indice.value;
  }  
}
function esistonoRighe()
{
  var n = document.frmDati.elements.length;
  for(var i=0;i<n;i++)
  {
    if(document.frmDati.elements[i].type=='radio')
    {
      return true;
    }
  }
  return false;
}
function abilitaTasti()
{
  Disable(document.frmSearch.txtDataA);
  Disable(document.frmSearch.txtDataDa);
  if(!esistonoRighe())
  {
    if(document.frmDati.AGGIORNA)
    {
      Disable(document.frmDati.AGGIORNA);
    }
    if(document.frmDati.ELIMINA)
    {
      Disable(document.frmDati.ELIMINA);
    }
    if(document.frmDati.STAMPA)
    {
      Disable(document.frmDati.STAMPA);
    }    
  }
}
</SCRIPT>

<TITLE>FATTURAZIONE NON TRAFFICO</TITLE>
</HEAD>
<BODY onload="">
  <!-- Gestione navigazione-->
<EJB:useHome id="home" type="com.ejbSTL.I5_2PARAM_VALORIZ_CLHome" location="I5_2PARAM_VALORIZ_CL" />  
<EJB:useBean id="eur" type="com.ejbSTL.I5_2PARAM_VALORIZ_CL" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<%
//Lettura del valore tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=0 Fare query (default)
// typeLoad=1 Variabile session

  int typeLoad=0;
  String strtypeLoad = request.getParameter("txtTypeLoad");
  if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }

  if (typeLoad!=0)
  {
    aRemote = (I5_2PARAM_VALORIZ_CL_ROW[]) session.getAttribute("aRemote");
  }
  else
  {   
    appoVector = eur.findAll(DATA_INIZIO_CICLO_FATRZ, DATA_FINE_CICLO_FATRZ);
    if (!(appoVector==null || appoVector.size()==0)) 
    {
      aRemote = (I5_2PARAM_VALORIZ_CL_ROW[])appoVector.toArray(new I5_2PARAM_VALORIZ_CL_ROW[1]);
      session.setAttribute( "aRemote", aRemote);
    }  
    else
    {
      session.setAttribute("aRemote", null);
    }  
  } 


%>

<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="cbn1_lista_euribor_cl.jsp">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/euribor.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Euribor</td>
                <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="1" align='center'>
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                    <tr>
                      <td>
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#0A6B98">
                          <tr>
                            <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp; Filtro di Ricerca</td>
                            <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                          </tr>
                          </table>
                      </td>
                    </tr>

        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr>
                      <td colspan='5' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>

                    <tr>
                      <td width="20%" class="textB" align="right">Data fatt. da:&nbsp;</td>
                      <td  width="30%" class="text">
                                            <input disabled class="text" type='text' name='txtDataDa'  size='11'
                        <%if (strDataDa==null){%>><%}else{%>value='<%=strDataDa%>' ><%}%>
                        <a href="javascript:showCalendar('frmSearch.txtDataDa','01/01/2002');">
                      <img src="../../common/images/body/calendario.gif" border="0" alt="Click per selezionare una data" align="top" WIDTH="24" HEIGHT="22"></a>

                        <a href="javascript:deleteData('frmSearch.txtDataDa');">
                      <img src="../../common/images/body/cancella.gif" border="0" alt="Click per cancellare la data" align="top" WIDTH="24" HEIGHT="22"></a>

                      </td>

                      <td width="20%" class="textB" align="right">Data fatt. a:&nbsp;</td>

                      <td  width="30%" class="text">
                        <input disabled class="text" type='text' name='txtDataA'  size='11'<%if (strDataA==null){%>><%}else{%>value='<%=strDataA%>' ><%}%>
                        <a href="javascript:showCalendar('frmSearch.txtDataA','01/01/2002');">
                      <img src="../../common/images/body/calendario.gif" border="0" alt="Click per selezionare una data" align="top" WIDTH="24" HEIGHT="22"></a>
                        <a href="javascript:deleteData('frmSearch.txtDataA');">
                      <img src="../../common/images/body/cancella.gif" border="0" alt="Click per cancellare la data" align="top" WIDTH="24" HEIGHT="22"></a>
                      </td>
                      
                      <td rowspan='2' width="10%" rowspan='2' class="textB" align="center">
                        <input class="textB" type="button" name="Esegui" value="Popola" onclick="submitFrmSearch('0');">                    
                        <input type="hidden" name="CodSel" value="">                     
                        <input type="hidden" name="txtTypeLoad" value="">
                        <input type="hidden" name="txtnumRec" value="">
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
                      <td>&nbsp;</td>
 					  <td>&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
					</td>
        </tr>
        <tr>
          <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
</form>
  <!-- Gestione navigazione-->
<form name="frmDati" method="post" action='ListaEuribor.jsp'>
        <tr>
          <td>
            <table border="0" width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#0A6B98">
              <tr>
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Lista Valori Percentuale Euribor</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
  <% 
  if ((aRemote==null)||(aRemote.length==0))  
  
  {
    %>
                    <tr>
                      <td bgcolor="#FFFFFF" class="textB" align="center">Nessun Record Trovato</td>
                    </tr>
   <%
  } else {
  %>
                    
                    <tr>
                      <td>
                        <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                        <tr>
                          <td bgcolor='white' width="0%" >&nbsp;</td>      
                          <td bgcolor='#D5DDF1' class="textB" width="30%">Valore % Euribor</td>
                          <td bgcolor='#D5DDF1' class="textB" width="30%">Periodo di Riferimento Euribor</td>
                          <td bgcolor='#D5DDF1' class="textB" width="20%">Data Inizio Ciclo Fatt.</td>
                          <td bgcolor='#D5DDF1' class="textB" width="20%">Data Fine Ciclo Fatt.</td>                         
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote.length%>">
<pg:param name="txtTypeLoad" value="1"></pg:param>
<pg:param name="CodSel" value="<%=CodSel%>"></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="txtDataDa" value="<%=strDataDa%>"></pg:param>
<pg:param name="txtDataA" value="<%=strDataA%>"></pg:param>

<!--<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>-->

<%

      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote.length) && (j<pagerPageNumber.intValue()*records_per_page));j++)
      {
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";
         String DATA_CONCAT    = aRemote[j].getPeriodo_rif();   
         VALO_EURIBOR = aRemote[j].getValo_euribor();                                                          
         java.text.SimpleDateFormat di = new java.text.SimpleDateFormat ("dd/MM/yyyy");
         String strDATA_INIZIO_CICLO_FATRZ = di.format(aRemote[j].getData_inizio_ciclo_fatrz());
         String strDATA_FINE_CICLO_FATRZ = di.format(aRemote[j].getData_fine_ciclo_fatrz());         
         if (CodSel!=null)
         {
             if (CodSel.equals(Integer.toString(j)))
             {
                  sChecked="checked";
             }
             else
             {
                  sChecked="";
             }
          }


%>
                        <TR>
                           <td bgcolor='white' >
                              <input type="radio" name="indice" <%=sChecked%> value="<%=j%>" onClick="ChangeSel('<%=j%>','0')" >
                           </td>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= VALO_EURIBOR.toString().replace('.',',') %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= DATA_CONCAT %></TD>            
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= strDATA_INIZIO_CICLO_FATRZ %></TD>                                 
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= strDATA_FINE_CICLO_FATRZ %></TD>                                 
                        </tr>
                        <tr>
                          <td colspan='5' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                        </tr>

<%
          i+=1;
        }
%>

                        <tr>
                          <td colspan='5' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="3" height='2'></td>
                        </tr>
<pg:index>
                        <tr>
                          <td bgcolor="#FFFFFF" colspan="5" class="text" align="center">
                          Risultati Pag.
                          <pg:prev> 
                            <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
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
                            <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
<%
    } 
%>
</pg:pages>
                          <pg:next>
                            <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
                          </pg:next>
                          </td>
                        </tr>
</pg:index>
</pg:pager>


                        </table>
<%
    }
%> 
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
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <td colspan="5">
            <input type="hidden" name="CodSel" value="<%= CodSel %>" >   
             
	        </td>
   
	      </tr>
	    </table>
      </td>
</table>
  </td>

  </tr>
  <TR>
    <TD>
      <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
    </TD>
  </TR>

</table>
</form>
<SCRIPT LANGUAGE="JavaScript">
    setnumRec();
    selezionaPrimo();
    abilitaTasti();
</SCRIPT>
</BODY>
</HTML>
