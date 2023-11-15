package com.ejbSTL.impl;

import com.ejbSTL.Ctr_ElabAttiveHome;
import com.ejbSTL.Ent_RegoleTariffe;
import com.ejbSTL.Ent_RegoleTariffeHome;
import com.ejbSTL.Ctr_TariffeNew;
import com.ejbSTL.Ctr_TariffeNewHome;

import com.ejbSTL.Ent_TariffeNew;
import com.ejbSTL.Ent_TariffeNewHome;

import javax.ejb.SessionBean;
import javax.ejb.SessionContext;

import com.utl.*;

import java.util.Vector;

import java.rmi.RemoteException;

import java.net.*;


import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;


public class Ent_AccordoBean extends AbstractClassicEJB implements SessionBean
{
  //  Ctr_TariffeNew lctr_TariffeNew = null;
  //  Ctr_TariffeNewHome lctr_TariffeNewHome = null;
    
    Ent_TariffeNew lent_TariffeNew = null;
    Ent_TariffeNewHome lent_TariffeNewHome = null;
    Ent_RegoleTariffe lent_RegoleTariffe = null;
    Ent_RegoleTariffeHome lent_RegoleTariffeHome = null;
    DB_TariffeNew lcls_tariffa = null;
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
  public Vector getOfferte()throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_ACCORDI + "getOfferte";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                        {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                      };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_Offerta.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getOfferte()",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }
  
  
  public Vector getOggettiFatturazione()throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_ACCORDI + "getOggettiFatturazione";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                        {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                      };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_OggettoFatturazioneNew.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getOggettiFatturazione()",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }
    public int insINVENTARIO_PRODOTTI(DB_InventProd parProd
    ,Connection pcls_Connection)
    throws CustomException, RemoteException {

       Vector    lvct_SPReturn = null;
       String lstr_StoredProcedureName = StaticContext.PKG_ACCORDI + "insINVENTARIO_PRODOTTI";

       try{
              
               String[][] larr_CallSP={
                      {lstr_StoredProcedureName},
                      {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(parProd.getTIPO_CAUSALE_ATT())},   
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(parProd.getCODE_STATO_ELEM())},   
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(parProd.getCODE_ACCOUNT())},   
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(parProd.getCODE_OFFERTA ())},   
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(parProd.getCODE_SERVIZIO())},   
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(parProd.getCODE_PRODOTTO())},   
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getCODE_ISTANZA_PROD()},  
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_INIZIO_VALID()},  
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_FINE_VALID()},   
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_INIZIO_FATRZ()},  
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_FINE_FATRZ()},   
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_INIZIO_FATRB()},  
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_FINE_FATRB()},   
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(parProd.getQNTA_VALO())},  
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getCODE_UTENTE_CREAZ()}
                      };

          lvct_SPReturn = this.callSP(larr_CallSP);
          //lvct_SPReturn = this.callSPparConn(larr_CallSP,pcls_Connection);
          Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
          return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "insINVENTARIO_PRODOTTI",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }
  /*  public int insACCORDI_ALL(DB_InventProd parProd ,DB_Accordo parAccordo,
    DB_TariffeNew parTariffe, DB_RegolaTariffa parRegole,
    )
    throws CustomException, RemoteException {

       Vector    lvct_SPReturn = null;
       String lstr_StoredProcedureName = StaticContext.PKG_ACCORDI + "insACCORDI_ALL";

       try{
              
               String[][] larr_CallSP={
                      {lstr_StoredProcedureName},
                      {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(parProd.getTIPO_CAUSALE_ATT())},   
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(parProd.getCODE_STATO_ELEM())},   
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(parProd.getCODE_ACCOUNT())},   
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(parProd.getCODE_OFFERTA ())},   
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(parProd.getCODE_SERVIZIO())},   
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(parProd.getCODE_PRODOTTO())},   
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getCODE_ISTANZA_PROD()},  
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_INIZIO_VALID()},  
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_FINE_VALID()},   
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_INIZIO_FATRZ()},  
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_FINE_FATRZ()},   
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_INIZIO_FATRB()},  
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_FINE_FATRB()},   
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(parProd.getQNTA_VALO())},  
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getCODE_UTENTE_CREAZ()},  
                      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, parProd.getDATA_CREAZ ()},  
                  
                      };

          lvct_SPReturn = this.callSP(larr_CallSP);
          Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
          return lvct_Return;
      }
      catch(Exception lexc_Exception){
                  throw new CustomException(lexc_Exception.toString(),
                                                                          "",
                                                                          "insACCORDI_ALL",
                                                                          this.getClass().getName(),
                                                                          StaticContext.FindExceptionType(lexc_Exception));
      }
    }
    */
   public void deleteRegolexTariffe(DB_Accordo objAccordo)throws CustomException, RemoteException{

      try{
        
        String lstr_StoredProcedure = StaticContext.PKG_ACCORDI + "deleteRegolexTariffe";
       

        
        String[][] larr_CallSP ={{lstr_StoredProcedure},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordo.getCODE_TARIFFA()},
           {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordo.getCODE_PR_TARIFFA()},
          };

        this.callSP(larr_CallSP,DB_Accordo.class);
        
      }
      catch(Exception lexc_Exception){
      
        throw new CustomException(lexc_Exception.toString(),
                        "",
                      "deleteRegolexTariffe",
                      this.getClass().getName(),
                      StaticContext.FindExceptionType(lexc_Exception));
      }
    }
   public void EliminaAccordo(DB_Accordo objAccordo)throws CustomException, RemoteException{

     try{
       
       String lstr_StoredProcedure = StaticContext.PKG_ACCORDI + "EliminaAccordo";
      

       
       String[][] larr_CallSP ={{lstr_StoredProcedure},
         {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordo.getCODE_ACCORDO()},
         };

       this.callSP(larr_CallSP,DB_Accordo.class);
       
     }
     catch(Exception lexc_Exception){
     
       throw new CustomException(lexc_Exception.toString(),
                       "",
                     "EliminaAccordo",
                     this.getClass().getName(),
                     StaticContext.FindExceptionType(lexc_Exception));
     }
   }
  public Vector getAccordo(String codeAccordo) throws CustomException, 
                                                      RemoteException
  {

    try
    {

      Vector lvct_SPReturn = null;
      String lstr_StoredProcedure = StaticContext.PKG_ACCORDI + "getAccordo";

      String[][] larr_CallSP =
      {
        { lstr_StoredProcedure },
        { AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR },
        { AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, 
          codeAccordo } };

      lvct_SPReturn = this.callSP(larr_CallSP, DB_Accordo.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);


      return lvct_Return;

    } catch (Exception lexc_Exception)
    {

      throw new CustomException(lexc_Exception.toString(), "", "getAccordo", 
                                this.getClass().getName(), 
                                StaticContext.FindExceptionType(lexc_Exception));
    }

  }
  public Vector getAccordi(String codeOfferta) throws CustomException, 
                                                      RemoteException
  {

    try
    {

      String lstr_StoredProcedure = StaticContext.PKG_ACCORDI + "getAccordi";

      String[][] larr_CallSP =
      {
        { lstr_StoredProcedure },
        { AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR },
        { AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, 
          codeOfferta } };

      Vector lcls_return = this.callSP(larr_CallSP, DB_Accordo.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);


      return lvct_Return;

    } catch (Exception lexc_Exception)
    {

      throw new CustomException(lexc_Exception.toString(), "", "getAccordi", 
                                this.getClass().getName(), 
                                StaticContext.FindExceptionType(lexc_Exception));
    }

  }

  private String createXML(Vector lvct_Ret)
  {

    DB_Accordo lcls_Accordo = null;
    String Ret = "";
    String lstr_CodePro = "";

    for (int i = 0; i < lvct_Ret.size(); i++)
    {

      lcls_Accordo = (DB_Accordo)lvct_Ret.get(i);
      lstr_CodePro = lcls_Accordo.getCODE_ACCORDO();

      Ret += "<Accordo ID=\"" + lstr_CodePro + "\">";
      Ret += 
          "<DESC>" + Utility.encodeXML(lcls_Accordo.getDESC_ACCORDO()) + "</DESC>";

      while (lstr_CodePro.equals(lcls_Accordo.getCODE_ACCORDO()))
      {
        Ret += "<PAR>";
        //       Ret += "<SERVIZIO>" + lcls_Accordo.getCODE_SERVIZIO() + "</SERVIZIO>";
        Ret += "<OFFERTA>" + lcls_Accordo.getCODE_OFFERTA() + "</OFFERTA>";
        Ret += "</PAR>";
        i++;
        if (i >= lvct_Ret.size())
          break;
        lcls_Accordo = (DB_Accordo)lvct_Ret.get(i);
      }
      i--;
      Ret += "</Accordo>";
    }

    return Ret;
  }
  public int CheckAccordixOfferta(String code_offerta) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    String lstr_StoredProcedureName = StaticContext.PKG_ACCORDI + "CheckAccordixOfferta";
  
    try{
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_offerta},
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                    "",
                  "CheckAccordixOfferta",
                  this.getClass().getName(),                              
                  StaticContext.FindExceptionType(lexc_Exception));
    }


  }
  public int pinsertTariffa(DB_TariffeNew p_Tariffa,int tipoTariffa)throws CustomException, RemoteException{

    try{
      String lstr_StoredProcedure="";
       lstr_StoredProcedure= StaticContext.PKG_ACCORDI + "insertTariffa";
      
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
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getDATA_FINE_VALID()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getDATA_CREAZ_TARIFFA()},        
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getTIPO_FLAG_CONG_REPR()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getTIPO_FLAG_PROVVISORIA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getTIPO_FLAG_ANT_POST()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getQNTA_SHIFT_CANONI()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_DOUBLE, p_Tariffa.getIMPT_TARIFFA()},
        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, p_Tariffa.getCODE_TIPO_ARROTONDAMENTO()}
        
        };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_TariffeNew.class);
      Integer lvct_Return = (Integer)lcls_return.get(0);
                  
      return lvct_Return.intValue();
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "pinsertTariffa",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
    private String pstrInsertTariffe(Vector pvct_Tariffe, Vector pvct_Regole,Vector pvct_TariffeRif,int tipoTariffa)
    throws CustomException, RemoteException{
      String Response = "";
      int int_Code_Tariffa = 0;
      int int_Pr_Code_Tariffa = 0;
     
      DB_RegolaTariffa lcls_regoleTariffa = null;
      boolean isPercent = false;
      String lstr_Oggi = "";

      int intTariffePersonalizzate = 0;

        
        Context lcls_Contesto = null;
        Object homeObject = null;

      try{
          lcls_Contesto = new InitialContext();
          lstr_Oggi = DataFormat.convertiData(DataFormat.setData(), StaticContext.FORMATO_DATA_ORA);
        //Controllo se ci già esiste una tariffa dello stesso tipo
        lcls_tariffa = (DB_TariffeNew)pvct_Tariffe.get(0);
        
          homeObject = lcls_Contesto.lookup("Ent_TariffeNew");
             lent_TariffeNewHome = (Ent_TariffeNewHome)PortableRemoteObject.narrow(homeObject, Ent_TariffeNewHome.class);
             lent_TariffeNew = lent_TariffeNewHome.create();

             homeObject = lcls_Contesto.lookup("Ent_RegoleTariffe");
             lent_RegoleTariffeHome = (Ent_RegoleTariffeHome)PortableRemoteObject.narrow(homeObject,Ent_RegoleTariffeHome.class);
             lent_RegoleTariffe = lent_RegoleTariffeHome.create();
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
       /*     if(lent_TariffeNew.existTariffa(lcls_tariffa,tipoTariffa)){
              Response = "Esiste già una tariffa valida per l'oggetto di fatturazione che si desidera inserire.";
              return Response;
            }
       */     
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
            int_Pr_Code_Tariffa = pinsertTariffa(lcls_tariffa,tipoTariffa);
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
   
    public String InsAccordo(Vector pvct_Tariffe, Vector pvct_Regole,Vector pvct_TariffeRif,
    int tipoTariffa,Vector pvct_Accordi,Vector pvct_InventarioProd) throws CustomException, RemoteException{

      String Response = null;
      Context lcls_Contesto = null;
      Object homeObject = null;
      Integer ritCodeInvent = 0;
      Integer ritCodeAccordo =0;
      Integer lint_Return = 0;
      String ritCodeTariffa[] = new String[1];
      try{
        lcls_Contesto = new InitialContext();
     
          
     
        //Controllo prima di tutto se sta girando un batch
        Response = this.isRunningBatchNew(lcls_Contesto,StaticContext.CF_TARIFFE);
        if (Response!=null){
          return "Attenzione : impossibile procedere alla modifica della struttura tariffaria per elaborazioni batch in corso.";
        }

          
          DB_Accordo objAccordi = (DB_Accordo)pvct_Accordi.get(0);
          DB_TariffeNew objTariffa = (DB_TariffeNew)pvct_Tariffe.get(0);
          DB_InventProd objInventProd = (DB_InventProd)pvct_InventarioProd.get(0);
          
      //INSERIMENTO    
          if(objTariffa.getCODE_TARIFFA().equals("")){
        
            conn = getConnection(dsName);
            
           ritCodeAccordo = insJ2_ACCORDI_COMMERCIALI( objAccordi.getCODE_ACCORDO(), objAccordi.getDESC_ACCORDO(),conn);
        
           lint_Return = insOFF_X_SERV_X_PROD( objInventProd.getCODE_OFFERTA(),
           objInventProd.getCODE_SERVIZIO(),objInventProd.getCODE_PRODOTTO(),"","",conn);
       
           Response = pstrInsertTariffe(pvct_Tariffe,pvct_Regole,pvct_TariffeRif,tipoTariffa);
               
           lint_Return = insJ2_ACCORDI_X_TARIFFE( objAccordi.getCODE_ACCORDO(),lcls_tariffa.getCODE_TARIFFA(), lcls_tariffa.getCODE_PR_TARIFFA(),conn);
         
           ritCodeInvent =insINVENTARIO_PRODOTTI(objInventProd,conn);
         
           lint_Return =  insJ2_ACCORDI_X_INVENTARIO( objAccordi.getCODE_ACCORDO()  ,Integer.toString(ritCodeInvent)  , objInventProd.getCODE_ISTANZA_PROD()  ,"0"  ,conn) ;
           
           insMATERIALI_SAP(objInventProd.getCODE_PRODOTTO(),objAccordi.getCODE_MATERIALE_SAP(),conn);
         
        conn.commit();
        conn.close();
          
            
        }
        
      }
      catch(Exception lexc_Exception) {
          try{
            conn.rollback();
            conn.close();
          }
          catch(Exception e)
          {
            System.out.println("lexc_Exception - Exception ["+e.getMessage()+"]");
          }
          Response = "Si è verificato un errore inaspettato. Contattare l'assistenza.";
          throw new RemoteException(lexc_Exception.toString());
      }    
      return Response;
    }


         
  public Vector getRegoleTariffa(int Code_Tariffa,int tipoTariffa)throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_ACCORDI + "getRegoleTariffa";
  
      //System.out.println("lstr_StoredProcedure "+lstr_StoredProcedure);
      String[][] larr_CallSP ={{lstr_StoredProcedure},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER,String.valueOf(Code_Tariffa)}
              };
      //System.out.println("larr_CallSP "+larr_CallSP.length);
      Vector lcls_return =  this.callSP(larr_CallSP,DB_RegolaTariffa.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getRegoleTariffa",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }
 
 public int insJ2_ACCORDI_X_INVENTARIO(String pCODE_ACCORDO  ,String pCODE_INVENT  ,
      String pCODE_ISTANZA_PROD ,String pATTIVO, Connection pcls_Connection )  throws RemoteException, 
                                                           CustomException
      {
          Vector lvct_SPReturn = null;
          String lstr_StoredProcedureName = StaticContext.PKG_ACCORDI + "insJ2_ACCORDI_X_INVENTARIO";
          
          try{
            String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(pCODE_ACCORDO)},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(pCODE_INVENT)},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pCODE_ISTANZA_PROD},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(pATTIVO)},
                    
                    };
              lvct_SPReturn = this.callSP(larr_CallSP);
           // lvct_SPReturn = this.callSPparConn(larr_CallSP,pcls_Connection);
            Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

            return lvct_Return.intValue();
          }
          catch(Exception lexc_Exception){
            throw new CustomException(lexc_Exception.toString(),
                          "",
                        "insJ2_ACCORDI_X_INVENTARIO",
                        this.getClass().getName(),                              
                        StaticContext.FindExceptionType(lexc_Exception));
      }
      
}

    public String getSequenceAccordo() throws RemoteException, 
                                                         CustomException
    {
        Vector lvct_SPReturn = null;
        String lstr_StoredProcedureName = StaticContext.PKG_ACCORDI + "getSequenceAccordo";
        
        try{
          String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING}
                  };

          lvct_SPReturn = this.callSP(larr_CallSP);
          String lstr_Return = (String)lvct_SPReturn.get(0);

          return lstr_Return;
        }
        catch(Exception lexc_Exception){
          throw new CustomException(lexc_Exception.toString(),
                        "",
                      "getSequenceAccordo",
                      this.getClass().getName(),                              
                      StaticContext.FindExceptionType(lexc_Exception));
    }
    
    }   
  public String getSequenceProdottoAccordo() throws RemoteException, 
                                                       CustomException
  {
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_ACCORDI + "getSequenceProdottoAccordo";
      
      try{
        String[][] larr_CallSP={
                {lstr_StoredProcedureName},
                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING}
                };

        lvct_SPReturn = this.callSP(larr_CallSP);
        String lstr_Return = (String)lvct_SPReturn.get(0);

        return lstr_Return;
      }
      catch(Exception lexc_Exception){
        throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getSequenceProdottoAccordo",
                    this.getClass().getName(),                              
                    StaticContext.FindExceptionType(lexc_Exception));
  }
  
  }   
    
    
    public String getSequenceTariffaStaccata() throws RemoteException, 
                                                         CustomException
    {
        Vector lvct_SPReturn = null;
        String lstr_StoredProcedureName = StaticContext.PKG_ACCORDI + "getSequenceTariffaStaccata";
        
        try{
          String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING}
                  };

          lvct_SPReturn = this.callSP(larr_CallSP);
          String lstr_Return = (String)lvct_SPReturn.get(0);

          return lstr_Return;
        }
        catch(Exception lexc_Exception){
          throw new CustomException(lexc_Exception.toString(),
                        "",
                      "getSequenceTariffaStaccata",
                      this.getClass().getName(),                              
                      StaticContext.FindExceptionType(lexc_Exception));
    }
    
    }

  /*public int insJ2_ACCORDI_X_INVENTARIOProva(Vector pvct_Accordi )  throws RemoteException, 
                                                            CustomException
       {
           Vector lvct_SPReturn = null;
           String lstr_StoredProcedureName = StaticContext.PKG_ACCORDI + "insJ2_ACCORDI_X_INVENTARIOProva";
           
           try{
             String[][] larr_CallSP={
                     {lstr_StoredProcedureName},
                     {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_VECTOR, pvct_Accordi }
                     
                     };
               lvct_SPReturn = this.callSP(larr_CallSP);
            // lvct_SPReturn = this.callSPparConn(larr_CallSP,pcls_Connection);
             Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

             return lvct_Return.intValue();
           }
           catch(Exception lexc_Exception){
             throw new CustomException(lexc_Exception.toString(),
                           "",
                         "insJ2_ACCORDI_X_INVENTARIOProva",
                         this.getClass().getName(),                              
                         StaticContext.FindExceptionType(lexc_Exception));
       }
       
  }

 */
   public String UpdAccordo(DB_Accordo objAccordi,Vector pvct_Regole) throws CustomException, RemoteException{

     String Response = null;
     Context lcls_Contesto = null;
     Object homeObject = null;
     int int_Code_Tariffa = 0;
     int int_Pr_Code_Tariffa = 0;
     Integer lint_Return = 0;
     String ritCodeTariffa[] = new String[1];
     DB_RegolaTariffa lcls_regoleTariffa = null;
     try{
       lcls_Contesto = new InitialContext();
    
       homeObject = lcls_Contesto.lookup("Ent_RegoleTariffe");
       lent_RegoleTariffeHome = (Ent_RegoleTariffeHome)PortableRemoteObject.narrow(homeObject,Ent_RegoleTariffeHome.class);
       lent_RegoleTariffe = lent_RegoleTariffeHome.create();
    
       //Controllo prima di tutto se sta girando un batch
       Response = this.isRunningBatchNew(lcls_Contesto,StaticContext.CF_TARIFFE);
       if (Response!=null){
         return "Attenzione : impossibile procedere alla modifica della struttura tariffaria per elaborazioni batch in corso.";
       }
  
       lint_Return= p_updateAccordo(objAccordi);
       //Cancello le regole e rinserisco 
       deleteRegolexTariffe(objAccordi);
       int_Code_Tariffa = Integer.parseInt( objAccordi.getCODE_TARIFFA());
       int_Pr_Code_Tariffa = Integer.parseInt(objAccordi.getCODE_PR_TARIFFA());;
    
       for(int j=0;j<pvct_Regole.size();j++){
         lcls_regoleTariffa = (DB_RegolaTariffa)pvct_Regole.get(j);
         
         lent_RegoleTariffe.insertRegoleTariffa(Integer.parseInt(lcls_regoleTariffa.getCODE_REGOLA()),
              int_Code_Tariffa,int_Pr_Code_Tariffa,lcls_regoleTariffa.getPARAMETRO(),0);
       }   
       
     }
     catch(Exception lexc_Exception) {
         try{
           conn.rollback();
           conn.close();
         }
         catch(Exception e)
         {
           System.out.println("lexc_Exception - Exception ["+e.getMessage()+"]");
         }
         Response = "Si è verificato un errore inaspettato. Contattare l'assistenza.";
         throw new RemoteException(lexc_Exception.toString());
     }    
     return Response;
   }

 
 
  public int p_updateAccordo(DB_Accordo objAccordi)throws CustomException, RemoteException{

    try{
      String lstr_StoredProcedure = StaticContext.PKG_ACCORDI + "updateAccordo";
      

  
  
      String[][] larr_CallSP ={{lstr_StoredProcedure},
        {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_INTEGER},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getCODE_UTENTE()}, 
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getCODE_ACCORDO()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getCODE_OFFERTA()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getDESC_ACCORDO()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getCODE_SERVIZIO()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getCODE_ACCOUNT()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getCODE_PRODOTTO()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getCODE_ISTANZA_PROD()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getDATA_INIZIO_VALID()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getDATA_FINE_VALID()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getDATA_INIZIO_FATRZ()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getDATA_FINE_FATRZ()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getDATA_INIZIO_FATRB()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getDATA_FINE_FATRB()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getCODE_TARIFFA()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getCODE_PR_TARIFFA()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getIMPT_TARIFFA()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getDATA_INIZIO_TARIFFA()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getDATA_FINE_TARIFFA()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getCODE_OGGETTO_FATRZ()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getTIPO_FLAG_ANT_POST()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getVALO_FREQ_APPL()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getQNTA_SHIFT_CANONI()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getCODE_MODAL_APPL_TARIFFA()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getCODE_MATERIALE_SAP()}
   
        };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_Accordo.class);
      Integer lvct_Return = (Integer)lcls_return.get(0);
                  
      return lvct_Return.intValue();
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "p_updateAccordo",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
  }
  }
 
  public int cessaAccordo(DB_Accordo objAccordi)throws CustomException, RemoteException{

    try{
      String lstr_StoredProcedure = StaticContext.PKG_ACCORDI + "cessaAccordo";
      

  
  
      String[][] larr_CallSP ={{lstr_StoredProcedure},
        {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_INTEGER},
    
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getCODE_ACCORDO()},
      {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getDATA_FINE_VALID()},
       {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getDATA_FINE_FATRZ()},
   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, objAccordi.getCODE_UTENTE()}, 
      
        };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_Accordo.class);
      Integer lvct_Return = (Integer)lcls_return.get(0);
                  
      return lvct_Return.intValue();
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "cessaAccordo",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
  }
  }
  public int insMATERIALI_SAP(String code_prodotto, 
                           String code_materiale_SAP,Connection pcls_Connection) throws RemoteException, 
                                                       CustomException
  {
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_ACCORDI + "insMATERIALI_SAP";
      
      try{
        String[][] larr_CallSP={
                {lstr_StoredProcedureName},
                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_prodotto},
                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_materiale_SAP}
                };

       // lvct_SPReturn = this.callSPparConn(larr_CallSP,pcls_Connection);
        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

        return lvct_Return.intValue();
      }
      catch(Exception lexc_Exception){
        throw new CustomException(lexc_Exception.toString(),
                      "",
                    "insMATERIALI_SAP",
                    this.getClass().getName(),                              
                    StaticContext.FindExceptionType(lexc_Exception));
  }
  
  }
  
  public int insJ2_ACCORDI_COMMERCIALI(String code_accordo, 
                           String desc_accordo,Connection pcls_Connection) throws RemoteException, 
                                                       CustomException
  {
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_ACCORDI + "insJ2_ACCORDI_COMMERCIALI";
      
      try{
        String[][] larr_CallSP={
                {lstr_StoredProcedureName},
                {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_accordo},
                {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, desc_accordo}
                };

       // lvct_SPReturn = this.callSPparConn(larr_CallSP,pcls_Connection);
        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

        return lvct_Return.intValue();
      }
      catch(Exception lexc_Exception){
        throw new CustomException(lexc_Exception.toString(),
                      "",
                    "insJ2_ACCORDI_COMMERCIALI",
                    this.getClass().getName(),                              
                    StaticContext.FindExceptionType(lexc_Exception));
  }
  
  }
    public int insOFF_X_SERV_X_PROD(String code_offerta,
     String code_servizio,
     String code_prodotto,
     String data_inizio_valid,
     String data_fine_valid,
    Connection pcls_Connection) throws RemoteException, 
                                                         CustomException
    {
        Vector lvct_SPReturn = null;
        String lstr_StoredProcedureName = StaticContext.PKG_ACCORDI + "insOFF_X_SERV_X_PROD";
        
        try{
          String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_offerta},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_servizio},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_prodotto},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, data_inizio_valid},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, data_fine_valid}
        
                  };

          //lvct_SPReturn = this.callSPparConn(larr_CallSP,pcls_Connection);
           lvct_SPReturn = this.callSP(larr_CallSP);
          Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

          return lvct_Return.intValue();
        }
        catch(Exception lexc_Exception){
          throw new CustomException(lexc_Exception.toString(),
                        "",
                      "insOFF_X_SERV_X_PROD",
                      this.getClass().getName(),                              
                      StaticContext.FindExceptionType(lexc_Exception));
    }
    
    }
    public int insJ2_ACCORDI_X_TARIFFE(String pCODE_ACCORDO ,String pCODE_TARIFFA ,
    String pCODE_PR_TARIFFA,Connection pcls_Connection ) throws RemoteException, 
                                                         CustomException
    {
        Vector lvct_SPReturn = null;
        String lstr_StoredProcedureName = StaticContext.PKG_ACCORDI + "insJ2_ACCORDI_X_TARIFFE";
        
        try{
          String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(pCODE_ACCORDO)},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(pCODE_TARIFFA)},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(pCODE_PR_TARIFFA)}
                  };

          lvct_SPReturn = this.callSP(larr_CallSP);
          //lvct_SPReturn = this.callSPparConn(larr_CallSP,pcls_Connection);
          Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

          return lvct_Return.intValue();
        }
        catch(Exception lexc_Exception){
          throw new CustomException(lexc_Exception.toString(),
                        "",
                      "insJ2_ACCORDI_X_TARIFFE",
                      this.getClass().getName(),                              
                      StaticContext.FindExceptionType(lexc_Exception));
    }
}

  /* public String getAccordiXml()throws CustomException, RemoteException{
    try{

      Vector lvct_Ret = getAccordi();
      return createXML(lvct_Ret);

    }
    catch(Exception lexc_Exception){

      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getAccordiXml",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }

  }*/


   public String getServizioxAccount(String codeAccount
                                  ) throws CustomException, 
                                                          RemoteException
   {
     String lstr_StoredProcedureName =  StaticContext.PKG_ACCORDI + "getServizioxAccount";

     try
     {


       String[][] larr_CallSP =
       {
         { lstr_StoredProcedureName },
         { AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING },
         { AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,codeAccount}
      };

        Vector  lvct_SPReturn = this.callSP(larr_CallSP);
         String lstr_Return = (String)lvct_SPReturn.get(0);
   
       return lstr_Return;
     } catch (Exception lexc_Exception)
     {
       throw new CustomException(lexc_Exception.toString(), "", 
                                 "getServizioxAccount", this.getClass().getName(), 
                                 StaticContext.FindExceptionType(lexc_Exception));
     }
   }
 
  public Vector getAccordiFiltro(String codeAcco, 
                                 String descAcco,
                                 String codeAccount, 
                                 String codeOfferta,
                                 String valorizzati
                                 ) throws CustomException, 
                                                         RemoteException
  {
    String lstr_StoredProcedureName = 
      StaticContext.PKG_ACCORDI + "getAccordiFiltro";

    try
    {


      String[][] larr_CallSP =
      {
        { lstr_StoredProcedureName },
        { AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR },
        { AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,codeAcco },
        { AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,descAcco },
        { AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,codeAccount},
        { AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,codeOfferta },
        { AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,valorizzati }
        };

    
      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Accordo.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    } catch (Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(), "", 
                                "getAccordiFiltro", this.getClass().getName(), 
                                StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  public String cancella_accordo(String code_accordo) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_ACCORDI + "cancella_accordo";
    String lstr_StoredProcedureName_error = StaticContext.PKG_ACCORDI + "getError";
    String msg_return = null;
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_accordo}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      //controllo se e' stata cancellata una sola occorrenza
      if(lvct_Return.intValue()==1){
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
                  "cancella accordo",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String aggiorna_accordo(DB_Accordo accordo) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_ACCORDI + "aggiorna_prodotti";
    String lstr_StoredProcedureName_error = StaticContext.PKG_ACCORDI + "getError";
    String msg_return = null;
    
    try {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, accordo.getCODE_ACCORDO()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, accordo.getDESC_ACCORDO()},
             
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
                  "aggiorna_ACCORDO",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
    }
  }
}
