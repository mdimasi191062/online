package com.ejbBMP.impl;

import java.util.*;
import java.rmi.*;
import java.sql.*;

import javax.ejb.*;
import javax.naming.*;

import oracle.jdbc.*;
import oracle.sql.*;

import com.ejbBMP.OggFattBMPPK;
import com.utl.*;


public class OggFattBMPBean extends AbstractEntityCommonBean implements EntityBean
{
  public EntityContext entityContext;
  private OggFattBMPPK pk;

  private boolean enableStore=false;
  private String myFlagSys=null;

  public OggFattBMPPK ejbCreate(String dataIni, String codeCOf, String descrizione, String tipoFlgAssocB, String dataFine, String codeTipoContr)
  throws CreateException, RemoteException, CustomEJBException
  {
    try
      {
      conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_INSERISCI(?,?,?,?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,dataIni);
      cs.setString(2,codeCOf);
      cs.setString(3,descrizione);
      cs.setString(4,tipoFlgAssocB);
      cs.setString(5,dataFine);
      cs.setString(6,codeTipoContr);

      cs.registerOutParameter(7,Types.VARCHAR);
      cs.registerOutParameter(8,Types.INTEGER);
      cs.registerOutParameter(9,Types.VARCHAR);

      cs.execute();

      if ((cs.getInt(8)!=DBMessage.OK_RT)&&(cs.getInt(8)!=DBMessage.NOT_FOUND_RT))
        throw new EJBException("DB:"+cs.getInt(8)+":"+cs.getString(9));

      pk=new OggFattBMPPK(dataIni,codeCOf,descrizione,tipoFlgAssocB,
                          dataFine,cs.getString(7));
     cs.close();
     conn.close();

      }
    catch(Exception lexc_Exception)
    {

		throw new CustomEJBException(lexc_Exception.toString(),
    							"Errore di inserimento nella store procedure PKG_BILL_SPE.OGGETTO_FATT_INSERISCI",
									"ejbCreate Special",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
  	}
    finally
      {
        try
        {
          conn.close();
        } catch(Exception lexc_Exception)
        {
          throw new CustomEJBException(lexc_Exception.toString(),
							"Errore nella chiusura della connessione",
							"ejbCreate Special",
							this.getClass().getName(),
							StaticContext.FindExceptionType(lexc_Exception));
        }
      }
    return pk;
  }


  public OggFattBMPPK ejbCreate(String dataIni, String codeCOf, String descrizione, String tipoFlgAssocB, String dataFine)
  throws CreateException, RemoteException, CustomEJBException
  {
    //System.out.println("ejbCreateCla>>");

    try
      {
      conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_CL_INSERISCI(?,?,?,?,?,?,?,?)}");
     // Impostazione types I/O
      cs.setString(1,dataIni);
      cs.setString(2,codeCOf);
      cs.setString(3,descrizione);
      cs.setString(4,tipoFlgAssocB);
      cs.setString(5,dataFine);

      cs.registerOutParameter(6,Types.VARCHAR);
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);

      cs.execute();

      if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
        throw new EJBException("DB:"+cs.getInt(7)+":"+cs.getString(8));

      pk=new OggFattBMPPK(dataIni,codeCOf,descrizione,tipoFlgAssocB,
                          dataFine,cs.getString(6));
     cs.close();
     conn.close();

      }

    catch(Exception lexc_Exception)
      {
		throw new CustomEJBException(lexc_Exception.toString(),
							"Errore di inserimento nella store procedure PKG_BILL_SPE.OGGETTO_FATT_CL_INSERISCI",
							"ejbCreate Classic",
							this.getClass().getName(),
							StaticContext.FindExceptionType(lexc_Exception));
      }
    finally
      {
        try
        {
          conn.close();
        } catch(Exception lexc_Exception)
        {
          throw new CustomEJBException(lexc_Exception.toString(),
							"Errore nella chiusura della connessione",
							"ejbCreate Classic",
							this.getClass().getName(),
							StaticContext.FindExceptionType(lexc_Exception));
        }
      }
      
