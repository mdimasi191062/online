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

public class Ctr_TariffeNewBean extends AbstractClassicEJB implements SessionBean 
{
  Ent_TariffeNew lent_TariffeNew = null;
  Ent_TariffeNewHome lent_TariffeNewHome = null;
  Ent_RegoleTariffe lent_RegoleTariffe = null;
  Ent_RegoleTariffeHome lent_RegoleTariffeHome = null;

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

  public boolean RunningBatch() throws CustomException, RemoteException{
    String Response = null;
    Context lcls_Contesto = null;
    try{
      lcls_Contesto = new InitialContext();    

      Response = this.isRunningBatchNew(lcls_Contesto,StaticContext.CF_TARIFFE);

      if (Response!=null){
        return false;
      }
      else{
        return true;
      }
    }
    catch(Exception lexc_Exception){
      return false;
    }
  }
  public String InsUpdTariffa(Vector pvct_Tariffe, Vector pvct_Regole,Vector pvct_TariffeRif,int tipoTariffa) throws CustomException, RemoteException{

    String Response = null;
    Context lcls_Contesto = null;
    Object homeObject = null;

    try{
      lcls_Contesto = new InitialContext();

      //Controllo prima di tutto se sta girando un batch
      Response = this.isRunningBatchNew(lcls_Contesto,StaticContext.CF_TARIFFE);
      if (Response!=null){
        return "Attenzione : impossibile procedere alla modifica della struttura tariffaria per elaborazioni batch in corso.";
      }

      homeObject = lcls_Contesto.lookup("Ent_TariffeNew");
      lent_TariffeNewHome = (Ent_TariffeNewHome)PortableRemoteObject.narrow(homeObject, Ent_TariffeNewHome.class);
      lent_TariffeNew = lent_TariffeNewHome.create();

      homeObject = lcls_Contesto.lookup("Ent_RegoleTariffe");
      lent_RegoleTariffeHome = (Ent_RegoleTariffeHome)PortableRemoteObject.narrow(homeObject,Ent_RegoleTariffeHome.class);
      lent_RegoleTariffe = lent_RegoleTariffeHome.create();
        
      DB_TariffeNew objTariffa = (DB_TariffeNew)pvct_Tariffe.get(0);
    
      if(objTariffa.getCODE_TARIFFA().equals("")){
        Response = pstrInsertTariffe(pvct_Tariffe,pvct_Regole,pvct_TariffeRif,tipoTariffa);
      }
      else{
        Response = pstrUpdateTariffe(pvct_Tariffe,pvct_Regole,pvct_TariffeRif,tipoTariffa);      
      }
    }
    catch(Exception lexc_Exception) {
        Response = "Si è verificato un errore inaspettato. Contattare l'assistenza.";
        throw new RemoteException(lexc_Exception.toString());
    }    
    return Response;
  }

