package com.ejbBMP.impl;
import java.util.*;
import java.rmi.*;
import java.sql.*;
import java.lang.*;
import java.text.*;
import javax.ejb.*;
import javax.naming.*;
import oracle.jdbc.*;
import oracle.sql.*;
import com.utl.*;
import java.util.Collection;
import com.ejbBMP.TariffaBMPPK;
import com.ejbBMP.TariffaBMP;

import java.util.regex.Pattern;

public class TariffaBMPBean extends AbstractEntityCommonBean implements EntityBean
{
  public EntityContext entityContext;
  private TariffaBMPPK pk;
  private boolean enableStore=false;
  private int errore;

  public TariffaBMPPK ejbCreate(String codContr, String contrDest, String codUt, String codOf, String codPs, String codTipoCaus, Integer flgCommit) throws CreateException, RemoteException
  {
     String nomeStored = ""; //stringa in cui caricare il nome della stored per la gestione delle eccezioni
     try
     {
      conn = getConnection(dsName);
      OracleCallableStatement cs;
      if (codContr.equals("0"))
      {
          nomeStored = "TARIFFA_RIB_DA_UNICO";
          cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".TARIFFA_RIB_DA_UNICO(?,?,?,?,?,?)}");
      }
      else
      {
          nomeStored = "TARIFFA_RIB_DA_PERS";
          cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".TARIFFA_RIB_DA_PERS(?,?,?,?,?,?)}");
      }
      // Impostazione types I/O
      cs.setString(1,contrDest);
      cs.setString(2,codUt);
      cs.setString(3,codOf);
      cs.setString(4,codPs);
      cs.setString(5,codTipoCaus);
      cs.setInt(6,flgCommit.intValue());
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(7)+":"+cs.getString(8));

      pk=new TariffaBMPPK (codContr, contrDest, codUt, codOf, codPs, codTipoCaus, flgCommit);
      
      cs.close();
      // Chiudo la connessione
      conn.close();
     }
     catch(Exception lexc_Exception)
      {
       throw new CustomEJBException(lexc_Exception.toString(),
       "Errore di inserimento nella store procedure " + nomeStored,
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

  public void ejbPostCreate(String codContr, String contrDest, String codUt, String codOf, String codPs, String codTipoCaus, Integer flgCommit)
  {
  }

  public TariffaBMPPK ejbCreate(String codTar, String progTar, String codUM, String codUt, String dataIniValAssOfPs, String codOf, String dataIniValOf, String codPs, String dataIniTar, String dataFineTar, String descTar, Double impTar, String flgMat, String codClSc, String prClSc, String causFatt,String codTipoOpz) throws CreateException, RemoteException
  {
     try
     {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".TARIFFA_INSERISCI(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,codTar);
      cs.setString(2,progTar);
      cs.setString(3,codUM);
      cs.setString(4,codUt);
      cs.setString(5,dataIniValAssOfPs);
      cs.setString(6,codOf);
      cs.setString(7,dataIniValOf);
      cs.setString(8,codPs);
      cs.setString(9,dataIniTar);
      cs.setString(10,dataFineTar);
      cs.setString(11,descTar);
      cs.setDouble(12,impTar.doubleValue());
      cs.setString(13,flgMat);
      cs.setString(14,codClSc);
      cs.setString(15,prClSc);
      cs.setString(16,causFatt);
      cs.setString(17,codTipoOpz);
      cs.registerOutParameter(18,Types.INTEGER);
      cs.registerOutParameter(19,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(18)!=DBMessage.OK_RT))
      {
        throw new Exception("DB:"+cs.getInt(18)+":"+cs.getString(19)+"NOME STORED: TARIFFA_INSERISCI");
      }

      pk=new TariffaBMPPK(codTar, progTar, codUM, codUt, dataIniValAssOfPs, codOf, dataIniValOf, codPs, dataIniTar, dataFineTar, descTar, impTar, flgMat, codClSc, prClSc, causFatt, codTipoOpz,0);

      cs.close();
      // Chiudo la connessione
      conn.close();
      }
    catch(Exception lexc_Exception)
      {
    throw new CustomEJBException(lexc_Exception.toString(),
       "Errore di inserimento nella store procedure PKG_BILL_SPE.TARIFFA_INSERISCI",
       "ejbCreate Classic",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
      }
    finally
      {
        try
        {
          conn.close();
        } 
        catch(Exception lexc_Exception)
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


  public void ejbPostCreate(String codTar, String progTar, String codUM, String codUt, String dataIniValAssOfPs, String codOf, String dataIniValOf, String codPs, String dataIniTar, String dataFineTar, String descTar, Double impTar, String flgMat, String codClSc, String prClSc, String causFatt,String tipoOpz)
  {
  }

  //METODO PER IL CARICAMENTO DELLA LISTA DELLE TARIFFE
  public Collection ejbFindAll(String CodPs, String CodOf, String CausBill, String CodTipoOpz) throws FinderException, RemoteException
	{
  if (CausBill=="")
      CausBill=null;

  if (CodTipoOpz=="")
      CodTipoOpz=null;
      
    Vector recs = new Vector();
 	 try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".TARIFFA_LST_RECENTI(?,?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodPs);
      cs.setString(2,CodOf);
      cs.setString(3,CausBill);
      cs.setString(4,CodTipoOpz);
      cs.registerOutParameter(5,OracleTypes.ARRAY, "ARR_TARIFFE_DETT");
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(6)!=DBMessage.OK_RT)&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
      {
            throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7)+"NOME STORED: TARIFFA_LST_RECENTI");
      }
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_TARIFFE_DETT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(5);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new TariffaBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              if (attr[0]!=null)
                 pk.setImpMinSps(new Double(attr[0].doubleValue()));
              else
                  pk.setImpMinSps(new Double(0));
              if (attr[1]!=null)
                  pk.setImpMaxSps(new Double(attr[1].doubleValue()));
              else
                  pk.setImpMaxSps(new Double(0));
              if (attr[2]!=null)
                  pk.setImpTar(new Double(attr[2].doubleValue()));
              else
                  pk.setImpTar(new Double(0));

              pk.setCodTar(attr[3].stringValue());
              pk.setProgTar(attr[4].stringValue());
              pk.setFlgMat(attr[5].stringValue());

              if (attr[6]!=null)
                pk.setDataIniTar(attr[6].stringValue());
              else
                pk.setDataIniTar("");

              if (attr[7]!=null)
                pk.setDataFineTar(attr[7].stringValue());
              else
                pk.setDataFineTar("");

                if (attr[8]!=null)
                pk.setDataCreazTar(attr[8].stringValue());
              else
                pk.setDataCreazTar("");

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
			}
      catch(Exception e)
			{

       StaticMessages.setCustomString(e.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5002,"","","",StaticContext.APP_SERVER_DRIVER));
        e.printStackTrace();
        throw new RemoteException(e.getMessage());
			}
		}
      System.out.println("11");
    return recs;
}
  //fine METODO PER IL CARICAMENTO DELLA LISTA DELLE TARIFFE

  //METODO PER IL CARICAMENTO DEI LISTINI
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

    public Collection ejbFindListiniClus(String codTipoContr) throws FinderException, RemoteException
          {
      Vector recs = new Vector();
          try
                  {
                          conn = getConnection(dsName);
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".CONTR_LST_LISTINI_CLUS(?,?,?,?)}");

        // Impostazione types I/O
        cs.setString(1,codTipoContr);
        cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_CONTRATTO_CLUS");
        cs.registerOutParameter(3,Types.INTEGER);
        cs.registerOutParameter(4,Types.VARCHAR);
        cs.execute();
        if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
              throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"STORED: CONTR_LST_LISTINI");

        // Costruisco l'array che conterrà i dati di ritorno della stored
        ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CONTRATTO_CLUS",conn);
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
                
                String codeCluster = (attr[2] == null ? "": attr[2].stringValue());
                String tipoCluster = (attr[3] == null ? "": attr[3].stringValue());
                
                if (attr[0]!=null)
                    pk.setCodContr(attr[0].stringValue() + "||" + codeCluster + "||" + tipoCluster + "||" + codTipoContr);
                else
                    pk.setCodContr(new String("") + "||" + codeCluster + "||" + tipoCluster + "||" + codTipoContr);
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

  //METODO PER IL CARICAMENTO DEL LISTINO PERSONALE
  public Collection ejbFindTariffaListinoPers(String codContr, String codTipoContr, String Storico) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 	 try
		{
		conn = getConnection(dsName);
    OracleCallableStatement cs;
    if (Storico.equals("0"))
        cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_LISTINO_PERS_ULT(?,?,?,?,?)}");
    else
        cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_LISTINO_PERS_STOR(?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,codContr);
      cs.setString(2,codTipoContr);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_LISTINO");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT))//&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
         if (Storico.equals("0"))
            throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5)+"NOME STORED: TARIFFA_LISTINO_PERS_ULT");
         else
            throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5)+"NOME STORED: TARIFFA_LISTINO_PERS_STOR");
         

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_LISTINO",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new TariffaBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              if (attr[0]!=null)
                  pk.setImpTar(new Double(attr[0].doubleValue()));
              else
                  pk.setImpTar(new Double(0));
              if (attr[1]!=null)
                  pk.setDataCreazTar(attr[1].stringValue());
              else
                  pk.setDataCreazTar(new String(""));
              if (attr[2]!=null)
                  pk.setProgTar(attr[2].stringValue());
              else
                  pk.setProgTar(new String(""));
              if (attr[3]!=null)
                 pk.setImpMinSps(new Double(attr[3].doubleValue()));
              else
                  pk.setImpMinSps(new Double(0));
              if (attr[4]!=null)
                  pk.setImpMaxSps(new Double(attr[4].doubleValue()));
              else
                  pk.setImpMaxSps(new Double(0));
              if (attr[5]!=null)
                  pk.setCodTar(attr[5].stringValue());
              else
                  pk.setCodTar(new String(""));
              if (attr[6]!=null)
                  pk.setFlgMat(attr[6].stringValue());
              else
                  pk.setFlgMat(new String(""));
              if (attr[7]!=null)
                  pk.setCodClSc(attr[7].stringValue());
              else
                  pk.setCodClSc(new String(""));
              if (attr[8]!=null)
                  pk.setPrClSc(attr[8].stringValue());
              else
                  pk.setPrClSc(new String(""));
              if (attr[9]!=null)
                  pk.setCodUM(attr[9].stringValue());
              else
                  pk.setCodUM(new String(""));
              if (attr[10]!=null)
                  pk.setDescUM(attr[10].stringValue());
              else
                  pk.setDescUM(new String(""));
              if (attr[11]!=null)
                  pk.setCodOf(attr[11].stringValue());
              else
                  pk.setCodOf(new String(""));
              if (attr[12]!=null)
                  pk.setDescOf(attr[12].stringValue());
              else
                  pk.setDescOf(new String(""));
              if (attr[13]!=null)
                  pk.setCodPs(attr[13].stringValue());
              else
                  pk.setCodPs(new String(""));
              if (attr[14]!=null)
                  pk.setDescEsP(attr[14].stringValue());
              else
                  pk.setDescEsP(new String(""));
              if (attr[15]!=null)
                  pk.setDescTipoCaus(attr[15].stringValue());
              else
                  pk.setDescTipoCaus(new String(""));
              if (attr[16]!=null)
                  pk.setDataIniTar(attr[16].stringValue());
              else
                  pk.setDataIniTar(new String(""));
              if (attr[17]!=null)
                  pk.setDataFineTar(attr[17].stringValue());
              else
                  pk.setDataFineTar(new String(""));
              if (attr[18]!=null)
                  pk.setDescTar(attr[18].stringValue());
              else
                  pk.setDescTar(new String(""));
              if (attr[19]!=null)
                  pk.setCodTipoCaus(attr[19].stringValue());
              else
                  pk.setCodTipoCaus(new String(""));
              //140203-INIIZO    
              if (attr[20]!=null)
                  pk.setCodTipoOpz(attr[20].stringValue());
              else
                  pk.setCodTipoOpz(new String(""));
              if (attr[21]!=null)
                  pk.setDescTipoOpz(attr[21].stringValue());
              else
                  pk.setDescTipoOpz(new String(""));
             //140203-FINE    

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

    public Collection ejbFindTariffaListinoPersClus(String codeTipoContr, String codeContr, String Storico) throws FinderException, RemoteException
          {
      Vector recs = new Vector();
           try
                  {
                  conn = getConnection(dsName);
      OracleCallableStatement cs;
      if (Storico.equals("0"))
          cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_LISTINO_PERS_ULT_CLU(?,?,?,?,?,?,?)}");
      else
          cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_LISTINO_PERS_STOR_CLU(?,?,?,?,?,?,?)}");

          String[] loc_data = codeContr.split(Pattern.quote( "||" ) );
          String locCodeContratto = loc_data[0];
          String codeCluster = loc_data[1];
          String tipoCluster = loc_data[2];
          

        // Impostazione types I/O
        cs.setString(1,codeTipoContr);
        cs.setString(2,locCodeContratto);
          cs.setString(3,codeCluster);
          cs.setString(4,tipoCluster);
        cs.registerOutParameter(5,OracleTypes.ARRAY, "ARR_LISTINO");
        cs.registerOutParameter(6,Types.INTEGER);
        cs.registerOutParameter(7,Types.VARCHAR);
        cs.execute();

        if ((cs.getInt(6)!=DBMessage.OK_RT))//&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
           if (Storico.equals("0"))
              throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7)+"NOME STORED: TARIFFA_LISTINO_PERS_ULT");
           else
              throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7)+"NOME STORED: TARIFFA_LISTINO_PERS_STOR");
           

        // Costruisco l'array che conterrà i dati di ritorno della stored
        ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_LISTINO",conn);
        ARRAY rs = new ARRAY(ad, conn, null);

        // Ottengo i dati
        rs=cs.getARRAY(5);
        Datum dati[]=rs.getOracleArray();

        // Estrazione dei dati
        for (int i=0;i<dati.length;i++)
            {
                pk = new TariffaBMPPK();

                STRUCT s=(STRUCT)dati[i];
                Datum attr[]=s.getOracleAttributes();

                if (attr[0]!=null)
                    pk.setImpTar(new Double(attr[0].doubleValue()));
                else
                    pk.setImpTar(new Double(0));
                if (attr[1]!=null)
                    pk.setDataCreazTar(attr[1].stringValue());
                else
                    pk.setDataCreazTar(new String(""));
                if (attr[2]!=null)
                    pk.setProgTar(attr[2].stringValue());
                else
                    pk.setProgTar(new String(""));
                if (attr[3]!=null)
                   pk.setImpMinSps(new Double(attr[3].doubleValue()));
                else
                    pk.setImpMinSps(new Double(0));
                if (attr[4]!=null)
                    pk.setImpMaxSps(new Double(attr[4].doubleValue()));
                else
                    pk.setImpMaxSps(new Double(0));
                if (attr[5]!=null)
                    pk.setCodTar(attr[5].stringValue());
                else
                    pk.setCodTar(new String(""));
                if (attr[6]!=null)
                    pk.setFlgMat(attr[6].stringValue());
                else
                    pk.setFlgMat(new String(""));
                if (attr[7]!=null)
                    pk.setCodClSc(attr[7].stringValue());
                else
                    pk.setCodClSc(new String(""));
                if (attr[8]!=null)
                    pk.setPrClSc(attr[8].stringValue());
                else
                    pk.setPrClSc(new String(""));
                if (attr[9]!=null)
                    pk.setCodUM(attr[9].stringValue());
                else
                    pk.setCodUM(new String(""));
                if (attr[10]!=null)
                    pk.setDescUM(attr[10].stringValue());
                else
                    pk.setDescUM(new String(""));
                if (attr[11]!=null)
                    pk.setCodOf(attr[11].stringValue());
                else
                    pk.setCodOf(new String(""));
                if (attr[12]!=null)
                    pk.setDescOf(attr[12].stringValue());
                else
                    pk.setDescOf(new String(""));
                if (attr[13]!=null)
                    pk.setCodPs(attr[13].stringValue());
                else
                    pk.setCodPs(new String(""));
                if (attr[14]!=null)
                    pk.setDescEsP(attr[14].stringValue());
                else
                    pk.setDescEsP(new String(""));
                if (attr[15]!=null)
                    pk.setDescTipoCaus(attr[15].stringValue());
                else
                    pk.setDescTipoCaus(new String(""));
                if (attr[16]!=null)
                    pk.setDataIniTar(attr[16].stringValue());
                else
                    pk.setDataIniTar(new String(""));
                if (attr[17]!=null)
                    pk.setDataFineTar(attr[17].stringValue());
                else
                    pk.setDataFineTar(new String(""));
                if (attr[18]!=null)
                    pk.setDescTar(attr[18].stringValue());
                else
                    pk.setDescTar(new String(""));
                if (attr[19]!=null)
                    pk.setCodTipoCaus(attr[19].stringValue());
                else
                    pk.setCodTipoCaus(new String(""));
                //140203-INIIZO    
                if (attr[20]!=null)
                    pk.setCodTipoOpz(attr[20].stringValue());
                else
                    pk.setCodTipoOpz(new String(""));
                if (attr[21]!=null)
                    pk.setDescTipoOpz(attr[21].stringValue());
                else
                    pk.setDescTipoOpz(new String(""));
               //140203-FINE    

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


  //METODO PER IL CARICAMENTO DEL LISTINO UNICO
  public Collection ejbFindTariffaListinoUnico(String codTipoContr, String Storico) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 	  try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs;
      if (Storico.equals("0"))
          cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_LISTINO_UNICO_ULT(?,?,?,?)}");
      else
          cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_LISTINO_UNICO_STOR(?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,codTipoContr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_LISTINO");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();


      if ((cs.getInt(3)!=DBMessage.OK_RT))//&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
           if (Storico.equals("0"))
              throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: TARIFFA_LISTINO_UNICO_ULT");
           else   
              throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: TARIFFA_LISTINO_UNICO_STOR");
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_LISTINO",conn);
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
                  pk.setImpTar(new Double(attr[0].doubleValue()));
              else
                  pk.setImpTar(new Double(0));
              if (attr[1]!=null)
                  pk.setDataCreazTar(attr[1].stringValue());
              else
                  pk.setDataCreazTar("");
              if (attr[2]!=null)
                  pk.setProgTar(attr[2].stringValue());
              else
                  pk.setProgTar("");
              if (attr[3]!=null)
                 pk.setImpMinSps(new Double(attr[3].doubleValue()));
              else
                  pk.setImpMinSps(new Double(0));
              if (attr[4]!=null)
                  pk.setImpMaxSps(new Double(attr[4].doubleValue()));
              else
                  pk.setImpMaxSps(new Double(0));
              if (attr[5]!=null)
                  pk.setCodTar(attr[5].stringValue());
              else
                  pk.setCodTar(new String(""));
              if (attr[6]!=null)
                  pk.setFlgMat(attr[6].stringValue());
              else
                  pk.setFlgMat(new String(""));
              if (attr[7]!=null)
                  pk.setCodClSc(attr[7].stringValue());
              else
                  pk.setCodClSc(new String(""));
              if (attr[8]!=null)
                  pk.setPrClSc(attr[8].stringValue());
              else
                  pk.setPrClSc(new String(""));
              if (attr[9]!=null)
                  pk.setCodUM(attr[9].stringValue());
              else
                  pk.setCodUM(new String(""));
              if (attr[10]!=null)
                  pk.setDescUM(attr[10].stringValue());
              else
                  pk.setDescUM(new String(""));
              if (attr[11]!=null)
                  pk.setCodOf(attr[11].stringValue());
              else
                  pk.setCodOf(new String(""));
              if (attr[12]!=null)
                  pk.setDescOf(attr[12].stringValue());
              else
                  pk.setDescOf(new String(""));
              if (attr[13]!=null)
                  pk.setCodPs(attr[13].stringValue());
              else
                  pk.setCodPs(new String(""));
              if (attr[14]!=null)
                  pk.setDescEsP(attr[14].stringValue());
              else
                  pk.setDescEsP(new String(""));
              if (attr[15]!=null)
                  pk.setDescTipoCaus(attr[15].stringValue());
              else
                  pk.setDescTipoCaus(new String(""));
              if (attr[16]!=null)
                  pk.setDataIniTar(attr[16].stringValue());
              else
                  pk.setDataIniTar(new String(""));
              if (attr[17]!=null)
                  pk.setDataFineTar(attr[17].stringValue());
              else
                  pk.setDataFineTar(new String(""));
              if (attr[18]!=null)
                  pk.setDescTar(attr[18].stringValue());
              else
                  pk.setDescTar(new String(""));
              if (attr[19]!=null)
                  pk.setCodTipoCaus(attr[19].stringValue());
              else
                  pk.setCodTipoCaus(new String(""));
              //140203-INIIZO    
              if (attr[20]!=null)
                  pk.setCodTipoOpz(attr[20].stringValue());
              else
                  pk.setCodTipoOpz(new String(""));
              if (attr[21]!=null)
                  pk.setDescTipoOpz(attr[21].stringValue());
              else
                  pk.setDescTipoOpz(new String(""));
             //140203-FINE    
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

  //METODO PER IL CARICAMENTO DEI LISTINI DI DESTINAZIONE
  public Collection ejbFindListDest(String codTipoContr) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 	 try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".CONTR_LST_SENZA_LIS_PERS(?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,codTipoContr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_CONTRATTO");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

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
             throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(1001,"Controller","","",StaticContext.APP_SERVER_DRIVER));
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


    public Collection ejbFindListDestClus(String codTipoContr) throws FinderException, RemoteException
          {
      Vector recs = new Vector();
           try
                  {
                          conn = getConnection(dsName);
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".CONTR_LST_SENZA_LIS_PERS_CLU(?,?,?,?)}");

        // Impostazione types I/O
        cs.setString(1,codTipoContr);
        cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_CONTRATTO_CLUS");
        cs.registerOutParameter(3,Types.INTEGER);
        cs.registerOutParameter(4,Types.VARCHAR);
        cs.execute();

        if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
              throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

        // Costruisco l'array che conterrà i dati di ritorno della stored
        ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CONTRATTO_CLUS",conn);
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
                    pk.setCodContr(attr[0].stringValue()+ "||"+attr[2].stringValue()+"||"+attr[3].stringValue()+"||"+attr[4].stringValue());
                else
                    pk.setCodContr(new String("")+ "||"+attr[2].stringValue()+"||"+attr[3].stringValue()+"||"+attr[4].stringValue());
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
               throw new FinderException(e.getMessage());
                  }
      catch(Exception ee)
                  {
         StaticMessages.setCustomString(ee.toString());
         StaticContext.writeLog(StaticMessages.getMessage(1001,"Controller","","",StaticContext.APP_SERVER_DRIVER));
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

    
    public Collection ejbFindProdottiClus(String codTipoContr) throws FinderException, RemoteException
          {
      Vector recs = new Vector();
           try
                  {
                          conn = getConnection(dsName);
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".LST_PRODOTTI_CLUSTER(?,?,?,?)}");

        // Impostazione types I/O
        cs.setString(1,codTipoContr);
        cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_CONTRATTO_CLUS");
        cs.registerOutParameter(3,Types.INTEGER);
        cs.registerOutParameter(4,Types.VARCHAR);
        cs.execute();

        if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
              throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

        // Costruisco l'array che conterrà i dati di ritorno della stored
        ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CONTRATTO_CLUS",conn);
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
               throw new FinderException(e.getMessage());
                  }
      catch(Exception ee)
                  {
         StaticMessages.setCustomString(ee.toString());
         StaticContext.writeLog(StaticMessages.getMessage(1001,"Controller","","",StaticContext.APP_SERVER_DRIVER));
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

  //METODO PER IL CARICAMENTO DELLE TARIFFE TARIFFA_UNICO_X_RIB
  public Collection ejbFindTariffaUnicoXRib(String codTipoContr) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 	 try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_UNICO_X_RIB(?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,codTipoContr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_LISTINO");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_LISTINO",conn);
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
                  pk.setImpTar(new Double(attr[0].doubleValue()));
              else
                  pk.setImpTar(new Double(0));
              if (attr[1]!=null)
                  pk.setDataCreazTar(attr[1].stringValue());
              else
                  pk.setDataCreazTar("");
              if (attr[2]!=null)
                  pk.setProgTar(attr[2].stringValue());
              else
                  pk.setProgTar("");
              if (attr[3]!=null)
                 pk.setImpMinSps(new Double(attr[3].doubleValue()));
              else
                  pk.setImpMinSps(new Double(0));
              if (attr[4]!=null)
                  pk.setImpMaxSps(new Double(attr[4].doubleValue()));
              else
                  pk.setImpMaxSps(new Double(0));
              if (attr[5]!=null)
                  pk.setCodTar(attr[5].stringValue());
              else
                  pk.setCodTar(new String(""));
              if (attr[6]!=null)
                  pk.setFlgMat(attr[6].stringValue());
              else
                  pk.setFlgMat(new String(""));
              if (attr[7]!=null)
                  pk.setCodClSc(attr[7].stringValue());
              else
                  pk.setCodClSc(new String(""));
              if (attr[8]!=null)
                  pk.setPrClSc(attr[8].stringValue());
              else
                  pk.setPrClSc(new String(""));
              if (attr[9]!=null)
                  pk.setCodUM(attr[9].stringValue());
              else
                  pk.setCodUM(new String(""));
              if (attr[10]!=null)
                  pk.setDescUM(attr[10].stringValue());
              else
                  pk.setDescUM(new String(""));
              if (attr[11]!=null)
                  pk.setCodOf(attr[11].stringValue());
              else
                  pk.setCodOf(new String(""));
              if (attr[12]!=null)
                  pk.setDescOf(attr[12].stringValue());
              else
                  pk.setDescOf(new String(""));
              if (attr[13]!=null)
                  pk.setCodPs(attr[13].stringValue());
              else
                  pk.setCodPs(new String(""));
              if (attr[14]!=null)
                  pk.setDescEsP(attr[14].stringValue());
              else
                  pk.setDescEsP(new String(""));
              if (attr[15]!=null)
                  pk.setDescTipoCaus(attr[15].stringValue());
              else
                  pk.setDescTipoCaus(new String(""));
              if (attr[16]!=null)
                  pk.setDataIniTar(attr[16].stringValue());
              else
                  pk.setDataIniTar(new String(""));
              if (attr[17]!=null)
                  pk.setDataFineTar(attr[17].stringValue());
              else
                  pk.setDataFineTar(new String(""));
              if (attr[18]!=null)
                  pk.setDescTar(attr[18].stringValue());
              else
                  pk.setDescTar(new String(""));
              if (attr[19]!=null)
                  pk.setCodTipoCaus(attr[19].stringValue());
              else
                  pk.setCodTipoCaus(new String(""));
                  //13-02-03 VITI
             if (attr[20]!=null)
                  pk.setCodTipoOpz(attr[20].stringValue());
              else
                  pk.setCodTipoOpz(new String(""));
              if (attr[21]!=null)
                  pk.setDescTipoOpz(attr[21].stringValue());
              else
                  pk.setDescTipoOpz(new String(""));
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

       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(1001,"Controller","","",StaticContext.APP_SERVER_DRIVER));
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

//METODO PER IL CARICAMENTO DELLE TARIFFE TARIFFA_PERS_X_RIB
public Collection ejbFindTariffaPersXRib(String codTipoContr, String codContr) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 	try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_PERS_X_RIB(?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,codTipoContr);
      cs.setString(2,codContr);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_LISTINO");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_LISTINO",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new TariffaBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              if (attr[0]!=null)
                  pk.setImpTar(new Double(attr[0].doubleValue()));
              else
                  pk.setImpTar(new Double(0));
              if (attr[1]!=null)
                  pk.setDataCreazTar(attr[1].stringValue());
              else
                  pk.setDataCreazTar("");
              if (attr[2]!=null)
                  pk.setProgTar(attr[2].stringValue());
              else
                  pk.setProgTar("");
              if (attr[3]!=null)
                 pk.setImpMinSps(new Double(attr[3].doubleValue()));
              else
                  pk.setImpMinSps(new Double(0));
              if (attr[4]!=null)
                  pk.setImpMaxSps(new Double(attr[4].doubleValue()));
              else
                  pk.setImpMaxSps(new Double(0));
              if (attr[5]!=null)
                  pk.setCodTar(attr[5].stringValue());
              else
                  pk.setCodTar(new String(""));
              if (attr[6]!=null)
                  pk.setFlgMat(attr[6].stringValue());
              else
                  pk.setFlgMat(new String(""));
              if (attr[7]!=null)
                  pk.setCodClSc(attr[7].stringValue());
              else
                  pk.setCodClSc(new String(""));
              if (attr[8]!=null)
                  pk.setPrClSc(attr[8].stringValue());
              else
                  pk.setPrClSc(new String(""));
              if (attr[9]!=null)
                  pk.setCodUM(attr[9].stringValue());
              else
                  pk.setCodUM(new String(""));
              if (attr[10]!=null)
                  pk.setDescUM(attr[10].stringValue());
              else
                  pk.setDescUM(new String(""));
              if (attr[11]!=null)
                  pk.setCodOf(attr[11].stringValue());
              else
                  pk.setCodOf(new String(""));
              if (attr[12]!=null)
                  pk.setDescOf(attr[12].stringValue());
              else
                  pk.setDescOf(new String(""));
              if (attr[13]!=null)
                  pk.setCodPs(attr[13].stringValue());
              else
                  pk.setCodPs(new String(""));
              if (attr[14]!=null)
                  pk.setDescEsP(attr[14].stringValue());
              else
                  pk.setDescEsP(new String(""));
              if (attr[15]!=null)
                  pk.setDescTipoCaus(attr[15].stringValue());
              else
                  pk.setDescTipoCaus(new String(""));
              if (attr[16]!=null)
                  pk.setDataIniTar(attr[16].stringValue());
              else
                  pk.setDataIniTar(new String(""));
              if (attr[17]!=null)
                  pk.setDataFineTar(attr[17].stringValue());
              else
                  pk.setDataFineTar(new String(""));
              if (attr[18]!=null)
                  pk.setDescTar(attr[18].stringValue());
              else
                  pk.setDescTar(new String(""));
              if (attr[19]!=null)
                  pk.setCodTipoCaus(attr[19].stringValue());
              else
                  pk.setCodTipoCaus(new String(""));
                  //13-02-03 VITI
             if (attr[20]!=null)
                  pk.setCodTipoOpz(attr[20].stringValue());
              else
                  pk.setCodTipoOpz(new String(""));
              if (attr[21]!=null)
                  pk.setDescTipoOpz(attr[21].stringValue());
              else
                  pk.setDescTipoOpz(new String(""));
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

       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(1001,"Controller","","",StaticContext.APP_SERVER_DRIVER));
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
 public TariffeSpecial ejbHomeAddTariffaSpecialNew(
           String i_code_utente,
           String i_code_ogg_fatrz,
           String i_data_inizio_tariffa_s,
           String i_desc_tariffa,
           String i_impt_tariffa_s,
           String i_tipo_flag_modal_appl_tariffa,
           String i_code_ps,
           String i_code_unita_di_misura,
           String i_flag_repricing,
           String i_code_tipo_caus,
           String i_code_contr,
           String i_desc_listino_applicato
           ) throws FinderException, RemoteException
  {
  TariffeSpecial ritorno = null;
  OracleCallableStatement cs;
  try
      {
      conn = getConnection(dsName);
      //cs=(OracleCallableStatement)conn.prepareCall("{call INSERT_TARIFFA(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
       cs=(OracleCallableStatement)conn.prepareCall("{call INSERT_TARIFFA(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");    
      // Impostazione types I/O
      cs.setString(1,i_code_utente);
      cs.setString(2,i_code_ogg_fatrz);
      cs.setString(3,i_data_inizio_tariffa_s);
      cs.setString(4,i_desc_tariffa);
      cs.setString(5,i_impt_tariffa_s);
      cs.setString(6,i_tipo_flag_modal_appl_tariffa);
      cs.setString(7,i_code_ps);
      cs.setString(8,i_code_unita_di_misura);
      cs.setString(9,i_flag_repricing);
      cs.setString(10,i_code_tipo_caus);
      cs.setString(11,i_code_contr);
      cs.setString(12,i_desc_listino_applicato);
      cs.setString(13,"");
      /*cs.registerOutParameter(12,Types.VARCHAR);
      cs.registerOutParameter(13,Types.VARCHAR);
      cs.registerOutParameter(14,Types.INTEGER);
      cs.registerOutParameter(15,Types.VARCHAR);*/
      
       cs.registerOutParameter(14,Types.VARCHAR);
       cs.registerOutParameter(15,Types.VARCHAR);
       cs.registerOutParameter(16,Types.INTEGER);
       cs.registerOutParameter(17,Types.VARCHAR);
       
      cs.execute();
      
      ritorno = new TariffeSpecial();
      
     /* System.out.println("Ritorno INSERT_TARIFFA code["+cs.getInt(14)+"]");
      System.out.println("Ritorno INSERT_TARIFFA message["+cs.getString(15)+"]");*/
      System.out.println("Ritorno INSERT_TARIFFA code["+cs.getInt(16)+"]");
      System.out.println("Ritorno INSERT_TARIFFA message["+cs.getString(17)+"]");
      
      //if (cs.getInt(14)!=DBMessage.OK_RT)
       if (cs.getInt(16)!=DBMessage.OK_RT)
      {
        ritorno.setFLAG_SYS("ERRORE");
        //throw new Exception(cs.getString(15));
         throw new Exception(cs.getString(17));
      }else{
      /*ritorno.setCODE_TARIFFA(cs.getString(12));
        ritorno.setCODE_PR_TARIFFA(cs.getString(13));*/
        ritorno.setCODE_TARIFFA(cs.getString(14));
        ritorno.setCODE_PR_TARIFFA(cs.getString(15));
        ritorno.setCODE_CONTR(i_code_contr);
      }

      cs.close();
      // Chiudo la connessione
      conn.close();
      
      }
    catch(Exception lexc_Exception)
    {
      System.out.println("lexc_Exception - ["+lexc_Exception.getMessage()+"]");
      try{
        conn.rollback();
      }
      catch(Exception e)
      {
        System.out.println("lexc_Exception - Exception ["+e.getMessage()+"]");
      }
      throw new FinderException(lexc_Exception.getMessage());
    }
    finally
    {
      try
      {
        if(conn != null)
          conn.close();
      } catch(Exception lexc_Exception)
      {
        throw new FinderException(lexc_Exception.getMessage());
      }
    }
   return ritorno;
  }
    
