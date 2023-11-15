<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.rmi.*,com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Collection" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_lancio_csi_cl.jsp")%>
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
  Object homeObject = null;
  int j=0;
  Collection collection=null;
  String Desc_Account = null;
  String sSELECTED = null;    
    //Contratti selezionati sulla maschera com_tc_001
  String  codiceTipoContratto = null;
  codiceTipoContratto = request.getParameter("codiceTipoContratto");
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


<TITLE>Lancio Confronto Storico Inventario</TITLE>
</HEAD>
<BODY >
<EJB:useHome id="home" type="com.ejbBMP.I5_1ACCOUNTHome" location="I5_1ACCOUNT" />
<%
    //Prendo le informazioni del tipo codice contratto che deve essere filtrato
  collection = home.findAll(codiceTipoContratto);      
  if (!(collection==null || collection.size()==0)) {
    aRemote = (I5_1ACCOUNT[]) collection.toArray( new I5_1ACCOUNT[1]);
  }  
%>
<form name="frmDati" method="get" action="flag_lancio.jsp">
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">Lancio Confronto Storico Inventario</td>
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
                          <td class="textB" valign="top" width="20%">&nbsp;Account</td>
                          <td class="text">
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
                      <td colspan='1' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td>
                        <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                          <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                          </tr>
                        <TR> 
                          <td class="textB" valign="top" width="20%">&nbsp;Account</td>
                          <td class="text">
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
      <input type="Hidden" name="strUrl" value="verifica_lancio_csi_cl.jsp" >
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
  document.frmDati.cmbRiepilogoAccount.options[0] = null;
  document.frmDati.cmbAccount.options[0] = null;	
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
