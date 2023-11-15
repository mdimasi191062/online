package com.ejbBMP.impl;
import javax.ejb.EntityBean;
import javax.ejb.EntityContext;
import com.ejbBMP.AssOfPsVerifEsistBMPPK;
import java.util.*;
import java.rmi.*;
import java.sql.*;
import javax.ejb.*;
import javax.naming.*;
import oracle.jdbc.*;
import oracle.sql.*;
import com.utl.*;


public class AssOfPsVerifEsistBMPBean extends AbstractEntityCommonBean implements EntityBean 
{
  public EntityContext entityContext;
  private AssOfPsVerifEsistBMPPK pk;
  private boolean enableStore=false;

  public AssOfPsVerifEsistBMPPK ejbCreate()
  {
    return null;
  }

  public void ejbPostCreate()
  {
  }

  public AssOfPsVerifEsistBMPPK ejbFindByPrimaryKey(AssOfPsVerifEsistBMPPK primaryKey)
  {
    return primaryKey;
  }


  public AssOfPsVerifEsistBMPPK ejbFindNumOfPs(String cod_contratto, String cod_of, String cod_ps) throws RemoteException, FinderException
  {
   //System.out.println("sono in ejbFindNumOfPs di AssOfPsVerifEsistBMPBean");
   //System.out.println("cod_contratto="+cod_contratto);
   //System.out.println("cod_of="+cod_of);
   //System.out.println("cod_ps="+cod_ps);
    AssOfPsVerifEsistBMPPK pk = new AssOfPsVerifEsistBMPPK();

    Connection conn=null;  

    try
    {
      conn = getConnection(dsName);

//      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_NICOLA.ASSOC_OFPS_VERIF_ESIST(?,?,?,?,?,?)}");
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_VERIF_ESIST(?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,cod_contratto);
      cs.setString(2,cod_of);
      cs.setString(3,cod_ps);

      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(5)!=DBMessage.OK_RT))//&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6)+"NOME STORED: ASSOC_OFPS_VERIF_ESIST");


      pk.setNumOfPs(cs.getInt(4));      
   //System.out.println("NUM="+cs.getInt(4));
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
             StaticMessages.setCustomString(e.toString());
             StaticContext.writeLog(StaticMessages.getMessage(5002,"AssOfPsVerEsisteBMPBean","","",StaticContext.APP_SERVER_DRIVER));
             e.printStackTrace();
             throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"AssOfPsVerEsisteBMPBean","","",StaticContext.APP_SERVER_DRIVER));
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

//   //System.out.println("Esco da AssOfPsVerifEsistBMPPK");
    return pk;
  }

  public String getCodeTipoContratto()
  {
      pk = (AssOfPsVerifEsistBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodeTipoContratto();
  }

  public void setCodeTipoContratto(String codeTipoContratto)
  {
		pk = (AssOfPsVerifEsistBMPPK) ctx.getPrimaryKey();
		pk.setCodeTipoContratto (codeTipoContratto);
    enableStore=true;
  }


  public String getCodeCOf()
  {
      pk = (AssOfPsVerifEsistBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodeCOf();
  }

  public void setCodeCOf(String codeCOf)
  {
		pk = (AssOfPsVerifEsistBMPPK) ctx.getPrimaryKey();
		pk.setCodeCOf (codeCOf);
    enableStore=true;
  }

  public String getCodePS()
  {
      pk = (AssOfPsVerifEsistBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodePS();
  }

  public void setCodePS(String codePS)
  {
		pk = (AssOfPsVerifEsistBMPPK) ctx.getPrimaryKey();
		pk.setCodePS(codePS);
    enableStore=true;
  }

  public int getNumOfPs()
  {
      pk = (AssOfPsVerifEsistBMPPK) ctx.getPrimaryKey();
      if (pk==null) return 0; 
      else
        return pk.getNumOfPs();
  }

  public void setNumOfPs(int NumOfPs)
  {
		pk = (AssOfPsVerifEsistBMPPK) ctx.getPrimaryKey();
		pk.setNumOfPs(NumOfPs);
    enableStore=true;
  }

}