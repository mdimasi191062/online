package com.ejbBMP.impl;
//import javax.ejb.EntityBean;
//import javax.ejb.EntityContext;
import java.util.*;
import java.rmi.*;
import java.sql.*;
import javax.ejb.*;
import oracle.jdbc.*;
import oracle.sql.*;
import com.ejbBMP.AssOfPsBMPClusPK;
import com.utl.*;
import javax.naming.*;

public class AssOfPsBMPClusBean extends AbstractEntityCommonBean implements EntityBean 
{
  public EntityContext entityContext;
  private AssOfPsBMPClusPK pk;

  private boolean enableStore=false;

  public AssOfPsBMPClusPK ejbCreate()                    throws CreateException, RemoteException 
  {
      try
      {
      conn = getConnection(dsName);
      conn.close();
      }
    catch(SQLException e)
      {
        throw new CreateException(e.getMessage());
      }
    catch(Exception ee)
      {
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

    return null;
  }


    public AssOfPsBMPClusPK ejbCreate(String dataIniOfPs, String codeOf,
                                  String codePs, String dataIniOf, String codeMod, String codeFreq,
                                  String codeUte, int quantShift, String flgAP, String dataFineOfPs,
                                  String tipoCluster, String codeCluster, String codeTipoContr)
                                   throws CreateException, RemoteException, CustomEJBException
    {
        pk=new AssOfPsBMPClusPK();
        try
        {
        conn = getConnection(dsName);
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_INSERISCI_CLUS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
        // Impostazione types I/O
        cs.setString(1,dataIniOfPs);
        cs.setString(2,codeOf);
        cs.setString(3,codePs);
        cs.setString(4,dataIniOf);
        cs.setString(5,codeMod);
        cs.setString(6,codeFreq);
        cs.setString(7,codeUte);
        cs.setInt(8,quantShift);
        cs.setString(9,flgAP);
        cs.setString(10,dataFineOfPs);
        cs.setString(11,tipoCluster);
        cs.setString(12,codeCluster);
        cs.setString(13,codeTipoContr);
        cs.registerOutParameter(14,Types.INTEGER);
        cs.registerOutParameter(15,Types.VARCHAR);
        cs.execute();

        if ((cs.getInt(14)!=DBMessage.OK_RT)&&(cs.getInt(14)!=DBMessage.NOT_FOUND_RT))
          throw new EJBException("DB:ASSOC_OFPS_INSERISCI_CLUS:"+cs.getInt(14)+":"+cs.getString(15));

        pk.setDataIniOfPs(dataIniOfPs);
        pk.setCodeOf(codeOf);
        pk.setCodePs(codePs);
        pk.setDataIniOf(dataIniOf);
        pk.setCodeModal(codeMod);
        pk.setCodeFreq(codeFreq);
        pk.setQntaShiftCanoni(quantShift);
        pk.setTipoFlgAP(flgAP);
        pk.setDataFineOfPs(dataFineOfPs);
		pk.setTipoCluster(tipoCluster);
		pk.setCodeCluster(codeCluster);
		pk.setCodeTipoContr(codeTipoContr);

        cs.close();
        // Chiudo la connessione
        conn.close();

        }
        catch(Exception lexc_Exception)
        {

        throw new CustomEJBException(lexc_Exception.toString(),
                      "Errore di inserimento nella store procedure PKG_BILL_SPE.ASSOC_OFPS_INSERISCI_CLUS",
                      "ejbCreate Special",
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
                  "ejbCreate Special",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
            }
          }
        return pk;
    }


  public void ejbPostCreate() 
  {
  }

  public void ejbPostCreate(String dataIniOfPs, String codeOf,
                            String codePs, String dataIniOf, String codeMod, String codeFreq,
                            String codeUte, int quantShift, String flgAP, String dataFineOfPs,
                            String tipoCluster, String codeCluster, String codeTipoContr) 
  {
  }

  public AssOfPsBMPClusPK ejbFindByPrimaryKey(AssOfPsBMPClusPK primaryKey)
  {
    return primaryKey;

  }


  public void ejbStore()
  {
   if (enableStore)
    {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
    }
  }


  //vedere i parametri e il codice contenuto!!!!!!
  public Collection ejbFindAll(String CodTipoContr, String cod_cluster, String tipo_cluster, boolean solo_attivi) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
    try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_LST_X_TIPO_CON_CLU(?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      if (solo_attivi)
        cs.setInt(2,0);
      else
        cs.setInt(2,1);
        cs.setString(3,cod_cluster);
        cs.setString(4,tipo_cluster);
      cs.registerOutParameter(5,OracleTypes.ARRAY, "ARR_ASSOC_OFPS_CLUS");
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.execute();

//      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
//        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ASSOC_OFPS_CLUS",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(5);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {

              pk = new AssOfPsBMPClusPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              //campi ricavati dalla select
              pk.setCodePs(attr[0].stringValue());
              pk.setDescPs(attr[1].stringValue());

              if (attr[2]!=null)  
                pk.setDataIniPs(attr[2].stringValue());   
              else
                pk.setDataIniPs("");   

              if (attr[3]!=null)  
                pk.setDataFinePs(attr[3].stringValue());
              else
                pk.setDataFinePs("");
   
              pk.setCodeOf(attr[4].stringValue());
              pk.setDescOf(attr[5].stringValue());
              pk.setDataIniOf(attr[6].stringValue());   
              pk.setCodeCOf(attr[7].stringValue());
              pk.setDescCOf(attr[8].stringValue());
              pk.setDataIniAssOf(attr[9].stringValue());   

              if (attr[10]!=null)  
                pk.setDataFineAssOf(attr[10].stringValue());
              else
                pk.setDataFineAssOf("");

              pk.setCodeFreq(attr[11].stringValue());   

              if (attr[12]!=null)  
                pk.setCodeModal(attr[12].stringValue());
              else
                pk.setCodeModal("");

              
              if (attr[13]!= null)
                  pk.setTipoFlgAssocB(attr[13].stringValue());
              else
                  pk.setTipoFlgAssocB("");
                  
              pk.setQntaShiftCanoni(attr[14].intValue());   
              pk.setCodeTipoContr(attr[15].stringValue());

              if (attr[16]!=null) 
                pk.setTipoCluster(attr[16].stringValue());
              else
                  pk.setTipoCluster("");
                  
              if (attr[17]!=null)
                pk.setCodeCluster(attr[17].stringValue());
              else
                  pk.setCodeCluster("");
                  
              recs.add(pk);
          }      
    //System.out.println("Chiudo la connessione!!!!");

      cs.close();
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
//   //System.out.println(" <<ejbFindAll");

    return recs;
  }


