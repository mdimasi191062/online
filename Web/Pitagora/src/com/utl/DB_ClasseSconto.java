package com.utl;
import com.utl.AbstractDataBean;

public class DB_ClasseSconto extends AbstractDataBean
{
  private String CODE_CLAS_SCONTO = "";
  private String CODE_PR_CLAS_SCONTO = "";
  private String IMPT_MIN_SPESA = "";
  private String IMPT_MAX_SPESA = "";
  private String DATA_INIZIO_VALID = "";
  private String DATA_FINE_VALID = "";
  private String DESC_CLAS_SCONTO = "";
  private String CODE_GEST = "";
  private String NOME_RAG_SOC_GEST = "";
  private String CODE_TEST_SPESA_COMPL = "";
  private String DATA_MM_RIF_SPESA_COMPL = "";
  private String DATA_AA_RIF_SPESA_COMPL = "";
  private String CODE_ACCOUNT = "";
  private String DESC_ACCOUNT = "";

    private String DATA_DECORR_CLAS_SCONTO = "";
    private String DATA_SCAD_CLAS_SCONTO = "";
    private String TIPO_FLAG_CONGUAGLIO = "";
    private String CODE_PARAM_CLAS_SCONTO_RIF = "";


    public String getDATA_DECORR_CLAS_SCONTO()
    {
        return DATA_DECORR_CLAS_SCONTO;
    }

    public void setDATA_DECORR_CLAS_SCONTO(String newDATA_DECORR_CLAS_SCONTO)
    {
        DATA_DECORR_CLAS_SCONTO = newDATA_DECORR_CLAS_SCONTO;
    }

    public String getCODE_PARAM_CLAS_SCONTO_RIF()
    {
        return CODE_PARAM_CLAS_SCONTO_RIF;
    }

    public void setCODE_PARAM_CLAS_SCONTO_RIF(String newCODE_PARAM_CLAS_SCONTO_RIF)
    {
        CODE_PARAM_CLAS_SCONTO_RIF = newCODE_PARAM_CLAS_SCONTO_RIF;
    }

    public String getDATA_SCAD_CLAS_SCONTO()
    {
        return DATA_SCAD_CLAS_SCONTO;
    }

    public void setDATA_SCAD_CLAS_SCONTO(String newDATA_SCAD_CLAS_SCONTO)
    {
        DATA_SCAD_CLAS_SCONTO = newDATA_SCAD_CLAS_SCONTO;
    }

    public String getTIPO_FLAG_CONGUAGLIO()
    {
        return TIPO_FLAG_CONGUAGLIO;
    }

    public void setTIPO_FLAG_CONGUAGLIO(String newTIPO_FLAG_CONGUAGLIO)
    {
        TIPO_FLAG_CONGUAGLIO = newTIPO_FLAG_CONGUAGLIO;
    }


  public String getCODE_CLAS_SCONTO()
  {
    return CODE_CLAS_SCONTO;
  }

  public void setCODE_CLAS_SCONTO(String newCODE_CLAS_SCONTO)
  {
    CODE_CLAS_SCONTO = newCODE_CLAS_SCONTO;
  }

  public String getCODE_PR_CLAS_SCONTO()
  {
    return CODE_PR_CLAS_SCONTO;
  }

  public void setCODE_PR_CLAS_SCONTO(String newCODE_PR_CLAS_SCONTO)
  {
    CODE_PR_CLAS_SCONTO = newCODE_PR_CLAS_SCONTO;
  }

  public String getIMPT_MIN_SPESA()
  {
    return IMPT_MIN_SPESA;
  }

  public void setIMPT_MIN_SPESA(String newIMPT_MIN_SPESA)
  {
    IMPT_MIN_SPESA = newIMPT_MIN_SPESA;
  }

  public String getIMPT_MAX_SPESA()
  {
    return IMPT_MAX_SPESA;
  }

  public void setIMPT_MAX_SPESA(String newIMPT_MAX_SPESA)
  {
    IMPT_MAX_SPESA = newIMPT_MAX_SPESA;
  }

  public String getDATA_INIZIO_VALID()
  {
    return DATA_INIZIO_VALID;
  }

  public void setDATA_INIZIO_VALID(String newDATA_INIZIO_VALID)
  {
    DATA_INIZIO_VALID = newDATA_INIZIO_VALID;
  }

  public String getDATA_FINE_VALID()
  {
    return DATA_FINE_VALID;
  }

  public void setDATA_FINE_VALID(String newDATA_FINE_VALID)
  {
    DATA_FINE_VALID = newDATA_FINE_VALID;
  }

  public String getDESC_CLAS_SCONTO()
  {
    return DESC_CLAS_SCONTO;
  }

  public void setDESC_CLAS_SCONTO(String newDESC_CLAS_SCONTO)
  {
    DESC_CLAS_SCONTO = newDESC_CLAS_SCONTO;
  }

    public String getCODE_GEST()
    {
        return CODE_GEST;
    }

    public void setCODE_GEST(String newCODE_GEST)
    {
        CODE_GEST = newCODE_GEST;
    }

    public String getNOME_RAG_SOC_GEST()
    {
        return NOME_RAG_SOC_GEST;
    }

    public void setNOME_RAG_SOC_GEST(String newNOME_RAG_SOC_GEST)
    {
        NOME_RAG_SOC_GEST = newNOME_RAG_SOC_GEST;
    }

    public String getCODE_ACCOUNT()
    {
        return CODE_ACCOUNT;
    }

    public void setCODE_ACCOUNT(String newCODE_ACCOUNT)
    {
        CODE_ACCOUNT = newCODE_ACCOUNT;
    }

    public String getDESC_ACCOUNT()
    {
        return DESC_ACCOUNT;
    }

    public void setDESC_ACCOUNT(String newDESC_ACCOUNT)
    {
        DESC_ACCOUNT = newDESC_ACCOUNT;
    }

    public String getCODE_TEST_SPESA_COMPL()
    {
        return CODE_TEST_SPESA_COMPL;
    }

    public void setCODE_TEST_SPESA_COMPL(String newCODE_TEST_SPESA_COMPL)
    {
        CODE_TEST_SPESA_COMPL = newCODE_TEST_SPESA_COMPL;
    }

    public String getDATA_MM_RIF_SPESA_COMPL()
    {
        return DATA_MM_RIF_SPESA_COMPL;
    }

    public void setDATA_MM_RIF_SPESA_COMPL(String newDATA_MM_RIF_SPESA_COMPL)
    {
        DATA_MM_RIF_SPESA_COMPL = newDATA_MM_RIF_SPESA_COMPL;
    }

    public String getDATA_AA_RIF_SPESA_COMPL()
    {
        return DATA_AA_RIF_SPESA_COMPL;
    }

    public void setDATA_AA_RIF_SPESA_COMPL(String newDATA_AA_RIF_SPESA_COMPL)
    {
        DATA_AA_RIF_SPESA_COMPL = newDATA_AA_RIF_SPESA_COMPL;
    }
}