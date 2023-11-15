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

public class ContrattoSTLBean extends AbstractSessionCommonBean implements SessionBean 
{
//DA QUI
//METODO PER IL CARICAMENTO DELLA COMBO DEI CONTRATTI 02/09/02
  public Vector getContratti(String CodTipoContr) throws RemoteException, CustomException
	{
    Vector vect=new Vector();
    Connection conn=null;
   try
      {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CONTR_LST_ATT_CON_TARIFFE_PERS(?,?,?,?)}");
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_ROSA.CONTR_LST_ATT_CON_TARIFFE_PERS(?,?,?,?)}");
      
      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
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
//     //System.out.println("dati.length "+dati.length);
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ContrattoElem elem = new ContrattoElem();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
      
              elem.setCodeContratto(attr[0].stringValue());
              
              elem.setDescContratto(attr[1].stringValue());
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
									"getContratti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getContratti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
//   //System.out.println("esco");
    return vect;
  }
// Fine METODO PER IL CARICAMENTO DELLA COMBO SU LISTA_TARIFFE 
//A QUI


//Gianluca-26/09/2002-INIZIO
  public Vector getContrattiXIns(String CodTipoContr) throws RemoteException, CustomException
	{
    Vector vect=new Vector();
    Connection conn=null;
   try
      {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CONTR_LST_CON_ASS_OFPS_PERS_2(?,?,?,?)}");
//      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_ROSA.CONTR_LST_CON_ASS_OFPS_PERS_2(?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
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
//     //System.out.println("dati.length "+dati.length);
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ContrattoElem elem = new ContrattoElem();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              elem.setCodeContratto(attr[0].stringValue());
              elem.setDescContratto(attr[1].stringValue());
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
									"getContrattiXIns",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getContrattiXIns",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
//   //System.out.println("esco");
    return vect;
  }
//GIANLUCA-26/09/2002-fine


 public Vector getContrattiXInsCluster(String CodTipoContr) throws RemoteException, CustomException
       {
   Vector vect=new Vector();
   Connection conn=null;
  try
     {
     conn = getConnection(dsName);
     OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CONTR_LST_CON_ASS_OFPS_PERS_2C(?,?,?,?)}");
 //      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_ROSA.CONTR_LST_CON_ASS_OFPS_PERS_2(?,?,?,?)}");
     // Impostazione types I/O
     cs.setString(1,CodTipoContr);
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
 //     //System.out.println("dati.length "+dati.length);
     // Estrazione dei dati
     for (int i=0;i<dati.length;i++)
         {
             ContrattoElem elem = new ContrattoElem();
             STRUCT s=(STRUCT)dati[i];
             Datum attr[]=s.getOracleAttributes();
             elem.setCodeContratto((attr[0]==null?"":attr[0].stringValue())+ "||" + attr[2].stringValue() + "||" + attr[3].stringValue() + "||" + attr[4].stringValue());
             elem.setDescContratto(attr[1].stringValue());
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
                                                                       "getContrattiXIns",
                                                                       this.getClass().getName(),
                                                                       StaticContext.FindExceptionType(sqle));
       }

     throw new CustomException(lexc_Exception.toString(),
                                                                       "",
                                                                       "getContrattiXIns",
                                                                       this.getClass().getName(),
                                                                       StaticContext.FindExceptionType(lexc_Exception));
   }
 //   //System.out.println("esco");
   return vect;
 }


