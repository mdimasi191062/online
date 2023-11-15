package com.ejbSTL;

import java.sql.*;
import java.io.Serializable;

public class I5_5SCARTI_VALORIZZAZIONE implements Serializable
{

  protected String CODE_ITRF_FAT_XDSL_XML_RIF;
  protected String CODE_SCARTO;
  protected String DESC_SCARTO;
  protected Date   DATA_SCARTO;
  protected Date   DATA_CHIUSURA_SCARTO;
  protected String STATO_SCARTO;
  protected String DESC_ID_RISORSA;
  protected String CODE_TIPO_CONTR;
  protected String CODE_CONTR;
  protected String CODE_TRACCIATO;
  protected String CODE_DETT_SCARTO;
  protected String CHIAVE_PITA_JPUB;

 

  public String getCODE_ITRF_FAT_XDSL_XML_RIF()
   {
     return CODE_ITRF_FAT_XDSL_XML_RIF;
   }

  public void setCODE_ITRF_FAT_XDSL_XML_RIF(String pValue)
   {
     CODE_ITRF_FAT_XDSL_XML_RIF = pValue;
   }

  public String getCODE_SCARTO()
   {
     return CODE_SCARTO;
   }

  public void setCODE_SCARTO(String pValue)
   {
     CODE_SCARTO = pValue;
   }

  public String getDESC_SCARTO()
   {
     return DESC_SCARTO;
   }

  public void setDESC_SCARTO(String pValue)
   {
     DESC_SCARTO = pValue;
   }

  public Date getDATA_SCARTO()
   {
     return DATA_SCARTO;
   }

  public void setDATA_SCARTO(Date pValue)
   {
     DATA_SCARTO = pValue;
   }

  public Date getDATA_CHIUSURA_SCARTO()
   {
     return DATA_CHIUSURA_SCARTO;
   }

  public void setDATA_CHIUSURA_SCARTO(Date pValue)
   {
     DATA_CHIUSURA_SCARTO = pValue;
   }

  public String getSTATO_SCARTO()
   {
     return STATO_SCARTO;
   }

  public void setSTATO_SCARTO(String pValue)
   {
     STATO_SCARTO = pValue;
   }

  public String getDESC_ID_RISORSA()
   {
     return DESC_ID_RISORSA;
   }

  public void setDESC_ID_RISORSA(String pValue)
   {
     DESC_ID_RISORSA = pValue;
   }

  public String getCODE_TIPO_CONTR()
   {
     return CODE_TIPO_CONTR;
   }

  public void setCODE_TIPO_CONTR(String pValue)
   {
     CODE_TIPO_CONTR = pValue;
   }

  public String getCODE_CONTR()
   {
     return CODE_CONTR;
   }

  public void setCODE_CONTR(String pValue)
   {
     CODE_CONTR = pValue;
   }

  public String getCODE_TRACCIATO()
   {
     return CODE_TRACCIATO;
   }

  public void setCODE_TRACCIATO(String pValue)
   {
     CODE_TRACCIATO = pValue;
   }

  public String getCODE_DETT_SCARTO()
   {
     return CODE_DETT_SCARTO;
   }

  public void setCODE_DETT_SCARTO(String pValue)
   {
     CODE_DETT_SCARTO = pValue;
   }

  public String getCHIAVE_PITA_JPUB()
   {
     return CHIAVE_PITA_JPUB;
   }

  public void setCHIAVE_PITA_JPUB(String pValue)
   {
     CHIAVE_PITA_JPUB = pValue;
   }

}