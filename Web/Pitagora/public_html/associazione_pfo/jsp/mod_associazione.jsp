<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*,java.util.Vector" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"ins_associazione.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  String bgcolor="";
  int i=0;
  int j=0;
  String CODE_PROF_UTENTE=null;
  String CODE_FUNZ=null;
  String CODE_OP_ELEM=null;
  String strQueryString = request.getQueryString();
  String sChecked = "";
  java.util.Vector appoVector=null;

    // Variabile per la memorizzazione delle informazioni dalla variabile collection
  I5_6MEM_FUNZ_PROF_OP_EL_ROW[] aRemote = null;

  String CodSel=request.getParameter("CodSel");
  String txtProfUtente =request.getParameter("txtProfUtente");  
  String txtFunz =request.getParameter("txtFunz");
  String txtOper =request.getParameter("txtOper");
  String numRec = request.getParameter("numRec");
  String txtnumRec = request.getParameter("txtnumRec"); 
  String strPagerOffset = request.getParameter("pager.offset"); 

  if (numRec==null)
    numRec="5";
  int records_per_page = Integer.parseInt(numRec);
  
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">

function ONANNULLA()
{
   window.close();
}   

function ONCONFERMA()
{ var i=0;
  if (document.frmSearch.CODE_PROF_UTENTE.selectedIndex==0)
  {
    alert('Il Profilo Utente è obbligatorio.');
    document.frmSearch.CODE_PROF_UTENTE.focus();
    return;
  }
  if (document.frmSearch.CODE_FUNZ.selectedIndex==0)
  {
    alert('La funzione è obbligatoria.');
    document.frmSearch.CODE_FUNZ.focus();
    return;
  }  
  if (document.frmSearch.CODE_OP_ELEM.selectedIndex==0)
  {
    alert('L\'Operazione è obbligatoria.');
    document.frmSearch.CODE_OP_ELEM.focus();
    return;
  }    
  Enable(document.frmSearch.CODE_PROF_UTENTE);
  Enable(document.frmSearch.CODE_FUNZ);
  Enable(document.frmSearch.CODE_OP_ELEM);
  if (confirm('Si conferma l\'inserimento dell\'Associazione?')==true)
  {
       window.document.frmSearch.submit();
  }
}

</SCRIPT>

<TITLE>FATTURAZIONE NON TRAFFICO</TITLE>
</HEAD>
<BODY onload="">
<EJB:useHome id="home" type="com.ejbSTL.I5_6MEM_FUNZ_PROF_OP_ELHome" location="I5_6MEM_FUNZ_PROF_OP_EL" />  
<EJB:useBean id="associa" type="com.ejbSTL.I5_6MEM_FUNZ_PROF_OP_EL" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<form name="frmSearch"  method="post" action='salva_associazione.jsp?<%=strQueryString%>'>
   <input type="hidden" name="numRec" value="<%=numRec%>">
   <input type="hidden" name="txtnumRec" value="<%=txtnumRec%>">
   <input type="hidden" name="txtProfUtente" value="<%=txtProfUtente%>">
   <input type="hidden" name="txtFunz" value="<%=txtFunz%>">                        
   <input type="hidden" name="txtOper" value="<%=txtOper%>">     
   <input type="hidden" name="pager.offset" value="<%=strPagerOffset%>">        
<br>
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/assproffunzopelem.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Inserimento Associazione</td>
                <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>  
    </td>
  </tr>
  <tr>
    <td>

                  <table width="90%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9" align="center">
                    <tr>
                      <td colspan='5' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
                    </tr>

                    <tr>
                      <td width="20%" class="textB" align="right">Profili:</td>
                      <td  width="25%" class="text" align="left">
                          <select class="text" name="CODE_PROF_UTENTE">
                              <option></option>
                              <%  
                                I5_6PROF_UTENTE_ROW[] bRemote = null;              
                                int y=0;
                                Vector appoVector2 = associa.findAllProfili();
                                bRemote = (I5_6PROF_UTENTE_ROW[])appoVector2.toArray(new I5_6PROF_UTENTE_ROW[1]);
                                for(y=0;y<bRemote.length;y++)
                                {
                                  String strAppo = bRemote[y].getCODE_PROF_UTENTE();
                                  String strDESC_PROF_UTENTE = bRemote[y].getDESC_PROF_UTENTE();                                  
                              %>
                              <option value="<%=strAppo%>"><%=strAppo%></option>
                              <%}%>
                          </select>
                     </td>
                     </tr>
                     <tr>
                      <td width="20%" class="textB" align="right">Funzioni:</td>
                      <td  width="25%" class="text" align="left">
                          <select class="text"  name="CODE_FUNZ">
                              <option></option>                          
                              <%  
                                I5_6ANAG_FUNZ_ROW[] cRemote = null;              
                                int z=0;
                                Vector appoVector3 = associa.findAllFunzioni();
                                cRemote = (I5_6ANAG_FUNZ_ROW[])appoVector3.toArray(new I5_6ANAG_FUNZ_ROW[1]);
                                for(z=0;z<cRemote.length;z++)
                                {
                                  String strAppo = cRemote[z].getCODE_FUNZ();
                                  String strDESC_FUNZ = cRemote[z].getDESC_FUNZ();                                  
                              %>
                              <option value="<%=strAppo%>"><%=strAppo%></option>
                              <%}%>
                          </select>
                     </td>
                     </tr> 
                     <tr>
                     <td width="20%" class="textB" align="right">Operazioni:</td>
                     <td  width="25%" class="text">
                          <select class="text" name="CODE_OP_ELEM">
                              <option></option>
                              <%  
                                I5_6OP_ELEM_ROW[] dRemote = null;              
                                int w=0;
                                Vector appoVector4 = associa.findAllOperazioni();
                                dRemote = (I5_6OP_ELEM_ROW[])appoVector4.toArray(new I5_6OP_ELEM_ROW[1]);
                                for(w=0;w<dRemote.length;w++)
                                {
                                  String strAppo = dRemote[w].getCODE_OP_ELEM();
                                  String strDESC_OP_ELEM = dRemote[w].getDESC_OP_ELEM();
                              %>
                              <option value="<%=strAppo%>"><%=strDESC_OP_ELEM%></option>
                              <%}%>
                          </select>
                        <input type="hidden" name="CodSel" value="">                     
                        <input type="hidden" name="txtTypeLoad" value="">
                        <input type="hidden" name="txtnumRec" value="">
                     </td>      
                     </tr>
                     </table>
        </td>
    </tr>

    <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td >
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
