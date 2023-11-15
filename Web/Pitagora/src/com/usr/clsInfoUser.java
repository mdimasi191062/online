package com.usr;


import java.util.*;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;
import com.utl.StaticContext;
import com.utl.StaticMessages;
import com.cj.log.LogBean; //TAGLIB Utilizzato per i logFiles

import java.util.Hashtable;

import com.ejbSTL.Security;

public class clsInfoUser implements HttpSessionBindingListener, java.io.Serializable
{
	private String theUserName=null;
	private String theIpAddress=null;
	private String theComputerName=null;
	private String theUserProfile=null;
	private String theAdminIndicator=null;
  private String theClientIp=null;
  private String theDB_instanceName=null;
  private String theServer=null;
  private Security theRemoteInterface=null;

	private Date theTimeToConnect=null;
  private String theDesc_Mobile=null;
  private String theDesc_Mail=null;

	public void valueBound(HttpSessionBindingEvent event)
	{
    Hashtable hashtable = null;
		HttpSession session = event.getSession();

    hashtable = (Hashtable)session.getServletContext().getAttribute(StaticContext.ATTRIBUTE_LOG_FILE);
    if(hashtable == null)
        hashtable = new Hashtable();
    
    LogBean userLogBean = new LogBean();
    userLogBean.setFileName(StaticContext.LOG_DIR+(theUserName+"_"+StaticContext.formatter_filename.format(new Date())+".log").toLowerCase());
    userLogBean.setOnState(true);
    hashtable.put(theUserName, userLogBean);

    session.getServletContext().setAttribute(StaticContext.ATTRIBUTE_LOG_FILE,hashtable);

    StaticMessages.setCustomString(session.getId());
    theTimeToConnect = new Date();
/*    theTimeToConnect = StaticMessages.formatter_row.format(new Date());    */

	}

	public void valueUnbound(HttpSessionBindingEvent event) 	{

        HttpSession session = event.getSession();
        StaticMessages.setCustomString(session.getId());

        // messaggi per il master-log
        StaticContext.writeLog(StaticMessages.getMessage(3010,"CONNECTED " +StaticMessages.formatter_row.format(theTimeToConnect)+" DISCONNECTED "+StaticMessages.formatter_row.format(new Date()) ,theUserName));
//        StaticContext.writeLog(StaticMessages.getMessage(3010,"CONNECTED " +theTimeToConnect+" DISCONNECTED "+StaticMessages.formatter_row.format(new Date()) ,theUserName));        

        theUserName=null;
        theIpAddress=null;
        theComputerName=null;
        theUserProfile=null;
        theRemoteInterface=null;
        theAdminIndicator=null;
        theTimeToConnect=null;
        theClientIp=null;
        theDB_instanceName=null;
        theServer=null;
        theDesc_Mobile=null;
        theDesc_Mail=null;
   
	}

	public Security getRemoteInterface()
	{
		return theRemoteInterface;
	}
	public void setRemoteInterface(Security aRemoteInterface)
	{
		theRemoteInterface=aRemoteInterface;
	}


	public String getUserName()
	{
		return theUserName;
	}
	public void setUserName(String aUserName)
	{
		theUserName=aUserName;
	}
  
	public void setTimeToConnect(Date aTimeToConnect)
	{
		theTimeToConnect=aTimeToConnect;
	}

	public String getIpAddress()
	{
		return theIpAddress;
	}
	public void setIpAddress(String aIpAddress)
	{
		theIpAddress=aIpAddress;
	}


	public String getComputerName()
	{
		return theComputerName;
	}
	public void setComputerName(String aComputerName)
	{
		theComputerName=aComputerName;
	}

	public String getUserProfile()
	{
		return theUserProfile;
	}
	public void setUserProfile(String aUserProfile)
	{
		theUserProfile=aUserProfile;
	}

	public String getAdminIndicator()
	{
		return theAdminIndicator;
	}
	public void setAdminIndicator(String aAdminIndicator)
	{
		theAdminIndicator=aAdminIndicator;
	}

  public String getClientIp()
	{
		return theClientIp;
	}
	public void setClientIp(String aClientIp)
	{
		theClientIp=aClientIp;
	}

  public String getDB_instanceName()
	{
		return theDB_instanceName;
	}
	public void setDB_istanceName(String aDB_instace)
	{
		theDB_instanceName=aDB_instace;
	}

  public String getServer()
	{
		return theServer;
	}
	public void setServer(String aServer)
	{
		theServer=aServer;
	}

  public String getDescMobile()
	{
		return theDesc_Mobile;
	}
	public void setDescMobile(String aDesc_Mobile)
	{
		theDesc_Mobile=aDesc_Mobile;
	}

  public String getDescMail()
	{
		return theDesc_Mail;
	}
	public void setDescMail(String aDesc_Mail)
	{
		theDesc_Mail=aDesc_Mail;
	}

	public clsInfoUser(String aUserName,String aIpAddress,String aServerName,String aUserProfile,String aAdminIndicator,Security aRemoteInterface,String aClientIp, String aDB_instance, String aServer, String aDesc_Mobile, String aDesc_Mail)
	{
		theUserName=aUserName;
		theIpAddress=aIpAddress;
		theComputerName=aServerName;
		theUserProfile=aUserProfile;
		theAdminIndicator=aAdminIndicator;
		theRemoteInterface=aRemoteInterface;    
    theClientIp=aClientIp;
    theDB_instanceName=aDB_instance;
    theServer=aServer;
    theDesc_Mobile=aDesc_Mobile;
    theDesc_Mail=aDesc_Mail;
	}

/****************************************************************************/
/******************** FUNZIONE USATA PER TEST *******************************/
/**
private void trace(String s, HttpSessionBindingEvent event) 
{
  HttpSession session = event.getSession();

  java.util.Date now = new java.util.Date(System.currentTimeMillis());
  java.util.Date last = new java.util.Date(session.getLastAccessedTime());
  SimpleDateFormat fmt = new SimpleDateFormat ("hh:mm:ss");
  StringBuffer sb;
  sb = new StringBuffer();
  sb.append ("TRACE: ");
  sb.append (fmt.format(now));
  sb.append (" session: ");
  sb.append (session.getId());
  sb.append (" ultimo accesso ");
  sb.append (fmt.format(last));  
  System.out.println (sb.toString());
  sb = new StringBuffer();
  sb.append ("TRACE: ");
  sb.append (fmt.format(now));
  sb.append (" session: ");
  sb.append (session.getId());  
  sb.append (" theUserName: ");
  sb.append (theUserName);
  sb.append ("\nthePassword: ");
  sb.append (thePassword);
  sb.append (" theIpAddress: ");
  sb.append (theIpAddress);
  sb.append (" theComputerName: ");
  sb.append (theComputerName);
  System.out.println (sb.toString());
}
**/  
/****************************************************************************/



}