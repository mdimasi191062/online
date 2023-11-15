<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*,java.util.Vector.*" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" VectorName="vectorButton" />
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"AccNoteCredSp.jsp")%>
</logtag:logData>

<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");
String codeFunzBatch       = request.getParameter("codeFunzBatch");
String codeFunzBatchNC     = request.getParameter("codeFunzBatchNC");
String codeFunzBatchRE     = request.getParameter("codeFunzBatchRE");
String soloPopolamento     = request.getParameter("soloPopolamento");
String dataIniCiclo        = request.getParameter("dataIniCiclo");
String act                 =request.getParameter("act");
String cod_tipo_contr      =request.getParameter("cod_tipo_contr");
String des_tipo_contr      =request.getParameter("des_tipo_contr");
String[] CodeAccountRiep1 = null; //request.getParameterValues("CodeAccountRiep1");
if (CodeAccountRiep1==null) CodeAccountRiep1 = (String[])session.getAttribute("CodeAccountRiep1");
String dataFineA = request.getParameter("dataFineA");
String dataSched = request.getParameter("dataSched");

String numAcc       = request.getParameter("numAcc");
if (numAcc==null || numAcc.equals("null")) numAcc="0";
// Lettura dell'indice Combo Numero Record
int index=0;
String strIndex = request.getParameter("txtnumRec");
if (strIndex!=null && strIndex!="null" && !(strIndex.equals("")))

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
int typeLoad=0;
String strtypeLoad = request.getParameter("typeLoad");
if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }

String numAccChiamante=null;
if ((CodeAccountRiep1!=null) && typeLoad==0)
   numAccChiamante = new String (new Integer(CodeAccountRiep1.length).toString());
else
   numAccChiamante= request.getParameter("numAccChiamante");
// Vettore contenente risultati query
Collection account=(Collection)session.getAttribute("account");

String testo1=" ";
String testo2=" ";
String testo3=" ";

if (act!=null && act.equalsIgnoreCase("accountNoteCred"))
  testo1 = "Per i seguenti Account esistono elaborazioni batch di tipo Note di Credito";
else if (act!=null && act.equalsIgnoreCase("accountRepricing"))
  testo1 = "Per i seguenti Account esistono elaborazioni batch di tipo Repricing";
testo2 = "non congelate.Conferma per proseguire escludendo gli account individuati"; 
testo3 = "Lista Account";
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE> Lista Account </TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>

if ("<%=act%>"=="refresh")
{
     opener.document.lancioVAForm.act.value="refresh";
     opener.dialogWin.returnFunc();
     self.close();
}
var codeFunzBatch=<%=codeFunzBatch%>;
var codeFunzBatchNC=<%=codeFunzBatchNC%>;
var codeFunzBatchRE=<%=codeFunzBatchRE%>;
var soloPopolamento="<%=soloPopolamento%>";

var abi_conferma=true;

function submitFrmSearch(typeLoad)
{
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.typeLoad.value=typeLoad;
  document.frmSearch.submit();
}

function setInitialValue()
{
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
  if (!abi_conferma)
  {
      Disable(document.frmSearch.CONFERMA);
  }
}

function ONANNULLA()
{
      if (opener && !opener.closed) 
			{
				opener.document.frmDati.button.value = "ANNULLA";
        opener.dialogWin.returnFunc();
				self.close();
			}
			else
			{ 
				alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
				self.close();
			}
}

function ONCONFERMA()
{
         document.frmSearch.codeFunzBatch.value       = "<%=codeFunzBatch%>";
         document.frmSearch.codeFunzBatchNC.value     = "<%=codeFunzBatchNC%>";
         document.frmSearch.codeFunzBatchRE.value     = "<%=codeFunzBatchRE%>";
         document.frmSearch.soloPopolamento.value     = "<%=soloPopolamento%>";
         document.frmSearch.dataIniCiclo.value        = "<%=dataIniCiclo%>";
         document.frmSearch.cod_tipo_contr.value      = "<%=cod_tipo_contr%>";
         document.frmSearch.des_tipo_contr.value      = "<%=des_tipo_contr%>";
         opener.document.frmDati.button.value = "CONFERMA";
         opener.document.frmDati.numAcc.value=document.frmSearch.numAcc.value;
         
         if (document.frmSearch.numAcc.value=="0")
         {
              opener.document.frmDati.act.value="non_lanciare_batch";
         }
         else if (eval(document.frmSearch.numAcc.value)>0)
              {
                 opener.document.frmDati.act.value="lanciare_batch_Note_Repricing";
                 opener.document.frmDati.soloPopolamento.value=document.frmSearch.soloPopolamento.value; 
                 opener.document.frmDati.dataFineA.value=document.frmSearch.dataFineA.value;
                 opener.document.frmDati.dataSched.value=document.frmSearch.dataSched.value;
                 
                 if ( eval(document.frmSearch.numAccChiamante.value)>1 &&  eval(document.frmSearch.numAcc.value)>1)
                 {
                     for (var i=0; document.frmSearch.numAcc.value>i;i++)
                     {
                        opener.document.frmDati.CodeAccountRiep1[i].value=document.frmSearch.CodeAccountRiep1[i].value;
                     }  
                 }
                 if ( eval(document.frmSearch.numAccChiamante.value)>1 &&  eval(document.frmSearch.numAcc.value)==1)
                 {
                    if (String(document.frmSearch.CodeAccountRiep1.length)=="undefined")
                    {
                      opener.document.frmDati.CodeAccountRiep1[0].value=document.frmSearch.CodeAccountRiep1.value;
                    }
                    else
                    {
                      opener.document.frmDati.CodeAccountRiep1[0].value=document.frmSearch.CodeAccountRiep1[0].value;
                    }
                 }
                 
                 if ( eval(document.frmSearch.numAccChiamante.value)==1 &&  eval(document.frmSearch.numAcc.value)==1)
                 {
                    opener.document.frmDati.CodeAccountRiep1.value=document.frmSearch.CodeAccountRiep1.value;
                  }
              }    
         self.close();
         opener.dialogWin.returnFunc();
}

