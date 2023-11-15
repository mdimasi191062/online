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


//Stateless da utilizzare per il richiamo di stored necessarie per effettuari controlli generici
//fatti prima di eseguire delle modifiche alla base dati.


public class ControlliSTLBean extends AbstractSessionCommonBean implements SessionBean  
{
  public ControlliElem getInventPsSpVerEs(String codesito,String codeaccount) throws RemoteException, CustomException
	{
    
System.out.println("getInventPsSpVerEs");
    Connection conn=null;
    ControlliElem elem = new ControlliElem();
   try
      {
            
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".INVENT_PS_SP_VER_ES(?,?,?,?,?)}");
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.INVENT_PS_SP_VER_ES(?,?,?,?,?)}");
      
      // Impostazione types I/O
      cs.setString(1,codesito);
      cs.setString(2,codeaccount);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      
      cs.execute();


     if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));
     

      
              elem.setNumTariffe(cs.getInt(3));
             
              
             
      // Chiudo la connessione
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
									"getInventPsSpVerEs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getInventPsSpVerEs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
   


    return elem;
  }
  public int verFattAccount(String codesito,String codeaccount,String dataini) throws RemoteException, CustomException
	{
    
    Connection conn=null;
    int verifica = 0;
    try
      {
            
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_SITO_VER_PROVV(?,?,?,?,?,?)}");
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.TARIFFA_X_SITO_VER_PROVV(?,?,?,?,?,?)}");
      
      // Impostazione types I/O
      cs.setString(1,codesito);
      cs.setString(2,codeaccount);
      cs.setString(3,dataini);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      
      cs.execute();


     if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6));
      verifica= cs.getInt(4);
      // Chiudo la connessione
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
									"verFattAccount",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"verFattAccount",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
   


    return verifica;
  }

}