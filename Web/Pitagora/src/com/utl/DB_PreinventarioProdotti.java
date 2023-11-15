package com.utl;
import com.utl.AbstractDataBean;

public class DB_PreinventarioProdotti extends AbstractDataBean 
{
/* Attributi*/
 private String ID_SISTEMA_MITTENTE           ; 
 private String ID_EVENTO                     ; 
 private String ID_TRANSAZIONE                ; 
 private String CODE_EVENTO                   ; 
 private String CODE_TIPO_EVENTO              ; 
 private String CODE_TIPO_EVENTO_HD           ; 
 private String TIPO_ELAB                     ; 
 private String CODE_ACCOUNT                  ; 
 private String CODE_OFFERTA                  ; 
 private String CODE_SERVIZIO                 ; 
 private String CODE_PRODOTTO                 ; 
 private String CODE_ISTANZA_PROD             ; 
 private String DATA_EFFETTIVA_EVENTO         ; 
 private String DATA_RICEZIONE_ORDINE         ; 
 private String DATA_RICHIESTA_CESSAZ         ; 
 private String DATA_CREAZ                    ; 
 private String DATA_ULTIMA_FATRZ             ; 
 private String QNTA_VALO                     ; 
 private String TIPO_FLAG_CONSISTENZA         ;
 private String DATA_INIZIO_NOL_ORIGINALE     ;
 private String CODICE_PROGETTO               ;
  private String INVARIANT_ID;
 
  public DB_PreinventarioProdotti()
  {
  	ID_SISTEMA_MITTENTE       =""    ; 
    ID_EVENTO                 =""    ; 
    ID_TRANSAZIONE            =""    ; 
    CODE_EVENTO               =""    ; 
    CODE_TIPO_EVENTO          =""    ; 
    CODE_TIPO_EVENTO_HD       =""    ; 
    TIPO_ELAB                 =""    ; 
    CODE_ACCOUNT              =""    ; 
    CODE_OFFERTA              =""    ; 
    CODE_SERVIZIO             =""    ; 
    CODE_PRODOTTO             =""    ; 
    CODE_ISTANZA_PROD         =""    ; 
    DATA_EFFETTIVA_EVENTO     =""    ; 
    DATA_RICEZIONE_ORDINE     =""    ; 
    DATA_RICHIESTA_CESSAZ     =""    ; 
    DATA_CREAZ                =""    ; 
    DATA_ULTIMA_FATRZ         =""    ; 
    QNTA_VALO                 =""    ; 
    TIPO_FLAG_CONSISTENZA     =""    ; 
    DATA_INIZIO_NOL_ORIGINALE =""    ;
    CODICE_PROGETTO           =""    ;
    INVARIANT_ID = ""; 
  }

  public void setID_SISTEMA_MITTENTE    (String value) {	ID_SISTEMA_MITTENTE  	= value	;} 
	public void setID_EVENTO              (String value) {	ID_EVENTO            	= value	;} 
	public void setID_TRANSAZIONE         (String value) {	ID_TRANSAZIONE       	= value	;} 
	public void setCODE_EVENTO            (String value) {	CODE_EVENTO          	= value	;} 
	public void setCODE_TIPO_EVENTO       (String value) {	CODE_TIPO_EVENTO     	= value	;} 
	public void setCODE_TIPO_EVENTO_HD    (String value) {	CODE_TIPO_EVENTO_HD  	= value	;} 
	public void setTIPO_ELAB              (String value) {	TIPO_ELAB            	= value	;} 
	public void setCODE_ACCOUNT           (String value) {	CODE_ACCOUNT         	= value	;} 
	public void setCODE_OFFERTA           (String value) {	CODE_OFFERTA         	= value	;} 
	public void setCODE_SERVIZIO          (String value) {	CODE_SERVIZIO        	= value	;} 
	public void setCODE_PRODOTTO          (String value) {	CODE_PRODOTTO        	= value	;} 
	public void setCODE_ISTANZA_PROD      (String value) {	CODE_ISTANZA_PROD    	= value	;} 
	public void setDATA_EFFETTIVA_EVENTO  (String value) {	DATA_EFFETTIVA_EVENTO	= value	;} 
	public void setDATA_RICEZIONE_ORDINE  (String value) {	DATA_RICEZIONE_ORDINE	= value	;} 
	public void setDATA_RICHIESTA_CESSAZ  (String value) {	DATA_RICHIESTA_CESSAZ	= value	;} 
	public void setDATA_CREAZ             (String value) {	DATA_CREAZ           	= value	;} 
	public void setDATA_ULTIMA_FATRZ      (String value) {	DATA_ULTIMA_FATRZ    	= value	;} 
	public void setQNTA_VALO              (String value) {	QNTA_VALO            	= value	;} 
	public void setTIPO_FLAG_CONSISTENZA  (String value) {	TIPO_FLAG_CONSISTENZA	= value	;} 
  public void setDATA_INIZIO_NOL_ORIGINALE  (String value) {DATA_INIZIO_NOL_ORIGINALE = value; }
  public void setCODICE_PROGETTO            (String value) {CODICE_PROGETTO = value; }
  public void setINVARIANT_ID  (String value) {INVARIANT_ID = value; }

 	public String getID_SISTEMA_MITTENTE    () {	return ID_SISTEMA_MITTENTE  	;	} 
	public String getID_EVENTO              () {	return ID_EVENTO            	;	} 
	public String getID_TRANSAZIONE         () {	return ID_TRANSAZIONE       	;	} 
	public String getCODE_EVENTO            () {	return CODE_EVENTO          	;	} 
	public String getCODE_TIPO_EVENTO       () {	return CODE_TIPO_EVENTO     	;	} 
	public String getCODE_TIPO_EVENTO_HD    () {	return CODE_TIPO_EVENTO_HD  	;	} 
	public String getTIPO_ELAB              () {	return TIPO_ELAB            	;	} 
	public String getCODE_ACCOUNT           () {	return CODE_ACCOUNT         	;	} 
	public String getCODE_OFFERTA           () {	return CODE_OFFERTA         	;	} 
	public String getCODE_SERVIZIO          () {	return CODE_SERVIZIO        	;	} 
	public String getCODE_PRODOTTO          () {	return CODE_PRODOTTO        	;	} 
	public String getCODE_ISTANZA_PROD      () {	return CODE_ISTANZA_PROD    	;	} 
	public String getDATA_EFFETTIVA_EVENTO  () {	return DATA_EFFETTIVA_EVENTO	;	} 
	public String getDATA_RICEZIONE_ORDINE  () {	return DATA_RICEZIONE_ORDINE	;	} 
	public String getDATA_RICHIESTA_CESSAZ  () {	return DATA_RICHIESTA_CESSAZ	;	} 
	public String getDATA_CREAZ             () {	return DATA_CREAZ           	;	} 
	public String getDATA_ULTIMA_FATRZ      () {	return DATA_ULTIMA_FATRZ    	;	} 
	public String getQNTA_VALO              () {	return QNTA_VALO            	;	} 
	public String getTIPO_FLAG_CONSISTENZA  () {	return TIPO_FLAG_CONSISTENZA	;	} 
  public String getDATA_INIZIO_NOL_ORIGINALE  () { return DATA_INIZIO_NOL_ORIGINALE ; }
  public String getCODICE_PROGETTO            () { return CODICE_PROGETTO ; }
  public String getINVARIANT_ID  () { return INVARIANT_ID ; }
  
}