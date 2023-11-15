<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.rmi.*,com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Collection" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_lista_fascia_cl.jsp")%>
</logtag:logData>
<% 
  response.addHeader("Pragma", "no-cache"); 
  response.addHeader("Cache-Control", "no-store");
    //---------------------------------------------------------------------------------
    //                                Dichiarazioni
    //---------------------------------------------------------------------------------    
    //Interfaccia Remota
  I5_2FASCIE remote = null;       
    //Se valorizzato ad uno indica che la pagina e richiamata dalla pagina di cancellazione 
    //e bisogna dare un avviso all'utente 
  String bErrore = null;
  String bgcolor="";
    //Flag per individuare se una riga é selezionata
  boolean bCheck = false;
  int i=0;
  int j=0;
  int iPagina=0;  
     //Il campo contiene l'elemento selezionato dall'utente
  String selCODE_FASCIA=null;
  String sChecked="checked";
    // This is the variable we will store all records in.
  Collection collection=null;
    // Variabile per la memorizzazione delle informazioni dalla variabile collection
  I5_2FASCIE[] aRemote = null;
  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");        
  I5_2FASCIEPK PrimaryKey    = null;                                                     
  String DESC_FASCIA    = null;
  String VALO_LIM_MAX    = null;
  String VALO_LIM_MIN    = null;
  String DATA_INIZIO_VALID = null;  
  
  selCODE_FASCIA=request.getParameter("CodSel");  

  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
 
    //eventuale Filtro di ricerca
  String strCodRicerca= request.getParameter("txtCodRicerca");

    //Lettura dell'indice Numero record per pagina della combo per ripristino dopo  ricaricamento
  int index=0;
  String strIndex = request.getParameter("txtnumRec");
  if (strIndex!=null)
  {
    Integer tmpindext=new Integer(strIndex);
    index=tmpindext.intValue();
  }

//Lettura del valore Numero record per pagina della combo per visualizzazione risultato (default 5)
  int records_per_page=5;
  String strNumRec = request.getParameter("numRec");
  if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }  
  

//Lettura del valore tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=1 Fare query (default)
// typeLoad=0 Variabile session

  int typeLoad=0;
  String strtypeLoad = request.getParameter("txtTypeLoad");
  if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
  if (typeLoad!=0)
  {
    aRemote = (I5_2FASCIE[]) session.getAttribute("aRemote");
  }
  else
  {
%>  
<EJB:useHome id="home" type="com.ejbBMP.I5_2FASCIEHome" location="I5_2FASCIE" />    
<%  
    collection = home.findAll(strCodRicerca);      
    if (!(collection==null || collection.size()==0)) {
      aRemote = (I5_2FASCIE[]) collection.toArray( new I5_2FASCIE[1]);
      session.setAttribute( "aRemote", aRemote);
    }else{  
      session.setAttribute( "aRemote", null);    
    }  
  }
  //------------------------------------------------------------------------------
  //Fine Standard Ricerca
  //------------------------------------------------------------------------------  
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
function ONSTAMPA()
{
  var W=800;
  var H=600;
  openDialog("stampa_fascia_cl.jsp", 800, 600, "","print");  
}
function ONNUOVO()
{
  GestioneFascie(0);
}
function ONAGGIORNA()
{
  GestioneFascie(1);
}
function GestioneFascie(iGestione)
{
  var sParametri='';
  sParametri= '?txtnumRec=<%=index%>';
  sParametri= sParametri + '&numRec=<%=records_per_page%>';
  sParametri= sParametri + '&txtTypeLoad=1'; 
<%  
  if (strCodRicerca!=null){
%>
  sParametri= sParametri + '&txtCodRicerca=<%=strCodRicerca%>'; 
<%  
  }
%>      
  if (parseInt(iGestione)==0){
    sParametri= sParametri + '&strProvenienza=0i';
  }else{  
    sParametri= sParametri + '&strProvenienza=0m';
    sParametri= sParametri + '&CodiceFascia=' + document.frmDati.CodSel.value;         
  }
  openDialog("cbn1_ins_fascia_cl.jsp" + sParametri, 600, 350);    
}
function ONELIMINA()  
{
  if (confirm('Si conferma la cancellazione della Procedure Emittente selezionata ?')==true){
    var sParametri='';
    sParametri= '?txtnumRec=<%=index%>';
    sParametri= sParametri + '&numRec=<%=records_per_page%>';
    sParametri= sParametri + '&txtTypeLoad=1'; 
    sParametri= sParametri + '&txtCodRicerca=<%=strCodRicerca%>'; 
    window.document.frmDati.action=window.document.frmDati.action + sParametri;
    window.document.frmDati.submit();
  }
  return(false);
}
  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function submitFrmSearch(typeLoad)
{
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.CodSel.value=document.frmDati.CodSel.value;
  document.frmSearch.txtTypeLoad.value=typeLoad;
  document.frmSearch.submit();
}  
function setnumRec()
{
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
}

function ChangeSel(codice,indice)
{
  document.frmDati.CodSel.value=codice;
//  document.frmDati.RagSel.value=eval('document.frmOlo.SelClienti[indice].value');
}
  //------------------------------------------------------------------------------
  //Fine Gestione Standard Ricerca
  //------------------------------------------------------------------------------  

</SCRIPT>


