package com.ejbBMP.impl;
import java.util.*;
import java.rmi.*;
import java.sql.*;
import javax.ejb.*;
import javax.naming.*;
import oracle.jdbc.*;
import oracle.sql.*;
import com.ejbBMP.ElaborBatchBMPPK;
import com.utl.*;


public class ElaborBatchBMPBean extends AbstractEntityCommonBean implements EntityBean
{
  public EntityContext entityContext;
  private ElaborBatchBMPPK pk;
  private boolean enableStore=false;
  public ElaborBatchBMPPK ejbCreate()
  throws CreateException, RemoteException
  {
    pk= new ElaborBatchBMPPK();
    return pk;
  }

  public void ejbPostCreate()
  {
  }

 public ElaborBatchBMPPK ejbFindByPrimaryKey(ElaborBatchBMPPK primaryKey)
  {
    return primaryKey;
  }
  public ElaborBatchBMPPK ejbFindElabBatchCodeFunz(String codeFunz) throws FinderException, RemoteException
    {
    ElaborBatchBMPPK pk = new ElaborBatchBMPPK();
    //Connection conn=null;
    try
      {
        conn = getConnection(dsName);
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ELAB_BATCH_X_CODE_FUNZ (?,?,?,?)}");

         // Impostazione types I/O
        cs.setString(1,codeFunz);
        cs.registerOutParameter(2,Types.INTEGER);
        cs.registerOutParameter(3,Types.INTEGER);
        cs.registerOutParameter(4,Types.VARCHAR);
        cs.execute();
        pk.setElabUguali(cs.getInt(2));
        
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
    
  public ElaborBatchBMPPK ejbFindManualCodeFunz(String[] account) throws FinderException, RemoteException
    {
    ElaborBatchBMPPK pk = new ElaborBatchBMPPK();
    //Connection conn=null;
    try
      {
        conn = getConnection(dsName);
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CONTROLLO_MANUAL_REPR_SPE (?,?,?,?)}");
        String Accounts="";
        int ritorno=0;
        
        for (int i=0; i<(account.length-1);i++)
        {
          cs.setString(1,account[i+1]);
          cs.registerOutParameter(2,Types.INTEGER);
          cs.registerOutParameter(3,Types.INTEGER);
          cs.registerOutParameter(4,Types.VARCHAR);
          cs.execute();
          ritorno+=cs.getInt(2);
          
        }
        /*Accounts=Accounts.substring(0,(Accounts.length()-1));
         // Impostazione types I/O
        cs.setString(1,Accounts);
        cs.registerOutParameter(2,Types.INTEGER);
        cs.registerOutParameter(3,Types.INTEGER);
        cs.registerOutParameter(4,Types.VARCHAR);
        cs.execute();*/
        pk.setElabUguali(ritorno);
        
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
    
  public ElaborBatchBMPPK ejbFindManualUpdateCodeFunz(String[] account) throws FinderException, RemoteException
  {
  ElaborBatchBMPPK pk = new ElaborBatchBMPPK();
  //Connection conn=null;
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".TARIFFA_MANUALE_ST_AGGIORNA (?,?,?)}");
      String Accounts="";
      
        int ritorno=0;
        
        for (int i=0; i<(account.length-1);i++)
        {
          cs.setString(1,account[i+1]);
          cs.registerOutParameter(2,Types.INTEGER);
          cs.registerOutParameter(3,Types.INTEGER);
          cs.execute();
          ritorno+=cs.getInt(2);
          
        }
        
     // Accounts=Accounts.substring(0,(Accounts.length()-3));
       // Impostazione types I/O
      /*cs.setString(1,Accounts);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.INTEGER);
     // cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();*/
      pk.setElabUguali(ritorno);
      
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

public ElaborBatchBMPPK ejbFindElabBatchXDSL() throws FinderException, RemoteException
  {
  ElaborBatchBMPPK pk = new ElaborBatchBMPPK();
  //Connection conn=null;
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ELAB_BATCH_CONG_IN_EXEC_XDSL (?,?,?)}");

       // Impostazione types I/O

      cs.registerOutParameter(1,Types.INTEGER);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.execute();
      pk.setElabBatch(cs.getInt(1));
      
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
  public ElaborBatchBMPPK ejbFindElabBatchULL() throws FinderException, RemoteException
  {
  ElaborBatchBMPPK pk = new ElaborBatchBMPPK();

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ELAB_BATCH_CONG_IN_EXEC_ULL (?,?,?)}");

       // Impostazione types I/O
      cs.registerOutParameter(1,Types.INTEGER);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.execute();
      pk.setElabBatch(cs.getInt(1));
      
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

  public ElaborBatchBMPPK ejbFindElabBatchCL() throws FinderException, RemoteException
  {
  ElaborBatchBMPPK pk = new ElaborBatchBMPPK();
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ELAB_BATCH_CONG_IN_EXEC_CL (?,?,?)}");

       // Impostazione types I/O
      cs.registerOutParameter(1,Types.INTEGER);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.execute();
      pk.setElabBatch(cs.getInt(1));
      
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
  public ElaborBatchBMPPK ejbFindElabBatchCSV(String CodeFunz) throws FinderException, RemoteException
  {
  ElaborBatchBMPPK pk = new ElaborBatchBMPPK();
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ELAB_BATCH_CSV_IN_EXEC (?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,CodeFunz);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      pk.setElabBatch(cs.getInt(2));
      
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
  public ElaborBatchBMPPK ejbFindElabBatchCSV2(String CodeFunz,String Sys) throws FinderException, RemoteException
  {
  ElaborBatchBMPPK pk = new ElaborBatchBMPPK();
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ELAB_BATCH_CSV_IN_EXEC_2 (?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,CodeFunz);
      cs.setString(2,Sys);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
      pk.setElabBatch(cs.getInt(3));

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

public Collection ejbFindLstVer(String CodeFunz, String CodeTipoContratto) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
    String procedure = "";
 		try
		{
			conn = getConnection(dsName);

      if(CodeFunz.equals("498") || CodeFunz.equals("499"))
        procedure = ".ELAB_BATCH_LST_VER_REPORT (?,?,?,?,?)}";
      else if(CodeFunz.equals("1006") || CodeFunz.equals("27") || CodeFunz.equals("55"))
        procedure = ".ELAB_BATCH_LST_VER_CONG (?,?,?,?,?)}";
      else
        procedure = ".ELAB_BATCH_LST_VER (?,?,?,?,?)}";
        
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ELAB_BATCH_LST_VER (?,?,?,?,?)}");
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + procedure);
      // Impostazione types I/O

      cs.setString(1,CodeFunz);
      cs.setString(2,CodeTipoContratto);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_ELAB_VER");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);

      cs.execute();

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ELAB_VER",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
        
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
      {
        pk = new ElaborBatchBMPPK();
        STRUCT s=(STRUCT)dati[i];
        Datum attr[]=s.getOracleAttributes();

        if(attr[0]!=null)
          pk.setCodeElab(attr[0].stringValue());
        else
          pk.setCodeElab("");

        if(attr[2]!=null)
          pk.setCodeStato(attr[2].stringValue());
        else
          pk.setCodeStato("");

        if (attr[4]!=null) pk.setDataIni(attr[4].stringValue());
        else pk.setDataIni("");
        
        if (attr[5]!=null) pk.setDataFine(attr[5].stringValue());
        else pk.setDataFine("");

        if (attr[3]!=null) 
          pk.setStato(attr[3].stringValue());
        else
          pk.setStato("");
        
        if (attr[6]!=null) 
          pk.setNPS(attr[6].stringValue());
        else
          pk.setNPS("");
          
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

public Collection ejbFindLstVerRepricing(String CodeFunz, String CodeTipoContratto) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 		try
		{
			conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ELAB_BATCH_LST_VER_REPRICING(?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodeFunz);
      cs.setString(2,CodeTipoContratto);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_ELAB_VER");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ELAB_VER",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new ElaborBatchBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setCodeElab(attr[0].stringValue());
              pk.setCodeStato(attr[2].stringValue());
              if (attr[4]!=null) pk.setDataIni(attr[4].stringValue());
              else pk.setDataIni("");
              if (attr[5]!=null) pk.setDataFine(attr[5].stringValue());
              else pk.setDataFine("");
              pk.setStato(attr[3].stringValue());
              pk.setNPS(attr[6].stringValue());
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
  
public ElaborBatchBMPPK ejbFindElabBatchUguali(int flagContratto) throws FinderException, RemoteException
  {


  ElaborBatchBMPPK pk = new ElaborBatchBMPPK();

  //Connection conn=null;

  try
    {

      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_VER_ELAB_IN_CORSO (?,?,?,?)}");

       // Impostazione types I/O
      cs.setInt(1,flagContratto);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      pk.setElabUguali(cs.getInt(2));

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
  public ElaborBatchBMPPK ejbFindElabBatchCtrlEV(String CodeFunzBatch) throws FinderException, RemoteException
  {
   ElaborBatchBMPPK pk = new ElaborBatchBMPPK();
  //Connection conn=null;
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ELAB_BATCH_CTRL_EXEC_VA (?,?,?,?)}");
       // Impostazione types I/O
      cs.setString(1,CodeFunzBatch);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      pk.setElabBatch(cs.getInt(2));

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


  public ElaborBatchBMPPK ejbFindElabBatchEsistNC(String CodeFunzBatch,String CodeAccount) throws FinderException, RemoteException
  {
   ElaborBatchBMPPK pk = new ElaborBatchBMPPK();
  //Connection conn=null;
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ELAB_BATCH_VER_ESIST_NC (?,?,?,?,?)}");
       // Impostazione types I/O
      cs.setString(1,CodeFunzBatch);
       cs.setString(2,CodeAccount);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
      pk.setElabBatch(cs.getInt(3));

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


public ElaborBatchBMPPK ejbFindElabBatchInCorso() throws FinderException, RemoteException
	{

    Vector recs = new Vector();
 	try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ELAB_BATCH_COLOC_IN_CORSO(?,?,?)}");
      cs.registerOutParameter(1,Types.INTEGER);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(2)!=DBMessage.OK_RT)&&(cs.getInt(2)!=DBMessage.NOT_FOUND_RT))
      {
            throw new Exception("DB:"+cs.getInt(2)+":"+cs.getString(3)+"NOME STORED: ELAB_BATCH_COLOC_IN_CORSO");
      }

      pk = new ElaborBatchBMPPK();
      pk.setElabBatch(cs.getInt(1));

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
      StaticMessages.setCustomString(e.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5002,"ElaborBatchBMPBean","","",StaticContext.APP_SERVER_DRIVER));
      e.printStackTrace();
      throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
      StaticMessages.setCustomString(ee.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5003,"ElaborBatch","","",StaticContext.APP_SERVER_DRIVER));
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

    return pk;
}

  public int getElabBatch()
  {
      pk = (ElaborBatchBMPPK) ctx.getPrimaryKey();
      return pk.getElabBatch();

  }

  public void setElabBatch(int elabBatch)
  {
		pk = (ElaborBatchBMPPK) ctx.getPrimaryKey();
		pk.setElabBatch (elabBatch);
  }

   public String getCodeElab()
  {
      pk = (ElaborBatchBMPPK) ctx.getPrimaryKey();
      return pk.getCodeElab();

  }

  public void setCodeElab(String elabBatch)
  {
// //System.out.println("bean set codeelab"+elabBatch);
		pk = (ElaborBatchBMPPK) ctx.getPrimaryKey();
		pk.setCodeElab (elabBatch);

  }

   public String getStato()
  {
      pk = (ElaborBatchBMPPK) ctx.getPrimaryKey();
      return pk.getStato();

  }

  public void setStato(String stato)
  {
		pk = (ElaborBatchBMPPK) ctx.getPrimaryKey();
		pk.setStato (stato);

  }
    public String getDataIni()
  {
      pk = (ElaborBatchBMPPK) ctx.getPrimaryKey();
      return pk.getDataIni();

  }

  public void setDataIni(String dataIni)
  {
		pk = (ElaborBatchBMPPK) ctx.getPrimaryKey();
		pk.setDataIni (dataIni);

  }
     public String getDataFine()
  {
      pk = (ElaborBatchBMPPK) ctx.getPrimaryKey();
      return pk.getDataFine();

  }

//verificare problema verifica valorizz Attiva dopo il lancio (se data è null)
   /*public String getDataFine()
  {
      pk = (ElaborBatchBMPPK) ctx.getPrimaryKey();
      if (pk==null) 
        return null;
      else
        return pk.getDataFine();
  }*/

  public void setDataFine(String dataFine)
  {
		pk = (ElaborBatchBMPPK) ctx.getPrimaryKey();
		pk.setDataFine (dataFine);

  }
      public String getNPS()
  {
      pk = (ElaborBatchBMPPK) ctx.getPrimaryKey();
      return pk.getNPS();

  }

  public void setNPS(String NPS)
  {
		pk = (ElaborBatchBMPPK) ctx.getPrimaryKey();
		pk.setNPS (NPS);

  }
  public String getCodeStato()
  {
      pk = (ElaborBatchBMPPK) ctx.getPrimaryKey();
      return pk.getCodeStato();

  }

  public void setCodeStato(String codeStato)
  {
		pk = (ElaborBatchBMPPK) ctx.getPrimaryKey();
		pk.setCodeStato(codeStato);

  }
     public int getElabUguali()
  {
      pk = (ElaborBatchBMPPK) ctx.getPrimaryKey();
      return pk.getElabUguali();

  }

  public void setElabUguali(int elabUguali)
  {
		pk = (ElaborBatchBMPPK) ctx.getPrimaryKey();
		pk.setElabUguali (elabUguali);
  }


  /* verifica se è in corso una valorizzazione su stesso batch e stesso code_tipo_contr */
  public ElaborBatchBMPPK ejbFindElabBatchCodeTipoContrUguali(String CodeTipoContr) throws FinderException, RemoteException
  {
    ElaborBatchBMPPK pk = new ElaborBatchBMPPK();
    try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACC_VER_ELAB_CONTR_IN_CORSO (?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,CodeTipoContr);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      pk.setElabUguali(cs.getInt(2));

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



  
}
