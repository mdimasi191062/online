<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>

<sec:ChkUserAuth RedirectEnabled="true" VectorName="bot_lista" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3007,"Oggetti di Fatturazione")%>
<%=StaticMessages.getMessage(3006,"ListaOf.jsp")%>
</logtag:logData>
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");
  
//String cod_contratto=request.getParameter("cod_contratto");
String cod_contratto=request.getParameter("codiceTipoContratto");
if (cod_contratto==null) cod_contratto=request.getParameter("cod_contratto");
if (cod_contratto==null) cod_contratto=(String)session.getAttribute("cod_contratto");

//String des_contratto=request.getParameter("des_contratto");
String des_contratto=request.getParameter("hidDescTipoContratto");
if (des_contratto==null) des_contratto=request.getParameter("des_contratto");
if (des_contratto==null) des_contratto=(String)session.getAttribute("des_contratto");
String flag_sys=request.getParameter("hidFlagSys");
if (flag_sys==null) flag_sys=request.getParameter("flag_sys");
if (flag_sys==null) flag_sys=(String)session.getAttribute("flag_sys");

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

// Vettore contenente risultati query
Collection oggFatts;
%>
<EJB:useHome id="home" type="com.ejbBMP.OggFattBMPHome" location="OggFattBMP" />
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Lista Oggetti di Fatturazione
</TITLE>
<SCRIPT LANGUAGE='Javascript'>

var codOggFattSel="";

function ChangeSel(codice)
{
  codOggFattSel=codice;
}


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

  /*
  if (String(document.ListaOf.SelOf)!="undefined")
  {
    window.alert(document.ListaOf.SelOf.length);
    
    if ((document.ListaOf.SelOf.length=="undefined") ||
        (document.ListaOf.SelOf.length=="undefined"))
      document.ListaOf.SelOf.checked=true;
    else
      document.ListaOf.SelOf[0].checked=true;
  }
 */  
}

function CancelMe()
{
  self.close();
	return false;
}

function ONNUOVO()
{
    document.ListaOf.act.value="nuovo";
    document.ListaOf.action="OggettoFatt.jsp";
    document.ListaOf.submit();  
    //return false; 
}

function ONAGGIORNA()
{
    document.ListaOf.act.value="aggiorna";
    document.ListaOf.action="OggettoFatt.jsp";
    document.ListaOf.submit();  
    //return false; 
}
function ONDISATTIVA()
{
    document.ListaOf.act.value="disattiva";    
    document.ListaOf.action="OggettoFatt.jsp";
    document.ListaOf.submit();  
    //return false; 
}
</SCRIPT>

</HEAD>
<BODY onload="setInitialValue();">

