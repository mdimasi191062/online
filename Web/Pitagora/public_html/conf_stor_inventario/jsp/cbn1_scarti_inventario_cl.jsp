<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.rmi.*,com.ejbSTL.*,com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Vector" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_scarti_inventario_cl.jsp")%>
</logtag:logData>
<% 
  response.addHeader("Pragma", "no-cache"); 
  response.addHeader("Cache-Control", "no-store");
    //---------------------------------------------------------------------------------
    //                                Dichiarazioni
    //---------------------------------------------------------------------------------    
  String bgcolor="";
  boolean bCheck=false;  
  int i=0;
  int j=0;
    // Variabile per la memorizzazione delle informazioni dalla variabile collection
  I5_2RECORD_SCARTATO_CL_ROW[] aRemote = null;
  Vector appoVector=null;  
  String Code_elab=null;
  String flag_sys=null;
  String Code_account=null;  
  String Desc_account;    
  String Code_Scarto;
  String Desc_Motivo_Scarto;
  String Code_Istanza_Ps;
  String Desc_Valo_Attuale;
  String Desc_Valo_St;  
    //Contratti selezionati sulla maschera cb1_scari_inventario
  String codiceTipoContratto =null;
  int ElabBatchSelezionato;
  I5_2Elab_Batch[] aRemoteElab_Batch = null;
  
  ElabBatchSelezionato =  Integer.parseInt(request.getParameter("code_elab_flag_sys"));
  aRemoteElab_Batch = (I5_2Elab_Batch[]) session.getAttribute("aRemote");  
  I5_2Elab_Batch remoteElabBatch = (I5_2Elab_Batch) PortableRemoteObject.narrow(aRemoteElab_Batch[ElabBatchSelezionato],I5_2Elab_Batch.class);                                                        
  I5_2Elab_BatchPK PrimaryKey    = (I5_2Elab_BatchPK) remoteElabBatch.getPrimaryKey();      
  Code_elab=PrimaryKey.getcode_elab();
  flag_sys=PrimaryKey.getFlag_sys(); 
  String strCode_account=request.getParameter("Code_account");
  Code_account=strCode_account.substring(0,strCode_account.indexOf(','));
  Desc_account=strCode_account.substring(strCode_account.indexOf(',')+1);

  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  

    //eventuale Filtro di ricerca
  String strCodRicerca= request.getParameter("txtCodRicerca");

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
  
  
//Lettura del valore tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=1 Fare query (default)
// typeLoad=0 Variabile session

  int typeLoad=0;
  String strtypeLoad = request.getParameter("txtTypeLoad");
  if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function submitFrmSearch(typeLoad)
{
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.txtTypeLoad.value=typeLoad;
  document.frmSearch.submit();
}  
function setnumRec()
{
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
}

  //------------------------------------------------------------------------------
  //Fine Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function ONSTAMPA()
{
  openDialog("stampa_scarti_inventario_cl.jsp", 600, 600, " ,scrollbars=1, resizable=1, toolbar=0, status=0, menubar=1");  
}
</SCRIPT>


<TITLE>Visualizza Ricavi</TITLE>
</HEAD>
<BODY onload="setnumRec();">
<%
if (typeLoad!=0)
  {
    aRemote = (I5_2RECORD_SCARTATO_CL_ROW[]) session.getAttribute("aRemote_I5_2RECORD_SCARTATO_CL_ROW");
  }
  else
  {   
%>
<EJB:useHome id="home" type="com.ejbSTL.I5_2RECORD_SCARTATO_CLHome" location="I5_2RECORD_SCARTATO_CL" />
<EJB:useBean id="remote_I5_2RECORD_SCARTATO_CL" type="com.ejbSTL.I5_2RECORD_SCARTATO_CL" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
    appoVector = remote_I5_2RECORD_SCARTATO_CL.findAll(Code_account,flag_sys,Code_elab);
    if (!(appoVector==null || appoVector.size()==0)) 
    {
      aRemote = (I5_2RECORD_SCARTATO_CL_ROW[])appoVector.toArray(new I5_2RECORD_SCARTATO_CL_ROW[1]);
      session.setAttribute( "aRemote_I5_2RECORD_SCARTATO_CL_ROW", aRemote);
    }else{      
      session.setAttribute( "aRemote_I5_2RECORD_SCARTATO_CL_ROW", null);    
    }  
  }    
