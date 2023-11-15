package com.ejbBMP.impl;
import javax.ejb.EntityBean;
import javax.ejb.EntityContext;
import com.ejbBMP.GestAssOfPsBMPPK;
import java.util.*;
import java.rmi.*;
import java.sql.*;
import javax.ejb.*;
import oracle.jdbc.*;
import oracle.sql.*;
import com.utl.*;
import javax.naming.*;

public class GestAssOfPsBMPBean extends AbstractEntityCommonBean implements EntityBean 
{
  public EntityContext entityContext;
  private GestAssOfPsBMPPK pk;
  private boolean enableStore=false;

  public GestAssOfPsBMPPK ejbCreate()
  {
    return null;
  }

  public void ejbPostCreate()
  {
  }


  public GestAssOfPsBMPPK ejbFindByPrimaryKey(GestAssOfPsBMPPK primaryKey)
        throws  FinderException,RemoteException, CustomEJBException
  {
  //System.out.println("ejbFindByPrimaryKey");
    Connection conn=null;  

    pk = primaryKey;
    
  try
    {
      conn = getConnection(dsName);

      OracleCallableStatement cs;
      //TARIFFA_VER_ESIST_2
      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".TARIFFA_VER_ESIST_2(?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,pk.getCodePs());
      cs.setString(2,pk.getCodeOf());
      cs.setString(3,pk.getDataIniOfPs());
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(5)!=DBMessage.OK_RT))//&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6)+"NOME STORED: TARIFFA_VER_ESIST_2");

      pk.setNumTariffe(cs.getInt(4));      
//     //System.out.println("Numero tariffe="+cs.getInt(4));


      //PS_DETTAGLIO
      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PS_DETTAGLIO(?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,pk.getCodePs());
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT))//&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: PS_DETTAGLIO");

      if(cs.getString(2)==null)
            pk.setDescPs("");      
      else
            pk.setDescPs(cs.getString(2));      
//     //System.out.println("descPs="+pk.getDescPs());




      //CLAS_OGG_FAT_DETTAGLIO
      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CLAS_OGG_FAT_DETTAGLIO(?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,pk.getCodeCOf());
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT))//&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: CLAS_OGG_FAT_DETTAGLIO");

      if(cs.getString(2)==null)
            pk.setDescCOf("");      
      else
            pk.setDescCOf(cs.getString(2));      
//     //System.out.println("descCOf="+pk.getDescCOf());




      //OGGETTO_FATT_LEGGI_DETTAGLIO
      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_LEGGI_DETTAGLIO(?,?,?,?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,pk.getCodeOf());
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.registerOutParameter(8,Types.INTEGER);
      cs.registerOutParameter(9,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(8)!=DBMessage.OK_RT))//&&(cs.getInt(8)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(8)+":"+cs.getString(9)+"NOME STORED: OGGETTO_FATT_LEGGI_DETTAGLIO");

      if(cs.getString(2)==null)
            pk.setDescOf("");      
      else
            pk.setDescOf(cs.getString(2));      

      if(cs.getString(6)==null)
            pk.setDataFineOf("");      
      else
            pk.setDataFineOf(cs.getString(6));      


      //MOD_APPL_RATEI_DETTAGLIO
      if((pk.getCodModalAppl()!=null) && (!pk.getCodModalAppl().equals("")))
      {
        cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".MOD_APPL_RATEI_DETTAGLIO(?,?,?,?)}");
        // Impostazione types I/O
        cs.setString(1,pk.getCodModalAppl());
        cs.registerOutParameter(2,Types.VARCHAR);
        cs.registerOutParameter(3,Types.INTEGER);
        cs.registerOutParameter(4,Types.VARCHAR);
        cs.execute();

        if ((cs.getInt(3)!=DBMessage.OK_RT))//&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
              throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: MOD_APPL_RATEI_DETTAGLIO");

        pk.setDescModalAppl(cs.getString(2));      
