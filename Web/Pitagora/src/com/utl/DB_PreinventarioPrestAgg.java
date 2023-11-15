package com.utl;

public class DB_PreinventarioPrestAgg extends AbstractDataBean 
{
  /* Attributi */
	private String ID_SISTEMA_MITTENTE    ;
	private String ID_EVENTO              ;
	private String CODE_EVENTO            ;
	private String CODE_PRODOTTO          ;
	private String CODE_COMPONENTE        ;
	private String CODE_PREST_AGG         ;
	private String CODE_ISTANZA_PROD      ;
	private String CODE_ISTANZA_COMPO     ;
	private String CODE_ISTANZA_PREST_AGG ;
	private String DATA_EFFETTIVA_EVENTO  ;
	private String DATA_RICEZIONE_ORDINE  ;
	private String DATA_RICHIESTA_CESSAZ  ;
	private String DATA_ULTIMA_FATRZ      ;
	private String QNTA_VALO              ;
  private String DATA_INIZIO_NOL_ORIGINALE ;
  private String INVARIANT_ID;
  
  public DB_PreinventarioPrestAgg()
  {	
      ID_SISTEMA_MITTENTE    = "";
      ID_EVENTO              = "";
      CODE_EVENTO            = "";
      CODE_PRODOTTO          = "";
      CODE_COMPONENTE        = "";
      CODE_PREST_AGG         = "";
      CODE_ISTANZA_PROD      = "";
      CODE_ISTANZA_COMPO     = "";
      CODE_ISTANZA_PREST_AGG = "";
      DATA_EFFETTIVA_EVENTO  = "";
      DATA_RICEZIONE_ORDINE  = "";
      DATA_RICHIESTA_CESSAZ  = "";
      DATA_ULTIMA_FATRZ      = "";
      QNTA_VALO              = "";
      DATA_INIZIO_NOL_ORIGINALE = "";
      INVARIANT_ID = "";
  }

	public void setID_SISTEMA_MITTENTE    (String value) { ID_SISTEMA_MITTENTE    = value;}
	public void setID_EVENTO              (String value) { ID_EVENTO              = value;}
	public void setCODE_EVENTO            (String value) { CODE_EVENTO            = value;}
	public void setCODE_PRODOTTO          (String value) { CODE_PRODOTTO          = value;}
	public void setCODE_COMPONENTE        (String value) { CODE_COMPONENTE        = value;}
	public void setCODE_PREST_AGG         (String value) { CODE_PREST_AGG         = value;}
	public void setCODE_ISTANZA_PROD      (String value) { CODE_ISTANZA_PROD      = value;}
	public void setCODE_ISTANZA_COMPO     (String value) { CODE_ISTANZA_COMPO     = value;}
	public void setCODE_ISTANZA_PREST_AGG (String value) { CODE_ISTANZA_PREST_AGG = value;}
	public void setDATA_EFFETTIVA_EVENTO  (String value) { DATA_EFFETTIVA_EVENTO  = value;}
	public void setDATA_RICEZIONE_ORDINE  (String value) { DATA_RICEZIONE_ORDINE  = value;}
	public void setDATA_RICHIESTA_CESSAZ  (String value) { DATA_RICHIESTA_CESSAZ  = value;}
	public void setDATA_ULTIMA_FATRZ      (String value) { DATA_ULTIMA_FATRZ      = value;}
	public void setQNTA_VALO              (String value) { QNTA_VALO              = value;}
  public void setDATA_INIZIO_NOL_ORIGINALE  (String value) {DATA_INIZIO_NOL_ORIGINALE = value; }
  public void setINVARIANT_ID  (String value) {INVARIANT_ID = value; } 


  public String getID_SISTEMA_MITTENTE    () { return ID_SISTEMA_MITTENTE    ;}
	public String getID_EVENTO              () { return ID_EVENTO              ;}
	public String getCODE_EVENTO            () { return CODE_EVENTO            ;}
	public String getCODE_PRODOTTO          () { return CODE_PRODOTTO          ;}
	public String getCODE_COMPONENTE        () { return CODE_COMPONENTE        ;}
	public String getCODE_PREST_AGG         () { return CODE_PREST_AGG         ;}
	public String getCODE_ISTANZA_PROD      () { return CODE_ISTANZA_PROD      ;}
	public String getCODE_ISTANZA_COMPO     () { return CODE_ISTANZA_COMPO     ;}
	public String getCODE_ISTANZA_PREST_AGG () { return CODE_ISTANZA_PREST_AGG ;}
	public String getDATA_EFFETTIVA_EVENTO  () { return DATA_EFFETTIVA_EVENTO  ;}
	public String getDATA_RICEZIONE_ORDINE  () { return DATA_RICEZIONE_ORDINE  ;}
	public String getDATA_RICHIESTA_CESSAZ  () { return DATA_RICHIESTA_CESSAZ  ;}
	public String getDATA_ULTIMA_FATRZ      () { return DATA_ULTIMA_FATRZ      ;}
	public String getQNTA_VALO              () { return QNTA_VALO              ;}
  public String getDATA_INIZIO_NOL_ORIGINALE  () { return DATA_INIZIO_NOL_ORIGINALE ; }
  public String getINVARIANT_ID  () { return INVARIANT_ID ; }
  
}