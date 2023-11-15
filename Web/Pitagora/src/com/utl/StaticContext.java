package com.utl;

import com.cj.log.LogBean; //TAGLIB Utilizzato per i logFiles
import com.usr.clsInfoUser;
import java.io.PrintWriter;
import java.io.PrintStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.File;


import java.util.StringTokenizer;

import javax.naming.NamingException;
import javax.ejb.FinderException;
import java.rmi.RemoteException;
import java.sql.SQLException;

import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.Date;
import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.naming.AuthenticationException;
import javax.naming.Context;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.DirContext;
import javax.naming.directory.Attributes;
import javax.naming.directory.*;

import javax.*;

import javax.servlet.jsp.JspWriter;

/* LDAP */
import javax.naming.directory.SearchControls;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;

public class StaticContext {
    //MB Modalità applicazione percentuale
    public static final String FLAG_MODALITA_PERCENTUALE  = "5";

    public static final String INITIAL_CONTEXT_FACTORY    = "com.evermind.server.rmi.RMIInitialContextFactory";
    public static final String SECURITY_PRINCIPAL         = "admin";
    public static final String SECURITY_CREDENTIALS       = "admin";
    public static final String PROVIDER_URL               = "ormi://RC2603:23791/ear";

    //QS 28-09-2008: Su richiesta di Ingegneria modificato il MAX_INACTIVE_INTERVAL da 3600 a 1020
    public static final int MAX_INACTIVE_INTERVAL         = 1020;
    public static final String TREE_MAIN_PAGE             = "./common/jsp/index_with_tree.jsp";
    public static final String LOGIN_MAIN_PAGE            = "./login/html/index.html";
    public static final String LOGIN_RECONNECT_PAGE       = "./common/html/index_reconnect.html";
    public static final String DISCONNECT_PAGE            = "./common/jsp/index_disconnect.jsp";
    public static final String NOIUSSES_PAGE              = "./common/html/index_noiusses.html";
    public static final String SCAD_PWD_MAIN_PAGE         = "./login/html/index_scadpwd.html";
    public static final String USER_NOPROFILE             = "./login/jsp/userNoprofile.jsp";


    public static final String LOGIN_FAILED               = "./login/html/loginFailed.html";
    public static final String USER_DISABLED              = "./login/html/userDisabled.html";
    public static final String USER_LOGIN_DISABLED        = "./login/html/userLoginDisabled.html";
    public static final String IMAGE_DIR_PATH             = "/image";
    public static final String CSS_PATH                   = "/css/Style.css";
    public static final boolean DEBUG                     = true;
    public static final String JDBC_URL                   = "jdbc:oracle:thin:@RC2603:1521:SACCEPT";
    public static final String DSNAME                     = "jdbc/PitagoraDS";
    
/*    ATTENZIONE!!!!!!!!!!!!!!!!! 
 *  ATTENZIONE!!!!!!!!!!!!!!!!!     (LA VERSIONE IN ESERCIZIO ATTUALMENTE DEVE ESSERE LA 1.9.1.2)
 *  NON MODIFICARE LA VERSIONE DI JPUB2 PER ESERCIZIO
 *  O SE DEVE ESSERE MODIFICATA DITEMELO CHE CAMBIO I CONTROLLI CHE EFFETTUO SUL CODICE..
 *  PER NON RILASCIARE IN ESERCIZIO UNA VERSIONE CHE DEVE ANCORA ESSERE COLLAUDATA.
 *  MARTINO MARANGI 
 *  */

    public static final String VERSIONE_JPUB              = "11.5.1";	//TRACCIABILITA LISTINI E FATT-NDC

    public static final String ATTRIBUTE_USER             = "INFO_USER";

    public static final String ATTRIBUTE_LOG_FILE         = "coldjavalog";  // GESTISCE LE FUNZIONALITA' LEGATE AI LOG FILE
    // UTILIZZATO DAL TAGLIB DI GESTIONE DEI LOG FILE ED IMPOSTATO NEL SERVLET CONTROLLER.
    public static final String ID_MASTER_LOG              = "MASTER_LOG";    // ID UTILIZZATO NELLE JSP PER RIFERIRSI AL MASTERLOG TRAMITE IL TAG LOGDATA
    public static final String ID_DAILY_LOG               = "DAILY_LOG";    // ID UTILIZZATO NELLE JSP PER RIFERIRSI AL MASTERLOG TRAMITE IL TAG LOGDATA
    public static final String LOG_DIR                    = "./log/";
    public static final String MASTER_LOG                 = "./log/TRACCIAMENTI/master.log";  // UTILIZZATO NELL CONTROLLER SERVLET PER IMPOSTARE IL LOG FILE GENERALE   
    public static final String PACKAGE_CLASSIC            = "PKG_BILL_CLA";
    public static final String PACKAGE_SPECIAL            = "PKG_BILL_SPE";
    public static final String PACKAGE_UTILITY            = "PKG_UTILITY";
    public static final String PACKAGE_REPDECOMM          = "PKG_REPDECOMM";
    public static final String PACKAGE_SPECIAL_ONLINE     = "PKG_BILL_SPE_ONLINE";    
    public static final String PACKAGE_COMMON             = "PKG_BILL_COM";
    public static final String PKG_EVENTI                 = "PKG_EVENTI.";
    public static final String PKG_CATALOGO               = "PKG_CATALOGO.";
    public static final String PKG_CATALOGO_AGGIORNAMENTO = "PKG_CATALOGO_AGGIORNAMENTO.";    
    public static final String PKG_DOWNLOAD               = "PKG_DOWNLOAD.";    
    public static final String PKG_ESTRAZIONI             = "ESTRAZIONI.";        

  public static final String PKG_ACCORDI = "PKG_ACCORDI.";
		// NOTA SE SI EFFETTUA IL DEBUG DENTRO JDEVELOPER 10g 10.1.3 VA CREATA LA CARTELLA DI LOG
		// NEL PATH DI JDEVELOPER EMBEDDED, ALTRIMENTI SI INCAPPA NELL ERRORE GENERATO IN FASE DI SCRITTURA DEL FILE DI LOG.
		// C:\jdev10g_1013__3673__jdk5\jdev\system\oracle.j2ee.10.1.3.36.73\embedded-oc4j\config
		///////////////////////////////////////////////////////////////////////////////////////////////


    public static final String APP_SERVER_DRIVER          = "APSERVER";

    public static final SimpleDateFormat formatter_filename   = new SimpleDateFormat( "yyyyMMdd", Locale.getDefault() );

    public static final String SENDADRRESS          = "jpub_support@telecomitalia.it";
    public static final String RECIPIENTADDRESS     = "jpub_support@telecomitalia.it";
    
    /*QS 15-01-2009: Modificato l'IP del server di posta ESMTP da 156.54.242.23 a 156.54.205.249 */
    public static final String MAILSERVER           = "156.54.205.249";
    public static final String POPSERVER            = "156.54.205.249";
    public static final String SUBJECT              = "Errore Billing Integrato";
    public static final String USER_SEND_MAIL       = "CD007483@telecomitalia.it";
    public static final String PWD_SEND_MAIL        = "1!elia22";

    public static final String ACTION_INDICATOR      = "ACTION_INDICATOR"; // Indicatore dell'azione correntemente eseguita dall'amministratore. S=SHUTDOWN
    public static final String ACTION_SHUTDOWN       = "S"; // Azione correntemente eseguita dall'amministratore. S=SHUTDOWN
    public static final String ADMIN_INDICATOR       = "Y"; // Controlla se l'tente preso dal DB e' amministratore
    public static final String OLO_PARAM             = "OLO"; // Valore della colonna CODE_PARAM DI i5_6PARAM
    public static final String VOL_PARAM             = "VOL"; // Valore della colonna CODE_PARAM DI i5_6PARAM
    public static final String ALL_PARAM             = "ALL"; // Valore della colonna CODE_PARAM DI i5_6PARAM
    public static final String MANUTENZIONE_PARAM    = "MAN"; // Valore della colonna CODE_PARAM DI i5_6PARAM

    // Aggiunte pre autenticazione ldap
    public static final String DEFAULT_FACTORY        = "com.sun.jndi.ldap.LdapCtxFactory";
    public static final String DEFAULT_AUTHENTICATION = "simple";
    public static final String NO_AUTHENTICATION = "none";
    public static final String uidAttribute = "uid";
    public static final int MAXDURPASSWORD = 180;

    public final static String ENCCharset = "UTF-8";

