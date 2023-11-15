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

import java.text.DateFormat;

import java.text.SimpleDateFormat;

import java.util.Vector;


public class EstrazioniConfSTLBean extends AbstractSessionCommonBean implements SessionBean
{
 public Vector getEstrazioniConf() throws RemoteException, CustomException
    {
    Vector vect=new Vector();

    Connection conn=null;
    try
      {

      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ESTRAZIONI_CONF(?,?,?)}");

      //cs.setString(1,lettera);  
      
      cs.registerOutParameter(1,OracleTypes.ARRAY, "ARR_ACC_ESTRAZIONI_CONF");
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);

      cs.execute();
      if ((cs.getInt(2)!=DBMessage.OK_RT)&&(cs.getInt(2)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(2)+":"+cs.getString(3));
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACC_ESTRAZIONI_CONF",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(1);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ClassEstrazioniConf  elem= new ClassEstrazioniConf();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setId_funz(attr[0].stringValue());
              elem.setNome_estrazione(attr[1].stringValue());
              elem.setFunzione(attr[2].stringValue());
              elem.setN_parametri(attr[3].stringValue());
              elem.setNome_file(attr[4].stringValue());
              elem.setPath_oracle(attr[5].stringValue());
              elem.setPath_download(attr[6].stringValue());

              vect.addElement(elem);
          }

      cs.close();    
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
									"getAllCLLI",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAllCLLI",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }
  
  public Vector getEstrazioniCruscottoConf() throws RemoteException, CustomException
  {
    
    Vector vect=new Vector();

    Connection conn=null;
    try
      {

      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ESTRAZIONI_CONF(?,?,?)}");

      //cs.setString(1,lettera);  
      
      cs.registerOutParameter(1,OracleTypes.ARRAY, "ARR_ACC_ESTRAZIONI_CONF");
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);

      cs.execute();
      if ((cs.getInt(2)!=DBMessage.OK_RT)&&(cs.getInt(2)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(2)+":"+cs.getString(3));
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACC_ESTRAZIONI_CONF",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(1);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ClassEstrazioniConf  elem= new ClassEstrazioniConf();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setId_funz(attr[0].stringValue());
              elem.setNome_estrazione(attr[1].stringValue());
              elem.setFunzione(attr[2].stringValue());
              elem.setN_parametri(attr[3].stringValue());
              elem.setNome_file(attr[4].stringValue());
              elem.setPath_oracle(attr[5].stringValue());
              elem.setPath_download(attr[6].stringValue());
              
              if ( "20".equals(elem.getId_funz()) || "21".equals(elem.getId_funz())) {
                vect.addElement(elem);
              }
          }

