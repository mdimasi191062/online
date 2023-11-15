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

public class OpzioniTariffaSTLBean extends AbstractSessionCommonBean implements SessionBean 
{
  public Vector getOpz()throws CustomException, RemoteException
    {
    Vector vect=new Vector();
     try
      {
       conn = getConnection(dsName);
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call  " + StaticContext.PACKAGE_SPECIAL + ".CARICA_OPZ_TARIFFA(?,?,?)}");
     
      // Impostazione types I/O
      cs.registerOutParameter(1,OracleTypes.ARRAY, "ARR_OPZIONI");
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(2)!=DBMessage.OK_RT)&&(cs.getInt(2)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(2)+":"+cs.getString(3));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_OPZIONI",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(1);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              OpzioniElem  elem= new OpzioniElem();
                   
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setCodeOpzione(attr[0].stringValue());
              elem.setDescOpzione(attr[1].stringValue());
              
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
									"getOpz",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getOpz",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}

    return vect;
  }

  public OpzioniElem getOpzioniFlag(String codOf,String codPs) throws RemoteException, CustomException
    {
    OpzioniElem  elem = null;
    Connection conn= null;
    try
      {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".VER_ESISTENZA_OPZ(?,?,?,?,?)}");
      cs.setString(1,codOf);
      cs.setString(2,codPs);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR); 
      cs.execute();
      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:VER_ESISTENZA_OPZ:"+cs.getInt(4)+":"+cs.getString(5));

      if ((cs.getInt(4)==DBMessage.NOT_FOUND_RT))
      {
         if (!conn.isClosed()) conn.close();
         return elem;
      }
      elem=new OpzioniElem();
      elem.setOpzioniFlag(cs.getInt(3));

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
									"getOpzioniFlag",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }
      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getOpzioniFlag",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return elem;
  }

  //04-03-03 INIZIO estrae il codice e la descrizione per opzione tariffa x Tipo Contratto
  public Vector getOpzTarXTipoContr(String codOf,String codPs)throws CustomException, RemoteException
    {
    Vector vect=new Vector();
     try
      {
       conn = getConnection(dsName);
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call  " + StaticContext.PACKAGE_SPECIAL + ".CARICA_OPZ_TAR_INS(?,?,?,?,?)}");
    
      // Impostazione types I/O
      cs.setString(1,codOf);
      cs.setString(2,codPs);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_OPZIONI");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_OPZIONI",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              OpzioniElem  elem= new OpzioniElem();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              elem.setCodeOpzione(attr[0].stringValue());
              elem.setDescOpzione(attr[1].stringValue());
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
									"getOpzXTipoContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getOpzXTipoContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}

    return vect;
  } 
  //04-03-03 INIZIO

   //05-03-03 INIZIO
   //estrae il codice e la descrizione per opzione tariffa x Cliente
   public Vector getOpzTarXCliente(String codContr ,String codOf,String codPs) throws CustomException, RemoteException
   {
    Vector vect=new Vector();
     try
      {
       conn = getConnection(dsName);
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call  " + StaticContext.PACKAGE_SPECIAL + ".CARICA_OPZ_TAR_INS_X_CONTR(?,?,?,?,?,?)}");
    
      // Impostazione types I/O
      cs.setString(1,codContr);
      cs.setString(2,codOf);
      cs.setString(3,codPs);
      cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_OPZIONI");
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_OPZIONI",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(4);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              OpzioniElem  elem= new OpzioniElem();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              elem.setCodeOpzione(attr[0].stringValue());
              elem.setDescOpzione(attr[1].stringValue());
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
									"getOpzTarXCliente",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getOpzTarXCliente",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
    return vect;
  }  
  //05-03-03 FINE

  //viti 07-03-03
  public Vector getDispOpz(String codOf,String codPs)throws CustomException, RemoteException
    {
    Vector vect=new Vector();
     try
      {
       conn = getConnection(dsName);
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call  " + StaticContext.PACKAGE_SPECIAL + ".CARICA_OPZ_TAR_DISP(?,?,?,?,?)}");
    
      // Impostazione types I/O
      cs.setString(1,codOf);
      cs.setString(2,codPs);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_OPZIONI");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_OPZIONI",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              OpzioniElem  elem= new OpzioniElem();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              elem.setCodeOpzione(attr[0].stringValue());
              elem.setDescOpzione(attr[1].stringValue());
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
									"getDispOpz",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDispOpz",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}

    return vect;
  }  
  public Vector getDispOpzXContr(String codeContr, String codOf,String codPs)throws CustomException, RemoteException
    {
    Vector vect=new Vector();
     try
      {
       conn = getConnection(dsName);
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call  " + StaticContext.PACKAGE_SPECIAL + ".CARICA_OPZ_TAR_DISP_X_CONTR(?,?,?,?,?,?)}");
    
      // Impostazione types I/O
      cs.setString(1,codeContr);
      cs.setString(2,codOf);
      cs.setString(3,codPs);
      cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_OPZIONI");
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_OPZIONI",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(4);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              OpzioniElem  elem= new OpzioniElem();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              elem.setCodeOpzione(attr[0].stringValue());
              elem.setDescOpzione(attr[1].stringValue());
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
									"getDispOpzXContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDispOpzXContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}

    return vect;
  }

}