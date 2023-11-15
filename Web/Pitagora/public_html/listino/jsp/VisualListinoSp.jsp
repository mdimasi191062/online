<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.usr.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*" %>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="BOTTONI" />
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3007,"Visualizzazione Listino")%>
<%=StaticMessages.getMessage(3006,"VisualListinoSp.jsp")%>
</logtag:logData>
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");
//INIZIO
//String descTipoContratto=request.getParameter("descTipoContratto");
   String descTipoContratto=request.getParameter("hidDescTipoContratto");
if (descTipoContratto==null) descTipoContratto=request.getParameter("descTipoContratto");
if (descTipoContratto==null) descTipoContratto=(String)session.getAttribute("hidDescTipoContratto");

//String code_contratto=request.getParameter("code_contratto");
   String codeTipoContratto=request.getParameter("codeTipoContratto");
if (codeTipoContratto==null) codeTipoContratto=request.getParameter("codiceTipoContratto");
if (codeTipoContratto==null) codeTipoContratto=(String)session.getAttribute("codiceTipoContratto");

//String Storico=request.getParameter("Storico");
//if (Storico==null) Storico=request.getParameter("Storico");
//if (Storico==null) Storico=(String)session.getAttribute("Storico");

String action=request.getParameter("act");
Collection Listini; //per il caricamento della lista degli stati elab batch
//FINE

// Lettura dell'indice Combo Numero Record
int index = 0;
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
int typeLoad = 0;
String strtypeLoad = request.getParameter("typeLoad");
if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }

%>
<EJB:useHome id="TariffaHome" type="com.ejbBMP.TariffaBMPHome" location="TariffaBMP" />
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Listino Tariffe
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>
IExplorer = document.all?true:false;
Navigator = document.layers?true:false;

var SelCodeContratto = "";
var SelDescContratto = "";

//var codeTipoContratto = "";

function submitFrmSearch(typeLoad)
{
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.typeLoad.value=typeLoad;
  submitME();
}

function submitME()
{
  Enable(document.frmSearch.codeTipoContratto);
  Enable(document.frmSearch.descTipoContratto);

  document.frmSearch.submit();
}

function setInitialValue()
{
//Setta il numero di record  
eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
//Setta il primo elemento della lista
  if (String(document.frmSearch.SelCodeContratto)!="undefined")
  {
    if (document.frmSearch.SelCodeContratto.lenght=="undefined")
    {
      document.frmSearch.SelCodeContratto.checked=true; 
    }
    else
    {
      if (document.frmSearch.SelCodeContratto[1])
      {
         document.frmSearch.SelCodeContratto[0].checked=true;
         SelCodeContratto = document.frmSearch.SelCodeContratto[0].value;
         codeContratto = document.frmSearch.SelCodeContratto[0].value;
         SelDescContratto = document.frmSearch.SelDescContratto[0].value;
         descContratto = document.frmSearch.SelDescContratto[0].value;
      }
      else   
      {
         SelCodeContratto = document.frmSearch.SelCodeContratto.value;
         SelDescContratto = document.frmSearch.SelDescContratto.value; 
         codeContratto = document.frmSearch.SelCodeContratto.value;         
         descContratto = document.frmSearch.SelDescContratto.value; 
      }
    }
  }

//Imposta lo stato dei bottoni e della checkbox
    Disable(document.frmSearch.disattivi);     
    Disable(document.frmSearch.STAMPA);
  if (String(document.frmSearch.SelCodeContratto)!="undefined")
  {
    if (document.frmSearch.SelCodeContratto.lenght != "undefined")
    if (document.frmSearch.SelCodeContratto[1])
    {
        if (document.frmSearch.SelCodeContratto[0].value != null &&
            document.frmSearch.SelCodeContratto[0].value != "")     
        {
             Enable(document.frmSearch.disattivi);
             Enable(document.frmSearch.STAMPA);
        }    
     }
     else
     {
        if (document.frmSearch.SelCodeContratto.value != null &&
            document.frmSearch.SelCodeContratto.value != "")     
        {
             Enable(document.frmSearch.disattivi);
             Enable(document.frmSearch.STAMPA);
        }    
     }
  }
  if (SelCodeContratto == "0")
  {
      codeContratto = "0";
      descContratto = "Standard";
  }
  checkit();
}

 function ChangeSel(SelCodeContratto,SelDescContratto)
 {
  codeContratto = SelCodeContratto;
  descContratto = SelDescContratto;        
 }

 function blocca()
 {
 document.frmSearch.STAMPA.focus(); 
 alert('campo non editabile');
 }

 function ONSTAMPA()
 {
    if (String(document.frmSearch.SelCodeContratto) != "undefined")
    {    
        codeTipoContratto = document.frmSearch.codeTipoContratto.value;
        descTipoContratto = document.frmSearch.descTipoContratto.value;    
        //descContratto = document.frmSearch.descContratto.value;     
        //Storico = document.frmSearch.Storico.value;

        if (document.frmSearch.disattivi.checked)
           Storico = 1;
        else   
           Storico = 0;
        var TariffaListinoSp = "../../listino/jsp/TariffaListinoSp.jsp?codeTipoContratto="+codeTipoContratto+"&descTipoContratto="+descTipoContratto+"&codeContratto="+codeContratto+"&Storico="+Storico+"&descContratto="+descContratto;    
        openDialog(TariffaListinoSp, 800, 600, handleReturnedValueStampa, "resizable");
        //handleReturnedValueStampa();
    }    
 }

 function handleReturnedValueStampa()
 {
  //window.alert("ritorno dalla VisualListinoSp");
 }

 function checkit()
 {
 /*if (document.frmSearch.Storico.checked == false)
     document.frmSearch.Storico.value = 0;
 else
     document.frmSearch.Storico.value = 1;
 Storico = document.frmSearch.Storico.value;*/
 }
 
