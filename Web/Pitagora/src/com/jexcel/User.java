package com.jexcel;

import java.util.*;

public class User 
{
  public User()
  {
  }

private String userID;
private String nome;
private String cognome;
private String profilo;
private String funzione;
private String dataAbilitazione;
private String dataDisabilitazione = "31/12/2999 23:59:59";
private String modificheProfilo;
private String dataModifica;
private String dataInizioAccesso;
private String dataFineAccesso;
private Vector vetDateAcessoDisconnessione;

  public String getCognome()
  {
    return cognome;
  }

  public void setCognome(String cognome)
  {
    this.cognome = cognome;
  }

  public String getDataAbilitazione()
  {
    return dataAbilitazione;
  }

  public void setDataAbilitazione(String dataAbilitazione)
  {
    this.dataAbilitazione = dataAbilitazione;
  }

  public String getDataDisabilitazione()
  {
    return dataDisabilitazione;
  }

  public void setDataDisabilitazione(String dataDisabilitazione)
  {
    this.dataDisabilitazione = dataDisabilitazione;
  }

  public String getDataModifica()
  {
    return dataModifica;
  }

  public void setDataModifica(String dataModifica)
  {
    this.dataModifica = dataModifica;
  }

  public String getFunzione()
  {
    return funzione;
  }

  public void setFunzione(String funzione)
  {
    this.funzione = funzione;
  }

  public String getModificheProfilo()
  {
    return modificheProfilo;
  }

  public void setModificheProfilo(String modificheProfilo)
  {
    this.modificheProfilo = modificheProfilo;
  }

  public String getNome()
  {
    return nome;
  }

  public void setNome(String nome)
  {
    this.nome = nome;
  }

  public String getProfilo()
  {
    return profilo;
  }

  public void setProfilo(String profilo)
  {
    this.profilo = profilo;
  }

  public String getUserID()
  {
    return userID;
  }

  public void setUserID(String userID)
  {
    this.userID = userID;
  }

  public String getDataInizioAccesso()
  {
    return dataInizioAccesso;
  }

  public void setDataInizioAccesso(String dataInizioAccesso)
  {
    this.dataInizioAccesso = dataInizioAccesso;
  }

  public String getDataFineAccesso()
  {
    return dataFineAccesso;
  }

  public void setDataFineAccesso(String dataFineAccesso)
  {
    this.dataFineAccesso = dataFineAccesso;
  }

  public Vector getVetDateAccessoDisconnessione()
  {
    return vetDateAcessoDisconnessione;
  }

  public void setVetDateAccessoDisconnessione(Vector newVetDateAccessoDisconnessione)
  {
    this.vetDateAcessoDisconnessione = newVetDateAccessoDisconnessione;
  }


  public boolean isInRange(){
    boolean b = false;
    try{
      StringTokenizer stz = new StringTokenizer(dataAbilitazione, "/ :.");
      int date=Integer.parseInt(stz.nextToken());
      int month=Integer.parseInt(stz.nextToken())-1;
      int year=Integer.parseInt(stz.nextToken());
      int hrs=0;
      int min=0;
      int sec=0;
      try {
        hrs=Integer.parseInt(stz.nextToken());
        min=Integer.parseInt(stz.nextToken());
        sec=Integer.parseInt(stz.nextToken());
      }catch(Exception ex1){}

      Calendar d0 = Calendar.getInstance();
      d0.set(year, month, date, hrs, min, sec);

      if(dataDisabilitazione == null)
         dataDisabilitazione = "31/12/2999 23:59:59";

      stz = new StringTokenizer(dataDisabilitazione, "/ :");
      date=Integer.parseInt(stz.nextToken());
      month=Integer.parseInt(stz.nextToken())-1;
      year=Integer.parseInt(stz.nextToken());
      hrs=0; min=0; sec=0;
      try {
        hrs=Integer.parseInt(stz.nextToken());
        min=Integer.parseInt(stz.nextToken());
        sec=Integer.parseInt(stz.nextToken());
      }catch(Exception ex1){}
      
      Calendar d1 = Calendar.getInstance();
      d1.set(year, month, date, hrs, min, sec);


      stz = new StringTokenizer(dataInizioAccesso, "/ :");
      date=Integer.parseInt(stz.nextToken());
      month=Integer.parseInt(stz.nextToken())-1;
      year=Integer.parseInt(stz.nextToken());
      hrs=0; min=0; sec=0;
      try {
        hrs=Integer.parseInt(stz.nextToken());
        min=Integer.parseInt(stz.nextToken());
        sec=Integer.parseInt(stz.nextToken());
      }catch(Exception ex1){}
      
      Calendar da = Calendar.getInstance();
      da.set(year, month, date, hrs, min, sec);


      if ((da.equals(d0) || da.after(d0)) && (da.before(d1) || da.equals(d1))){

        stz = new StringTokenizer(dataFineAccesso, "/ :");
        date=Integer.parseInt(stz.nextToken());
        month=Integer.parseInt(stz.nextToken())-1;
        year=Integer.parseInt(stz.nextToken());
        hrs=0; min=0; sec=0;
        try {
          hrs=Integer.parseInt(stz.nextToken());
          min=Integer.parseInt(stz.nextToken());
          sec=Integer.parseInt(stz.nextToken());
        }catch(Exception ex1){}

        Calendar db = Calendar.getInstance();
        db.set(year, month, date, hrs, min, sec);

        b = ((db.equals(d0) || db.after(d0)) && (db.equals(d1) || db.before(d1)));
    }


    }catch(Exception ex){
      System.out.println("Exception User.isInRange: "+ex.toString());
    }
    return b;
  }

}