  private String pstrInsertTariffe(Vector pvct_Tariffe, Vector pvct_Regole,Vector pvct_TariffeRif,int tipoTariffa) throws CustomException, RemoteException{
    String Response = "";
    int int_Code_Tariffa = 0;
    int int_Pr_Code_Tariffa = 0;
    DB_TariffeNew lcls_tariffa = null;
    DB_RegolaTariffa lcls_regoleTariffa = null;
    boolean isPercent = false;
    String lstr_Oggi = "";
    int intTariffePersonalizzate = 0;

    try{
      lstr_Oggi = DataFormat.convertiData(DataFormat.setData(), StaticContext.FORMATO_DATA_ORA);
      //Controllo se ci già esiste una tariffa dello stesso tipo
      lcls_tariffa = (DB_TariffeNew)pvct_Tariffe.get(0);

/* 
 * Martino Marangi 02/12/2005 INIZIO 
 * inserita evolutiva per inserimento delle tariffe. a fronte di una ragola di tipo 13 : tariffa per account 
 * il controllo sull'esistenza della tariffa viene effettuato in maniera diversa verificando che non sia inserita 
 * la stessa regola (con relativo parametro) per la tariffa da inserire invecde dei canonici controlli*/

        /* Per tutte le regole che sono state inserite da on-line verifico*/
        for(int j=0;j<pvct_Regole.size();j++){
          lcls_regoleTariffa = (DB_RegolaTariffa)pvct_Regole.get(j);
            if (lcls_regoleTariffa.getCODE_REGOLA().equals ( "13" ) ) {
              intTariffePersonalizzate  = 1;
            }
        }

      if ( 1 == intTariffePersonalizzate ) {

        //Reperisco la sequence della tariffa se non sto facendo un update
        if (lcls_tariffa.getCODE_TARIFFA().equals("")){
          for(int j=0;j<pvct_Regole.size();j++){
            lcls_regoleTariffa = (DB_RegolaTariffa)pvct_Regole.get(j);
            if(lent_TariffeNew.existTariffaPersonalizzata(lcls_tariffa,lcls_regoleTariffa,tipoTariffa)){
              Response = "Esiste già una tariffa valida per l'oggetto di fatturazione e il gruppo di account che si desidera inserire.";
              return Response;
            }
          }
            int_Code_Tariffa = lent_TariffeNew.getSequenceTariffa(tipoTariffa);
        }
        else{
          int_Code_Tariffa = Integer.parseInt(lcls_tariffa.getCODE_TARIFFA());
        }
           
      }
      else  { /* Tariffe non personalizzate */
        //Reperisco la sequence della tariffa se non sto facendo un update
        if (lcls_tariffa.getCODE_TARIFFA().equals("")){
          if(lent_TariffeNew.existTariffa(lcls_tariffa,tipoTariffa)){
            Response = "Esiste già una tariffa valida per l'oggetto di fatturazione che si desidera inserire.";
            return Response;
          }
          int_Code_Tariffa = lent_TariffeNew.getSequenceTariffa(tipoTariffa);
        }
        else{
          int_Code_Tariffa = Integer.parseInt(lcls_tariffa.getCODE_TARIFFA());
        }
      }
        //inserisco le tariffe e le regole associate
        for(int i=0;i<pvct_Tariffe.size();i++){
          lcls_tariffa = (DB_TariffeNew)pvct_Tariffe.get(i);
          lcls_tariffa.setDATA_CREAZ_TARIFFA(lstr_Oggi);
          lcls_tariffa.setCODE_TARIFFA(String.valueOf(int_Code_Tariffa));
          int_Pr_Code_Tariffa = lent_TariffeNew.insertTariffa(lcls_tariffa,tipoTariffa);
          lcls_tariffa.setCODE_PR_TARIFFA(String.valueOf(int_Pr_Code_Tariffa));
        
          if(pvct_TariffeRif.size()>0){
            for(int z=0;z<pvct_TariffeRif.size();z++){
              lent_TariffeNew.insertTariffaXTariffaPerc(
                  lcls_tariffa,(String)pvct_TariffeRif.elementAt(z),tipoTariffa);
            }
          }
                
          for(int j=0;j<pvct_Regole.size();j++){
            lcls_regoleTariffa = (DB_RegolaTariffa)pvct_Regole.get(j);
            lent_RegoleTariffe.insertRegoleTariffa(Integer.parseInt(lcls_regoleTariffa.getCODE_REGOLA()),
                  int_Code_Tariffa,int_Pr_Code_Tariffa,lcls_regoleTariffa.getPARAMETRO(),tipoTariffa);
          }
        }    
      
    }
    catch(Exception lexc_Exception) {
        Response = "Si è verificato un errore inaspettato. Contattare l'assistenza.";
        throw new CustomException(lexc_Exception.toString(), "", "insertTariffe",
                      this.getClass().getName(), StaticContext.FindExceptionType(lexc_Exception));
    }    

    return Response;

  }
  private String pstrUpdateTariffe(Vector pvct_Tariffe, Vector pvct_Regole,Vector pvct_TariffeRif,int tipoTariffa) throws CustomException, RemoteException{
    String Response = "";

    Object homeObject = null;

    int int_Code_Tariffa = 0;

    DB_TariffeNew lcls_tariffa = null;
    DB_TariffeNew lcls_tariffaOld = null;
    Vector pvct_TariffeOld = null;
    Vector pvct_TariffeRifOld = null;
    Vector pvct_RegoleTariffeOld = null;
    String str_DataInizioValiditaOld = "";
    String str_listino_applicato = "";
    int intTariffePersonalizzate = 0;
    DB_RegolaTariffa lcls_regoleTariffa = null;
    
    try{
      //Controllo prima di tutto se sta girando un batch
      lcls_tariffa = (DB_TariffeNew)pvct_Tariffe.get(0);  
      int_Code_Tariffa = Integer.parseInt(lcls_tariffa.getCODE_TARIFFA());
      pvct_TariffeOld = lent_TariffeNew.getTariffa(int_Code_Tariffa,tipoTariffa);
      pvct_RegoleTariffeOld = lent_RegoleTariffe.getRegoleTariffa(int_Code_Tariffa,tipoTariffa); 
      pvct_TariffeRifOld = lent_TariffeNew.getListaTariffeRiferimXCode(int_Code_Tariffa,0); 
      lcls_tariffaOld = (DB_TariffeNew)pvct_TariffeOld.get(0); 
      str_listino_applicato = lcls_tariffaOld.getDESC_LISTINO_APPLICATO();
      str_DataInizioValiditaOld = ((DB_TariffeNew)pvct_TariffeOld.get(0)).getDATA_INIZIO_VALID();

/* 
 * Martino Marangi 02/12/2005 INIZIO 
 * inserita evolutiva per inserimento delle tariffe. a fronte di una ragola di tipo 13 : tariffa per account 
 * il controllo sull'esistenza della tariffa viene effettuato in maniera diversa verificando che non sia inserita 
 * la stessa regola (con relativo parametro) per la tariffa da inserire invecde dei canonici controlli*/

        /* Per tutte le regole che sono state inserite da on-line verifico*/
/*        for(int j=0;j<pvct_Regole.size();j++){
          lcls_regoleTariffa = (DB_RegolaTariffa)pvct_Regole.get(j);
            if (lcls_regoleTariffa.getCODE_REGOLA().equals ( "13" ) ) {
              intTariffePersonalizzate  = 1;
            }
        }

      if ( 1 == intTariffePersonalizzate ) {
            for(int j=0;j<pvct_Regole.size();j++){
              lcls_regoleTariffa = (DB_RegolaTariffa)pvct_Regole.get(j);
              if(lent_TariffeNew.existTariffaPersonalizzata(lcls_tariffa,lcls_regoleTariffa)){
                Response = "Esiste già una tariffa valida per l'oggetto di fatturazione e il gruppo di account che si desidera inserire.";
                return Response;
              }
          }
      }*/

 
      if(CheckModifiche(pvct_Tariffe,pvct_TariffeOld,pvct_Regole,pvct_RegoleTariffeOld,pvct_TariffeRif,pvct_TariffeRifOld)){
      
      
        //SE LA DATA INSERITA è MINORE DELLA DATA VALIDA
        //ELIMINO TUTTE LE TARIFFE CHE HANNO DATA INIZIO VALIDITA MAGGIORE E IL FLAG PROVV = "N"
        //ANNULLO TUTTE LE TARIFFE CHE HANNO DATA INIZIO VALIDITA MAGGIORE E IL FLAG PROVV <> "N"
        if (DataFormat.setData(str_DataInizioValiditaOld, StaticContext.FORMATO_DATA).getTime().getTime()
          >= DataFormat.setData(lcls_tariffa.getDATA_INIZIO_VALID(), StaticContext.FORMATO_DATA).getTime().getTime()){        
          if(lent_TariffeNew.isDeletable(int_Code_Tariffa,tipoTariffa)){
            pDeleteTariffaFromData(lcls_tariffa,tipoTariffa);
          }
          pAnnullaTariffeFromData(lcls_tariffa,tipoTariffa);
        }
        Response = pstrInsertTariffe(pvct_Tariffe,pvct_Regole,pvct_TariffeRif,tipoTariffa);
      }
   
      else if (!str_listino_applicato.equalsIgnoreCase(lcls_tariffa.getDESC_LISTINO_APPLICATO() )  ) {
        //inserisco le tariffe e le regole associate
        for(int i=0;i<pvct_Tariffe.size();i++){
          lcls_tariffa = (DB_TariffeNew)pvct_Tariffe.get(i);  
         lent_TariffeNew.updateTariffaListino(lcls_tariffa,0);
        }
        
      }
     
      else{
        Response = "Non è stato modificato nessun dato!";
      }
    }
    catch(Exception lexc_Exception) {
        Response = "Si è verificato un errore inaspettato. Contattare l'assistenza.";
        throw new CustomException(lexc_Exception.toString(), "", "insertTariffe",
                      this.getClass().getName(), StaticContext.FindExceptionType(lexc_Exception));
    }    

    return Response;

  }

