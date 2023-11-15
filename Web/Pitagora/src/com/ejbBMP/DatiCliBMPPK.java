package com.ejbBMP;

import com.utl.*;

public class DatiCliBMPPK extends AbstractPK  
{

  private String account;
  private String desc;
  private String codeParam;
  private String codeDocFatt;
  private String codElabBatch;
//Tommaso 0909
  private Integer NumFattLisUn;
//Fine Tommaso 0909
//gianluca 09/092002-inizio-17.00
  private String dataIniPerFatt;
  private String dataFinePerFatt;
//gianluca 09/092002-fine-17.00
  private String maxDataFine;
 
  public DatiCliBMPPK()
  {
  }

  public DatiCliBMPPK(String account, String descrizione)
  {
   this.desc=descrizione;
   this.account=account;
  }


  public String getCodeDocFatt()
  {
    return codeDocFatt;
  }
  public void setCodeDocFatt(String stringa)
  {
     //Gianluca-10/10/2002-inizio
     codeDocFatt=stringa;
  }

  
  public String getAccount()
  {
    return account;
  }
  public void setAccount(String stringa)
  {
      account=stringa;
  }
  public String getDesc()
  {
    return desc;
  }
  public void setDesc(String stringa)
  {
    desc=stringa;
  }

//Gianluca-20/09/2002-inizio
  public String getCodeParam()
  {
    return codeParam;
  }
  public void setCodeParam(String stringa)
  {
      codeParam=stringa;
  }
//Gianluca-20/09/2002-fine
  
  public void setCodElabBatch(String stringa)
  {
    codElabBatch=stringa;
  }
  public String getCodElabBatch()
  {
    return codElabBatch;
  }
//Tommaso 0909
  public void setNumFattLisUn(Integer stringa)
  {
    NumFattLisUn=stringa;
  }
  public Integer getNumFattLisUn()
  {
    return NumFattLisUn;
  }
//fine Tommaso 0909

//gianluca 09/092002-inizio-16.51
  public String getDataIniPerFatt()
  {
    return dataIniPerFatt;
  }
  public void setDataIniPerFatt(String stringa)
  {
    dataIniPerFatt=stringa;
  }
  public String getDataFinePerFatt()
  {
    return dataFinePerFatt;
  }
  public void setDataFinePerFatt(String stringa)
  {
    dataFinePerFatt=stringa;
  }
//gianluca 09/092002-fine-16.51

  public String getMaxDataFine()
  {
    return maxDataFine;
  }
  public void setMaxDataFine(String stringa)
  {
    maxDataFine=stringa;
  }
 
}