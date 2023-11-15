package com.ejbBMP;
import java.io.Serializable;
import com.utl.*;

public class AssOfPsVerEsistAperteBMPPK  extends AbstractPK  
{
  private String codeCOf;
  private String codeTipoContratto;
  private String codePS;
  private int NumAss;

  public AssOfPsVerEsistAperteBMPPK()
  {
  }

  public AssOfPsVerEsistAperteBMPPK(String codeCOf,String codeTipoContratto,String codePS)
  {
    this.codeCOf=codeCOf;
    this.codeTipoContratto=codeTipoContratto;
    this.codePS=codePS;
  }

  public String getCodeCOf()
  {
    return codeCOf;
  }
  public void setCodeCOf(String stringa)
  {
    codeCOf=stringa;
  }

  public String getCodeTipoContratto()
  {
    return codeTipoContratto;
  }
  public void setCodeTipoContratto(String stringa)
  {
    codeTipoContratto=stringa;
  }

  public String getCodePS()
  {
    return codePS;
  }
  public void setCodePS(String stringa)
  {
    codePS=stringa;
  }

  public int getNumAss()
  {
    return NumAss;
  }
  public void setNumAss(int numero)
  {
    NumAss=numero;
  }

}