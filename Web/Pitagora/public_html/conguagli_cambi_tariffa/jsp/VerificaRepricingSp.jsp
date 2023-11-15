<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottonSp" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"VerificaRepricingSp.jsp")%>
</logtag:logData>

<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

String cod_tipo_contr=request.getParameter("codiceTipoContratto");
if (cod_tipo_contr==null) cod_tipo_contr=request.getParameter("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("cod_tipo_contr");

String des_tipo_contr=request.getParameter("hidDescTipoContratto");
if (des_tipo_contr==null) des_tipo_contr=request.getParameter("des_tipo_contr");
if (des_tipo_contr==null) des_tipo_contr=(String)session.getAttribute("des_tipo_contr");

String code_elab=request.getParameter("code_elab");
if (code_elab==null) code_elab=(String)session.getAttribute("code_elab");
String sizeLst=request.getParameter("sizeLst");
String code_stato=request.getParameter("code_stato");
if (code_stato==null) code_stato=(String)session.getAttribute("code_stato");   
//04-01-03 viti
String flagTipoContr                   = request.getParameter("flagTipoContr");
if (flagTipoContr!=null && flagTipoContr.equals("null")) flagTipoContr=null;
String codeFunzBatch                   = request.getParameter("codeFunzBatch");
if (codeFunzBatch!=null && codeFunzBatch.equals("null")) codeFunzBatch=null;
String codeFunzBatchRepr                   = request.getParameter("codeFunzBatchRepr");
if (codeFunzBatchRepr!=null && codeFunzBatchRepr.equals("null")) codeFunzBatchRepr=null;
BatchElem  datiBatch=null;

String size=request.getParameter("size");
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

// Lettura tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=1 Fare query (default)
// typeLoad=0 Variabile session
int typeLoad=0;

String strtypeLoad = request.getParameter("typeLoad");
if (strtypeLoad!=null && !strtypeLoad.equals(""))
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  
  }

// Vettore contenente risultati query
Collection oggAbort;
%>
<EJB:useHome id="homeRepricing" type="com.ejbBMP.ElaborBatchBMPHome" location="ElaborBatchBMP" />

<EJB:useHome id="homeBatch" type="com.ejbSTL.BatchSTLHome" location="BatchSTL" />
<EJB:useBean id="remoteBatch" type="com.ejbSTL.BatchSTL" value="<%=homeBatch.create()%>" scope="session"></EJB:useBean>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Verifica Repricing
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>
var codeFunzBatch   = "<%=codeFunzBatch%>";
var flagTipoContr   = "<%=flagTipoContr%>";
function submitVerificaForm(typeLoad)
{
  document.verificaForm.txtnumRec.value=document.verificaForm.numRec.selectedIndex;
  document.verificaForm.typeLoad.value=typeLoad;
  document.verificaForm.submit();
}
function setInitialValue()
{
//Setta il numero di record  
  eval('document.verificaForm.numRec.options[<%=index%>].selected=true');
//Setta il primo elemento della lista
  if (String(document.verificaForm.SelOf)!="undefined")
  {
    if (document.verificaForm.SelOf.length=="undefined")
      document.verificaForm.SelOf.checked=true;
    else
        if(document.verificaForm.SelOf[1])
           document.verificaForm.SelOf[0].checked=true;
    else  document.verificaForm.SelOf.checked=true;     
  }
  if(document.verificaForm.size.value=="true")
     Enable(document.verificaForm.SELEZIONA);
  else
     Disable(document.verificaForm.SELEZIONA);
 }

function ChangeSel(codice, codeStato)
{

  document.verificaForm.code_elab.value=codice;
  document.verificaForm.code_stato.value=codeStato;
  
}
function ONSELEZIONA()
{
    document.verificaForm.action="CongelaRepricingSp.jsp" ;
    document.verificaForm.submit();
}

function ONAGGIORNA()
{
    document.verificaForm.typeLoad.value="0";
    document.verificaForm.action="VerificaRepricingSp.jsp" ;
    document.verificaForm.submit();  
}
</SCRIPT>

</HEAD>
<BODY onload="setInitialValue();">

<%

   if (typeLoad!=0)
   {
     oggAbort = (Collection) session.getAttribute("oggAbort");
     
   }
   else
   {
       datiBatch=remoteBatch.getCodeFunzFlag(cod_tipo_contr,"VR",null,"S");
       if (datiBatch!=null)
            codeFunzBatchRepr=  datiBatch.getCodeFunz();
       datiBatch=remoteBatch.getCodeFunzFlag(cod_tipo_contr,"CR",null,"S");
       if (datiBatch!=null)
       {
           flagTipoContr=  (new Integer(datiBatch.getFlagTipoContr())).toString();
           codeFunzBatch = datiBatch.getCodeFunz();
       }    
       oggAbort = homeRepricing.findLstVerRepricing(codeFunzBatchRepr,cod_tipo_contr);
    }
    if (oggAbort!=null && oggAbort.size()!=0)
    {    
        session.setAttribute("oggAbort", oggAbort);
        Object[] ogg=oggAbort.toArray();
        ElaborBatchBMP elab=(ElaborBatchBMP)ogg[0];
        code_stato=elab.getCodeStato();
        if(code_stato!=null)
            session.setAttribute("code_stato",code_stato);
        code_elab=elab.getCodeElab();
        if(code_elab!=null)
            session.setAttribute("code_elab",code_elab);
        sizeLst=String.valueOf(oggAbort.size());
    }
     else sizeLst="0";
