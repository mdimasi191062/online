<%
//La pagina ha il solo scopo di di settare una variabile di sessione per verificare 
//che si sta effettuando il lancio attraverso i passi giusti
session.setAttribute("FlagLancioCsi","1");
String QueryString=request.getQueryString();
response.sendRedirect("messaggio.jsp?" + QueryString);
%>