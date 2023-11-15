package com.utl;

import java.io.Serializable;

public class DB_CodiceProgetto implements Serializable
{
    private int codeServizioLogico;
    private String codeServizioLogicoDesc;
    private String codeProgetto;
    private String tipologia;
    private String dataDiRiferimento;
    private int codeAccount;
    private String codeAccountStr;
    private String codeAccountDesc;
        
    public DB_CodiceProgetto() {
        codeServizioLogico = 0;
        codeServizioLogicoDesc = "";
        codeProgetto = "";
        tipologia = "";
        dataDiRiferimento = "";
        codeAccount = 0;
        codeAccountDesc = "";
        codeAccountStr = "";
    }

    public void setCodeServizioLogico(int codeServizioLogico) {
        this.codeServizioLogico = codeServizioLogico;
    }

    public int getCodeServizioLogico() {
        return codeServizioLogico;
    }

    public void setCodeServizioLogicoDesc(String codeServizioLogicoDesc) {
        this.codeServizioLogicoDesc = codeServizioLogicoDesc;
    }

    public String getCodeServizioLogicoDesc() {
        return codeServizioLogicoDesc;
    }

    public void setCodeProgetto(String codeProgetto) {
        this.codeProgetto = codeProgetto;
    }

    public String getCodeProgetto() {
        return codeProgetto;
    }

    public void setDataDiRiferimento(String dataDiRiferimento) {
        this.dataDiRiferimento = dataDiRiferimento;
    }

    public String getDataDiRiferimento() {
        return dataDiRiferimento;
    }

    public void setCodeAccount(int codeAccount) {
        this.codeAccount = codeAccount;
    }

    public int getCodeAccount() {
        return codeAccount;
    }

    public void setCodeAccountDesc(String codeAccountDesc) {
        this.codeAccountDesc = codeAccountDesc;
    }

    public String getCodeAccountDesc() {
        return codeAccountDesc;
    }

    public void setTipologia(String tipologia) {
        this.tipologia = tipologia;
    }

    public String getTipologia() {
        return tipologia;
    }

    public void setCodeAccountStr(String codeAccountStr) {
        this.codeAccountStr = codeAccountStr;
    }

    public String getCodeAccountStr() {
        return codeAccountStr;
    }
}