    return pk;
  }


  public void ejbPostCreate(String dataIni, String codeCOf, String descrizione, String tipoFlgAssocB, String dataFine, String codeTipoContr)
  {

  }

  public void ejbPostCreate(String dataIni, String codeCOf, String descrizione, String tipoFlgAssocB, String dataFine)
  {

  }

  public OggFattBMPPK ejbFindByPrimaryKey(OggFattBMPPK primaryKey) throws FinderException, RemoteException, CustomEJBException
  {

  //System.out.println("ejbFindByPrimaryKey>>");

  Connection conn=null;

  try
    {
    conn = getConnection(dsName);

    pk = primaryKey;

    //System.out.println(">>>dopo pk=");
    
    myFlagSys=pk.getFlagSys();

    //System.out.println(">>>dopo myFlagSys="+myFlagSys);
    
    if (myFlagSys.equals("S"))
    {
      // Trattamento per Special
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_LEGGI_DETTAGLIO(?,?,?,?,?,?,?,?,?)}");

//      pk = primaryKey;
      //System.out.println(">>>CodeOf="+pk.getCodeOf());
      String myCodeOf=pk.getCodeOf();
      
       // Impostazione types I/O
      cs.setString(1,pk.getCodeOf());
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.registerOutParameter(8,Types.INTEGER);
      cs.registerOutParameter(9,Types.VARCHAR);
      cs.execute();

      //System.out.println(">>>rt="+cs.getInt(8));
      
      if ((cs.getInt(8)!=DBMessage.OK_RT)&&(cs.getInt(8)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("Special: DB:----"+cs.getInt(8)+"---:---"+cs.getString(9));

      if (cs.getInt(8)==DBMessage.NOT_FOUND_RT)
        throw new FinderException("Oggetto di fatturazione non trovato per Special:"+primaryKey);

      
      if (cs.getString(6)!=null)
      pk=new OggFattBMPPK(cs.getString(5),cs.getString(3),cs.getString(2),cs.getString(7),
                          cs.getString(6),myCodeOf);
      else
      pk=new OggFattBMPPK(cs.getString(5),cs.getString(3),cs.getString(2),cs.getString(7),
                          "",myCodeOf);

      
      pk.setFlagSys("S");  
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    else
    {
      // Trattamento per Classic
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_CL_LEGGI_DETT(?,?,?,?,?,?,?,?)}");
//      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_ALB.OGGETTO_FATT_CL_LEGGI_DETT(?,?,?,?,?,?,?,?)}");
//      pk = primaryKey;
      String myCodeOf=pk.getCodeOf();
       // Impostazione types I/O
      cs.setString(1,pk.getCodeOf());

      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("Classic: DB:----"+cs.getInt(7)+"---:---"+cs.getString(8));

      if (cs.getInt(7)==DBMessage.NOT_FOUND_RT)
        throw new FinderException("Oggetto di fatturazione non trovato per Classic:"+primaryKey);

      if (cs.getString(5)!=null)
      pk=new OggFattBMPPK(cs.getString(4),cs.getString(3),cs.getString(2),cs.getString(6),
                          cs.getString(5),myCodeOf);
      else
      pk=new OggFattBMPPK(cs.getString(4),cs.getString(3),cs.getString(2),cs.getString(6),
                          "",myCodeOf);

      pk.setFlagSys("C");                    
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    }
    catch(Exception lexc_Exception)
      {
      //System.out.println(">>> nella catch");
		throw new CustomEJBException(lexc_Exception.toString(),
							"",
							"ejbFindByPrimaryKey",
							this.getClass().getName(),
							StaticContext.FindExceptionType(lexc_Exception));
      }
    finally
      {
        try
        {
          conn.close();
        } catch(Exception lexc_Exception)
        {
          throw new CustomEJBException(lexc_Exception.toString(),
							"Errore nella chiusura della connessione",
							"ejbFindByPrimaryKey",
							this.getClass().getName(),
							StaticContext.FindExceptionType(lexc_Exception));
        }
      }

    return pk;
  }

//METODO PER IL CARICAMENTO DELLA COMBO SU LISTA_TARIFFE

  public Collection ejbFindOggFattTar(String codPs) throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{

			conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_LST_OF_X_TAR (?,?,?,?,?)}");

      // Impostazione types I/O
      //System.out.println("**********ejbFindOggFattTar************");  
      //System.out.println("Imposto l'Input");
      //System.out.println("codPs --->"+codPs);
      cs.setString(1,codPs);
      //System.out.println("Imposto l'Output");      
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_OGG_DI_FATRZ");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);

      //System.out.println("ESEGUO");      

      cs.execute();
 

      

      if ((cs.getInt(3)!=DBMessage.OK_RT))//&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: OGGETTO_FATT_LST_OF_X_TAR" );

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_OGG_DI_FATRZ",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new OggFattBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              pk.setCodeOf(attr[0].stringValue());
              pk.setDescOf(attr[1].stringValue());
              recs.add(pk);
          }
      cs.close();   
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
      StaticMessages.setCustomString(e.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5002,"OggFattBMPBean","","",StaticContext.APP_SERVER_DRIVER));
      e.printStackTrace();
      throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
      StaticMessages.setCustomString(ee.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5003,"OggFattBMPBean","","",StaticContext.APP_SERVER_DRIVER));
      ee.printStackTrace();
			throw new RemoteException(ee.getMessage());

		}
   finally
		{
			try
			{
				conn.close();
			}
      catch(Exception e)
			{

       StaticMessages.setCustomString(e.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5002,"","","",StaticContext.APP_SERVER_DRIVER));
        e.printStackTrace();
        throw new RemoteException(e.getMessage());
			}
		}

    return recs;
  }
