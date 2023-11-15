package com.ejbBMP;

import com.utl.*;

public class TariffaBMPPK extends AbstractPK
{

private String codContr;
private String descContr;
private String descEsP;
private String codTar;
private String progTar;
private String codUM;
private String codUt;
private String dataIniValAssOfPs;
private String codOf;
private String descOf;
private String dataIniValOf;
private String codPs;
private String dataIniTar;
private String dataFineTar;
private String descTar;
private String flgMat;
private String codClSc;
private String causFatt;
private String codFascia;
private String codPrFascia;
private String codTipoCaus;
private String codTipoOf;
private String prClSc;
private String flgCongRe;
private String dataCreazTar;
private String flgProvv;
//Aggiornamento Mario 13/09/02 inizio
//Tommaso 0909
private String contrDest;
private Integer flgCommit;
//fine Tommaso 0909
//Aggiornamento Mario 13/09/02 fine
private String descTipoCaus;
//Valeria inizio 12-02-03
private String codTipoOpz;
private String descTipoOpz;
//Valeria fine 12-02-03
private String descUM;
private Double impTar;
private Double impMinSps;
private Double impMaxSps;

private String impTarStr;

private String descPs;

private Integer numTariffe;  //numero delle tariffe trovate: stored procedure TARIFFA_VER_ES_ATTIVE
private String dataFineValAssOfPs; //data fine validita' associazione of/ps: stored procedure ASSOC_OFPS_DISATTIVA
private Integer numElaborazTrovate; //numero elaborazioni trovate: stored procedure ELAB_BATCH_IN_CORSO_FATT

//Valeria 30-07-02 inizio
private Integer numTarDisattive;  //numero delle tariffe disattive: stored procedure TARIFFA_VER_DISATTIVA
private Integer numTarProvvisor;  //numero delle tariffe provvisorie: stored procedure TARIFFA_VER_PROVV
//Valeria 30-07-02 fine

//Valeria inizio 30-09-02
private String dataIniTarDigitata;
//Valeria fine 30-09-02

private int codePromozione;

private String descListinoApplicato;

  public TariffaBMPPK()
  {
  }

  public TariffaBMPPK(String codTar, String progTar, String codUM, String codUt, String dataIniValAssOfPs, String codOf, String dataIniValOf, String codPs, String dataIniTar, String dataFineTar, String descTar, Double impTar, String flgMat, String codClSc, String prClSc, String causFatt ,String codTipoOpz, int codePromozione)
  {
  this.codTar=codTar;
  this.progTar=progTar;
  this.codUM=codUM;
  this.codUt=codUt;
  this.dataIniValAssOfPs=dataIniValAssOfPs;
  this.codOf=codOf;
  this.dataIniValOf=dataIniValOf;
  this.codPs=codPs ;
  this.dataIniTar=dataIniTar;
  this.dataFineTar=dataFineTar ;
  this.descTar=descTar;
  this.impTar=impTar;
  this.flgMat=flgMat;
  this.codClSc=codClSc;
  this.prClSc=prClSc;
  this.causFatt=causFatt;
  this.codTipoOpz=codTipoOpz;  //10-03-03
  this.codePromozione=codePromozione;
  }

  public TariffaBMPPK(String codTar, String progTar, String codUM, String codUt, String dataIniValAssOfPs, String codOf, String dataIniValOf, String codPs, String dataIniTar, String dataFineTar, String descTar, Double impTar, String flgMat, String codClSc, String prClSc, String causFatt ,String codTipoOpz, int codePromozione,String descListinoApplicato)
  {
  this.codTar=codTar;
  this.progTar=progTar;
  this.codUM=codUM;
  this.codUt=codUt;
  this.dataIniValAssOfPs=dataIniValAssOfPs;
  this.codOf=codOf;
  this.dataIniValOf=dataIniValOf;
  this.codPs=codPs ;
  this.dataIniTar=dataIniTar;
  this.dataFineTar=dataFineTar ;
  this.descTar=descTar;
  this.impTar=impTar;
  this.flgMat=flgMat;
  this.codClSc=codClSc;
  this.prClSc=prClSc;
  this.causFatt=causFatt;
  this.codTipoOpz=codTipoOpz;  //10-03-03
  this.codePromozione=codePromozione;
  this.descListinoApplicato=descListinoApplicato;
  }

//Ribaltamento Listino
public TariffaBMPPK(String codContr, String contrDest, String codUt, String codOf, String codPs, String codTipoCaus, Integer flgCommit)
  {
  this.codContr=codContr;
  this.contrDest=contrDest;
  this.codUt=codUt;
  this.codOf=codOf;
  this.codPs=codPs ;
  this.codTipoCaus=codTipoCaus;
  //Valeria inizio 12-02-03
  this.codTipoOpz = codTipoOpz;
  this.descTipoOpz = descTipoOpz;
  //Valeria inizio 12-02-03
  this.flgCommit=flgCommit;
  }

public void setCodContr(String stringa)
  {
    codContr=stringa;
  }

