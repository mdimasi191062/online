package com.ejbSTL.impl;
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

public class Ent_InventariBean extends AbstractClassicEJB implements SessionBean 
{
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

 public int inserisciElabBatch( String strCodeFunz, String strCodeUtente, String strCodeStatoBatch ) 
  throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "insElabBatch";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeFunz},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeUtente},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeStatoBatch},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, "O"}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"inserisciElabBatch",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

 public int aggiornaElabBatch( String strCodeElab, String strElemElaborati, String strElemScartati, String strScarti, String strReturnCode ) 
  throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "aggElabBatch";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeElab},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strElemElaborati},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strElemScartati},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strScarti},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strReturnCode}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"aggiornaElabBatch",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

 
 
 
 //public int inserimentoRipristino( String strCodeUtente, String strID_Evento, String strDataElaborazione) 
  public int inserimentoRipristino( String strCodeUtente, String strID_Evento, String strDataElaborazione,String CodIstProd,String strSistema_Mittente,String strCodTipoEvento,String strNoteRettifica) 
  throws CustomException, RemoteException
  {
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "InsEventoPreinvPerRipr";
     
     	/*
      try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeUtente},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strID_Evento},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strDataElaborazione}
                    };
      */
      try {
   /* MS 17/12/2009           
         String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeUtente},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strID_Evento},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strDataElaborazione},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, CodIstProd},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strSistema_Mittente}
                    }
                    ;
        */
    String[][] larr_CallSP={
               {lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeUtente},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strID_Evento},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strDataElaborazione},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, CodIstProd},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strSistema_Mittente},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodTipoEvento},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strNoteRettifica}
               }
               ;
        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"inserimentoRipristino",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public int inserimentoNoteRettificaRipristino( String code_istanza_prod, String strID_Evento, String motivazione) 
  throws CustomException, RemoteException
  {



      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "insNoteRettificaRipristino";
     
   try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_istanza_prod},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strID_Evento},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, motivazione}
                    };
  
        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                    "",
                  "inserimentoNoteRettificaRipristino",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
    }
  }


 
  
  public int removepreinvent( String param) throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "removepreinvent";

String[] values =  param.split("@");

     try   {

      if (values[2].compareToIgnoreCase("")==0){
        values[2]=null;
      }
      if (values[3].compareToIgnoreCase("")==0){
        values[3]=null;
      }

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, values[0]},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, values[1]},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, values[2]},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, values[3]},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, values[4]}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
                throw new CustomException(lexc_Exception.toString(),
                                                                        "",
                                                                        "removepreinvent",
                                                                        this.getClass().getName(),
                                                                        StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  public Vector getInventarioProdotti (String strCodeIstanzaProdotto )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getInventarioProdotti";

    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaProdotto}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_InventProd.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getInventariProdotti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  public Vector getstPrenvProdxCessazione (String strCodeIstanzaProdotto )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getstPrenvProdxCessazione";

    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaProdotto}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_InventProd.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                    "",
                  "getstPrenvProdxCessazione",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  public Vector getstPrenvCompoxCessazione (String strCodeIstanzaProdotto,String strCodeIstanzaCompo )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getstPrenvCompoxCessazione";

    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaProdotto},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaCompo}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_InventProd.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                    "",
                  "getstPrenvCompoxCessazione",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getstPrenvPrestAggxCessazione (String strCodeIstanzaProdotto,String strCodeIstanzaCompo, String strCodeIstanzaPrest )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getstPrenvPrestAggxCessazione";

    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaProdotto},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaCompo},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaPrest}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_InventProd.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                    "",
                  "getstPrenvPrestAggxCessazione",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  
  public Vector getInventarioComponenti (String strCodeIstanzaProdotto )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getInventarioComponenti";


    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaProdotto}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_InventCompo.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getInventariProdotti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getInventarioPrestazioni (String strCodeIstanzaProdotto )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getInventarioPrestAgg";


    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaProdotto}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_InventPrest.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getInventarioPrestAgg",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getInventarioAnagraficoPP   (String strCodeIstanzaProdotto )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getInventarioAnagraficoPP";


    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaProdotto}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_Invent_PP.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getInventarioAnagraficoPP",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getInventarioAnagraficoITC   (String strCodeIstanzaProdotto )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getInventarioAnagraficoITC";


    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaProdotto}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_Invent_ITC.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getInventarioAnagraficoITC",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getInventarioAnagraficoITCREV   (String strCodeIstanzaProdotto )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getInventarioAnagraficoITCREV";


    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaProdotto}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_Invent_ITC_REV.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getInventarioAnagraficoITCREV",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
