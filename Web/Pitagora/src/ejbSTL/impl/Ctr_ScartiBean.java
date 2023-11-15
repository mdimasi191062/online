package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;
import java.rmi.RemoteException;
import java.util.Vector;
import java.util.GregorianCalendar;
import com.utl.*;
import com.ejbSTL.*;
import java.util.*;
import java.rmi.*;
import java.sql.*;
import java.lang.*;
import javax.ejb.*;
import javax.naming.*;
import oracle.jdbc.*;
import oracle.sql.*;
import com.utl.*;
import java.util.Collection;


public class Ctr_ScartiBean extends AbstractClassicEJB implements SessionBean 
{
  public void ejbCreate()
  {
  }

  public void ejbActivate()
  {
  }

  public void ejbPassivate()
  {
  }

  public void ejbRemove()
  {
  }

  public void setSessionContext(SessionContext ctx)
  {
  }

  // updScarti
  public String updScarti (Vector pvct_Scarti)
        throws CustomException, RemoteException
  {
    Integer lint_Result;
    String lstr_Error="";
    Object homeObject = null;
    Context lcls_Contesto = null;
    Ent_Scarti lEnt_Scarti = null;
    Ent_ScartiHome lEnt_ScartiHome = null;
    DB_Scarti lDB_Scarto = null;
    try 
    {
      if ( pvct_Scarti != null && pvct_Scarti.size() > 0)
      {
        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();

        // Istanzio una classe Ent_Batch
        homeObject = lcls_Contesto.lookup("Ent_Scarti");
        lEnt_ScartiHome = (Ent_ScartiHome)PortableRemoteObject.narrow(homeObject, Ent_ScartiHome.class);
        lEnt_Scarti = lEnt_ScartiHome.create();

        for (int ind=0; ind < pvct_Scarti.size(); ind++)
        {
          lDB_Scarto = (DB_Scarti)pvct_Scarti.get(ind);
          lint_Result = lEnt_Scarti.updScarti(StaticContext.LIST,
                                              lDB_Scarto.getCODE_SCARTO(),
                                              lDB_Scarto.getTIPO_FLAG_STATO_SCARTO());
                                              
        }
      }
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"updScarti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}

    return lstr_Error;
  }

  /**
   * 
   */
  Vector ejbGetListaOloConScarti(String pCodeTipoContr)
    throws RemoteException, FinderException
  {
    Vector recs = new Vector();

    String lArray = "ARR_CONTRATTO";
    
    String lPackage = StaticContext.PACKAGE_SPECIAL;
           lPackage = "SKA_VIEWER";
    String lFunzione = "SCARTI_LST";

    String lChimataCompleta = lPackage + "." + lPackage;
    
    try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + lChimataCompleta + "(?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1, pCodeTipoContr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, lArray);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"STORED: " + lChimataCompleta);

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor(lArray,conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      /*
      for (int i=0;i<dati.length;i++)
      {
        pk = new TariffaBMPPK();
        STRUCT s=(STRUCT)dati[i];
        Datum attr[]=s.getOracleAttributes();
        if (attr[0]!=null)
            pk.setCodContr(attr[0].stringValue());
        else
            pk.setCodContr(new String(""));
        if (attr[1]!=null)
            pk.setDescContr(attr[1].stringValue());
        else
            pk.setDescContr(new String(""));
       recs.add(pk);
      }
      */
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
      StaticMessages.setCustomString(e.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5002,"Ctr_ScartiBean","","",StaticContext.APP_SERVER_DRIVER));
      e.printStackTrace();
      throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
      StaticMessages.setCustomString(ee.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5003,"Ctr_ScartiBean","","",StaticContext.APP_SERVER_DRIVER));
      ee.printStackTrace();
      throw new RemoteException(ee.getMessage());
		}
    finally
		{
			try
			{
				conn.close();
			} catch(Exception e)
			{
              throw new RemoteException(e.getMessage());
			}
		}
    return recs;      
  }

/*
  public Collection ejbFindListini(String codTipoContr) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 	try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".CONTR_LST_LISTINI(?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,codTipoContr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_CONTRATTO");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"STORED: CONTR_LST_LISTINI");

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CONTRATTO",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new TariffaBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              if (attr[0]!=null)
                  pk.setCodContr(attr[0].stringValue());
              else
                  pk.setCodContr(new String(""));
              if (attr[1]!=null)
                  pk.setDescContr(attr[1].stringValue());
              else
                  pk.setDescContr(new String(""));
             recs.add(pk);
          }
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
           StaticMessages.setCustomString(e.toString());
           StaticContext.writeLog(StaticMessages.getMessage(5002,"TariffaBMPBean","","",StaticContext.APP_SERVER_DRIVER));
           e.printStackTrace();
             throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"TariffaBMPBean","","",StaticContext.APP_SERVER_DRIVER));
       ee.printStackTrace();
       throw new RemoteException(ee.getMessage());
		}
    finally
		{
			try
			{
				conn.close();
			} catch(Exception e)
			{
              throw new RemoteException(e.getMessage());
			}
		}
    return recs;  
  }
*/  
}