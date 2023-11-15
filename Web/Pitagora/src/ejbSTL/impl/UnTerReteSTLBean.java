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

public class UnTerReteSTLBean extends AbstractSessionCommonBean implements SessionBean 
{
  // inizio METODO PER IL CARICAMENTO DELLA COMBO U.T.R. SU LISTA_ACCOUNT_COL
public Vector getUTR() throws RemoteException
	{
    Vector vect=new Vector();
    Connection conn=null;
   try
      {
            
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".UNITA_TERR_RETE_LISTA(?,?,?)}");
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.UNITA_TERR_RETE_LISTA(?,?,?)}");
      
      // Impostazione types I/O
      
      cs.registerOutParameter(1,OracleTypes.ARRAY, "ARR_UTR");
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);
      
      cs.execute();


     if ((cs.getInt(2)!=DBMessage.OK_RT)&&(cs.getInt(2)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(2)+":"+cs.getString(3));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_UTR",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(1);
      Datum dati[]=rs.getOracleArray();
      
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              UnTerReteElem elem = new UnTerReteElem();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
      
              elem.setCodeUTR(attr[0].stringValue());
              //System.out.println("attr[0].stringValue() "+attr[0].stringValue());            
              vect.addElement(elem);
          }      

      // Chiudo la connessione
      conn.close();
     }
    catch(Throwable e)
    {
      try
        {
          if (!conn.isClosed()) 
              conn.close();
        }
      catch (SQLException sqle)
        {
          sqle.printStackTrace();
          throw new RemoteException(sqle.getMessage());
        }

      e.printStackTrace();
      throw new RemoteException(e.getMessage());
     
    }
   

 //System.out.println("esco");
    return vect;
  }
// Fine METODO PER IL CARICAMENTO DELLA COMBO U.T.R SU LISTA_ACCOUNT_COL 

}