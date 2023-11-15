package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;

import java.sql.*;

import oracle.jdbc.*;
import oracle.sql.*;
import java.rmi.*;


import com.utl.*;

public class AssOfPsSTLBean extends AbstractSessionCommonBean implements SessionBean  
{

public int esiste_tariffa_x_contr(String codeContr,String codePs, String codeOf, String dataIniOfPs)
       throws RemoteException, CustomException

{
  int ret=0;

  Connection conn=null;
  try
      {
      conn = getConnection(dsName);

            /*
            PROCEDURE TARIFFA_X_CONTR_VER_ESIST
                                          (i_code_contr        IN  VARCHAR2,
                                           i_code_ps           IN  VARCHAR2,
                                           i_code_of           IN  VARCHAR2,
                                           i_data_inizio_ofps  IN  VARCHAR2,
                                           o_num_tar           OUT NUMBER,
                                           o_errore_sql        OUT NUMBER,
                                           o_errore_msg        OUT VARCHAR2);
            */

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".TARIFFA_X_CONTR_VER_ESIST(?,?,?,?,?,?,?)}");
      cs.setString(1,codeContr);
      cs.setString(2,codePs);
      cs.setString(3,codeOf);
      cs.setString(4,dataIniOfPs);
      
      cs.registerOutParameter(5,Types.INTEGER);
      
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      
      cs.execute();

      if ((cs.getInt(6)!=DBMessage.OK_RT)&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:TARIFFA_X_CONTR_VER_ESIST:"+cs.getInt(6)+":"+cs.getString(7));
    
      if (cs.getInt(6)==DBMessage.NOT_FOUND_RT)
        {
        conn.close();
        return ret;
        }
       
      ret=cs.getInt(5);
            
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
									"esiste_tariffa_x_contr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"esiste_tariffa_x_contr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }    

  return ret;
}


public String getMinDataIniCorr(String tipoContr, String dataCorr, String codeOf, String codePs)
       throws RemoteException, CustomException
  {
  String dt="";
  Connection conn=null;
  try
      {
      conn = getConnection(dsName);
    /*
    PROCEDURE ASSOC_OFPS_MIN_DIV (i_code_tipo_contr   IN VARCHAR2,
                                  i_code_of           IN VARCHAR2,
                                  i_code_ps           IN VARCHAR2,
                                  o_data_ini_ofps    OUT VARCHAR2,
                                  o_errore_sql       OUT NUMBER,
                                  o_errore_msg       OUT VARCHAR2)
   */
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_MIN_DIV(?,?,?,?,?,?)}");
      cs.setString(1,tipoContr);
      cs.setString(2,codeOf);
      cs.setString(3,codePs);
      cs.setString(4,dataCorr);
      cs.registerOutParameter(5,Types.VARCHAR);
      
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(6)!=DBMessage.OK_RT)&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:ASSOC_OFPS_MIN_DIV:"+cs.getInt(6)+":"+cs.getString(7));
    
      if (cs.getInt(6)==DBMessage.NOT_FOUND_RT)
        {
        conn.close();
        return dt;
        }
      
      dt=cs.getString(5);
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
									"getMinDataIniCorr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getMinDataIniCorr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }    

  return dt;
}

