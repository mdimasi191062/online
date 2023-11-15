<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.rmi.*,com.ejbBMP.*,com.ejbSTL.*,com.utl.*,com.usr.*,java.util.Vector" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_ver_cpm_lista_account_cl.jsp")%>
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
    // Variabile per la memorizzazione delle informazioni dalla variabile collection
  LISTA_VERIFICA_ACCOUNT_CPM_CL_ROW[] aRemote = null;
  I5_2Elab_Batch[] aRemoteElab_Batch = null;
  Vector appoVector=null;  
  String Code_elab=null;
  String flag_sys=null;
  I5_2PARAM_VALORIZ_CL_ROW rowPARAM_VALORIZ  =null;
    //Contratti selezionati sulla maschera cb1_ver_inventario_cl
  int ElabBatchSelezionato; 
  String strCode_account=null;
  
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
function ChangeSel(indice)
{
  document.frmDati.CodSel.value=document.frmDati.Code_account[(indice-1)].value;
}
  //------------------------------------------------------------------------------
  //Fine Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function ONDATI()
{
  window.document.location="cbn1_ver_calcolo_penali_cl.jsp?txtTypeLoad=0"
}
function ONVISUALIZZA_SCARTI()
{
  window.document.frmDati.submit();
}  

</SCRIPT>


<TITLE>Visualizza Ricavi</TITLE>
</HEAD>
<BODY onload="setnumRec();">
<%
  ElabBatchSelezionato =  Integer.parseInt(request.getParameter("code_elab_flag_sys"));
  aRemoteElab_Batch = (I5_2Elab_Batch[]) session.getAttribute("aRemote");
  I5_2Elab_Batch remoteElabBatch = (I5_2Elab_Batch) PortableRemoteObject.narrow(aRemoteElab_Batch[ElabBatchSelezionato],I5_2Elab_Batch.class);                                                        
  I5_2Elab_BatchPK PrimaryKey    = (I5_2Elab_BatchPK) remoteElabBatch.getPrimaryKey();      
  Code_elab=PrimaryKey.getcode_elab();
  flag_sys=PrimaryKey.getFlag_sys();  
  rowPARAM_VALORIZ = (I5_2PARAM_VALORIZ_CL_ROW) session.getAttribute( "rowPARAM_VALORIZ");  
  if (typeLoad!=0)
  {
    aRemote = (LISTA_VERIFICA_ACCOUNT_CPM_CL_ROW[]) session.getAttribute("aRemoteAccount");
  }
  else
  {   
%>
<EJB:useHome id="home" type="com.ejbSTL.LISTA_VERIFICA_ACCOUNT_CPM_CLHome" location="LISTA_VERIFICA_ACCOUNT_CPM_CL" />
<EJB:useBean id="remote_LISTA_VERIFICA_ACCOUNT_CPM_CL" type="com.ejbSTL.LISTA_VERIFICA_ACCOUNT_CPM_CL" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
    appoVector = remote_LISTA_VERIFICA_ACCOUNT_CPM_CL.findAll(Code_elab,flag_sys,rowPARAM_VALORIZ.getData_inizio_ciclo_fatrz(),rowPARAM_VALORIZ.getData_fine_ciclo_fatrz());
    if (!(appoVector==null || appoVector.size()==0)) 
    {
      aRemote = (LISTA_VERIFICA_ACCOUNT_CPM_CL_ROW[])appoVector.toArray(new LISTA_VERIFICA_ACCOUNT_CPM_CL_ROW[1]);
      session.setAttribute( "aRemoteAccount", aRemote);
    }else{
      session.setAttribute( "aRemoteAccount", null);                        
    }  
  }    