public Vector getContrAssOfPs(String TipoContr, String FlagSys) throws RemoteException, CustomException
{
 Vector vect=new Vector();
 Connection conn=null;
 try
      {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CONTR_LST_CON_ASS_OFPS_PERS_1(?,?,?,?,?)}");
      //
      cs.setString(1,TipoContr);
      cs.setString(2,FlagSys);
      
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_CONTRATTO");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));

     // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CONTRATTO",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
     
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      for (int i=0;i<dati.length;i++)
          {
              ContrattoElem elem = new ContrattoElem();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              elem.setCodeContratto(attr[0].stringValue());
              elem.setDescContratto(attr[1].stringValue());
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
									"getContrAssOfPs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getContrAssOfPs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
}

    public Vector getContrAssOfPsCluster(String TipoContr, String FlagSys) throws RemoteException, CustomException
    {
     Vector vect=new Vector();
     Connection conn=null;
     try
          {
          conn = getConnection(dsName);
          OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CONTR_LST_CON_ASS_OFPS_PERS_C(?,?,?,?,?)}");
          //
          cs.setString(1,TipoContr);
          cs.setString(2,FlagSys);
          
          cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_CONTRATTO");
          cs.registerOutParameter(4,Types.INTEGER);
          cs.registerOutParameter(5,Types.VARCHAR);
          cs.execute();

          if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));

         // Costruisco l'array che conterrà i dati di ritorno della stored  
          ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CONTRATTO",conn);
          ARRAY rs = new ARRAY(ad, conn, null);
         
          rs=cs.getARRAY(3);
          Datum dati[]=rs.getOracleArray();

          for (int i=0;i<dati.length;i++)
              {
                  ContrattoElem elem = new ContrattoElem();
                  STRUCT s=(STRUCT)dati[i];
                  Datum attr[]=s.getOracleAttributes();
                  elem.setCodeContratto(attr[0].stringValue());
                  elem.setDescContratto(attr[1].stringValue());
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
                                                                            "getContrAssOfPs",
                                                                            this.getClass().getName(),
                                                                            StaticContext.FindExceptionType(sqle));
            }

          throw new CustomException(lexc_Exception.toString(),
                                                                            "",
                                                                            "getContrAssOfPs",
                                                                            this.getClass().getName(),
                                                                            StaticContext.FindExceptionType(lexc_Exception));
        }
        return vect;
    }

public Vector getContrTipo(String TipoContr) throws RemoteException, CustomException
{
 Vector vect=new Vector();
 Connection conn=null;

  try
      {
      conn = getConnection(dsName);

          /*
           PROCEDURE CONTR_LST_X_TIPO
                                        (i_tipo_contr        IN  VARCHAR2,
                                         o_dati_contr        OUT ARR_CONTRATTO,
                                         o_errore_sql        OUT NUMBER,
                                         o_errore_msg        OUT VARCHAR2);

          */

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CONTR_LST_X_TIPO(?,?,?,?)}");
      //
      cs.setString(1,TipoContr);
      
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_CONTRATTO");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

     // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CONTRATTO",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
     
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      for (int i=0;i<dati.length;i++)
          {
              ContrattoElem elem = new ContrattoElem();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              elem.setCodeContratto(attr[0].stringValue());
              elem.setDescContratto(attr[1].stringValue());
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
									"getContrTipo",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getContrTipo",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;

}


public int check_fatt_lu(String tipoContr, String codeContr, String flagSys ) throws RemoteException, CustomException
{
int ret=-1;
Connection conn=null;

  try
      {
      conn = getConnection(dsName);

                /*
                PROCEDURE ACCOUNT_ACC_X_CONTR
                                              (i_code_contr        IN  VARCHAR2,
                                               i_flag_sys          IN  CHAR,
                                               o_code_account      OUT VARCHAR2,
                                               o_errore_sql        OUT NUMBER,
                                               o_errore_msg        OUT VARCHAR2);

                */
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_ACC_X_CONTR(?,?,?,?,?)}");
      cs.setString(1,codeContr);
      cs.setString(2,flagSys);
      
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));

      String codeAccount=cs.getString(3);
      
                /*
                PROCEDURE DOC_FATT_VER_ES_ACC_LU
                                              (i_tipo_contr        IN  VARCHAR2,
                                               i_code_account      IN  VARCHAR2,
                                               o_num_doc           OUT NUMBER,
                                               o_errore_sql        OUT NUMBER,
                                               o_errore_msg        OUT VARCHAR2);
                */
      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".DOC_FATT_VER_ES_ACC_LU(?,?,?,?,?)}");
      cs.setString(1,tipoContr);
      cs.setString(2,codeAccount);
      
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

       if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));
   
      ret=cs.getInt(3);

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
									"check_fatt_lu",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"check_fatt_lu",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return ret;
    }

  public String getDataIni(String codeContr, String flagSys ) throws RemoteException, CustomException
    {
    String dt="";

    try
      {
      conn = getConnection(dsName);
                /*
                PROCEDURE CONTR_DETTAGLIO
                                              (i_code_contr        IN  VARCHAR2,
                                               i_flag_sys          IN  CHAR,
                                               o_desc_contr        OUT VARCHAR2,
                                               o_data_inizio_contr OUT VARCHAR2,
                                               o_errore_sql        OUT NUMBER,
                                               o_errore_msg        OUT VARCHAR2);
                */

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CONTR_DETTAGLIO(?,?,?,?,?,?)}");
      cs.setString(1,codeContr);
      cs.setString(2,flagSys);

      cs.registerOutParameter(3,Types.VARCHAR);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

       if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6));
          
      dt=cs.getString(4);

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
									"check_fatt_lu",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"check_fatt_lu",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return dt;
    }            
}