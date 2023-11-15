package com.utl;

public class DB_Invent_RPVD extends AbstractDataBean 
{
  /* Attributi*/
  private String TAB                                    ;
  private String PROD                                   ;
  private String COMPO                                  ;
  private String PREST_AGG                              ;
	private String CODE_INVENT                            ;
	private String DESC_NUM_ORDINE_CLIENTE                ;
	private String DESC_NUM_ORDINE_CLIENTE_CESSAZ         ;
	private String DESC_FLUSSO_TERMINAZ                   ;
	private String DESC_TIPO_RETE                         ;
	private String DESC_SEDE_1                            ;
	private String DESC_IMPIANTO_SEDE_1                   ;
	private String DESC_COMUNE_SEDE_1                     ;
	private String DESC_PROVINCIA_SEDE_1                  ;
	private String DESC_DTRT_SEDE_1                       ;
	private String DESC_CENTRALE_SEDE_1                   ;
	private String DESC_SEDE_2                            ;
	private String DESC_IMPIANTO_SEDE_2                   ;
	private String DESC_COMUNE_SEDE_2                     ;
	private String DESC_PROVINCIA_SEDE_2                  ;
	private String DESC_DTRT_SEDE_2                       ;
	private String DESC_CENTRALE_SEDE_2                   ;       
  private int    MODIFICATO                             ;
  private String INSERITO                                  ;                             
  public DB_Invent_RPVD()
  {
     TAB                             = "" ;
     PROD                            = "" ;
     COMPO                           = "" ;
     PREST_AGG                       = "" ;
     CODE_INVENT                     = "" ;
     DESC_NUM_ORDINE_CLIENTE         = "" ;
     DESC_NUM_ORDINE_CLIENTE_CESSAZ  = "" ;
     DESC_FLUSSO_TERMINAZ            = "" ;
     DESC_TIPO_RETE                  = "" ;
     DESC_SEDE_1                     = "" ;
     DESC_IMPIANTO_SEDE_1            = "" ;
     DESC_COMUNE_SEDE_1              = "" ;
     DESC_PROVINCIA_SEDE_1           = "" ;
     DESC_DTRT_SEDE_1                = "" ;
     DESC_CENTRALE_SEDE_1            = "" ;
     DESC_SEDE_2                     = "" ;
     DESC_IMPIANTO_SEDE_2            = "" ;
     DESC_COMUNE_SEDE_2              = "" ;
     DESC_PROVINCIA_SEDE_2           = "" ;
     DESC_DTRT_SEDE_2                = "" ;
     DESC_CENTRALE_SEDE_2            = "" ;   
     MODIFICATO                      = 0;  
    INSERITO                         =""      ;
  }

  /* Metodi */
   public String getTAB                            () { return TAB                            ;    }
   public String getPROD                           () { return PROD                           ;    }
   public String getCOMPO                          () { return COMPO                          ;    }
   public String getPREST_AGG                      () { return PREST_AGG                      ;    }
   public String getCODE_INVENT                    () { return CODE_INVENT                    ;    }
   public String getDESC_NUM_ORDINE_CLIENTE        () { return DESC_NUM_ORDINE_CLIENTE        ;    }
   public String getDESC_NUM_ORDINE_CLIENTE_CESSAZ () { return DESC_NUM_ORDINE_CLIENTE_CESSAZ ;    }
   public String getDESC_FLUSSO_TERMINAZ           () { return DESC_FLUSSO_TERMINAZ           ;    }
   public String getDESC_TIPO_RETE                 () { return DESC_TIPO_RETE                 ;    }
   public String getDESC_SEDE_1                    () { return DESC_SEDE_1                    ;    }
   public String getDESC_IMPIANTO_SEDE_1           () { return DESC_IMPIANTO_SEDE_1           ;    }
   public String getDESC_COMUNE_SEDE_1             () { return DESC_COMUNE_SEDE_1             ;    }
   public String getDESC_PROVINCIA_SEDE_1          () { return DESC_PROVINCIA_SEDE_1          ;    }
   public String getDESC_DTRT_SEDE_1               () { return DESC_DTRT_SEDE_1               ;    }
   public String getDESC_CENTRALE_SEDE_1           () { return DESC_CENTRALE_SEDE_1           ;    }
   public String getDESC_SEDE_2                    () { return DESC_SEDE_2                    ;    }
   public String getDESC_IMPIANTO_SEDE_2           () { return DESC_IMPIANTO_SEDE_2           ;    }
   public String getDESC_COMUNE_SEDE_2             () { return DESC_COMUNE_SEDE_2             ;    }
   public String getDESC_PROVINCIA_SEDE_2          () { return DESC_PROVINCIA_SEDE_2          ;    }
   public String getDESC_DTRT_SEDE_2               () { return DESC_DTRT_SEDE_2               ;    }
   public String getDESC_CENTRALE_SEDE_2           () { return DESC_CENTRALE_SEDE_2           ;    }    
   public int    eMODIFICATO                       () { return MODIFICATO                     ;    }
   public String    getINSERITO                      () { return INSERITO               ; }

