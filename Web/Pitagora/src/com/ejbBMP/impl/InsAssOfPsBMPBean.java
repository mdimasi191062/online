package com.ejbBMP.impl;
import javax.ejb.EntityBean;
import javax.ejb.EntityContext;
import com.ejbBMP.InsAssOfPsBMPPK;
import java.util.*;
import java.rmi.*;
import java.sql.*;
import javax.ejb.*;
import oracle.jdbc.*;
import oracle.sql.*;
import com.utl.*;
import javax.naming.*;

public class InsAssOfPsBMPBean extends AbstractEntityCommonBean implements EntityBean 
{
  public EntityContext entityContext;
  private InsAssOfPsBMPPK pk;
  private boolean enableStore=false;


  public InsAssOfPsBMPPK ejbCreate(String data_ini,String cod_of,String PS,String dataInizioOf,
                                   String modApplSelezValue,String freqSelezValue,String codiceUtente,
                                   int shift,String flagAP,String data_fine) 
                                    throws CreateException, RemoteException, CustomEJBException
  {

if(flagAP.equals("null")) 
{
  flagAP="X";
}
if(modApplSelezValue.equals("-1")) 
{
  modApplSelezValue="";
}

      try
      {
      conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_INSERISCI(?,?,?,?,?,?,?,?,?,?,?,?)}");


      // Impostazione types I/O

      cs.setString(1,data_ini);
      cs.setString(2,cod_of);
      cs.setString(3,PS);
      cs.setString(4,dataInizioOf);
      cs.setString(5,modApplSelezValue);
      cs.setString(6,freqSelezValue);
      cs.setString(7,codiceUtente);
      cs.setInt(8,shift);
      cs.setString(9,flagAP);
      cs.setString(10,data_fine);

      cs.registerOutParameter(11,Types.INTEGER);
      cs.registerOutParameter(12,Types.VARCHAR);
      
      cs.execute();

      if ((cs.getInt(11)!=DBMessage.OK_RT)&&(cs.getInt(11)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(11)+":"+cs.getString(12));


      pk=new InsAssOfPsBMPPK(data_ini,cod_of,PS,dataInizioOf,
                         modApplSelezValue,freqSelezValue,codiceUtente,
                         shift,flagAP,data_fine);
     cs.close();
     conn.close();

      }

//inserita la nuova gestione delle eccezioni
    catch(Exception lexc_Exception)
      {
  throw new CustomEJBException(lexc_Exception.toString(),
       "Errore di inserimento nella store procedure ASSOC_OFPS_INSERISCI",
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
 

  public void ejbPostCreate(String data_ini,String cod_of,String PS,String dataInizioOf,
                            String modApplSelezValue,String freqSelezValue,String codiceUtente,
                            int shift,String flagAP,String data_fine) 
                                    
  {
  }

  public InsAssOfPsBMPPK ejbFindByPrimaryKey(InsAssOfPsBMPPK primaryKey)
  {
    return primaryKey;
  }


 public InsAssOfPsBMPPK ejbFindAssOfPsMaxDataIni(String codPs) throws FinderException, RemoteException      
  {
  //Restituisce la data inizio validità più recente di un prodotto servizio
/*
Parametri di input: 
 codice prodotto servizio	varchar2
Parametri di output:
 data inizio validità ps		varchar2  (formato dd/mm/yyyy)
 codice errore sql       	number
 descrizione errore sql  	varchar2
*/
// //System.out.println("> ejbFindAssOfPsMaxDataIni");
  InsAssOfPsBMPPK pk = new InsAssOfPsBMPPK();
  Connection conn=null;  

  try
    {
      conn = getConnection(dsName);

      // CONTROLLARE IL PACKAGE
//      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_ROSA.PS_MAX_DATA_INI(?,?,?,?)}");
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PS_MAX_DATA_INI(?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codPs);

      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);

      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"STORED: PS_MAX_DATA_INI");

      pk.setDataIni(cs.getString(2));      
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
       StaticMessages.setCustomString(e.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5002,"InsAssOfPsBMPBean","","",StaticContext.APP_SERVER_DRIVER));
       e.printStackTrace();
         throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"InsAssOfPsBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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

   return pk;
  }



// public InsAssOfPsBMPPK ejbFindAssOfPsMaxDataIniOf(String cod_contratto) throws FinderException, RemoteException      
 public InsAssOfPsBMPPK ejbFindAssOfPsMaxDataIniOf(String cod_of) throws FinderException, RemoteException      
  {
  //Restituisce la data inizio validità più recente di un prodotto servizio
/*
Parametri di input: 
 codice prodotto servizio	varchar2
Parametri di output:
 data inizio validità ps		varchar2  (formato dd/mm/yyyy)
 codice errore sql       	number
 descrizione errore sql  	varchar2
*/
// //System.out.println("> findAssOfPsMaxDataIniOf");
  InsAssOfPsBMPPK pk = new InsAssOfPsBMPPK();
  Connection conn=null;  

  try
    {
      conn = getConnection(dsName);

      // CONTROLLARE IL PACKAGE
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_MAX_DATAINI_OF(?,?,?,?)}");

       // Impostazione types I/O
//      cs.setString(1,cod_contratto);
      cs.setString(1,cod_of);

      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);

      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"STORED: OGGETTO_FATT_MAX_DATAINI_OF");

