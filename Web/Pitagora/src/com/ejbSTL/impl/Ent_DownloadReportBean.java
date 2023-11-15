package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;

import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public class Ent_DownloadReportBean extends AbstractClassicEJB implements SessionBean 
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

  public Vector getLstFunzionalita()throws CustomException, RemoteException{
    try{
      String lstr_StoredProcedure = StaticContext.PKG_DOWNLOAD + "getLstFunzionalita";
      String[][] larr_CallSP ={
                              {lstr_StoredProcedure},
                              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                              };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_DownloadReport_Funzionalita.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);            
      return lvct_Return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getLstFunzionalita",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
    public Vector getLstFunzionalitaCL()throws CustomException, RemoteException{
      try{
        String lstr_StoredProcedure = StaticContext.PKG_DOWNLOAD + "getLstFunzionalitaCL";
        String[][] larr_CallSP ={
                                {lstr_StoredProcedure},
                                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                                };

        Vector lcls_return =  this.callSP(larr_CallSP,DB_DownloadReport_Funzionalita.class);
        Vector lvct_Return = (Vector)lcls_return.get(0);            
        return lvct_Return;
      }
      catch(Exception lexc_Exception){
        throw new CustomException(lexc_Exception.toString(),
                        "",
                      "getLstFunzionalita",
                      this.getClass().getName(),
                      StaticContext.FindExceptionType(lexc_Exception));
      }
    }  
  public Vector getLstCicli(String strCodeFunz, String strTipoBatch,String strFlagSys)throws CustomException, RemoteException{
    try{
      String lstr_StoredProcedure = StaticContext.PKG_DOWNLOAD + "XDSL_getLstCicli";
      String[][] larr_CallSP ={
                              {lstr_StoredProcedure},
                              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeFunz},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strTipoBatch},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strFlagSys}
                              };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_DownloadReport_Periodi.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);            
      return lvct_Return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getLstCicli",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public Vector getLstTipoContr(String strCodeFunz, String strTipoBatch,String strFlagSys, String strCodeCiclo)throws CustomException, RemoteException{
    try{
      String lstr_StoredProcedure = StaticContext.PKG_DOWNLOAD + "XDSL_getLstTipoContr";
      String[][] larr_CallSP ={
                              {lstr_StoredProcedure},
                              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeFunz},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strTipoBatch},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strFlagSys},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeCiclo}
                              };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_DownloadReport_Servizi.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);            
      return lvct_Return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getLstTipoContr",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public Vector getLstAccount(String strCodeFunz, String strCodeTipoContr, String strCiclo, 
                              String strTipoBatch, String strFlagSys)throws CustomException, RemoteException{
    try{
      String lstr_StoredProcedure = StaticContext.PKG_DOWNLOAD + "XDSL_getLstAccount";
      String[][] larr_CallSP ={
                              {lstr_StoredProcedure},
                              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeFunz},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strTipoBatch},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strFlagSys},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeTipoContr},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCiclo}
                              };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_DownloadReport_Account.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);            
      return lvct_Return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getLstAccount",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public DB_DownloadReport_Funzionalita getParamFunzionalita(String strCodeFunz)throws CustomException, RemoteException{
    try{
      String lstr_StoredProcedure = StaticContext.PKG_DOWNLOAD + "XDSL_getParamFunzionalita";
      String[][] larr_CallSP ={
                              {lstr_StoredProcedure},
                              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeFunz}
                              };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_DownloadReport_Funzionalita.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      DB_DownloadReport_Funzionalita paramFunz = (DB_DownloadReport_Funzionalita)lvct_Return.get(0);
      return paramFunz;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getParamFunzionalita",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public DB_DownloadReport_Periodi getParamCiclo(String codeCiclo)throws CustomException, RemoteException
  {
    try{
      String lstr_StoredProcedure = StaticContext.PKG_DOWNLOAD + "xdsl_getparamciclo";
      String[][] larr_CallSP ={
                              {lstr_StoredProcedure},
                              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeCiclo}
                              };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_DownloadReport_Periodi.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      DB_DownloadReport_Periodi paramCiclo = (DB_DownloadReport_Periodi)lvct_Return.get(0);
      return paramCiclo;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getParamCiclo",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public DB_DownloadReport_Servizi getParamTipoContr(String codeServizio, String tipoBatch)throws CustomException, RemoteException
  { 
  DB_DownloadReport_Servizi paramTipoContr;
   /*  String tipoBatchSearch = "";
   
    switch (tipoBatch.charAt(0)){
    case 'V': tipoBatchSearch = "0";
    case 'R': tipoBatchSearch = "1";
    case 'M': tipoBatchSearch = "2";
   default:  tipoBatchSearch = "";
    }*/
  /*  if(tipoBatch.equals("V"))
      tipoBatchSearch = "0";
    else if(tipoBatch.equals("R"))
      tipoBatchSearch = "1";
    else if(tipoBatch.equals("M"))
      tipoBatchSearch = "2";
    else
      tipoBatchSearch = "";
      */
    try{
      String lstr_StoredProcedure = StaticContext.PKG_DOWNLOAD + "XDSL_getParamTipoContr";
      String[][] larr_CallSP ={
                              {lstr_StoredProcedure},
                              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeServizio},
                            //  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, tipoBatchSearch}
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, tipoBatch}
                              };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_DownloadReport_Servizi.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      if(lvct_Return.size() == 0){
        paramTipoContr = new DB_DownloadReport_Servizi();
        paramTipoContr.setCODE_TIPO_CONTR("");
        paramTipoContr.setDESC_TIPO_CONTR("");
        paramTipoContr.setFLAG_SYS("");
      }else{
        paramTipoContr = (DB_DownloadReport_Servizi)lvct_Return.get(0);
      }
      return paramTipoContr;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getParamTipoContr",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getDataDownload(String strCodeFunz, String strTipoBatch, String strQueryServizi, String strQueryPeriodi,
                                String strQueryAccount, String strEstensioneFile, String strEstensioneFileStorici,
                                String strPathReport, String strPathReportStorici, String strPathFileZip,
                                String strFlagSys, String strCodeServizio, String strCodeCiclo, 
                                String strCodeAccount, String strTipoFile)throws CustomException, RemoteException{
    String lstr_StoredProcedure = "";
    Vector lcls_return = null;
  /*  System.out.println("************************************************************************");
    System.out.println("getDataDownload - strCodeFunz              ["+strCodeFunz+"]");
    System.out.println("getDataDownload - strTipoBatch             ["+strTipoBatch+"]");
    System.out.println("getDataDownload - strQueryServizi          ["+strQueryServizi+"]");
    System.out.println("getDataDownload - strQueryPeriodi          ["+strQueryPeriodi+"]");
    System.out.println("getDataDownload - strQueryAccount          ["+strQueryAccount+"]");
    System.out.println("getDataDownload - strEstensioneFile        ["+strEstensioneFile+"]");
    System.out.println("getDataDownload - strEstensioneFileStorici ["+strEstensioneFileStorici+"]");
    System.out.println("getDataDownload - strPathReport            ["+strPathReport+"]");
    System.out.println("getDataDownload - strPathReportStorici     ["+strPathReportStorici+"]");
    System.out.println("getDataDownload - strPathFileZip           ["+strPathFileZip+"]");
    System.out.println("getDataDownload - strFlagSys               ["+strFlagSys+"]");
    System.out.println("getDataDownload - strCodeServizio          ["+strCodeServizio+"]");
    System.out.println("getDataDownload - strCodeCiclo             ["+strCodeCiclo+"]");    
    System.out.println("getDataDownload - strCodeAccount           ["+strCodeAccount+"]");    
    System.out.println("getDataDownload - strTipoFile              ["+strTipoFile+"]");        
    */
    try{
      if(!strQueryServizi.equals(""))
        lstr_StoredProcedure = StaticContext.PKG_DOWNLOAD + strQueryServizi;
      else if(!strQueryPeriodi.equals(""))
        lstr_StoredProcedure = StaticContext.PKG_DOWNLOAD + strQueryPeriodi;
      else if(!strQueryAccount.equals(""))
        lstr_StoredProcedure = StaticContext.PKG_DOWNLOAD + strQueryAccount;
      
      
      String[][] larr_CallSP ={
                              {lstr_StoredProcedure},
                              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeFunz},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strTipoBatch},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeCiclo},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeServizio},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeAccount},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strTipoFile},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strFlagSys}
                              };
      
      if(!strQueryServizi.equals(""))
        lcls_return =  this.callSP(larr_CallSP,DB_DownloadReport_Servizi.class);
      else if(!strQueryPeriodi.equals(""))
        lcls_return =  this.callSP(larr_CallSP,DB_DownloadReport_Periodi.class);
      else if(!strQueryAccount.equals(""))
        lcls_return =  this.callSP(larr_CallSP,DB_DownloadReport_Account.class);
      
      
      Vector lvct_Return = (Vector)lcls_return.get(0);            
      return lvct_Return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getDataDownload for ["+strQueryServizi+strQueryPeriodi+strQueryAccount+"]",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
}
