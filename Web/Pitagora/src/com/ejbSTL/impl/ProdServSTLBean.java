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


public class ProdServSTLBean extends AbstractSessionCommonBean implements SessionBean
{

public Vector getPsTar(String CodTipoContr) throws RemoteException, CustomException
{
    Vector vect=new Vector();
    Connection conn=null;
    try
      {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PS_LST_X_INS_TARIFFE(?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_PS");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PS",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ProdServElem  elem= new ProdServElem();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              elem.setCodePs(attr[0].stringValue());
              elem.setDescPs(attr[1].stringValue());
              vect.addElement(elem);
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
									"getPsTar",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPsTar",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
}

public Vector getPsTar(String CodTipoContr,String strRicerca) throws RemoteException, CustomException
{
    Vector vect=new Vector();
    Connection conn=null;
    try
      {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PS_LST_X_INS_TARIFFE_RICERCA(?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.setString(2,strRicerca);

      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_PS");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PS",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ProdServElem  elem= new ProdServElem();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              elem.setCodePs(attr[0].stringValue());
              elem.setDescPs(attr[1].stringValue());
              vect.addElement(elem);
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
									"getPsTarRicerca",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPsTarRicerca",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
}



public Vector getPs(String CodTipoContr) throws RemoteException, CustomException
    {
    Vector vect=new Vector();

    Connection conn=null;
    try
      {

      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PS_LST_CON_TARIFFE(?,?,?,?)}");


      // Impostazione types I/O
      cs.setString(1,CodTipoContr);

      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_PS");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);

      cs.execute();
      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PS",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ProdServElem  elem= new ProdServElem();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setCodePs(attr[0].stringValue());
              elem.setDescPs(attr[1].stringValue());

              vect.addElement(elem);
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
									"getPs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }


//Aggiornamento Mario 13/09/02 inizio
//Nicola 13/09/02 inizio
public Vector getPsAssOfPs(String CodTipoContr) throws RemoteException, CustomException
    {
    Vector vect=new Vector();

    Connection conn=null;
    try
      {

      conn = getConnection(dsName);
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_NICOLA.PS_LST_PER_ASS_OFPS(?,?,?,?)}");
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+ StaticContext.PACKAGE_SPECIAL  +".PS_LST_PER_ASS_OFPS(?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodTipoContr);

      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_PS");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);

      cs.execute();
      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PS",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ProdServElem  elem= new ProdServElem();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setCodePs(attr[0].stringValue());
              elem.setDescPs(attr[1].stringValue());

              vect.addElement(elem);
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
									"getPsAssOfPs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPsAssOfPs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }
//Nicola 13/09/02 fine

// Dario -inizio
//Caricamento della lista su NuovaCol.jsp
public Vector getPsUmQta(String CodTipoCol,String CodeSito,String CodeAccount) throws RemoteException, CustomException
    {
    Vector vect=new Vector();
    vect = getPsUm(CodTipoCol);
    Object[] objs=vect.toArray();

    for (int i=0;i<vect.size();i++)
      {
          ProdServElem obj=(ProdServElem)objs[i];
//         //System.out.println(obj.getDescPs());
//         //System.out.println(obj.getCodePs());
          obj.setQtaPs(getPsQta(CodeSito,CodeAccount,obj.getCodePs())) ;
      }
    return vect;
  }

//MMM 24/10/02
//private int getPsQta(String CodeSito,String CodeAccount,String CodePs) throws RemoteException, CustomException
private Double getPsQta(String CodeSito,String CodeAccount,String CodePs) throws RemoteException, CustomException
{
    //MMM 24/10/02 inizio
      //int qta=-1;
      Double qta=new Double(-1);
    //MMM 24/10/02 fine
    Connection conn=null;
    try
      {

      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".INVENT_PS_SP_LEGGI_QNTA(?,?,?,?,?,?)}");
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.INVENT_PS_SP_LEGGI_QNTA(?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodeSito);
      cs.setString(2,CodeAccount);
      cs.setString(3,CodePs);

      //MMM 24/10/02 inizio
        //cs.registerOutParameter(4,Types.INTEGER);
        cs.registerOutParameter(4,Types.DOUBLE);
      //MMM 24/10/02 fine  
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);

      cs.execute();
      
      if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6));
      if ((cs.getInt(5)==DBMessage.NOT_FOUND_RT))
      //MMM 24/10/02 inizio
          //qta=-1;
          qta=new Double(-1);
      //MMM 24/10/02 fine    
      else
      //MMM 24/10/02 inizio
         //qta = cs.getInt(4);
         qta = new Double(cs.getDouble(4));
      //MMM 24/10/02 fine  

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
									"getPsQta",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPsQTa",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return qta;
}

//Aggiornamento Mario 13/09/02 fine

// Dario - fine



// Caricamento della lista dei PS da Lista Tariffe per Conntratto
public Vector getPsXContr(String CodContr) throws RemoteException, CustomException
    {
    Vector vect=new Vector();
    Connection conn=null;
    //System.out.println("Caricamento della lista dei PS da Lista Tariffe per Conntratto");
    try
      {

      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PS_LST_CON_TAR_PERS(?,?,?,?)}");
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_ROSA.PS_LST_CON_TAR_PERS(?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodContr);

      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_PS");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);

      cs.execute();
      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PS",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ProdServElem  elem= new ProdServElem();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setCodePs(attr[0].stringValue());
//             //System.out.println("elem.setCodePs "+attr[0].stringValue());
              elem.setDescPs(attr[1].stringValue());
              //System.out.println("elem.setDescPs "+attr[1].stringValue());

              vect.addElement(elem);
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
									"getPsXContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPsXContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }
//11/09/02 fine



//Caricamento della lista su NuovaCol.jsp
public Vector getPsUm(String CodTipoCol) throws RemoteException, CustomException
    {
    Vector vect=new Vector();
    Connection conn=null;
//   //System.out.println("Caricamento della lista su NuovaCol.jsp");
    try
      {

      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PS_X_TIPO_COLOC_LST(?,?,?,?)}");
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_MARIO.PS_X_TIPO_COLOC_LST(?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodTipoCol);

      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_PS");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);

      cs.execute();
      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PS",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ProdServElem  elem= new ProdServElem();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              elem.setCodePs(attr[0].stringValue());
              elem.setDescPs(attr[1].stringValue());
              vect.addElement(elem);
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
									"getPsUm",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPsUm",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }
//Aggiornamento Mario 13/09/02 fine


//GIANLUCA-26/09/2002-INIZIO
// Caricamento della lista dei PS da Lista Tariffe per Conntratto
public Vector getPsXContrIns(String TipoContr,String CodContr) throws RemoteException, CustomException
    {
    Vector vect=new Vector();
    Connection conn=null;

    try
      {

      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PS_LST_X_INS_TAR_X_CONTR(?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,TipoContr);
      cs.setString(2,CodContr);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_PS");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);

      cs.execute();
      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PS",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ProdServElem  elem= new ProdServElem();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setCodePs(attr[0].stringValue());
//             //System.out.println("elem.setCodePs "+attr[0].stringValue());
              elem.setDescPs(attr[1].stringValue());
//             //System.out.println("elem.setDescPs "+attr[1].stringValue());

              vect.addElement(elem);
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
									"getPsXContrIns",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPsXContrIns",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }
//11/09/02 fine

//GIANLUCA-26/09/2002-FINE


 
    public Vector getPsXContrClusIns(String TipoContr,String CodContr, String codeCluster, String tipoCluster) throws RemoteException, CustomException
        {
        Vector vect=new Vector();
        Connection conn=null;

        try
          {

          conn = getConnection(dsName);
          OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PS_LST_X_INS_TAR_X_CONTR_CLUS(?,?,?,?,?,?,?)}");
          // Impostazione types I/O
          cs.setString(1,TipoContr);
          cs.setString(2,CodContr);
              cs.setString(3,codeCluster);
              cs.setString(4,tipoCluster);
          cs.registerOutParameter(5,OracleTypes.ARRAY, "ARR_PS");
          cs.registerOutParameter(6,Types.INTEGER);
          cs.registerOutParameter(7,Types.VARCHAR);

          cs.execute();
          if ((cs.getInt(6)!=DBMessage.OK_RT)&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
            throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7));
          // Costruisco l'array che conterrà i dati di ritorno della stored
          ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PS",conn);
          ARRAY rs = new ARRAY(ad, conn, null);

          // Ottengo i dati
          rs=cs.getARRAY(5);
          Datum dati[]=rs.getOracleArray();

          // Estrazione dei dati
          for (int i=0;i<dati.length;i++)
              {
                  ProdServElem  elem= new ProdServElem();

                  STRUCT s=(STRUCT)dati[i];
                  Datum attr[]=s.getOracleAttributes();

                  elem.setCodePs(attr[0].stringValue());
    //             //System.out.println("elem.setCodePs "+attr[0].stringValue());
                  elem.setDescPs(attr[1].stringValue());
    //             //System.out.println("elem.setDescPs "+attr[1].stringValue());

                  vect.addElement(elem);
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
                                                                            "getPsXContrIns",
                                                                            this.getClass().getName(),
                                                                            StaticContext.FindExceptionType(sqle));
            }

          throw new CustomException(lexc_Exception.toString(),
                                                                            "",
                                                                            "getPsXContrIns",
                                                                            this.getClass().getName(),
                                                                            StaticContext.FindExceptionType(lexc_Exception));
        }
        return vect;
      }

//Tommaso inizio 09/10/2002
public ProdServElem getDataIni(String CodPs) throws RemoteException, CustomException
{
    ProdServElem data = new ProdServElem();
    Connection conn=null;
    try
      {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PS_MAX_DATA_INI(?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodPs);
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));
        

      // Estrazione dei dati
       data.setDataIni(cs.getString(2));

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
									"getDataIni",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDataIni",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return data;
}
//Tommaso fine 09/10/2002

//Martino 28/08/2006
public Vector getPsAssOfPs(String CodTipoContr,String strPsRicerca)  throws RemoteException, CustomException
    {
    Vector vect=new Vector();

    Connection conn=null;
    try
      {

      conn = getConnection(dsName);
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_NICOLA.PS_LST_PER_ASS_OFPS(?,?,?,?)}");
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call "+ StaticContext.PACKAGE_SPECIAL  +".PS_LST_PER_ASS_OFPS_RICERCA(?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.setString(2,strPsRicerca);

      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_PS");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);

      cs.execute();
      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PS",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ProdServElem  elem= new ProdServElem();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setCodePs(attr[0].stringValue());
              elem.setDescPs(attr[1].stringValue());

              vect.addElement(elem);
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
									"getPsAssOfPs Ricerca",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPsAssOfPs Ricerca",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }

public Vector getPsXContrIns(String TipoContr,String CodContr,String strRicerca) throws RemoteException, CustomException
    {
    Vector vect=new Vector();
    Connection conn=null;

    try
      {

      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PS_LST_X_INS_TAR_X_CONTR_RIC(?,?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,TipoContr);
      cs.setString(2,CodContr);
      cs.setString(3,strRicerca);
      
      cs.registerOutParameter(4,OracleTypes.ARRAY, "ARR_PS");
      cs.registerOutParameter(5,Types.INTEGER);
      cs.registerOutParameter(6,Types.VARCHAR);

      cs.execute();
      if ((cs.getInt(5)!=DBMessage.OK_RT)&&(cs.getInt(5)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(5)+":"+cs.getString(6));
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PS",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(4);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ProdServElem  elem= new ProdServElem();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setCodePs(attr[0].stringValue());
//             //System.out.println("elem.setCodePs "+attr[0].stringValue());
              elem.setDescPs(attr[1].stringValue());
//             //System.out.println("elem.setDescPs "+attr[1].stringValue());

              vect.addElement(elem);
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
									"getPsXContrIns Ricerca",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPsXContrIns Ricerca",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }


// Caricamento della lista dei PS da Lista Tariffe per Conntratto
public Vector getPsXContr(String CodContr, String strRicerca) throws RemoteException, CustomException
    {
    Vector vect=new Vector();
    Connection conn=null;
    //System.out.println("Caricamento della lista dei PS da Lista Tariffe per Conntratto");
    try
      {

      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PS_LST_CON_TAR_PERS_RIC(?,?,?,?,?)}");
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_ROSA.PS_LST_CON_TAR_PERS(?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodContr);
      cs.setString(2,strRicerca);

      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_PS");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);

      cs.execute();
      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PS",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ProdServElem  elem= new ProdServElem();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setCodePs(attr[0].stringValue());
//             //System.out.println("elem.setCodePs "+attr[0].stringValue());
              elem.setDescPs(attr[1].stringValue());
              //System.out.println("elem.setDescPs "+attr[1].stringValue());

              vect.addElement(elem);
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
									"getPsXContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPsXContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }

public Vector getPs(String CodTipoContr, String strPsRicerca) throws RemoteException, CustomException
    {
    Vector vect=new Vector();

    Connection conn=null;
    try
      {

      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PS_LST_CON_TARIFFE_RIC(?,?,?,?,?)}");


      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.setString(2,strPsRicerca);

      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_PS");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);

      cs.execute();
      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PS",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ProdServElem  elem= new ProdServElem();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setCodePs(attr[0].stringValue());
              elem.setDescPs(attr[1].stringValue());

              vect.addElement(elem);
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
									"getPs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }



  
//11/09/02 fine

}