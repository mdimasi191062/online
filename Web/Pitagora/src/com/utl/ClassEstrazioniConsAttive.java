package com.utl;

public class ClassEstrazioniConsAttive implements java.io.Serializable
{

  private String servizio;
  private String descServizio;
  private String operatore;
  private String descOperatore;
  private String prodotto;
  private String descProdotto;
  private String meseAnnoComp;
  private String numConsistenze;


  public String getServizio()
  {
    return servizio;
  }
  public void setServizio(String stringa)
  {
      servizio=stringa;
  }

  public String getDescServizio()
  {
      return descServizio;
  }
  public void setDescServizio(String stringa)
  {
     descServizio=stringa;
  }

  public String getOperatore()
  {
    return operatore;
  }
  public void setOperatore(String stringa)
  {
      operatore=stringa;
  }

    public String getDescOperatore()
    {
      return descOperatore;
    }
    public void setDescOperatore(String stringa)
    {
        descOperatore=stringa;
    }

  public String getProdotto()
  {
    return prodotto;
  }
  public void setProdotto(String stringa)
  {
      prodotto=stringa;
  }

    public String getDescProdotto()
    {
      return descProdotto;
    }
    public void setDescProdotto(String stringa)
    {
        descProdotto=stringa;
    }
    
  public String getMeseAnnoComp()
  {
    return meseAnnoComp;
  }
  public void setMeseAnnoComp(String stringa)
  {
      meseAnnoComp=stringa;
  }
  
  public String getNumConsistenze()
  {
    return numConsistenze;
  }
  public void setNumConsistenze(String stringa)
  {
      numConsistenze=stringa;
  }
  
}