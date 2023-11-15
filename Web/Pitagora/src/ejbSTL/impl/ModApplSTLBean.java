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

public class ModApplSTLBean  extends AbstractSessionCommonBean implements SessionBean 
{
  public Vector getLista()throws CustomException, RemoteException
    {
    Vector vect=new Vector();
    
     try
      {
      
       conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call  " + StaticContext.PACKAGE_SPECIAL + ".MOD_APPL_RATEI_LISTA(?,?,?)}");

      
      // Impostazione types I/O
      cs.registerOutParameter(1,OracleTypes.ARRAY, "ARR_MOD_APPL_RATEI");
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);
      
      cs.execute();

      if ((cs.getInt(2)!=DBMessage.OK_RT)&&(cs.getInt(2)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(2)+":"+cs.getString(3));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_MOD_APPL_RATEI",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(1);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ClassModApplRateiElem  elem= new ClassModApplRateiElem();
                   
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setCodeModAppl(attr[0].stringValue());
              elem.setDescModAppl(attr[1].stringValue());
              
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