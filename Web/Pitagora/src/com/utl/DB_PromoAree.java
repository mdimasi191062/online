package com.utl;

import java.io.Serializable;

public class DB_PromoAree implements Serializable
{

  private String descAccount;
  private String descArea; 
  private String codeAccount;
  private String codeArea;
  private String idPromoAree;
  
  public DB_PromoAree()
  {
  }

  public void setDescAccount(String descAccount)
  {
    this.descAccount = descAccount;
  }

  public String getDescAccount()
  {
    return descAccount;
  }  

    public void setDescArea(String descArea) {
        this.descArea = descArea;
    }

    public String getDescArea() {
        return descArea;
    }

    public void setCodeAccount(String codeAccount) {
        this.codeAccount = codeAccount;
    }

    public String getCodeAccount() {
        return codeAccount;
    }

    public void setCodeArea(String codeArea) {
        this.codeArea = codeArea;
    }

    public String getCodeArea() {
        return codeArea;
    }

    public void setIdPromoAree(String idPromoAree) {
        this.idPromoAree = idPromoAree;
    }

    public String getIdPromoAree() {
        return idPromoAree;
    }
}
