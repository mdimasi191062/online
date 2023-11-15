package com.utl;

public class DB_CAT_off_x_serv_x_sconto extends DB_CAT_off_x_serv
{
  private String CODE_CLAS_SCONTO;
  private String VALO_FREQ_CICLI_SPESA;

  public String getCODE_CLAS_SCONTO()
  {
    return CODE_CLAS_SCONTO;
  }
  public void setCODE_CLAS_SCONTO(String new_CODE_CLAS_SCONTO)
  {
    CODE_CLAS_SCONTO = new_CODE_CLAS_SCONTO;
  }

  public String getVALO_FREQ_CICLI_SPESA()
  {
    return VALO_FREQ_CICLI_SPESA;
  }
  public void setVALO_FREQ_CICLI_SPESA(String new_VALO_FREQ_CICLI_SPESA)
  {
    VALO_FREQ_CICLI_SPESA = new_VALO_FREQ_CICLI_SPESA;
  }
}