  public String getCodePs()
  {
//     //System.out.println("getCodePs>>");
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      //if (pk==null)//System.out.println("pK IS NULL"); 
      return pk.getCodePs();
  //    enableStore=false;
  //    return mdescPs;
  }

  public void setCodePs(String codePs)
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setCodePs (codePs);
      enableStore=true;
//    mdescPs=descPs;
  }

  public String getDescPs()
  {
//     //System.out.println("getDescPs>>");
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      //if (pk==null)//System.out.println("pK IS NULL"); 
      return pk.getDescPs();
  //    enableStore=false;
  //    return mdescPs;
  }

  public void setDescPs(String descPs)
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setDescPs (descPs);
      enableStore=true;
//    mdescPs=descPs;
  }

///////////
  public String getDataIniPs()
  {
//     //System.out.println("getDataIniPs>>");
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      //if (pk==null)//System.out.println("pK IS NULL"); 
      return pk.getDataIniPs();
  //    enableStore=false;
  //    return mdataIniPs;
  }

  public void setDataIniPs(String dataIniPs)
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setDataIniPs (dataIniPs);
      enableStore=true;
//    mdataIniPs=dataIniPs;
  }

  public String getDataFinePs()
  {
//     //System.out.println("getDataFinePs>>");
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      //if (pk==null)//System.out.println("pK IS NULL"); 
      return pk.getDataFinePs();
  //    enableStore=false;
  //    return mdataFinePs;
  }

  public void setDataFinePs(String dataFinePs)
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setDataFinePs (dataFinePs);
      enableStore=true;
//    mdataFinePs=dataFinePs;
  }

  public String getCodeTipo()
  {
//     //System.out.println("getCodeTipo>>");
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      //if (pk==null)//System.out.println("pK IS NULL"); 
      return pk.getCodeTipo();
  //    enableStore=false;
  //    return mdescPs;
  }

  public void setCodeTipo(String codeTipo)
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setCodeTipo (codeTipo);

      enableStore=true;
//    mdescPs=descPs;
  }

  public String getDescTipo()
  {
//     //System.out.println("getDescTipo>>");
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      //if (pk==null)//System.out.println("pK IS NULL"); 
      return pk.getDescTipo();
  //    enableStore=false;
  //    return mdescPs;
  }

  public void setDescTipo(String descTipo)
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setDescTipo (descTipo);

      enableStore=true;
  }

  public String getCodeOf()
  {
//     //System.out.println("getCodeOf>>");
      enableStore=false;
      
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodeOf();
  }

  public void setCodeOf(String codeOf)
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setCodeOf (codeOf);

      enableStore=true;
  }

  public String getDescOf()
  {
//     //System.out.println("getDescOf>>");
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      //if (pk==null)//System.out.println("pK IS NULL"); 
      return pk.getDescOf();
  //    enableStore=false;
  //    return mdescPs;
  }

  public void setDescOf(String descOf)
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setDescOf (descOf);

      enableStore=true;
//    mdescPs=descPs;
  }

  public String getDataIniOf()
  {
//     //System.out.println("getDataIniOf>>");
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      //if (pk==null)//System.out.println("pK IS NULL"); 
      return pk.getDataIniOf();
  //    enableStore=false;
  //    return mdescPs;
  }

  public void setDataIniOf(String dataIniOf)
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setDataIniOf (dataIniOf);

      enableStore=true;