/*fine vettori itc-itcrev*/

 public Vector getTipoCausaliNoVariazione   ()
 throws CustomException, RemoteException {

  Vector lvct_SPReturn = null;
  String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getTipoCausaliNoVariazione";


   try{
       String[][] larr_CallSP={
                   {lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   };

       lvct_SPReturn = this.callSP(larr_CallSP,DB_Servizio.class);
       Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
       return lvct_Return;
   }
   catch(Exception lexc_Exception){
     throw new CustomException(lexc_Exception.toString(),
                   "",
                 "getTipoCausaliNoVariazione",
                 this.getClass().getName(),
                 StaticContext.FindExceptionType(lexc_Exception));
   }
 }
 
  public Vector getServizi   ()
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getServizi";


    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_Servizio.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getServizi",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getCausali   ()
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getCausali";


    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_TipoCausaleNew.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCausali",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Integer getNewSequencePreinv()     throws CustomException, RemoteException {
     Vector    lvct_SPReturn = null;
     String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getNewSequencePreinv";

     try{
             String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getNewSequencePreinv",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }


  public Vector getInventarioAnagraficoMP  (String strCodeIstanzaProdotto ) 
  throws CustomException, RemoteException {
  
   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getInventarioAnagraficoMP";


    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaProdotto}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_Invent_MP.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getInventarioAnagraficoMP",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  

  public Vector getInventarioAnagraficoATM (String strCodeIstanzaProdotto )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getInventarioAnagraficoATM";


    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaProdotto}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_Invent_ATM.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getInventarioAnagraficoATM",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }


  public Vector getInventarioAnagraficoRPVD (String strCodeIstanzaProdotto )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getInventarioAnagraficoRPVD";


    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaProdotto}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_Invent_RPVD.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getInventarioAnagraficoRPVD",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }


  public Vector getInventarioComponente (String strCodeIstanzaComponente )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getInventarioComponente";

    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaComponente}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_InventCompo.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getInventariProdotti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }



  public String getDescrizioneAccount (String strCodeAccount )
  throws CustomException, RemoteException {

  Vector lvct_SPReturn = null;
  String  strDescAccount = null;
  String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getDescrizioneAccount";


    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeAccount}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        strDescAccount =(String)lvct_SPReturn.get(0);
        return strDescAccount;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDescrizioneAccount",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getDescrizioneOfferta (String strCodeOfferta )
  throws CustomException, RemoteException {

  Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getDescrizioneOfferta";


    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeOfferta}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        String  strDescAccount =(String)lvct_SPReturn.get(0);
        return strDescAccount;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDescrizioneOfferta",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getDescrizioneStato (String strCodeStato )
  throws CustomException, RemoteException {

  Vector lvct_SPReturn = null;
  String  strDescStato = null;
  String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getDescrizioneStato";


    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeStato}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        strDescStato =(String)lvct_SPReturn.get(0);
        return strDescStato;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDescrizioneStato",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getDescrizioneServizio (String strCodeServizio )
  throws CustomException, RemoteException {

  Vector lvct_SPReturn = null;
  String  strDescServizio = null;
  String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getDescrizioneServizio";


    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeServizio}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        strDescServizio =(String)lvct_SPReturn.get(0);
        return strDescServizio;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDescrizioneServizio",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getDescrizioneComponente (String strCodeComponente )
  throws CustomException, RemoteException {

  Vector lvct_SPReturn = null;
  String  strDescComponente = null;
  String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getDescrizioneComponente";


    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeComponente}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        strDescComponente =(String)lvct_SPReturn.get(0);
        return strDescComponente;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDescrizioneComponente",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }


  public String getDescrizioneProdotto (String strCodeProdotto )
  throws CustomException, RemoteException {

  Vector lvct_SPReturn = null;
  String  strDescProdotto = null;
  String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getDescrizioneProdotto";


    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeProdotto}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        strDescProdotto =(String)lvct_SPReturn.get(0);
        return strDescProdotto;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDescrizioneProdotto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getDescrizioneCausale (String strCodeCausale )
  throws CustomException, RemoteException {

  Vector lvct_SPReturn = null;
  String  strDescCausale = null;
  String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getDescrizioneCausale";


    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeCausale}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        strDescCausale =(String)lvct_SPReturn.get(0);
        return strDescCausale;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDescrizioneCausale",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }


  public String getDescrizioneCiclo (String strCodeCiclo )
  throws CustomException, RemoteException {

  Vector lvct_SPReturn = null;
  String  strDescrizioneCiclo = null;
  String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getDescrizioneCiclo";


    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeCiclo}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        strDescrizioneCiclo =(String)lvct_SPReturn.get(0);
        return strDescrizioneCiclo;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDescrizioneCiclo",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getOfferte (String strCodeServizio )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getOfferte";

    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeServizio}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_Offerta.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getOfferte",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getProdotti (String strCodeServizio, String strCodeOfferta )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getProdotti";

    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeServizio},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeOfferta}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_Prodotto.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getProdotti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }


  public Vector getComponenti (String strCodeServizio, String strCodeOfferta, String strCodeProdotto )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getComponenti";

    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeServizio},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeOfferta},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeProdotto}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_Componente.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getComponenti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getPrestazioniAggiuntive (String strCodeServizio, String strCodeOfferta, String strCodeProdotto, String strCodeComponente )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getPrestazioniAggiuntive";

    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeServizio},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeOfferta},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeProdotto},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeComponente}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_PrestazioneAggiuntiva.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPrestazioniAggiuntive",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getAccount (String strCodeServizio )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getAccount";

    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeServizio}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccount",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Integer insPreinventarioProdotti (DB_PreinventarioProdotti parProd)
  throws CustomException, RemoteException {

     Vector    lvct_SPReturn = null;
     String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "insPreinvProd";

     try{
             String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getID_SISTEMA_MITTENTE()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getID_EVENTO()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getID_TRANSAZIONE()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getCODE_EVENTO()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getCODE_TIPO_EVENTO()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getCODE_TIPO_EVENTO_HD()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getTIPO_ELAB()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getCODE_ACCOUNT()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getCODE_OFFERTA()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getCODE_SERVIZIO()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getCODE_PRODOTTO()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getCODE_ISTANZA_PROD()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_EFFETTIVA_EVENTO()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_RICEZIONE_ORDINE()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_RICHIESTA_CESSAZ()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_CREAZ()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_ULTIMA_FATRZ()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getQNTA_VALO()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getTIPO_FLAG_CONSISTENZA()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_INIZIO_NOL_ORIGINALE()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getCODICE_PROGETTO()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getINVARIANT_ID() }
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insPreinventarioProdotti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Integer insPreinventarioComponenti (DB_PreinventarioComponenti parCompo)
  throws CustomException, RemoteException {

     Vector lvct_SPReturn = null;
     String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "insPreinvCompo";

     try{
             String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parCompo.getID_SISTEMA_MITTENTE       ()},    
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parCompo.getID_EVENTO                 ()},    
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parCompo.getCODE_EVENTO               ()},    
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parCompo.getCODE_PRODOTTO             ()},    
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parCompo.getCODE_COMPONENTE           ()},    
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parCompo.getCODE_ISTANZA_PROD         ()},    
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parCompo.getCODE_ISTANZA_COMPO        ()},    
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parCompo.getDATA_EFFETTIVA_EVENTO     ()},    
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parCompo.getDATA_RICEZIONE_ORDINE     ()},    
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parCompo.getDATA_RICHIESTA_CESSAZ     ()},    
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parCompo.getDATA_ULTIMA_FATRZ         ()},    
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parCompo.getQNTA_VALO                 ()},    
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parCompo.getDATA_INIZIO_NOL_ORIGINALE ()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parCompo.getINVARIANT_ID() }
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insPreinventarioComponenti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Integer insPreinventarioPrestazioni (DB_PreinventarioPrestAgg parPrest)
  throws CustomException, RemoteException {

     Vector lvct_SPReturn = null;
     String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "insPreinvPrestAgg";

     try{
             String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPrest.getID_SISTEMA_MITTENTE       () },     																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPrest.getID_EVENTO                 () },     																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPrest.getCODE_EVENTO               () },     																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPrest.getCODE_PRODOTTO             () },     																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPrest.getCODE_COMPONENTE           () },     																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPrest.getCODE_PREST_AGG            () },     																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPrest.getCODE_ISTANZA_PROD         () },     																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPrest.getCODE_ISTANZA_COMPO        () },     																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPrest.getCODE_ISTANZA_PREST_AGG    () },     																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPrest.getDATA_EFFETTIVA_EVENTO     () },     																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPrest.getDATA_RICEZIONE_ORDINE     () },     																																																																																																																																																																						 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPrest.getDATA_RICHIESTA_CESSAZ     () },     																																																																																																																																																																						 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPrest.getDATA_ULTIMA_FATRZ         () },     																																																																																																																																																																						
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPrest.getQNTA_VALO                 () },    
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPrest.getDATA_INIZIO_NOL_ORIGINALE () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPrest.getINVARIANT_ID() }
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insPreinventarioPrestazioni",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Integer insPreinventarioPP (DB_PreinventarioPP parPP)
  throws CustomException, RemoteException {

     Vector lvct_SPReturn = null;
     String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "insPreinvPP";

     try{
             String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getID_SISTEMA_MITTENTE             () }, 																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getID_EVENTO                       () }, 																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getCODE_ISTANZA_PROD               () }, 																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getCODE_ISTANZA_COMPO              () }, 																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getCODE_ISTANZA_PREST_AGG          () }, 																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getDESC_NUM_ORDINE_CLIENTE         () }, 																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getDESC_NUM_ORDINE_CLIENTE_CESSAZ  () }, 																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getDESC_TIPO_TERMINAZIONE          () }, 																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getDESC_FRAZIONAMENTO              () }, 																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getDESC_SEDE_1                     () }, 																																																																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getDESC_TIPO_RETE_SEDE_1           () }, 																																																																																																																																																																						 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getDESC_IMPIANTO_SEDE_1            () }, 																																																																																																																																																																						 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getDESC_COMUNE_SEDE_1              () }, 																																																																																																																																																																						
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getDESC_PROVINCIA_SEDE_1           () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getDESC_DTRT_SEDE_1                () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getDESC_CENTRALE_SEDE_1            () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getDESC_SEDE_2           					() },																																											         
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getDESC_TIPO_RETE_SEDE_2 					() },																																											         
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getDESC_IMPIANTO_SEDE_2  					() },																																											         
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getDESC_COMUNE_SEDE_2    					() },																																											         
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getDESC_PROVINCIA_SEDE_2 					() },																																											         
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getDESC_DTRT_SEDE_2      					() },																																											         
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parPP.getDESC_CENTRALE_SEDE_2  					() },																																											         
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insPreinventarioPP",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Integer insPreinventarioMP (DB_PreinventarioMP parMP)
  throws CustomException, RemoteException {

     Vector lvct_SPReturn = null;
     String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "insPreinvMP";

     try{
             String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getID_SISTEMA_MITTENTE            	() } ,																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getID_EVENTO                      	() } ,																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getCODE_ISTANZA_PROD              	() } ,																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getCODE_ISTANZA_COMPO             	() } ,																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getCODE_ISTANZA_PREST_AGG         	() } ,																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getDESC_NUM_ORDINE_CLIENTE        	() } ,																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getDESC_NUM_ORDINE_CLIENTE_CESSAZ 	() } ,																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getDESC_TIPO_RETE                 	() } ,																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getDESC_SEDE_1                    	() } ,																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getDESC_IMPIANTO_SEDE_1           	() } ,																																																														 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getDESC_COMUNE_SEDE_1             	() } ,																																																																																																																						 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getDESC_PROVINCIA_SEDE_1          	() } ,																																																																																																																						 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getDESC_DTRT_SEDE_1               	() } ,																																																																																																																						
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getDESC_CENTRALE_SEDE_1            () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getDESC_SEDE_2                     () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getDESC_IMPIANTO_SEDE_2            () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getDESC_COMUNE_SEDE_2              () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getDESC_PROVINCIA_SEDE_2           () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getDESC_DTRT_SEDE_2                () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parMP.getDESC_CENTRALE_SEDE_2            () } ,
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insPreinventarioMP",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Integer insPreinventarioRPVD (DB_PreinventarioRPVD parRPVD)
  throws CustomException, RemoteException {

     Vector lvct_SPReturn = null;
     String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "insPreinvRPVD";

     try{
             String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getID_SISTEMA_MITTENTE            () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getID_EVENTO                      () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getCODE_ISTANZA_PROD              () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getCODE_ISTANZA_COMPO             () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getCODE_ISTANZA_PREST_AGG         () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getDESC_NUM_ORDINE_CLIENTE        () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getDESC_NUM_ORDINE_CLIENTE_CESSAZ () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getDESC_FLUSSO_TERMINAZ           () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getDESC_TIPO_RETE                 () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getDESC_SEDE_1                    () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getDESC_IMPIANTO_SEDE_1           () },																												 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getDESC_COMUNE_SEDE_1             () },																												 
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getDESC_PROVINCIA_SEDE_1          () },																												
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getDESC_DTRT_SEDE_1               () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getDESC_CENTRALE_SEDE_1           () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getDESC_SEDE_2                    () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getDESC_IMPIANTO_SEDE_2           () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getDESC_COMUNE_SEDE_2             () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getDESC_PROVINCIA_SEDE_2          () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getDESC_DTRT_SEDE_2               () },
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parRPVD.getDESC_CENTRALE_SEDE_2           () }
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insPreinventarioRPVD",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Integer insPreinventarioATM (DB_PreinventarioATM parATM )
  throws CustomException, RemoteException {

     Vector lvct_SPReturn = null;
     String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "insPreinvATM";

     try{
             String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getID_SISTEMA_MITTENTE            () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getID_EVENTO                      () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getTD_KIT                         () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getCODE_ISTANZA_PROD              () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getCODE_ISTANZA_COMPO             () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getCODE_ISTANZA_PREST_AGG         () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getDESC_NUM_ORDINE_CLIENTE        () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getDESC_NUM_ORDINE_CLIENTE_CESSAZ () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getDESC_TIPO_TERMINAZIONE         () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getDESC_FRAZIONAMENTO             () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getDESC_SEDE_1                    () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getDESC_TIPO_RETE_SEDE_1          () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getDESC_IMPIANTO_SEDE_1           () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getDESC_COMUNE_SEDE_1             () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getDESC_PROVINCIA_SEDE_1          () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getDESC_DTRT_SEDE_1               () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getDESC_CENTRALE_SEDE_1           () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getDESC_SEDE_2                    () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getDESC_TIPO_RETE_SEDE_2          () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getDESC_IMPIANTO_SEDE_2           () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getDESC_COMUNE_SEDE_2             () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getDESC_PROVINCIA_SEDE_2          () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getDESC_DTRT_SEDE_2               () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parATM.getDESC_CENTRALE_SEDE_2           () } 
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insPreinventarioATM",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Integer insPreinventarioITC (DB_PreinventarioITC parITC )
  throws CustomException, RemoteException {

     Vector lvct_SPReturn = null;
     String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "insPreinvITC";

     try{
             String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getID_SISTEMA_MITTENTE            () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getID_EVENTO                      () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getCODE_ISTANZA_PROD              () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getCODE_ISTANZA_COMPO             () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getCODE_ISTANZA_PREST_AGG         () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getDESC_NUM_ORDINE_CLIENTE        () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getDESC_NUM_ORDINE_CLIENTE_CESSAZ () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getDESC_SEDE_1                    () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getDESC_TIPO_RETE_SEDE_1          () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getDESC_TIPO_IMPIANTO_SEDE_1     () } ,                    
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getDESC_IMPIANTO_SEDE_1           () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getDESC_COMUNE_SEDE_1             () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getDESC_PROVINCIA_SEDE_1          () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getDESC_DTRT_SEDE_1               () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getDESC_CENTRALE_SEDE_1           () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getDESC_SEDE_2                    () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getDESC_TIPO_RETE_SEDE_2          () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getDESC_TIPO_IMPIANTO_SEDE_2     () } ,                                        
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getDESC_IMPIANTO_SEDE_2           () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getDESC_COMUNE_SEDE_2             () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getDESC_PROVINCIA_SEDE_2          () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getDESC_DTRT_SEDE_2               () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITC.getDESC_CENTRALE_SEDE_2           () } 
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insPreinventarioITC",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }


  public Integer insPreinventarioITCREV (DB_PreinventarioITCREV parITCREV )
  throws CustomException, RemoteException {

     Vector lvct_SPReturn = null;
     String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "insPreinvITCREV";

     try{
             String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getID_SISTEMA_MITTENTE            () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getID_EVENTO                      () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getCODE_ISTANZA_PROD              () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getCODE_ISTANZA_COMPO             () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getCODE_ISTANZA_PREST_AGG         () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getDESC_NUM_ORDINE_CLIENTE        () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getDESC_NUM_ORDINE_CLIENTE_CESSAZ () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getDESC_SEDE_1                    () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getDESC_TIPO_RETE_SEDE_1          () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getDESC_IMPIANTO_SEDE_1           () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getDESC_TIPO_IMPIANTO_SEDE_1           () } ,                    
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getDESC_COMUNE_SEDE_1             () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getDESC_PROVINCIA_SEDE_1          () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getDESC_DTRT_SEDE_1               () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getDESC_CENTRALE_SEDE_1           () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getDESC_SEDE_2                    () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getDESC_TIPO_RETE_SEDE_2          () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getDESC_TIPO_IMPIANTO_SEDE_2           () } ,                                        
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getDESC_IMPIANTO_SEDE_2           () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getDESC_COMUNE_SEDE_2             () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getDESC_PROVINCIA_SEDE_2          () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getDESC_DTRT_SEDE_2               () } ,
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parITCREV.getDESC_CENTRALE_SEDE_2           () } 
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insPreinventarioITCREV",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }








  public String getCodeIstanzaProd (String strCodeIstanzaProd ) throws CustomException, RemoteException {
  Vector lvct_SPReturn = null;
  String msg_return = null;
  String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getCodeIstanzaProd";
  

    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaProd}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

        if(lvct_Return.intValue() != -1){
          msg_return = "";
        }else{
          msg_return = "Codice Istanza Prodotto non presente in Inventario.";
        }
        return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCodeIstanzaProd",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getStoricoCodeIstanzaProdXRipr (String strCodeIstanzaProdotto) throws CustomException, RemoteException {

    Vector lvct_SPReturn = null;
    String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "getIdEventoPerRiprPerIstProd";

    try{
      String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaProdotto}
                    };

      lvct_SPReturn = this.callSP(larr_CallSP, DB_StoricoCodeIstanzaProd.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
      return lvct_Return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                "",
                "getStoricoCodeIstanzaProdXRipr",
                this.getClass().getName(),
                StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public int checkRettificaSuperRipr( String strCodeIstanzaProd,String strID_Evento,String strID_EventoIniz) throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "checkRettificaSuperRipr";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaProd},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strID_Evento},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strID_EventoIniz}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"checkRettificaSuperRipr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
    public int getCheckRipristino( String strCodeIstanzaProd) throws CustomException, RemoteException
    {      
        Vector lvct_SPReturn = null;
        String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "checkRipristino";

       try   {

          String[][] larr_CallSP={
                      {lstr_StoredProcedureName},
                      {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaProd}
                      };

          lvct_SPReturn = this.callSP(larr_CallSP);
          Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
          return lvct_Return.intValue();
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "getCheckRipristino",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }
    
  public int checkCodeStatoElem( String strCodeIstanzaProd) throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_EVENTI + "checkCodeStatoElem";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeIstanzaProd}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
                throw new CustomException(lexc_Exception.toString(),
                                                                        "",
                                                                        "checkCodeStatoElem",
                                                                        this.getClass().getName(),
                                                                        StaticContext.FindExceptionType(lexc_Exception));
    }
  } 
}
