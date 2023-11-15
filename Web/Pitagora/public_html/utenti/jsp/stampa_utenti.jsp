<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.utl.*, com.usr.*" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_utenti.jsp")%>
</logtag:logData>
<%
  int j=0;
  I5_6anag_utenteROW[] aRemote = null;
  aRemote = (I5_6anag_utenteROW[]) session.getAttribute("aRemote");
%>

<HTML xmlns:o="urn:schemas-microsoft-com:office:office" 
			xmlns:x="urn:schemas-microsoft-com:office:excel"
			xmlns="http://www.w3.org/TR/REC-html40"> 
<HEAD>
<STYLE>
  .text{
     COLOR: #006699;
     FONT-FAMILY: Verdana,Arial;
     FONT-SIZE: 8pt;
     FONT-STYLE: normale;
  }
  .textB{
     COLOR: #006699;
     FONT-FAMILY: Verdana,Arial;
     FONT-SIZE: 8pt;
     FONT-WEIGHT: bolder;

  }
</STYLE>


<TITLE>Stampa Utenti</TITLE>
</HEAD>
<BODY >
  <table border=1>
  <tr>
    <td class="text">Utente</td>
    <td class="text">Profilo</td>
    <td class="text">Nome</td>
    <td class="text" nowrap>Inizio<br>Validità<br>Utente</td>
    <td class="text" nowrap>Fine<br>Validità<br>Utente</td>
    <td class="text" nowrap>Ultimo<br>Accesso<br>Utente</td>
  </tr>
                        
<%
  /*String            CODE_UTENTE      =null;
  String            CODE_PROF_UTENTE =null;
  String            NOME_COGN_UTENTE =null;
  java.util.Date    DATE_END         =null;
  java.util.Date    DATE_PWD_UPD     =null;
  int               NUM_PWD_DUR;
  String            FLAG_ADMIN_IND   =null;
  String            CODE_PWD         =null;*/

  String            CODE_UTENTE      =null;
  String            CODE_PROF_UTENTE =null;
  String            NOME_COGN_UTENTE =null;
  String            DATE_END         =null;
  //java.util.Date  DATE_PWD_UPD     =null;
  //int             NUM_PWD_DUR;
  String            FLAG_ADMIN_IND   =null;
  //String          CODE_PWD         =null;
  String            DATA_LOGIN       = null;
  String            DATA_START       = null;

  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");

     for(j=0;(j<aRemote.length);j++)
     {

        CODE_UTENTE      = aRemote[j].getCode_utente();
        CODE_PROF_UTENTE = aRemote[j].getCode_prof_utente();
        NOME_COGN_UTENTE = aRemote[j].getNome_cogn_utente();
        DATE_END         = aRemote[j].getData_end_char();
        DATA_LOGIN       = aRemote[j].getData_login();
        DATA_START       = aRemote[j].getData_start_char();
        FLAG_ADMIN_IND   = aRemote[j].getFlag_admin_ind();

        if(DATE_END == null)
           DATE_END = "";
        if(DATA_LOGIN == null)
           DATA_LOGIN = "";
        if(DATA_START == null)
           DATA_START = "";
%>
                        <TR>
                           <TD class="textB" x:str="<%=CODE_UTENTE%>"></TD></TD>
                           <TD class="textB" x:str="<%=CODE_PROF_UTENTE%>"></TD>
                           <TD class="textB" x:str="<%=NOME_COGN_UTENTE%>"></TD>
                           <TD class="textB" x:str="<%=DATA_START%>"></TD>
                           <TD class="textB" x:str="<%=DATE_END%>"></TD>
                           <TD class="textB" x:str="<%=DATA_LOGIN%>"></TD>
                       </tr>
<%
        }
%>

</table>
</form>
</BODY>
</HTML>
