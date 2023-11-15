<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*, com.utl.*,com.usr.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"agg_gestore.jsp")%>
</logtag:logData>

<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  String strMessaggioFunz="";
  

    //Gestione Paramteri Navigazione
  String CodSel = request.getParameter("CodSel");
  int Operazione = Integer.parseInt(request.getParameter("Operazione"));
  String strQueryString = request.getQueryString();

  String CODE_GEST=null;
  String CODE_TIPOL_OPERATORE=null;
  String CODE_TIPO_GEST=null;
  String CODE_COMUNE_SEDE_LEGALE=null;
  String CODE_COMUNE_SEDE_CENTRALE=null;
  String NOME_RAG_SOC_GEST=null;
  String NOME_GEST_SIGLA=null;
  String CODE_PARTITA_IVA=null;
  String INDR_VIA_SEDE_LEGALE=null;
  String INDR_CIV_SEDE_LEGALE=null;
  String CODE_CAP_SEDE_LEGALE=null;
  String INDR_TEL_SEDE_LEGALE=null;
  String INDR_FAX_SEDE_LEGALE=null;
  String INDR_VIA_SEDE_CENTRALE=null;
  String INDR_CIV_SEDE_CENTRALE=null;
  String CODE_CAP_SEDE_CENTRALE=null;
  String INDR_TEL_SEDE_CENTRALE=null;
  String INDR_FAX_SEDE_CENTRALE=null;
  String INDR_INTERNET=null;
  String TEXT_NOTE=null;
  Integer QNTA_DIP=null;
  String TEXT_ALLEANZE=null;
  String TEXT_INFO_ESTERO=null;
  String TEXT_DIP=null;
  String TEXT_TIPOL_OPERATORE=null;
  String CODE_GEST_TIRKS=null;

  CODE_GEST = request.getParameter("CodSel");


%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>Gestione Gestore Normalizzato</title>
</head>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<script language="JavaScript">

function impostaFocus()
{

  for(var i=0;i<document.forms[0].elements.length;i++)
  {
      if(document.forms[0].elements[i].type=="text")
      {      
        document.forms[0].elements[i].focus();
        break;
      }
  }
}   



function ONANNULLA()
{
   window.close();
}   
function ONCONFERMA()
{
  if(document.frmDati.QNTA_DIP.value.length>0)
  {
    if(!CheckNum(document.frmDati.QNTA_DIP.value))
    {
      alert("Formato Numerico non valido!")
      document.frmDati.QNTA_DIP.focus();
      return;
    }
  }
  if(document.frmDati.TEXT_NOTE.value.length>500)
  {
      alert("Il campo non può contenere più di 500 caratteri!")
      document.frmDati.TEXT_NOTE.focus();
      return;
  }
  if(document.frmDati.TEXT_ALLEANZE.value.length>500)
  {
      alert("Il campo non può contenere più di 500 caratteri!")
      document.frmDati.TEXT_ALLEANZE.focus();
      return;
  }
  if(document.frmDati.TEXT_INFO_ESTERO.value.length>500)
  {
      alert("Il campo non può contenere più di 500 caratteri!")
      document.frmDati.TEXT_INFO_ESTERO.focus();
      return;
  }
  if(document.frmDati.TEXT_DIP.value.length>100)
  {
      alert("Il campo non può contenere più di 100 caratteri!")
      document.frmDati.TEXT_DIP.focus();
      return;
  }
  if(document.frmDati.TEXT_TIPOL_OPERATORE.value.length>250)
  {
      alert("Il campo non può contenere più di 250 caratteri!")
      document.frmDati.TEXT_TIPOL_OPERATORE.focus();
      return;
  }
  document.frmDati.submit();
}   


</script>
<body onLoad="impostaFocus()">
<form name="frmDati" method="post" action='salva_gestore.jsp?<%=strQueryString%>'>
<EJB:useHome id="home" type="com.ejbSTL.I5_3GEST_TLCejbHome" location="I5_3GEST_TLCejb" />  
<EJB:useBean id="gestori" type="com.ejbSTL.I5_3GEST_TLCejb" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>


