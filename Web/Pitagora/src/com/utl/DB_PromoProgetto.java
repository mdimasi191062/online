package com.utl;

import java.io.Serializable;

public class DB_PromoProgetto implements Serializable
{
    private String codeAccountDesc;
    private String codeAccount;
    private String codeProgetto;
    private String codePromozione;
    private String dataInizio;
    private String dataFine;
        
    public DB_PromoProgetto()
    {
    }

    public void setCodeAccount(String codeAccount) {
        this.codeAccount = codeAccount;
    }

    public String getCodeAccount() {
        return codeAccount;
    }

    public void setCodeProgetto(String codeProgetto) {
        this.codeProgetto = codeProgetto;
    }

    public String getCodeProgetto() {
        return codeProgetto;
    }

    public void setCodePromozione(String codePromozione) {
        this.codePromozione = codePromozione;
    }

    public String getCodePromozione() {
        return codePromozione;
    }

    public void setDataInizio(String dataInizio) {
        this.dataInizio = dataInizio;
    }

    public String getDataInizio() {
        return dataInizio;
    }

    public void setDataFine(String dataFine) {
        this.dataFine = dataFine;
    }

    public String getDataFine() {
        return dataFine;
    }

    public void setCodeAccountDesc(String codeAccountDesc) {
        this.codeAccountDesc = codeAccountDesc;
    }

    public String getCodeAccountDesc() {
        return codeAccountDesc;
    }
}
