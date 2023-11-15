package com.utl;
import java.io.Serializable;
import java.math.BigDecimal;

public class I5_2SCONTO_CL_ROW implements Serializable 
{
  private String CodeSconto = null;
  private String DescSconto = null;
  private Integer PercSconto = null;
  private BigDecimal Decremento = null; 

  public I5_2SCONTO_CL_ROW()
  {
    CodeSconto = null;
    DescSconto = null;
    PercSconto = null;
    Decremento = null;    
  }

  public void setCodeSconto(String code_sconto)
  {
    CodeSconto = code_sconto;
  }


  public void setDescSconto(String desc_sconto)
  {
    DescSconto = desc_sconto;
  }

  public void setPercSconto(Integer perc_sconto)
  {
    PercSconto = perc_sconto;
  }

  public void setDecremento(BigDecimal decremento)
  {
    Decremento = decremento;
  }
  
  

  public String getCodeSconto()
  {
    return CodeSconto;
  }
  
  public String getDescSconto()
  {
    return DescSconto;
  }

  public Integer getPercSconto()
  {
    return PercSconto;
  }

  public BigDecimal getDecremento()
  {
    return Decremento;
  }


}