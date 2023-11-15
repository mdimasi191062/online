package com.ejbBMP;
import java.io.Serializable;

public class AssOfPsXContrBMPPK implements Serializable 
{

  private String codePs;
  private String descPs;
  private String dataIni;
  private String dataFine;
  private String codeOf;
  private String descOf;
  private String dataIniOf;
  private String dataFineOf;
  private String codeCOf;
  private String descCOf;
  private String dataIniOfPs;
  private String dataFineOfPs;
  private String codeFreq;
  private String descFreq;  
  private String codeModal;
  private String descModal;
  private String tipoFlgAP;
  private int qntaShiftCanoni;
  private String codeTipoContr;

  private String flagSys;
  private String codeContr;
  private String descContr;
  private String dataIniContr;
  
  

  public AssOfPsXContrBMPPK()
  {
  }

  public AssOfPsXContrBMPPK(String codePs,String descPs,String dataIni,String dataFine,String codeOf,String descOf,String dataIniOf,String dataFineOf,String codeCOf,String descCOf,String dataIniOfPs,String dataFineOfPs,String codeFreq,String descFreq,String codeModal,String descModal,String tipoFlgAP,
                            int qntaShiftCanoni,String codeTipoContr, String flagSys,String codeContr, String descContr, String dataIniContr)
  {
  this.codePs=codePs;
  this.descPs=descPs;
  this.dataIni=dataIni;
  this.dataFine=dataFine;
  this.codeOf=codeOf;
  this.descOf=descOf;
  this.dataIniOf=dataIniOf;
  this.dataFineOf=dataFineOf;
  this.codeCOf=codeCOf;
  this.descCOf=descCOf;
  this.dataIniOfPs=dataIniOfPs;
  this.dataFineOfPs=dataFineOfPs;
  this.codeFreq=codeFreq;
  this.descFreq=descFreq;
  this.codeModal=codeModal;
  this.descModal=descModal;
  this.tipoFlgAP=tipoFlgAP;
  this.qntaShiftCanoni=qntaShiftCanoni;
  this.codeTipoContr=codeTipoContr;
  
  this.flagSys=flagSys;
  this.codeContr=codeContr;
  this.descContr=descContr;
  this.dataIniContr=dataIniContr;
  
  }

  public String getCodePs()
    {return this.codePs;}

  public void setCodePs(String s)
    {this.codePs=s;}
  
  public String getDescPs()
    {return this.descPs;}

  public void setDescPs(String s)
    {this.descPs=s;}

  public String getDataIni()
    {return this.dataIni;}

  public void setDataIni(String s)
    {this.dataIni=s;}

  public String getDataFine()
    {return this.dataFine;}

  public void setDataFine(String s)
    {this.dataFine=s;}

  public String getCodeOf()
    {return this.codeOf;}

  public void setCodeOf(String s)
    {this.codeOf=s;}

  public String getDescOf()
    {return this.descOf;}

  public void setDescOf(String s)
    {this.descOf=s;}

  public String getDataIniOf()
    {return this.dataIniOf;}

  public void setDataIniOf(String s)
    {this.dataIniOf=s;}

  public String getDataFineOf()
    {return this.dataFineOf;}

  public void setDataFineOf(String s)
    {this.dataFineOf=s;}

  public String getCodeCOf()
    {return this.codeCOf;}

  public void setCodeCOf(String s)
    {this.codeCOf=s;}

  public String getDescCOf()
    {return this.descCOf;}

  public void setDescCOf(String s)
    {this.descCOf=s;}

  public String getDataIniOfPs()
    {return this.dataIniOfPs;}

  public void setDataIniOfPs(String s)
    {this.dataIniOfPs=s;}

  public String getDataFineOfPs()
    {return this.dataFineOfPs;}

  public void setDataFineOfPs(String s)
    {this.dataFineOfPs=s;}

  public String getCodeFreq()
    {return this.codeFreq;}

  public void setCodeFreq(String s)
    {this.codeFreq=s;}

  public String getDescFreq()
    {return this.descFreq;}

  public void setDescFreq(String s)
    {this.descFreq=s;}

  public String getCodeModal()
    {return this.codeModal;}

  public void setCodeModal(String s)
    {this.codeModal=s;}


  public String getDescModal()
    {return this.descModal;}

  public void setDescModal(String s)
    {this.descModal=s;}
  public String getTipoFlgAP()
    {return this.tipoFlgAP;}

  public void setTipoFlgAP(String s)
    {this.tipoFlgAP=s;}

  public int getQntaShiftCanoni()
    {return this.qntaShiftCanoni;}

  public void setQntaShiftCanoni(int i)
    {this.qntaShiftCanoni=i;}

  public String getCodeTipoContr()
    {return this.codeTipoContr;}

  public void setCodeTipoContr(String s)
    {this.codeTipoContr=s;}

  public String getFlagSys()
    {return this.flagSys;}

  public void setFlagSys(String s)
    {this.flagSys=s;}

  public String getCodeContr()
    {return this.codeContr;}

  public void setCodeContr(String s)
    {this.codeContr=s;}

  public String getDescContr()
    {return this.descContr;}

  public void setDescContr(String s)
    {this.descContr=s;}

  public String getDataIniContr()
    {return this.dataIniContr;}

  public void setDataIniContr(String s)
    {this.dataIniContr=s;}

  public boolean equals(Object other)
  {
    // Add custom equals() impl here
    return super.equals(other);
  }

  public int hashCode()
  {
    // Add custom hashCode() impl here
    return super.hashCode();
  }
}