</SCRIPT>
</HEAD>
<BODY onload="setInitialValue();">
<%
   if (typeLoad!=0)
   {
     Listini = (Collection) session.getAttribute("Listini");
   }
   else
   {
      //Listini = TariffaHome.findListini(codeTipoContratto);
      Listini = TariffaHome.findListiniClus(codeTipoContratto);
      if (Listini!=null)
          session.setAttribute("Listini", Listini);
   }       

      String checkedfiltra="";
      String checkvalue="";
      if ((request.getParameter("disattivi")!=null)&& (request.getParameter("disattivi").equals("yes")))
          {
           checkedfiltra="checked";
           checkvalue="yes";
           }     
%>
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="get" action="VisualListinoSp.jsp">
<table width="90%" align=center border="0" cellspacing="0" cellpadding="0" >
 <tr>
   <td><img src="../images/titoloPagina.gif" alt="" border="0">
   </td>
 </tr>
 <tr>
   <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="1"></td>
 </tr>
 <tr>
   <td>
	   <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
        <tr>
           <td>
             <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>">
               <tr>
                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Listino Tariffe</td>
                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
               </tr>
        	   </table>               
           </td>
        </tr>
	   </table>
   </td>
 </tr>
</table>
<tr>
  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
</tr> 
<tr>
 	 <td>
	    <table  width="70%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                    <tr>
                      <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Seleziona storico tariffe</td>
                      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
<tr>
  <td>
    <table width="70%" border="0" cellspacing="0" align='center' cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
      <tr>
         <td width="20%" class="textB" align="Left">&nbsp;Tipo contratto:&nbsp;
            <input type="hidden" name="codeTipoContratto" id=codeTipoContratto value="<%=codeTipoContratto%>"> 
            <input type="hidden" name="descTipoContratto" id=descTipoContratto value="<%=descTipoContratto%>">             
         </td>   
         <td width="20%" class="text" align="Left"> <%=descTipoContratto%>
         </td>   
         <td width="60%" class="text" align="Left">&nbsp;
         </td>   
      </tr>
    </table>
   </td>
 </tr>
  <tr>
    <td>
      <table width="70%" border="0" cellspacing="0" align='center' cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
          <tr>
            <input class="textB" type="hidden" name="txtnumPag" value="1">
            <input class="textB" type="hidden" name="typeLoad" value="">
            <input class="textB" type="hidden" name="txtnumRec" value="">
          </tr>
           <td width="50%" class="textB" align="left">&nbsp;Mostra storico tariffe:&nbsp;
               <!--input type=checkbox name=Storico align="center" onClick="checkit()"-->
               <input type=checkbox name=disattivi value="yes" <%=checkedfiltra%>>
           </td>
           <td width="50%" class="textB" align="left">&nbsp;
           </td>           
          <tr>
             <td width="50%" class="textB" align="right">Risultati per pag.:&nbsp;</td>
               <td class="text">
                  <select class="text" name="numRec" onchange="submitFrmSearch('1');">
                  <option class="text" value=5>5</option>
                  <option class="text" value=10>10</option>
                  <option class="text" value=20>20</option>
                  <option class="text" value=50>50</option>
                  </select>
               </td>
             </tr>
           </td>
        </tr>
      </table>
    </td>
  </tr>