//    mdescPs=descPs;
  }

  public String getCodeCOf()
  {
//     //System.out.println("getCodeCOf>>");
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodeCOf();
  //    enableStore=false;
  //    return mdescPs;
  }

  public void setCodeCOf(String codeCOf)
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setCodeCOf (codeCOf);

      enableStore=true;
//    mdescPs=descPs;
  }

  public String getDescCOf()
  {
//     //System.out.println("getDescCOf>>");
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      //if (pk==null)//System.out.println("pK IS NULL"); 
      return pk.getDescCOf();
  //    enableStore=false;
  //    return mdescPs;
  }

  public void setDescCOf(String descCOf)
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setDescCOf (descCOf);

      enableStore=true;
//    mdescPs=descPs;
  }

  public String getDataIniAssOf()
  {
//     //System.out.println("getDataIniAssOf>>");
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      //if (pk==null)//System.out.println("pK IS NULL"); 
      return pk.getDataIniAssOf();
  //    enableStore=false;
  //    return mdescPs;
  }

  public void setDataIniAssOf(String dataIniAssOf)  
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setDataIniAssOf (dataIniAssOf);

      enableStore=true;
//    mdescPs=descPs;
  }

  public String getDataFineAssOf()
  {
//     //System.out.println("getDataFineAssOf>>");
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      //if (pk==null)//System.out.println("pK IS NULL"); 
      return pk.getDataFineAssOf();
  //    enableStore=false;
  //    return mdescPs;
  }

  public void setDataFineAssOf(String dataFineAssOf)
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setDataFineAssOf (dataFineAssOf);

      enableStore=true;
//    mdescPs=descPs;
  }

  public String getCodeFreq()
  {
//     //System.out.println("getCodeFreq>>");
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      //if (pk==null)//System.out.println("pK IS NULL"); 
      return pk.getCodeFreq();
  //    enableStore=false;
  //    return mdescPs;
  }

  public void setCodeFreq(String codeFreq)  
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setCodeFreq (codeFreq);

      enableStore=true;
//    mdescPs=descPs;
  }

  public String getCodeModal()
  {
//     //System.out.println("getCodeModal>>");
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      //if (pk==null)//System.out.println("pK IS NULL"); 
      return pk.getCodeModal();
  //    enableStore=false;
  //    return mdescPs;
  }

  public void setCodeModal(String codeModal)  
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setCodeModal (codeModal);

      enableStore=true;
//    mdescPs=descPs;
  }

  public String getTipoFlgAssocB()  
  {
//     //System.out.println("getTipoFlgAssocB>>");
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      //if (pk==null)//System.out.println("pK IS NULL"); 
      return pk.getTipoFlgAssocB();
  //    enableStore=false;
  //    return mdescPs;
  }

  public void setTipoFlgAssocB(String tipoFlgAssocB)
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setTipoFlgAssocB (tipoFlgAssocB);

      enableStore=true;
//    mdescPs=descPs;
  }

  public int getQntaShiftCanoni()
  {
//     //System.out.println("getQntaShiftCanoni>>");
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      //if (pk==null)//System.out.println("pK IS NULL"); 
      return pk.getQntaShiftCanoni();
  //    enableStore=false;
  //    return mdescPs;
  }

  public void setQntaShiftCanoni(int qntaShiftCanoni)  
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setQntaShiftCanoni (qntaShiftCanoni);

      enableStore=true;
//    mdescPs=descPs;
  }

  public String getCodeTipoContr()
  {
//     //System.out.println("getCodeTipoContr>>");
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      //if (pk==null)//System.out.println("pK IS NULL"); 
      return pk.getCodeTipoContr();
  //    enableStore=false;
  //    return mdescPs;
  }

  public void setCodeTipoContr(String codeTipoContr)  
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setCodeTipoContr (codeTipoContr);

      enableStore=true;
//    mdescPs=descPs;
  }
/*
  public String getDataIni()
  {
//     //System.out.println("getDataIniPs>>");
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
      //if (pk==null)//System.out.println("pK IS NULL"); 
      return pk.getDataIni();
  //    enableStore=false;
  //    return mdataIniPs;
  }

  public void setDataIni(String dataIni)
  {
      pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
 		  pk.setDataIni(dataIni);
      enableStore=true;
//    mdataIniPs=dataIniPs;
  }
*/


 public String getTipoCluster()  
 {
     pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
     return pk.getTipoCluster();

 }

 public void setTipoCluster(String tipoCluster)
 {
     pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
                 pk.setTipoCluster (tipoCluster);
     enableStore=true;

 }

public String getCodeCluster()  
{
    pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
    return pk.getCodeCluster();

}

public void setCodeCluster(String codeCluster)
{
    pk = (AssOfPsBMPClusPK) ctx.getPrimaryKey();
                pk.setCodeCluster (codeCluster);
    enableStore=true;

}

}