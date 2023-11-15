package com.ejbBMP.impl;
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
import com.ejbBMP.ColocationBMPPK;

public class ColocationBMPBean extends AbstractEntityCommonBean implements EntityBean 
{
  public EntityContext entityContext;

  private ColocationBMPPK pk;
  private boolean enableStore=false;
  private Integer errore;


  public ColocationBMPPK ejbCreate(String code_utente,String sitoSelez, String accountSelez, String data_ini, Double imptar, Double impcons, int mod_ull, int mod_itc,String[] eleCodePs,String[] eleQtaPs)
  throws CreateException, RemoteException, CustomEJBException
  {
    try
      {
     //System.out.println("CREATE impcons "+impcons);
      conn = getConnection(dsName);

      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.TARIFFA_X_SITO_INSERISCI(?,?,?,?,?,?,?,?)}");  
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_SITO_INSERISCI(?,?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,code_utente);
      cs.setString(2,sitoSelez);
      cs.setString(3,accountSelez);
      cs.setString(4,data_ini);
      if (imptar!=null)
        cs.setDouble(5,imptar.doubleValue());
      else  
        cs.setDouble(5,0);
      if (impcons!=null) 
        cs.setDouble(6,impcons.doubleValue());
      else
        cs.setDouble(6,0);
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
        throw new EJBException("DB:"+cs.getInt(7)+":"+cs.getString(8));
 
      pk=new ColocationBMPPK(code_utente,sitoSelez,accountSelez,data_ini,
                          imptar,impcons);

      String CodePs="";
      //MMM 24/10/02 inizio
        //int QtaPs = 0;
        Double QtaPs = new Double((double)0);
      //MMM 24/10/02 fine        

      
      for (int jj=0;jj<eleCodePs.length;jj++)
      {
        CodePs= eleCodePs[jj];
        if (eleQtaPs[jj]!=null && !eleQtaPs[jj].equals("") && !eleQtaPs[jj].equals("0") && !eleQtaPs[jj].equals("-1") )
        {
          //MMM 24/10/02 inizio
            //QtaPs= new Integer(eleQtaPs[jj]).intValue();
            QtaPs= new Double(eleQtaPs[jj].replace(',','.'));
          //MMM 24/10/02 fine
          
            //cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.INVENT_PS_SP_INSERISCI(?,?,?,?,?,?,?,?,?,?)}");  
            cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".INVENT_PS_SP_INSERISCI(?,?,?,?,?,?,?,?,?,?)}");

            // Impostazione types I/O
            cs.setString(1,code_utente);
            cs.setString(2,sitoSelez);
            cs.setString(3,accountSelez);
            cs.setString(4,data_ini);
            cs.setInt(5,mod_ull);
            cs.setInt(6,mod_itc);
            cs.setString(7,CodePs);
            //MMM 24/10/02 inizio            
              //cs.setInt(8,QtaPs);
              cs.setDouble(8,QtaPs.doubleValue());
            ////MMM 24/10/02 fine
            cs.registerOutParameter(9,Types.INTEGER);
            cs.registerOutParameter(10,Types.VARCHAR);
            cs.execute();

            if ((cs.getInt(9)!=DBMessage.OK_RT))
              throw new EJBException("DB:"+cs.getInt(9)+":"+cs.getString(10));
         }
      }

      //cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.INVENT_PS_SP_INSERISCI(?,?,?,?,?,?,?,?,?,?)}");  
      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".INVENT_PS_SP_INSERISCI(?,?,?,?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,code_utente);
      cs.setString(2,sitoSelez);
      cs.setString(3,accountSelez);
      cs.setString(4,data_ini);
      cs.setInt(5,mod_ull);
      cs.setInt(6,mod_itc);
      cs.setString(7,"1");
      cs.setInt(8,0);
      cs.registerOutParameter(9,Types.INTEGER);
      cs.registerOutParameter(10,Types.VARCHAR);
      cs.execute();



