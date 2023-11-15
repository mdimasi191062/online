<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottonSp" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"ScartiSp.jsp")%>
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

String account=request.getParameter("account");
String descAccount=request.getParameter("descAccount");
if (descAccount!=null) descAccount=descAccount.replace('#',' ');
String chiamante=request.getParameter("chiamante");

String flagTipoContr = request.getParameter("flagTipoContr");//060203

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
String strtypeLoad = request.getParameter("typeLoad");
if (strtypeLoad!=null && !strtypeLoad.equals(""))
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  
  }
// Lettura tipo caricamento per fare query o utilizzare variabili Session
// Vettore contenente risultati query
Collection oggScarti;
String desc_chiamante="";
String folder="";
String codFunz="";

if(chiamante!=null && chiamante.equals("verificaNC"))
{
   desc_chiamante="Verifica Nota di Credito: "+des_tipo_contr;
   folder="nota_credito";
   if(flagTipoContr!=null && flagTipoContr.equals("0")) //if(cod_tipo_contr.equals(StaticContext.ULL)) 060203
       codFunz=StaticContext.INFR_BATCH_NOTE_CREDITO_SP;
   else
      codFunz=StaticContext.INFR_BATCH_NOTE_CRED_XDSL;
}   
else 
if (chiamante!=null && chiamante.equals("verificaRepricing"))
{
   desc_chiamante="Verifica Repricing: "+des_tipo_contr;
   folder="conguagli_cambi_tariffa";
   codFunz=StaticContext.INFR_BATCH_CAMBI_TARIFFA_SP;
}   
else 
{
   desc_chiamante="Verifica Valorizzazione Attiva: "+des_tipo_contr;
   folder="valorizza_attiva";
   if(flagTipoContr!=null && flagTipoContr.equals("0"))
      codFunz=StaticContext.INFR_BATCH_VAL_ATTIVA_SP;
   else
      codFunz=StaticContext.INFR_BATCH_VAL_ATTIVA_XDSL;
}

%>
<EJB:useHome id="homeScarti" type="com.ejbBMP.ScartiBMPHome" location="ScartiBMP" />
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
<%=desc_chiamante%>
</TITLE>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>
IExplorer =document.all?true:false;
Navigator =document.layers?true:false;

function submitScartiForm(typeLoad)
{
  document.scartiForm.txtnumRec.value=document.scartiForm.numRec.selectedIndex;
  document.scartiForm.typeLoad.value=typeLoad;
  document.scartiForm.submit();
}
function ONANNULLA(){
  window.close();
	return false;
}
function setInitialValue()
{
//Setta il numero di record  
eval('document.scartiForm.numRec.options[<%=index%>].selected=true');
}
</SCRIPT>

</HEAD>
<BODY onload="setInitialValue();">
<%
   if (typeLoad!=0)
   {
     oggScarti = (Collection) session.getAttribute("oggScarti");
   }
   else
   {
      oggScarti = homeScarti.findScartiLst(account, codFunz,cod_tipo_contr);
   }
 
   if (oggScarti!=null && oggScarti.size()!=0)
       session.setAttribute("oggScarti", oggScarti);
   
%>

<form name="scartiForm" method="get" action="ScartiSp.jsp">
                        <input class="textB" type="hidden" name="cod_tipo_contr" value="<%=cod_tipo_contr%>">
                        <input class="textB" type="hidden" name="des_tipo_contr" value="<%=des_tipo_contr%>">                        
                        <input class="textB" type="hidden" name="flagTipoContr" value="<%=flagTipoContr%>"> <!--060203-->
                        <input class="textB" type="hidden" name="account" value="<%=account%>">
                        <input class="textB" type="hidden" name="descAccount" value="<%=descAccount%>">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                        <input class="textB" type="hidden" name="typeLoad" value="<%=typeLoad%>">
                        <input class="textB" type="hidden" name="chiamante" value="<%=chiamante%>">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
     <td><img src="../../<%=folder%>/images/titoloPagina.gif" alt="" border="0"></td>
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
                 <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;<%=desc_chiamante%></td>
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
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Riepilogo scarti</td>
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
                      <td width="50%" class="textB" align="left">&nbsp Account:&nbsp;</td>
                    </tr>
                    <tr>
                      <td  width="50%" class="text">&nbsp &nbsp <%=descAccount%>
                       </td>
                    </tr>
                   </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>">
                    <tr>
                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <select class="text" name="numRec" onchange="submitScartiForm('1');">
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
                <td colspan=4 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
              </tr>
<%
    if ((oggScarti==null)||(oggScarti.size()==0))
    {
%>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan=4 class="textB" align="center">No Record Found</td>
              </tr>
<%
 }
    else
    {
%>

              <tr>
               <td bgcolor="<%=StaticContext.bgColorFooter%>" class='textB'>Tipo&nbsp;</td>
               <td bgcolor="<%=StaticContext.bgColorFooter%>" class='textB'>Motivo</td>
               <td bgcolor="<%=StaticContext.bgColorFooter%>" class='textB'>Oggetto&nbsp;</td>
               <td bgcolor="<%=StaticContext.bgColorFooter%>" class='textB'>Codice</td>
          </tr>
<%
    }
%>

                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=oggScarti.size()%>">
                <pg:param name="typeLoad" value="1"></pg:param>
                <pg:param name="account" value="<%=account%>"></pg:param>
                <pg:param name="cod_tipo_contr" value="<%=cod_tipo_contr%>"></pg:param>
                <pg:param name="des_tipo_contr" value="<%=des_tipo_contr%>"></pg:param>
                <pg:param name="flagTipoContr" value="<%=flagTipoContr%>"></pg:param> <!--060203-->
                <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
                <pg:param name="descAccount" value="<%=descAccount%>"></pg:param>
                <pg:param name="chiamante" value="<%=chiamante%>"></pg:param>
                <%
                String bgcolor="";
                Object[] objs=oggScarti.toArray();

                for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<oggScarti.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                    {
                    ScartiBMP obj=(ScartiBMP)objs[i];
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;

                %>

                       <tr>
                       
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getTipo()%></td>
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getMotivo()%></td>
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getOggetto()%></td>
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getCodice()%></td>
              
    
                    <%    
                     
                    }
                %>    

                    <tr>
                      <td colspan=4 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="3" height='2'></td>
                    </tr>

                <pg:index>
                          <tr>
                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan=4 class="text" align="center">
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
                  <td colspan=4 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
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