function Close()
{
    self.close();
    opener.dialogWin.returnFunc();
}
</SCRIPT>

</HEAD>
<BODY onload="setInitialValue();">
<form name="frmSearch" method="post" action="AccNoteCredSp.jsp">
<input type="hidden" name=dataIniCiclo     id= dataIniCiclo    value="<%=dataIniCiclo%>">  
<input type="hidden" name=cod_tipo_contr   id=cod_tipo_contr   value="<%=cod_tipo_contr%>">
<input type="hidden" name=des_tipo_contr   id=des_tipo_contr   value="<%=des_tipo_contr%>">
<input type="hidden" name=act              id=act              value="<%=act%>">
<input type="hidden" name=numAccChiamante  id=numAccChiamante  value="<%=numAccChiamante%>">
<input type="hidden" name=soloPopolamento  id=soloPopolamento  value= "<%=soloPopolamento%>">
<input type="hidden" name=dataFineA        id=dataFineA        value= "<%=dataFineA%>">
<input type="hidden" name=dataSched        id=dataSched        value= "<%=dataSched%>">
<input type="hidden" name="codeFunzBatch"        value="<%=codeFunzBatch%>">
<input type="hidden" name="codeFunzBatchNC"      value="<%=codeFunzBatchNC%>">
<input type="hidden" name="codeFunzBatchRE"      value="<%=codeFunzBatchRE%>">
<input type="hidden" name="typeLoad"             value="">
<input type="hidden" name="txtnumRec"            value="">
<input type="hidden" name="txtnumPag"            value="1">
<%
if (CodeAccountRiep1!=null)
 {
   for (int i=0; i<CodeAccountRiep1.length; i++)
   {%>
   <input type="hidden" name=CodeAccountRiep1 id=CodeAccountRiep1 value="<%=CodeAccountRiep1[i]%>">
 <%
 }
   if (typeLoad==0) 
   {%>
      <input type="hidden" name=numAcc id=numAcc value="<%=CodeAccountRiep1.length%>">
   <%}else{%>
      <input type="hidden" name=numAcc id=numAcc value="<%=numAcc%>">
<%}
}else{%>
   <input type="hidden" name=numAcc id=numAcc value="0">
 <%}%>


