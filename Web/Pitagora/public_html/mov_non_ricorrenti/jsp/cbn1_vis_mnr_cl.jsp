<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbBMP.*,com.ejbSTL.*,com.utl.*,com.usr.*,java.util.Collection,java.util.Vector" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_vis_mnr_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  boolean bCheck = false;
  I5_2MOV_NON_RICEJB remote=null;
  String bErrore = null;
  String bgcolor="";
  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
  int i=0;  
  int j=0;
  int iPagina=0;  
  String selCODE_MOVIM =null;
  String sChecked="checked";
     // This is the variable we will store all records in.
  Collection collection=null;
  I5_2MOV_NON_RICEJB[] aRemote = null;
  bErrore = request.getParameter("bErrore");
  if (bErrore!=null){
     selCODE_MOVIM =(String) session.getAttribute("CODE_MOV_NON_RIC");
    }  
  else {
     selCODE_MOVIM =request.getParameter("CodSel");
    }
  Vector vettore = new Vector();
  DatiOcc[] vettArray = null;

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Visualizzazione movimenti non ricorrenti</title>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<script language="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<script language="JavaScript">
function ONANNULLA()
{  
     window.location.href="cbn1_lista_mnr_cl.jsp?txtTypeLoad=0";
}
</SCRIPT>
<TITLE>Visualizzazione Movimento</TITLE>
</HEAD>
<BODY>
<EJB:useHome id="home" type="com.ejbSTL.FILTRO_MOV_NON_RICEJBHome" location="FILTRO_MOV_NON_RICEJB" />
<EJB:useBean id="remoto" type="com.ejbSTL.FILTRO_MOV_NON_RICEJB" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
     vettore = remoto.FindOcc(selCODE_MOVIM);
     if (!(vettore==null || vettore.size()==0)) 
     {
        vettArray = (DatiOcc[]) vettore.toArray( new DatiOcc[1]);
        session.setAttribute( "vettArray", vettArray);
     }  
     DatiOcc DatiOcc = vettArray[0];
     String desc_acc = DatiOcc.get_desc_account();
     String desc_forn = DatiOcc.get_desc_forn();
     String dest_mov = DatiOcc.get_desc_mov();
     java.util.Date data_fatt = DatiOcc.get_data_fatrb();
     java.util.Date data_tran = DatiOcc.get_data_transaz();
     String importo = DatiOcc.get_importo();         
     String flag_ft = DatiOcc.get_flag_fatt();
     String flag_da = DatiOcc.get_flag_d_a();
     String mese = DatiOcc.get_mese();
     if (mese==null){
         mese="";
     }else if(mese.equals("1")){
      mese="Gennaio";
     }else if(mese.equals("2")){
      mese="Febbraio";
     }else if(mese.equals("3")){
      mese="Marzo";
     }else if(mese.equals("4")){
      mese="Aprile";
     }else if(mese.equals("5")){
      mese="Maggio";
     }else if(mese.equals("6")){
      mese="Giugno";
     }else if(mese.equals("7")){
      mese="Luglio";
     }else if(mese.equals("8")){
      mese="Agosto";
     }else if(mese.equals("9")){
      mese="Settembre";
     }else if(mese.equals("10")){
      mese="Ottobre";
     }else if(mese.equals("11")){
      mese="Novembre";
     }else if(mese.equals("12")){
      mese="Dicembre";
     }      
     String anno = DatiOcc.get_anno();
     if (anno==null){
         anno="";
     }
     String desc_ogg = DatiOcc.get_desc_oggetto();
     String desc_classe = DatiOcc.get_desc_classe();
     String code_istanza = DatiOcc.get_code_istanza();
     if (code_istanza==null){
         code_istanza="";
     }
     String destinazione = null;
     if(flag_ft.equals("N")) 
     {
        destinazione = "Nota di Credito";
     }
     if((flag_ft.equals("F")) &&
        (flag_da.equals("C")))
     {
        destinazione = "Fattura - Credito";
     }
     if((flag_ft.equals("F")) &&
        (flag_da.equals("D")))
     {
        destinazione = "Fattura - Debito";
     }

