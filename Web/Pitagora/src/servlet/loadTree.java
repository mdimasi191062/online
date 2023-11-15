package com.servlet;

import java.util.*;
import java.io.*;
import java.rmi.RemoteException;
import javax.naming.NamingException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;
import javax.ejb.CreateException;
import javax.servlet.*;
import javax.servlet.http.*;

import com.ejbSTL.I5_6tree;
import com.ejbSTL.I5_6treeHome;
import com.utl.StaticContext;
import com.usr.clsInfoUser;
import com.utl.CustomException;
import com.utl.StaticMessages;

public class loadTree extends HttpServlet
{

	I5_6treeHome i5_6treeHome=null;
	I5_6tree i5_6tree=null;


	public void init() throws ServletException
	{
		try
		{
  		Context context=null;
			context = new InitialContext();     
			Object home = context.lookup("I5_6tree");        
			i5_6treeHome = (I5_6treeHome)PortableRemoteObject.narrow(home, I5_6treeHome.class);
		} 
    catch (Exception ex)
    {
       StaticMessages.setCustomString(ex.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5001,"loadTree","","",StaticContext.APP_SERVER_DRIVER));
       ex.printStackTrace();
    }
	}

	public void service(HttpServletRequest req, HttpServletResponse res) 
  {
		try
		{
      String attribute = new String(req.getParameter("fillme"));
			HttpSession httpsession=req.getSession(false);
			clsInfoUser userLogged=(clsInfoUser)httpsession.getAttribute(StaticContext.ATTRIBUTE_USER);
			sendOutput(loadTreeFromProfile(userLogged.getUserProfile()),res);
		} 
    catch (Exception ex)
    {
       StaticMessages.setCustomString(ex.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5001,"loadTree","","",StaticContext.APP_SERVER_DRIVER));
       ex.printStackTrace();
    }
	}

	public Vector loadTreeFromProfile(String aUserProfile)throws CustomException,RemoteException,CreateException
	{
		Vector vReturned=null;
    i5_6tree = i5_6treeHome.create(  );
    vReturned=i5_6tree.findAllTreeByProfile(aUserProfile);
		return vReturned;
	}

	public synchronized void sendOutput(Object toSend,HttpServletResponse res) throws Exception
	{
			OutputStream out = res.getOutputStream();
			ObjectOutputStream objStreamOut = new ObjectOutputStream(out);
			objStreamOut.writeObject(toSend);
			objStreamOut.flush();
			objStreamOut.close();
	}
}