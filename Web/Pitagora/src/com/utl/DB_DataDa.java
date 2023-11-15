package com.utl;

public class DB_DataDa extends AbstractDataBean 
{
    private String CODE_DATADA = "";
    private String DESC_DATADA = "";


    public void setCODE_DATADA(String cODE_DATADA) {
        this.CODE_DATADA = cODE_DATADA;
    }

    public String getCODE_DATADA() {
        return CODE_DATADA;
    }

    public void setDESC_DATADA(String dESC_DATADA) {
        this.DESC_DATADA = dESC_DATADA;
    }

    public String getDESC_DATADA() {
        return DESC_DATADA;
    }
}
