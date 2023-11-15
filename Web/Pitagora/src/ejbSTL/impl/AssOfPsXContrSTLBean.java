package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;

import java.sql.*;

import oracle.jdbc.*;
import oracle.sql.*;
import java.rmi.*;


import com.utl.*;

public class AssOfPsXContrSTLBean extends AbstractSessionCommonBean implements SessionBean  
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


public String getMinDataIniCorr(String tipoContr, String codeContr,String dataCorr, String codeOf, String codePs)
       throws RemoteException, CustomException
  {
  String dt="";

  Connection conn=null;
  try
      {
      conn = getConnection(dsName);
              /*
                PROCEDURE ASSOC_OFPS_X_CONTR_MINDIV_CORR
                                              (i_tipo_contr        IN  VARCHAR2,
                                               i_code_contr        IN  VARCHAR2,
                                               i_data              IN  VARCHAR2,
                                               i_code_of           IN  VARCHAR2,
                                               i_code_ps           IN  VARCHAR2,
                                               o_data_inizio_valid OUT VARCHAR2,
                                               o_errore_sql        OUT NUMBER,
                                               o_errore_msg        OUT VARCHAR2);
                */
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_MINDIV_CORR(?,?,?,?,?,?,?,?)}");
      cs.setString(1,tipoContr);
      cs.setString(2,codeContr);
      cs.setString(3,dataCorr);
      cs.setString(4,codeOf);
      cs.setString(5,codePs);
      
      cs.registerOutParameter(6,Types.VARCHAR);
      
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:ASSOC_OFPS_X_CONTR_MINDIV_CORR:"+cs.getInt(7)+":"+cs.getString(8));
    
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


public String getMinDataIniCorrClus(String tipoContr, String codeContr,String dataCorr, String codeOf, String codePs, String codeClus, String tipoClus)
       throws RemoteException, CustomException
  {
  String dt="";

  Connection conn=null;
  try
      {
      conn = getConnection(dsName);
              /*
                PROCEDURE ASSOC_OFPS_X_CONTR_MINDIV_CORR
                                              (i_tipo_contr        IN  VARCHAR2,
                                               i_code_contr        IN  VARCHAR2,
                                               i_data              IN  VARCHAR2,
                                               i_code_of           IN  VARCHAR2,
                                               i_code_ps           IN  VARCHAR2,
                                               o_data_inizio_valid OUT VARCHAR2,
                                               o_errore_sql        OUT NUMBER,
                                               o_errore_msg        OUT VARCHAR2);
                */
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_MINDIV_CLUS(?,?,?,?,?,?,?,?,?,?)}");
      cs.setString(1,tipoContr);
      cs.setString(2,codeContr);
      cs.setString(3,dataCorr);
      cs.setString(4,codeOf);
      cs.setString(5,codePs);
      cs.setString(6,codeClus);
	  cs.setString(7,tipoClus);
	  
      cs.registerOutParameter(8,Types.VARCHAR);
      
      cs.registerOutParameter(9,Types.INTEGER);
      cs.registerOutParameter(10,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(9)!=DBMessage.OK_RT)&&(cs.getInt(9)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:ASSOC_OFPS_X_CONTR_MINDIV_CLUS:"+cs.getInt(9)+":"+cs.getString(10));
    
      if (cs.getInt(9)==DBMessage.NOT_FOUND_RT)
        {
        conn.close();
        return dt;
        }
      
      dt=cs.getString(8);   

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

public String getMinDataIni(String tipoContr, String codeContr, String codeOf, String codePs)
       throws RemoteException, CustomException
{
String dt="";

Connection conn=null;
try
      {
      conn = getConnection(dsName);
      /*
       PROCEDURE ASSOC_OFPS_X_CONTR_MIN_DIV
                              (i_tipo_contr        IN  VARCHAR2,
                               i_code_contr        IN  VARCHAR2,
                               i_code_of           IN  VARCHAR2,
                               i_code_ps           IN  VARCHAR2,
                               o_data_inizio_valid OUT VARCHAR2,
                               o_errore_sql        OUT NUMBER,
                               o_errore_msg        OUT VARCHAR2);
      */
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_MIN_DIV(?,?,?,?,?,?,?)}");
      cs.setString(1,tipoContr);
      cs.setString(2,codeContr);
      cs.setString(3,codeOf);
      cs.setString(4,codePs);
      
      cs.registerOutParameter(5,Types.VARCHAR);
      
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(6)!=DBMessage.OK_RT)&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:ASSOC_OFPS_X_CONTR_MIN_DIV:"+cs.getInt(6)+":"+cs.getString(7));
    
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


    public String getMinDataIniClus(String tipoContr, String codeContr, String codeOf, String codePs,String cod_cluster,String tipo_cluster)
           throws RemoteException, CustomException
    {
    String dt="";

    Connection conn=null;
    try
          {
          conn = getConnection(dsName);
          /*
           PROCEDURE ASSOC_OFPS_X_CONTR_MIN_DIV
                                  (i_tipo_contr        IN  VARCHAR2,
                                   i_code_contr        IN  VARCHAR2,
                                   i_code_of           IN  VARCHAR2,
                                   i_code_ps           IN  VARCHAR2,
                                   o_data_inizio_valid OUT VARCHAR2,
                                   o_errore_sql        OUT NUMBER,
                                   o_errore_msg        OUT VARCHAR2);
          */
          OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_MIN_DIV_C(?,?,?,?,?,?,?,?,?)}");
          cs.setString(1,tipoContr);
          cs.setString(2,codeContr);
          cs.setString(3,codeOf);
          cs.setString(4,codePs);
              cs.setString(5,cod_cluster);
              cs.setString(6,tipo_cluster);
          
          cs.registerOutParameter(7,Types.VARCHAR);
          
          cs.registerOutParameter(8,Types.INTEGER);
          cs.registerOutParameter(9,Types.VARCHAR);
          cs.execute();

          if ((cs.getInt(8)!=DBMessage.OK_RT)&&(cs.getInt(8)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:ASSOC_OFPS_X_CONTR_MIN_DIV:"+cs.getInt(8)+":"+cs.getString(9));
        
          if (cs.getInt(8)==DBMessage.NOT_FOUND_RT)
            {
            conn.close();
            return dt;
            }
          
          dt=cs.getString(7);   

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



public String getMaxDataFine(String tipoContr, String codeContr, String codeOf, String codePs)
       throws RemoteException, CustomException
{
String dt="";

Connection conn=null;
try
      {
      conn = getConnection(dsName);
      /*
      PROCEDURE ASSOC_OFPS_X_CONTR_MAX_DFV
                                    (i_tipo_contr        IN  VARCHAR2,
                                     i_code_contr        IN  VARCHAR2,
                                     i_code_of           IN  VARCHAR2,
                                     i_code_ps           IN  VARCHAR2,
                                     o_data_fine_valid   OUT VARCHAR2,
                                     o_errore_sql        OUT NUMBER,
                                     o_errore_msg        OUT VARCHAR2);

      */
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_MAX_DFV(?,?,?,?,?,?,?)}");
      cs.setString(1,tipoContr);
      cs.setString(2,codeContr);
      cs.setString(3,codeOf);
      cs.setString(4,codePs);
      
      cs.registerOutParameter(5,Types.VARCHAR);
      
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(6)!=DBMessage.OK_RT)&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:ASSOC_OFPS_X_CONTR_MAX_DFV:"+cs.getInt(6)+":"+cs.getString(7));
    
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

    public String getMaxDataFineCluster(String tipoContr, String codeContr, String codeOf, String codePs, String codeClus, String tipoClus, String codeTipoContr)
           throws RemoteException, CustomException
    {
    String dt="";

    Connection conn=null;
    try
          {
          conn = getConnection(dsName);

          OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_MAX_DFV_CLU(?,?,?,?,?,?,?,?,?,?)}");
          cs.setString(1,tipoContr);
          cs.setString(2,codeContr);
          cs.setString(3,codeOf);
          cs.setString(4,codePs);
              cs.setString(5,codeClus);
              cs.setString(6,tipoClus);
              cs.setString(7,codeTipoContr);
              
          cs.registerOutParameter(8,Types.VARCHAR);
          
          cs.registerOutParameter(9,Types.INTEGER);
          cs.registerOutParameter(10,Types.VARCHAR);
          cs.execute();

          if ((cs.getInt(9)!=DBMessage.OK_RT)&&(cs.getInt(9)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:ASSOC_OFPS_X_CONTR_MAX_DFV:"+cs.getInt(9)+":"+cs.getString(10));
        
          if (cs.getInt(9)==DBMessage.NOT_FOUND_RT)
            {
            conn.close();
            return dt;
            }
          
          dt=cs.getString(8);   

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

public int check_aperte(String tipoContr, String codeContr, String codeOf, String codePs)
       throws RemoteException, CustomException
{
Connection conn=null;
int ret=0; 
 
try
      {
      conn = getConnection(dsName);
 
        /*
        PROCEDURE ASSOC_OFPS_X_CONTR_VER_ES_AP
                                      (i_tipo_contr        IN  VARCHAR2,
                                       i_code_contr        IN  VARCHAR2,
                                       i_code_of           IN  VARCHAR2,
                                       i_code_ps           IN  VARCHAR2,
                                       o_num_ass_ofps      OUT NUMBER,
                                       o_errore_sql        OUT NUMBER,
                                       o_errore_msg        OUT VARCHAR2);
        */

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_VER_ES_AP(?,?,?,?,?,?,?)}");
      cs.setString(1,tipoContr);
      cs.setString(2,codeContr);
      cs.setString(3,codeOf);
      cs.setString(4,codePs);
      
      cs.registerOutParameter(5,Types.INTEGER);
      
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(6)!=DBMessage.OK_RT)&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:ASSOC_OFPS_X_CONTR_VER_ES_AP:"+cs.getInt(6)+":"+cs.getString(7));
    
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

    public int check_aperte_clus(String tipoContr, String codeContr, String codeOf, String codePs, String codeClus, String tipoClus, String codeTipoContr)
           throws RemoteException, CustomException
    {
    Connection conn=null;
    int ret=0; 
     
    try
          {
          conn = getConnection(dsName);
     
            /*
            PROCEDURE ASSOC_OFPS_X_CONTR_VER_ES_AP
                                          (i_tipo_contr        IN  VARCHAR2,
                                           i_code_contr        IN  VARCHAR2,
                                           i_code_of           IN  VARCHAR2,
                                           i_code_ps           IN  VARCHAR2,
                                           o_num_ass_ofps      OUT NUMBER,
                                           o_errore_sql        OUT NUMBER,
                                           o_errore_msg        OUT VARCHAR2);
            */

          OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_VER_ES_AP_C(?,?,?,?,?,?,?,?,?,?)}");
          cs.setString(1,tipoContr);
          cs.setString(2,codeContr);
          cs.setString(3,codeOf);
          cs.setString(4,codePs);
          
              cs.setString(5,codeClus);
              cs.setString(6,tipoClus);          
              cs.setString(7,codeTipoContr);
              
          cs.registerOutParameter(8,Types.INTEGER);
          
          cs.registerOutParameter(9,Types.INTEGER);
          cs.registerOutParameter(10,Types.VARCHAR);
          cs.execute();

          if ((cs.getInt(9)!=DBMessage.OK_RT)&&(cs.getInt(9)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:ASSOC_OFPS_X_CONTR_VER_ES_AP:"+cs.getInt(9)+":"+cs.getString(10));
        
          if (cs.getInt(9)==DBMessage.NOT_FOUND_RT)
            {
            conn.close();
            return ret;
            }
          
          ret=cs.getInt(8);   

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


public int check_esiste(String tipoContr, String codeContr, String codeOf, String codePs)
       throws RemoteException, CustomException
{
 Connection conn=null;
 int ret=0; 
 try
      {
      conn = getConnection(dsName);
 
      /*
      PROCEDURE ASSOC_OFPS_X_CONTR_VER_ES
                                    (i_tipo_contr        IN  VARCHAR2,
                                     i_code_contr        IN  VARCHAR2,
                                     i_code_of           IN  VARCHAR2,
                                     i_code_ps           IN  VARCHAR2,
                                     o_num_ass_ofps      OUT NUMBER,
                                     o_errore_sql        OUT NUMBER,
                                     o_errore_msg        OUT VARCHAR2);

      */
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_VER_ES(?,?,?,?,?,?,?)}");
      cs.setString(1,tipoContr);
      cs.setString(2,codeContr);
      cs.setString(3,codeOf);
      cs.setString(4,codePs);
//System.out.println("tipoContr="+tipoContr);
//System.out.println("codeContr="+codeContr);
//System.out.println("codeOf="+codeOf);
//System.out.println("codePs="+codePs);
      
      cs.registerOutParameter(5,Types.INTEGER);
      
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(6)!=DBMessage.OK_RT)&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:ASSOC_OFPS_X_CONTR_VER_ES:"+cs.getInt(6)+":"+cs.getString(7));
    
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

    public int check_esiste_clus(String tipoContr, String codeContr, String codeOf, String codePs, String codeClus, String tipoClus, String codeTipoContr)
           throws RemoteException, CustomException
    {
     Connection conn=null;
     int ret=0; 
     try
          {
          conn = getConnection(dsName);
     
          OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_VER_ES_CLUS(?,?,?,?,?,?,?,?,?,?)}");
          cs.setString(1,tipoContr);
          cs.setString(2,codeContr);
          cs.setString(3,codeOf);
          cs.setString(4,codePs);
          
              cs.setString(5,codeClus);
              cs.setString(6,tipoClus);
              cs.setString(7,codeTipoContr);
              
    //System.out.println("tipoContr="+tipoContr);
    //System.out.println("codeContr="+codeContr);
    //System.out.println("codeOf="+codeOf);
    //System.out.println("codePs="+codePs);
          
          cs.registerOutParameter(8,Types.INTEGER);
          
          cs.registerOutParameter(9,Types.INTEGER);
          cs.registerOutParameter(10,Types.VARCHAR);
          cs.execute();

          if ((cs.getInt(9)!=DBMessage.OK_RT)&&(cs.getInt(9)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:ASSOC_OFPS_X_CONTR_VER_ES:"+cs.getInt(9)+":"+cs.getString(10));
        
          if (cs.getInt(9)==DBMessage.NOT_FOUND_RT)
            {
            conn.close();
            return ret;
            }
          
          ret=cs.getInt(8);   

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

public CanoneElem check_canone_exist(String tipoContr, String codeContr, String classeOf, String codePs)
        throws RemoteException, CustomException
  {
  CanoneElem ret=null;

  Connection conn=null;

  try
      {
      conn = getConnection(dsName);
           /* 
           PROCEDURE ASSOC_OFPS_X_CONTR_DATI_MA
                                      (i_tipo_contr        IN  VARCHAR2,
                                       i_code_contr        IN  VARCHAR2,
                                       i_classe_of         IN  VARCHAR2,
                                       i_code_ps           IN  VARCHAR2,
                                       o_code_freq         OUT VARCHAR2,
                                       o_code_mod_appl     OUT VARCHAR2,
                                       o_flag_ant_post     OUT VARCHAR2,
                                       o_qnta_shift_canoni OUT NUMBER,
                                       o_errore_sql        OUT NUMBER,
                                       o_errore_msg        OUT VARCHAR2);
           */ 
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_DATI_MA(?,?,?,?,?,?,?,?,?,?)}");
      cs.setString(1,tipoContr);
      cs.setString(2,codeContr);
      cs.setString(3,classeOf);
      cs.setString(4,codePs);
      
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.registerOutParameter(8,Types.INTEGER);
      
      cs.registerOutParameter(9,Types.INTEGER);
      cs.registerOutParameter(10,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(9)!=DBMessage.OK_RT)&&(cs.getInt(9)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:ASSOC_OFPS_X_CONTR_DATI_MA:"+cs.getInt(9)+":"+cs.getString(10));
    
      if (cs.getInt(9)==DBMessage.NOT_FOUND_RT)
        {
        conn.close();
        return ret;
        }
      
      ret=new CanoneElem(cs.getString(5),cs.getString(6),cs.getString(7),cs.getInt(8));
           
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

    public CanoneElem check_canone_exist_cluster(String tipoContr, String codeContr, String classeOf, String codePs, String codeClus, String tipoClus)
            throws RemoteException, CustomException
      {
      CanoneElem ret=null;

      Connection conn=null;

      try
          {
          conn = getConnection(dsName);

          OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_DATI_MA_CLU(?,?,?,?,?,?,?,?,?,?,?,?)}");
          cs.setString(1,tipoContr);
          cs.setString(2,codeContr);
          cs.setString(3,classeOf);
          cs.setString(4,codePs);
          
              cs.setString(5,codeClus);
              cs.setString(6,tipoClus);
          
          cs.registerOutParameter(7,Types.VARCHAR);
          cs.registerOutParameter(8,Types.VARCHAR);
          cs.registerOutParameter(9,Types.VARCHAR);
          cs.registerOutParameter(10,Types.INTEGER);
          
          cs.registerOutParameter(11,Types.INTEGER);
          cs.registerOutParameter(12,Types.VARCHAR);
          cs.execute();

          if ((cs.getInt(11)!=DBMessage.OK_RT)&&(cs.getInt(11)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:ASSOC_OFPS_X_CONTR_DATI_MA:"+cs.getInt(11)+":"+cs.getString(12));
        
          if (cs.getInt(11)==DBMessage.NOT_FOUND_RT)
            {
            conn.close();
            return ret;
            }
          
          ret=new CanoneElem(cs.getString(7),cs.getString(8),cs.getString(9),cs.getInt(10));
               
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