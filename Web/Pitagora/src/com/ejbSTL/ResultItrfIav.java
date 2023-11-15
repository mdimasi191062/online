package com.ejbSTL;

import java.io.Serializable;

public class ResultItrfIav implements Serializable{

      private String flowName;
      private String CODE_ITRF_FAT_XDSL;
      private String CODE_RICH_XDSL_TI;           
      private String DESC_ID_RISORSA;             
      private String CODE_TIPO_PREST;             
      private String CODE_PREST_AGG;              
      private String CODE_CAUS_XDSL;              
      private String CODE_TIPO_CAUS_VARIAZ;       
      private String CODE_COMUNE;                 
      private String DATA_DRO;                    
      private String DATA_DVTC;                   
      private String DATA_DEST;                   
      private String CODE_STATO_PS_XDSL;          
      private String CODE_PS_FATT;                
      private String DATA_ACQ_CHIUS;
      private String CODE_CONTR;                  
      private String TIPO_FLAG_ACQ_RICH;          
      private String CODE_AREA_RACCOLTA;          
      private String CODE_GEST;                   
      private String SERVIZIO_IAV;                
      private String NOME_FILE;                   
      private String ID_FLUSSO;                   
      private String PROGRESSIVO_RIGA;            
      private String CODICE_OLO;                  
      private String NOME_RAG_SOC_GEST;           
      private String CODICE_ORDINE_OLO;           
      private String STATO;                       
      private String IDRISORSA;                   
      private String CODICE_RICHULL_TI;           
      private String CODICE_CAUSALE_OLO;          
      private String DESCRIZIONE_CAUSALE_OLO;     
      private String CODICE_PROGETTO;             
      private String STATO_AGGR;                  
      private String CARATTERISTICA;              
      private String DATA_ULTIMA_MODIFICA_ORDINE; 
      private String VIA_OLO;                     
      private String UTENZA_PRIMARIA;             
      private String PARTICELLAOLO;               
      private String CIVICOOLO;                   
      private String CODICE_CAUSALE_SOSP_OLO;     
      private String COMUNE;                      
      private String LOCALITA_OLO;                
      private String PROV;                        
      private String DATA_CHIUSURA;               
      private String DATA_RICEZIONE_ORDINE;       
      private String FLAG_NPD;                    
      private String CODICE_CAUSALE;              
      private String DESCRIZIONE_CAUSALE;         
      private String FL_MOS_MOI;                  
      private String DESC_IMPRESA;                
      private String TIPO_SERVIZIO;               
      private String MITTENTE;                    
      private String TIPOLOGIA;                   
      private String DATA_FINE_SOSPENSIONE;       
      private String DATA_INIZIO_SOSPENSIONE;     
      private String DATA_INVIO_NOTIFICA_SOSP;    
      private String DESCRIZIONE_CAUSALE_SOSP_OLO;
      private String COGNOME_REF;                 
      private String EMAIL_REF;                   
      private String FAX_REF;                     
      private String FISSO_REF;                   
      private String MOBILE_REF;                  
      private String NOME_REF;                    
      private String QUALIFICA_REFERENTE;     
      private String IDENTIFICATIVOTT;             
      private String ID_IDENTIFICATIVO_TT;         
      private String TIPOSERVIZIO;                 
      private String SERVIZIO_EROGATO;             
      private String TIPOTICKETOLO;                
      private String OGGETTO_SEGNALATO;            
      private String RISCONTRO;                    
      private String DATAORAINIZIOSEGN;            
      private String DATAORAFINEDISSERVIZIO;       
      private String CHIUSURATT_TTMWEB;            
      private String NOMEOLO;                      
      private String CODICEFONTE;                  
      private String DESCCAUSACHIUSURAOLO;         
      private String CLASSIFICAZIONE_TECNICA;      
      private String COMPETENZA_CHIUSURA;          
      private String ANNO_CHIUSURA;                
      private String MESE_CHIUSURA;                
      private String RISCONTRATI_AUTORIPR;         
      private String REMOTO_ON_FIELD;              
      private String CODICE_IMPRESA;               
      private String DESCRIZIONE_IMPRESA;          
      private String ADDR_CIRCUITINFO;             
      private String ADDR_CUST;                    
      private String LOCATIONDESC;                 
      private String TECHASSIGNED;                 
      private String DATA_CREAZIONE_WR;            
      private String COMPCANDATETIME;                        
      private String FLAG_REFERENTE;
      private String VERIFICA_4_REF;
      private String CHIAMATA_4_REF;
      private String PIN_4_REF;
      private String INDICATORE_4_REF;
    
