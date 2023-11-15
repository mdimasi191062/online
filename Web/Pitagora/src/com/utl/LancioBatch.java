package com.utl;
import oracle.jdbc.*;

import java.sql.*;
import javax.sql.*;

import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.*;

import java.util.*;
import java.rmi.*;
import java.text.*;
import oracle.sql.*;



public class LancioBatch extends AbstractDataSource
{
  private static final String LancioRibes ="{? = call  EXTERNAL_LIBRARY.SEND_REQUEST(?,?,?,?,?,?) }";;
  private CallableStatement cs = null;
  final int primo_parametro=0;
  public LancioBatch()
  {
  }
  public int Esecuzione(String strComRibes) throws Exception{

    int ritorno;
    String send = "";
    String dataSched = "";
    String codeTipoContr = "";
    if(strComRibes.substring(0,1).equals("$"))
    {
      dataSched = strComRibes.substring(1,20);
      strComRibes = strComRibes.substring(21,strComRibes.length());   
    }
    else
    {
      send = "SEND";
    }
    
    String codeFunz = "";
    String codeUtente = "";
    String generaReport = "";
    StringTokenizer st = new StringTokenizer(strComRibes,"$");

    /* RM - aggiunta code_tipo_contr per lancio parallelo su contratti diversi - INIZIO */
    if(send.equals("")){
      codeTipoContr = st.nextToken();
    /* RM - aggiunta code_tipo_contr per lancio parallelo su contratti diversi - FINE */

      int lunghezza = 0;
      lunghezza = codeTipoContr.length()+1;
    
      strComRibes = strComRibes.substring(lunghezza,strComRibes.length());   
      System.out.println("strComRibes dopo code_tipo_contr ["+strComRibes+"]");

    }

    codeFunz = st.nextToken();
    codeUtente = st.nextToken();
    if(!codeFunz.equals("2001"))
      generaReport = st.nextToken();
      
    try
    {
      
      conn = getConnection(dsName);
      OracleCallableStatement cs = (OracleCallableStatement)conn.prepareCall(LancioRibes);
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ELAB_BATCH_SCHED_LISTA(?,?,?,?,?,?,?,?)}");
      cs.registerOutParameter(1,OracleTypes.NUMBER);
      cs.setString(2,send); //SEND OR NULL
      cs.setString(3,strComRibes); //MESSAGGIO RIBES
      cs.setString(4,dataSched); //DATA SCHEDULAZIONE
      cs.setString(5,codeUtente); //CODICE UTENTE
      cs.setString(6,codeTipoContr); //CODE_TIPO_CONTR
      cs.registerOutParameter(7,OracleTypes.STRUCT, "EXTERNAL_LIBRARY_OBJ");
      cs.execute();
      ritorno = cs.getInt(1);
      cs.close();
      

      if(send.equals(""))
        ritorno = 1;
      else
        ritorno = 0;
        
      // Costruisco l'array che conterr� i dati di ritorno della stored
      if(ritorno == 1)
      {
        System.out.println("SCHED_OK");
      }
      else if(ritorno == 0)
      {
        System.out.println("LANCIO_OK");
      }
      else
      {
        System.out.println("ERRORE");
        StructDescriptor sd = StructDescriptor.createDescriptor("EXTERNAL_LIBRARY_OBJ",conn);
        Object[] paramArrayOfObject = null;
        STRUCT rs = new STRUCT(sd, conn, paramArrayOfObject);

        // Ottengo i dati
        rs=cs.getSTRUCT(6);
        Datum dati[]=rs.getOracleAttributes();      
        System.out.println("dati.length ["+dati.length+"]");

        ClassJRibesReturn jribesClass = new ClassJRibesReturn();
        
        if (dati[0]!=null) jribesClass.setJr_code_elab(dati[0].stringValue());
        else jribesClass.setJr_code_elab("");
          
        if (dati[1]!=null) jribesClass.setJr_flag_sys(dati[1].stringValue());
        else jribesClass.setJr_flag_sys("");

        if (dati[2]!=null) jribesClass.setJr_name(dati[2].stringValue());
        else jribesClass.setJr_name("");

        if (dati[3]!=null) jribesClass.setJr_username(dati[3].stringValue());
        else jribesClass.setJr_username("");

        if (dati[4]!=null) jribesClass.setJr_is_available(dati[4].stringValue());
        else jribesClass.setJr_is_available("");

        if (dati[5]!=null) jribesClass.setJr_have_concurrency(dati[5].stringValue());
        else jribesClass.setJr_have_concurrency("");

        if (dati[6]!=null) jribesClass.setJr_error_code(dati[6].intValue());
        else jribesClass.setJr_error_code(0);
        System.out.println("Error Code ["+jribesClass.getJr_error_code()+"]");

        if (dati[7]!=null) jribesClass.setJr_error_desc(dati[7].stringValue());
        else jribesClass.setJr_error_desc("");
        System.out.println("Error MSG ["+jribesClass.getJr_error_desc()+"]");
        
        ritorno = 2;
      }
      

    }
    catch (Exception e)
    {
      System.out.println("Eccezione: " +e.getMessage());
      throw new Exception(e.getMessage());
    }
    finally
    {
      try
      {
       conn.close();
      }
      catch (Exception e){
        System.out.println("Eccezione: " +e.getMessage());
        throw new Exception(e.getMessage());
      }
    }
    return ritorno;
  }
}