//       //System.out.println("codModalAppl="+pk.getDescModalAppl());
      }

      //FREQUENZA_DETTAGLIO
      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".FREQUENZA_DETTAGLIO(?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,pk.getCodFreq());
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT))//&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: FREQUENZA_DETTAGLIO");

      if(cs.getString(2)==null)
            pk.setDescFreq("");      
      else
            pk.setDescFreq(cs.getString(2));      
//System.out.println("descFreq="+pk.getDescFreq());




      //ASSOC_OFPS_VERIF_ESIST
      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_VERIF_ESIST(?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,pk.getCodContratto());
      cs.setString(2,pk.getCodeOf());
      cs.setString(3,pk.getCodePs());
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(5)!=DBMessage.OK_RT))//&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6)+"NOME STORED: ASSOC_OFPS_VERIF_ESIST");

            pk.setNumOfPs(cs.getInt(4));      
//     //System.out.println("NUM="+cs.getInt(4));


      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_MIN_DIV_RISP_CORR(?,?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,pk.getCodContratto());
      cs.setString(2,pk.getCodeOf());
      cs.setString(3,pk.getCodePs());
      cs.setString(4,pk.getDataIniOfPs());
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(6)!=DBMessage.OK_RT))//&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7)+"NOME STORED: ASSOC_OFPS_MIN_DIV_RISP_CORR");

      if(cs.getString(5)==null)
            pk.setDataMin("");      
      else
            pk.setDataMin(cs.getString(5));      
