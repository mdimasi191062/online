package com.utl;
import java.io.Serializable;

public class DB_TipiContratto implements Serializable
{
  private String CODE_TIPO_CONTR;
  private String DESC_TIPO_CONTR;
  private String FLAG_SYS;
  private String TIPO_SPECIAL;

  public DB_TipiContratto()
  {
  }

  public String getCODE_TIPO_CONTR()
  {
    return CODE_TIPO_CONTR;
  }

  public void setCODE_TIPO_CONTR(String newCODE_TIPO_CONTR)
  {
    CODE_TIPO_CONTR = newCODE_TIPO_CONTR;
  }

  public String getDESC_TIPO_CONTR()
  {
    return DESC_TIPO_CONTR;
  }

  public void setDESC_TIPO_CONTR(String newDESC_TIPO_CONTR)
  {
    DESC_TIPO_CONTR = newDESC_TIPO_CONTR;
  }

  public String getFLAG_SYS()
  {
    return FLAG_SYS;
  }

  public void setFLAG_SYS(String newFLAG_SYS)
  {
    FLAG_SYS = newFLAG_SYS;
  }

  public String getTIPO_SPECIAL()
  {
    return TIPO_SPECIAL;
  }

  public void setTIPO_SPECIAL(String newTIPO_SPECIAL)
  {
    TIPO_SPECIAL = newTIPO_SPECIAL;
  }


}