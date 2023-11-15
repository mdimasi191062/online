package com.ejbBMP;

import com.utl.*;

public class ColocationBMPPK extends AbstractPK 
{

private String codeAccount;
private String descAccount;
private String dataConsSito;
private String dataIniValAcc;
int numeroElab;
private String code_utente;
private String sitoSelez;
private String accountSelez;
private String data_ini;
private Double imptar;
private Double impcons;


 


//code_utente,sitoSelez,accountSelez,data_ini, imptar,impcons);

//Metodo di prova per rosa
public ColocationBMPPK(String code_utente,String sitoSelez,String accountSelez,String data_ini,Double imptar,Double impcons)
  {
    this.code_utente=code_utente;
    this.sitoSelez=sitoSelez;
    this.accountSelez=accountSelez;
    this.data_ini=data_ini;
    this.imptar=imptar;
    this.impcons=impcons;
  }

  public ColocationBMPPK()
  {
  }

  public void setCodeAccount(String stringa)
  {
    codeAccount=stringa;
  }

  public String getCodeAccount()
  {
    return codeAccount;
  }

  public void setDescAccount(String stringa)
  {
    descAccount=stringa;
  }

  public String getDescAccount()
  {
    return descAccount;
  }

  public void setDataConsSito(String stringa)
  {
    dataConsSito=stringa;
  }

  public String getDataConsSito()
  {
    return dataConsSito;
  }

 public void setNumeroElab(int stringa)
  {
    numeroElab=stringa;
  }

  public int getNumeroElab()
  {
    return numeroElab;
  }
              
  public void setDataIniValAcc(String stringa)
  {
    dataIniValAcc=stringa;
  }

  public String getDataIniValAcc()
  {
    return dataIniValAcc;
  }

//***********




 public void setCode_utente(String stringa)
  {
    code_utente=stringa;
  }

  public String getCode_utente()
  {
    return code_utente;
  }


  public void setSitoSelez(String stringa)
  {
    sitoSelez=stringa;
  }

  public String getSitoSelez()
  {
    return sitoSelez;
  }


  public void setAccountSelez(String stringa)
  {
    accountSelez=stringa;
  }

  public String getAccountSelez()
  {
    return accountSelez;
  }

  public void setData_ini(String stringa)
  {
    data_ini=stringa;
  }

  public String getData_ini()
  {
    return data_ini;
  }


  public void setImptar(Double stringa)
  {
    imptar=stringa;
  }


  public Double getImptar()
  {
    return imptar;
  }


  public void setImpcons(Double stringa)
  {
    impcons=stringa;
  }


  public Double getImpcons()
  {
    return impcons;
  }
  
//********

  
}