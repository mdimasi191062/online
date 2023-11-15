package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import java.util.Vector;
import java.sql.*;
import com.utl.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oracle.jdbc.OracleTypes;

public class Ent_TipiServizioBean implements SessionBean 
{
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


  public Vector getTipiServiziAssurance()
        throws CustomException, RemoteException
  {
    try
    {
      Vector lvct_TipiServizio = new Vector();
      Connection dbConnection;

      javax.naming.InitialContext ic = new javax.naming.InitialContext(); 
      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME); 
      dbConnection = dataSource.getConnection();

      CallableStatement call = dbConnection.prepareCall("{? = call PKG_BILL_COM.getTipiServiziAssurance(?,?)}");
      call.registerOutParameter(1, OracleTypes.CURSOR);
      call.registerOutParameter(2, OracleTypes.VARCHAR);
      call.registerOutParameter(3, OracleTypes.VARCHAR);
      call.execute();

      String data_inizio_ciclo = call.getString(2);
      String descrizione_ciclo = call.getString(3);
      System.out.println("data_inizio_ciclo="+data_inizio_ciclo);
      System.out.println("descrizione_ciclo="+descrizione_ciclo);    
      
      ResultSet lrs_Rset = (ResultSet)call.getObject(1);
      DB_TipiServizio lobj_TipoServizio = new DB_TipiServizio();
      while (lrs_Rset.next())
      
      {
        lobj_TipoServizio = new DB_TipiServizio();
        
        lobj_TipoServizio.setCODE_TIPO_SERVIZIO(lrs_Rset.getString("CODE_TIPO_SERVIZIO"));
        lobj_TipoServizio.setDESC_TIPO_SERVIZIO(lrs_Rset.getString("DESC_TIPO_SERVIZIO"));
        lvct_TipiServizio.addElement(lobj_TipoServizio);
      }
      
      lrs_Rset.close();
      call.close();
      dbConnection.close();
      
      lobj_TipoServizio = new DB_TipiServizio();
      
      //Data Ultimo Congelamento
      lobj_TipoServizio.setCODE_TIPO_SERVIZIO(data_inizio_ciclo);
      lobj_TipoServizio.setDESC_TIPO_SERVIZIO(descrizione_ciclo);
      lvct_TipiServizio.addElement(lobj_TipoServizio);
      
      return lvct_TipiServizio;
    }
    catch(Exception lexc_Exception)
    {
    throw new CustomException(lexc_Exception.toString(),
                    "",
                  "getTipiServizio",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
  }
  }

  
  public Vector getTipiServiziAssuranceXDSL()
        throws CustomException, RemoteException
  {
    try
    {
      Vector lvct_TipiServizio = new Vector();
      Connection dbConnection;

      javax.naming.InitialContext ic = new javax.naming.InitialContext(); 
      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME); 
      dbConnection = dataSource.getConnection();

      CallableStatement call = dbConnection.prepareCall("{? = call PKG_BILL_COM.getTipiServiziAssuranceXDSL(?,?)}");
      call.registerOutParameter(1, OracleTypes.CURSOR);
      call.registerOutParameter(2, OracleTypes.VARCHAR);
      call.registerOutParameter(3, OracleTypes.VARCHAR);
      call.execute();

      String data_inizio_ciclo = call.getString(2);
      String descrizione_ciclo = call.getString(3);
      System.out.println("data_inizio_ciclo="+data_inizio_ciclo);
      System.out.println("descrizione_ciclo="+descrizione_ciclo);    
      
      ResultSet lrs_Rset = (ResultSet)call.getObject(1);
      DB_TipiServizio lobj_TipoServizio = new DB_TipiServizio();
      while (lrs_Rset.next())
      
      {
        lobj_TipoServizio = new DB_TipiServizio();
        
        lobj_TipoServizio.setCODE_TIPO_SERVIZIO(lrs_Rset.getString("CODE_TIPO_SERVIZIO"));
        lobj_TipoServizio.setDESC_TIPO_SERVIZIO(lrs_Rset.getString("DESC_TIPO_SERVIZIO"));
        lvct_TipiServizio.addElement(lobj_TipoServizio);
      }
      
      lrs_Rset.close();
      call.close();
      dbConnection.close();
      
      lobj_TipoServizio = new DB_TipiServizio();
      
      //Data Ultimo Congelamento
      lobj_TipoServizio.setCODE_TIPO_SERVIZIO(data_inizio_ciclo);
      lobj_TipoServizio.setDESC_TIPO_SERVIZIO(descrizione_ciclo);
      lvct_TipiServizio.addElement(lobj_TipoServizio);
      
      return lvct_TipiServizio;
    }
    catch(Exception lexc_Exception)
    {
    throw new CustomException(lexc_Exception.toString(),
                    "",
                  "getTipiServizio",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
  }
  }
  