    public ResultItrfIav() {
        flowName=null;
        CODE_ITRF_FAT_XDSL            =null; 
        CODE_RICH_XDSL_TI             =null;  
        DESC_ID_RISORSA               =null;  
        CODE_TIPO_PREST               =null;  
        CODE_PREST_AGG                =null;  
        CODE_CAUS_XDSL                =null;  
        CODE_TIPO_CAUS_VARIAZ         =null;  
        CODE_COMUNE                   =null;  
        DATA_DRO                      =null;  
        DATA_DVTC                     =null;  
        DATA_DEST                     =null;  
        CODE_STATO_PS_XDSL            =null;  
        CODE_PS_FATT                  =null;  
        DATA_ACQ_CHIUS                =null;  
        CODE_CONTR                    =null;  
        TIPO_FLAG_ACQ_RICH            =null;  
        CODE_AREA_RACCOLTA            =null;  
        CODE_GEST                     =null;  
        SERVIZIO_IAV                  =null;  
        NOME_FILE                     =null;  
        ID_FLUSSO                     =null;  
        PROGRESSIVO_RIGA              =null;  
        CODICE_OLO                    =null;  
        NOME_RAG_SOC_GEST             =null;  
        CODICE_ORDINE_OLO             =null;  
        STATO                         =null;  
        IDRISORSA                     =null;  
        CODICE_RICHULL_TI             =null;  
        CODICE_CAUSALE_OLO            =null;  
        DESCRIZIONE_CAUSALE_OLO       =null;  
        CODICE_PROGETTO               =null;  
        STATO_AGGR                    =null;  
        CARATTERISTICA                =null;  
        DATA_ULTIMA_MODIFICA_ORDINE   =null;  
        VIA_OLO                       =null;  
        UTENZA_PRIMARIA               =null;  
        PARTICELLAOLO                 =null;  
        CIVICOOLO                     =null;  
        CODICE_CAUSALE_SOSP_OLO       =null;  
        COMUNE                        =null;  
        LOCALITA_OLO                  =null;  
        PROV                          =null;  
        DATA_CHIUSURA                 =null;  
        DATA_RICEZIONE_ORDINE         =null;  
        FLAG_NPD                      =null;  
        CODICE_CAUSALE                =null;  
        DESCRIZIONE_CAUSALE           =null;  
        FL_MOS_MOI                    =null;  
        DESC_IMPRESA                  =null;  
        TIPO_SERVIZIO                 =null;  
        MITTENTE                      =null;  
        TIPOLOGIA                     =null;  
        DATA_FINE_SOSPENSIONE         =null;  
        DATA_INIZIO_SOSPENSIONE       =null;  
        DATA_INVIO_NOTIFICA_SOSP      =null;  
        DESCRIZIONE_CAUSALE_SOSP_OLO  =null; 
        COGNOME_REF                   =null; 
        EMAIL_REF                     =null; 
        FAX_REF                       =null; 
        FISSO_REF                     =null; 
        MOBILE_REF                    =null; 
        NOME_REF                      =null; 
        QUALIFICA_REFERENTE           =null; 
        IDENTIFICATIVOTT            =null;  
        ID_IDENTIFICATIVO_TT        =null;  
        TIPOSERVIZIO                =null;  
        SERVIZIO_EROGATO            =null;  
        TIPOTICKETOLO               =null;  
        OGGETTO_SEGNALATO           =null;  
        RISCONTRO                   =null;  
        DATAORAINIZIOSEGN           =null;  
        DATAORAFINEDISSERVIZIO      =null;  
        CHIUSURATT_TTMWEB           =null;  
        NOMEOLO                     =null;  
        CODICEFONTE                 =null;  
        DESCCAUSACHIUSURAOLO        =null;  
        CLASSIFICAZIONE_TECNICA     =null;  
        COMPETENZA_CHIUSURA         =null;  
        ANNO_CHIUSURA               =null;  
        MESE_CHIUSURA               =null;  
        RISCONTRATI_AUTORIPR        =null;  
        REMOTO_ON_FIELD             =null;  
        CODICE_IMPRESA              =null;  
        DESCRIZIONE_IMPRESA         =null;  
        ADDR_CIRCUITINFO            =null;  
        ADDR_CUST                   =null;  
        LOCATIONDESC                =null;  
        TECHASSIGNED                =null;  
        DATA_CREAZIONE_WR           =null;  
        COMPCANDATETIME             =null;  
    }


