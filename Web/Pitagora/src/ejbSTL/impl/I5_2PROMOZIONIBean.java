package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.ejb.EJBException;
import oracle.jdbc.OracleTypes;
import com.utl.StaticContext;
import com.utl.AbstractSequenceBean;
import java.util.*;
import com.ejbSTL.I5_2PROMOZIONI_ROW;
import com.ejbSTL.I5_1CONTR;
import com.ejbSTL.I5_2PROMOZIONI_TIPI_ROW;
import java.rmi.RemoteException;
import java.sql.*;
import com.utl.*;
import java.util.Vector;
 
//public class I5_2PROMOZIONIBean  extends AbstractSessionCommonBean implements SessionBean 
 public class I5_2PROMOZIONIBean  extends AbstractClassicEJB implements SessionBean 
{
  private final String PKG_NAME = "PKG_PROMOZIONI";
  private String findAllPromozioni = "{? = call " + PKG_NAME +".I5_2PROMOZIONI_FindAll() }";
  private String findAllTipi       = "{? = call " + PKG_NAME +".I5_2PROMOZIONI_FindTipiAll() }";
  private String findStoredAll     = "{? = call " + PKG_NAME +".I5_2PROMOZIONI_FindStoredAll() }";
  private String insertPromozioni  = "{call " + PKG_NAME +".I5_2PROMOZIONI_Insert(?,?,?,?,?,?) }";  
  private String checkPromozioni   = "{call " + PKG_NAME +".I5_2PROMOZIONI_Check(?,?,?,?) }";
  private String EliminaPromo   = "{call " + PKG_NAME +".EliminaPromo(?) }";
  private String modificaPromo  = "{call " + PKG_NAME +".ModificaPromo(?,?,?) }";
  private String insertPromozioniOF  = "{call " + PKG_NAME +".I5_2PROM_X_OGG_FATRZ_Insert(?,?,?,?) }";  
  private String getServizi        = "{? = call " + PKG_NAME +".getServizi() }";
  private String getServiziXPromo        = "{? = call " + PKG_NAME +".getServiziXPromo(?) }";
  
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
  