public String getMinDataIni(String tipoContr, String codeOf, String codePs)
       throws RemoteException, CustomException
{
String dt="";

Connection conn=null;
try
      {
      conn = getConnection(dsName);
      /*
    PROCEDURE ASSOC_OFPS_MIN_DIV (i_code_tipo_contr   IN VARCHAR2,
                                  i_code_of           IN VARCHAR2,
                                  i_code_ps           IN VARCHAR2,
                                  o_data_ini_ofps    OUT VARCHAR2,
                                  o_errore_sql       OUT NUMBER,
                                  o_errore_msg       OUT VARCHAR2)
      */
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_MIN_DIV(?,?,?,?,?,?)}");
      cs.setString(1,tipoContr);
      cs.setString(2,codeOf);
      cs.setString(3,codePs);
      
      cs.registerOutParameter(4,Types.VARCHAR);
      
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:ASSOC_OFPS_MIN_DIV:"+cs.getInt(5)+":"+cs.getString(6));
    
      if (cs.getInt(5)==DBMessage.NOT_FOUND_RT)
        {
        conn.close();
        return dt;
        }
      
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
									"getMinDataIni",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getMinDataIni",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }    
      
return dt;      
}

    
    public String getMinDataIniClus(String tipoContr, String codeOf, String codePs, String cod_cluster, String tipo_cluster)
       throws RemoteException, CustomException
    {
    String dt="";

    Connection conn=null;
    try
      {
      conn = getConnection(dsName);
      /*
    PROCEDURE ASSOC_OFPS_MIN_DIV (i_code_tipo_contr   IN VARCHAR2,
                                  i_code_of           IN VARCHAR2,
                                  i_code_ps           IN VARCHAR2,
                                  o_data_ini_ofps    OUT VARCHAR2,
                                  o_errore_sql       OUT NUMBER,
                                  o_errore_msg       OUT VARCHAR2)
      */
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_MIN_DIV_CLU(?,?,?,?,?,?,?,?)}");
      cs.setString(1,tipoContr);
      cs.setString(2,codeOf);
      cs.setString(3,codePs);
          cs.setString(4,cod_cluster);
          cs.setString(5,tipo_cluster);
      
      cs.registerOutParameter(6,Types.VARCHAR);
      
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:ASSOC_OFPS_MIN_DIV:"+cs.getInt(7)+":"+cs.getString(8));
    
      if (cs.getInt(7)==DBMessage.NOT_FOUND_RT)
        {
        conn.close();
        return dt;
        }
      
      dt=cs.getString(6);   
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
                                                                        "getMinDataIni",
                                                                        this.getClass().getName(),
                                                                        StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
                                                                        "",
                                                                        "getMinDataIni",
                                                                        this.getClass().getName(),
                                                                        StaticContext.FindExceptionType(lexc_Exception));
    }    
      
    return dt;
    }




public String getMaxDataFine(String tipoContr, String codeOf, String codePs)
       throws RemoteException, CustomException
{
String dt="";
Connection conn=null;
try
      {
      conn = getConnection(dsName);
      /*
    PROCEDURE ASSOC_OFPS_MAX_DFV (i_code_tipo_contr   IN VARCHAR2,
                                  i_code_of           IN VARCHAR2,
                                  i_code_ps           IN VARCHAR2,
                                  o_data_fine_ofps   OUT VARCHAR2,
                                  o_errore_sql       OUT NUMBER,
                                  o_errore_msg       OUT VARCHAR2)
      */
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_MAX_DFV(?,?,?,?,?,?)}");

      cs.setString(1,tipoContr);
      cs.setString(2,codeOf);
      cs.setString(3,codePs);
      cs.registerOutParameter(4,Types.VARCHAR);
      
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:ASSOC_OFPS_MAX_DFV:"+cs.getInt(5)+":"+cs.getString(6));
    
      if (cs.getInt(5)==DBMessage.NOT_FOUND_RT)
        {
        conn.close();
        return dt;
        }
      
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
									"getMaxDataFine",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getMaxDataFine",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }    
      
return dt;      
}

    public String getMaxDataFineClus(String tipoContr, String codeOf, String codePs,String cod_cluster, String tipo_cluster)
           throws RemoteException, CustomException
    {
    String dt="";
    Connection conn=null;
    try
          {
          conn = getConnection(dsName);
          /*
        PROCEDURE ASSOC_OFPS_MAX_DFV (i_code_tipo_contr   IN VARCHAR2,
                                      i_code_of           IN VARCHAR2,
                                      i_code_ps           IN VARCHAR2,
                                      o_data_fine_ofps   OUT VARCHAR2,
                                      o_errore_sql       OUT NUMBER,
                                      o_errore_msg       OUT VARCHAR2)
          */
          OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_MAX_DFV_CLU(?,?,?,?,?,?,?,?)}");

          cs.setString(1,tipoContr);
          cs.setString(2,codeOf);
          cs.setString(3,codePs);
              cs.setString(4,cod_cluster);
              cs.setString(5,tipo_cluster);
              
          cs.registerOutParameter(6,Types.VARCHAR);
          
          cs.registerOutParameter(7,Types.INTEGER);
          cs.registerOutParameter(8,Types.VARCHAR);
          cs.execute();

          if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:ASSOC_OFPS_MAX_DFV:"+cs.getInt(7)+":"+cs.getString(8));
        
          if (cs.getInt(7)==DBMessage.NOT_FOUND_RT)
            {
            conn.close();
            return dt;
            }
          
          dt=cs.getString(6);   
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
                                                                            "getMaxDataFine",
                                                                            this.getClass().getName(),
                                                                            StaticContext.FindExceptionType(sqle));
            }

          throw new CustomException(lexc_Exception.toString(),
                                                                            "",
                                                                            "getMaxDataFine",
                                                                            this.getClass().getName(),
                                                                            StaticContext.FindExceptionType(lexc_Exception));
        }    
          
    return dt;      
    }

