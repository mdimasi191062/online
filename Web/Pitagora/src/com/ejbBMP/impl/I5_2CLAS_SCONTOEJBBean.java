package com.ejbBMP.impl;
import javax.sql.*;
import javax.naming.*;
import javax.ejb.EntityBean;
import javax.ejb.EntityContext;
import com.utl.*;
import java.sql.Date;
import javax.ejb.*;
import java.sql.*;
import java.util.*;
import java.rmi.*;
import com.ejbBMP.*;
import oracle.jdbc.OracleTypes;
import java.math.BigDecimal;

public class I5_2CLAS_SCONTOEJBBean extends AbstractEntityCommonBean implements EntityBean 
{
  private I5_2CLAS_SCONTOPK primaryKey;
  private String Desc_Cls_Sconto = null;
  private BigDecimal Min_Spesa = null;
  private BigDecimal Max_Spesa = null; 
  private java.util.Date  In_Valid ;
  private java.util.Date  Fi_Valid ;

  public EntityContext entityContext;

  private  String DisattivaClsSconto = "{? = call " + StaticContext.PACKAGE_CLASSIC +".I5_2CLAS_SCONTOEJBStore(?,?) }";
  private  String InsertStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC +".I5_2CLAS_SCONTOEJBCreate(?,?,?,?,?,?) }";
  private  String CaricaClsSconto = "{? = call " + StaticContext.PACKAGE_CLASSIC +".I5_2CLAS_SCONTOEJBLoad(?,?) }";
  private  String LeggiClsSconto = "{? = call " + StaticContext.PACKAGE_CLASSIC +".I5_2CLAS_SCONTOEJBFindall(?,?) }";
  private  String findAllByCodeClsSconto ="{? = call " + StaticContext.PACKAGE_CLASSIC +".I5_2CLAS_SCONTOEJBfindallCODE(?) }"; 
  private  String DeleteStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC +".I5_2CLAS_SCONTOEJBRemove(?,?) }";
  private  String ControlloTariffe ="{? = call " + StaticContext.PACKAGE_CLASSIC +".I5_2CLAS_SCONTOEJBAssTariffe(?) }";


  public com.ejbBMP.I5_2CLAS_SCONTOPK ejbFindByPrimaryKey(com.ejbBMP.I5_2CLAS_SCONTOPK primaryKey)
   {
    return primaryKey;
   }

  public Collection ejbFindAll() throws FinderException, RemoteException,CustomException
  {
    CallableStatement cs = null;
    Vector Vectorpk = new Vector();
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiClsSconto);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
   
      long i = 0;
     
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      {   
        i++;
        primaryKey.setId_Cls_Sconto(rs.getString("CODE_CLAS_SCONTO"));
        primaryKey.setCode_Pr_Cls_Sconto(rs.getString("CODE_PR_CLAS_SCONTO"));
        Vectorpk.add(new String(rs.getString(1)));
      }
      rs.close();
    } 
    catch (SQLException e) {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2CLAS_SCONTO","ejbCreate","I5_2CLAS_SCONTO",StaticContext.FindExceptionType(e));                            
    } finally {
      try {
	       cs.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
    return Vectorpk;
  }

  public Collection ejbFindAll(String filtro, String strCodRicerca) throws FinderException, RemoteException,CustomException
  {
    CallableStatement cs = null;
    Vector Vectorpk = new Vector();
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiClsSconto);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
   
    
      if (filtro==null)
      {
        cs.setNull(2,Types.VARCHAR);
      }
      else 
      {
        cs.setString(2,filtro);
      }

        if (strCodRicerca==null)
      {
        cs.setNull(3,Types.VARCHAR);
      }
      else 
      {
        cs.setString(3,strCodRicerca);
      }

     
      
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      {   
   
        String a = rs.getString("CODE_CLAS_SCONTO");
        String b = rs.getString("CODE_PR_CLAS_SCONTO");
        primaryKey = new I5_2CLAS_SCONTOPK(a,b);
        Vectorpk.add(primaryKey);
      } 
      rs.close();
    } 
    catch (SQLException e) {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2CLAS_SCONTO","ejbCreate","I5_2CLAS_SCONTO",StaticContext.FindExceptionType(e));                            
    } finally {
      try {
	       cs.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
    return Vectorpk;
  }

//*****************
 public Collection ejbFindAllByCodeClsSconto(String FiltroCODE_CLS_SCONTO) throws FinderException, RemoteException,CustomException
  {
  
    CallableStatement cs = null;
    Vector recs = new Vector();
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAllByCodeClsSconto);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,FiltroCODE_CLS_SCONTO);
      cs.execute();  
      ResultSet rs = (ResultSet)cs.getObject(1);      
    
      while (rs.next()) 
      {        
        String a = rs.getString("CODE_CLAS_SCONTO");
        String b = rs.getString("CODE_PR_CLAS_SCONTO");
        primaryKey = new I5_2CLAS_SCONTOPK(a,b);
       	recs.add(primaryKey);
      } 
      rs.close();
    }
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2CLAS_SCONTO","ejbFindAllByCodeClsSconto","I5_2CLAS_SCONTO",StaticContext.FindExceptionType(e));                            
    } 
    finally 
    {
      try 
      {
	       cs.close();
      } 
      catch (Exception e){ System.out.println(e.getMessage());
      }
      try 
      {
	       conn.close();
      } 
      catch (Exception e){ System.out.println(e.getMessage());
      }
    }
    return recs;
  }

