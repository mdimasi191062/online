package com.utl;

public class ClassElencoAccountPsElem implements java.io.Serializable
{
  private String code_account;
  private String desc_account;
  //3/10/02
  private String dataIniValAcc;

  public String getCodeAccountPs()
  {
    return code_account;
  }
  public void setCodeAccountPs(String stringa)
  {
      code_account=stringa;
  }
  public String getDescAccountPs()
  {
    return desc_account;
  }
  public void setDescAccountPs(String stringa)
  {
      desc_account=stringa;
  }
  //3/10/02 Mario inizio
  public void setDataIniValAcc(String stringa)
  {
      dataIniValAcc=stringa;
  }

  public String getDataIniValAcc()
  {
    return dataIniValAcc;
  }
  //3/10/02 fine
}