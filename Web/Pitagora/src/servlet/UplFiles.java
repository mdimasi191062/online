package com.servlet;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.PrintWriter;
import java.io.IOException;
import com.oreilly.servlet.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import javax.swing.filechooser.FileSystemView;
import java.io.*;
import java.util.*;
import com.utl.StaticContext;
import com.utl.StaticMessages;
import com.utl.*;
import com.ejbSTL.*;
import java.sql.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;
import java.rmi.RemoteException;


public class UplFiles extends HttpServlet 
{
  private static final String CONTENT_TYPE = "text/html; charset=windows-1252";
  private boolean ignoreEnv=false;
  private File f ;
  private String strDirectory;
  private String strTipoFile;

  private static String replaceString(java.lang.String inputStr, java.lang.String findStr, java.lang.String replaceStr) {
          String returnStr = new String(inputStr);
          int pos = returnStr.indexOf(findStr, 0);
          while (pos != -1) {
                  returnStr = returnStr.substring(0, pos)+ replaceStr+returnStr.substring(pos+findStr.length());
                  pos = returnStr.indexOf(findStr, pos+replaceStr.length());
          }
          return returnStr;
  }

  
  public void init(ServletConfig config) throws ServletException
  {
    super.init(config);
  }

  private static boolean isWindows(){
    return System.getProperty("file.separator").equals("\\");
  }