      //MMM 24/10/02 inizio
      if ((impcons!=null)&&(impcons.doubleValue()!=0))
      {
         //System.out.println(">>>ColocationBMPBean if impcons!=null && impcons!=0 in inert");
          //cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.INVENT_PS_SP_INSERISCI(?,?,?,?,?,?,?,?,?,?)}");  
          cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".INVENT_PS_SP_INSERISCI(?,?,?,?,?,?,?,?,?,?)}");

          // Impostazione types I/O
          cs.setString(1,code_utente);
          cs.setString(2,sitoSelez);
          cs.setString(3,accountSelez);
          cs.setString(4,data_ini);
          cs.setInt(5,mod_ull);
          cs.setInt(6,mod_itc);
          cs.setString(7,"4");
          cs.setInt(8,0);
          cs.registerOutParameter(9,Types.INTEGER);
          cs.registerOutParameter(10,Types.VARCHAR);
          cs.execute();
        }
     conn.close();

      }
    catch(Exception lexc_Exception)
    {

		throw new CustomEJBException(lexc_Exception.toString(),
    							"Errore di inserimento nella store procedure INVENT_PS_SP_INSERISCI",
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
  

  public void ejbPostCreate(String code_utente,String sitoSelez, String accountSelez, String data_ini, Double imptar, Double impcons, int mod_ull, int mod_itc,String[] eleCodePs,String[] eleQtaPs)
  {
  
  }

  public ColocationBMPPK ejbFindByPrimaryKey(ColocationBMPPK primaryKey)
  {
    return primaryKey;
  }




 public Collection ejbFindAll(String CodSito) throws FinderException, RemoteException
	{
    
    Vector recs = new Vector();
 	try
		{
      
			conn = getConnection(dsName);
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.ACCOUNT_CON_TARIFFA_X_SITO_LST(?,?,?,?)}");  
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_CON_TARIFFA_X_SITO_LST(?,?,?,?)}");

      // Impostazione types I/O

      
      cs.setString(1,CodSito);
      
      
     
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_ACCOUNT_SITO");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      
       cs.execute();
       

//05/09/02 inizio
//Modifica per inserimento dei messaggi d'errore:
//Se il DB ritorna "Data not found" qualcosa è andato storto!!!
      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
      {
            throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: ACCOUNT_CON_TARIFFA_X_SITO_LST");
            //StaticMessages.setCustomString(e.toString("DB:"+cs.getInt(3)+":"+cs.getString(4)));
            //StaticContext.writeLog(StaticMessages.getMessage(1001,"Controller","","",StaticContext.APP_SERVER_DRIVER));
            //e.printStackTrace();
      }
//05/09/02 fine

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT_SITO",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new ColocationBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              
              pk.setCodeAccount(attr[0].stringValue());
              pk.setDescAccount(attr[1].stringValue());
              if (attr[2]!=null)  
                pk.setDataConsSito(attr[2].stringValue());
              else
                pk.setDataConsSito("");
             recs.add(pk);
          }      

      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
      StaticMessages.setCustomString(e.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5002,"ColocationBMPBean","","",StaticContext.APP_SERVER_DRIVER));
      e.printStackTrace();
      throw new FinderException(e.getMessage());
		} 
    catch(Exception ee)
		{
      StaticMessages.setCustomString(ee.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5003,"Colocation","","",StaticContext.APP_SERVER_DRIVER));
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



public ColocationBMPPK ejbFindDataIniValAcc(String accountSelez) throws FinderException, RemoteException
	{
    
    Vector recs = new Vector();
 	try
		{
			conn = getConnection(dsName);
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_MARIO.ACCOUNT_DATA_INI(?,?,?,?)}");  
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_DATA_INI(?,?,?,?)}");
      cs.setString(1,accountSelez);
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR); 
      
       cs.execute();
       

      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
      {
            throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: ACCOUNT_DATA_INI");
            //StaticMessages.setCustomString(e.toString("DB:"+cs.getInt(3)+":"+cs.getString(4)));
            //StaticContext.writeLog(StaticMessages.getMessage(1001,"Controller","","",StaticContext.APP_SERVER_DRIVER));
            //e.printStackTrace();
      }
      
              pk = new ColocationBMPPK();

              
              pk.setDataIniValAcc(cs.getString(2));
              
             
        

      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
      StaticMessages.setCustomString(e.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5002,"ColocationBMPBean","","",StaticContext.APP_SERVER_DRIVER));
      e.printStackTrace();
      throw new FinderException(e.getMessage());
		} 
    catch(Exception ee)
		{
      StaticMessages.setCustomString(ee.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5003,"Colocation","","",StaticContext.APP_SERVER_DRIVER));
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


