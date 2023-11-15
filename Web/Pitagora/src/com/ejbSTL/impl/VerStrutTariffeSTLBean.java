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

public class VerStrutTariffeSTLBean extends AbstractSessionCommonBean implements SessionBean
{

  public Vector getContrXTipoContr(String CodTipoContr)throws java.rmi.RemoteException
  {
    Vector vect=new Vector();
    Connection conn=null;
    try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".CONTR_LST(?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_CONTR");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
    
      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+" NOME STORED: CONTR_LST");
    
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CONTR",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
      {
        ClassElencoContrElem  elem= new ClassElencoContrElem();
        STRUCT s=(STRUCT)dati[i];
        Datum attr[]=s.getOracleAttributes();
        elem.setCodeContr(attr[0].stringValue());
        elem.setDescContr(attr[1].stringValue());
        vect.addElement(elem);
      }
      // Chiudo la connessione
      conn.close();
    }
    catch(Throwable ee)
    {
      try
        {
          if (!conn.isClosed())
              conn.close();
        }
      catch (SQLException e)
        {
          StaticMessages.setCustomString(e.toString());
           StaticContext.writeLog(StaticMessages.getMessage(5002,"VerStrutTariffeSTLBean","","",StaticContext.APP_SERVER_DRIVER));
           e.printStackTrace();
          throw new RemoteException(e.getMessage());
        }
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"VerStrutTariffeSTL","","",StaticContext.APP_SERVER_DRIVER));
       ee.printStackTrace();
      throw new RemoteException(ee.getMessage());
    
    }
    return vect;
  }

  public Vector getPsXTipoContr(String CodTipoContr)throws java.rmi.RemoteException
  {
    Vector vect=new Vector();
    Connection conn=null;
    try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".PS_LST(?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_PS_2");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
    
      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+" NOME STORED: PS_LST");
    
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PS_2",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
      {
        ClassElencoPsElem  elem= new ClassElencoPsElem();
        STRUCT s=(STRUCT)dati[i];
        Datum attr[]=s.getOracleAttributes();
        elem.setCode_ps(attr[0].stringValue());
        elem.setDesc_es_ps(attr[1].stringValue());
        vect.addElement(elem);
      }
      // Chiudo la connessione
      conn.close();
    }
    catch(Throwable ee)
    {
      try
        {
          if (!conn.isClosed())
              conn.close();
        }
      catch (SQLException e)
        {
          StaticMessages.setCustomString(e.toString());
           StaticContext.writeLog(StaticMessages.getMessage(5002,"VerStrutTariffeSTLBean","","",StaticContext.APP_SERVER_DRIVER));
           e.printStackTrace();
          throw new RemoteException(e.getMessage());
        }
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"VerStrutTariffeSTL","","",StaticContext.APP_SERVER_DRIVER));
       ee.printStackTrace();
      throw new RemoteException(ee.getMessage());
    
    }
    return vect;
  }

  public Vector getOggFatrzXTipoContr(String CodTipoContr)throws java.rmi.RemoteException
  {
    Vector vect=new Vector();
    Connection conn=null;
    try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".OGG_FATRZ_LST(?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_OGG_FATRZ");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
    
      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+" NOME STORED: OGG_FATRZ_LST");
    
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_OGG_FATRZ",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
      {
        ClassElencoOggFatrzElem  elem= new ClassElencoOggFatrzElem();
        STRUCT s=(STRUCT)dati[i];
        Datum attr[]=s.getOracleAttributes();
        elem.setCode_ogg_fatrz(attr[0].stringValue());
        elem.setDesc_ogg_fatrz(attr[1].stringValue());
        vect.addElement(elem);
      }
      // Chiudo la connessione
      conn.close();
    }
    catch(Throwable ee)
    {
      try
        {
          if (!conn.isClosed())
              conn.close();
        }
      catch (SQLException e)
        {
          StaticMessages.setCustomString(e.toString());
           StaticContext.writeLog(StaticMessages.getMessage(5002,"VerStrutTariffeSTLBean","","",StaticContext.APP_SERVER_DRIVER));
           e.printStackTrace();
          throw new RemoteException(e.getMessage());
        }
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"VerStrutTariffeSTL","","",StaticContext.APP_SERVER_DRIVER));
       ee.printStackTrace();
      throw new RemoteException(ee.getMessage());
    
    }
    return vect;
  }

  public Vector getCausaliXTipoContr(String CodTipoContr,String code_ogg_fatrz)throws java.rmi.RemoteException
  {
    Vector vect=new Vector();
    Connection conn=null;
    try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".CAUSALI_LST(?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.setString(2,code_ogg_fatrz);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_CAUSALI");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
    
      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5)+" NOME STORED: CAUSALI_LST");
    
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_CAUSALI",conn);
      ARRAY rs = new ARRAY(ad, conn, null);
      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
      {
        ClassElencoCausaliElem  elem= new ClassElencoCausaliElem();
        STRUCT s=(STRUCT)dati[i];
        Datum attr[]=s.getOracleAttributes();
        elem.setCode_tipo_caus_fatt(attr[0].stringValue());
        elem.setDesc_tipo_caus_fatt(attr[1].stringValue());
        vect.addElement(elem);
      }
      // Chiudo la connessione
      conn.close();
    }
    catch(Throwable ee)
    {
      try
        {
          if (!conn.isClosed())
              conn.close();
        }
      catch (SQLException e)
        {
          StaticMessages.setCustomString(e.toString());
           StaticContext.writeLog(StaticMessages.getMessage(5002,"VerStrutTariffeSTLBean","","",StaticContext.APP_SERVER_DRIVER));
           e.printStackTrace();
          throw new RemoteException(e.getMessage());
        }
       StaticMessages.setCustomString(ee.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5003,"VerStrutTariffeSTL","","",StaticContext.APP_SERVER_DRIVER));
       ee.printStackTrace();
      throw new RemoteException(ee.getMessage());
    
    }
    return vect;
  }

}