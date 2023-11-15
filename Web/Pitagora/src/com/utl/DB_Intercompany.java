package com.utl;

import java.io.Serializable;

public class DB_Intercompany implements Serializable
{
    private String codiceCliente;
    private String denominazione;
        
    public DB_Intercompany() {
        codiceCliente = "";
        denominazione = "";
    }

    public void setCodiceCliente(String codiceCliente) {
        this.codiceCliente = codiceCliente;
    }

    public String getCodiceCliente() {
        return codiceCliente;
    }

    public void setDenominazione(String denominazione) {
        this.denominazione = denominazione;
    }

    public String getDenominazione() {
        return denominazione;
    }
}