public TariffeSpecial ejbHomeAddTariffaSpecialNewClus(
              String i_code_utente,
              String i_code_ogg_fatrz,
              String i_data_inizio_tariffa_s,
              String i_desc_tariffa,
              String i_impt_tariffa_s,
              String i_tipo_flag_modal_appl_tariffa,
              String i_code_ps,
              String i_code_unita_di_misura,
              String i_flag_repricing,
              String i_code_tipo_caus,
              String i_code_contr,
              String i_desc_listino_applicato,
              String i_code_cluster,
              String i_tipo_cluster,
              String i_code_tipo_contr
              ) throws FinderException, RemoteException
     {
     TariffeSpecial ritorno = null;
     OracleCallableStatement cs;
     try
         {
         conn = getConnection(dsName);
         //cs=(OracleCallableStatement)conn.prepareCall("{call INSERT_TARIFFA(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
          cs=(OracleCallableStatement)conn.prepareCall("{call INSERT_TARIFFA_CLUS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");    
         // Impostazione types I/O
         cs.setString(1,i_code_utente);
         cs.setString(2,i_code_ogg_fatrz);
         cs.setString(3,i_data_inizio_tariffa_s);
         cs.setString(4,i_desc_tariffa);
         cs.setString(5,i_impt_tariffa_s);
         cs.setString(6,i_tipo_flag_modal_appl_tariffa);
         cs.setString(7,i_code_ps);
         cs.setString(8,i_code_unita_di_misura);
         cs.setString(9,i_flag_repricing);
         cs.setString(10,i_code_tipo_caus);
         cs.setString(11,i_code_contr);
         cs.setString(12,i_desc_listino_applicato);
         cs.setString(13,"");
             cs.setString(14,i_code_cluster);
             cs.setString(15,i_tipo_cluster);
             cs.setString(16,i_code_tipo_contr);
         
         
         /*cs.registerOutParameter(12,Types.VARCHAR);
         cs.registerOutParameter(13,Types.VARCHAR);
         cs.registerOutParameter(14,Types.INTEGER);
         cs.registerOutParameter(15,Types.VARCHAR);*/
         
          cs.registerOutParameter(17,Types.VARCHAR);
          cs.registerOutParameter(18,Types.VARCHAR);
          cs.registerOutParameter(19,Types.INTEGER);
          cs.registerOutParameter(20,Types.VARCHAR);
          
         cs.execute();
         
         ritorno = new TariffeSpecial();
         
        /* System.out.println("Ritorno INSERT_TARIFFA code["+cs.getInt(14)+"]");
         System.out.println("Ritorno INSERT_TARIFFA message["+cs.getString(15)+"]");*/
         System.out.println("Ritorno INSERT_TARIFFA code["+cs.getInt(19)+"]");
         System.out.println("Ritorno INSERT_TARIFFA message["+cs.getString(20)+"]");
         
         //if (cs.getInt(14)!=DBMessage.OK_RT)
          if (cs.getInt(19)!=DBMessage.OK_RT)
         {
           ritorno.setFLAG_SYS("ERRORE");
           //throw new Exception(cs.getString(15));
            throw new Exception(cs.getString(20));
         }else{
         /*ritorno.setCODE_TARIFFA(cs.getString(12));
           ritorno.setCODE_PR_TARIFFA(cs.getString(13));*/
           ritorno.setCODE_TARIFFA(cs.getString(17));
           ritorno.setCODE_PR_TARIFFA(cs.getString(18));
           ritorno.setCODE_CONTR(i_code_contr);
         }

         cs.close();
         // Chiudo la connessione
         conn.close();
         
         }
       catch(Exception lexc_Exception)
       {
         System.out.println("lexc_Exception - ["+lexc_Exception.getMessage()+"]");
         try{
           conn.rollback();
         }
         catch(Exception e)
         {
           System.out.println("lexc_Exception - Exception ["+e.getMessage()+"]");
         }
         throw new FinderException(lexc_Exception.getMessage());
       }
       finally
       {
         try
         {
           if(conn != null)
             conn.close();
         } catch(Exception lexc_Exception)
         {
           throw new FinderException(lexc_Exception.getMessage());
         }
       }
      return ritorno;
     }
  
  
  
  public int ejbHomeAddPromozioneTariffaSpecialNew(
            String i_code_promozione,            
            String i_code_contr,
            String i_code_tariffa,
            String i_code_pr_tariffa,
            String i_flag_attiva,
            String i_strDataDa,
            String i_strDataA,
            String i_strDataDaCan,
            String i_strDataACan,
            String i_strNumMesi,
            String i_strCodiceProgBill
            ) throws FinderException, RemoteException
   {
   int ret = 0;
   try
       {
       conn = getConnection(dsName);
       conn.setAutoCommit(false);
       OracleCallableStatement cs;
       cs=(OracleCallableStatement)conn.prepareCall("{call INSERT_ASS_PROMO_TARIFFA(?,?,?,?,?,?,?,?,?,?,?,?,?)}");

     
       // Impostazione types I/O
       cs.setString(1,i_code_tariffa);
       cs.setString(2,i_code_pr_tariffa);
       cs.setString(3,i_code_contr);
       cs.setString(4,i_code_promozione);
       cs.setString(5,i_strDataDa);
       cs.setString(6,i_strDataA);
       cs.setString(7,i_strDataDaCan);
       cs.setString(8,i_strDataACan);
       cs.setString(9,i_strNumMesi);
       cs.setString(10,i_strCodiceProgBill);
       cs.setString(11,i_flag_attiva);
       cs.registerOutParameter(12,Types.INTEGER);
       cs.registerOutParameter(13,Types.VARCHAR);
       
       cs.execute();
       
       System.out.println("ritorno number ["+cs.getInt(12)+"]");
       System.out.println("ritorno string ["+cs.getString(13)+"]");
       if (cs.getInt(12)!=DBMessage.OK_RT)
       {
         ret = 1;
         cs.close();
         throw new Exception(cs.getString(13));
       }
       //conn.commit();
       cs.close();
       // Chiudo la connessione
       conn.close();
       ret = 0;
       
       }
     catch(Exception lexc_Exception)
     {
       ret = 1;
       System.out.println("ejbHomeAddPromozioneTariffaSpecialNew - lexc_Exception - ["+lexc_Exception.getMessage()+"]");
       try{
         conn.rollback();
       }
       catch(Exception e)
       {
         System.out.println("ejbHomeAddPromozioneTariffaSpecialNew - lexc_Exception - Exception ["+e.getMessage()+"]");
       }
       throw new FinderException(lexc_Exception.getMessage());
     }
     finally
       {
         try
         {
           conn.close();
         } catch(Exception lexc_Exception)
         {
           throw new FinderException(lexc_Exception.getMessage());
         }
       }
    return ret;
   }

    public int ejbHomeAddPromozioneTariffaSpecialNewClu(
              String i_code_promozione,            
              String i_code_contr,
              String i_code_tariffa,
              String i_code_pr_tariffa,
              String i_flag_attiva,
              String i_strDataDa,
              String i_strDataA,
              String i_strDataDaCan,
              String i_strDataACan,
              String i_strNumMesi,
              String i_strCodiceProgBill,
              String i_code_cluster,
              String i_tipo_cluster,
              String i_code_tipo_contr
              ) throws FinderException, RemoteException
     {
     int ret = 0;
     try
         {
         conn = getConnection(dsName);
         conn.setAutoCommit(false);
         OracleCallableStatement cs;
         cs=(OracleCallableStatement)conn.prepareCall("{call INSERT_ASS_PROMO_TARIFFA_CLU(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

       
         // Impostazione types I/O
         cs.setString(1,i_code_tariffa);
         cs.setString(2,i_code_pr_tariffa);
         cs.setString(3,i_code_contr);
         cs.setString(4,i_code_promozione);
         cs.setString(5,i_strDataDa);
         cs.setString(6,i_strDataA);
         cs.setString(7,i_strDataDaCan);
         cs.setString(8,i_strDataACan);
         cs.setString(9,i_strNumMesi);
         cs.setString(10,i_strCodiceProgBill);
         cs.setString(11,i_flag_attiva);
             cs.setString(12,i_code_cluster);
             cs.setString(13,i_tipo_cluster);
             cs.setString(14,i_code_tipo_contr);
         cs.registerOutParameter(15,Types.INTEGER);
         cs.registerOutParameter(16,Types.VARCHAR);
         
         cs.execute();
         
         System.out.println("ritorno number ["+cs.getInt(15)+"]");
         System.out.println("ritorno string ["+cs.getString(16)+"]");
         if (cs.getInt(15)!=DBMessage.OK_RT)
         {
           ret = 1;
           cs.close();
           throw new Exception(cs.getString(16));
         }
         //conn.commit();
         cs.close();
         // Chiudo la connessione
         conn.close();
         ret = 0;
         
         }
       catch(Exception lexc_Exception)
       {
         ret = 1;
         System.out.println("ejbHomeAddPromozioneTariffaSpecialNew - lexc_Exception - ["+lexc_Exception.getMessage()+"]");
         try{
           conn.rollback();
         }
         catch(Exception e)
         {
           System.out.println("ejbHomeAddPromozioneTariffaSpecialNew - lexc_Exception - Exception ["+e.getMessage()+"]");
         }
         throw new FinderException(lexc_Exception.getMessage());
       }
       finally
         {
           try
           {
             conn.close();
           } catch(Exception lexc_Exception)
           {
             throw new FinderException(lexc_Exception.getMessage());
           }
         }
      return ret;
     }
  
  public void ejbHomeAddTariffaRibDaPers(String codContr, String contrDest, String codUt, Collection TarIns) throws FinderException, RemoteException
  {
  STRUCT Tabella_ins[] = null;
  try
      {
      conn = getConnection(dsName);
      OracleCallableStatement cs;
      cs=(OracleCallableStatement)conn.prepareCall("{call " +StaticContext.PACKAGE_SPECIAL +".TARIFFA_RIB_DA_PERS(?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,codContr);
      cs.setString(2,contrDest);
      cs.setString(3,codUt);
      cs.registerOutParameter(4,OracleTypes.STRUCT, "DATI_CHIAVE_RIBTYPE");
      StructDescriptor sd=StructDescriptor.createDescriptor("DATI_CHIAVE_RIBTYPE",conn);
      cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_DATI_CHIAVE_RIB");
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_DATI_CHIAVE_RIB",conn);

      if (TarIns.size() > 0)
      {
        Tabella_ins = new STRUCT[TarIns.size()];
      }

      Object[] objs_ins = TarIns.toArray();
      Object[] row = new Object[4]; //Object[3]; 030224
      for (int i=0;i<TarIns.size();i++)
      {
          TariffeInsElem objtar = (TariffeInsElem)objs_ins[i];

          if (objtar.getCodOf() != null)
              row[0] = objtar.getCodOf();
          else
              row[0] = "";
          if (objtar.getCodPs() != null)
              row[1] = objtar.getCodPs();
          else
              row[1] = "";
          if (objtar.getCodTipoCaus() != null)
              row[2] = objtar.getCodTipoCaus();
          else
              row[2] = "";
          //030224-inizio    
          if (objtar.getCodTipoOpz() != null)
              row[3] = objtar.getCodTipoOpz();
          else
              row[3] = "";
          //030224-fine    
              
          Tabella_ins[i] = new STRUCT(sd,conn,row);
      }
      ARRAY arrayIns = new ARRAY(ad, conn, Tabella_ins);
      cs.setArray(4,arrayIns);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();
      if (cs.getInt(5)!=DBMessage.OK_RT)
      {
        
         throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6));
      }
      
      cs.close();
      // Chiudo la connessione
      conn.close();

      }
    catch(Exception lexc_Exception)
      {
     
      
  throw new CustomEJBException(lexc_Exception.toString(),
       "Errore di inserimento nella store procedure PKG_BILL_SPE.TARIFFA_RIB_DA_PERS",
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


    public void ejbHomeAddTariffaRibDaPersClus(String codContr, String contrDest, String codUt, String codeCluster, String tipoCluster, String codeTipoContr, Collection TarIns) throws FinderException, RemoteException
    {
    STRUCT Tabella_ins[] = null;
    try
        {
        conn = getConnection(dsName);
        OracleCallableStatement cs;
        cs=(OracleCallableStatement)conn.prepareCall("{call " +StaticContext.PACKAGE_SPECIAL +".TARIFFA_RIB_DA_PERS_CLU(?,?,?,?,?,?,?,?,?)}");

        // Impostazione types I/O
        cs.setString(1,codContr);
        cs.setString(2,contrDest);
        cs.setString(3,codUt);
            cs.setString(4,codeCluster);
            cs.setString(5,tipoCluster);
            cs.setString(6,codeTipoContr);
        cs.registerOutParameter(7,OracleTypes.STRUCT, "DATI_CHIAVE_RIBTYPE");
        StructDescriptor sd=StructDescriptor.createDescriptor("DATI_CHIAVE_RIBTYPE",conn);
        cs.registerOutParameter(7,OracleTypes.ARRAY, "ARR_DATI_CHIAVE_RIB");
        ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_DATI_CHIAVE_RIB",conn);

        if (TarIns.size() > 0)
        {
          Tabella_ins = new STRUCT[TarIns.size()];
        }

        Object[] objs_ins = TarIns.toArray();
        Object[] row = new Object[4]; //Object[3]; 030224
        for (int i=0;i<TarIns.size();i++)
        {
            TariffeInsElem objtar = (TariffeInsElem)objs_ins[i];

            if (objtar.getCodOf() != null)
                row[0] = objtar.getCodOf();
            else
                row[0] = "";
            if (objtar.getCodPs() != null)
                row[1] = objtar.getCodPs();
            else
                row[1] = "";
            if (objtar.getCodTipoCaus() != null)
                row[2] = objtar.getCodTipoCaus();
            else
                row[2] = "";
            //030224-inizio    
            if (objtar.getCodTipoOpz() != null)
                row[3] = objtar.getCodTipoOpz();
            else
                row[3] = "";
            //030224-fine    
                
            Tabella_ins[i] = new STRUCT(sd,conn,row);
        }
        ARRAY arrayIns = new ARRAY(ad, conn, Tabella_ins);
        cs.setArray(7,arrayIns);
        cs.registerOutParameter(8,Types.INTEGER);
        cs.registerOutParameter(9,Types.VARCHAR);
        cs.execute();
        if (cs.getInt(8)!=DBMessage.OK_RT)
        {
          
           throw new Exception("DB:"+cs.getInt(8)+":"+cs.getString(9));
        }
        
        cs.close();
        // Chiudo la connessione
        conn.close();

        }
      catch(Exception lexc_Exception)
        {
       
        
    throw new CustomEJBException(lexc_Exception.toString(),
         "Errore di inserimento nella store procedure PKG_BILL_SPE.TARIFFA_RIB_DA_PERS",
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

    public void ejbHomeAddTariffaRibDaPersClusClus(String codContr, String contrDest, String codUt, String codeClusterSource, String codeClusterDest, String tipoClusterSource, String tipoClusterDest, String codeTipoContr, Collection TarIns) throws FinderException, RemoteException
    {
    STRUCT Tabella_ins[] = null;
    try
        {
        conn = getConnection(dsName);
        OracleCallableStatement cs;
        cs=(OracleCallableStatement)conn.prepareCall("{call " +StaticContext.PACKAGE_SPECIAL +".TARIFFA_RIB_DA_PERS_CLU_CLU(?,?,?,?,?,?,?,?,?,?,?)}");

        // Impostazione types I/O
        cs.setString(1,codContr);
        cs.setString(2,contrDest);
        cs.setString(3,codUt);
            cs.setString(4,codeClusterSource);
            cs.setString(5,tipoClusterSource);
            cs.setString(6,codeClusterDest);
            cs.setString(7,tipoClusterDest);
            cs.setString(8,codeTipoContr);
        cs.registerOutParameter(9,OracleTypes.STRUCT, "DATI_CHIAVE_RIBTYPE");
        StructDescriptor sd=StructDescriptor.createDescriptor("DATI_CHIAVE_RIBTYPE",conn);
        cs.registerOutParameter(9,OracleTypes.ARRAY, "ARR_DATI_CHIAVE_RIB");
        ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_DATI_CHIAVE_RIB",conn);

        if (TarIns.size() > 0)
        {
          Tabella_ins = new STRUCT[TarIns.size()];
        }

        Object[] objs_ins = TarIns.toArray();
        Object[] row = new Object[4]; //Object[3]; 030224
        for (int i=0;i<TarIns.size();i++)
        {
            TariffeInsElem objtar = (TariffeInsElem)objs_ins[i];

            if (objtar.getCodOf() != null)
                row[0] = objtar.getCodOf();
            else
                row[0] = "";
            if (objtar.getCodPs() != null)
                row[1] = objtar.getCodPs();
            else
                row[1] = "";
            if (objtar.getCodTipoCaus() != null)
                row[2] = objtar.getCodTipoCaus();
            else
                row[2] = "";
            //030224-inizio    
            if (objtar.getCodTipoOpz() != null)
                row[3] = objtar.getCodTipoOpz();
            else
                row[3] = "";
            //030224-fine    
                
            Tabella_ins[i] = new STRUCT(sd,conn,row);
        }
        ARRAY arrayIns = new ARRAY(ad, conn, Tabella_ins);
        cs.setArray(9,arrayIns);
        cs.registerOutParameter(10,Types.INTEGER);
        cs.registerOutParameter(11,Types.VARCHAR);
        cs.execute();
        if (cs.getInt(10)!=DBMessage.OK_RT)
        {
          
           throw new Exception("DB:"+cs.getInt(10)+":"+cs.getString(11));
        }
        
        cs.close();
        // Chiudo la connessione
        conn.close();

        }
      catch(Exception lexc_Exception)
        {
       
        
    throw new CustomEJBException(lexc_Exception.toString(),
         "Errore di inserimento nella store procedure PKG_BILL_SPE.TARIFFA_RIB_DA_PERS",
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

    public void ejbHomeAddTariffaRibDaPersClusContr(String codContr, String contrDest, String codUt, String codeClusterSource, String tipoClusterSource, String codeTipoContr, Collection TarIns) throws FinderException, RemoteException
    {
    STRUCT Tabella_ins[] = null;
    try
        {
        conn = getConnection(dsName);
        OracleCallableStatement cs;
        cs=(OracleCallableStatement)conn.prepareCall("{call " +StaticContext.PACKAGE_SPECIAL +".TARIFFA_RIB_DA_PERS_CLU_CON(?,?,?,?,?,?,?,?,?)}");

        // Impostazione types I/O
        cs.setString(1,codContr);
        cs.setString(2,contrDest);
        cs.setString(3,codUt);
            cs.setString(4,codeClusterSource);
            cs.setString(5,tipoClusterSource);
            cs.setString(6,codeTipoContr);
        cs.registerOutParameter(7,OracleTypes.STRUCT, "DATI_CHIAVE_RIBTYPE");
        StructDescriptor sd=StructDescriptor.createDescriptor("DATI_CHIAVE_RIBTYPE",conn);
        cs.registerOutParameter(7,OracleTypes.ARRAY, "ARR_DATI_CHIAVE_RIB");
        ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_DATI_CHIAVE_RIB",conn);

        if (TarIns.size() > 0)
        {
          Tabella_ins = new STRUCT[TarIns.size()];
        }

        Object[] objs_ins = TarIns.toArray();
        Object[] row = new Object[4]; //Object[3]; 030224
        for (int i=0;i<TarIns.size();i++)
        {
            TariffeInsElem objtar = (TariffeInsElem)objs_ins[i];

            if (objtar.getCodOf() != null)
                row[0] = objtar.getCodOf();
            else
                row[0] = "";
            if (objtar.getCodPs() != null)
                row[1] = objtar.getCodPs();
            else
                row[1] = "";
            if (objtar.getCodTipoCaus() != null)
                row[2] = objtar.getCodTipoCaus();
            else
                row[2] = "";
            //030224-inizio    
            if (objtar.getCodTipoOpz() != null)
                row[3] = objtar.getCodTipoOpz();
            else
                row[3] = "";
            //030224-fine    
                
            Tabella_ins[i] = new STRUCT(sd,conn,row);
        }
        ARRAY arrayIns = new ARRAY(ad, conn, Tabella_ins);
        cs.setArray(7,arrayIns);
        cs.registerOutParameter(8,Types.INTEGER);
        cs.registerOutParameter(9,Types.VARCHAR);
        cs.execute();
        if (cs.getInt(8)!=DBMessage.OK_RT)
        {
          
           throw new Exception("DB:"+cs.getInt(8)+":"+cs.getString(9));
        }
        
        cs.close();
        // Chiudo la connessione
        conn.close();

        }
      catch(Exception lexc_Exception)
        {
       
        
    throw new CustomEJBException(lexc_Exception.toString(),
         "Errore di inserimento nella store procedure PKG_BILL_SPE.TARIFFA_RIB_DA_PERS",
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


  public void ejbHomeAddTariffaRibDaUnico(String contrDest, String codUt, Collection TarIns) throws FinderException, RemoteException
  {
  STRUCT Tabella_ins[] = null;
  try
      {
      conn = getConnection(dsName);
      OracleCallableStatement cs;
      cs=(OracleCallableStatement)conn.prepareCall("{call " +StaticContext.PACKAGE_SPECIAL +".TARIFFA_RIB_DA_UNICO(?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,contrDest);
      cs.setString(2,codUt);
      cs.registerOutParameter(3,OracleTypes.STRUCT, "DATI_CHIAVE_RIBTYPE");
      StructDescriptor sd=StructDescriptor.createDescriptor("DATI_CHIAVE_RIBTYPE",conn);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_DATI_CHIAVE_RIB");
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_DATI_CHIAVE_RIB",conn);

      if (TarIns.size() > 0)
      {
        Tabella_ins = new STRUCT[TarIns.size()];
      }

      Object[] objs_ins = TarIns.toArray();
      Object[] row = new Object[4]; //Object[3]; 030224


      for (int i=0;i<TarIns.size();i++)
      {
          TariffeInsElem objtar=(TariffeInsElem)objs_ins[i];
          if (objtar.getCodOf() != null)
              row[0] = objtar.getCodOf();
          else
              row[0] = "";
          if (objtar.getCodPs() != null)
              row[1] = objtar.getCodPs();
          else
              row[1] = "";
          if (objtar.getCodTipoCaus() != null)
              row[2] = objtar.getCodTipoCaus();
          else
              row[2] = "";
          //030224-inizio    
          if (objtar.getCodTipoOpz() != null)
              row[3] = objtar.getCodTipoOpz();
          else
              row[3] = "";
          //030224-fine    
          Tabella_ins[i] = new STRUCT(sd,conn,row);
      }
      ARRAY arrayIns = new ARRAY(ad, conn, Tabella_ins);
      cs.setArray(3,arrayIns);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      if (cs.getInt(4)!=DBMessage.OK_RT)
          throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));

      cs.close();
      // Chiudo la connessione
      conn.close();

      }
    catch(Exception lexc_Exception)
      {
  throw new CustomEJBException(lexc_Exception.toString(),
       "Errore di inserimento nella store procedure PKG_BILL_SPE.TARIFFA_RIB_DA_UNICO",
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

    public void ejbHomeAddTariffaRibDaUnicoCluster(String contrDest, String codUt, String codeCluster, String tipoCluster, String codeTipoContr, Collection TarIns) throws FinderException, RemoteException
    {
    STRUCT Tabella_ins[] = null;
    try
        {
        conn = getConnection(dsName);
        OracleCallableStatement cs;
        cs=(OracleCallableStatement)conn.prepareCall("{call " +StaticContext.PACKAGE_SPECIAL +".TARIFFA_RIB_DA_UNICO_CLU(?,?,?,?,?,?,?,?)}");

        // Impostazione types I/O
        cs.setString(1,contrDest);
        cs.setString(2,codUt);
            cs.setString(3,codeCluster);
            cs.setString(4,tipoCluster);
            cs.setString(5,codeTipoContr);
        cs.registerOutParameter(6,OracleTypes.STRUCT, "DATI_CHIAVE_RIBTYPE");
        StructDescriptor sd=StructDescriptor.createDescriptor("DATI_CHIAVE_RIBTYPE",conn);
        cs.registerOutParameter(6,OracleTypes.ARRAY, "ARR_DATI_CHIAVE_RIB");
        ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_DATI_CHIAVE_RIB",conn);

        if (TarIns.size() > 0)
        {
          Tabella_ins = new STRUCT[TarIns.size()];
        }

        Object[] objs_ins = TarIns.toArray();
        Object[] row = new Object[4]; //Object[3]; 030224


        for (int i=0;i<TarIns.size();i++)
        {
            TariffeInsElem objtar=(TariffeInsElem)objs_ins[i];
            if (objtar.getCodOf() != null)
                row[0] = objtar.getCodOf();
            else
                row[0] = "";
            if (objtar.getCodPs() != null)
                row[1] = objtar.getCodPs();
            else
                row[1] = "";
            if (objtar.getCodTipoCaus() != null)
                row[2] = objtar.getCodTipoCaus();
            else
                row[2] = "";
            //030224-inizio    
            if (objtar.getCodTipoOpz() != null)
                row[3] = objtar.getCodTipoOpz();
            else
                row[3] = "";
            //030224-fine    
            Tabella_ins[i] = new STRUCT(sd,conn,row);
        }
        ARRAY arrayIns = new ARRAY(ad, conn, Tabella_ins);
        cs.setArray(6,arrayIns);
        cs.registerOutParameter(7,Types.INTEGER);
        cs.registerOutParameter(8,Types.VARCHAR);
        cs.execute();

        if (cs.getInt(7)!=DBMessage.OK_RT)
            throw new Exception("DB:"+cs.getInt(7)+":"+cs.getString(8));

        cs.close();
        // Chiudo la connessione
        conn.close();

        }
      catch(Exception lexc_Exception)
        {
    throw new CustomEJBException(lexc_Exception.toString(),
         "Errore di inserimento nella store procedure PKG_BILL_SPE.TARIFFA_RIB_DA_UNICO",
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


  public TariffaBMPPK ejbFindByPrimaryKey(TariffaBMPPK primaryKey) throws FinderException, RemoteException
  {
   Connection conn=null;
   pk = new TariffaBMPPK();
   try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_DETTAGLIO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
  
       // Impostazione types I/O
      cs.setString(1,primaryKey.getCodTar());
      cs.setString(2,primaryKey.getProgTar());
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.registerOutParameter(8,Types.VARCHAR);
      cs.registerOutParameter(9,Types.VARCHAR);
      cs.registerOutParameter(10,Types.VARCHAR);
      cs.registerOutParameter(11,Types.VARCHAR);
      cs.registerOutParameter(12,Types.VARCHAR);
      cs.registerOutParameter(13,Types.VARCHAR);
      cs.registerOutParameter(14,Types.VARCHAR);
      cs.registerOutParameter(15,Types.VARCHAR);
      cs.registerOutParameter(16,Types.DOUBLE);
      cs.registerOutParameter(17,Types.VARCHAR);
      cs.registerOutParameter(18,Types.VARCHAR);
      cs.registerOutParameter(19,Types.VARCHAR);
      cs.registerOutParameter(20,Types.VARCHAR);
      cs.registerOutParameter(21,Types.INTEGER);
      cs.registerOutParameter(22,Types.VARCHAR);
      cs.execute();

      //030219  
      if ((cs.getInt(21)!=DBMessage.OK_RT))//&&(cs.getInt(21)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(21)+":"+cs.getString(22)+"NOME STORED: TARIFFA_DETTAGLIO");

      pk.setCodTar(primaryKey.getCodTar());
      pk.setProgTar(primaryKey.getProgTar());
      
      pk.setCodUM(cs.getString(3));
      pk.setDataIniValAssOfPs(cs.getString(4));
      pk.setCodOf(cs.getString(5));
      pk.setDataIniValOf(cs.getString(6));
      pk.setCodPs(cs.getString(7));
      pk.setFlgMat(cs.getString(8));
      pk.setCodTipoCaus(cs.getString(9));
      pk.setCodClSc(cs.getString(10));
      pk.setPrClSc(cs.getString(11));
      pk.setCodTipoOf(cs.getString(12));
      pk.setDataIniTar(cs.getString(13));
      pk.setDataFineTar(cs.getString(14));
      pk.setDescTar(cs.getString(15));
      pk.setImpTar(new Double (cs.getDouble(16)));
      pk.setCausFatt(cs.getString(17));
      pk.setFlgProvv(cs.getString(18));
      pk.setCodTipoOpz(cs.getString(19));
      pk.setDescTipoOpz(cs.getString(20));

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(SQLException e)    //030219-INIZIO
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
        StaticMessages.setCustomString(e.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5002,"","","",StaticContext.APP_SERVER_DRIVER));
        e.printStackTrace();
        throw new RemoteException(e.getMessage());
			}
		}
   return pk;
    /*catch(Exception lexc_Exception)
      {
     throw new CustomEJBException(lexc_Exception.toString(),
       "Errore di inserimento nella store procedure PKG_BILL_SPE.TARIFFA_DETTAGLIO",
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
      } 030219-FINE*/
}
public Collection ejbFindTariffa(String CodePs, String CodOf, String CausBill) throws FinderException, RemoteException
{
Vector recs = new Vector();
 	try
		{

			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".TARIFFA_LST(?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodePs);
      cs.setString(2,CodOf);
      cs.setString(3,CausBill);

      

      cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_TARIFFE_DETT_2");
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);

      cs.execute();

      if (cs.getInt(5)!=DBMessage.OK_RT)
         throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6)+"NOME STORED: TARIFFA_LST_STORIA");

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_TARIFFE_DETT_2",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(4);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new TariffaBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              if (attr[0]!=null)
                 pk.setImpMinSps(new Double(attr[0].doubleValue()));
              else
                  pk.setImpMinSps(new Double(0));
              if (attr[1]!=null)
                  pk.setImpMaxSps(new Double(attr[1].doubleValue()));
              else
                  pk.setImpMaxSps(new Double(0));
              if (attr[2]!=null)
                  pk.setImpTar(new Double(attr[2].doubleValue()));
              else
                  pk.setImpTar(new Double(0));
              if (attr[2]!=null){
                  NumberFormat nf = DecimalFormat.getInstance(Locale.ITALIAN);
                  nf.setMaximumFractionDigits(6);
                  //System.out.println("importo => ["+nf.format(attr[2].doubleValue())+"]");
                  pk.setImpTarStr(nf.format(attr[2].doubleValue()));
              }else
                  pk.setImpTarStr("0");


              pk.setCodTar(attr[3].stringValue());
              pk.setProgTar(attr[4].stringValue());
              pk.setFlgMat(attr[5].stringValue());

              if (attr[6]!=null)
                pk.setDataIniTar(attr[6].stringValue());
              else
                pk.setDataIniTar("");

              if (attr[7]!=null)
                pk.setDataFineTar(attr[7].stringValue());
              else
                pk.setDataFineTar("");

              if (attr[8]!=null)
                pk.setDataCreazTar(attr[8].stringValue());
              else
                pk.setDataCreazTar("");

              if (attr[9]!=null)
                pk.setCodePromozione(attr[9].intValue());
              else
                pk.setCodePromozione(0);
                
            if (attr[10]!=null)
              pk.setDescListinoApplicato(attr[10].stringValue());
            else
              pk.setDescListinoApplicato("");
              
             recs.add(pk);
          }

      // Chiudo la connessione
      cs.close();
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
        StaticMessages.setCustomString(e.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5002,"","","",StaticContext.APP_SERVER_DRIVER));
        e.printStackTrace();
        throw new RemoteException(e.getMessage());
			}
		}

    return recs;
}

public Collection ejbFindDettaglio(String CodTar, String CodOf, String CausBill, String CodTipoOpz) throws FinderException, RemoteException
{
Vector recs = new Vector();
 	try
		{

			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".TARIFFA_LST_STORIA(?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodTar);
      cs.setString(2,CodOf);
      cs.setString(3,CausBill);
      cs.setString(4,CodTipoOpz);
      

      cs.registerOutParameter(5,OracleTypes.ARRAY, "ARR_TARIFFE_DETT");
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);

      cs.execute();

      if (cs.getInt(6)!=DBMessage.OK_RT)
         throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7)+"NOME STORED: TARIFFA_LST_STORIA");

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_TARIFFE_DETT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(5);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new TariffaBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              if (attr[0]!=null)
                 pk.setImpMinSps(new Double(attr[0].doubleValue()));
              else
                  pk.setImpMinSps(new Double(0));
              if (attr[1]!=null)
                  pk.setImpMaxSps(new Double(attr[1].doubleValue()));
              else
                  pk.setImpMaxSps(new Double(0));
              if (attr[2]!=null)
                  pk.setImpTar(new Double(attr[2].doubleValue()));
              else
                  pk.setImpTar(new Double(0));


              pk.setCodTar(attr[3].stringValue());
              pk.setProgTar(attr[4].stringValue());
              pk.setFlgMat(attr[5].stringValue());

              if (attr[6]!=null)
                pk.setDataIniTar(attr[6].stringValue());
              else
                pk.setDataIniTar("");

              if (attr[7]!=null)
                pk.setDataFineTar(attr[7].stringValue());
              else
                pk.setDataFineTar("");

                if (attr[8]!=null)
                pk.setDataCreazTar(attr[8].stringValue());
              else
                pk.setDataCreazTar("");

             recs.add(pk);
          }

      // Chiudo la connessione
      cs.close();
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
        StaticMessages.setCustomString(e.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5002,"","","",StaticContext.APP_SERVER_DRIVER));
        e.printStackTrace();
        throw new RemoteException(e.getMessage());
			}
		}

    return recs;
}

public TariffaBMPPK ejbFindUnitaMisuraDettXTar(String codTar, String progTar) throws FinderException, RemoteException
  {
  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".UNITA_MISURA_DETT_X_TAR(?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codTar);
      cs.setString(2,progTar);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5)+"NOME STORED: UNITA_MISURA_DETT_X_TAR");

      pk.setDescUM(cs.getString(3));

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
//
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
        StaticMessages.setCustomString(e.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5002,"","","",StaticContext.APP_SERVER_DRIVER));
        e.printStackTrace();
        throw new RemoteException(e.getMessage());
			}
		}
   return  pk;

  }

 public TariffaBMPPK ejbFindCausFattLeggiDett(String codTipoCaus) throws FinderException, RemoteException
  {
  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".CAUS_FAT_LEGGI_DETT(?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codTipoCaus);
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT))//&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: CAUS_FAT_LEGGI_DETT");

      pk. setDescTipoCaus(cs.getString(2));

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
        StaticMessages.setCustomString(e.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5002,"","","",StaticContext.APP_SERVER_DRIVER));
        e.printStackTrace();
        throw new RemoteException(e.getMessage());
			}
		}
   return  pk;

  }


  public TariffaBMPPK ejbFindTariffaVerEsAttive(String codPs, String codOf) throws FinderException, RemoteException
  {
  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_VER_ES_ATTIVE(?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codPs);
      cs.setString(2,codOf);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);

      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5)+"NOME STORED: TAR_VER_ES_ATTIVE");

      pk.setNumTariffe(new Integer(cs.getInt(3)));

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
      StaticContext.writeLog(StaticMessages.getMessage(5004,"TariffaBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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



 public TariffaBMPPK ejbFindTariffaMaxDataFine(String codPs, String codOf) throws FinderException, RemoteException
  {

  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_MAX_DATA_FINE(?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,codPs);
      cs.setString(2,codOf);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT))//&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5)+"NOME STORED: TARIFFA_MAX_DATA_FINE");

      pk.setDataFineTar(cs.getString(3));

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
      StaticContext.writeLog(StaticMessages.getMessage(5004,"TariffaBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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


 public TariffaBMPPK  ejbFindAssocOfpsDisattiva(String dataFineValAssOfPs, String codOf, String dataIniValOf, String dataIniValAssOfPs,String codPs) throws FinderException, RemoteException
   {

  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_DISATTIVA(?,?,?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,dataFineValAssOfPs);
      cs.setString(2,codOf);
      cs.setString(3,dataIniValOf);
      cs.setString(4,dataIniValAssOfPs);
      cs.setString(5,codPs);

      cs.registerOutParameter(7,Types.VARCHAR);
      cs.registerOutParameter(6,Types.INTEGER);

      cs.execute();

      if ((cs.getInt(6)!=DBMessage.OK_RT))//&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7)+"NOME STORED: ASSOC_OFPS_DISATTIVA");

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
        StaticMessages.setCustomString(e.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5002,"","","",StaticContext.APP_SERVER_DRIVER));
        e.printStackTrace();
        throw new RemoteException(e.getMessage());
			}
		}
   return  pk;

  }

