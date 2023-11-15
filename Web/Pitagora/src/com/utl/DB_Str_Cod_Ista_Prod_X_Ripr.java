package com.utl;
import com.utl.AbstractDataBean;

public class DB_Str_Cod_Ista_Prod_X_Ripr extends AbstractDataBean 
{
  /* Attributi*/
  private String ID_EVENTO               ;
  /*private String ID_SISTEMA_MITTENTE  ;
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
	private String DATA_ELAB            ;*/
                          
  public DB_Str_Cod_Ista_Prod_X_Ripr()
  {
      ID_EVENTO                = "" ;
      /*ID_SISTEMA_MITTENTE   = "" ;
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
      DATA_ELAB             = "" ;*/
  }

  //GET
  public String getID_EVENTO               () { return ID_EVENTO              ; }
  /*public String getID_SISTEMA_MITTENTE   () { return ID_SISTEMA_MITTENTE ; }
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
	public String getDATA_ELAB             () { return DATA_ELAB           ; }*/
	
  //SET
  public String setID_EVENTO              (String value) { return ID_EVENTO              ; }
/*  public String setID_SISTEMA_MITTENTE (String value) { return ID_SISTEMA_MITTENTE ; }
  public String setDESC_EVENTO         (String value) { return DESC_EVENTO         ; }
  public String setDESC_TIPO_EVENTO_HD (String value) { return DESC_TIPO_EVENTO_HD ; }
	public String setCODE_OFFERTA        (String value) { return CODE_OFFERTA        ; }
	public String setDESC_OFFERTA        (String value) { return DESC_OFFERTA        ; }
	public String setCODE_SERVIZIO       (String value) { return CODE_SERVIZIO       ; }
	public String setDESC_SERVIZIO       (String value) { return DESC_SERVIZIO       ; }
	public String setCODE_ISTANZA_PROD   (String value) { return CODE_ISTANZA_PROD   ; }
	public String setCODE_PRODOTTO       (String value) { return CODE_PRODOTTO       ; }
	public String setDESC_PRODOTTO       (String value) { return DESC_PRODOTTO       ; }
	public String setCODE_ISTANZA_COMPO  (String value) { return CODE_ISTANZA_COMPO  ; }
	public String setCODE_COMPONENTE     (String value) { return CODE_COMPONENTE     ; }
	public String setDESC_COMPONENTE     (String value) { return DESC_COMPONENTE     ; }
	public String setDATA_ELAB           (String value) { return DATA_ELAB           ; }*/
}
