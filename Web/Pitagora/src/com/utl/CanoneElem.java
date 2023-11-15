package com.utl;

public class CanoneElem implements java.io.Serializable
{
  private String codeFreq;
  private String codeModal;
  private String tipoFlgAP;
  private int qntaShiftCanoni;

  public CanoneElem(String codeFreq, String codeModal, String tipoFlgAP, int qntaShiftCanoni)
  {
    this.codeFreq=codeFreq;
    this.codeModal=codeModal;
    this.tipoFlgAP=tipoFlgAP;
    this.qntaShiftCanoni=qntaShiftCanoni;

  }


  public String getCodeFreq()
    {return this.codeFreq;}

  public void setCodeFreq(String s)
    {this.codeFreq=s;}

  public String getCodeModal()
    {return this.codeModal;}

  public void setCodeModal(String s)
    {this.codeModal=s;}

  public String getTipoFlgAP()
    {return this.tipoFlgAP;}

  public void setTipoFlgAP(String s)
    {this.tipoFlgAP=s;}

  public int getQntaShiftCanoni()
    {return this.qntaShiftCanoni;}

  public void setQntaShiftCanoni(int i)
    {this.qntaShiftCanoni=i;}

}