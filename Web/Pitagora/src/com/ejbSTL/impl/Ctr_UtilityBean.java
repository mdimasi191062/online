package com.ejbSTL.impl;

import com.utl.CausaleElem;

import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;
import java.rmi.RemoteException;
import java.util.Vector;
import java.util.GregorianCalendar;
import com.utl.*;
import com.ejbSTL.*;
import java.sql.*;

import oracle.jdbc.OracleCallableStatement;

public class Ctr_UtilityBean extends AbstractClassicEJB implements SessionBean 
{

  public static final java.lang.String PACKAGE_UTILITY = "PKG_UTILITY";
  public static final java.lang.String PACKAGE_INV_SPECIAL = "bo_invent_special";
  
  public void ejbCreate()
  {
  }

  public void ejbActivate()
  {
  }

  public void ejbPassivate()
  {
  }

  public void ejbRemove()
  {
  }

  public void setSessionContext(SessionContext ctx)
  {
  }

  public Vector getStatistiche_odl() throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PACKAGE_SPECIAL + ".getStatistiche_odl";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Statistiche_odl.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getStatistiche_odl",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
    public Vector getPreServiziSpecial()throws CustomException, RemoteException{

      try{

        String lstr_StoredProcedure = PACKAGE_UTILITY + ".getPreServiziSpecial";

        String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                      AbstractEJBTypes.TYPE_VECTOR}};

        Vector lcls_return =  this.callSP(larr_CallSP,DB_ServizioSpecial.class);
        Vector lvct_Return = (Vector)lcls_return.get(0);
        
            
        return lvct_Return;
        
      }
      catch(Exception lexc_Exception){
      
        throw new CustomException(lexc_Exception.toString(),
                        "",
                      "getPreServiziSpecial",
                      this.getClass().getName(),
                      StaticContext.FindExceptionType(lexc_Exception));
      }
      
    }

    public Vector getGestoriSpecial(String codeservizio)throws CustomException, RemoteException{

      try{

        String lstr_StoredProcedure = PACKAGE_UTILITY + ".getGestoriSpecial";

        String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                      AbstractEJBTypes.TYPE_VECTOR},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,codeservizio}
                        };

        Vector lcls_return =  this.callSP(larr_CallSP,DB_GestoriSpecial.class);
        Vector lvct_Return = (Vector)lcls_return.get(0);
        
              
        return lvct_Return;
        
      }
      catch(Exception lexc_Exception){
      
        throw new CustomException(lexc_Exception.toString(),
                        "",
                      "getGestoriSpecial",
                      this.getClass().getName(),
                      StaticContext.FindExceptionType(lexc_Exception));
      }
      
    }
  
    public Vector getPreDisponibiliSpecial(String codice_servizio,String codice_accorpante)throws CustomException, RemoteException{
      try{
        String lstr_StoredProcedure = PACKAGE_UTILITY + ".getPreDisponibiliSpecial";
        String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codice_servizio},                              
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codice_accorpante}
                                };
        Vector lcls_return =  this.callSP(larr_CallSP,DB_GestoriSpecial.class);
        Vector lvct_Return = (Vector)lcls_return.get(0);
        return lvct_Return;
      }
      catch(Exception lexc_Exception){
        throw new CustomException(lexc_Exception.toString(),
                        "",
                      "getPreDisponibiliSpecial",
                      this.getClass().getName(),
                      StaticContext.FindExceptionType(lexc_Exception));
      }
    }
  public int insAccorpamentiSpecial(String str_Servizi, String str_AccountAccorpante,String[] str_AccountAccorpati) throws CustomException, RemoteException
  {
    int i = 0;
    int int_Return = 0;
    Vector lvct_SPReturn = null;
    String str_AccountAccorpato = "";
    try     
    {
      if(str_AccountAccorpati!=null && str_AccountAccorpati.length > 0){
        for(i=0;i<str_AccountAccorpati.length;i++){
          str_AccountAccorpato = str_AccountAccorpati[i];
          String lstr_StoredProcedure = PACKAGE_UTILITY + ".insaccorpamentiSpecial";
          String[][] larr_CallSP ={
                              {lstr_StoredProcedure},
                              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, str_AccountAccorpato},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, str_AccountAccorpante},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, str_Servizi}
                              };
          lvct_SPReturn = this.callSP(larr_CallSP);
          Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
          int_Return = lvct_Return.intValue();
        }
      }

      return int_Return;

    }
    catch(Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insAccorpamentiSpecial",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

  }