// Fine METODO PER IL CARICAMENTO DELLA COMBO SU LISTA_TARIFFE

//METODO PER IL CARICAMENTO DELLA COMBO SU  INSERIMENTO NUOVA TARIFFA

    public Collection ejbFindOggFatt(String CodPs) throws FinderException, RemoteException
	{
    //System.out.println("ejbFindOggFatt");
    Vector recs = new Vector();

 		try
		{
//     //System.out.println("Sono in ejbFindOggFatt");
			conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_LST_OF_X_TAR (?,?,?,?)}");//Mario eliminato un ?

      // Impostazione types I/O
      
      //System.out.println("Imposto l'Input");
      //System.out.println("codPs --->"+CodPs);
      
      cs.setString(1,CodPs);

      //System.out.println("Imposto l'Output");      
      
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_OGG_DI_FATRZ");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);

      //System.out.println("ESEGUO");      

      cs.execute();

      if (cs.getInt(3)!=DBMessage.OK_RT && cs.getInt(3)!=DBMessage.NOT_FOUND_RT)
      {
            throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: OGGETTO_FATT_LST_OF_X_TAR");

      }
      

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_OGG_DI_FATRZ",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new OggFattBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              pk.setCodeOf(attr[0].stringValue());
              pk.setDescOf(attr[1].stringValue());
              //31/07/02 inizio
              pk.setCodeClasseOf(attr[4].stringValue());

              //31/07/02 fine
              recs.add(pk);
          }
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
      StaticMessages.setCustomString(e.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5002,"OggFattBMPBean","","",StaticContext.APP_SERVER_DRIVER));
      e.printStackTrace();
      throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
      StaticMessages.setCustomString(ee.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5003,"OggFattBMPBean","","",StaticContext.APP_SERVER_DRIVER));
      ee.printStackTrace();
			throw new RemoteException(ee.getMessage());

		}
   finally
		{
			try
			{
				conn.close();
			}
      catch(Exception e)
			{

       StaticMessages.setCustomString(e.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5002,"","","",StaticContext.APP_SERVER_DRIVER));
        e.printStackTrace();
        throw new RemoteException(e.getMessage());
			}
		}

    return recs;
  }
// Fine METODO PER IL CARICAMENTO DELLA COMBO SU LISTA_TARIFFE

//METODO PER IL CARICAMENTO DELLA COMBO SU LISTA TARIFFE PER CONTRATTO

    public Collection ejbFindOggFatt(String CodContr, String CodPs) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
    
 		try
		{

			conn = getConnection(dsName);
      
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_LST_OF_TAR_CONTR(?,?,?,?,?)}");
      
      // Impostazione types I/O
      cs.setString(1,CodContr);
      cs.setString(2,CodPs);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_OGG_DI_FATRZ");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      
      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
      {
            throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5)+"NOME STORED: OGGETTO_FATT_LST_OF_TAR_CONTR");

      }

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_OGG_DI_FATRZ",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new OggFattBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              pk.setCodeOf(attr[0].stringValue());
              
              pk.setDescOf(attr[1].stringValue());
              
              //31/07/02 inizio
              if (attr[4].stringValue()==null)
              {
                pk.setCodeClasseOf("");
                
              }
              else
              {
               pk.setCodeClasseOf(attr[4].stringValue());
               
              }
              //31/07/02 fine
              recs.add(pk);
          }
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
      
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
// Fine METODO PER IL CARICAMENTO DELLA COMBO SU LISTA_TARIFFE_X_CONTR