   public void setTAB                            ( String value ) { TAB                            = value;  }
   public void setPROD                           ( String value ) { PROD                           = value;  }
   public void setCOMPO                          ( String value ) { COMPO                          = value;  }
   public void setPREST_AGG                      ( String value ) { PREST_AGG                      = value;  }
   public void setCODE_INVENT                    ( String value ) { CODE_INVENT                    = value;  }
   public void setDESC_NUM_ORDINE_CLIENTE        ( String value ) { DESC_NUM_ORDINE_CLIENTE        = value;  }
   public void setDESC_NUM_ORDINE_CLIENTE_CESSAZ ( String value ) { DESC_NUM_ORDINE_CLIENTE_CESSAZ = value;  }
   public void setDESC_FLUSSO_TERMINAZ           ( String value ) { DESC_FLUSSO_TERMINAZ           = value;  }
   public void setDESC_TIPO_RETE                 ( String value ) { DESC_TIPO_RETE                 = value;  }
   public void setDESC_SEDE_1                    ( String value ) { DESC_SEDE_1                    = value;  }
   public void setDESC_IMPIANTO_SEDE_1           ( String value ) { DESC_IMPIANTO_SEDE_1           = value;  }
   public void setDESC_COMUNE_SEDE_1             ( String value ) { DESC_COMUNE_SEDE_1             = value;  }
   public void setDESC_PROVINCIA_SEDE_1          ( String value ) { DESC_PROVINCIA_SEDE_1          = value;  }
   public void setDESC_DTRT_SEDE_1               ( String value ) { DESC_DTRT_SEDE_1               = value;  }
   public void setDESC_CENTRALE_SEDE_1           ( String value ) { DESC_CENTRALE_SEDE_1           = value;  }
   public void setDESC_SEDE_2                    ( String value ) { DESC_SEDE_2                    = value;  }
   public void setDESC_IMPIANTO_SEDE_2           ( String value ) { DESC_IMPIANTO_SEDE_2           = value;  }
   public void setDESC_COMUNE_SEDE_2             ( String value ) { DESC_COMUNE_SEDE_2             = value;  }
   public void setDESC_PROVINCIA_SEDE_2          ( String value ) { DESC_PROVINCIA_SEDE_2          = value;  }
   public void setDESC_DTRT_SEDE_2               ( String value ) { DESC_DTRT_SEDE_2               = value;  }
   public void setDESC_CENTRALE_SEDE_2           ( String value ) { DESC_CENTRALE_SEDE_2           = value;  }  
   public void Modifica                          ()               {  MODIFICATO           = 1; }    
   public void annullaModifica                   ()               { MODIFICATO            = 0; }    
  public void setINSERITO                          (String value)               { INSERITO               = value;      }    
}