public  TariffaBMPPK ejbFindElabBatchInCorsoFatt()  throws FinderException, RemoteException
  {
  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".ELAB_BATCH_IN_CORSO_FATT(?,?,?)}");

       // Impostazione types I/O
      cs.registerOutParameter(1,Types.INTEGER);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(2)!=DBMessage.OK_RT))//&&(cs.getInt(2)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(2)+":"+cs.getString(3)+"NOME STORED: ELAB_BATCH_IN_CORSO_FATT");

      pk.setNumElaborazTrovate(new Integer(cs.getInt(1)));

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
        StaticMessages.setCustomString(e.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5002,"","","",StaticContext.APP_SERVER_DRIVER));
        e.printStackTrace();
        throw new RemoteException(e.getMessage());
			}
		}
   return  pk;

  }

public TariffaBMPPK ejbFindTariffaVerDisattiva(String codTar, String progTar) throws FinderException, RemoteException
{
  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_VER_DISATTIVA(?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codTar);
      cs.setString(2,progTar);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT))//&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5)+"NOME STORED: TARIFFA_VER_DISATTIVA");

      pk.setNumTarDisattive(new Integer(cs.getInt(3)));

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
        StaticMessages.setCustomString(e.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5002,"","","",StaticContext.APP_SERVER_DRIVER));
        e.printStackTrace();
        throw new RemoteException(e.getMessage());
			}
		}
   return  pk;

  }



