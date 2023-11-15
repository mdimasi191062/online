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

public class SitoSTLBean extends AbstractSessionCommonBean implements SessionBean 
{
// inizio METODO PER IL CARICAMENTO DELLA COMBO SITO SU LISTA_ACCOUNT_COL
public Vector getSito(String CodUtr) throws RemoteException, CustomException
	{
    Vector vect=new Vector();
    Connection conn=null;
   //System.out.println("Bean Sito");
   //System.out.println("Bean Sito CodUtr "+CodUtr);
   try
      {
            
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CENTR_GAT_LISTA(?,?,?,?)}");
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.CENTR_GAT_LISTA(?,?,?,?)}");
      
      // Impostazione types I/O
      cs.setString(1,CodUtr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_SITI");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      
      cs.execute();


     if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_SITI",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();
      
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              SitoElem elem = new SitoElem();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
      
              elem.setCodeSito(attr[0].stringValue());
              elem.setDescSito(attr[1].stringValue());
              
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
									"getSito",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getSito",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
   

 //System.out.println("esco");
    return vect;
  }
// Fine METODO PER IL CARICAMENTO DELLA COMBO SITO SU LISTA_ACCOUNT_COL 

//Dario -inizio METODO PER IL CARICAMENTO DEI DATI DI DETTAGLIO SU VisAggCanCol 
public SitoElem getDataImportoSito(String CodeSito,String CodeAccount) throws RemoteException, CustomException
	{
    Connection conn=null;
    SitoElem elem = new SitoElem();
    try
      {
            
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_SITO_DETT(?,?,?,?,?,?,?)}");
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.TARIFFA_X_SITO_DETT(?,?,?,?,?,?,?)}");

      // Estrazione data di consegna del sito e importo tariffa del sito
      // Impostazione types I/O
      cs.setString(1,CodeSito);
      cs.setString(2,CodeAccount);
      cs.setString(3,"1");
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      
      cs.execute();


     if ((cs.getInt(6)!=DBMessage.OK_RT)&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB 0:"+cs.getInt(6)+":"+cs.getString(7));

      // Imposta i valori di output

      elem.setDataSito(cs.getString(4));
      elem.setImportoTariffaFittoSito(cs.getDouble(5));

      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_SITO_DETT(?,?,?,?,?,?,?)}");
      //cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.TARIFFA_X_SITO_DETT(?,?,?,?,?,?,?)}");
      
      // Estrazione importo tarif fa di consulenza per security
      // Impostazione types I/O
      cs.setString(1,CodeSito);
      cs.setString(2,CodeAccount);
      cs.setString(3,"4");
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      
      cs.execute();


     if ((cs.getInt(6)!=DBMessage.OK_RT)&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB 1:"+cs.getInt(6)+":"+cs.getString(7));

      // Imposta i valori di output
      if (cs.getInt(6)!=DBMessage.NOT_FOUND_RT)
          elem.setImportoTariffaSecuritySito(cs.getDouble(5));
      else    
          elem.setImportoTariffaSecuritySito(0);

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
									"getSito",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getSito",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
   

//System.out.println("esco");
    return elem;
  }

//Dario -inizio METODO PER IL CARICAMENTO DEI DATI DI DETTAGLIO SU VisAggCanCol 
public SitoElem getNumModuli(String CodeSito,String CodeAccount) throws RemoteException, CustomException
	{
    Connection conn=null;
    SitoElem elem = new SitoElem();
    try
      {
     //System.out.println("passo da ejbFindNumModuli");            
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".INVENT_PS_SP_LEGGI_NUM_MOD(?,?,?,?,?,?)}");
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.INVENT_PS_SP_LEGGI_NUM_MOD(?,?,?,?,?,?)}");

      // Estrazione data di consegna del sito e importo tariffa del sito
      // Impostazione types I/O
      cs.setString(1,CodeSito);
      cs.setString(2,CodeAccount);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      
      cs.execute();

 
      if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB :"+cs.getInt(5)+":"+cs.getString(6));

      // Imposta i valori di output
      
      elem.setnumModuliUll(cs.getInt(3));
      elem.setnumModuliItc(cs.getInt(4));

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
									"getSito",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getSito",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
   
//System.out.println("esco");
    return elem;
  }
//3/10/02 mario inizio
public SitoElem findTarXSito(String codesito,String codeaccount) throws RemoteException, CustomException
	{
    
System.out.println("findTarXSito");
    Connection conn=null;
    SitoElem elem = new SitoElem();
   try
      {
            
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_SITO_VER_ES(?,?,?,?,?)}");
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.TARIFFA_X_SITO_VER_ES(?,?,?,?,?)}");
      
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
									"findTarXSito",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"findTarXSito",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
   


    return elem;
  }

//3/10/02 mario fine

// Fine METODO PER IL CARICAMENTO DEI DATI DI DETTAGLIO SU VisAggCanCol 


 
}