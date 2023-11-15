<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.rmi.*,com.ejbBMP.*,com.ejbSTL.*,com.utl.*,com.usr.*,java.util.Collection,java.text.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_lancio_calc_penali_cl.jsp")%>
</logtag:logData>
<% 
  response.addHeader("Pragma", "no-cache"); 
  response.addHeader("Cache-Control", "no-store");
    //---------------------------------------------------------------------------------
    //                                Dichiarazioni
    //---------------------------------------------------------------------------------    
    //Interfaccia Remota I5_1ACCOUNT
  I5_1ACCOUNT remote = null;       
  I5_1ACCOUNT[] aRemote = null;
  I5_1ACCOUNT[] aRemote_anomali = null;    
  I5_1ACCOUNTPK PrimaryKey = null;
  I5_2PARAM_VALORIZ_CL_ROW rowPARAM_VALORIZ =null;
  int j=0;
  Collection collection=null;
  String Desc_Account = null;
  String sSELECTED = null;   
  String strData="";
    //Contratti selezionati sulla maschera com_tc_001
  String  codiceTipoContratto = null;
  String sMessaggio = null;
  sMessaggio = request.getParameter("sMessaggio");  
  if (sMessaggio==null){
    codiceTipoContratto = request.getParameter("codiceTipoContratto");
    session.setAttribute( "codiceTipoContratto", codiceTipoContratto);  
  } else {  
    codiceTipoContratto = (String) session.getAttribute( "codiceTipoContratto");  
  }
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">

function ONINSERISCI_SEL(){
  if (document.frmDati.cmbAccount.selectedIndex>-1) {
  	testo=document.frmDati.cmbAccount.options[document.frmDati.cmbAccount.selectedIndex].text;
    valore=document.frmDati.cmbAccount.options[document.frmDati.cmbAccount.selectedIndex].value;
  	seloption=new Option(testo, valore);
    document.frmDati.cmbRiepilogoAccount.options[document.frmDati.cmbRiepilogoAccount.length] = seloption;
  	document.frmDati.cmbAccount.options[document.frmDati.cmbAccount.selectedIndex] = null;	
    Enable(document.frmDati.LANCIOBATCH);
  }
}
function ONINSERISCI_TUTTI(){
  for (i=0;i<document.frmDati.cmbAccount.options.length;i++) {
  	testo=document.frmDati.cmbAccount.options[i].text;
    valore=document.frmDati.cmbAccount.options[i].value;
  	seloption=new Option(testo, valore);
  	document.frmDati.cmbRiepilogoAccount.options[document.frmDati.cmbRiepilogoAccount.length] = seloption;	
  }
  for (i=document.frmDati.cmbAccount.options.length;i>=0;i--) {
  	document.frmDati.cmbAccount.options[i] = null;	
  }
  Enable(document.frmDati.LANCIOBATCH);
}

function ONELIMINA(){
  if (document.frmDati.cmbRiepilogoAccount.selectedIndex>-1) {
  	testo=document.frmDati.cmbRiepilogoAccount.options[document.frmDati.cmbRiepilogoAccount.selectedIndex].text;
    valore=document.frmDati.cmbRiepilogoAccount.options[document.frmDati.cmbRiepilogoAccount.selectedIndex].value;
  	seloption=new Option(testo, valore);
  	document.frmDati.cmbAccount.options[document.frmDati.cmbAccount.length] = seloption;
    document.frmDati.cmbRiepilogoAccount.options[document.frmDati.cmbRiepilogoAccount.selectedIndex] = null;	
    if (document.frmDati.cmbRiepilogoAccount.options.length==0){
        Disable(document.frmDati.LANCIOBATCH);
    }
  }
}
function ONLANCIOBATCH(){
  objForm=window.document.frmDati
  for (i=0;i<objForm.cmbRiepilogoAccount.options.length;i++) {
    objForm.RiepilogoAccount.value=objForm.RiepilogoAccount.value + objForm.cmbRiepilogoAccount.options[i].value + ",";
  }
  objForm.submit();
}

</SCRIPT>


<TITLE>Lancio Batch Calcolo Penali Mensili</TITLE>
</HEAD>
<BODY >
<EJB:useHome id="home_PARAM_VALORIZ_CL" type="com.ejbSTL.I5_2PARAM_VALORIZ_CLHome" location="I5_2PARAM_VALORIZ_CL" />
<EJB:useBean id="remote_PARAM_VALORIZ_CL" type="com.ejbSTL.I5_2PARAM_VALORIZ_CL" scope="session">
  <EJB:createBean instance="<%=home_PARAM_VALORIZ_CL.create()%>" />