%>
  <!-- Gestione navigazione-->
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="cbn1_scarti_inventario_cl.jsp">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/confrstoricoinven.gif" alt="" border="0"></td>
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Visualizza Scarti</td>
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
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">Dati Account</td>
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
                      <td class="textB" align="right">Account</td>
                      <td  class="text">&nbsp;<%=Desc_account%></td>
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
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Filtro di Ricerca</td>
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
                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <input class="textB" type="hidden" name="txtTypeLoad" value="1">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                        <input class="textB" type="hidden" name="codiceTipoContratto" value="<%=codiceTipoContratto%>">                        
                        <input class="textB" type="hidden" name="code_elab_flag_sys" value="<%=ElabBatchSelezionato%>">                                                
                        <input class="textB" type="hidden" name="Code_account" value="<%=strCode_account%>">                                                                        
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
<form name="frmDati" method="post" action='cbn1_ver_csi_lista_account_cl.jsp'>
        <tr>
          <td>
            <table border="0" width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Dati Elaborazione</td>
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
                          <td bgcolor='#D5DDF1' class="textB" >Motivo</td>      
                          <td bgcolor='#D5DDF1' class="textB" >Codice Istanza P/S</td>
                          <td bgcolor='#D5DDF1' class="textB" >Valore ad inventario</td>      
                          <td bgcolor='#D5DDF1' class="textB" >Valore a storico</td>
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote.length%>">
<pg:param name="txtTypeLoad" value="1"></pg:param>
<pg:param name="txtCliente" value=""></pg:param>
<pg:param name="codiceTipoContratto" value="<%=codiceTipoContratto%>"></pg:param>
<pg:param name="code_elab_flag_sys" value="<%=ElabBatchSelezionato%>"></pg:param>
<pg:param name="Code_account" value="<%=strCode_account%>"></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>                        
<%

      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote.length) && (j<pagerPageNumber.intValue()*records_per_page));j++)      
      {
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";
         Code_Scarto=aRemote[j].getCode_Scarto();
         Desc_Motivo_Scarto=aRemote[j].getDesc_Motivo_Scarto();
         Code_Istanza_Ps=aRemote[j].getCode_Istanza_Ps();
         Desc_Valo_Attuale=aRemote[j].getDesc_Valo_Attuale();
         Desc_Valo_St=aRemote[j].getDesc_Valo_St();         
%>
                        <TR>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= Desc_Motivo_Scarto %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= Code_Istanza_Ps %></TD>
<%                           
         if (Desc_Valo_Attuale != null){
%>         
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= Desc_Valo_Attuale %></TD>
<%                           
         } else {
%>
                           <TD bgcolor='<%=bgcolor%>' class='text'>&nbsp;</TD>
<%
         }
         if (Desc_Valo_St != null){
%>                                    
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= Desc_Valo_St %></TD>                           
<%                           
         } else {
%>
                           <TD bgcolor='<%=bgcolor%>' class='text'>&nbsp;</TD>
<%
         }                           
%>         
                        </tr>

<%
      }
%>      

                        <tr>
                          <td colspan='5' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="3" height='2'></td>
                        </tr>
<pg:index>
                        <tr>
                          <td bgcolor="#FFFFFF" colspan="5" class="text" align="center">
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
<%
    }
%> 

                        <tr>
                          <td colspan='5' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
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
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />	        
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>
<script language="javascript">
<% 
if ((aRemote==null)||(aRemote.length==0)) { 
%>
    Disable(document.frmDati.STAMPA);
<%
}
%>
</script>
</BODY>
</HTML>