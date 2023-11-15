<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"NCLstAccElabSp.jsp")%>
</logtag:logData>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottonSp" />
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");
String cod_tipo_contr=request.getParameter("codiceTipoContratto");
if (cod_tipo_contr==null) cod_tipo_contr=request.getParameter("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("cod_tipo_contr");
String des_tipo_contr=request.getParameter("hidDescTipoContratto");
if (des_tipo_contr==null) des_tipo_contr=request.getParameter("des_tipo_contr");
if (des_tipo_contr==null) des_tipo_contr=(String)session.getAttribute("des_tipo_contr");
String flagTipoContr                   = request.getParameter("flagTipoContr");
if (flagTipoContr!=null && flagTipoContr.equals("null")) flagTipoContr=null;
String codeFunzBatch                   = request.getParameter("codeFunzBatch");
if (codeFunzBatch!=null && codeFunzBatch.equals("null")) codeFunzBatch=null;
String codeFunzBatchNC                   = request.getParameter("codeFunzBatchNC");
if (codeFunzBatchNC!=null && codeFunzBatchNC.equals("null")) codeFunzBatchNC=null;

String account=request.getParameter("account");
String descAccount=request.getParameter("descAccount");
String codeParam=request.getParameter("codeParam");
String congela=request.getParameter("congela");
String congelaTutti=request.getParameter("congelaTutti");
String appomsg=request.getParameter("appomsg");
String appoParam=request.getParameter("appoParam");
String errore=request.getParameter("errore");
String notaCredito=request.getParameter("notaCredito");
String erroreSel=request.getParameter("erroreSel");
String nScartiSel=request.getParameter("nScartiSel");
String numNCTrovate=request.getParameter("numNCTrovate");
String code_elabNC=request.getParameter("code_elabNC");
if (code_elabNC==null) code_elabNC=(String)session.getAttribute("code_elabNC");
String code_statoNC=request.getParameter("code_statoNC");
if (code_statoNC==null) code_statoNC=(String)session.getAttribute("code_statoNC"); 
String sizeLst=request.getParameter("sizeLst");
String rtrnAcc=request.getParameter("rtrnAcc");
     request.getSession().setAttribute("NUMBER_STEP_LANCIO_BATCH",new Integer(0));

// Lettura del Numero di record per pagina (default 5)
int records_per_page=5;
String strnumRec1 = request.getParameter("numRec1");
if (strnumRec1!=null)
  {
    Integer tmpnumRec1=new Integer(strnumRec1);
    records_per_page=tmpnumRec1.intValue();
  }
  // Lettura dell'indice Combo Numero Record
int index=0;
String strIndex = request.getParameter("txtnumRec1");
if (strIndex!=null && !strIndex.equals(""))
  {
   Integer tmpindext=new Integer(strIndex);
   index=tmpindext.intValue();
  }

// Lettura tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=1 Fare query (default)
// typeLoad=0 Variabile session
int typeLoad1=0;
int nrgCsv = 0;
int nrgPS = 0;
int nrgLst = 0;
int flagContratto = 0;
int nrgElab = 0;
String strtypeLoad1 = request.getParameter("typeLoad1");
if (strtypeLoad1!=null && !strtypeLoad1.equals(""))
  {
  
    Integer tmptypeLoad1=new Integer(strtypeLoad1);
    typeLoad1=tmptypeLoad1.intValue();
    
  }

// Vettore contenente risultati query
Collection  accElab;
%>
<EJB:useHome id="homeLstAccElab" type="com.ejbSTL.AccountElabSTLHome" location="AccountElabSTL" />
<EJB:useBean id="remoteLstAccElab" type="com.ejbSTL.AccountElabSTL" value="<%=homeLstAccElab.create()%>" scope="session"></EJB:useBean>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Verifica Nota di Credito
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>
IExplorer =document.all?true:false;
Navigator =document.layers?true:false;

function submitAccElabForm(typeLoad1)
{
  document.accElabForm.txtnumRec1.value=document.accElabForm.numRec1.selectedIndex;
  document.accElabForm.typeLoad1.value=typeLoad1;
  document.accElabForm.submit();
}
function setInitialValue()
{
//Setta il numero di record  
  eval('document.accElabForm.numRec1.options[<%=index%>].selected=true');
//Setta il primo elemento della lista

 if (String(document.accElabForm.SelOf)!="undefined")
 {
    if (document.accElabForm.SelOf.length=="undefined")
          document.accElabForm.SelOf.checked=true;
    else
        if(document.accElabForm.SelOf[1])
           document.accElabForm.SelOf[0].checked=true;
           
  }
  DisabilitaTasti();
 }
 function DisabilitaTasti()
 {
  if(document.accElabForm.code_statoNC.value=="SUCC")
  {
    if(document.accElabForm.errore.value!="true")
       Enable(document.accElabForm.CONGELA_TUTTI);
    else
       Disable(document.accElabForm.CONGELA_TUTTI);
    if(document.accElabForm.erroreSel.value=="N")
       Enable(document.accElabForm.CONGELA_SEL);
    else
       Disable(document.accElabForm.CONGELA_SEL);
      
  }
  else
  {
     Disable(document.accElabForm.CONGELA_TUTTI);
     Disable(document.accElabForm.CONGELA_SEL);
     
   }
  if(document.accElabForm.erroreSel.value=="S" || document.accElabForm.nScartiSel.value!="0")
    Enable(document.accElabForm.VISUALIZZA_SCARTI);
  else 
    Disable(document.accElabForm.VISUALIZZA_SCARTI);

}

function ChangeSel(codice,descAcc,erroreSel,nrgScarti,numNC,param)
{

  document.accElabForm.account.value=codice;
  document.accElabForm.erroreSel.value=erroreSel;
  document.accElabForm.nScartiSel.value=nrgScarti;
  document.accElabForm.numNCTrovate.value=numNC;
  document.accElabForm.descAccount.value=descAcc.replace('Æ','\'');
  document.accElabForm.codeParam.value=param;
  DisabilitaTasti();
}
function ONCONGELA_TUTTI()
{

 if (document.accElabForm.CONGELA_TUTTI.disabled) 
    window.alert('Non è possibile congelare account relativi ad elaborazioni non terminate correttamente.'); 
  else 
  {
   document.accElabForm.congelaTutti.value="true";
   //new
      document.accElabForm.action = "CongelaNCSp.jsp";
			//EnableAllControls(document.accElabForm);
				
      //new
   document.accElabForm.submit(); 
  }
 }
function ONCONGELA_SEL()
{
 if (document.accElabForm.CONGELA_SEL.disabled) 
    window.alert('Non è possibile congelare account relativi ad elaborazioni non terminate correttamente.'); 
  else 
  {
    document.accElabForm.appomsg.value=document.accElabForm.account.value;
    document.accElabForm.appoParam.value=document.accElabForm.codeParam.value;
    document.accElabForm.congela.value="true";
    //new
      document.accElabForm.action = "CongelaNCSp.jsp";
			//EnableAllControls(document.accElabForm);
				
      //new
    document.accElabForm.submit(); 
  }
}

function ONVISUALIZZA_SCARTI()
{
 if (document.accElabForm.VISUALIZZA_SCARTI.disabled) 
    window.alert('Non è possibile visualizzare gli scarti.'); 
  else 
  {
     var codeSel=document.accElabForm.account.value;
     var accountSel=document.accElabForm.descAccount.value;
     var verifica="verificaNC";
     var stringa="../../valorizza_attiva/jsp/ScartiSp.jsp?account="+codeSel+"&cod_tipo_contr=<%=cod_tipo_contr%>&des_tipo_contr=<%=des_tipo_contr%>&flagTipoContr=<%=flagTipoContr%>&descAccount="+accountSel+"&chiamante="+verifica;
     openDialog(stringa, 700, 400, handleReturnedValueDett);
   }
 }

function handleReturnedValueDett()
{}
</SCRIPT>

</HEAD>
<BODY onload="setInitialValue();">
<form name="accElabForm" method="get" action="NCLstAccElabSp.jsp">
                        <input class="textB" type="hidden" name="des_tipo_contr" value="<%=des_tipo_contr%>">
                        <input type="hidden" name=cod_tipo_contr    id=cod_tipo_contr      value="<%=cod_tipo_contr%>">
                        <input class="textB" type="hidden" name="code_elabNC" value="<%=code_elabNC%>">
                        <input class="textB" type="hidden" name="code_statoNC" value="<%=code_statoNC%>">
                        <input class="textB" type="hidden" name="typeLoad1" value="<%=typeLoad1%>">
                        <input class="textB" type="hidden" name="txtnumRec1" value="">
                        <input class="textB" type="hidden" name="txtnumPag1" value="1">
                        <input class="textB" type="hidden" name="rtrnAcc" value="<%=rtrnAcc%>">
                        <input type="hidden" name=flagTipoContr           id=flagTipoContr            value="<%=flagTipoContr%>">  
                        <input type="hidden" name=codeFunzBatch           id=codeFunzBatch            value="<%=codeFunzBatch%>">
                        <input type="hidden" name=codeFunzBatchNC         id=codeFunzBatchNC          value="<%=codeFunzBatchNC%>">
<%
    if (typeLoad1!=0)
   {
     accElab = (Collection) session.getAttribute("accElab");
   
   }
   else
   {
   
   
       accElab = remoteLstAccElab.getLstAccNC(code_elabNC, cod_tipo_contr);
       
    }
    if (accElab!=null && accElab.size()!=0)
    {
       session.setAttribute("accElab", accElab);
       Object[] ogg=accElab.toArray();
       LstAccElabElem acc=(LstAccElabElem)ogg[0];
       account=acc.getCodeAccount();
       descAccount=acc.getAccount();
       erroreSel=acc.getFlagErrore();
       nScartiSel=String.valueOf(acc.getScarti());
       numNCTrovate=String.valueOf(acc.getNumNC());
       sizeLst=String.valueOf(accElab.size());
       codeParam=acc.getCodeParam();
    }%>

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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Verifica Nota di Credito: <%=des_tipo_contr%></td>
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
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista account elaborati</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                
                <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>">
                 <tr>
                      <td colspan=2>&nbsp;</td>
                      </tr>
                    <tr>
                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <select class="text" name="numRec1" onchange="submitAccElabForm('1');">
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
    if ((accElab==null)||(accElab.size()==0))
    {
%>

              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan=6 class="textB" align="center">No Record Found</td>
              </tr>
<%
 }
    else
    {
%>
              <tr>
               <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white">&nbsp;</td>
               <td bgcolor='<%=StaticContext.bgColorFooter%>' class='textB'>Account</td>
               <td bgcolor='<%=StaticContext.bgColorFooter%>' class='textB'>Inizio periodo fatt.&nbsp;</td>
               <td bgcolor='<%=StaticContext.bgColorFooter%>' class='textB'>Fine periodo fatt.&nbsp;</td>
               <td bgcolor='<%=StaticContext.bgColorFooter%>' class='textB' align='right'>Scarti&nbsp;</td>
               <td bgcolor='<%=StaticContext.bgColorFooter%>' class='textB' align="center">Errore bloc.</td>
              </tr>
<%
    }
%>

                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=accElab.size()%>">
                <pg:param name="des_tipo_contr" value="<%=des_tipo_contr%>"></pg:param>
                <pg:param name="typeLoad1" value="1"></pg:param>
                <pg:param name="cod_tipo_contr" value="<%=cod_tipo_contr%>"></pg:param>
                <pg:param name="code_elabNC" value="<%=code_elabNC%>"></pg:param>
                <pg:param name="account" value="<%=account%>"></pg:param>
                <pg:param name="code_statoNC" value="<%=code_statoNC%>"></pg:param>
                <pg:param name="txtnumRec1" value="<%=index%>"></pg:param>
                <pg:param name="numRec1" value="<%=strnumRec1%>"></pg:param>
                <pg:param name="sizeLst" value="<%=sizeLst%>"></pg:param>
                <pg:param name="descAccount" value="<%=descAccount%>"></pg:param>
                <pg:param name="errore" value="<%=errore%>"></pg:param>
                 <pg:param name="notaCredito" value="<%=notaCredito%>"></pg:param>
                 <pg:param name="numNCTrovate" value="<%=numNCTrovate%>"></pg:param>
                 <pg:param name="nScartiSel" value="<%=nScartiSel%>"></pg:param>
                 <pg:param name="erroreSel" value="<%=erroreSel%>"></pg:param>
                 <pg:param name="appomsg" value="<%=appomsg%>"></pg:param>
                 <pg:param name="appomsg" value="<%=appoParam%>"></pg:param>
                 <pg:param name="rtrnAcc" value="<%=rtrnAcc%>"></pg:param>
                 <pg:param name="codeParam" value="<%=codeParam%>"></pg:param>
                 <pg:param name="flagTipoContr" value="<%=flagTipoContr%>"></pg:param>
                 <pg:param name="codeFunzBatch" value="<%=codeFunzBatch%>"></pg:param>
                 <pg:param name="codeFunzBatchNC" value="<%=codeFunzBatchNC%>"></pg:param>
                <%
                String bgcolor="";
                Object[] objs=accElab.toArray();
                errore="false"; 
                notaCredito=""; 
                for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<accElab.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                    {
                    LstAccElabElem obj=(LstAccElabElem)objs[i];
                    
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;

                %>
                       <tr>
                       <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>
                            <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name='SelOf' checked="true" value='<%=obj.getCodeAccount()%>' onclick="ChangeSel('<%=obj.getCodeAccount()%>','<%=obj.getAccount().replace('\'','Æ')%>','<%=obj.getFlagErrore()%>','<%=obj.getScarti()%>','<%=obj.getNumNC()%>','<%=obj.getCodeParam()%>')";>
                        </td>   
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getAccount()%></td>
                         <%
                          if(obj.getDataIni()==null || obj.getDataIni().equals("") || obj.getDataIni().equals(" "))
                          {%>
                            <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;</td>
                        <%}
                          else
                          {%>
                            <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getDataIni()%></td>
                          <%}%>
                          <%if(obj.getDataFine()==null || obj.getDataFine().equals("") || obj.getDataFine().equals(" "))                          
                          {%>
                            <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;</td>
                        <%}
                          else
                          {%>
                            <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getDataFine()%></td>
                          <%}%>

                        <td bgcolor='<%=bgcolor%>' class='text' align='right'><%=obj.getScarti()%></td>
                        <%
                        
                          if(obj.getFlagErrore()==null || obj.getFlagErrore().equals("") || obj.getFlagErrore().equals(" "))
                          {
                          %>
                          <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;</td>
                          <%
                          }
                          else
                          {
                          %>
                        <td bgcolor='<%=bgcolor%>' class='text' align="center"><%=obj.getFlagErrore()%></td>
                        <%
                        }
                     }
                    for(int i=0;i<accElab.size();i++)
                    {
                      LstAccElabElem obj=(LstAccElabElem)objs[i];
                      if(obj.getNumNC()==0)
                          notaCredito=notaCredito+"0";
                        else  notaCredito=notaCredito+"-";
                        if(obj.getFlagErrore().equalsIgnoreCase("S"))
                          errore="true";
                      
                    }
                    //System.out.println("notaCredito"+notaCredito);
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
                        <input type="hidden" name=account    id=account      value="<%=account%>">
                        <input type="hidden" name=descAccount    id=descAccount      value="<%=descAccount%>">
                        <input type="hidden" name=codeParam    id=codeParam      value="<%=codeParam%>">
                        <input type="hidden" name=congela    id=congela      value=<%=congela%>>
                        <input type="hidden" name=congelaTutti    id=congelaTutti      value=<%=congelaTutti%>>
                        <input type="hidden" name=errore    id=errore      value=<%=errore%>>
                        <input type="hidden" name=notaCredito    id=notaCredito      value="<%=notaCredito%>">
                        <input type="hidden" name=numNCTrovate    id=numNCTrovate      value=<%=numNCTrovate%>>
                        <input type="hidden" name=nScartiSel    id=nScartiSel      value=<%=nScartiSel%>>
                        <input type="hidden" name=erroreSel    id=erroreSel      value=<%=erroreSel%>>
                        <input class="textB" type="hidden" name="sizeLst" value="<%=sizeLst%>">
                        <input type="hidden" name=appomsg    id=appomsg      value="<%=appomsg%>">
                         <input type="hidden" name=appoParam    id=appoParam      value="<%=appoParam%>">
</form>

</BODY>
</HTML>
