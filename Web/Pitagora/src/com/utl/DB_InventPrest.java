package com.utl;
import com.utl.AbstractDataBean;

public class DB_InventPrest extends AbstractDataBean
{
/*attributi*/
 private String CODE_INVENT                    ;
 private String CODE_INVENT_RIF                ;
 private String TIPO_CAUSALE_ATT               ;
 private String TIPO_CAUSALE_CES               ;
 private String TIPO_CAUSALE_ATT_HD            ;
 private String TIPO_CAUSALE_CES_HD            ;
 private String CODE_STATO_ELEM                ;
 private String CODE_ACCOUNT                   ;
 private String CODE_OFFERTA                   ;
 private String CODE_SERVIZIO                  ;
 private String CODE_PRODOTTO                  ;
 private String CODE_COMPONENTE                ;
 private String CODE_PREST_AGG                 ;
 private String CODE_ISTANZA_PROD              ;
 private String CODE_ISTANZA_COMPO             ;
 private String CODE_ISTANZA_PREST_AGG         ;
 private String DATA_INIZIO_VALID              ;
 private String DATA_FINE_VALID                ;
 private String DATA_INIZIO_FATRZ              ;
 private String DATA_FINE_FATRZ                ;
 private String CODE_ULTIMO_CICLO_FATRZ        ;
 private String DATA_FINE_NOL                  ;
 private String DATA_CESSAZ                    ;
 private String DATA_INIZIO_FATRB              ;
 private String DATA_FINE_FATRB                ;
 private String QNTA_VALO                      ;
 private String TIPO_FLAG_CONG                 ;
 private String CODE_UTENTE_CREAZ              ;
 private String DATA_CREAZ                     ;
 private String CODE_UTENTE_MODIF              ;
 private String DATA_MODIF                     ;
 private String CODE_UTENTE_CREAZ_HD           ;
 private String DATA_CREAZ_HD                  ;
 private String CODE_UTENTE_MODIF_HD           ;
 private String DATA_MODIF_HD                  ;
 private String ELAB_VALORIZ                   ;
 private String TIPO_FLAG_MIGRAZIONE           ;
 private String DESC_TIPO_CAUSALE_ATT          ;
 private String DESC_TIPO_CAUSALE_CES          ;
 private String DESC_ACCOUNT                   ;
 private String DESC_OFFERTA                   ;
 private String DESC_SERVIZIO                  ;
 private String DESC_STATO_ELEM                ;
 private String DESC_PRODOTTO                  ;
 private String DESC_COMPONENTE                ;
 private String DESC_PREST_AGG                 ;
 private String DESCRIZIONE_CICLO              ;
 private int    MODIFICATO                     ;
 private String CODE_STATO_ELEM_PREC           ;
 private String DATA_DRO                       ;
 private String DATA_DIN                       ;
 private String DATA_DEE                       ;
  private String INVARIANT_ID;
  private int INSERITO                   =0;
  /* Costruttore */
  public DB_InventPrest()
  {
     CODE_INVENT                  ="";  
     CODE_INVENT_RIF              ="";  
     TIPO_CAUSALE_ATT             ="";  
     TIPO_CAUSALE_CES             ="";  
     TIPO_CAUSALE_ATT_HD          ="";  
     TIPO_CAUSALE_CES_HD          ="";  
     CODE_STATO_ELEM              ="";  
     CODE_ACCOUNT                 ="";  
     CODE_OFFERTA                 ="";  
     CODE_SERVIZIO                ="";  
     CODE_PRODOTTO                ="";  
     CODE_COMPONENTE              ="";
     CODE_PREST_AGG               ="";
     CODE_ISTANZA_PROD            ="";  
     CODE_ISTANZA_COMPO           ="";  
     DATA_INIZIO_VALID            ="";  
     DATA_FINE_VALID              ="";  
     DATA_INIZIO_FATRZ            ="";  
     DATA_FINE_FATRZ              ="";  
     CODE_ULTIMO_CICLO_FATRZ      ="";  
     DATA_FINE_NOL                ="";  
     DATA_CESSAZ                  ="";  
     DATA_INIZIO_FATRB            ="";  
     DATA_FINE_FATRB              ="";  
     QNTA_VALO                    ="";  
     TIPO_FLAG_CONG               ="";  
     CODE_UTENTE_CREAZ            ="";  
     DATA_CREAZ                   ="";  
     CODE_UTENTE_MODIF            ="";  
     DATA_MODIF                   ="";  
     CODE_UTENTE_CREAZ_HD         ="";  
     DATA_CREAZ_HD                ="";  
     CODE_UTENTE_MODIF_HD         ="";  
     DATA_MODIF_HD                ="";  
     ELAB_VALORIZ                 ="";  
     TIPO_FLAG_MIGRAZIONE         ="";  
     DESC_TIPO_CAUSALE_ATT        ="";
     DESC_TIPO_CAUSALE_CES        ="";
     DESC_ACCOUNT                 ="";
     DESC_OFFERTA                 ="";
     DESC_SERVIZIO                ="";
     DESC_STATO_ELEM              ="";
     DESC_PRODOTTO                ="";
     DESC_COMPONENTE              ="";
     DESC_PREST_AGG               ="";
     DESCRIZIONE_CICLO            ="";
     MODIFICATO                   = 0;
     CODE_STATO_ELEM_PREC         ="";
     DATA_DRO                     ="";
     DATA_DIN                     = "";
     DATA_DEE                = "";
    INVARIANT_ID = ""; 
  }
  
