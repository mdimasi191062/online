package com.utl;

public class DB_I5_6SysParam extends AbstractDataBean  {
    private String CODE_ID;
    private String CODE_TEXT_VALUE;
    private String NUM_NUMERIC_VALUE;
    private String DESC_DESCRIPTION;

    public DB_I5_6SysParam() {
    }

    public String getCODE_ID() {
        return CODE_ID;
    }

    public void setCODE_ID(String newCODE_ID) {
        CODE_ID = newCODE_ID;
    }

    public String getCODE_TEXT_VALUE() {
        return CODE_TEXT_VALUE;
    }

    public void setCODE_TEXT_VALUE(String newCODE_TEXT_VALUE) {
        CODE_TEXT_VALUE = newCODE_TEXT_VALUE;
    }

    public String getNUM_NUMERIC_VALUE() {
        return NUM_NUMERIC_VALUE;
    }

    public void setNUM_NUMERIC_VALUE(String newNUM_NUMERIC_VALUE) {
        NUM_NUMERIC_VALUE = newNUM_NUMERIC_VALUE;
    }

    public String getDESC_DESCRIPTION() {
        return DESC_DESCRIPTION;
    }

    public void setDESC_DESCRIPTION(String newDESC_DESCRIPTION) {
        DESC_DESCRIPTION = newDESC_DESCRIPTION;
    }
}