%>

<form name="verificaForm" method="get" action="VerificaRepricingSp.jsp">
                        <input class="textB" type="hidden" name="cod_tipo_contr" value="<%=cod_tipo_contr%>">
                        <input class="textB" type="hidden" name="des_tipo_contr" value="<%=des_tipo_contr%>">
                        <input class="textB" type="hidden" name="code_elab" value="<%=code_elab%>">
                        <input class="textB" type="hidden" name="code_stato" value="<%=code_stato%>">
                        <input class="textB" type="hidden" name="typeLoad" value="<%=typeLoad%>">
                        <input class="textB" type="hidden" name="size" value="<%=size%>">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                        <input class="textB" type="hidden" name="sizeLst" value="<%=sizeLst%>">
                        <input type="hidden" name=flagTipoContr           id=flagTipoContr            value="<%=flagTipoContr%>">  
                        <input type="hidden" name=codeFunzBatch           id=codeFunzBatch            value="<%=codeFunzBatch%>">
                        <input type="hidden" name=codeFunzBatchRepr           id=codeFunzBatchRepr            value="<%=codeFunzBatchRepr%>">
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Verifica Repricing: <%=des_tipo_contr%></td>
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
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dati Elaborazione</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>">
                    <tr>
                      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td class="textB" align="left">&nbsp; &nbsp;</td>
                    </tr>
                    
                   </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>">
                    <tr>
                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <select class="text" name="numRec" onchange="submitVerificaForm('1');">
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
                <td colspan=6 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
              </tr>
<%
    if ((oggAbort==null)||(oggAbort.size()==0))
    {
%>
      <SCRIPT LANGUAGE='Javascript'>
       document.verificaForm.size.value="false";
       </SCRIPT>

              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan=6 class="textB" align="center">No Record Found</td>
              </tr>
<%
 }
    else
    {
%>
   <SCRIPT LANGUAGE='Javascript'>
       document.verificaForm.size.value="true";
   </SCRIPT>
              <tr>
               <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white">&nbsp;</td>
               <td bgcolor='<%=StaticContext.bgColorFooter%>' class='textB'>Codice&nbsp;&nbsp;&nbsp;</td>
               <td bgcolor='<%=StaticContext.bgColorFooter%>' class='textB'>Data/Ora inizio elab.&nbsp;&nbsp;&nbsp;</td>
               <td bgcolor='<%=StaticContext.bgColorFooter%>' class='textB'>Data/Ora fine elab.&nbsp;&nbsp;&nbsp;</td>
               <td bgcolor='<%=StaticContext.bgColorFooter%>' class='textB'>Stato</td>
               <td bgcolor='<%=StaticContext.bgColorFooter%>' class='textB' align=right>Nr. P/S processati</td>
              </tr>
<%
    }
%>
               
                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=oggAbort.size()%>">
                <pg:param name="typeLoad" value="1"></pg:param>
                <pg:param name="cod_tipo_contr" value="<%=cod_tipo_contr%>"></pg:param>
                <pg:param name="des_tipo_contr" value="<%=des_tipo_contr%>"></pg:param>
                <pg:param name="code_elab" value="<%=code_elab%>"></pg:param>
                <pg:param name="code_stato" value="<%=code_stato%>"></pg:param>
                <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
                <pg:param name="size" value="<%=size%>"></pg:param>
                <pg:param name="sizeLst" value="<%=sizeLst%>"></pg:param>
                <pg:param name="flagTipoContr" value="<%=flagTipoContr%>"></pg:param>
                <pg:param name="codeFunzBatchRepr" value="<%=codeFunzBatchRepr%>"></pg:param>
                <pg:param name="codeFunzBatch" value="<%=codeFunzBatch%>"></pg:param>
                <%
                String bgcolor="";
                Object[] objs=oggAbort.toArray();
                

                for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<oggAbort.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                    {
                    ElaborBatchBMP obj=(ElaborBatchBMP)objs[i];
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;

                %>

                       <tr>
                       <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>
                           
                            <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio' checked="true" name='SelOf' value='<%=obj.getCodeElab()%>' onclick=ChangeSel('<%=obj.getCodeElab()%>','<%=obj.getCodeStato()%>')>
                        </td>   
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getCodeElab()%></td>
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getDataIni()%></td>
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getDataFine()%></td>
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getStato()%></td>
                        <td bgcolor='<%=bgcolor%>' class='text' align=right><%=obj.getNPS()%></td>
    
                    <%    
                     
                    }
                   
                %>    

                    <tr>
                      <td colspan=6 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="3" height='2'></td>
                    </tr>

                <pg:index>
                          <tr>
                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan=6 class="text" align="center">
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
                  <td colspan=6 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
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