    public static final String url = "ldap://156.54.242.110/O=Telecom Italia Group";
    public static final String baseInternalDN = "OU=dipendenti,OU=TelecomItalia,O=Telecom Italia Group";
    public static final String baseExternalDN = "OU=personale esterno,O=Telecom Italia Group";
    public static final String searchDipendenti = "ou=dipendenti,ou=Telecomitalia";
    public static final String searchPersonaleEsterno = "OU=personale esterno";
    public static final String searchOlivetti = "ou=dipendenti,ou=Telecomitalia";
    

    //public static final String REGISTRATION_SUBJECT = "Registrazione Utente";
    //public static final String REGISTRATION_FROM = "sistinaonline@telecomitalia.it";

    public static void writeDEBUG (String aString)
    {
        if (DEBUG)
            System.out.println (aString);
    }

    public static synchronized void writeLog(String sLogString)
    {
        try {
            FileOutputStream fileoutputstream = new FileOutputStream(MASTER_LOG, true);
            byte abyte[] = sLogString.getBytes();
            fileoutputstream.write(abyte, 0, abyte.length);
            fileoutputstream.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static synchronized void writeLogUser(String sLogString, HttpSession sessioneHttp, Hashtable hashtable)
    {

        try {
            clsInfoUser aInfoUser = (clsInfoUser) sessioneHttp.getAttribute(ATTRIBUTE_USER);

            LogBean userLogBean = (LogBean) hashtable.get(aInfoUser.getUserName());
 
            FileOutputStream fileoutputstream = new FileOutputStream(userLogBean.getFileName(), true);
            byte abyte[] = sLogString.getBytes();
            fileoutputstream.write(abyte, 0, abyte.length);
            fileoutputstream.close();
        } catch (Exception ex) {
            if ((ex instanceof IllegalStateException) ||
                (ex instanceof NullPointerException)) writeLog(sLogString);
            else ex.printStackTrace();
        }
    }
//log collector
 public static synchronized void writeLogDaily(String sLogString, HttpServletRequest sessioneHttp, Hashtable hashtable)
 {

     try {
         clsInfoUser aInfoUser = (clsInfoUser) sessioneHttp.getSession().getAttribute(ATTRIBUTE_USER);

         LogBean dailyLogBean = (LogBean) hashtable.get(ID_DAILY_LOG);
 
         String ServletName= getJspName(sessioneHttp);
         FileOutputStream fileoutputstream = new FileOutputStream(dailyLogBean.getFileName(), true);
         String idSession = sessioneHttp.getSession().getId();
         SimpleDateFormat formatter_timeStamp  = new SimpleDateFormat( "dd-MM-yyyy kkmm-ss", Locale.getDefault() );
         String timeStamp =formatter_timeStamp.format(new Date());
         String Sorgente = sessioneHttp.getRemoteAddr();
         String Destinazione = sessioneHttp.getLocalAddr();
         String Utenza =  aInfoUser.getUserName();
         String ProfUtenza = aInfoUser.getUserProfile();
         String Servizio = "HTTP";
         String TipoEvento = StaticMessages.getMessage(3020,ServletName).replace("\n","");
         String Evento = "Elaborazione WEB";
         String Messaggio = idSession + "," + timeStamp +  "," + Sorgente + "," + Destinazione + "," + Utenza + "," + ProfUtenza + "," + Servizio + "," + TipoEvento + "," + Evento + "\n";
         byte abyte[] = Messaggio.getBytes();
         fileoutputstream.write(abyte, 0, abyte.length);
         fileoutputstream.close();
     } catch (Exception ex) {
         if ((ex instanceof IllegalStateException) ||
             (ex instanceof NullPointerException)) writeLog(sLogString);
         else ex.printStackTrace();
     }
 }
//log collector
    public static void RedirectPageToLogin (HttpServletRequest request,JspWriter out,boolean modal) throws Exception
    {
        StaticContext.writeLog(StaticMessages.getMessage(7004,request,APP_SERVER_DRIVER)); //RIDIREZIONE UTENTE NON AUTORIZZATO

        out.println("<HTML>");
        out.println("<HEAD>");
        out.println("<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">");
        out.println("<META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">");
        out.println("<script language=\"JavaScript\">");
        out.println("function invalidate()");
        out.println("{");
        if (modal) {

            out.println("if ((String(opener)!='undefined')&&(String(opener)!='null'))");
            out.println("{");
            out.println(" if ((String(opener.opener)!='undefined')&&(String(opener.opener)!='null'))");
            out.println(" {");
            out.println("   self.close();");
            out.println("   opener.self.close();");
            out.println("   opener.opener.top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.LOGIN_RECONNECT_PAGE + "\"");
            out.println(" }else{");
            out.println("   self.close();");
            out.println("   opener.top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.LOGIN_RECONNECT_PAGE + "\"");
            out.println(" }");
            out.println("}");
            out.println("else");
            out.println("top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.LOGIN_RECONNECT_PAGE + "\"");

            /*out.println("if ((String(opener)!='undefined')&&(String(opener)!='null'))");
            out.println("{");
            out.println("self.close();");
            out.println("opener.top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.LOGIN_RECONNECT_PAGE + "\"");
            out.println("}");
            out.println("else");
            out.println("top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.LOGIN_RECONNECT_PAGE + "\"");*/
        } else
            out.println("top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.LOGIN_RECONNECT_PAGE + "\"");

        out.println("}");
        out.println("</script>");
        out.println("</HEAD>");
        out.println("<BODY onLoad=invalidate();>");
        out.println("</BODY>");
        out.println("<HEAD>");
        out.println("<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">");
        out.println("<META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">");
        out.println("</HEAD>");
        out.println("</HTML>");
    }

    public static void RedirectPageToLogin (HttpServletRequest request,java.io.PrintWriter out,boolean modal) throws Exception
    {
        StaticContext.writeLog(StaticMessages.getMessage(7004,request,APP_SERVER_DRIVER)); //RIDIREZIONE UTENTE NON AUTORIZZATO

        out.println("<HTML>");
        out.println("<HEAD>");
        out.println("<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">");
        out.println("<META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">");
        out.println("<script language=\"JavaScript\">");
        out.println("function invalidate()");
        out.println("{");
        if (modal) {
            out.println("if ((String(opener)!='undefined')&&(String(opener)!='null'))");
            out.println("{");
            out.println(" if ((String(opener.opener)!='undefined')&&(String(opener.opener)!='null'))");
            out.println(" {");
            out.println("   self.close();");
            out.println("   opener.self.close();");
            out.println("   opener.opener.top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.LOGIN_RECONNECT_PAGE + "\"");
            out.println(" }else{");
            out.println("   self.close();");
            out.println("   opener.top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.LOGIN_RECONNECT_PAGE + "\"");
            out.println(" }");
            out.println("}");
            out.println("else");
            out.println("top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.LOGIN_RECONNECT_PAGE + "\"");

        } else
            out.println("top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.LOGIN_RECONNECT_PAGE + "\"");

        out.println("}");
        out.println("</script>");
        out.println("</HEAD>");
        out.println("<BODY onLoad=invalidate();>");
        out.println("</BODY>");
        out.println("<HEAD>");
        out.println("<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">");
        out.println("<META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">");
        out.println("</HEAD>");
        out.println("</HTML>");
    }

    public static void RedirectPageNoIusses (HttpServletRequest request,JspWriter out,boolean modal) throws Exception
    {
        StaticContext.writeLog(StaticMessages.getMessage(7001,request,APP_SERVER_DRIVER)); //RIDIREZIONE UTENTE NON AUTORIZZATO

        out.println("<HTML>");
        out.println("<HEAD>");
        out.println("<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">");
        out.println("<META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">");
        out.println("<script language=\"JavaScript\">");
        out.println("function invalidate()");
        out.println("{");
        if (modal) {
            out.println("if ((String(opener)!='undefined')&&(String(opener)!='null'))");
            out.println("{");
            out.println("self.close();");
            out.println("opener.top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.NOIUSSES_PAGE + "\"");
            out.println("}");
            out.println("else");
            out.println("top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.NOIUSSES_PAGE + "\"");
        } else
            out.println("top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.NOIUSSES_PAGE + "\"");
        out.println("}");
        out.println("</script>");
        out.println("</HEAD>");
        out.println("<BODY onLoad=invalidate();>");
        out.println("</BODY>");
        out.println("<HEAD>");
        out.println("<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">");
        out.println("<META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">");
        out.println("</HEAD>");
        out.println("</HTML>");
    }

    public static void RedirectPageNoIusses (HttpServletRequest request,java.io.PrintWriter out,boolean modal) throws Exception
    {
        StaticContext.writeLog(StaticMessages.getMessage(7001,request,APP_SERVER_DRIVER)); //RIDIREZIONE UTENTE NON AUTORIZZATO

        out.println("<HTML>");
        out.println("<HEAD>");
        out.println("<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">");
        out.println("<META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">");
        out.println("<script language=\"JavaScript\">");
        out.println("function invalidate()");
        out.println("{");
        if (modal) {
            out.println("if ((String(opener)!='undefined')&&(String(opener)!='null'))");
            out.println("{");
            out.println("self.close();");
            out.println("opener.top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.NOIUSSES_PAGE + "\"");
            out.println("}");
            out.println("else");
            out.println("top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.NOIUSSES_PAGE + "\"");
        } else
            out.println("top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.NOIUSSES_PAGE + "\"");
        out.println("}");
        out.println("</script>");
        out.println("</HEAD>");
        out.println("<BODY onLoad=invalidate();>");
        out.println("</BODY>");
        out.println("<HEAD>");
        out.println("<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">");
        out.println("<META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">");
        out.println("</HEAD>");
        out.println("</HTML>");
    }


    public static void RedirectPageDisconnect (HttpServletRequest request,java.io.PrintWriter out,boolean modal) throws Exception
    {
        StaticContext.writeLog(StaticMessages.getMessage(7005,request,APP_SERVER_DRIVER)); //RIDIREZIONE UTENTE X ALLINEAMENTO DB

        out.println("<HTML>");
        out.println("<HEAD>");
        out.println("<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">");
        out.println("<META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">");
        out.println("<script language=\"JavaScript\">");
        out.println("function invalidate()");
        out.println("{");
        if (modal) {

            out.println("if ((String(opener)!='undefined')&&(String(opener)!='null'))");
            out.println("{");
            out.println(" if ((String(opener.opener)!='undefined')&&(String(opener.opener)!='null'))");
            out.println(" {");
            out.println("   self.close();");
            out.println("   opener.self.close();");
            out.println("   opener.opener.top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.DISCONNECT_PAGE + "\"");
            out.println(" }else{");
            out.println("   self.close();");
            out.println("   opener.top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.DISCONNECT_PAGE + "\"");
            out.println(" }");
            out.println("}");
            out.println("else");
            out.println("top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.DISCONNECT_PAGE + "\"");

        } else
            out.println("top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.DISCONNECT_PAGE + "\"");

        out.println("}");
        out.println("</script>");
        out.println("</HEAD>");
        out.println("<BODY onLoad=invalidate();>");
        out.println("</BODY>");
        out.println("<HEAD>");
        out.println("<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">");
        out.println("<META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">");
        out.println("</HEAD>");
        out.println("</HTML>");
    }

    public static void RedirectPageDisconnect (HttpServletRequest request,JspWriter out,boolean modal) throws Exception
    {
        StaticContext.writeLog(StaticMessages.getMessage(7005,request,APP_SERVER_DRIVER)); //RIDIREZIONE UTENTE X ALLINEAMENTO DB

        out.println("<HTML>");
        out.println("<HEAD>");
        out.println("<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">");
        out.println("<META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">");
        out.println("<script language=\"JavaScript\">");
        out.println("function invalidate()");
        out.println("{");
        if (modal) {

            out.println("if ((String(opener)!='undefined')&&(String(opener)!='null'))");
            out.println("{");
            out.println(" if ((String(opener.opener)!='undefined')&&(String(opener.opener)!='null'))");
            out.println(" {");
            out.println("   self.close();");
            out.println("   opener.self.close();");
            out.println("   opener.opener.top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.DISCONNECT_PAGE + "\"");
            out.println(" }else{");
            out.println("   self.close();");
            out.println("   opener.top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.DISCONNECT_PAGE + "\"");
            out.println(" }");
            out.println("}");
            out.println("else");
            out.println("top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.DISCONNECT_PAGE + "\"");

        } else
            out.println("top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.DISCONNECT_PAGE + "\"");

        out.println("}");
        out.println("</script>");
        out.println("</HEAD>");
        out.println("<BODY onLoad=invalidate();>");
        out.println("</BODY>");
        out.println("<HEAD>");
        out.println("<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">");
        out.println("<META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">");
        out.println("</HEAD>");
        out.println("</HTML>");
    }

    public static void RedirectPageDisconnect (HttpServletRequest request,java.io.PrintWriter out,boolean modal,String param) throws Exception
    {
        String message="";

        if (param.equals(StaticContext.OLO_PARAM))
            message="Accorpamento OLO";
        else
            if (param.equals(StaticContext.VOL_PARAM))
            message="Voltura Circuiti";
        else
            if (param.equals(StaticContext.MANUTENZIONE_PARAM))
            message="Manutenzione del sistema JPUB";
        else
            if (param.equals(StaticContext.ALL_PARAM))
            message="Allineamento DB";

        StaticContext.writeLog(StaticMessages.getMessage(7006,request,APP_SERVER_DRIVER)); //RIDIREZIONE UTENTE PER ATTIVITA SUL DB

        out.println("<HTML>");
        out.println("<HEAD>");
        out.println("<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">");
        out.println("<META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">");
        out.println("<script language=\"JavaScript\">");
        out.println("function invalidate()");
        out.println("{");
        if (modal) {

            out.println("if ((String(opener)!='undefined')&&(String(opener)!='null'))");
            out.println("{");
            out.println(" if ((String(opener.opener)!='undefined')&&(String(opener.opener)!='null'))");
            out.println(" {");
            out.println("   self.close();");
            out.println("   opener.self.close();");
            out.println("   opener.opener.top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.DISCONNECT_PAGE + "?message="+message+"\"");
            out.println(" }else{");
            out.println("   self.close();");
            out.println("   opener.top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.DISCONNECT_PAGE + "?message="+message+"\"");
            out.println(" }");
            out.println("}");
            out.println("else");
            out.println("top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.DISCONNECT_PAGE + "?message="+message+"\"");

        } else
            out.println("top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.DISCONNECT_PAGE + "?message="+message+"\"");

        out.println("}");
        out.println("</script>");
        out.println("</HEAD>");
        out.println("<BODY onLoad=invalidate();>");
        out.println("</BODY>");
        out.println("<HEAD>");
        out.println("<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">");
        out.println("<META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">");
        out.println("</HEAD>");
        out.println("</HTML>");
    }

    public static void RedirectPageDisconnect (HttpServletRequest request,JspWriter out,boolean modal,String param) throws Exception
    {
        String message="";

        if (param.equals(StaticContext.OLO_PARAM))
            message="Accorpamanto OLO in esecuzione";
        else
            if (param.equals(StaticContext.VOL_PARAM))
            message="Voltura Circuiti in esecuzione";
        else
            if (param.equals(StaticContext.MANUTENZIONE_PARAM))
            message="Manutenzione del sistema JPUB";
        else
            if (param.equals(StaticContext.ALL_PARAM))
            message="Allineamento DB";

        StaticContext.writeLog(StaticMessages.getMessage(7006,request,APP_SERVER_DRIVER)); //RIDIREZIONE UTENTE PER ATTIVITA SUL DB

        out.println("<HTML>");
        out.println("<HEAD>");
        out.println("<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">");
        out.println("<META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">");
        out.println("<script language=\"JavaScript\">");
        out.println("function invalidate()");
        out.println("{");
        if (modal) {
            out.println("if ((String(opener)!='undefined')&&(String(opener)!='null'))");
            out.println("{");
            out.println(" if ((String(opener.opener)!='undefined')&&(String(opener.opener)!='null'))");
            out.println(" {");
            out.println("   self.close();");
            out.println("   opener.self.close();");
            out.println("   opener.opener.top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.DISCONNECT_PAGE + "?message="+message+"\"");
            out.println(" }else{");
            out.println("   self.close();");
            out.println("   opener.top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.DISCONNECT_PAGE + "?message="+message+"\"");
            out.println(" }");
            out.println("}");
            out.println("else");
            out.println("top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.DISCONNECT_PAGE + "?message="+message+"\"");

        } else
            out.println("top.location="+"\"" + request.getContextPath() +"/"+ StaticContext.DISCONNECT_PAGE + "?message="+message+"\"");

        out.println("}");
        out.println("</script>");
        out.println("</HEAD>");
        out.println("<BODY onLoad=invalidate();>");
        out.println("</BODY>");
        out.println("<HEAD>");
        out.println("<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">");
        out.println("<META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">");
        out.println("</HEAD>");
        out.println("</HTML>");
    }



    public static String getJspName(HttpServletRequest request)
    {

        String AbsoluteServletPath = request.getServletPath();
        String sJspName=null;
        // CONTROLLO SE IL PATH CONTIENE IL . OPPURE SE POTREBBE NON ESSERE UN SERVLET
        int idxLastPoint=AbsoluteServletPath.lastIndexOf(".");
        if (idxLastPoint>0)
            sJspName =  AbsoluteServletPath.substring(AbsoluteServletPath.lastIndexOf("/")+1,idxLastPoint).toUpperCase();
        else
            sJspName =  AbsoluteServletPath.substring(AbsoluteServletPath.lastIndexOf("/")+1).toUpperCase();

        return sJspName;
    }


    public static clsInfoUser getAllInfoUser(HttpServletRequest request)
    {

        HttpSession httpsession = request.getSession(false);
        clsInfoUser aUserInfo =(clsInfoUser)httpsession.getAttribute(StaticContext.ATTRIBUTE_USER);

        return aUserInfo;

    }

    public static String FindExceptionType (Exception e)
    {
        String typeException="";
        System.out.println(e.toString());
        if (e instanceof NamingException)
            typeException="NamingException";
        else if (e instanceof FinderException)
            typeException="FinderException";
        else if (e instanceof RemoteException)
            typeException="RemoteException";
        else if (e instanceof SQLException)
            typeException="SQLException";
        else if (e instanceof javax.servlet.ServletException)
            typeException="ServletException";
        else if (e instanceof java.lang.NullPointerException)
            typeException="NullPointerException";
        else if (e instanceof com.utl.DecodingException)
            typeException="DecodingException";

        return typeException;
    }

    public static String replaceString(java.lang.String inputStr, java.lang.String findStr, java.lang.String replaceStr) {
        String returnStr = new String(inputStr);
        int pos = returnStr.indexOf(findStr, 0);
        while (pos != -1) {
            returnStr = returnStr.substring(0, pos)+ replaceStr+returnStr.substring(pos+findStr.length());
            pos = returnStr.indexOf(findStr, pos+replaceStr.length());
        }
        return returnStr;
    }


/*---------------------------------------------------------------
         AUTENTICAZIONE LDAP - INIZIO
---------------------------------------------------------------*/

    private static int checkExpiredPasword(String timeExpiredPasswordNanoseconds)
    {
        long delta = 0 ;
        long now = 0 ;
        long expiration = Long.parseLong(timeExpiredPasswordNanoseconds);
        long SECS_BETWEEN_EPOCHS = 11644473600l ;
        int returnedValue=-1;

        try {
            expiration = expiration/10000000;
            delta = expiration - SECS_BETWEEN_EPOCHS ;
            now =  System.currentTimeMillis()/1000;
            if ( delta < now ) {
                returnedValue=1;
            } else
                returnedValue=0;
        } catch (Exception e) {
            System.out.println(e.toString());
        } finally {
            return returnedValue;
        }
    }

public static int doAuthenticateLdap(String username, String password, String securityPrincipal, String urlDB)
    {
        int returnedValue = -1;
        String timeExpiredPasswordNanoseconds = "";
        String distinguishedName = "";
        Hashtable srchEnv = new Hashtable(11);
        srchEnv.put("java.naming.factory.initial", "com.sun.jndi.ldap.LdapCtxFactory");
        srchEnv.put("java.naming.provider.url", urlDB);
        srchEnv.put("java.naming.security.authentication", "simple");
        try
        {
            DirContext srchContext = new InitialDirContext(srchEnv);
            String base = "O=Telecom Italia Group";
            SearchControls srchControls = new SearchControls();
            srchControls.setSearchScope(2);
            NamingEnumeration srchResponse = srchContext.search(base, "(& (uid=" + username + "))", srchControls);
            if(srchResponse != null)
            {
                returnedValue = 0;
                SearchResult sr = (SearchResult)srchResponse.next();
                Attributes attrs = sr.getAttributes();
                timeExpiredPasswordNanoseconds = attrs.get("tigPwdExpirationDate").get().toString();
                distinguishedName = attrs.get("distinguishedName").get().toString();
                //returnedValue = checkExpiredPasword(timeExpiredPasswordNanoseconds);
                //returnedValue = 0;
                
                if(returnedValue == 0){
                  returnedValue = checkPasswordLdap(username, password, distinguishedName, urlDB);
                }
                
            }
            int j = returnedValue;
            return j;
        }
        catch(AuthenticationException authEx)
        {
            System.out.println("Authentication failed!");
            int i = returnedValue;
            return i;
        }
        catch(NamingException namEx)
        {
            System.out.println("Something went wrong!");
            namEx.printStackTrace();
            byte byte0 = 3;
            return byte0;
        }
    }

    
     public static int checkPasswordLdap(String username, String password, String securityPrincipal, String urlDB)
    {
        int returnedValue = 2;
        Hashtable srchEnv = new Hashtable(11);
        srchEnv.put("java.naming.factory.initial", "com.sun.jndi.ldap.LdapCtxFactory");
        srchEnv.put("java.naming.provider.url", urlDB);
        srchEnv.put("java.naming.security.authentication", "simple");
        srchEnv.put("java.naming.security.principal", securityPrincipal);
        srchEnv.put("java.naming.security.credentials", password);
        try
        {
            DirContext srchContext = new InitialDirContext(srchEnv);
            String base = "O=Telecom Italia Group";
            SearchControls srchControls = new SearchControls();
            srchControls.setSearchScope(2);
            NamingEnumeration srchResponse = srchContext.search(base, "(& (uid=" + username + "))", srchControls);
            if(srchResponse != null)
                returnedValue = 0;
            int j = returnedValue;
            return j;
        }
        catch(AuthenticationException authEx)
        {
            System.out.println("Authentication failed!");
            int i = returnedValue;
            return i;
        }
        catch(NamingException namEx)
        {
            System.out.println("Something went wrong!");
            namEx.printStackTrace();
            byte byte0 = 3;
            return byte0;
        }
    }



    /*
    public static Attributes getAttributes(String username,String baseDN, String searchDN,String urlDB)
    {
        DirContext conn = null;
        Attributes userAttributes=null;
        int returnedValue=-1;

        StringBuffer searchBuffer = new StringBuffer("uid=");
        searchBuffer.append(username).append(",").append(searchDN);

        try {
            Hashtable env = new Hashtable(5, 0.75f);
            env.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory");
            env.put(Context.PROVIDER_URL, urlDB);
            env.put(Context.SECURITY_AUTHENTICATION, NO_AUTHENTICATION);
            conn = new InitialDirContext(env);
            String[] listUserAttributes = new String[2];
            listUserAttributes [0]=new String("mobile");
            listUserAttributes [1]=new String("mail");            
            userAttributes=conn.getAttributes(searchBuffer.toString(),listUserAttributes);

            String urlDBManager = "ldap://156.54.242.110/O=Telecom Italia Group";
            Attributes attributesUserListManager;
            attributesUserListManager = StaticContext.searchUserLDAP(username,urlDBManager);
            String mailManager = "";
      
            if(attributesUserListManager != null){
              javax.naming.directory.Attribute mailManagerAttribute = attributesUserListManager.get("mailManager");
              if(mailManagerAttribute != null){
                mailManager = (String)mailManagerAttribute.get();
              }
            }

            userAttributes.remove("mailManager");
            userAttributes.put("mailManager",mailManager);
            
        } catch (Exception e) {
            System.out.println(e.toString());
        } finally {
            if ( conn != null )
                try {
                    conn.close();
                } catch (Exception e) {
                    System.out.println(e.toString());
                }
            return userAttributes;
        }

    }
    */

    public static Attributes getAttributes(String userName, String urlDB) {
      Attributes attrs = null;
      Hashtable srchEnv = new Hashtable(11);
      srchEnv.put("java.naming.factory.initial","com.sun.jndi.ldap.LdapCtxFactory");
      srchEnv.put("java.naming.provider.url", "ldap://156.54.242.110:389");
      srchEnv.put("java.naming.security.authentication", "simple");
      try {
        javax.naming.directory.DirContext srchContext = new InitialDirContext(srchEnv);
        String base = "O=Telecom Italia Group";
        SearchControls srchControls = new SearchControls();
        srchControls.setSearchScope(2);
        NamingEnumeration srchResponse = srchContext.search(base,"(& (uid=".concat(userName).concat("))"),srchControls);
        if (srchResponse != null) {
          SearchResult sr = (SearchResult) srchResponse.next();
          attrs = sr.getAttributes();
          //System.out.println("-------------------------START---------------------------------------------------------");
          NamingEnumeration all = attrs.getAll();
          Attribute attr = null;
          int iCounter = 0;
          while (all.hasMore()) {
            iCounter++;
            attr = (Attribute) all.next();
            //System.out.println(String.valueOf(iCounter).concat(") ").concat(attr.getID()).concat(" = ").concat(String.valueOf(attr.get())));
          }
          //System.out.println("-------------------------END---------------------------------------------------------");
        }
        Attributes attributes = attrs;
        return attributes;
			}  catch (AuthenticationException authEx){
          System.out.println("Authentication failed!");
          Attributes attributes = attrs;
          return attributes;
      } catch (NamingException namEx) {
          System.out.println("Something went wrong!");
          namEx.printStackTrace();
          Attributes attributes = attrs;
          return attributes;
      }
    }

    public static Attributes searchUserLDAP(String username, String urlDB)
    {
	    int returnedValue = -1;
	    String manager = "";
	    Attributes attrs = null;
	    Attributes attrsManager = null;
	    Hashtable srchEnv = new Hashtable(11);
	    srchEnv.put("java.naming.factory.initial", "com.sun.jndi.ldap.LdapCtxFactory");
	    srchEnv.put("java.naming.provider.url", urlDB);
	    srchEnv.put("java.naming.security.authentication", "simple");
	    try
	    {
	      DirContext srchContext = new InitialDirContext(srchEnv);
	      String base = "O=Telecom Italia Group";
	      SearchControls srchControls = new SearchControls();
	      srchControls.setSearchScope(2);
	      NamingEnumeration srchResponse = srchContext.search(base, "(& (uid=" + username + "))", srchControls);
	      if(srchResponse != null)
	      {
	        returnedValue = 0;
	        SearchResult sr = (SearchResult)srchResponse.next();
	        attrs = sr.getAttributes();
	        manager = attrs.get("manager").get().toString();
	        manager = manager.substring(4,12);
	        String  RamoLdap = Misc.nh((String)attrs.get("distinguishedName").get());
          StringTokenizer tokenRamo = new StringTokenizer(RamoLdap, ",");
	        String Utente =tokenRamo.nextToken();//fittizio in realà serve solo a scorrere il token
	        String strRamo = tokenRamo.nextToken();
	        strRamo=strRamo.substring(3);
          
          
            
	        NamingEnumeration srchResponseManager = srchContext.search(base, "(& (uid=" + manager + "))", srchControls);
	        if(srchResponseManager != null)
	        {
	          returnedValue = 0;
	          SearchResult srManager = (SearchResult)srchResponseManager.next();
	          attrsManager = srManager.getAttributes();
	          String ouManager = attrsManager.get("department").get().toString();
	          String mailManager =attrsManager.get("mail").get().toString();
	          
	          
	          attrs.remove("mailManager");
	          attrs.put("mailManager",mailManager);
	          
	          if(strRamo.compareToIgnoreCase("Dipendenti")!=0){
	            String companyManager = attrs.get("company").get().toString();
	            
	
	            String ouPersonaleEsterno = companyManager +"/"+ouManager;
	            attrs.remove("ou");
	            attrs.put("ou",ouPersonaleEsterno);
	          } else
            {
              String ouInterno = attrs.get("department").get().toString();
              attrs.remove("ou");
              attrs.put("ou",ouInterno);
            }
	          
	        }
	      }
	      return attrs;
	    }
	    catch(AuthenticationException authEx)
	    {
	      System.out.println("Authentication failed!");
	      int i = returnedValue;
	      return attrs;
	    }
	    catch(NamingException namEx)
	    {
	      System.out.println("Something went wrong!");
	      namEx.printStackTrace();
	      byte byte0 = 3;
	      return attrs;
	    }
      catch(Exception ex)
      {
        System.out.println("Something went wrong! "+ex.getMessage());
        return attrs;
      }
      
 
  	}



/*---------------------------------------------------------------
         AUTENTICAZIONE LDAP - FINE
---------------------------------------------------------------*/


/* ----------------------------------------------------------------
   INIZIO COSTANTI CPI
   ----------------------------------------------------------------*/
    //number format
    public static final String nfInputMask   = "************,******";
    // PageStyle
    public static final String bgColorHeader   = "#0a6b98";
    public static final String bgColorFooter   = "#d5ddf1";
    public static final String bgColorRigaPariErroreTabella   = "#FFFACD";
    public static final String bgColorRigaDispariErroreTabella   = "#F0E68C";
    public static final String bgColorTestataTabella   = "#d5ddf1";
    public static final String bgColorRigaDispariTabella   = "#cfdbe9";
    public static final String bgColorRigaPariTabella   = "#ebf0f0";
    public static final String bgColorCellaBianca   = "#ffffff";
    public static final String bgColorTabellaForm   = "#cfdbe9";
    public static final String bgColorTabellaGenerale  = "#cfdbe9";//#F6FAFA
    public static final String bgColorMsgPageBg1  = "#006699";
    public static final String bgColorMsgPageBg2  = "#ebf2ff";


    // Costanti che identificano la tipologia dell'operazione richiesta all'EJB.
    public static final int LIST   = 1;
    public static final int INSERT = 2;
    public static final int UPDATE = 3;
    public static final int DELETE = 4;

    public static final String FLAGSYS = "C";
    public static final String MERGE = "MERGE";
    public static final String DIFF  = "DIFF";
    public static final String MATCH = "MATCH";

    // Costanti che identificano la funzionalità che ha richiesto l'operazione all'EJB.
    public static final int FN_TARIFFA  = 1;
    public static final int FN_ASS_OFPS = 2;
    public static final int FN_TARIFFA_CDN = 3;
    public static final int FN_TARIFFA_PS_FIGLI_CDN = 4;
    public static final int FN_NOTE_DI_CREDITO = 5;
    public static final int FN_TARIFFA_TIPO_CONTR = 6;
    public static final int FN_CONGUAGLI_CAMBI_TARIFFA = 7;
    public static final int FN_SPESA_COMPLESSIVA = 8;
    public static final int FN_VALORIZZAZIONE_ATTIVA = 9;
    public static final int FN_ASS_TAR_SCO = 10;
    public static final int FN_STATISTICHE = 11;
    public static final int FN_PROVISIONING = 12;

    // Costanti di identificazione errori dell'applicazione.
    public static final String RUNNING_BATCH = "3003";
    public static final String ERR_ACCOUNT_NON_GEST = "3041";
    public static final String ERR_LANCIO_BATCH_NOT_OK = "3042";
    public static final String ERR_LANCIO_BATCH_OK = "3043";
    public static final String ERR_IMPOSS_ELAB = "CCB5B0044";

    // Costanti di identificazione dei package Oracle.
    public static final String PKG_ANAGRAFICAMESSAGGI        = "PKG_BILL_CLA.";
    public static final String PKG_BATCH                     = "PKG_BILL_CLA.";
    public static final String PKG_CLASS_OGG_FATT            = "PKG_BILL_CLA.";
    public static final String PKG_CLASSISCONTO              = "PKG_BILL_CLA.";
    public static final String PKG_CLIENTI                   = "PKG_BILL_CLA.";
    public static final String PKG_CONTRATTI                 = "PKG_BILL_CLA.";
    public static final String PKG_FASCE                     = "PKG_BILL_CLA.";
    public static final String PKG_FATTURE                   = "PKG_BILL_CLA.";
    public static final String PKG_FREQUENZE                 = "PKG_BILL_CLA.";
    public static final String PKG_MAP                       = "PKG_BILL_CLA.";
    public static final String PKG_OGGETTIFATTURAZIONE       = "PKG_BILL_CLA.";
    public static final String PKG_ASSOCOGGETTIFATTURAZIONE  = "PKG_BILL_CLA.";
    public static final String PKG_PRESTAZIONIAGGIUNTIVE     = "PKG_BILL_CLA.";
    public static final String PKG_PRODOTTISERVIZI           = "PKG_BILL_CLA.";
    public static final String PKG_SCARTI                    = "PKG_BILL_CLA.";
    public static final String PKG_TARIFFE                   = "PKG_BILL_CLA.";
    public static final String PKG_TARIFFESCONTI             = "PKG_BILL_CLA.";
    public static final String PKG_TIPIOFFERTE               = "PKG_BILL_CLA.";
    public static final String PKG_TIPICAUSALE               = "PKG_BILL_CLA.";
    public static final String PKG_UNITAMISURA               = "PKG_BILL_CLA.";
    public static final String PKG_SPESACOMPLESSIVA          = "PKG_BILL_CLA.";
    public static final String PKG_SCONTI                    = "PKG_BILL_CLA.";
    public static final String PKG_LANCIOBATCH               = "EXTERNAL_LIBRARY.";
    public static final String PKG_PROVISIONING              = "PKG_BILL_CLA.";

    // package J-PUB2
    public static final String PKG_SERVIZI                   = "PKG_TARIFFE.";
    public static final String PKG_OFFERTE                   = "PKG_TARIFFE.";
    public static final String PKG_PRODOTTI                  = "PKG_TARIFFE.";
    public static final String PKG_TARIFFE_NEW               = "PKG_TARIFFE.";
    public static final String PKG_TARIFFE_VERIFICA          = "PKG_TARIFFE_VERIFICA.";    
    public static final String PKG_OGGETTIFATTURAZIONE_NEW   = "PKG_TARIFFE.";
    public static final String PKG_MODALITAAPPLICAZIONE_NEW  = "PKG_TARIFFE.";
    public static final String PKG_TIPICAUSALE_NEW           = "PKG_TARIFFE.";
    public static final String PKG_CLASSISCONTO_NEW          = "PKG_TARIFFE.";
    public static final String PKG_FASCE_NEW                 = "PKG_TARIFFE.";
    public static final String PKG_REGOLE_TARIFFE            = "PKG_TARIFFE.";
    public static final String PKG_COMPONENTI                = "PKG_TARIFFE.";
    public static final String PKG_PRESTAZIONIAGGIUNTIVE_NEW = "PKG_TARIFFE.";
    public static final String PKG_BATCH_NEW                 = "PKG_TARIFFE.";
    public static final String PKG_TIPO_ARROTONDAMENTI       = "PKG_TARIFFE.";
    public static final String PKG_ELAB_ATTIVE               = "PKG_ELAB_ATTIVE.";
    public static final String PKG_RELAZIONI                 = "PKG_ELAB_ATTIVE.";

    public static final String CF_TARIFFE                    = "INSUPDDELTARIFFE";


    // Costanti di identificazione delle tipologie di contratto.
    public static final int TPL_ITC = 2; //interconnessione
    public static final int TPL_CDN = 5; //cdn
    public static final int TPL_ACCESSO_RETE_DATI = 7; //accesso rete dati
    public static final int TPL_ACQUISTI = 6; //acquisti
    public static final int TPL_CIRCUITI_PARZIALI = 8; //circuiti parziali

    // Costanti di identificazione del P/S
    public static final int PS_PORTA_CON_SEGNALAZIONE = 200;
    public static final int PS_PORTA_SENZA_SEGNALAZIONE = 201;
    public static final int PS_FLUSSO_RPVD = 1970;

    // Costanti di identificazione famiglie P/S
    public static final int PS_CDA = 1900;
    public static final int PS_CDF = 1945;
    public static final int PS_MULTIPUNTO = 1632;

    public static final String PS_34_MBITS = "3010";


    // Costanti di identificazione dell'Oggetto di Fatturazione
    public static final int OF_CONTRIBUTO_INSTALLAZIONE = 6;
    public static final int OF_CONTRIBUTO_INSTALLAZIONE_AMPL = 14;
    public static final int OF_CANONE_MENSILE_ITC = 7;
    public static final int OF_CANONE_MENSILE_AMPL_CANALI = 12;
    public static final int OF_CONTRIBUTO_INSTALLAZIONE_TRASM = 13;
    public static final int OF_CANONE_MENSILE_TRASM_FISSO = 4;
    public static final int OF_CANONE_MENSILE_TRASM_KM_FRAZIONE = 5;
    public static final int OF_CONTRIBUTO_VARIAZIONE_SWAP = 37;
    public static final int OF_CANONE_AGGIUNTIVO_FRIACO = 38;
    public static final int OF_CONTRIBUTO_ATTIVAZIONE_RPVD = 15;

    public static final int OF_CONTRIBUTO_DI_ALLACCIAMENTO = 1;
    public static final int OF_CANONE_MENSILE_RACC_CENTRALE = 2;
    public static final int OF_CANONE_MENSILE_AGGIUNTIVO_PER_DIRAMAZIONE_ATTIVA = 35;
    public static final int OF_CANONE_MENSILE_AGGIUNTIVO_PER_PUNTO_DI_DERIVAZIONE = 36;
    public static final int OF_CANONE_MENSILE_PORTA_ATM = 40;
    public static final int OF_CONTRIBUTO_DI_ATTIVAZIONE_PORTA_ATM = 39;
    public static final int OF_CONTRIBUTO_PER_TRASLOCO_INTERNO = 41;
    public static final int OF_CONTRIBUTO_DI_ATTIVAZIONE_KIT_IMA = 44;
    public static final int OF_CANONE_MENSILE_KIT_IMA = 45;
    //Contributo Sla Premium
    public static final int OF_CONTRIBUTO_SLA_PREMIUM = 54;
    //Canone mensile sla per disponibilita 51
    public static final int OF_CANONE_SLA_DISP = 51;
    //Canone mensile sla per disponibilita scontato 52
    public static final int OF_CANONE_SLA_SCONTO = 52;
    //Canone mensile sla per ripristino 53
    public static final int OF_CANONE_SLA_RIPRI = 53;

    public static final int OF_CONTRIBUTO_PIANIFICAZIONE = 55;
    public static final int OF_CONTRIBUTO_VOLTURA = 56;

    //costanti per code_tipo_caus
    public static final int CAUS_TRASLOCO_INTERNO = 10;

    //costanti per tipo compo
    public static final String TC_TERMINAZIONE = "01";
    public static final String TC_PARTE_TRASMISSIVA = "02";

    public static final String TC_TERMINAZIONE_PIANIFICATA = "03";
    public static final String TC_TERMINAZIONE_SEDE_COLO = "04";
    public static final String TC_TERMINAZIONE_SEDE_COLO_P = "05";

    public static final String CL_CONTRIBUTO = "1";
    public static final String CL_CANONE = "2";

    //costanti per code_class_ps
    public static final String CL_PS_BASSA01 = "01";
    public static final String CL_PS_BASSA02 = "02";

    // Costanti di identificazione dell'Unita di misura
    public static final int UM_KM = 1;

    // Costanti di definizioni Globali dell'applicazione.
    public static final String FORMATO_DATA = "dd/mm/yyyy";
    public static final String FORMATO_DATA_ORA = "dd/mm/yyyy hh24:mm:ss";

    //Costanti di definizione dei percorsi delle cartelle
    public static final String PH_CSS = "../../css/";

    public static final String PH_COMMON_JS = "../../common/js/";
    public static final String PH_COMMON_JSP = "../../common/jsp/";
    public static final String PH_COMMON_IMAGES = "../../common/images/body/";

    public static final String PH_CLASSIC_COMMON_JS = "../../classic_common/js/";
    public static final String PH_CLASSIC_COMMON_JSP = "../../classic_common/jsp/";
    public static final String PH_CLASSIC_COMMON_IMAGES = "../../classic_common/images/";

    public static final String PH_ASSOCIAZIONIOFPS_JS = "../../associazioni_ofps/js/";
    public static final String PH_ASSOCIAZIONIOFPS_JSP = "../../associazioni_ofps/jsp/";
    public static final String PH_ASSOCIAZIONIOFPS_IMAGES = "../../associazioni_ofps/images/";

    public static final String PH_RIBALTAMENTOTARIFFE_JS = "../../ribaltamento_tariffe/js/";
    public static final String PH_RIBALTAMENTOTARIFFE_JSP = "../../ribaltamento_tariffe/jsp/";
    public static final String PH_RIBALTAMENTOTARIFFE_IMAGES = "../../ribaltamento_tariffe/images/";

    public static final String PH_SPESACOMPLESSIVA_JS = "../../spesa_complessiva/js/";
    public static final String PH_SPESACOMPLESSIVA_JSP = "../../spesa_complessiva/jsp/";
    public static final String PH_SPESACOMPLESSIVA_IMAGES = "../../spesa_complessiva/images/";

    public static final String PH_EVENTI_JS = "../../generatore_eventi/js/";
    public static final String PH_EVENTI_JSP = "../../generatore_eventi/jsp/";

    public static final String PH_CATALOGO_JS = "../../gest_catalogo/js/";
    public static final String PH_CATALOGO_JSP = "../../gest_catalogo/jsp/";
    public static final String PH_CATALOGO_IMAGES = "../../gest_catalogo/images/";

    public static final String PH_TARIFFE_JS = "../../tariffe/js/";
    public static final String PH_TARIFFE_JSP = "../../tariffe/jsp/";
    public static final String PH_TARIFFE_IMAGES = "../../tariffe/images/";

    public static final String PH_ASS_TARIFFE_SCONTI_JS = "../../tariffe_sconti/js/";
    public static final String PH_ASS_TARIFFE_SCONTI_JSP = "../../tariffe_sconti/jsp/";
    public static final String PH_ASS_TARIFFE_SCONTI_IMAGES = "../../tariffe_sconti/images/";

    public static final String PH_NOTEDICREDITO_JS = "../../note_di_credito/js/";
    public static final String PH_NOTEDICREDITO_JSP = "../../note_di_credito/jsp/";
    public static final String PH_NOTEDICREDITO_IMAGES = "../../note_di_credito/images/";

    public static final String PH_CONGUAGLICAMBITARIFFA_JS = "../../conguagli_cambi_tariffa/js/";
    public static final String PH_CONGUAGLICAMBITARIFFA_JSP = "../../conguagli_cambi_tariffa/jsp/";
    public static final String PH_CONGUAGLICAMBITARIFFA_IMAGES = "../../conguagli_cambi_tariffa/images/";

    public static final String PH_VALORIZZAZIONEATTIVA_JS = "../../valorizzazione_attiva/js/";
    public static final String PH_VALORIZZAZIONEATTIVA_JSP = "../../valorizzazione_attiva/jsp/";
    public static final String PH_VALORIZZAZIONEATTIVA_IMAGES = "../../valorizzazione_attiva/images/";

    public static final String PH_LISTINOTARIFFARIO_JS = "../../listino_tariffario/js/";
    public static final String PH_LISTINOTARIFFARIO_JSP = "../../listino_tariffario/jsp/";
    public static final String PH_LISTINOTARIFFARIO_IMAGES = "../../listino_tariffario/images/";

    public static final String PH_SCONTI_JS = "../../sconti/js/";
    public static final String PH_SCONTI_JSP = "../../sconti/jsp/";
    public static final String PH_SCONTI_IMAGES = "../../sconti/images/";

    public static final String PH_TOOL_PREF_BATCH_AUTOMATISMO_JS = "../../batch_automatismo/js/";
    public static final String PH_TOOL_PREF_BATCH_AUTOMATISMO_JSP = "../../batch_automatismo/jsp/";
    public static final String PH_TOOL_PREF_BATCH_AUTOMATISMO_IMAGES = "../../batch_automatismo/images/";

    public static final String PH_TOOL_PREF_BATCH_PREFATTURAZIONE_JS = "../../batch_prefatturazione/js/";
    public static final String PH_TOOL_PREF_BATCH_PREFATTURAZIONE_JSP = "../../batch_prefatturazione/jsp/";
    public static final String PH_TOOL_PREF_BATCH_PREFATTURAZIONE_IMAGES = "../../batch_prefatturazione/images/";

    public static final String PH_EXPORT_PER_SAP_JS = "../../export_per_sap/js/";
    public static final String PH_EXPORT_PER_SAP_JSP = "../../export_per_sap/jsp/";
    public static final String PH_EXPORT_PER_SAP_IMAGES = "../../export_per_sap/images/";

    public static final String PH_STORICIZ_NDC_FATT_JS = "../../stor_ndc_fatt/js/";
    public static final String PH_STORICIZ_NDC_FATT_JSP = "../../stor_ndc_fatt/jsp/";
    public static final String PH_STORICIZ_NDC_FATT_IMAGES = "../../stor_ndc_fatt/images/";

    public static final String PH_CONSUNT_SWN_JS = "../../consuntivo_swn/js/";
    public static final String PH_CONSUNT_SWN_JSP = "../../consuntivo_swn/jsp/";
    public static final String PH_CONSUNT_SWN_IMAGES = "../../consuntivo_swn/images/";

    public static final String PH_STATISTICHE_JS = "../../statistiche/js/";
    public static final String PH_STATISTICHE_JSP = "../../statistiche/jsp/";
    public static final String PH_STATISTICHE_IMAGES = "../../statistiche/images/";
    public static final String PH_STATISTICHE_SAVE = "../../statistiche/save/";

    public static final String PH_PROVISIONING_JSP = "../../provisioning/jsp/";
    public static final String PH_PROVISIONING_IMAGES = "../../provisioning/images/";

    public static final String PH_ELAB_ATT_JS = "../../elab_attive/js/";
    public static final String PH_ELAB_ATT_JSP = "../../elab_attive/jsp/";
    public static final String PH_ELAB_ATT_IMAGES = "../../elab_attive/images/";

    public static final String PH_UPLOAD_JS = "../../upload/js/";
    public static final String PH_UPLOAD_JSP = "../../upload/jsp/";
    public static final String PH_UPLOAD_IMAGES = "../../upload/images/";



// +-----------------------------------------------------------------------------------------
// | Costanti Ribes
    public static final int RIBES_INFR_OK = 0;
    public static final int RIBES_INFR_NOT_OK = 1;
    public static final String RIBES_INFR_BATCH_VAL_ATTIVA = "1";
    public static final String RIBES_INFR_BATCH_NOTE_CREDITO = "4";
    public static final String RIBES_INFR_BATCH_VAL_ATTIVA_AQ = "19";   //FC 10.12.2003
    public static final String RIBES_INFR_BATCH_NOTE_CREDITO_AQ = "12"; //FC 10.12.2003
    public static final String RIBES_INFR_BATCH_CAMBI_TARIFFA = "5";
    public static final String RIBES_INFR_BATCH_CALCOLO_SPESA_COMPLESSIVA = "9";
    public static final String RIBES_INFR_BATCH_RIBAL_TARIFFE = "6";
    //public static final String RIBES_INFR_BATCH_CALCOLO_CONGUAGLI_CAMBI_TARIFFA = "11";
    public static final String RIBES_CONG_BATCH_VAL_ATTIVA = "1001";
    public static final String RIBES_CONG_BATCH_NOTE_CREDITO = "1003";
    public static final String RIBES_CONG_BATCH_CAMBI_TARIFFA = "1004";
    public static final String RIBES_TOOL_PREFATTURAZIONE = "10030";
    public static final String RIBES_TOOL_AUTOMATISMO = "10031";
    public static final String RIBES_AUTOMATISMO_TLD = "10032";
    public static final String RIBES_EXPORT_PER_SAP = "10033";
    public static final String RIBES_IMPORT_PER_SAP = "10035";
    public static final String RIBES_IMPORT_PER_PS_SAP_SP = "10038";
    public static final String RIBES_IMPORT_COD_INVENT = "80100";
    public static final String RIBES_IMPORT_COD_ORDER = "80110";
    public static final String RIBES_SAP_REG = "10036";
    public static final String RIBES_SAP_XDSL = "10037";
    public static final String RIBES_REWRITE_SAP_REG = "10043";
    public static final String RIBES_REWRITE_SAP_XDSL = "10039";
    public static final String RIBES_SAP_ALL_CONTR = "99";
    public static final String RIBES_LANCIO_PKG = "10040";
    public static final String RIBES_STORICIZ_NDC_FATT = "10034";
    public static final String RIBES_IMPORT_TARIFFE_SP = "10044";    
    public static final String RIBES_IMPORT_PROMOZIONI = "10045";
    public static final String RIBES_IMPORT_FATTURE = "10046";
    public static final String RIBES_IMPORT_TARIFFE_SP_CLUS = "10047";
    public static final String RIBES_SEPARATORE_PARAMETRI = "$";
    public static final String RIBES_SEPARATORE1_PARAMETRI = "#";
    public static final String RIBES_SEPARATORE_FUNZ_PARAMETRI = "*";
    public static final String RIBES_SEPARATORE_PARAMETRI2 = " ";

    public static final String ELAB_ATTIVE_PARAM_GESTORI = "-g";
    public static final String ELAB_ATTIVE_PARAM_ACCOUNT = "-a";
    public static final String ELAB_ATTIVE_PARAM_SERVIZI = "-s";
    public static final String ELAB_ATTIVE_PARAM_TLD_FILE = "-f";
    public static final String ELAB_ATTIVE_PARAM_CONG_SPESA = "-z";
    public static final String ELAB_ATTIVE_PARAM_PARAMETRI = "-v";
    public static final String ELAB_ATTIVE_PARAM_VAL_MIGR = "-m";
    public static final String ELAB_ATTIVE_PARAM_DT_PERIOD = "-dp";
    public static final String ELAB_ATTIVE_PARAM_RES_SAP_JPUB2 = "-l";
    public static final String ELAB_ATTIVE_PARAM_RES_SAP_JPUBS = "-x";
    public static final String ELAB_ATTIVE_PARAM_RES_SAP_CICLO = "-c";
    public static final String ELAB_ATTIVE_PARAM_IVA_FC = "-fc";
    public static final String ELAB_ATTIVE_PARAM_CINQUE_ANNI = "-ca";
    public static final String ELAB_ATTIVE_PARAM_REPRICING = "-pr";


    public static final String RIBES_J2_VALMIGR = "VALMIGR";
    public static final String RIBES_J2_REPRICING = "REPRICING";
    public static final String RIBES_J2_VALORIZ = "VALORIZ";

    public static final String RIBES_J2_SAP = "EXPORT_SAP";
    public static final String RIBES_J2_EXPORT_SWN_VAL = "EXPORT_SWN_VAL";
    public static final String RIBES_J2_EXPORT_SWN_REPR = "EXPORT_SWN_REPR";
    public static final String RIBES_J2_EXPORT_CSV_REPR = "CSV_REPRICING";
    public static final String RIBES_J2_EXPORT_MENSILE = "EXPORT_MENSILE";
    public static final String RIBES_J2_EXPORT_REPRICING = "EXPORT_REPRICING";
    public static final String RIBES_J2_EXPORT_SAP_REPRICING = "EXPORT_SAP_REPRICING";
    public static final String RIBES_J2_ALL_PREINVE = "ALL_PREINVE";
    public static final String RIBES_J2_ALL_PREINVE_CRM = "ALL_PREINVE_CRM";
    public static final String RIBES_J2_ALL_PREINVE_CRM_JPUB= "ALL_PREINVE_CRM_JPUB";
    public static final String RIBES_J2_ALL_PREINVE_OD = "ALL_PREINVE_OD";
    public static final String RIBES_J2_ALL_PRE_CATALOGO = "ALL_PRE_CATALOGO";
    public static final String RIBES_J2_ELAB_PREINVE = "ELABORAZIONE_PREINVENTARIO";
    public static final String RIBES_IMPORT_PROVISIONING = "10041";
    public static final String RIBES_IMPORT_PROVISIONING_XML = "10042";
    public static final String RIBES_J2_GENERATORE_EVENTI = "GENEVENTI";
    public static final String RIBES_J2_CONSUNTIVO_SAP = "CONSUNTIVO_SAP";

    public static final String FATTURE_PROVVISORIE = "P";
    public static final String FATTURE_DEFINITIVE = "D";

    public static final String PKG_ACCORP_X_SAP = "PKG_ACCORPA_GEST_SAP_CL";
    public static final String PKG_VAL_CONSUNTIVO = "PKG_CONSUNT_SWN_VAL_CL";
    public static final String PKG_REP_CONSUNTIVO  = "PKG_CONSUNT_SWN_REP_CL";
/* ----------------------------------------------------------------
   FINE COSTANTI CPI
   ----------------------------------------------------------------*/
/* ----------------------------------------------------------------
   COSTANTI SPECIAL
   ----------------------------------------------------------------*/
    public static final String Interconnessione = "2";
    public static final String CDN                   = "5";
    public static final String Acquisti              = "6";
    public static final String CVPA                 = "7";
    public static final String NP                     = "7";
    public static final String CPS                   = "8";
    public static final String ULL                   = "9";
    public static final String CVP                   = "10";
    public static final String ADSL                 = "11";
    public static final String COLOCATION     = "12";
    public static final String EASYIP             = "13";
    public static final String CPVSA              = "18";

    public static final String INFR_BATCH_VAL_ATTIVA_CL       = "1";
    public static final String INFR_BATCH_SAR                   = "2";
    public static final String INFR_BATCH_NOTE_CREDITO_CL   = "4";
    public static final String INFR_BATCH_CAMBI_TARIFFA_CL  = "5";
    public static final String INFR_BATCH_VAL_ATTIVA_XDSL   = "21";
    public static final String INFR_BATCH_NOTE_CRED_XDSL        = "22";
    public static final String INFR_BATCH_VAL_ATTIVA_SP       = "23";
    public static final String INFR_BATCH_NOTE_CREDITO_SP   = "24";

    public static final String INFR_BATCH_CSV_NOTE_CREDITO_CL   = "503";
    public static final String INFR_BATCH_CSV_VAL_ATTIVA_CL     = "501";
    public static final String INFR_BATCH_CSV_AVANZAMENTO_RIC   = "502";
    public static final String INFR_BATCH_CSV_NC_DA_CAMBI_TAR   = "504";
    public static final String INFR_BATCH_CSV_VAL_ATT_XDSL      = "506";
    public static final String INFR_BATCH_CSV_NC_XDSL           = "507";
    public static final String INFR_BATCH_CSV_VAL_ATTIVA_SP     = "508";
    public static final String INFR_BATCH_CSV_NOTE_CREDITO_SP   = "509";

    public static final String INFR_BATCH_CONG_VAL_ATT_XDSL     = "1006";
    public static final String INFR_BATCH_CONG_NC_XDSL          = "1007";
    public static final String INFR_BATCH_CONG_VAL_ATTIVA_SP    = "1008";
    public static final String INFR_BATCH_CONG_NOTE_CREDITO_SP  = "1009";
    public static final String INFR_BATCH_CONG_REPR_ATT_XDSL    = "27";
    public static final String INFR_BATCH_CONG_FATT_MAN_XDSL    = "55";

    public static final String INFR_BATCH_CAMBI_TARIFFA_SP = "25";
    public static final String INFR_BATCH_CSV_CAMBI_TARIFFA_SP = "510";

/* ----------------------------------------------------------------
   FINE COSTANTI SPECIAL
   ----------------------------------------------------------------*/

/* ----------------------------------------------------------------
 * COSTANTI TRACCIAMENTI JEXCEL
 * VALORI DIVERSI A SECONDO DELL'AMBIENTE DOVE è INSTALLATO
 * ----------------------------------------------------------------*/

/*
    public static final String JEXCEL_DBDRIVER         = "oracle.jdbc.driver.OracleDriver";
    public static final String JEXCEL_DBUSR            = "jpub_oper";
    public static final String JEXCEL_DBPWD            = "jpub_oper";
    public static final String JEXCEL_DBURL            = "jdbc:oracle:thin:@10.188.40.20:1521:BILLSVIL";
*/
/* variabili locali */
/*
    public static final String JEXCEL_INPUTFILE           = "C:/jdev10g_1013__3673__jdk5/jdev/mywork/JEXCEL/master.log";
    public static final String JEXCEL_OUTPUTFILE_DLGS_196 = "C:/jdev10g_1013__3673__jdk5/jdev/mywork/JEXCEL/OUTPUT/dlgs_196_03_";    
    public static final String JEXCEL_OUTPUTFILE_DEL_152  = "C:/jdev10g_1013__3673__jdk5/jdev/mywork/JEXCEL/OUTPUT/del_152_02_cons_";    
    public static final String JEXCEL_LOGFILEHEADER       = "C:/jdev10g_1013__3673__jdk5/jdev/mywork/JEXCEL/LOG/outLog";
    public static final String JEXCEL_LOGDIRECTORY        = "C:/jdev10g_1013__3673__jdk5/jdev/mywork/JEXCEL/LOG/";
    public static final String JEXCEL_OUTPUTDIRECTORY     = "C:/jdev10g_1013__3673__jdk5/jdev/mywork/JEXCEL/OUTPUT/";
*/
/* variabili locali */

    public static final String JEXCEL_INPUTFILE           = LOG_DIR+"TRACCIAMENTI/master.log";
    public static final String JEXCEL_OUTPUTFILE_DLGS_196 = "/reportRac/UPLOAD/JEXCEL/OUTPUT/dlgs_196_03";    
    public static final String JEXCEL_OUTPUTFILE_DEL_152  = "/reportRac/UPLOAD/JEXCEL/OUTPUT/del_152_02_cons_";    
    //public static final String JEXCEL_OUTPUTFILEHEADER = LOG_DIR+"JEXCEL/OUTPUT/outExcel";
    public static final String JEXCEL_LOGDIRECTORY        = "/reportRac/UPLOAD/JEXCEL/LOG/";
    public static final String JEXCEL_OUTPUTDIRECTORY     = "/reportRac/UPLOAD/JEXCEL/OUTPUT/";
    public static final String JEXCEL_LOGFILEHEADER       = "/reportRac/UPLOAD/JEXCEL/LOG/outLog";        

/* ----------------------------------------------------------------
 * FINE COSTANTI TRACCIAMENTI JEXCEL
 * ----------------------------------------------------------------*/

}
