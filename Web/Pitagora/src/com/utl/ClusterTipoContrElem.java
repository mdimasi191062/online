package com.utl;

public class ClusterTipoContrElem implements java.io.Serializable
{
  private String codeClusterOf;
  private String descClusterOf;
  private String tipoClusterOf;

  public String getCodeClusterOf()
  {
    return codeClusterOf;
  }
  public void setCodeClusterOf(String stringa)
  {
      codeClusterOf=stringa;
  }
  public String getDescClusterOf()
  {
    return descClusterOf;
  }
  public void setDescClusterOf(String stringa)
  {
      descClusterOf=stringa;
  }
  public String getTipoClusterOf()
  {
    return tipoClusterOf;
  }
  public void setTipoClusterOf(String stringa)
  {
      tipoClusterOf=stringa;
  }
}