<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
     <img src="../images/titoloPagina.gif" alt="" border="0">
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;<%=testo1%>
                                                                         <BR>&nbsp;<%=testo2%>
                </td>
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
                      <td colspan='4' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="images/pixel.gif" width="1" height='2'></td>
                    </tr>
       
                   <tr>
                      <td width="10%">&nbsp;</td>
                      <td class="textB" width="40%" align="right">Risultati per pag.:</td>
                      <td class="text" width="25%" align="left">
                        <select class="text" name="numRec"  onchange="submitFrmSearch('1');">
                          <option class="text" value=5>5</option>
                          <option class="text" value=10>10</option>
                          <option class="text" value=20>20</option>
                          <option class="text" value=50>50</option>
                        </select>
                      </td>
                      <td width="25%">&nbsp;</td>
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
  <tr>
  	<td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;<%=testo3%></td>
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
    if ((account==null)||(account.size()==0))
    {%>
        <Script language='JavaScript'>abi_conferma=false;</Script>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="5" class="textB" align="center">No Record Found</td>
        </tr>
 <%}
   else
   {%>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white">&nbsp;</td>
                <td bgcolor="<%=StaticContext.bgColorFooter%>" class='textB'>&nbsp;</td>
                <td colspan='3' bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="white">&nbsp;</td>
              </tr>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white">&nbsp;</td>
                <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Descrizione Account</td>
                <td colspan='3' bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="white">&nbsp;</td>
              </tr>            
<%}%>
            </table>
            <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=account.size()%>">
                <pg:param name="typeLoad"            value="1"></pg:param>
                <pg:param name="cod_tipo_contr"      value="<%=cod_tipo_contr%>">  </pg:param>
                <pg:param name="codeFunzBatch"       value="<%=codeFunzBatch%>">   </pg:param>
                <pg:param name="codeFunzBatchNC"     value="<%=codeFunzBatchNC%>"> </pg:param>
                <pg:param name="codeFunzBatchRE"     value="<%=codeFunzBatchRE%>"> </pg:param>                
                <pg:param name="soloPopolamento"     value="<%=soloPopolamento%>"> </pg:param>
                <pg:param name="dataIniCiclo"        value="<%=dataIniCiclo%>">    </pg:param>
                <pg:param name="txtnumRec"           value="<%=index%>">           </pg:param>
                <pg:param name="numRec"              value="<%=strNumRec%>">       </pg:param>
                <pg:param name="act"                 value="<%=act%>">             </pg:param>
                <%
                String bgcolor="";
                String checked;  
                Object[] objs=account.toArray();
                //screma la lista e porta i dati nel caso di cambio pagina e, al conferma, alla pagina chiamante
                if ((act.equals("accountNoteCred") || act.equals("accountRepricing"))&& typeLoad==0)
                {
                  //carico il vettore vettAccount, contenente gli account selezionati
                  Vector vettAccount    = new Vector();   
                  for (int i=0; CodeAccountRiep1.length>i;i++)
                  {
                     vettAccount.add(CodeAccountRiep1[i]);
                  }

                  //carico objsScrem con gli account della POP-UP
                  Object[] objsScrem=account.toArray();
                  DatiCliBMP objScrem=null;
                  if (account.size()>0)
                  {
                  for (int i=0;i<account.size();i++)
                  {
                    objScrem=(DatiCliBMP)objsScrem[i];
                    String code_acc_elim=objScrem.getAccount();
                    int indice_da_elim=vettAccount.indexOf(code_acc_elim);
                    if (indice_da_elim!=-1)
                     {
                        vettAccount.remove(indice_da_elim);
                     }
                  }
                %>
                <script language='JavaScript'> document.frmSearch.numAcc.value=<%=vettAccount.size()%></script>
                <%
                Integer numAccInt=new Integer(vettAccount.size());
                numAcc=numAccInt.toString();
                  for (int i=0;i<vettAccount.size();i++)
                  {
                    CodeAccountRiep1[i]=vettAccount.elementAt(i).toString();
                    %>
                    <script language='JavaScript'>
                      if (document.frmSearch.numAccChiamante.value=="1")
                      {
                        document.frmSearch.CodeAccountRiep1.value= "<%=CodeAccountRiep1[0]%>";
                      }
                      else
                      {
                        document.frmSearch.CodeAccountRiep1[<%=i%>].value= "<%=CodeAccountRiep1[i]%>";
                      }
                    </script>
                    <%
                  }
                 } 
                }
                for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<account.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                {
                    DatiCliBMP obj=(DatiCliBMP)objs[i];
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;
                %>
                       <tr>                                                                                                      
                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>&nbsp;</td>
                        <td bgcolor='<%=bgcolor%>' name='des_account' class='text'>&nbsp;<%=obj.getDesc()%></td>
                        <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;</td>
                        <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;</td>
                        <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;</td>
                      </tr>
                <%    
                    }//for
                %>
                    <tr>
                      <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="3" height='2'></td>
                    </tr>

                 <%if (act.equals("accountNoteCred") || act.equals("accountRepricing"))
                 {
                 %>
                  <pg:param name="numAccChiamante"    value="<%=numAccChiamante%>"></pg:param>
                  <%if (CodeAccountRiep1!=null)
                   {
                    %>
                     <pg:param name="numAcc"    value="<%=numAcc%>"></pg:param>
                      <pg:param name="dataFineA"    value="<%=dataFineA%>"></pg:param>
                      <pg:param name="dataSched"    value="<%=dataSched%>"></pg:param>
                  <%}%>
                 <%}%>

                <pg:index>
                          <tr>
                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="5" class="text" align="center">
                                Risultati Pag.
                          <pg:prev>
                          
                                <%
                                pageUrl= pageUrl;
                                %>
                                <A HREF="<%=pageUrl%>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[<< Prev]</A>
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
                                  pageUrl= pageUrl;
                                %>
                                  <A HREF="<%=pageUrl%>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
                                <%
                                  } 
                                %>
                          </pg:pages>

                          <pg:next>
                                 <% pageUrl= pageUrl;%>
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
  <tr>
    <td colspan=5 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="1" height='3'></td>
  </tr>
  </table>
  <tr>
    <td colspan=5>  
       <sec:ShowButtons VectorName="vectorButton" />  
    </td>
  </tr> 
    </td>
  </tr>
</TABLE>   
</form>
</BODY>
</HTML>

