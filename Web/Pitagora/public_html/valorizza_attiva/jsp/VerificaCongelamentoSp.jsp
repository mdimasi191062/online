<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.utl.BatchElem,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>

<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottonSp" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"VerificaCongelamentoSp.jsp")%>
</logtag:logData>

<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

String strTipoReport = Misc.nh(request.getParameter("tipoReport"));
if(strTipoReport.equals(""))
  strTipoReport = "1006";

String cod_contratto=request.getParameter("codiceTipoContratto");
if (cod_contratto==null) cod_contratto=request.getParameter("cod_contratto");
if (cod_contratto==null) cod_contratto=(String)session.getAttribute("cod_contratto");
//04-01-03 viti
String flagTipoContr                   = request.getParameter("flagTipoContr");
if (flagTipoContr!=null && flagTipoContr.equals("null")) flagTipoContr=null;
String codeFunzBatch                   = request.getParameter("codeFunzBatch");
if (codeFunzBatch!=null && codeFunzBatch.equals("null")) codeFunzBatch=null;
String codeFunzBatchVA                   = request.getParameter("codeFunzBatchVA");
if (codeFunzBatchVA!=null && codeFunzBatchVA.equals("null")) codeFunzBatchVA=null;
BatchElem  datiBatch=null;

String des_contratto=request.getParameter("hidDescTipoContratto");
if (des_contratto==null) des_contratto=request.getParameter("des_contratto");
if (des_contratto==null) des_contratto=(String)session.getAttribute("des_contratto");
String sizeLst=request.getParameter("sizeLst");
String code_elab=request.getParameter("code_elab");
String code_stato=request.getParameter("code_stato");
   
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
<EJB:useHome id="homeVA" type="com.ejbBMP.ElaborBatchBMPHome" location="ElaborBatchBMP" />
<EJB:useHome id="homeBatch" type="com.ejbSTL.BatchSTLHome" location="BatchSTL" />
<EJB:useBean id="remoteBatch" type="com.ejbSTL.BatchSTL" value="<%=homeBatch.create()%>" scope="session"></EJB:useBean>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Verifica Congelamento
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>


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
  }
  if(document.verificaForm.size.value=="true")
     Enable(document.verificaForm.ACCOUNT_ELAB);
  else
     Disable(document.verificaForm.ACCOUNT_ELAB);
 }

function ChangeSel(codice, codeStato)
{
  document.verificaForm.code_elab.value=codice;
  document.verificaForm.code_stato.value=codeStato;
}

function ONACCOUNT_ELAB()
{
    document.verificaForm.action="VerificaCongelamentoLstAccSp.jsp" ;
    document.verificaForm.submit();
}

function ONAGGIORNA(){
    document.verificaForm.typeLoad.value="0";
    document.verificaForm.submit();  
}

function setTipoReportStart(){
  if(document.verificaForm.tipoReport.value == '1006'){
    document.verificaForm.txtRadio0.checked = true;
    document.verificaForm.txtRadio1.checked = false;
    document.verificaForm.tipoReport.value = "1006";
  }else if(document.verificaForm.tipoReport.value == '27')
  {
    document.verificaForm.txtRadio0.checked = false;
    document.verificaForm.txtRadio1.checked = true;
    document.verificaForm.txtRadio2.checked = false;
    document.verificaForm.tipoReport.value = "27";
  }
  else
   {
    document.verificaForm.txtRadio0.checked = false;
    document.verificaForm.txtRadio1.checked = false;
    document.verificaForm.txtRadio2.checked = true;
    document.verificaForm.tipoReport.value = "55";
  }
}

function setTipoReport(tipoReport){
  if (tipoReport == '1006'){
    document.verificaForm.txtRadio0.checked = true;
    document.verificaForm.txtRadio1.checked = false;
    document.verificaForm.txtRadio2.checked = false;
    document.verificaForm.tipoReport.value = "1006";
  }else if (tipoReport == '27') {
    document.verificaForm.txtRadio1.checked = true;
    document.verificaForm.txtRadio0.checked = false;
    document.verificaForm.txtRadio2.checked = false;
    document.verificaForm.tipoReport.value = "27";
  }else {
    
    document.verificaForm.txtRadio2.checked = true;
    document.verificaForm.txtRadio1.checked = false;
    document.verificaForm.txtRadio0.checked = false;
    document.verificaForm.tipoReport.value = "55";
  }
  submitVerificaForm('0');
  
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
    //04-01-03 viti
    
       datiBatch=remoteBatch.getCodeFunzFlag(cod_contratto,"VA",null,"S");
       if (datiBatch!=null)
           codeFunzBatchVA=  datiBatch.getCodeFunz();
           
       datiBatch=remoteBatch.getCodeFunzFlag(cod_contratto,"CA",null,"S");
       if (datiBatch!=null)
       {
          flagTipoContr=  (new Integer(datiBatch.getFlagTipoContr())).toString();
          codeFunzBatch = datiBatch.getCodeFunz();
       }   
    codeFunzBatchVA = strTipoReport;
    oggAbort = homeVA.findLstVer(codeFunzBatchVA,cod_contratto);
    }
    if (oggAbort!=null && oggAbort.size()!=0)
    {
        session.setAttribute("oggAbort", oggAbort);
        Object[] ogg=oggAbort.toArray();
        ElaborBatchBMP elab=(ElaborBatchBMP)ogg[0];
        code_stato=elab.getCodeStato();
        code_elab=elab.getCodeElab();   
        sizeLst=String.valueOf(oggAbort.size());
    }
    else sizeLst="0";
