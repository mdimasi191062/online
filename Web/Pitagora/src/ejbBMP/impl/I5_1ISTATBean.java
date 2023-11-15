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
import javax.ejb.RemoveException;
import java.rmi.*;
import com.ejbBMP.*;
import oracle.jdbc.OracleTypes;


public class I5_1ISTATBean extends AbstractSequenceBean implements EntityBean 
{
  private String Anno = null;
  private Float  Indice = null;
 

  public  EntityContext entityContext;
  //private String CreaSconto = "{? = call PKG_BILL_CLA.I5_2SCONTOEJBCreate(?,?,?) }";
  //private String AggiornaSconto = "{? = call PKG_BILL_CLA.I5_2SCONTOEJBStore(?,?,?,?) }";
  //private String CancellaSconto = "{? = call PKG_BILL_CLA.I5_2SCONTOEJBRemove(?) }";
  private String CaricaIndice = "{? = call ROSA.I5_1ISTATLoad(?) }";
  private String LeggiIndice = "{? = call ROSA.I5_1ISTATFindall() }";
  
 /* public String ejbCreate(String desc_sconto, Float perc_sconto, Float decremento)
  throws CreateException
  {
    CallableStatement cs = null;
    String primarykey = null;
    if (desc_sconto == null) 
      {
        throw new CreateException("passare i parametri valorizzati");
      }
    
  try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(CreaSconto);
      cs.registerOutParameter(1,OracleTypes.VARCHAR) ;
      cs.setString(2,desc_sconto);
      if (perc_sconto==null)
      {
        cs.setNull(3,Types.FLOAT);
      }
      else
      {
        cs.setFloat(3,perc_sconto.floatValue());
      }
      if (decremento==null)
      {
        cs.setNull(4,Types.FLOAT);
      }
      else
      {
        cs.setFloat(4,decremento.floatValue());;
      }
      cs.execute();
      primarykey = cs.getString(1);
      conn.close();
      if (primarykey==null)
      {
        throw new EJBException("Errore in fase di inserimento: ");
      }
    }
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
      throw new EJBException("Errore oracle: " + e.getMessage());
    }
    catch(Throwable ex)
    {
      System.out.println(ex.getMessage());
      ex.printStackTrace();
    }

      return primarykey;
  }
*/
 /* public void ejbPostCreate(String desc_sconto, Float perc_sconto, Float decremento)
  {
  }*/

  public Collection ejbFindAll() throws FinderException, RemoteException
  {
    CallableStatement cs = null;
    Vector Vectorpk = new Vector();
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiIndice);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      long i = 0;
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      {   
        i++;
        Vectorpk.add(new String(rs.getString(1)));
      } 
      if(i==0)
      { 
          throw new FinderException("Non è stato trovato alcun record");
      }
    } 
    catch (Exception e) {
      throw new FinderException(e.getMessage());
    } finally {
      try {
	       cs.close();
      } catch (Exception e) {}
      try {
	       conn.close();
      } catch (Exception e) {}
    }
    return Vectorpk;
  }

 public String ejbFindByPrimaryKey(String primaryKey) throws FinderException
  {
    CallableStatement cs = null;

    if (primaryKey == null)
    {
      throw new FinderException("La chiave primaria deve essere valorizzata");
    }

    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(CaricaIndice);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.setString(2,primaryKey);
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      boolean found = rs.next();
      if (!found) 
      {
        cs.close();
        conn.close();
        System.out.println("Occorrenza non trovata");
        throw new ObjectNotFoundException("Occorrenza non trovata");
      }
      cs.close();
      conn.close();
    } 

    catch (SQLException e) 
    {
      System.out.println(e.getMessage());    
    } 
    catch(Throwable ex)
    {
      ex.printStackTrace();
    }
    return primaryKey;
  }

  public void ejbActivate()
  {
  }

  public void ejbLoad()
  {
    CallableStatement cs = null;

    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(CaricaIndice);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      String primaryKey = (String) entityContext.getPrimaryKey();
      cs.setString(2,primaryKey);
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      boolean found = rs.next();
      if (found) 
      {
        Anno = primaryKey;
       
        Indice = new Float(rs.getFloat("INDICE_ISTAT"));
      }
      cs.close();
      rs.close();
      conn.close();
    } 
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
      System.out.println("load");
    } 
    catch(Throwable ex)
    {
      System.out.println(ex.getMessage());
      ex.printStackTrace();
    }
  }

  public void ejbPassivate()
  {
  }

  public void setEntityContext(EntityContext ctx)
  {
    this.entityContext = ctx;
  }

  public void unsetEntityContext()
  {
    this.entityContext = null;
  }

  public void setAnno(String anno)
  {
     Anno = anno;
  }

  public void setIndice(Float indice)
  {
    Indice = indice;
  }

  
  

  public String getAnno()
  {
    return Anno;
  }
  
 

  public Float getIndice()
  {
    return Indice;
  }

 
}