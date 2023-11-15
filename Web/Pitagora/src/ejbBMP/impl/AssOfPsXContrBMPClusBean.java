package com.ejbBMP.impl;
import javax.ejb.EntityBean;
import javax.ejb.EntityContext;
import com.ejbBMP.AssOfPsXContrBMPClusPK;
import com.utl.*;
import java.util.*;
import java.rmi.*;
import java.sql.*;

import javax.ejb.*;
import javax.naming.*;


import oracle.jdbc.*;
import oracle.sql.*;


public class AssOfPsXContrBMPClusBean extends AbstractEntityCommonBean implements EntityBean
{
  public EntityContext entityContext;


  private AssOfPsXContrBMPClusPK pk;

  private boolean enableStore=false;


  public AssOfPsXContrBMPClusPK ejbCreate(String codeContr, String dataIniOfPs, String codeOf,
                                      String codePs, String dataIniOf, String codeMod, String codeFreq,
                                      String codeUte, int quntShift, String flgAP, String dataFineOfPs, String codeCluster, String tipoCluster, String codeTipoContr)
                                      throws CreateException, RemoteException, CustomEJBException
  {
    pk=new AssOfPsXContrBMPClusPK();

     try
      {
      conn = getConnection(dsName);
            /*
            PROCEDURE ASSOC_OFPS_X_CONTR_INSERISCI
                                      (i_code_contr           IN  VARCHAR2,
                                       i_data_inizio_of_ps    IN  VARCHAR2,
                                       i_code_of              IN  VARCHAR2,
                                       i_code_ps              IN  VARCHAR2,
                                       i_data_inizio_of       IN  VARCHAR2,
                                       i_code_mod_appl        IN  VARCHAR2,
                                       i_code_freq            IN  VARCHAR2,
                                       i_code_utente          IN  VARCHAR2,
                                       i_qnta_shift_canoni    IN  NUMBER,
                                       i_flag_ant_post        IN  VARCHAR2,
                                       i_data_fine_of_ps      IN  VARCHAR2,
                                       o_errore_sql           OUT NUMBER,
                                       o_errore_msg           OUT VARCHAR2);
            */

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_INS_CLU(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,codeContr);
      cs.setString(2,dataIniOfPs);
      cs.setString(3,codeOf);
      cs.setString(4,codePs);
      cs.setString(5,dataIniOf);
      cs.setString(6,codeMod);
      cs.setString(7,codeFreq);
      cs.setString(8,codeUte);
      cs.setInt(9,quntShift);
      cs.setString(10,flgAP);
      cs.setString(11,dataFineOfPs);

          cs.setString(12,codeCluster);
          cs.setString(13,tipoCluster);
          cs.setString(14,codeTipoContr);

      cs.registerOutParameter(15,Types.INTEGER);
      cs.registerOutParameter(16,Types.VARCHAR);

      cs.execute();

      if ((cs.getInt(15)!=DBMessage.OK_RT)&&(cs.getInt(15)!=DBMessage.NOT_FOUND_RT))
        throw new EJBException("DB:ASSOC_OFPS_X_CONTR_INSERISCI:"+cs.getInt(15)+":"+cs.getString(16));

     pk.setCodeContr(codeContr);
     pk.setDataIniOfPs(dataIniOfPs);
     pk.setCodeOf(codeOf);
     pk.setCodePs(codePs);
     pk.setDataIniOf(dataIniOf);
     pk.setCodeModal(codeMod);
     pk.setCodeFreq(codeFreq);
     pk.setQntaShiftCanoni(quntShift);
     pk.setTipoFlgAP(flgAP);
     pk.setDataFineOfPs(dataFineOfPs);
     pk.setCodeCluster(codeCluster);
     pk.setTipoCluster(tipoCluster);
     pk.setCodeTipoContr(codeTipoContr);

     cs.close();
     conn.close();

      }
    catch(Exception lexc_Exception)
    {

		throw new CustomEJBException(lexc_Exception.toString(),
    							"Errore di inserimento nella store procedure PKG_BILL_SPE.OGGETTO_FATT_INSERISCI",
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

  public void ejbPostCreate(String codeContr, String dataIniOfPs, String codeOf,
                            String codePs, String dataIniOf, String codeMod, String codeFreq,
                            String codeUte, int quntShift, String flgAP, String dataFineOfPs, String codeCluster, String tipoCluster, String codeTipoContr)
  {
  }

  public AssOfPsXContrBMPClusPK ejbFindByPrimaryKey(AssOfPsXContrBMPClusPK primaryKey) throws FinderException, CustomEJBException, RemoteException
  {
//   //System.out.println(">>> ejbFindByPrimaryKey");

    try
		{
        conn = getConnection(dsName);
       
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CONTR_DETTAGLIO(?,?,?,?,?,?)}");

        cs.setString(1,primaryKey.getCodeContr());
        cs.setString(2,primaryKey.getFlagSys());

        cs.registerOutParameter(3,Types.VARCHAR);
        cs.registerOutParameter(4,Types.VARCHAR);
        cs.registerOutParameter(5,Types.INTEGER);
        cs.registerOutParameter(6,Types.VARCHAR);

        cs.execute();

        if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:CONTR_DETTAGLIO:"+cs.getInt(5)+":"+cs.getString(6));

        if (cs.getInt(5)==DBMessage.NOT_FOUND_RT)
        throw new FinderException("DB:CONTR_DETTAGLIO:"+cs.getInt(5)+":"+cs.getString(6));

        if (cs.getString(3)!=null)
          primaryKey.setDescContr(cs.getString(3));
        else
          primaryKey.setDescContr("");

        if (cs.getString(4)!=null)
          primaryKey.setDataIniContr(cs.getString(4));
        else
          primaryKey.setDataIniContr("");

      //PS_DETTAGLIO
      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PS_DETTAGLIO(?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,primaryKey.getCodePs());
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:PS_DETTAGLIO:"+cs.getInt(3)+":"+cs.getString(4));

      if (cs.getInt(3)==DBMessage.NOT_FOUND_RT)
        throw new FinderException("DB:PS_DETTAGLIO:"+cs.getInt(3)+":"+cs.getString(4));

      if(cs.getString(2)==null)
            primaryKey.setDescPs("");
      else
            primaryKey.setDescPs(cs.getString(2));

      //CLAS_OGG_FAT_DETTAGLIO
      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CLAS_OGG_FAT_DETTAGLIO(?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,primaryKey.getCodeCOf());
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:CLAS_OGG_FAT_DETTAGLIO:"+cs.getInt(3)+":"+cs.getString(4));

      if (cs.getInt(3)==DBMessage.NOT_FOUND_RT)
        throw new FinderException("DB:CLAS_OGG_FAT_DETTAGLIO:"+cs.getInt(3)+":"+cs.getString(4));

      if(cs.getString(2)==null)
            primaryKey.setDescCOf("");
      else
            primaryKey.setDescCOf(cs.getString(2));


      //OGGETTO_FATT_LEGGI_DETTAGLIO
      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_LEGGI_DETTAGLIO(?,?,?,?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,primaryKey.getCodeOf());
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.registerOutParameter(8,Types.INTEGER);
      cs.registerOutParameter(9,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(8)!=DBMessage.OK_RT)&&(cs.getInt(8)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:OGGETTO_FATT_LEGGI_DETTAGLIO:"+cs.getInt(8)+":"+cs.getString(9));

      if (cs.getInt(8)==DBMessage.NOT_FOUND_RT)
        throw new FinderException("DB:OGGETTO_FATT_LEGGI_DETTAGLIO:"+cs.getInt(8)+":"+cs.getString(9));

      if(cs.getString(2)==null)
            primaryKey.setDescOf("");
      else
            primaryKey.setDescOf(cs.getString(2));

      if(cs.getString(6)==null)
            primaryKey.setDataFineOf("");
      else
            primaryKey.setDataFineOf(cs.getString(6));

      //MOD_APPL_RATEI_DETTAGLIO
      if((primaryKey.getCodeModal()!=null) && (!primaryKey.getCodeModal().equals("")))
      {
        cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".MOD_APPL_RATEI_DETTAGLIO(?,?,?,?)}");
        // Impostazione types I/O
        cs.setString(1,primaryKey.getCodeModal());
        cs.registerOutParameter(2,Types.VARCHAR);
        cs.registerOutParameter(3,Types.INTEGER);
        cs.registerOutParameter(4,Types.VARCHAR);
        cs.execute();

        if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
          throw new Exception("DB:MOD_APPL_RATEI_DETTAGLIO"+cs.getInt(3)+":"+cs.getString(4));

        if (cs.getInt(3)==DBMessage.NOT_FOUND_RT)
          throw new FinderException("DB:MOD_APPL_RATEI_DETTAGLIO:"+cs.getInt(3)+":"+cs.getString(4));

        primaryKey.setDescModal(cs.getString(2));
      }


      //FREQUENZA_DETTAGLIO
      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".FREQUENZA_DETTAGLIO(?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,primaryKey.getCodeFreq());
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
         throw new Exception("DB:FREQUENZA_DETTAGLIO:"+cs.getInt(3)+":"+cs.getString(4));

      if (cs.getInt(3)==DBMessage.NOT_FOUND_RT)
          throw new FinderException("DB:FREQUENZA_DETTAGLIO:"+cs.getInt(3)+":"+cs.getString(4));

      if(cs.getString(2)==null)
            primaryKey.setDescFreq("");
      else
            primaryKey.setDescFreq(cs.getString(2));

      cs.close();
      // chiusura connessione
      conn.close();
    }
		catch(Exception lexc_Exception)
    {
      try
        {
          if (!conn.isClosed())
              conn.close();
        }
      catch (SQLException sqle)
        {
            throw new CustomEJBException(sqle.toString(),
	  							"Errore nella chiusura della connessione",
									"ejbFindByPrimaryKey",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomEJBException(lexc_Exception.toString(),
	  								"",
									"ejbFindByPrimaryKey",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

    pk=primaryKey;
    return primaryKey;
  }


   public void disattiva(String dataFineOfPs) throws RemoteException,CustomEJBException
   {
//  //System.out.println(">>> disattiva");
   pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();

    try
		{
        conn = getConnection(dsName);


      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_DIS_CLUS(?,?,?,?,?,?,?,?,?,?)}");
      cs.setString(1,dataFineOfPs);
      cs.setString(2,pk.getCodeContr());
      cs.setString(3,pk.getCodeOf());
      cs.setString(4,pk.getDataIniOf());
      cs.setString(5,pk.getDataIniOfPs());
      cs.setString(6,pk.getCodePs());
        cs.setString(7,pk.getCodeCluster());
        cs.setString(8,pk.getTipoCluster());
      cs.registerOutParameter(9,Types.INTEGER);
      cs.registerOutParameter(10,Types.VARCHAR);

      cs.execute();

       if (cs.getInt(9)!=DBMessage.OK_RT)
         throw new Exception("DB:ASSOC_OFPS_X_CONTR_DISATTIVA:"+cs.getInt(9)+":"+cs.getString(10));
      cs.close();
      // chiusura connessione
      conn.close();
    }
		catch(Exception lexc_Exception)
    {
      try
        {
          if (!conn.isClosed())
              conn.close();
        }
      catch (SQLException sqle)
        {
            throw new CustomEJBException(sqle.toString(),
	  							"Errore nella chiusura della connessione",
									"disattiva",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomEJBException(lexc_Exception.toString(),
	  								"",
									"disattiva",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

    return;
   }


   public Collection ejbFindAll(String CodTipoContr, String CodContr, boolean attivi) throws FinderException, CustomException, RemoteException
	{

//   //System.out.println(">>> ejbFindAll");

    Vector recs = new Vector();
    try
		{
			conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_LST_1(?,?,?,?,?,?)}");
      cs.setString(1,CodTipoContr);
      cs.setString(2,CodContr);

      if (attivi)
        cs.setInt(3,0);
      else
        cs.setInt(3,1);

      cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_ASSOC_OFPS");
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);

      cs.execute();

      if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new FinderException("DB:"+cs.getInt(5)+":"+cs.getString(6));

      if (cs.getInt(5)==DBMessage.NOT_FOUND_RT)
        {
        conn.close();
        return recs;
        }

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ASSOC_OFPS",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      rs=cs.getARRAY(4);
      Datum dati[]=rs.getOracleArray();

      for (int i=0;i<dati.length;i++)
        {
        AssOfPsXContrBMPClusPK pk = new AssOfPsXContrBMPClusPK();

        STRUCT s=(STRUCT)dati[i];
        Datum attr[]=s.getOracleAttributes();

        if ((attr[0]!=null)&&(attr[0].stringValue()!=null))
            pk.setCodePs(attr[0].stringValue());
        else
            pk.setCodePs("");

        if ((attr[1]!=null)&&(attr[1].stringValue()!=null))
            pk.setDescPs(attr[1].stringValue());
        else
            pk.setDescPs("");

        if ((attr[2]!=null)&&(attr[2].stringValue()!=null))
            pk.setDataIni(attr[2].stringValue());
        else
            pk.setDataIni("");

        if ((attr[3]!=null)&&(attr[3].stringValue()!=null))
            pk.setDataFine(attr[3].stringValue());
        else
            pk.setDataFine("");

        if ((attr[4]!=null)&&(attr[4].stringValue()!=null))
            pk.setCodeOf(attr[4].stringValue());
        else
            pk.setCodeOf("");

        if ((attr[5]!=null)&&(attr[5].stringValue()!=null))
            pk.setDescOf(attr[5].stringValue());
        else
            pk.setDescOf("");

        if ((attr[6]!=null)&&(attr[6].stringValue()!=null))
            pk.setDataIniOf(attr[6].stringValue());
        else
            pk.setDataIniOf("");

        if ((attr[7]!=null)&&(attr[7].stringValue()!=null))
            pk.setCodeCOf(attr[7].stringValue());
        else
            pk.setCodeCOf("");

        if ((attr[8]!=null)&&(attr[8].stringValue()!=null))
            pk.setDescCOf(attr[8].stringValue());
        else
            pk.setDescCOf("");

        if ((attr[9]!=null)&&(attr[9].stringValue()!=null))
            pk.setDataIniOfPs(attr[9].stringValue());
        else
            pk.setDataIniOfPs("");

        if ((attr[10]!=null)&&(attr[10].stringValue()!=null))
            pk.setDataFineOfPs(attr[10].stringValue());
        else
            pk.setDataFineOfPs("");

        if ((attr[11]!=null)&&(attr[11].stringValue()!=null))
            pk.setCodeFreq(attr[11].stringValue());
        else
            pk.setCodeFreq("");

       if ((attr[12]!=null)&&(attr[12].stringValue()!=null))
            pk.setCodeModal(attr[12].stringValue());
       else
            pk.setCodeModal("");

       if ((attr[13]!=null)&&(attr[13].stringValue()!=null))
            pk.setTipoFlgAP(attr[13].stringValue());
       else
            pk.setTipoFlgAP("");

       if (attr[14]!=null)
          pk.setQntaShiftCanoni(attr[14].intValue());

       if ((attr[15]!=null)&&(attr[15].stringValue()!=null))
            pk.setCodeTipoContr(attr[15].stringValue());
       else
            pk.setCodeTipoContr("");

        recs.add(pk);
      }

       cs.close();
      // Chiudo la connessione
      conn.close();
    }

		catch(Exception lexc_Exception)
    {
      try
        {
          if (!conn.isClosed())
              conn.close();
        }
      catch (SQLException sqle)
        {
            throw new CustomException(sqle.toString(),
	  							"Errore nella chiusura della connessione",
									"ejbFindAll",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"ejbFindAll",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return recs;
  }

    public Collection ejbFindAll(String CodTipoContr, String CodContr, String codCluster, String tipoCluster, boolean attivi) throws FinderException, CustomException, RemoteException
         {

    //   //System.out.println(">>> ejbFindAll");

     Vector recs = new Vector();
     try
                 {
                         conn = getConnection(dsName);

       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_LST_1_CLUS(?,?,?,?,?,?,?,?)}");
       cs.setString(1,CodTipoContr);
       cs.setString(2,CodContr);

       if (attivi)
         cs.setInt(3,0);
       else
         cs.setInt(3,1);

         cs.setString(4,codCluster);
         cs.setString(5,tipoCluster);

       cs.registerOutParameter(6,OracleTypes.ARRAY, "ARR_ASSOC_OFPS_CLUS");
       cs.registerOutParameter(7,Types.INTEGER);
       cs.registerOutParameter(8,Types.VARCHAR);

       cs.execute();

       if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
         throw new FinderException("DB:"+cs.getInt(7)+":"+cs.getString(8));

       if (cs.getInt(7)==DBMessage.NOT_FOUND_RT)
         {
         conn.close();
         return recs;
         }

       // Costruisco l'array che conterrà i dati di ritorno della stored
       ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ASSOC_OFPS_CLUS",conn);
       ARRAY rs = new ARRAY(ad, conn, null);

       rs=cs.getARRAY(6);
       Datum dati[]=rs.getOracleArray();

       for (int i=0;i<dati.length;i++)
         {
         AssOfPsXContrBMPClusPK pk = new AssOfPsXContrBMPClusPK();

         STRUCT s=(STRUCT)dati[i];
         Datum attr[]=s.getOracleAttributes();

         if ((attr[0]!=null)&&(attr[0].stringValue()!=null))
             pk.setCodePs(attr[0].stringValue());
         else
             pk.setCodePs("");

         if ((attr[1]!=null)&&(attr[1].stringValue()!=null))
             pk.setDescPs(attr[1].stringValue());
         else
             pk.setDescPs("");

         if ((attr[2]!=null)&&(attr[2].stringValue()!=null))
             pk.setDataIni(attr[2].stringValue());
         else
             pk.setDataIni("");

         if ((attr[3]!=null)&&(attr[3].stringValue()!=null))
             pk.setDataFine(attr[3].stringValue());
         else
             pk.setDataFine("");

         if ((attr[4]!=null)&&(attr[4].stringValue()!=null))
             pk.setCodeOf(attr[4].stringValue());
         else
             pk.setCodeOf("");

         if ((attr[5]!=null)&&(attr[5].stringValue()!=null))
             pk.setDescOf(attr[5].stringValue());
         else
             pk.setDescOf("");

         if ((attr[6]!=null)&&(attr[6].stringValue()!=null))
             pk.setDataIniOf(attr[6].stringValue());
         else
             pk.setDataIniOf("");

         if ((attr[7]!=null)&&(attr[7].stringValue()!=null))
             pk.setCodeCOf(attr[7].stringValue());
         else
             pk.setCodeCOf("");

         if ((attr[8]!=null)&&(attr[8].stringValue()!=null))
             pk.setDescCOf(attr[8].stringValue());
         else
             pk.setDescCOf("");

         if ((attr[9]!=null)&&(attr[9].stringValue()!=null))
             pk.setDataIniOfPs(attr[9].stringValue());
         else
             pk.setDataIniOfPs("");

         if ((attr[10]!=null)&&(attr[10].stringValue()!=null))
             pk.setDataFineOfPs(attr[10].stringValue());
         else
             pk.setDataFineOfPs("");

         if ((attr[11]!=null)&&(attr[11].stringValue()!=null))
             pk.setCodeFreq(attr[11].stringValue());
         else
             pk.setCodeFreq("");

        if ((attr[12]!=null)&&(attr[12].stringValue()!=null))
             pk.setCodeModal(attr[12].stringValue());
        else
             pk.setCodeModal("");

        if ((attr[13]!=null)&&(attr[13].stringValue()!=null))
             pk.setTipoFlgAP(attr[13].stringValue());
        else
             pk.setTipoFlgAP("");

        if (attr[14]!=null)
           pk.setQntaShiftCanoni(attr[14].intValue());

        if ((attr[15]!=null)&&(attr[15].stringValue()!=null))
             pk.setCodeTipoContr(attr[15].stringValue());
        else
             pk.setCodeTipoContr("");

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

        cs.close();
       // Chiudo la connessione
       conn.close();
     }

                 catch(Exception lexc_Exception)
     {
       try
         {
           if (!conn.isClosed())
               conn.close();
         }
       catch (SQLException sqle)
         {
             throw new CustomException(sqle.toString(),
                                                                 "Errore nella chiusura della connessione",
                                                                         "ejbFindAll",
                                                                         this.getClass().getName(),
                                                                         StaticContext.FindExceptionType(sqle));
         }

       throw new CustomException(lexc_Exception.toString(),
                                                                         "",
                                                                         "ejbFindAll",
                                                                         this.getClass().getName(),
                                                                         StaticContext.FindExceptionType(lexc_Exception));
     }
     return recs;
    }

  public void ejbRemove() throws RemoveException, RemoteException
  {
//    //System.out.println(">>> ejbRemove");

     pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();

    try
    {
      conn = getConnection(dsName);

       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ASSOC_OFPS_X_CONTR_CANC_CLUS(?,?,?,?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,pk.getCodeContr());
      cs.setString(2,pk.getCodeOf());
      cs.setString(3,pk.getDataIniOf());
      cs.setString(4,pk.getDataIniOfPs());
      cs.setString(5,pk.getCodePs());
        cs.setString(6,pk.getCodeCluster());
        cs.setString(7,pk.getTipoCluster());
        cs.setString(8,pk.getCodeTipoContr());

      cs.registerOutParameter(9,Types.INTEGER);
      cs.registerOutParameter(10,Types.VARCHAR);

      cs.execute();

      if ((cs.getInt(9)!=DBMessage.OK_RT))//&&(cs.getInt(9)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7)+"NOME STORED: ASSOC_OFPS_X_CONTR_CANCELLA");

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
 }

 public String getCodePs()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
        return pk.getCodePs();
  }

 public String getDescPs()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getDescPs();
   }

 public String getDataIni()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getDataIni();
  }

 public String getDataFine()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getDataFine();

  }

 public String getCodeOf()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getCodeOf();

  }

 public String getDescOf()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getDescOf();
  }

 public String getDataIniOf()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getDataIniOf();

  }

 public String getDataFineOf()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getDataFineOf();

  }

 public String getCodeCOf()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getCodeCOf();
  }

 public String getDescCOf()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getDescCOf();


  }

 public String getDataIniOfPs()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getDataIniOfPs();

  }

 public String getDataFineOfPs()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getDataFineOfPs();

  }

 public String getCodeFreq()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getCodeFreq();

  }

 public String getDescFreq()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getDescFreq();

  }

 public String getCodeModal()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getCodeModal();

  }

 public String getDescModal()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getDescModal();

  }

 public String getTipoFlgAP()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getTipoFlgAP();

  }

 public int getQntaShiftCanoni()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return 0;
      else
      return pk.getQntaShiftCanoni();
  }

 public String getCodeTipoContr()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getCodeTipoContr();

  }

 public String getFlagSys()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getFlagSys();
  }

 public String getCodeContr()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getCodeContr();
  }

 public String getDescContr()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getDescContr();

  }

 public String getDataIniContr()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getDataIniContr();
  }

 public String getCodeCluster()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getCodeCluster();

  }

 public String getTipoCluster()
  {
      pk = (AssOfPsXContrBMPClusPK) ctx.getPrimaryKey();
      enableStore=false;
      if (pk==null) return null;
      else
      return pk.getTipoCluster();

  }

}