public int check_aperte(String tipoContr, String codeOf, String codePs)
       throws RemoteException, CustomException
{
Connection conn=null;
int ret=0; 
 
try
      {
      conn = getConnection(dsName);
 
        /*
    PROCEDURE ASSOC_OFPS_VER_ESIST_APERTE (i_code_tipo_contr   IN VARCHAR2,
                                           i_code_of           IN VARCHAR2,
                                           i_code_ps           IN VARCHAR2,
                                           o_num_ofps         OUT NUMBER,
                                           o_errore_sql       OUT NUMBER,
                                           o_errore_msg       OUT VARCHAR2)
        */

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_VER_ESIST_APERTE(?,?,?,?,?,?)}");
      cs.setString(1,tipoContr);
      cs.setString(2,codeOf);
      cs.setString(3,codePs);
      
      cs.registerOutParameter(4,Types.INTEGER);
      
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:ASSOC_OFPS_VER_ESIST_APERTE:"+cs.getInt(5)+":"+cs.getString(6));
    
      if (cs.getInt(5)==DBMessage.NOT_FOUND_RT)
        {
        conn.close();
        return ret;
        }
      
      ret=cs.getInt(4);   
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
									"check_aperte",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"check_aperte",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
return ret;
}

    public int check_aperte_clus(String tipoContr, String codeOf, String codePs, String codeClus, String tipoClus)
           throws RemoteException, CustomException
    {
    Connection conn=null;
    int ret=0; 
     
    try
          {
          conn = getConnection(dsName);
     
            /*
        PROCEDURE ASSOC_OFPS_VER_ESIST_APERTE (i_code_tipo_contr   IN VARCHAR2,
                                               i_code_of           IN VARCHAR2,
                                               i_code_ps           IN VARCHAR2,
                                               o_num_ofps         OUT NUMBER,
                                               o_errore_sql       OUT NUMBER,
                                               o_errore_msg       OUT VARCHAR2)
            */

          OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_VER_ESIST_APER_CLUS(?,?,?,?,?,?,?,?)}");
          cs.setString(1,tipoContr);
          cs.setString(2,codeOf);
          cs.setString(3,codePs);
              cs.setString(4,codeClus);
              cs.setString(5,tipoClus);
              
          cs.registerOutParameter(6,Types.INTEGER);
          
          cs.registerOutParameter(7,Types.INTEGER);
          cs.registerOutParameter(8,Types.VARCHAR);
          cs.execute();

          if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:ASSOC_OFPS_VER_ESIST_APERTE:"+cs.getInt(5)+":"+cs.getString(6));
        
          if (cs.getInt(7)==DBMessage.NOT_FOUND_RT)
            {
            conn.close();
            return ret;
            }
          
          ret=cs.getInt(6);   
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
                                                                            "check_aperte",
                                                                            this.getClass().getName(),
                                                                            StaticContext.FindExceptionType(sqle));
            }

          throw new CustomException(lexc_Exception.toString(),
                                                                            "",
                                                                            "check_aperte",
                                                                            this.getClass().getName(),
                                                                            StaticContext.FindExceptionType(lexc_Exception));
        }
    return ret;
    }

