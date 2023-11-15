package com.utl;
import com.utl.AbstractDataBean;

public class DB_CAT_Account extends DB_AccountNew 
{
    private String FLAG_INTERIM = "";
    private String CODE_GESTORE_SAP = "";
    private String FLAG_INVIO_SAP = "";
    private String DATA_INIZIO_VALIDITA_SAP = "";
    private String DATA_FINE_VALIDITA_SAP = "";
    private String DESC_GESTORE = "";
    private String FLAG_MODIF = "";    

    public String getFLAG_INTERIM()
    {
        return FLAG_INTERIM;
    }

    public void setFLAG_INTERIM(String newFLAG_INTERIM)
    {
        FLAG_INTERIM = newFLAG_INTERIM;
    }

    public String getFLAG_INVIO_SAP()
    {
        return FLAG_INVIO_SAP;
    }

    public void setFLAG_INVIO_SAP(String newFLAG_INVIO_SAP)
    {
        FLAG_INVIO_SAP = newFLAG_INVIO_SAP;
    }

    public String getDATA_INIZIO_VALIDITA_SAP()
    {
        return DATA_INIZIO_VALIDITA_SAP;
    }

    public void setDATA_INIZIO_VALIDITA_SAP(String newDATA_INIZIO_VALIDITA_SAP)
    {
        DATA_INIZIO_VALIDITA_SAP = newDATA_INIZIO_VALIDITA_SAP;
    }

    public String getDATA_FINE_VALIDITA_SAP()
    {
        return DATA_FINE_VALIDITA_SAP;
    }

    public void setDATA_FINE_VALIDITA_SAP(String newDATA_FINE_VALIDITA_SAP)
    {
        DATA_FINE_VALIDITA_SAP = newDATA_FINE_VALIDITA_SAP;
    }

    public String getDESC_GESTORE()
    {
        return DESC_GESTORE;
    }

    public void setDESC_GESTORE(String value)
    {
        DESC_GESTORE = value;
    }

    public String getCODE_GESTORE_SAP()
    {
        return CODE_GESTORE_SAP;
    }

    public void setCODE_GESTORE_SAP(String value)
    {
        CODE_GESTORE_SAP = value;
    }
    
    public String getFLAG_MODIF()
    {
      return FLAG_MODIF;
    }
    public void setFLAG_MODIF(String value)
    {
      FLAG_MODIF = value;
    }
}
