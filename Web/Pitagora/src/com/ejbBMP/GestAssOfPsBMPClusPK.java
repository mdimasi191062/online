package com.ejbBMP;
import com.utl.*;
import java.io.Serializable;

public class GestAssOfPsBMPClusPK extends AbstractPK 
{
  private String codOf;
  private String descOf;
  private String codPs;
  private String descPs;
  private String codCOf;
  private String descCOf;
  private String codModalAppl;
  private String descModalAppl;
  private String flag;
  private String codFreq;
  private String descFreq;
  private String dataIni;
  private String dataIniOf;
  private String dataIniOfPs;
  private String dataFineOfPs;
  private String dataFineOf;
  private String dataIniPs;
  private String shift;
  private int NumTariffe;
  private int NumOfPs;
  private String dataMin;
  private String codContratto;
  private String tipoCluster;
  private String codeCluster;
  private String codeTipoContr;

  public GestAssOfPsBMPClusPK()
  {
  }


  public GestAssOfPsBMPClusPK(String codPs,String codOf,String dataIniOfPs,String dataIniPs)
  {
    this.codPs=codPs;
    this.codOf=codOf;
    this.dataIniOfPs=dataIniOfPs;
    this.dataIniPs=dataIniPs;
  }


  public int getNumOfPs()
  {
    return NumOfPs;
  }
  public void setNumOfPs(int numero)
  {
    NumOfPs=numero;
  }

  public int getNumTariffe()
  {
    return NumTariffe;
  }
  public void setNumTariffe(int numero)
  {
    NumTariffe=numero;
  }

  public String getCodePs()
  {
    return codPs;
  }
  public void setCodePs(String stringa)
  {
    codPs=stringa;
  }

  public String getDescPs()
  {
    return descPs;
  }
  public void setDescPs(String stringa)
  {
    descPs=stringa;
  }

  public String getCodeOf()
  {
    return codOf;
  }
  public void setCodeOf(String stringa)
  {
    codOf=stringa;
  }

  public String getDescOf()
  {
    return descOf;
  }
  public void setDescOf(String stringa)
  {
    descOf=stringa;
  }

  public String getCodeCOf()
  {
    return codCOf;
  }
  public void setCodeCOf(String stringa)
  {
    codCOf=stringa;
  }

  public String getDescCOf()
  {
    return descCOf;
  }
  public void setDescCOf(String stringa)
  {
    descCOf=stringa;
  }

  public String getCodModalAppl()
  {
    return codModalAppl;
  }
  public void setCodModalAppl(String stringa)
  {
    codModalAppl=stringa;
  }

  public String getDescModalAppl()
  {
    return descModalAppl;
  }
  public void setDescModalAppl(String stringa)
  {
    descModalAppl=stringa;
  }

  public String getFlag()
  {
    return flag;
  }
  public void setFlag(String stringa)
  {
    flag=stringa;
  }

  public String getCodFreq()
  {
    return codFreq;
  }
  public void setCodFreq(String stringa)
  {
    codFreq=stringa;
  }

  public String getDescFreq()
  {
    return descFreq;
  }
  public void setDescFreq(String stringa)
  {
    descFreq=stringa;
  }

  public String getDataIni()
  {
    return dataIni;
  }
  public void setDataIni(String stringa)
  {
    dataIni=stringa;
  }

  public String getShift()
  {
    return shift;
  }
  public void setShift(String stringa)
  {
    shift=stringa;
  }

  public String getDataMin()
  {
    return dataMin;
  }
  public void setDataMin(String stringa)
  {
    dataMin=stringa;
  }

  public String getDataIniOfPs()
  {
    return dataIniOfPs;
  }
  public void setDataIniOfPs(String stringa)
  {
    dataIniOfPs=stringa;
  }

  public String getDataIniOf()
  {
    return dataIniOf;
  }
  public void setDataIniOf(String stringa)
  {
    dataIniOf=stringa;
  }

  public String getDataFineOfPs()
  {
    return dataFineOfPs;
  }
  public void setDataFineOfPs(String stringa)
  {
    dataFineOfPs=stringa;
  }

  public String getDataFineOf()
  {
    return dataFineOf;
  }
  public void setDataFineOf(String stringa)
  {
    dataFineOf=stringa;
  }

  public String getCodContratto()
  {
    return codContratto;
  }
  public void setCodContratto(String stringa)
  {
    codContratto=stringa;
  }

  public String getTipoCluster()  
  {
    return tipoCluster;
  }

  public void setTipoCluster(String stringa)
  {
	tipoCluster=stringa;
  }

  public String getCodeCluster()  
  {
    return codeCluster;
  }

  public void setCodeCluster(String stringa)
  {
    codeCluster=stringa;
  }

  public String getCodeTipoContr()  
  {
    return codeTipoContr;
  }

  public void setCodeTipoContr(String stringa)
  {
    codeTipoContr=stringa;
  }
}