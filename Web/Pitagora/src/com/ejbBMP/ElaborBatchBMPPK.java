package com.ejbBMP;

import com.utl.*;

public class ElaborBatchBMPPK extends AbstractPK  
{
  private int numElab;
  private String codeElab; 
  private String stato;
  private String dataIni;
  private String dataFine;
  private String nPS; 
  private String codeStato;
  private int numElabUguali;
  public ElaborBatchBMPPK()
  {
  
  }

  public ElaborBatchBMPPK(int numElab, String codeElab, String codeStato,String stato,String dataIni,String dataFine, String nPS, int numElabUguali)
  {
   this.numElab=numElab;
   this.codeElab=codeElab;
   this.stato=stato;
   this.dataIni=dataIni;
   this.dataFine=dataFine;
   this.nPS=nPS;
   this.codeStato=codeStato;
   this.numElabUguali=numElabUguali;
  }
  public void setElabBatch(int numElab)
  {
    this.numElab=numElab;
  }
  public int getElabBatch()
  {
    return this.numElab;
  }
  public void setElabUguali(int numElabUguali)
  {
    this.numElabUguali=numElabUguali;
  }
  public int getElabUguali()
  {
    return this.numElabUguali;
  }
    public void setCodeElab(String codeElab)
  {
    
    this.codeElab=codeElab;
    
  }
  public String getCodeElab()
  {
  
    return this.codeElab;
  }
  public void setStato(String stato)
  {
    this.stato=stato;
  }
  public String getStato()
  {
    return this.stato;
  }
    public void setCodeStato(String codeStato)
  {
    this.codeStato=codeStato;
  }
  public String getCodeStato()
  {
    return this.codeStato;
  }
  public void setDataIni(String dataIni)
  {
    this.dataIni=dataIni;
  }
  public String getDataIni()
  {
    return this.dataIni;
  }
    public void setDataFine(String dataFine)
  {
    this.dataFine=dataFine;
  }
  public String getDataFine()
  {
    return this.dataFine;
  }
 public void setNPS(String nPS)
  {
    this.nPS=nPS;
  }
  public String getNPS()
  {
    return this.nPS;
  }
}