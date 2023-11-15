package com.ejbBMP.impl;
import java.util.*;
import java.rmi.*;
import java.sql.*;
import javax.ejb.*;
import javax.naming.*;
import oracle.jdbc.*;
import oracle.sql.*;
import com.ejbBMP.DatiCliBMPPK;
import com.utl.*;
import com.ejbBMP.DatiCliBMP;

public class DatiCliBMPBean extends AbstractEntityCommonBean implements EntityBean
{
  public EntityContext entityContext;
  private DatiCliBMPPK pk;
  private boolean enableStore=false;

  public DatiCliBMPPK ejbCreate()
  throws CreateException, RemoteException
  {
    pk= new DatiCliBMPPK();
    return pk;
  }


  public void ejbPostCreate()
  {
  }

 public DatiCliBMPPK ejbFindByPrimaryKey(DatiCliBMPPK primaryKey)
  {
    return primaryKey;
  }

public DatiCliBMPPK ejbFindCodElabBatch(String codFunz, String periodoRif, String sys) throws FinderException, RemoteException
  {
  DatiCliBMPPK pk = new DatiCliBMPPK();
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ELAB_BATCH_LEGGI_COD (?,?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codFunz);
      cs.setString(2,periodoRif);
      cs.setString(3,sys);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();
      pk.setCodElabBatch(cs.getString(4));

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
      catch(Throwable e)
    {
      try
        {
          if (!conn.isClosed())
              conn.close();
        }
      catch (SQLException sqle)
        {
          sqle.printStackTrace();
          throw new RemoteException(sqle.getMessage());
        }

      e.printStackTrace();
       throw new RemoteException(e.getMessage());
    }

   return  pk;
  }
  
  public DatiCliBMPPK ejbFindNumFattLisUn(String flagTipoContr, String codContr) throws FinderException, RemoteException
  {
  DatiCliBMPPK pk = new DatiCliBMPPK();
  Connection conn=null;
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs = null;
 
      if (flagTipoContr.equals("0"))
         cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_VER_FATT_LIS_UN_ULL (?,?,?,?)}");
      else if (flagTipoContr.equals("1"))
         cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_VER_FATT_LIS_UN_XDSL (?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,codContr);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      pk.setNumFattLisUn(new Integer(cs.getInt(2)));
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
      catch(Throwable e)
    {
      try
        {
          if (!conn.isClosed())
              conn.close();
        }
      catch (SQLException sqle)
        {
          sqle.printStackTrace();
          throw new RemoteException(sqle.getMessage());
        }

      e.printStackTrace();
       throw new RemoteException(e.getMessage());
    }
   return  pk;
  }

  public Collection ejbFindValAttSpec1(String DataIni, String DataFine, String CodTipoContr,String CodeFunz,String Sys) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_LST_REPORT_VA_ULL (?,?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,DataIni);
      cs.setString(2,DataFine);
      cs.setString(3,CodTipoContr);
      cs.setString(4,CodeFunz);
      cs.setString(5,Sys);
      cs.registerOutParameter(6,OracleTypes.ARRAY, "ARR_ACCOUNT_CONG");
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);
      cs.execute();

      // Costruisco l'array che conterr� i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_CONG",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(6);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new DatiCliBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setAccount(attr[1].stringValue());
              pk.setDesc(attr[2].stringValue());
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

public Collection ejbFindValAttClass(String DataIni, String DataFine, String CodTipoContr,String CodeFunz,String Sys) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_LST_REPORT_VA_CL (?,?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,DataIni);
      cs.setString(2,DataFine);
      cs.setString(3,CodTipoContr);
      cs.setString(4,CodeFunz);
      cs.setString(5,Sys);
      cs.registerOutParameter(6,OracleTypes.ARRAY, "ARR_ACCOUNT_CONG");
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);
      cs.execute();

      // Costruisco l'array che conterr� i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_CONG",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(6);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new DatiCliBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setAccount(attr[1].stringValue());
              pk.setDesc(attr[2].stringValue());
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

public Collection ejbFindAvanzRicClass(String Mese, String Anno, String CodTipoContr,String Sys) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_LST_REPORT_SAR_CL (?,?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,Mese);
      cs.setString(2,Anno);
      cs.setString(3,CodTipoContr);
      cs.setString(4,Sys);
      cs.registerOutParameter(5,OracleTypes.ARRAY, "ARR_ACCOUNT_CONG");
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.execute();

      // Costruisco l'array che conterr� i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_CONG",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(5);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new DatiCliBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setAccount(attr[1].stringValue());
              pk.setDesc(attr[2].stringValue());
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