public TariffaBMPPK ejbFindTariffaVerProvv(String codTar, String progTar) throws FinderException, RemoteException
{

  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_VER_PROVV(?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codTar);
      cs.setString(2,progTar);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5)+"NOME STORED: TARIFFA_VER_PROVV");

      pk.setNumTarProvvisor(new Integer(cs.getInt(3)));

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
        StaticMessages.setCustomString(e.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5002,"","","",StaticContext.APP_SERVER_DRIVER));
        e.printStackTrace();
        throw new RemoteException(e.getMessage());
			}
		}
   return  pk;

  }


//06/09/02 inizio

public String getCodContr()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getCodContr();
  }

  public void setDescContr(String descContr)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setDescContr(descContr);
    enableStore=true;
  }

  public String getDescContr()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getDescContr();
  }


  public void setDescEsP(String descEsP)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setDescEsP(descEsP);
    enableStore=true;
  }

  public String getDescEsP()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getDescEsP();
  }

  public void setCodContr(String codContr)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setCodContr(codContr);
    enableStore=true;
  }
//06/09/02 fine


  public String getCodTar()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getCodTar();
  }

  public void setCodTar(String codTar)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setCodTar(codTar);
    enableStore=true;
  }


  public String getProgTar()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
     //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getProgTar();
  }

  public void setProgTar(String progTar)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setProgTar(progTar);
    enableStore=true;
  }



  public String getCodUM()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getCodUM();
  }

  public void setCodUM(String codUM)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setCodUM(codUM);
    enableStore=true;
  }


  public String getCodUt()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getCodUt();
  }

  public void setCodUt(String codUt)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setCodUt(codUt);
    enableStore=true;
  }


  public String getDataIniValAssOfPs()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getDataIniValAssOfPs();
  }

  public void setDataIniValAssOfPs(String dataIniValAssOfPs)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setDataIniValAssOfPs(dataIniValAssOfPs);
    enableStore=true;
  }


  public String getCodOf()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getCodOf();
  }

  public void setCodOf(String codOf)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setCodOf(codOf);
    enableStore=true;
  }