  private void pAnnullaTariffeFromData(DB_TariffeNew lcls_tariffa,int tipoTariffa) throws CustomException, RemoteException{
    try{
       lent_TariffeNew.annullaTariffaFromData(lcls_tariffa,tipoTariffa);
    }
    catch(Exception lexc_Exception) {
        throw new CustomException(lexc_Exception.toString(), "", "pAnnullaTariffeFromData",
                      this.getClass().getName(), StaticContext.FindExceptionType(lexc_Exception));
    }    
  }

  public String DeleteTariffa(DB_TariffeNew lcls_tariffa,int tipoTariffa) throws CustomException, RemoteException{
    Context lcls_Contesto = null;
    Object homeObject = null;
    String Response = null;

    try{
      lcls_Contesto = new InitialContext();

      //Controllo prima di tutto se sta girando un batch
      Response = this.isRunningBatchNew(lcls_Contesto,StaticContext.CF_TARIFFE);
      if (Response!=null){
        return "Attenzione : impossibile procedere alla modifica della struttura tariffaria per elaborazioni batch in corso.";
      }

      homeObject = lcls_Contesto.lookup("Ent_TariffeNew");
      lent_TariffeNewHome = (Ent_TariffeNewHome)PortableRemoteObject.narrow(homeObject, Ent_TariffeNewHome.class);
      lent_TariffeNew = lent_TariffeNewHome.create();

      pDeleteTariffa(lcls_tariffa,tipoTariffa);
    }
    catch(Exception lexc_Exception) {
        Response = "Si è verificato un errore inaspettato. Contattare l'assistenza.";
        throw new RemoteException(lexc_Exception.toString());
    }    
    return Response;
  }      