//************** GESTIONE DISATTIVACLSSCONTO

  // java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
  // String txtDataFine = df.format(Fi_Valid);
  
   
   
 public void ejbStore() throws RemoteException
  {
    CallableStatement cs = null;
    I5_2CLAS_SCONTOPK newIdClsSconto;
    if (Fi_Valid==null)
    {
        return;
    }
    java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
    String txtDataFine = df.format(Fi_Valid);
      
    try 
    {
      newIdClsSconto = (com.ejbBMP.I5_2CLAS_SCONTOPK) entityContext.getPrimaryKey();
      conn = getConnection(dsName);
      cs = conn.prepareCall(DisattivaClsSconto);
      cs.registerOutParameter(1,OracleTypes.NUMBER);
      cs.setString(2,newIdClsSconto.getId_Cls_Sconto());
      cs.setString(3,txtDataFine);
      cs.execute();
    } 
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
      throw new EJBException(e);
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
      }
      try 
      {
	       conn.close();
      } 
      catch (Exception e)
      {
        System.out.println(e.getMessage());
      }
    }
  }

 // GESTIONE DIDATTIVACLSSCONTO***********************************/

//******************** 

public com.ejbBMP.I5_2CLAS_SCONTOPK ejbCreate()
  {
    return null;
  }

  public void ejbPostCreate()
  {
  }

 
 public I5_2CLAS_SCONTOPK ejbCreate(I5_2CLAS_SCONTOPK newPrimaryKey, String newDataInizio, String txtDescrizioneIntervallo, java.math.BigDecimal txtValoreMinimo,  java.math.BigDecimal txtValoreMassimo) throws RemoteException, CreateException
// public I5_2CLAS_SCONTOPK ejbCreate(I5_2CLAS_SCONTOPK newPrimaryKey, String newDataInizio, String txtDescrizioneIntervallo, String txtValoreMinimo,  String txtValoreMassimo) throws RemoteException, CreateException
  {
   CallableStatement cs = null;
    try 
    {        
			conn = getConnection(dsName);
      cs = conn.prepareCall(InsertStatement);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2,newPrimaryKey.getId_Cls_Sconto());
      cs.setString(3,newPrimaryKey.getCode_Pr_Cls_Sconto());
      cs.setString(4,newDataInizio);
      cs.setString(5,txtDescrizioneIntervallo);
      cs.setBigDecimal(6,txtValoreMinimo);
      if(txtValoreMassimo!=null)
      {
        cs.setBigDecimal(7,txtValoreMassimo);
      }
      else
      {
        cs.setNull(7,Types.DECIMAL);
      }
       cs.execute();
       conn.close();
    }
    catch(Throwable ex)
    {
      ex.printStackTrace();
      throw new CreateException(ex.getMessage());
    }  finally 
    {
      try 
      {
	       cs.close();
      } 
      catch (Exception e)
      {
        System.out.println(e.getMessage());
      }
      try 
      {
	       conn.close();
      } 
      catch (Exception e)
      {
        System.out.println(e.getMessage());
      }
    }
    return newPrimaryKey;
  }

  public void ejbPostCreate(I5_2CLAS_SCONTOPK newPrimaryKey, String newDataInizio, String txtDescrizioneIntervallo, java.math.BigDecimal txtValoreMinimo,  java.math.BigDecimal txtValoreMassimo)
  {
  }
 //**********************************


  public void ejbPassivate()
  {
  }


 //****************************

  public void ejbRemove() throws RemoteException,RemoveException
  {
      CallableStatement cs = null;
    try 
    {
      primaryKey = (com.ejbBMP.I5_2CLAS_SCONTOPK) entityContext.getPrimaryKey();
      conn = getConnection(dsName);
      cs = conn.prepareCall(DeleteStatement);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2, primaryKey.getId_Cls_Sconto());
      cs.setString(3, primaryKey.getCode_Pr_Cls_Sconto());
      cs.execute();
      conn.close();
    } 
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
      throw new RemoveException(e.getMessage());
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
      }
      try 
      {
	       conn.close();
      } 
      catch (Exception e)
      {
        System.out.println(e.getMessage());
      }
    }


  }