//06/09/02 inizio
//descOf
  public String getDescOf()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getDescOf();
  }

  public void setDescOf(String descOf)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setDescOf(descOf);
    enableStore=true;
  }
//
//06/09/02 fine

  public String getDataIniValOf()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getDataIniValOf();
  }

  public void setDataIniValOf(String dataIniValOf)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setDataIniValOf(dataIniValOf);
    enableStore=true;
  }



  public String getCodPs()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getCodPs();
  }

  public void setCodPs(String codPs)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setCodPs(codPs);
    enableStore=true;
  }


  public String getDataIniTar()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getDataIniTar();
  }

  public void setDataIniTar(String dataIniTar)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setDataIniTar(dataIniTar);
    enableStore=true;
  }



  public String getDataFineTar()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getDataFineTar();
  }

  public void setDataFineTar(String dataFineTar)
  {
		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setDataFineTar(dataFineTar);
    enableStore=true;
    return;
  }



  public String getDescTar()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getDescTar();
  }

  public void setDescTar(String descTar)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setDescTar(descTar);
    enableStore=true;
  }



  public void setDescTipoCaus(String descTipoCaus)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setDescTipoCaus(descTipoCaus);
    enableStore=true;
  }
  public String getDescTipoCaus()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getDescTipoCaus();
  }
  public void setDescUM(String descUM)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setDescUM(descUM);
    enableStore=true;
  }
  public String getDescUM()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getDescUM();
  }



  public Double getImpTar()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getImpTar();
  }

  public void setImpTar(Double impTar)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setImpTar(impTar);
    enableStore=true;
  }


