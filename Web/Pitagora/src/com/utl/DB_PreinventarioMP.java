package com.utl;
import com.utl.AbstractDataBean;

public class DB_PreinventarioMP extends AbstractDataBean 
{

  /* Attributi */
  private String ID_SISTEMA_MITTENTE            ;
	private String ID_EVENTO                      ;
	private String CODE_ISTANZA_PROD              ;
	private String CODE_ISTANZA_COMPO             ;
	private String CODE_ISTANZA_PREST_AGG         ;
	private String DESC_NUM_ORDINE_CLIENTE        ;
	private String DESC_NUM_ORDINE_CLIENTE_CESSAZ ;
	private String DESC_TIPO_RETE                 ;
	private String DESC_SEDE_1                    ;
	private String DESC_IMPIANTO_SEDE_1           ;
	private String DESC_COMUNE_SEDE_1             ;
	private String DESC_PROVINCIA_SEDE_1          ;
	private String DESC_DTRT_SEDE_1               ;
	private String DESC_CENTRALE_SEDE_1           ;
	private String DESC_SEDE_2                    ;
	private String DESC_IMPIANTO_SEDE_2           ;
	private String DESC_COMUNE_SEDE_2             ;
	private String DESC_PROVINCIA_SEDE_2          ;
	private String DESC_DTRT_SEDE_2               ;
	private String DESC_CENTRALE_SEDE_2           ;
  
  public DB_PreinventarioMP()
  {
  	ID_SISTEMA_MITTENTE            = "";
    ID_EVENTO                      = "";
    CODE_ISTANZA_PROD              = "";
    CODE_ISTANZA_COMPO             = "";
    CODE_ISTANZA_PREST_AGG         = "";
    DESC_NUM_ORDINE_CLIENTE        = "";
    DESC_NUM_ORDINE_CLIENTE_CESSAZ = "";
    DESC_TIPO_RETE                 = "";
    DESC_SEDE_1                    = "";
    DESC_IMPIANTO_SEDE_1           = "";
    DESC_COMUNE_SEDE_1             = "";
    DESC_PROVINCIA_SEDE_1          = "";
    DESC_DTRT_SEDE_1               = "";
    DESC_CENTRALE_SEDE_1           = "";
    DESC_SEDE_2                    = "";
    DESC_IMPIANTO_SEDE_2           = "";
    DESC_COMUNE_SEDE_2             = "";
    DESC_PROVINCIA_SEDE_2          = "";
    DESC_DTRT_SEDE_2               = "";
    DESC_CENTRALE_SEDE_2           = "";
  }

  public String getID_SISTEMA_MITTENTE            () { return ID_SISTEMA_MITTENTE           ; }
	public String getID_EVENTO                      () { return ID_EVENTO                     ; }
	public String getCODE_ISTANZA_PROD              () { return CODE_ISTANZA_PROD             ; }
	public String getCODE_ISTANZA_COMPO             () { return CODE_ISTANZA_COMPO            ; }
	public String getCODE_ISTANZA_PREST_AGG         () { return CODE_ISTANZA_PREST_AGG        ; }
	public String getDESC_NUM_ORDINE_CLIENTE        () { return DESC_NUM_ORDINE_CLIENTE       ; }
	public String getDESC_NUM_ORDINE_CLIENTE_CESSAZ () { return DESC_NUM_ORDINE_CLIENTE_CESSAZ; }
	public String getDESC_TIPO_RETE                 () { return DESC_TIPO_RETE                ; }
	public String getDESC_SEDE_1                    () { return DESC_SEDE_1                   ; }
	public String getDESC_IMPIANTO_SEDE_1           () { return DESC_IMPIANTO_SEDE_1          ; }
	public String getDESC_COMUNE_SEDE_1             () { return DESC_COMUNE_SEDE_1            ; }
	public String getDESC_PROVINCIA_SEDE_1          () { return DESC_PROVINCIA_SEDE_1         ; }
	public String getDESC_DTRT_SEDE_1               () { return DESC_DTRT_SEDE_1              ; }
	public String getDESC_CENTRALE_SEDE_1           () { return DESC_CENTRALE_SEDE_1          ; }
	public String getDESC_SEDE_2                    () { return DESC_SEDE_2                   ; }
	public String getDESC_IMPIANTO_SEDE_2           () { return DESC_IMPIANTO_SEDE_2          ; }
	public String getDESC_COMUNE_SEDE_2             () { return DESC_COMUNE_SEDE_2            ; }
	public String getDESC_PROVINCIA_SEDE_2          () { return DESC_PROVINCIA_SEDE_2         ; }
	public String getDESC_DTRT_SEDE_2               () { return DESC_DTRT_SEDE_2              ; }
	public String getDESC_CENTRALE_SEDE_2           () { return DESC_CENTRALE_SEDE_2          ; }

	public void setID_SISTEMA_MITTENTE            ( String value ) { ID_SISTEMA_MITTENTE            = value; }
	public void setID_EVENTO                      ( String value ) { ID_EVENTO                      = value; }
	public void setCODE_ISTANZA_PROD              ( String value ) { CODE_ISTANZA_PROD              = value; }
	public void setCODE_ISTANZA_COMPO             ( String value ) { CODE_ISTANZA_COMPO             = value; }
	public void setCODE_ISTANZA_PREST_AGG         ( String value ) { CODE_ISTANZA_PREST_AGG         = value; }
	public void setDESC_NUM_ORDINE_CLIENTE        ( String value ) { DESC_NUM_ORDINE_CLIENTE        = value; }
	public void setDESC_NUM_ORDINE_CLIENTE_CESSAZ ( String value ) { DESC_NUM_ORDINE_CLIENTE_CESSAZ = value; }
	public void setDESC_TIPO_RETE                 ( String value ) { DESC_TIPO_RETE                 = value; }
	public void setDESC_SEDE_1                    ( String value ) { DESC_SEDE_1                    = value; }
	public void setDESC_IMPIANTO_SEDE_1           ( String value ) { DESC_IMPIANTO_SEDE_1           = value; }
	public void setDESC_COMUNE_SEDE_1             ( String value ) { DESC_COMUNE_SEDE_1             = value; }
	public void setDESC_PROVINCIA_SEDE_1          ( String value ) { DESC_PROVINCIA_SEDE_1          = value; }
	public void setDESC_DTRT_SEDE_1               ( String value ) { DESC_DTRT_SEDE_1               = value; }
	public void setDESC_CENTRALE_SEDE_1           ( String value ) { DESC_CENTRALE_SEDE_1           = value; }
	public void setDESC_SEDE_2                    ( String value ) { DESC_SEDE_2                    = value; }
	public void setDESC_IMPIANTO_SEDE_2           ( String value ) { DESC_IMPIANTO_SEDE_2           = value; }
	public void setDESC_COMUNE_SEDE_2             ( String value ) { DESC_COMUNE_SEDE_2             = value; }
	public void setDESC_PROVINCIA_SEDE_2          ( String value ) { DESC_PROVINCIA_SEDE_2          = value; }
	public void setDESC_DTRT_SEDE_2               ( String value ) { DESC_DTRT_SEDE_2               = value; }
	public void setDESC_CENTRALE_SEDE_2           ( String value ) { DESC_CENTRALE_SEDE_2           = value; }

}