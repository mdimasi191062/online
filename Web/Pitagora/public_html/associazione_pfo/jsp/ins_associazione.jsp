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

  int i=0;
  String strQueryString = request.getQueryString();
  String sChecked = "";
  String strTitolo="";
  java.util.Vector appoVector=null;

    // Variabile per la memorizzazione delle informazioni dalla variabile collection
  I5_6MEM_FUNZ_PROF_OP_EL_ROW[] aRemote = null;
    //Richiesta Variabili 
  String txtCODE_PROF_UTENTE=request.getParameter("txtCODE_PROF_UTENTE");    
  String txtCODE_FUNZ=request.getParameter("txtCODE_FUNZ");      
  String txtCODE_OP_ELEM=request.getParameter("txtCODE_OP_ELEM");        
  int operazione=Integer.parseInt(request.getParameter("operazione"));          
  switch (operazione){
  case 0:
    strTitolo="Inserimento";
    break;
  case 1:
    strTitolo="Modifica";
    break;    
  case 2:
    strTitolo="Cancellazione";    
    break;    
  }
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
{ 
<%  
  if (operazione!=2){ 
%>
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
<%  
  }
%>  
  if (confirm('Si conferma l\'operazione di \'<%=strTitolo%>\' dell\'Associazione?')==true)
  {
       window.document.frmSearch.submit();
  }
}

</SCRIPT>

<TITLE>Gestione Associazioni Profili Funzioni</TITLE>
</HEAD>
<BODY onload="">
<EJB:useHome id="home" type="com.ejbSTL.I5_6MEM_FUNZ_PROF_OP_ELHome" location="I5_6MEM_FUNZ_PROF_OP_EL" />  
<EJB:useBean id="associa" type="com.ejbSTL.I5_6MEM_FUNZ_PROF_OP_EL" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<form name="frmSearch"  method="post" action='salva_associazione.jsp?<%=strQueryString%>'>
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp; <%=strTitolo%></td>
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
                                  if (strAppo.equals(txtCODE_PROF_UTENTE)){
                                    sChecked="Selected";
                                  }else{  
                                    sChecked="";                                    
                                  }
                              %>
                              <option value="<%=strAppo%>" <%=sChecked%>><%=strAppo%></option>
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
                                  if (strAppo.equals(txtCODE_FUNZ)){
                                    sChecked="Selected";
                                  }else{  
                                    sChecked="";                                    
                                  }
                              %>
                              <option value="<%=strAppo%>" <%=sChecked%>><%=strAppo%></option>
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
                                  if (strAppo.equals(txtCODE_OP_ELEM)){
                                    sChecked="Selected";
                                  }else{  
                                    sChecked="";                                    
                                  }
                              %>
                              <option value="<%=strAppo%>" <%=sChecked%>><%=strDESC_OP_ELEM%></option>
                              <%}%>
                          </select>
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
<%
  if (operazione==2){ 
%>
  <script language="javascript">
  Disable(document.frmSearch.CODE_PROF_UTENTE);
  Disable(document.frmSearch.CODE_FUNZ);
  Disable(document.frmSearch.CODE_OP_ELEM);  
  </script>  
<%
  }
%>
</BODY>
</HTML>