<tr>
 	 <td>
	    <table  width="70%" border="0" cellspacing="0" cellpadding="1" align='center'>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" align="center" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                    <tr>
                      <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista dei listini</td>
                      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
      <tr> 
        <td> 
          <table width="70%" align='center' border="0" cellspacing="0" cellpadding="0">
            <tr> 
              <td colspan='2' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='0'></td>
            </tr>

            <%
                  //Listini = TariffaHome.findListini(codeTipoContratto);
                  if ((Listini==null)||(Listini.size()==0))
                  {
              %>
            <tr> 
              <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="2" class="textB" align="center">No Record Found</td>
            </tr>
              <%
                  }
                  else
                  {
                  %>
                  <tr> 
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class='white'>&nbsp;</td>
                    <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Descrizione listino </td>
                  </tr>
                  <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=Listini.size()%>">
                  <pg:param name="codeTipoContratto" value="<%=codeTipoContratto%>"></pg:param> 
                  <pg:param name="descTipoContratto" value="<%=descTipoContratto%>"></pg:param>             
                  <pg:param name="typeLoad" value="1"></pg:param> 
                  <pg:param name="txtnumRec" value="<%=index%>"></pg:param> 
                  <pg:param name="numRec" value="<%=strNumRec%>"></pg:param> 
                  <pg:param name="disattivi" value="<%=checkvalue%>"></pg:param>
                  <%
                   String bgcolor="";
                   String checked;  
                   Object[] objs=Listini.toArray();
                   //Lista Listini
                 //if ((Listini!=null)&&(Listini.size()!=0))
                 //{
                      // Visualizzo elementi
                      for(int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<Listini.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                      {
                       TariffaBMP obj=(TariffaBMP)objs[i];
                         if ((i%2)==0)
                             bgcolor=StaticContext.bgColorRigaPariTabella;
                         else
                             bgcolor=StaticContext.bgColorRigaDispariTabella;
                         %>
                          <tr> 
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'> 
                              <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name='SelCodeContratto' checked = 'true' value='<%=obj.getCodContr()%>' onClick="ChangeSel('<%=obj.getCodContr()%>','<%=obj.getDescContr().replace('\'','Æ')%>')">
                              <input type='hidden'  name='SelDescContratto' checked = 'true' value='<%=obj.getDescContr()%>'>
                            </td>
                            <td bgcolor="<%=bgcolor%>" class='text'><%=obj.getDescContr()%></td>
                          </tr>
                      <%
                      }
                      %>
                            <pg:index> 
                            <tr> 
                              <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan='2' class="text" align="center"> Risultati 
                                Pag. <pg:prev> <a href="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[<< 
                                Prev]</a> </pg:prev> <pg:pages> 
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
                                          <a href="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true"><%= pageNumber %></a>&nbsp; 
                                          <%
                                          } 
                                        %>
                                  </pg:pages> <pg:next> <a href="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[Next 
                                  >>]</a> </pg:next> </td>
                              </tr>
                              </pg:index> </pg:pager> 
                              <%
                              //}//chiusura dell if
                        }            
                        %>
                      <tr> 
                        <td colspan='2' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='0'></td>
                      </tr>
                   </td> 
                 </tr>
               </table> 
            </tr>
          </table>
        </td>
            <input class="textB" type="hidden" name=num_rec id=num_rec value="<%=Listini.size()%>">
      </tr> 
      <tr> 
         <td>
            <table width="90%" align=center border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>">
               <tr>
                  <td colspan='1' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
               </tr>
               <tr> 
                 <td>
                   <sec:ShowButtons VectorName="BOTTONI" /> 
                 </td>  
               </tr>
            </table>       
         </td>  
       </tr>
</form>
</BODY>
</HTML>