//METODO PER IL CARICAMENTO DELLA COMBO SU  INSERIMENTO NUOVA TARIFFA Associata a Ps
    public Collection ejbFindOggFattAssPs(String CodPs, String CodTipoContr) throws FinderException, RemoteException
	{
//System.out.println("Sono in ejbFindOggFattAssPsdd");
    Vector recs = new Vector();

 		try
		{
     //System.out.println("Sono in ejbFindOggFattAssPs");
			conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_LST_OF_X_ASS_OFPS(?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodPs);
      cs.setString(2,CodTipoContr);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_OGG_DI_FATRZ");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_OGG_DI_FATRZ",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new OggFattBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setCodeOf(attr[0].stringValue());
              pk.setDescOf(attr[1].stringValue());
              //31/07/02 inizio
              pk.setCodeClasseOf(attr[4].stringValue());
             //System.out.println("attr[4].stringValue() "+attr[4].stringValue());

              //31/07/02 fine
              recs.add(pk);
          }
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} finally
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
// Fine METODO PER IL CARICAMENTO DELLA COMBO SU LISTA_TARIFFE Associate a Ps

  public Collection ejbFindOFPSXTariffa(String CodPs, String CodTipoContr) throws FinderException, RemoteException
	{
//System.out.println("Sono in ejbFindOggFattAssPsdd");
    Vector recs = new Vector();

 		try
		{
     //System.out.println("Sono in ejbFindOggFattAssPs");
			conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OF_PS_LST_TARIFFA(?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodPs);
      cs.setString(2,CodTipoContr);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_OGG_DI_FATRZ");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_OGG_DI_FATRZ",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new OggFattBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setCodeOf(attr[0].stringValue());
              pk.setDescOf(attr[1].stringValue());
              //31/07/02 inizio
              pk.setCodeClasseOf(attr[4].stringValue());
             //System.out.println("attr[4].stringValue() "+attr[4].stringValue());

              //31/07/02 fine
              recs.add(pk);
          }
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} finally
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
  public Collection ejbFindOFPSXContrXTariffa(String CodPs, String CodContr,String CodTipoContr) throws FinderException, RemoteException
	{
 Vector recs = new Vector();
 		try
		{
//     //System.out.println("Sono in ejbFindOggFattAssPsXContr");
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OF_PS_X_CONTR_LST_TARIFFA(?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.setString(2,CodContr);
      cs.setString(3,CodPs);
      cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_OGG_DI_FATRZ");
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_OGG_DI_FATRZ",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
      // Ottengo i dati
      rs=cs.getARRAY(4);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new OggFattBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setCodeOf(attr[0].stringValue());
              pk.setDescOf(attr[1].stringValue());
              //31/07/02 inizio
              pk.setCodeClasseOf(attr[4].stringValue());
//             //System.out.println("attr[4].stringValue() "+attr[4].stringValue());
              //31/07/02 fine
              recs.add(pk);
          }
       cs.close();
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} finally
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
  
      
    public Collection ejbFindOFPSXContrXTariffaClus(String CodPs, String CodContr,String CodTipoContr,String codeCluster, String tipoCluster) throws FinderException, RemoteException
          {
    Vector recs = new Vector();
                  try
                  {
    //     //System.out.println("Sono in ejbFindOggFattAssPsXContr");
                          conn = getConnection(dsName);
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OF_PS_X_CONTR_LST_TARIFFA_CLUS(?,?,?,?,?,?,?,?)}");
        // Impostazione types I/O
        cs.setString(1,CodTipoContr);
        cs.setString(2,CodContr);
        cs.setString(3,CodPs);
          cs.setString(4,codeCluster);
          cs.setString(5,tipoCluster);
        cs.registerOutParameter(6,OracleTypes.ARRAY, "ARR_OGG_DI_FATRZ");
        cs.registerOutParameter(7,Types.INTEGER);
        cs.registerOutParameter(8,Types.VARCHAR);
        cs.execute();
        // Costruisco l'array che conterrà i dati di ritorno della stored
        ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_OGG_DI_FATRZ",conn);
        ARRAY rs = new ARRAY(ad, conn, null);
        // Ottengo i dati
        rs=cs.getARRAY(6);
        Datum dati[]=rs.getOracleArray();
        // Estrazione dei dati
        for (int i=0;i<dati.length;i++)
            {
                pk = new OggFattBMPPK();
                STRUCT s=(STRUCT)dati[i];
                Datum attr[]=s.getOracleAttributes();
                pk.setCodeOf(attr[0].stringValue());
                pk.setDescOf(attr[1].stringValue());
                //31/07/02 inizio
                pk.setCodeClasseOf(attr[4].stringValue());
    //             //System.out.println("attr[4].stringValue() "+attr[4].stringValue());
                //31/07/02 fine
                recs.add(pk);
            }
         cs.close();
        // Chiudo la connessione
        conn.close();
      }
                  catch(SQLException e)
                  {
                          throw new FinderException(e.getMessage());
                  } finally
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
    
  public void ejbStore() throws RemoteException, CustomEJBException
  {
//System.out.println("ejbStore");
  if (enableStore)
  {
   pk = (OggFattBMPPK) ctx.getPrimaryKey();

//    String myFlagSys=pk.getFlagSys();
   if (myFlagSys.equals("S"))
   {
     try
      {
      conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_AGGIORNA(?,?,?,?,?,?,?)}");

      cs.setString(1,pk.getCodeClasseOf());
      cs.setString(2,pk.getDescOf());
      cs.setString(3,pk.getTipoFlgAssocb());
      cs.setString(4,pk.getDataFine());
      cs.setString(5,pk.getCodeOf());

      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);

      cs.execute();

      if (cs.getInt(6)!=DBMessage.OK_RT)
          throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7));
      cs.close();
      conn.close();
      }

    catch(Exception lexc_Exception)
      {
		throw new CustomEJBException(lexc_Exception.toString(),
							"Errore di aggiornamento nella store procedure PKG_BILL_SPE.OGGETTO_FATT_AGGIORNA",
							"ejbStore",
							this.getClass().getName(),
							StaticContext.FindExceptionType(lexc_Exception));
      }
    finally
      {
        try
        {
          conn.close();
        } catch(Exception lexc_Exception)
        {
          throw new CustomEJBException(lexc_Exception.toString(),
							"Errore nella chiusura della connessione - Special",
							"ejbStore",
							this.getClass().getName(),
							StaticContext.FindExceptionType(lexc_Exception));
        }
      }

   }
   else
   {
     try
      {
//     //System.out.println("funziona-flag="+myFlagSys);
      conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_CL_AGGIORNA(?,?,?,?,?,?,?)}");
//      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_ALB.OGGETTO_FATT_CL_AGGIORNA(?,?,?,?,?,?,?)}");

      cs.setString(1,pk.getCodeClasseOf());
      cs.setString(2,pk.getDescOf());
      cs.setString(3,pk.getTipoFlgAssocb());
      cs.setString(4,pk.getDataFine());
      cs.setString(5,pk.getCodeOf());

      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);

      cs.execute();

      if (cs.getInt(6)!=DBMessage.OK_RT)
          throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7));
      cs.close();
      conn.close();
      }
    catch(Exception lexc_Exception)
      {
		throw new CustomEJBException(lexc_Exception.toString(),
							"Errore di aggiornamento nella store procedure PKG_BILL_SPE.OGGETTO_FATT_CL_AGGIORNA",
							"ejbStore",
							this.getClass().getName(),
							StaticContext.FindExceptionType(lexc_Exception));
      }
    finally
      {
        try
        {
          conn.close();
        } catch(Exception lexc_Exception)
        {
          throw new CustomEJBException(lexc_Exception.toString(),
							"Errore nella chiusura della connessione - Classic",
							"ejbStore",
							this.getClass().getName(),
							StaticContext.FindExceptionType(lexc_Exception));
        }
      }

	   }
  }

  }


  public Collection ejbFindAll(String CodTipoContr, boolean solo_attivi) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
    
 		try
		{
			conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_CARICA_LISTA(?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      if (solo_attivi)
        cs.setInt(2,0);
      else
        cs.setInt(2,1);

      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_OGG_DI_FATRZ");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);

      cs.execute();

      
      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new FinderException("DB:"+cs.getInt(4)+":"+cs.getString(5));

      if (cs.getInt(4)==DBMessage.NOT_FOUND_RT)
        { 
        cs.close();
        conn.close();
        return recs;
        }
      
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_OGG_DI_FATRZ",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new OggFattBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              pk.setCodeOf(attr[0].stringValue());
              pk.setDescOf(attr[1].stringValue());
              pk.setDataIni(attr[2].stringValue());

              if (attr[3]!=null)
                pk.setDataFine(attr[3].stringValue());
              else
                pk.setDataFine("");

              pk.setCodeClasseOf(attr[4].stringValue());
              pk.setTipoFlgAssocb(attr[5].stringValue());
              pk.setDescClasseOf(attr[6].stringValue());

              recs.add(pk);
          }
      cs.close();
      // Chiudo la connessione
      conn.close();
    }

		catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} finally
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

  public Collection ejbFindAllCla(boolean solo_attivi) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_CL_CARICA_LISTA(?,?,?,?)}");