  /**
   * Process the HTTP doGet request.
   */
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    response.setContentType(CONTENT_TYPE);
    PrintWriter out = response.getWriter();
    out.println("<html>");
    out.println("<head><title>UplFiles</title></head>");
    out.println("<body>");
    out.println("<p>The servlet has received a GET. This is the reply.</p>");
    out.println("</body></html>");
    out.close();
  }

  /**
   * Process the HTTP doPost request.
   */
  public void doPost(HttpServletRequest request, HttpServletResponse response) 
  throws ServletException, IOException {

  MultipartRequest multi = null;

  Ctr_ElabAttive lCtr_ElabAttive = null;
  Ctr_ElabAttiveHome lCtr_ElabAttiveHome = null;
  Object homeObject = null;
  Context lcls_Contesto = null;
  String numFileUpload = null;
  ServletContext context;
  int  maxUploadSize;
  String NameFileOut;
  String CodeFunz;

  try   {
      // Acquisisco il contesto 
      lcls_Contesto = new InitialContext();

      // Istanzio una classe Ent_BatchNew
      homeObject = lcls_Contesto.lookup("Ctr_ElabAttive");
      lCtr_ElabAttiveHome = (Ctr_ElabAttiveHome)PortableRemoteObject.narrow(homeObject, Ctr_ElabAttiveHome.class);
      lCtr_ElabAttive = lCtr_ElabAttiveHome.create();
   
       // Per utilizzare la session
       HttpSession httpsession=request.getSession(true);


       // Stabiliamo la grandezza massima del file che vogliamo uploadare
    //   MultipartRequest upp = new MultipartRequest(request,".");
      String lungFile = (String) httpsession.getAttribute("MaxSizeUpl");
      NameFileOut = (String) httpsession.getAttribute("NameFileOut");
      CodeFunz = (String) httpsession.getAttribute("CodeFunz");
    //  Long lngFile = (Long) httpsession.getAttribute("MaxSizeUpl");
   
        maxUploadSize = Integer.valueOf(lungFile).intValue() * 1024 * 1024;
    //   long maxUploadSize =  1024 * 1024;

      // Il ServletContext sevirà per ricavare il MIME type del file uploadato
       context = getServletContext();
  }
  catch(RemoteException lexc_Exception){
         System.err.println("doPost.Upload 1: "+lexc_Exception.toString());
        System.out.println("doPost.Upload 1: "+lexc_Exception.toString());
        StaticMessages.setCustomString(lexc_Exception.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5001,"UplFiles","","",StaticContext.APP_SERVER_DRIVER));
        lexc_Exception.printStackTrace();
        redirect(request,response,0);
        return;
      }
      catch(Exception lexc_Exception){
        System.err.println("doPost.Upload 1: "+lexc_Exception.toString());
        System.out.println("doPost.Upload 1: "+lexc_Exception.toString());
        StaticMessages.setCustomString(lexc_Exception.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5001,"UplFiles","","",StaticContext.APP_SERVER_DRIVER));
        lexc_Exception.printStackTrace();
        redirect(request,response,0);
        return;
    }
    
   try {
//   mostraOrologio(request,response);
   //Controllo la lunghezza con il massimo definito sul sistema
   multi = new MultipartRequest(request,".",maxUploadSize); 

   strDirectory = multi.getParameter("VarPathUpl"); 
  
   f = multi.getFile("FileDiUpload");
   }
   catch ( Exception ex )   {
        System.err.println("doPost.Upload 1: "+ex.toString());
        System.out.println("doPost.Upload 1: "+ex.toString());
        StaticMessages.setCustomString(ex.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5001,"UplFiles","","",StaticContext.APP_SERVER_DRIVER));
        ex.printStackTrace();
        redirect(request,response,2);
        return;
   }
   if ( f.length() > maxUploadSize ) {
      //Gestione Messsaggio Errore
      redirect(request,response,2);
   } 
   else {
     String fileName = multi.getFilesystemName("FileDiUpload"); 

      try {
        if (f!=null) 
        { 
          numFileUpload = lCtr_ElabAttive.getValueUplFile();
          System.out.println( "Sequence Estratta [" + numFileUpload + "]" );
          System.out.println( "NameFileOut       [" + NameFileOut + "]" );
          System.out.println( "strDirectory      [" + strDirectory + "]" );
          File fOUT;
          /* Se è specificato un tipo di nome del file da elaborare altrimenti viene inserito l'originale */
          if ( null != NameFileOut && !NameFileOut.equals("")) {
            fOUT = new File(strDirectory,NameFileOut + numFileUpload + ".csv" ) ;
          }
          else {
            fOUT = new File(strDirectory,fileName) ;
          }
          
          //Provo a modificare i permessi
          try {
              System.out.println( "Lancio comando : /bin/chmod 777 " + fOUT.getAbsolutePath() );
              String[] cmd = new String[3];
              cmd[0] = "/bin/chmod";
              cmd[1] = "777";
              cmd[2] = fOUT.getAbsolutePath();
              
              Process p = Runtime.getRuntime().exec(cmd);
          } catch ( Exception ex) {
              System.out.println( "Problema comando : /bin/chmod 777 " + fOUT.getAbsolutePath() );
          }
          
          
          try{
         if(CodeFunz.compareTo(StaticContext.RIBES_IMPORT_FATTURE)!=0)
         {
            /* controllo se esistono altri file da elaborare */
            File dir = new File(strDirectory);
            // It is also possible to filter the list of returned files.
            // This example does not return any files that start with `.'.
            FilenameFilter filter = new FilenameFilter() {
                  public boolean accept(File dir, String name) {
                      //return name.startsWith("dnmon_gcti.")&& name.endsWith(".txt");
                      //return name.startsWith(NameFileOut) && name.endsWith(".csv");
                      return name.endsWith(".csv");
                  }
              };
              
            String[] children = dir.list(filter);
  
            if (children.length > 0)
            {
              redirect(request,response,3);
              return;
            }
         }
          }catch(Exception ex){
            System.err.println("Nessun file trovato nella cartella ["+strDirectory+"]");
          }            
          
          FileInputStream fIS = new FileInputStream(f); 
          FileOutputStream fOS = new FileOutputStream(fOUT); 
          while (fIS.available()>0) 
            fOS.write(fIS.read()); 
          fIS.close(); 
          fOS.close(); 
        } 
      } catch ( Exception ex )   {
        System.err.println("doPost.Upload 1: "+ex.toString());
        System.out.println("doPost.Upload 1: "+ex.toString());
        StaticMessages.setCustomString(ex.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5001,"UplFiles","","",StaticContext.APP_SERVER_DRIVER));
        ex.printStackTrace();
        redirect(request,response,0);
        return;
      }

      try {
  //       String forw = StaticContext.PH_UPLOAD_JSP + "upload_done.jsp"; 
//           String forw = request.getContextPath()+ "/upload/jsp/upload_done.jsp";
    
          // mettiamo nella request i dati così da poterli ricavare dalla jsp 
//          httpsession.setAttribute("contentType",context.getMimeType(pr.getProperty("PATHFILE")+f.getName()));
//          httpsession.setAttribute("path",pr.getProperty("PATHFILE")+f.getName());
  //        httpsession.setAttribute("size",Long.toString(f.length())+" Bytes");
          strTipoFile = (context.getMimeType(strDirectory+f.getName())== null)?"File Testo": context.getMimeType(strDirectory+f.getName());
  //        request.setAttribute("contentType",strTipoFile);
//          request.setAttribute("path",strDirectory);
//          request.setAttribute("size",Long.toString(f.length())+" Bytes");

            redirect(request,response,1);
//           response.sendRedirect(forw);
//            RequestDispatcher rd =request.getRequestDispatcher(forw);
//            rd.forward(request,response);
          }catch(Exception ex) {
            System.err.println("doPost.Upload 2: "+ex.toString());
            System.out.println("doPost.Upload 2: "+ex.toString());
            StaticMessages.setCustomString(ex.toString());
            StaticContext.writeLog(StaticMessages.getMessage(5001,"UplFiles","","",StaticContext.APP_SERVER_DRIVER));
            ex.printStackTrace(); 
            redirect(request,response,0);
          }
   }
  } 

  private void mostraOrologio (HttpServletRequest request, HttpServletResponse response)  throws IOException {
      response.setContentType("text/html; charset=windows-1252");
      PrintWriter out = response.getWriter();

    out.println("<html>");
    out.println("<head>");
    out.println("<LINK REL=\"stylesheet\" HREF=\"" + request.getContextPath()  + "/css/Style.css\" TYPE=\"text/css\">");
    out.println("<title>upload_done</title></head>");
    out.println("<BODY>																							");			
    out.println("<form name=\"frmDati\" method=\"post\" action=\"\">                                                                                                                                              ");
    out.println("<table align=\"center\" width=\"95%\"  border=\"0\" cellspacing=\"0\" cellpadding=\"0\">                                                                                                             ");
    out.println("  <tr>                                                                                                                                                                                     ");
    out.println("	<td align=\"left\"><img src=\""  + request.getContextPath() +  "/upload/images/upload.gif\" alt=\"\" border=\"0\"></td>                                                                                                       ");
    out.println("  </tr>                                                                                                                                                                                    ");
    out.println("</table>                                                                                                                                                                                   ");
    out.println("<table width=\"95%\" border=\"0\" cellspacing=\"0\" cellpadding=\"1\" bgcolor=\"" + StaticContext.bgColorHeader + "\" align = \"center\">                                                                 ");
    out.println("	<tr>                                                                                                                                                                                    ");
    out.println("		<td>                                                                                                                                                                            ");
    out.println("		 <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"1\" bgcolor=\"" + StaticContext.bgColorHeader + "\">                                                                     ");
    out.println("			<tr>                                                                                                                                                                    ");
    out.println("			  <td bgcolor=\"" + StaticContext.bgColorHeader + "\" class=\"white\" valign=\"top\" width=\"91%\">RESPONSO UPLOAD</td>                                        ");
    out.println("			  <td bgcolor=\"" + StaticContext.bgColorCellaBianca + "\" class=\"white\" align=\"center\" width=\"9%\"><img src=\"" + request.getContextPath() + "/common/images/body/" + "tre.gif\" width=\"28\"></td>    ");
    out.println("			</tr>                                                                                                                                                                   ");
    out.println("		 </table>                                                                                                                                                                       ");
    out.println("		</td>                                                                                                                                                                           ");
    out.println("	</tr>                                                                                                                                                                                   ");
    out.println("</table>                                                                                                                                                                                   ");
    out.println("<br>                                                                                                                                                                                       ");
    out.println("<table width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"1\" bgcolor=\"" + StaticContext.bgColorHeader +"\" align = \"center\">                                                                 ");
    out.println("	<tr>                                                                                                                                                                                    ");
    out.println("		<td>                                                                                                                                                                            ");
    out.println("		 <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"1\" bgcolor=\"" + StaticContext.bgColorHeader +"\">                                                                     ");
    out.println("			<tr>                                                                                                                                                                    ");
    out.println("			  <td bgcolor=\"" + StaticContext.bgColorHeader + "\" class=\"white\" valign=\"top\" width=\"91%\">Dati Relativi All'Upload del file</td>                                                                  ");
    out.println("			  <td bgcolor=\"" + StaticContext.bgColorCellaBianca + "\" class=\"white\" align=\"center\" width=\"9%\"><img src=\"" + request.getContextPath() + "/common/images/body/" + "quad_blu.gif\"></td>          ");
    out.println("			</tr>                                                                                                                                                                   ");
    out.println("		 </table>                                                                                                                                                                       ");
    out.println("		</td>                                                                                                                                                                           ");
    out.println("	</tr>                                                                                                                                                                                   ");
    out.println("</table>  ");

    out.println("  <TR bgcolor=\"" + StaticContext.bgColorCellaBianca + "\">");
    out.println("    <TD align=\"center\" valign=\"middle\">");
    out.println("      <IMG align=\"center\" name=\"imgProgress\" id=\"imgProgress\" alt=\"Elaborazione in corso\" src=\"" + request.getContextPath() + "/common/images/body/" + "orologio.gif\">");
    out.println("      <BR>");
    out.println("      <FONT class=\"text\" id=\"msg\" name=\"msg\">");
    out.println("      Elaborazione in corso...");
    out.println("      </FONT>");
    out.println("    </TD>");
    out.println("  </TR>");

   out.println("</table>                                                                      ");


    out.println("</form>                                                                                                                                                                                    ");
    out.println("</BODY>                                                                                                                                                                                    ");
    out.println("</HTML>                                                                                                                                                                                    ");
    out.close();

  }

  private void redirect(HttpServletRequest request, HttpServletResponse response, int i ) throws IOException
  {

    response.setContentType("text/html; charset=windows-1252");
    PrintWriter out = response.getWriter();

    out.println("<html>");
    out.println("<head>");
    out.println("<LINK REL=\"stylesheet\" HREF=\"" + request.getContextPath()  + "/css/Style.css\" TYPE=\"text/css\">");
    out.println("<title>upload_done</title></head>");
    out.println("<BODY>																							");			
    out.println("<form name=\"frmDati\" method=\"post\" action=\"\">                                                                                                                                              ");
    out.println("<table align=\"center\" width=\"95%\"  border=\"0\" cellspacing=\"0\" cellpadding=\"0\">                                                                                                             ");
    out.println("  <tr>                                                                                                                                                                                     ");
    out.println("	<td align=\"left\"><img src=\""  + request.getContextPath() +  "/upload/images/upload.gif\" alt=\"\" border=\"0\"></td>                                                                                                       ");
    out.println("  </tr>                                                                                                                                                                                    ");
    out.println("</table>                                                                                                                                                                                   ");
    out.println("<table width=\"95%\" border=\"0\" cellspacing=\"0\" cellpadding=\"1\" bgcolor=\"" + StaticContext.bgColorHeader + "\" align = \"center\">                                                                 ");
    out.println("	<tr>                                                                                                                                                                                    ");
    out.println("		<td>                                                                                                                                                                            ");
    out.println("		 <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"1\" bgcolor=\"" + StaticContext.bgColorHeader + "\">                                                                     ");
    out.println("			<tr>                                                                                                                                                                    ");
    out.println("			  <td bgcolor=\"" + StaticContext.bgColorHeader + "\" class=\"white\" valign=\"top\" width=\"91%\">RESPONSO UPLOAD</td>                                        ");
    out.println("			  <td bgcolor=\"" + StaticContext.bgColorCellaBianca + "\" class=\"white\" align=\"center\" width=\"9%\"><img src=\"" + request.getContextPath() + "/common/images/body/" + "tre.gif\" width=\"28\"></td>    ");
    out.println("			</tr>                                                                                                                                                                   ");
    out.println("		 </table>                                                                                                                                                                       ");
    out.println("		</td>                                                                                                                                                                           ");
    out.println("	</tr>                                                                                                                                                                                   ");
    out.println("</table>                                                                                                                                                                                   ");
    out.println("<br>                                                                                                                                                                                       ");
    out.println("<table width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"1\" bgcolor=\"" + StaticContext.bgColorHeader +"\" align = \"center\">                                                                 ");
    out.println("	<tr>                                                                                                                                                                                    ");
    out.println("		<td>                                                                                                                                                                            ");
    out.println("		 <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"1\" bgcolor=\"" + StaticContext.bgColorHeader +"\">                                                                     ");
    out.println("			<tr>                                                                                                                                                                    ");
    out.println("			  <td bgcolor=\"" + StaticContext.bgColorHeader + "\" class=\"white\" valign=\"top\" width=\"91%\">Dati Relativi All'Upload del file</td>                                                                  ");
    out.println("			  <td bgcolor=\"" + StaticContext.bgColorCellaBianca + "\" class=\"white\" align=\"center\" width=\"9%\"><img src=\"" + request.getContextPath() + "/common/images/body/" + "quad_blu.gif\"></td>          ");
    out.println("			</tr>                                                                                                                                                                   ");
    out.println("		 </table>                                                                                                                                                                       ");
    out.println("		</td>                                                                                                                                                                           ");
    out.println("	</tr>                                                                                                                                                                                   ");
    out.println("</table>  ");
    //Corpo della pagina    

    out.println("<TABLE width=\"70%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" bgcolor=\"" + StaticContext.bgColorTabellaGenerale + "\">");
    if ( 1 == i ) {
      out.println("            <tr>                                                                   ");
      out.println("                <td>                                                               ");
      out.println("                    <font face=\"Tahoma\" size=\"3\">Percorso sul server:</font>   ");
      out.println("                </td>                                                              ");
      out.println("                <td>                                                               ");
      out.println("                    <font face=\"Tahoma\" size=\"3\">" + strDirectory + "</font>              ");
      out.println("                </td>                                                              ");
      out.println("            </tr>                                                                  ");
      out.println("            <tr>                                                                   ");
      out.println("                <td>                                                               ");
      out.println("                    <font face=\"Tahoma\" size=\"3\">MIME type:</font>             ");
      out.println("                </td>                                                              ");
      out.println("                <td>                                                               ");
      out.println("                    <font face=\"Tahoma\" size=\"3\">" + strTipoFile + "</font>       ");
      out.println("                </td>                                                              ");
      out.println("                </tr>                                                              ");
      out.println("                <tr>                                                               ");
      out.println("                <td>                                                               ");
      out.println("                    <font face=\"Tahoma\" size=\"3\">Dimensioni</font>             ");
      out.println("                </td>                                                              ");
      out.println("                <td>                                                               ");
      out.println("                    <font face=\"Tahoma\" size=\"3\">" + Long.toString(f.length()) +  " Bytes </font>              ");
      out.println("                </td>                                                              ");
      out.println("             </tr>                                                                 ");
    } else if ( 2 == i ) {
      out.println("            <tr>                                                                   ");
      out.println("                <td>                                                               ");
      out.println("                    <font face=\"Tahoma\" size=\"3\">Il file selezionato ha una dimensione troppo grande.</font>   ");
      out.println("                </td>                                                              ");
      out.println("            </tr>    ");
    } else if ( 3 == i ) {
      out.println("            <tr>                                                                   ");
      out.println("                <td>                                                               ");
      out.println("                    <font face=\"Tahoma\" size=\"3\">Esiste un file ancora da elaborare.</font>   ");
      out.println("                </td>                                                              ");
      out.println("            </tr>    ");
    }else {
      out.println("            <tr>                                                                   ");
      out.println("                <td>                                                               ");
      out.println("                    <font face=\"Tahoma\" size=\"3\">Si è verificato un errore durante upload del file contattare Assistenza.</font>   ");
      out.println("                </td>                                                              ");
      out.println("            </tr>    ");
    }
    out.println("</table>                                                                      ");
    //fine Corpo pagina


    out.println("</form>                                                                                                                                                                                    ");
    out.println("</BODY>                                                                                                                                                                                    ");
    out.println("</HTML>                                                                                                                                                                                    ");
    out.close();

	}
}

