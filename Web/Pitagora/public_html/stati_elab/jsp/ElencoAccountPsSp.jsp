<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.usr.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="BOTTONI" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"ElencoAccountPsSp.jsp")%>
</logtag:logData>
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");
String codeElab=request.getParameter("codeElab");
if (codeElab==null) codeElab=(String)session.getAttribute("codeElab");

String flagSys=request.getParameter("flagSys");
if (flagSys==null) flagSys=(String)session.getAttribute("flagSys");

String action=request.getParameter("act");
String title="";

Collection ElencoAccountPs; //per il caricamento della lista degli account per i quali non esistono PS venduti

// Lettura dell'indice Combo Numero Record
int index=0;
String strIndex = request.getParameter("txtnumRec");
if (strIndex!=null)
  {
   Integer tmpindext=new Integer(strIndex);
   index=tmpindext.intValue();
  }
// Lettura del Numero di record per pagina (default 5)
int records_per_page=5;
String strNumRec = request.getParameter("numRec");
if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }
// Lettura tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=1 Fare query (default)
// typeLoad=0 Variabile session
int typeLoad = 0;
String strtypeLoad = request.getParameter("typeLoad");
if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
%>
<EJB:useHome id="ElencoAccountPsHome" type="com.ejbSTL.ElencoAccountPsSTLHome" location="ElencoAccountPsSTL" /> 
<EJB:useBean id="ElencoAccountPsRemote" type="com.ejbSTL.ElencoAccountPsSTL" value="<%=ElencoAccountPsHome.create()%>" scope="page"></EJB:useBean>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Elenco Account per i quali non esistono PS venduti
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>
IExplorer =document.all?true:false;
Navigator =document.layers?true:false;

function submitFrmSearch(typeLoad)
{
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.typeLoad.value=typeLoad;
  document.frmSearch.submit();
}

function setInitialValue()
{
//Setta il numero di record  
eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
}

function cancelLink ()
{
  return false;
}

function disableLink (link)
{
  if (link.onclick)
    link.oldOnClick = link.onclick;
  link.onclick = cancelLink;
  if (link.style)
    link.style.cursor = 'default';
}

function enableLink (link)
{
  link.onclick = link.oldOnClick ? link.oldOnClick : null;
  if (link.style)
      link.style.cursor = document.all ? 'hand' : 'pointer';
}

function ONANNULLA()
{
  self.close();
}
</SCRIPT>
</HEAD>
<BODY onload="setInitialValue();">
<%
   if (typeLoad!=0)
     ElencoAccountPs = (Collection) session.getAttribute("ElencoAccountPs");
   else
   {
     ElencoAccountPs = ElencoAccountPsRemote.getElencoAccountPs(codeElab, flagSys);
     if (ElencoAccountPs!=null)
         session.setAttribute("ElencoAccountPs", ElencoAccountPs);
   }
%>
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="get" action="ElencoAccountPsSp.jsp">
  <tr>
    <td>
      <table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="../images/elenco_account_Titolo.gif" alt="" border="0">
          </td>
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
                      <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Elenco Account per i quali non esistono PS venduti</td>
                      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
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
      <table width="90%" border="0" cellspacing="0" align="center" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr>
           <td width="15%" class="textB" align="Left">&nbsp;Codice:&nbsp;
           </td>   
           <td width="10%" class="text" align="left"> <%=codeElab%><%=flagSys%>
           </td>   
           <td width="75%" class="text" align="left">&nbsp;
           </td>   
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>
       <table width="90%" border="0" cellspacing="0" align="center" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">                    
         <tr>
            <td colspan='2' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
         </tr>
           <tr>
             <tr>
                 <input class="textB" type="hidden" name="txtnumPag" value="1">
                 <input class="textB" type="hidden" name="typeLoad" value="">
                 <input class="textB" type="hidden" name="txtnumRec" value="">
             </tr>
           </tr>
           <tr> 
              <td class="textB" align="right">Risultati per pag.:&nbsp;&nbsp;</td>
              <td class="text" >
                <select class="text"  name="numRec" onchange="submitFrmSearch('1');">
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
  <tr>
  	<td>
      <table align=center width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dettaglio</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan='6' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
              </tr>
                  <input type="hidden" name=act id=act value="popolalista">
                  <input type="hidden" name=codeElab     id=codeElab    value= <%=codeElab%>> 
                  <input type="hidden" name=flagSys      id=flagSys     value=<%=flagSys%>> 
                 <%
                        ElencoAccountPs = ElencoAccountPsRemote.getElencoAccountPs(codeElab, flagSys);
                        if ((ElencoAccountPs==null)||(ElencoAccountPs.size()==0))
                        {
                 %>
                                  <tr>
                                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="6" class="textB" align="center">No Record Found</td>
                                  </tr>
                 <%
                        }
                        else
                        {
                 %>
                           <tr>
                           <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class='textB'>&nbsp&nbsp&nbsp;</td>
                           <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Codice account</td>
                           <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Descrizione Account </td>
                           <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class='textB'>&nbsp;</td>
                           <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class='textB'>&nbsp;</td>
                           <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class='textB'>&nbsp;</td>
                           </tr>
                         <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=ElencoAccountPs.size()%>">
                         <pg:param name="codeElab" value="<%=codeElab%>"></pg:param>
                         <pg:param name="flagSys" value="<%=flagSys%>"></pg:param>
                         <pg:param name="typeLoad" value="1"></pg:param>
                         <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                         <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
                    <%
                       String bgcolor="";
                       String checked;  
                       Object[] objs=ElencoAccountPs.toArray();
                       //Lista Batch 
                       if ((ElencoAccountPs!=null)&&(ElencoAccountPs.size()!=0))
                          // Visualizzo elementi
                          for(int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<ElencoAccountPs.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                          {
                           ClassElencoAccountPsElem obj=(ClassElencoAccountPsElem)objs[i];
                             if ((i%2)==0)
                                 bgcolor=StaticContext.bgColorRigaPariTabella;
                             else
                                 bgcolor=StaticContext.bgColorRigaDispariTabella;
                     %>
                          <tr>
                              <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;</td>
                              <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getCodeAccountPs()%></td>
                              <td bgcolor="<%=bgcolor%>" class='text'><%=obj.getDescAccountPs()%></td>
                              <td bgcolor="<%=bgcolor%>" class='text'>&nbsp;</td>
                              <td bgcolor="<%=bgcolor%>" class='text'>&nbsp;</td>
                              <td bgcolor="<%=bgcolor%>" class='text'>&nbsp;</td>
                          </tr>
                      <%
                          }
                      %>
                          <!--<tr>
                             <td colspan='6' bgcolor="#FFFFFF"><img src="../../images/pixel.gif" width="1" height='2'></td>
                          </tr>-->
                            <pg:index>
                                      <tr>
                                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="6" class="text" align="center">Risultati Pag.
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
                  <%
                  }//chiusura dell'else
                  %>
                <tr>
                  <td colspan='6' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                </tr>
            </table>
          </td>
        </tr>
      <input class="textB" type="hidden" name=num_rec id=num_rec value="<%=ElencoAccountPs.size()%>">
    </table>   
<tr> 
   <td>
      <table width="90%" align=center border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>">
         <tr>
            <td colspan='1' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
         </tr>
         <tr> 
           <td>
             <sec:ShowButtons VectorName="BOTTONI" /> 
           </td>  
          </tr>
      </table>       
   </td>  
</tr>
</form>
</BODY>
</HTML>
