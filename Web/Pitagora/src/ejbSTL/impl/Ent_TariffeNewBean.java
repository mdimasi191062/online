package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import com.utl.*;
import java.util.Vector;
import java.rmi.RemoteException;

public class Ent_TariffeNewBean extends AbstractClassicEJB implements SessionBean 
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

  public Vector getListaTariffeRiferimXPerc(int CodeServizio,int CodeOfferta,
      int CodeClasse,int CodeFascia,int tipoTariffa )throws CustomException, RemoteException{

    try{
      String lstr_StoredProcedure="";
      // TARIFFE_VERIFICA
      if (tipoTariffa != 0 ) {
        lstr_StoredProcedure = StaticContext.PKG_TARIFFE_VERIFICA + "getListaTariffeRiferimXPerc";
      } else{
        lstr_StoredProcedure = StaticContext.PKG_TARIFFE_NEW + "getListaTariffeRiferimXPerc";
      }
      String[][] larr_CallSP ={{lstr_StoredProcedure},
      {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
      {AbstractEJBTypes.PARAMETER_INPUT,AbstractEJBTypes.TYPE_INTEGER,String.valueOf(CodeServizio)},
      {AbstractEJBTypes.PARAMETER_INPUT,AbstractEJBTypes.TYPE_INTEGER,String.valueOf(CodeOfferta)},      
      {AbstractEJBTypes.PARAMETER_INPUT,AbstractEJBTypes.TYPE_INTEGER,String.valueOf(CodeClasse)},
      {AbstractEJBTypes.PARAMETER_INPUT,AbstractEJBTypes.TYPE_INTEGER,String.valueOf(CodeFascia)},      
      };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_TariffeNew.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                  
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getListaTariffeRiferimXPerc(" + CodeServizio + "," 
                        + CodeOfferta + "," 
                        + CodeClasse + "," 
                        + CodeFascia + ")",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getListaTariffeRiferimXCode(int CodeTariffaPerc,int tipoTariffa)throws CustomException, RemoteException{

    try{
      String lstr_StoredProcedure="";
      // TARIFFE_VERIFICA
      if (tipoTariffa != 0 ) {
        lstr_StoredProcedure = StaticContext.PKG_TARIFFE_VERIFICA + "getListaTariffeRiferimXCode";
      } else{
      lstr_StoredProcedure = StaticContext.PKG_TARIFFE_NEW + "getListaTariffeRiferimXCode";
      }
      String[][] larr_CallSP ={{lstr_StoredProcedure},
      {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
      {AbstractEJBTypes.PARAMETER_INPUT,AbstractEJBTypes.TYPE_INTEGER,String.valueOf(CodeTariffaPerc)},
      };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_TariffeNew.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                  
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getListaTariffeRiferimXCode(" + CodeTariffaPerc +  ")",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getListaTariffe(int CodeServizio,int CodeOfferta,
      int CodeProdotto,int CodeComponente,int CodePrestazioneAggiuntiva,int tipoTariffa)throws CustomException, RemoteException{

    try{
      String lstr_StoredProcedure="";
      // TARIFFE_VERIFICA
      if (tipoTariffa != 0 ) {
        lstr_StoredProcedure = StaticContext.PKG_TARIFFE_VERIFICA + "GETLISTATARIFFE";
      } else{
      lstr_StoredProcedure = StaticContext.PKG_TARIFFE_NEW + "GETLISTATARIFFE";
      }
      String[][] larr_CallSP ={{lstr_StoredProcedure},
      {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
      {AbstractEJBTypes.PARAMETER_INPUT,AbstractEJBTypes.TYPE_INTEGER,String.valueOf(CodeServizio)},
      {AbstractEJBTypes.PARAMETER_INPUT,AbstractEJBTypes.TYPE_INTEGER,String.valueOf(CodeOfferta)},      
      {AbstractEJBTypes.PARAMETER_INPUT,AbstractEJBTypes.TYPE_INTEGER,String.valueOf(CodeProdotto)},
      {AbstractEJBTypes.PARAMETER_INPUT,AbstractEJBTypes.TYPE_INTEGER,String.valueOf(CodeComponente)},
      {AbstractEJBTypes.PARAMETER_INPUT,AbstractEJBTypes.TYPE_INTEGER,String.valueOf(CodePrestazioneAggiuntiva)},      
      };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_TariffeNew.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                  
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getListaTariffe(" + CodeServizio + "," + CodeOfferta + "," + CodeProdotto + "," + CodeComponente + "," + CodePrestazioneAggiuntiva + ")",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public int getSequenceTariffa(int tipoTariffa)throws CustomException, RemoteException{

    try{
      String lstr_StoredProcedure="";
      // TARIFFE_VERIFICA
      if (tipoTariffa != 0 ) {
        lstr_StoredProcedure = StaticContext.PKG_TARIFFE_VERIFICA + "getSequenceTariffa";
      } else{
      lstr_StoredProcedure = StaticContext.PKG_TARIFFE_NEW + "getSequenceTariffa";
      }

   
      
      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_INTEGER}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_TariffeNew.class);
      Integer lvct_Return = (Integer)lcls_return.get(0);
                  
      return lvct_Return.intValue();
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getTariffaSequence",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }


  public int insertTariffa(DB_TariffeNew p_Tariffa,int tipoTariffa)throws CustomException, RemoteException{

    try{
      String lstr_StoredProcedure="";
      // TARIFFE_VERIFICA
      if (tipoTariffa != 0 ) {
        lstr_StoredProcedure = StaticContext.PKG_TARIFFE_VERIFICA + "insertTariffa";
      } else{
      lstr_StoredProcedure = StaticContext.PKG_TARIFFE_NEW + "insertTariffa";
      }


      
      String[][] larr_CallSP ={{lstr_StoredProcedure},
        {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_INTEGER},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_TARIFFA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_OFFERTA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_SERVIZIO()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_PRODOTTO()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_COMPONENTE()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_PREST_AGG()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_TIPO_CAUSALE()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_FASCIA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_PR_FASCIA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_OGGETTO_FATRZ()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_CLAS_SCONTO()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_PR_CLAS_SCONTO()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_UNITA_MISURA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_MODAL_APPL_TARIFFA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_MODAL_APPL_RATEI()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getVALO_FREQ_APPL()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_UTENTE()},        
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getDATA_INIZIO_VALID()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getDATA_CREAZ_TARIFFA()},        
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getTIPO_FLAG_CONG_REPR()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getTIPO_FLAG_PROVVISORIA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getTIPO_FLAG_ANT_POST()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getQNTA_SHIFT_CANONI()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_DOUBLE, p_Tariffa.getIMPT_TARIFFA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_TIPO_ARROTONDAMENTO()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getDESC_LISTINO_APPLICATO()},        
        
        
        };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_TariffeNew.class);
      Integer lvct_Return = (Integer)lcls_return.get(0);
                  
      return lvct_Return.intValue();
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "insertTariffa",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public int updateTariffaListino(DB_TariffeNew p_Tariffa,int tipoTariffa)throws CustomException, RemoteException{

    try{
      String lstr_StoredProcedure="";

      lstr_StoredProcedure = StaticContext.PKG_TARIFFE_NEW + "updateTariffaListino";
      
      String[][] larr_CallSP ={{lstr_StoredProcedure},
        {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_INTEGER},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_TARIFFA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_PR_TARIFFA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getDESC_LISTINO_APPLICATO()}
        };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_TariffeNew.class);
      Integer lvct_Return = (Integer)lcls_return.get(0);
                  
      return lvct_Return.intValue();
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "updateTariffaListino",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
  }
  }
  public int updateTariffa(DB_TariffeNew p_Tariffa,int tipoTariffa)throws CustomException, RemoteException{

    try{
      String lstr_StoredProcedure="";
      // TARIFFE_VERIFICA
      if (tipoTariffa != 0 ) {
        lstr_StoredProcedure = StaticContext.PKG_TARIFFE_VERIFICA + "updateTariffa";
      } else{
      lstr_StoredProcedure = StaticContext.PKG_TARIFFE_NEW + "updateTariffa";
      }

  
      
      String[][] larr_CallSP ={{lstr_StoredProcedure},
        {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_INTEGER},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_TARIFFA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_PR_TARIFFA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_OFFERTA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_SERVIZIO()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_PRODOTTO()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_COMPONENTE()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_PREST_AGG()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_TIPO_CAUSALE()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_FASCIA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_PR_FASCIA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_OGGETTO_FATRZ()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_CLAS_SCONTO()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_PR_CLAS_SCONTO()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_UNITA_MISURA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_MODAL_APPL_TARIFFA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_MODAL_APPL_RATEI()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getVALO_FREQ_APPL()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_UTENTE()},        
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getDATA_INIZIO_VALID()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getDATA_FINE_VALID()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getDATA_CREAZ_TARIFFA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getTIPO_FLAG_CONG_REPR()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getTIPO_FLAG_PROVVISORIA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getTIPO_FLAG_ANT_POST()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getQNTA_SHIFT_CANONI()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getIMPT_TARIFFA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getDESC_LISTINO_APPLICATO()},
        };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_TariffeNew.class);
      Integer lvct_Return = (Integer)lcls_return.get(0);
                  
      return lvct_Return.intValue();
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "updateTariffa",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
  }
 } 
 public Vector getTariffa(int CODE_TARIFFA,int tipoTariffa)throws CustomException, RemoteException{
    try{
      String lstr_StoredProcedure ="";
      // TARIFFE_VERIFICA
      if (tipoTariffa != 0 ) {
        lstr_StoredProcedure = StaticContext.PKG_TARIFFE_VERIFICA + "getTariffa";
      } else{
      lstr_StoredProcedure = StaticContext.PKG_TARIFFE_NEW + "getTariffa";
      }
      String[][] larr_CallSP ={{lstr_StoredProcedure},
        {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, String.valueOf(CODE_TARIFFA)},
        };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_TariffeNew.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                  
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getTariffa(" + CODE_TARIFFA + ")",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
  }
 }

/* 
 * Martino Marangi 02/12/2005 INIZIO  
 * 
 * Inserito nuovo metodo che effettua la verifica sulla esistenza della tariffa che si sta
 * tentando di inserire.... viene effettuata anche la verifica sulle regole.
 */

  public boolean existTariffaPersonalizzata(DB_TariffeNew lcls_tariffa, DB_RegolaTariffa lcls_regoleTariffa,int tipoTariffa) throws CustomException, RemoteException{
     try{
        
       String lstr_StoredProcedure ="";
       // TARIFFE_VERIFICA
       if (tipoTariffa != 0 ) {
         lstr_StoredProcedure = StaticContext.PKG_TARIFFE_VERIFICA + "existTariffaPersonalizzata";
       } else{
       lstr_StoredProcedure = StaticContext.PKG_TARIFFE_NEW + "existTariffaPersonalizzata";
       }
        
      
        String[][] larr_CallSP ={{lstr_StoredProcedure},
          {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_INTEGER},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, lcls_tariffa.getCODE_SERVIZIO()},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, lcls_tariffa.getCODE_OFFERTA()},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, lcls_tariffa.getCODE_PRODOTTO()},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, lcls_tariffa.getCODE_COMPONENTE()},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, lcls_tariffa.getCODE_PREST_AGG()},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, lcls_tariffa.getCODE_OGGETTO_FATRZ()},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, lcls_tariffa.getCODE_TIPO_CAUSALE()},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, lcls_regoleTariffa.getCODE_REGOLA()},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, lcls_regoleTariffa.getPARAMETRO()},
          };

        Vector lcls_return =  this.callSP(larr_CallSP,DB_TariffeRegole.class);
        Integer lvct_Return = (Integer)lcls_return.get(0);
                  
        if(lvct_Return.intValue()>0)
          return true;
        else
          return false;
     }
     catch(Exception lexc_Exception){
    
        throw new CustomException(lexc_Exception.toString(),
                        "",
                      "existTariffaPersonalizzata()",
                      this.getClass().getName(),
                      StaticContext.FindExceptionType(lexc_Exception));
    }    
  }


