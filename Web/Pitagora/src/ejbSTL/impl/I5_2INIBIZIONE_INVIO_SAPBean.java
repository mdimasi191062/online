package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.ejb.EJBException;
import oracle.jdbc.OracleTypes;
import com.utl.StaticContext;
import com.utl.AbstractSequenceBean;
import java.util.*;
import com.ejbSTL.I5_2INIBIZIONE_INVIO_SAP_ROW;


import java.rmi.RemoteException;
import java.sql.*;
import com.utl.*;

public class I5_2INIBIZIONE_INVIO_SAPBean  extends AbstractSessionCommonBean implements SessionBean 
{
  private final String PKG_NAME = "PKG_INIBIZIONE_GESTSAP";
  private String findAll = "{? = call " + PKG_NAME +".GET_RESULTSET_INIB_INVIO_SAP(?) }";
  private String insertInibSap  = "{? = call " + PKG_NAME +".INIB_INVIO_SAPIns(?,?,?,?,?,?,?,?,?) }";  
  private String checkGestSap  = "{? = call " + PKG_NAME +".checkGestSap(?,?,?,?) }";  
  private String findGestore = "{? = call " + PKG_NAME +".GET_INIB_INVIO_SAP_ONE(?,?) }";
  private String modifyInibSap = "{? = call " + PKG_NAME +".MODIF_INIBSAP(?,?,?,?,?,?,?) }";  
  private String elimina = "{? = call " + PKG_NAME +".ELIMINA_INIBSAP(?) }";
  private String chiudi = "{? = call " + PKG_NAME +".CHIUDI_INIBSAP(?) }";
  
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
  