//      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_ALB.OGGETTO_FATT_CL_CARICA_LISTA(?,?,?,?)}");

      // Impostazione types I/O
//      cs.setString(1,CodTipoContr);
      if (solo_attivi)
        cs.setInt(1,0);
      else
        cs.setInt(1,1);

      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_OGG_DI_FATRZ");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);

      cs.execute();

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_OGG_DI_FATRZ",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new OggFattBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              pk.setCodeOf(attr[0].stringValue());
              pk.setDescOf(attr[1].stringValue());
              pk.setDataIni(attr[2].stringValue());

              if (attr[3]!=null)
                pk.setDataFine(attr[3].stringValue());
              else
                pk.setDataFine("");

              pk.setCodeClasseOf(attr[4].stringValue());
              pk.setTipoFlgAssocb(attr[5].stringValue());
              pk.setDescClasseOf(attr[6].stringValue());

              recs.add(pk);
          }
       cs.close();
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} finally
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

  public OggFattBMPPK ejbFindOggFattMaxDataIni(String codeOf) throws FinderException, RemoteException
  {
    OggFattBMPPK pk = new OggFattBMPPK();
   //System.out.println("findOggFattMaxDataIni");
    Connection conn=null;  

    try
      {
        
        conn = getConnection(dsName);
        //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call OGGETTO_FATT_MAX_DATAINI_OF(?,?,?,?)}");
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.OGGETTO_FATT_MAX_DATAINI_OF(?,?,?,?)}");  
         // Impostazione types I/O
        cs.setString(1,codeOf);

        cs.registerOutParameter(2,Types.VARCHAR);
        cs.registerOutParameter(3,Types.INTEGER);
        cs.registerOutParameter(4,Types.VARCHAR);

        cs.execute();

        if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
          throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: OGGETTO_FATT_MAX_DATAINI_OF");
 
       pk.setDataIni(cs.getString(2));
       cs.close();
        // Chiudo la connessione
        conn.close();
      }

  catch(SQLException e)
      {
        StaticMessages.setCustomString(e.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5002,"OggFattBMPBean","","",StaticContext.APP_SERVER_DRIVER));
        e.printStackTrace();
        throw new FinderException(e.getMessage());
      } 
      catch(Exception ee)
      {
        StaticMessages.setCustomString(ee.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5003,"OggFattBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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
          StaticMessages.setCustomString(e.toString());
          StaticContext.writeLog(StaticMessages.getMessage(5002,"","","",StaticContext.APP_SERVER_DRIVER));
          e.printStackTrace();
          throw new RemoteException(e.getMessage());
        }
      }
    
     return  pk;
  }