//02/10/02 FINE

// Dario -Inizio aggiornamento e cancellazione

public void ejbHomeStore(String code_utente,String sitoSelez, String accountSelez, String data_ini, Double imptar, Double impcons, int mod_ull, int mod_itc,String[] eleCodePs,String[] eleQtaPs)
  throws CreateException, RemoteException, CustomEJBException
{
    try
      {
      conn = getConnection(dsName);

        //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.TARIFFA_X_SITO_CANCELLA (?,?,?,?)}");
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_SITO_CANCELLA (?,?,?,?)}");       
      System.out.println("TARIFFA_X_SITO_CANCELLA");
       // Impostazione types I/O
      cs.setString(1,sitoSelez);
      cs.setString(2,accountSelez);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      if (cs.getInt(3)!=DBMessage.OK_RT)
          throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));
       cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".INVENT_PS_SP_CANCELLA (?,?,?,?,?)}");       
      System.out.println("INVENT_PS_SP_CANCELLA");
       //cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.INVENT_PS_SP_CANCELLA (?,?,?,?,?)}");
       // Impostazione types I/O
      System.out.println("sitoSelez: "+sitoSelez);
      System.out.println("accountSelez: "+accountSelez);
      cs.setString(1,sitoSelez);
      cs.setString(2,accountSelez);
      cs.setInt(3,1);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);

      cs.execute();
      if (cs.getInt(4)!=DBMessage.OK_RT)
          throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));


      //cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.TARIFFA_X_SITO_INSERISCI(?,?,?,?,?,?,?,?)}");  
      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_SITO_INSERISCI(?,?,?,?,?,?,?,?)}");
      System.out.println("INVENT_PS_SP_CANCELLA");

      // Impostazione types I/O
      cs.setString(1,code_utente);
      cs.setString(2,sitoSelez);
      cs.setString(3,accountSelez);
      cs.setString(4,data_ini);
      cs.setDouble(5,imptar.doubleValue());
      cs.setDouble(6,impcons.doubleValue());
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);

      cs.execute();

      if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
        throw new EJBException("DB:"+cs.getInt(7)+":"+cs.getString(8));

      pk=new ColocationBMPPK(code_utente,sitoSelez,accountSelez,data_ini,
                          imptar,impcons);

      String CodePs="";
      //MMM 24/10/02 inizio
      //int QtaPs = 0;
      Double QtaPs = new Double((double)0);
      
      for (int jj=0;jj<eleCodePs.length;jj++)
      {
        CodePs= eleCodePs[jj];
        if (eleQtaPs[jj]!=null && !eleQtaPs[jj].equals("") && !eleQtaPs[jj].equals("0") && !eleQtaPs[jj].equals("-1") )
        {
          //MMM 24/10/02 inizio
            //QtaPs= new Integer(eleQtaPs[jj]).intValue();
              QtaPs= new Double(eleQtaPs[jj].replace(',','.'));

            //cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.INVENT_PS_SP_INSERISCI(?,?,?,?,?,?,?,?,?,?)}");  
            cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".INVENT_PS_SP_INSERISCI(?,?,?,?,?,?,?,?,?,?)}");
      System.out.println("INVENT_PS_SP_INSERISCI");

            // Impostazione types I/O
            cs.setString(1,code_utente);
            cs.setString(2,sitoSelez);
            cs.setString(3,accountSelez);
            cs.setString(4,data_ini);
            cs.setInt(5,mod_ull);
            cs.setInt(6,mod_itc);
            cs.setString(7,CodePs);
            //MMM 24/10/02 inizio
              //cs.setInt(8,QtaPs);
              cs.setDouble(8,QtaPs.doubleValue());
            cs.registerOutParameter(9,Types.INTEGER);
            cs.registerOutParameter(10,Types.VARCHAR);
            cs.execute();

            if ((cs.getInt(9)!=DBMessage.OK_RT))
              throw new EJBException("DB:"+cs.getInt(9)+":"+cs.getString(10));
         }
      }

      //cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.INVENT_PS_SP_INSERISCI(?,?,?,?,?,?,?,?,?,?)}");  
      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".INVENT_PS_SP_INSERISCI(?,?,?,?,?,?,?,?,?,?)}");
      System.out.println("INVENT_PS_SP_INSERISCI");

      // Impostazione types I/O
      cs.setString(1,code_utente);
      cs.setString(2,sitoSelez);
      cs.setString(3,accountSelez);
      cs.setString(4,data_ini);
      cs.setInt(5,mod_ull);
      cs.setInt(6,mod_itc);
      cs.setString(7,"1");
      cs.setInt(8,0);
      cs.registerOutParameter(9,Types.INTEGER);
      cs.registerOutParameter(10,Types.VARCHAR);
      cs.execute();
      

    //MMM 24/10/02 inizio
    if((impcons!=null)&&(impcons.doubleValue()!=0))
    {  
         //System.out.println(">>>>ColocationBMPBean if impcons!=null e impcons!=0");
          //cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.INVENT_PS_SP_INSERISCI(?,?,?,?,?,?,?,?,?,?)}");  
          cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".INVENT_PS_SP_INSERISCI(?,?,?,?,?,?,?,?,?,?)}");
      System.out.println("INVENT_PS_SP_INSERISCI");

          // Impostazione types I/O
          cs.setString(1,code_utente);
          cs.setString(2,sitoSelez);
          cs.setString(3,accountSelez);
          cs.setString(4,data_ini);
          cs.setInt(5,mod_ull);
          cs.setInt(6,mod_itc);
          cs.setString(7,"4");
          cs.setInt(8,0);
          cs.registerOutParameter(9,Types.INTEGER);
          cs.registerOutParameter(10,Types.VARCHAR);
          cs.execute();
    }
    //MMM 24/10/02 fine
    
     conn.close();

      }
    catch(Exception lexc_Exception)
    {

		throw new CustomEJBException(lexc_Exception.toString(),
    							"Errore di inserimento nella store procedure INVENT_PS_SP_INSERISCI",
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
      return ;
}

  public void ejbHomeRemove(ColocationBMPPK pk) throws FinderException, RemoteException
  {

    Connection conn=null;  
    try
    {
      //deleteRow(pk); 

      conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_SITO_CANCELLA (?,?,?,?)}");       
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.TARIFFA_X_SITO_CANCELLA (?,?,?,?)}");
       // Impostazione types I/O
      cs.setString(1,pk.getSitoSelez());
      cs.setString(2,pk.getAccountSelez());
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      if (cs.getInt(3)!=DBMessage.OK_RT)
          throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));
       cs=(OracleCallableStatement)conn.prepareCall("{call "+StaticContext.PACKAGE_SPECIAL + ".INVENT_PS_SP_CANCELLA (?,?,?,?,?)}");       
       //cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.INVENT_PS_SP_CANCELLA (?,?,?,?,?)}");
       // Impostazione types I/O
      cs.setString(1,pk.getSitoSelez());
      cs.setString(2,pk.getAccountSelez());
      cs.setInt(3,1);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);

      cs.execute();
      if (cs.getInt(4)!=DBMessage.OK_RT)
          throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));


      // Chiudo la connessione
      conn.close();
    }
