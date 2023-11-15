package com.ejbSTL;

import java.io.Serializable;

public class TypeDescrizione implements Serializable{

    private String desc;

    public TypeDescrizione() {
    desc = null;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getDesc() {
        return desc;
    }
}