      pk.setDataIniOf(cs.getString(2));      
      // Chiudo la connessione
      cs.close();
      conn.close();
    }
		catch(SQLException e)
		{
             StaticMessages.setCustomString(e.toString());
             StaticContext.writeLog(StaticMessages.getMessage(5002,"InsAssOfPsBMPBean","","",StaticContext.APP_SERVER_DRIVER));
             e.printStackTrace();
             throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"InsAssOfPsBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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
   return pk;
  }



 public InsAssOfPsBMPPK ejbFindDataFineValOf(String cod_of) throws FinderException, RemoteException      
  {
  //Restituisce la data fine validità di un oggetto di fatturazione
/*
Parametri di input: 
codice ogg. fatturazione  	varchar2

Parametri di output:
descrizione ogg. fatturazione	varchar2
codice classe of		varchar2
data inizio ogg. fatturazione	varchar2  (formato dd/mm/yyyy)
data fine ogg. fatturazione	varchar2  (formato dd/mm/yyyy)
flag associabile			varchar2  
codice tipo contratto		varchar2  
codice errore sql       number
descrizione errore sql  varchar2
*/

  InsAssOfPsBMPPK pk = new InsAssOfPsBMPPK();
  Connection conn=null;  

  try
    {
      conn = getConnection(dsName);

      // CONTROLLARE IL PACKAGE
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_LEGGI_DETTAGLIO(?,?,?,?,?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,cod_of);

      cs.registerOutParameter(2,Types.VARCHAR); 
      cs.registerOutParameter(3,Types.VARCHAR); 
      cs.registerOutParameter(4,Types.VARCHAR); 
      cs.registerOutParameter(5,Types.VARCHAR); 
      cs.registerOutParameter(6,Types.VARCHAR); 
      cs.registerOutParameter(7,Types.VARCHAR); 
      cs.registerOutParameter(8,Types.INTEGER);
      cs.registerOutParameter(9,Types.VARCHAR);

      cs.execute();

      if ((cs.getInt(8)!=DBMessage.OK_RT))//&&(cs.getInt(8)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(8)+":"+cs.getString(9)+"NOME STORED: OGGETTO_FATT_LEGGI_DETTAGLIO");

      pk.setDataFine(cs.getString(6));      

      cs.close();      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
             StaticMessages.setCustomString(e.toString());
             StaticContext.writeLog(StaticMessages.getMessage(5002,"InsAssOfPsBMPBean","","",StaticContext.APP_SERVER_DRIVER));
             e.printStackTrace();
             throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"InsAssOfPsBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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
   return pk;
  }




 public InsAssOfPsBMPPK ejbFindMinData(String cod_contratto,String cod_of,String cod_ps) throws FinderException, RemoteException      
  {
  //Si preleva la data di inizio validità più vecchia dell'associazione 

/*
Parametri di input: 
codice tipo contratto			varchar2
codice oggetto fatturazione		varchar2
codice prodotto servizio		varchar2

Parametri di output:
data inizio validità			varchar2  (formato dd/mm/yyyy)
codice errore sql           		number
descrizione errore sql       		varchar2
*/
// //System.out.println("> FindMinData");
  InsAssOfPsBMPPK pk = new InsAssOfPsBMPPK();
  Connection conn=null;  

  try
    {
      conn = getConnection(dsName);

      // CONTROLLARE IL PACKAGE
//      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_NICOLA.ASSOC_OFPS_MIN_DIV(?,?,?,?,?,?)}");
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_MIN_DIV(?,?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,cod_contratto);
      cs.setString(2,cod_of);
      cs.setString(3,cod_ps);

      cs.registerOutParameter(4,Types.VARCHAR);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);

      cs.execute();

      pk.setDataIniValidMin(cs.getString(4));      

      if ((cs.getInt(5)!=DBMessage.OK_RT))//&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6)+"NOME STORED: ASSOC_OFPS_MIN_DIV");
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
             StaticMessages.setCustomString(e.toString());
             StaticContext.writeLog(StaticMessages.getMessage(5002,"InsAssOfPsBMPBean","","",StaticContext.APP_SERVER_DRIVER));
             e.printStackTrace();
             throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"InsAssOfPsBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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
   return pk;
  }


 public InsAssOfPsBMPPK ejbFindMaxData(String cod_contratto,String cod_of,String cod_ps) throws FinderException, RemoteException      
  {
    //Si preleva la data di fine validità più recente dell'associazione 

/*
Parametri di input: 
codice tipo contratto			varchar2
codice oggetto fatturazione		varchar2
codice prodotto servizio		varchar2

Parametri di output:
data fine validità			varchar2  (formato dd/mm/yyyy)
codice errore sql           		number
descrizione errore sql       		varchar2
*/
// //System.out.println("> FindMaxData");
  InsAssOfPsBMPPK pk = new InsAssOfPsBMPPK();
  Connection conn=null;  

  try
    {
      conn = getConnection(dsName);

      // CONTROLLARE IL PACKAGE
//      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_NICOLA.ASSOC_OFPS_MAX_DFV(?,?,?,?,?,?)}");
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_MAX_DFV(?,?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,cod_contratto);
      cs.setString(2,cod_of);
      cs.setString(3,cod_ps);

      cs.registerOutParameter(4,Types.VARCHAR);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);

      cs.execute();

      if ((cs.getInt(5)!=DBMessage.OK_RT))//&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6)+"NOME STORED: ASSOC_OFPS_MAX_DFV");

      pk.setDataFineValidMax(cs.getString(4));      
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
             StaticMessages.setCustomString(e.toString());
             StaticContext.writeLog(StaticMessages.getMessage(5002,"InsAssOfPsBMPBean","","",StaticContext.APP_SERVER_DRIVER));
             e.printStackTrace();
             throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"InsAssOfPsBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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
   return pk;
  }


 public InsAssOfPsBMPPK ejbFindDataInizioOf(String cod_of) throws FinderException, RemoteException      
  {
  //Restituisce la data inizio validità di un oggetto di fatturazione
/*
Parametri di input: 
codice ogg. fatturazione  	varchar2

Parametri di output:
descrizione ogg. fatturazione	varchar2
codice classe of			varchar2
descrizione classe of		varchar2
data inizio ogg. fatturazione	varchar2  (formato dd/mm/yyyy)
data fine ogg. fatturazione	varchar2  (formato dd/mm/yyyy)
flag associabile			varchar2  
codice tipo contratto		varchar2  
codice errore sql       number
descrizione errore sql  varchar2
*/

// //System.out.println("> ejbFindDataInizioOf");
  InsAssOfPsBMPPK pk = new InsAssOfPsBMPPK();
  Connection conn=null;  

  try
    {
      conn = getConnection(dsName);

      // CONTROLLARE IL PACKAGE
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_LEGGI_DETTAGLIO(?,?,?,?,?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,cod_of);

      cs.registerOutParameter(2,Types.VARCHAR); 
      cs.registerOutParameter(3,Types.VARCHAR); 
      cs.registerOutParameter(4,Types.VARCHAR); 
      cs.registerOutParameter(5,Types.VARCHAR); 
      cs.registerOutParameter(6,Types.VARCHAR); 
      cs.registerOutParameter(7,Types.VARCHAR); 
      cs.registerOutParameter(8,Types.INTEGER);
      cs.registerOutParameter(9,Types.VARCHAR);

      cs.execute();

      if ((cs.getInt(8)!=DBMessage.OK_RT))//&&(cs.getInt(8)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(8)+":"+cs.getString(9)+"NOME STORED: OGGETTO_FATT_LEGGI_DETTAGLIO");


      pk.setDataIni(cs.getString(5));      
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
             StaticMessages.setCustomString(e.toString());
             StaticContext.writeLog(StaticMessages.getMessage(5002,"InsAssOfPsBMPBean","","",StaticContext.APP_SERVER_DRIVER));
             e.printStackTrace();
             throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"InsAssOfPsBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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
   return pk;
  }





  public String getDataIni()
  {
      pk = (InsAssOfPsBMPPK) ctx.getPrimaryKey();
      return pk.getDataIni();
  
  }

  public void setDataIni(String dataIni)
  {
      pk = (InsAssOfPsBMPPK) ctx.getPrimaryKey();
 		  pk.setDataIni(dataIni);
      enableStore=true;

  }

  public String getDataFine()
  {
      pk = (InsAssOfPsBMPPK) ctx.getPrimaryKey();
    
      return pk.getDataFine();

  }

  public void setDataFine(String dataFine)
  {
      pk = (InsAssOfPsBMPPK) ctx.getPrimaryKey();
 		  pk.setDataFine(dataFine);
      enableStore=true;

  }

  public String getDataIniOf()
  {
      pk = (InsAssOfPsBMPPK) ctx.getPrimaryKey();
     
      return pk.getDataIniOf();
 
  }

  public void setDataIniOf(String dataIniOf)
  {
      pk = (InsAssOfPsBMPPK) ctx.getPrimaryKey();
 		  pk.setDataIniOf(dataIniOf);
      enableStore=true;

  }


  public String getDataIniValidMin()
  {
      pk = (InsAssOfPsBMPPK) ctx.getPrimaryKey();
   
      return pk.getDataIniValidMin();
 
  }

  public void setDataIniValidMin(String DataIniValidMin)
  {
      pk = (InsAssOfPsBMPPK) ctx.getPrimaryKey();
 		  pk.setDataIniValidMin(DataIniValidMin);
      enableStore=true;

  }

  public String getDataFineValidMax()
  {
      pk = (InsAssOfPsBMPPK) ctx.getPrimaryKey();
      return pk.getDataFineValidMax();
  
  }

  public void setDataFineValidMax(String DataFineValidMax)
  {
//System.out.println("in setDataFineValidMax: DataFineValidMax="+DataFineValidMax);
      pk = (InsAssOfPsBMPPK) ctx.getPrimaryKey();
 		  pk.setDataFineValidMax(DataFineValidMax);
      enableStore=true;

  }

}