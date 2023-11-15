package com.ejbBMP;
import java.io.Serializable;
import com.utl.*;

public class AssOfPsVerifEsistBMPPK  extends AbstractPK  
{
  private String codeCOf;
  private String codeTipoContratto;
  private String codePS;
  private int NumOfPs;


  public AssOfPsVerifEsistBMPPK()
  {
  }

  public AssOfPsVerifEsistBMPPK(String codeCOf,String codeTipoContratto,String codePS)
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

  public int getNumOfPs()
  {
    return NumOfPs;
  }
  public void setNumOfPs(int numero)
  {
    NumOfPs=numero;
  }


}