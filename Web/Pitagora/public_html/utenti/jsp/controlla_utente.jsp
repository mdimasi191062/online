<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*,javax.naming.directory.*" %>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"controlla_utente.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  String strUserName = request.getParameter("utente");
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
</HEAD>
<BODY>
<%--<form name="frmControllaUser" method="post" action="">--%>
<%
      String urlDB = "ldap://156.54.242.110";
      Attributes attributesUserList;
      attributesUserList = StaticContext.searchUserLDAP(strUserName,urlDB);
      String errore = "";
      String ou = "";
      String displayName = "";
      String search = "";
      String base = "";
      String mail = "";
      String mailManager = "";
      String nomeUtente = "";
      String cognomeUtente = "";
      if(attributesUserList != null){
        Attribute displayNameAttribute = attributesUserList.get("displayName");
        Attribute ouAttribute = attributesUserList.get("ou");
        Attribute baseAttribute = attributesUserList.get("base");
        Attribute searchAttribute = attributesUserList.get("search");
        Attribute mailAttribute = attributesUserList.get("mail");
        Attribute mailManagerAttribute = attributesUserList.get("mailManager");
        Attribute nomeUtenteAttribute = attributesUserList.get("givenName");
        Attribute cognomeUtenteAttribute = attributesUserList.get("sn");
        if(displayName != null){
          displayName = (String)displayNameAttribute.get();
        }
        if(ouAttribute != null){
          ou = (String)ouAttribute.get();
        }
        if(baseAttribute != null){
          base = (String)baseAttribute.get();
        }
        if(searchAttribute != null){
          search = (String)searchAttribute.get();
        }
        if(mailAttribute != null){
          mail = (String)mailAttribute.get();
        }
        if(mailManagerAttribute != null){
          mailManager = (String)mailManagerAttribute.get();
        }
        if(nomeUtenteAttribute != null){
          nomeUtente = (String)nomeUtenteAttribute.get();
        }
        if(cognomeUtenteAttribute != null){
          cognomeUtente = (String)cognomeUtenteAttribute.get();
        }
      }else{
        errore = "Errore";
      }
%>
<SCRIPT LANGUAGE="JavaScript">
  var displayName = "<%=displayName%>";
  var ou = "<%=ou%>";
  var base = "<%=base%>";
  var search = "<%=search%>";
  var errore = "<%=errore%>";
/*
  var mail = "<%=mail%>";
  var mailManager = "<%=mailManager%>";
*/
  var nomeUtente = "<%=nomeUtente%>";
  var cognomeUtente = "<%=cognomeUtente%>";
  //window.close();
  parent.popolaCampi(displayName,ou,base,search,nomeUtente,cognomeUtente,errore);  
  //parent.popolaCampi(displayName,ou,base,search,mail,mailManager,nomeUtente,cognomeUtente,errore);
</SCRIPT>
<%--</form>--%>
</BODY>
</HTML>