//Valeria fine 02-09-02  



  public String getCodeOggFatt()
  {
      pk = (OggFattBMPPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
        return pk.getCodeOf();
  }

  public void setCodeOggFatt(String codeOggFatt)
  {

		pk = (OggFattBMPPK) ctx.getPrimaryKey();
		pk.setCodeOf (codeOggFatt);
    enableStore=true;
  }

 public String getDescOggFatt()
  {
      pk = (OggFattBMPPK) ctx.getPrimaryKey();
      return pk.getDescOf();
//      enableStore=false;
//      return mDescOggFatt;
  }

  public void setDescOggFatt(String descOggFatt)
  {
		pk = (OggFattBMPPK) ctx.getPrimaryKey();
		pk.setDescOf (descOggFatt);
    enableStore=true;
//    mDescOggFatt=descOggFatt;
  }

 public String getDataIni()
  {
      pk = (OggFattBMPPK) ctx.getPrimaryKey();
      return pk.getDataIni();
//      enableStore=false;
//      return mDataIni;
  }

  public void setDataIni(String dataIni)
  {
		pk = (OggFattBMPPK) ctx.getPrimaryKey();
		pk.setDataIni (dataIni);
    enableStore=true;
//    mDataIni=dataIni;
  }

  public String getCodeCOf()
  {
      pk = (OggFattBMPPK) ctx.getPrimaryKey();
      return pk.getCodeClasseOf();

  }

  public void setCodeCOf(String codeCOf)
  {
		pk = (OggFattBMPPK) ctx.getPrimaryKey();
		pk.setCodeClasseOf (codeCOf);
    enableStore=true;

  }

 public String getTipoFlgAssocB()
  {
      pk = (OggFattBMPPK) ctx.getPrimaryKey();
      return pk.getTipoFlgAssocb();

  }

  public void setTipoFlgAssocB(String tipoFlgAssocB)
  {
		pk = (OggFattBMPPK) ctx.getPrimaryKey();
		pk.setTipoFlgAssocb (tipoFlgAssocB);
    enableStore=true;

  }

  public String getDataFine()
  {
      pk = (OggFattBMPPK) ctx.getPrimaryKey();
      return pk.getDataFine();

  }

  public void setDataFine(String dataFine)
  {
		pk = (OggFattBMPPK) ctx.getPrimaryKey();
System.out.println("pk.setDataFine-1");
		pk.setDataFine (dataFine);
System.out.println("pk.setDataFine-2");
    enableStore=true;
//    mDataFine=dataFine;
  }

  public String getDescClasseOf()
  {
      pk = (OggFattBMPPK) ctx.getPrimaryKey();
      return pk.getDescClasseOf();

  }


public boolean isDisattivabile() throws CustomEJBException
  {
  // Controlla se l'oggetto di fatturazione è
  // disattivabile
 //System.out.println("isDisattivabile");

  pk = (OggFattBMPPK) ctx.getPrimaryKey();  

  Connection conn=null;  

  try
      {
        conn = getConnection(dsName);

        
        if (pk.getFlagSys().equalsIgnoreCase("S"))
          {
          // special

          OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_VER_ES_X_OF(?,?,?,?)}");

          cs.setString(1,pk.getCodeOf());

          cs.registerOutParameter(2,Types.INTEGER);
          
          cs.registerOutParameter(3,Types.INTEGER);
          cs.registerOutParameter(4,Types.VARCHAR);

          cs.execute();

          if (cs.getInt(3)!=DBMessage.OK_RT)
            throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

          int num_ass=cs.getInt(2);
          if (num_ass!=0) return false;

          cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_VER_ES_X_OF(?,?,?,?)}");
          cs.setString(1,pk.getCodeOf());

          cs.registerOutParameter(2,Types.INTEGER);
          
          cs.registerOutParameter(3,Types.INTEGER);
          cs.registerOutParameter(4,Types.VARCHAR);

          cs.execute();

          if (cs.getInt(3)!=DBMessage.OK_RT)
            throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

          num_ass=cs.getInt(2);
          if (num_ass!=0) return false;


          }
        else
          {
          // classic

          OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_CL_VER_ES_X_OF(?,?,?,?)}");

          cs.setString(1,pk.getCodeOf());

          cs.registerOutParameter(2,Types.INTEGER);
          
          cs.registerOutParameter(3,Types.INTEGER);
          cs.registerOutParameter(4,Types.VARCHAR);

          cs.execute();

          if (cs.getInt(3)!=DBMessage.OK_RT)
            throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

          int num_ass=cs.getInt(2);
          if (num_ass!=0) return false;
 
          }
        
        conn.close();
      }

    catch(Exception lexc_Exception)
    {
    throw new CustomEJBException(lexc_Exception.toString(),
    							"Errore nella verifica se l'oggetto di fatturazione è disattivabile",
									"isDisattivabile Special",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
  	}
    finally
      {
        try
        {
          conn.close();
        } catch(Exception lexc_Exception)
        {
          throw new CustomEJBException(lexc_Exception.toString(),
							"Errore nella chiusura della connessione",
							"isDisattivabile Special",
							this.getClass().getName(),
							StaticContext.FindExceptionType(lexc_Exception));
        }
      }
  
  return true;
  }