catch(Exception lexc_Exception)
      {
  throw new CustomEJBException(lexc_Exception.toString(),
       "Errore di cancellazione nella store procedure INVENT_PS_SP_CANCELLA o TARIFFA_X_SITO_CANCELLA",
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
//Valeria fine 19-09-02      

  }

// Dario Fine aggiornamento e cancellazione




public void setCodeAccount(String stringa)
  {
    pk = (ColocationBMPPK) ctx.getPrimaryKey();
    pk.setCodeAccount(stringa);
    enableStore=true;
  }

  public String getCodeAccount()
  {
    pk = (ColocationBMPPK) ctx.getPrimaryKey();
    if (pk==null) return null; 
      else
        return pk.getCodeAccount();
    
  }

  public void setDescAccount(String stringa)
  {
    pk = (ColocationBMPPK) ctx.getPrimaryKey();
    pk.setDescAccount(stringa);
    enableStore=true;
  }

  public String getDescAccount()
  {
   pk = (ColocationBMPPK) ctx.getPrimaryKey();
    if (pk==null) return null; 
      else
        return pk.getDescAccount();
  }
  
public void setDataConsSito(String stringa)
  {
    pk = (ColocationBMPPK) ctx.getPrimaryKey();
    pk.setDataConsSito(stringa);
    enableStore=true;
  }

  public String getDataConsSito()
  {
   pk = (ColocationBMPPK) ctx.getPrimaryKey();
    if (pk==null) return null; 
      else
        return pk.getDataConsSito();
  }

public void setNumeroElab(int stringa)
  {
    pk = (ColocationBMPPK) ctx.getPrimaryKey();
    pk.setNumeroElab(stringa);
    //enableStore=true;
  }

  public int getNumeroElab()
  {
    pk = (ColocationBMPPK) ctx.getPrimaryKey();
    if (pk==null) return -1; 
     else
        return pk.getNumeroElab();
  }

 public void setDataIniValAcc(String stringa)
  {
    pk = (ColocationBMPPK) ctx.getPrimaryKey();
    pk.setDataIniValAcc(stringa);
  }

  public String getDataIniValAcc()
  {
    pk = (ColocationBMPPK) ctx.getPrimaryKey();
    if (pk==null) return null; 
     else
        return pk.getDataIniValAcc();
  }

//metodi prova rosa

 public void setCode_utente(String stringa)
  {
    pk = (ColocationBMPPK) ctx.getPrimaryKey();
    pk.setCode_utente(stringa);
  }

  public String getCode_utente()
  { 
    pk = (ColocationBMPPK) ctx.getPrimaryKey();
    if (pk==null) return null; 
     else
        return pk.getCode_utente();
  }


  public void setSitoSelez(String stringa)
  {
    pk = (ColocationBMPPK) ctx.getPrimaryKey();
    pk.setSitoSelez(stringa);
  }

  public String getSitoSelez()
  {
   pk = (ColocationBMPPK) ctx.getPrimaryKey();
    if (pk==null) return null; 
     else
        return pk.getSitoSelez();
  }


  public void setAccountSelez(String stringa)
  {
    pk = (ColocationBMPPK) ctx.getPrimaryKey();
    pk.setAccountSelez(stringa);
  }

  public String getAccountSelez()
  {
    pk = (ColocationBMPPK) ctx.getPrimaryKey();
    if (pk==null) return null; 
     else
        return pk.getAccountSelez();
  }

  public void setData_ini(String stringa)
  {
     pk = (ColocationBMPPK) ctx.getPrimaryKey();
      pk.setData_ini(stringa);
  }

  public String getData_ini()
  {
    pk = (ColocationBMPPK) ctx.getPrimaryKey();
    if (pk==null) return null; 
     else
        return pk.getData_ini();
  }


  public void setImptar(Double stringa)
  {
    pk = (ColocationBMPPK) ctx.getPrimaryKey();
      pk.setImptar(stringa);
  }


  public Double getImptar()
  {
    pk = (ColocationBMPPK) ctx.getPrimaryKey();
    if (pk==null) return null; 
     else
        return pk.getImptar();
  }


  public void setImpcons(Double stringa)
  {
    pk = (ColocationBMPPK) ctx.getPrimaryKey();
      pk.setImpcons(stringa);
  }


  public Double getImpcons()
  {
    pk = (ColocationBMPPK) ctx.getPrimaryKey();
    if (pk==null) return null; 
     else
        return pk.getImpcons();
  }
  

//
  
}