%>
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/movnonric.gif" alt="" border="0"></td>
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Visualizzazione Movimenti non Ricorrenti</td>
                <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
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
  <!-- Gestione navigazione-->
<form name="frmSearch" method="get" action='elimina_mov_non_ric_cl.jsp'> 
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Dati di riferimento</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr>
                      <td colspan='4' bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <input type='hidden' name="txtOccorrenzaCanc" value="<%=selCODE_MOVIM%>">
                      <td class="textB" align="right" width="30%">Fornitore:</td>
                      <td class="text">&nbsp;<%=desc_forn%></td>
                      <td class="textB" align="right">Account:</td>
                      <td class="text">&nbsp;<%=desc_acc%></td>
                    </tr>
                    <tr>
                      <td colspan='4'>&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan='1' class="textB" align="right">Classe Oggetto di Fatturazione:</td>
                      <td colspan='3' class="text">&nbsp;<%=desc_classe%></td>
                    </tr>
                    <tr>
                      <td colspan='4' >&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="1" class="textB" align="right">Oggetto di fatturazione:</td>
                      <td colspan="3" class="text">&nbsp;<%=desc_ogg%></td>
                    </tr>
                    <tr>
                      <td colspan='4' class="textB" align="right">&nbsp;</td>
                    </tr>
                    <tr>
                      <td  class="textB" align="right">Codice Istanza PS:</td>
                      <td  colspan='3' class="text" align="left">&nbsp;<%=code_istanza%></td>
                    </tr>   
                  </table>
                </td>
              </tr>
            </table>
					</td>
        </tr>
        <tr>
          <td colspan='3' bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='2'></td>
        </tr>
      </table>
    </td>
  </tr>      
  <tr>
    <td>
      <table border="0" width="100%" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
            <tr>
              <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Dati movimento</td>
              <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
            </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
              <tr>
                <td colspan='4' bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='2'></td>
              </tr>
              <tr>
                <td colspan='1' class="textB" align="right" width="30%">Data transazione:</td>
                <td colspan='3' class="text" align="left">&nbsp;<%=df.format(data_tran)%></td>
              </tr>   
              <tr>
                <td colspan='4' class="textB" align="right">&nbsp;</td>
              </tr>
              <tr>
                <td colspan='1' class="textB" align="right">Descrizione:</td>
                <td colspan='3' class="text" align="left">&nbsp;<%=dest_mov%></td>
              </tr>   
              <tr>
                <td colspan='4' class="textB" align="right">&nbsp;</td>
              </tr>
              <tr>
                <td colspan='1' class="textB" align="right">Importo:</td>
                <td colspan='3' class="text" align="left">&nbsp;<%=importo%></td>
              </tr>   
              <tr>
                <td colspan='4' class="textB" align="right">&nbsp;</td>
              </tr>
              <tr>
                <td colspan='1' class="textB" align="right">Data Fatturabilità:</td>
                <td colspan='3' class="text">&nbsp;<%=df.format(data_fatt)%></td>
              </tr>
              <tr>
                <td colspan='4' class="textB" align="right">&nbsp;</td>
              </tr>
              <tr>
                <td colspan='1' class="textB" align="right">Destinazione Movimento:</td>
                <td colspan='3' class="text">&nbsp;<%=destinazione%></td>
              </tr>
              <tr>
                <td colspan='4' class="textB" align="right">&nbsp;</td>
              </tr>
              <tr>
                <td class="textB" align="right">Mese Riferimento Fattura:</td>
                <td class="text" width="10%">&nbsp;<%=mese%></td>
                <td  class="textB" align="right" >Anno Riferimento Fattura:</td>
                <td  class="text" align="right">&nbsp;<%=anno%></td>
              </tr>   
              <tr>
                <td colspan='4' class="textB" align="right">&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>                  
      </table>
    </td>
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
</BODY>
</HTML>
