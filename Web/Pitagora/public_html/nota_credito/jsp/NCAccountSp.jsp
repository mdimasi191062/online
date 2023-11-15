<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottonSp" />
<sec:ChkUserAuth RedirectEnabled="true" VectorName="NCAccountSp1" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"NCAccountSp.jsp")%>
</logtag:logData>
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

String cod_tipo_contr=request.getParameter("codiceTipoContratto");
if (cod_tipo_contr==null) cod_tipo_contr=request.getParameter("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("cod_tipo_contr");
String flagTipoContr                   = request.getParameter("flagTipoContr");
if (flagTipoContr!=null && flagTipoContr.equals("null")) flagTipoContr=null;

String code_elabNC=request.getParameter("code_elabNC");
if (code_elabNC==null) code_elabNC=(String)session.getAttribute("code_elabNC");
String controllo=request.getParameter("controllo");
String rtrnAcc=request.getParameter("rtrnAcc");
String testo;
if(controllo.equals("csv"))
   testo= "Elenco account per i quali necessita generare il CSV";
else
  testo="Per i seguenti account non sono state generate note di credito.";
// Lettura del Numero di record per pagina (default 5)
int records_per_page=5;
String strNumRec = request.getParameter("numRec");
if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }
  // Lettura dell'indice Combo Numero Record
int index=0;
String strIndex = request.getParameter("txtnumRec");
if (strIndex!=null && !strIndex.equals(""))
  {
   Integer tmpindext=new Integer(strIndex);
   index=tmpindext.intValue();
  }
int typeLoad=0;
// Lettura tipo caricamento per fare query o utilizzare variabili Session
// Vettore contenente risultati query
Collection oggAccount;
String strtypeLoad = request.getParameter("typeLoad");
if (strtypeLoad!=null && !strtypeLoad.equals(""))
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
 
  }
%>
<EJB:useHome id="homeAccount" type="com.ejbBMP.CsvBMPHome" location="CsvBMP" />
<EJB:useHome id="homeAccount2Lst" type="com.ejbBMP.DoppioListinoBMPHome" location="DoppioListinoBMP" />

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Verifica Nota di Credito
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>
IExplorer =document.all?true:false;
Navigator =document.layers?true:false;

function submitAccountForm(typeLoad)
{
  document.AccountForm.typeLoad.value=typeLoad;
  document.AccountForm.txtnumRec.value=document.AccountForm.numRec.selectedIndex;
  document.AccountForm.submit();
}

function ONANNULLA() //per CSV
{
    opener.document.lancioForm.rtrnAcc.value="false";
    self.close();
    opener.document.lancioForm.submit();
}

//function ONCONFERMA sostituita con ONCONTINUA
function ONCONTINUA() //per Note Di Credito
{
    opener.document.lancioForm.rtrnAcc.value="true";
    self.close();
    //opener.document.lancioForm.submit();
    opener.dialogWin.returnFunc();
}

function setInitialValue()
{
//Setta il numero di record  

eval('document.AccountForm.numRec.options[<%=index%>].selected=true');
}
</SCRIPT>

</HEAD>
<BODY onload="setInitialValue();">
<form name="AccountForm" method="get" action="NCAccountSp.jsp">
                        <input class="textB" type="hidden" name="cod_tipo_contr" value="<%=cod_tipo_contr%>">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                        <input class="textB" type="hidden" name="typeLoad" value="<%=typeLoad%>">
                        <input class="textB" type="hidden" name="controllo" value="<%=controllo%>">
                        <input class="textB" type="hidden" name="code_elabNC" value="<%=code_elabNC%>">
                        <input class="textB" type="hidden" name="rtrnAcc" value="<%=rtrnAcc%>">
                        <input type="hidden" name=flagTipoContr           id=flagTipoContr            value="<%=flagTipoContr%>"> 
<%
 if (typeLoad!=0)
 {
    oggAccount = (Collection) session.getAttribute("oggAccount");
 }
 else
 {    
   if(controllo.equals("csv"))
   {
     //if(cod_tipo_contr.equals(StaticContext.ULL))
     if(flagTipoContr.equals("0"))
          oggAccount = homeAccount.findAccountLstNC(code_elabNC);
          
     else
          oggAccount = homeAccount.findAccountLstXDSLNC(code_elabNC);
          
    }       
   else
   {
     //if(cod_tipo_contr.equals(StaticContext.ULL))
     if(flagTipoContr.equals("0"))
              oggAccount = homeAccount2Lst.findAccountLstNC(code_elabNC);
      else
              oggAccount = homeAccount2Lst.findAccountLstXDSLNC(code_elabNC);
       
   }
 } 
  
    if (oggAccount!=null && oggAccount.size()!=0)
           session.setAttribute("oggAccount", oggAccount);
   
%>

                     
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Verifica Nota di Credito</td>
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
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lsta account</td>
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
                      <td class="textB" colspan =2 align="center"><%=testo%></td>
                    </tr>
                    <tr>
                      <td colspan =2>&nbsp;</td>
                    </tr>
                    <tr>
                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <select class="text" name="numRec" onchange="submitAccountForm('1');">
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

			</td>
		</tr>
  </table>
          <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
        
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
    if ((oggAccount==null)||(oggAccount.size()==0))
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

                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=oggAccount.size()%>">
                <pg:param name="cod_tipo_contr" value="<%=cod_tipo_contr%>"></pg:param>
                <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                <pg:param name="typeLoad" value="1"></pg:param>
                <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
                <pg:param name="controllo" value="<%=controllo%>"></pg:param>
                <pg:param name="code_elabNC" value="<%=code_elabNC%>"></pg:param>
                <pg:param name="flagTipoContr" value="<%=flagTipoContr%>"></pg:param>
                <%
                String bgcolor="";
                Object[] objs=oggAccount.toArray();
              if(controllo.equals("csv"))
              {
                for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<oggAccount.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                    {
                    CsvBMP obj=(CsvBMP)objs[i];
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;

                %>

                       <tr>
                           <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>
                           &nbsp;      </td>  
                           <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getAccount()%></td>
                  <%    
                     
                    }
                 }
                 else
                 {
                 for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<oggAccount.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                    {
                    DoppioListinoBMP obj=(DoppioListinoBMP)objs[i];
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;

                %>

                       <tr>
                           <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>
                           &nbsp;      </td>  
                           <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getAccount()%></td>
                  <%    
                     
                    }
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
    <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td >
    <% 
    if(!controllo.equals("csv")) //2 BOTTONI
    {//bottone continua%>
        <sec:ShowButtons VectorName="bottonSp" />
     <%
     } else 
     {//per CSV bottone annulla%>   
        <sec:ShowButtons PageName="NCAccountSp1" /> 
     <% } %>    
    </td>
  </tr>
</TABLE>   
</form>

</BODY>
</HTML>