<TITLE>Selezione Fascia</TITLE>
</HEAD>
<BODY onload="setnumRec();">
  <!-- Gestione navigazione-->
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="cbn1_lista_fascia_cl.jsp">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/fascia.gif" alt="" border="0"></td>
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Lista Fasce</td>
                <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Filtro di Ricerca</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr>
                      <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td width="40%" class="textB" align="right">Codice:&nbsp;</td>
                      <td  width="40%" class="text">
                        <%
                        if (strCodRicerca==null){
                        %>
                          <input class="text" type='text' name='txtCodRicerca'  size='20'>                        
                        <%                        
                        }else{
                        %>
                          <input class="text" type='text' name='txtCodRicerca' value='<%=strCodRicerca%>' size='20'>                        
                        <%                        
                        }
                        %>
                      </td>
                      <td width="20%" rowspan='2' class="textB" valign="center" align="center">
                        <input class="textB" type="button" name="Esegui" value="Popola" onclick="submitFrmSearch('0');">
                        <% 
                        if (selCODE_FASCIA!=null){
                        %>
                        <input class="textB" type="hidden" name="CodSel" value="<%=selCODE_FASCIA%>">
                        <%
                        }else{
                        %>
                        <input class="textB" type="hidden" name="CodSel" value="">
                        <%
                        }  
                        %>
                        <input class="textB" type="hidden" name="txtTypeLoad" value="">
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
          <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
        </tr>
</form>
  <!-- Gestione navigazione-->
<form name="frmDati" method="post" action='cbn1_dis_fascia_cl.jsp'>
        <tr>
          <td>
            <table border="0" width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Procedure Fasce</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td colspan='1' bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
                    </tr>
  <% 
  if ((aRemote==null)||(aRemote.length==0)){
    %>
                    <tr>
                      <td bgcolor="#FFFFFF" colspan="1" class="textB" align="center">No Record Found</td>
                    </tr>
   <%
  } else {
  %>
                    
                    <tr>
                      <td>
                        <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                        <tr>
                          <td bgcolor='white' class="textB" width="0%">&nbsp;</td>      
                          <td bgcolor='#D5DDF1' class="textB" width="20%">Codice</td>
                          <td bgcolor='#D5DDF1' class="textB" width="20%">Descrizione</td>
                          <td bgcolor='#D5DDF1' class="textB" width="20%">Minimo</td>
                          <td bgcolor='#D5DDF1' class="textB" width="20%">Massimo</td>                         
                          <td bgcolor='#D5DDF1' class="textB" width="20%">Data Inizio</td>                                                    
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote.length%>">
<pg:param name="txtTypeLoad" value="1"></pg:param>
<pg:param name="CodSel" value="<%=selCODE_FASCIA%>"></pg:param>
<pg:param name="txtCodRicerca" value="<%=strCodRicerca%>"></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>                        
<%

      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote.length) && (j<pagerPageNumber.intValue()*records_per_page));j++)      
      {
         remote = (I5_2FASCIE) PortableRemoteObject.narrow(aRemote[j],I5_2FASCIE.class);                                                
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";
         PrimaryKey    = (I5_2FASCIEPK) remote.getPrimaryKey();                                                    
         DESC_FASCIA    = remote.getDESC_FASCIA();
         VALO_LIM_MAX    = Integer.toString(remote.getVALO_LIM_MAX());
         VALO_LIM_MIN    = Integer.toString(remote.getVALO_LIM_MIN());
         DATA_INIZIO_VALID = df.format(remote.getDATA_INIZIO_VALID());         
         sChecked="";
         if (!bCheck){
           if (selCODE_FASCIA!=null){
              if(PrimaryKey.getCode_fascia().equals(selCODE_FASCIA)){
                sChecked="checked";
                bCheck=true;
              }                
           }  else {   
              if (i==0) {
                selCODE_FASCIA=PrimaryKey.getCode_fascia();
                sChecked="checked";
                bCheck=true;              
              }  
           }
         }
%>
                        <TR>
                           <td bgcolor='white'>
                              <input type="radio" name="CODE_FASCIA" value="<%= PrimaryKey.getCode_fascia() %>" <%=sChecked%> onclick=ChangeSel('<%=PrimaryKey.getCode_fascia()%>','<%=i%>')>
                           </td>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= PrimaryKey.getCode_fascia() %></TD>                           
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= DESC_FASCIA %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= VALO_LIM_MIN %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= VALO_LIM_MAX %></TD>                           
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= DATA_INIZIO_VALID %></TD>      
                        </tr>
                        <tr>
                          <td colspan='6' bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
                        </tr>

<%
          i+=1;
        }
%>        
<pg:index>
                        <tr>
                          <td bgcolor="#FFFFFF" colspan="6" class="text" align="center">
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
<%
}
%>
                        <tr>
                          <td colspan='6' bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
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
    <td bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
                <% 
        if (selCODE_FASCIA!=null){
        %>
        <input class="textB" type="hidden" name="CodSel" value="<%=selCODE_FASCIA%>">
        <%
        }else{
        %>
        <input class="textB" type="hidden" name="CodSel" value="">
        <%
        }  
        %>
	      <tr>
            <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>
<script language="javascript">
<% 
if ((aRemote==null)||(aRemote.length==0)) { 
%>
    Disable(document.frmDati.ELIMINA);
    Disable(document.frmDati.AGGIORNA);        
    Disable(document.frmDati.STAMPA);
<%
}else{
  if (!bCheck){
    if (i==1){
%>
    document.frmDati.CODE_FASCIA.checked=true;
//    document.frmDati.CodSel.value=codice;
<%    
    }else{    
%>
    document.frmDati.CODE_FASCIA[0].checked=true;
//    document.frmDati.CodSel.value=codice;
<% 
    }
  }
}  
%>
</script>
</BODY>
</HTML>
