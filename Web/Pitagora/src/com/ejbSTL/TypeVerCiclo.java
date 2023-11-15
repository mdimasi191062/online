package com.ejbSTL;

import java.io.Serializable;

public class TypeVerCiclo implements Serializable{

    private String ciclo;
    private String code;
    private String desc;

    public TypeVerCiclo() {
    ciclo = null;
    }


    public void setCiclo(String ciclo) {
        this.ciclo = ciclo;
    }

    public String getCiclo() {
        return ciclo;
    }
}