    public void setCODE_ITRF_FAT_XDSL(String cODE_ITRF_FAT_XDSL) {
        this.CODE_ITRF_FAT_XDSL = cODE_ITRF_FAT_XDSL;
    }

    public String getCODE_ITRF_FAT_XDSL() {
        return CODE_ITRF_FAT_XDSL;
    }

    public void setCODE_RICH_XDSL_TI(String cODE_RICH_XDSL_TI) {
        this.CODE_RICH_XDSL_TI = cODE_RICH_XDSL_TI;
    }

    public String getCODE_RICH_XDSL_TI() {
        return CODE_RICH_XDSL_TI;
    }

    public void setDESC_ID_RISORSA(String dESC_ID_RISORSA) {
        this.DESC_ID_RISORSA = dESC_ID_RISORSA;
    }

    public String getDESC_ID_RISORSA() {
        return DESC_ID_RISORSA;
    }

    public void setCODE_TIPO_PREST(String cODE_TIPO_PREST) {
        this.CODE_TIPO_PREST = cODE_TIPO_PREST;
    }

    public String getCODE_TIPO_PREST() {
        return CODE_TIPO_PREST;
    }

    public void setCODE_PREST_AGG(String cODE_PREST_AGG) {
        this.CODE_PREST_AGG = cODE_PREST_AGG;
    }

    public String getCODE_PREST_AGG() {
        return CODE_PREST_AGG;
    }

    public void setCODE_CAUS_XDSL(String cODE_CAUS_XDSL) {
        this.CODE_CAUS_XDSL = cODE_CAUS_XDSL;
    }

    public String getCODE_CAUS_XDSL() {
        return CODE_CAUS_XDSL;
    }

    public void setCODE_TIPO_CAUS_VARIAZ(String cODE_TIPO_CAUS_VARIAZ) {
        this.CODE_TIPO_CAUS_VARIAZ = cODE_TIPO_CAUS_VARIAZ;
    }

    public String getCODE_TIPO_CAUS_VARIAZ() {
        return CODE_TIPO_CAUS_VARIAZ;
    }

    public void setCODE_COMUNE(String cODE_COMUNE) {
        this.CODE_COMUNE = cODE_COMUNE;
    }

    public String getCODE_COMUNE() {
        return CODE_COMUNE;
    }

    public void setDATA_DRO(String dATA_DRO) {
        this.DATA_DRO = dATA_DRO;
    }

    public String getDATA_DRO() {
        return DATA_DRO;
    }

    public void setDATA_DVTC(String dATA_DVTC) {
        this.DATA_DVTC = dATA_DVTC;
    }

    public String getDATA_DVTC() {
        return DATA_DVTC;
    }

    public void setDATA_DEST(String dATA_DEST) {
        this.DATA_DEST = dATA_DEST;
    }

    public String getDATA_DEST() {
        return DATA_DEST;
    }

    public void setCODE_STATO_PS_XDSL(String cODE_STATO_PS_XDSL) {
        this.CODE_STATO_PS_XDSL = cODE_STATO_PS_XDSL;
    }

    public String getCODE_STATO_PS_XDSL() {
        return CODE_STATO_PS_XDSL;
    }

    public void setCODE_PS_FATT(String cODE_PS_FATT) {
        this.CODE_PS_FATT = cODE_PS_FATT;
    }

    public String getCODE_PS_FATT() {
        return CODE_PS_FATT;
    }

    public void setDATA_ACQ_CHIUS(String dATA_ACQ_CHIUS) {
        this.DATA_ACQ_CHIUS = dATA_ACQ_CHIUS;
    }

    public String getDATA_ACQ_CHIUS() {
        return DATA_ACQ_CHIUS;
    }