  /* Metodi Comuni */
  public String getCODE_INVENT                   () { return CODE_INVENT              ; }         
  public String getCODE_INVENT_RIF               () { return CODE_INVENT_RIF          ; }       
  public String getTIPO_CAUSALE_ATT              () { return TIPO_CAUSALE_ATT         ; }       
  public String getTIPO_CAUSALE_CES              () { return TIPO_CAUSALE_CES         ; }       
  public String getTIPO_CAUSALE_ATT_HD           () { return TIPO_CAUSALE_ATT_HD      ; }       
  public String getTIPO_CAUSALE_CES_HD           () { return TIPO_CAUSALE_CES_HD      ; }       
  public String getCODE_STATO_ELEM               () { return CODE_STATO_ELEM          ; }       
  public String getCODE_ACCOUNT                  () { return CODE_ACCOUNT             ; }       
  public String getCODE_OFFERTA                  () { return CODE_OFFERTA             ; }       
  public String getCODE_SERVIZIO                 () { return CODE_SERVIZIO            ; }       
  public String getCODE_PRODOTTO                 () { return CODE_PRODOTTO            ; }       
  public String getCODE_COMPONENTE               () { return CODE_COMPONENTE          ; }       
  public String getCODE_PREST_AGG                () { return CODE_PREST_AGG           ; }       
  public String getCODE_ISTANZA_PROD             () { return CODE_ISTANZA_PROD        ; }       
  public String getCODE_ISTANZA_COMPO            () { return CODE_ISTANZA_COMPO       ; }       
  public String getCODE_ISTANZA_PREST_AGG        () { return CODE_ISTANZA_PREST_AGG   ; }       
  public String getDATA_INIZIO_VALID             () { return DATA_INIZIO_VALID        ; }       
  public String getDATA_FINE_VALID               () { return DATA_FINE_VALID          ; }       
  public String getDATA_INIZIO_FATRZ             () { return DATA_INIZIO_FATRZ        ; }       
  public String getDATA_FINE_FATRZ               () { return DATA_FINE_FATRZ          ; }       
  public String getCODE_ULTIMO_CICLO_FATRZ       () { return CODE_ULTIMO_CICLO_FATRZ  ; }       
  public String getDATA_FINE_NOL                 () { return DATA_FINE_NOL            ; }       
  public String getDATA_CESSAZ                   () { return DATA_CESSAZ              ; }       
  public String getDATA_INIZIO_FATRB             () { return DATA_INIZIO_FATRB        ; }       
  public String getDATA_FINE_FATRB               () { return DATA_FINE_FATRB          ; }       
  public String getQNTA_VALO                     () { return QNTA_VALO                ; }       
  public String getTIPO_FLAG_CONG                () { return TIPO_FLAG_CONG           ; }       
  public String getCODE_UTENTE_CREAZ             () { return CODE_UTENTE_CREAZ        ; }       
  public String getDATA_CREAZ                    () { return DATA_CREAZ               ; }       
  public String getCODE_UTENTE_MODIF             () { return CODE_UTENTE_MODIF        ; }       
  public String getDATA_MODIF                    () { return DATA_MODIF               ; }       
  public String getCODE_UTENTE_CREAZ_HD          () { return CODE_UTENTE_CREAZ_HD     ; }       
  public String getDATA_CREAZ_HD                 () { return DATA_CREAZ_HD            ; }       
  public String getCODE_UTENTE_MODIF_HD          () { return CODE_UTENTE_MODIF_HD     ; }       
  public String getDATA_MODIF_HD                 () { return DATA_MODIF_HD            ; }       
  public String getELAB_VALORIZ                  () { return ELAB_VALORIZ             ; }       
  public String getTIPO_FLAG_MIGRAZIONE          () { return TIPO_FLAG_MIGRAZIONE     ; }       
  public String getDESC_TIPO_CAUSALE_ATT         () { return DESC_TIPO_CAUSALE_ATT    ; }
  public String getDESC_TIPO_CAUSALE_CES         () { return DESC_TIPO_CAUSALE_CES    ; }
  public String getDESC_ACCOUNT                  () { return DESC_ACCOUNT             ; }
  public String getDESC_OFFERTA                  () { return DESC_OFFERTA             ; }
  public String getDESC_SERVIZIO                 () { return DESC_SERVIZIO            ; }
  public String getDESC_STATO_ELEM               () { return DESC_STATO_ELEM          ; }
  public String getDESC_PRODOTTO                 () { return DESC_PRODOTTO            ; }
  public String getDESC_COMPONENTE               () { return DESC_COMPONENTE          ; }
  public String getDESC_PREST_AGG                () { return DESC_PREST_AGG           ; }
  public String getDESCRIZIONE_CICLO             () { return DESCRIZIONE_CICLO        ; }
  public int    eMODIFICATO                      () { return MODIFICATO               ; }
  public String getCODE_STATO_ELEM_PREC          () { return CODE_STATO_ELEM_PREC   ; }       
  public String getDATA_DRO                      () { return DATA_DRO   ; }       
  public String getDATA_DIN                      () { return DATA_DIN ; }
  public String getDATA_DEE                () { return DATA_DEE ; }
  public String getINVARIANT_ID  () { return INVARIANT_ID ; }
  public int    getINSERITO                      () { return INSERITO               ; }
      
