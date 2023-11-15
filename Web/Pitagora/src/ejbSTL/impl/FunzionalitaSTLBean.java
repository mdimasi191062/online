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

public class FunzionalitaSTLBean  extends AbstractSessionCommonBean implements SessionBean 
{
  public Vector getOfs(String CodTipoContr, String Sys)throws CustomException, RemoteException
    {
    Vector vect=new Vector();
    
     try
      {
      
       conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call  " + StaticContext.PACKAGE_SPECIAL + ".FUNZION_X_TIPO_CONTR(?,?,?,?,?)}");

      
      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.setString(2,Sys);
        
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_FUNZION");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      
      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_FUNZION",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ClassFunzElem  elem= new ClassFunzElem();
                   
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setCodeFunz(attr[0].stringValue());
              elem.setDescFunz(attr[1].stringValue());
              
              vect.addElement(elem);
          }      

      // Chiudo la connessione
      conn.close();

      }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getOfs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}

    return vect;
  }


}