    public void setCODE_CONTR(String cODE_CONTR) {
        this.CODE_CONTR = cODE_CONTR;
    }

    public String getCODE_CONTR() {
        return CODE_CONTR;
    }

    public void setTIPO_FLAG_ACQ_RICH(String tIPO_FLAG_ACQ_RICH) {
        this.TIPO_FLAG_ACQ_RICH = tIPO_FLAG_ACQ_RICH;
    }

    public String getTIPO_FLAG_ACQ_RICH() {
        return TIPO_FLAG_ACQ_RICH;
    }

    public void setCODE_AREA_RACCOLTA(String cODE_AREA_RACCOLTA) {
        this.CODE_AREA_RACCOLTA = cODE_AREA_RACCOLTA;
    }

    public String getCODE_AREA_RACCOLTA() {
        return CODE_AREA_RACCOLTA;
    }

    public void setCODE_GEST(String cODE_GEST) {
        this.CODE_GEST = cODE_GEST;
    }

    public String getCODE_GEST() {
        return CODE_GEST;
    }

    public void setSERVIZIO_IAV(String sERVIZIO_IAV) {
        this.SERVIZIO_IAV = sERVIZIO_IAV;
    }

    public String getSERVIZIO_IAV() {
        return SERVIZIO_IAV;
    }

    public void setNOME_FILE(String nOME_FILE) {
        this.NOME_FILE = nOME_FILE;
    }

    public String getNOME_FILE() {
        return NOME_FILE;
    }

    public void setID_FLUSSO(String iD_FLUSSO) {
        this.ID_FLUSSO = iD_FLUSSO;
    }

    public String getID_FLUSSO() {
        return ID_FLUSSO;
    }

    public void setPROGRESSIVO_RIGA(String pROGRESSIVO_RIGA) {
        this.PROGRESSIVO_RIGA = pROGRESSIVO_RIGA;
    }

    public String getPROGRESSIVO_RIGA() {
        return PROGRESSIVO_RIGA;
    }

    public void setCODICE_OLO(String cODICE_OLO) {
        this.CODICE_OLO = cODICE_OLO;
    }

    public String getCODICE_OLO() {
        return CODICE_OLO;
    }

    public void setNOME_RAG_SOC_GEST(String nOME_RAG_SOC_GEST) {
        this.NOME_RAG_SOC_GEST = nOME_RAG_SOC_GEST;
    }

    public String getNOME_RAG_SOC_GEST() {
        return NOME_RAG_SOC_GEST;
    }

    public void setCODICE_ORDINE_OLO(String cODICE_ORDINE_OLO) {
        this.CODICE_ORDINE_OLO = cODICE_ORDINE_OLO;
    }

    public String getCODICE_ORDINE_OLO() {
        return CODICE_ORDINE_OLO;
    }

    public void setSTATO(String sTATO) {
        this.STATO = sTATO;
    }

    public String getSTATO() {
        return STATO;
    }

    public void setIDRISORSA(String iDRISORSA) {
        this.IDRISORSA = iDRISORSA;
    }

    public String getIDRISORSA() {
        return IDRISORSA;
    }

    public void setCODICE_RICHULL_TI(String cODICE_RICHULL_TI) {
        this.CODICE_RICHULL_TI = cODICE_RICHULL_TI;
    }

    public String getCODICE_RICHULL_TI() {
        return CODICE_RICHULL_TI;
    }

    public void setCODICE_CAUSALE_OLO(String cODICE_CAUSALE_OLO) {
        this.CODICE_CAUSALE_OLO = cODICE_CAUSALE_OLO;
    }

    public String getCODICE_CAUSALE_OLO() {
        return CODICE_CAUSALE_OLO;
    }

    public void setDESCRIZIONE_CAUSALE_OLO(String dESCRIZIONE_CAUSALE_OLO) {
        this.DESCRIZIONE_CAUSALE_OLO = dESCRIZIONE_CAUSALE_OLO;
    }

    public String getDESCRIZIONE_CAUSALE_OLO() {
        return DESCRIZIONE_CAUSALE_OLO;
    }

    public void setCODICE_PROGETTO(String cODICE_PROGETTO) {
        this.CODICE_PROGETTO = cODICE_PROGETTO;
    }

