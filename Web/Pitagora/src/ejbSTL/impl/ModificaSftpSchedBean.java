package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.*;

import java.util.*;
import java.rmi.*;
import java.sql.*;

import oracle.jdbc.*;
import oracle.sql.*;
import java.util.Vector;
import java.rmi.RemoteException;
import com.utl.*;

public class ModificaSftpSchedBean  extends AbstractSessionCommonBean implements SessionBean 
{
  public int modifica(String azione,String idMessag,String dataSched)throws CustomException, RemoteException
    {
     
     try
      {
        int ritorno=-1;
       conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call  " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".MODIFICA_SFTP_SCHED(?,?,?,?,?)}");

      
      // Impostazione types I/O
      cs.setString(1,azione);
      cs.setString(2,idMessag);
      cs.setString(3,dataSched);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      
      cs.execute();
      ritorno=cs.getInt(4);

      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception(cs.getString(5));
      else
        ritorno=0;

      // Chiudo la connessione
      conn.close();
      return ritorno;
      }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"modifica",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}

    
  }
}