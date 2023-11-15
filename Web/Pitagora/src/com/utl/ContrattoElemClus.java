package com.utl;

public class ContrattoElemClus extends ContrattoElem implements java.io.Serializable 
{
  private String codeCluster;
  private String tipoCluster;
  private String codeTipoContr;

  public String getCodeCluster()
  { return codeCluster; }
  
  public void setCodeCluster(String stringa)
  {  codeCluster=stringa; }

  public String getTipoCluster()
  {  return tipoCluster; }
  
  public void setTipoCluster(String stringa)
  {  tipoCluster=stringa; }
  
  public String getCodeTipoContr()
  {  return codeTipoContr; }
  
  public void setCodeTipoContr(String stringa)
  {  codeTipoContr=stringa; }
}