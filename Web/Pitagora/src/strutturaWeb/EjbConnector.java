package com.strutturaWeb;
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
import com.ejbBMP.*;
import com.ejbSTL.*;
import javax.ejb.EJBHome;
public class EjbConnector 
{


  public static EJBHome getHome(String requestEjb,Class classe) throws Exception
  {
  		Context context=null;
			context = new InitialContext();     
			Object home = context.lookup(requestEjb);        
			return (EJBHome)PortableRemoteObject.narrow(home, classe);
  }


}