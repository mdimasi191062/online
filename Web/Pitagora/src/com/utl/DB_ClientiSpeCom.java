package com.utl;
import com.utl.AbstractDataBean;

public class DB_ClientiSpeCom extends AbstractDataBean 
{
    private String CODE_GEST = "";
    private String COUNT_TESTATA_SPE_COM = "";
    private String MAX_DATA_CREAZ_SPE_COM = "";
    private String DATE_DATA_INS = "";
    private String DATE_DATA_OR = "";

    public String getCODE_GEST()
    {
        return CODE_GEST;
    }

    public void setCODE_GEST(String newCODE_GEST)
    {
        CODE_GEST = newCODE_GEST;
    }

    public String getCOUNT_TESTATA_SPE_COM()
    {
        return COUNT_TESTATA_SPE_COM;
    }

    public void setCOUNT_TESTATA_SPE_COM(String newCOUNT_TESTATA_SPE_COM)
    {
        COUNT_TESTATA_SPE_COM = newCOUNT_TESTATA_SPE_COM;
    }

    public String getMAX_DATA_CREAZ_SPE_COM()
    {
        return MAX_DATA_CREAZ_SPE_COM;
    }

    public void setMAX_DATA_CREAZ_SPE_COM(String newMAX_DATA_CREAZ_SPE_COM)
    {
        MAX_DATA_CREAZ_SPE_COM = newMAX_DATA_CREAZ_SPE_COM;
    }

    public String getDATE_DATA_INS()
    {
        return DATE_DATA_INS;
    }

    public void setDATE_DATA_INS(String newDATE_DATA_INS)
    {
        DATE_DATA_INS = newDATE_DATA_INS;
    }

    public String getDATE_DATA_OR()
    {
        return DATE_DATA_OR;
    }

    public void setDATE_DATA_OR(String newDATE_DATA_OR)
    {
        DATE_DATA_OR = newDATE_DATA_OR;
    }
}