<% 
          I5_3GEST_TLC_ROW row = gestori.loadGestNorm(CODE_GEST);        
          CODE_TIPOL_OPERATORE = row.getCODE_TIPOL_OPERATORE();
          CODE_TIPO_GEST = row.getCODE_TIPO_GEST();
          CODE_COMUNE_SEDE_LEGALE = row.getCODE_COMUNE_SEDE_LEGALE();
          CODE_COMUNE_SEDE_CENTRALE = row.getCODE_COMUNE_SEDE_CENTRALE();
          NOME_RAG_SOC_GEST = row.getNOME_RAG_SOC_GEST();
          NOME_GEST_SIGLA = row.getNOME_GEST_SIGLA();
          CODE_PARTITA_IVA = row.getCODE_PARTITA_IVA();
          INDR_VIA_SEDE_LEGALE = row.getINDR_VIA_SEDE_LEGALE();
          INDR_CIV_SEDE_LEGALE = row.getINDR_CIV_SEDE_LEGALE();
          CODE_CAP_SEDE_LEGALE = row.getCODE_CAP_SEDE_LEGALE();
          INDR_TEL_SEDE_LEGALE = row.getINDR_TEL_SEDE_LEGALE();
          INDR_FAX_SEDE_LEGALE = row.getINDR_FAX_SEDE_LEGALE();
          INDR_VIA_SEDE_CENTRALE = row.getINDR_VIA_SEDE_CENTRALE();
          INDR_CIV_SEDE_CENTRALE = row.getINDR_CIV_SEDE_CENTRALE();
          CODE_CAP_SEDE_CENTRALE = row.getCODE_CAP_SEDE_CENTRALE();
          INDR_TEL_SEDE_CENTRALE = row.getINDR_TEL_SEDE_CENTRALE();
          INDR_FAX_SEDE_CENTRALE = row.getINDR_FAX_SEDE_CENTRALE();
          INDR_INTERNET = row.getINDR_INTERNET();
          TEXT_NOTE = row.getTEXT_NOTE();
          QNTA_DIP = row.getQNTA_DIP();
          TEXT_ALLEANZE = row.getTEXT_ALLEANZE();
          TEXT_INFO_ESTERO = row.getTEXT_INFO_ESTERO();
          TEXT_DIP = row.getTEXT_DIP();
          TEXT_TIPOL_OPERATORE = row.getTEXT_TIPOL_OPERATORE();
          CODE_GEST_TIRKS = row.getCODE_GEST_TIRKS();