  private void pDeleteTariffa(DB_TariffeNew lcls_tariffa,int tipoTariffa) throws CustomException, RemoteException{
    try{
       lent_TariffeNew.deleteTariffa(lcls_tariffa,tipoTariffa);
    }
    catch(Exception lexc_Exception) {
        throw new CustomException(lexc_Exception.toString(), "", "pDeleteTariffa",
                      this.getClass().getName(), StaticContext.FindExceptionType(lexc_Exception));
    }    
  }

  private void pDeleteTariffaFromData(DB_TariffeNew lcls_tariffa,int tipoTariffa) throws CustomException, RemoteException{
    try{
       lent_TariffeNew.deleteTariffaFromData(lcls_tariffa,tipoTariffa);
    }
    catch(Exception lexc_Exception) {
        throw new CustomException(lexc_Exception.toString(), "", "pDeleteTariffaFromData",
                      this.getClass().getName(), StaticContext.FindExceptionType(lexc_Exception));
    }    
  }

  private boolean CheckModifiche(Vector pvct_Tariffe, Vector pvct_TariffeOld,
      Vector pvct_RegoleTariffe,Vector pvct_RegoleTariffeOld,
      Vector pvct_TariffeRif,Vector pvct_TariffeRifOld)throws CustomException, RemoteException{

    Vector pvct_AppoTariffeRif = (Vector)pvct_TariffeRif.clone();
    DB_TariffeNew objTariffa = null;
    
    if(pvct_Tariffe.size()!=pvct_TariffeOld.size())
      return true;
    System.out.println("Tariffe stessa grandezza");
    if(pvct_RegoleTariffe.size()!=pvct_RegoleTariffeOld.size())
      return true;
    System.out.println("Regole stessa grandezza");      
    if(pvct_TariffeRif.size()!=pvct_TariffeRifOld.size())
      return true;
    System.out.println("Tariffe riferimento stessa grandezza");      
    if(!pvct_Tariffe.containsAll(pvct_TariffeOld))
      return true;
    System.out.println("Tariffe uguali");      
    if(!pvct_RegoleTariffe.containsAll(pvct_RegoleTariffeOld))
      return true;
    System.out.println("Regole uguali");        
    for(int i=0;i<pvct_TariffeRifOld.size();i++){
      objTariffa = (DB_TariffeNew)pvct_TariffeRifOld.elementAt(i);
      if(!pvct_AppoTariffeRif.removeElement(objTariffa.getCODE_TARIFFA())){
        return true;
      }
    }
    if(pvct_AppoTariffeRif.size()>0) return true; 
    System.out.println("Tariffe riferimento uguali");
      
    return false;
  }
}