      cs.close();    
      // Chiudo la connessione
      conn.close();

      }catch(Exception lexc_Exception)
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
                  "getAllCLLI",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
                    "",
                  "getAllCLLI",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  
  
  
  }
  
  public String getUltimoAggiornamento() throws RemoteException, CustomException {

      Connection conn=null;
      String ret = "";
      try
        {

        conn = getConnection(dsName);
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_ESTRAZIONI_CONS_ATTIVE.GET_ULTIMO_AGG(?,?,?)}");

        //cs.setString(1,lettera);  
      
        cs.registerOutParameter(1,Types.VARCHAR);
        cs.registerOutParameter(2,Types.INTEGER);
        cs.registerOutParameter(3,Types.VARCHAR);

        cs.execute();
        if ((cs.getInt(2)!=DBMessage.OK_RT)&&(cs.getInt(2)!=DBMessage.NOT_FOUND_RT)) {
          //throw new Exception("DB:"+cs.getInt(2)+":"+cs.getString(3));
          
            /*DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            java.util.Date date = new java.util.Date();
            ret = dateFormat.format(date);*/
            ret = "--/--/---- --:--";
        } else {
            ret = cs.getString(1);
        }
        
      
          
      cs.close();    
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
                                                                        "getEstrazioniConsistenzeAttive",
                                                                        this.getClass().getName(),
                                                                        StaticContext.FindExceptionType(sqle));
        }

      /*throw new CustomException(lexc_Exception.toString(),
                                                                        "",
                                                                        "getEstrazioniConsistenzeAttive",
                                                                        this.getClass().getName(),
                                                                        StaticContext.FindExceptionType(lexc_Exception));*/
       ret = "--/--/---- --:--";
      }
      return ret;
      }
      
    public Vector getEstrazioniConsistenzeAttive(String strCodeServizio, String strDataCompDa, String strDataCompA, String strCodeAccount, String strCodeProdotto ) throws RemoteException, CustomException
       {
       Vector vect=new Vector();

       Connection conn=null;
       try
         {

         conn = getConnection(dsName);
         OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_ESTRAZIONI_CONS_ATTIVE.GET_CONS_ATTIVE_MESE(?,?,?,?,?,?,?,?)}");

         //cs.setString(1,lettera);  
 
             cs.setString(1,strDataCompDa); 
             cs.setString(2,strDataCompA); 
             cs.setString(3,strCodeServizio);
             cs.setString(4,strCodeAccount); 
             cs.setString(5,strCodeProdotto); 
         cs.registerOutParameter(6,OracleTypes.ARRAY, "ARR_CONS_ATT");
         cs.registerOutParameter(7,Types.INTEGER);
         cs.registerOutParameter(8,Types.VARCHAR);

         cs.execute();
         if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
           throw new Exception("DB:"+cs.getInt(7)+":"+cs.getString(8));
         // Costruisco l'array che conterrà i dati di ritorno della stored
         ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CONS_ATT",conn);
         ARRAY rs = new ARRAY(ad, conn, null);

         // Ottengo i dati
         rs=cs.getARRAY(6);
         Datum dati[]=rs.getOracleArray();

         // Estrazione dei dati
         for (int i=0;i<dati.length;i++)
             {
                 ClassEstrazioniConsAttive  elem= new ClassEstrazioniConsAttive();

                 STRUCT s=(STRUCT)dati[i];
                 Datum attr[]=s.getOracleAttributes();

                 elem.setServizio(attr[0].stringValue());
                 if (attr[1] != null ) elem.setDescServizio(attr[1].stringValue()); else elem.setDescServizio("");
                 elem.setOperatore(attr[2].stringValue());
                 if (attr[3] != null ) elem.setDescOperatore(attr[3].stringValue()); else elem.setDescOperatore("");
                 elem.setProdotto(attr[4].stringValue());
                 if (attr[5] != null ) elem.setDescProdotto(attr[5].stringValue()); else elem.setDescProdotto("");
                 elem.setMeseAnnoComp(attr[6].stringValue());
                 elem.setNumConsistenze(attr[7].stringValue());

                 vect.addElement(elem);
             }

         cs.close();    
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
                                                                           "getEstrazioniConsistenzeAttive",
                                                                           this.getClass().getName(),
                                                                           StaticContext.FindExceptionType(sqle));
           }

         throw new CustomException(lexc_Exception.toString(),
                                                                           "",
                                                                           "getEstrazioniConsistenzeAttive",
                                                                           this.getClass().getName(),
                                                                           StaticContext.FindExceptionType(lexc_Exception));
       }
       return vect;
     }
     
    public Vector getDettaglioEstrazioniConsistenzeAttive(String strCodeServizio,String strCodeAccount, String strCodeProdotto, String strMeseAnnoComp,String strDataCompDa, String strDataCompA) throws RemoteException, CustomException
       {
       Vector vect=new Vector();

       Connection conn=null;
       try
         {

         conn = getConnection(dsName);
         OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_ESTRAZIONI_CONS_ATTIVE.GET_DETT_CONS_ATTIVE(?,?,?,?,?,?,?,?,?,?)}");

         //cs.setString(1,lettera);
         if (strMeseAnnoComp!= null) {
            int pFSpace = strMeseAnnoComp.indexOf(" ");
            int pLSpace = strMeseAnnoComp.lastIndexOf(" ");
             
            strMeseAnnoComp = strMeseAnnoComp.substring(0,pFSpace) + " " + strMeseAnnoComp.substring(pLSpace+1);
         } else 
             strMeseAnnoComp = "   ";
             
          String[] strTmp = strMeseAnnoComp.split(" ");
          String strMese = strTmp[0];
          String strAnno = strTmp[1];
             
             cs.setString(1,strMese); 
             cs.setString(2,strAnno); 
             cs.setString(3,strDataCompDa); 
             cs.setString(4,strDataCompA); 
             cs.setString(5,strCodeServizio);
             cs.setString(6,strCodeAccount); 
             cs.setString(7,strCodeProdotto); 
         cs.registerOutParameter(8,OracleTypes.ARRAY, "ARR_DETT_CONS_ATT");
         cs.registerOutParameter(9,Types.INTEGER);
         cs.registerOutParameter(10,Types.VARCHAR);

         cs.execute();
         if ((cs.getInt(9)!=DBMessage.OK_RT)&&(cs.getInt(9)!=DBMessage.NOT_FOUND_RT))
           throw new Exception("DB:"+cs.getInt(9)+":"+cs.getString(10));
         // Costruisco l'array che conterrà i dati di ritorno della stored
         ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_DETT_CONS_ATT",conn);
         ARRAY rs = new ARRAY(ad, conn, null);

         // Ottengo i dati
         rs=cs.getARRAY(8);
         Datum dati[]=rs.getOracleArray();

         // Estrazione dei dati
         for (int i=0;i<dati.length;i++)
             {
                 ClassDettaglioConsAttive  elem= new ClassDettaglioConsAttive();

                 STRUCT s=(STRUCT)dati[i];
                 Datum attr[]=s.getOracleAttributes();

                 elem.setServizio(attr[0].stringValue());
                 elem.setOperatore(attr[1].stringValue());
                 elem.setProdotto(attr[2].stringValue());
                 elem.setMeseAnnoComp(attr[3].stringValue());
                 if ( attr[4] != null) elem.setCODE_ISTANZA_PS(attr[4].stringValue());    else elem.setCODE_ISTANZA_PS("");
                 if ( attr[5] != null) elem.setDATA_DRO(attr[5].stringValue());           else elem.setDATA_DRO("");
                 if ( attr[6] != null) elem.setDATA_INIZIO_FATRZ(attr[6].stringValue());  else elem.setDATA_INIZIO_FATRZ("");
                 if ( attr[7] != null) elem.setDATA_FINE_FATRZ(attr[7].stringValue());    else elem.setDATA_FINE_FATRZ("");
                 if ( attr[8] != null) elem.setDATA_CESS(attr[8].stringValue());          else elem.setDATA_CESS("");
                 if ( attr[9] != null) elem.setDATA_INIZIO_VALID(attr[9].stringValue());  else elem.setDATA_INIZIO_VALID("");
                 if ( attr[10] != null) elem.setDATA_FINE_VALID(attr[10].stringValue());  else elem.setDATA_FINE_VALID("");
                 if ( attr[11] != null) elem.setDATA_VARIAZ(attr[11].stringValue());      else elem.setDATA_VARIAZ("");
                 
                 vect.addElement(elem);
             }

         cs.close();    
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
                                                                           "getEstrazioniConsistenzeAttive",
                                                                           this.getClass().getName(),
                                                                           StaticContext.FindExceptionType(sqle));
           }

         throw new CustomException(lexc_Exception.toString(),
                                                                           "",
                                                                           "getEstrazioniConsistenzeAttive",
                                                                           this.getClass().getName(),
                                                                           StaticContext.FindExceptionType(lexc_Exception));
       }
       return vect;
     }

     
}