package com.ejbSTL.impl;

import com.utl.AbstractClassicEJB;
import com.utl.AbstractEJBTypes;
import com.utl.CustomException;
import com.utl.DBMessage;
import com.utl.DB_AliquotaIva;

import com.utl.DB_Gestori;
import com.utl.DB_PreOfferte;
import com.utl.StaticContext;

import java.rmi.RemoteException;

import java.util.Vector;

import javax.ejb.EJBException;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;

public class AliquotaIvaBean extends AbstractClassicEJB implements SessionBean
{
  private SessionContext _context;

  public void ejbCreate()
  {
  }

  public void setSessionContext(SessionContext context) throws EJBException
  {
    _context = context;
  }

  public void ejbRemove() throws EJBException
  {
  }

  public void ejbActivate() throws EJBException
  {
  }

  public void ejbPassivate() throws EJBException
  {
  }
  
  public Vector getAllAliquote() throws CustomException, RemoteException {
    
    try{

      String lstr_StoredProcedure = StaticContext.PACKAGE_SPECIAL_ONLINE + ".getAliquote";

      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                    AbstractEJBTypes.TYPE_VECTOR}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_AliquotaIva.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                  
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreAliquote",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }    
  }
  
  public Vector getAllAliquoteClassic() throws CustomException, RemoteException {
    
    try{

      String lstr_StoredProcedure = StaticContext.PACKAGE_SPECIAL_ONLINE + ".getAliquoteClassic";

      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                    AbstractEJBTypes.TYPE_VECTOR}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_AliquotaIva.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                  
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreAliquoteClassic",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }    
  }
  
  
  public String insAliquotaIvaClassic(DB_AliquotaIva aliquotaIva) throws CustomException, RemoteException {
    
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PACKAGE_SPECIAL_ONLINE + ".InsAliquoteClassic";
    String lstr_StoredProcedureName_error = StaticContext.PACKAGE_SPECIAL_ONLINE + ".getError";
    String msg_return = null;
    String iva = null;

    try   {

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, aliquotaIva.getCODE_ALIQUOTA()},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, aliquotaIva.getDESC_ALIQUOTA()},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, aliquotaIva.getALIQUOTA()},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, aliquotaIva.getDATA_INIZIO_VALID()}
                  //{AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, aliquotaIva.getDATA_FINE_VALID()}
                  };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
      
      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      
      return msg_return;
    }
    catch(Exception lexc_Exception){
    throw new CustomException(lexc_Exception.toString(),
                  "",
                "insAliquota",
                this.getClass().getName(),
                StaticContext.FindExceptionType(lexc_Exception));
    }

  }
  
  public String insAliquotaIva(DB_AliquotaIva aliquotaIva) throws CustomException, RemoteException {
    
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PACKAGE_SPECIAL_ONLINE + ".InsAliquote";
    String lstr_StoredProcedureName_error = StaticContext.PACKAGE_SPECIAL_ONLINE + ".getError";
    String msg_return = null;
    String iva = null;
    
    try {

      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, aliquotaIva.getCODE_ALIQUOTA()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,  aliquotaIva.getDESC_ALIQUOTA()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, aliquotaIva.getALIQUOTA()},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, aliquotaIva.getDATA_INIZIO_VALID()}
                  //{AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, aliquotaIva.getDATA_FINE_VALID()}
      };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      
      return msg_return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                    "",
                "insAliquota",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
    }
  
  }
  
  
  public String aggAliquotaIva(DB_AliquotaIva aliquotaIva) throws CustomException, RemoteException {
    
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PACKAGE_SPECIAL_ONLINE + ".aggAliquotaIva";
    String lstr_StoredProcedureName_error = StaticContext.PACKAGE_SPECIAL_ONLINE + ".getError";
    String msg_return = null;
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, aliquotaIva.getCODE_ALIQUOTA()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,  aliquotaIva.getDESC_ALIQUOTA()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, aliquotaIva.getALIQUOTA()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,  aliquotaIva.getDATA_INIZIO_VALID()},
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                    "",
                  "aggiorna_gestore",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
    }
  
  }
  
  
  public String aggAliquotaIvaClassic(DB_AliquotaIva aliquotaIva) throws CustomException, RemoteException {
    
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PACKAGE_SPECIAL_ONLINE + ".aggAliquotaIvaClassic";
    String lstr_StoredProcedureName_error = StaticContext.PACKAGE_SPECIAL_ONLINE + ".getError";
    String msg_return = null;
    
    try {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, aliquotaIva.getCODE_ALIQUOTA()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,  aliquotaIva.getDESC_ALIQUOTA()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, aliquotaIva.getALIQUOTA()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,  aliquotaIva.getDATA_INIZIO_VALID()},
      };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                      "",
                  "aggAliquotaIvaClassic",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  
}

  public String cancella_aliquotaIva(String code_aliquota) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PACKAGE_SPECIAL_ONLINE + ".cancella_aliquotaIva";
    String lstr_StoredProcedureName_error = StaticContext.PACKAGE_SPECIAL_ONLINE + ".getError";
    String msg_return = null;
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_aliquota}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue()==DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                    "",
                  "cancella aliquotaIva",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public String cancella_aliquotaIvaClassic(String code_aliquota) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PACKAGE_SPECIAL_ONLINE + ".cancella_aliquotaIvaClassic";
    String lstr_StoredProcedureName_error = StaticContext.PACKAGE_SPECIAL_ONLINE + ".getError";
    String msg_return = null;
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_aliquota}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue()==DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                    "",
                  "cancella aliquotaIvaClassic",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public Vector getPreAliquote_codAliquota(String codeAliquota)throws CustomException, RemoteException{
    try{

      String lstr_StoredProcedure = StaticContext.PACKAGE_SPECIAL_ONLINE + ".getprealiquote_codaliquota";

      String[][] larr_CallSP ={
          {lstr_StoredProcedure},
          {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeAliquota}
      };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_AliquotaIva.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                
      return lvct_Return;
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreAliquote_codAliquota",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }



  public Vector getPreAliquote_codAliquotaClassic(String codeAliquota)throws CustomException, RemoteException{
    try{

      String lstr_StoredProcedure = StaticContext.PACKAGE_SPECIAL_ONLINE + ".getprealiquote_codaliquotaC";

      String[][] larr_CallSP ={
          {lstr_StoredProcedure},
          {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeAliquota}
      };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_AliquotaIva.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                
      return lvct_Return;
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getprealiquote_codaliquotaC",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }


}