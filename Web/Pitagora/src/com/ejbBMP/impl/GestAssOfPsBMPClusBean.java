package com.ejbBMP.impl;
import javax.ejb.EntityBean;
import javax.ejb.EntityContext;
import com.ejbBMP.GestAssOfPsBMPClusPK;
import java.util.*;
import java.rmi.*;
import java.sql.*;
import javax.ejb.*;
import oracle.jdbc.*;
import oracle.sql.*;
import com.utl.*;
import javax.naming.*;

public class GestAssOfPsBMPClusBean extends AbstractEntityCommonBean implements EntityBean 
{
  public EntityContext entityContext;
  private GestAssOfPsBMPClusPK pk;
  private boolean enableStore=false;

  public GestAssOfPsBMPClusPK ejbCreate()
  {
    return null;
  }

  public void ejbPostCreate()
  {
  }


  public GestAssOfPsBMPClusPK ejbFindByPrimaryKey(GestAssOfPsBMPClusPK primaryKey)
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
      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_VERIF_ESIST_CLUS(?,?,?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,pk.getCodeTipoContr());
      cs.setString(2,pk.getCodeOf());
      cs.setString(3,pk.getCodePs());
        cs.setString(4,pk.getCodeCluster());
        cs.setString(5,pk.getTipoCluster());
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(7)!=DBMessage.OK_RT))//&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(7)+":"+cs.getString(8)+"NOME STORED: ASSOC_OFPS_VERIF_ESIST_CLUS");

            pk.setNumOfPs(cs.getInt(6));      
