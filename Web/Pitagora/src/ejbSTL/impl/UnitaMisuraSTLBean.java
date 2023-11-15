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

public class UnitaMisuraSTLBean extends AbstractSessionCommonBean implements SessionBean 
{
  public Vector getUm() throws RemoteException, CustomException
  {
   Vector vect=new Vector();
   Connection conn=null;
   try
      {
      conn = getConnection(dsName);
//      InitialContext ic  = new javax.naming.InitialContext(); 
//      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME); 
//      conn = dataSource.getConnection(); 
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".UNITA_MISURA_LISTA(?,?,?)}");
      // Impostazione types I/O
      cs.registerOutParameter(1,OracleTypes.ARRAY, "ARR_UNITA_MIS");
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(2)!=DBMessage.OK_RT)&&(cs.getInt(2)!=DBMessage.NOT_FOUND_RT))
          throw new Exception("DB:"+cs.getInt(2)+":"+cs.getString(3));
      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_UNITA_MIS",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
      // Ottengo i dati
      rs=cs.getARRAY(1);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              UnitaMisuraElem  elem= new UnitaMisuraElem();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              elem.setCodeUnitaMisura(attr[0].stringValue());
              elem.setDescUnitaMisura(attr[1].stringValue());
              vect.addElement(elem);
          }      
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
									"getUm",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getUm",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }
}