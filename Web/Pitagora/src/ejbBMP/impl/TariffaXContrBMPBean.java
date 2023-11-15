package com.ejbBMP.impl;
import java.util.*;
import java.rmi.*;
import java.sql.*;
import java.lang.*;
import java.text.*;
import javax.ejb.*;
import javax.naming.*;
import com.utl.*;
import oracle.jdbc.*;
import oracle.sql.*;
import com.utl.*;
import com.utl.*;
import java.util.Collection;
import com.ejbBMP.TariffaXContrBMPPK;

public class TariffaXContrBMPBean extends AbstractEntityCommonBean implements EntityBean 
{
  public EntityContext entityContext;

  private TariffaXContrBMPPK pk;
  private boolean enableStore=false;
  private int errore;

  public TariffaXContrBMPPK ejbFindByPrimaryKey(TariffaXContrBMPPK primaryKey) throws FinderException, RemoteException
  {
  Connection conn=null;  
  pk = new TariffaXContrBMPPK();
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_DETTAGLIO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); //03-03-03

       // Impostazione types I/O
      cs.setString(1,primaryKey.getCodContr());   
      cs.setString(2,primaryKey.getCodTar());
      cs.setString(3,primaryKey.getProgTar());
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
      cs.registerOutParameter(16,Types.VARCHAR);      
      cs.registerOutParameter(17,Types.DOUBLE);
      cs.registerOutParameter(18,Types.VARCHAR);
      cs.registerOutParameter(19,Types.VARCHAR);      
      cs.registerOutParameter(20,Types.VARCHAR); //03-03-03
      cs.registerOutParameter(21,Types.VARCHAR); //03-03-03     
      cs.registerOutParameter(22,Types.INTEGER);
      cs.registerOutParameter(23,Types.VARCHAR);
      cs.execute();

//      if ((cs.getInt(20)!=DBMessage.OK_RT)&&(cs.getInt(20)!=DBMessage.NOT_FOUND_RT))
//        throw new Exception("DB:"+cs.getInt(20)+":"+cs.getString(21));
//
 //     if (cs.getInt(20)==DBMessage.NOT_FOUND_RT)
 //       throw new FinderException("Tariffa non trovata:"+primaryKey);
//
     pk.setCodTar(primaryKey.getCodTar());
     pk.setProgTar(primaryKey.getProgTar());
     pk.setCodContr(primaryKey.getCodContr());     
     pk.setCodUM(cs.getString(4));         
     pk.setDataIniValAssOfPs(cs.getString(5));
     pk.setCodOf(cs.getString(6));   
     pk.setDataIniValOf(cs.getString(7));     
     pk.setCodPs(cs.getString(8));
     pk.setFlgMat(cs.getString(9));
     pk.setCodTipoCaus(cs.getString(10));    
     pk.setCodClSc(cs.getString(11));    
     pk.setPrClSc(cs.getString(12));        
     pk.setCodTipoOf(cs.getString(13));    
     pk.setDataIniTar(cs.getString(14));    
     pk.setDataFineTar(cs.getString(15));         
     pk.setDescTar(cs.getString(16));         
     pk.setImpTar(new Double (cs.getDouble(17)));   
     pk.setCausFatt(cs.getString(18));    
     pk.setFlgProvv(cs.getString(19));
     pk.setCodTipoOpz(cs.getString(20)); //05-03-03
     pk.setDescTipoOpz(cs.getString(21)); //03-03-03

