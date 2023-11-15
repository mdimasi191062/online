<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.ejb.*,com.ejbSTL.*,com.ejbSTL.impl.*, com.usr.*,com.utl.*,java.util.Collection" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"lista_anag_funz.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  boolean bCheck = false;
    //Dichiarazioni

  String bgcolor="";
  int i=0;
  int j=0;
     //Il campo contiene l'elemento selezionato dall'utente
  String CodSel=request.getParameter("CodSel");
  String pCode_Funz=null;
  String sChecked="checked";
    // This is the variable we will store all records in.
  Collection collection=null;
  I5_6ANAG_FUNZ_ROW[] aRemote = null;


   //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  

    //eventuale Filtro di ricerca
  String strCodRicerca= request.getParameter("txtCodRicerca");
  String filtro =  request.getParameter("chkClsDisatt");
 
    //Lettura dell'indice Numero record per pagina della combo per ripristino dopo  ricaricamento
  int index=0;
  String strIndex = request.getParameter("txtnumRec");
  if (strIndex!=null)
  {
    Integer tmpindext=new Integer(strIndex);
    index=tmpindext.intValue();
  }

//Lettura del valore Numero record per pagina della combo per visualizzazione risultato (default 5)
  int records_per_page=5;
  String strNumRec = request.getParameter("numRec");
  if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }
  
  
//Lettura del valore Numero pagina per visualizzazione risultato (default 1)
  int nPage=1;
  String strPage=request.getParameter("txtnumPag");
  if ((strPage!=null)&&((strPage!="")))
  {
    Integer tmpPageCount=new Integer(strPage);
    nPage=tmpPageCount.intValue();
  }

// Lettura del valore tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=1 Fare query (default)
// typeLoad=0 Variabile session

//****************
  int typeLoad=0;
  String strtypeLoad = request.getParameter("txtTypeLoad");
  if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }

  //------------------------------------------------------------------------------
  //Fine Standard Ricerca
  //------------------------------------------------------------------------------  

%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">

function selezionaPrimo()
{
  var n = document.frmLista.elements.length;
  var esiste=0;
  var selezionato=false;
  for(i=0;i<n;i++)
  {
    if(document.frmLista.elements[i].type=="radio")
    {
        esiste++;
        if(document.frmLista.elements[i].checked==true)
          selezionato=true;
    }
  }
  
  if(esiste>1 && !selezionato)
  {
      document.frmLista.code_funz[0].checked=true;
      document.frmLista.CodSel.value=document.frmLista.code_funz[0].value;
  }
  if(esiste==1 && !selezionato)
  {
      document.frmLista.code_funz.checked=true;
      document.frmLista.CodSel.value=document.frmLista.code_funz.value;
  }  
}

function ONNUOVO()
{
  GestioneAnagFunz(0);
}
function ONAGGIORNA()
{
  GestioneAnagFunz(1);
}
function ONCANCELLA()
{
  GestioneAnagFunz(2);
}
function ONSTAMPA()
{
  openDialog("stampa_anag_funz.jsp", 800, 500, "","print");
}




function GestioneAnagFunz(iGestione)
{
  var sParametri='';
  sParametri= '?txtnumRec=<%=index%>';
  sParametri= sParametri + '&numRec=<%=records_per_page%>';
  sParametri= sParametri + '&txtTypeLoad=1'; 
  sParametri= sParametri + '&txtnumPag=<%=nPage%>'; 
  sParametri= sParametri + '&txtCodRicerca=' + document.forms.frmSearch.txtCodRicerca.value; 
  switch (parseInt(iGestione)){
  case 0:
    sParametri= sParametri + '&strProvenienza=0i';
    break;
  case 1:
    sParametri= sParametri + '&strProvenienza=0m';
    sParametri= sParametri + '&CodSel=' + window.document.frmLista.CodSel.value;         
    break;    
  case 2:     
    sParametri= sParametri + '&strProvenienza=2';  
    sParametri= sParametri + '&CodSel=' + window.document.frmLista.CodSel.value;             
  }
  openDialog("gest_anag_funz.jsp" + sParametri, 600, 300);
}
  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function submitFrmSearch(typeLoad)
{
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.CodSel.value=document.frmLista.CodSel.value;
  document.frmSearch.txtTypeLoad.value=typeLoad;
  document.frmSearch.submit();
}  
function setnumRec()
{
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true');

}
function gotoPage(page)
{
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.CodSel.value=document.frmLista.CodSel.value;
  document.frmSearch.txtTypeLoad.value=1;
  document.frmSearch.txtnumPag.value=page;
  document.frmSearch.submit();
}


function ChangeSel(codice,indice)
{
  document.frmLista.CodSel.value=codice;
//  document.frmLista.RagSel.value=eval('document.frmOlo.SelClienti[indice].value');
}
  //------------------------------------------------------------------------------
  //Fine Gestione Standard Ricerca
  //------------------------------------------------------------------------------  

function esistonoRighe()
{
  var n = document.frmLista.elements.length;
  for(var i=0;i<n;i++)
  {
    if(document.frmLista.elements[i].type=='radio')
    {
      return true;
    }
  }
  return false;
}
function abilitaTasti()
{
  if(!esistonoRighe())
  {
    if(document.frmLista.AGGIORNA)
    {
      Disable(document.frmLista.AGGIORNA);
    }
    if(document.frmLista.STAMPA)
    {
      Disable(document.frmLista.STAMPA);
    }
  }
}
</SCRIPT>


<TITLE>Lista Anagrafica Funzionalità</TITLE>
</HEAD>
<BODY onLoad="setnumRec();">

  <!-- Gestione navigazione-->

