<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  isModal="true" VectorName="bottoni" />
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

String cod_tar=request.getParameter("cod_tar");
String cod_ogg_fatt=request.getParameter("cod_ogg_fatt");
String cod_causale=request.getParameter("cod_causale");
//modifica opzioni 18-02-03 inizio
String cod_opzione=request.getParameter("cod_opzione");
//modifica opzioni 18-02-03 fine

String cod_tipo_contr=request.getParameter("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("cod_tipo_contr");
String des_tipo_contr=request.getParameter("des_tipo_contr");
if (des_tipo_contr==null) des_tipo_contr=(String)session.getAttribute("des_tipo_contr");

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

// Lettura tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=1 Fare query (default)
// typeLoad=0 Variabile session
int typeLoad=0;
String strtypeLoad = request.getParameter("typeLoad");
if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }

//  contenente risultati query
Collection tariffe;
%>
<EJB:useHome id="homeTariffa" type="com.ejbBMP.TariffaBMPHome" location="TariffaBMP" />
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Dettaglio Tariffa
</TITLE>
<SCRIPT LANGUAGE='Javascript'>

var codOggFattSel="";
var descOggFattSel="";




function submitFrmSearch(typeLoad)
{
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.typeLoad.value=typeLoad;
  document.frmSearch.submit();
}

function setInitialValue()
{
//Setta il numero di record  
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
//Setta il primo elemento della lista
  if (String(document.frmSearch.SelOf)!="undefined")
  {
    if (document.frmSearch.SelOf.lenght=="undefined")
      document.frmSearch.SelOf.checked=true;
    else
      document.frmSearch.SelOf[0].checked=true;
  }
}

function ONANNULLA()
{
  self.close();
}

function CancelMe()
{
  self.close();
	return false;
}
</SCRIPT>

</HEAD>
<BODY onload="setInitialValue();">
<%
  

   if (typeLoad!=0)
   {
     tariffe = (Collection) session.getAttribute("tariffe");
   }
   else
   {
     
      if (cod_causale=="")
          cod_causale=null;
      //modifica opzioni 18-02-03 inizio    
            if (cod_opzione=="")
          cod_opzione=null;
      //modifica opzioni 18-02-03 fine      

      tariffe = homeTariffa.findDettaglio(cod_tar, cod_ogg_fatt, cod_causale, cod_opzione);
      
      if (tariffe!=null)
        
        session.setAttribute("tariffe", tariffe);
   }

  String checkedfiltra="";
  String checkvalue="";
  if ((request.getParameter("disattivi")!=null)&&
       (request.getParameter("disattivi").equals("yes")))
       {
       checkedfiltra="checked";
       checkvalue="yes";
       } 

%>
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="GET" action="DettaglioTariffaSp.jsp">

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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista Dettaglio Tariffa</td>
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
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                    <tr>
                      <td colspan='6' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                   
                    <tr>
                      <td width="25%">&nbsp;</td>
                      <td class="textB" width="25%" colspan='3' align="center">Risultati per pag.:&nbsp;</td>
                        <input class="textB" type="hidden" name="cod_tipo_contr" value="<%=cod_tipo_contr%>">
                        <input class="textB" type="hidden" name="des_tipo_contr" value="<%=des_tipo_contr%>">
                        <input class="textB" type="hidden" name="typeLoad" value="">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                        <td class="text" width="25%" align="left">
                        <select class="text" name="numRec" onchange="submitFrmSearch('1');">
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

<input type="hidden" name="cod_tipo_contr" id="cod_tipo_contr" value="<%=cod_tipo_contr%>">
<input type="hidden" name="des_tipo_contr" id="des_tipo_contr" value="<%=des_tipo_contr%>">


<input type="hidden" name=cod_tar id=cod_tar value=<%=cod_tar%>>
<input type="hidden" name=cod_ogg_fatt id=cod_ogg_fatt value=<%=cod_ogg_fatt%>>
<input type="hidden" name=cod_causale id=cod_causale value=<%=cod_causale%>>
<!--modifica opzioni 18-02-03 inizio-->
<input type="hidden" name=cod_opzione id=cod_opzione value=<%=cod_opzione%>>
<!--modifica opzioni 18-02-03 fine-->



<input type="hidden" name=act id=act value="">
  <tr>
  	<td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp; Risultato di ricerca</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan='7' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
              </tr>
<%
    if ((tariffe==null)||(tariffe.size()==0))
    {
%>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="7" class="textB" align="center">No Record Found</td>
              </tr>
<%
    }
    else
    {
%>
              <tr>
                <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Min Cl. Sc.</td>
                <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Max Cl. Sc.</td>
                <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Importo Tariffa</td>
                <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Tipo Imp.</td>
                <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Data Inizio</td>
                <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Data Fine</td>
                <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Data Creaz</td>
              </tr>            
<%
    }
%>

                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=tariffe.size()%>">
                <pg:param name="typeLoad" value="1"></pg:param>
                <pg:param name="cod_tar" value="<%=cod_tar%>"></pg:param>
                <pg:param name="cod_ogg_fatt" value="<%=cod_ogg_fatt%>"></pg:param>
                <pg:param name="cod_causale" value="<%=cod_causale%>"></pg:param>
                <pg:param name="cod_opzione" value="<%=cod_opzione%>"></pg:param>                
                <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>

                <%
                String bgcolor="";
                String checked;  
                Object[] objs=tariffe.toArray();

                for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<tariffe.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                {
                    TariffaBMP obj=(TariffaBMP)objs[i];
                    
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;



                %>
                       <tr>                                                                                                      
                        <!--MMM 24/10/02 CustomNumberFormat.setToCurrencyFormat(obj.get***().toString(),4)-->
                        <td bgcolor='<%=bgcolor%>' class='text'><%=CustomNumberFormat.setToNumberFormat(obj.getImpMinSps().toString(),4,false,true)%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=CustomNumberFormat.setToNumberFormat(obj.getImpMaxSps().toString(),4,false,true)%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=CustomNumberFormat.setToNumberFormat(obj.getImpTar().toString(),4,false,true)%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getFlgMat()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getDataIniTar()%></td>
                <%
                  if (obj.getDataFineTar()=="")
                  {
                %>
                        <td bgcolor="<%=bgcolor%>" class="text">&nbsp;</td>
                <%
                  }else
                  {
                %>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getDataFineTar()%></td>
                <%        
                  }           
                %>  
                        
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getDataCreazTar()%></td>  

                        
                      </tr>
                <%    
                }//for
                %>
                    <tr>
                      <td colspan='7' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/pixel.gif" width="3" height='2'></td>
                    </tr>

                <pg:index>
                          <tr>
                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="7" class="text" align="center">
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
                  <td colspan='7' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                </tr>
        
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td colspan=7 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td colspan=7>
    <sec:ShowButtons VectorName="bottoni" />
    </td>
  </tr>
</TABLE>
    </td>
  </tr>
  </TABLE>
</form>
</BODY>
</HTML>
