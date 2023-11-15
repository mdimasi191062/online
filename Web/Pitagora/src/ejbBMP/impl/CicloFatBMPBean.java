package com.ejbBMP.impl;
//import javax.ejb.EntityBean;
//import javax.ejb.EntityContext;

import java.util.*;
import java.rmi.*;
import java.sql.*;
import javax.ejb.*;
import javax.naming.*;
import oracle.jdbc.*;
import oracle.sql.*;
import com.ejbBMP.CicloFatBMPPK;
import com.utl.*;

public class CicloFatBMPBean extends AbstractEntityCommonBean implements EntityBean
{
  public EntityContext entityContext;
  private CicloFatBMPPK pk;
  private boolean enableStore=false;

  public CicloFatBMPPK ejbCreate() throws CreateException, RemoteException
  {   return null; 
  }

  public void ejbPostCreate(){}

  public CicloFatBMPPK ejbFindByPrimaryKey(CicloFatBMPPK primaryKey) throws RemoteException, FinderException
  {
      return primaryKey;
  }

  
//METODO PER IL CARICAMENTO DELLA COMBO SU  Valorizzazione Attiva
  public Collection ejbFindCicloFat() throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 		try
		{
      //System.out.println("Sono in ejbFindCicloFat");
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CICLO_FAT_LISTA (?,?,?)}");
      // Impostazione types I/O
      cs.registerOutParameter(1,OracleTypes.ARRAY, "ARR_CICLI_FAT");
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.execute();
//      if ((cs.getInt(2)!=DBMessage.OK_RT)&&(cs.getInt(2)!=DBMessage.NOT_FOUND_RT))
//        throw new Exception("DB:"+cs.getInt(2)+":"+cs.getString(3));

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CICLI_FAT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(1);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new CicloFatBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              pk.setCodeCf(attr[0].stringValue());
              pk.setDescCf(attr[1].stringValue());
              //31/07/02 inizio
              //pk.setCodeClasseOf(attr[4].stringValue());
              //31/07/02 fine
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
// Fine METODO PER IL CARICAMENTO DELLA COMBO SU LISTA_TARIFFE



  public void ejbStore() throws RemoteException
  {
  }

  public String getCodeCicloFat()
  {
      pk = (CicloFatBMPPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
        return pk.getCodeCf();
  }

  public void setCodeCicloFat(String codeCicloFat)
  {
		pk = (CicloFatBMPPK) ctx.getPrimaryKey();
		pk.setCodeCf (codeCicloFat);
    enableStore=true;
  }

 public String getDescCicloFat()
  {
      pk = (CicloFatBMPPK) ctx.getPrimaryKey();
      return pk.getDescCf();
  }

  public void setDescCicloFat(String descCicloFat)
  {
		pk = (CicloFatBMPPK) ctx.getPrimaryKey();
		pk.setDescCf (descCicloFat);
    enableStore=true;
  }


}