//********************************************
 public int AssociazioneTariffe()  throws RemoteException,CustomException
 {

   int iRisposta=0;
   CallableStatement cs = null;  
   try 
    {
    
      primaryKey = (com.ejbBMP.I5_2CLAS_SCONTOPK) entityContext.getPrimaryKey();
      conn = getConnection(dsName);
      cs = conn.prepareCall(ControlloTariffe);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2, primaryKey.getId_Cls_Sconto());
      cs.execute();  
      iRisposta = cs.getInt(1);      
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2CLAS_SCONTO","AssociazioneTariffe","I5_2CLAS_SCONTO",StaticContext.FindExceptionType(e));                            
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
      }
      try 
      {
	       conn.close();
      } 
      catch (Exception e)
      {
        System.out.println(e.getMessage());
      }
    }
    return iRisposta;
  
  }

//**************************************************

  public void ejbActivate()
  {
  }

  public void ejbLoad() throws RemoteException
  {
    CallableStatement cs = null;

    try 
    {
      primaryKey = (com.ejbBMP.I5_2CLAS_SCONTOPK) entityContext.getPrimaryKey();
      conn = getConnection(dsName);
      cs = conn.prepareCall(CaricaClsSconto);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.setString(2, primaryKey.getId_Cls_Sconto());
      cs.setString(3, primaryKey.getCode_Pr_Cls_Sconto());
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      boolean found = rs.next();
      if (found) 
      {
        Desc_Cls_Sconto = rs.getString("DESC_CLAS_SCONTO");
        if(rs.getObject(3)!=null)
        {
          Min_Spesa = (BigDecimal) rs.getObject(3);
        }
        if(rs.getObject(4)!=null)
        {
          Max_Spesa = (BigDecimal) rs.getObject(4);
        }
        else
        {
          Max_Spesa = null;
        }
        In_Valid = rs.getDate("DATA_INIZIO_VALID");
        Fi_Valid = rs.getDate("DATA_FINE_VALID");
      }

      cs.close();
      rs.close();
    } 
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
      throw new EJBException(e.getMessage());
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
      }
      try 
      {
	       conn.close();
      } 
      catch (Exception e)
      {
        System.out.println(e.getMessage());
      }
    }
  }

  public void setEntityContext(EntityContext ctx)
  {
    this.entityContext = ctx;
  }


  public void unsetEntityContext()
  {
    this.entityContext = null;
  }


  public void setDesc_Cls_Sconto(String desc_clas_sconto)
  {
    Desc_Cls_Sconto =  desc_clas_sconto;
  }

  public void setMin_Spesa(BigDecimal impt_min_spesa)
  {
    Min_Spesa = impt_min_spesa;
  }

  public void setMax_Spesa(BigDecimal impt_max_spesa)
  {
    Max_Spesa = impt_max_spesa;
  }

  public void setIn_Valid(java.util.Date data_inizio_valid)
  {
    In_Valid = data_inizio_valid;
  }

  public void setFi_Valid(java.util.Date data_fine_valid)
  {
    Fi_Valid = data_fine_valid;
  }

  public String getDesc_Cls_Sconto()
  {
    return  Desc_Cls_Sconto; 
  }

  public BigDecimal getMin_Spesa()
  {
    return Min_Spesa;
  }

  public BigDecimal getMax_Spesa()
  {
    return Max_Spesa;
  }

  public  java.util.Date getIn_Valid()
  {
    return In_Valid;
  }

  public java.util.Date getFi_Valid()
  {
    return Fi_Valid;
  }

}