     cs.close();
     // Chiudo la connessione
     conn.close();
    }
    catch(Exception lexc_Exception)
      {
       throw new CustomEJBException(lexc_Exception.toString(),
       "Errore di inserimento nella store procedure PKG_BILL_SPE.TARIFFA_X_CONTR_DETTAGLIO",
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

  public void ejbPostCreate(String codContr, String codTar, String progTar, String codUM, String codUt, String dataIniValAssOfPs, String codOf, String dataIniValOf, String codPs, String dataIniTar, String dataFineTar, String descTar, Double impTar, String flgMat, String codClSc, String prClSc, String causFatt,String tipoOpz)
  {
  }

  public void ejbActivate()
  {
  }

  public void ejbLoad()
  {
  }

  public void ejbPassivate()
  {
  }

/*  public void setEntityContext(EntityContext ctx)
  {
    this.entityContext = ctx;
  }

  public void unsetEntityContext()
  {
    this.entityContext = null;
  }
*/

//METODO PER IL CARICAMENTO DELLA LISTA DELLE TARIFFE X CONTR
 public Collection ejbFindAll(String CodContr, String CodPs, String CodOf, String CausBill,String CodTipoOpz) throws FinderException, RemoteException
	{
  if (CausBill=="")
      CausBill=null;

  //03-03-03
  if (CodTipoOpz=="")
     CodTipoOpz=null;

    Vector recs = new Vector();
   	try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_LST_RECENTI(?,?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodContr);
      cs.setString(2,CodPs);
      cs.setString(3,CodOf);
      cs.setString(4,CausBill);
      cs.setString(5,CodTipoOpz);  //03-03-03
      cs.registerOutParameter(6,OracleTypes.ARRAY, "ARR_TARIFFE_DETT");
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);
      cs.execute();

      //Se il DB ritorna "Data not found" qualcosa è andato storto!!!
      if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
      {
            throw new Exception("DB:"+cs.getInt(7)+":"+cs.getString(8)+"NOME STORED: TARIFFA_X_CONTR_LST_RECENTI");
      }

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_TARIFFE_DETT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(6);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new TariffaXContrBMPPK();
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
      StaticContext.writeLog(StaticMessages.getMessage(5002,"TariffaXContrBMPBean","","",StaticContext.APP_SERVER_DRIVER));
      e.printStackTrace();
      throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
      StaticMessages.setCustomString(ee.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5003,"TariffaXContrBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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
//fine METODO PER IL CARICAMENTO DELLA LISTA DELLE TARIFFE X CONTR
public Collection ejbFindTariffa(String CodContr, String CodTar, String CodOf, String CausBill) throws FinderException, RemoteException
{
  //modifica opzioni 18-02-03 inizio
  //il dato CodTipoContr è stato solo aggiunto nell'interfaccia (per avere compilazione ok) ma non gestito. 
  //la gestione verrà effettuata in seguito
Vector recs = new Vector();
 	try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".TARIFFA_X_CONTR_LST_PROMO(?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodContr);
      cs.setString(2,CodTar);
      cs.setString(3,CodOf);
      cs.setString(4,CausBill);
    
      cs.registerOutParameter(5,OracleTypes.ARRAY, "ARR_TARIFFE_DETT_2");
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.execute();

      if (cs.getInt(6)!=DBMessage.OK_RT)
          throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7)+"NOME STORED: TARIFFA_LST_STORIA");

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_TARIFFE_DETT_2",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(5);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new TariffaXContrBMPPK();

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

    return recs;
}


    public Collection ejbFindTariffaClus(String CodContr, String CodTar, String CodOf, String CausBill, String i_code_contr_listino,String i_code_cluster_listino, String i_tipo_cluster_listino) throws FinderException, RemoteException
    {
      //modifica opzioni 18-02-03 inizio
      //il dato CodTipoContr è stato solo aggiunto nell'interfaccia (per avere compilazione ok) ma non gestito. 
      //la gestione verrà effettuata in seguito
    Vector recs = new Vector();
            try
                    {
                            conn = getConnection(dsName);
          OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".TARIFFA_X_CONTR_LST_PROMO_CLU(?,?,?,?,?,?,?,?,?,?)}");

          // Impostazione types I/O
          cs.setString(1,CodContr);
          cs.setString(2,CodTar);
          cs.setString(3,CodOf);
          cs.setString(4,CausBill);
            cs.setString(5,i_code_contr_listino);
            cs.setString(6,i_code_cluster_listino);
            cs.setString(7,i_tipo_cluster_listino);
            
          cs.registerOutParameter(8,OracleTypes.ARRAY, "ARR_TARIFFE_DETT_2");
          cs.registerOutParameter(9,Types.INTEGER);
          cs.registerOutParameter(10,Types.VARCHAR);
          cs.execute();

          if (cs.getInt(9)!=DBMessage.OK_RT)
              throw new Exception("DB:"+cs.getInt(9)+":"+cs.getString(10)+"NOME STORED: TARIFFA_LST_STORIA");

          // Costruisco l'array che conterrà i dati di ritorno della stored
          ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_TARIFFE_DETT_2",conn);
          ARRAY rs = new ARRAY(ad, conn, null);

          // Ottengo i dati
          rs=cs.getARRAY(8);
          Datum dati[]=rs.getOracleArray();

          // Estrazione dei dati
          for (int i=0;i<dati.length;i++)
              {
                  pk = new TariffaXContrBMPPK();

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

        return recs;
    }



//METODO PER IL CARICAMENTO DELLA LISTA DI DETTAGLIO DELLE TARIFFE PER CONTRATTO
public Collection ejbFindDettaglio(String CodContr, String CodTar, String CodOf, String CausBill, String CodTipoOpz) throws FinderException, RemoteException
{
  //modifica opzioni 18-02-03 inizio
  //il dato CodTipoContr è stato solo aggiunto nell'interfaccia (per avere compilazione ok) ma non gestito. 
  //la gestione verrà effettuata in seguito
Vector recs = new Vector();
 	try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_LST_STORIA(?,?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodContr);
      cs.setString(2,CodTar);
      cs.setString(3,CodOf);
      cs.setString(4,CausBill);
      cs.setString(5,CodTipoOpz);
      cs.registerOutParameter(6,OracleTypes.ARRAY, "ARR_TARIFFE_DETT");
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);
      cs.execute();

      if (cs.getInt(7)!=DBMessage.OK_RT)
          throw new Exception("DB:"+cs.getInt(7)+":"+cs.getString(8)+"NOME STORED: TARIFFA_LST_STORIA");

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_TARIFFE_DETT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(6);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new TariffaXContrBMPPK();

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

public TariffaXContrBMPPK ejbFindUnitaMisuraDettXTarXContr(String codTar, String progTar) throws FinderException, RemoteException
  {
  TariffaXContrBMPPK pk = new TariffaXContrBMPPK();
  Connection conn=null;
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".UNITA_MISURA_DETT_X_CONTR(?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codTar);
      cs.setString(2,progTar);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5)+"NOME STORED: UNITA_MISURA_DETT_X_CONTR");
      pk.setDescUM(cs.getString(3));
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
//
    catch(SQLException e)
		{
      StaticMessages.setCustomString(e.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5002,"TariffaXContrBMPBean","","",StaticContext.APP_SERVER_DRIVER));
      e.printStackTrace();
			throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
      StaticMessages.setCustomString(ee.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5003,"TariffaXContrBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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



public TariffaXContrBMPPK ejbFindTarXContrVerProvv(String codTar, String progTar) throws FinderException, RemoteException        
{

  TariffaXContrBMPPK pk = new TariffaXContrBMPPK();
  Connection conn=null;  

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_VER_PROVV(?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codTar);       
      cs.setString(2,progTar);      
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5)+"NOME STORED: TARIFFA_X_CONTR_VER_PROVV");

      pk.setNumTarProvvisor(new Integer(cs.getInt(3)));      

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(SQLException e)
		{
      StaticMessages.setCustomString(e.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5002,"TariffaXContrBMPBean","","",StaticContext.APP_SERVER_DRIVER));
      e.printStackTrace();
			throw new FinderException(e.getMessage());
		} 
    catch(Exception ee)
		{
      StaticMessages.setCustomString(ee.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5003,"TariffaXContrBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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


public TariffaXContrBMPPK ejbFindTarXContrVerDisatt(String codTar, String progTar) throws FinderException, RemoteException        
{
  TariffaXContrBMPPK pk = new TariffaXContrBMPPK();
  Connection conn=null;  
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_VER_DISATTIVA(?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codTar);       
      cs.setString(2,progTar);      
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT))//&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5)+"NOME STORED: TARIFFA_X_CONTR_VER_DISATTIVA");

      pk.setNumTarDisattive(new Integer(cs.getInt(3)));      

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(SQLException e)
		{
      StaticMessages.setCustomString(e.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5002,"TariffaXContrBMPBean","","",StaticContext.APP_SERVER_DRIVER));
      e.printStackTrace();
			throw new FinderException(e.getMessage());
		} 
    catch(Exception ee)
		{
      StaticMessages.setCustomString(ee.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5003,"TariffaXContrBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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

  public void ejbStore() throws RemoteException, CustomEJBException
  {
  if (enableStore)
  {
    enableStore = false;
    pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();

   Connection conn=null;  

    try
      {
         conn = getConnection(dsName);
         OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_AGGIORNA(?,?,?,?,?)}");         
 
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
  } 
}


  public TariffaXContrBMPPK ejbFindTarXContrVerEsAtt(String codPs, String codOf, String codContr) throws FinderException, RemoteException    
  {
  
  TariffaXContrBMPPK pk = new TariffaXContrBMPPK();
  Connection conn=null;  
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_VER_ES_ATT (?,?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codPs);
      cs.setString(2,codOf);      
      cs.setString(3,codContr);            
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6)+"NOME STORED: TARIFFA_X_CONTR_VER_ES_ATT");

      pk.setNumTariffe(new Integer(cs.getInt(4)));
    
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
catch(SQLException e)
		{
      StaticMessages.setCustomString(e.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5002,"TariffaXContrBMPBean","","",StaticContext.APP_SERVER_DRIVER));
      e.printStackTrace();
			throw new FinderException(e.getMessage());
		} 
    catch(Exception ee)
		{
      StaticMessages.setCustomString(ee.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5004,"TariffaXContrBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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


 public TariffaXContrBMPPK ejbFindTarXContrMaxDataFine(String codPs, String codOf, String codContr) throws FinderException, RemoteException      
  {
  TariffaXContrBMPPK pk = new TariffaXContrBMPPK();
  Connection conn=null;  

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_MAX_DATA_FINE(?,?,?,?,?,?)}");      

       // Impostazione types I/O
      cs.setString(1,codPs);
      cs.setString(2,codOf);      
      cs.setString(3,codOf);            
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(5)!=DBMessage.OK_RT))//&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6)+"NOME STORED: TARIFFA_X_CONTR_MAX_DATA_FINE");

      pk.setDataFineTar(cs.getString(4));      
    
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(SQLException e)
		{
      StaticMessages.setCustomString(e.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5002,"TariffaXContrBMPBean","","",StaticContext.APP_SERVER_DRIVER));
      e.printStackTrace();
			throw new FinderException(e.getMessage());
		} 
    catch(Exception ee)
		{
      StaticMessages.setCustomString(ee.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5004,"TariffaXContrBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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


 public TariffaXContrBMPPK  ejbFindAssocOfpsXContrDisat(String dataFineValAssOfPs, String codOf, String dataIniValOf, String dataIniValAssOfPs, String codPs, String codContr) throws FinderException, RemoteException        
  {
  TariffaXContrBMPPK pk = new TariffaXContrBMPPK();
  Connection conn=null;  
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_DISATTIVA(?,?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,dataFineValAssOfPs);       
      cs.setString(2,codOf);        
      cs.setString(3,dataIniValOf); 
      cs.setString(4,dataIniValAssOfPs);       
      cs.setString(5,codPs);
      cs.setString(6,codContr);      
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(7)!=DBMessage.OK_RT))//&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(7)+":"+cs.getString(8)+"NOME STORED: ASSOC_OFPS_X_CONTR_DISATTIVA");
  
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(SQLException e)
		{
      StaticMessages.setCustomString(e.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5002,"TariffaXContrBMPBean","","",StaticContext.APP_SERVER_DRIVER));
      e.printStackTrace();
			throw new FinderException(e.getMessage());
		} 
    catch(Exception ee)
		{
      StaticMessages.setCustomString(ee.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5003,"TariffaXContrBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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


  public void ejbRemove(TariffaXContrBMPPK pk) throws FinderException, RemoteException,CustomEJBException
  {
    Connection conn=null;  
    try
    {
      //deleteRow(pk); 
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_CANCELLA(?,?,?,?)}");       

       // Impostazione types I/O
      cs.setString(1,pk.getCodTar());
      cs.setString(2,pk.getProgTar());
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.execute();

//      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
//        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));
//
//      if (cs.getInt(4)==DBMessage.NOT_FOUND_RT)
//        throw new FinderException("Tariffa non trovata:"+primaryKey);
// 
      cs.close();
      // Chiudo la connessione
      conn.close();
    }

    catch(Exception lexc_Exception)
      {
    throw new CustomEJBException(lexc_Exception.toString(),
       "Errore di inserimento nella store procedure PKG_BILL_SPE.TARIFFA_X_CONTR_CANCELLA",
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
//Valeria fine 19-09-02      
  }

  public TariffaXContrBMPPK ejbFindMaxPrgTarXContr(String codTar) throws FinderException, RemoteException, FinderException
  {
  TariffaXContrBMPPK pk = new TariffaXContrBMPPK();
  Connection conn=null;  

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_MAX_PRG(?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codTar);       
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

//      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
//        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));
//
//      if (cs.getInt(3)==DBMessage.NOT_FOUND_RT)
//        throw new FinderException("Descrizione non trovata"+primaryKey);
//
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


  public TariffaXContrBMPPK ejbFindAlm1TarXContrProvv(String codTar) throws FinderException, RemoteException
  {
   TariffaXContrBMPPK pk = new TariffaXContrBMPPK();
   Connection conn=null;  

   try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_VER_ALM_1_PROV(?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codTar);       
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

//      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
//        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));
//
//      if (cs.getInt(3)==DBMessage.NOT_FOUND_RT)
//        throw new FinderException("Descrizione non trovata"+primaryKey);
//
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

  public Collection ejbFindTarXContrLeggiProvv(String CodTar) throws FinderException, RemoteException
  {
  Vector recs = new Vector();
 	try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_LEGGI_PROVV(?,?,?,?)}");        

      // Impostazione types I/O
      cs.setString(1,CodTar);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_TAR_PROVV");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      
      cs.execute();

//      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
//        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_TAR_PROVV",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new TariffaXContrBMPPK();

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
                  pk.setDataFineTar(attr[3].stringValue());
              else
                  pk.setDataFineTar("");

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

  public TariffaXContrBMPPK ejbCreate(String codContr, String codTar, String progTar, String codUM, String codUt, String dataIniValAssOfPs, String codOf, String dataIniValOf, String codPs, String dataIniTar, String dataFineTar, String descTar, Double impTar, String flgMat, String codClSc, String prClSc, String causFatt,String codTipoOpz) throws CreateException, RemoteException 
  {


      try
      {
      conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_INSERISCI(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
       
      // Impostazione types I/O
      cs.setString(1,codContr);      
      cs.setString(2,codTar);
      cs.setString(3,progTar);
      cs.setString(4,codUM);
      cs.setString(5,codUt);
      cs.setString(6,dataIniValAssOfPs);
      cs.setString(7,codOf);
      cs.setString(8,dataIniValOf);
      cs.setString(9,codPs);
      cs.setString(10,dataIniTar);
      cs.setString(11,dataFineTar);
      cs.setString(12,descTar);
      cs.setDouble(13,impTar.doubleValue());
      cs.setString(14,flgMat);
      cs.setString(15,codClSc);
      cs.setString(16,prClSc);
      cs.setString(17,causFatt);
      cs.setString(18,codTipoOpz);  
      
      cs.registerOutParameter(19,Types.INTEGER);
      cs.registerOutParameter(20,Types.VARCHAR);
      
      cs.execute();

      if ((cs.getInt(19)!=DBMessage.OK_RT))
      {
       
        throw new Exception("DB:"+cs.getInt(19)+":"+cs.getString(20)+"NOME STORED: TARIFFA_X_CONTR_INSERISCI");
      }

      pk=new TariffaXContrBMPPK(codContr, codTar, progTar, codUM, codUt, dataIniValAssOfPs, codOf, dataIniValOf, codPs, dataIniTar, dataFineTar, descTar, impTar, flgMat, codClSc, prClSc, causFatt, codTipoOpz,0);
                          

     conn.close();

      }
//inserita la nuova gestione delle eccezioni
    catch(Exception lexc_Exception)
      {
  throw new CustomEJBException(lexc_Exception.toString(),
       "Errore di inserimento nella store procedure PKG_BILL_SPE.TARIFFA_X_CONTR_INSERISCI",
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

//METODO PER IL CALCOLO DEL CODICE PER INSERIMENTO TARIFFA X CONTRATTO
 public TariffaXContrBMPPK ejbFindCalcolaCodiceXContr() throws FinderException, RemoteException
	{
   TariffaXContrBMPPK pk =new TariffaXContrBMPPK();
 	 try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_CALC_CODICE(?,?,?)}");
      // Impostazione types I/O
      cs.registerOutParameter(1,Types.VARCHAR);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(2)!=DBMessage.OK_RT)&&(cs.getInt(2)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(2)+":"+cs.getString(3));
      
      pk.setCodTar(cs.getString(1));

      cs.close();
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

  public TariffaXContrBMPPK ejbFindOfMaxDataIniOfPsXContr(String codeContr, String codOf, String codPs) throws FinderException, RemoteException      
  {
  TariffaXContrBMPPK pk = new TariffaXContrBMPPK();
  Connection conn=null;  
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_MAX_INI_VAL(?,?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codeContr);
      cs.setString(2,codOf);
      cs.setString(3,codPs);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

//      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
//        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));
//
//      if (cs.getInt(4)==DBMessage.NOT_FOUND_RT)
//        throw new FinderException("Descrizione non trovata"+primaryKey);
//
      if (cs.getString(4) !=null)
         pk.setDataIniValAssOfPs(cs.getString(4));      

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

  public TariffaXContrBMPPK ejbFindNumTarXContr(String codTipoContr,String codeContr,String codePs) throws FinderException, RemoteException      
  {
  TariffaXContrBMPPK pk = new TariffaXContrBMPPK();
  Connection conn=null;  

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".PS_VER_TAR_X_CONTR_DA_ACQ(?,?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codTipoContr);
      cs.setString(2,codeContr);
      cs.setString(3,codePs);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

//      if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
//        throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6));
//
//      if (cs.getInt(4)==DBMessage.NOT_FOUND_RT)
//        throw new FinderException("Descrizione non trovata"+primaryKey);
//
      pk.setNumTariffe(new Integer(cs.getInt(4)));

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

public TariffaXContrBMPPK ejbFindTariffaXContrGestCanc(String codTar, String progTar) throws FinderException, RemoteException
{
  TariffaXContrBMPPK pk = new TariffaXContrBMPPK();
  Connection conn=null;  

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_GEST_CANC(?,?,?,?)}");

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

public TariffaXContrBMPPK ejbFindTariffaXContrGestDis(String codTar, String progTar, String dataFineTar, String codPs, String codOf, String dataIniValOf, String dataIniValAssOfPs) throws FinderException, RemoteException
{
  TariffaXContrBMPPK pk = new TariffaXContrBMPPK();
  Connection conn=null;  

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_GEST_DIS(?,?,?,?,?,?,?,?,?)}");

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

public TariffaXContrBMPPK ejbFindTariffaXContrAggConProvv(String codTar, String dataIniTarDigitata, String descTar, Double impTar, String codUt, int inserimento) throws FinderException, RemoteException
{
  TariffaXContrBMPPK pk = new TariffaXContrBMPPK();
  Connection conn=null;  

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs;
      if (inserimento == 0){
        cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_AGG_CON_PROVV(?,?,?,?,?,?,?)}");
      }else{
        cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_INS_CON_PROVV(?,?,?,?,?,?,?)}");
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

public TariffaXContrBMPPK ejbFindTariffaXContrAggNoProvv(String codContr, String codTar, String progTar, String dataFineTarDigitata, String codUM, String dataIniValAssOfPs, String codOf, String dataIniValOf, String codPs, String flgMat, String codTipoCaus, String codClSc, String prClSc, String codTipoOf, String dataIniTar, String dataFineTar, String descTar, Double impTar, String causFatt, String flgProvv, String codUt,String codTipoOpz) throws FinderException, RemoteException
{
  TariffaXContrBMPPK pk = new TariffaXContrBMPPK();
  Connection conn=null;  

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_AGG_NO_PROVV(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,codContr);       
      cs.setString(2,codTar);       
      cs.setString(3,progTar);           
      cs.setString(4,dataFineTarDigitata);       
      cs.setString(5,codUM);    
      cs.setString(6,dataIniValAssOfPs);
      cs.setString(7,codOf);          
      cs.setString(8,dataIniValOf);                
      cs.setString(9,codPs);                
      cs.setString(10,flgMat);                      
      cs.setString(11,codTipoCaus);                      
      cs.setString(12,codClSc);                      
      cs.setString(13,prClSc);                
      cs.setString(14,codTipoOf);                
      cs.setString(15,dataIniTar);                      
      cs.setString(16,dataFineTar);                      
      cs.setString(17,descTar);    
      cs.setDouble(18,impTar.doubleValue());      
      cs.setString(19,causFatt);                
      cs.setString(20,flgProvv);                      
      cs.setString(21,codUt);
      cs.setString(22,codTipoOpz);
      cs.registerOutParameter(23,Types.INTEGER);
      cs.registerOutParameter(24,Types.VARCHAR);

      cs.execute();

      if (cs.getInt(23)!=DBMessage.OK_RT)
        throw new Exception("DB:"+cs.getInt(23)+":"+cs.getString(24));

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


//METODI SET - GET inizio
public String getCodContr()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getCodContr();
  }

  public void setCodContr(String codContr)
  {

		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setCodContr(codContr);
    enableStore=true;
  }
  

  public void setDescContr(String descContr)
  {

		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setDescContr(descContr);
    enableStore=true;
  }

  public String getDescContr()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getDescContr();
  }


  public void setDescEsP(String descEsP)
  {

		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setDescEsP(descEsP);
    enableStore=true;
  }

  public String getDescEsP()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getDescEsP();
  }

  public String getCodTar()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getCodTar();
  }

  public void setCodTar(String codTar)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setCodTar(codTar);
    enableStore=true;
  }


  public String getProgTar()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
     //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getProgTar();
  }

  public void setProgTar(String progTar)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setProgTar(progTar);
    enableStore=true;
  }



  public String getCodUM()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getCodUM();
  }

  public void setCodUM(String codUM)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setCodUM(codUM);
    enableStore=true;
  }


  public String getCodUt()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getCodUt();
  }

  public void setCodUt(String codUt)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setCodUt(codUt);
    enableStore=true;
  }


  public String getDataIniValAssOfPs()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getDataIniValAssOfPs();
  }

  public void setDataIniValAssOfPs(String dataIniValAssOfPs)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setDataIniValAssOfPs(dataIniValAssOfPs);
    enableStore=true;
  }


  public String getCodOf()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getCodOf();
  }

  public void setCodOf(String codOf)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setCodOf(codOf);
    enableStore=true;
  }

  public String getDescOf()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null;
      else
        return pk.getDescOf();
  }

  public void setDescOf(String descOf)
  {

		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setDescOf(descOf);
    enableStore=true;
  }

  public String getDataIniValOf()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else return pk.getDataIniValOf();
  }

  public void setDataIniValOf(String dataIniValOf)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setDataIniValOf(dataIniValOf);
    enableStore=true;
  }



  public String getCodPs()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getCodPs();
  }

  public void setCodPs(String codPs)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setCodPs(codPs);
    enableStore=true;
  }


  public String getDataIniTar()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getDataIniTar();
  }

  public void setDataIniTar(String dataIniTar)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setDataIniTar(dataIniTar);
    enableStore=true;
  }

  public String getDataFineTar()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getDataFineTar();
  }

  public void setDataFineTar(String dataFineTar)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setDataFineTar(dataFineTar);
    enableStore=true;
  }



  public String getDescTar()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getDescTar();
  }

  public void setDescTar(String descTar)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setDescTar(descTar);
    enableStore=true;
  }



  public void setDescTipoCaus(String descTipoCaus)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setDescTipoCaus(descTipoCaus);
    enableStore=true;
  }
  public String getDescTipoCaus()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getDescTipoCaus();
  }
  public void setDescUM(String descUM)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setDescUM(descUM);
    enableStore=true;
  }
  public String getDescUM()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getDescUM();
  }



  public Double getImpTar()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else return pk.getImpTar();
  }

  public void setImpTar(Double impTar)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setImpTar(impTar);
    enableStore=true;
  }