<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="lista_anag_funz.jsp">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/gestfunz.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Gestione Anagrafica Funzionalità</td>
                <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
      
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                   <tr>
                      <td>
                          <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                          <tr>
                            <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp; Filtro di Ricerca</td>
                            <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                          </tr>
                          </table>                        
                      </td>
                  </tr>   
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr>
                      <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>               

                    <tr>
                      <td width="40%" class="textB" align="right">Codice Funzionalità:&nbsp;</td>

                       <td  width="40%" class="text">
                        <%
                        if (strCodRicerca==null){
                        %>
                          <input class="text" type='text' name='txtCodRicerca'  size='20'>                        
                        <%                        
                        }else{
                        %>
                          <input class="text" type='text' name='txtCodRicerca' value='<%=strCodRicerca%>' size='20'>                        
                        <%                        
                        }
                        %>
                      </td>

                      <td width="20%" rowspan='2' class="textB" valign="center" align="center">
                       <input class="textB" type="button" name="Esegui" value="Popola" onclick="submitFrmSearch('0');">
                        <% 
                        if (CodSel!=null){
                        %>
                        <input class="textB" type="hidden" name="CodSel" value="<%=CodSel%>">
                         <%
                        }else{
                        %>
                        <input class="textB" type="hidden" name="CodSel" value="">
                        <%
                        }  
                        %> 
                        <input class="textB" type="hidden" name="txtTypeLoad" value="">
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
          <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
</form>
  <!-- Gestione navigazione-->

<form name="frmLista">

<EJB:useHome id="home" type="com.ejbSTL.I5_6ANAG_FUNZHome" location="I5_6ANAG_FUNZ" />
<EJB:useBean id="funzioni" type="com.ejbSTL.I5_6ANAG_FUNZ" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

 
<%if (typeLoad!=0)
  {
    aRemote = (I5_6ANAG_FUNZ_ROW[]) session.getAttribute("aRemote");
  }
  else
  {
        collection = funzioni.FindAll(strCodRicerca);
 

    if (!(collection==null || collection.size()==0)) 
    {
      aRemote = (I5_6ANAG_FUNZ_ROW[]) collection.toArray( new I5_6ANAG_FUNZ_ROW[1]);
      session.setAttribute("aRemote", aRemote);
    }
    else
    {
      session.setAttribute("aRemote", null);
    }
  }    
%>


        <tr>
          <td>
            <table border="0" width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp; Lista Funzionalità</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                
                  <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td colspan='1' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
  <% 
  if ((aRemote==null)||(aRemote.length==0))  
  {
    %>
                    <tr>
                      <td bgcolor="#FFFFFF" colspan="1" class="textB" align="center">No Record Found</td>
                    </tr>
   <%
  } else {
  %>
                    
                    <tr>
                      <td>
                        <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                        <tr>
                         <td bgcolor='white'width="0%" >&nbsp;</td>      
                         <td bgcolor='#D5DDF1' class="textB" width="30%" >Codice</td>
                         <td bgcolor='#D5DDF1' class="textB" width="60%" >Descrizione</td>
                         <td bgcolor='#D5DDF1' class="textB" width="10%" >Tipo Funzione</td> 
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote.length%>">
<pg:param name="txtTypeLoad" value="1"></pg:param>
<pg:param name="CodSel" value="<%=CodSel%>"></pg:param>
<pg:param name="txtCodRicerca" value="<%=strCodRicerca%>"></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>                        


                        
<%
   //Scrittura dati su lista
     

    String code_funz   = null ;
    String desc_funz   = null;
    String tipo_funz   = null;
    String flag_sys   = null;

      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote.length) && (j<pagerPageNumber.intValue()*records_per_page));j++)
      {
        
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";
        
          code_funz = aRemote[j].getCODE_FUNZ();
          desc_funz = aRemote[j].getDESC_FUNZ();
          tipo_funz = aRemote[j].getTIPO_FUNZ();
          flag_sys  = aRemote[j].getFLAG_SYS();
          if (CodSel!=null)
          {
            if(CodSel.equals(code_funz)){
              sChecked="checked";
              bCheck=true;
            }else{
              sChecked="";
            }
          } 
          else 
          {   
            if (i==0) {
              sChecked="checked";
              CodSel=code_funz;
              bCheck=true;              
            }else{  
              sChecked="";
            }
          }  

%>
                        <TR>
                           <td bgcolor='white' >
                              <input type="radio" name="code_funz" value="<%=code_funz%>" <%=sChecked%> onclick=ChangeSel('<%=code_funz%>','<%=i%>')>
                           </td>
                            <TD bgcolor='<%=bgcolor%>' class='text'><%=code_funz%></td>
                            <TD bgcolor='<%=bgcolor%>' class='text'><%=desc_funz %></td>
                            <TD bgcolor='<%=bgcolor%>' name= Tipo_Funzione class='text'><%=tipo_funz%></td> 
                       </tr>

                         

                        <tr>
                          <td colspan='4' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                        </tr>

<%
          i+=1;
        }

%>

                        <tr>
                          <td colspan='4' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                        </tr>
<pg:index>
                        <tr>
                          <td bgcolor="#FFFFFF" colspan="4" class="text" align="center">
                          Risultati Pag.
                          <pg:prev> 
                            <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
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
                            <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
<%
    } 
%>
</pg:pages>
                          <pg:next>
                            <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
                          </pg:next>
                          </td>
                        </tr>
</pg:index>
</pg:pager>
                        
                        </table>
<%
    }
%> 
                      </td>
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
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <td class="textB" bgcolor="#D5DDF1" align="center" colspan="5">
            <input type="hidden" name="CodSel" value="<%= CodSel %>" > 
	        </td>
            <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>


<SCRIPT LANGUAGE="JavaScript">
selezionaPrimo();
    abilitaTasti();
</script>


</BODY>
</HTML>
