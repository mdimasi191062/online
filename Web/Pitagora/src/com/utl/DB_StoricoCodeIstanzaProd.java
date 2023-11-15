package com.utl;
import com.utl.AbstractDataBean;

public class DB_StoricoCodeIstanzaProd extends AbstractDataBean 
{
  /* Attributi*/
  private String EVENTO               ;
  private String ID_SISTEMA_MITTENTE  ;
  private String DESC_EVENTO          ;
  private String DESC_TIPO_EVENTO_HD  ;
	private String CODE_OFFERTA         ;
	private String DESC_OFFERTA         ;
	private String CODE_SERVIZIO        ;
	private String DESC_SERVIZIO        ;
	private String CODE_ISTANZA_PROD    ;
	private String CODE_PRODOTTO        ;
	private String DESC_PRODOTTO        ;
	private String CODE_ISTANZA_COMPO   ;
	private String CODE_COMPONENTE      ;
	private String DESC_COMPONENTE      ;
	private String DATA_ELAB            ;
  private String DATA_RIC_ORD         ;
  private String DATA_RIC_CESS        ;
   private String  DATA_EFF_EVENTO    ;
                          
  public DB_StoricoCodeIstanzaProd()
  {
      EVENTO                = "" ;
      ID_SISTEMA_MITTENTE   = "" ;
      DESC_EVENTO           = "" ;
      DESC_TIPO_EVENTO_HD   = "" ;
      CODE_OFFERTA          = "" ;
      DESC_OFFERTA          = "" ;
      CODE_SERVIZIO         = "" ;
      DESC_SERVIZIO         = "" ;
      CODE_ISTANZA_PROD     = "" ;
      CODE_PRODOTTO         = "" ;
      DESC_PRODOTTO         = "" ;
      CODE_ISTANZA_COMPO    = "" ;
      CODE_COMPONENTE       = "" ;
      DESC_COMPONENTE       = "" ;
      DATA_ELAB             = "" ;
      DATA_RIC_ORD          = "" ;
      DATA_RIC_CESS         = "" ;
      DATA_EFF_EVENTO       = "" ;                 
  }

  //GET
  public String getEVENTO                () { return EVENTO              ; }
  public String getID_SISTEMA_MITTENTE   () { return ID_SISTEMA_MITTENTE ; }
  public String getDESC_EVENTO           () { return DESC_EVENTO         ; }
  public String getDESC_TIPO_EVENTO_HD   () { return DESC_TIPO_EVENTO_HD ; }
	public String getCODE_OFFERTA          () { return CODE_OFFERTA        ; }
	public String getDESC_OFFERTA          () { return DESC_OFFERTA        ; }
	public String getCODE_SERVIZIO         () { return CODE_SERVIZIO       ; }
	public String getDESC_SERVIZIO         () { return DESC_SERVIZIO       ; }
	public String getCODE_ISTANZA_PROD     () { return CODE_ISTANZA_PROD   ; }
	public String getCODE_PRODOTTO         () { return CODE_PRODOTTO       ; }
	public String getDESC_PRODOTTO         () { return DESC_PRODOTTO       ; }
	public String getCODE_ISTANZA_COMPO    () { return CODE_ISTANZA_COMPO  ; }
	public String getCODE_COMPONENTE       () { return CODE_COMPONENTE     ; }
	public String getDESC_COMPONENTE       () { return DESC_COMPONENTE     ; }
	public String getDATA_ELAB             () { return DATA_ELAB           ; }
  public String getDATA_RIC_ORD          () { return DATA_RIC_ORD        ; }
  public String getDATA_RIC_CESS         () { return DATA_RIC_CESS       ; }
  public String getDATA_EFF_EVENTO       () { return DATA_EFF_EVENTO     ; }  
  //SET
  public void setEVENTO              (String value) { EVENTO = value              ; }
  public void setID_SISTEMA_MITTENTE (String value) { ID_SISTEMA_MITTENTE = value ; }
  public void setDESC_EVENTO         (String value) { DESC_EVENTO = value         ; }
  public void setDESC_TIPO_EVENTO_HD (String value) { DESC_TIPO_EVENTO_HD = value ; }
	public void setCODE_OFFERTA        (String value) { CODE_OFFERTA = value        ; }
	public void setDESC_OFFERTA        (String value) { DESC_OFFERTA = value        ; }
	public void setCODE_SERVIZIO       (String value) { CODE_SERVIZIO = value       ; }
	public void setDESC_SERVIZIO       (String value) { DESC_SERVIZIO = value       ; }
	public void setCODE_ISTANZA_PROD   (String value) { CODE_ISTANZA_PROD = value   ; }
	public void setCODE_PRODOTTO       (String value) { CODE_PRODOTTO = value       ; }
	public void setDESC_PRODOTTO       (String value) { DESC_PRODOTTO = value       ; }
	public void setCODE_ISTANZA_COMPO  (String value) { CODE_ISTANZA_COMPO = value  ; }
	public void setCODE_COMPONENTE     (String value) { CODE_COMPONENTE = value     ; }
	public void setDESC_COMPONENTE     (String value) { DESC_COMPONENTE = value     ; }
	public void setDATA_ELAB           (String value) { DATA_ELAB = value           ; }
  public void setDATA_RIC_ORD        (String value) { DATA_RIC_ORD = value        ; }
  public void setDATA_RIC_CESS       (String value) { DATA_RIC_CESS = value       ; }
  public void setDATA_EFF_EVENTO       (String value) { DATA_EFF_EVENTO = value       ; }  
}
