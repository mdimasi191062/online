<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.rmi.*,com.ejbSTL.*,com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Vector" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_ver_sar_lista_account_cl.jsp")%>
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
  I5_2TEST_AVANZ_COSTI_RICAVI_ROW[] aRemote = null;
  Vector appoVector=null;  
  String Code_elab=null;
  String flag_sys=null;
  String Code_account;
  String Code_confr_invent;
    //Contratti selezionati sulla maschera cb1_ver_inventario_cl
  String  code_elab_flag_sys = null;
  String ChiaveAccount=null;
  int ElabBatchSelezionato; 
  I5_2Elab_Batch[] aRemoteElab_Batch = null;
  
  ElabBatchSelezionato =  Integer.parseInt(request.getParameter("code_elab_flag_sys"));
  aRemoteElab_Batch = (I5_2Elab_Batch[]) session.getAttribute("aRemote");  
  I5_2Elab_Batch remoteElabBatch = (I5_2Elab_Batch) PortableRemoteObject.narrow(aRemoteElab_Batch[ElabBatchSelezionato],I5_2Elab_Batch.class);                                                        
  I5_2Elab_BatchPK PrimaryKey    = (I5_2Elab_BatchPK) remoteElabBatch.getPrimaryKey();      
  Code_elab=PrimaryKey.getcode_elab();
  flag_sys=PrimaryKey.getFlag_sys();  

  
  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  

  selCODE=request.getParameter("CodSel");

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
function ONDATI()
{
  window.document.location="cbn1_ver_ava_ric_cl.jsp?txtTypeLoad=1";
}
function ONCONGELA_TUTTI()
{
  if (confirm('Si conferma il congelamento dei dati selezionati?')==true)
   {
       window.document.frmDati.submit();
   }
}  
function ONCONGELA_SEL()
{
  if (confirm('Si conferma il congelamento dei dati selezionati?')==true)
   {   
       window.document.frmDati.action=window.document.frmDati.action + "?SingoloCongelamento=1";
       window.document.frmDati.submit();
   }
}  
</SCRIPT>


<TITLE>Visualizza Ricavi</TITLE>
</HEAD>
<BODY onload="setnumRec();">
<%
if (typeLoad!=0)
  {
    aRemote = (I5_2TEST_AVANZ_COSTI_RICAVI_ROW[]) session.getAttribute("aRemoteTEST_AVANZ_COSTI_RICAVI_ROW");
  }
  else
  {   
%>
<EJB:useHome id="home" type="com.ejbSTL.I5_2TEST_AVANZ_COSTI_RICAVIHome" location="I5_2TEST_AVANZ_COSTI_RICAVI" />
<EJB:useBean id="remote_TEST_ACR" type="com.ejbSTL.I5_2TEST_AVANZ_COSTI_RICAVI" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
    appoVector = remote_TEST_ACR.findAll(Code_elab,flag_sys);
    if (!(appoVector==null || appoVector.size()==0)) 
    {
      aRemote = (I5_2TEST_AVANZ_COSTI_RICAVI_ROW[])appoVector.toArray(new I5_2TEST_AVANZ_COSTI_RICAVI_ROW[1]);
      session.setAttribute( "aRemoteTEST_AVANZ_COSTI_RICAVI_ROW", aRemote);
    }else{
      session.setAttribute( "aRemoteTEST_AVANZ_COSTI_RICAVI_ROW", null);    
    }  
  }    
%>
  <!-- Gestione navigazione-->
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="cbn1_ver_sar_lista_account_cl.jsp">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/avanzamricavi.gif" alt="" border="0"></td>
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Verifica stato avanzamento costi</td>
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
<form name="frmDati" method="get" action="flag_lancio.jsp">
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
                    </tr>
                   <tr>
                      <td bgcolor='#EBF0F0' class="textB" ><%=Code_elab%></td>      
                      <td bgcolor='#EBF0F0' class="textB" ><%=remoteElabBatch.getData_ora_inizio_elab_batch()%></td>
                      <td bgcolor='#EBF0F0' class="textB" ><%=remoteElabBatch.getData_ora_fine_elab_batch()%></td>      
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
                          <td bgcolor='#D5DDF1' class="textB" >Mese</td>      
                          <td bgcolor='#D5DDF1' class="textB" >Anno</td>
                          <td bgcolor='#D5DDF1' class="textB" >&nbsp;</td>
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote.length%>">
<pg:param name="txtTypeLoad" value="1"></pg:param>
<pg:param name="CodSel" value="<%=selCODE%>"></pg:param>
<pg:param name="txtCliente" value=""></pg:param>
<pg:param name="code_elab_flag_sys" value="<%=ElabBatchSelezionato%>"></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>                        
<%
///pagerPageNumber= new Integer(6);
      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote.length) && (j<pagerPageNumber.intValue()*records_per_page));j++)      
      {
         ChiaveAccount= aRemote[j].getCode_Account() + "," + aRemote[j].getCode_Stato_Avanz_Ricavi();
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";
         if (selCODE!=null){
            if(ChiaveAccount.equals(selCODE)){
              sChecked="checked";
              bCheck=true;
            }else{
              sChecked="";
            }
         }  else {   
            if (i==0) {
              sChecked="checked";
              bCheck=true;              
            }else{  
              sChecked="";
            }
         }          
%>
                        <TR>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= aRemote[j].getNome_Rag_Soc_Gest() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= aRemote[j].getDesc_Account() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= aRemote[j].getAnno() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= aRemote[j].getMese() %></TD>
                           <td bgcolor='white'>
<%
            if (aRemote[j].getCode_Stato_Batch().equals("SUCC")){
                      i+=1;
%>
                              <input type="radio" name="ChiaveAccount" <%=sChecked%> value="<%=ChiaveAccount%>" onclick=ChangeSel('<%=ChiaveAccount%>','<%=i%>') >
<%
            
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
      <input type="Hidden" name="strUrl" value="verifica_congelamento_sar_cl.jsp" >
      <input type="Hidden" name="strMessaggio" value="<%=response.encodeURL("Verifica degli account selezionati")%>" >
      <input class="textB" type="hidden" name="code_elab_flag_sys" value="<%=ElabBatchSelezionato%>">          
      <input class="textB" type="hidden" name="CodSel" value="<%=selCODE%>">              
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <td class="textB" bgcolor="#D5DDF1" align="center" colspan="5">
            <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />	                  
	        </td>
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
    Disable(document.frmDati.CONGELA_TUTTI);
    Disable(document.frmDati.CONGELA_SEL);    
<%
}else{
  if (!bCheck){
    if (i==1){
%>
    document.frmDati.ChiaveAccount.checked=true;
<%    
    }else{    
%>
    document.frmDati.ChiaveAccount[0].checked=true;
<% 
    }
  }
}  
%>
</script>
</BODY>
</HTML>