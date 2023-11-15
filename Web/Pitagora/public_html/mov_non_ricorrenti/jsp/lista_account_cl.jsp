<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="java.io.*,java.util.*,java.text.*,javax.naming.*,javax.rmi.*,javax.ejb.*,java.sql.*,com.ejbBMP.*,com.ejbSTL.*,com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"lista_account_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  boolean bCheck = false;
%>
<%
  FILTRO_MOV_NON_RICEJB remote=null;
  String bErrore = null;
  Vector vettore = new Vector();
  DatiAcc[] vettArray = null;
  String bgcolor="";
  int i=0;  
  int j=0; 
  int iPagina=0;  

  String sChecked="checked";
     // This is the variable we will store all records in.
  bErrore = request.getParameter("bErrore");

  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------   
  int CodSel=0;
  String strCodSel = request.getParameter("CodSel");
  if(strCodSel!=null)
  {
    CodSel=Integer.parseInt(strCodSel);
  }
     
  //eventuale Filtro di ricerca
// rivedere!!!
  String strFornitore = request.getParameter("txtFornitore"); 
  String codiceTipoContratto;     
  codiceTipoContratto= (String) session.getAttribute("codiceTipoContratto");
  
  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
  
  //Lettura dell'indice Numero record per pagina della combo per ripristino dopo ricaricamento
  int index=0;
  String strIndex = request.getParameter("txtnumRec");
  if (strIndex!=null)
  {
    Integer tmpindext=new Integer(strIndex);
    index=tmpindext.intValue();
  }
 
  //Lettura del valore Numero record per pagina della cisualizzazione risultato (default 5)
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

  //------------------------------------------------------------------------------
  //Fine Standard Ricerca
  //------------------------------------------------------------------------------  

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Lista Account</title>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<script language="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<script language="JavaScript">
  //------------------------------------------------------------------------------  //Gestione Standard Ricerca
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
}
  //------------------------------------------------------------------------------
  //Fine Gestione Standard Ricerca
  //------------------------------------------------------------------------------  


function ONCONFERMA()
{
  if (document.frmDati.CodSel.length==0){ 
     alert('Non è stato selezionato alcun dato');
     return(false);}
  else {
     document.frmDati.action="ins_account_cl.jsp"
     document.frmDati.method="POST";
     document.frmDati.submit(); }  
}
function ONANNULLA()
{  
     window.close();
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
      document.frmDati.indiceArray[0].checked=true;
      document.frmDati.CodSel.value=document.frmDati.indiceArray[0].value;
  }
  if(esiste==1 && !selezionato)
  {
      document.frmDati.indiceArray.checked=true;
      document.frmDati.CodSel.value=document.frmDati.indiceArray.value;
  }  
}
</SCRIPT>
<TITLE>Selezione Account</TITLE>
</HEAD>
<BODY onload="selezionaPrimo();">
<%
  if (typeLoad!=0)
  {
    vettArray = (DatiAcc[]) session.getAttribute("vettArray");
  }
  else
  {    

%>
<EJB:useHome id="home" type="com.ejbSTL.FILTRO_MOV_NON_RICEJBHome" location="FILTRO_MOV_NON_RICEJB" />
<EJB:useBean id="remoto_FILTRO_MOV_NON_RICEJB" type="com.ejbSTL.FILTRO_MOV_NON_RICEJB" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
    String codforn = request.getParameter("txtCodeFornitore");
    String provenienza = request.getParameter("txtProvenienza");
    vettore = remoto_FILTRO_MOV_NON_RICEJB.FindAcc(codforn, provenienza,codiceTipoContratto);
    if (!(vettore==null || vettore.size()==0)) 
    {
      vettArray = (DatiAcc[]) vettore.toArray( new DatiAcc[1]);
      session.setAttribute( "vettArray", vettArray);
    }  
  }
%>
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/movnonric.gif" alt="" border="0"></td>
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Lista Account</td>
                <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='3'></td>
  </tr>
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="lista_account_cl.jsp">
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
                            <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp; Filtro di Ricerca</td>
                            <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                          </tr>
                          </table>
                      </td>
                    </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr>
                      <td colspan='2' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td width="50%" class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <input type="hidden" name="CodSel" value="">                     
                        <input type="hidden" name="txtTypeLoad" value="">
                        <input type="hidden" name="txtnumRec" value="">                      
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
          <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
</form>


<form name="frmDati">
        <tr>
          <td>
            <input type="hidden" name="CodSel" value="<%=CodSel%>" >  
            <input class="textB" type="hidden" name="txtTypeLoad" value="">
            <input class="textB" type="hidden" name="txtnumRec" value="">
            <input class="textB" type="hidden" name="txtnumPag" value="1">
            <table border="0" width="100%" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Account selezionati</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td colspan='1' bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='2'></td>
                    </tr>
  <% 
  if ((vettArray==null)||(vettArray.length==0)) 
  {
    %>
                    <tr>
                      <td bgcolor="#FFFFFF"  class="textB" align="center">No Record Found</td>
                    </tr>
   <%
  } else {
  %>
                    
                    <tr>
                      <td>
                        <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                        <tr>
                          <td bgcolor='white' width="0%" >&nbsp;</td>      
                          <td bgcolor='#D5DDF1' class="textB" width="100%" >Account</td>
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=vettArray.length%>">
<pg:param name="txtTypeLoad" value="1"></pg:param>
<pg:param name="CodSel" value="<%=CodSel%>"></pg:param>
<pg:param name="txtFornitore" value=""></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>   
<%

      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<vettArray.length) && (j<pagerPageNumber.intValue()*records_per_page));j++)
      {
         DatiAcc datiacc = vettArray[j];
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";
         String CODE_ACCOUNT            = datiacc.get_codice();                                                    
         String DESC_ACCOUNT            = datiacc.get_descrizione();
           if(CodSel==j)
           {
              sChecked="checked";
           }
           else
           {
              sChecked="";
            }
%>
                        <TR>
                           <td bgcolor='white'>
                              <input type="radio" name="indiceArray" value="<%=j%>" <%=sChecked%> onClick="ChangeSel(<%=j%>,0)">
                           </td>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= DESC_ACCOUNT %></TD>
                        </tr>
                        <tr>
                          <td colspan='2' bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='2'></td>
                        </tr>


<%
          i+=1;
        }
%>
<pg:index>
                        <tr>
                          <td bgcolor="#FFFFFF" colspan="2" class="text" align="center">
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
                          <td colspan='2' bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='2'></td>
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
  </tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>  
  <tr>   
    <td>  
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />	        
	      </tr>
	    </table>
    </td>
  </tr>        
</table>
</form>
<script language="javascript">
setnumRec();
<% 
if ((vettArray==null)||(vettArray.length==0)) {
%> 
    Disable(document.frmDati.CONFERMA);
<%
}  
%>
</script>
</BODY>
</HTML>
