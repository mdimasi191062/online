<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>

<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"resocontoSap.jsp")%>
</logtag:logData>

<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");
String all_JPUBS = "";
String all_JPUB2 = "";
%>

<EJB:useHome id="homeAccountElabSTL" type="com.ejbSTL.AccountElabSTLHome" location="AccountElabSTL" />
<EJB:useBean id="remoteAccountElabSTL" type="com.ejbSTL.AccountElabSTL" scope="session">
    <EJB:createBean instance="<%=homeAccountElabSTL.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttiveHome" location="Ctr_ElabAttive"/>
<EJB:useBean id="remoteCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttive" scope="session">
  <EJB:createBean instance="<%=homeCtr_ElabAttive.create()%>"/>
</EJB:useBean>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/inputValue.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/comboCange.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../elab_attive/js/ElabAttive.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<script language="JavaScript" src="../../common/js/misc.js"></script>

<SCRIPT LANGUAGE='Javascript'>

function ONLANCIOBATCH()
{
  //Disable(formPag.LANCIOBATCH);
  if (document.formPag.ciclo.value != ''){
    var parametri = "servizi_jpub2="+document.formPag.servizi_jpub2.value;
    parametri = parametri+"&servizi_jpubS="+document.formPag.servizi_jpubS.value;
    parametri = parametri+"&ciclo="+document.formPag.ciclo.value;
  
    var URL = "resocontoSap2.jsp?"+parametri; 
    openCentral(URL,'Action','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',400,400);
  }else{
    alert("Selezionare il ciclo di Riferimento!");
  }
}

function settaComponente(objcheck)
{
  var componente = '';
  
  if(objcheck.name == 'JPUBS-ALL'){
    componente = 'JPUBS';
    if(objcheck.checked)
      document.formPag.servizi_jpubS.value=document.formPag.all_JPUBS.value;
    else
      document.formPag.servizi_jpubS.value="";
  }else{
    componente = 'JPUB2';
    if(objcheck.checked)
      document.formPag.servizi_jpub2.value=document.formPag.all_JPUB2.value;
    else
      document.formPag.servizi_jpub2.value="";
  }
  
  if(objcheck.checked){
    /*disabilita tutti i contratti dello special*/
    for(k=0; k<document.forms[0].elements.length; k++) {
      // se il campo è special lo disabilito
      if ( componente == document.forms[0].elements[k].id ) {
        document.forms[0].elements[k].checked = false;
        document.forms[0].elements[k].disabled = true;
      }
    }
  }else{
    for(k=0; k<document.forms[0].elements.length; k++) {
      // se il campo è special lo disabilito
      if ( componente == document.forms[0].elements[k].id ) {
        document.forms[0].elements[k].disabled = false;
        document.forms[0].elements[k].checked = false;
      }
    }
  }
  
  /*controllo se settare la rewrite e il ciclo*/
  if(document.formPag.servizi_jpub2.value != "" || 
     document.formPag.servizi_jpubS.value != "")
  {
    document.formPag.REWRITE.checked = true;
    document.formPag.ciclo.value="A";
    document.formPag.REWRITE.disabled = true;
    document.formPag.ciclo.disabled = true;    
  }else{
    document.formPag.REWRITE.checked = false;
    document.formPag.ciclo.value="";
    document.formPag.REWRITE.disabled = false;
    document.formPag.ciclo.disabled = false;
  }
}

