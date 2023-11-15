package com.ejbSTL;
import java.io.Serializable;

public class I5_2PROMOZIONI_TIPI_ROW implements Serializable 
{
  private Integer TIPO_PROMOZIONE;
  private String DESCRIZIONE;

  public I5_2PROMOZIONI_TIPI_ROW()
  {
  	TIPO_PROMOZIONE = null;
	DESCRIZIONE = null;
  }
  
  public Integer getTIPO_PROMOZIONE()
  {
    return TIPO_PROMOZIONE;
  }

  public void setTIPO_PROMOZIONE(Integer new_TIPO_PROMOZIONE)
  {
    TIPO_PROMOZIONE = new_TIPO_PROMOZIONE;
  }  

  public String getDESCRIZIONE()
  {
    return DESCRIZIONE;
  }

  public void setDESCRIZIONE(String new_DESCRIZIONE)
  {
    DESCRIZIONE = new_DESCRIZIONE;
  }  
  
}