public Vector getScartiFreschi() throws CustomException, RemoteException{

      String lstr_StoredProcedureName = PACKAGE_UTILITY + ".getScartiFreschi";



      try{



        String[][] larr_CallSP={

                    {lstr_StoredProcedureName},

                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}

                    };



        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ScartiFreschi.class);

        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);



        return lvct_Return;

      }

      catch(Exception lexc_Exception){

                  throw new CustomException(lexc_Exception.toString(),

                                                                          "",

                                                                          "getScartiFreschi",

                                                                          this.getClass().getName(),

                                                                          StaticContext.FindExceptionType(lexc_Exception));

      }

    }

    public int insScartiFreschi(String str_flagap) throws CustomException, RemoteException

    {

        int int_Return = 0;

        Vector lvct_SPReturn = null;

        try{

          String lstr_StoredProcedure = PACKAGE_UTILITY + ".insScartiFreschi";

          String[][] larr_CallSP ={

                                  {lstr_StoredProcedure},

                                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},

                                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, str_flagap}

                                  };

            lvct_SPReturn = this.callSP(larr_CallSP);

            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

            int_Return = lvct_Return.intValue();

          return int_Return;

        }

        catch(Exception lexc_Exception){

          throw new CustomException(lexc_Exception.toString(),

                          "",

                        "insScartiFreschi",

                        this.getClass().getName(),

                        StaticContext.FindExceptionType(lexc_Exception));

        }

    }

    public Vector getScartiPopolamento(String datarif) throws CustomException, RemoteException{
      

      try{
        String lstr_StoredProcedureName = PACKAGE_UTILITY + ".getScartiPopolamento";
        
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,datarif}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ScartiPopolamento.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getScartiPopolamento",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }

    public Vector getMonitRiscontri1(String datarif) throws CustomException, RemoteException{
      

      try{
        String lstr_StoredProcedureName = PACKAGE_UTILITY + ".getMonitRiscontri1";
        
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,datarif}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_MonRiscSap.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getMonitRiscontri1",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    } 
    public Vector getMonitRiscontri2(String datarif) throws CustomException, RemoteException{
      

      try{
        String lstr_StoredProcedureName = PACKAGE_UTILITY + ".getMonitRiscontri2";
        
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,datarif}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_MonRiscSap.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getMonitRiscontri2",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }
    public Vector getMonitRiscontri3(String datarif) throws CustomException, RemoteException{
      

      try{
        String lstr_StoredProcedureName = PACKAGE_UTILITY + ".getMonitRiscontri3";
        
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,datarif}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_MonRiscSap.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getMonitRiscontri3",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }
    public Vector getMonitRiscontri4(String datarif) throws CustomException, RemoteException{
      

      try{
        String lstr_StoredProcedureName = PACKAGE_UTILITY + ".getMonitRiscontri4";
        
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,datarif}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_MonRiscSap.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getMonitRiscontri4",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }
    public Vector getMonitRiscontri5(String datarif) throws CustomException, RemoteException{
      

      try{
        String lstr_StoredProcedureName = PACKAGE_UTILITY + ".getMonitRiscontri5";
        
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,datarif}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_MonRiscSap.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getMonitRiscontri5",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }    

    public Vector getScartiVal(String datarif) throws CustomException, RemoteException{
      

      try{
        String lstr_StoredProcedureName = PACKAGE_UTILITY + ".getScartiVal";
        
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,datarif}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ScartiVal.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getScartiVal",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }

    public Vector getAccountDup(String datarif) throws CustomException, RemoteException{
      

      try{
        String lstr_StoredProcedureName = PACKAGE_UTILITY + ".getAccountDup";
        
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,datarif}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_AccountDup.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getAccountDup",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }    
    
    public int insOrdiniCessazNoCodeContr(String str_Tabella, String str_Ticket,String str_datarif) throws CustomException, RemoteException
    {
      int i = 0;
      int int_Return = 0;
      Vector lvct_SPReturn = null;

      try     
      {
            String lstr_StoredProcedure = PACKAGE_UTILITY + ".insOrdiniCessazNoCodeContr";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, str_Tabella},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, str_Ticket},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, str_datarif}
                                };
            lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
            int_Return = lvct_Return.intValue();

        return int_Return;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "insOrdiniCessazNoCodeContr",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    }    

    public int insOrdiniCessazSiCodeContr(String str_Tabella, String str_Ticket,String str_datarif) throws CustomException, RemoteException
    {
      int i = 0;
      int int_Return = 0;
      Vector lvct_SPReturn = null;

      try     
      {
            String lstr_StoredProcedure = PACKAGE_UTILITY + ".insOrdiniCessazSiCodeContr";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, str_Tabella},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, str_Ticket},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, str_datarif}
                                };
            lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
            int_Return = lvct_Return.intValue();

        return int_Return;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "insOrdiniCessazSiCodeContr",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    } 

    public int lanciaStatoRisorsa(String risorsa) throws CustomException, RemoteException
    {
        int i = 0;
        int int_Return = 0;
        Vector lvct_SPReturn = null;
        
      try     
      {
            String lstr_StoredProcedure = PACKAGE_UTILITY + ".lanciaStatoRisorsa";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, risorsa}
                                };
          lvct_SPReturn = this.callSP(larr_CallSP);


        return 0;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "lanciaStatoRisorsa",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    } 

    public Vector getAnalisiRisorsa(String risorsa) throws CustomException, RemoteException{
      

      try{
        String lstr_StoredProcedureName = PACKAGE_UTILITY + ".getAnalisiRisorsa";
        
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,risorsa}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_StatoRisorsa.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getAnalisiRisorsa",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }

    public Vector getUltimaFatt(String risorsa) throws CustomException, RemoteException{
      

      try{
        String lstr_StoredProcedureName = PACKAGE_UTILITY + ".getUltimaFatt";
        
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,risorsa}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_StatoRisorsa.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getUltimaFatt",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }
    
    public Vector getUltimaNdc(String risorsa) throws CustomException, RemoteException{
      

      try{
        String lstr_StoredProcedureName = PACKAGE_UTILITY + ".getUltimaNdc";
        
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,risorsa}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_StatoRisorsa.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getUltimaNdc",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }

    public Vector getRagSocOlo(String risorsa) throws CustomException, RemoteException{
      

      try{
        String lstr_StoredProcedureName = PACKAGE_UTILITY + ".getRagSocOlo";
        
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,risorsa}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_AccountOlo.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getRagSocOlo",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }
    
    public int updRagSocOlo(String codice, String descrizione) throws CustomException, RemoteException
    {
      int i = 0;
      int int_Return = 0;
      Vector lvct_SPReturn = null;

      try     
      {
            String lstr_StoredProcedure = PACKAGE_UTILITY + ".updRagSocOlo";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codice},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, descrizione}
                                };
            lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
            int_Return = lvct_Return.intValue();

        return int_Return;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "updRagSocOlo",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    } 
//////////////////////
 public ControlliPreValorizElem getControlliPreValoriz() throws RemoteException, CustomException
   {
   ControlliPreValorizElem  elem = null;
   Connection conn= null;
   try
     {
     conn = getConnection(dsName);
     OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_UTILITY + ".CHECK_PRE_VALORIZ(?,?,?,?,?,?,?,?,?)}");
     cs.registerOutParameter(1,Types.INTEGER);
     cs.registerOutParameter(2,Types.INTEGER);
     cs.registerOutParameter(3,Types.INTEGER);
     cs.registerOutParameter(4,Types.INTEGER);
     cs.registerOutParameter(5,Types.INTEGER);
     cs.registerOutParameter(6,Types.INTEGER);
     cs.registerOutParameter(7,Types.INTEGER);
     cs.registerOutParameter(8,Types.INTEGER);
     cs.registerOutParameter(9,Types.VARCHAR); 
     cs.execute();
     if ((cs.getInt(8)!=DBMessage.OK_RT)&&(cs.getInt(8)!=DBMessage.NOT_FOUND_RT))
       throw new Exception("DB:BATCH_DA_LANCIRE:"+cs.getInt(8)+":"+cs.getString(9));

     if ((cs.getInt(8)==DBMessage.NOT_FOUND_RT))
     {
        if (!conn.isClosed()) conn.close();
        return elem;
     }
     elem=new ControlliPreValorizElem();
     elem.seto_dett_fatt(cs.getInt(1));
     elem.seto_test_fatt(cs.getInt(2));
     elem.seto_dett_ndc(cs.getInt(3));
     elem.seto_test_ndc(cs.getInt(4));
     elem.seto_dett_csv(cs.getInt(5));
     elem.seto_test_csv(cs.getInt(6));
     elem.seto_acc_dupl(cs.getInt(7));             
     cs.close();
     //Chiudo la connessione
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
                                                                       "getCodeFunzFlag",
                                                                       this.getClass().getName(),
                                                                       StaticContext.FindExceptionType(sqle));
       }
     throw new CustomException(lexc_Exception.toString(),
                                                                       "",
                                                                       "getCodeFunzFlag",
                                                                       this.getClass().getName(),
                                                                       StaticContext.FindExceptionType(lexc_Exception));
   }
   return elem;
 }
 
    public ControlliProgDigDivElem getControlliProgDigDiv() throws RemoteException, CustomException
      {
      ControlliProgDigDivElem  elem = null;
      Connection conn= null;
      try
        {
        conn = getConnection(dsName);
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_UTILITY + ".CHECK_PROG_DIGDIV(?,?,?)}");
        cs.registerOutParameter(1,Types.INTEGER);
        cs.registerOutParameter(2,Types.INTEGER);
        cs.registerOutParameter(3,Types.VARCHAR); 
        cs.execute();
        if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
          throw new Exception("DB:BATCH_DA_LANCIARE:"+cs.getInt(2)+":"+cs.getString(3));

        if ((cs.getInt(2)==DBMessage.NOT_FOUND_RT))
        {
           if (!conn.isClosed()) conn.close();
           return elem;
        }
        elem=new ControlliProgDigDivElem();
        elem.seto_dett(cs.getInt(1));
        cs.close();
        //Chiudo la connessione
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
                                                                          "getControlliProgDigDiv",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(sqle));
          }
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getControlliProgDigDiv",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
      return elem;
    }
    public Vector getAnagContrRegNow(String datarif) throws CustomException, RemoteException{

          



          try{

            String lstr_StoredProcedureName = PACKAGE_UTILITY + ".getAnagContrRegNow";

            

            String[][] larr_CallSP={

                        {lstr_StoredProcedureName},

                        {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},

                        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,datarif}

                        };



            Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_MonTabInt.class);

            Vector lvct_Return = (Vector)lvct_SPReturn.get(0);



            return lvct_Return;

          }

          catch(Exception lexc_Exception){

                      throw new CustomException(lexc_Exception.toString(),

                                                                              "",

                                                                              "getAnagContrRegNow",

                                                                              this.getClass().getName(),

                                                                              StaticContext.FindExceptionType(lexc_Exception));

          }

        }    

        

        public Vector getAnagContrXdslNow(String datarif) throws CustomException, RemoteException{

          



          try{

            String lstr_StoredProcedureName = PACKAGE_UTILITY + ".getAnagContrXdslNow";

            

            String[][] larr_CallSP={

                        {lstr_StoredProcedureName},

                        {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},

                        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,datarif}

                        };



            Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_MonTabInt.class);

            Vector lvct_Return = (Vector)lvct_SPReturn.get(0);



            return lvct_Return;

          }

          catch(Exception lexc_Exception){

                      throw new CustomException(lexc_Exception.toString(),

                                                                              "",

                                                                              "getAnagContrXdslNow",

                                                                              this.getClass().getName(),

                                                                              StaticContext.FindExceptionType(lexc_Exception));

          }

        }    

        

        public Vector getAnagGestRegNow(String datarif) throws CustomException, RemoteException{

          



          try{

            String lstr_StoredProcedureName = PACKAGE_UTILITY + ".getAnagGestRegNow";

            

            String[][] larr_CallSP={

                        {lstr_StoredProcedureName},

                        {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},

                        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,datarif}

                        };



            Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_MonTabInt.class);

            Vector lvct_Return = (Vector)lvct_SPReturn.get(0);



            return lvct_Return;

          }

          catch(Exception lexc_Exception){

                      throw new CustomException(lexc_Exception.toString(),

                                                                              "",

                                                                              "getAnagGestRegNow",

                                                                              this.getClass().getName(),

                                                                              StaticContext.FindExceptionType(lexc_Exception));

          }

        }    

        

        public Vector getAnagGestXdslNow(String datarif) throws CustomException, RemoteException{

          



          try{

            String lstr_StoredProcedureName = PACKAGE_UTILITY + ".getAnagGestXdslNow";

            

            String[][] larr_CallSP={

                        {lstr_StoredProcedureName},

                        {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},

                        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,datarif}

                        };



            Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_MonTabInt.class);

            Vector lvct_Return = (Vector)lvct_SPReturn.get(0);



            return lvct_Return;

          }

          catch(Exception lexc_Exception){

                      throw new CustomException(lexc_Exception.toString(),

                                                                              "",

                                                                              "getAnagGestXdslNow",

                                                                              this.getClass().getName(),

                                                                              StaticContext.FindExceptionType(lexc_Exception));

          }

        } 

    public int annullaTutto(String codeAccount,String codeIstanza,String dataInizioFatt,String codeH3,String dataFineAcq,String tracciamento) throws CustomException, RemoteException
    {
      int i = 0;
      int int_Return = 0;
      Vector lvct_SPReturn = null;

      try     
      {
            String lstr_StoredProcedure = PACKAGE_UTILITY + ".annullaRiga";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeAccount},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeIstanza},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, dataInizioFatt},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeH3},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, dataFineAcq},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, tracciamento}
                                };
            lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
            int_Return = lvct_Return.intValue();

        return int_Return;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "annullaRiga",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    } 
 
    public int annullaTuttoSingolo(String codeInventario,String codeH3,String tracciamento) throws CustomException, RemoteException
    {
      int i = 0;
      int int_Return = 0;
      Vector lvct_SPReturn = null;

      try     
      {
            String lstr_StoredProcedure = PACKAGE_UTILITY + ".annullaRigaSingolo";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeInventario},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeH3},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, tracciamento}
                                };
            lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
            int_Return = lvct_Return.intValue();

        return int_Return;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "annullaRigaSingolo",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    } 
      
    public int annullaTuttoMassivo() throws CustomException, RemoteException
    {
      int i = 0;
      int int_Return = 0;
      Vector lvct_SPReturn = null;

      try     
      {
            String lstr_StoredProcedure = PACKAGE_UTILITY + ".annullaRigaMassivo";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER}
                                };
            lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
            int_Return = lvct_Return.intValue();

        return int_Return;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "annullaRigaMassivo",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    } 
    
    public int annullaOrdineMassivo() throws CustomException, RemoteException
    {
      int i = 0;
      int int_Return = 0;
      Vector lvct_SPReturn = null;

      try     
      {
            String lstr_StoredProcedure = PACKAGE_UTILITY + ".annullaOrdineMassivo";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER}
                                };
            lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
            int_Return = lvct_Return.intValue();

        return int_Return;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "annullaOrdineMassivo",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    } 
    
    public int annullaOrdine(String IdOrdCrmws,String tracciamento,String dataAcq) throws CustomException, RemoteException
    {
      int i = 0;
      int int_Return = 0;
      Vector lvct_SPReturn = null;

      try     
      {
            String lstr_StoredProcedure = PACKAGE_UTILITY + ".annullaOrdine";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, IdOrdCrmws},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, tracciamento},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, dataAcq}
                                };
            lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
            int_Return = lvct_Return.intValue();

        return int_Return;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "annullaOrdine",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    }

    public int trasportoMirato(String IdOrdCrmws) throws CustomException, RemoteException
    {
      int i = 0;
      int int_Return = 0;
      Vector lvct_SPReturn = null;

      try     
      {
            String lstr_StoredProcedure = PACKAGE_UTILITY + ".CRMW_to_JPUB";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, IdOrdCrmws}
                                };
            lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
            int_Return = lvct_Return.intValue();

        return int_Return;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "CRMW_to_JPUB",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    }

    public Vector getOperatoriClassic(String listaservizi)throws CustomException, RemoteException{

      try{

        String lstr_StoredProcedure = PACKAGE_UTILITY + ".getOperatoriClassic";

        String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                      AbstractEJBTypes.TYPE_VECTOR},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,listaservizi}
                        };

        Vector lcls_return =  this.callSP(larr_CallSP,DB_GestoriSpecial.class);
        Vector lvct_Return = (Vector)lcls_return.get(0);
        
              
        return lvct_Return;
        
      }
      catch(Exception lexc_Exception){
      
        throw new CustomException(lexc_Exception.toString(),
                        "",
                      "getOperatoriClassic",
                      this.getClass().getName(),
                      StaticContext.FindExceptionType(lexc_Exception));
      }
      
    }    

    public Vector getOperatoriSpecial(String listaservizi)throws CustomException, RemoteException{

      try{

        String lstr_StoredProcedure = PACKAGE_UTILITY + ".getOperatoriSpecial";

        String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                      AbstractEJBTypes.TYPE_VECTOR},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,listaservizi}
                        };

        Vector lcls_return =  this.callSP(larr_CallSP,DB_GestoriSpecial.class);
        Vector lvct_Return = (Vector)lcls_return.get(0);
        
              
        return lvct_Return;
        
      }
      catch(Exception lexc_Exception){
      
        throw new CustomException(lexc_Exception.toString(),
                        "",
                      "getOperatoriSpecial",
                      this.getClass().getName(),
                      StaticContext.FindExceptionType(lexc_Exception));
      }
      
    }    
    public Vector getElab_Batch_valo() throws CustomException, RemoteException{
      String lstr_StoredProcedureName = StaticContext.PACKAGE_UTILITY + ".getElab_Batch_valo";

      try{

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Elab_Batch.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getElab_Batch_valo",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }    
    
    public Vector getElab_Batch_flsap() throws CustomException, RemoteException{
      String lstr_StoredProcedureName = StaticContext.PACKAGE_UTILITY + ".getElab_Batch_flsap";

      try{

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Elab_Batch.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getElab_Batch_flsap",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }        
    
    public Vector getElab_Batch_cong() throws CustomException, RemoteException{
      String lstr_StoredProcedureName = StaticContext.PACKAGE_UTILITY + ".getElab_Batch_cong";

      try{

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Elab_Batch.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getElab_Batch_cong",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }        
    
    public Vector getTestoRepr() throws CustomException, RemoteException{
      String lstr_StoredProcedureName = StaticContext.PACKAGE_UTILITY + ".getTestoRepricing";

      try{

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Param_Sap.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getTestoRepr",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }    
    
    public int truncateAnnullaOrdine() throws CustomException, RemoteException
    {
      int int_Return = 0;
      Vector lvct_SPReturn = null;

      try     
      {
            String lstr_StoredProcedure = PACKAGE_UTILITY + ".truncateAnnullaOrdine";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER}
                                };
            lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
            int_Return = lvct_Return.intValue();

        return int_Return;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "truncateAnnullaOrdine",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    }

    public int truncateAnnullaTutto() throws CustomException, RemoteException
    {
      int int_Return = 0;
      Vector lvct_SPReturn = null;

      try     
      {
            String lstr_StoredProcedure = PACKAGE_UTILITY + ".truncateAnnullaTutto";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER}
                                };
            lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
            int_Return = lvct_Return.intValue();

        return int_Return;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "truncateAnnullaOrdine",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    }
    
    public int insertAnnullaTutto(String codeInventario) throws CustomException, RemoteException
    {
      int int_Return = 0;
      Vector lvct_SPReturn = null;

      try     
      {
            String lstr_StoredProcedure = PACKAGE_UTILITY + ".insertAnnullaTutto";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,codeInventario}
                                };
            lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
            int_Return = lvct_Return.intValue();

        return int_Return;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "insertAnnullaTutto",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    }
    
    public int insertAnnullaOrdine(String codeOrdineCrmws,String dataAcq) throws CustomException, RemoteException
    {
      int int_Return = 0;
      Vector lvct_SPReturn = null;

      try     
      {
            String lstr_StoredProcedure = PACKAGE_UTILITY + ".insertAnnullaOrdine";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,codeOrdineCrmws},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,dataAcq}
                                };
            lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
            int_Return = lvct_Return.intValue();

        return int_Return;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "insertAnnullaOrdine",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    }
    
    public Vector getQuadratureSapClassic(String strTipoExport,String strCicloVal)throws CustomException, RemoteException{

      try{

        //String lstr_StoredProcedure = PACKAGE_UTILITY + ".QuadratureRiscontriSAP_Classic";
        String lstr_StoredProcedure = PACKAGE_UTILITY + ".QuadRiscSAPDett_Classic";
        String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                      AbstractEJBTypes.TYPE_VECTOR},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,strTipoExport},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,strCicloVal}
                        };

        Vector lcls_return =  this.callSP(larr_CallSP,DB_QuadratureSap.class);
        Vector lvct_Return = (Vector)lcls_return.get(0);
        
              
        return lvct_Return;
        
      }
      catch(Exception lexc_Exception){
      
        throw new CustomException(lexc_Exception.toString(),
                        "",
                      "getQuadratureSapClassic",
                      this.getClass().getName(),
                      StaticContext.FindExceptionType(lexc_Exception));
      }
      
    }
    public Vector getQuadratureSapSpecial(String strTipoExport,String strCicloVal)throws CustomException, RemoteException{

      try{

        //String lstr_StoredProcedure = PACKAGE_UTILITY + ".QuadratureRiscontriSAP_Special";
        String lstr_StoredProcedure = PACKAGE_UTILITY + ".QuadRiscSAPDett_Special";
        
        String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                      AbstractEJBTypes.TYPE_VECTOR},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,strTipoExport},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,strCicloVal}
                        };

        Vector lcls_return =  this.callSP(larr_CallSP,DB_QuadratureSap.class);
        Vector lvct_Return = (Vector)lcls_return.get(0);
        
              
        return lvct_Return;
        
      }
      catch(Exception lexc_Exception){
      
        throw new CustomException(lexc_Exception.toString(),
                        "",
                      "getQuadratureSapSpecial",
                      this.getClass().getName(),
                      StaticContext.FindExceptionType(lexc_Exception));
      }
      
    }
    
    public Vector getcomuniClusterByFilter(String strtipoCluster,String strcodeCluster, String istatComune, String dataIniVal, String dataFineVal)throws CustomException, RemoteException{

      try{

        String lstr_StoredProcedure = PACKAGE_UTILITY + ".getcomuniClusterByFilter";

        String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                      AbstractEJBTypes.TYPE_VECTOR},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,strtipoCluster},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,strcodeCluster},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,istatComune},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,dataIniVal},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,dataFineVal}
                        };

        Vector lcls_return =  this.callSP(larr_CallSP,I5_1COMUNI_CLUSTER_PRICING.class);
        Vector lvct_Return = (Vector)lcls_return.get(0);
        
              
        return lvct_Return;
        
      }
      catch(Exception lexc_Exception){
      
        throw new CustomException(lexc_Exception.toString(),
                        "",
                      "getcomuniClusterByFilter",
                      this.getClass().getName(),
                      StaticContext.FindExceptionType(lexc_Exception));
      }
      
    }
    
    public Vector getcomuniCluster() throws CustomException, RemoteException{
      String lstr_StoredProcedureName = StaticContext.PACKAGE_UTILITY + ".getcomuniCluster";

      try{

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, I5_1COMUNI_CLUSTER_PRICING.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getcomuniCluster",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }    

    public Vector getcodeCluster() throws CustomException, RemoteException{
      String lstr_StoredProcedureName = StaticContext.PACKAGE_UTILITY + ".getcodeCluster";

      try{

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, I5_1COMUNI_CLUSTER_PRICING.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getcodeCluster",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }    

    public Vector gettipoCluster() throws CustomException, RemoteException{
      String lstr_StoredProcedureName = StaticContext.PACKAGE_UTILITY + ".gettipoCluster";

      try{

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, I5_1COMUNI_CLUSTER_PRICING.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "gettipoCluster",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }    
    
    public Vector getPeriodoRiferimento(String StoredProcedure) throws CustomException, RemoteException{
      String lstr_StoredProcedureName = StaticContext.PACKAGE_UTILITY + "." + StoredProcedure;

      try{

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_PeriodoRiferimento.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getPeriodoRiferimento",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }
    
    public int cruscottoGuiByCodeId(String codeId) throws CustomException, RemoteException
    {
      int int_Return = 0;
      Vector lvct_SPReturn = null;

      try     
      {
            String lstr_StoredProcedure = PACKAGE_UTILITY + ".cruscottoGuiByCodeId";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,codeId}
                                };
            lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
            int_Return = lvct_Return.intValue();

        return int_Return;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "cruscottoGuiByCodeId",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    }

    public int cruscottoGuiCountRunn(String codeFunz) throws CustomException, RemoteException
    {
      int int_Return = 0;
      Vector lvct_SPReturn = null;

      try     
      {
            String lstr_StoredProcedure = PACKAGE_UTILITY + ".cruscottoGuiCountRunn";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,codeFunz}
                                };
            lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
            int_Return = lvct_Return.intValue();

        return int_Return;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "cruscottoGuiCountRunn",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    }
    
    public int cruscottoGuiStatus(String codeFunz) throws CustomException, RemoteException
    {
      int int_Return = 0;
      Vector lvct_SPReturn = null;

      try     
      {
            String lstr_StoredProcedure = PACKAGE_UTILITY + ".cruscottoGuiStatus";
            String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,codeFunz}
                                };
            lvct_SPReturn = this.callSP(larr_CallSP);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
            int_Return = lvct_Return.intValue();

        return int_Return;

      }
      catch(Exception lexc_Exception)
      {
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "cruscottoGuiStatus",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }

    }
    public Vector getCruscottoDett(String tipoDett) throws CustomException, RemoteException{
      String lstr_StoredProcedureName = StaticContext.PACKAGE_UTILITY + ".getCruscottoDett";

      try{

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,tipoDett}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_CruscottoGui.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getCruscottoDett",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }
    public Vector getTimeLineRisorsa(String IdRisorsa) throws CustomException, RemoteException{
      String lstr_StoredProcedureName = StaticContext.PACKAGE_UTILITY + ".getTimeLineRisorsa";

      try{

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,IdRisorsa}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_TimeLineRisorsa.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getTimeLineRisorsa",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }
    
    public Vector getTimeLineCons(String IdRisorsa) throws CustomException, RemoteException{
      String lstr_StoredProcedureName = StaticContext.PACKAGE_UTILITY + ".getTimeLineCons";

      try{

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,IdRisorsa}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_TimeLineRisorsa.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getTimeLineCons",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }    
    
    public TmlRisorsaDett getTmlRisorsaDett(String codeInvent) throws RemoteException, CustomException
      {
      TmlRisorsaDett  elem = null;
      Connection conn= null;
      try
        {
        conn = getConnection(dsName);
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_UTILITY + ".getTMLRisorsaDett(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
        cs.setString(1,codeInvent);
        cs.registerOutParameter(2,Types.VARCHAR);
        cs.registerOutParameter(3,Types.VARCHAR);
        cs.registerOutParameter(4,Types.VARCHAR); 
        cs.registerOutParameter(5,Types.VARCHAR);
        cs.registerOutParameter(6,Types.VARCHAR);
        cs.registerOutParameter(7,Types.VARCHAR); 
        cs.registerOutParameter(8,Types.VARCHAR);
        cs.registerOutParameter(9,Types.VARCHAR);
        cs.registerOutParameter(10,Types.VARCHAR); 
        cs.registerOutParameter(11,Types.VARCHAR);
        cs.registerOutParameter(12,Types.VARCHAR);
        cs.registerOutParameter(13,Types.VARCHAR);             
        cs.registerOutParameter(14,Types.VARCHAR); 
        cs.registerOutParameter(15,Types.VARCHAR);             
        cs.registerOutParameter(16,Types.INTEGER);         
        cs.registerOutParameter(17,Types.VARCHAR);         
        cs.execute();
        if ((cs.getInt(16)!=DBMessage.OK_RT)&&(cs.getInt(16)!=100))
          throw new Exception("DB:getTMLRisorsaDett:"+cs.getInt(16)+":"+cs.getString(17));

        if ((cs.getInt(16)==100))
        {
           if (!conn.isClosed()) conn.close();
            //elem=new TmlRisorsaDett();
           return elem;
        }
        elem=new TmlRisorsaDett();
        elem.seto_code_num_td(cs.getString(2));
        elem.seto_stato_risorsa(cs.getString(3));
        elem.seto_code_lotto(cs.getString(4));
        elem.seto_flag_trasporto(cs.getString(5));            
        elem.seto_id_accesso(cs.getString(6));
        elem.seto_tecnologia_fibra(cs.getString(7));
        elem.seto_flag_qualifica(cs.getString(8));
        elem.seto_flag_test2(cs.getString(9));
        elem.seto_tipo_cluster(cs.getString(10));
        elem.seto_code_cluster(cs.getString(11));        
        elem.seto_codice_interfaccia(cs.getString(12));
        elem.seto_id_ord_crmws(cs.getString(13));                    
        elem.seto_messaggio(cs.getString(14));        
        elem.seto_code_istanza_ps(cs.getString(15));
        cs.close();
        //Chiudo la connessione
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
                                                                          "getTMLRisorsaDett",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(sqle));
          }
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getTMLRisorsaDett",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
      return elem;
    }    
    public TmlRisorsaDett getTmlUltFatt(String codeInvent) throws RemoteException, CustomException
      {
      TmlRisorsaDett  elem = null;
      Connection conn= null;
      try
        {
        conn = getConnection(dsName);
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_UTILITY + ".getTmlUltFatt(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
        cs.setString(1,codeInvent);
        cs.registerOutParameter(2,Types.VARCHAR);
        cs.registerOutParameter(3,Types.VARCHAR);
        cs.registerOutParameter(4,Types.VARCHAR); 
        cs.registerOutParameter(5,Types.VARCHAR);
        cs.registerOutParameter(6,Types.VARCHAR);
        cs.registerOutParameter(7,Types.VARCHAR); 
        cs.registerOutParameter(8,Types.VARCHAR);
        cs.registerOutParameter(9,Types.VARCHAR);
        cs.registerOutParameter(10,Types.VARCHAR); 
        cs.registerOutParameter(11,Types.VARCHAR);
        cs.registerOutParameter(12,Types.VARCHAR);
        cs.registerOutParameter(13,Types.VARCHAR);             
        cs.registerOutParameter(14,Types.DOUBLE); 
        cs.registerOutParameter(15,Types.INTEGER);             
        cs.registerOutParameter(16,Types.VARCHAR);         
        cs.execute();
        if ((cs.getInt(15)!=DBMessage.OK_RT)&&(cs.getInt(15)!=100))
          throw new Exception("DB:getTmlUltFatt:"+cs.getInt(15)+":"+cs.getString(16));

        if ((cs.getInt(15)==100))
        {
           if (!conn.isClosed()) conn.close();
            //elem=new TmlRisorsaDett();
           return elem;
        }
        elem=new TmlRisorsaDett();
        elem.seto_code_clli(cs.getString(2));
        elem.seto_code_doc(cs.getString(3));
        elem.seto_codice_progetto(cs.getString(4));
        elem.seto_code_ogg_fatrz(cs.getString(5));            
        elem.seto_code_promozione(cs.getString(6));
        elem.seto_code_pr_tariffa(cs.getString(7));
        elem.seto_code_ps(cs.getString(8));
        elem.seto_code_riga(cs.getString(9));
        elem.seto_code_tariffa(cs.getString(10));
        elem.seto_data_da(cs.getString(11));        
        elem.seto_data_a(cs.getString(12));
        elem.seto_data_inizio_fatrz(cs.getString(13));                    
        elem.seto_impt_riga(cs.getDouble(14));
        cs.close();
        //Chiudo la connessione
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
                                                                          "getTmlUltFatt",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(sqle));
          }
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getTmlUltFatt",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
      return elem;
    }        
    public TmlRisorsaDett getTmlUltNC(String codeInvent) throws RemoteException, CustomException
      {
      TmlRisorsaDett  elem = null;
      Connection conn= null;
      try
        {
        conn = getConnection(dsName);
        OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_UTILITY + ".getTmlUltNC(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
        cs.setString(1,codeInvent);
        cs.registerOutParameter(2,Types.VARCHAR);
        cs.registerOutParameter(3,Types.VARCHAR);
        cs.registerOutParameter(4,Types.VARCHAR); 
        cs.registerOutParameter(5,Types.VARCHAR);
        cs.registerOutParameter(6,Types.VARCHAR);
        cs.registerOutParameter(7,Types.VARCHAR); 
        cs.registerOutParameter(8,Types.VARCHAR);
        cs.registerOutParameter(9,Types.VARCHAR);
        cs.registerOutParameter(10,Types.VARCHAR); 
        cs.registerOutParameter(11,Types.VARCHAR);
        cs.registerOutParameter(12,Types.VARCHAR);
        cs.registerOutParameter(13,Types.VARCHAR);             
        cs.registerOutParameter(14,Types.DOUBLE); 
        cs.registerOutParameter(15,Types.INTEGER);             
        cs.registerOutParameter(16,Types.VARCHAR);         
        cs.execute();
        if ((cs.getInt(15)!=DBMessage.OK_RT)&&(cs.getInt(15)!=100))
          throw new Exception("DB:getTmlUltNC:"+cs.getInt(15)+":"+cs.getString(16));

        if ((cs.getInt(15)==100))
        {
           if (!conn.isClosed()) conn.close();
            //elem=new TmlRisorsaDett();
           return elem;
        }
        elem=new TmlRisorsaDett();
        elem.seto_code_clli(cs.getString(2));
        elem.seto_code_doc(cs.getString(3));
        elem.seto_codice_progetto(cs.getString(4));
        elem.seto_code_ogg_fatrz(cs.getString(5));            
        elem.seto_code_promozione(cs.getString(6));
        elem.seto_code_pr_tariffa(cs.getString(7));
        elem.seto_code_ps(cs.getString(8));
        elem.seto_code_riga(cs.getString(9));
        elem.seto_code_tariffa(cs.getString(10));
        elem.seto_data_da(cs.getString(11));        
        elem.seto_data_a(cs.getString(12));
        elem.seto_data_inizio_fatrz(cs.getString(13));                    
        elem.seto_impt_riga(cs.getDouble(14));
        cs.close();
        //Chiudo la connessione
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
                                                                          "getTmlUltNC",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(sqle));
          }
        throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getTmlUltNC",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
      return elem;
    }    
    public Vector getTimeLineScarti(String codeInvent) throws CustomException, RemoteException{
      String lstr_StoredProcedureName = StaticContext.PACKAGE_UTILITY + ".getTimeLineScart";

      try{

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,codeInvent}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_TimeLineScart.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getTimeLineScart",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }    
}