public Collection ejbFindNotaCreClass(String DataFine, String CodTipoContr,String Sys) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_LST_REPORT_NC_CL (?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,DataFine);
      cs.setString(2,CodTipoContr);
      cs.setString(3,Sys);
      cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_ACCOUNT_CONG");
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

      // Costruisco l'array che conterr� i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_CONG",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(4);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new DatiCliBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setAccount(attr[1].stringValue());
              pk.setDesc(attr[2].stringValue());
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
public Collection ejbFindRepricClass(String CodTipoContr,String CodFunz, String CodElab, String Sys) throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_LST_REPORT_REPR_CL (?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.setString(2,CodFunz);
      cs.setString(3,CodElab);
      cs.setString(4,Sys);
      cs.registerOutParameter(5,OracleTypes.ARRAY, "ARR_ACCOUNT_CONG");
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.execute();

      // Costruisco l'array che conterr� i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_CONG",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(5);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new DatiCliBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              pk.setAccount(attr[1].stringValue());
              pk.setDesc(attr[2].stringValue());
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
public Collection ejbFindNotaCreSpec1(String DataIni, String DataFine, String CodTipoContr,String Sys) throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{

			conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_LST_REPORT_NC_ULL (?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,DataIni);
      cs.setString(2,DataFine);
      cs.setString(3,CodTipoContr);
      cs.setString(4,Sys);
      cs.registerOutParameter(5,OracleTypes.ARRAY, "ARR_ACCOUNT");
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);

      cs.execute();


      // Costruisco l'array che conterr� i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(5);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new DatiCliBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              pk.setAccount(attr[0].stringValue());
              pk.setDesc(attr[1].stringValue());
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
  
 public Collection ejbFindValAttSpec2(String DataIni, String DataFine, String CodTipoContr,String CodeFunz,String Sys) throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".ACCOUNT_LST_REPORT_VA_XDSL (?,?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,DataIni);
      cs.setString(2,DataFine);
      cs.setString(3,CodTipoContr);
      cs.setString(4,CodeFunz);
      cs.setString(5,Sys);
      cs.registerOutParameter(6,OracleTypes.ARRAY, "ARR_ACCOUNT_CONG");
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);

      cs.execute();


      // Costruisco l'array che conterr� i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_CONG",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(6);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new DatiCliBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              pk.setAccount(attr[1].stringValue());
              pk.setDesc(attr[2].stringValue());
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
public Collection ejbFindNotaCreSpec2(String DataIni, String DataFine, String CodTipoContr,String Sys)  throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{

			conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_LST_REPORT_NC_XDSL (?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,DataIni);
      cs.setString(2,DataFine);
      cs.setString(3,CodTipoContr);
      cs.setString(4,Sys);
      cs.registerOutParameter(5,OracleTypes.ARRAY, "ARR_ACCOUNT");
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);

      cs.execute();


      // Costruisco l'array che conterr� i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(5);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new DatiCliBMPPK();
 
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              pk.setAccount(attr[0].stringValue());
              pk.setDesc(attr[1].stringValue());
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
public Collection ejbFindAccountNoCong(String Code_funz, String CodTipoContr)  throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{

			conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_VALOR_NO_CONG (?,?,?,?,?)}");
   
      // Impostazione types I/O
      cs.setString(1,Code_funz);
      cs.setString(2,CodTipoContr);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_ACCOUNT");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();


      // Costruisco l'array che conterr� i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new DatiCliBMPPK();
 
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              pk.setAccount(attr[0].stringValue());
              pk.setDesc(attr[1].stringValue());
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

  public Collection ejbFindFattProvv(String CodeFunzBatch,String CicloFatt,String DataIniCiclo, String CodeTipoContr) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 	try {
        conn = getConnection(dsName);
        OracleCallableStatement cs=null;
        if (CodeFunzBatch.equals("23"))
            cs=(OracleCallableStatement)conn.prepareCall("{call "+ StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_CON_FATT_PROVV (?,?,?,?,?,?)}");
        else
        if (CodeFunzBatch.equals("21"))
            cs=(OracleCallableStatement)conn.prepareCall("{call "+ StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_CON_FATT_PROVV_XDSL (?,?,?,?,?,?)}");
        else{}
        // Impostazione types I/O
        cs.setString(1,CicloFatt);
        cs.setString(2,DataIniCiclo);
        cs.setString(3,CodeTipoContr); // lp 25/08/2004 anomalia Cambio Ciclo
        cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_ACCOUNT_FATT_PROVV");
        cs.registerOutParameter(5,Types.INTEGER);
        cs.registerOutParameter(6,Types.VARCHAR);
        cs.execute();

        if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        {
            if (CodeFunzBatch.equals("23"))
                throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6)+"STORED: ACCOUNT_CON_FATT_PROVV");
            else if (CodeFunzBatch.equals("21"))
                throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6)+"STORED: ACCOUNT_CON_FATT_PROVV_XDSL ");
        }

        // Costruisco l'array che conterr� i dati di ritorno della stored
        ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_FATT_PROVV",conn);
        ARRAY rs = new ARRAY(ad, conn, null);

        // Ottengo i dati
        rs=cs.getARRAY(4);
        Datum dati[]=rs.getOracleArray();
        // Estrazione dei dati

        for (int i=0;i<dati.length;i++)
        {
            pk = new DatiCliBMPPK();
            STRUCT s=(STRUCT)dati[i];
            Datum attr[]=s.getOracleAttributes();

            if (attr[0]!=null)
                pk.setAccount(attr[0].stringValue());
            else
                pk.setAccount(new String(""));

            if (attr[1]!=null)
                pk.setDesc(attr[1].stringValue());
            else
                pk.setDesc(new String(""));

            if (attr[2]!=null)
                pk.setCodeDocFatt(attr[2].stringValue());
            else
                pk.setCodeDocFatt(new String("")); 

            recs.add(pk);
        }
          
        cs.close();          
        // Chiudo la connessione
        conn.close();
    } catch(SQLException e) {
           StaticMessages.setCustomString(e.toString());
           StaticContext.writeLog(StaticMessages.getMessage(5002,"FattureBMPBean","","",StaticContext.APP_SERVER_DRIVER));
           e.printStackTrace();
             throw new FinderException(e.getMessage());
    }
    catch(Exception ee) {
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"FattureBMPBean","","",StaticContext.APP_SERVER_DRIVER));
       ee.printStackTrace();
       throw new RemoteException(ee.getMessage());
    }
    finally {
        try {
            conn.close();
        } catch(Exception e) {
          throw new RemoteException(e.getMessage());
        }
    }
    return recs;
  }

  public void ejbHomeAggInsCodParam(Collection Account_provv) throws FinderException, RemoteException
  {
  STRUCT Tabella_ins[] = null;
   try
      {
      conn = getConnection(dsName);
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_AGGIORNA(?,?,?)}");
      // Impostazione types I/O
      cs.registerOutParameter(1,OracleTypes.STRUCT, "ACCOUNT_CAMBIO_CICLOTYPE");      
      StructDescriptor sd=StructDescriptor.createDescriptor("ACCOUNT_CAMBIO_CICLOTYPE",conn);
      cs.registerOutParameter(1,OracleTypes.ARRAY, "ARR_ACCOUNT_CAMBIO_CICLO");      
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_CAMBIO_CICLO",conn);
      if (Account_provv.size() > 0)
      {
        Tabella_ins = new STRUCT[Account_provv.size()];
      }

      Object[] objs_ins = Account_provv.toArray();
      Object[] row = new Object[3];

      for (int i=0;i<Account_provv.size();i++)
      {
          
          DatiCliElem objtar = (DatiCliElem)objs_ins[i];
          if (objtar.getAccount() != null)
              row[0] = objtar.getAccount();
          else
              row[0] = "";
          if (objtar.getDesc() != null)
              row[1] = objtar.getDesc();
          else
              row[1] = "";
          if (objtar.getCodeParam() != null)
              row[2] = objtar.getCodeParam();
          else
              row[2] = "";
          Tabella_ins[i] = new STRUCT(sd,conn,row);
      }      
       ARRAY arrayIns = new ARRAY(ad, conn, Tabella_ins);
       cs.setArray(1,arrayIns);
       cs.registerOutParameter(2,Types.INTEGER);
       cs.registerOutParameter(3,Types.VARCHAR);

       cs.execute();
      if (cs.getInt(2)!=DBMessage.OK_RT)
          throw new Exception("DB:"+cs.getInt(2)+":"+cs.getString(3));

     cs.close();
     conn.close();

      }
    catch(Exception lexc_Exception)
      {
  throw new CustomEJBException(lexc_Exception.toString(),
       "Errore di inserimento nella store procedure "+StaticContext.PACKAGE_SPECIAL+".PARAM_VALO_AGGIORNA",
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
   return;
}
  
  public void ejbHomeRemoveFattProvv(String codeFunzBatch,Collection Account_fatt_provv) throws FinderException, RemoteException
  {
  STRUCT Tabella_can[] = null;
  String NOME_STORED="";
   try
      {
       conn = getConnection(dsName);
       OracleCallableStatement cs=null;
        if (codeFunzBatch.equals("23"))
        {
            cs=(OracleCallableStatement)conn.prepareCall("{call "+ StaticContext.PACKAGE_SPECIAL + ".DOCUM_FATT_ELIMINA_ULL(?,?,?)}");
            NOME_STORED="DOCUM_FATT_ELIMINA_ULL";
        }
        else if (codeFunzBatch.equals("21"))
              {
              cs=(OracleCallableStatement)conn.prepareCall("{call "+ StaticContext.PACKAGE_SPECIAL + ".DOCUM_FATT_ELIMINA_XDSL(?,?,?)}");
              NOME_STORED="DOCUM_FATT_ELIMINA_XDSL";
              }
        else{}
      // Impostazione types I/O
      cs.registerOutParameter(1,OracleTypes.STRUCT, "ACCOUNT_FATT_PROVVTYPE");      
      StructDescriptor sd=StructDescriptor.createDescriptor("ACCOUNT_FATT_PROVVTYPE",conn);
      cs.registerOutParameter(1,OracleTypes.ARRAY, "ARR_ACCOUNT_FATT_PROVV");
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_FATT_PROVV",conn);
      if (Account_fatt_provv.size() > 0)
      {
        Tabella_can = new STRUCT[Account_fatt_provv.size()];
      }

      Object[] objs_ins = Account_fatt_provv.toArray();
      Object[] row = new Object[3];

      for (int i=0;i<Account_fatt_provv.size();i++)
      {
      
         DatiCliElem objtar = (DatiCliElem)objs_ins[i];
          if (objtar.getAccount() != null)
              row[0] = objtar.getAccount();
          else
              row[0] = "";
          if (objtar.getDesc() != null)
              row[1] = objtar.getDesc();
          else
              row[1] = "";
          if (objtar.getCodeDocFatt() != null)
              row[2] = objtar.getCodeDocFatt();
          else
              row[2] = "";
          Tabella_can[i] = new STRUCT(sd,conn,row);
      }      
      ARRAY arrayIns = new ARRAY(ad, conn, Tabella_can);
      cs.setArray(1,arrayIns);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.execute();
      
      if (cs.getInt(2)!=DBMessage.OK_RT)
          throw new Exception("DB:"+cs.getInt(2)+":"+cs.getString(3));

     cs.close();
     conn.close();

      }
    catch(Exception lexc_Exception)
      {
  throw new CustomEJBException(lexc_Exception.toString(),  
       "Errore di inserimento nella store procedure "+StaticContext.PACKAGE_SPECIAL+" :"+NOME_STORED,
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
   return;
  }

  public Collection ejbFindAllAccNoVa(String CodTipoContr,String CicloFatt, String DataIniCiclo)  throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_NO_VA(?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.setString(2,CicloFatt);
      cs.setString(3,DataIniCiclo);
      cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_ACCOUNT_CAMBIO_CICLO");
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

       if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6)+"NOME STORED: ACCOUNT_NO_VA");

      // Costruisco l'array che conterr� i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_CAMBIO_CICLO",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
      // Ottengo i dati
      rs=cs.getARRAY(4);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new DatiCliBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setAccount(attr[0].stringValue());
              pk.setDesc(attr[1].stringValue());
              pk.setCodeParam(attr[2].stringValue());
              recs.add(pk);
          }

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(SQLException e)
		{
           StaticMessages.setCustomString(e.toString());
           StaticContext.writeLog(StaticMessages.getMessage(5002,"DatiCliBMPBean","","",StaticContext.APP_SERVER_DRIVER));
           e.printStackTrace();
             throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"DatiCliBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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




  public Collection ejbFindAllAccXVa(String CicloFatt, String DataIniCiclo, String CodTipoContr)  throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_LST_X_VA(?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CicloFatt);
      cs.setString(2,DataIniCiclo);
      cs.setString(3,CodTipoContr);
      cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_ACCOUNT_ABORT");
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();
       if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6)+"NOME STORED: ACCOUNT_LST_X_VA");

      // Costruisco l'array che conterr� i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_ABORT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
      // Ottengo i dati
      rs=cs.getARRAY(4);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new DatiCliBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setAccount(attr[0].stringValue());
              pk.setDesc(attr[1].stringValue());
              pk.setDataIniPerFatt(attr[4].stringValue());
              if (attr[5]!=null)
                pk.setDataFinePerFatt(attr[5].stringValue());
              recs.add(pk);
          }

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(SQLException e)
		{
           StaticMessages.setCustomString(e.toString());
           StaticContext.writeLog(StaticMessages.getMessage(5002,"DatiCliBMPBean","","",StaticContext.APP_SERVER_DRIVER));
           e.printStackTrace();
             throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"DatiCliBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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

    public Collection ejbFindAllAccXVa2(String CicloFatt, String DataIniCiclo, String CodTipoContr, String prov)  throws FinderException, RemoteException
          {
      Vector recs = new Vector();
                  try
                  {
                          conn = getConnection(dsName);
          OracleCallableStatement cs=null;
    //    if ((!prov.equals(null))&&(prov.equals("1")))                          {
     if (prov==null) {
            cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_LST_X_VA(?,?,?,?,?,?)}");
        }
        else{
        cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_LST_X_PREPO(?,?,?,?,?,?)}");}
        // Impostazione types I/O
        cs.setString(1,CicloFatt);
        cs.setString(2,DataIniCiclo);
        cs.setString(3,CodTipoContr);
        cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_ACCOUNT_ABORT");
        cs.registerOutParameter(5,Types.INTEGER);
        cs.registerOutParameter(6,Types.VARCHAR);
        cs.execute();
         if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
              throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6)+"NOME STORED: ACCOUNT_LST_X_VA");

        // Costruisco l'array che conterr� i dati di ritorno della stored
        ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_ABORT",conn);
        ARRAY rs = new ARRAY(ad, conn, null);
        // Ottengo i dati
        rs=cs.getARRAY(4);
        Datum dati[]=rs.getOracleArray();
        // Estrazione dei dati
        for (int i=0;i<dati.length;i++)
            {
                pk = new DatiCliBMPPK();
                STRUCT s=(STRUCT)dati[i];
                Datum attr[]=s.getOracleAttributes();
                pk.setAccount(attr[0].stringValue());
                pk.setDesc(attr[1].stringValue());
                pk.setDataIniPerFatt(attr[4].stringValue());
                if (attr[5]!=null)
                  pk.setDataFinePerFatt(attr[5].stringValue());
                recs.add(pk);
            }

        cs.close();
        // Chiudo la connessione
        conn.close();
      }
      catch(SQLException e)
                  {
             StaticMessages.setCustomString(e.toString());
             StaticContext.writeLog(StaticMessages.getMessage(5002,"DatiCliBMPBean","","",StaticContext.APP_SERVER_DRIVER));
             e.printStackTrace();
               throw new FinderException(e.getMessage());
                  }
      catch(Exception ee)
                  {
         StaticMessages.setCustomString(ee.toString());
         StaticContext.writeLog(StaticMessages.getMessage(5003,"DatiCliBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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

  public Collection ejbFindAllAccXVaCiclo(String CicloFatt, String DataIniCiclo, String CodTipoContr)  throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_VA_ABORT_X_CICLO(?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CicloFatt);
      cs.setString(2,DataIniCiclo);
      cs.setString(3,CodTipoContr);
      cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_ACCOUNT_ABORT");
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();
       if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6)+"NOME STORED: ACCOUNT__VA_ABORT_X_CICLO");

      // Costruisco l'array che conterr� i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_ABORT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
      // Ottengo i dati
      rs=cs.getARRAY(4);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new DatiCliBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setAccount(attr[0].stringValue());
              pk.setDesc(attr[1].stringValue());
              pk.setDataIniPerFatt(attr[4].stringValue());
              pk.setDataFinePerFatt(attr[5].stringValue());
              recs.add(pk);
          }

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(SQLException e)
		{
           StaticMessages.setCustomString(e.toString());
           StaticContext.writeLog(StaticMessages.getMessage(5002,"DatiCliBMPBean","","",StaticContext.APP_SERVER_DRIVER));
           e.printStackTrace();
             throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"DatiCliBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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

    public Collection ejbFindAllAccXVaCiclo2(String CicloFatt, String DataIniCiclo, String CodTipoContr,String prov)  throws FinderException, RemoteException
          {
      Vector recs = new Vector();
                  try
                  {
                          conn = getConnection(dsName);
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_VA_ABORT_X_CICLO(?,?,?,?,?,?)}");
        // Impostazione types I/O
        cs.setString(1,CicloFatt);
        cs.setString(2,DataIniCiclo);
        cs.setString(3,CodTipoContr);
        cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_ACCOUNT_ABORT");
        cs.registerOutParameter(5,Types.INTEGER);
        cs.registerOutParameter(6,Types.VARCHAR);
        cs.execute();
         if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
              throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6)+"NOME STORED: ACCOUNT__VA_ABORT_X_CICLO");

        // Costruisco l'array che conterr� i dati di ritorno della stored
        ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_ABORT",conn);
        ARRAY rs = new ARRAY(ad, conn, null);
        // Ottengo i dati
        rs=cs.getARRAY(4);
        Datum dati[]=rs.getOracleArray();
        // Estrazione dei dati
        for (int i=0;i<dati.length;i++)
            {
                pk = new DatiCliBMPPK();
                STRUCT s=(STRUCT)dati[i];
                Datum attr[]=s.getOracleAttributes();
                pk.setAccount(attr[0].stringValue());
                pk.setDesc(attr[1].stringValue());
                pk.setDataIniPerFatt(attr[4].stringValue());
                pk.setDataFinePerFatt(attr[5].stringValue());
                recs.add(pk);
            }

        cs.close();
        // Chiudo la connessione
        conn.close();
      }
      catch(SQLException e)
                  {
             StaticMessages.setCustomString(e.toString());
             StaticContext.writeLog(StaticMessages.getMessage(5002,"DatiCliBMPBean","","",StaticContext.APP_SERVER_DRIVER));
             e.printStackTrace();
               throw new FinderException(e.getMessage());
                  }
      catch(Exception ee)
                  {
         StaticMessages.setCustomString(ee.toString());
         StaticContext.writeLog(StaticMessages.getMessage(5003,"DatiCliBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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

public DatiCliBMPPK ejbFindPredValAtt(String CodTipoContr) throws FinderException, RemoteException
 {
  DatiCliBMPPK pk = new DatiCliBMPPK();
  Connection conn=null;
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_PREDISPONI_VA(?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.execute();

      cs.close();      
      // Chiudo la connessione
      conn.close();

    }
      catch(Throwable e)
    {
      try
        {
          if (!conn.isClosed())
              conn.close();
        }
      catch (SQLException sqle)
        {
          sqle.printStackTrace();
          throw new RemoteException(sqle.getMessage());
        }
      e.printStackTrace();
       throw new RemoteException(e.getMessage());
    }
   return  pk;
  }

  public Collection ejbFindAllAccXNC(String Code_funz_va, String Code_funz_nc, String CodTipoContr)  throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_VA_CONG(?,?,?,?,?,?)}");
     // Impostazione types I/O
      cs.setString(1,Code_funz_va);
      cs.setString(2,Code_funz_nc);
      cs.setString(3,CodTipoContr);
      cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_ACCOUNT_CONG");
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();
      
      // Costruisco l'array che conterr� i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_CONG",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
      // Ottengo i dati
      rs=cs.getARRAY(4);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new DatiCliBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setAccount(attr[1].stringValue());
              pk.setDesc(attr[2].stringValue());
              
              if (attr[3]!=null)
                pk.setDataFinePerFatt(attr[3].stringValue());
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
    public Collection ejbFindAllAccXNCAbort(String Code_funz_va, String Code_funz_nc)  throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_VALOR_CONG_VER_ABORT(?,?,?,?,?)}");
        // Impostazione types I/O
      cs.setString(1,Code_funz_va);
      cs.setString(2,Code_funz_nc);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_ACCOUNT_CONG");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
       // Costruisco l'array che conterr� i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_CONG",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new DatiCliBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setAccount(attr[1].stringValue());
              pk.setDesc(attr[2].stringValue());
              
              if (attr[3]!=null)
                pk.setDataFinePerFatt(attr[3].stringValue());
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


  public Collection ejbFindAllAccNoteCred(String CodeFunzBatchNC ,String CodTipoContr) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 	try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=null;
      if (CodeFunzBatchNC.equals("24"))
         cs=(OracleCallableStatement)conn.prepareCall("{call "+ StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_NO_CONG_NC_ULL (?,?,?,?,?)}");
      else
      if (CodeFunzBatchNC.equals("22"))
          cs=(OracleCallableStatement)conn.prepareCall("{call "+ StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_NO_CONG_NC_XDSL (?,?,?,?,?)}");          
      else
      {}
       // Impostazione types I/O
      cs.setString(1,CodeFunzBatchNC);
      cs.setString(2,CodTipoContr);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_ACCOUNT");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
      {
        if (CodeFunzBatchNC.equals("24"))
            throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5)+"STORED: ACCOUNT_NO_CONG_NC_ULL");
        else if (CodeFunzBatchNC.equals("22"))
            throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5)+"STORED: ACCOUNT_NO_CONG_NC_XDSL ");
       }
      // Costruisco l'array che conterr� i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new DatiCliBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              if (attr[0]!=null)
                  pk.setAccount(attr[0].stringValue());
              else
                  pk.setAccount(new String(""));
              if (attr[1]!=null)
                  pk.setDesc(attr[1].stringValue());
              else
                  pk.setDesc(new String(""));
             recs.add(pk);
          }

      cs.close();          
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
           StaticMessages.setCustomString(e.toString());
           StaticContext.writeLog(StaticMessages.getMessage(5002,"FattureBMPBean","","",StaticContext.APP_SERVER_DRIVER));
           e.printStackTrace();
             throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"FattureBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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

  public Collection ejbFindAllAccRepricing(String chiamante, String CodeFunzBatchRE ,String CodTipoContr) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 	try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=null;
      if (CodeFunzBatchRE.equals("25"))
      {
         if (chiamante.equalsIgnoreCase("LancioValAttiva2Sp"))
            cs=(OracleCallableStatement)conn.prepareCall("{call "+ StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_VA_NO_CONG_CT_ULL (?,?,?,?,?)}");
         else //chiamante.equalsIgnoreCae("LancioBatchNCSp");
            cs=(OracleCallableStatement)conn.prepareCall("{call "+ StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_NC_NO_CONG_CT_ULL (?,?,?,?,?)}");            
      }         
      /*else
      if (CodeFunzBatchVA.equals("21")) //da implementare in futuro
      {
        if (chiamante.equalsIgnoreCase("LancioValAttiva2Sp"))        
          cs=(OracleCallableStatement)conn.prepareCall("{call "+ StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_VA_NO_CONG_CT_XDSL (?,?,?,?,?)}");          
        else
          cs=(OracleCallableStatement)conn.prepareCall("{call "+ StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_NC_NO_CONG_CT_XDSL (?,?,?,?,?)}");          
      }
      */
      else
      {}
       // Impostazione types I/O
      cs.setString(1,CodeFunzBatchRE);
      cs.setString(2,CodTipoContr);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_ACCOUNT");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
      {
        if (CodeFunzBatchRE.equals("25"))
            throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5)+"STORED: ACCOUNT_VA_NO_CONG_CT_ULL");
