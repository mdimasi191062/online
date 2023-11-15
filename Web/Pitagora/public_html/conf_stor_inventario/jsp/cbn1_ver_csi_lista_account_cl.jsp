<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.rmi.*,com.ejbSTL.*,com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Vector" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_ver_csi_lista_account_cl.jsp")%>
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
  I5_2CONFR_INVENT_ROW[] aRemote = null;
  Vector appoVector=null;  
  String Code_elab=null;
  String flag_sys=null;
  String Code_account;
  String Nome_rag_soc_gest;
  String Desc_account;
  Integer Qnta_ps_invent;
  Integer Num_ps_reg;
  Integer Qnta_ps_atvti_invent;
  Integer Qnta_ps_dis_st;
  Integer Qnta_scarti;           
  String codiceTipoContratto =null;
  I5_2Elab_Batch[] aRemoteElab_Batch = null;
  int ElabBatchSelezionato; 

  ElabBatchSelezionato =  Integer.parseInt(request.getParameter("code_elab_flag_sys"));
  aRemoteElab_Batch = (I5_2Elab_Batch[]) session.getAttribute("aRemote");  
  I5_2Elab_Batch remoteElabBatch = (I5_2Elab_Batch) PortableRemoteObject.narrow(aRemoteElab_Batch[ElabBatchSelezionato],I5_2Elab_Batch.class);                                                        
  I5_2Elab_BatchPK PrimaryKey    = (I5_2Elab_BatchPK) remoteElabBatch.getPrimaryKey();      
  Code_elab=PrimaryKey.getcode_elab();
  flag_sys=PrimaryKey.getFlag_sys();  
  
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
function ChangeSel(indice)
{
  document.frmDati.CodSel.value=document.frmDati.Code_account[(indice-1)].value;
}
  //------------------------------------------------------------------------------
  //Fine Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function ONDATI()
{
  window.document.location="cbn1_ver_inventario_cl.jsp?txtTypeLoad=1"
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
if (typeLoad!=0)
  {
    aRemote = (I5_2CONFR_INVENT_ROW[]) session.getAttribute("aRemoteI5_2CONFR_INVENT_ROW");
  }
  else
  {   
%>
<EJB:useHome id="home" type="com.ejbSTL.I5_2CONFR_INVENTHome" location="I5_2CONFR_INVENT" />
<EJB:useBean id="remote_I5_2CONFR_INVENT" type="com.ejbSTL.I5_2CONFR_INVENT" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
    appoVector = remote_I5_2CONFR_INVENT.findAllByCode_elab(Code_elab,flag_sys);
    if (!(appoVector==null || appoVector.size()==0)) 
    {
      aRemote = (I5_2CONFR_INVENT_ROW[])appoVector.toArray(new I5_2CONFR_INVENT_ROW[1]);
      session.setAttribute( "aRemoteI5_2CONFR_INVENT_ROW", aRemote);
    }else{
      session.setAttribute( "aRemoteI5_2CONFR_INVENT_ROW", null);          
    }  
  }    
%>
  <!-- Gestione navigazione-->
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="cbn1_ver_csi_lista_account_cl.jsp">
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
                      <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <input class="textB" type="hidden" name="CodSel" value="<%=selCODE%>">
                        <input class="textB" type="hidden" name="txtTypeLoad" value="1">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                        <input class="textB" type="hidden" name="codiceTipoContratto" value="<%=codiceTipoContratto%>">                        
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
<form name="frmDati" method="post" action='cbn1_scarti_inventario_cl.jsp'>
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
                          <td bgcolor='#D5DDF1' class="textB" >Fornitore</td>      
                          <td bgcolor='#D5DDF1' class="textB" >Account</td>
                          <td bgcolor='#D5DDF1' class="textB" >Numero P/S inve.</td>      
                          <td bgcolor='#D5DDF1' class="textB" >Numero P/S reg.</td>
                          <td bgcolor='#D5DDF1' class="textB" >Numero nuove att.</td>                          
                          <td bgcolor='#D5DDF1' class="textB" >Numero nuove disattivaz.</td>
                          <td bgcolor='#D5DDF1' class="textB" >Numero scarti</td>
                          <td bgcolor='#D5DDF1' class="textB" >&nbsp;</td>
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote.length%>">
<pg:param name="txtTypeLoad" value="1"></pg:param>
<pg:param name="CodSel" value="<%=selCODE%>"></pg:param>
<pg:param name="txtCliente" value=""></pg:param>
<pg:param name="codiceTipoContratto" value="<%=codiceTipoContratto%>"></pg:param>
<pg:param name="code_elab_flag_sys" value="<%=ElabBatchSelezionato%>"></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>                        
<%
///pagerPageNumber= new Integer(6);
      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote.length) && (j<pagerPageNumber.intValue()*records_per_page));j++)      
      {
         if ((j%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";
         Code_account=aRemote[j].getCode_Account() + "," + aRemote[j].getDesc_account();
         Nome_rag_soc_gest=aRemote[j].getNome_rag_soc_gest();
         Desc_account=aRemote[j].getDesc_account();
         Qnta_ps_invent=aRemote[j].getQnta_ps_invent();
         Num_ps_reg=aRemote[j].getNum_ps_reg();
         Qnta_ps_atvti_invent=aRemote[j].getQnta_ps_atvti_invent();         
         Qnta_ps_dis_st=aRemote[j].getQnta_ps_dis_st();
         Qnta_scarti=aRemote[j].getQnta_scarti();
         if (selCODE!=null){
            if(Code_account.equals(selCODE)){
              sChecked="checked";
              bCheck=true;
            }else{
              sChecked="";
            }
         }  else {   
            if (i==0) {
              selCODE=Code_account;
              sChecked="checked";
              bCheck=true;              
            }else{  
              sChecked="";
            }
         }          
%>
                        <TR>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= Nome_rag_soc_gest %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= Desc_account %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= Qnta_ps_invent %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= Num_ps_reg %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= Qnta_ps_atvti_invent %></TD>                           
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= Qnta_ps_dis_st %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= Qnta_scarti %></TD>                           
                           <td bgcolor='white'>
<%
          if (!(Qnta_scarti==null)){
            if (Qnta_scarti.intValue()>0){
                      i+=1;
%>
                              <input type="radio" name="Code_account" <%=sChecked%> value="<%=Code_account%>" onclick="ChangeSel(<%=i%>);" >
<%
            
            } else {
%>
                              &nbsp;
<%
            }
          } else {
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
                          <td colspan='8' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="3" height='2'></td>
                        </tr>
<pg:index>
                        <tr>
                          <td bgcolor="#FFFFFF" colspan="8" class="text" align="center">
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
                          <td colspan='8' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
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
if ((aRemote==null)||(aRemote.length==0)||(i==0)) { 
%>
    Disable(document.frmDati.VISUALIZZA_SCARTI);
<%
}else{
  if (!bCheck){
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