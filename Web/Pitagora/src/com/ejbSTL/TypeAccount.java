package com.ejbSTL;

import java.io.Serializable;

public class TypeAccount implements Serializable{

    private String code;
    private String desc;

    public TypeAccount() {
    code = null;
    desc = null;
    }


    public void setCode(String code) {
        this.code = code;
    }

    public String getCode() {
        return code;
    }
    
    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getDesc() {
        return desc;
    }
}