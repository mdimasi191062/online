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
import java.util.Vector;

public class ClliSTLBean extends AbstractSessionCommonBean implements SessionBean
{
 public Vector getAllCLLIdaProg(String prog,String anno) throws RemoteException, CustomException
    {
    Vector vect=new Vector();

    Connection conn=null;
    try
      {

      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".LISTA_CLLI_DA_PROG(?,?,?,?,?)}");

      cs.setString(1,prog);
      cs.setString(2,anno); 
      
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_ACC_CLLI");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);

      cs.execute();
      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACC_CLLI",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ClassCLLI  elem= new ClassCLLI();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setCode_clli(attr[0].stringValue());
              elem.setNome_sede(attr[1].stringValue());

              vect.addElement(elem);
          }

      cs.close();    
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
									"getAllCLLIdaProg",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAllCLLIdaProg",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }

  
  public Vector getAllCLLI(String lettera) throws RemoteException, CustomException
     {
     Vector vect=new Vector();

     Connection conn=null;
     try
       {

       conn = getConnection(dsName);
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".LISTA_CLLI(?,?,?,?)}");

       cs.setString(1,lettera);  
       
       cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_ACC_CLLI");
       cs.registerOutParameter(3,Types.INTEGER);
       cs.registerOutParameter(4,Types.VARCHAR);

       cs.execute();
       if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
         throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));
       // Costruisco l'array che conterrà i dati di ritorno della stored
       ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACC_CLLI",conn);
       ARRAY rs = new ARRAY(ad, conn, null);

       // Ottengo i dati
       rs=cs.getARRAY(2);
       Datum dati[]=rs.getOracleArray();

       // Estrazione dei dati
       for (int i=0;i<dati.length;i++)
           {
               ClassCLLI  elem= new ClassCLLI();

               STRUCT s=(STRUCT)dati[i];
               Datum attr[]=s.getOracleAttributes();

               elem.setCode_clli(attr[0].stringValue());
               elem.setNome_sede(attr[1].stringValue());

               vect.addElement(elem);
           }

       cs.close();    
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
                   "getAllCLLI",
                   this.getClass().getName(),
                   StaticContext.FindExceptionType(sqle));
         }

       throw new CustomException(lexc_Exception.toString(),
                     "",
                   "getAllCLLI",
                   this.getClass().getName(),
                   StaticContext.FindExceptionType(lexc_Exception));
     }
     return vect;
   }
   
  public Vector getAnniEstrazione() throws RemoteException, CustomException
     {
     Vector vect=new Vector();

     Connection conn=null;
     try
       {

       conn = getConnection(dsName);
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".LISTA_ANNI_ESTRAZIONE(?,?,?)}");

             
       cs.registerOutParameter(1,OracleTypes.ARRAY, "ARR_TYPE_GENERICO");
       cs.registerOutParameter(2,Types.INTEGER);
       cs.registerOutParameter(3,Types.VARCHAR);

       cs.execute();
       if ((cs.getInt(2)!=DBMessage.OK_RT)&&(cs.getInt(2)!=DBMessage.NOT_FOUND_RT))
         throw new Exception("DB:"+cs.getInt(2)+":"+cs.getString(3));
       // Costruisco l'array che conterrà i dati di ritorno della stored
       ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_TYPE_GENERICO",conn);
       ARRAY rs = new ARRAY(ad, conn, null);

       // Ottengo i dati
       rs=cs.getARRAY(1);
       Datum dati[]=rs.getOracleArray();

       // Estrazione dei dati
       for (int i=0;i<dati.length;i++)
           {
               ClassCLLI  elem= new ClassCLLI();

               STRUCT s=(STRUCT)dati[i];
               Datum attr[]=s.getOracleAttributes();

               elem.setCode_clli(attr[0].stringValue());
               elem.setNome_sede(attr[1].stringValue());

               vect.addElement(elem);
           }

       cs.close();    
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
                   "getAnniEstrazione",
                   this.getClass().getName(),
                   StaticContext.FindExceptionType(sqle));
         }

       throw new CustomException(lexc_Exception.toString(),
                     "",
                   "getAnniEstrazione",
                   this.getClass().getName(),
                   StaticContext.FindExceptionType(lexc_Exception));
     }
     return vect;
   }
   
   
  public Vector getAnniEstrazioneTipoContr(String anno) throws RemoteException, CustomException
     {
     Vector vect=new Vector();

     Connection conn=null;
     try
       {

       conn = getConnection(dsName);
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".LISTA_TIPO_CONT_X_ANNO(?,?,?,?)}");

       cs.setString(1,anno);  
       
       cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_TYPE_GENERICO");
       cs.registerOutParameter(3,Types.INTEGER);
       cs.registerOutParameter(4,Types.VARCHAR);

       cs.execute();
       if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
         throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));
       // Costruisco l'array che conterrà i dati di ritorno della stored
       ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_TYPE_GENERICO",conn);
       ARRAY rs = new ARRAY(ad, conn, null);

       // Ottengo i dati
       rs=cs.getARRAY(2);
       Datum dati[]=rs.getOracleArray();

       // Estrazione dei dati
       for (int i=0;i<dati.length;i++)
           {
               ClassCLLI  elem= new ClassCLLI();

               STRUCT s=(STRUCT)dati[i];
               Datum attr[]=s.getOracleAttributes();

               elem.setCode_clli(attr[0].stringValue());
               elem.setNome_sede(attr[1].stringValue());

               vect.addElement(elem);
           }

       cs.close();    
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
                   "getAnniEstrazioneTipoContr",
                   this.getClass().getName(),
                   StaticContext.FindExceptionType(sqle));
         }

       throw new CustomException(lexc_Exception.toString(),
                     "",
                   "getAnniEstrazioneTipoContr",
                   this.getClass().getName(),
                   StaticContext.FindExceptionType(lexc_Exception));
     }
     return vect;
   }
   
}