//     //System.out.println("descFreq="+pk.getDataMin());
      cs.close();
      conn.close();
    }
    catch(Exception lexc_Exception)
      {
       throw new CustomEJBException(lexc_Exception.toString(),
       "Errore nella ejbFindByPrimaryKey",
       "ejbCreate Classic",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
      }
    finally
      {
        try
        {
          conn.close();
        } catch(Exception lexc_Exception)
        {
          throw new CustomEJBException(lexc_Exception.toString(),
           "Errore nella chiusura della connessione",
           "findByPrimaryKey",
           this.getClass().getName(),
           StaticContext.FindExceptionType(lexc_Exception));
        }
      }

   return pk;
  }





  public void setDataFineOfPs(String dataFine) throws CustomEJBException
  {
		pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();

    Connection conn=null;  

    try
    {
      conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_DISATTIVA(?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,dataFine);
      cs.setString(2,pk.getCodeOf()); 
      cs.setString(3,pk.getDataIni());
      cs.setString(4,pk.getDataIniOfPs());
      cs.setString(5,pk.getCodePs());
/*
System.out.println("-----------------------------");
System.out.println(dataFine);
System.out.println(pk.getCodeCOf());
System.out.println(pk.getDataIni());
System.out.println(pk.getDataIniOf());
System.out.println(pk.getCodePs());
System.out.println("-----------------------------");
*/
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(6)!=DBMessage.OK_RT))//&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7)+"NOME STORED: ASSOC_OFPS_DISATTIVA");
/*
System.out.println(cs.getInt(6));
System.out.println("-----------------------------");
*/
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(Exception lexc_Exception)
    {
    throw new CustomEJBException(lexc_Exception.toString(),
    							"Errore nella verifica se l'oggetto di fatturazione è disattivabile",
									"isDisattivabile Special",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
  	}
    finally
      {
        try
        {
          conn.close();
        } catch(Exception lexc_Exception)
        {
          throw new CustomEJBException(lexc_Exception.toString(),
							"Errore nella chiusura della connessione",
							"isDisattivabile Special",
							this.getClass().getName(),
							StaticContext.FindExceptionType(lexc_Exception));
        }
      }

		pk.setDataFineOfPs(dataFine);
    enableStore=false;
    return ;

  }





  public void ejbRemove() throws RemoveException, RemoteException 
  {
    //System.out.println("****** ejbRemove() *****");
		pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();

    Connection conn=null;  

    try
    {
      conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_CANCELLA(?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,pk.getCodeOf());
      cs.setString(2,pk.getDataIni());
      cs.setString(3,pk.getDataIniOfPs());
      cs.setString(4,pk.getCodePs());
/*
System.out.println("*********");
System.out.println(pk.getCodeOf());
System.out.println(pk.getDataIni());
System.out.println(pk.getDataIniOf());
System.out.println(pk.getCodePs());
System.out.println("*********");
*/
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(5)!=DBMessage.OK_RT))//&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6)+"NOME STORED: ASSOC_OFPS_CANCELLA");
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
      catch(Throwable e)
    {
      try
        {
          if (!conn.isClosed()) 
              conn.close();
        }
      catch (SQLException sqle)
        {
          sqle.printStackTrace();
          throw new RemoteException(sqle.getMessage());
        }

      e.printStackTrace();
       throw new RemoteException(e.getMessage());
    }

    enableStore=false;
    return ;
  }


  public int getNumTariffe()
  {
      pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
      if (pk==null)
       return -1; 
      else
        return pk.getNumTariffe();
  }

  public String getCodeOf()
  {
      pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodeOf();
  }

  public void setCodeOf(String codeOf)
  {
		pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
		pk.setCodeOf(codeOf);
    enableStore=true;
  }

  public String getDescOf()
  {
      pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDescOf();
  }

  public void setDescOf(String descOf)
  {
		pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
		pk.setDescOf(descOf);
    enableStore=true;
  }

  public String getCodePs()
  {
      pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodePs();
  }

  public void setCodePs(String codePs)
  {
		pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
		pk.setCodePs(codePs);
    enableStore=true;
  }

  public String getDescPs()
  {
      pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDescPs();
  }

  public void setDescPs(String descPs)
  {
		pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
		pk.setDescPs(descPs);
    enableStore=true;
  }

  public String getCodeCOf()
  {
      pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodeCOf();
  }

  public void setCodeCOf(String codeCOf)
  {
		pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
		pk.setCodeCOf(codeCOf);
    enableStore=true;
  }

  public String getDescCOf()
  {
      pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDescCOf();
  }

  public void setDescCOf(String descCOf)
  {
		pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
		pk.setDescCOf(descCOf);
    enableStore=true;
  }

  public String getCodModalAppl()
  {
      pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodModalAppl();
  }

  public void setCodModalAppl(String codModalAppl)
  {
		pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
		pk.setCodModalAppl(codModalAppl);
    enableStore=true;
  }

  public String getDescModalAppl()
  {
      pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDescModalAppl();
  }

  public void setDescModalAppl(String descModalAppl)
  {
		pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
		pk.setDescModalAppl(descModalAppl);
    enableStore=true;
  }

  public String getFlag()
  {
      pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getFlag();
  }

  public void setFlag(String flag)
  {
		pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
		pk.setDescModalAppl(flag);
    enableStore=true;
  }

  public String getCodFreq()
  {
      pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodFreq();
  }

  public void setCodFreq(String codFreq)
  {
		pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
		pk.setCodFreq(codFreq);
    enableStore=true;
  }

  public String getDescFreq()
  {
      pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDescFreq();
  }

  public void setDescFreq(String descFreq)
  {
		pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
		pk.setDescFreq(descFreq);
    enableStore=true;
  }

  public String getDataIni()
  {
      pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDataIni();
  }

  public void setDataIni(String dataIni)
  {
		pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
		pk.setDataIni(dataIni);
    enableStore=true;
  }

  public String getDataIniOfPs()
  {
      pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDataIniOfPs();
  }

  public void setDataIniOfPs(String dataIni)
  {
		pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
		pk.setDataIniOfPs(dataIni);
    enableStore=true;
  }


  public void setDataIniOf(String dataIni)
  {
		pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
		pk.setDataIniOf(dataIni);
    enableStore=true;
  }

  public String getDataIniOf()
  {
      pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDataIniOf();
  }



  public String getDataFineOfPs()
  {
      pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDataFineOfPs();
  }

  public String getDataFineOf()
  {
      pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDataFineOf();
  }

  public String getDataMin()
  {
      pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDataMin();
  }

  public void setDataMin(String dataMin)
  {
		pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
		pk.setDataMin(dataMin);
    enableStore=true;
  }

  public void setDataFineOf(String dataFine)
  {
		pk = (GestAssOfPsBMPPK) ctx.getPrimaryKey();
		pk.setDataFineOf(dataFine);
    enableStore=true;
  }
}