public Double getImpMaxSps()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getImpMaxSps();
  }

  public void setImpMaxSps(Double impMaxSps)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setImpMaxSps(impMaxSps);
    enableStore=true;
  }

public Double getImpMinSps()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getImpMinSps();
  }

  public void setImpMinSps(Double impMinSps)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setImpMaxSps(impMinSps);
    enableStore=true;
  }



  public String getFlgMat()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getFlgMat();
  }

  public void setFlgMat(String flgMat)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setFlgMat(flgMat);
    enableStore=true;
  }



  public String getCodClSc()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getCodClSc();
  }

  public void setCodClSc(String codClSc)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setCodClSc(codClSc);
    enableStore=true;
  }



  public String getCausFatt()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getCausFatt();
  }

  public void setCausFatt(String causFatt)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setCausFatt(causFatt);
    enableStore=true;
  }



  public String getCodFascia()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getCodFascia();
  }

  public void setCodFascia(String codFascia)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setCodFascia(codFascia);
    enableStore=true;
  }



  public String getCodPrFascia()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getCodPrFascia();
  }

  public void setCodPrFascia(String codPrFascia)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setCodPrFascia(codPrFascia);
    enableStore=true;
  }



  public String getCodTipoCaus()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getCodTipoCaus();
  }

  public void setCodTipoCaus(String codTipoCaus)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setCodTipoCaus(codTipoCaus);
    enableStore=true;
  }



  public String getCodTipoOf()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getCodTipoOf();
  }

  public void setCodTipoOf(String codTipoOf)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setCodTipoOf(codTipoOf);
    enableStore=true;
  }



  public String getPrClSc()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getPrClSc();
  }

  public void setPrClSc(String prClSc)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setPrClSc(prClSc);
    enableStore=true;
  }



  public String getFlgCongRe()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getFlgCongRe();
  }

  public void setFlgCongRe(String flgCongRe)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setFlgCongRe(flgCongRe);
    enableStore=true;
  }
  
  


  public String getDataCreazTar()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getDataCreazTar();
  }

  public void setDataCreazTar(String dataCreazTar)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setDataCreazTar(dataCreazTar);
    enableStore=true;
  }



  public String getFlgProvv()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getFlgProvv();
  }

  public void setFlgProvv(String flgProvv)
  {
    
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setFlgProvv(flgProvv);
    enableStore=true;
  }

  
  public void setNumTariffe(Integer numTariffe)
  {
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setNumTariffe(numTariffe);
    //Valeria inizio 02-09-02
    //non serve chiamare TARIFFA_AGGIORNA
    //enableStore=true;
    //Valeria fine 02-09-02
  }
  
  public Integer getNumTariffe()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getNumTariffe();
  }

  public void setDataFineValAssOfPs(String dataFineValAssOfPs)
  {
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setDataFineValAssOfPs(dataFineValAssOfPs);
    enableStore=true;
  } 
  
  public String getDataFineValAssOfPs()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else return pk.getDataFineValAssOfPs();
  } 


  public void setNumElaborazTrovate(Integer numElaborazTrovate)
  {
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setNumElaborazTrovate(numElaborazTrovate);
    //Valeria inizio 02-09-02
    //qui enableStore non serve (per TARIFFA_AGGIORNA)
    //enableStore=true;
    //Valeria fine 02-09-02
  } 
  
  public Integer getNumElaborazTrovate()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getNumElaborazTrovate();
  } 


  public void setCodePromozione(int codePromozione)
  {
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setCodePromozione(codePromozione);
    //Valeria inizio 02-09-02
    //qui enableStore non serve (per TARIFFA_AGGIORNA)
    //enableStore=true;
    //Valeria fine 02-09-02
  } 
  
  public int getCodePromozione()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return 0; 
      else
        return pk.getCodePromozione();
  } 

 

  public void setNumTarDisattive(Integer numTarDisattive)
  {
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setNumTarDisattive(numTarDisattive);
    enableStore=true;
  } 
  
  public Integer getNumTarDisattive()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getNumTarDisattive();

  } 

  public void setNumTarProvvisor(Integer numTarProvvisor)
  {
 		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setNumTarProvvisor(numTarProvvisor);
    enableStore=true;
  } 
  
  public Integer getNumTarProvvisor()
  {
      pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
      //enableStore=false;
      if (pk==null) return null; 
      else
        return pk.getNumTarProvvisor();
  } 

