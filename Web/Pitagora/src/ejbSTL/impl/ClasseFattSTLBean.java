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

public class ClasseFattSTLBean extends AbstractSessionCommonBean implements SessionBean 
{
  
  public Vector getCfs() throws RemoteException, CustomException
  {
   Vector vect=new Vector();
   Connection conn=null;
   try
      {
      conn = getConnection(dsName);
     
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CLAS_OGG_FAT_LISTA(?,?,?)}");

      // Impostazione types I/O
      
        
      cs.registerOutParameter(1,OracleTypes.ARRAY, "ARR_CLASSE_OF");
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);
      
      cs.execute();

      if ((cs.getInt(2)!=DBMessage.OK_RT)&&(cs.getInt(2)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(2)+":"+cs.getString(3));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CLASSE_OF",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(1);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ClasseFattElem  elem= new ClasseFattElem();
                   
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setDescClasseOf(attr[0].stringValue());
              elem.setCodeClasseOf(attr[1].stringValue());
 
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
									"getCfs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCfs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

    return vect;
  }

  public Vector getCfsCla() throws RemoteException, CustomException
  {
   Vector vect=new Vector();
   Connection conn=null;
   try
      {
      conn = getConnection(dsName);
//      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call CLASSE_OGGETTO_FATT.CARICA_LISTA_CLASSE_OF(?,?,?)}");
//      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_ALB.CLAS_OGG_FAT_CL_LISTA(?,?,?)}");

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CLAS_OGG_FAT_CL_LISTA(?,?,?)}");

      // Impostazione types I/O
       
      cs.registerOutParameter(1,OracleTypes.ARRAY, "ARR_CLASSE_OF");
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);
      
      cs.execute();

      if ((cs.getInt(2)!=DBMessage.OK_RT)&&(cs.getInt(2)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(2)+":"+cs.getString(3));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CLASSE_OF",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(1);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ClasseFattElem  elem= new ClasseFattElem();
                   
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setDescClasseOf(attr[0].stringValue());
              elem.setCodeClasseOf(attr[1].stringValue());
 
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
									"getCfsCla",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

        throw new CustomException(lexc_Exception.toString(),
	  							"",
									"getCfsCla",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
     
    }
    return vect;
  }

  public Vector getCfsTipoContr( String strTipoContr ) throws RemoteException, CustomException
  {
   Vector vect=new Vector();
   Connection conn=null;
   try
      {
      conn = getConnection(dsName);
     
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CLAS_OGG_FAT_LISTA_CONTR(?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,strTipoContr);
      
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_CLASSE_OF");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      
      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CLASSE_OF",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ClasseFattElem  elem= new ClasseFattElem();
                   
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setDescClasseOf(attr[0].stringValue());
              elem.setCodeClasseOf(attr[1].stringValue());
 
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
									"getCfsTipoContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCfsTipoContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

    return vect;
  }


   public Vector getClusterTipoContr( String strTipoContr ) throws RemoteException, CustomException  {
   Vector vect=new Vector();
   Connection conn=null;
   try
      {
      conn = getConnection(dsName);
     
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_COMMON + ".getClusterTipoContrFilter(?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,strTipoContr); 
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_CLUSTER_OF");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      
      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CLUSTER_OF",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ClusterTipoContrElem  elem= new ClusterTipoContrElem();
                   
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setDescClusterOf(attr[0].stringValue());
              elem.setCodeClusterOf(attr[1].stringValue());
              elem.setTipoClusterOf(attr[2].stringValue());
 
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
									"getClusterTipoContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getClusterTipoContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

    return vect;
  }
}