<%
   if (typeLoad!=0)
   {
     oggFatts = (Collection) session.getAttribute("oggFatts");
    //System.out.println("Non fatta query");
   }
   else
   {
      oggFatts=null; 
      if ((request.getParameter("disattivi")!=null)&&
         (request.getParameter("disattivi").equals("yes")))
          {
          if (flag_sys.equals("S"))
            oggFatts = home.findAll(cod_contratto, false);
          else
            oggFatts = home.findAllCla(false);
          }
      else
          {
          if (flag_sys.equals("S"))
            oggFatts = home.findAll(cod_contratto, true);
          else
            oggFatts = home.findAllCla(true);
          }

      if (oggFatts!=null)
       session.setAttribute("oggFatts", oggFatts);
    
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
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="get" action="ListaOf.jsp">

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/oggettiFatturazioneTitolo.gif" alt="" border="0"></td>
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista Oggetti di Fatturazione</td>
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
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Filtro di Ricerca</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                    <tr>
                      <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td width="50%" class="textB" align="right">Mostra gli oggetti di fatturazione disattivi:&nbsp;</td>
                      <td  width="20%" class="text">
                         <input type=checkbox name=disattivi value="yes" <%=checkedfiltra%>>
                      </td>
                      <td width="30%" rowspan='2' class="textB" valign="center" align="center">
                        <input class="textB" type="button" name="Esegui" value="Esegui" onclick="submitFrmSearch('0');">
                        <input class="textB" type="hidden" name="cod_contratto" value="<%=cod_contratto%>">
                        <input class="textB" type="hidden" name="des_contratto" value="<%=des_contratto%>">
                        <input class="textB" type="hidden" name="flag_sys" value="<%=flag_sys%>">
                        <input class="textB" type="hidden" name="typeLoad" value="">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                      </td>
                    </tr>
                    <tr>
                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <select class="text" name="numRec" onchange="submitFrmSearch('1');">
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
        <tr>
          <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
			</td>
		</tr>
  </table>
</form>
<form  name="ListaOf" id="ListaOf" method="get" action='ListaOf.jsp'>
<input type="hidden" name=cod_contratto id=cod_contratto value=<%=cod_contratto%>>
<input type="hidden" name=des_contratto id=des_contratto value="<%=des_contratto%>">
<input type="hidden" name=flag_sys      id=flag_sys      value=<%=flag_sys%>>
<input type="hidden" name=act id=act value="">
  <tr>
  	<td>
      <table align=center width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;<%=des_contratto%></td>
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
    if ((oggFatts==null)||(oggFatts.size()==0))
    {
%>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="5" class="textB" align="center">No Record Found</td>
              </tr>
<%
    }
    else
    {
%>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white">&nbsp;</td>
                <td bgcolor="<%=StaticContext.bgColorTabellaForm%>" class='textB'>Classe 0ggetto di Fatturazione</td>
                <td bgcolor="<%=StaticContext.bgColorTabellaForm%>" class='textB'>Oggetto di Fatturazione</td>
                <td bgcolor="<%=StaticContext.bgColorTabellaForm%>" class='textB'>Data Inizio</td>
                <td bgcolor="<%=StaticContext.bgColorTabellaForm%>" class='textB'>Data Fine</td>
              </tr>
<%
    }
%>

                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=oggFatts.size()%>">
                <pg:param name="typeLoad" value="1"></pg:param>
                <pg:param name="cod_contratto" value="<%=cod_contratto%>"></pg:param>
                <pg:param name="des_contratto" value="<%=des_contratto%>"></pg:param>
                <pg:param name="flag_sys" value="<%=flag_sys%>"></pg:param>
                <pg:param name="disattivi" value="<%=checkvalue%>"></pg:param>
                <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>

                <%
                String bgcolor="";
                String checked;  
                Object[] objs=oggFatts.toArray();

                boolean first_rec=true;
                
                for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<oggFatts.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                    {
                    OggFattBMP obj=(OggFattBMP)objs[i];
                    
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;

                %>
                       <tr>
                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>
                            <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name='SelOf' value='<%=obj.getCodeOggFatt()%>' <%if (first_rec) {out.print("checked");first_rec=false;}%> onclick=ChangeSel('<%=obj.getCodeOggFatt()%>')>
                        </td>
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getDescClasseOf()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getDescOggFatt()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getDataIni()%></td>
                <%    
                        if (obj.getDataFine()==""){ 
                %>
                        <td bgcolor="<%=bgcolor%>" class="text">&nbsp;</td>
                <%    
                       } else{
                %>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getDataFine()%></td>
            
                      </tr>
                <%    
                      }
                    }
                %>
                    <tr>
                      <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/pixel.gif" width="3" height='2'></td>
                    </tr>

                <pg:index>
                          <tr>
                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="5" class="text" align="center">
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
                  <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                </tr>
        
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td colspan=5 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td colspan=5>

<%
if ((oggFatts==null)||(oggFatts.size()==0))
    {
%>
      <sec:ShowButtons PageName="NUOVO_LISTA_OF" />
<%  
    }
else
    {
%>
    <sec:ShowButtons VectorName="bot_lista" />
<%
    }
%>
    </td>
  </tr>
</TABLE>   
</form>
</BODY>
</HTML>
