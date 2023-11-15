package com.ejbBMP;
import com.utl.*;
//import java.io.Serializable;

public class CicloFatBMPPK extends  AbstractPK 
{
  private String codeCf;
  private String descCf;

  public CicloFatBMPPK()
  {
  }

  public CicloFatBMPPK(String codeCf,String descrizione)
  {
    this.descCf=descrizione;
    this.codeCf=codeCf;
  }

  public String getCodeCf()
  {
    return codeCf;
  }
  public void setCodeCf(String stringa)
  {
      codeCf=stringa;
  }
  public String getDescCf()
  {
    return descCf;
  }
  public void setDescCf(String stringa)
  {
    descCf=stringa;
  }
}