public boolean isAssOfPs() throws CustomEJBException
  {
  // Controlla se sono collegate delle associazioni OfPS
  
 //System.out.println("isAssOfPs");

  pk = (OggFattBMPPK) ctx.getPrimaryKey();  

  Connection conn=null;  

  try
      {
        conn = getConnection(dsName);

        
        if (pk.getFlagSys().equalsIgnoreCase("S"))
          {
          // special

          OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_VER_ES_X_OF_2(?,?,?,?)}");

          cs.setString(1,pk.getCodeOf());

          cs.registerOutParameter(2,Types.INTEGER);
          
          cs.registerOutParameter(3,Types.INTEGER);
          cs.registerOutParameter(4,Types.VARCHAR);

          cs.execute();

          if (cs.getInt(3)!=DBMessage.OK_RT)
            throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

          int num_ass=cs.getInt(2);
          if (num_ass!=0) return true;

          cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_VER_X_OF_3(?,?,?,?)}");
          cs.setString(1,pk.getCodeOf());

          cs.registerOutParameter(2,Types.INTEGER);
          
          cs.registerOutParameter(3,Types.INTEGER);
          cs.registerOutParameter(4,Types.VARCHAR);

          cs.execute();

          if (cs.getInt(3)!=DBMessage.OK_RT)
            throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

          num_ass=cs.getInt(2);
          if (num_ass!=0) return true;


          }
        else
          {
          // classic

          OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_CL_VER_ES_X_OF(?,?,?,?)}");

          cs.setString(1,pk.getCodeOf());

          cs.registerOutParameter(2,Types.INTEGER);
          
          cs.registerOutParameter(3,Types.INTEGER);
          cs.registerOutParameter(4,Types.VARCHAR);

          cs.execute();

          if (cs.getInt(3)!=DBMessage.OK_RT)
            throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

          int num_ass=cs.getInt(2);
          if (num_ass!=0) return true;
 
          }
        
        conn.close();
      }

    catch(Exception lexc_Exception)
    {
    throw new CustomEJBException(lexc_Exception.toString(),
    							"Errore nella verifica se l'oggetto di fatturazione è disattivabile",
									"isDisattivabile Special",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
  	}
    finally
      {
        try
        {
          conn.close();
        } catch(Exception lexc_Exception)
        {
          throw new CustomEJBException(lexc_Exception.toString(),
							"Errore nella chiusura della connessione",
							"isDisattivabile Special",
							this.getClass().getName(),
							StaticContext.FindExceptionType(lexc_Exception));
        }
      }
  
  return false;
  }

//METODO PER IL CARICAMENTO DELLA COMBO SU  INSERIMENTO NUOVA TARIFFA Associata a Ps
    public Collection ejbFindOggFattAssPsXContr(String CodTipoContr,String CodContr,String CodPs) throws FinderException, RemoteException
	{
//System.out.println("Sono in ejbFindOggFattAssPsdd");
    Vector recs = new Vector();
 		try
		{
//     //System.out.println("Sono in ejbFindOggFattAssPsXContr");
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_LST_OF_OFPS_CONTR(?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.setString(2,CodContr);
      cs.setString(3,CodPs);
      cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_OGG_DI_FATRZ");
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_OGG_DI_FATRZ",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
      // Ottengo i dati
      rs=cs.getARRAY(4);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new OggFattBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setCodeOf(attr[0].stringValue());
              pk.setDescOf(attr[1].stringValue());
              //31/07/02 inizio
              pk.setCodeClasseOf(attr[4].stringValue());
//             //System.out.println("attr[4].stringValue() "+attr[4].stringValue());
              //31/07/02 fine
              recs.add(pk);
          }
       cs.close();
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} finally
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
// Fine METODO PER IL CARICAMENTO DELLA COMBO SU INSERIMENTO TARIFFA X CONTR Associate a Ps

}