    public String getCODICE_PROGETTO() {
        return CODICE_PROGETTO;
    }

    public void setSTATO_AGGR(String sTATO_AGGR) {
        this.STATO_AGGR = sTATO_AGGR;
    }

    public String getSTATO_AGGR() {
        return STATO_AGGR;
    }
 
    public void setCARATTERISTICA(String cARATTERISTICA) {
        this.CARATTERISTICA = cARATTERISTICA;
    }

    public String getCARATTERISTICA() {
        return CARATTERISTICA;
    }

    public void setDATA_ULTIMA_MODIFICA_ORDINE(String dATA_ULTIMA_MODIFICA_ORDINE) {
        this.DATA_ULTIMA_MODIFICA_ORDINE = dATA_ULTIMA_MODIFICA_ORDINE;
    }

    public String getDATA_ULTIMA_MODIFICA_ORDINE() {
        return DATA_ULTIMA_MODIFICA_ORDINE;
    }

    public void setVIA_OLO(String vIA_OLO) {
        this.VIA_OLO = vIA_OLO;
    }

    public String getVIA_OLO() {
        return VIA_OLO;
    }

    public void setUTENZA_PRIMARIA(String uTENZA_PRIMARIA) {
        this.UTENZA_PRIMARIA = uTENZA_PRIMARIA;
    }

    public String getUTENZA_PRIMARIA() {
        return UTENZA_PRIMARIA;
    }

    public void setPARTICELLAOLO(String pARTICELLAOLO) {
        this.PARTICELLAOLO = pARTICELLAOLO;
    }

    public String getPARTICELLAOLO() {
        return PARTICELLAOLO;
    }

    public void setCIVICOOLO(String cIVICOOLO) {
        this.CIVICOOLO = cIVICOOLO;
    }

    public String getCIVICOOLO() {
        return CIVICOOLO;
    }

    public void setCODICE_CAUSALE_SOSP_OLO(String cODICE_CAUSALE_SOSP_OLO) {
        this.CODICE_CAUSALE_SOSP_OLO = cODICE_CAUSALE_SOSP_OLO;
    }

    public String getCODICE_CAUSALE_SOSP_OLO() {
        return CODICE_CAUSALE_SOSP_OLO;
    }

    public void setCOMUNE(String cOMUNE) {
        this.COMUNE = cOMUNE;
    }

    public String getCOMUNE() {
        return COMUNE;
    }

    public void setLOCALITA_OLO(String lOCALITA_OLO) {
        this.LOCALITA_OLO = lOCALITA_OLO;
    }

    public String getLOCALITA_OLO() {
        return LOCALITA_OLO;
    }

    public void setPROV(String pROV) {
        this.PROV = pROV;
    }

    public String getPROV() {
        return PROV;
    }

    public void setDATA_CHIUSURA(String dATA_CHIUSURA) {
        this.DATA_CHIUSURA = dATA_CHIUSURA;
    }

    public String getDATA_CHIUSURA() {
        return DATA_CHIUSURA;
    }

    public void setDATA_RICEZIONE_ORDINE(String dATA_RICEZIONE_ORDINE) {
        this.DATA_RICEZIONE_ORDINE = dATA_RICEZIONE_ORDINE;
    }

    public String getDATA_RICEZIONE_ORDINE() {
        return DATA_RICEZIONE_ORDINE;
    }

    public void setFLAG_NPD(String fLAG_NPD) {
        this.FLAG_NPD = fLAG_NPD;
    }

    public String getFLAG_NPD() {
        return FLAG_NPD;
    }

    public void setCODICE_CAUSALE(String cODICE_CAUSALE) {
        this.CODICE_CAUSALE = cODICE_CAUSALE;
    }

    public String getCODICE_CAUSALE() {
        return CODICE_CAUSALE;
    }

    public void setDESCRIZIONE_CAUSALE(String dESCRIZIONE_CAUSALE) {
        this.DESCRIZIONE_CAUSALE = dESCRIZIONE_CAUSALE;
    }

    public String getDESCRIZIONE_CAUSALE() {
        return DESCRIZIONE_CAUSALE;
    }

    public void setFL_MOS_MOI(String fL_MOS_MOI) {
        this.FL_MOS_MOI = fL_MOS_MOI;
    }