  public String getCodContr()
  {
    return codContr;
  }

  public void setDescContr(String stringa)
    {
      descContr=stringa;
    }

    public String getDescContr()
    {
      return descContr;
  }
  public void setDescEsP(String stringa)
    {
      descEsP=stringa;
    }

    public String getDescEsP()
    {
      return descEsP;
  }

//a qui


  public void setCodTar(String stringa)
  {
    codTar=stringa;
  }

  public String getCodTar()
  {
    return codTar;
  }

  public void setProgTar(String stringa)
  {
    progTar=stringa;
  }

  public String getProgTar()
  {
    return progTar;
  }

  public void setCodUM(String stringa)
  {
    codUM=stringa;
  }

  public String getCodUM()
  {
    return codUM;
  }

  public void setCodUt(String stringa)
  {
    codUt=stringa;
  }

  public String getCodUt()
  {
    return codUt;
  }

  public void setDataIniValAssOfPs(String stringa)
  {
    dataIniValAssOfPs=stringa;
  }

  public String getDataIniValAssOfPs()
  {
    return dataIniValAssOfPs;
  }

  public void setCodOf(String stringa)
  {
    codOf=stringa;
  }

  public String getCodOf()
  {
    return codOf;
  }

  public void setDescOf(String stringa)
  {
    descOf=stringa;
  }

  public String getDescOf()
  {
    return descOf;
  }

  public void setDataIniValOf(String stringa)
  {
    dataIniValOf=stringa;
  }

  public String getDataIniValOf()
  {
    return dataIniValOf;
  }

  public void setCodPs(String stringa)
  {
    codPs=stringa;
  }
  public String getCodPs()
  {
    return codPs;
  }

  public void setDataIniTar(String stringa)
  {
    dataIniTar=stringa;
  }

  public String getDataIniTar()
  {
    return dataIniTar;
  }

  public void setDataFineTar(String stringa)
  {
    dataFineTar=stringa;
  }

  public String getDataFineTar()
  {
    return dataFineTar;
  }


 public void setDescTipoCaus(String stringa)
  {
    descTipoCaus=stringa;
  }
  public String getDescTipoCaus()
  {
    return descTipoCaus;
  }
  //Valeria inizio 12-02-03
   public void setCodTipoOpz(String stringa)
  {
    codTipoOpz=stringa;
  }
  public String getCodTipoOpz()
  {
    return codTipoOpz;
  }

  public void setDescTipoOpz(String stringa)
  {
    descTipoOpz=stringa;
  }
  public String getDescTipoOpz()
  {
    return descTipoOpz;
  }
  //Valeria fine 12-02-03
  
   public void setDescUM(String stringa)
  {
    descUM=stringa;
  }
  public String getDescUM()
  {
    return descUM;
  }





  public void setDescTar(String stringa)
  {
    descTar=stringa;
  }
  public String getDescTar()
  {
    return descTar;
  }

  public void setFlgMat(String stringa)
  {
    flgMat=stringa;
  }

  public String getFlgMat()
  {
    return flgMat;
  }

  public void setCodClSc(String stringa)
  {
    codClSc=stringa;
  }

  public String getCodClSc()
  {
    return codClSc;
  }

  public void setCausFatt(String stringa)
  {
    causFatt=stringa;
  }