%>
  <!-- Gestione navigazione-->
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="cbn1_ver_cpm_lista_account_cl.jsp">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/calcpenmens.gif" alt="" border="0"></td>
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Verifica Batch Calcolo Penali Mensili</td>
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
                      <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <input class="textB" type="hidden" name="CodSel" value="<%=selCODE%>">
                        <input class="textB" type="hidden" name="txtTypeLoad" value="1">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                        <input class="textB" type="hidden" name="code_elab_flag_sys" value="<%=ElabBatchSelezionato%>">                                                
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
<form name="frmDati" method="post" action='cbn1_vis_scarti_penali_cl.jsp'>
        <tr>
          <td>
            <table border="0" width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Dato Elaborato Selezioanto</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                   <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                   <tr>
                      <td bgcolor='#D5DDF1' class="textB" >Codice</td>      
                      <td bgcolor='#D5DDF1' class="textB" >Data/Ora inizio elab.</td>
                      <td bgcolor='#D5DDF1' class="textB" >Data/Ora fine elab.</td>      
                      <td bgcolor='#D5DDF1' class="textB" >Stato</td>
                      <td bgcolor='#D5DDF1' class="textB" >Nr. P/S processati</td>                              
                    </tr>
                   <tr>
                      <td bgcolor='#EBF0F0' class="textB" ><%=Code_elab%></td>      
                      <td bgcolor='#EBF0F0' class="textB" ><%=remoteElabBatch.getData_ora_inizio_elab_batch()%></td>
                      <td bgcolor='#EBF0F0' class="textB" ><%=remoteElabBatch.getData_ora_fine_elab_batch()%></td>      
                      <td bgcolor='#EBF0F0' class="textB" ><%=remoteElabBatch.getValo_nr_ps_elab()%></td>
                      <td bgcolor='#EBF0F0' class="textB" ><%=remoteElabBatch.getDesc_Stato_Batch()%></td>                          
                    </tr>                    
                    </table>
                </td>
              </tr>                        
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Lista Account Elaborati Calcolo Penali Mensili</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td colspan='1' bgcolor="#FFFFFF">
                          <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                          <tr>
                            <td bgcolor='#D5DDF1' class="textB" >Inizio ciclo di fatturazione</td>      
                            <td bgcolor='#D5DDF1' class="textB" ><%=rowPARAM_VALORIZ.getData_inizio_ciclo_fatrz()%></td>                                  
                            <td bgcolor='#D5DDF1' class="textB" >Fine ciclo di fatturazione</td>
                            <td bgcolor='#D5DDF1' class="textB" ><%=rowPARAM_VALORIZ.getData_fine_ciclo_fatrz()%></td>                                  
                          </tr>                            
                          </table>                            
                      </td>
                    </tr>
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
                          <td bgcolor='#D5DDF1' class="textB" >Cliente</td>      
                          <td bgcolor='#D5DDF1' class="textB" >Account</td>
                          <td bgcolor='#D5DDF1' class="textB" >Mese di riferimento Penale</td>      
                          <td bgcolor='#D5DDF1' class="textB" >Anno di riferimento Penale</td>
                          <td bgcolor='#D5DDF1' class="textB" >Scarti NB</td>                          
                          <td bgcolor='#D5DDF1' class="textB" >Errore Bloccante</td>
                          <td bgcolor='#D5DDF1' class="textB" >&nbsp;</td>
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote.length%>">
<pg:param name="txtTypeLoad" value="1"></pg:param>
<pg:param name="CodSel" value="<%=selCODE%>"></pg:param>
<pg:param name="code_elab_flag_sys" value="<%=ElabBatchSelezionato%>"></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>                        
<%      
      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote.length) && (j<pagerPageNumber.intValue()*records_per_page));j++)      
      {
         strCode_account=aRemote[j].getCode_account() + "," + aRemote[j].getDesc_account();
         if ((j%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";
         if (selCODE!=null){
            if(strCode_account.equals(selCODE)){
              sChecked="checked";
              bCheck=true;
            }else{
              sChecked="";
            }
         }  else {   
            if (i==0) {
              selCODE=strCode_account;
              sChecked="checked";
              bCheck=true;              
            }else{  
              sChecked="";
            }
         }          
%>
                        <TR>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= aRemote[j].getNome_rag_soc_gest()%></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= aRemote[j].getDesc_account() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= aRemote[j].getMese() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= aRemote[j].getAnno() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= aRemote[j].getScartiNB() %></TD>                           
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= aRemote[j].getErroriBloccanti() %></TD>                   
                           <td bgcolor='white'>
<%
                  if ( (aRemote[j].getScartiNB()>0) || (aRemote[j].getErroriBloccanti().equals("S") ) ) {
                      i+=1;
%>
                              <input type="radio" name="Code_account" <%=sChecked%> value="<%=strCode_account%>" onclick="ChangeSel(<%=i%>);" >
<%
                  }else{
%>
                              &nbsp;
<%
                  }    
%>                              
                           </td>
                        </tr>

<%
      }
%>      

                        <tr>
                          <td colspan='7' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="3" height='2'></td>
                        </tr>
<pg:index>
                        <tr>
                          <td bgcolor="#FFFFFF" colspan="7" class="text" align="center">
                          Risultati Pag.
                          <pg:prev> 
                            <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
                          </pg:prev>
<pg:pages>
<% 
    if (pageNumber.intValue() == pagerPageNumber.intValue()) 
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
                          <td colspan='7' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
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
      <input class="textB" type="hidden" name="code_elab_flag_sys" value="<%=ElabBatchSelezionato%>">          
      <input class="textB" type="hidden" name="CodSel" value="<%=selCODE%>">          
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
if ((aRemote==null)||(aRemote.length==0) || (i==0)) { 
%>
    Disable(document.frmDati.VISUALIZZA_SCARTI);
<%
}else{
  if ((!bCheck) && (i>0)) {
    if (i==1){
%>
    document.frmDati.Code_account.checked=true;
<%    
    }else{    
%>
    document.frmDati.Code_account[0].checked=true;
<% 
    }
  }
}  
%>
</script>
</BODY>
</HTML>