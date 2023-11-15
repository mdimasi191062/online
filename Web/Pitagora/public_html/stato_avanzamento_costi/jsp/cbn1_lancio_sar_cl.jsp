<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.rmi.*,com.ejbSTL.*,com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Collection" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_lancio_sar_cl.jsp")%>
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
  I5_1ACCOUNTPK PrimaryKey = null;
  I5_2TEST_AVANZ_COSTI_RICAVI_ROW[] aRemote_TEST_ACR_ROW = null;  
  Object homeObject = null;
  int j=0;
  Collection collection=null;
  String Desc_Account = null;
  String sSELECTED = null;    
    //Contratti selezionati sulla maschera com_tc_001
  String  codiceTipoContratto = null;
    //Individua se vuoto che dobbiamo caricare i periodi di competenza altrimenti contiene il periodo selezionato
  String  CaricaPeriodo = null;
  codiceTipoContratto = request.getParameter("codiceTipoContratto");
  CaricaPeriodo = request.getParameter("CaricaPeriodo");  
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
  DisableAllControls(objForm);
  objForm.submit();
}

function PopolaAccount(){
  window.document.frmDati.action="cbn1_lancio_sar_cl.jsp";
  window.document.frmDati.submit();
}

</SCRIPT>


<TITLE>Lancio Batch Calcolo Penali Mensili</TITLE>
</HEAD>
<BODY >
<% if (CaricaPeriodo!=null) {%>
<EJB:useHome id="home" type="com.ejbBMP.I5_1ACCOUNTHome" location="I5_1ACCOUNT" />
<%
    aRemote_TEST_ACR_ROW = (I5_2TEST_AVANZ_COSTI_RICAVI_ROW[]) session.getAttribute("aRemote_TEST_ACR_ROW");
    collection = home.findAll_SAR(codiceTipoContratto,CaricaPeriodo.substring(0,4),CaricaPeriodo.substring(4));      
    if (!(collection==null || collection.size()==0)) {
      aRemote = (I5_1ACCOUNT[]) collection.toArray( new I5_1ACCOUNT[1]);
    }  
  } else {
%>
<EJB:useHome id="home_TEST_ACR" type="com.ejbSTL.I5_2TEST_AVANZ_COSTI_RICAVIHome" location="I5_2TEST_AVANZ_COSTI_RICAVI" />
<EJB:useBean id="remote_TEST_ACR" type="com.ejbSTL.I5_2TEST_AVANZ_COSTI_RICAVI" scope="session">
  <EJB:createBean instance="<%=home_TEST_ACR.create()%>" />
</EJB:useBean>
<%
    collection = remote_TEST_ACR.findAllPC(codiceTipoContratto);      
    if (!(collection==null || collection.size()==0)) {
      aRemote_TEST_ACR_ROW = (I5_2TEST_AVANZ_COSTI_RICAVI_ROW[]) collection.toArray( new I5_2TEST_AVANZ_COSTI_RICAVI_ROW[1]);
      session.setAttribute( "aRemote_TEST_ACR_ROW", aRemote_TEST_ACR_ROW); 
    }else{      
      session.setAttribute( "aRemote_TEST_ACR_ROW", null);     
    }  
  } 
%>
<form name="frmDati" method="get" action="flag_lancio.jsp">
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">Lancio stato avanzamento costi</td>
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
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">Periodo di compentenza</td>
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
                          <td bgcolor='#D5DDF1' class="text" >
                            <Select class="text" name="CaricaPeriodo" size="1" >
  <% 
  if (!((aRemote_TEST_ACR_ROW==null)||(aRemote_TEST_ACR_ROW.length==0))) {
      for(j=0;(j<aRemote_TEST_ACR_ROW.length);j++)
      {
        sSELECTED="";
        if (CaricaPeriodo!=null){
          if (CaricaPeriodo.equals(aRemote_TEST_ACR_ROW[j].getAnno() + aRemote_TEST_ACR_ROW[j].getMese())){
            sSELECTED="SELECTED";           
          }
        } else {
          if (j==0){
            sSELECTED="SELECTED";
          }
        }

%>
                            
                           <option class="text" value="<%=aRemote_TEST_ACR_ROW[j].getAnno() + aRemote_TEST_ACR_ROW[j].getMese()%>" <%=sSELECTED%>><%=aRemote_TEST_ACR_ROW[j].getPeriodoCompetenza()%></option>

<%
      }
  }
%>
                            </select>                          
                          </td>      
                          <td class="textB">
                            <input class="textB" type="button" name="cmdPopolaAccount" value="Popola Account" onClick="PopolaAccount();">
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
                        <tr>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                        <TR> 
                          <td class="textB" valign="top" width="30%">&nbsp;Account</td>
                          <td class="text" align="left" width="70%">
                            <Select class="text" name="cmbAccount" size="7" multiple style="width: 80%;" >
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
                      <td  bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td>
                        <table align='center' width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                        <tr>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                        <TR> 
                          <td class="textB" valign="top" width="30%">&nbsp;Account</td>
                          <td class="text" align="left" width="70%">
                            <Select class="text" name="cmbRiepilogoAccount" size="7" style="width: 80%;">
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
      <input type="Hidden" name="strUrl" value="verifica_lancio_sar_cl.jsp" >
      <input type="Hidden" name="strMessaggio" value="<%=response.encodeURL("Verifica degli account selezionati")%>" >   
      <input type="Hidden" name="codiceTipoContratto" value="<%=codiceTipoContratto%>" >          

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
  document.frmDati.cmbRiepilogoAccount.options[0] = null;
  document.frmDati.cmbAccount.options[0] = null;	
<%
    if ((aRemote_TEST_ACR_ROW==null)||(aRemote_TEST_ACR_ROW.length==0)) { 
%>        
    Disable(document.frmDati.cmdPopolaAccount);
<%    
    }
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
