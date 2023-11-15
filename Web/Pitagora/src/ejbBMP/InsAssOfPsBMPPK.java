package com.ejbBMP;
import com.utl.*;

public class InsAssOfPsBMPPK extends AbstractPK 
{
  private String dataIni; 
  private String dataFine; 
  private String dataIniOf; 
  private String DataIniValidMin; 
  private String DataFineValidMax; 

  private String cod_contratto; 
  private String PS; 
  private String modApplSelezValue; 
  private String freqSelezValue; 
  private String codiceUtente; 
  private int shift; 
  private String flagAP; 



  public InsAssOfPsBMPPK()
  {
  }

  public InsAssOfPsBMPPK(String data_ini,String cod_of,String PS,String dataInizioOf,
                         String modApplSelezValue,String freqSelezValue,String codiceUtente,
                         int shift,String flagAP,String data_fine) 
  {
   this.dataIni=data_ini;
   this.cod_contratto=cod_contratto;
   this.PS=PS;
   this.dataIniOf=dataInizioOf;
   this.modApplSelezValue=modApplSelezValue;
   this.freqSelezValue=freqSelezValue;
   this.codiceUtente=codiceUtente;
   this.shift=shift;
   this.flagAP=flagAP;
   this.dataFine=data_fine;

 //System.out.println("cod_contratto="+cod_contratto);
 //System.out.println("data_ini="+data_ini);
 //System.out.println("cod_of="+cod_of);
 //System.out.println("PS="+PS);
 //System.out.println("dataInizioOf="+dataInizioOf);
 //System.out.println("modApplSelezValue="+modApplSelezValue);
 //System.out.println("freqSelezValue="+freqSelezValue);
 //System.out.println("codiceUtente="+codiceUtente);
 //System.out.println("shift="+shift);
 //System.out.println("flagAP="+flagAP);
 //System.out.println("data_fine="+data_fine);
//System.out.println("----------------------------");

  }

  public InsAssOfPsBMPPK(String dataIni,String dataFine,String dataIniOf)
  {
   this.dataIni=dataIni;
   this.dataFine=dataFine;
   this.dataIniOf=dataIniOf;
  }

  public void setDataIni(String stringa)
  {
    dataIni=stringa;
  }
  
  public String getDataIni()
  {
    return dataIni;
  }

  public void setDataFine(String stringa)
  {
 //System.out.println("nel PK="+stringa);    
    dataFine=stringa;
  }
  
  public String getDataFine()
  {
    return dataFine;
  }

  public void setDataIniOf(String stringa)
  {
    dataIniOf=stringa;
  }
  
  public String getDataIniOf()
  {
    return dataIniOf;
  }

  public void setDataIniValidMin(String stringa)
  {
    DataIniValidMin=stringa;
  }
  
  public String getDataIniValidMin()
  {
    return DataIniValidMin;
  }

  public void setDataFineValidMax(String stringa)
  {
    DataFineValidMax=stringa;
  }

  public String getDataFineValidMax()
  {
    return DataFineValidMax;
  }


}