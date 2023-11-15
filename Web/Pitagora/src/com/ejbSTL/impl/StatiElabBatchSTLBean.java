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

import javax.ejb.FinderException;

public class StatiElabBatchSTLBean extends AbstractSessionCommonBean implements SessionBean 
{
  public Vector getStatiElabBatch(String codiceFunzione, String codiceStatoBatch, String codiceUtente, String data_da, String data_a) throws RemoteException, CustomException
  {
   Vector vect=new Vector();
   Connection conn=null;
   try
      {
      conn = getConnection(dsName);
     
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ELAB_BATCH_LISTA(?,?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      
      cs.setString(1,codiceFunzione);
      cs.setString(2,codiceStatoBatch);
      cs.setString(3,codiceUtente);
      cs.setString(4,data_da);
      cs.setString(5,data_a);
      cs.registerOutParameter(6,OracleTypes.ARRAY, "ARR_ELAB_BATCH");
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);

      cs.execute();

      if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
          throw new Exception("DB:"+cs.getInt(7)+":"+cs.getString(8));
        
      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ELAB_BATCH",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(6);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ClassStatiElabBatchElem elem= new ClassStatiElabBatchElem();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              if (attr[0] != null)
                  elem.setCodeElab(attr[0].stringValue());
              else
                  elem.setCodeElab("");
              if (attr[1] != null)
                  elem.setFlagSys(attr[1].stringValue());
              else    
                  elem.setFlagSys("");
              if (attr[2] != null)
                  elem.setCodeFunz(attr[2].stringValue());
              else    
                  elem.setCodeFunz("");
              if (attr[3] != null)
                  elem.setDescFunz(attr[3].stringValue());
              else
                  elem.setDescFunz("");
              if (attr[4] != null)
                  elem.setCodeStato(attr[4].stringValue());
              else
                  elem.setCodeStato("");
              if (attr[5] != null)
                  elem.setDescStato(attr[5].stringValue());
              else
                  elem.setDescStato("");
              if (attr[6] != null)
                  elem.setCodeUtente(attr[6].stringValue());
              else
                  elem.setCodeUtente("");
              if (attr[7] != null)
                  elem.setDataOraIniBatch(attr[7].stringValue());
              else
                  elem.setDataOraIniBatch("");
              if (attr[8] != null)
                  elem.setEsitoBatch(attr[8].stringValue());
              else    
                  elem.setEsitoBatch("");
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

  public Vector getStatiElabBatchImportFile(String codiceFunzione, String codiceStatoBatch, String codiceUtente, String data_da, String data_a) throws RemoteException, CustomException
  {
   Vector vect=new Vector();
   Connection conn=null;
   try
      {
      conn = getConnection(dsName);
     
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ELAB_BATCH_LISTA_IMPORT_FILE(?,?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      
      cs.setString(1,codiceFunzione);
      cs.setString(2,codiceStatoBatch);
      cs.setString(3,codiceUtente);
      cs.setString(4,data_da);
      cs.setString(5,data_a);
      cs.registerOutParameter(6,OracleTypes.ARRAY, "ARR_ELAB_BATCH");
      cs.registerOutParameter(7,Types.INTEGER);
      cs.registerOutParameter(8,Types.VARCHAR);

      cs.execute();

      if ((cs.getInt(7)!=DBMessage.OK_RT)&&(cs.getInt(7)!=DBMessage.NOT_FOUND_RT))
          throw new Exception("DB:"+cs.getInt(7)+":"+cs.getString(8));
        
      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ELAB_BATCH",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(6);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              ClassStatiElabBatchElem elem= new ClassStatiElabBatchElem();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              if (attr[0] != null)
                  elem.setCodeElab(attr[0].stringValue());
              else
                  elem.setCodeElab("");
              if (attr[1] != null)
                  elem.setFlagSys(attr[1].stringValue());
              else    
                  elem.setFlagSys("");
              if (attr[2] != null)
                  elem.setCodeFunz(attr[2].stringValue());
              else    
                  elem.setCodeFunz("");
              if (attr[3] != null)
                  elem.setDescFunz(attr[3].stringValue());
              else
                  elem.setDescFunz("");
              if (attr[4] != null)
                  elem.setCodeStato(attr[4].stringValue());
              else
                  elem.setCodeStato("");
              if (attr[5] != null)
                  elem.setDescStato(attr[5].stringValue());
              else
                  elem.setDescStato("");
              if (attr[6] != null)
                  elem.setCodeUtente(attr[6].stringValue());
              else
                  elem.setCodeUtente("");
              if (attr[7] != null)
                  elem.setDataOraIniBatch(attr[7].stringValue());
              else
                  elem.setDataOraIniBatch("");
              if (attr[8] != null)
                  elem.setEsitoBatch(attr[8].stringValue());
              else    
                  elem.setEsitoBatch("");
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

  public Vector getElencoScartiImportFile(String codiceElab) throws RemoteException, CustomException
  {
   Vector vect=new Vector();
   Connection conn=null;
   try
      {
      conn = getConnection(dsName);

        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".SCARTI_IMPORT_FILE(?,?,?,?)}");

      // Impostazione types I/O

      cs.setString(1,codiceElab);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_ELAB_UPL_FILES");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);

      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ELAB_UPL_FILES",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      if (rs != null)
      {
        Datum dati[]=rs.getOracleArray();
        // Estrazione dei dati
        for (int i=0;i<dati.length;i++)
        {
          I5_6ELAB_UPL_FILES_ROW elem= new I5_6ELAB_UPL_FILES_ROW();

          STRUCT s=(STRUCT)dati[i];
          Datum attr[]=s.getOracleAttributes();

          if (attr[0] != null)
              elem.setCODE_ELAB_UPL(attr[0].stringValue());
          else
              elem.setCODE_ELAB_UPL("");
                  
          if (attr[1] != null)
              elem.setCODE_ELAB(attr[1].stringValue());
          else
              elem.setCODE_ELAB("");
                  
          if (attr[2] != null)
              elem.setCODE_FUNZ(attr[2].stringValue());
          else
              elem.setCODE_FUNZ("");
                  
          if (attr[3] != null)
              elem.setCODE_STATO_BATCH(attr[3].stringValue());
          else
              elem.setCODE_STATO_BATCH("");

          if (attr[4] != null)
              elem.setCODE_UTENTE(attr[4].stringValue());
          else
              elem.setCODE_UTENTE("");

          if (attr[5] != null)
              elem.setNUM_RIGA_ELAB(attr[5].stringValue());
          else
              elem.setNUM_RIGA_ELAB("");

          if (attr[6] != null)
              elem.setDESC_ERROR(attr[6].stringValue());
          else
              elem.setDESC_ERROR("");
          
            if (attr[7] != null)
                elem.setFILE_DOWNLOAD(attr[7].stringValue());
            else
                elem.setFILE_DOWNLOAD("");
          
            
              
          vect.addElement(elem);

        }
      }
      else
      {
        I5_6ELAB_UPL_FILES_ROW elem= new I5_6ELAB_UPL_FILES_ROW();
        elem.setCODE_ELAB_UPL("");
        elem.setCODE_ELAB("");
        elem.setCODE_FUNZ("");
        elem.setCODE_STATO_BATCH("");
        elem.setCODE_UTENTE("");
        elem.setNUM_RIGA_ELAB("");
        elem.setDESC_ERROR("NULL");
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

  public  Vector findLstFilesManuali(String[] codeParam) throws FinderException, RemoteException
    {
      Vector recs = new Vector();
      String listaParam="";
   try
      {
      conn = getConnection(dsName);

        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".LISTA_MANUAL_REPR_SPE(?,?,?,?)}");

      // Impostazione types I/O
         for (int i=0; i<(codeParam.length-1);i++)
         { 
            if(i==(codeParam.length-2))
              listaParam+="'"+codeParam[i+1]+"'";
            else
              listaParam+="'"+codeParam[i+1]+"',";           
         }
        
        for(int i=0;i<codeParam.length;i++)
        {
        cs.setString(1,codeParam[i]);
        cs.registerOutParameter(2,OracleTypes.ARRAY,"ARR_LISTA_DETT_FILES");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();


      // Costruisco l'array che conterrà i dati di ritorno della stored
        ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_LISTA_DETT_FILES",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
        Datum dati[]=rs.getOracleArray();
        ListaFilesManualiPK pkl;
        
        // Estrazione dei dati
        for (int j=0;j<dati.length;j++)
        {
                pkl = new ListaFilesManualiPK();

                STRUCT s=(STRUCT)dati[j];
          Datum attr[]=s.getOracleAttributes();
                pkl.setNomeUtente(attr[0].stringValue());
                pkl.setCognomeUtente(attr[1].stringValue());
                pkl.setDataElaborazione(attr[2].stringValue());
                String temp=attr[3].stringValue();
                int fistIndex=temp.lastIndexOf("/");
                if(fistIndex>0)
                  pkl.setNomeFile(temp.substring(fistIndex+1,temp.length()));
                else
                  pkl.setNomeFile(temp);
                recs.add(pkl);
            }

        
        }
        cs.close();
      // Chiudo la connessione
      conn.close();
      }
      catch(SQLException e)
      {
        throw new FinderException(e.getMessage());
      } 
      catch(Exception e)
      {
        throw new FinderException(e.getMessage());
      }finally
      {
        try
        {
          conn.close();
        } catch(Exception e)
        {
          throw new RemoteException(e.getMessage());
        }
      }
      
      return recs;

    }

  
  public Vector getElencoSftpEstrazioni(String codiceElab) throws RemoteException, CustomException
  {
   Vector vect=new Vector();
   Connection conn=null;
   try
      {
      conn = getConnection(dsName);

        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".SFTP_ESTRAZIONI(?,?,?,?)}");

      // Impostazione types I/O

      cs.setString(1,codiceElab);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_SFTP_SCHED_TYPE");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);

      cs.execute();

      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4));

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_SFTP_SCHED_TYPE",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      if (rs != null)
      {
        Datum dati[]=rs.getOracleArray();
        // Estrazione dei dati
        for (int i=0;i<dati.length;i++)
        {
          SFTP_SCHED_ROW elem= new SFTP_SCHED_ROW();

          STRUCT s=(STRUCT)dati[i];
          Datum attr[]=s.getOracleAttributes();

          if (attr[0] != null)
              elem.setId_message(attr[0].stringValue());
          else
              elem.setId_message(" ");

          if (attr[1] != null)
              elem.setCode_elab(attr[1].stringValue());
          else
              elem.setCode_elab("");
                  
          if (attr[2] != null)
              elem.setCode_utente(attr[2].stringValue());
          else
              elem.setCode_utente("");
                  
          if (attr[3] != null)
              elem.setStart_sched_time(attr[3].stringValue());
          else
              elem.setStart_sched_time("");
                  
          if (attr[4] != null)
              elem.setStart_time(attr[4].stringValue());
          else
              elem.setStart_time("");

          if (attr[5] != null)
              elem.setEnd_time(attr[5].stringValue());
          else
              elem.setEnd_time("");
          if (attr[6] != null)
              elem.setDesc_message(attr[6].stringValue());
          else
              elem.setDesc_message("");

                     
              
          vect.addElement(elem);

        }
      }
      else
      {
        SFTP_SCHED_ROW elem= new SFTP_SCHED_ROW();
        elem.setId_message(" ");
        elem.setCode_elab("");
        elem.setCode_utente("");
        elem.setStart_sched_time("");
        elem.setStart_time("");
        elem.setEnd_time("");
        elem.setDesc_message(" ");
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
                  "getElencoSftpEstrazioni",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(sqle));
        }

      throw new CustomException(lexc_Exception.toString(),
                  "",
                  "getElencoSftpEstrazioni",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));

    }
    return vect;
  }

  
}