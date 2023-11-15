package com.utl;
import com.utl.AbstractDataBean;

public class DB_VisualizzaInfo extends AbstractDataBean
{
 private String DESC_OFFERTA    ;
 private String DESC_SERVIZIO   ;
 private String PRIMO_NOL       ;
 private String RINNOVO_NOL     ;
 private String TEMPO_PREAVVISO ;
 private String FLAG_SPESA      ;
 private String DATO_ESERCIZIO  ;
 private String DESC_MODAL_APPLICAB_NOLEG ; 
 private String TRASMISSIVO ;
 private String COLOCATA ;
 private String DATA_FINE_NOL ;
 //QS: 15-01-2008
 private String CODE_MODAL_APPLICAB_NOLEG;

 
 public void setDESC_OFFERTA    ( String value ) {DESC_OFFERTA   = value;}
 public void setDESC_SERVIZIO   ( String value ) {DESC_SERVIZIO  = value;}
 public void setPRIMO_NOL       ( String value ) {PRIMO_NOL      = value;}
 public void setRINNOVO_NOL     ( String value ) {RINNOVO_NOL    = value;}
 public void setTEMPO_PREAVVISO ( String value ) {TEMPO_PREAVVISO= value;}
 public void setFLAG_SPESA      ( String value ) {FLAG_SPESA     = value;}
 public void setDATO_ESERCIZIO  ( String value ) {DATO_ESERCIZIO = value;}
 public void setDESC_MODAL_APPLICAB_NOLEG (String value) { DESC_MODAL_APPLICAB_NOLEG =value;}
 public void setTRASMISSIVO (String value) { TRASMISSIVO =value;}
 public void setCOLOCATA (String value) { COLOCATA =value;}
 public void setDATA_FINE_NOL (String value) { DATA_FINE_NOL =value;} 
  //QS: 15-01-2008
  public void setCODE_MODAL_APPLICAB_NOLEG (String value) { CODE_MODAL_APPLICAB_NOLEG =value;}
 
 public String getDESC_OFFERTA   () { return DESC_OFFERTA    ;}
 public String getDESC_SERVIZIO  () { return DESC_SERVIZIO   ;}
 public String getPRIMO_NOL      () { return PRIMO_NOL       ;}
 public String getRINNOVO_NOL    () { return RINNOVO_NOL     ;}
 public String getTEMPO_PREAVVISO() { return TEMPO_PREAVVISO ;}
 public String getFLAG_SPESA     () { return FLAG_SPESA      ;}
 public String getDATO_ESERCIZIO () { return DATO_ESERCIZIO  ;}
 public String getDESC_MODAL_APPLICAB_NOLEG () { return DESC_MODAL_APPLICAB_NOLEG;}
 public String getTRASMISSIVO () { return TRASMISSIVO;}
 public String getCOLOCATA () { return COLOCATA;}
 public String getDATA_FINE_NOL () { return DATA_FINE_NOL;} 
  //QS: 15-01-2008
  public String getCODE_MODAL_APPLICAB_NOLEG () { return CODE_MODAL_APPLICAB_NOLEG;} 
  
 public DB_VisualizzaInfo() {
    DESC_OFFERTA    = "";
    DESC_SERVIZIO   = "";
    PRIMO_NOL       = "";
    RINNOVO_NOL     = "";
    TEMPO_PREAVVISO = "";
    FLAG_SPESA      = "";
    DATO_ESERCIZIO  = "";
    DESC_MODAL_APPLICAB_NOLEG = "";
    TRASMISSIVO = "";
    COLOCATA = "";
    DATA_FINE_NOL = "";
    //QS: 15-01-2008
    CODE_MODAL_APPLICAB_NOLEG ="";
 }

}