public Double getImpMaxSps()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getImpMaxSps();
  }

  public void setImpMaxSps(Double impMaxSps)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setImpMaxSps(impMaxSps);
    enableStore=true;
  }

public Double getImpMinSps()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getImpMinSps();
  }

  public void setImpMinSps(Double impMinSps)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setImpMaxSps(impMinSps);
    enableStore=true;
  }



  public String getFlgMat()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getFlgMat();
  }

  public void setFlgMat(String flgMat)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setFlgMat(flgMat);
    enableStore=true;
  }



  public String getCodClSc()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getCodClSc();
  }

  public void setCodClSc(String codClSc)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setCodClSc(codClSc);
    enableStore=true;
  }



  public String getCausFatt()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getCausFatt();
  }

  public void setCausFatt(String causFatt)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setCausFatt(causFatt);
    enableStore=true;
  }



  public String getCodFascia()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getCodFascia();
  }

  public void setCodFascia(String codFascia)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setCodFascia(codFascia);
    enableStore=true;
  }



  public String getCodPrFascia()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getCodPrFascia();
  }

  public void setCodPrFascia(String codPrFascia)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setCodPrFascia(codPrFascia);
    enableStore=true;
  }



  public String getCodTipoCaus()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getCodTipoCaus();
  }

  public void setCodTipoCaus(String codTipoCaus)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setCodTipoCaus(codTipoCaus);
    enableStore=true;
  }



  public String getCodTipoOf()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getCodTipoOf();
  }

  public void setCodTipoOf(String codTipoOf)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setCodTipoOf(codTipoOf);
    enableStore=true;
  }



  public String getPrClSc()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getPrClSc();
  }

  public void setPrClSc(String prClSc)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setPrClSc(prClSc);
    enableStore=true;
  }



  public String getFlgCongRe()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getFlgCongRe();
  }

  public void setFlgCongRe(String flgCongRe)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setFlgCongRe(flgCongRe);
    enableStore=true;
  }




  public String getDataCreazTar()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getDataCreazTar();
  }

  public void setDataCreazTar(String dataCreazTar)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setDataCreazTar(dataCreazTar);
    enableStore=true;
  }



  public String getFlgProvv()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getFlgProvv();
  }

  public void setFlgProvv(String flgProvv)
  {
		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setFlgProvv(flgProvv);
    enableStore=true;
  }


  public void setNumTariffe(Integer numTariffe)
  {
		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setNumTariffe(numTariffe);
  }

  public Integer getNumTariffe()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getNumTariffe();
  }

  public void setDataFineValAssOfPs(String dataFineValAssOfPs)
  {
		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setDataFineValAssOfPs(dataFineValAssOfPs);
    enableStore=true;
  }

  public String getDataFineValAssOfPs()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getDataFineValAssOfPs();
  }


  public void setNumElaborazTrovate(Integer numElaborazTrovate)
  {
		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setNumElaborazTrovate(numElaborazTrovate);
  }

  public Integer getNumElaborazTrovate()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getNumElaborazTrovate();
  }



  public void setNumTarDisattive(Integer numTarDisattive)
  {
		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setNumTarDisattive(numTarDisattive);
    enableStore=true;
  }

  public Integer getNumTarDisattive()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getNumTarDisattive();

  }

  public void setNumTarProvvisor(Integer numTarProvvisor)
  {
 		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setNumTarProvvisor(numTarProvvisor);
    enableStore=true;
  }

  public Integer getNumTarProvvisor()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getNumTarProvvisor();
  }

//METODO PER IL CARICAMENTO DELLA LISTA DELLE TARIFFE
 public TariffaBMPPK ejbFindCalcolaCodice() throws FinderException, RemoteException
	{
   TariffaBMPPK pk =new TariffaBMPPK();
 	 try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_CALCOLA_CODICE(?,?,?)}");
      // Impostazione types I/O
      cs.registerOutParameter(1,Types.VARCHAR);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(2)!=DBMessage.OK_RT)&&(cs.getInt(2)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(2)+":"+cs.getString(3));

      pk.setCodTar(cs.getString(1));

      cs.close();
      // Chiudo la connessione
      conn.close();
     }
     catch(SQLException e)
     {
        //throw new CreateException(e.getMessage());  //LUCA VERIFICARE
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
        }
        catch(Exception e)
        {
         throw new RemoteException(e.getMessage());
        }
      }//finally
      return pk;
  }


  public TariffaBMPPK ejbFindOfMaxDataIniOfPs(String codOf,String codPs) throws FinderException, RemoteException
  {
// //System.out.println("ejbFindOfMaxDataIniOfPs");
  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_MAX_DATAINI_VAL(?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codOf);
      cs.setString(2,codPs);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

//      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
//        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));
//
//      if (cs.getInt(4)==DBMessage.NOT_FOUND_RT)
//        throw new FinderException("Descrizione non trovata"+primaryKey);
//
      pk.setDataIniValAssOfPs(cs.getString(3));
      
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
   return pk;
  }

  public TariffaBMPPK ejbFindOfMaxDataIniOf(String codOf) throws FinderException, RemoteException
  {
  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_MAX_DATAINI_OF(?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codOf);
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

//      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
//        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));
//
//      if (cs.getInt(4)==DBMessage.NOT_FOUND_RT)
//        throw new FinderException("Descrizione non trovata"+primaryKey);
//
      pk.setDataIniValOf(cs.getString(2));
      
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
   return pk;
  }

  public TariffaBMPPK ejbFindNumTar(String codTipoContr, String codePs) throws FinderException, RemoteException
  {
  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".PS_VER_TAR_DA_ACQ(?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codTipoContr);
      cs.setString(2,codePs);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      pk.setNumTariffe(new Integer(cs.getInt(3)));
      
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
   return pk;
  }

public void ejbStore() throws RemoteException
{
  if (enableStore)
  {
      enableStore = false;
      pk = (TariffaBMPPK) ctx.getPrimaryKey();


   Connection conn=null;

    try
      {
         conn = getConnection(dsName);
         OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_AGGIORNA(?,?,?,?,?)}");

         // Impostazione types I/O
        cs.setString(1,pk.getCodTar());
        cs.setString(2,pk.getProgTar());
        cs.setString(3,pk.getDataFineTar());

        cs.registerOutParameter(4,Types.INTEGER);
        cs.registerOutParameter(5,Types.VARCHAR);

        cs.execute();

        if (cs.getInt(4)!=DBMessage.OK_RT)
          throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));

      cs.close();
      // Chiudo la connessione
      conn.close();

      }
    catch(Exception lexc_Exception)
      {
  throw new CustomEJBException(lexc_Exception.toString(),
       "Errore di inserimento nella store procedure PKG_BILL_SPE.TARIFFA_AGGIORNA",
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
  }
}



  public void ejbRemove(TariffaBMPPK pk) throws FinderException, RemoteException
  {
    Connection conn=null;
    try
    {
       conn = getConnection(dsName);
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_CANCELLA(?,?,?,?)}");

      // Impostazione types I/O
     cs.setString(1,pk.getCodTar());
      cs.setString(2,pk.getProgTar());
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.execute();


      cs.close();
      // Chiudo la connessione
      conn.close();

    }

catch(Exception lexc_Exception)
      {
  throw new CustomEJBException(lexc_Exception.toString(),
       "Errore di inserimento nella store procedure PKG_BILL_SPE.TARIFFA_CANCELLA",
       "ejbStore Classic",
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
  }

public TariffaBMPPK ejbFindMaxPrgTariffa(String codTar) throws FinderException, RemoteException, FinderException
{
  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_MAX_PRG(?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codTar);
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      pk.setProgTar(cs.getString(2));

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

   return pk;

}

public TariffaBMPPK ejbFindAlmeno1TariffaProvv(String codTar) throws FinderException, RemoteException
{
  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_VER_ALMENO_1_PROVV(?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codTar);

      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      pk.setNumTarProvvisor(new Integer(cs.getInt(2)));

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

   return pk;

}

public Collection ejbFindTariffeProvv(String CodTar) throws FinderException, RemoteException, FinderException
{

Vector recs = new Vector();
 	try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_LEGGI_PROVV(?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodTar);

//     //System.out.println("Imposto l'O");
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_TAR_PROVV");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_TAR_PROVV",conn);
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
                  pk.setCodTar(attr[0].stringValue());
              else
                  pk.setCodTar("");

              if (attr[1]!=null)
                  pk.setProgTar(attr[1].stringValue());
              else
                  pk.setProgTar("");

              if (attr[2]!=null)
                  pk.setDataIniTar(attr[2].stringValue());
              else
                  pk.setDataIniTar("");

              if (attr[3]!=null)
              {
                  pk.setDataFineTar(attr[3].stringValue());
              }
              else
              {
               pk.setDataFineTar("");
              }

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

  public void setContrDest(String contrDest)
  {
 		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setContrDest(contrDest);
    enableStore=true;
  }

  public String getContrDest()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getContrDest();
  }

  public void setFlgCommit(Integer flgCommit)
  {
 		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setFlgCommit(flgCommit);
    enableStore=true;
  }

  public Integer getFlgCommit()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getFlgCommit();
  }


public TariffaBMPPK ejbFindTariffaGestCancella(String codTar, String progTar) throws FinderException, RemoteException
{
  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_GEST_CANCELLA(?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codTar);
      cs.setString(2,progTar);

      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);

      cs.execute();

      if (cs.getInt(3)!=DBMessage.OK_RT)
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

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

   return pk;

}

public TariffaBMPPK ejbFindTariffaGestDisattiva(String codTar, String progTar, String dataFineTar, String codPs, String codOf, String dataIniValOf, String dataIniValAssOfPs) throws FinderException, RemoteException
{
// //System.out.println("TariffaGestDisattiva");
  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_GEST_DISATTIVA(?,?,?,?,?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codTar);
      cs.setString(2,progTar);
      cs.setString(3,dataFineTar);
      cs.setString(4,codPs);
      cs.setString(5,codOf);
      cs.setString(6,dataIniValOf);
      cs.setString(7,dataIniValAssOfPs);

      cs.registerOutParameter(8,Types.INTEGER);
      cs.registerOutParameter(9,Types.VARCHAR);

      cs.execute();

      if (cs.getInt(8)!=DBMessage.OK_RT)
        throw new Exception("DB:"+cs.getInt(8)+":"+cs.getString(9));

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

   return pk;

}

public TariffaBMPPK ejbFindTariffaAggiornaConProvv(String codTar, String dataIniTarDigitata, String descTar, Double impTar, String codUt, int inserimento) throws FinderException, RemoteException
{
  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs;
      if (inserimento == 0){
        cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_AGGIORNA_CON_PROVV(?,?,?,?,?,?,?)}");
      }else{
        cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_INSERIMENTO_CON_PROVV(?,?,?,?,?,?,?)}");
      }

       // Impostazione types I/O
      cs.setString(1,codTar);
      cs.setString(2,dataIniTarDigitata);
      cs.setString(3,descTar);
      cs.setDouble(4,impTar.doubleValue());
      cs.setString(5,codUt);
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);

      cs.execute();

      pk.setNumTarProvvisor(new Integer(cs.getInt(6)));

      if (cs.getInt(6)!=DBMessage.OK_RT && cs.getInt(6)!=1)
        throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7));
      
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

   return pk;

}