    public String getFL_MOS_MOI() {
        return FL_MOS_MOI;
    }

    public void setDESC_IMPRESA(String dESC_IMPRESA) {
        this.DESC_IMPRESA = dESC_IMPRESA;
    }

    public String getDESC_IMPRESA() {
        return DESC_IMPRESA;
    }

    public void setTIPO_SERVIZIO(String tIPO_SERVIZIO) {
        this.TIPO_SERVIZIO = tIPO_SERVIZIO;
    }

    public String getTIPO_SERVIZIO() {
        return TIPO_SERVIZIO;
    }

    public void setMITTENTE(String mITTENTE) {
        this.MITTENTE = mITTENTE;
    }

    public String getMITTENTE() {
        return MITTENTE;
    }

    public void setTIPOLOGIA(String tIPOLOGIA) {
        this.TIPOLOGIA = tIPOLOGIA;
    }

    public String getTIPOLOGIA() {
        return TIPOLOGIA;
    }

    public void setDATA_FINE_SOSPENSIONE(String dATA_FINE_SOSPENSIONE) {
        this.DATA_FINE_SOSPENSIONE = dATA_FINE_SOSPENSIONE;
    }

    public String getDATA_FINE_SOSPENSIONE() {
        return DATA_FINE_SOSPENSIONE;
    }

    public void setDATA_INIZIO_SOSPENSIONE(String dATA_INIZIO_SOSPENSIONE) {
        this.DATA_INIZIO_SOSPENSIONE = dATA_INIZIO_SOSPENSIONE;
    }

    public String getDATA_INIZIO_SOSPENSIONE() {
        return DATA_INIZIO_SOSPENSIONE;
    }

    public void setDATA_INVIO_NOTIFICA_SOSP(String dATA_INVIO_NOTIFICA_SOSP) {
        this.DATA_INVIO_NOTIFICA_SOSP = dATA_INVIO_NOTIFICA_SOSP;
    }

    public String getDATA_INVIO_NOTIFICA_SOSP() {
        return DATA_INVIO_NOTIFICA_SOSP;
    }

    public void setDESCRIZIONE_CAUSALE_SOSP_OLO(String dESCRIZIONE_CAUSALE_SOSP_OLO) {
        this.DESCRIZIONE_CAUSALE_SOSP_OLO = dESCRIZIONE_CAUSALE_SOSP_OLO;
    }

    public String getDESCRIZIONE_CAUSALE_SOSP_OLO() {
        return DESCRIZIONE_CAUSALE_SOSP_OLO;
    }

    public void setCOGNOME_REF(String cOGNOME_REF) {
        this.COGNOME_REF = cOGNOME_REF;
    }

    public String getCOGNOME_REF() {
        return COGNOME_REF;
    }

    public void setEMAIL_REF(String eMAIL_REF) {
        this.EMAIL_REF = eMAIL_REF;
    }

    public String getEMAIL_REF() {
        return EMAIL_REF;
    }

    public void setFAX_REF(String fAX_REF) {
        this.FAX_REF = fAX_REF;
    }

    public String getFAX_REF() {
        return FAX_REF;
    }

    public void setFISSO_REF(String fISSO_REF) {
        this.FISSO_REF = fISSO_REF;
    }

    public String getFISSO_REF() {
        return FISSO_REF;
    }

    public void setMOBILE_REF(String mOBILE_REF) {
        this.MOBILE_REF = mOBILE_REF;
    }

    public String getMOBILE_REF() {
        return MOBILE_REF;
    }

    public void setNOME_REF(String nOME_REF) {
        this.NOME_REF = nOME_REF;
    }

    public String getNOME_REF() {
        return NOME_REF;
    }

    public void setQUALIFICA_REFERENTE(String qUALIFICA_REFERENTE) {
        this.QUALIFICA_REFERENTE = qUALIFICA_REFERENTE;
    }

    public String getQUALIFICA_REFERENTE() {
        return QUALIFICA_REFERENTE;
    }
    public void setIDENTIFICATIVOTT(String iDENTIFICATIVOTT) {
        this.IDENTIFICATIVOTT = iDENTIFICATIVOTT;
    }

