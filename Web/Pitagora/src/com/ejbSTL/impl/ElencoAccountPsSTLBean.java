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

public class ElencoAccountPsSTLBean extends AbstractSessionCommonBean implements SessionBean
{
  public Vector getElencoAccountPs(String codeElab, String flagSys) throws RemoteException, CustomException
  {
   Vector vect=new Vector();
   Connection conn=null;
   try
      {
      conn = getConnection(dsName);

        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_SENZA_PS_LST(?,?,?,?,?)}");

      // Impostazione types I/O

      cs.setString(1,codeElab);
      cs.setString(2,flagSys);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_ACC_SENZA_PS");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);

      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACC_SENZA_PS",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ClassElencoAccountPsElem elem= new ClassElencoAccountPsElem();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              if (attr[0] != null)
                  elem.setCodeAccountPs(attr[0].stringValue());
              else
                  elem.setCodeAccountPs("");
              if (attr[1] != null)
                  elem.setDescAccountPs(attr[1].stringValue());
              else
                  elem.setDescAccountPs("");
              vect.addElement(elem);
          }

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
									"getElencoAccountPs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  							"",
									"getElencoAccountPs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));

    }
    return vect;
  }


  //Aggiornamento Mario 13/09/02 inizio
  public Vector getAccCol(String CodTipoContr)throws java.rmi.RemoteException
  {


      Vector vect=new Vector();
      Connection conn=null;
      try
        {
        conn = getConnection(dsName);
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_LST(?,?,?,?)}");
        //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.ACCOUNT_LST(?,?,?,?)}");
        // Impostazione types I/O
        cs.setString(1,CodTipoContr);
        cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_ACCOUNT");
        cs.registerOutParameter(3,Types.INTEGER);
        cs.registerOutParameter(4,Types.VARCHAR);
        cs.execute();

        if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
          throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: ACCOUNT_LST");

        // Costruisco l'array che conterrà i dati di ritorno della stored
        ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT",conn);
        ARRAY rs = new ARRAY(ad, conn, null);
        // Ottengo i dati
        rs=cs.getARRAY(2);
        Datum dati[]=rs.getOracleArray();
        // Estrazione dei dati
        for (int i=0;i<dati.length;i++)
            {
                ClassElencoAccountPsElem  elem= new ClassElencoAccountPsElem();
                STRUCT s=(STRUCT)dati[i];
                Datum attr[]=s.getOracleAttributes();
                elem.setCodeAccountPs(attr[0].stringValue());
                elem.setDescAccountPs(attr[1].stringValue());
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
             StaticContext.writeLog(StaticMessages.getMessage(5002,"ElencoAccountPsStlBean","","",StaticContext.APP_SERVER_DRIVER));
             e.printStackTrace();
            throw new RemoteException(e.getMessage());
          }
         StaticMessages.setCustomString(ee.toString());
         StaticContext.writeLog(StaticMessages.getMessage(5003,"ElencoAccountStl","","",StaticContext.APP_SERVER_DRIVER));
         ee.printStackTrace();
        throw new RemoteException(ee.getMessage());

      }
      return vect;
  }

  public ClassElencoAccountPsElem findDataIniValAcc(String accountSelez)throws java.rmi.RemoteException
  //public String findDataIniValAcc(String accountSelez)throws java.rmi.RemoteException
  {


      ClassElencoAccountPsElem  elem= new ClassElencoAccountPsElem();
     String data=null;
      Connection conn=null;
      try
        {
        conn = getConnection(dsName);
        //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE.ACCOUNT_DATA_INI(?,?,?,?)}");
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_DATA_INI(?,?,?,?)}");
        // Impostazione types I/O
        cs.setString(1,accountSelez);
        cs.registerOutParameter(2,Types.VARCHAR);
        cs.registerOutParameter(3,Types.INTEGER);
        cs.registerOutParameter(4,Types.VARCHAR);

         cs.execute();

        if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
          throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: ACCOUNT_DATA_INI");

               //ClassElencoAccountPsElem elem= new ClassElencoAccountPsElem();
               elem.setDataIniValAcc(cs.getString(2));
               // data=cs.getString(2);


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
             StaticContext.writeLog(StaticMessages.getMessage(5002,"ElencoAccountPsStlBean","","",StaticContext.APP_SERVER_DRIVER));
             e.printStackTrace();
            throw new RemoteException(e.getMessage());
          }
         StaticMessages.setCustomString(ee.toString());
         StaticContext.writeLog(StaticMessages.getMessage(5003,"ElencoAccountStl","","",StaticContext.APP_SERVER_DRIVER));
         ee.printStackTrace();
        throw new RemoteException(ee.getMessage());

      }

      return elem;
      //return data;

  }

  //Mario 3/10/02 fine

  //Aggiornamento Mario 13/09/02 fine


}