public TariffaBMPPK ejbFindTariffaAggiornaSenzaProvv(String codTar, String progTar, String dataFineTarDigitata, String codUM, String dataIniValAssOfPs, String codOf, String dataIniValOf, String codPs, String flgMat, String codTipoCaus, String codClSc, String prClSc, String codTipoOf, String dataIniTar, String dataFineTar, String descTar, Double impTar, String causFatt, String flgProvv, String codUt, String codTipoOpz) throws FinderException, RemoteException
{

  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_AGGIORNA_SENZA_PROVV(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

       // Impostazione types I/O

      cs.setString(1,codTar);
      cs.setString(2,progTar);
      cs.setString(3,dataFineTarDigitata);
      cs.setString(4,codUM);
      cs.setString(5,dataIniValAssOfPs);
      cs.setString(6,codOf);
      cs.setString(7,dataIniValOf);
      cs.setString(8,codPs);
      cs.setString(9,flgMat);
      cs.setString(10,codTipoCaus);
      cs.setString(11,codClSc);
      cs.setString(12,prClSc);
      cs.setString(13,codTipoOf);
      cs.setString(14,dataIniTar);
      cs.setString(15,dataFineTar);
      cs.setString(16,descTar);
      cs.setDouble(17,impTar.doubleValue());
      cs.setString(18,causFatt);
      cs.setString(19,flgProvv);
      cs.setString(20,codUt);
      cs.setString(21,codTipoOpz);
      cs.registerOutParameter(22,Types.INTEGER);
      cs.registerOutParameter(23,Types.VARCHAR);

      cs.execute();

      if (cs.getInt(22)!=DBMessage.OK_RT)
        throw new Exception("DB:"+cs.getInt(22)+":"+cs.getString(23));
      // Chiudo la connessione 
      cs.close();
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

   return pk;

}

public TariffaBMPPK ejbFindTariffaUnica(String codTar) throws FinderException, RemoteException
{
  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_UNICA(?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codTar);

      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      pk.setNumTarProvvisor(new Integer(cs.getInt(2)));

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
   return pk;
}

public TariffaBMPPK ejbFindTariffaAggiornaUnicaProvv(String codTar, String dataIniTarDigitata, String descTar, Double impTar, String codUt) throws FinderException, RemoteException
{
  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs;
      cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_UNICA_AGGIORNA_PROVV(?,?,?,?,?,?,?)}");
       // Impostazione types I/O
      cs.setString(1,codTar);
      cs.setString(2,dataIniTarDigitata);
      cs.setString(3,descTar);
      cs.setDouble(4,impTar.doubleValue());
      cs.setString(5,codUt);
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);

      cs.execute();

      pk.setNumTarProvvisor(new Integer(cs.getInt(6)));

      if (cs.getInt(6)!=DBMessage.OK_RT && cs.getInt(6)!=1)
        throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7));
      
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
   return pk;
}

