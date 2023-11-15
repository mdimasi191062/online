package com.utl;

public class DB_AnagFunz extends AbstractDataBean  {
    private String CODE_FUNZ;
    private String DESC_FUNZ;

    public DB_AnagFunz() {
    }

    public String getCODE_FUNZ() {
        return CODE_FUNZ;
    }

    public void setCODE_FUNZ(String newCODE_FUNZ) {
        CODE_FUNZ = newCODE_FUNZ;
    }

    public String getDESC_FUNZ() {
        return DESC_FUNZ;
    }

    public void setDESC_FUNZ(String newDESC_FUNZ) {
        DESC_FUNZ = newDESC_FUNZ;
    }
}