/*        else if (CodeFunzBatchRE.equals(""))
            throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5)+"STORED: ACCOUNT_VA_NO_CONG_CT_XDSL ");*/
       }
      // Costruisco l'array che conterr� i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new DatiCliBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              if (attr[0]!=null)
                  pk.setAccount(attr[0].stringValue());
              else
                  pk.setAccount(new String(""));
              if (attr[1]!=null)
                  pk.setDesc(attr[1].stringValue());
              else
                  pk.setDesc(new String(""));
             recs.add(pk);
          }

      cs.close();          
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
           StaticMessages.setCustomString(e.toString());
           StaticContext.writeLog(StaticMessages.getMessage(5002,"FattureBMPBean","","",StaticContext.APP_SERVER_DRIVER));
           e.printStackTrace();
             throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"FattureBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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

 public DatiCliBMPPK ejbFindCodeParamAccount(String code_account) throws FinderException, RemoteException
  {

  DatiCliBMPPK pk = new DatiCliBMPPK();
  Connection conn=null;

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs = null;
     cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_LEGGI_COD_X_ACC(?,?,?,?)}");
       // Impostazione types I/O
      cs.setString(1,code_account);
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      pk.setCodeParam(cs.getString(2));

      cs.close();      
      // Chiudo la connessione
      conn.close();
    }
      catch(Throwable e)
    {
      try
        {
          if (!conn.isClosed())
              conn.close();
        }
      catch (SQLException sqle)
        {
          sqle.printStackTrace();
          throw new RemoteException(sqle.getMessage());
        }
      e.printStackTrace();
       throw new RemoteException(e.getMessage());
    }
   return  pk;
  }

  //public DatiCliBMPPK ejbFindMaxDataFine(String codeFunzBatchNC) throws FinderException, RemoteException //19-01-2004
  public DatiCliBMPPK ejbFindMaxDataFine(String codeFunzBatchNC,String CodTipoContr) throws FinderException, RemoteException//19-01-2004
  {
  DatiCliBMPPK pk = new DatiCliBMPPK();
  Connection conn=null;

  try
    {
      conn = getConnection(dsName);
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".LEGGI_MAX_DATA_FINE_NC(?,?,?,?)}");//19-01-2004
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".LEGGI_MAX_DATA_FINE_NC(?,?,?,?,?)}");//19-01-2004

       // Impostazione types I/O
      cs.setString(1,codeFunzBatchNC);
      cs.setString(2,CodTipoContr); //19-01-2004
      /*cs.registerOutParameter(2,Types.VARCHAR);  //19-01-2004
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);*/
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      /*if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))  //19-01-2004
        throw new EJBException("DB:"+cs.getInt(3)+":"+cs.getString(4));
      pk.setMaxDataFine(cs.getString(2));*/

      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new EJBException("DB:"+cs.getInt(4)+":"+cs.getString(5));
      pk.setMaxDataFine(cs.getString(3));


      cs.close();
      // Chiudo la connessione
      conn.close();

    }

    catch(Exception lexc_Exception)
      {
       throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindMaxDataFine",
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
       "",
       "ejbFindMaxDataFine",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
        }
      }
   return pk;
  }


 public Collection ejbFindRepricSpec(String DataIni, String DataFine, String CodTipoContr,String CodeFunz,String Sys) throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_LST_REPORT_REPR_SP (?,?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,DataIni);
      cs.setString(2,DataFine);
      cs.setString(3,CodTipoContr);
      cs.setString(4,CodeFunz);
      cs.setString(5,Sys);
      cs.registerOutParameter(6,OracleTypes.ARRAY, "ARR_ACCOUNT_CONG");
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);

      cs.execute();


      // Costruisco l'array che conterr� i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_CONG",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(6);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new DatiCliBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              pk.setAccount(attr[1].stringValue());
              pk.setDesc(attr[2].stringValue());
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
  
  
  public Collection ejbFindFattMan(String DataIni, String DataFine, String CodTipoContr,String CodeFunz,String Sys) throws FinderException, RemoteException
   {
     Vector recs = new Vector();

     try
     {
       conn = getConnection(dsName);
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".ACCOUNT_LST_REPORT_MAN (?,?,?,?,?,?,?,?)}");

       // Impostazione types I/O
       cs.setString(1,DataIni);
       cs.setString(2,DataFine);
       cs.setString(3,CodTipoContr);
       cs.setString(4,CodeFunz);
       cs.setString(5,Sys);
       cs.registerOutParameter(6,OracleTypes.ARRAY, "ARR_ACCOUNT_CONG");
       cs.registerOutParameter(7,Types.INTEGER);
       cs.registerOutParameter(8,Types.VARCHAR);

       cs.execute();


       // Costruisco l'array che conterr� i dati di ritorno della stored
       ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_CONG",conn);
       ARRAY rs = new ARRAY(ad, conn, null);

       // Ottengo i dati
       rs=cs.getARRAY(6);
       Datum dati[]=rs.getOracleArray();

       // Estrazione dei dati
       for (int i=0;i<dati.length;i++)
           {
               pk = new DatiCliBMPPK();

               STRUCT s=(STRUCT)dati[i];
               Datum attr[]=s.getOracleAttributes();

               pk.setAccount(attr[1].stringValue());
               pk.setDesc(attr[2].stringValue());
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

  public String getCodeDocFatt()
  {
      pk = (DatiCliBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null;
      else
        return pk.getCodeDocFatt();
  }

  public void setCodeDocFatt(String code)
  {
		pk = (DatiCliBMPPK) ctx.getPrimaryKey();
		pk.setCodeDocFatt (code);
  }
  
  public String getAccount()
  {
      pk = (DatiCliBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null;
      else
        return pk.getAccount();
  }

  public void setAccount(String code)
  {

		pk = (DatiCliBMPPK) ctx.getPrimaryKey();
		pk.setAccount (code);

  }

 public String getDesc()
  {
      pk = (DatiCliBMPPK) ctx.getPrimaryKey();
      return pk.getDesc();

  }

  public void setDesc(String desc)
  {
		pk = (DatiCliBMPPK) ctx.getPrimaryKey();
		pk.setDesc (desc);

  }

  public String getCodeParam()
  {
      pk = (DatiCliBMPPK) ctx.getPrimaryKey();
      return pk.getCodeParam();
  }

  public void setCodeParam(String code)
  {
		pk = (DatiCliBMPPK) ctx.getPrimaryKey();
		pk.setCodeParam (code);
  }


  public String getCodElabBatch()
  {
      pk = (DatiCliBMPPK) ctx.getPrimaryKey();
      return pk.getCodElabBatch();
  }

  public void setCodElabBatch(String codElabBatch)
  {
		pk = (DatiCliBMPPK) ctx.getPrimaryKey();
		pk.setCodElabBatch (codElabBatch);
  }

 public Integer getNumFattLisUn()
  {
      pk = (DatiCliBMPPK) ctx.getPrimaryKey();
      return pk.getNumFattLisUn();

  }

  public void setNumFattLisUn(Integer NumFattLisUn)
  {
		pk = (DatiCliBMPPK) ctx.getPrimaryKey();
		pk.setNumFattLisUn (NumFattLisUn);
  }

  public String getDataFinePerFatt()
  {
      pk = (DatiCliBMPPK) ctx.getPrimaryKey();
      if (pk==null)
         return null;
      else
        return pk.getDataFinePerFatt();
  }

  public void setDataFinePerFatt(String dataF)
  {
		pk = (DatiCliBMPPK) ctx.getPrimaryKey();
		pk.setDataFinePerFatt (dataF);
  }

  public String getDataIniPerFatt()
  {
      pk = (DatiCliBMPPK) ctx.getPrimaryKey();
      return pk.getDataIniPerFatt();
  }

  public void setDataIniPerFatt(String dataI)
  {
		pk = (DatiCliBMPPK) ctx.getPrimaryKey();
		pk.setDataIniPerFatt (dataI);
  }

 public String getMaxDataFine()
  {
      pk = (DatiCliBMPPK) ctx.getPrimaryKey();
       if (pk==null) return null;
      else
         return pk.getMaxDataFine();
  }

  public void setMaxDataFine(String dataF)
  {
		pk = (DatiCliBMPPK) ctx.getPrimaryKey();
		pk.setMaxDataFine (dataF);
  }
}
