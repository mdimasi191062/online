<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"VerificaCongelamentoLstAccSp.jsp")%>
</logtag:logData>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottonSp" />

<%

response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

String cod_contratto=Misc.nh(request.getParameter("cod_contratto"));
String code_elab=Misc.nh(request.getParameter("code_elab"));
String desc_contratto= Misc.nh(request.getParameter("des_contratto"));
int typeLoad1=0;


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


String strtypeLoad1 = request.getParameter("typeLoad1");
if (strtypeLoad1!=null && !strtypeLoad1.equals(""))
{
  Integer tmptypeLoad1=new Integer(strtypeLoad1);
  typeLoad1=tmptypeLoad1.intValue();
}

// Vettore contenente risultati query
Collection  accElab;
BatchElem   datiBatch=null;

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
Verifica Congelamento
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>

function setInitialValue()
{
  //Setta il numero di record
  eval('document.accElabForm.numRec1.options[<%=index%>].selected=true');
}

function ONAGGIORNA(){
    document.accElabForm.typeLoad1.value="0";
    document.accElabForm.submit();  
}

function submitAccElabForm(typeLoad1)
{
  document.accElabForm.txtnumRec1.value=document.accElabForm.numRec1.selectedIndex;
  document.accElabForm.typeLoad1.value=typeLoad1;
  document.accElabForm.submit();
}
</SCRIPT>

</HEAD>
<BODY onload="setInitialValue()">
<form name="accElabForm" method="post" action="VerificaCongelamentoLstAccSp.jsp">
<%
  clsInfoUser strUserName=(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);

  String codUtente = "";
  String codeParam = "";
  String dataIni = "";
  String dataFine = "";
  String account = "";
  String descAccount = "";
  String stato = "";
  String errore = "";
  
  if (typeLoad1!=0)
  {
    accElab = (Collection) session.getAttribute("accElab");
  }
  else
  {
    accElab = remoteLstAccElab.getLstAccCongSpecial(code_elab);
  }
  if (accElab!=null && accElab.size()!=0)
  {
    session.setAttribute("accElab", accElab);
    Object[] ogg=accElab.toArray();
    LstAccElabElem acc=(LstAccElabElem)ogg[0];
    codeParam=acc.getCodeParam();
    dataIni=acc.getCicloIni();
    dataFine=acc.getCicloFine();
    account=acc.getCodeAccount();
    descAccount=acc.getAccount();
    stato=acc.getFlagErrore();
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Verifica Congelamento: <%=desc_contratto%></td>
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
               <td bgcolor='<%=StaticContext.bgColorFooter%>' class='textB'>Data Inizio&nbsp;</td>
               <td bgcolor='<%=StaticContext.bgColorFooter%>' class='textB'>Data Fine&nbsp;</td>
               <td bgcolor='<%=StaticContext.bgColorFooter%>' class='textB'>Stato&nbsp;&nbsp;</td>
              </tr>
<%
    }
%>

                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=accElab.size()%>">
                <pg:param name="des_contratto" value="<%=desc_contratto%>"></pg:param>
                <pg:param name="typeLoad1" value="1"></pg:param>
                <pg:param name="cod_contratto" value="<%=cod_contratto%>"></pg:param>
                <pg:param name="dataFine" value="<%=dataFine%>"></pg:param>
                <pg:param name="dataIni" value="<%=dataIni%>"></pg:param>
                <pg:param name="code_elab" value="<%=code_elab%>"></pg:param>
                <pg:param name="account" value="<%=account%>"></pg:param>
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

                  if(obj.getFlagErrore().equals("D")){
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
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>&nbsp;</td>
                    <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getAccount()%></td>
                    <%if(obj.getDataIni()==null || obj.getDataIni().equals("") || obj.getDataIni().equals(" ")){
                    %>
                      <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;</td>
                    <%
                    }else{
                    %>
                      <td bgcolor='<%=bgcolor%>' class='text' ><%=obj.getDataIni()%></td>
                    <%}
                    if(obj.getDataFine()==null || obj.getDataFine().equals("") || obj.getDataFine().equals(" ")){
                    %>
                      <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;</td>
                    <%
                    }else{
                    %>
                      <td bgcolor='<%=bgcolor%>' class='text' ><%=obj.getDataFine()%></td>
                    <%
                    }

                    if(obj.getFlagErrore()!=null && obj.getFlagErrore().equals("R")){
                    %>
                      <td bgcolor='<%=bgcolor%>' class='text'>In esecuzione</td>
                    <%
                    }else if(obj.getFlagErrore()!=null && obj.getFlagErrore().equals("D")){
                    %>
                      <td bgcolor='<%=bgcolor%>' class='text' align="left">Errore</td>
                    <%
                    }else if(obj.getFlagErrore()!=null && obj.getFlagErrore().equals("I")){
                    %>
                      <td bgcolor='<%=bgcolor%>' class='text' align="left">Inizializzato</td>
                    <%
                    }else if(obj.getFlagErrore()!=null && obj.getFlagErrore().equals("C")){
                    %>
                      <td bgcolor='<%=bgcolor%>' class='text' align="left">In chiusura</td>
                    <%
                    }
                    else
                    {
                    %>
                      <td bgcolor='<%=bgcolor%>' class='text' align="left">Terminata</td>
                    <%
                    }

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
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
      <sec:ShowButtons VectorName="bottonSp" />
    </td>
  </tr>
</TABLE>

  <input type="hidden" name="des_contratto" id=des_contratto value="<%=desc_contratto%>">
  <input type="hidden" name="cod_contratto" id=cod_contratto value="<%=cod_contratto%>">
  <input type="hidden" name="code_elab"     id=code_elab     value="<%=code_elab%>">
  <input type="hidden" name="typeLoad1" value="<%=typeLoad1%>">
  <input type="hidden" name="txtnumRec1" value="">
  <input type="hidden" name="txtnumPag1" value="1">
</form>

</BODY>
</HTML>
