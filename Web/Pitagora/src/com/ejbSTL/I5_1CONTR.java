package com.ejbSTL;

import java.io.Serializable;
import java.sql.*;

public class I5_1CONTR implements Serializable
{
 
  protected String CODE_CONTR;
  protected String CODE_TIPO_CONTR;
  protected String CODE_GEST;
  protected String DESC_CONTR;
  protected Date   DATA_SCAD_CONTR;
  protected Date   DATA_STIP_CONTR;
  protected String DESC_PUNTI_CONTT_TI;
  protected String DESC_PUNTI_CONTT_OI;
  protected Date   DATA_INIZIO_VALID;
  protected Date   DATA_FINE_VALID;
  protected String CODE_UTENTE_CREAZ;
  protected Date   DATA_CREAZ;
  protected String CODE_UTENTE_MODIF;
  protected Date   DATA_MODIF;
  protected String DESC_TEMPI_RECES;
  protected String TIPO_FLAG_INTERIM_CAP;
  protected String TIPO_FLAG_PROV;
  protected String FLAG_SYS;

 /* In definitiva non necessario in quanto implicitamente già assegnato il null
  public I5_1CONTR()
  {
    CODE_CONTR            = null;
    CODE_TIPO_CONTR       = null;
    CODE_GEST             = null;
    DESC_CONTR            = null;
    DATA_SCAD_CONTR       = null;
    DATA_STIP_CONTR       = null;
    DESC_PUNTI_CONTT_TI   = null;
    DESC_PUNTI_CONTT_OI   = null;
    DATA_INIZIO_VALID     = null;
    DATA_FINE_VALID       = null;
    CODE_UTENTE_CREAZ     = null;
    DATA_CREAZ            = null;
    CODE_UTENTE_MODIF     = null;
    DATA_MODIF            = null;
    DESC_TEMPI_RECES      = null;
    TIPO_FLAG_INTERIM_CAP = null;
    TIPO_FLAG_PROV        = null;
    FLAG_SYS              = null;
  }
  */
 

  public String getCODE_CONTR()
   {
     return CODE_CONTR ;
   }

  public void setCODE_CONTR(String value)
   {
     CODE_CONTR = value;
   }

  public String getCODE_TIPO_CONTR()
   {
     return CODE_TIPO_CONTR ;
   }

  public void setCODE_TIPO_CONTR(String value)
   {
     CODE_TIPO_CONTR = value;
   }

  public String getCODE_GEST()
   {
     return CODE_GEST ;
   }

  public void setCODE_GEST(String value)
   {
     CODE_GEST = value;
   }

  public String getDESC_CONTR()
   {
     return DESC_CONTR ;
   }

  public void setDESC_CONTR(String value)
   {
     DESC_CONTR = value;
   }

  public Date getDATA_SCAD_CONTR()
   {
     return DATA_SCAD_CONTR ;
   }

  public void setDATA_SCAD_CONTR(Date value)
   {
     DATA_SCAD_CONTR = value;
   }

  public Date getDATA_STIP_CONTR()
   {
     return DATA_STIP_CONTR ;
   }

  public void setDATA_STIP_CONTR(Date value)
   {
     DATA_STIP_CONTR = value;
   }

  public String getDESC_PUNTI_CONTT_TI()
   {
     return DESC_PUNTI_CONTT_TI ;
   }

  public void setDESC_PUNTI_CONTT_TI(String value)
   {
     DESC_PUNTI_CONTT_TI = value;
   }

  public String getDESC_PUNTI_CONTT_OI()
   {
     return DESC_PUNTI_CONTT_OI ;
   }

  public void setDESC_PUNTI_CONTT_OI(String value)
   {
     DESC_PUNTI_CONTT_OI = value;
   }

  public Date getDATA_INIZIO_VALID()
   {
     return DATA_INIZIO_VALID ;
   }

  public void setDATA_INIZIO_VALID(Date value)
   {
     DATA_INIZIO_VALID = value;
   }

  public Date getDATA_FINE_VALID()
   {
     return DATA_FINE_VALID ;
   }

  public void setDATA_FINE_VALID(Date value)
   {
     DATA_FINE_VALID = value;
   }

  public String getCODE_UTENTE_CREAZ()
   {
     return CODE_UTENTE_CREAZ ;
   }

  public void setCODE_UTENTE_CREAZ(String value)
   {
     CODE_UTENTE_CREAZ = value;
   }

  public Date getDATA_CREAZ()
   {
     return DATA_CREAZ ;
   }

  public void setDATA_CREAZ(Date value)
   {
     DATA_CREAZ = value;
   }

  public String getCODE_UTENTE_MODIF()
   {
     return CODE_UTENTE_MODIF ;
   }

  public void setCODE_UTENTE_MODIF(String value)
   {
     CODE_UTENTE_MODIF = value;
   }

  public Date getDATA_MODIF()
   {
     return DATA_MODIF ;
   }

  public void setDATA_MODIF(Date value)
   {
     DATA_MODIF = value;
   }

  public String getDESC_TEMPI_RECES()
   {
     return DESC_TEMPI_RECES ;
   }

  public void setDESC_TEMPI_RECES(String value)
   {
     DESC_TEMPI_RECES = value;
   }

  public String getTIPO_FLAG_INTERIM_CAP()
   {
     return TIPO_FLAG_INTERIM_CAP ;
   }

  public void setTIPO_FLAG_INTERIM_CAP(String value)
   {
     TIPO_FLAG_INTERIM_CAP = value;
   }

  public String getTIPO_FLAG_PROV()
   {
     return TIPO_FLAG_PROV ;
   }

  public void setTIPO_FLAG_PROV(String value)
   {
     TIPO_FLAG_PROV = value;
   }

  public String getFLAG_SYS()
   {
     return FLAG_SYS ;
   }

  public void setFLAG_SYS(String value)
   {
     FLAG_SYS = value;
   }
  
}