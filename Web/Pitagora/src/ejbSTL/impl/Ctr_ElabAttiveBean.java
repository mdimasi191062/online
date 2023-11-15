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

public class Ctr_ElabAttiveBean extends AbstractClassicEJB implements SessionBean 
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

  public Vector getElabAttive() throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + "getElabAttive";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ElabAttive.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getElabAttive",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public DB_ElabAttive getElabAttiva(String CodeFunz) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + "getElabAttiva";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, CodeFunz}                                                      
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ElabAttive.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return (DB_ElabAttive)lvct_Return.get(0);
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getElabAttiva(" + CodeFunz + ")",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getVerificaElabAttive(String CodeFunz) throws CustomException, RemoteException{
  
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + "getVerificaElabAttive";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, CodeFunz}                                    
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ElabBatch.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getVerificaElabAttive(" + CodeFunz + ")",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getAccountFromServizio(String CodeServizio) throws CustomException, RemoteException{
  
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + "getAccountFromServizio";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, CodeServizio}                                    
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_AccountNew.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountFromServizio(" + CodeServizio + ")",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getVerificaDettaglioElabAttive(String StoredProcedure,String CodeElab) throws CustomException, RemoteException{
  
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + StoredProcedure;

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, CodeElab}                                    
                  };
      Vector lvct_SPReturn;
      if(StoredProcedure.equals("getdettverificaResocontoSap"))
        lvct_SPReturn = this.callSP(larr_CallSP, DB_ElabBatchDettaglioResoconto.class);
      else
        lvct_SPReturn = this.callSP(larr_CallSP, DB_ElabBatchDettaglio.class);

      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getVerificaDettaglioElabAttive(" + StoredProcedure + "," + CodeElab + ")",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getVerificaDettaglioElabAttive(String StoredProcedure,String CodeElab,String DescAccGest) throws CustomException, RemoteException{
  
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + StoredProcedure;

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, CodeElab},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, DescAccGest}                  
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ElabBatchDettaglio.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getVerificaDettaglioElabAttive(" + StoredProcedure + "," + CodeElab + "," + DescAccGest + ")",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getScartiElabAttive(String StoredProcedure,String CodeGestoreAccount,String CodeElab) throws CustomException, RemoteException{
  
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + StoredProcedure;

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, CodeGestoreAccount},                                    
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, CodeElab},                  
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ScartiNew.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getScartiElabAttive(" + StoredProcedure + "," + CodeGestoreAccount + "," + CodeElab + ")",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public DB_ElabBatch getVerificaElabAttiva(String CodeFunz,String CodeElab) throws CustomException, RemoteException{
  
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + "getVerificaElabAttiva";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, CodeFunz},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, CodeElab}                  
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ElabBatch.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return (DB_ElabBatch)lvct_Return.get(0);
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getVerificaElabAttiva(" + CodeFunz + "," + CodeElab + ")",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getXmlServizi(String StoredProcedure) throws CustomException, RemoteException{
    String Ret = "";
    DB_Servizio lcls_Obj = null;
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + StoredProcedure;
    
    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Servizio.class);
      Vector lvct_Ret = (Vector)lvct_SPReturn.get(0);

      for (int i = 0;i < lvct_Ret.size();i++){

        lcls_Obj = (DB_Servizio)lvct_Ret.get(i);
        
        Ret += "<SERVIZIO ID=\"" + lcls_Obj.getCODE_SERVIZIO() + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_Obj.getDESC_SERVIZIO()) + "</DESC>";
        Ret += "</SERVIZIO>";
      }

      return Ret;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getXmlServizi(" + StoredProcedure + ")",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getXmlServizi(String StoredProcedure,String PeriodoRif) throws CustomException, RemoteException{
    String Ret = "";
    DB_Servizio lcls_Obj = null;
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + StoredProcedure;

    if(PeriodoRif.equals(""))
      PeriodoRif = null;
    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, PeriodoRif}                  
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Servizio.class);
      Vector lvct_Ret = (Vector)lvct_SPReturn.get(0);

      for (int i = 0;i < lvct_Ret.size();i++){

        lcls_Obj = (DB_Servizio)lvct_Ret.get(i);
        
        Ret += "<SERVIZIO ID=\"" + lcls_Obj.getCODE_SERVIZIO() + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_Obj.getDESC_SERVIZIO()) + "</DESC>";
        Ret += "</SERVIZIO>";
      }

      return Ret;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getXmlServizi(" + StoredProcedure + "," + PeriodoRif + ")",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getXmlAccount(String StoredProcedure) throws CustomException, RemoteException{
    String Ret = "";
    DB_AccountNew lcls_Obj = null;
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + StoredProcedure;
    
    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_AccountNew.class);
      Vector lvct_Ret = (Vector)lvct_SPReturn.get(0);

      for (int i = 0;i < lvct_Ret.size();i++){

        lcls_Obj = (DB_AccountNew)lvct_Ret.get(i);
        
        Ret += "<ACCOUNT ID=\"" + lcls_Obj.getCODE_ACCOUNT() + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_Obj.getDESC_ACCOUNT()) + "</DESC>";
        Ret += "<SERVIZIO>" + lcls_Obj.getCODE_SERVIZIO() + "</SERVIZIO>";        
        Ret += "</ACCOUNT>";
      }

      return Ret;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getXmlAccount(" + StoredProcedure + ")",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getXmlAccount(String StoredProcedure,String PeriodoRif) throws CustomException, RemoteException{
    String Ret = "";
    DB_AccountNew lcls_Obj = null;
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + StoredProcedure;
    
    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, PeriodoRif}                                    
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_AccountNew.class);
      Vector lvct_Ret = (Vector)lvct_SPReturn.get(0);

      for (int i = 0;i < lvct_Ret.size();i++){

        lcls_Obj = (DB_AccountNew)lvct_Ret.get(i);
        
        Ret += "<ACCOUNT ID=\"" + lcls_Obj.getCODE_ACCOUNT() + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_Obj.getDESC_ACCOUNT()) + "</DESC>";
        Ret += "<SERVIZIO>" + lcls_Obj.getCODE_SERVIZIO() + "</SERVIZIO>";        
        Ret += "</ACCOUNT>";
      }

      return Ret;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getXmlAccount(" + StoredProcedure + ")",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getXmlGestori(String StoredProcedure) throws CustomException, RemoteException{
    String Ret = "";
    DB_Gestori lcls_Obj = null;
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + StoredProcedure;
    
    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Gestori.class);
      Vector lvct_Ret = (Vector)lvct_SPReturn.get(0);

      for (int i = 0;i < lvct_Ret.size();i++){

        lcls_Obj = (DB_Gestori)lvct_Ret.get(i);
        
        Ret += "<GESTORE ID=\"" + lcls_Obj.getCODE_GESTORE() + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_Obj.getDESC_GESTORE()) + "</DESC>";
        Ret += "</GESTORE>";
      }

      return Ret;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getXmlGestori(" + StoredProcedure + ")",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
 
  }

  public String getXmlGestori(String StoredProcedure,String PeriodoRif) throws CustomException, RemoteException{

    String Ret = "";
    DB_Gestori lcls_Obj = null;
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + StoredProcedure;
    String strAnnoRif = "";
    String strMeseRif = "";    
    Vector vctSplit = null;
    Vector lvct_SPReturn = null;
   
    try{

      vctSplit = Misc.split(PeriodoRif,"-");

      if (vctSplit.size() == 2){
        strAnnoRif = (String)vctSplit.get(0);
        strMeseRif = (String)vctSplit.get(1);

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strAnnoRif},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strMeseRif}
                    };
        lvct_SPReturn = this.callSP(larr_CallSP, DB_Gestori.class);
      }
      else{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, PeriodoRif}
                    };
        lvct_SPReturn = this.callSP(larr_CallSP, DB_Gestori.class);
      }

      Vector lvct_Ret = (Vector)lvct_SPReturn.get(0);

      for (int i = 0;i < lvct_Ret.size();i++){

        lcls_Obj = (DB_Gestori)lvct_Ret.get(i);
        
        Ret += "<GESTORE ID=\"" + lcls_Obj.getCODE_GESTORE() + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_Obj.getDESC_GESTORE()) + "</DESC>";
        Ret += "</GESTORE>";
      }

      return Ret;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getXmlGestori(" + StoredProcedure + "," + PeriodoRif + ")",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
 
  }


  public Vector getPeriodoRiferimento(String StoredProcedure) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + StoredProcedure;

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

  //QS 06/12/2007-Modifica per GECOM: aggiunto alla funzione lancioBatch il flag checkInvioGecom
  public int lancioBatch(String pstr_CodeElab,String str_User,String str_Param,String str_PeriodoRif,
        String[] str_Gestori,
        String[] str_Servizi,
        String[] str_Account,
        String str_DataFinePeriodo,
        String ivaFc,
        boolean bol_AcquisizioneTldDaFile,boolean bol_CongelamentoSpesa,
        String strTextNomeFile, boolean bol_checkInvioGecom,String cinqueAnni,
        //String reprDel,String richEmissRepr,String dataDelib,String dataChiusAnnoCont,String motRepricing) throws CustomException, RemoteException
         String newParameter) throws CustomException, RemoteException
  {
    String msgRibes = "";
    String strFormatDataFine = "";
    Vector vctAccount = null;
    String strLocalAccount = "";
    DB_AccountNew lcls_acc = null;
    int i = 0;

    try     
    {

    if(!str_DataFinePeriodo.equals(""))
		strFormatDataFine = DataFormat.convertiData(DataFormat.setData(str_DataFinePeriodo,"dd/mm/yyyy"),"dd/mm/yyyy");
    //Code Elab
    msgRibes = pstr_CodeElab + StaticContext.RIBES_SEPARATORE_PARAMETRI;      

    //User 
    msgRibes += str_User + StaticContext.RIBES_SEPARATORE_PARAMETRI;   

    //*(underscore) per param
    msgRibes +=  StaticContext.RIBES_SEPARATORE_FUNZ_PARAMETRI + StaticContext.RIBES_SEPARATORE_PARAMETRI;     

    //Parametro aggiuntivo 
    if(!str_Param.equals(""))
    msgRibes += str_Param + StaticContext.RIBES_SEPARATORE_PARAMETRI2;    

    //Ciclo o code elab
    if (
       (!pstr_CodeElab.equals(StaticContext.RIBES_J2_SAP) ) && 
       (!pstr_CodeElab.equals(StaticContext.RIBES_J2_EXPORT_SWN_VAL) ) &&
       (!pstr_CodeElab.equals(StaticContext.RIBES_J2_EXPORT_SWN_REPR) ) &&
       (!pstr_CodeElab.equals(StaticContext.RIBES_J2_EXPORT_MENSILE) ) &&
       (!pstr_CodeElab.equals(StaticContext.RIBES_J2_EXPORT_REPRICING) ) &&
       (!pstr_CodeElab.equals(StaticContext.RIBES_J2_EXPORT_SAP_REPRICING) )
       )
    if (!str_PeriodoRif.equals("") && !pstr_CodeElab.equals(StaticContext.RIBES_J2_ELAB_PREINVE))
    msgRibes += str_PeriodoRif + StaticContext.RIBES_SEPARATORE_PARAMETRI2;  

   if  ( pstr_CodeElab.equals(StaticContext.RIBES_J2_CONSUNTIVO_SAP ) ) 
   {
      msgRibes += StaticContext.ELAB_ATTIVE_PARAM_DT_PERIOD + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
      msgRibes += strTextNomeFile + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
   } else 
   /* rm01 28/11/2005 Inizio */
   if ( pstr_CodeElab.equals(StaticContext.RIBES_J2_ALL_PREINVE) || 
        pstr_CodeElab.equals(StaticContext.RIBES_J2_ALL_PREINVE_OD) ||
        pstr_CodeElab.equals(StaticContext.RIBES_J2_ALL_PRE_CATALOGO) ||
        pstr_CodeElab.equals(StaticContext.RIBES_J2_ALL_PREINVE_CRM) ||
     pstr_CodeElab.equals(StaticContext.RIBES_J2_ALL_PREINVE_CRM_JPUB)
        )
   {
       msgRibes += pstr_CodeElab + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
   /* rm01 28/11/2005 Fine */
    
   }else if ( ( pstr_CodeElab.equals(StaticContext.RIBES_J2_EXPORT_SWN_VAL) ) || 
        ( pstr_CodeElab.equals(StaticContext.RIBES_J2_EXPORT_SWN_REPR ) ) || 
        ( pstr_CodeElab.equals(StaticContext.RIBES_J2_EXPORT_MENSILE ) )  ||
        ( pstr_CodeElab.equals(StaticContext.RIBES_J2_EXPORT_REPRICING ) ) 
      ){
      msgRibes += pstr_CodeElab + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
      msgRibes += StaticContext.ELAB_ATTIVE_PARAM_PARAMETRI + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
      msgRibes += strTextNomeFile + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
      msgRibes += str_PeriodoRif ;
      //QS: 06/12/2007 INIZIO modifica per export GECOM 
      if (bol_checkInvioGecom){
        msgRibes += StaticContext.RIBES_SEPARATORE_PARAMETRI2 + "1";
      }
      else if (pstr_CodeElab.equals(StaticContext.RIBES_J2_EXPORT_MENSILE) || 
               pstr_CodeElab.equals(StaticContext.RIBES_J2_EXPORT_REPRICING)){
        msgRibes += StaticContext.RIBES_SEPARATORE_PARAMETRI2 + "0";
      }
     //QS: 06/12/2007 FINE modifica per export GECOM 
      if(str_Servizi!=null && str_Servizi.length > 0){
       msgRibes += StaticContext.RIBES_SEPARATORE_PARAMETRI2 + StaticContext.ELAB_ATTIVE_PARAM_SERVIZI + StaticContext.RIBES_SEPARATORE_PARAMETRI2;     
       for(i=0;i<str_Servizi.length;i++){
          msgRibes += str_Servizi[i] + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
        }
      }
   }
   else
   if ( pstr_CodeElab.equals(StaticContext.RIBES_J2_SAP) ||
        pstr_CodeElab.equals(StaticContext.RIBES_J2_EXPORT_SAP_REPRICING ) 
      ) {

      if(str_Servizi!=null && str_Servizi.length > 0){
        msgRibes += StaticContext.ELAB_ATTIVE_PARAM_SERVIZI + StaticContext.RIBES_SEPARATORE_PARAMETRI2;     
        msgRibes += str_PeriodoRif + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
        if(!strFormatDataFine.equals(""))            
        msgRibes += strFormatDataFine + StaticContext.RIBES_SEPARATORE_PARAMETRI2; 

        for(i=0;i<str_Servizi.length;i++){
          msgRibes += str_Servizi[i] + StaticContext.RIBES_SEPARATORE_PARAMETRI2;

        }

        if(pstr_CodeElab.equals(StaticContext.RIBES_J2_EXPORT_SAP_REPRICING ))
          msgRibes += "R";
      }
   }
   else
    if (!pstr_CodeElab.equals(StaticContext.RIBES_J2_VALMIGR) )  {
    
      if(str_Gestori!=null && str_Gestori.length > 0){
        msgRibes += StaticContext.ELAB_ATTIVE_PARAM_GESTORI + StaticContext.RIBES_SEPARATORE_PARAMETRI2;     
        if(!strFormatDataFine.equals(""))      
        msgRibes += strFormatDataFine + StaticContext.RIBES_SEPARATORE_PARAMETRI2;     
        for(i=0;i<str_Gestori.length;i++){
          msgRibes += str_Gestori[i] + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
        }
      }

      if(pstr_CodeElab.equals(StaticContext.RIBES_J2_REPRICING))
      {
        msgRibes += StaticContext.ELAB_ATTIVE_PARAM_IVA_FC + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
        msgRibes += ivaFc + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
        
        msgRibes += StaticContext.ELAB_ATTIVE_PARAM_CINQUE_ANNI + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
        msgRibes += cinqueAnni + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
          
          msgRibes += StaticContext.ELAB_ATTIVE_PARAM_REPRICING + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
          //msgRibes += reprDel + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
          //msgRibes += richEmissRepr + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
          //msgRibes += dataDelib + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
          //msgRibes += dataChiusAnnoCont + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
          //msgRibes += motRepricing + "'" + StaticContext.RIBES_SEPARATORE_PARAMETRI2; 
           msgRibes += newParameter + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
      }
      
      if(pstr_CodeElab.equals(StaticContext.RIBES_J2_VALORIZ))
        {          
          msgRibes += StaticContext.ELAB_ATTIVE_PARAM_CINQUE_ANNI + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
          msgRibes += cinqueAnni + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
      }
      
      if(str_Servizi!=null && str_Servizi.length > 0){
        msgRibes += StaticContext.ELAB_ATTIVE_PARAM_SERVIZI + StaticContext.RIBES_SEPARATORE_PARAMETRI2;     
        if(!strFormatDataFine.equals(""))            
        msgRibes += strFormatDataFine + StaticContext.RIBES_SEPARATORE_PARAMETRI2;     
        for(i=0;i<str_Servizi.length;i++){
          msgRibes += str_Servizi[i] + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
        }
      }

      if(str_Account!=null && str_Account.length > 0){
        msgRibes += StaticContext.ELAB_ATTIVE_PARAM_ACCOUNT + StaticContext.RIBES_SEPARATORE_PARAMETRI2;     
        if(!strFormatDataFine.equals(""))            
        msgRibes += strFormatDataFine + StaticContext.RIBES_SEPARATORE_PARAMETRI2;     
        for(i=0;i<str_Account.length;i++){
          msgRibes += str_Account[i] + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
        }
      }

      if(pstr_CodeElab.equals(StaticContext.RIBES_J2_ELAB_PREINVE)){
        //msgRibes += StaticContext.ELAB_ATTIVE_PARAM_ACCOUNT + StaticContext.RIBES_SEPARATORE_PARAMETRI2;     
        if(!strFormatDataFine.equals(""))            
        msgRibes += strFormatDataFine + StaticContext.RIBES_SEPARATORE_PARAMETRI2;     
        /*for(i=0;i<str_Account.length;i++){
          msgRibes += str_Account[i] + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
        }*/
      }
    }
    else {

      msgRibes += StaticContext.ELAB_ATTIVE_PARAM_VAL_MIGR + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
      if(str_Account!=null && str_Account.length > 0){
        for ( int a = 0 ;a< str_Account.length ; a++ ) {
          msgRibes += str_Account[a] + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
        }
      }

     /* Trascodifica dei servizi in account */
        if(str_Servizi!=null && str_Servizi.length > 0) {
            for(i=0;i<str_Servizi.length;i++){
                vctAccount = getAccountFromServizio(str_Servizi[i]);
                for ( int a = 0; a< vctAccount.size() ;a++) {
                    lcls_acc = (DB_AccountNew) vctAccount.elementAt(a);
                    strLocalAccount =lcls_acc.getCODE_ACCOUNT();
                    msgRibes += strLocalAccount + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
                }
            }
        }
    }
    /*mm02 24/03/2005 fine gestione per valorizzazione migrazione*/

    if(bol_AcquisizioneTldDaFile){
      msgRibes += StaticContext.ELAB_ATTIVE_PARAM_TLD_FILE + StaticContext.RIBES_SEPARATORE_PARAMETRI2;        
      msgRibes += "S" + StaticContext.RIBES_SEPARATORE_PARAMETRI2;              
    }

    if(bol_CongelamentoSpesa){
      msgRibes += StaticContext.ELAB_ATTIVE_PARAM_CONG_SPESA + StaticContext.RIBES_SEPARATORE_PARAMETRI2;        
    }
    System.out.println(msgRibes);

    StaticMessages.setCustomString(msgRibes);
    StaticContext.writeLog(StaticMessages.getMessage(3011,msgRibes));
        
 		String[][] larr_CallSP =
				{{StaticContext.PKG_LANCIOBATCH + "Send_Request"},
				 {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
				 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, "SEND"},
				 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, msgRibes},
				 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, null},
 				 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, str_User},
				 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, null},
				 {AbstractEJBTypes.PARAMETER_OUTPUT, AbstractEJBTypes.TYPE_STRUCT, "EXTERNAL_LIBRARY_OBJ"}
				};

		Vector lvct_SPReturn = this.callSP(larr_CallSP);
		Integer lint_Return = (Integer)lvct_SPReturn.get(0);

    return lint_Return.intValue();

    }
    catch(Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"lancioBatch(" + pstr_CodeElab + "," + str_Gestori + "," + str_Servizi + ","
                  + str_Account + "," + str_DataFinePeriodo + ")",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

  }

  public String getDescErrore(int CodeErrore)throws CustomException, RemoteException{

    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + "getDescError";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER,String.valueOf(CodeErrore)},                  
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP);
      String lstr_Return = (String)lvct_SPReturn.get(0);

      return lstr_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDescErrore(" + String.valueOf(CodeErrore) + ")",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  
  }

  public DB_WebUplFiles getWebUpl(String CodeFunz) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + "getWebUpl";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, CodeFunz}                                                      
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_WebUplFiles.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return (DB_WebUplFiles)lvct_Return.get(0);
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getWebUpl(" + CodeFunz + ")",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }


  public Vector getWebUplFile() throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + "getWebUplFile";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_WebUplFiles.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getWebUplFile",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public int insertElabPreinve(String codice_ciclo) throws CustomException, RemoteException{
  
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + "insertElabPreinve";
    
    try{
      System.out.println("insertElabPreinve - CODICE_CICLO => ["+codice_ciclo+"]");
      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codice_ciclo}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return.intValue();
      
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insertElabPreinve(" + codice_ciclo + ")",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public int insGruppoAccount (String strDescGruppo , String strDataInizioValid,  String strCodeAccount,  String strCodeRelazione ) throws CustomException, RemoteException{
  
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + "InserisciGruppo";
    
    try{
      System.out.println("InserisciGruppo - Gruppo => ["+strDescGruppo+"] strDataInizioValid [" + strDataInizioValid + "] Account [" + strCodeAccount + "] Relazione [" + strCodeRelazione + "]");
      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strDescGruppo},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strDataInizioValid},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeAccount},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeRelazione}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return.intValue();
      
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"InserisciGruppo(" + strDescGruppo + ") strDataInizioValid (" + strDataInizioValid + ")",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getValueUplFile ( ) throws CustomException, RemoteException{
  
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + "getValueUplFile";
    
    try{
      System.out.println("getValueUplFile");
      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP);
      String lint_Return = (String)lvct_SPReturn.get(0);

      return lint_Return;
      
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getValueUplFile",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  //QS 06/12/2007-Modifica per GECOM: aggiunto alla funzione lancioBatch il flag checkInvioGecom
  public int lancioBatchResocontoSAP(String pstr_CodeElab,String str_User,
                                     String str_ParamJPUB2,String str_ParamJPUBS,
                                     String str_CodeCiclo) throws CustomException, RemoteException
  {
    String msgRibes = "";

    try     
    {

      //Code Elab
      msgRibes = pstr_CodeElab + StaticContext.RIBES_SEPARATORE_PARAMETRI;      

      //User 
      msgRibes += str_User + StaticContext.RIBES_SEPARATORE_PARAMETRI;   

      //*(underscore) per param
      msgRibes +=  StaticContext.RIBES_SEPARATORE_FUNZ_PARAMETRI + StaticContext.RIBES_SEPARATORE_PARAMETRI;     
      
      str_ParamJPUB2 = str_ParamJPUB2.replace("|"," ");
      str_ParamJPUBS = str_ParamJPUBS.replace("|"," ");      
      
      //Parametro aggiuntivo 
      if(!str_ParamJPUB2.equals("") || !str_ParamJPUBS.equals(""))
      {
        msgRibes += StaticContext.ELAB_ATTIVE_PARAM_RES_SAP_JPUB2 + StaticContext.RIBES_SEPARATORE_PARAMETRI2 + str_ParamJPUB2 + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
        msgRibes += StaticContext.ELAB_ATTIVE_PARAM_RES_SAP_JPUBS + StaticContext.RIBES_SEPARATORE_PARAMETRI2 + str_ParamJPUBS + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
      }else{
        msgRibes += StaticContext.ELAB_ATTIVE_PARAM_RES_SAP_CICLO + StaticContext.RIBES_SEPARATORE_PARAMETRI2 + str_CodeCiclo + StaticContext.RIBES_SEPARATORE_PARAMETRI2;
      }
      
      System.out.println(msgRibes);
  
      StaticMessages.setCustomString(msgRibes);
      StaticContext.writeLog(StaticMessages.getMessage(3011,msgRibes));

      String[][] larr_CallSP =
          {{StaticContext.PKG_LANCIOBATCH + "Send_Request"},
           {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
           {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, "SEND"},
           {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, msgRibes},
           {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, null},
           {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, str_User},
           {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, null},
           {AbstractEJBTypes.PARAMETER_OUTPUT, AbstractEJBTypes.TYPE_STRUCT, "EXTERNAL_LIBRARY_OBJ"}
          };

      Vector lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return.intValue();
    }
    catch(Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(),
                    "",
                  "lancioBatchResocontoSAP(" + pstr_CodeElab +","+str_User+","+str_ParamJPUB2+","+str_ParamJPUBS+","+str_CodeCiclo + ")",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
    }

  }

 public int lancioProgDigDiv(String pstr_CodeElab,String str_User,
                                    String str_ParamANNO) throws CustomException, RemoteException
 {
   String msgRibes = "";

   try     
   {

     //Code Elab
     msgRibes = pstr_CodeElab + StaticContext.RIBES_SEPARATORE_PARAMETRI;      

     //User 
     msgRibes += str_User + StaticContext.RIBES_SEPARATORE_PARAMETRI;   

     //*(underscore) per param
     msgRibes +=  StaticContext.RIBES_SEPARATORE_FUNZ_PARAMETRI + StaticContext.RIBES_SEPARATORE_PARAMETRI;     
     
     //Parametro aggiuntivo 
       msgRibes += str_ParamANNO + StaticContext.RIBES_SEPARATORE_PARAMETRI2;

     
     System.out.println(msgRibes);
 
     StaticMessages.setCustomString(msgRibes);
     StaticContext.writeLog(StaticMessages.getMessage(3011,msgRibes));

     String[][] larr_CallSP =
         {{StaticContext.PKG_LANCIOBATCH + "Send_Request"},
          {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, "SEND"},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, msgRibes},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, null},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, str_User},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, null},
          {AbstractEJBTypes.PARAMETER_OUTPUT, AbstractEJBTypes.TYPE_STRUCT, "EXTERNAL_LIBRARY_OBJ"}
         };

     Vector lvct_SPReturn = this.callSP(larr_CallSP);
     Integer lint_Return = (Integer)lvct_SPReturn.get(0);

     return lint_Return.intValue();
   }
   catch(Exception lexc_Exception)
   {
     throw new CustomException(lexc_Exception.toString(),
                   "",
                 "lancioProgDigDiv(" + pstr_CodeElab +","+str_User+","+str_ParamANNO+")",
                 this.getClass().getName(),
                 StaticContext.FindExceptionType(lexc_Exception));
   }

 }


  public Vector getVerificaElabAttiveResocontoSap(String CodeFunz) throws CustomException, RemoteException{
  
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + "getVerElabAttiveResocontoSap";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, CodeFunz}                                    
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ElabBatchResocontoSAP.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                    "",
                  "getVerElabAttiveResocontoSap(" + CodeFunz + ")",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
    }
  } 
  
  
  public DB_ElabBatchResocontoSAP getVerificaElabAttivaResoconto(String CodeFunz,String CodeElab) throws CustomException, RemoteException{
  
    String lstr_StoredProcedureName = StaticContext.PKG_ELAB_ATTIVE + "getVerificaElabAttivaResoconto";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, CodeFunz},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, CodeElab}                  
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_ElabBatchResocontoSAP.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return (DB_ElabBatchResocontoSAP)lvct_Return.get(0);
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                    "",
                  "getVerificaElabAttiva(" + CodeFunz + "," + CodeElab + ")",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
    }
  }
}