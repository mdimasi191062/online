package com.utl;

public class DB_WarningValori  extends AbstractDataBean {
    public DB_WarningValori() {
    }
    
    /* STATO,CODE_RIGA,CODE_OGG_FATRZ,DATA_DA,DATA_A,IMPORTO,CODE_ISTANZA,IVA,FLAG_FC_IVA,DESC_CLASSE_OGG_FATRZ,FATT_NDC,CODE_ACCOUNT*/
    private String STATO;
    private String CODE_RIGA;
    private String CODE_OGG_FATRZ;
    private String DATA_DA;
    private String DATA_A;
    private String IMPORTO;
    private String CODE_ISTANZA;
    private String IVA;
    private String FLAG_FC_IVA;
    private String DESC_CLASSE_OGG_FATRZ;
//DOR - Add FATT_NDC & CODE_ACCOUNT -
    private String FATT_NDC;
    private String CODE_ACCOUNT;

    public void setSTATO(String sTATO) {
        this.STATO = sTATO;
    }

    public String getSTATO() {
        return STATO;
    }

    public void setCODE_RIGA(String cODE_RIGA) {
        this.CODE_RIGA = cODE_RIGA;
    }

    public String getCODE_RIGA() {
        return CODE_RIGA;
    }

    public void setCODE_OGG_FATRZ(String cODE_OGG_FATRZ) {
        this.CODE_OGG_FATRZ = cODE_OGG_FATRZ;
    }

    public String getCODE_OGG_FATRZ() {
        return CODE_OGG_FATRZ;
    }

    public void setDATA_DA(String dATA_DA) {
        this.DATA_DA = dATA_DA;
    }

    public String getDATA_DA() {
        return DATA_DA;
    }

    public void setIMPORTO(String iMPORTO) {
        this.IMPORTO = iMPORTO;
    }

    public String getIMPORTO() {
        return IMPORTO;
    }

    public void setCODE_ISTANZA(String cODE_ISTANZA) {
        this.CODE_ISTANZA = cODE_ISTANZA;
    }

    public String getCODE_ISTANZA() {
        return CODE_ISTANZA;
    }

    public void setIVA(String iVA) {
        this.IVA = iVA;
    }

    public String getIVA() {
        return IVA;
    }

    public void setFLAG_FC_IVA(String fLAG_FC_IVA) {
        this.FLAG_FC_IVA = fLAG_FC_IVA;
    }

    public String getFLAG_FC_IVA() {
        return FLAG_FC_IVA;
    }

    public void setDATA_A(String dATA_A) {
        this.DATA_A = dATA_A;
    }

    public String getDATA_A() {
        return DATA_A;
    }
//DOR - Add set/get FATT_NDC ; CODE_ACCOUNT ; DESC_CLASSE_OGG_FATRZ-
    public void setFATT_NDC(String fATT_NDC) {
        this.FATT_NDC = fATT_NDC;
    }

    public String getFATT_NDC() {
        return FATT_NDC;
    }

    public void setDESC_CLASSE_OGG_FATRZ(String dESC_CLASSE_OGG_FATRZ) {
        this.DESC_CLASSE_OGG_FATRZ = dESC_CLASSE_OGG_FATRZ;
    }

    public String getDESC_CLASSE_OGG_FATRZ() {
        return DESC_CLASSE_OGG_FATRZ;
    }

    public void setCODE_ACCOUNT(String cODE_ACCOUNT) {
        this.CODE_ACCOUNT = cODE_ACCOUNT;
    }

    public String getCODE_ACCOUNT() {
        return CODE_ACCOUNT;
    }
}
