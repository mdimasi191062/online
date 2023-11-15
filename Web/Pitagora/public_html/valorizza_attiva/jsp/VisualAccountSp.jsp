<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottonSp" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"VisualAccountSp.jsp")%>
</logtag:logData>
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");
String cod_contratto=request.getParameter("codiceTipoContratto");
if (cod_contratto==null) cod_contratto=request.getParameter("cod_contratto");
if (cod_contratto==null) cod_contratto=(String)session.getAttribute("cod_contratto");

String flagTipoContr = request.getParameter("flagTipoContr"); //060203
if (flagTipoContr!=null && flagTipoContr.equals("null")) flagTipoContr=null;
//System.out.println(">>>>>>>>>>>>>>>> flagTipoContr VisualAccountSp :"+flagTipoContr);


String code_elab=request.getParameter("code_elab");
String controllo=request.getParameter("controllo");
String testo;
if(controllo.equals("1"))
   testo= "Elenco account per i quali necessita generare il CSV";
else
  //MMM 31/10/02 INIZIO
  //testo="Elenco account per i quali necessita effettuare nuovamente il lancio della valorizzazione attiva";
  testo="Elenco account per i quali necessita effettuare nuovamente il lancio della valorizzazione attiva a causa dell'esistenza del listino unico e di quello personalizzato.";






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
String strtypeLoad = request.getParameter("typeLoad");
if (strtypeLoad!=null && !strtypeLoad.equals(""))
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  
  }
Collection oggAccount;
%>
<EJB:useHome id="homeAccount" type="com.ejbBMP.CsvBMPHome" location="CsvBMP" />
<EJB:useHome id="homeAccount2Lst" type="com.ejbBMP.DoppioListinoBMPHome" location="DoppioListinoBMP" />

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Verifica valorizzazione attiva
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>
IExplorer =document.all?true:false;
Navigator =document.layers?true:false;

function submitAccountForm(typeLoad)
{
  document.accountForm.typeLoad.value=typeLoad;
  document.accountForm.txtnumRec.value=document.accountForm.numRec.selectedIndex;
  document.accountForm.submit();
}
function ONANNULLA(){
  //window.close();
	//return false;
  self.close();
  opener.dialogWin.returnFunc();
}
function setInitialValue()
{
//Setta il numero di record  

eval('document.accountForm.numRec.options[<%=index%>].selected=true');
}

</SCRIPT>

</HEAD>
<BODY onload="setInitialValue();">
<form name="accountForm" method="get" action="VisualAccountSp.jsp">
<input class="textB" type="hidden" name="cod_contratto" value="<%=cod_contratto%>">
<input class="textB" type="hidden" name="flagTipoContr" value="<%=flagTipoContr%>"> <!--060203-->
<input class="textB" type="hidden" name="controllo" value="<%=controllo%>">
<input class="textB" type="hidden" name="code_elab" value="<%=code_elab%>">
<input class="textB" type="hidden" name="codcontratto" value="<%=cod_contratto%>">
<input class="textB" type="hidden" name="txtnumRec" value="">
<input class="textB" type="hidden" name="txtnumPag" value="1">
<input class="textB" type="hidden" name="typeLoad" value="<%=typeLoad%>">
<%
 if (typeLoad!=0)
   {
     oggAccount = (Collection) session.getAttribute("oggAccount");
    
   }
   else
   {    
     /*if(cod_contratto.equals(StaticContext.ULL) || cod_contratto.equals(StaticContext.NP) || cod_contratto.equals(StaticContext.CPS) 
                                   || cod_contratto.equals(StaticContext.COLOCATION)) 060203*/
    if(flagTipoContr!=null && flagTipoContr.equals("0"))
    {
    //primo controllo nella mappa chiamante
          if(controllo.equals("1"))
             oggAccount = homeAccount.findAccountLstSP(code_elab);
          else   
             oggAccount = homeAccount2Lst.findAccountLstSP(code_elab);
     }        
     else
     {
          if(controllo.equals("1"))
             oggAccount = homeAccount.findAccountLstXDSL(code_elab);
          else   
             oggAccount = homeAccount2Lst.findAccountLstXDSL(code_elab);
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Verifica Valorizzazione Attiva</td>
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
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista account</td>
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
                <pg:param name="cod_contratto" value="<%=cod_contratto%>"></pg:param>
                <pg:param name="flagTipoContr" value="<%=flagTipoContr%>"></pg:param> <!--060203-->
                <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                <pg:param name="typeLoad" value="1"></pg:param>
                <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
                <pg:param name="controllo" value="<%=controllo%>"></pg:param>
                <pg:param name="code_elab" value="<%=code_elab%>"></pg:param>
                
                <%
                String bgcolor="";
                Object[] objs=oggAccount.toArray();
              if(controllo.equals("1"))
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
        <sec:ShowButtons VectorName="bottonSp" />

    </td>
  </tr>
</TABLE>   


</form>

</BODY>
</HTML>
