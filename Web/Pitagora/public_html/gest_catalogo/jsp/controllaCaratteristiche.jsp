<%@ page contentType="text/html;charset=windows-1252"%>
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.rmi.PortableRemoteObject" %>
<%@ page import="java.rmi.RemoteException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.ejb.*" %>
<%@ page import="com.utl.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%--<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<sec:ChkUserAuth isModal="true"/>
--%>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"controllaCaratteristiche.jsp")%>
</logtag:logData>


<EJB:useHome id="homeEnt_Catalogo" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="remoteEnt_Catalogo" type="com.ejbSTL.Ent_Catalogo" scope="session">
    <EJB:createBean instance="<%=homeEnt_Catalogo.create()%>" />
</EJB:useBean>


<% 
  String strTipo  = Misc.nh(request.getParameter("Tipo"));
  String PROD  = Misc.nh(request.getParameter("PROD"));
  String COMPO  = Misc.nh(request.getParameter("COMPO"));
  String PREST  = Misc.nh(request.getParameter("PREST"));
  String ProdottoRif  = Misc.nh(request.getParameter("ProdottoRif"));   
  String ComponenteRif  = Misc.nh(request.getParameter("ComponenteRif"));      

  String strProdotto = "";
  String strComponente = "";
  String strPrestazione = "";
  int determinaAssenzaCaratt = 0;
  String elementi = "";
  
  PROD = Misc.replace(PROD,"PROD=","");
  COMPO = Misc.replace(COMPO,"COMPO=","");
  PREST = Misc.replace(PREST,"PREST=","");
  System.out.println( "-----------------------------");
  System.out.println( "PROD  [" + PROD + "]");
  System.out.println( "COMPO [" + COMPO + "]");
  System.out.println( "PREST [" + PREST + "]");
  System.out.println( "strTipo [" + strTipo + "]");
  System.out.println( "elementi [" + elementi + "]");
  
  if ( strTipo.equals( "PRODOTTO" ) ){
    StringTokenizer strElemento = new StringTokenizer( PROD, "|" );
    strComponente = "";
    strPrestazione = "";
    do {
      strProdotto = strElemento.nextToken();
      determinaAssenzaCaratt = 0;
      determinaAssenzaCaratt =  remoteEnt_Catalogo.determinaAssenzaCaratt(strProdotto , strComponente , strPrestazione);

      if (determinaAssenzaCaratt == 0){
        elementi = elementi + "|" +strProdotto;
      }
      
    } while ( strElemento.hasMoreElements());
  }
  else if (strTipo.equals( "COMPONENTE" ) ) {
    StringTokenizer strElemento = new StringTokenizer( COMPO, "|" );
    strProdotto = ProdottoRif;
    strPrestazione = "";
    do {
      strComponente = strElemento.nextToken();
      determinaAssenzaCaratt = 0;
      determinaAssenzaCaratt =  remoteEnt_Catalogo.determinaAssenzaCaratt(strProdotto , strComponente , strPrestazione);

      if (determinaAssenzaCaratt == 0){
        elementi = elementi + "|" +strComponente;
      }

    } while ( strElemento.hasMoreElements() );
  } 
  else if ( strTipo.equals( "PRESTAZIONE" ) ) {
    StringTokenizer strElemento = new StringTokenizer( PREST, "|" );
    strProdotto = ProdottoRif;
    strComponente = ComponenteRif;    
    do {
      strPrestazione = strElemento.nextToken();
      determinaAssenzaCaratt = 0;
      determinaAssenzaCaratt =  remoteEnt_Catalogo.determinaAssenzaCaratt(strProdotto , strComponente , strPrestazione);

      if (determinaAssenzaCaratt == 0){
        elementi = elementi + "|" +strPrestazione;
      }
      
    } while ( strElemento.hasMoreElements() );    
  }

%>

<HTML>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title></title>
</head>
<body>
<FORM name="prova" method="post" action="">
<input type="hidden" name="elementi" value="<%=elementi%>">
<input type="hidden" name="tipo" value="<%=strTipo%>">

<script>
var elem = document.prova.elementi.value;
var tipo = document.prova.tipo.value;

parent.frmDati.assenzaCaratt.value = elem;
parent.frmDati.assenzaCarattTipo.value = tipo;

parent.verificaAssenzaAccorpamenti();
</script>
</form>
</body>
</HTML>