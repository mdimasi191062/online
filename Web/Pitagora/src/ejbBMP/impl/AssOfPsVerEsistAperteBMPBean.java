package com.ejbBMP.impl;
import javax.ejb.EntityBean;
import javax.ejb.EntityContext;
import com.ejbBMP.AssOfPsVerEsistAperteBMPPK;
import java.util.*;
import java.rmi.*;
import java.sql.*;
import javax.ejb.*;
import javax.naming.*;
import oracle.jdbc.*;
import oracle.sql.*;
import com.utl.*;

public class AssOfPsVerEsistAperteBMPBean extends AbstractEntityCommonBean implements EntityBean 
{
  public EntityContext entityContext;
  private AssOfPsVerEsistAperteBMPPK pk;
  private boolean enableStore=false;


  public AssOfPsVerEsistAperteBMPPK ejbCreate()
  {
    return null;
  }

  public void ejbPostCreate()
  {
  }

  public AssOfPsVerEsistAperteBMPPK ejbFindByPrimaryKey(AssOfPsVerEsistAperteBMPPK primaryKey)
  {
    return primaryKey;
  }

  public AssOfPsVerEsistAperteBMPPK ejbFindNumAss(String cod_contratto, String cod_of, String cod_ps) throws RemoteException, FinderException
  {
//System.out.println("sono in ejbFindNumAss");
    AssOfPsVerEsistAperteBMPPK pk = new AssOfPsVerEsistAperteBMPPK();

    Connection conn=null;  

    try
    {
      conn = getConnection(dsName);

//      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_NICOLA.ASSOC_OFPS_VER_ESIST_APERTE(?,?,?,?,?,?)}");
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_VER_ESIST_APERTE(?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,cod_contratto);
      cs.setString(2,cod_of);
      cs.setString(3,cod_ps);

      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(5)!=DBMessage.OK_RT))//&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6)+"NOME STORED: ASSOC_OFPS_VER_ESIST_APERTE");


      pk.setNumAss(cs.getInt(4));      
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
             StaticMessages.setCustomString(e.toString());
             StaticContext.writeLog(StaticMessages.getMessage(5002,"AssOfPsVerEsistAperteBMPBean","","",StaticContext.APP_SERVER_DRIVER));
             e.printStackTrace();
             throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"AssOfPsVerEsistAperteBMPBean","","",StaticContext.APP_SERVER_DRIVER));
       ee.printStackTrace();
       throw new RemoteException(ee.getMessage());

		}
    finally
		{
			try
			{
				conn.close();
			} catch(Exception e)
			{
              throw new RemoteException(e.getMessage());
			}
		}

//   //System.out.println("Esco da ejbFindNumAss");
    return pk;
  }

  public String getCodeTipoContratto()
  {
      pk = (AssOfPsVerEsistAperteBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodeTipoContratto();
  }

  public void setCodeTipoContratto(String codeTipoContratto)
  {
		pk = (AssOfPsVerEsistAperteBMPPK) ctx.getPrimaryKey();
		pk.setCodeTipoContratto (codeTipoContratto);
    enableStore=true;
  }


  public String getCodeCOf()
  {
      pk = (AssOfPsVerEsistAperteBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodeCOf();
  }

  public void setCodeCOf(String codeCOf)
  {
		pk = (AssOfPsVerEsistAperteBMPPK) ctx.getPrimaryKey();
		pk.setCodeCOf (codeCOf);
    enableStore=true;
  }

  public String getCodePS()
  {
      pk = (AssOfPsVerEsistAperteBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodePS();
  }

  public void setCodePS(String codePS)
  {
		pk = (AssOfPsVerEsistAperteBMPPK) ctx.getPrimaryKey();
		pk.setCodePS(codePS);
    enableStore=true;
  }

  public int getNumAss()
  {
      pk = (AssOfPsVerEsistAperteBMPPK) ctx.getPrimaryKey();
      if (pk==null)
       return 0; 
      else
        return pk.getNumAss();
  }

  public void setNumAss(int NumAss)
  {
		pk = (AssOfPsVerEsistAperteBMPPK) ctx.getPrimaryKey();
		pk.setNumAss(NumAss);
    enableStore=true;
  }



}