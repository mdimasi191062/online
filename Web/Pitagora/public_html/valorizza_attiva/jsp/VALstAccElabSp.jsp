<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"VALstAccElabSp.jsp")%>
</logtag:logData>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottonSp" />
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

String cod_contratto=request.getParameter("codiceTipoContratto");
if (cod_contratto==null) cod_contratto=request.getParameter("cod_contratto");
if (cod_contratto==null) cod_contratto=(String)session.getAttribute("cod_contratto");

String des_contratto=request.getParameter("hidDescTipoContratto");
if (des_contratto==null) des_contratto=request.getParameter("des_contratto");
if (des_contratto==null) des_contratto=(String)session.getAttribute("des_contratto");

String flagTipoContr = request.getParameter("flagTipoContr"); //060203
if (flagTipoContr!=null && flagTipoContr.equals("null")) flagTipoContr=null;   //060203
//System.out.println(">>>>>>>>>>>>>>>>flagTipoContr VALstAccElabSp :"+flagTipoContr);

String account=request.getParameter("account");
String descAccount=request.getParameter("descAccount");
String congela=request.getParameter("congela");
String congelaTutti=request.getParameter("congelaTutti");
String appomsg=request.getParameter("appomsg");
String errore=request.getParameter("errore");
String erroreSel=request.getParameter("erroreSel");
String nScartiSel=request.getParameter("nScartiSel");
String cicloFine=request.getParameter("cicloFine");
if(cicloFine==null) cicloFine="";
String cicloIni=request.getParameter("cicloIni");
if(cicloIni==null) cicloIni="";
String code_elab=request.getParameter("code_elab");
String code_stato=request.getParameter("code_stato");
String sizeLst=request.getParameter("sizeLst");
// Lettura del Numero di record per pagina (default 5)
int records_per_page=50;
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
BatchElem   datiBatch=null;

//RESET VARIABILE DEGLI STEPS X IL LANCIO BATCH
session.setAttribute("NUMBER_STEP_LANCIO_BATCH",new Integer(0));
%>

