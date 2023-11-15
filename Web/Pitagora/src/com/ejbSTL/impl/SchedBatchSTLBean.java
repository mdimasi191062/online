package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.*;

import java.util.*;
import java.rmi.*;
import java.sql.*;
import java.text.*;

import oracle.jdbc.*;
import oracle.sql.*;

import com.utl.*;
import java.sql.Date;

public class SchedBatchSTLBean extends AbstractSessionCommonBean implements SessionBean 
{
  public Vector getSchedBatch(String codiceFunzione, String codiceStatoSched, String codiceUtente, String data_sched, String data_ins) throws RemoteException, CustomException
  {
   Vector vect=new Vector();
   Connection conn=null;
   OracleCallableStatement cs=null;
   try
      {
      conn = getConnection(dsName);
      cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_COMMON + ".i5_6SYS_BATCH_SCHEDlista(?,?,?,?,?,?,?,?)}");
      
      // Impostazione types I/O
      
      cs.setString(1,codiceUtente);
      cs.setString(2,codiceFunzione);
      cs.setString(3,codiceStatoSched);
      cs.setString(4,data_ins);
      cs.setString(5,data_sched);
      cs.registerOutParameter(6,OracleTypes.ARRAY, "ARR_SCHED_BATCH");
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);

      cs.execute();

      if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
          throw new Exception("DB:"+cs.getInt(7)+":"+cs.getString(8));
        
      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_SCHED_BATCH",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(6);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ClassSchedBatchElem elem= new ClassSchedBatchElem();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              if (attr[0] != null)
                  elem.setIdSched(attr[0].stringValue());
              else
                  elem.setIdSched("");
              if (attr[1] != null)
                  elem.setCodeElab(attr[1].stringValue());
              else
                  elem.setCodeElab("");

              if (attr[2] != null)
                  elem.setCodeFunz(attr[2].stringValue());
              else    
                  elem.setCodeFunz("");
                  
              if (attr[3] != null)
                  elem.setDescFunz(attr[3].stringValue());
              else
                  elem.setDescFunz("");

              if (attr[4] != null)
                  elem.setCodeStatoSched(attr[4].stringValue());
              else
                  elem.setCodeStatoSched("");
                  
              if (attr[5] != null)
                  elem.setDescStatoSched(attr[5].stringValue());
              else
                  elem.setDescStatoSched("");                  
                  
              if (attr[6] != null)
                  elem.setCodeUtente(attr[6].stringValue());
              else
                  elem.setCodeUtente("");
    
              if (attr[7] != null)
                  elem.setDataOraInsSched(attr[7].stringValue());
              else
                  elem.setDataOraInsSched("");

              if (attr[8] != null)
                  elem.setDataOraSched(attr[8].stringValue());
              else
                  elem.setDataOraSched("");
                  
