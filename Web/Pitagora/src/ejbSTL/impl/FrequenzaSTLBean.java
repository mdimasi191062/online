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

public class FrequenzaSTLBean extends AbstractSessionCommonBean implements SessionBean 
{
  public Vector getLista()throws CustomException, RemoteException
    {
    Vector vect=new Vector();
    
     try
      {
      
       conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call  " + StaticContext.PACKAGE_SPECIAL + ".FREQUENZA_LISTA(?,?,?)}");

      
      cs.registerOutParameter(1,OracleTypes.ARRAY, "ARR_FREQ");
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);
      
      cs.execute();

      if ((cs.getInt(2)!=DBMessage.OK_RT)&&(cs.getInt(2)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(2)+":"+cs.getString(3));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_FREQ",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(1);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ClassFreqElem  elem= new ClassFreqElem();
                   
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setCodeFreq(attr[0].stringValue());
              elem.setDescFreq(attr[1].stringValue());
              
              vect.addElement(elem);
          }      

      // Chiudo la connessione
      conn.close();

      }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getLista",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}

    return vect;
  }
}