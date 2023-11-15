<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.rmi.*,com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Collection" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_ver_inventario_cl.jsp")%>
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
     //Il campo contiene l'elemento selezionato dall'utente
  String selCODE=null;
  String sChecked="checked";
    // This is the variable we will store all records in.
  Collection collection=null;
    //Interfaccia Remota
  I5_2Elab_Batch remote = null;           
    // Variabile per la memorizzazione delle informazioni dalla variabile collection  
  I5_2Elab_Batch[] aRemote = null;
  I5_2Elab_BatchPK PrimaryKey    = null;                                                     
  String Data_ora_inizio_elab_batch = null;
  String Data_ora_fine_elab_batch = null;
  String Valo_nr_ps_elab = null;
  String Desc_Stato_Batch = null;        
  String code_elab_flag_sys= null;
    //Contratti selezionati sulla maschera com_tc_001
  String  codiceTipoContratto = null;
  
  codiceTipoContratto = request.getParameter("codiceTipoContratto");
  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  

  selCODE=request.getParameter("CodSel");

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
<SCRIPT LANGUAGE="JavaScript">
  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function submitFrmSearch(typeLoad)
{
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.CodSel.value=document.frmDati.CodSel.value;
  document.frmSearch.txtTypeLoad.value=typeLoad;
  document.frmSearch.submit();
}  
function setnumRec()
{
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
}
function ChangeSel(codice,indice)
{
  document.frmDati.CodSel.value=codice;
}
  //------------------------------------------------------------------------------
  //Fine Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function ONLISTA()
{
  window.document.frmDati.submit();
}  

</SCRIPT>


<TITLE>Visualizza Ricavi</TITLE>
</HEAD>
<BODY onload="setnumRec();">
<%
if (typeLoad!=0)
  {
    aRemote = (I5_2Elab_Batch[]) session.getAttribute("aRemote");
  }
  else
  {   
%>
<EJB:useHome id="home" type="com.ejbBMP.I5_2Elab_BatchHome" location="I5_2Elab_Batch" />
<%
   collection = home.findAll(codiceTipoContratto);      
   if (!(collection==null || collection.size()==0)) {
    aRemote = (I5_2Elab_Batch[]) collection.toArray( new I5_2Elab_Batch[1]);
    session.setAttribute( "aRemote", aRemote);    
    }else{
      session.setAttribute( "aRemote", null);              
   }  
  }   
%>
  <!-- Gestione navigazione-->
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="cbn1_ver_inventario_cl.jsp">
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Verifica confronto storico inventario</td>
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
                      <td colspan='2' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <input class="textB" type="hidden" name="CodSel" value="<%=selCODE%>">
                        <input class="textB" type="hidden" name="txtTypeLoad" value="">
                        <input class="textB" type="hidden" name="txtnumRec" value="">                        
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
<form name="frmDati" method="post" action='cbn1_ver_csi_lista_account_cl.jsp?codiceTipoContratto=<%=codiceTipoContratto%>'>
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
                          <td bgcolor='#D5DDF1' class="textB" >Codice</td>      
                          <td bgcolor='#D5DDF1' class="textB" >Data/Ora inizio elab.</td>
                          <td bgcolor='#D5DDF1' class="textB" >Data/Ora fine elab.</td>      
                          <td bgcolor='#D5DDF1' class="textB" >Stato</td>
                          <td bgcolor='#D5DDF1' class="textB" >Nr. P/S processati</td>                          
                          <td bgcolor='#D5DDF1' class="textB" >&nbsp;</td>      
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote.length%>">
<pg:param name="txtTypeLoad" value="1"></pg:param>
<pg:param name="CodSel" value="<%=selCODE%>"></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>                        
<%

      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote.length) && (j<pagerPageNumber.intValue()*records_per_page));j++)      
      {
         remote = (I5_2Elab_Batch) PortableRemoteObject.narrow(aRemote[j],I5_2Elab_Batch.class);                                                
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";
         PrimaryKey    = (I5_2Elab_BatchPK) remote.getPrimaryKey();       
         code_elab_flag_sys=PrimaryKey.getcode_elab() + "," + PrimaryKey.getFlag_sys();
         Data_ora_inizio_elab_batch = remote.getData_ora_inizio_elab_batch();
         Data_ora_fine_elab_batch = remote.getData_ora_fine_elab_batch();
         Valo_nr_ps_elab = remote.getValo_nr_ps_elab();
         Desc_Stato_Batch = remote.getDesc_Stato_Batch();         
         if (selCODE!=null){
            if( j == Integer.parseInt(selCODE)){         
              sChecked="checked";
              bCheck=true;
            }else{
              sChecked="";
            }
         }  else {   
            if (i==0) {
              selCODE= Integer.toString(j);
              sChecked="checked";
              bCheck=true;              
            }else{  
              sChecked="";
            }
         }           
%>
                        <TR>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= PrimaryKey.getcode_elab() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= Data_ora_inizio_elab_batch %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= Data_ora_fine_elab_batch %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= Desc_Stato_Batch %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= Valo_nr_ps_elab %></TD>
                           <td bgcolor='white'>
                              <input type="radio" name="code_elab_flag_sys" <%=sChecked%> value="<%=j%>" onclick=ChangeSel('<%=j%>','<%=i%>')>
                           </td>
                        </tr>

<%
          i+=1;
      }
%>      

                        <tr>
                          <td colspan='6' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="3" height='2'></td>
                        </tr>
<pg:index>
                        <tr>
                          <td bgcolor="#FFFFFF" colspan="3" class="text" align="center">
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
                        <tr>
                          <td colspan='6' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                        </tr>
<%
    }
%> 
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
    			<td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
        </tr>
        <tr>
          <td>
            <input class="textB" type="hidden" name="CodSel" value="<%=selCODE%>">          
            <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
              <tr>
                 <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />	        
              </tr>
            </table>
          </td>
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
    Disable(document.frmDati.LISTA_ACCOUNT);
<%
}else{
  if (!bCheck){
    if (i==1){
%>
    document.frmDati.code_elab_flag_sys.checked=true;
<%    
    }else{    
%>
    document.frmDati.code_elab_flag_sys[0].checked=true;
<% 
    }
  }
}  
%>
</script>
</BODY>
</HTML>