  public Vector findAll() throws CustomException
  {
    CallableStatement cs = null;
    Vector recs = new Vector();
    I5_2PROMOZIONI_ROW row = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAllPromozioni);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      { 
        row =  new I5_2PROMOZIONI_ROW();
        row.setCODE_PROMOZIONE(rs.getInt("CODE_PROMOZIONE"));
        row.setDESCRIZIONE(rs.getString("DESCRIZIONE"));     
        row.setTIPO_PROMOZIONE(rs.getInt("TIPO_PROMOZIONE"));
        row.setVALORE(rs.getFloat("VALORE"));
        row.setSTORED_PROCEDURE(rs.getString("STORED_PROCEDURE"));
        row.setDESCR_ESTESA(rs.getString("DESCR_ESTESA"));
        row.setCODE_CLASSE_OF(rs.getString("CODE_CLASSE_OF"));
        row.setCLASSE_OF(rs.getString("CLASSE_OF"));
        recs.add(row);
      } 
      rs.close();
    } 
    catch (Exception e) {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PROMOZIONI","findAll","I5_2PROMOZIONIBean",StaticContext.FindExceptionType(e));
    } finally {
      try {
	       cs.close();
      } catch (Exception e) {
              System.out.println(e.getMessage());
              throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PROMOZIONI","findAll","I5_2PROMOZIONIBean",StaticContext.FindExceptionType(e));
        }
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
    return recs;
  }
  
    public Vector findTipiAll() throws CustomException
    {
      CallableStatement cs = null;
      Vector recs = new Vector();
      I5_2PROMOZIONI_TIPI_ROW row = null;
      try
      {
        conn = getConnection(dsName);
        cs = conn.prepareCall(findAllTipi);
        cs.registerOutParameter(1,OracleTypes.CURSOR);
        cs.execute();
        ResultSet rs = (ResultSet) cs.getObject(1);
        while (rs.next()) 
        { 
          row =  new I5_2PROMOZIONI_TIPI_ROW();
          row.setDESCRIZIONE(rs.getString("DESCRIZIONE"));     
          row.setTIPO_PROMOZIONE(rs.getInt("TIPO_PROMOZIONE"));
          recs.add(row);
        } 
        rs.close();
      } 
      catch (Exception e) {
        System.out.println(e.getMessage());
        throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PROMOZIONI_TIPI","findTipiAll","I5_2PROMOZIONIBean",StaticContext.FindExceptionType(e));
      } finally {
        try {
                 cs.close();
        } catch (Exception e) {
                System.out.println(e.getMessage());
                throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PROMOZIONI_TIPI","findTipiAll","I5_2PROMOZIONIBean",StaticContext.FindExceptionType(e));
          }
        try {
                 conn.close();
        } catch (Exception e) {System.out.println(e.getMessage());}
      }
      return recs;
    }
    
    public Vector findStoredAll() throws CustomException
    {
      CallableStatement cs = null;
      Vector recs = new Vector();
      I5_2PROMOZIONI_ROW row = null;
      try
      {
        conn = getConnection(dsName);
        cs = conn.prepareCall(findStoredAll);
        cs.registerOutParameter(1,OracleTypes.CURSOR);
        cs.execute();
        ResultSet rs = (ResultSet) cs.getObject(1);
        while (rs.next()) 
        { 
          row =  new I5_2PROMOZIONI_ROW();
          row.setSTORED_PROCEDURE(rs.getString("STORED_PROCEDURE")); 
          row.setDESCR_ESTESA(rs.getString("DESCR_ESTESA")); 
          recs.add(row);
        } 
        rs.close();
      } 
      catch (Exception e) {
        System.out.println(e.getMessage());
        throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PROMOZIONI","findStoredAll","I5_2PROMOZIONIBean",StaticContext.FindExceptionType(e));
      } finally {
        try {
                 cs.close();
        } catch (Exception e) {
                System.out.println(e.getMessage());
                throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PROMOZIONI","findStoredAll","I5_2PROMOZIONIBean",StaticContext.FindExceptionType(e));
          }
        try {
                 conn.close();
        } catch (Exception e) {System.out.println(e.getMessage());}
      }
      return recs;
    }
    
    public Boolean insertPromizioni(I5_2PROMOZIONI_ROW row) throws CustomException {
        
        CallableStatement cs = null;
        Integer ret=1;
        try 
        {
          conn = getConnection(dsName);
          
          cs = conn.prepareCall(insertPromozioni);
          cs.registerOutParameter(1,Types.INTEGER) ;
          cs.setInt(2,row.getCODE_PROMOZIONE());
          cs.setString(3,row.getDESCRIZIONE());      
          cs.setInt(4,row.getTIPO_PROMOZIONE());            
          cs.setFloat(5,row.getVALORE());
          cs.setString(6,row.getSTORED_PROCEDURE());      
          cs.execute();
          ret = cs.getInt(1);       
        } 
        catch(Exception e)
        {
            System.out.println(e.getMessage());
            throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PROMOZIONI","insert","I5_2PROMOZIONIBean",StaticContext.FindExceptionType(e));
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
              throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PROMOZIONI","insert","I5_2PROMOZIONIBean",StaticContext.FindExceptionType(e));
          }
          try 
          {
                   conn.close();
          } catch (Exception e) {System.out.println(e.getMessage());}
        }
        if (ret != 0){
            return false;
        }
        
        return true;
    }

    public Boolean insertPromizioniOF(int codePromo, int classeOF, int servizio) throws CustomException {
        
        CallableStatement cs = null;
        Integer ret=1;
        try 
        {
          conn = getConnection(dsName);
          
          cs = conn.prepareCall(insertPromozioniOF);
          cs.registerOutParameter(1,Types.INTEGER) ;
          cs.setInt(2,codePromo);      
          cs.setInt(3,classeOF);            
          cs.setInt(4,servizio);
          cs.execute();
          ret = cs.getInt(1);       
        } 
        catch(Exception e)
        {
            System.out.println(e.getMessage());
            throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PROMOZIONI_X_OGG_FATRZ","insert","I5_2PROMOZIONIBean",StaticContext.FindExceptionType(e));
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
              throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PROMOZIONI_X_OGG_FATRZ","insert","I5_2PROMOZIONIBean",StaticContext.FindExceptionType(e));
          }
          try 
          {
                   conn.close();
          } catch (Exception e) {System.out.println(e.getMessage());}
        }
        if (ret != 0){
            return false;
        }
        
        return true;
    }
    
    public Boolean checkPromizioni(I5_2PROMOZIONI_ROW row) throws CustomException {
        
        CallableStatement cs = null;
        Integer ret=1;
        try 
        {
          conn = getConnection(dsName);
          
          cs = conn.prepareCall(checkPromozioni);
          cs.registerOutParameter(1,Types.INTEGER) ;
          cs.setInt(2,row.getTIPO_PROMOZIONE());            
          cs.setFloat(3,row.getVALORE());
          cs.setString(4,row.getSTORED_PROCEDURE());      
          cs.execute();
          ret = cs.getInt(1);       
        } 
        catch(Exception e)
        {
            System.out.println(e.getMessage());
            throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PROMOZIONI","insert","I5_2PROMOZIONIBean",StaticContext.FindExceptionType(e));
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
              throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PROMOZIONI","insert","I5_2PROMOZIONIBean",StaticContext.FindExceptionType(e));
          }
          try 
          {
                   conn.close();
          } catch (Exception e) {System.out.println(e.getMessage());}
        }
        if (ret != 0){
            return false;
        }
        
        return true;
    }

    public int eliminaPromo(String Promo) throws CustomException, RemoteException
    {
      int i = 0;
      int int_Return = 0;
      Vector lvct_SPReturn = null;
      try     
      {
            String lstr_StoredProcedure = PKG_NAME + ".EliminaPromo";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Promo}
                                };
            lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
            int_Return = lvct_Return.intValue();
          

        return int_Return;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "eliminaPromo",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    }
    
    public int modificaPromo(String Promo, String servizio, String oggFatt) throws CustomException, RemoteException
    {
      int i = 0;
      int int_Return = 0;
      Vector lvct_SPReturn = null;
      try     
      {
            String lstr_StoredProcedure = PKG_NAME + ".ModificaPromo";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Promo},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, servizio},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, oggFatt}
                                };
            lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
            int_Return = lvct_Return.intValue();
          

        return int_Return;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "modificaPromo",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    }    
    public Vector getServizi() throws CustomException
    {
      CallableStatement cs = null;
      Vector recs = new Vector();
      I5_1CONTR row = null;
      try
      {
        conn = getConnection(dsName);
        cs = conn.prepareCall(getServizi);
        cs.registerOutParameter(1,OracleTypes.CURSOR);
        cs.execute();
        ResultSet rs = (ResultSet) cs.getObject(1);
        while (rs.next()) 
        { 
          row =  new I5_1CONTR();
          row.setCODE_TIPO_CONTR(rs.getString("CODE_TIPO_CONTR"));     
          row.setDESC_CONTR(rs.getString("DESC_TIPO_CONTR"));
          recs.add(row);
        } 
        rs.close();
      } 
      catch (Exception e) {
        System.out.println(e.getMessage());
        throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_1TIPO_CONTR","getServizi","I5_2PROMOZIONIBean",StaticContext.FindExceptionType(e));
      } finally {
        try {
                 cs.close();
        } catch (Exception e) {
                System.out.println(e.getMessage());
                throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_1TIPO_CONTR","getServizi","I5_2PROMOZIONIBean",StaticContext.FindExceptionType(e));
          }
        try {
                 conn.close();
        } catch (Exception e) {System.out.println(e.getMessage());}
      }
      return recs;
    }

  
