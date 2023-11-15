<%
if (!request.getScheme().equals("https"))
   response.setHeader("Pragma", "no-cache");
else
   response.setHeader("Pragma", "public");
   
response.addHeader("Cache-Control", "no-store");
%>