  public Vector findAllGestore(String flagSys) throws CustomException
  {

    CallableStatement cs = null;
    Vector recs = new Vector();
    I5_2INIBIZIONE_INVIO_SAP_ROW row = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAll);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.setString(2,flagSys);
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      { 
        row =  new I5_2INIBIZIONE_INVIO_SAP_ROW();
        row.setID_REGOLA(rs.getInt("ID_REGOLA"));
        row.setCODE_ACCOUNT(rs.getString("CODE_ACCOUNT"));
        row.setCODE_GEST(rs.getString("CODE_GEST"));     
        row.setDESC_ACCOUNT(rs.getString("DESC_ACCOUNT")); 
        row.setDATA_INIZIO_VALID(rs.getString("DATA_INIZIO_VALID"));
        row.setDATA_FINE_VALID(rs.getString("DATA_FINE_VALID"));
        row.setCODE_TIPO_CONTR(rs.getString("CODE_TIPO_CONTR"));
        row.setTIPO_DOC(rs.getString("TIPO_DOC"));
        if (!(rs.getString("FLAG_SAP") == null))
          {row.setFLAG_SAP(rs.getString("FLAG_SAP"));} 
        else 
           {row.setFLAG_SAP(""); }
        if (!(rs.getString("FLAG_RESOCONTO_SAP") == null))
          {row.setFLAG_RESOCONTO_SAP(rs.getString("FLAG_RESOCONTO_SAP"));} 
        else 
          { row.setFLAG_RESOCONTO_SAP(""); }
        if (!(rs.getString("NOTE_RESOCONTO_SAP") == null))
          {row.setNOTE_RESOCONTO_SAP(rs.getString("NOTE_RESOCONTO_SAP"));} 
        else 
          { row.setNOTE_RESOCONTO_SAP(""); }        
        if (!(rs.getString("NOTE") == null))
        {row.setNOTE(rs.getString("NOTE"));} 
        else 
        { row.setNOTE(""); }
        
        if (!(rs.getString("TIPO_DOC") == null))
            {row.setTIPO_DOC(rs.getString("TIPO_DOC"));} 
        else 
        { row.setTIPO_DOC(""); }        
        
        row.setFLAG_SYS(rs.getString("FLAG_SYS"));
        row.setFLAG_ATTIVA(rs.getString("FLAG_ATTIVA"));
        recs.add(row);
      } 
      rs.close();
    } 
    catch (Exception e) {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2INIBIZIONE_INVIO_SAP","findAll","I5_2INIBIZIONE_INVIO_SAPBean",StaticContext.FindExceptionType(e));
    } finally {
      try {
	       cs.close();
      } catch (Exception e) {
              System.out.println(e.getMessage());
              throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2INIBIZIONE_INVIO_SAP","findAll","I5_2INIBIZIONE_INVIO_SAPBean",StaticContext.FindExceptionType(e));
        }
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
    return recs;
  }


  public Vector findGestore(String descGest, String flagSys) throws CustomException
  {

    CallableStatement cs = null;
    Vector recs = new Vector();
    I5_2INIBIZIONE_INVIO_SAP_ROW row = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(findGestore);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.setString(2,descGest);  
      cs.setString(3,flagSys);
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      { 
        row =  new I5_2INIBIZIONE_INVIO_SAP_ROW();
          row.setID_REGOLA(rs.getInt("ID_REGOLA"));
          row.setCODE_ACCOUNT(rs.getString("CODE_ACCOUNT"));
          row.setCODE_GEST(rs.getString("CODE_GEST"));     
          row.setDESC_ACCOUNT(rs.getString("DESC_ACCOUNT")); 
          row.setDATA_INIZIO_VALID(rs.getString("DATA_INIZIO_VALID"));
          row.setDATA_FINE_VALID(rs.getString("DATA_FINE_VALID"));
          row.setCODE_TIPO_CONTR(rs.getString("CODE_TIPO_CONTR"));   
          row.setTIPO_DOC(rs.getString("TIPO_DOC"));
          if (!(rs.getString("FLAG_SAP") == null))
            {row.setFLAG_SAP(rs.getString("FLAG_SAP"));} 
          else 
             {row.setFLAG_SAP(""); }
          if (!(rs.getString("FLAG_RESOCONTO_SAP") == null))
            {row.setFLAG_RESOCONTO_SAP(rs.getString("FLAG_RESOCONTO_SAP"));} 
          else 
            { row.setFLAG_RESOCONTO_SAP(""); }
          if (!(rs.getString("NOTE_RESOCONTO_SAP") == null))
            {row.setNOTE_RESOCONTO_SAP(rs.getString("NOTE_RESOCONTO_SAP"));} 
          else 
            { row.setNOTE_RESOCONTO_SAP(""); }        
          if (!(rs.getString("NOTE") == null))
          {row.setNOTE(rs.getString("NOTE"));} 
          else 
          { row.setNOTE(""); }
          if (!(rs.getString("TIPO_DOC") == null))
              {row.setTIPO_DOC(rs.getString("TIPO_DOC"));} 
          else 
          { row.setTIPO_DOC(""); }   
          row.setFLAG_SYS(rs.getString("FLAG_SYS"));
          row.setFLAG_ATTIVA(rs.getString("FLAG_ATTIVA"));
        recs.add(row);
      } 
      rs.close();
    } 
    catch (Exception e) {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2INIBIZIONE_INVIO_SAP","findAll","I5_2INIBIZIONE_INVIO_SAPBean",StaticContext.FindExceptionType(e));
    } finally {
      try {
	       cs.close();
      } catch (Exception e) {
              System.out.println(e.getMessage());
              throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2INIBIZIONE_INVIO_SAP","findAll","I5_2INIBIZIONE_INVIO_SAPBean",StaticContext.FindExceptionType(e));
        }
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
    return recs;
  }

    public Boolean modifyInibSap(I5_2INIBIZIONE_INVIO_SAP_ROW row) throws CustomException {
        
        CallableStatement cs = null;
        Integer ret=1;
        try 
        {
          conn = getConnection(dsName);
          
          cs = conn.prepareCall(modifyInibSap);
          cs.registerOutParameter(1,Types.INTEGER) ;
          cs.setInt(2,row.getID_REGOLA());
          cs.setString(3,row.getFLAG_SAP()); 
          cs.setString(4,row.getFLAG_RESOCONTO_SAP()); 
          cs.setString(5,row.getNOTE_RESOCONTO_SAP());      
          cs.setString(6,row.getNOTE());
          cs.setString(7,row.getDATA_FINE_VALID());
          cs.setString(8,row.getTIPO_DOC());
          cs.execute();
          ret = cs.getInt(1);       
        } 
        catch(Exception e)
        {
            System.out.println(e.getMessage());
            throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2INIBIZIONE_INVIO_SAP","update","I5_2INIBIZIONE_INVIO_SAPBean",StaticContext.FindExceptionType(e));
        }
        finally 
        {
          try 
          {
                   cs.close();
          } 
          catch (Exception e) 
          {
              System.out.println(e.getMessage());
              throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2INIBIZIONE_INVIO_SAP","update","I5_2INIBIZIONE_INVIO_SAPBean",StaticContext.FindExceptionType(e));
          }
          try 
          {
                   conn.close();
          } catch (Exception e) {System.out.println(e.getMessage());}
        }

        if (ret != 1){
            return false;
        }
        
        return true;
    }

