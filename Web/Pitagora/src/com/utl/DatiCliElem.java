package com.utl;

public class DatiCliElem implements java.io.Serializable
{
  private String account;
  private String desc;
  private String codeParam;
  private String codeDocFatt;

  public String getAccount()
  { return account;}
  public void setAccount(String stringa)
  { account=stringa; }
  public String getDesc()
  { return desc;}
  public void setDesc(String stringa)
  { desc=stringa; }
  public String getCodeDocFatt()
  { return codeDocFatt;}
  public void setCodeDocFatt(String stringa)
  { codeDocFatt=stringa; }
  public String getCodeParam()
  { return codeParam;}
  public void setCodeParam(String stringa)
  {  codeParam=stringa; }
}
