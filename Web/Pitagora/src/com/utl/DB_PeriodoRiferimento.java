package com.utl;
import com.utl.AbstractDataBean;

public class DB_PeriodoRiferimento extends AbstractDataBean
{
  String TXT_DATA_MM_RIF_SPESA_COMPL = "";
  String DATA_AA_RIF_SPESA_COMPL = "";
  String DATA_MM_RIF_SPESA_COMPL = "";
  /*
  tag attribute: DESCRIZIONE_CICLO
  */
  private String DESCRIZIONE_CICLO = "";
  /*
  tag attribute: CODE_CICLO
  */
  private String CODE_CICLO = "";

/* MM01 04/05/2005 INIZIO*/
  private String TXT_DATA_FINE_CICLO = "";

  public void setTXT_DATA_FINE_CICLO(String TXT_DATA_FINE_CICLO)
  {
    this.TXT_DATA_FINE_CICLO = TXT_DATA_FINE_CICLO;
  }

  public String getTXT_DATA_FINE_CICLO()
  {
    return TXT_DATA_FINE_CICLO;
  }
/* MM01 04/05/2005 FINE*/

  public void setTXT_DATA_MM_RIF_SPESA_COMPL(String TXT_DATA_MM_RIF_SPESA_COMPL)
  {
    this.TXT_DATA_MM_RIF_SPESA_COMPL = TXT_DATA_MM_RIF_SPESA_COMPL;
  }


  public String getTXT_DATA_MM_RIF_SPESA_COMPL()
  {
    return TXT_DATA_MM_RIF_SPESA_COMPL;
  }


  public void setDATA_AA_RIF_SPESA_COMPL(String DATA_AA_RIF_SPESA_COMPL)
  {
    this.DATA_AA_RIF_SPESA_COMPL = DATA_AA_RIF_SPESA_COMPL;
  }


  public String getDATA_AA_RIF_SPESA_COMPL()
  {
    return DATA_AA_RIF_SPESA_COMPL;
  }


  public void setDATA_MM_RIF_SPESA_COMPL(String DATA_MM_RIF_SPESA_COMPL)
  {
    this.DATA_MM_RIF_SPESA_COMPL = DATA_MM_RIF_SPESA_COMPL;
  }


  public String getDATA_MM_RIF_SPESA_COMPL()
  {
    return DATA_MM_RIF_SPESA_COMPL;
  }


  public void setDESCRIZIONE_CICLO(String value)
  {
    DESCRIZIONE_CICLO = value;
  }


  public String getDESCRIZIONE_CICLO()
  {
    return DESCRIZIONE_CICLO;
  }


  public void setCODE_CICLO(String value)
  {
    CODE_CICLO = value;
  }


  public String getCODE_CICLO()
  {
    return CODE_CICLO;
  }
  
}