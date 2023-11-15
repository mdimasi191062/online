package com.ejbBMP;

import com.utl.*;

public class PeriodoRifBMPPK extends AbstractPK  
{
  private String code;
  private String descOf;
  //gianluca 09/092002-inizio-17.00
  private String dataIniCiclo;
  private String dataFineCiclo;
  private String periodoFat;
  //gianluca 09/092002-fine-17.00
  
  public PeriodoRifBMPPK()
  {
  }

  public PeriodoRifBMPPK(String code, String descrizione)
  {
   this.descOf=descrizione;
   this.code=code;
  }

  
  public String getCode()
  {
    return code;
  }
  public void setCode(String stringa)
  {
      code=stringa;
  }
  public String getDescOf()
  {
    return descOf;
  }
  public void setDescOf(String stringa)
  {
    descOf=stringa;
  }

//gianluca 09/092002-inizio-16.51
  public String getDataIniCiclo()
  {
    return dataIniCiclo;
  }
  public void setDataIniCiclo(String stringa)
  {
    dataIniCiclo=stringa;
  }
  public String getDataFineCiclo()
  {
    return dataFineCiclo;
  }
  public void setDataFineCiclo(String stringa)
  {
    dataFineCiclo=stringa;
  }
  public String getPeriodoFat()
  {
    return periodoFat;
  }
  public void setPeriodoFat(String stringa)
  {
    periodoFat=stringa;
  }
//gianluca 09/092002-fine-16.51  
}