public Vector getServiziXPromo(String Promo) throws CustomException
    {
      CallableStatement cs = null;
      Vector recs = new Vector();
      I5_2PROMOZIONI_ROW row = null;
      try
      {
        conn = getConnection(dsName);
        cs = conn.prepareCall(getServiziXPromo);
        cs.registerOutParameter(1,OracleTypes.CURSOR);
        cs.setString(2,Promo);
        cs.execute();
        ResultSet rs = (ResultSet) cs.getObject(1);
        while (rs.next()) 
        { 
          row =  new I5_2PROMOZIONI_ROW();
          row.setCODE_SERVIZIO(rs.getString("CODE_SERVIZIO"));     
          recs.add(row);
        } 
        rs.close();
      } 
      catch (Exception e) {
        System.out.println(e.getMessage());
        throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PROMOZIONI_X_OGG_FATRZ","getServiziXPromo","I5_2PROMOZIONIBean",StaticContext.FindExceptionType(e));
      } finally {
        try {
                 cs.close();
        } catch (Exception e) {
                System.out.println(e.getMessage());
                throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PROMOZIONI_X_OGG_FATRZ","getServiziXPromo","I5_2PROMOZIONIBean",StaticContext.FindExceptionType(e));
          }
        try {
                 conn.close();
        } catch (Exception e) {System.out.println(e.getMessage());}
      }
      return recs;
    }
}
  