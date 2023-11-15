package com.utl;

public class DB_Istanza  extends AbstractDataBean 
{
    private String CODE_ISTANZA = "";
    private String DESC_ISTANZA = "";


    public void setCODE_ISTANZA(String cODE_ISTANZA) {
        this.CODE_ISTANZA = cODE_ISTANZA;
    }

    public String getCODE_ISTANZA() {
        return CODE_ISTANZA;
    }

    public void setDESC_ISTANZA(String dESC_ISTANZA) {
        this.DESC_ISTANZA = dESC_ISTANZA;
    }

    public String getDESC_ISTANZA() {
        return DESC_ISTANZA;
    }
}
