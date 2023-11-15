package com.utl;

import java.io.Serializable;

import java.util.Date;

public class TariffaOpereSpeciali implements Serializable
{
  private String dataInizioTariffa;
  private String dataFineTariffa;
  private int idVoce;
  private Double impTariffa;
  private String descTariffa;
  private String unitaMisura;
  private String codeTariffa;
  private String codePrTariffa;
  private String descEsSP;
  
  public TariffaOpereSpeciali()
  {
  }

  public void setIdVoce(int idVoce)
  {
    this.idVoce = idVoce;
  }

  public int getIdVoce()
  {
    return idVoce;
  }

  public void setImpTariffa(Double impTariffa)
  {
    this.impTariffa = impTariffa;
  }

  public Double getImpTariffa()
  {
    return impTariffa;
  }

  public void setDescTariffa(String descTariffa)
  {
    this.descTariffa = descTariffa;
  }

  public String getDescTariffa()
  {
    return descTariffa;
  }

  public void setUnitaMisura(String unitaMisura)
  {
    this.unitaMisura = unitaMisura;
  }

  public String getUnitaMisura()
  {
    return unitaMisura;
  }

  public void setCodeTariffa(String codeTariffa)
  {
    this.codeTariffa = codeTariffa;
  }

  public String getCodeTariffa()
  {
    return codeTariffa;
  }

  public void setCodePrTariffa(String codePrTariffa)
  {
    this.codePrTariffa = codePrTariffa;
  }

  public String getCodePrTariffa()
  {
    return codePrTariffa;
  }

  public void setDataInizioTariffa(String dataInizioTariffa)
  {
    this.dataInizioTariffa = dataInizioTariffa;
  }

  public String getDataInizioTariffa()
  {
    return dataInizioTariffa;
  }

  public void setDataFineTariffa(String dataFineTariffa)
  {
    this.dataFineTariffa = dataFineTariffa;
  }

  public String getDataFineTariffa()
  {
    return dataFineTariffa;
  }  
  public void setDescEsSP(String descEsSP)
  {
    this.descEsSP = descEsSP;
  }

  public String getDescEsSP()
  {
    return descEsSP;
  }
}