	public void setCODE_INVENT                    ( String value ) { CODE_INVENT              = value ; }        
	public void setCODE_INVENT_RIF                ( String value ) { CODE_INVENT_RIF          = value ; }      
	public void setTIPO_CAUSALE_ATT               ( String value ) { TIPO_CAUSALE_ATT         = value ; }      
	public void setTIPO_CAUSALE_CES               ( String value ) { TIPO_CAUSALE_CES         = value ; }      
	public void setTIPO_CAUSALE_ATT_HD            ( String value ) { TIPO_CAUSALE_ATT_HD      = value ; }      
	public void setTIPO_CAUSALE_CES_HD            ( String value ) { TIPO_CAUSALE_CES_HD      = value ; }      
	public void setCODE_STATO_ELEM                ( String value ) { CODE_STATO_ELEM          = value ; }      
	public void setCODE_ACCOUNT                   ( String value ) { CODE_ACCOUNT             = value ; }      
	public void setCODE_OFFERTA                   ( String value ) { CODE_OFFERTA             = value ; }      
	public void setCODE_SERVIZIO                  ( String value ) { CODE_SERVIZIO            = value ; }      
	public void setCODE_PRODOTTO                  ( String value ) { CODE_PRODOTTO            = value ; }      
	public void setCODE_COMPONENTE                ( String value ) { CODE_COMPONENTE          = value ; }      
	public void setCODE_PREST_AGG                 ( String value ) { CODE_PREST_AGG           = value ; }      
	public void setCODE_ISTANZA_PROD              ( String value ) { CODE_ISTANZA_PROD        = value ; }      
	public void setCODE_ISTANZA_COMPO             ( String value ) { CODE_ISTANZA_COMPO       = value ; }      
	public void setCODE_ISTANZA_PREST_AGG         ( String value ) { CODE_ISTANZA_PREST_AGG   = value ; }      
	public void setDATA_INIZIO_VALID              ( String value ) { DATA_INIZIO_VALID        = value ; }      
	public void setDATA_FINE_VALID                ( String value ) { DATA_FINE_VALID          = value ; }      
	public void setDATA_INIZIO_FATRZ              ( String value ) { DATA_INIZIO_FATRZ        = value ; }      
	public void setDATA_FINE_FATRZ                ( String value ) { DATA_FINE_FATRZ          = value ; }      
	public void setCODE_ULTIMO_CICLO_FATRZ        ( String value ) { CODE_ULTIMO_CICLO_FATRZ  = value ; }      
	public void setDATA_FINE_NOL                  ( String value ) { DATA_FINE_NOL            = value ; }      
	public void setDATA_CESSAZ                    ( String value ) { DATA_CESSAZ              = value ; }      
	public void setDATA_INIZIO_FATRB              ( String value ) { DATA_INIZIO_FATRB        = value ; }      
	public void setDATA_FINE_FATRB                ( String value ) { DATA_FINE_FATRB          = value ; }      
	public void setQNTA_VALO                      ( String value ) { QNTA_VALO                = value ; }      
	public void setTIPO_FLAG_CONG                 ( String value ) { TIPO_FLAG_CONG           = value ; }      
	public void setCODE_UTENTE_CREAZ              ( String value ) { CODE_UTENTE_CREAZ        = value ; }      
	public void setDATA_CREAZ                     ( String value ) { DATA_CREAZ               = value ; }      
	public void setCODE_UTENTE_MODIF              ( String value ) { CODE_UTENTE_MODIF        = value ; }      
	public void setDATA_MODIF                     ( String value ) { DATA_MODIF               = value ; }      
	public void setCODE_UTENTE_CREAZ_HD           ( String value ) { CODE_UTENTE_CREAZ_HD     = value ; }      
	public void setDATA_CREAZ_HD                  ( String value ) { DATA_CREAZ_HD            = value ; }      
	public void setCODE_UTENTE_MODIF_HD           ( String value ) { CODE_UTENTE_MODIF_HD     = value ; }      
	public void setDATA_MODIF_HD                  ( String value ) { DATA_MODIF_HD            = value ; }      
	public void setELAB_VALORIZ                   ( String value ) { ELAB_VALORIZ             = value ; }      
	public void setTIPO_FLAG_MIGRAZIONE           ( String value ) { TIPO_FLAG_MIGRAZIONE     = value ; }      
  public void setDESC_TIPO_CAUSALE_ATT          ( String value ) { DESC_TIPO_CAUSALE_ATT    = value ; }
  public void setDESC_TIPO_CAUSALE_CES          ( String value ) { DESC_TIPO_CAUSALE_CES    = value ; }
  public void setDESC_ACCOUNT                   ( String value ) { DESC_ACCOUNT             = value ; }
  public void setDESC_OFFERTA                   ( String value ) { DESC_OFFERTA             = value ; }
  public void setDESC_SERVIZIO                  ( String value ) { DESC_SERVIZIO            = value ; }
  public void setDESC_STATO_ELEM                ( String value ) { DESC_STATO_ELEM          = value ; }
  public void setDESC_PRODOTTO                  ( String value ) { DESC_PRODOTTO            = value ; }
  public void setDESC_COMPONENTE                ( String value ) { DESC_COMPONENTE          = value ; }
  public void setDESC_PREST_AGG                 ( String value ) { DESC_PREST_AGG           = value ; }
  public void setDESCRIZIONE_CICLO              ( String value ) { DESCRIZIONE_CICLO        = value ; }
	public void Modifica                          ()               { MODIFICATO               = 1;      }    
 	public void annullaModifica                   ()               { MODIFICATO               = 0; } 
	public void setCODE_STATO_ELEM_PREC           ( String value ) { CODE_STATO_ELEM_PREC     = value ; }      
  public void setDATA_DRO                       ( String value ) { DATA_DRO                 = value  ; }    
  public void setDATA_DIN                       ( String value ) { DATA_DIN                 = value  ; }    
  public void  setDATA_DEE                      ( String value ) { DATA_DEE                = value ; }       
  public void setINVARIANT_ID  (String value) {INVARIANT_ID = value; }
  public void setINSERITO                          ()               { INSERITO               = 1;      }   
}