%>

<form name="verificaForm" method="get" action="VerificaCongelamentoSp.jsp">
  <input class="textB" type="hidden" name="cod_contratto" value="<%=cod_contratto%>">
  <input class="textB" type="hidden" name=des_contratto    id=des_contratto value="<%=des_contratto%>">
  <input class="textB" type="hidden" name="code_elab" value="<%=code_elab%>">
  <input class="textB" type="hidden" name="code_stato" value="<%=code_stato%>">
  <input class="textB" type="hidden" name="typeLoad" value="<%=typeLoad%>">
  <input class="textB" type="hidden" name="size" value="<%=size%>">
  <input class="textB" type="hidden" name="txtnumRec" value="">
  <input class="textB" type="hidden" name="txtnumPag" value="1">
  <input type="hidden" name=flagTipoContr   id=flagTipoContr   value="<%=flagTipoContr%>">  
  <input type="hidden" name=codeFunzBatch   id=codeFunzBatch   value="<%=codeFunzBatch%>">
  <input type="hidden" name=codeFunzBatchVA id=codeFunzBatchVA value="<%=codeFunzBatchVA%>">

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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Verifica Congelamento</td>
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
                      <td width="50%" class="textB" align="left">&nbsp; Verifica Batch Congelamento : &nbsp;</td>
                    </tr>
                    <tr>
                      <td  width="50%" class="text">&nbsp;&nbsp;&nbsp;<%=des_contratto%>
                      </td>
                    </tr>
                  </table>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>">
                    <tr>
                      <td class="textB" align="left">
                        <table>
                          <tr>
                            <td class="textB" align="left">&nbsp;Congelamento Valorizzazione:</td>
                            <td  width="10%" class="text" align="left">
                              <input type='radio' name='txtRadio0' value='1006' onclick='setTipoReport(this.value);'>
                            </td>
                            <td class="textB" align="left">Congelamento Repricing:</td>
                            <td  width="10%" class="text" align="left">
                              <input type='radio' name='txtRadio1' value='27' onclick='setTipoReport(this.value);'>
                            </td>
                            <td class="textB" align="left">Congelamento Fatt./N.C. Manuale:</td>
                            <td  width="10%" class="text" align="left">
                              <input type='radio' name='txtRadio2' value='55' onclick='setTipoReport(this.value);'>
                            </td>
                            <input type="hidden" name="tipoReport" value="<%=strTipoReport%>">
                          </tr>
                        </table>
                      </td>
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
              </tr>
<%
    }
%>

                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=oggAbort.size()%>">
                <pg:param name="typeLoad" value="1"></pg:param>
                <pg:param name="cod_contratto" value="<%=cod_contratto%>"></pg:param>
                <pg:param name="des_contratto" value="<%=des_contratto%>"></pg:param>
                <pg:param name="code_elab" value="<%=code_elab%>"></pg:param>
                <pg:param name="code_stato" value="<%=code_stato%>"></pg:param>
                <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
                <pg:param name="size" value="<%=size%>"></pg:param>
                <pg:param name="sizeLst" value="<%=sizeLst%>"></pg:param>
                <pg:param name="flagTipoContr" value="<%=flagTipoContr%>"></pg:param>
                <pg:param name="codeFunzBatchVA" value="<%=codeFunzBatchVA%>"></pg:param>
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
                        <% if (obj.getDataFine().equals("")){%>
                            <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;</td>
                        <%}else{%>   
                            <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getDataFine()%></td>
                        <%}%>   
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getStato()%></td>
    
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
<input class="textB" type="hidden" name="sizeLst" value="<%=sizeLst%>">
</form>

<SCRIPT LANGUAGE="JavaScript">
    setTipoReportStart();
</SCRIPT>

</BODY>
</HTML>

