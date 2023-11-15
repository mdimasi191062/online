package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.*;
import java.util.*;
import java.rmi.*;
import java.sql.*;
import oracle.jdbc.*;
import oracle.sql.*;
import com.utl.*;


public class BatchSTLBean  extends AbstractSessionCommonBean implements SessionBean 
{
  /*public int elabora(String Msg) throws CustomException, RemoteException
    {
    //Connection conn=null;
    int p= 0;
    try
      {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call EXTERNAL_LIBRARY.INVIA_MSG(?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,Msg);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR); 
      cs.execute();
       /*     if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));*/
      /* p=cs.getInt(2);

       // Chiudo la connessione
      conn.close();
    }
 catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"elabora",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	   }
  return p; 
  }*/

  public BatchElem getCodeFunzFlag(String codeTipoContr,String codeTipoBatch, String codeFunzXRep, String flagSys) throws RemoteException, CustomException
    {
    BatchElem  elem = null;
    Connection conn= null;
    try
      {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".BATCH_DA_LANCIARE(?,?,?,?,?,?,?,?)}");
      cs.setString(1,codeTipoContr);
      cs.setString(2,codeTipoBatch);
      cs.setString(3,codeFunzXRep);
      cs.setString(4,flagSys);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR); 
      cs.execute();
      if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:BATCH_DA_LANCIRE:"+cs.getInt(7)+":"+cs.getString(8));

      if ((cs.getInt(7)==DBMessage.NOT_FOUND_RT))
      {
         if (!conn.isClosed()) conn.close();
         return elem;
      }
      elem=new BatchElem();
      elem.setCodeFunz(cs.getString(5));
      elem.setFlagTipoContr(cs.getInt(6));

      cs.close();
      //Chiudo la connessione
      conn.close();
      }
 catch(Exception lexc_Exception)
    {
      try
        {
          if (!conn.isClosed()) 
              conn.close();
        }
      catch (SQLException sqle)
        {
            throw new CustomException(sqle.toString(),
	  							"Errore nella chiusura della connessione",
									"getCodeFunzFlag",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }
      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCodeFunzFlag",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return elem;
  }
  

}