  public String getCausFatt()
  {
    return causFatt;
  }

  public void setCodFascia(String stringa)
  {
    codFascia=stringa;
  }

  public String getCodFascia()
  {
    return codFascia;
  }

  public void setCodPrFascia(String stringa)
  {
    codPrFascia=stringa;
  }

  public String getCodPrFascia()
  {
    return codPrFascia;
  }

  public void setCodTipoCaus(String stringa)
  {
    codTipoCaus=stringa;
  }

  public String getCodTipoCaus()
  {
    return codTipoCaus;
  }
  
  public void setCodTipoOf(String stringa)
  {
    codTipoOf=stringa;
  }

  public String getCodTipoOf()
  {
    return codTipoOf;
  }

  public void setPrClSc(String stringa)
  {
    prClSc=stringa;
  }

  public String getPrClSc()
  {
    return prClSc;
  }

  public void setFlgCongRe(String stringa)
  {
    flgCongRe=stringa;
  }

  public String getFlgCongRe()
  {
    return flgCongRe;
  }

  public void setDataCreazTar(String stringa)
  {
    dataCreazTar=stringa;
  }

  public String getDataCreazTar()
  {
    return dataCreazTar;
  }

  public void setFlgProvv(String stringa)
  {
    flgProvv=stringa;
  }

  public String getFlgProvv()
  {
    return flgProvv;
  }

  public void setImpTar(Double numero)
  {
    impTar=numero;
  }

  public Double getImpTar()
  {
    return impTar;
  }

 public void setImpMinSps(Double numero)
  {
    impMinSps=numero;
  }

  public Double getImpMinSps()
  {
    return impMinSps;
  }

  public void setImpMaxSps(Double numero)
  {
    impMaxSps=numero;
  }

  public Double getImpMaxSps()
  {
    return impMaxSps;
  }



  public void setNumTariffe(Integer numero)
  {
    numTariffe = numero;
  }

  public Integer getNumTariffe()
  {
    return numTariffe;
  }

  public void setDataFineValAssOfPs(String stringa)
  {
    dataFineValAssOfPs = stringa;
  }

  public String getDataFineValAssOfPs()
  {
    return dataFineValAssOfPs;
  }


  public void setNumElaborazTrovate(Integer numero)
  {
    numElaborazTrovate = numero;
  }

  public Integer getNumElaborazTrovate()
  {
    return numElaborazTrovate;
  }

  public void setNumTarDisattive(Integer numero)
  {
    numTarDisattive = numero;
  }

  public Integer getNumTarDisattive()
  {
    return numTarDisattive;
  }

  public void setNumTarProvvisor(Integer numero)
  {
    numTarProvvisor = numero;
  }

  public Integer getNumTarProvvisor()
  {
    return numTarProvvisor;
  }

//Agg Mario 13/09/02 inizio
//Tommaso 0909
  public void setContrDest(String stringa)
  {
    contrDest = stringa;
  }

  public String getContrDest()
  {
    return contrDest;
  }

  public void setFlgCommit(Integer numero)
  {
    flgCommit = numero;
  }

  public Integer getFlgCommit()
  {
    return flgCommit;
  }
//fine Tommaso 0909
//Agg Mario 13/09/02 fine

//Valeria inizio 30-09-02
  public void setDataIniTarDigitata(String stringa)
  {
    dataIniTarDigitata = stringa;
  }

  public String getDataIniTarDigitata()
  {
    return dataIniTarDigitata;
  }

//Valeria fine 30-09-02

  public void setImpTarStr(String strInput)
  {
    impTarStr = strInput;
  }
  
  public String getImpTarStr()
  {
    return impTarStr;
  }

  public void setCodePromozione(int numero)
  {
    codePromozione = numero;
  }

  public int getCodePromozione()
  {
    return codePromozione;
  }
  
  public void setDescListinoApplicato(String strInput)
  {
    descListinoApplicato = strInput;
  }
  
  public String getDescListinoApplicato()
  {
    return descListinoApplicato;
  }
    public void setDescPs(String strInput)
    {
      descPs = strInput;
    }
    
    public String getDescPs()
    {
      return descPs;
    }
  
}

