package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.*;

public interface TariffaBMP extends EJBObject 
{
  
  public void setCodContr(String codContr) throws RemoteException;

  public String getCodContr() throws RemoteException;

  public void setDescContr(String descContr) throws RemoteException;

  public String getDescContr() throws RemoteException;

  public void setDescEsP(String descEsP) throws RemoteException;

  public String getDescEsP() throws RemoteException;

  public void setDescOf(String descOf) throws RemoteException;

  public String getDescOf() throws RemoteException;

  public void setCodTar(String codTar) throws RemoteException;

  public String getCodTar() throws RemoteException;

  public void setProgTar(String progTar) throws RemoteException;

  public String getProgTar() throws RemoteException;

  public void setCodUM(String codUM) throws RemoteException;

  public String getCodUM() throws RemoteException;
  
  public void setCodUt(String codUt) throws RemoteException;

  public String getCodUt() throws RemoteException;
  
  public void setDataIniValAssOfPs(String dataIniValAssOfPs) throws RemoteException;

  public String getDataIniValAssOfPs() throws RemoteException;
  
  public void setCodOf(String codOf) throws RemoteException;

  public String getCodOf() throws RemoteException;
  
  public void setDataIniValOf(String dataIniValOf) throws RemoteException;

  public String getDataIniValOf() throws RemoteException;
  
  public void setCodPs(String codPs) throws RemoteException;

  public String getCodPs() throws RemoteException;
  
  public void setDataIniTar(String dataIniTar) throws RemoteException;

  public String getDataIniTar() throws RemoteException;
  
  public void setDataFineTar(String dataFineTar) throws RemoteException;

  public String getDataFineTar() throws RemoteException;
  
  public void setDescTar(String descTar) throws RemoteException;

  public String getDescTar() throws RemoteException;

  public void setDescTipoCaus(String escTipoCaus) throws RemoteException;
  
  public String getDescTipoCaus() throws RemoteException;


  public void setDescUM(String escUM) throws RemoteException;
  
  public String getDescUM() throws RemoteException;
  
  
  public void setFlgMat(String flgMat) throws RemoteException;

  public String getFlgMat() throws RemoteException;

  public void setCodClSc(String codClSc) throws RemoteException;

  public String getCodClSc() throws RemoteException;
  
  public void setCausFatt(String causFatt) throws RemoteException;

  public String getCausFatt() throws RemoteException;
  
  public void setCodFascia(String codFascia) throws RemoteException;

  public String getCodFascia() throws RemoteException;
  
  public void setCodPrFascia(String codPrFascia) throws RemoteException;

  public String getCodPrFascia() throws RemoteException;
 
  public void setCodTipoCaus(String codTipoCaus) throws RemoteException;

  public String getCodTipoCaus() throws RemoteException;

//Valeria inizio 12-02-03
  public void setCodTipoOpz(String codTipoOpz) throws RemoteException;

  public String getCodTipoOpz() throws RemoteException;

  public void setDescTipoOpz(String descTipoOpz) throws RemoteException;

  public String getDescTipoOpz() throws RemoteException;
//Valeria fine 12-02-03
  
  public void setCodTipoOf(String codTipoOf) throws RemoteException;

  public String getCodTipoOf() throws RemoteException;
  
  public void setPrClSc(String prClSc) throws RemoteException;

  public String getPrClSc() throws RemoteException;

  public void setFlgCongRe(String flgCongRe) throws RemoteException;

  public String getFlgCongRe() throws RemoteException;

  public void setDataCreazTar(String dataCreazTar) throws RemoteException;

  public String getDataCreazTar() throws RemoteException;

  public void setFlgProvv(String flgProvv) throws RemoteException;

  public String getFlgProvv() throws RemoteException;

  public void setImpTar(Double impTar) throws RemoteException;

  public Double getImpTar() throws RemoteException;

  public void setImpMinSps(Double impMinSps) throws RemoteException;

  public Double getImpMinSps() throws RemoteException;

  public void setImpMaxSps(Double impMaxSps) throws RemoteException;

  public Double getImpMaxSps() throws RemoteException;  

  public void setNumTariffe(Integer numTariffe) throws RemoteException;

  public Integer getNumTariffe() throws RemoteException;

  public void setDataFineValAssOfPs(String dataFineValAssOfPs) throws RemoteException;
  
  public String getDataFineValAssOfPs() throws RemoteException;

  public void setNumElaborazTrovate(Integer numElaborazTrovate)  throws RemoteException;
  
  public Integer getNumElaborazTrovate() throws RemoteException;

  
  public void setNumTarDisattive(Integer numTarDisattive) throws RemoteException;
  
  public Integer getNumTarDisattive() throws RemoteException;

  public void setNumTarProvvisor(Integer numTarProvvisor)  throws RemoteException;
  
  public Integer getNumTarProvvisor() throws RemoteException;

//aGGIORNAMENTO mARIO 13/09/02 inizio
//Tommaso 0909
  public void setContrDest(String contrDest) throws RemoteException;

  public String getContrDest() throws RemoteException;

  public void setFlgCommit(Integer flgCommit)  throws RemoteException;

  public Integer getFlgCommit() throws RemoteException;
//fine Tommaso 0909
//Aggiornamento Mario 13/09/02 fine

//Valeria inizio 30-09-02
  public void setDataIniTarDigitata(String dataIniTarDigitata) throws RemoteException;

  public String getDataIniTarDigitata() throws RemoteException;
//Valeria fine 30-09-02

  public void setImpTarStr(String impTarStr) throws RemoteException;
  public String getImpTarStr() throws RemoteException;

  public void setCodePromozione(int codePromozione)  throws RemoteException;
  public int getCodePromozione() throws RemoteException;

}