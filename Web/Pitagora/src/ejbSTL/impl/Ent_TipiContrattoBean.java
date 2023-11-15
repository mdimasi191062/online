package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import java.util.Vector;
import java.sql.*;
import com.utl.*;
import oracle.jdbc.OracleTypes;

public class Ent_TipiContrattoBean implements SessionBean 
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

  public Vector getTipiContratto(String pstr_NoCodeTipoContrCL,
                                 String pstr_NoCodeTipoContrSP)
        throws CustomException, RemoteException
  {
    try
    {
      Vector lvct_TipiContratto = new Vector();
      Connection dbConnection;

      pstr_NoCodeTipoContrCL = "*" + pstr_NoCodeTipoContrCL + "*";
      pstr_NoCodeTipoContrSP = "*" + pstr_NoCodeTipoContrSP + "*";

      javax.naming.InitialContext ic = new javax.naming.InitialContext(); 
      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME); 
      dbConnection = dataSource.getConnection();

      CallableStatement call = dbConnection.prepareCall("{? = call PKG_BILL_COM.getTipiContratto(?,?)}");
      call.registerOutParameter(1, OracleTypes.CURSOR);
      call.setString(2, pstr_NoCodeTipoContrCL);
      call.setString(3, pstr_NoCodeTipoContrSP);
      call.execute();

      ResultSet lrs_Rset = (ResultSet)call.getObject(1);
      while (lrs_Rset.next())
      {
        DB_TipiContratto lobj_TipoContratto = new DB_TipiContratto();
        lobj_TipoContratto.setCODE_TIPO_CONTR(lrs_Rset.getString("CODE_TIPO_CONTR"));
        lobj_TipoContratto.setDESC_TIPO_CONTR(lrs_Rset.getString("DESC_TIPO_CONTR"));
        lobj_TipoContratto.setFLAG_SYS(lrs_Rset.getString("FLAG_SYS"));
        lvct_TipiContratto.addElement(lobj_TipoContratto);
      }
      lrs_Rset.close();
      call.close();
      dbConnection.close();
      
      return lvct_TipiContratto;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getTipiContratto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

/*PASQUALE */
 public Vector getTipiContrattoFilter(String strLocFilter, String strTipo)
       throws CustomException, RemoteException
 {
   try
   {
     Vector lvct_TipiContratto = new Vector();
     Connection dbConnection;

     javax.naming.InitialContext ic = new javax.naming.InitialContext(); 
     javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME); 
     dbConnection = dataSource.getConnection();

     CallableStatement call = dbConnection.prepareCall("{? = call PKG_BILL_COM.getTipiContrattoFilter(?,?)}");
     call.registerOutParameter(1, OracleTypes.CURSOR);
     call.setString(2, strLocFilter);
     call.setString(3, strTipo);
     call.execute();

     ResultSet lrs_Rset = (ResultSet)call.getObject(1);
     while (lrs_Rset.next())
     {
       DB_TipiContratto lobj_TipoContratto = new DB_TipiContratto();
       lobj_TipoContratto.setCODE_TIPO_CONTR(lrs_Rset.getString("CODE_TIPO_CONTR"));
       lobj_TipoContratto.setDESC_TIPO_CONTR(lrs_Rset.getString("DESC_TIPO_CONTR"));
       lobj_TipoContratto.setFLAG_SYS(lrs_Rset.getString("FLAG_SYS"));
       lvct_TipiContratto.addElement(lobj_TipoContratto);
     }
     lrs_Rset.close();
     call.close();
     dbConnection.close();
     
     return lvct_TipiContratto;
   }
   catch(Exception lexc_Exception)
   {
               throw new CustomException(lexc_Exception.toString(),
                                                                       "",
                                                                       "getTipiContrattoFilter",
                                                                       this.getClass().getName(),
                                                                       StaticContext.FindExceptionType(lexc_Exception));
       }
 }
/*PASQUALE */


  public Vector getTipiContrattoPS() throws CustomException, RemoteException
  {
    try
    {
      Vector lvct_TipiContratto = new Vector();
      Connection dbConnection;

      javax.naming.InitialContext ic = new javax.naming.InitialContext(); 
      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME); 
      dbConnection = dataSource.getConnection();

      CallableStatement call = dbConnection.prepareCall("{? = call PKG_BILL_COM.getTipiContrattoPS}");
      call.registerOutParameter(1, OracleTypes.CURSOR);
      call.execute();

      ResultSet lrs_Rset = (ResultSet)call.getObject(1);
      while (lrs_Rset.next())
      {
        DB_TipiContratto lobj_TipoContratto = new DB_TipiContratto();
        lobj_TipoContratto.setCODE_TIPO_CONTR(lrs_Rset.getString("CODE_TIPO_CONTR"));
        lobj_TipoContratto.setDESC_TIPO_CONTR(lrs_Rset.getString("DESC_TIPO_CONTR"));
        lobj_TipoContratto.setFLAG_SYS(lrs_Rset.getString("FLAG_SYS"));
        lobj_TipoContratto.setTIPO_SPECIAL(lrs_Rset.getString("TIPO_SPECIAL"));
        lvct_TipiContratto.addElement(lobj_TipoContratto);
      }
      lrs_Rset.close();
      call.close();
      dbConnection.close();
      
      return lvct_TipiContratto;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getTipiContrattoPS",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }
}