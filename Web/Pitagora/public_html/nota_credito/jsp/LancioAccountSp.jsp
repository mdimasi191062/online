<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<!--%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*" %-->
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottonSp" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"LancioAccountSp.jsp")%>
</logtag:logData>
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

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

String chiamante = request.getParameter("chiamante");
String POP_UP = request.getParameter("POP_UP");
 
String conf = request.getParameter("conf");
// Vettore contenente risultati query
Collection dati;
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Lancio Nota di Credito
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>
IExplorer =document.all?true:false;
Navigator =document.layers?true:false;

function submitAbortForm()
{
  document.abortForm.txtnumRec.value=document.abortForm.numRec.selectedIndex;
  document.abortForm.submit();
}
function setInitialValue()
{
//Setta il numero di record  
  eval('document.abortForm.numRec.options[<%=index%>].selected=true');

}
function ONANNULLA()
{
    if (document.abortForm.chiamante.value=="LBNCSP")
    {
      opener.document.frmDati.conf.value="false";
      opener.dialogWin.returnFunc();
    }  
    else  
      opener.document.lancioForm.conf.value="false";

     self.close();     
     if (document.abortForm.chiamante.value!="LBNCSP")
         opener.document.lancioForm.submit();
}
function ONCONFERMA()
{
    if (document.abortForm.chiamante.value=="LBNCSP")
    {
       opener.document.frmDati.conf.value="true";
       opener.dialogWin.returnFunc();
    }   
    else
       opener.document.lancioForm.conf.value="true";
    self.close();
    if (document.abortForm.chiamante.value!="LBNCSP")
        opener.document.lancioForm.submit();
}
</SCRIPT>

</HEAD>
<BODY onload="setInitialValue();">


<%
     dati = (Collection) session.getAttribute("dati");
     
 
%>

<form name="abortForm" method="get" action="LancioAccountSp.jsp">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                        <input class="textB" type="hidden" name="conf" value="<%=conf%>">
                        <input class="textB" type="hidden" name="chiamante" id="chiamante"  value="<%=chiamante%>">
                        <input class="textB" type="hidden" name="POP_UP" id="POP_UP"  value="<%=POP_UP%>">
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lancio Nota di Credito</td>
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
	    <table  width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista account non congelati</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>">
                    <tr>
                      <td colspan=2 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td class="textB" colspan =2 align="left">&nbsp;&nbsp;Per i seguenti account esistono elaborazioni batch di tipo </td>
                    </tr>
                    <tr>
                       <%if (POP_UP.equalsIgnoreCase("POP_UP1"))
                       {%>
                         <td class="textB" colspan =2 align="left">&nbsp;&nbsp;Valorizzazione attiva non congelate.</td>
                       <%}
                       else
                       {%>
                         <td class="textB" colspan =2 align="left">&nbsp;&nbsp;Repricing non congelate.</td>
                       <%}%>
                    </tr>
                    <tr>
                      <td class="textB" colspan =2 align="left">&nbsp;&nbsp;Conferma per proseguire escludendo gli account individuati. </td>
                    </tr>
                    <tr>
                      <td class="textB" colspan =2 align="left">&nbsp;&nbsp;Annulla per interrompere l'elaborazione batch.</td>
                    </tr>
                    <tr>
                      <td colspan =2>&nbsp;</td>
                    </tr>
                             <tr>
                               <td class="textB" width="50%" align="right">Risultati per pag.:</td>
                                <td class="text" width="50%" align="left">
                                  <select class="text" name="numRec"  onchange="submitAbortForm();">
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
          <td colspan=2 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
			</td>
		</tr>
  </table>
  <tr>
  	<td>
      <table align=center width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
       <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Risultati della ricerca</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
         </tr>

        <tr>
          <td>
            <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan=2 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
              </tr>
<%
    if ((dati==null)||(dati.size()==0))
    {
 
%>

              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan=2 class="textB" align="center">No Record Found</td>
              </tr>
<%
    
 }
    else
    {
%>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white">&nbsp;</td>
                <td bgcolor="<%=StaticContext.bgColorFooter%>" class='textB'>Account</td>
              </tr>
<%
    }
%>

                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=dati.size()%>">
                <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
                <pg:param name="chiamante" value="<%=chiamante%>"></pg:param>
                <pg:param name="POP_UP" value="<%=POP_UP%>"></pg:param>

                <%
                String bgcolor="";
                Object[] objs=dati.toArray();

                for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<dati.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                    {
                    DatiCliBMP obj=(DatiCliBMP)objs[i];
                    
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;

                %>
                       <tr>
                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>
                           &nbsp; 
                        </td>
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getDesc()%></td>
                    <%    
                     
                    }
                %>    
               
                    <tr>
                      <td colspan=2 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="3" height='2'></td>
                    </tr>

                <pg:index>
                          <tr>
                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan=2 class="text" align="center">
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
                  <td colspan=2 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                </tr>
        
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td colspan=2 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td colspan=2>
         <sec:ShowButtons VectorName="bottonSp" />

    </td>
  </tr>
</TABLE>   
</form>

</BODY>
</HTML>