function settaSottoComponente(objcheck)
{
  var componente = '';
  
  if(objcheck.id == 'JPUBS'){
    if(objcheck.checked)
    {
      if(document.formPag.servizi_jpubS.value != "")
        document.formPag.servizi_jpubS.value=document.formPag.servizi_jpubS.value+"|"+objcheck.value;
      else
        document.formPag.servizi_jpubS.value=objcheck.value;
    }
    else
    {
      var app = document.formPag.servizi_jpubS.value;
      var result = "";
      VetValues=app.split("|");
      for (i=0;i < VetValues.length;i++)
      {
        if(VetValues[i] != objcheck.value)
        {
          if(result == "")
            result=VetValues[i];
          else
            result=result+"|"+VetValues[i];
        }  
      }
      document.formPag.servizi_jpubS.value=result;
    }
  }else{
    if(objcheck.checked)
    {
      if(document.formPag.servizi_jpub2.value != "")
        document.formPag.servizi_jpub2.value=document.formPag.servizi_jpub2.value+"|"+objcheck.value;
      else
        document.formPag.servizi_jpub2.value=objcheck.value;
    }
    else
    {
      var app = document.formPag.servizi_jpub2.value;
      var result = "";
      VetValues=app.split("|");
      for (i=0;i < VetValues.length;i++)
      {
        if(VetValues[i] != objcheck.value)
        {
          if(result == "")
            result=VetValues[i];
          else
            result=result+"|"+VetValues[i];
        }  
      }
      document.formPag.servizi_jpub2.value=result;
    }
  }
  
  /*controllo se settare la rewrite e il ciclo*/
  if(document.formPag.servizi_jpub2.value != "" || 
     document.formPag.servizi_jpubS.value != "")
  {
    document.formPag.REWRITE.checked = true;
    document.formPag.ciclo.value="A";
    document.formPag.REWRITE.disabled = true;
    document.formPag.ciclo.disabled = true;    
  }else{
    document.formPag.REWRITE.checked = false;
    document.formPag.ciclo.value="";
    document.formPag.REWRITE.disabled = false;
    document.formPag.ciclo.disabled = false;
  }
  
  
}

function settaRewrite(objectRewrite){
  if(objectRewrite.checked){
    for(k=0; k<document.forms[0].elements.length; k++) {
      // se il campo è special lo disabilito
      if ("JPUB2" == document.forms[0].elements[k].id || 
          "JPUBS" == document.forms[0].elements[k].id ||
          "JPUB2-ALL" == document.forms[0].elements[k].id ||
          "JPUBS-ALL" == document.forms[0].elements[k].id) {
        document.forms[0].elements[k].checked = false;
        document.forms[0].elements[k].disabled = true;
      }
    }
  }else{
    for(k=0; k<document.forms[0].elements.length; k++) {
      // se il campo è special lo disabilito
      if ("JPUB2" == document.forms[0].elements[k].id || 
          "JPUBS" == document.forms[0].elements[k].id ||
          "JPUB2-ALL" == document.forms[0].elements[k].id ||
          "JPUBS-ALL" == document.forms[0].elements[k].id) {
        document.forms[0].elements[k].checked = false;
        document.forms[0].elements[k].disabled = false;
      }
    }
  }  
}

function settaComboPeriodo(objectComboPeriodo)
{
  if(objectComboPeriodo.value != ''){
    if(document.formPag.REWRITE.checked == false){
      document.formPag.REWRITE.checked = true;
      settaRewrite(document.formPag.REWRITE);
    }
  }
}

</SCRIPT>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<title>
Resoconto Valorizzazione JPUB
</title>
</head>

<BODY>
<form name="formPag" method="post">