%>
<!--<input type="hidden" name="strQueryString" value="<%=strQueryString%>">-->
<table align='center' width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="../images/gestgestnorm.gif" alt="" border="0"></td>
  <tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
						<tr>
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Modifica Gestore Normalizzato</td>
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
        <table align='center' width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
          <tr> 
            <td  class="textB" align="left">Codice Gestore:</td>
            <td  class="text" align="left"> 
              <input type="hidden" name="CODE_GEST" value="<%=CODE_GEST%>">
              <%=CODE_GEST%> </td>
            <td  class="textB" align="left">Sigla:</td>
            <td  class="text" align="left">
              <%if (Operazione==0){%>
              <input class="text" type="text" name="NOME_GEST_SIGLA" value="<%if(NOME_GEST_SIGLA!=null){out.println(NOME_GEST_SIGLA);}%>" maxlength="15" size="10">
              <%}else{if(NOME_GEST_SIGLA!=null){out.println(NOME_GEST_SIGLA);}else{out.println("&nbsp;");}}%>
            </td>
          </tr>
          <tr> 
            <td  class="textB" align="left">Ragione Sociale:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <input class="text" type="TEXT" name="NOME_RAG_SOC_GEST" value="<%if(NOME_RAG_SOC_GEST!=null){out.println(NOME_RAG_SOC_GEST);}%>" maxlength="50" size="25">
              <%}else{if(NOME_RAG_SOC_GEST!=null){out.println(NOME_RAG_SOC_GEST);}else{out.println("&nbsp;");}}%>
            </td>
            <td  class="textB" align="left">Partita IVA:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <input class="text" type="TEXT" name="CODE_PARTITA_IVA" value="<%if(CODE_PARTITA_IVA!=null){out.println(CODE_PARTITA_IVA);}%>" maxlength="16" size="16">
              <%}else{if(CODE_PARTITA_IVA!=null){out.println(CODE_PARTITA_IVA);}else{out.println("&nbsp;");}}%>
            </td>
          </tr>
          <tr> 
            <td  class="textB" align="left">Tipologia Operatore:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <input class="text" type="TEXT" name="CODE_TIPOL_OPERATORE" value="<%if(CODE_TIPOL_OPERATORE!=null){out.println(CODE_TIPOL_OPERATORE);}%>" maxlength="3" size="3">
              <%}else{if(CODE_TIPOL_OPERATORE!=null){out.println(CODE_TIPOL_OPERATORE);}else{out.println("&nbsp;");}}%>              
            </td>
            <td  class="textB" align="left">Codice Tipo Gestore:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <input class="text" type="TEXT" name="CODE_TIPO_GEST" value="<%if(CODE_TIPO_GEST!=null){out.println(CODE_TIPO_GEST);}%>" maxlength="3" size="3">
              <%}else{if(CODE_TIPO_GEST!=null){out.println(CODE_TIPO_GEST);}else{out.println("&nbsp;");}}%>              
            </td>
          </tr>
          <tr> 
            <td  class="textB" align="left">Comune Sede Centrale:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <input class="text" type="TEXT" name="CODE_COMUNE_SEDE_CENTRALE" value="<%if(CODE_COMUNE_SEDE_CENTRALE!=null){out.println(CODE_COMUNE_SEDE_CENTRALE);}%>" maxlength="5" size="5">
              <%}else{if(CODE_COMUNE_SEDE_CENTRALE!=null){out.println(CODE_COMUNE_SEDE_CENTRALE);}else{out.println("&nbsp;");}}%>              
            </td>
            <td  class="textB" align="left">Comune Sede Legale:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <input class="text" type="TEXT" name="CODE_COMUNE_SEDE_LEGALE" value="<%if(CODE_COMUNE_SEDE_LEGALE!=null){out.println(CODE_COMUNE_SEDE_LEGALE);}%>" maxlength="5" size="5">
              <%}else{if(CODE_COMUNE_SEDE_CENTRALE!=null){out.println(CODE_COMUNE_SEDE_CENTRALE);}else{out.println("&nbsp;");}}%>              
            </td>
          </tr>
          <tr> 
            <td  class="textB" align="left">Indirizzo Sede Centrale:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <input class="text" type="TEXT" name="INDR_VIA_SEDE_CENTRALE" value="<%if(INDR_VIA_SEDE_CENTRALE!=null){out.println(INDR_VIA_SEDE_CENTRALE);}%>" maxlength="70" size="20">
              <%}else{if(INDR_VIA_SEDE_CENTRALE!=null){out.println(INDR_VIA_SEDE_CENTRALE);}else{out.println("&nbsp;");}}%>              
            </td>
            <td  class="textB" align="left">Indirizzo Sede Legale:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <input class="text" type="TEXT" name="INDR_VIA_SEDE_LEGALE" value="<%if(INDR_VIA_SEDE_LEGALE!=null){out.println(INDR_VIA_SEDE_LEGALE);}%>" maxlength="70" size="20">
              <%}else{if(INDR_VIA_SEDE_LEGALE!=null){out.println(INDR_VIA_SEDE_LEGALE);}else{out.println("&nbsp;");}}%>              
            </td>
          </tr>
          <tr> 
            <td  class="textB" align="left">Numero Civico Sede Centrale:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <input class="text" type="TEXT" name="INDR_CIV_SEDE_CENTRALE" value="<%if(INDR_CIV_SEDE_CENTRALE!=null){out.println(INDR_CIV_SEDE_CENTRALE);}%>" maxlength="10" size="5">
              <%}else{if(INDR_CIV_SEDE_CENTRALE!=null){out.println(INDR_CIV_SEDE_CENTRALE);}else{out.println("&nbsp;");}}%>              
            </td>
            <td  class="textB" align="left">Numero Civico Sede Legale:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <input class="text" type="TEXT" name="INDR_CIV_SEDE_LEGALE" value="<%if(INDR_CIV_SEDE_LEGALE!=null){out.println(INDR_CIV_SEDE_LEGALE);}%>" maxlength="10" size="5">
              <%}else{if(INDR_CIV_SEDE_LEGALE!=null){out.println(INDR_CIV_SEDE_LEGALE);}else{out.println("&nbsp;");}}%>              
            </td>
          </tr>
          <tr> 
            <td  class="textB" align="left">CAP Sede Centrale:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <input class="text" type="TEXT" name="CODE_CAP_SEDE_CENTRALE" value="<%if(CODE_CAP_SEDE_CENTRALE!=null){out.println(CODE_CAP_SEDE_CENTRALE);}%>" maxlength="5" size="5">
              <%}else{if(CODE_CAP_SEDE_CENTRALE!=null){out.println(CODE_CAP_SEDE_CENTRALE);}else{out.println("&nbsp;");}}%>              
            </td>
            <td  class="textB" align="left">CAP Sede Legale:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <input class="text" type="TEXT" name="CODE_CAP_SEDE_LEGALE" value="<%if(CODE_CAP_SEDE_LEGALE!=null){out.println(CODE_CAP_SEDE_LEGALE);}%>" maxlength="5" size="5">
              <%}else{if(CODE_CAP_SEDE_LEGALE!=null){out.println(CODE_CAP_SEDE_LEGALE);}else{out.println("&nbsp;");}}%>              
            </td>
          </tr>
          <tr> 
            <td  class="textB" align="left">Telefono Sede Centrale</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <input class="text" type="TEXT" name="INDR_TEL_SEDE_CENTRALE" value="<%if(INDR_TEL_SEDE_LEGALE!=null){out.println(INDR_TEL_SEDE_LEGALE);}%>" maxlength="20" size="10">
              <%}else{if(INDR_TEL_SEDE_LEGALE!=null){out.println(INDR_TEL_SEDE_LEGALE);}else{out.println("&nbsp;");}}%>              
            </td>
            <td  class="textB" align="left">Telefono Sede Legale:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <input class="text" type="TEXT" name="INDR_TEL_SEDE_LEGALE" value="<%if(INDR_TEL_SEDE_LEGALE!=null){out.println(INDR_TEL_SEDE_LEGALE);}%>" maxlength="20" size="10">
              <%}else{if(INDR_TEL_SEDE_LEGALE!=null){out.println(INDR_TEL_SEDE_LEGALE);}else{out.println("&nbsp;");}}%>              
            </td>
          </tr>
          <tr> 
            <td  class="textB" align="left">Fax Sede Centrale:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <input class="text" type="TEXT" name="INDR_FAX_SEDE_CENTRALE" value="<%if(INDR_FAX_SEDE_CENTRALE!=null){out.println(INDR_FAX_SEDE_CENTRALE);}%>" maxlength="20" size="10">
              <%}else{if(INDR_FAX_SEDE_CENTRALE!=null){out.println(INDR_FAX_SEDE_CENTRALE);}else{out.println("&nbsp;");}}%>              
            </td>
            <td  class="textB" align="left">Fax Sede Legale:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <input class="text" type="TEXT" name="INDR_FAX_SEDE_LEGALE" value="<%if(INDR_FAX_SEDE_LEGALE!=null){out.println(INDR_FAX_SEDE_LEGALE);}%>" maxlength="20" size="10">
              <%}else{if(INDR_FAX_SEDE_LEGALE!=null){out.println(INDR_FAX_SEDE_LEGALE);}else{out.println("&nbsp;");}}%>              
            </td>
          </tr>
          <tr> 
            <td  class="textB" align="left">Note:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <textarea class="text" name="TEXT_NOTE"><%if(TEXT_NOTE!=null){out.println(TEXT_NOTE);}%></textarea>
              <%}else{if(TEXT_NOTE!=null){out.println(TEXT_NOTE);}else{out.println("&nbsp;");}}%>                            
            </td>
            <td  class="textB" align="left">Indirizzo Internet:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <input class="text" type="TEXT" name="INDR_INTERNET" value="<%if(INDR_INTERNET!=null){out.println(INDR_INTERNET);}%>" maxlength="70" size="20">
              <%}else{if(INDR_INTERNET!=null){out.println(INDR_INTERNET);}else{out.println("&nbsp;");}}%>                            
            </td>
          </tr>
          <tr> 
            <td  class="textB" align="left">Alleanze:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>
              <textarea class="text" name="TEXT_ALLEANZE"><%if(TEXT_ALLEANZE!=null){out.println(TEXT_ALLEANZE);}%></textarea>
              <%}else{if(TEXT_ALLEANZE!=null){out.println(TEXT_ALLEANZE);}else{out.println("&nbsp;");}}%>                            
            </td>
            <td  class="textB" align="left">Numero Dipendenti:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>            
              <input class="text" type="TEXT" name="QNTA_DIP" value="<%if(QNTA_DIP!=null){out.println(QNTA_DIP);}%>" maxlength="9" size="5">
              <%}else{if(QNTA_DIP!=null){out.println(QNTA_DIP);}else{out.println("&nbsp;");}}%>                            
            </td>
          </tr>
          <tr> 
            <td  class="textB" align="left">TEXT_DIP:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>            
              <textarea class="text" name="TEXT_DIP"><%if(TEXT_DIP!=null){out.println(TEXT_DIP);}%></textarea>
              <%}else{if(TEXT_DIP!=null){out.println(TEXT_DIP);}else{out.println("&nbsp;");}}%>                            
            </td>
            <td  class="textB" align="left">Info Estero:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>                        
              <textarea class="text" name="TEXT_INFO_ESTERO"><%if(TEXT_INFO_ESTERO!=null){out.println(TEXT_INFO_ESTERO);}%></textarea>
              <%}else{if(TEXT_INFO_ESTERO!=null){out.println(TEXT_INFO_ESTERO);}else{out.println("&nbsp;");}}%>                                          
            </td>
          </tr>
          <tr> 
            <td  class="textB" align="left">CODE_GEST_TIRKS:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>                                    
              <input class="text" type="TEXT" name="CODE_GEST_TIRKS" value="<%if(CODE_GEST_TIRKS!=null){out.println(CODE_GEST_TIRKS);}%>" maxlength="4" size="4">
              <%}else{if(CODE_GEST_TIRKS!=null){out.println(CODE_GEST_TIRKS);}else{out.println("&nbsp;");}}%>                                          
            </td>
            <td  class="textB" align="left">TEXT_TIPOL_OPERATORE:</td>
            <td  class="text" align="left"> 
              <%if (Operazione==0){%>                                    
              <textarea class="text" name="TEXT_TIPOL_OPERATORE"><%if(TEXT_TIPOL_OPERATORE!=null){out.println(TEXT_TIPOL_OPERATORE);}%></textarea>
              <%}else{if(TEXT_TIPOL_OPERATORE!=null){out.println(TEXT_TIPOL_OPERATORE);}else{out.println("&nbsp;");}}%>                                          
            </td>
          </tr>
        </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='10'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
              <%if (Operazione==0){%>     
                <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
              <%}else{%>
                  <td class="textB" bgcolor="#D5DDF1" align="center">
                  <input class="textB" type="button" name="ANNULLA" value="Chiudi" onClick="ONANNULLA();">
                  </td>
              <%}%>
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>
</BODY>
</HTML>