public TariffaBMPPK ejbFindTariffaAggiornaUnica(String codTar, String dataIniTarDigitata, String descTar, Double impTar, String codUt) throws FinderException, RemoteException
{
  TariffaBMPPK pk = new TariffaBMPPK();
  Connection conn=null;
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs;
      cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_UNICA_AGGIORNA(?,?,?,?,?,?,?)}");
       // Impostazione types I/O
      cs.setString(1,codTar);
      cs.setString(2,dataIniTarDigitata);
      cs.setString(3,descTar);
      cs.setDouble(4,impTar.doubleValue());
      cs.setString(5,codUt);
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.execute();
      pk.setNumTarProvvisor(new Integer(cs.getInt(6)));
      if (cs.getInt(6)!=DBMessage.OK_RT && cs.getInt(6)!=1)
        throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7)); 
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
   return pk;
}

  public void setDataIniTarDigitata(String dataIniTarDigitata)
  {
		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setDataIniTarDigitata(dataIniTarDigitata);
    //enableStore=true;
  }

  public String getDataIniTarDigitata()
  {
    pk = (TariffaBMPPK) ctx.getPrimaryKey();
    //enableStore=false;
    if (pk==null) return null;
    else
      return pk.getDataIniTarDigitata();

  }

  //Valeria inizio 12-02-03
    public void setCodTipoOpz(String codTipoOpz)
  {
		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setCodTipoOpz(codTipoOpz);
    //enableStore=true;
  }

  public String getCodTipoOpz()
  {
    pk = (TariffaBMPPK) ctx.getPrimaryKey();
    //enableStore=false;
    if (pk==null) return null;
    else
      return pk.getCodTipoOpz();

  }

    public void setDescTipoOpz(String descTipoOpz)
  {
		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setDescTipoOpz(descTipoOpz);
    //enableStore=true;
  }

  public String getDescTipoOpz()
  {
    pk = (TariffaBMPPK) ctx.getPrimaryKey();
    //enableStore=false;
    if (pk==null) return null;
    else
      return pk.getDescTipoOpz();

  }

  //METODO PER IL CARICAMENTO DELLE TARIFFE TARIFFA_PERS_X_RIB
  public Collection ejbFindTariffaPersXRib(String codTipoContr, String codContr, String codContrDest ) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 	try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_PERS_X_RIB_CONTR(?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,codTipoContr);
      cs.setString(2,codContr);
      cs.setString(3,codContrDest);

      cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_LISTINO");
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6));

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_LISTINO",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(4);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new TariffaBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              if (attr[0]!=null)
                  pk.setImpTar(new Double(attr[0].doubleValue()));
              else
                  pk.setImpTar(new Double(0));
              if (attr[1]!=null)
                  pk.setDataCreazTar(attr[1].stringValue());
              else
                  pk.setDataCreazTar("");
              if (attr[2]!=null)
                  pk.setProgTar(attr[2].stringValue());
              else
                  pk.setProgTar("");
              if (attr[3]!=null)
                 pk.setImpMinSps(new Double(attr[3].doubleValue()));
              else
                  pk.setImpMinSps(new Double(0));
              if (attr[4]!=null)
                  pk.setImpMaxSps(new Double(attr[4].doubleValue()));
              else
                  pk.setImpMaxSps(new Double(0));
              if (attr[5]!=null)
                  pk.setCodTar(attr[5].stringValue());
              else
                  pk.setCodTar(new String(""));
              if (attr[6]!=null)
                  pk.setFlgMat(attr[6].stringValue());
              else
                  pk.setFlgMat(new String(""));
              if (attr[7]!=null)
                  pk.setCodClSc(attr[7].stringValue());
              else
                  pk.setCodClSc(new String(""));
              if (attr[8]!=null)
                  pk.setPrClSc(attr[8].stringValue());
              else
                  pk.setPrClSc(new String(""));
              if (attr[9]!=null)
                  pk.setCodUM(attr[9].stringValue());
              else
                  pk.setCodUM(new String(""));
              if (attr[10]!=null)
                  pk.setDescUM(attr[10].stringValue());
              else
                  pk.setDescUM(new String(""));
              if (attr[11]!=null)
                  pk.setCodOf(attr[11].stringValue());
              else
                  pk.setCodOf(new String(""));
              if (attr[12]!=null)
                  pk.setDescOf(attr[12].stringValue());
              else
                  pk.setDescOf(new String(""));
              if (attr[13]!=null)
                  pk.setCodPs(attr[13].stringValue());
              else
                  pk.setCodPs(new String(""));
              if (attr[14]!=null)
                  pk.setDescEsP(attr[14].stringValue());
              else
                  pk.setDescEsP(new String(""));
              if (attr[15]!=null)
                  pk.setDescTipoCaus(attr[15].stringValue());
              else
                  pk.setDescTipoCaus(new String(""));
              if (attr[16]!=null)
                  pk.setDataIniTar(attr[16].stringValue());
              else
                  pk.setDataIniTar(new String(""));
              if (attr[17]!=null)
                  pk.setDataFineTar(attr[17].stringValue());
              else
                  pk.setDataFineTar(new String(""));
              if (attr[18]!=null)
                  pk.setDescTar(attr[18].stringValue());
              else
                  pk.setDescTar(new String(""));
              if (attr[19]!=null)
                  pk.setCodTipoCaus(attr[19].stringValue());
              else
                  pk.setCodTipoCaus(new String(""));
                  //13-02-03 VITI
             if (attr[20]!=null)
                  pk.setCodTipoOpz(attr[20].stringValue());
              else
                  pk.setCodTipoOpz(new String(""));
              if (attr[21]!=null)
                  pk.setDescTipoOpz(attr[21].stringValue());
              else
                  pk.setDescTipoOpz(new String(""));
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

       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(1001,"Controller","","",StaticContext.APP_SERVER_DRIVER));
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


    public Collection ejbFindTariffaPersXRibNClus(String codTipoContr, String codContr, String codContrDest, String codeClusterDest, String tipoClusterDest, String prodottoCluster ) throws FinderException, RemoteException
        {
        Vector recs = new Vector();
        boolean flgAggiungi = true;
        try
                {
                        conn = getConnection(dsName);
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_PERS_X_RIB_CONTR_NCLU(?,?,?,?,?,?,?,?)}");

        // Impostazione types I/O
        cs.setString(1,codTipoContr);
        cs.setString(2,codContr);
        cs.setString(3,codContrDest);
        cs.setString(4,codeClusterDest);
        cs.setString(5,tipoClusterDest);
        cs.registerOutParameter(6,OracleTypes.ARRAY, "ARR_LISTINO_EXT");
        cs.registerOutParameter(7,Types.INTEGER);
        cs.registerOutParameter(8,Types.VARCHAR);
        cs.execute();

        if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(7)+":"+cs.getString(8));

        // Costruisco l'array che conterrà i dati di ritorno della stored
        ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_LISTINO_EXT",conn);
        ARRAY rs = new ARRAY(ad, conn, null);

        // Ottengo i dati
        rs=cs.getARRAY(6);
        Datum dati[]=rs.getOracleArray();

        // Estrazione dei dati
        for (int i=0;i<dati.length;i++)
          {
              
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              flgAggiungi = true;
              if ( prodottoCluster != null &&  ! "".equals(prodottoCluster) && ! "-1".equals(prodottoCluster)) {
                  if ( attr[22] != null ){
                      if (prodottoCluster.contains("%")) {
                          if (attr[22].stringValue().contains(prodottoCluster.replace("%","")) ) {
                              flgAggiungi = true;
                          } else {
                              flgAggiungi = false;
                          }                         
                      } else {
                          if (attr[22].stringValue().equals(prodottoCluster) ) {
                              flgAggiungi = true;
                          } else {
                              flgAggiungi = false;
                          }
                      }
                  }
              } 
              
              if (flgAggiungi) {
                  pk = new TariffaBMPPK();
                  if (attr[0]!=null)
                      pk.setImpTar(new Double(attr[0].doubleValue()));
                  else
                      pk.setImpTar(new Double(0));
                  if (attr[1]!=null)
                      pk.setDataCreazTar(attr[1].stringValue());
                  else
                      pk.setDataCreazTar("");
                  if (attr[2]!=null)
                      pk.setProgTar(attr[2].stringValue());
                  else
                      pk.setProgTar("");
                  if (attr[3]!=null)
                     pk.setImpMinSps(new Double(attr[3].doubleValue()));
                  else
                      pk.setImpMinSps(new Double(0));
                  if (attr[4]!=null)
                      pk.setImpMaxSps(new Double(attr[4].doubleValue()));
                  else
                      pk.setImpMaxSps(new Double(0));
                  if (attr[5]!=null)
                      pk.setCodTar(attr[5].stringValue());
                  else
                      pk.setCodTar(new String(""));
                  if (attr[6]!=null)
                      pk.setFlgMat(attr[6].stringValue());
                  else
                      pk.setFlgMat(new String(""));
                  if (attr[7]!=null)
                      pk.setCodClSc(attr[7].stringValue());
                  else
                      pk.setCodClSc(new String(""));
                  if (attr[8]!=null)
                      pk.setPrClSc(attr[8].stringValue());
                  else
                      pk.setPrClSc(new String(""));
                  if (attr[9]!=null)
                      pk.setCodUM(attr[9].stringValue());
                  else
                      pk.setCodUM(new String(""));
                  if (attr[10]!=null)
                      pk.setDescUM(attr[10].stringValue());
                  else
                      pk.setDescUM(new String(""));
                  if (attr[11]!=null)
                      pk.setCodOf(attr[11].stringValue());
                  else
                      pk.setCodOf(new String(""));
                  if (attr[12]!=null)
                      pk.setDescOf(attr[12].stringValue());
                  else
                      pk.setDescOf(new String(""));
                  if (attr[13]!=null)
                      pk.setCodPs(attr[13].stringValue());
                  else
                      pk.setCodPs(new String(""));
                  if (attr[14]!=null)
                      pk.setDescEsP(attr[14].stringValue());
                  else
                      pk.setDescEsP(new String(""));
                  if (attr[15]!=null)
                      pk.setDescTipoCaus(attr[15].stringValue());
                  else
                      pk.setDescTipoCaus(new String(""));
                  if (attr[16]!=null)
                      pk.setDataIniTar(attr[16].stringValue());
                  else
                      pk.setDataIniTar(new String(""));
                  if (attr[17]!=null)
                      pk.setDataFineTar(attr[17].stringValue());
                  else
                      pk.setDataFineTar(new String(""));
                  if (attr[18]!=null)
                      pk.setDescTar(attr[18].stringValue());
                  else
                      pk.setDescTar(new String(""));
                  if (attr[19]!=null)
                      pk.setCodTipoCaus(attr[19].stringValue());
                  else
                      pk.setCodTipoCaus(new String(""));
                      //13-02-03 VITI
                 if (attr[20]!=null)
                      pk.setCodTipoOpz(attr[20].stringValue());
                  else
                      pk.setCodTipoOpz(new String(""));
                  if (attr[21]!=null)
                      pk.setDescTipoOpz(attr[21].stringValue());
                  else
                      pk.setDescTipoOpz(new String(""));

                  if (attr[22]!=null)
                      pk.setDescPs(attr[22].stringValue());
                  else
                      pk.setDescPs(new String(""));
                      
                 recs.add(pk);
              }
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

        StaticMessages.setCustomString(ee.toString());
        StaticContext.writeLog(StaticMessages.getMessage(1001,"Controller","","",StaticContext.APP_SERVER_DRIVER));
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
    
    public Collection ejbFindTariffaPersXRibClus(String codTipoContr, String codContr, String codContrDest, String codeCluster, String tipoCluster, String codeClusterDest, String tipoClusterDest, String prodottoCluster ) throws FinderException, RemoteException
          {
      Vector recs = new Vector();
        boolean flgAggiungi = true;
          try
                  {
                          conn = getConnection(dsName);
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_PERS_X_RIB_CONTR_CLU(?,?,?,?,?,?,?,?,?,?)}");

        // Impostazione types I/O
        cs.setString(1,codTipoContr);
        cs.setString(2,codContr);
        cs.setString(3,codContrDest);
          cs.setString(4,codeCluster);
          cs.setString(5,tipoCluster);
          cs.setString(6,codeClusterDest);
          cs.setString(7,tipoClusterDest);
         cs.registerOutParameter(8,OracleTypes.ARRAY, "ARR_LISTINO_EXT");
        cs.registerOutParameter(9,Types.INTEGER);
        cs.registerOutParameter(10,Types.VARCHAR);
        cs.execute();

        if ((cs.getInt(9)!=DBMessage.OK_RT)&&(cs.getInt(9)!=DBMessage.NOT_FOUND_RT))
              throw new Exception("DB:"+cs.getInt(9)+":"+cs.getString(10));

        // Costruisco l'array che conterrà i dati di ritorno della stored
        ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_LISTINO_EXT",conn);
        ARRAY rs = new ARRAY(ad, conn, null);

        // Ottengo i dati
        rs=cs.getARRAY(8);
        Datum dati[]=rs.getOracleArray();

        // Estrazione dei dati
        for (int i=0;i<dati.length;i++)
            {
               
                STRUCT s=(STRUCT)dati[i];
                Datum attr[]=s.getOracleAttributes();

                flgAggiungi = true;
                if ( prodottoCluster != null &&  ! "".equals(prodottoCluster) && ! "-1".equals(prodottoCluster)) {
                    if ( attr[22] != null ){
                        if (prodottoCluster.contains("%")) {
                            if (attr[22].stringValue().contains(prodottoCluster.replace("%","")) ) {
                                flgAggiungi = true;
                            } else {
                                flgAggiungi = false;
                            }                         
                        } else {
                            if (attr[22].stringValue().equals(prodottoCluster) ) {
                                flgAggiungi = true;
                            } else {
                                flgAggiungi = false;
                            }
                        }
                    }
                } 
                
                if (flgAggiungi) {
                
                    pk = new TariffaBMPPK();
                    
                    if (attr[0]!=null)
                        pk.setImpTar(new Double(attr[0].doubleValue()));
                    else
                        pk.setImpTar(new Double(0));
                    if (attr[1]!=null)
                        pk.setDataCreazTar(attr[1].stringValue());
                    else
                        pk.setDataCreazTar("");
                    if (attr[2]!=null)
                        pk.setProgTar(attr[2].stringValue());
                    else
                        pk.setProgTar("");
                    if (attr[3]!=null)
                       pk.setImpMinSps(new Double(attr[3].doubleValue()));
                    else
                        pk.setImpMinSps(new Double(0));
                    if (attr[4]!=null)
                        pk.setImpMaxSps(new Double(attr[4].doubleValue()));
                    else
                        pk.setImpMaxSps(new Double(0));
                    if (attr[5]!=null)
                        pk.setCodTar(attr[5].stringValue());
                    else
                        pk.setCodTar(new String(""));
                    if (attr[6]!=null)
                        pk.setFlgMat(attr[6].stringValue());
                    else
                        pk.setFlgMat(new String(""));
                    if (attr[7]!=null)
                        pk.setCodClSc(attr[7].stringValue());
                    else
                        pk.setCodClSc(new String(""));
                    if (attr[8]!=null)
                        pk.setPrClSc(attr[8].stringValue());
                    else
                        pk.setPrClSc(new String(""));
                    if (attr[9]!=null)
                        pk.setCodUM(attr[9].stringValue());
                    else
                        pk.setCodUM(new String(""));
                    if (attr[10]!=null)
                        pk.setDescUM(attr[10].stringValue());
                    else
                        pk.setDescUM(new String(""));
                    if (attr[11]!=null)
                        pk.setCodOf(attr[11].stringValue());
                    else
                        pk.setCodOf(new String(""));
                    if (attr[12]!=null)
                        pk.setDescOf(attr[12].stringValue());
                    else
                        pk.setDescOf(new String(""));
                    if (attr[13]!=null)
                        pk.setCodPs(attr[13].stringValue());
                    else
                        pk.setCodPs(new String(""));
                    if (attr[14]!=null)
                        pk.setDescEsP(attr[14].stringValue());
                    else
                        pk.setDescEsP(new String(""));
                    if (attr[15]!=null)
                        pk.setDescTipoCaus(attr[15].stringValue());
                    else
                        pk.setDescTipoCaus(new String(""));
                    if (attr[16]!=null)
                        pk.setDataIniTar(attr[16].stringValue());
                    else
                        pk.setDataIniTar(new String(""));
                    if (attr[17]!=null)
                        pk.setDataFineTar(attr[17].stringValue());
                    else
                        pk.setDataFineTar(new String(""));
                    if (attr[18]!=null)
                        pk.setDescTar(attr[18].stringValue());
                    else
                        pk.setDescTar(new String(""));
                    if (attr[19]!=null)
                        pk.setCodTipoCaus(attr[19].stringValue());
                    else
                        pk.setCodTipoCaus(new String(""));
                        //13-02-03 VITI
                   if (attr[20]!=null)
                        pk.setCodTipoOpz(attr[20].stringValue());
                    else
                        pk.setCodTipoOpz(new String(""));
                    if (attr[21]!=null)
                        pk.setDescTipoOpz(attr[21].stringValue());
                    else
                        pk.setDescTipoOpz(new String(""));
                   
                    if (attr[22]!=null)
                        pk.setDescPs(attr[22].stringValue());
                    else
                        pk.setDescPs(new String(""));
                        
                   recs.add(pk);
                }
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

         StaticMessages.setCustomString(ee.toString());
         StaticContext.writeLog(StaticMessages.getMessage(1001,"Controller","","",StaticContext.APP_SERVER_DRIVER));
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

  //METODO PER IL CARICAMENTO DELLE TARIFFE TARIFFA_UNICO_X_RIB
  public Collection ejbFindTariffaUnicoXRib(String codTipoContr , String codContrDest) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 	 try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_UNICO_X_RIB_CONTR(?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,codTipoContr);
      cs.setString(2,codContrDest);
      
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_LISTINO");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_LISTINO",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new TariffaBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              if (attr[0]!=null)
                  pk.setImpTar(new Double(attr[0].doubleValue()));
              else
                  pk.setImpTar(new Double(0));
              if (attr[1]!=null)
                  pk.setDataCreazTar(attr[1].stringValue());
              else
                  pk.setDataCreazTar("");
              if (attr[2]!=null)
                  pk.setProgTar(attr[2].stringValue());
              else
                  pk.setProgTar("");
              if (attr[3]!=null)
                 pk.setImpMinSps(new Double(attr[3].doubleValue()));
              else
                  pk.setImpMinSps(new Double(0));
              if (attr[4]!=null)
                  pk.setImpMaxSps(new Double(attr[4].doubleValue()));
              else
                  pk.setImpMaxSps(new Double(0));
              if (attr[5]!=null)
                  pk.setCodTar(attr[5].stringValue());
              else
                  pk.setCodTar(new String(""));
              if (attr[6]!=null)
                  pk.setFlgMat(attr[6].stringValue());
              else
                  pk.setFlgMat(new String(""));
              if (attr[7]!=null)
                  pk.setCodClSc(attr[7].stringValue());
              else
                  pk.setCodClSc(new String(""));
              if (attr[8]!=null)
                  pk.setPrClSc(attr[8].stringValue());
              else
                  pk.setPrClSc(new String(""));
              if (attr[9]!=null)
                  pk.setCodUM(attr[9].stringValue());
              else
                  pk.setCodUM(new String(""));
              if (attr[10]!=null)
                  pk.setDescUM(attr[10].stringValue());
              else
                  pk.setDescUM(new String(""));
              if (attr[11]!=null)
                  pk.setCodOf(attr[11].stringValue());
              else
                  pk.setCodOf(new String(""));
              if (attr[12]!=null)
                  pk.setDescOf(attr[12].stringValue());
              else
                  pk.setDescOf(new String(""));
              if (attr[13]!=null)
                  pk.setCodPs(attr[13].stringValue());
              else
                  pk.setCodPs(new String(""));
              if (attr[14]!=null)
                  pk.setDescEsP(attr[14].stringValue());
              else
                  pk.setDescEsP(new String(""));
              if (attr[15]!=null)
                  pk.setDescTipoCaus(attr[15].stringValue());
              else
                  pk.setDescTipoCaus(new String(""));
              if (attr[16]!=null)
                  pk.setDataIniTar(attr[16].stringValue());
              else
                  pk.setDataIniTar(new String(""));
              if (attr[17]!=null)
                  pk.setDataFineTar(attr[17].stringValue());
              else
                  pk.setDataFineTar(new String(""));
              if (attr[18]!=null)
                  pk.setDescTar(attr[18].stringValue());
              else
                  pk.setDescTar(new String(""));
              if (attr[19]!=null)
                  pk.setCodTipoCaus(attr[19].stringValue());
              else
                  pk.setCodTipoCaus(new String(""));
                  //13-02-03 VITI
             if (attr[20]!=null)
                  pk.setCodTipoOpz(attr[20].stringValue());
              else
                  pk.setCodTipoOpz(new String(""));
              if (attr[21]!=null)
                  pk.setDescTipoOpz(attr[21].stringValue());
              else
                  pk.setDescTipoOpz(new String(""));
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

       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(1001,"Controller","","",StaticContext.APP_SERVER_DRIVER));
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


    public Collection ejbFindTariffaUnicoXRib(String codTipoContr , String codContrDest,String codeCluster, String tipoCluster, String prodottoCluster) throws FinderException, RemoteException
          {
      Vector recs = new Vector();
      boolean flgAggiungi = true;
           try
                  {
                          conn = getConnection(dsName);
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_UNICO_X_RIB_CONTR_CG(?,?,?,?,?,?,?)}");

        // Impostazione types I/O
        cs.setString(1,codTipoContr);
        cs.setString(2,codContrDest);
          cs.setString(3,codeCluster);
          cs.setString(4,tipoCluster);
          
        cs.registerOutParameter(5,OracleTypes.ARRAY, "ARR_LISTINO_EXT");
        cs.registerOutParameter(6,Types.INTEGER);
        cs.registerOutParameter(7,Types.VARCHAR);
        cs.execute();

        if ((cs.getInt(6)!=DBMessage.OK_RT)&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
              throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7));

        // Costruisco l'array che conterrà i dati di ritorno della stored
        ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_LISTINO_EXT",conn);
        ARRAY rs = new ARRAY(ad, conn, null);

        // Ottengo i dati
        rs=cs.getARRAY(5);
        Datum dati[]=rs.getOracleArray();

        // Estrazione dei dati
        for (int i=0;i<dati.length;i++)
            {
            
                STRUCT s=(STRUCT)dati[i];
                Datum attr[]=s.getOracleAttributes();
                
                flgAggiungi = true;
                if ( prodottoCluster != null &&  ! "".equals(prodottoCluster) && ! "-1".equals(prodottoCluster)) {
                    if ( attr[22] != null ){
                        if (prodottoCluster.contains("%")) {
                            if (attr[22].stringValue().contains(prodottoCluster.replace("%","")) ) {
                                flgAggiungi = true;
                            } else {
                                flgAggiungi = false;
                            }                         
                        } else {
                            if (attr[22].stringValue().equals(prodottoCluster) ) {
                                flgAggiungi = true;
                            } else {
                                flgAggiungi = false;
                            }
                        }
                    }
                } 
                
                if (flgAggiungi) {
                    pk = new TariffaBMPPK();
                    if (attr[0]!=null)
                        pk.setImpTar(new Double(attr[0].doubleValue()));
                    else
                        pk.setImpTar(new Double(0));
                    if (attr[1]!=null)
                        pk.setDataCreazTar(attr[1].stringValue());
                    else
                        pk.setDataCreazTar("");
                    if (attr[2]!=null)
                        pk.setProgTar(attr[2].stringValue());
                    else
                        pk.setProgTar("");
                    if (attr[3]!=null)
                       pk.setImpMinSps(new Double(attr[3].doubleValue()));
                    else
                        pk.setImpMinSps(new Double(0));
                    if (attr[4]!=null)
                        pk.setImpMaxSps(new Double(attr[4].doubleValue()));
                    else
                        pk.setImpMaxSps(new Double(0));
                    if (attr[5]!=null)
                        pk.setCodTar(attr[5].stringValue());
                    else
                        pk.setCodTar(new String(""));
                    if (attr[6]!=null)
                        pk.setFlgMat(attr[6].stringValue());
                    else
                        pk.setFlgMat(new String(""));
                    if (attr[7]!=null)
                        pk.setCodClSc(attr[7].stringValue());
                    else
                        pk.setCodClSc(new String(""));
                    if (attr[8]!=null)
                        pk.setPrClSc(attr[8].stringValue());
                    else
                        pk.setPrClSc(new String(""));
                    if (attr[9]!=null)
                        pk.setCodUM(attr[9].stringValue());
                    else
                        pk.setCodUM(new String(""));
                    if (attr[10]!=null)
                        pk.setDescUM(attr[10].stringValue());
                    else
                        pk.setDescUM(new String(""));
                    if (attr[11]!=null)
                        pk.setCodOf(attr[11].stringValue());
                    else
                        pk.setCodOf(new String(""));
                    if (attr[12]!=null)
                        pk.setDescOf(attr[12].stringValue());
                    else
                        pk.setDescOf(new String(""));
                    if (attr[13]!=null)
                        pk.setCodPs(attr[13].stringValue());
                    else
                        pk.setCodPs(new String(""));
                    if (attr[14]!=null)
                        pk.setDescEsP(attr[14].stringValue());
                    else
                        pk.setDescEsP(new String(""));
                    if (attr[15]!=null)
                        pk.setDescTipoCaus(attr[15].stringValue());
                    else
                        pk.setDescTipoCaus(new String(""));
                    if (attr[16]!=null)
                        pk.setDataIniTar(attr[16].stringValue());
                    else
                        pk.setDataIniTar(new String(""));
                    if (attr[17]!=null)
                        pk.setDataFineTar(attr[17].stringValue());
                    else
                        pk.setDataFineTar(new String(""));
                    if (attr[18]!=null)
                        pk.setDescTar(attr[18].stringValue());
                    else
                        pk.setDescTar(new String(""));
                    if (attr[19]!=null)
                        pk.setCodTipoCaus(attr[19].stringValue());
                    else
                        pk.setCodTipoCaus(new String(""));
                        //13-02-03 VITI
                   if (attr[20]!=null)
                        pk.setCodTipoOpz(attr[20].stringValue());
                    else
                        pk.setCodTipoOpz(new String(""));
                    if (attr[21]!=null)
                        pk.setDescTipoOpz(attr[21].stringValue());
                    else
                        pk.setDescTipoOpz(new String(""));

                    if (attr[22]!=null)
                        pk.setDescPs(attr[22].stringValue());
                    else
                        pk.setDescPs(new String(""));
                   recs.add(pk);
                }
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

         StaticMessages.setCustomString(ee.toString());
         StaticContext.writeLog(StaticMessages.getMessage(1001,"Controller","","",StaticContext.APP_SERVER_DRIVER));
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


public String getImpTarStr()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getImpTarStr();
  }

  public void setImpTarStr(String impTar)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setImpTarStr(impTar);
    enableStore=true;
  }

 
  public int getCodePromozione()
  {
      pk = (TariffaBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) 
        return 0;
      else
        return pk.getCodePromozione();
  }

  public void setCodePromozione(int codePromozione)
  {

		pk = (TariffaBMPPK) ctx.getPrimaryKey();
		pk.setCodePromozione(codePromozione);
    enableStore=true;
  }


}