//     //System.out.println("NUM="+cs.getInt(6));


      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_MIN_DIV_RI_CO_CLUS(?,?,?,?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,pk.getCodeTipoContr());
      cs.setString(2,pk.getCodeOf());
      cs.setString(3,pk.getCodePs());
      cs.setString(4,pk.getDataIniOfPs());
        cs.setString(5,pk.getCodeCluster());
        cs.setString(6,pk.getTipoCluster());

      cs.registerOutParameter(7,Types.VARCHAR);
      cs.registerOutParameter(8,Types.INTEGER);
      cs.registerOutParameter(9,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(8)!=DBMessage.OK_RT))//&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(8)+":"+cs.getString(9)+"NOME STORED: ASSOC_OFPS_MIN_DIV_RI_CO_CLUS");

      if(cs.getString(7)==null)
            pk.setDataMin("");      
      else
            pk.setDataMin(cs.getString(7));      
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
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();

    Connection conn=null;  

    try
    {
      conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_DISATTIVA_CLUS(?,?,?,?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,dataFine);
      cs.setString(2,pk.getCodeOf()); 
      cs.setString(3,pk.getDataIni());
      cs.setString(4,pk.getDataIniOfPs());
      cs.setString(5,pk.getCodePs());
      
        cs.setString(6,pk.getCodeTipoContr());
        cs.setString(7,pk.getCodeCluster());
        cs.setString(8,pk.getTipoCluster());
/*
System.out.println("-----------------------------");
System.out.println(dataFine);
System.out.println(pk.getCodeCOf());
System.out.println(pk.getDataIni());
System.out.println(pk.getDataIniOf());
System.out.println(pk.getCodePs());
System.out.println("-----------------------------");
*/
      cs.registerOutParameter(9,Types.INTEGER);
      cs.registerOutParameter(10,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(9)!=DBMessage.OK_RT))//&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(9)+":"+cs.getString(10)+"NOME STORED: ASSOC_OFPS_DISATTIVA");
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
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();

    Connection conn=null;  

    try
    {
      conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_CANCELLA_CLUS(?,?,?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,pk.getCodeOf());
      cs.setString(2,pk.getDataIni());
      cs.setString(3,pk.getDataIniOfPs());
      cs.setString(4,pk.getCodePs());
      
      cs.setString(5,pk.getCodeTipoContr());
      cs.setString(6,pk.getCodeCluster());
      cs.setString(7,pk.getTipoCluster());
/*
System.out.println("*********");
System.out.println(pk.getCodeOf());
System.out.println(pk.getDataIni());
System.out.println(pk.getDataIniOf());
System.out.println(pk.getCodePs());
System.out.println("*********");
*/
      cs.registerOutParameter(8,Types.INTEGER);
      cs.registerOutParameter(9,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(8)!=DBMessage.OK_RT))//&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(8)+":"+cs.getString(9)+"NOME STORED: ASSOC_OFPS_CANCELLA_CLUS");
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
      pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null)
       return -1; 
      else
        return pk.getNumTariffe();
  }

  public String getCodeOf()
  {
      pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodeOf();
  }

  public void setCodeOf(String codeOf)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setCodeOf(codeOf);
    enableStore=true;
  }

  public String getDescOf()
  {
      pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDescOf();
  }

  public void setDescOf(String descOf)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setDescOf(descOf);
    enableStore=true;
  }

  public String getCodePs()
  {
      pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodePs();
  }

  public void setCodePs(String codePs)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setCodePs(codePs);
    enableStore=true;
  }

  public String getDescPs()
  {
      pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDescPs();
  }

  public void setDescPs(String descPs)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setDescPs(descPs);
    enableStore=true;
  }

  public String getCodeCOf()
  {
      pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodeCOf();
  }

  public void setCodeCOf(String codeCOf)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setCodeCOf(codeCOf);
    enableStore=true;
  }

  public String getDescCOf()
  {
      pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDescCOf();
  }

  public void setDescCOf(String descCOf)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setDescCOf(descCOf);
    enableStore=true;
  }

  public String getCodModalAppl()
  {
      pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodModalAppl();
  }

  public void setCodModalAppl(String codModalAppl)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setCodModalAppl(codModalAppl);
    enableStore=true;
  }

  public String getDescModalAppl()
  {
      pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDescModalAppl();
  }

  public void setDescModalAppl(String descModalAppl)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setDescModalAppl(descModalAppl);
    enableStore=true;
  }

  public String getFlag()
  {
      pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getFlag();
  }

  public void setFlag(String flag)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setDescModalAppl(flag);
    enableStore=true;
  }

  public String getCodFreq()
  {
      pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodFreq();
  }

  public void setCodFreq(String codFreq)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setCodFreq(codFreq);
    enableStore=true;
  }

  public String getDescFreq()
  {
      pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDescFreq();
  }

  public void setDescFreq(String descFreq)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setDescFreq(descFreq);
    enableStore=true;
  }

  public String getDataIni()
  {
      pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDataIni();
  }

  public void setDataIni(String dataIni)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setDataIni(dataIni);
    enableStore=true;
  }

  public String getDataIniOfPs()
  {
      pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDataIniOfPs();
  }

  public void setDataIniOfPs(String dataIni)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setDataIniOfPs(dataIni);
    enableStore=true;
  }


  public void setDataIniOf(String dataIni)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setDataIniOf(dataIni);
    enableStore=true;
  }

  public String getDataIniOf()
  {
      pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDataIniOf();
  }



  public String getDataFineOfPs()
  {
      pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDataFineOfPs();
  }

  public String getDataFineOf()
  {
      pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDataFineOf();
  }

  public String getDataMin()
  {
      pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getDataMin();
  }

  public void setDataMin(String dataMin)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setDataMin(dataMin);
    enableStore=true;
  }

  public void setDataFineOf(String dataFine)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setDataFineOf(dataFine);
    enableStore=true;
  }
  
  public String getTipoCluster()
  {
	  pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getTipoCluster();
  }
  
  public void setTipoCluster(String tipoCluster)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setTipoCluster(tipoCluster);
    enableStore=true;
  }	  

  public String getCodeCluster()
  {
	  pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodeCluster();
  }
  
  public void setCodeCluster(String codeCluster)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setCodeCluster(codeCluster);
    enableStore=true;
  }	  

  public String getCodeTipoContr()
  {
	  pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodeTipoContr();
  }
  
  public void setCodeTipoContr(String codeTipoContr)
  {
		pk = (GestAssOfPsBMPClusPK) ctx.getPrimaryKey();
		pk.setCodeTipoContr(codeTipoContr);
    enableStore=true;
  }	  
}