<input type="hidden" name="servizi_jpub2" id="servizi_jpub2">
<input type="hidden" name="servizi_jpubS" id="servizi_jpubS">

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td><img src="../../valorizza_attiva/images/titoloPagina.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Resoconto Valorizzazione JPUB</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" heigth="100%">
              <table width="90%" border="0" cellspacing="0" cellpadding="3" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                <tr>
                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                </tr>
                <tr>
                  <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>" >
                      <Tr>
                        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">
                          <input type="checkbox" name="JPUBS-ALL" id="JPUBS-ALL" value="0" onclick="settaComponente(this)">Jpub Special
                        </td>
                        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">
                          <input type="checkbox" name="JPUB2-ALL" id="JPUB2-ALL" value="0" onclick="settaComponente(this)">Jpub 2
                        </td>
                      </Tr>
                      <Tr bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                        <td valign="left">
                          <table width="50%" border="0" cellspacing="0" cellpadding="0">
                          <%
                          Collection  accElab;
                          accElab = remoteAccountElabSTL.getLstServiziResocontoSap("S");
                          Object[] objs=accElab.toArray();
                          all_JPUBS = "";
                          for (int i=0;i<accElab.size();i++)
                          {
                            LstCodeTipoContrElem obj=(LstCodeTipoContrElem)objs[i];
                            if(all_JPUBS.equals(""))
                              all_JPUBS = obj.getCodeTipoContr();
                            else
                              all_JPUBS = all_JPUBS + "|" +obj.getCodeTipoContr();
                            %>
                            <tr>
                              <td class="text" nowrap align="left" widht="49%"><input type="checkbox" name="JPUBS<%=obj.getCodeTipoContr()%>" id="JPUBS" value="<%=obj.getCodeTipoContr()%>" onclick="settaSottoComponente(this)" ><%=obj.getDescTipoContr()%></td>
                            </tr>
                            <%
                          }
                          %>
                          </table>
                        </td>
                        <input type="hidden" name="all_JPUBS" id="all_JPUBS" value="<%=all_JPUBS%>">
                        
                        <td valign="left">
                          <table width="50%" border="0" cellspacing="0" cellpadding="0">
                          <%
                            Collection  accElabJp2;
                            accElabJp2 = remoteAccountElabSTL.getLstServiziResocontoSap("JPUB2");
                            Object[] objsJp2=accElabJp2.toArray();
                            all_JPUB2 = "";
                            for (int i=0;i<accElabJp2.size();i++)
                            {
                              LstCodeTipoContrElem objJp2=(LstCodeTipoContrElem)objsJp2[i];
                              if(all_JPUB2.equals(""))
                                all_JPUB2 = objJp2.getCodeTipoContr();
                              else
                                all_JPUB2 = all_JPUB2 + "|" +objJp2.getCodeTipoContr();
                              %>
                              <tr>
                                <td class="text" nowrap align="left" widht="49%"><input type="checkbox" name="JPUB2<%=objJp2.getCodeTipoContr()%>" id="JPUB2" value="<%=objJp2.getCodeTipoContr()%>" onclick="settaSottoComponente(this)" ><%=objJp2.getDescTipoContr()%></td>
                              </tr>
                              <%
                            }
                            %>
                          </table>
                          <input type="hidden" name="all_JPUB2" id="all_JPUB2" value="<%=all_JPUB2%>">
                        </td>
                      </Tr>
                    </Table>
                  </td>
                </tr>
                <%-- DISPONIBILI E ACCORPATI - FINE --%>
                <tr>
                  <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>" >
                      <Tr>
                        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">
                          <input type="checkbox" name="REWRITE" onclick="settaRewrite(this);">Genera file
                          <Select name="ciclo" id="ciclo" class="text" label="Ciclo di riferimento" onchange="settaComboPeriodo(this);">
                          <%
                          Vector vctPeriodoRif = null;
                          DB_PeriodoRiferimento objPeriodoRif = null;
                          vctPeriodoRif = remoteCtr_ElabAttive.getPeriodoRiferimento("getCicliResocontoSap");
                          String strCmbValue = "[Ciclo di Riferimento]";
                          %>
                            <option value=""><%=strCmbValue%></option>
                            <%
                            for(int z=0;z<vctPeriodoRif.size();z++){
                              objPeriodoRif = (DB_PeriodoRiferimento)vctPeriodoRif.get(z);
                              if(objPeriodoRif.getCODE_CICLO().equals("999"))
                                objPeriodoRif.setCODE_CICLO("A");
                              %>
                              <option value="<%=objPeriodoRif.getCODE_CICLO()%>">
                                <%=objPeriodoRif.getDESCRIZIONE_CICLO()%>
                              </option>
                              <%
                            }
                          %>
                          </Select>
                        </td>
                        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </tr>
                                
              </TABLE>
                
          </td>
        </tr>
      </table>
    </td>
  </tr>  
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
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

<script language="Javascript">
Enable(formPag.LANCIABATCH);
</script>

</body>
</html>
