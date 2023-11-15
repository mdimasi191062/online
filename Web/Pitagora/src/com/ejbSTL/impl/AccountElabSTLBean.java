package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.*;
import java.util.*;
import java.rmi.*;
import java.sql.*;
import oracle.jdbc.*;
import oracle.sql.*;
import com.utl.*;
import java.util.Vector;
import java.rmi.RemoteException;

public class AccountElabSTLBean  extends AbstractSessionCommonBean implements SessionBean
{
  public Vector getLstAcc(String CodeElab) throws CustomException, RemoteException
  {
   Vector vect=new Vector();
   //Connection conn=null;
   try
      {
       conn = getConnection(dsName);
//       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_LST_X_VER_VA(?,?,?,?,?,?)}");
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".ACCOUNT_LST_X_VER_VA_2(?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodeElab);
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.VARCHAR);
      //cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_ACC_X_VER_VA");
      cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_ACC_X_VER_VA_2");
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6));

      // Costruisco l'array che conterrà i dati di ritorno della stored
      //ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACC_X_VER_VA",conn);
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACC_X_VER_VA_2",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(4);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              LstAccElabElem  elem= new LstAccElabElem();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              if(attr[1]!=null) elem.setCodeAccount(attr[1].stringValue());
              if(attr[2]!=null) elem.setAccount(attr[2].stringValue());
              if(attr[3]!=null) 
                 elem.setDataIni(attr[3].stringValue());
              else
                 elem.setDataIni("");
              if(attr[4]!=null) 
                 elem.setDataFine(attr[4].stringValue());
              else
                 elem.setDataFine("");
              if(attr[5]!=null) 
                 elem.setScarti(attr[5].intValue());
              if(attr[6]!=null) 
                 elem.setFlagErrore(attr[6].stringValue());
              else
                 elem.setFlagErrore("");
              /*eventuale stato report*/
              if(attr[7]!=null) 
                 elem.setFlagErroreReport(attr[7].stringValue());
              else
                 elem.setFlagErroreReport("");
              if(cs.getString(2)!=null) elem.setCicloIni(cs.getString(2));
              if(cs.getString(3)!=null) elem.setCicloFine(cs.getString(3));
              vect.addElement(elem);
          }
      cs.close();
      // Chiudo la connessione
      conn.close();
      }
catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getLstAcc",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
    return vect;
  }
  
  public Vector getLstAccNC(String CodeElab, String TipoContr) throws CustomException, RemoteException
  {
   Vector vect=new Vector();
   //Connection conn=null;
   try
      {

       conn = getConnection(dsName);
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_LST_X_VER_NC(?,?,?,?,?)}");

      // Impostazione types I/O

      cs.setString(1,CodeElab);
      cs.setString(2,TipoContr);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_ACC_X_VER_NC");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);

      cs.execute();


      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));


      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACC_X_VER_NC",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati

      for (int i=0;i<dati.length;i++)
          {
              LstAccElabElem  elem= new LstAccElabElem();

              STRUCT s=(STRUCT)dati[i];

              Datum attr[]=s.getOracleAttributes();
              elem.setCodeParam(attr[0].stringValue());
              elem.setCodeAccount(attr[1].stringValue());
              elem.setAccount(attr[2].stringValue());
              if(attr[3]!=null)
                elem.setDataIni(attr[3].stringValue());
              else
                elem.setDataIni("");
              if(attr[4]!=null)
              elem.setDataFine(attr[4].stringValue());
              else
                elem.setDataFine("");
              elem.setScarti(attr[5].intValue());
              elem.setFlagErrore(attr[6].stringValue());
              elem.setNumNC(attr[7].intValue());
            
              vect.addElement(elem);

          }
      cs.close();
      // Chiudo la connessione
      conn.close();
      }
catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getLstAccNC",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
    return vect;
  }
  public Vector getLstAccRepricing(String CodeElab, String TipoContr, String flagTipoContr) throws CustomException, RemoteException
  {
   Vector vect=new Vector();
   //Connection conn=null;
   try
      {

       conn = getConnection(dsName);
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_LST_X_VER_RPC(?,?,?,?,?,?)}");

      // Impostazione types I/O

      cs.setString(1,CodeElab);
      cs.setString(2,TipoContr);
      cs.setString(3,flagTipoContr);
      cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_ACC_X_VER_NC");
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);

      cs.execute();


      if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6));


      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACC_X_VER_NC",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(4);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati

      for (int i=0;i<dati.length;i++)
          {
              LstAccElabElem  elem= new LstAccElabElem();

              STRUCT s=(STRUCT)dati[i];

              Datum attr[]=s.getOracleAttributes();
              elem.setCodeParam(attr[0].stringValue());
              elem.setCodeAccount(attr[1].stringValue());
              elem.setAccount(attr[2].stringValue());
              if(attr[3]!=null)
                elem.setDataIni(attr[3].stringValue());
              else
                elem.setDataIni("");
              if(attr[4]!=null)
              elem.setDataFine(attr[4].stringValue());
              else
                elem.setDataFine("");
              elem.setScarti(attr[5].intValue());
              elem.setFlagErrore(attr[6].stringValue());
              elem.setNumNC(attr[7].intValue());
            
              vect.addElement(elem);

          }
      cs.close();
      // Chiudo la connessione
      conn.close();
      }
catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getLstAccNC",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
    return vect;
  }

  public Vector getLstAccRepricingSpecial(String TipoContr) throws CustomException, RemoteException
  {
   Vector vect=new Vector();
   //Connection conn=null;
   try
      {

       conn = getConnection(dsName);
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_LST_X_VER_RPC_SPE(?,?,?,?)}");

      // Impostazione types I/O

    
      cs.setString(1,TipoContr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_ACC_X_VER_NC");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
    

      cs.execute();


      

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACC_X_VER_NC",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati

      for (int i=0;i<dati.length;i++)
          {
              LstAccElabElem  elem= new LstAccElabElem();

              STRUCT s=(STRUCT)dati[i];

              Datum attr[]=s.getOracleAttributes();
              elem.setCodeParam(attr[0].stringValue());
              elem.setCodeAccount(attr[1].stringValue());
              elem.setAccount(attr[2].stringValue());
 
              vect.addElement(elem);

          }
      cs.close();
      // Chiudo la connessione
      conn.close();
      }
catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getLstAccREP",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
    return vect;
  }


  public Vector getLstAccXCongRepricing(String CodeElab) throws CustomException, RemoteException
  {
   Vector vect=new Vector();
   //Connection conn=null;
   try
      {
       conn = getConnection(dsName);
//       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_ACC_2_LIS_REP_XDSL(?,?,?,?)}");
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".PARAM_VALO_ACC_2_LIS_REP_XDSL(?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodeElab);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_ACC_X_VER_VA_2");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACC_X_VER_VA_2",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              LstAccElabElem  elem= new LstAccElabElem();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              if(attr[0] != null)
                elem.setCodeParam(attr[0].stringValue());
              else
                elem.setCodeParam("");
                
              if(attr[1] != null)
                elem.setCodeAccount(attr[1].stringValue());
              else
                elem.setCodeAccount("");
                
              if(attr[2] != null)
                elem.setAccount(attr[2].stringValue());
              else
                elem.setAccount("");
                
              if(attr[6] != null)
                elem.setFlagErrore(attr[6].stringValue());
              else
                elem.setFlagErrore("");

              if(attr[7] != null)
                elem.setFlagErroreReport(attr[7].stringValue());
              else
                elem.setFlagErroreReport("");
                
              vect.addElement(elem);
          }
      cs.close();
      // Chiudo la connessione
      conn.close();
      }
catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getLstAccXCongRepricing",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
    return vect;
  }

  public boolean controllaAccountRepricing(String CodeTipoContr) throws CustomException, RemoteException
  {
       try
      {
       conn = getConnection(dsName);
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CONTROLLO_ACC_REPR_SPE(?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodeTipoContr);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));
        int nTestate=cs.getInt(2);
      cs.close();
      // Chiudo la connessione
      conn.close();
      return nTestate==0;
      }
      catch(Exception lexc_Exception)
      {
          throw new CustomException(lexc_Exception.toString(),
                          "",
                        "getLstAcc",
                        this.getClass().getName(),
                        StaticContext.FindExceptionType(lexc_Exception));
      }

  }

  public Vector getLstAccReport(String CodeElab) throws CustomException, RemoteException
  {
   Vector vect=new Vector();
   //Connection conn=null;
   try
      {
       conn = getConnection(dsName);
       OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".ACCOUNT_LST_X_VER_REPORT(?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodeElab);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_ACC_X_VER_VA_2");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

      // Costruisco l'array che conterrà i dati di ritorno della stored
      //ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACC_X_VER_VA",conn);
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACC_X_VER_VA_2",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
      {
          LstAccElabElem  elem= new LstAccElabElem();
          STRUCT s=(STRUCT)dati[i];
          Datum attr[]=s.getOracleAttributes();
          if(attr[0]!=null) elem.setCodeParam(attr[0].stringValue());
          if(attr[1]!=null) elem.setCodeAccount(attr[1].stringValue());
          if(attr[2]!=null) elem.setAccount(attr[2].stringValue());
          if(attr[3]!=null) 
             elem.setDataIni(attr[3].stringValue());
          else
             elem.setDataIni("");
          if(attr[4]!=null) 
             elem.setDataFine(attr[4].stringValue());
          else
             elem.setDataFine("");
          if(attr[6]!=null) 
             elem.setFlagErrore(attr[6].stringValue());
          else
             elem.setFlagErrore("");

          vect.addElement(elem);
      }
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
                    "getLstAccReport",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }

  /* Elenco servizi special da congelare *
   * tipo_batch = V valorizzazione
   *           = R repricing */
  public Vector getLstServiziDaCongelare(String tipo_batch) throws CustomException, RemoteException
  {
    Vector vect=new Vector();
    try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".SERVIZI_LST_X_CONG_SP(?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,tipo_batch);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_ACC_X_VER_VA_2");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACC_X_VER_VA_2",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
      {
        LstCodeTipoContrElem  elem= new LstCodeTipoContrElem();
        STRUCT s=(STRUCT)dati[i];
        Datum attr[]=s.getOracleAttributes();
        if(attr[1]!=null) elem.setCodeTipoContr(attr[1].stringValue());
        if(attr[2]!=null) elem.setDescTipoContr(attr[2].stringValue());
        vect.addElement(elem);
      }
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(),
                "",
                "getLstServiziDaCongelare",
                this.getClass().getName(),
                StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }

  public Vector getLstAccCongSpecial(String code_elab) throws CustomException, RemoteException
  {
    Vector vect=new Vector();
    //Connection conn=null;
    try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".ACCOUNT_LST_X_CONG_SPE(?,?,?,?)}");

      // Impostazione types I/O    
      cs.setString(1,code_elab);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_ACC_X_VER_VA_2");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);

      cs.execute();

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACC_X_VER_VA_2",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
      {
        LstAccElabElem  elem= new LstAccElabElem();

        STRUCT s=(STRUCT)dati[i];

        Datum attr[]=s.getOracleAttributes();
        if(attr[0] != null)
          elem.setCodeParam(Misc.nh(attr[0].stringValue()));
        else
          elem.setCodeParam("");

        if(attr[1] != null)
          elem.setCodeAccount(Misc.nh(attr[1].stringValue()));
        else
          elem.setCodeAccount("");
          
        if(attr[2] != null)
          elem.setAccount(Misc.nh(attr[2].stringValue()));
        else
          elem.setAccount("");
        
        if(attr[3] != null)
          elem.setDataIni(Misc.nh(attr[3].stringValue()));
        else
          elem.setDataIni("");
          
        if(attr[4] != null)
          elem.setDataFine(Misc.nh(attr[4].stringValue()));
        else
          elem.setDataFine("");
        
        if(attr[5] != null)
          elem.setFlagErrore(Misc.nh(attr[5].stringValue()));
        else
          elem.setFlagErrore("");
        
        vect.addElement(elem);

      }
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(),
	  							"",
									"getLstAccCongSpecial",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }

  public Vector getLstAccLanCongSpecial(String code_tipo_contr) throws CustomException, RemoteException
  {
    Vector vect=new Vector();
    //Connection conn=null;
    try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".ACCOUNT_LST_X_LAN_CONG_SPE(?,?,?,?)}");

      // Impostazione types I/O    
      cs.setString(1,code_tipo_contr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_ACC_X_VER_VA_2");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);

      cs.execute();

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACC_X_VER_VA_2",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
      {
        LstAccElabElem  elem= new LstAccElabElem();

        STRUCT s=(STRUCT)dati[i];

        Datum attr[]=s.getOracleAttributes();
        elem.setCodeParam(Misc.nh(attr[0].stringValue()));
        elem.setCodeAccount(Misc.nh(attr[1].stringValue()));
        elem.setDataIni(Misc.nh(attr[3].stringValue()));

        vect.addElement(elem);

      }
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(),
	  							"",
									"getLstAccCongSpecial",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }

  public Vector getLstServiziResocontoSap(String tipo_sistema) throws CustomException, RemoteException
  {
    Vector vect=new Vector();
    try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".RESOCONTO_SAP_GETSERVIZI(?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,tipo_sistema);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_ACC_X_VER_VA_2");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACC_X_VER_VA_2",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
      {
        LstCodeTipoContrElem  elem= new LstCodeTipoContrElem();
        STRUCT s=(STRUCT)dati[i];
        Datum attr[]=s.getOracleAttributes();
        if(attr[1]!=null) elem.setCodeTipoContr(attr[1].stringValue());
        if(attr[2]!=null) elem.setDescTipoContr(attr[2].stringValue());
        vect.addElement(elem);
      }
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(),
                "",
                "getLstServiziDaCongelare",
                this.getClass().getName(),
                StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }

}