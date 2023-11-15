package com.strutturaWeb.Action;

public class ActionFactory 
{
  public ActionFactory()
  {
  }

  public ActionInterface getAction(String nomeFunzione)
  {
      ActionInterface ai=null;
      if(nomeFunzione.compareTo("uploadFile")==0)
       ai=new ActionUploadFile();
      if(nomeFunzione.compareTo("ExportCsv")==0)
       ai=new ActionExportCsv();
      if(nomeFunzione.compareTo("ExportCsvConsAttive")==0)
        ai=new ActionExportCsvConsAttive();
      if(nomeFunzione.compareTo("mostraCsv")==0)
        ai=new ActionMostraCsv();
      if(nomeFunzione.compareTo("lanciaRepricing")==0)
        ai=new ActionPopolaAccountRepricing();
      if(nomeFunzione.compareTo("lancioBatchRepricing")==0)
        ai=new ActionLancioBatch();
      if(nomeFunzione.compareTo("lancioBatchRepricingManuale")==0)
        ai = new ActionVerificaBatch();
      if(nomeFunzione.compareTo("lancioBatchCongelaRepricing")==0)
        ai=new ActionLancioBatch();
      if(nomeFunzione.compareTo("listaCongelamentoRepricing")==0)
        ai=new ActionPopolaListaRepricing();
      if(nomeFunzione.compareTo("listaAccountCongelamentoRep")==0)
       ai=new ActionLstAccountCongelamentoRep();
      if(nomeFunzione.compareTo("listaContrattiXTariffe")==0)
       ai=new ActionLstContrattiXTariffe();
      if(nomeFunzione.compareTo("listaPsXTariffe")==0)
       ai=new ActionPopolaPsXTariffa();
      if(nomeFunzione.compareTo("listaOF_PSXTariffe")==0)
        ai=new ActionPopolaOFPSxTariffa();
      if(nomeFunzione.compareTo("listaCausaliXTariffa")==0)
        ai=new ActionPopolaCausaliXTariffa();
      if(nomeFunzione.compareTo("listaTariffe")==0)
       ai=new ActionListaTariffe();
      if(nomeFunzione.compareTo("listaUnitaMisura")==0)
       ai=new ActionListaUnitaMisura();
      if(nomeFunzione.compareTo("inserisciTariffa")==0)
        ai=new ActionInserisciTariffa();
      if(nomeFunzione.compareTo("listaTipiContr")==0)
        ai=new ActionListaTipoContratti();
      if(nomeFunzione.compareTo("listaTipiContrCVIDYA")==0)
        ai=new ActionListaTipoContrattiCVIDYA(); 
      if(nomeFunzione.compareTo("listaTipiServiziAssurance")==0)
        ai=new ActionListaTipoServiziAssurance();      
      if(nomeFunzione.compareTo("listaTipiGestoreAssurance")==0)
        ai=new ActionlistaTipoGestoreAssurance();      
      if(nomeFunzione.compareTo("listaTipiServiziAssuranceXDSL")==0)
        ai=new ActionListaTipoServiziAssuranceXDSL(); 
      if(nomeFunzione.compareTo("listaTipiServiziAssuranceReg")==0)
        ai=new ActionListaTipoServiziAssuranceReg();         
      if(nomeFunzione.compareTo("listaTipoContrRientriTI")==0)
        ai=new ActionListaTipoContrattiRientriTI();
      if(nomeFunzione.compareTo("listaAccountXTipoContr")==0)
        ai=new ActionLstAccountXTipoContr(); 
      if(nomeFunzione.compareTo("ControllaDateRientriTI")==0)
        ai=new ActionControllaDateRientriTI(); 
      if(nomeFunzione.compareTo("TracciabilitaListini")==0)
        ai=new ActionTracciabilitaListini(); 
      if(nomeFunzione.compareTo("TracciabilitaFattureNdC")==0)
        ai=new ActionTracciabilitaFattureNdC(); 
      if(nomeFunzione.compareTo("listaCLLI")==0)
        ai=new ActionListaCLLI();
      if(nomeFunzione.compareTo("listaCLLIProg")==0)
        ai=new ActionListaCLLIProg();
      if(nomeFunzione.compareTo("listaAnniEstrazione")==0)
        ai=new ActionListaAnniEstrazione();
      if(nomeFunzione.compareTo("listaAnniTipoContr")==0)
        ai=new ActionListaAnniTipoContr();
      if(nomeFunzione.compareTo("ControllaDateRicaviAC")==0)
        ai=new ActionControllaDateRicaviAC();
      if(nomeFunzione.compareTo("EstrazioniConf")==0)
        ai=new ActionEstrazioniConf();
      if(nomeFunzione.compareTo("listaFile")==0)
        ai=new ActionElencoFileEstrazioni();
      if(nomeFunzione.compareTo("listaPromozioni")==0)
        ai=new ActionPopolaPromozioni();
      if(nomeFunzione.compareTo("addPromozioniSession")==0)
        ai=new ActionAddPromozioniSession();
      if(nomeFunzione.compareTo("removePromozioniSession")==0)
        ai=new ActionRemovePromozioniSession();
      if(nomeFunzione.compareTo("listaServiziDaCongelareSpecial")==0)
        ai=new ActionPopolaCongelamenti();
      if(nomeFunzione.compareTo("InvioFileSftp")==0)
        ai=new ActionInvioFileSftp();
      if(nomeFunzione.compareTo("listaSftpSched")==0)
        ai=new ActionListaSftpSched();
    if(nomeFunzione.compareTo("modificaSftpSched")==0)
      ai=new ActionModificaSftpSched();
      if(nomeFunzione.compareTo("EstrazioneNDCCessate")==0)
        ai=new ActionEstrazioneNDCCessate();
      
/*DOWNLOAD REPORT SPECIAL - inizio*/
      if(nomeFunzione.compareTo("DownloadReport_Funzionalita")==0)
        ai=new ActionDownloadReport_Funzionalita();
      if(nomeFunzione.compareTo("DownloadReport_Periodi")==0)
        ai=new ActionDownloadReport_Periodi();
      if(nomeFunzione.compareTo("DownloadReport_Servizi")==0)
        ai=new ActionDownloadReport_Servizi();
      if(nomeFunzione.compareTo("DownloadReport_Account")==0)
        ai=new ActionDownloadReport_Account();
      if(nomeFunzione.compareTo("DownloadReport_ElencoFile")==0)
        ai=new ActionDownloadReport_ElencoFile();
/*DOWNLOAD REPORT SPECIAL - fine*/  
      if(nomeFunzione.compareTo("DownloadReport_FunzionalitaCL")==0)
        ai=new ActionDownloadReport_FunzionalitaCL();
      if(nomeFunzione.compareTo("DownloadReport_ElencoFileCl")==0)
        ai=new ActionDownloadReport_ElencoFileCl();      
/*DOWNLOAD REPORT CLASSIC - inizio*/      

/*DOWNLOAD REPORT CLASSIC - fine*/  
/*ESTRAZIONI VERIFICA STRUTTURE TARIFFARIE XDSL - inizio*/
      if(nomeFunzione.compareTo("listaContrXTipoContr")==0)
        ai=new ActionLstContrXTipoContr();
      if(nomeFunzione.compareTo("listaPsXTipoContr")==0)
        ai=new ActionLstPsXTipoContr();
      if(nomeFunzione.compareTo("listaOggFatrzXTipoContr")==0)
        ai=new ActionLstOggFatrzXTipoContr();
      if(nomeFunzione.compareTo("listaCausaliXTipoContr")==0)
        ai=new ActionLstCausaliXTipoContr();
      if(nomeFunzione.compareTo("lanciaEstrazioneTariffe")==0)
        ai=new ActionLanciaEstrazioneTariffe();        
/*ESTRAZIONI VERIFICA STRUTTURE TARIFFARIE XDSL - fine*/
        
      /* JPUB2_ACCORPAMENTI - INIZIO */
      if(nomeFunzione.compareTo("listaServizi")==0)
        ai=new Action_J2_LstServizi();
      if(nomeFunzione.compareTo("listaGestori")==0)
        ai=new Action_J2_LstGestori();
      if(nomeFunzione.compareTo("listaAccountAccorpanti")==0)
        ai=new Action_J2_LstAccountAccorpanti();
      if(nomeFunzione.compareTo("listaAccountDisponibili")==0)
        ai=new Action_J2_LstAccountDisponibili();
      if(nomeFunzione.compareTo("listaAccountAccorpati")==0)
        ai=new Action_J2_LstAccountAccorpati();
      if(nomeFunzione.compareTo("salvaCaratteristicheCatalogo")==0)
        ai=new Action_J2_Caratteristiche();
      if(nomeFunzione.compareTo("checkGestoreSap")==0)
        ai=new Action_J2_CheckGestoreSap();
      if(nomeFunzione.compareTo("checkTariffaRepricing")==0)
        ai=new Action_J2_CheckTariffaRepricing();
			
      if(nomeFunzione.compareTo("ElencoFileTracciamenti")==0)
        ai=new Action_J2_Tracciamenti();
      if(nomeFunzione.compareTo("LanciaTracciamenti")==0)
        ai=new Action_J2_Tracciamenti_lancio();   
      if(nomeFunzione.compareTo("ElencoFileDownload")==0)
        ai=new Action_J2_ElencoFileDownload();
      if(nomeFunzione.startsWith("ElencoFileDownloadJPUB2"))
        ai=new Action_J2_ElencoFileDownloadJpub2();           
      /* JPUB2_ACCORPAMENTI - FINE */

       /* JPUB_ACCORPAMENTI_SPECIAL - INIZIO */
       if(nomeFunzione.compareTo("listaServizi_special")==0)
         ai=new Action_J2_LstServiziSpecial();
       if(nomeFunzione.compareTo("listaGestori_special")==0)
         ai=new Action_J2_LstGestoriSpecial();
      if(nomeFunzione.compareTo("listaAccountDisponibili_special")==0)
        ai=new Action_J2_LstAccountDisponibiliSpecial();         
    
            
       /* JPUB2_ACCORPAMENTI_SPECIAL - FINE */

        if(nomeFunzione.compareTo("listaOperatoriClassic")==0)
          ai=new Action_J2_LstOperatoriClassic();         

      if(nomeFunzione.compareTo("listaOperatoriSpecial")==0)
        ai=new Action_J2_LstOperatoriSpecial();         

      if(nomeFunzione.compareTo("CheckRettificaSuperRipr")==0)
         ai=new Action_J2_CheckRettificaSuperRipr();

    if(nomeFunzione.compareTo("CheckCodeAccordo")==0)
      ai=new Action_J2_CheckCodeAccordo();       

    /* OPERE SPECIALI - INIZIO */
    if(nomeFunzione.compareTo("listinoOpereSpeciali")==0)
      ai=new ActionListinoOpereSpeciali();
    
    if(nomeFunzione.compareTo("tariffeOpereSpeciali")==0)
      ai=new ActionTariffeOpereSpeciali();
    
    if(nomeFunzione.compareTo("checkAndUpdateListino")==0)
      ai=new ActionCheckAndUpdateListinoOpereSpeciali();
    
    if(nomeFunzione.compareTo("updateListinoOpereSpeciali")==0)
      ai=new ActionUpdateListinoOpereSpeciali();
      
    if(nomeFunzione.compareTo("insertListinoOpereSpeciali")==0)
      ai=new ActionInsertListinoOpereSpeciali();
    
    if(nomeFunzione.compareTo("eliminaListinoOpereSpeciali")==0)
      ai=new ActionEliminaListinoOpereSpeciali();
    /* OPERE SPECIALI - FINE */
    /*Promo Aree inizio*/
     if(nomeFunzione.compareTo("promoAree")==0)
         ai=new ActionPromoAree();     
      if(nomeFunzione.compareTo("promoAreeServizi")==0)
        ai=new ActionPromoAree_Servizi();  
      if(nomeFunzione.compareTo("promoAreeAccount")==0)
        ai=new ActionPromoAree_Account(); 
      if(nomeFunzione.compareTo("inserisciPromoArea")==0)
        ai=new ActionInserisciPromoArea(); 
      if(nomeFunzione.compareTo("eliminaPromoArea")==0)
        ai=new ActionEliminaPromoArea(); 
      if(nomeFunzione.compareTo("promoAreeAreeRaccolta")==0)
        ai=new ActionPromoAree_AreeRaccolta();  
      
     /*Promo Aree fine*/
     
      /*Cinque Anni inizio*/
      
        if(nomeFunzione.compareTo("cinqueAnniServizi")==0)
          ai=new ActionCinqueAnni_Servizi();  
        if(nomeFunzione.compareTo("cinqueAnniAccount")==0)
          ai=new ActionCinqueAnni_Account(); 
        if(nomeFunzione.compareTo("cinqueAnniRisorsa")==0)
         ai=new ActionCinqueAnni_Risorsa(); 
        if(nomeFunzione.compareTo("cinqueAnniDataDa")==0)
        ai=new ActionCinqueAnni_DataDa(); 
        if(nomeFunzione.compareTo("cinqueAnni")==0)
        ai=new ActionCinqueAnni(); 
        if(nomeFunzione.compareTo("updateCinqueAnni")==0)
        ai=new ActionCinqueAnni_Update(); 
       /*Cinque Anni fine*/
  
       /*Promozioni Progetto inizio*/
        if( nomeFunzione.compareTo("promoProgetto") == 0 ){
            ai = new ActionPromoProgetto();     
        }
        if( nomeFunzione.compareTo("promoProgettoServizi") == 0 ){
            ai = new ActionPromoProgetto_Servizi();  
        }
        if( nomeFunzione.compareTo("promoProgettoAccount") == 0 ){
            ai = new ActionPromoProgetto_Account(); 
        }
        if( nomeFunzione.compareTo("promoProgettoPromozioni") == 0 ){
          ai = new ActionPromoProgetto_Promozioni(); 
        }
        if( nomeFunzione.compareTo("inserisciPromoProgetto") ==0 ){
            ai = new ActionInserisciPromoProgetto(); 
        }
        if( nomeFunzione.compareTo("eliminaPromoProgetto") == 0 ){
            ai = new ActionEliminaPromoProgetto(); 
        }
        /*Promozioni Progetto fine*/
        
        /*
        /*Codice Progetto inizio*/
        //inizio R1I-10-0386
         if( nomeFunzione.compareTo("Intercompany") == 0 ){
             ai = new ActionIntercompany();     
         }
         if( nomeFunzione.compareTo("eliminaIntercompany") == 0 ){
             ai = new ActionEliminaIntercompany(); 
         }
         if( nomeFunzione.compareTo("inserisciIntercompany") ==0 ){
             ai = new ActionInserisciIntercompany(); 
         }
         //fine R1I-10-0386
        if( nomeFunzione.compareTo("codiceProgetto") == 0 ){
            ai = new ActionCodiceProgetto();     
        }
        if( nomeFunzione.compareTo("codiceProgettoServizi") == 0 ){
            ai = new ActionCodiceProgetto_Servizi();  
        }
        if( nomeFunzione.compareTo("codiceProgettoAccount") == 0 ){
            ai = new ActionCodiceProgetto_Account(); 
        }
        if( nomeFunzione.compareTo("codiceProgettoTipologia") == 0 ){
          ai = new ActionCodiceProgetto_Tipologia(); 
        }
        if( nomeFunzione.compareTo("inserisciCodiceProgetto") ==0 ){
            ai = new ActionInserisciCodiceProgetto(); 
        }
        if( nomeFunzione.compareTo("eliminaCodiceProgetto") == 0 ){
            ai = new ActionEliminaCodiceProgetto(); 
        }
        /*Codice Progetto fine*/ 
      
      return ai;
  }
}