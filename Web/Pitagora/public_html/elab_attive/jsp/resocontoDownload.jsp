<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.zip.ZipOutputStream"%>
<%@ page import="java.util.zip.ZipEntry"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*"%>
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>

<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"resocontoDownload.jsp")%>
</logtag:logData>

<%@ page import="com.utl.StaticContext" %>
<%@ page import="com.utl.*" %>

<%
String nomefile         = Misc.nh(request.getParameter("nomeFileHidden"));
String path             = Misc.nh(request.getParameter("comboNomeFile"));
String listafile = Misc.nh(request.getParameter("ListaFileHidden"));
String operazione       = Misc.nh(request.getParameter("OperazioneHidden"));
if (!operazione.equalsIgnoreCase("1")){
%>

<pg:downloadTag1 file="<%=nomefile%>" dir="<%=path%>" inline="false" contentType="application/vnd.ms-excel"/>
<% } else {
        
        String[] Arrlistafile;
        
       
        
         //Create list for file URLs - these are files from all different locations
    List<String> filenames = new ArrayList<String>();
    filenames = Arrays.asList(listafile.split("\\s*,\\s*")); //listafile.split(",");
    //..code to add URLs to the list
//alf
    byte[] buf = new byte[2048];

    // Create the ZIP file
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    ZipOutputStream out1 = new ZipOutputStream(baos);

    // Compress the files
    for (int i=0; i<filenames.size(); i++) {

    FileInputStream fis = new FileInputStream(filenames.get(i).toString());
    BufferedInputStream bis = new BufferedInputStream(fis);

    // Add ZIP entry to output stream.
    File file = new File(filenames.get(i).toString());
    String entryname = file.getName();
    out1.putNextEntry(new ZipEntry(entryname));

    int bytesRead;
    while ((bytesRead = bis.read(buf)) != -1) {
    out1.write(buf, 0, bytesRead);
    }

    out1.closeEntry();
    bis.close();
    fis.close();
    }
     out1.flush();
    baos.flush();
    out1.close();
    baos.close();

    ServletOutputStream sos = response.getOutputStream();
    response.setContentType("application/zip");
    response.setHeader("Content-Disposition", "attachment; filename=\"Estrazione.ZIP\"");
    sos.write(baos.toByteArray());
    out1.flush();
    out1.close();
    sos.flush();
    /*
        response.setContentType("application/zip");   
    response.setHeader("Content-Disposition", "attachment; filename=\"Estrazione.ZIP\"");   
    
    
     BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
     FileInputStream fis = new FileInputStream(listafile);

        int len;
        byte[] buf = new byte[1024];

        while ((len = fis.read(buf)) > 0)
        {
            bos.write(buf, 0, len);
        }

        bos.close();
        fis.close();   
    */
     }
%>
