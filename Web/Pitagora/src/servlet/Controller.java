package com.servlet;

import com.cj.log.LogBean; //TAGLIB Utilizzato per i logFiles
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.InitialContext;

import com.ejbSTL.Security;
import com.utl.I5_6anag_utenteROW;
import com.utl.ClassDatiTop;
import com.ejbSTL.SecurityHome;

import javax.ejb.CreateException;
import javax.ejb.FinderException;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;

import java.rmi.RemoteException;
import com.utl.CustomException;

import com.usr.clsInfoUser;
import com.utl.StaticContext;
import com.utl.StaticMessages;
import com.utl.DecodingException;

import java.net.InetAddress;

import java.text.SimpleDateFormat;

import javax.naming.directory.Attributes;
import javax.naming.directory.Attribute;

public class Controller extends HttpServlet
{
	SecurityHome securityHome=null;
	Security security=null;
        Hashtable hashtable=null;
	public void init()
	{
		try
		{
      Context context=null;
			context = new InitialContext();

      hashtable = (Hashtable)this.getServletContext().getAttribute(StaticContext.ATTRIBUTE_LOG_FILE);
      if(hashtable == null)
          hashtable = new Hashtable();


      LogBean masterLogBean = new LogBean();
      masterLogBean.setFileName(StaticContext.MASTER_LOG);
      masterLogBean.setOnState(true);
      hashtable.put(StaticContext.ID_MASTER_LOG, masterLogBean);
      this.getServletContext().setAttribute(StaticContext.ATTRIBUTE_LOG_FILE,hashtable);

			Object home = context.lookup("Security");
			securityHome = (SecurityHome)PortableRemoteObject.narrow(home, SecurityHome.class);
		}
    catch (Exception ex)
    {
       StaticMessages.setCustomString(ex.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5001,"Controller","","",StaticContext.APP_SERVER_DRIVER));
       ex.printStackTrace();
    }
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
	{
    try
    {
    if(isAuthenticated(request) == true)
        redirectToTreeMainPage(response,StaticContext.TREE_MAIN_PAGE);
      else
          processing(request, response);
    }
    catch (Exception ex)
    {
      try
      {
        ServletConfig servletconfig=getServletConfig();
        com.utl.SendError mySendError = new com.utl.SendError();
        mySendError.sendErrorRedirect (request,response,servletconfig,"/common/jsp/TrackingErrorPage.jsp",ex);
      }
      catch(Exception e)
      {
        StaticMessages.setCustomString(ex.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5001,"Controller","","",StaticContext.APP_SERVER_DRIVER));
        e.printStackTrace();
      }
    }
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
	{
    try
    {

      if(isAuthenticated(request) == true)
        redirectToTreeMainPage(response,StaticContext.TREE_MAIN_PAGE);
      else
        processing(request, response);
    }
    catch (Exception e)
    {
      try
      {
        ServletConfig servletconfig=getServletConfig();
        com.utl.SendError mySendError = new com.utl.SendError();
        mySendError.sendErrorRedirect (request,response,servletconfig,"/common/jsp/TrackingErrorPage.jsp",e);
      }
      catch(Exception ex)
      {
        StaticMessages.setCustomString(ex.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5001,"Controller","","",StaticContext.APP_SERVER_DRIVER));
        ex.printStackTrace();
      }
    }
	}


	public void processing(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse) throws CustomException
	{
    try
    {
      String s = httpservletrequest.getParameter("ACTION");
      if( "LOGIN".equalsIgnoreCase(s)){
        doAuthenticate(httpservletrequest, httpservletresponse);
      }else{
        HttpSession session = null; 
        Hashtable hstUtente = null;
        session = httpservletrequest.getSession(false); 
        if (session!=null) {
        // lp 20040511 : se la sessione � valorizzata provvede a scrivere 
        //               il msg di logout sul log-utente.
          hstUtente = (Hashtable)session.getServletContext().getAttribute(StaticContext.ATTRIBUTE_LOG_FILE);
          StaticContext.writeLogUser(StaticMessages.getMessage(3002,""),session,hstUtente);
          session.invalidate();
        }
        httpservletresponse.sendRedirect(StaticContext.LOGIN_MAIN_PAGE);
      }
    }
    catch(Exception e)
    {
      if (e instanceof CustomException)
      {
        CustomException myexception = (CustomException)e;
        throw myexception;
      }
      else
        throw new CustomException(e.toString(),"Errore durante processing","processing","Controller",StaticContext.FindExceptionType(e));
    }

	}

	private void doAuthenticate(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse) throws CustomException {
      	try {
            int aggiornaTntLogin = 0;
            String strUserName = httpservletrequest.getParameter("USERNAME");

            if(strUserName == null)
                strUserName = "";

            strUserName=strUserName.toUpperCase();
            String strPassword = httpservletrequest.getParameter("PWD_HIDDEN");

            if(strPassword == null)
                strPassword = "";

            String theClientAddress = httpservletrequest.getRemoteAddr();
            String theClientName = httpservletrequest.getRemoteHost();
            HttpSession httpsession=httpservletrequest.getSession(true);
            I5_6anag_utenteROW i5_6anag_utenteROW=null;
            ClassDatiTop classDatiTop=null;

            security = (Security)securityHome.create();
            i5_6anag_utenteROW = security.findByPK(strUserName);
            classDatiTop = security.findDataTop();

            String ip_ldap = security.findIpLdap();
            String root_ldap = security.findRootLdap();

//            String ldapUrl = "ldap://" +ip_ldap + "/" + root_ldap;
            String ldapUrl = "ldap://" +ip_ldap;

            if (i5_6anag_utenteROW!=null) {
                clsInfoUser aInfoUser=null;

                String decodedPasswordFromClient=null;

                decodedPasswordFromClient=new com.utl.CustomDecode(strPassword,strUserName).decode();

                /* controllo se utente � disabilitato */
                if (!i5_6anag_utenteROW.getflag_disabled().equalsIgnoreCase("S")
                    && !i5_6anag_utenteROW.getflag_disabled_pwd_err().equalsIgnoreCase("S")) {

                  // mando all LDAP
                  int result;
                  result = StaticContext.doAuthenticateLdap(strUserName,
                                                          decodedPasswordFromClient,
                                                          null,
                                                          ldapUrl);

                  if (result == 0 || result == 1){
                
                    //if (!i5_6anag_utenteROW.getflag_disabled().equalsIgnoreCase("S")) {
                      Date date = new Date();

                      if (!i5_6anag_utenteROW.getDateStart().after(date) &&
                          (i5_6anag_utenteROW.getDate_end() == null || 
                           (i5_6anag_utenteROW.getDate_end() != null && !i5_6anag_utenteROW.getDateStart().after(i5_6anag_utenteROW.getDate_end()))
                          )
                         )
                      {
                          Attributes attributesUserList;
                          attributesUserList = StaticContext.getAttributes(strUserName,ldapUrl);
                          Attribute mobileAttribute = attributesUserList.get("mobile");
                          Attribute mailAttribute = attributesUserList.get("mail");
                          Attribute nomeUtenteAttribute = attributesUserList.get("givenName");
                          Attribute cognUtenteAttribute = attributesUserList.get("sn");
                          Attribute managerAttribute = attributesUserList.get("manager");
                          
                          String mobile = null;
                          String mail = null;
                          String nomeUtente = null;
                          String cognUtente = null;
                          String manager = null;

                          if(managerAttribute != null){
                            manager = (String)managerAttribute.get();
                          }
                          
                          if(mobileAttribute != null){
                            mobile = (String)mobileAttribute.get();
                          }

                          if(mailAttribute != null){
                            mail = (String)mailAttribute.get();
                          }
                          
                          if(nomeUtenteAttribute != null){
                            nomeUtente = (String)nomeUtenteAttribute.get();
                          }

                          if(cognUtenteAttribute != null){
                            cognUtente = (String)cognUtenteAttribute.get();
                          }


                          /* dati manager */
                          String mailManager = null;
                          Attributes attributesUserListManager;
                          String uidManager = null;

                          try {
                            StringTokenizer stz = new StringTokenizer(manager,",");
                            String app = stz.nextToken();
                            uidManager = app.substring(4,app.length());                          
                          }catch(Exception ex){} 
                          
                          
                          attributesUserListManager = StaticContext.getAttributes(uidManager,ldapUrl);
                          Attribute mailManagerAttribute = attributesUserListManager.get("mail");

                          if(mailManagerAttribute != null){
                            mailManager = (String)mailManagerAttribute.get();
                          }

                          
                          httpsession.setMaxInactiveInterval(StaticContext.MAX_INACTIVE_INTERVAL);
                          aggiornaTntLogin = security.aggiorna_tnt_login(0,i5_6anag_utenteROW.getCode_utente());
                          aInfoUser=new clsInfoUser (i5_6anag_utenteROW.getCode_utente(),
                                                     theClientAddress,
                                                     theClientName,
                                                     i5_6anag_utenteROW.getCode_prof_utente(),
                                                     i5_6anag_utenteROW.getFlag_admin_ind(),
                                                     security,
                                                     theClientAddress,
                                                     classDatiTop.getDB_instance(),
                                                     classDatiTop.getServer(),
                                                     mobile,
                                                     mail
                                                    );
          
                          httpsession.setAttribute(StaticContext.ATTRIBUTE_USER, aInfoUser);
                          hashtable = (Hashtable)this.getServletContext().getAttribute(StaticContext.ATTRIBUTE_LOG_FILE);

                          if(hashtable == null)
                            hashtable = new Hashtable();

                          LogBean userLogBean = new LogBean();
                          userLogBean.setFileName(StaticContext.LOG_DIR+(i5_6anag_utenteROW.getCode_utente()+"_"+
                                                                     StaticContext.formatter_filename.format(new Date())+".log").toLowerCase());

                          //log collector    
                          InetAddress ip = InetAddress.getLocalHost();
                          String hostname = ip.getHostName();
                          SimpleDateFormat formatter_filename   = new SimpleDateFormat( "yyyy-MM-dd_23-59", Locale.getDefault() );
                          LogBean dailyLogBean = new LogBean();
                          dailyLogBean.setFileName(StaticContext.LOG_DIR+"JPUB.STDAPPL.1.1."+hostname+"."+formatter_filename.format(new Date())+".STANDARD-10.log");
                          hashtable.put(StaticContext.ID_DAILY_LOG, dailyLogBean);
                          this.getServletContext().setAttribute(StaticContext.ATTRIBUTE_LOG_FILE,hashtable);
                          dailyLogBean.setOnState(true);
                          //log collector                                                                     
                                                                     
                          userLogBean.setOnState(true);
                          hashtable.put(i5_6anag_utenteROW.getCode_utente(), userLogBean);

                          this.getServletContext().setAttribute(StaticContext.ATTRIBUTE_LOG_FILE,hashtable);

                          StaticContext.writeLogUser(StaticMessages.getMessage(3001,httpservletrequest), httpsession, hashtable);

                          if (security.aggiorna_login(strUserName,mail,mobile) != 0) 
                              throw new Exception();

                          /*if (security.aggiorna_email_mobile(strUserName,mail,mobile) != 0) 
                              throw new Exception();*/
                        
                          if (result == 0)
                              redirectToTreeMainPage(httpservletresponse,StaticContext.TREE_MAIN_PAGE);
                          else
                              redirectToTreeMainPage(httpservletresponse,StaticContext.SCAD_PWD_MAIN_PAGE);
                      } else {
                          /* utente disabilitato */
                          StaticContext.writeLog(StaticMessages.getMessage(7002,httpservletrequest,StaticContext.APP_SERVER_DRIVER)); //login DISABILITATA
                          httpservletresponse.sendRedirect(StaticContext.USER_LOGIN_DISABLED);
                      }                      
                  /*} else {
                      /* utente disabilitato */
                      /*StaticContext.writeLog(StaticMessages.getMessage(7002,httpservletrequest,StaticContext.APP_SERVER_DRIVER)); //login DISABILITATA
                      httpservletresponse.sendRedirect(StaticContext.USER_LOGIN_DISABLED);
                  }*/
                  } else {
                    /* utente non trovato in LDAP o password errata */
                    aggiornaTntLogin = security.aggiorna_tnt_login(i5_6anag_utenteROW.getNum_tnt_login()+1,i5_6anag_utenteROW.getCode_utente());
                    //StaticContext.writeLog(StaticMessages.getMessage(7002,httpservletrequest,StaticContext.APP_SERVER_DRIVER)); //NON AUTENTICATO SU LDAP
                    StaticContext.writeLog(StaticMessages.getMessage(7007,httpservletrequest,strUserName));
                    if(i5_6anag_utenteROW.getNum_tnt_login()+1 > 3){
                      StaticContext.writeLog(StaticMessages.getMessage(7008,httpservletrequest,strUserName));
                    }
                    httpservletresponse.sendRedirect(StaticContext.USER_NOPROFILE+"?SISTEMA=TELECOMITALIA"+"&USERNAME="+strUserName);                
                  }
                } else {
                    /* utente disabilitato */
                    //StaticContext.writeLog(StaticMessages.getMessage(7002,httpservletrequest,StaticContext.APP_SERVER_DRIVER)); //login DISABILITATA
                    StaticContext.writeLog(StaticMessages.getMessage(7009,httpservletrequest,strUserName));
                    httpservletresponse.sendRedirect(StaticContext.USER_LOGIN_DISABLED);
                }                  
            } else {
                /* utente non ha profilo in JPUB */
                StaticContext.writeLog(StaticMessages.getMessage(7002,httpservletrequest,StaticContext.APP_SERVER_DRIVER));  //NON AUTENTICATO SU JPUB
                httpservletresponse.sendRedirect(StaticContext.USER_NOPROFILE+"?SISTEMA=JPUB"+"&USERNAME="+strUserName);
            }
        } catch(Exception e) {
            if (e instanceof CustomException) {
                CustomException myexception = (CustomException)e;
                throw myexception;
            } else
                throw new CustomException(e.toString(),
                                                           "Errore durante autenticazione",
                                                           "doAuthenticated",
                                                           "Controller",
                                                           StaticContext.FindExceptionType(e));
        }
    }

	private boolean isAuthenticated(HttpServletRequest httpservletrequest) throws CustomException
	{
    try
    {
      clsInfoUser aUserInfo=null;
      I5_6anag_utenteROW i5_6anag_utenteROW2=null;
      HttpSession httpsession = httpservletrequest.getSession(false);

      if (httpsession!=null)
        aUserInfo =(clsInfoUser)httpsession.getAttribute(StaticContext.ATTRIBUTE_USER);

      if(aUserInfo != null)
      {
        String usernameNEW = httpservletrequest.getParameter("USERNAME");
        String usernameOLD = aUserInfo.getUserName();
        String strPasswordNEW = httpservletrequest.getParameter("PWD_HIDDEN");
        security = (Security)securityHome.create();
        i5_6anag_utenteROW2 = security.findByPK(usernameNEW);
        if (i5_6anag_utenteROW2 != null){
          String ldapUrlP = "ldap://" +security.findIpLdap() + "/" + security.findRootLdap();
          clsInfoUser aInfoUser=null;

          String decodedPasswordFromClientP=null;
          decodedPasswordFromClientP=new com.utl.CustomDecode(strPasswordNEW,usernameNEW).decode();

          // mando all LDAP
          int resultP;
          resultP = StaticContext.doAuthenticateLdap(usernameNEW,
                                                    decodedPasswordFromClientP,
                                                    null,
                                                    ldapUrlP);

          if (resultP == 0 || resultP == 1){
            if (!i5_6anag_utenteROW2.getflag_disabled().equalsIgnoreCase("S")) {
               Date date2 = new Date();
               if (!i5_6anag_utenteROW2.getDateStart().after(date2) &&
                  (i5_6anag_utenteROW2.getDate_end() == null || 
                  (i5_6anag_utenteROW2.getDate_end() != null && 
                   !i5_6anag_utenteROW2.getDateStart().after(i5_6anag_utenteROW2.getDate_end()))))
               {
                          Attributes attributesUserList2;
                          attributesUserList2 = StaticContext.getAttributes(usernameNEW,ldapUrlP);
                          Attribute mobileAttribute = attributesUserList2.get("mobile");
                          Attribute mailAttribute = attributesUserList2.get("mail");
                          Attribute mailManagerAttribute = attributesUserList2.get("mailManager");

                          Attribute nomeUtenteAttribute = attributesUserList2.get("givenName");
                          Attribute cognUtenteAttribute = attributesUserList2.get("sn");
                          
                          String mobile = null;
                          String mail = null;
                          String mailManager = null;
                          
                          if(mobileAttribute != null){
                            mobile = (String)mobileAttribute.get();
                          }

                          if(mailAttribute != null){
                            mail = (String)mailAttribute.get();
                          }

                          if(mailManagerAttribute != null){
                            mailManager = (String)mailManagerAttribute.get();
                          }

                          String nomeUtente = null;
                          String cognUtente = null;
                          
                          if(nomeUtenteAttribute != null){
                            nomeUtente = (String)nomeUtenteAttribute.get();
                          }

                          if(cognUtenteAttribute != null){
                            cognUtente = (String)cognUtenteAttribute.get();
                          }
                          
                          ClassDatiTop classDatiTop2=null;
                          classDatiTop2 = security.findDataTop();
                          
                          httpsession.setMaxInactiveInterval(StaticContext.MAX_INACTIVE_INTERVAL);
                          String theClientAddress2 = httpservletrequest.getRemoteAddr();
                          String theClientName2 = httpservletrequest.getRemoteHost();
                          aInfoUser=new clsInfoUser (i5_6anag_utenteROW2.getCode_utente(),
                                                     theClientAddress2,
                                                     theClientName2,
                                                     i5_6anag_utenteROW2.getCode_prof_utente(),
                                                     i5_6anag_utenteROW2.getFlag_admin_ind(),
                                                     security,
                                                     theClientAddress2,
                                                     classDatiTop2.getDB_instance(),
                                                     classDatiTop2.getServer(),
                                                     mobile,
                                                     mail
                                                    );
          
                          httpsession.setAttribute(StaticContext.ATTRIBUTE_USER, aInfoUser);
                          hashtable = (Hashtable)this.getServletContext().getAttribute(StaticContext.ATTRIBUTE_LOG_FILE);

                          if(hashtable == null)
                            hashtable = new Hashtable();

                          LogBean userLogBean = new LogBean();
                          userLogBean.setFileName(StaticContext.LOG_DIR+(i5_6anag_utenteROW2.getCode_utente()+"_"+
                                                                     StaticContext.formatter_filename.format(new Date())+".log").toLowerCase());

 //log collector    
                         InetAddress ip = InetAddress.getLocalHost();
                         String hostname = ip.getHostName();
                         SimpleDateFormat formatter_filename   = new SimpleDateFormat( "yyyy-MM-dd_23-59", Locale.getDefault() );
                         LogBean dailyLogBean = new LogBean();
                         dailyLogBean.setFileName(StaticContext.LOG_DIR+"JPUB.STDAPPL.1.1."+hostname+"."+formatter_filename.format(new Date())+".STANDARD-10.log");
                         hashtable.put(StaticContext.ID_DAILY_LOG, dailyLogBean);
                         this.getServletContext().setAttribute(StaticContext.ATTRIBUTE_LOG_FILE,hashtable);
                         dailyLogBean.setOnState(true);
 //log collector                                                                     

                          userLogBean.setOnState(true);
                          hashtable.put(i5_6anag_utenteROW2.getCode_utente(), userLogBean);

                          this.getServletContext().setAttribute(StaticContext.ATTRIBUTE_LOG_FILE,hashtable);

                          StaticContext.writeLogUser(StaticMessages.getMessage(3001,httpservletrequest), httpsession, hashtable);

                          if (security.aggiorna_login(usernameNEW,mail,mobile) != 0) 
                              throw new Exception();

                        
                          if (resultP == 0)
                              //redirectToTreeMainPage(httpservletresponse,StaticContext.TREE_MAIN_PAGE);
                              return true;
                          else
                              //redirectToTreeMainPage(httpservletresponse,StaticContext.SCAD_PWD_MAIN_PAGE);
                              return false;
                } else {
                          /* utente disabilitato */
                          StaticContext.writeLog(StaticMessages.getMessage(7002,httpservletrequest,StaticContext.APP_SERVER_DRIVER)); //login DISABILITATA
                          return false;
                }                      
            } else {
                      /* utente disabilitato */
                      StaticContext.writeLog(StaticMessages.getMessage(7002,httpservletrequest,StaticContext.APP_SERVER_DRIVER)); //login DISABILITATA
                      return false;
            }
          } else {
                  /* utente non trovato in LDAP*/
                  StaticContext.writeLog(StaticMessages.getMessage(7002,httpservletrequest,StaticContext.APP_SERVER_DRIVER)); //NON AUTENTICATO SU LDAP
                  return false;
          }
        }else{
          StaticContext.writeLog(StaticMessages.getMessage(3003,httpservletrequest,StaticContext.APP_SERVER_DRIVER));
          return false;
        }
      }
      else
      {
        StaticContext.writeLog(StaticMessages.getMessage(3003,httpservletrequest,StaticContext.APP_SERVER_DRIVER));
        return false;
      }
    }
    catch(Exception e)
    {
      if (e instanceof CustomException)
      {
        CustomException myexception = (CustomException)e;
        throw myexception;
      }
      else
        throw new CustomException(e.toString(),"Errore durante autenticazione","isAuthenticated","Controller",StaticContext.FindExceptionType(e));
    }
	}

	private void redirectToTreeMainPage(HttpServletResponse response,String location) throws IOException
  {

    response.setContentType("text/html; charset=windows-1252");
		PrintWriter printwriter = response.getWriter();

        printwriter.println("<HTML>");
 		printwriter.println("<HEAD>");
		printwriter.println("<script language=\"JavaScript\">");
		printwriter.println("function invalidate()");
		printwriter.println("{");
 		printwriter.println("top.location=\""+ location + "\"");
		printwriter.println("}");
		printwriter.println("</script>");
		printwriter.println("</HEAD>");
		printwriter.println("<BODY onLoad=invalidate();>");
		printwriter.println("</BODY>");
		printwriter.println("</HTML>");
		printwriter.close();

	}
}
