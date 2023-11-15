package com.ejbBMP.impl;

import java.util.*;
import java.rmi.*;
import java.sql.*;

import javax.ejb.*;
import javax.naming.*;

import oracle.jdbc.*;
import oracle.sql.*;

import com.ejbBMP.AbortLstBMPPK;
import com.utl.*;


public class AbortLstBMPBean extends AbstractEntityCommonBean implements EntityBean 
{
  public EntityContext entityContext;
  private AbortLstBMPPK pk;

  private boolean enableStore=false;
  

  public AbortLstBMPPK ejbCreate()
  throws CreateException, RemoteException 
  {
    //System.out.println("ejbCreate>>");
    pk= new AbortLstBMPPK();
    return pk;
  }


  public void ejbPostCreate()
  {
    
  }

 public AbortLstBMPPK ejbFindByPrimaryKey(AbortLstBMPPK primaryKey)
  {
    return primaryKey;
  }
  public Collection ejbFindAll(String CodContratto) throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{
      
			conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_LST_ABORT (?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodContratto);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_ACCOUNT");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      
      cs.execute();


      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new AbortLstBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
      
              pk.setAccount(attr[1].stringValue());
              recs.add(pk);
          }      

      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} finally
		{
			try
			{
				conn.close();
			} catch(Exception e)
			{
        throw new RemoteException(e.getMessage());
			}
		}


    return recs;
  }
    public String getAccount()
  {
      pk = (AbortLstBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getAccount();
  }

  public void setAccount(String code)
  {
    
		pk = (AbortLstBMPPK) ctx.getPrimaryKey();
		pk.setAccount (code);
   
  }
}