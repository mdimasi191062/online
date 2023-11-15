package com.ejbBMP.impl;

import java.util.*;
import java.rmi.*;
import java.sql.*;

import javax.ejb.*;
import javax.naming.*;

import oracle.jdbc.*;
import oracle.sql.*;

import com.ejbBMP.ScartiBMPPK;
import com.utl.*;


public class ScartiBMPBean extends AbstractEntityCommonBean implements EntityBean 
{
  public EntityContext entityContext;
  private ScartiBMPPK pk;

  private boolean enableStore=false;
  

  public ScartiBMPPK ejbCreate()
  throws CreateException, RemoteException 
  {
   //System.out.println("ejbCreate>>");
    pk= new ScartiBMPPK();
    return pk;
  }


  public void ejbPostCreate()
  {
    
  }

 public ScartiBMPPK ejbFindByPrimaryKey(ScartiBMPPK primaryKey)
  {
    return primaryKey;
  }
public Collection ejbFindScartiLst(String Account,String CodeFunz, String CodeContratto) throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{
      
			conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".SCARTI_LST (?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,Account);
      cs.setString(2,CodeFunz);
      cs.setString(3,CodeContratto);
      cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_SCARTI");
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      
      cs.execute();


      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_SCARTI",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(4);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new ScartiBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
      
              pk.setTipo(attr[0].stringValue());
              pk.setMotivo(attr[1].stringValue());
              pk.setOggetto(attr[2].stringValue());
              pk.setCodice(attr[3].stringValue());
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
    public String getTipo()
  {
      pk = (ScartiBMPPK) ctx.getPrimaryKey();
      return pk.getTipo();

  }

  public void setTipo(String tipo)
  {
		pk = (ScartiBMPPK) ctx.getPrimaryKey();
		pk.setTipo(tipo);

  }
    public String getMotivo()
  {
      pk = (ScartiBMPPK) ctx.getPrimaryKey();
      return pk.getMotivo();

  }

  public void setMotivo(String motivo)
  {
		pk = (ScartiBMPPK) ctx.getPrimaryKey();
		pk.setMotivo(motivo);

  }
    public String getOggetto()
  {
      pk = (ScartiBMPPK) ctx.getPrimaryKey();
      return pk.getOggetto();

  }

  public void setOggetto(String oggetto)
  {
		pk = (ScartiBMPPK) ctx.getPrimaryKey();
		pk.setOggetto(oggetto);

  }  public String getCodice()
  {
      pk = (ScartiBMPPK) ctx.getPrimaryKey();
      return pk.getCodice();

  }

  public void setCodice(String codeScarto)
  {
		pk = (ScartiBMPPK) ctx.getPrimaryKey();
		pk.setCodice(codeScarto);

  }
  }