public int check_esiste(String tipoContr, String codeOf, String codePs)
       throws RemoteException, CustomException
{
 Connection conn=null;
 int ret=0; 
 try
      {
      conn = getConnection(dsName);
 
      /*
    PROCEDURE ASSOC_OFPS_VERIF_ESIST (i_code_tipo_contr   IN VARCHAR2,
                                      i_code_of           IN VARCHAR2,
                                      i_code_ps           IN VARCHAR2,
                                      o_num_ofps         OUT NUMBER,
                                      o_errore_sql       OUT NUMBER,
                                      o_errore_msg       OUT VARCHAR2)

      */
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_VERIF_ESIST(?,?,?,?,?,?)}");
      cs.setString(1,tipoContr);
      cs.setString(2,codeOf);
      cs.setString(3,codePs);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:ASSOC_OFPS_VERIF_ESIST:"+cs.getInt(5)+":"+cs.getString(6));
    
      if (cs.getInt(5)==DBMessage.NOT_FOUND_RT)
        {
        conn.close();
        return ret;
        }
      
      ret=cs.getInt(4);   
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
									"check_esiste",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"check_esiste",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return ret;
}

    public int check_esiste_clus(String tipoContr, String codeOf, String codePs, String codeClus, String tipoClus)
           throws RemoteException, CustomException
    {
     Connection conn=null;
     int ret=0; 
     try
          {
          conn = getConnection(dsName);
     
          /*
        PROCEDURE ASSOC_OFPS_VERIF_ESIST (i_code_tipo_contr   IN VARCHAR2,
                                          i_code_of           IN VARCHAR2,
                                          i_code_ps           IN VARCHAR2,
                                          o_num_ofps         OUT NUMBER,
                                          o_errore_sql       OUT NUMBER,
                                          o_errore_msg       OUT VARCHAR2)

          */
          OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_VERIF_ESIST_CLUS(?,?,?,?,?,?,?,?)}");
          cs.setString(1,tipoContr);
          cs.setString(2,codeOf);
          cs.setString(3,codePs);
              cs.setString(4,codeClus);
              cs.setString(5,tipoClus);
          cs.registerOutParameter(6,Types.INTEGER);
          cs.registerOutParameter(7,Types.INTEGER);
          cs.registerOutParameter(8,Types.VARCHAR);
          cs.execute();

          if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:ASSOC_OFPS_VERIF_ESIST:"+cs.getInt(7)+":"+cs.getString(8));
        
          if (cs.getInt(7)==DBMessage.NOT_FOUND_RT)
            {
            conn.close();
            return ret;
            }
          
          ret=cs.getInt(6);   
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
                                                                            "check_esiste",
                                                                            this.getClass().getName(),
                                                                            StaticContext.FindExceptionType(sqle));
            }

          throw new CustomException(lexc_Exception.toString(),
                                                                            "",
                                                                            "check_esiste",
                                                                            this.getClass().getName(),
                                                                            StaticContext.FindExceptionType(lexc_Exception));
        }
        return ret;
    }