    public String getIDENTIFICATIVOTT() {
        return IDENTIFICATIVOTT;
    }
    
    public void setID_IDENTIFICATIVO_TT(String iD_IDENTIFICATIVO_TT) {
        this.ID_IDENTIFICATIVO_TT = iD_IDENTIFICATIVO_TT;
    }

    public String getID_IDENTIFICATIVO_TT() {
        return ID_IDENTIFICATIVO_TT;
    }

    public void setTIPOSERVIZIO(String tIPOSERVIZIO) {
        this.TIPOSERVIZIO = tIPOSERVIZIO;
    }

    public String getTIPOSERVIZIO() {
        return TIPOSERVIZIO;
    }

    public void setSERVIZIO_EROGATO(String sERVIZIO_EROGATO) {
        this.SERVIZIO_EROGATO = sERVIZIO_EROGATO;
    }

    public String getSERVIZIO_EROGATO() {
        return SERVIZIO_EROGATO;
    }

    public void setTIPOTICKETOLO(String tIPOTICKETOLO) {
        this.TIPOTICKETOLO = tIPOTICKETOLO;
    }

    public String getTIPOTICKETOLO() {
        return TIPOTICKETOLO;
    }

    public void setOGGETTO_SEGNALATO(String oGGETTO_SEGNALATO) {
        this.OGGETTO_SEGNALATO = oGGETTO_SEGNALATO;
    }

    public String getOGGETTO_SEGNALATO() {
        return OGGETTO_SEGNALATO;
    }

    public void setRISCONTRO(String rISCONTRO) {
        this.RISCONTRO = rISCONTRO;
    }

    public String getRISCONTRO() {
        return RISCONTRO;
    }

    public void setDATAORAINIZIOSEGN(String dATAORAINIZIOSEGN) {
        this.DATAORAINIZIOSEGN = dATAORAINIZIOSEGN;
    }

    public String getDATAORAINIZIOSEGN() {
        return DATAORAINIZIOSEGN;
    }

    public void setDATAORAFINEDISSERVIZIO(String dATAORAFINEDISSERVIZIO) {
        this.DATAORAFINEDISSERVIZIO = dATAORAFINEDISSERVIZIO;
    }

    public String getDATAORAFINEDISSERVIZIO() {
        return DATAORAFINEDISSERVIZIO;
    }

    public void setCHIUSURATT_TTMWEB(String cHIUSURATT_TTMWEB) {
        this.CHIUSURATT_TTMWEB = cHIUSURATT_TTMWEB;
    }

    public String getCHIUSURATT_TTMWEB() {
        return CHIUSURATT_TTMWEB;
    }

    public void setNOMEOLO(String nOMEOLO) {
        this.NOMEOLO = nOMEOLO;
    }

    public String getNOMEOLO() {
        return NOMEOLO;
    }
 
    public void setCODICEFONTE(String cODICEFONTE) {
        this.CODICEFONTE = cODICEFONTE;
    }

    public String getCODICEFONTE() {
        return CODICEFONTE;
    }

    public void setDESCCAUSACHIUSURAOLO(String dESCCAUSACHIUSURAOLO) {
        this.DESCCAUSACHIUSURAOLO = dESCCAUSACHIUSURAOLO;
    }

    public String getDESCCAUSACHIUSURAOLO() {
        return DESCCAUSACHIUSURAOLO;
    }

    public void setCLASSIFICAZIONE_TECNICA(String cLASSIFICAZIONE_TECNICA) {
        this.CLASSIFICAZIONE_TECNICA = cLASSIFICAZIONE_TECNICA;
    }

    public String getCLASSIFICAZIONE_TECNICA() {
        return CLASSIFICAZIONE_TECNICA;
    }

    public void setCOMPETENZA_CHIUSURA(String cOMPETENZA_CHIUSURA) {
        this.COMPETENZA_CHIUSURA = cOMPETENZA_CHIUSURA;
    }

    public String getCOMPETENZA_CHIUSURA() {
        return COMPETENZA_CHIUSURA;
    }

    public void setANNO_CHIUSURA(String aNNO_CHIUSURA) {
        this.ANNO_CHIUSURA = aNNO_CHIUSURA;
    }

    public String getANNO_CHIUSURA() {
        return ANNO_CHIUSURA;
    }

