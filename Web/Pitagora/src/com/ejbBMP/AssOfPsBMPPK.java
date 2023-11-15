package com.ejbBMP;
import java.io.Serializable;

public class AssOfPsBMPPK implements Serializable 
{

  private String codePs;
  private String descPs;
  private String dataIniPs;
  private String dataFinePs;
  private String codeTipo;
  private String descTipo;
  private String codeOf;
  private String descOf;
  private String dataIni;
  private String dataIniOf;
  private String codeCOf;
  private String descCOf;
  private String dataIniAssOf;
  private String dataFineAssOf;
  private String codeFreq;
  private String codeModal;
  private String tipoFlgAssocB;
  private int qntaShiftCanoni;
  private String codeTipoContr;
  private String dataIniOfPs;
  private String tipoFlgAP;
  private String dataFineOfPs;

  public AssOfPsBMPPK()
  {
  }
  public AssOfPsBMPPK(String codePs, String descPs, String dataIniPs, String dataFinePs, String codeOf, String descOf, String dataIniOf, String codeCOf, String descCOf, String dataIniAssOf, String dataFineAssOf, String codeFreq, String codeModal, String tipoFlgAssocB, int qntaShiftCanoni, String codeTipoContr)
  {
    this.codePs=codePs;
    this.descPs=descPs;
    this.dataIniPs=dataIniPs;
    this.dataFinePs=dataFinePs;
    this.codeOf=codeOf;
    this.descOf=descOf;
    this.dataIniOf=dataIniOf;
    this.codeCOf=codeCOf;
    this.descCOf=descCOf;
    this.dataIniAssOf=dataIniAssOf;
    this.dataFineAssOf=dataFineAssOf;
    this.codeFreq=codeFreq;
    this.codeModal=codeModal;
    this.tipoFlgAssocB=tipoFlgAssocB;
    this.qntaShiftCanoni=qntaShiftCanoni;
    this.codeTipoContr=codeTipoContr;
  }

  public String getCodePs()
  {
    return codePs;
  }

  public void setCodePs(String stringa)
  {
    codePs=stringa;
  }

  public String getDescPs()
  {
    return descPs;
  }
  public void setDescPs(String stringa)
  {
    descPs=stringa;
  }
  
  public String getDataIniPs()
  {
    return dataIniPs;
  }
  public void setDataIniPs(String stringa)
  {
    dataIniPs=stringa;
  }

  public String getDataFinePs()
  {
    return dataFinePs;
  }
  public void setDataFinePs(String stringa)
  {
    dataFinePs=stringa;
  }

  public String getCodeTipo()
  {
    return codeTipo;
  }
  public void setCodeTipo(String stringa)
  {
    codeTipo=stringa;
  }

  public String getDescTipo()
  {
    return descTipo;
  }
  public void setDescTipo(String stringa)
  {
    descTipo=stringa;
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

  public String getDataIniOf()
  {
    return dataIniOf;
  }
  public void setDataIniOf(String stringa)
  {
    dataIniOf=stringa;
  }

  public String getCodeCOf()
  {
    return codeCOf;
  }
  public void setCodeCOf(String stringa)
  {
    codeCOf=stringa;
  }

  public String getDescCOf()
  {
    return descCOf;
  }
  public void setDescCOf(String stringa)
  {
    descCOf=stringa;
  }

  public String getDataIniAssOf()
  {
    return dataIniAssOf;
  }
  public void setDataIniAssOf(String stringa)
  {
    dataIniAssOf=stringa;
  }

  public String getDataFineAssOf()
  {
    return dataFineAssOf;
  }
  public void setDataFineAssOf(String stringa)
  {
    dataFineAssOf=stringa;
  }

  public String getCodeFreq()
  {
    return codeFreq;
  }
  public void setCodeFreq(String stringa)
  {
    codeFreq=stringa;
  }

  public String getCodeModal()
  {
    return codeModal;
  }
  public void setCodeModal(String stringa)
  {
    codeModal=stringa;
  }

  public String getTipoFlgAssocB()
  {
    return tipoFlgAssocB;
  }
  public void setTipoFlgAssocB(String stringa)
  {
    tipoFlgAssocB=stringa;
  }

  public int getQntaShiftCanoni()
  {
    return qntaShiftCanoni;
  }
  public void setQntaShiftCanoni(int intero)
  {
    qntaShiftCanoni=intero;
  }

  public String getCodeTipoContr()
  {
    return codeTipoContr;
  }
  public void setCodeTipoContr(String stringa)
  {
    codeTipoContr=stringa;
  }

  public String getDataIniOfPs()
  {
    return dataIniOfPs;
  }

  public void setDataIniOfPs(String s)
  {
     dataIniOfPs=s;
  }

  public String getTipoFlgAP()
  {
    return tipoFlgAP;
  }

  public void setTipoFlgAP(String s)
  {
    tipoFlgAP=s;
  }

  public String getDataFineOfPs()
  {
    return dataFineOfPs;
  }

  public void setDataFineOfPs(String s)
  {
    dataFineOfPs=s;
  }

}