public CanoneElem check_canone_exist(String tipoContr, String classeOf, String codePs)
        throws RemoteException, CustomException
  {
  CanoneElem ret=null;

  Connection conn=null;

  try
      {
      conn = getConnection(dsName);
           /* 
    PROCEDURE ASSOC_OFPS_LEGGI_DATI_MA (i_code_tipo_contratto  IN VARCHAR2,
                                        i_code_c_of            IN VARCHAR2,
                                        i_code_ps              IN VARCHAR2,
                                        o_code_freq            OUT VARCHAR2,
                                        o_code_mod_appl        OUT VARCHAR2,
                                        o_tipo_flag            OUT VARCHAR2,
                                        o_qta_shift            OUT NUMBER,
                                        o_errore_sql           OUT NUMBER,
                                        o_errore_msg           OUT VARCHAR2)
           */ 
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_LEGGI_DATI_MA(?,?,?,?,?,?,?,?,?)}");
      cs.setString(1,tipoContr);
      cs.setString(2,classeOf);
      cs.setString(3,codePs);
      
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.registerOutParameter(7,Types.INTEGER);
      
      cs.registerOutParameter(8,Types.INTEGER);
      cs.registerOutParameter(9,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(8)!=DBMessage.OK_RT)&&(cs.getInt(8)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:ASSOC_OFPS_LEGGI_DATI_MA:"+cs.getInt(8)+":"+cs.getString(9));
    
      if (cs.getInt(8)==DBMessage.NOT_FOUND_RT)
        {
        conn.close();
        return ret;
        }
      
      ret=new CanoneElem(cs.getString(4),cs.getString(5),cs.getString(6),cs.getInt(7));

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
									"check_canone_exist",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"check_canone_exist",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return ret;
   
  }
  
    public CanoneElem check_canone_exist_cluster(String tipoContr, String classeOf, String codePs,String cod_cluster, String tipo_cluster)
            throws RemoteException, CustomException
      {
      CanoneElem ret=null;

      Connection conn=null;

      try
          {
          conn = getConnection(dsName);
               /* 
        PROCEDURE ASSOC_OFPS_LEGGI_DATI_MA (i_code_tipo_contratto  IN VARCHAR2,
                                            i_code_c_of            IN VARCHAR2,
                                            i_code_ps              IN VARCHAR2,
                                            o_code_freq            OUT VARCHAR2,
                                            o_code_mod_appl        OUT VARCHAR2,
                                            o_tipo_flag            OUT VARCHAR2,
                                            o_qta_shift            OUT NUMBER,
                                            o_errore_sql           OUT NUMBER,
                                            o_errore_msg           OUT VARCHAR2)
               */ 
          OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_LEGGI_DATI_MA_CLU(?,?,?,?,?,?,?,?,?,?,?)}");
          cs.setString(1,tipoContr);
          cs.setString(2,classeOf);
          cs.setString(3,codePs);
              cs.setString(4,cod_cluster);
              cs.setString(5,tipo_cluster);
              
          cs.registerOutParameter(6,Types.VARCHAR);
          cs.registerOutParameter(7,Types.VARCHAR);
          cs.registerOutParameter(8,Types.VARCHAR);
          cs.registerOutParameter(9,Types.INTEGER);
          
          cs.registerOutParameter(10,Types.INTEGER);
          cs.registerOutParameter(11,Types.VARCHAR);
          cs.execute();

          if ((cs.getInt(10)!=DBMessage.OK_RT)&&(cs.getInt(10)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:ASSOC_OFPS_LEGGI_DATI_MA:"+cs.getInt(10)+":"+cs.getString(11));
        
          if (cs.getInt(10)==DBMessage.NOT_FOUND_RT)
            {
            conn.close();
            return ret;
            }
          
          ret=new CanoneElem(cs.getString(6),cs.getString(7),cs.getString(8),cs.getInt(9));

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
                                                                            "check_canone_exist",
                                                                            this.getClass().getName(),
                                                                            StaticContext.FindExceptionType(sqle));
            }

          throw new CustomException(lexc_Exception.toString(),
                                                                            "",
                                                                            "check_canone_exist",
                                                                            this.getClass().getName(),
                                                                            StaticContext.FindExceptionType(lexc_Exception));
        }
        return ret;
       
      }
      
  public void ejbCreate()
  {
  }

  public void ejbActivate()
  {
  }

  public void ejbPassivate()
  {
  }

  public void ejbRemove()
  {
  }

  public void setSessionContext(SessionContext ctx)
  {
  }
}