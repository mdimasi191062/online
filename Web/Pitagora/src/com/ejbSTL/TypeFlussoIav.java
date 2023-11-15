package com.ejbSTL;

import java.io.Serializable;

public class TypeFlussoIav implements Serializable{

    private Integer idFlusso;
    private String type;
    private String scope;
    private String descr;

    public TypeFlussoIav() {
    idFlusso = null;
    type = null;
    scope = null;
    descr = null;
    }

    public void setIdFlusso(Integer idFlusso) {
        this.idFlusso = idFlusso;
    }

    public Integer getIdFlusso() {
        return idFlusso;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }

    public void setScope(String scope) {
        this.scope = scope;
    }

    public String getScope() {
        return scope;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }

    public String getDescr() {
        return descr;
    }
}