<EJB:useHome id="homeLstAccElab" type="com.ejbSTL.AccountElabSTLHome" location="AccountElabSTL" />
<EJB:useBean id="remoteLstAccElab" type="com.ejbSTL.AccountElabSTL" value="<%=homeLstAccElab.create()%>" scope="session"></EJB:useBean>
<EJB:useHome id="homeLstAccElab2" type="com.ejbBMP.CsvBMPHome" location="CsvBMP" />
<EJB:useHome id="homeLstAccElab3" type="com.ejbBMP.DoppioListinoBMPHome" location="DoppioListinoBMP" />
<EJB:useHome id="homeLstAccElab4" type="com.ejbBMP.ElaborBatchBMPHome" location="ElaborBatchBMP" />

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Verifica Valorizzazione Attiva
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
    {
      document.accElabForm.SelOf.checked=true;
    }
    else
        if(document.accElabForm.SelOf[1])
            document.accElabForm.SelOf[0].checked=true;
              
  }
  DisabilitaTasti();
 }
 
 function DisabilitaTasti()
 {
  if(document.accElabForm.code_stato.value=="SUCC" || 
     document.accElabForm.code_stato.value=="SUC2")
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

function ChangeSel(codice,descAcc,erroreSel,nrgScarti)
{

  document.accElabForm.account.value=codice;
  document.accElabForm.erroreSel.value=erroreSel;
  document.accElabForm.nScartiSel.value=nrgScarti;
  document.accElabForm.descAccount.value=descAcc.replace('Æ','\'');
  DisabilitaTasti();
}
function ONCONGELA_TUTTI()
{
   document.accElabForm.congelaTutti.value="true";
   if(document.accElabForm.AccountCode.length=="undefined")
      document.accElabForm.appomsg.value=document.accElabForm.AccountCode.value;
   else if(document.accElabForm.AccountCode[1])
   {
    document.accElabForm.appomsg.value=document.accElabForm.AccountCode[0].value;
    for (i=1;document.accElabForm.AccountCode.length>i; i++)
     {
       document.accElabForm.appomsg.value=document.accElabForm.appomsg.value+"$"+document.accElabForm.AccountCode[i].value;
      }
   }
    //MMM 30/10/02 inizio
      document.accElabForm.action="VALstAccElab2Sp.jsp" ;
    //MMM 30/10/02 fine
     document.accElabForm.submit();
 }
 
function ONCONGELA_SEL()
{
    document.accElabForm.appomsg.value=document.accElabForm.account.value;
    document.accElabForm.congela.value="true";
    //MMM 30/10/02 inizio
      document.accElabForm.action="VALstAccElab2Sp.jsp" ;
    //MMM 30/10/02 fine
    document.accElabForm.submit();
}

function ONVISUALIZZA_SCARTI()
{
     var codeSel=document.accElabForm.account.value;
     var accountSel=document.accElabForm.descAccount.value;
     var stringa="../../valorizza_attiva/jsp/ScartiSp.jsp?account="+codeSel+"&flagTipoContr=<%=flagTipoContr%>&cod_tipo_contr=<%=cod_contratto%>&des_tipo_contr=<%=des_contratto%>&descAccount="+accountSel;
     openDialog(stringa, 700, 400, handleReturnedValueDett);
 }

function VisualizzaAccount(contr)
{
     var controllo = contr;
     var stringa="../../valorizza_attiva/jsp/VisualAccountSp.jsp?controllo="+controllo+"&cod_contratto=<%=cod_contratto%>&code_elab=<%=code_elab%>&flagTipoContr=<%=flagTipoContr%>";
     openDialog(stringa, 700, 400, handleReturnedValueDett);

}
function handleReturnedValueDett()
{

}
</SCRIPT>

</HEAD>
<BODY onload="setInitialValue();">
<form name="accElabForm" method="post" action="VALstAccElabSp.jsp">
  <input type="hidden" name="des_contratto" id=des_contratto value="<%=des_contratto%>">
  <input type="hidden" name="cod_contratto"   id=cod_contratto  value="<%=cod_contratto%>">
  <input type="hidden" name="flagTipoContr"   id=flagTipoContr  value="<%=flagTipoContr%>"> <!--060203-->
  <input type="hidden" name="code_elab" value="<%=code_elab%>">
  <input type="hidden" name="code_stato" value="<%=code_stato%>">
  <input type="hidden" name="typeLoad1" value="<%=typeLoad1%>">
  <input type="hidden" name="txtnumRec1" value="">
  <input type="hidden" name="txtnumPag1" value="1">
<%
   clsInfoUser strUserName=(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
   String codUtente=strUserName.getUserName();

   if (typeLoad1!=0)
   {
     accElab = (Collection) session.getAttribute("accElab");
   }
   else
   {
      accElab = remoteLstAccElab.getLstAcc(code_elab);
   }
   if (accElab!=null && accElab.size()!=0)
   {
       session.setAttribute("accElab", accElab);
       Object[] ogg=accElab.toArray();
       LstAccElabElem acc=(LstAccElabElem)ogg[0];
       cicloIni=acc.getCicloIni();
       cicloFine=acc.getCicloFine();
       account=acc.getCodeAccount();
       descAccount=acc.getAccount();
       erroreSel=acc.getFlagErrore();
       nScartiSel=String.valueOf(acc.getScarti());
       sizeLst=String.valueOf(accElab.size());

    }

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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Verifica Valorizzazione Attiva: <%=des_contratto%></td>
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
                      <td colspan=2 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td width="25%" class="textB" align="left">&nbsp Inizio cliclo fatturazione:&nbsp;</td>
                      <td width="25%" class="textB" align="left">&nbsp Fine cliclo fatturazione:&nbsp;</td>
                    </tr>
                    <tr>
                      <td  width="25%" class="text">&nbsp <%=cicloIni%>
                       </td>
                      <td  width="25%" class="text">&nbsp <%=cicloFine%>
                       </td>
                    </tr>
                   </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>">
                    <tr>
                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <select class="text" name="numRec1" onchange="submitAccElabForm('1');">
                          <option class="text" value=50>50</option>
                          <option class="text" value=100>100</option>
                          <option class="text" value=150>150</option>
                          <option class="text" value=200>200</option>
                          <option class="text" value=250>250</option>
                          <option class="text" value=300>300</option>
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
                <td colspan=7 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
              </tr>
<%
    if ((accElab==null)||(accElab.size()==0))
    {
%>

              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan=7 class="textB" align="center">No Record Found</td>
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
               <td bgcolor='<%=StaticContext.bgColorFooter%>' class='textB' align="center">Scarti&nbsp;</td>
               <td bgcolor='<%=StaticContext.bgColorFooter%>' class='textB'>Stato&nbsp;&nbsp;</td>
               <td bgcolor='<%=StaticContext.bgColorFooter%>' class='textB'>Report</td>
              </tr>
<%
    }
%>

                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=accElab.size()%>">
                <pg:param name="des_contratto" value="<%=des_contratto%>"></pg:param>
                <pg:param name="typeLoad1" value="1"></pg:param>
                <pg:param name="cod_contratto" value="<%=cod_contratto%>"></pg:param>
                <pg:param name="flagTipoContr" value="<%=flagTipoContr%>"></pg:param><!--060203-->
                <pg:param name="cicloFine" value="<%=cicloFine%>"></pg:param>
                <pg:param name="cicloIni" value="<%=cicloIni%>"></pg:param>
                <pg:param name="code_elab" value="<%=code_elab%>"></pg:param>
                <pg:param name="account" value="<%=account%>"></pg:param>
                <pg:param name="code_stato" value="<%=code_stato%>"></pg:param>
                <pg:param name="txtnumRec1" value="<%=index%>"></pg:param>
                <pg:param name="numRec1" value="<%=strnumRec1%>"></pg:param>
                <pg:param name="sizeLst" value="<%=sizeLst%>"></pg:param>
                <pg:param name="descAccount" value="<%=descAccount%>"></pg:param>
                <%
                String bgcolor="";
                Object[] objs=accElab.toArray();
                errore="false";
                for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<accElab.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                    {
                    LstAccElabElem obj=(LstAccElabElem)objs[i];

                    if(obj.getFlagErrore().equals("D") || (obj.getFlagErroreReport() != null && obj.getFlagErroreReport().equals("D"))){
                      if ((i%2)==0)
                          bgcolor=StaticContext.bgColorRigaPariErroreTabella;
                      else
                          bgcolor=StaticContext.bgColorRigaDispariErroreTabella;
                    }
                    else
                    {
                      if ((i%2)==0)
                          bgcolor=StaticContext.bgColorRigaPariTabella;
                      else
                          bgcolor=StaticContext.bgColorRigaDispariTabella;
                    }

                %>
                       <tr>
                       <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>
                            <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name='SelOf' checked="true" value='<%=obj.getCodeAccount()%>' onclick="ChangeSel('<%=obj.getCodeAccount()%>','<%=obj.getAccount().replace('\'','Æ')%>','<%=obj.getFlagErrore()%>','<%=obj.getScarti()%>')";>
                        </td>
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getAccount()%></td>
                        <%if(obj.getDataIni()==null || obj.getDataIni().equals("") || obj.getDataIni().equals(" "))
                         {%>
                          <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;</td>
                       <%}
                         else
                         {%>
                         <td bgcolor='<%=bgcolor%>' class='text' ><%=obj.getDataIni()%></td>
                         <%}%>
                        <%if(obj.getDataFine()==null || obj.getDataFine().equals("") || obj.getDataFine().equals(" "))
                         {%>
                          <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;</td>
                       <%}
                         else
                         {%>
                         <td bgcolor='<%=bgcolor%>' class='text' ><%=obj.getDataFine()%></td>
                         <%}%>
                       <td bgcolor='<%=bgcolor%>' class='text' align="center"><%=obj.getScarti()%></td>
                       <%if(obj.getFlagErrore()!=null && obj.getFlagErrore().equals("E"))
                         {%>
                          <td bgcolor='<%=bgcolor%>' class='text'>In esecuzione</td>
                       <%}
                         else if(obj.getFlagErrore()!=null && obj.getFlagErrore().equals("D")){
                         %>
                         <td bgcolor='<%=bgcolor%>' class='text' align="left">Errore</td>
                         <%}
                         else if(obj.getFlagErrore()!=null && obj.getFlagErrore().equals("C")){
                         %>
                         <td bgcolor='<%=bgcolor%>' class='text' align="left">In chiusura</td>
                         <%}
                         else if(obj.getFlagErrore()!=null && obj.getFlagErrore().equals("I")){
                         %>
                         <td bgcolor='<%=bgcolor%>' class='text' align="left">Inizializzato</td>
                         <%}
                         else if(obj.getFlagErrore()!=null && obj.getFlagErrore().equals("P")){
                         %>
                         <td bgcolor='<%=bgcolor%>' class='text' align="left">In attesa</td>
                         <%}
                         else
                         {%>
                         <td bgcolor='<%=bgcolor%>' class='text' align="left">Terminata</td>
                         <%}

                         /*Report Special - inizio*/
                         if(obj.getFlagErrore()!=null && obj.getFlagErrore().equals("D")){
                         %>
                         <td bgcolor='<%=bgcolor%>' class='text' align="left">Errore in valorizzazione</td>
                         <%
                         }else if(obj.getFlagErroreReport()!=null && obj.getFlagErroreReport().equals("I")){
                         %>
                         <td bgcolor='<%=bgcolor%>' class='text' align="left">Inizializzato</td>
                         <%
                         }else if(obj.getFlagErroreReport()!=null && obj.getFlagErroreReport().equals("D")){
                         %>
                         <td bgcolor='<%=bgcolor%>' class='text' align="left">Errore</td>
                         <%
                         }else if(obj.getFlagErroreReport()!=null && obj.getFlagErroreReport().equals("E")){
                         %>
                         <td bgcolor='<%=bgcolor%>' class='text' align="left">In esecuzione</td>
                         <%
                         }else if(obj.getFlagErroreReport()!=null && obj.getFlagErroreReport().equals("P")){
                         %>
                         <td bgcolor='<%=bgcolor%>' class='text' align="left">In attesa</td>
                         <%
                         }else if(obj.getFlagErroreReport()!=null && obj.getFlagErroreReport().equals("C")){
                         %>
                         <td bgcolor='<%=bgcolor%>' class='text' align="left">In chiusura</td>
                         <%
                         }else if(obj.getFlagErroreReport()==null || obj.getFlagErroreReport().equals("")){
                         %>
                         <td bgcolor='<%=bgcolor%>' class='text' align="left">Non richiesto</td>
                         <%
                         }else{
                         %>
                         <td bgcolor='<%=bgcolor%>' class='text' align="left">Generato</td>
                         <%
                         }
                         /*Report Special - fine*/
                    }
                    for(int i=0;i<accElab.size();i++)
                    {
                      LstAccElabElem obj=(LstAccElabElem)objs[i];
                    %>
                     <input type="hidden" name='AccountCode' id='AccountCode'  value= '<%=obj.getCodeAccount()%>'>   
                     
                     <%
                        if(obj.getFlagErrore().equalsIgnoreCase("S") ||
                           obj.getFlagErrore().equalsIgnoreCase("D"))
                          errore="true";
                        
                    }
                %>

                    <tr>
                      <td colspan=7 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="3" height='2'></td>
                    </tr>

                <pg:index>
                          <tr>
                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan=7 class="text" align="center">
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
                  <td colspan=7 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
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
                        <input type="hidden" name=account        id=account      value="<%=account%>">
                        <input type="hidden" name=descAccount    id=descAccount  value="<%=descAccount%>">
                        <input type="hidden" name=congela        id=congela      value="<%=congela%>">
                        <input type="hidden" name=congelaTutti   id=congelaTutti value="<%=congelaTutti%>">
                        <input type="hidden" name="cicloFine" value="<%=cicloFine%>">
                        <input type="hidden" name="cicloIni"  value="<%=cicloIni%>">
                        <input type="hidden" name=errore        id=errore      value="<%=errore%>">
                        <input type="hidden" name=nScartiSel    id=nScartiSel      value="<%=nScartiSel%>">
                        <input type="hidden" name=erroreSel    id=erroreSel      value="<%=erroreSel%>">
                        <input type="hidden" name="sizeLst"   value="<%=sizeLst%>">
                        <input type="hidden" name=appomsg    id=appomsg      value="<%=appomsg%>">
</form>

</BODY>
</HTML>
