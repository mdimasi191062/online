package com.utl;
import com.utl.AbstractDataBean;

public class DB_ElabAttive extends AbstractDataBean
{
  private String DESC_FUNZ = "";
  private String CODE_FUNZ = "";
  private String QUERY_SERVIZI = "";
  private String QUERY_ACCOUNT = "";
  private String DATA_VISIBLE = "";
  private String SERVIZI_VISIBLE = "";
  private String ACCOUNT_VISIBLE = "";
  private String QUERY_GESTORE = "";
  private String GESTORE_VISIBLE = "";
  private String PERIODO_RIFERIMENTO_VISIBLE = "";
  private String QUERY_PERIODO_RIFERIMENTO = "";
  private String QUERY_GESTORE_NEED_PER_RIF = "";
  private String CHECK_ACQ_TLD_DA_FILE = "";
  private String QUERY_SERVIZIO_NEED_PER_RIF = "";
  private String QUERY_ACCOUNT_NEED_PER_RIF = "";  
  private String FUNZ_PARAM = "";
  private String BATCH_NEED_PER_RIF = "";
  private String QUERY_DETT_VERIFICA = "";
  private String QUERY_SCARTI = "";
/*mm01 23/01/2005 INIZIO*/
  private String CHECK_CONG_SPESA_COMPL = "";
/*mm01 23/01/2005 FINE*/
/*mm01 04/05/2005 INIZIO*/
  private String TEXT_NOME_FILE = "";
/*mm01 04/05/2005 FINE*/


  public void setDESC_FUNZ(String value)
  {
    DESC_FUNZ = value;
  }

  public String getDESC_FUNZ()
  {
    return DESC_FUNZ;
  }

  public void setCODE_FUNZ(String value)
  {
    CODE_FUNZ = value;
  }

  public String getCODE_FUNZ()
  {
    return CODE_FUNZ;
  }

  public void setQUERY_SERVIZI(String value)
  {
    QUERY_SERVIZI = value;
  }

  public String getQUERY_SERVIZI()
  {
    return QUERY_SERVIZI;
  }

  public void setQUERY_ACCOUNT(String value)
  {
    QUERY_ACCOUNT = value;
  }

  public String getQUERY_ACCOUNT()
  {
    return QUERY_ACCOUNT;
  }

  public void setDATA_VISIBLE(String value)
  {
    DATA_VISIBLE = value;
  }

  public String getDATA_VISIBLE()
  {
    return DATA_VISIBLE;
  }

  public void setSERVIZI_VISIBLE(String value)
  {
    SERVIZI_VISIBLE = value;
  }

  public String getSERVIZI_VISIBLE()
  {
    return SERVIZI_VISIBLE;
  }

  public void setACCOUNT_VISIBLE(String value)
  {
    ACCOUNT_VISIBLE = value;
  }

  public String getACCOUNT_VISIBLE()
  {
    return ACCOUNT_VISIBLE;
  }

  public boolean equals(Object obj)
  {
    try{
      DB_ElabAttive myObj = (DB_ElabAttive)obj;
      return this.getCODE_FUNZ().equals(myObj.getCODE_FUNZ());
    }
    catch(Exception e){
      return false;
    }
  }


  public void setGESTORE_VISIBLE(String value)
  {
    GESTORE_VISIBLE = value;
  }


  public String getGESTORE_VISIBLE()
  {
    return GESTORE_VISIBLE;
  }


  public void setQUERY_GESTORE(String value)
  {
    QUERY_GESTORE = value;
  }


  public String getQUERY_GESTORE()
  {
    return QUERY_GESTORE;
  }


  public void setPERIODO_RIFERIMENTO_VISIBLE(String value)
  {
    PERIODO_RIFERIMENTO_VISIBLE = value;
  }


  public String getPERIODO_RIFERIMENTO_VISIBLE()
  {
    return PERIODO_RIFERIMENTO_VISIBLE;
  }


  public void setQUERY_PERIODO_RIFERIMENTO(String value)
  {
    QUERY_PERIODO_RIFERIMENTO = value;
  }


  public String getQUERY_PERIODO_RIFERIMENTO()
  {
    return QUERY_PERIODO_RIFERIMENTO;
  }


  public void setQUERY_GESTORE_NEED_PER_RIF(String value)
  {
    QUERY_GESTORE_NEED_PER_RIF = value;
  }


  public String getQUERY_GESTORE_NEED_PER_RIF()
  {
    return QUERY_GESTORE_NEED_PER_RIF;
  }


  public void setCHECK_ACQ_TLD_DA_FILE(String value)
  {
    CHECK_ACQ_TLD_DA_FILE = value;
  }


  public String getCHECK_ACQ_TLD_DA_FILE()
  {
    return CHECK_ACQ_TLD_DA_FILE;
  }

/*mm01 23/01/2005 INIZIO*/
  public void setCHECK_CONG_SPESA_COMPL(String value)
  {
    CHECK_CONG_SPESA_COMPL = value;
  }

  public String getCHECK_CONG_SPESA_COMPL()
  {
    return CHECK_CONG_SPESA_COMPL;
  }
/*mm01 23/01/2005 FINE*/

/*mm01 04/05/2005 INIZIO*/
  public void setTEXT_NOME_FILE(String value)
  {
    TEXT_NOME_FILE = value;
  }

  public String getTEXT_NOME_FILE()
  {
    return TEXT_NOME_FILE;
  }
/*mm01 04/05/2005 FINE*/


  public void setQUERY_SERVIZIO_NEED_PER_RIF(String value)
  {
    QUERY_SERVIZIO_NEED_PER_RIF = value;
  }


  public String getQUERY_SERVIZIO_NEED_PER_RIF()
  {
    return QUERY_SERVIZIO_NEED_PER_RIF;
  }

  public void setQUERY_ACCOUNT_NEED_PER_RIF(String value)
  {
    QUERY_ACCOUNT_NEED_PER_RIF = value;
  }


  public String getQUERY_ACCOUNT_NEED_PER_RIF()
  {
    return QUERY_ACCOUNT_NEED_PER_RIF;
  }


  public void setFUNZ_PARAM(String value)
  {
    FUNZ_PARAM = value;
  }


  public String getFUNZ_PARAM()
  {
    return FUNZ_PARAM;
  }


  public void setBATCH_NEED_PER_RIF(String value)
  {
    BATCH_NEED_PER_RIF = value;
  }


  public String getBATCH_NEED_PER_RIF()
  {
    return BATCH_NEED_PER_RIF;
  }


  public void setQUERY_DETT_VERIFICA(String value)
  {
    QUERY_DETT_VERIFICA = value;
  }


  public String getQUERY_DETT_VERIFICA()
  {
    return QUERY_DETT_VERIFICA;
  }


  public void setQUERY_SCARTI(String value)
  {
    QUERY_SCARTI = value;
  }


  public String getQUERY_SCARTI()
  {
    return QUERY_SCARTI;
  }

}