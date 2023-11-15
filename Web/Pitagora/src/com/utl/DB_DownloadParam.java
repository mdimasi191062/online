package com.utl;
import com.utl.AbstractDataBean;

public class DB_DownloadParam extends AbstractDataBean 
{
  /*
  tag attribute: CODICE_FUNZIONE
  */
  private String CODICE_FUNZIONE = "";
 
   /*
  tag attribute: PATH
  */
  private String PATH = "";
 
 
   /*
  tag attribute: NAME_FINDER
  */
  private String NAME_FINDER = "";
 
   /*
  tag attribute: FLAG_SYS
  */
  private String FLAG_SYS = "";
 
 

  public DB_DownloadParam()
  {
  }


  public void setCODICE_FUNZIONE(String value)
  {
    CODICE_FUNZIONE = value;
  }
  public String getCODICE_FUNZIONE()
  {
    return CODICE_FUNZIONE;
  }


  public void setPATH(String value)
  {
    PATH = value;
  }
  public String getPATH()
  {
    return PATH;
  }


  public void setNAME_FINDER(String value)
  {
    NAME_FINDER = value;
  }
  public String getNAME_FINDER()
  {
    return NAME_FINDER;
  }


  public void setFLAG_SYS(String value)
  {
    FLAG_SYS = value;
  }
  public String getFLAG_SYS()
  {
    return FLAG_SYS;
  }

}