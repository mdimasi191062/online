package com.ejbBMP;

import com.utl.AbstractPK;


public class OggFattBMPPK extends AbstractPK  
{

  private String codeOf;
  private String descOf;
  private String dataIni;
  private String dataFine;
  private String codeClasseOf;
  private String descClasseOf;
  private String tipoFlgAssocb;
  private String flagSys;
  
  public OggFattBMPPK()
  {
  }

  public OggFattBMPPK(String dataIni, String codeCOf, String descrizione, String tipoFlgAssocB, String dataFine, String codeOf)
  {
  this.dataIni=dataIni;
  this.codeClasseOf=codeCOf;
  this.descOf=descrizione;
  this.tipoFlgAssocb=tipoFlgAssocB;
  this.dataFine=dataFine;
  this.codeOf=codeOf;
  }

  
  public String getCodeOf()
  {
    return codeOf;
  }
  public void setCodeOf(String stringa)
  {
      codeOf=stringa;
  }
  public String getDescOf()
  {
    return descOf;
  }
  public void setDescOf(String stringa)
  {
    descOf=stringa;
  }
  public String getDataIni()
  {
    return dataIni;
  }
  public void setDataIni(String stringa)
  {
    dataIni=stringa;
  }
  public String getDataFine()
  {
    return dataFine;
  }
  public void setDataFine(String stringa)
  {
    dataFine=stringa;
  }
  public String getCodeClasseOf()
  {
    return codeClasseOf;
  }
  public void setCodeClasseOf(String stringa)
  {
      codeClasseOf=stringa;
  }
  public String getDescClasseOf()
  {
    return descClasseOf;
  }
  public void setDescClasseOf(String stringa)
  {
      descClasseOf=stringa;
  }
  public String getTipoFlgAssocb()
  {
    return tipoFlgAssocb;
  }
  public void setTipoFlgAssocb(String stringa)
  {
      tipoFlgAssocb=stringa;
  }
  public String getFlagSys()
  {
    return flagSys;
  }
  public void setFlagSys(String stringa)
  {
      flagSys=stringa;
  }

}