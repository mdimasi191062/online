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


public class UplFilesAnnOrd extends HttpServlet 
{
  private static final String CONTENT_TYPE = "text/html; charset=windows-1252";
  private boolean ignoreEnv=false;
  private File f ;
  private String strDirectory;
  private String strTipoFile;
  int numeroRighe = 0;

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
    out.println("<head><title>UplFilesAnnOrd</title></head>");
    out.println("<body>");
    out.println("<p>The servlet has received a GET. This is the reply.</p>");
    out.println("</body></html>");
    out.close();
  }

  /**
   * Process the HTTP doPost request.
   */
  public void doPost(HttpServletRequest request, HttpServletResponse response) 
  throws ServletException, IOException  {

  MultipartRequest multi = null;
  //int numeroRighe = 0;
  Ctr_ElabAttive lCtr_ElabAttive = null;
  Ctr_ElabAttiveHome lCtr_ElabAttiveHome = null;
  Ctr_Utility lCtr_Utility = null;
  Ctr_UtilityHome lCtr_UtilityHome = null;
  Object homeObject = null;
  Object homeObjectUtl = null;  
  Context lcls_Contesto = null;
  Context lcls_ContestoUtility = null;
  String numFileUpload = null;
  ServletContext context;
  int  maxUploadSize;
  final String NameFileOut;
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

      // Il ServletContext sevir? per ricavare il MIME type del file uploadato
       context = getServletContext();
  }
  catch(RemoteException lexc_Exception){
         System.err.println("doPost.Upload 1: "+lexc_Exception.toString());
        System.out.println("doPost.Upload 1: "+lexc_Exception.toString());
        StaticMessages.setCustomString(lexc_Exception.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5001,"UplFilesAnnOrd","","",StaticContext.APP_SERVER_DRIVER));
        lexc_Exception.printStackTrace();
        redirect(request,response,0);
        return;
      }
      catch(Exception lexc_Exception){
        System.err.println("doPost.Upload 1: "+lexc_Exception.toString());
        System.out.println("doPost.Upload 1: "+lexc_Exception.toString());
        StaticMessages.setCustomString(lexc_Exception.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5001,"UplFilesAnnOrd","","",StaticContext.APP_SERVER_DRIVER));
        lexc_Exception.printStackTrace();
        redirect(request,response,0);
        return;
    }
    
   try {
//   mostraOrologio(request,response);
   int esito =0;
   String funzupload  = request.getParameter("funzupload");
   //Controllo la lunghezza con il massimo definito sul sistema
   if (funzupload != null) { 

          try   {
              // Acquisisco il contesto 
              lcls_ContestoUtility = new InitialContext();

              // Istanzio una classe Ent_BatchNew
              homeObjectUtl = lcls_ContestoUtility.lookup("Ctr_Utility");
              lCtr_UtilityHome = (Ctr_UtilityHome)PortableRemoteObject.narrow(homeObjectUtl, Ctr_UtilityHome.class);
              lCtr_Utility = lCtr_UtilityHome.create();
              
               // Per utilizzare la session
               HttpSession httpsession=request.getSession(true);

              esito = lCtr_Utility.annullaOrdineMassivo();
              context = getServletContext();
          }
          catch(Exception lexc_Exception){
            System.err.println("doPost.Upload 1: "+lexc_Exception.toString());
           System.out.println("doPost.Upload 1: "+lexc_Exception.toString());
           StaticMessages.setCustomString(lexc_Exception.toString());
           StaticContext.writeLog(StaticMessages.getMessage(5001,"UplFilesAnnOrd","","",StaticContext.APP_SERVER_DRIVER));
           lexc_Exception.printStackTrace();
           redirect(request,response,0);
           return;
          }
          
         
   
   
          response.setContentType("text/html; charset=windows-1252");
          PrintWriter out = response.getWriter();

          out.println("<html>");
          out.println("<head>");
          out.println("<LINK REL=\"stylesheet\" HREF=\"" + request.getContextPath()  + "/css/Style.css\" TYPE=\"text/css\">");
          out.println("<title>upload_done</title></head>");
          out.println("<BODY>                                                                                                                                                                                 ");
          out.println("<form name=\"frmDati\" method=\"post\" action=\"\">                                                                                                                                              ");
          out.println("<input type=\"hidden\" name=\"funzupload\" id=\"funzupload\" value=\"prima\">");
          out.println("<table align=\"center\" width=\"95%\"  border=\"0\" cellspacing=\"0\" cellpadding=\"0\">                                                                                                             ");
          out.println("  <tr>                                                                                                                                                                                     ");
          out.println("       <td align=\"left\"><img src=\""  + request.getContextPath() +  "/utility/images/AnnullaOrdine.gif\" alt=\"\" border=\"0\"></td>                                                                                                       ");
          out.println("  </tr>                                                                                                                                                                                    ");
          out.println("</table>                                                                                                                                                                                   ");
          out.println("<TABLE width=\"70%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" bgcolor=\"" + StaticContext.bgColorTabellaGenerale + "\">");
          //out.println("<table width=\"95%\" border=\"0\" cellspacing=\"0\" cellpadding=\"1\" bgcolor=\"" + StaticContext.bgColorHeader + "\" align = \"center\">                                                                 ");
          out.println("       <tr>                                                                                                                                                                                    ");
          out.println("               <td>                                                                                                                                                                            ");
          out.println("                <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"1\" bgcolor=\"" + StaticContext.bgColorHeader + "\">                                                                     ");
          out.println("                       <tr>                                                                                                                                                                    ");
          out.println("                         <td bgcolor=\"" + StaticContext.bgColorHeader + "\" align=\"center\" class=\"white\" valign=\"top\" width=\"91%\">ANNULAMENTO MASSIVO LANCIATO CON SUCCESSO</td>                                        ");
          out.println("                         <td bgcolor=\"" + StaticContext.bgColorCellaBianca + "\" class=\"white\" align=\"center\" width=\"9%\"><img src=\"" + request.getContextPath() + "/common/images/body/" + "tre.gif\" width=\"28\"></td>    ");
          out.println("                       </tr>                                                                                                                                                                   ");
          out.println("            <tr>                                                                   ");
          out.println("                <td align=\"center\" bgcolor=\"" + StaticContext.bgColorCellaBianca + "\" width=\"100%\" >                                                               ");
          //out.println("                    <input class=\"textB\" title=\"Ricerca\" type=\"button\" maxlength=\"30\" name=\"Esci\" bgcolor=\"<%=StaticContext.bgColorFooter%>\" value=\"Procedi\" onClick=\"window.location.href='utility/jsp/ann_tutto_mas.jsp'\">");
          out.println("                    <input class=\"textB\" title=\"Indietro\" type=\"button\" maxlength=\"30\" name=\"Indietro\" bgcolor=\"<%=StaticContext.bgColorFooter%>\" value=\"Indietro\" onClick=\"window.location.href='utility/jsp/ann_ord_mas.jsp'\">");
          out.println("                </td>                                                              ");
          out.println("            </tr>    ");
          out.println("                </table>                                                                                                                                                                       ");
          out.println("               </td>                                                                                                                                                                           ");
          out.println("       </tr>                                                                                                                                                                                   ");
          out.println("</table>     ");
          //out.println("<h1> Caricato </h1>                                                                                                                                                                                 ");
          out.println("</BODY>                                                                                                                                                                                 ");
          out.println("</HTML>                                                                                                                                                                                    ");
          out.close();
   
   
   
   return; 
      }
   
   multi = new MultipartRequest(request,".",maxUploadSize); 
   
   strDirectory = multi.getParameter("VarPathUpl"); 
   
   
   
   f = multi.getFile("FileDiUpload");
    }
   
   catch ( Exception ex )   {
        System.err.println("doPost.Upload 1: "+ex.toString());
        System.out.println("doPost.Upload 1: "+ex.toString());
        StaticMessages.setCustomString(ex.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5001,"UplFilesAnnOrd","","",StaticContext.APP_SERVER_DRIVER));
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
          /* Se ? specificato un tipo di nome del file da elaborare altrimenti viene inserito l'originale */
          if ( null != NameFileOut && !NameFileOut.equals("")) {
            //fOUT = new File(strDirectory,NameFileOut + numFileUpload + ".csv" ) ;
             fOUT = new File(strDirectory,NameFileOut +  ".csv" ) ;
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
        StaticContext.writeLog(StaticMessages.getMessage(5001,"UplFilesAnnOrd","","",StaticContext.APP_SERVER_DRIVER));
        ex.printStackTrace();
        redirect(request,response,0);
        return;
      }
       int esito =0;

       String txtFilePath = strDirectory + File.separator + NameFileOut +  ".csv";
       BufferedReader reader = new BufferedReader(new FileReader(txtFilePath));
       //BufferedReader br = new InputStreamReader(new FileInputStream(txtFilePath));
       StringBuilder sb = new StringBuilder();
       String codOrdine;
       String dataAcq;
       String line;
       try 
       {
       // Acquisisco il contesto 
       lcls_ContestoUtility = new InitialContext();

       // Istanzio una classe Ent_BatchNew
       homeObjectUtl = lcls_ContestoUtility.lookup("Ctr_Utility");
       lCtr_UtilityHome = (Ctr_UtilityHome)PortableRemoteObject.narrow(homeObjectUtl, Ctr_UtilityHome.class);
       lCtr_Utility = lCtr_UtilityHome.create();
       
       numeroRighe = 0;
       
        // Per utilizzare la session
        HttpSession httpsession=request.getSession(true);
       while((line = reader.readLine())!= null){
           sb.append(line+"\n");
           ++ numeroRighe;
           
           try   {

               codOrdine = line.split(";")[0];
               dataAcq = line.split(";")[1];
               esito = lCtr_Utility.insertAnnullaOrdine(codOrdine,dataAcq);
               context = getServletContext();
           }
           catch(Exception lexc_Exception){
             System.err.println("doPost.Upload 1: "+lexc_Exception.toString());
            System.out.println("doPost.Upload 1: "+lexc_Exception.toString());
            StaticMessages.setCustomString(lexc_Exception.toString());
            StaticContext.writeLog(StaticMessages.getMessage(5001,"UplFilesAnnOrd","","",StaticContext.APP_SERVER_DRIVER));
            lexc_Exception.printStackTrace();
            redirect(request,response,0);
            return;
           }
           
       }   
       System.out.println(sb.toString()); 
       }
       catch (Exception e){}
      try {

          strTipoFile = (context.getMimeType(strDirectory+f.getName())== null)?"File Testo": context.getMimeType(strDirectory+f.getName());

            redirect(request,response,1);
          }catch(Exception ex) {
            System.err.println("doPost.Upload 2: "+ex.toString());
            System.out.println("doPost.Upload 2: "+ex.toString());
            StaticMessages.setCustomString(ex.toString());
            StaticContext.writeLog(StaticMessages.getMessage(5001,"UplFilesAnnOrd","","",StaticContext.APP_SERVER_DRIVER));
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
    out.println("<SCRIPT LANGUAGE=\"JavaScript\">");
    out.println("	    function carica() { frmDati.action=\"UplFilesAnnOrd\"; frmDati.ENCTYPE=\"multipart/form-data\"; frmDati.submit();  }");
    out.println("</SCRIPT>");	    
	      
    
    out.println("<LINK REL=\"stylesheet\" HREF=\"" + request.getContextPath()  + "/css/Style.css\" TYPE=\"text/css\">");
    out.println("<title>upload_done</title></head>");
    out.println("<BODY>																							");			
    out.println("<form name=\"frmDati\" method=\"post\" action=\"\">                                                                                                                                              ");
    out.println("<input type=\"hidden\" name=\"funzupload\" id=\"funzupload\" value=\"prima\">");
    out.println("<table align=\"center\" width=\"95%\"  border=\"0\" cellspacing=\"0\" cellpadding=\"0\">                                                                                                             ");
    out.println("  <tr>                                                                                                                                                                                     ");
    out.println("	<td align=\"left\"><img src=\""  + request.getContextPath() +  "/utility/images/AnnullaOrdine.gif\" alt=\"\" border=\"0\"></td>                                                                                                       ");
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
        out.println("                <tr>                                                               ");
        out.println("                <td>                                                               ");
        out.println("                    <font face=\"Tahoma\" size=\"3\">Numero Occorrenze</font>             ");
        out.println("                </td>                                                              ");
        out.println("                <td>                                                               ");
        out.println("                    <font face=\"Tahoma\" size=\"3\">" + numeroRighe  +  "  </font>              ");
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
      out.println("                    <font face=\"Tahoma\" size=\"3\">Si e' verificato un errore durante upload del file.</font>   ");
      out.println("                </td>                                                              ");
      out.println("            </tr>    ");
    } 
	    
    
    out.println("</table>                                                                      ");
    //fine Corpo pagina
     out.println("<TABLE width=\"70%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" bgcolor=\"" + StaticContext.bgColorTabellaGenerale + "\">");
	    out.println("            <tr>                                                                   ");
	    out.println("                <td align=\"center\">                                                               ");
	    //out.println("                    <input class=\"textB\" title=\"Ricerca\" type=\"button\" maxlength=\"30\" name=\"Esci\" bgcolor=\"<%=StaticContext.bgColorFooter%>\" value=\"Procedi\" onClick=\"window.location.href='utility/jsp/ann_tutto_mas.jsp'\">");
	    if (( 1 == i )&& (numeroRighe>0) ) {
            //if (numeroRighe>0)  {
	    out.println("                    <input class=\"textB\" title=\"Esegui\" type=\"button\" maxlength=\"30\" name=\"Esegui\" bgcolor=\"<%=StaticContext.bgColorFooter%>\" value=\"Esegui\" onClick=\"carica();\">");
            }
            else
            {
            out.println("                    <input class=\"textB\" title=\"Indietro\" type=\"button\" maxlength=\"30\" name=\"Indietro\" bgcolor=\"<%=StaticContext.bgColorFooter%>\" value=\"Indietro\" onClick=\"window.location.href='utility/jsp/ann_ord_mas.jsp'\">");
            }
	    out.println("                </td>                                                              ");
	    out.println("            </tr>    ");
	    out.println("</table>                                                                      ");

    out.println("</form>                                                                                                                                                                                    ");
    out.println("</BODY>                                                                                                                                                                                    ");
    out.println("</HTML>                                                                                                                                                                                    ");
    out.close();

	}
}