              vect.addElement(elem);
          }      

      // Chiudo la connessione
      cs.close();
      conn.close();
        
      }
    catch(Exception lexc_Exception)
    {
      try
        {
          if (cs != null)
            cs.close();
          if (!conn.isClosed())
              conn.close();
        }
      catch (SQLException sqle)
        {
            throw new CustomException(sqle.toString(),
	  							"Errore nella chiusura della connessione",
									"getStatiElabBatch",
									this.getClass().getName(),
									StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getStatiElabBatch",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return vect;
  }

  public ClassSchedBatchElem loadSched(String idSched) throws RemoteException,CustomException 
  {
        ClassSchedBatchElem row = null;
        CallableStatement cs = null;
        Connection dbConnection = null;
    
        try {
            javax.naming.InitialContext ic = new javax.naming.InitialContext(); 
            javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME); 
            dbConnection = dataSource.getConnection();
            
            cs = dbConnection.prepareCall("{? = call PKG_BILL_COM.i5_6SYS_BATCH_SCHEDfindbyPk(?)}");
            cs.registerOutParameter(1,OracleTypes.CURSOR);
            cs.setString(2,idSched);
            cs.execute();

            ResultSet rs = (ResultSet) cs.getObject(1);

            while (rs.next()) { 

                row = new ClassSchedBatchElem();
                
                row.setIdSched(rs.getString("ID_SCHEDULAZIONE"));
                row.setCodeUtente(rs.getString("CODE_UTENTE"));
                row.setCodeElab(rs.getString("CODE_ELAB"));
                row.setCodeFunz(rs.getString("CODE_FUNZ"));
                row.setDescFunz(rs.getString("DESC_FUNZ"));
                row.setCodeStatoSched(rs.getString("CODE_STATO_SCHED"));
                row.setDescStatoSched(rs.getString("DESC_CODE_STATO_BATCH"));
                row.setDataOraInsSched(rs.getString("DATA_INS"));
                row.setDataOraSched(rs.getString("DATA_SCHED"));
                
            } 
            rs.close();
            
        } catch (Exception e) {
            System.out.println(e.getMessage());
            throw new CustomException(e.toString(),"Errore di accesso alla tabella delle schedulazioni","loadSched","i5_6SYS_BATCH_SCHEDfindbyPk",StaticContext.FindExceptionType(e));
        } finally {
            try {
               cs.close();
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
            try {
                dbConnection.close();
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
        return row;
  }


  public String deleteSched(String idSched) throws RemoteException,CustomException
  {
        CallableStatement cs = null;
        Connection dbConnection = null;
        int ret = 0;
        String ret2 = null;
        try
        {
          javax.naming.InitialContext ic = new javax.naming.InitialContext(); 
          javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME); 
          dbConnection = dataSource.getConnection();
          
          //cs = (OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_COMMON + ".i5_6SYS_BATCH_SCHEDremove(?)}");
          cs = dbConnection.prepareCall("{? = call PKG_BILL_COM.i5_6SYS_BATCH_SCHEDremove(?)}");
          
          cs.registerOutParameter(1,OracleTypes.NUMBER);
          cs.setString(2,idSched);
          cs.execute();
          ret = cs.getInt(1);
          if (ret!=DBMessage.OK_RT)
              ret2 = "Errore";
              //throw new Exception("DB:"+ret+": Errore nella cancellazione della schedulazione con id_schedulazione = "+idSched);
        } 
        catch (Exception e) 
        {
          System.out.println(e.getMessage());
          throw new CustomException(e.toString(),"Errore di accesso alle tabelle delle schedulazioni","deleteSched","i5_6SYS_BATCH_SCHEDremove",StaticContext.FindExceptionType(e));
        } 
         finally {
          try {
             cs.close();
          } catch (Exception e) {System.out.println(e.getMessage());}
          try {
             dbConnection.close();
          } catch (Exception e) {System.out.println(e.getMessage());}
        }
        return ret2;
}


  public String updateSched(ClassSchedBatchElem el) throws RemoteException,CustomException
  {
        CallableStatement cs = null;
        Connection dbConnection = null;
        String ret = "";
        String ritorno = null;
        try 
          {
            javax.naming.InitialContext ic = new javax.naming.InitialContext(); 
            javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME); 
            dbConnection = dataSource.getConnection();

            //cs = (OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_COMMON + ".i5_6SYS_BATCH_SCHEDstore(?,?)}");
            cs = dbConnection.prepareCall("{? = call PKG_BILL_COM.i5_6SYS_BATCH_SCHEDstore(?,?)}");

            cs.registerOutParameter(1,OracleTypes.VARCHAR);
            cs.setString(2,el.getIdSched());
            cs.setString(3,el.getDataOraSched());
            cs.execute();
            ret = cs.getString(1); 

            if (ret!=null)
              ritorno = ret;
          }
          catch (Exception e) 
          {
            System.out.println(e.getMessage());
            throw new CustomException(e.toString(),"Errore di accesso alla tabella degli utenti","updateUtente","I5_6ANAG_UTENTEejbBean",StaticContext.FindExceptionType(e));
          }
           finally {
          try {
             cs.close();
          } catch (Exception e) {System.out.println(e.getMessage());}
          try {
             dbConnection.close();
          } catch (Exception e) {System.out.println(e.getMessage());}
        }
        return ritorno;
  }
}