public Boolean eliminaInibSap(int idRegola) throws CustomException {
         
         CallableStatement cs = null;
         Integer ret=1;
         try 
         {
           conn = getConnection(dsName);
           
           cs = conn.prepareCall(elimina);
           cs.registerOutParameter(1,Types.INTEGER) ;
           cs.setInt(2,idRegola);
           cs.execute();
           ret = cs.getInt(1);       
         } 
         catch(Exception e)
         {
             System.out.println(e.getMessage());
             throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2INIBIZIONE_INVIO_SAP","elimina","I5_2INIBIZIONE_INVIO_SAPBean",StaticContext.FindExceptionType(e));
         }
         finally 
         {
           try 
           {
                    cs.close();
           } 
           catch (Exception e) 
           {
               System.out.println(e.getMessage());
               throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2INIBIZIONE_INVIO_SAP","elimina","I5_2INIBIZIONE_INVIO_SAPBean",StaticContext.FindExceptionType(e));
           }
           try 
           {
                    conn.close();
           } catch (Exception e) {System.out.println(e.getMessage());}
         }

         if (ret != 1){
             return false;
         }
         
         return true;
     }
     
    public Boolean chiudiInibSap(int idRegola) throws CustomException {
             
             CallableStatement cs = null;
             Integer ret=1;
             try 
             {
               conn = getConnection(dsName);
               
               cs = conn.prepareCall(chiudi);
               cs.registerOutParameter(1,Types.INTEGER) ;
               cs.setInt(2,idRegola);
               cs.execute();
               ret = cs.getInt(1);       
             } 
             catch(Exception e)
             {
                 System.out.println(e.getMessage());
                 throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2INIBIZIONE_INVIO_SAP","elimina","I5_2INIBIZIONE_INVIO_SAPBean",StaticContext.FindExceptionType(e));
             }
             finally 
             {
               try 
               {
                        cs.close();
               } 
               catch (Exception e) 
               {
                   System.out.println(e.getMessage());
                   throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2INIBIZIONE_INVIO_SAP","elimina","I5_2INIBIZIONE_INVIO_SAPBean",StaticContext.FindExceptionType(e));
               }
               try 
               {
                        conn.close();
               } catch (Exception e) {System.out.println(e.getMessage());}
             }

             if (ret != 1){
                 return false;
             }
             
             return true;
         }
         
    public String insertInibSap(I5_2INIBIZIONE_INVIO_SAP_ROW row) throws CustomException {
        
        CallableStatement cs = null;
        Integer ret=1;
        try 
        {
          conn = getConnection(dsName);
          
          cs = conn.prepareCall(insertInibSap);
          cs.registerOutParameter(1,Types.INTEGER) ;
          cs.setString(2,row.getCODE_ACCOUNT());
          cs.setString(3,row.getFLAG_SYS()); 
          cs.setString(4,row.getDATA_INIZIO_VALID());            
          cs.setString(5,row.getDATA_FINE_VALID());
          cs.setString(6,row.getFLAG_RESOCONTO_SAP());      
          cs.setString(7,row.getNOTE_RESOCONTO_SAP());      
          cs.setString(8,row.getFLAG_SAP());      
          cs.setString(9,row.getNOTE());      
          cs.setString(10,row.getTIPO_DOC());       

          cs.execute();
          ret = cs.getInt(1);       
        } 
        catch(Exception e)
        {
            System.out.println(e.getMessage());
            throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2INIBIZIONE_INVIO_SAP","insert","I5_2INIBIZIONE_INVIO_SAPBean",StaticContext.FindExceptionType(e));
        }
        finally 
        {
          try 
          {
                   cs.close();
          } 
          catch (Exception e) 
          {
              System.out.println(e.getMessage());
              throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2INIBIZIONE_INVIO_SAP","insert","I5_2INIBIZIONE_INVIO_SAPBean",StaticContext.FindExceptionType(e));
          }
          try 
          {
                   conn.close();
          } catch (Exception e) {System.out.println(e.getMessage());}
        }

        /*if (ret != 1){
            return false;
        }
        
        return true;*/
        return ret.toString();
    }

 public Vector getAccount() throws CustomException, RemoteException{
     
     Connection dbConnection = null;
     ResultSet lrs_Rset = null;
     CallableStatement call = null;
     try
     {
       Vector lvct_Accounts = new Vector();
       javax.naming.InitialContext ic = new javax.naming.InitialContext();
       javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
       dbConnection = dataSource.getConnection();

       call = dbConnection.prepareCall("{? = call PKG_INIBIZIONE_GESTSAP.getAccount()}");
       call.registerOutParameter(1, OracleTypes.CURSOR);
       call.execute();

       lrs_Rset = (ResultSet)call.getObject(1);
       while (lrs_Rset.next())
       {
         DB_Account lobj_Account = new DB_Account(); 
         lobj_Account.setCODE_ACCOUNT(lrs_Rset.getString(1));
         lobj_Account.setDESC_ACCOUNT(lrs_Rset.getString(2));
         lobj_Account.setCODE_GEST(lrs_Rset.getString(3));
         lvct_Accounts.addElement(lobj_Account);
       }
       return lvct_Accounts;
     } catch (Exception lexc_Exception)
     {
       throw new CustomException(lexc_Exception.toString(), "", 
                                 "getAccount", 
                                 this.getClass().getName(), 
                                 StaticContext.FindExceptionType(lexc_Exception));
     } finally
     {
       try
       {
         lrs_Rset.close();
         call.close();
         dbConnection.close();
       } catch (Exception lexc_Exception)
       {
         throw new CustomException(lexc_Exception.toString(), "", 
                                   "getAccount", 
                                   this.getClass().getName(), 
                                   StaticContext.FindExceptionType(lexc_Exception));
       }
     }
 }
    public Vector getAccountCl() throws CustomException, RemoteException{
        
        Connection dbConnection = null;
        ResultSet lrs_Rset = null;
        CallableStatement call = null;
        try
        {
          Vector lvct_Accounts = new Vector();
          javax.naming.InitialContext ic = new javax.naming.InitialContext();
          javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
          dbConnection = dataSource.getConnection();

          call = dbConnection.prepareCall("{? = call PKG_INIBIZIONE_GESTSAP.getAccountCl()}");
          call.registerOutParameter(1, OracleTypes.CURSOR);
          call.execute();

          lrs_Rset = (ResultSet)call.getObject(1);
          while (lrs_Rset.next())
          {
            DB_Account lobj_Account = new DB_Account(); 
            lobj_Account.setCODE_ACCOUNT(lrs_Rset.getString(1));
            lobj_Account.setDESC_ACCOUNT(lrs_Rset.getString(2));
            lobj_Account.setCODE_GEST(lrs_Rset.getString(3));
            lvct_Accounts.addElement(lobj_Account);
          }
          return lvct_Accounts;
        } catch (Exception lexc_Exception)
        {
          throw new CustomException(lexc_Exception.toString(), "", 
                                    "getAccountCl", 
                                    this.getClass().getName(), 
                                    StaticContext.FindExceptionType(lexc_Exception));
        } finally
        {
          try
          {
            lrs_Rset.close();
            call.close();
            dbConnection.close();
          } catch (Exception lexc_Exception)
          {
            throw new CustomException(lexc_Exception.toString(), "", 
                                      "getAccountCl", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }
}
  
