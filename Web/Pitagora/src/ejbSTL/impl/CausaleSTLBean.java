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

public class CausaleSTLBean  extends AbstractSessionCommonBean implements SessionBean
{
  public Vector getCaus(String CodTipoContr, String ClassOf, String CodPs, String CodOf) throws RemoteException, CustomException
  {
//System.out.println(CodTipoContr+ClassOf+CodPs+CodOf);
   Vector vect=new Vector();
   Connection conn=null;
   try
      {
/*      InitialContext ic  = new javax.naming.InitialContext(); 
      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME); 
      conn = dataSource.getConnection(); */
      conn = getConnection(dsName);
     
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CAUS_FAT_LST_DA_ACQ(?,?,?,?,?,?,?)}");
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_LUCA.CAUS_FAT_LST_DA_ACQ(?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      
      cs.setString(1,CodTipoContr);
      cs.setString(2,ClassOf);
      cs.setString(3,CodPs);
      cs.setString(4,CodOf);
      cs.registerOutParameter(5,OracleTypes.ARRAY, "ARR_CAUSALI_FAT");
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      
      cs.execute();
      if ((cs.getInt(6)!=DBMessage.OK_RT)&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7));
/*      if ((cs.getInt(6)!=DBMessage.OK_RT) &&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7)+"NOME STORED: CAUS_FAT_LST_DA_ACQ");*/

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CAUSALI_FAT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(5);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              CausaleElem  elem= new CausaleElem();
                   
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setCodeOggettoCf(attr[0].stringValue());
              elem.setDescOggettoCf(attr[1].stringValue());

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
									"getCaus",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCaus",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }

// METODO PER IL CARICAMENTO DELLA COMBO CAUSALE SU LISTA TARIFFE INIZIO
  public Vector getCausTar(String CodTipoContr, String CodPs, String CodOf) throws RemoteException, CustomException
  {
   Vector vect=new Vector();
   Connection conn=null;
   try
      {
      InitialContext ic  = new javax.naming.InitialContext(); 
      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME); 
      conn = dataSource.getConnection(); 
//      conn = getConnection(dsName);
     
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CAUS_FAT_CON_TARIFFA(?,?,?,?,?,?)}");
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_LUCA.CAUS_FAT_CON_TARIFFA(?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.setString(2,CodPs);
      cs.setString(3,CodOf);
      cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_CAUSALI_FAT");
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      
      cs.execute();
      if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CAUSALI_FAT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(4);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              CausaleElem  elem= new CausaleElem();
                   
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setCodeOggettoCf(attr[0].stringValue());
              elem.setDescOggettoCf(attr[1].stringValue());

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
									"getCausTar",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCausTar",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }

//METODO PER IL CARICAMENTO DELLA COMBO CAUSALE SU LISTA TARIFFE FINE


//Aggiornamento MARIO 13/09/02 inizio
//  METODO PER IL CARICAMENTO DELLA COMBO CAUSALE SU LISTA TARIFFE X CONTRATTO INIZIO
  public Vector getCausTar(String CodTipoContr, String CodContr, String CodPs, String CodOf) throws RemoteException, CustomException
  {
   Vector vect=new Vector();
   Connection conn=null;
//  //System.out.println("METODO PER IL CARICAMENTO DELLA COMBO CAUSALE SU LISTA TARIFFE X CONTRATTO");
   try
      {
      
      conn = getConnection(dsName);
     
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CAUS_FAT_CON_TARIFFA_PERS(?,?,?,?,?,?,?)}");
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_ROSA.CAUS_FAT_CON_TARIFFA_PERS(?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      
      cs.setString(1,CodTipoContr);
      cs.setString(2,CodContr);
      cs.setString(3,CodPs);
      cs.setString(4,CodOf);
      cs.registerOutParameter(5,OracleTypes.ARRAY, "ARR_CAUSALI_FAT");
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(6)!=DBMessage.OK_RT)&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CAUSALI_FAT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(5);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              CausaleElem  elem= new CausaleElem();
                   
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setCodeOggettoCf(attr[0].stringValue());
              elem.setDescOggettoCf(attr[1].stringValue());

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
									"getCausTar",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCausTar",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }

// Mario METODO PER IL CARICAMENTO DELLA COMBO CAUSALE SU LISTA TARIFFE X CONTRATTO FINE
//Aggiornamento 13/09/02 fine
//GIANLUCA-26/09/2002-INIZIO
  public Vector getCausXContr(String CodTipoContr, String CodContr, String ClassOf, String CodPs, String CodOf) throws RemoteException, CustomException
  {
//System.out.println(CodTipoContr+ClassOf+CodPs+CodOf);
   Vector vect=new Vector();
   Connection conn=null;
   try
      {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CAUS_FAT_LST_DA_ACQ_X_CONTR(?,?,?,?,?,?,?,?)}");
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_ROSA.CAUS_FAT_LST_DA_ACQ_X_CONTR(?,?,?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.setString(2,CodContr);
      cs.setString(3,ClassOf);
      cs.setString(4,CodPs);
      cs.setString(5,CodOf);
      cs.registerOutParameter(6,OracleTypes.ARRAY, "ARR_CAUSALI_FAT");
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(7)+":"+cs.getString(8));
/*      if ((cs.getInt(6)!=DBMessage.OK_RT) &&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7)+"NOME STORED: CAUS_FAT_LST_DA_ACQ");*/

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CAUSALI_FAT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(6);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              CausaleElem  elem= new CausaleElem();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              elem.setCodeOggettoCf(attr[0].stringValue());
              elem.setDescOggettoCf(attr[1].stringValue());
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
									"getCausXContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCausXContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }
//GIANLUCA26/09/2002-FINE

 public Vector getCausaliXTariffe(String CodTipoContr,String ClassOf) throws RemoteException, CustomException
  {
//System.out.println(CodTipoContr+ClassOf+CodPs+CodOf);
   Vector vect=new Vector();
   Connection conn=null;
   try
      {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CAUS_FAT_LST_CAUSALI_X_TARIFFA(?,?,?,?,?)}");
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_ROSA.CAUS_FAT_LST_DA_ACQ_X_CONTR(?,?,?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodTipoContr);

      cs.setString(2,ClassOf);


      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_CAUSALI_FAT");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CAUSALI_FAT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              CausaleElem  elem= new CausaleElem();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              elem.setCodeOggettoCf(attr[0].stringValue());
              elem.setDescOggettoCf(attr[1].stringValue());
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
									"getCausXContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCausXContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }

  public Vector getLstPromozioni(String CodTipoContr,String ClassOf) throws RemoteException, CustomException
  {
    System.out.println(CodTipoContr+ClassOf);
   Vector vect=new Vector();
   Connection conn=null;
   try
      {
      conn = getConnection(dsName);
      //R1I-13-0124 Servizi Promozioni
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".LST_PROMOZIONI(?,?,?,?,?)}");

      cs.setString(1,CodTipoContr);
      cs.setString(2,ClassOf);
      
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_PROMOZIONI_SP");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
      
      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PROMOZIONI_SP",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
      {
          PromozioniElem  elem= new PromozioniElem();
          STRUCT s=(STRUCT)dati[i];
          Datum attr[]=s.getOracleAttributes();
          elem.setCodePromozione(attr[0].stringValue());
          elem.setDescPromozione(attr[1].stringValue());
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
									"getLstPromozioni",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getLstPromozioni",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  } 

  public PromozioniDett loadPromozione(String codeTariffa,String codePrTariffa,String codePromozione) throws RemoteException, CustomException
  {
   PromozioniDett ret=new PromozioniDett();
   Connection conn=null;
   try
      {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".LOAD_PROMOZIONE(?,?,?,?,?,?,?,?,?,?,?,?)}");

      cs.setString(1,codeTariffa);
      cs.setString(2,codePrTariffa);
      cs.setString(3,codePromozione);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.registerOutParameter(8,Types.VARCHAR);
      cs.registerOutParameter(9,Types.VARCHAR);
      cs.registerOutParameter(10,Types.VARCHAR);
      cs.registerOutParameter(11,Types.VARCHAR);
      cs.registerOutParameter(12,Types.VARCHAR);
      cs.execute();
      
      ret.setDescPromozione(Misc.nh(cs.getString(4)));
      ret.setDIV(Misc.nh(cs.getString(5)));     
      ret.setDFV(Misc.nh(cs.getString(6)));
      ret.setDIVC(Misc.nh(cs.getString(7)));     
      ret.setDFVC(Misc.nh(cs.getString(8)));
      ret.setNUMC(Misc.nh(cs.getString(9)));  
      ret.setCODE_PROG_BILL(Misc.nh(cs.getString(10)));
      
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
									"loadPromozione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"loadPromozione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return ret;
  } 

public PromozioniDett getPromozioneParam(String codePromozione) throws RemoteException, CustomException
  {
   PromozioniDett ret=new PromozioniDett();
   Connection conn=null;
   try
      {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".getPromozioneParam(?,?,?,?,?,?,?)}");

      cs.setString(1,codePromozione);
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.execute();
      
      ret.setCodePromozione(codePromozione);
      ret.setDescPromozione(Misc.nh(cs.getString(2)));
      
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
									"loadPromozione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"loadPromozione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return ret;
  }

public Vector getLstPromozioniTariffa(String codeTariffa, String codePrTariffa) throws RemoteException, CustomException
  {
   Vector vect=new Vector();
   Connection conn=null;
   try
      {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".lst_promozioniTariffa(?,?,?,?,?)}");
			
			cs.setString(1,codeTariffa);
			cs.setString(2,codePrTariffa);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_PROMOZIONI_TARIFFE");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
      
      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PROMOZIONI_TARIFFE",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
      {
          PromozioniDett  elem= new PromozioniDett();
          STRUCT s=(STRUCT)dati[i];
          Datum attr[]=s.getOracleAttributes();
          
          if(attr[0] != null)
            elem.setCodePromozione(attr[0].stringValue());
          else
            elem.setCodePromozione("");
            
          if(attr[1] != null)
            elem.setDescPromozione(attr[1].stringValue());
          else
            elem.setDescPromozione("");

          if(attr[2] != null)
            elem.setDIV(attr[2].stringValue());
          else
            elem.setDIV("");
            
          if(attr[3] != null)
            elem.setDFV(attr[3].stringValue());
          else
            elem.setDFV("");
          
          if(attr[4] != null)
            elem.setDIVC(attr[4].stringValue());
          else
            elem.setDIVC("");          
        
          if(attr[5] != null)
            elem.setDFVC(attr[5].stringValue());
          else
            elem.setDFVC("");
            
          if(attr[6] != null)
            elem.setCODE_PROG_BILL(attr[6].stringValue());
          else
            elem.setCODE_PROG_BILL("");
            
          if(attr[7] != null)
            elem.setNUMC(attr[7].stringValue());
          else
            elem.setNUMC("");
            
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
									"getLstPromozioniTariffa",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getLstPromozioniTariffa",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  } 


}