    public void setMESE_CHIUSURA(String mESE_CHIUSURA) {
        this.MESE_CHIUSURA = mESE_CHIUSURA;
    }

    public String getMESE_CHIUSURA() {
        return MESE_CHIUSURA;
    }

    public void setRISCONTRATI_AUTORIPR(String rISCONTRATI_AUTORIPR) {
        this.RISCONTRATI_AUTORIPR = rISCONTRATI_AUTORIPR;
    }

    public String getRISCONTRATI_AUTORIPR() {
        return RISCONTRATI_AUTORIPR;
    }

    public void setREMOTO_ON_FIELD(String rEMOTO_ON_FIELD) {
        this.REMOTO_ON_FIELD = rEMOTO_ON_FIELD;
    }

    public String getREMOTO_ON_FIELD() {
        return REMOTO_ON_FIELD;
    }

    public void setCODICE_IMPRESA(String cODICE_IMPRESA) {
        this.CODICE_IMPRESA = cODICE_IMPRESA;
    }

    public String getCODICE_IMPRESA() {
        return CODICE_IMPRESA;
    }

    public void setDESCRIZIONE_IMPRESA(String dESCRIZIONE_IMPRESA) {
        this.DESCRIZIONE_IMPRESA = dESCRIZIONE_IMPRESA;
    }

    public String getDESCRIZIONE_IMPRESA() {
        return DESCRIZIONE_IMPRESA;
    }

    public void setADDR_CIRCUITINFO(String aDDR_CIRCUITINFO) {
        this.ADDR_CIRCUITINFO = aDDR_CIRCUITINFO;
    }

    public String getADDR_CIRCUITINFO() {
        return ADDR_CIRCUITINFO;
    }

    public void setADDR_CUST(String aDDR_CUST) {
        this.ADDR_CUST = aDDR_CUST;
    }

    public String getADDR_CUST() {
        return ADDR_CUST;
    }

    public void setLOCATIONDESC(String lOCATIONDESC) {
        this.LOCATIONDESC = lOCATIONDESC;
    }

    public String getLOCATIONDESC() {
        return LOCATIONDESC;
    }

    public void setTECHASSIGNED(String tECHASSIGNED) {
        this.TECHASSIGNED = tECHASSIGNED;
    }

    public String getTECHASSIGNED() {
        return TECHASSIGNED;
    }

    public void setDATA_CREAZIONE_WR(String dATA_CREAZIONE_WR) {
        this.DATA_CREAZIONE_WR = dATA_CREAZIONE_WR;
    }

    public String getDATA_CREAZIONE_WR() {
        return DATA_CREAZIONE_WR;
    }

    public void setCOMPCANDATETIME(String cOMPCANDATETIME) {
        this.COMPCANDATETIME = cOMPCANDATETIME;
    }

    public String getCOMPCANDATETIME() {
        return COMPCANDATETIME;
    }

    public void setFlowName(String flowName) {
        this.flowName = flowName;
    }

    public String getFlowName() {
        return flowName;
    }

    public void setFLAG_REFERENTE(String fLAG_REFERENTE) {
        this.FLAG_REFERENTE = fLAG_REFERENTE;
    }

    public String getFLAG_REFERENTE() {
        return FLAG_REFERENTE;
    }

    public void setVERIFICA_4_REF(String vERIFICA_4_REF) {
        this.VERIFICA_4_REF = vERIFICA_4_REF;
    }

    public String getVERIFICA_4_REF() {
        return VERIFICA_4_REF;
    }

    public void setCHIAMATA_4_REF(String cHIAMATA_4_REF) {
        this.CHIAMATA_4_REF = cHIAMATA_4_REF;
    }

    public String getCHIAMATA_4_REF() {
        return CHIAMATA_4_REF;
    }

    public void setPIN_4_REF(String pIN_4_REF) {
        this.PIN_4_REF = pIN_4_REF;
    }

    public String getPIN_4_REF() {
        return PIN_4_REF;
    }

    public void setINDICATORE_4_REF(String iNDICATORE_4_REF) {
        this.INDICATORE_4_REF = iNDICATORE_4_REF;
    }

    public String getINDICATORE_4_REF() {
        return INDICATORE_4_REF;
    }
}