/* 
 * Martino Marangi 02/12/2005 FINE  
 */
  public boolean existTariffa(DB_TariffeNew lcls_tariffa,int tipoTariffa) throws CustomException, RemoteException{
     try{
        String lstr_StoredProcedure ="";
   
       // TARIFFE_VERIFICA
       if (tipoTariffa != 0 ) {
         lstr_StoredProcedure = StaticContext.PKG_TARIFFE_VERIFICA + "existTariffa";
       } else{
         lstr_StoredProcedure = StaticContext.PKG_TARIFFE_NEW + "existTariffa";
       }
        
      
        String[][] larr_CallSP ={{lstr_StoredProcedure},
          {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_INTEGER},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, lcls_tariffa.getCODE_SERVIZIO()},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, lcls_tariffa.getCODE_OFFERTA()},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, lcls_tariffa.getCODE_PRODOTTO()},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, lcls_tariffa.getCODE_COMPONENTE()},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, lcls_tariffa.getCODE_PREST_AGG()},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, lcls_tariffa.getCODE_OGGETTO_FATRZ()},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, lcls_tariffa.getCODE_TIPO_CAUSALE()},
          };

        Vector lcls_return =  this.callSP(larr_CallSP,DB_TariffeNew.class);
        Integer lvct_Return = (Integer)lcls_return.get(0);
                  
        if(lvct_Return.intValue()>0)
          return true;
        else
          return false;
     }
     catch(Exception lexc_Exception){
    
        throw new CustomException(lexc_Exception.toString(),
                        "",
                      "existTariffa()",
                      this.getClass().getName(),
                      StaticContext.FindExceptionType(lexc_Exception));
    }    
  }

  public void deleteTariffa(DB_TariffeNew p_Tariffa,int tipoTariffa)throws CustomException, RemoteException{

    try{
      String lstr_StoredProcedure="";
      // TARIFFE_VERIFICA
      if (tipoTariffa != 0 ) {
        lstr_StoredProcedure = StaticContext.PKG_TARIFFE_VERIFICA + "deleteTariffa";
      } else{
      lstr_StoredProcedure = StaticContext.PKG_TARIFFE_NEW + "deleteTariffa";
      }

      
      String[][] larr_CallSP ={{lstr_StoredProcedure},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_TARIFFA()},
        };

      this.callSP(larr_CallSP,DB_TariffeNew.class);
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "deleteTariffa",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public void annullaTariffaFromData(DB_TariffeNew p_Tariffa,int tipoTariffa)throws CustomException, RemoteException{

    try{
      String lstr_StoredProcedure="";
      // TARIFFE_VERIFICA
      if (tipoTariffa != 0 ) {
        lstr_StoredProcedure = StaticContext.PKG_TARIFFE_VERIFICA + "annullaTariffaFromData";
      } else{
      lstr_StoredProcedure = StaticContext.PKG_TARIFFE_NEW + "annullaTariffaFromData";
      }

    
      
      String[][] larr_CallSP ={{lstr_StoredProcedure},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_TARIFFA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getDATA_INIZIO_VALID()},        
        };

      this.callSP(larr_CallSP,DB_TariffeNew.class);
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "annullaTariffaFromData",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public void deleteTariffaFromData(DB_TariffeNew p_Tariffa,int tipoTariffa)throws CustomException, RemoteException{

    try{
      String lstr_StoredProcedure="";
      // TARIFFE_VERIFICA
      if (tipoTariffa != 0 ) {
        lstr_StoredProcedure = StaticContext.PKG_TARIFFE_VERIFICA + "deleteTariffeFromData";
      } else{
        lstr_StoredProcedure = StaticContext.PKG_TARIFFE_NEW + "deleteTariffeFromData";
      }

   
      
      String[][] larr_CallSP ={{lstr_StoredProcedure},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_TARIFFA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getDATA_INIZIO_VALID()},        
        };

      this.callSP(larr_CallSP,DB_TariffeNew.class);
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "deleteTariffaFromData",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }

 public Vector getStoricoTariffa(int CODE_TARIFFA,int tipoTariffa)throws CustomException, RemoteException{
    try{
      String lstr_StoredProcedure ="";
     // TARIFFE_VERIFICA
     if (tipoTariffa != 0 ) {
       lstr_StoredProcedure = StaticContext.PKG_TARIFFE_VERIFICA + "getStoricoTariffa";
     } else{
     lstr_StoredProcedure = StaticContext.PKG_TARIFFE_NEW + "getStoricoTariffa";
     }
      String[][] larr_CallSP ={{lstr_StoredProcedure},
        {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, String.valueOf(CODE_TARIFFA)},
        };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_TariffeNew.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                  
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getStoricoTariffa(" + CODE_TARIFFA + ")",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
  }
 }
 public boolean isDeletable(int CODE_TARIFFA,int tipoTariffa)throws CustomException, RemoteException{
    try{
      String lstr_StoredProcedure ="";
      // TARIFFE_VERIFICA
      if (tipoTariffa != 0 ) {
       lstr_StoredProcedure = StaticContext.PKG_TARIFFE_VERIFICA + "isDeletable";
      } else{
      lstr_StoredProcedure = StaticContext.PKG_TARIFFE_NEW + "isDeletable";
      }

    
      
      String[][] larr_CallSP ={{lstr_StoredProcedure},
        {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, String.valueOf(CODE_TARIFFA)},
        };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_TariffeNew.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                  
      if(lvct_Return.size() > 0)
        return false;
      else
        return true;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "isDeletable(" + CODE_TARIFFA + ")",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
  }
 }

  public void insertTariffaXTariffaPerc(DB_TariffeNew p_Tariffa,String CodeTariffaRif,int tipoTariffa)throws CustomException, RemoteException{

    try{
      String lstr_StoredProcedure="";
        // TARIFFE_VERIFICA
        if (tipoTariffa != 0 ) {
          lstr_StoredProcedure = StaticContext.PKG_TARIFFE_VERIFICA + "insertTariffaXTariffaPerc";
        } else{
        lstr_StoredProcedure = StaticContext.PKG_TARIFFE_NEW + "insertTariffaXTariffaPerc";
        }

 
      String[][] larr_CallSP ={{lstr_StoredProcedure},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_TARIFFA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_PR_TARIFFA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, CodeTariffaRif},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_FASCIA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_PR_FASCIA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_CLAS_SCONTO()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_PR_CLAS_SCONTO()},        
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getDESC_LISTINO_APPLICATO()}        
        };

      this.callSP(larr_CallSP,DB_TariffeNew.class);
    
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "insertTariffaXTariffaPerc",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }
 
}