//METODI SET - GET fine


  public void setDataIniTarDigitata(String dataIniTarDigitata)
  {
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setDataIniTarDigitata(dataIniTarDigitata);
    //enableStore=true;
  }

  public String getDataIniTarDigitata()
  {
    pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
    //enableStore=false;
    if (pk==null) return null; 
    else
      return pk.getDataIniTarDigitata();
    
  }
  
//inizio 24-02-03
  public void setCodTipoOpz(String codTipoOpz)
  {
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setCodTipoOpz(codTipoOpz);
    //enableStore=true;
  }

  public String getCodTipoOpz()
  {
    pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
    //enableStore=false;
    if (pk==null) return null;
    else
      return pk.getCodTipoOpz();
  }
  public void setDescTipoOpz(String descTipoOpz)
  {
		pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
		pk.setDescTipoOpz(descTipoOpz);
    //enableStore=true;
  }

  public String getDescTipoOpz()
  {
    pk = (TariffaXContrBMPPK) ctx.getPrimaryKey();
    //enableStore=false;
    if (pk==null) return null;
    else
      return pk.getDescTipoOpz();
  }
//fine 24-02-03  

  public TariffaXContrBMPPK ejbFindTariffaUnicaXContr(String codContr,String codTar) throws  RemoteException, FinderException
{
  TariffaXContrBMPPK pk = new TariffaXContrBMPPK();
  Connection conn=null;

  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_UNA(?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,codContr);
      cs.setString(2,codTar);
      
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
      pk.setNumTarProvvisor(new Integer(cs.getInt(3)));

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

public TariffaXContrBMPPK ejbFindTariffaAggiornaUnicaProvvXContr(String codContr,String codTar, String dataIniTarDigitata, String descTar, Double impTar, String codUt) throws FinderException, RemoteException
{
  TariffaXContrBMPPK pk = new TariffaXContrBMPPK();
  Connection conn=null;
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs;
      cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_UNA_AGG_PROVV(?,?,?,?,?,?,?,?)}");
       // Impostazione types I/O
      cs.setString(1,codContr);
      cs.setString(2,codTar);
      cs.setString(3,dataIniTarDigitata);
      cs.setString(4,descTar);
      cs.setDouble(5,impTar.doubleValue());
      cs.setString(6,codUt);
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);

      cs.execute();

      pk.setNumTarProvvisor(new Integer(cs.getInt(7)));

      if (cs.getInt(7)!=DBMessage.OK_RT && cs.getInt(7)!=1)
        throw new Exception("DB:"+cs.getInt(7)+":"+cs.getString(8));
      
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

public TariffaXContrBMPPK ejbFindTariffaAggiornaUnicaXContr(String codContr,String codTar, String dataIniTarDigitata, String descTar, Double impTar, String codUt) throws FinderException, RemoteException
{
  TariffaXContrBMPPK pk = new TariffaXContrBMPPK();
  Connection conn=null;
  try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs;
      cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_UNA_AGG(?,?,?,?,?,?,?,?)}");
       // Impostazione types I/O
      cs.setString(1,codContr);
      cs.setString(2,codTar);
      cs.setString(3,dataIniTarDigitata);
      cs.setString(4,descTar);
      cs.setDouble(5,impTar.doubleValue());
      cs.setString(6,codUt);
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);
      cs.execute();
      pk.setNumTarProvvisor(new Integer(cs.getInt(7)));
      if (cs.getInt(7)!=DBMessage.OK_RT && cs.getInt(7)!=1)
        throw new Exception("DB:"+cs.getInt(7)+":"+cs.getString(8)); 
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
  
}