  public Vector getTipiServiziAssuranceReg()
        throws CustomException, RemoteException
  {
    try
    {
      Vector lvct_TipiServizio = new Vector();
      Connection dbConnection;

      javax.naming.InitialContext ic = new javax.naming.InitialContext(); 
      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME); 
      dbConnection = dataSource.getConnection();

      CallableStatement call = dbConnection.prepareCall("{? = call PKG_BILL_COM.getTipiServiziAssuranceReg(?,?)}");
      call.registerOutParameter(1, OracleTypes.CURSOR);
      call.registerOutParameter(2, OracleTypes.VARCHAR);
      call.registerOutParameter(3, OracleTypes.VARCHAR);
      call.execute();

      String data_inizio_ciclo = call.getString(2);
      String descrizione_ciclo = call.getString(3);
      System.out.println("data_inizio_ciclo="+data_inizio_ciclo);
      System.out.println("descrizione_ciclo="+descrizione_ciclo);    
      
      ResultSet lrs_Rset = (ResultSet)call.getObject(1);
      DB_TipiServizio lobj_TipoServizio = new DB_TipiServizio();
      while (lrs_Rset.next())
      
      {
        lobj_TipoServizio = new DB_TipiServizio();
        
        lobj_TipoServizio.setCODE_TIPO_SERVIZIO(lrs_Rset.getString("CODE_TIPO_SERVIZIO"));
        lobj_TipoServizio.setDESC_TIPO_SERVIZIO(lrs_Rset.getString("DESC_TIPO_SERVIZIO"));
        lvct_TipiServizio.addElement(lobj_TipoServizio);
      }
      
      lrs_Rset.close();
      call.close();
      dbConnection.close();
      
      lobj_TipoServizio = new DB_TipiServizio();
      
      //Data Ultimo Congelamento
      lobj_TipoServizio.setCODE_TIPO_SERVIZIO(data_inizio_ciclo);
      lobj_TipoServizio.setDESC_TIPO_SERVIZIO(descrizione_ciclo);
      lvct_TipiServizio.addElement(lobj_TipoServizio);
      
      return lvct_TipiServizio;
    }
    catch(Exception lexc_Exception)
    {
    throw new CustomException(lexc_Exception.toString(),
                    "",
                  "getTipiServizio",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
  }
  }
  
  public Vector getTipiGestoreAssurance()
        throws CustomException, RemoteException
  {
    try
    {
      Vector lvct_TipiServizio = new Vector();
      Connection dbConnection;

      javax.naming.InitialContext ic = new javax.naming.InitialContext(); 
      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME); 
      dbConnection = dataSource.getConnection();

      CallableStatement call = dbConnection.prepareCall("{? = call PKG_BILL_COM.getTipiGestoreAssurance(?,?)}");
      call.registerOutParameter(1, OracleTypes.CURSOR);
      call.registerOutParameter(2, OracleTypes.VARCHAR);
      call.registerOutParameter(3, OracleTypes.VARCHAR);
      call.execute();

      String data_inizio_ciclo = call.getString(2);
      String descrizione_ciclo = call.getString(3);
      System.out.println("data_inizio_ciclo="+data_inizio_ciclo);
      System.out.println("descrizione_ciclo="+descrizione_ciclo);
      
      ResultSet lrs_Rset = (ResultSet)call.getObject(1);
      while (lrs_Rset.next())
      {
        DB_TipiServizio lobj_TipoServizio = new DB_TipiServizio();
        lobj_TipoServizio.setCODE_TIPO_SERVIZIO(lrs_Rset.getString("CODE_TIPO_SERVIZIO"));
        lobj_TipoServizio.setDESC_TIPO_SERVIZIO(lrs_Rset.getString("DESC_TIPO_SERVIZIO"));
        lvct_TipiServizio.addElement(lobj_TipoServizio);
      }
      lrs_Rset.close();
      call.close();
      dbConnection.close();
      
      return lvct_TipiServizio;
    }
    catch(Exception lexc_Exception)
    {
    throw new CustomException(lexc_Exception.toString(),
                    "",
                  "getTipiServizio",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
  }
  }

}