</EJB:useBean>
<%
  rowPARAM_VALORIZ =  remote_PARAM_VALORIZ_CL.CicloDiFatturazione(codiceTipoContratto);
  if (rowPARAM_VALORIZ != null){
    SimpleDateFormat objDateformat = new SimpleDateFormat("dd/MM/yyyy");

    strData = objDateformat.format(rowPARAM_VALORIZ.getData_inizio_ciclo_fatrz())
    + " - " + objDateformat.format(rowPARAM_VALORIZ.getData_fine_ciclo_fatrz());
    
    session.setAttribute( "rowPARAM_VALORIZ", rowPARAM_VALORIZ);   
%>
<EJB:useHome id="home" type="com.ejbBMP.I5_1ACCOUNTHome" location="I5_1ACCOUNT" />
<%
      //Prendo le informazioni del tipo codice contratto che deve essere filtrato
    collection = home.findAll_CPM(codiceTipoContratto,rowPARAM_VALORIZ.getData_inizio_ciclo_fatrz());      
    if (!(collection==null || collection.size()==0)) {
      aRemote = (I5_1ACCOUNT[]) collection.toArray( new I5_1ACCOUNT[1]);
    }  
      //Prendo le informazioni del tipo codice contratto che deve essere filtrato
    collection = home.findAll_CPM_anomali(codiceTipoContratto,rowPARAM_VALORIZ.getData_inizio_ciclo_fatrz());      
    if (!(collection==null || collection.size()==0)) {
      aRemote_anomali = (I5_1ACCOUNT[]) collection.toArray( new I5_1ACCOUNT[1]);
    }  
  }    
%>
<form name="frmDati" method="get" action="flag_lancio.jsp">
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">Lancio Batch Calcolo Penali Mensili</td>
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
            <table border="0" width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">Ciclo di fatturazione di riferimento</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">                 
                    <tr>
                      <td>
                        <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                        <tr>
                          <td bgcolor='#D5DDF1' class="textB" >
                            <%=strData%>
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
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">Dati Cliente</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">                    
                    <tr>
                      <td>
                        <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                        <TR> 
                          <td width='20%' class="textB" >Account</td>      
                          <td class="text">
                            <Select class="text" name="cmbAccount" size="6" style="width: 80%;" >
                            <option class="text">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                            
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                            
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </option>                            
  <% 
  if (!((aRemote==null)||(aRemote.length==0))) {
      for(j=0;(j<aRemote.length);j++)
      {
         remote = (I5_1ACCOUNT) PortableRemoteObject.narrow(aRemote[j],I5_1ACCOUNT.class);                                                  
         PrimaryKey    = (I5_1ACCOUNTPK) remote.getPrimaryKey();                     
         Desc_Account    = remote.getDesc_Account();
         if (j==0){
           sSELECTED="SELECTED";
         }else { 
           sSELECTED="";
         }
%>
                            
                           <option class="text" value="<%=PrimaryKey.getCode_account() + "," + PrimaryKey.getFlag_sys()%>" <%=sSELECTED%>><%=Desc_Account%></option>

<%
      }
  }
%>
                            </select>
                          </td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                        
                        </table>
                      </td>                      
                    </tr>        
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">Riepilogo</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">                    
                    <tr>
                      <td>
                        <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                        <TR> 
                          <td width='20%' class="textB" >Account Anomali</td>      
                          <td class="text">
                            <Select class="text" name="cmbAccountAnomali" size="7" style="width: 80%;">
                            <option class="text">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                            
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                            
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </option>
  <% 
  if (!((aRemote_anomali==null)||(aRemote_anomali.length==0))) {
      for(j=0;(j<aRemote_anomali.length);j++)
      {
         remote = (I5_1ACCOUNT) PortableRemoteObject.narrow(aRemote_anomali[j],I5_1ACCOUNT.class);                                                  
         PrimaryKey    = (I5_1ACCOUNTPK) remote.getPrimaryKey();                     
         Desc_Account    = remote.getDesc_Account();
%>
                            
                           <option class="text" value="<%=PrimaryKey.getCode_account() + "," + PrimaryKey.getFlag_sys()%>"><%=Desc_Account%></option>

<%
      }
  }
%>
                            </select>
                          </td>
                        </tr>                        
                        <tr>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                        <TR> 
                          <td width='20%' class="textB" >Account</td>      
                          <td class="text">
                            <Select class="text" name="cmbRiepilogoAccount" size="6" multiple style="width: 80%;">
                            <option class="text">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                            
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                            
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </option>
                            </select>
                          </td>
                        </tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
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
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
      <input type="Hidden" name="RiepilogoAccount" value="" >
      <input type="Hidden" name="strUrl" value="verifica_lancio_cpm_cl.jsp" >
      <input type="Hidden" name="strMessaggio" value="<%=response.encodeURL("Verifica degli account selezionati")%>" >
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
  document.frmDati.cmbAccountAnomali.options[0] = null;
  document.frmDati.cmbRiepilogoAccount.options[0] = null;
  document.frmDati.cmbAccount.options[0] = null;	
<%
    if (sMessaggio != null ) { 
%>   
    alert('Non é possibile lanciare la procedura batch di Calcolo Penali Mensili in quanto tutti gli account selezionati hanno le fatture non congelate');
<%
    }
%>    
<%
    if ((aRemote==null)||(aRemote.length==0)) { 
%>    
    Disable(document.frmDati.INSERISCI_SEL);
    Disable(document.frmDati.INSERISCI_TUTTI);
    Disable(document.frmDati.ELIMINA);
<%    
    }
%>    
    Disable(document.frmDati.LANCIOBATCH);
</script>
</BODY>
</HTML>
