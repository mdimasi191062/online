package com.ejbSTL;

import java.io.Serializable;

public class ResultRefuseIav implements Serializable{

    private String nameFile;
    private String nameFlow; 
    private String dataAcquisizione;
    private String idFlusso;
    private String progressivoRiga;
    private String identificativoTT;
    private String idIdentificativoTT;
    private String tipoServizio; 
    private String codiceServizio;     
    private String verificaIvRef;
    private String chiamataIvRef;
    private String fisso;
    private String pinIvRef;
    private String indicatoreIvRef;
    private String indicatoreIvRefDati;
    private String indicatoreIvRefFonia;
    private String servizioErogato;
    private String tipoTicketOlo;
    private String oggettoSegnalato;
    private String riscontro;
    private String dataOraInizioSegn;
    private String dataOraFineServizio;
    private String chiusuraTTTTMWeb;
    private String nomeOlo;
    private String codiceFonte;
    private String descCausaChiusuraOlo;
    private String classificazioneTecnica;
    private String competenzaChiusura;
    private String annoChiusura;
    private String meseChiusura;
    private String riscontratiAutorip;
    private String remotoOnField;
    private String codiceImpresa;
    private String descrizioneImpresa;
    private String addCircuitInfo;
    private String addrCust;
    private String locationDesc;
    private String techAssigned;
    private String dataCreazioneWr;
    private String compCandaDateTime;
    private String motivoScarti;
    
    
    //FOR STAGING PROVISIONING
    private String codiceOlo;
    private String nomeRagSocGest;
    private String statoAggr;
    private String codiceCausaleOlo;
    private String descrizioneCausaleOlo;
    private String codiceProgetto;
    private String codiceOrdineOlo;
    private String caratteristica;
    private String viaOlo;
    private String particellaOlo;
    private String civicoOlo;
    private String comune;
    private String localitaOlo;
    private String prov;
    private String idRisorsa;
    private String codiceRichullTi;
    private String dataRicezioneOrdine;
    private String codiceCausale;
    private String descrizioneCausale;
    private String dataUltimaModificaOrdine;
    private String flagNpd;
    private String dataInvioNotificaSosp;
    private String cognomeRef;
    private String emailRef;
    private String faxRef;
    private String fissoRef;
    private String mobileRef;
    private String nomeRef;
    private String qualificaReferente;
    private String dro;
    private String dno;
    //private String particella;
    //private String via;
    //private String civico;
    //private String localita;
    private String dataChiusura;
    private String flMosMoi;
    private String descImpresa;
    private String mittente;
    private String tipologia;
    private String codiceCausaleSospOlo;
    private String dataInizioSospensione;
    private String dataFineSospensione;
    private String descrizioneCausaleSospOlo;
    private String cognome;
    private String mobile;
    private String qualifaReferente;
    
    
    //FOR INTERFACCIA ASSURANCE
    private String codeItrfFatXdsl;
    private String codeRichXdslTi;
    private String descIdRisorsa;
    private String codeTipoPrest;
    private String codePrestAgg;
    private String codeCausXdsl;
    private String codeTipoCausVariaz;
    private String codeComune;
    private String dataDro;
    private String dataDvct;
    private String dataDest;
    private String codeStatoPsXdsl;
    private String codePsFatt;
    private String dataAcqChius;
    private String codeContr;
    private String TipoFlashAcqRich;
    private String codeAreaRaccolta;
    private String codeGest;
    private String servizioIav;
    //private String nomeFile;
    private String nome;    
    private String flagReferente;
    private String statoErrore;
    private String codeErrrore;
    private String descrizioneErrore;
    private String countOK;
    private String countKO;
    

    private String verifica4Ref;
    private String chiamata4Ref;
    private String indicatore4Ref;
    private String pin4Ref;

    private String indicatore4RefFonia;
    private String indicatore4RefDati;

    
    private String typology;

    public ResultRefuseIav() {
    nameFile = null;
    nameFlow = null;
    countOK = null;
    countKO = null;
    }

    public void setNameFile(String nameFile) {
        this.nameFile = nameFile;
    }

    public String getNameFile() {
        return nameFile;
    }

  
    public void setNameFlow(String nameFlow) {
        this.nameFlow = nameFlow;
    }

    public String getNameFlow() {
        return nameFlow;
    }

    public void setCountOK(String countOK) {
        this.countOK = countOK;
    }

    public String getCountOK() {
        return countOK;
    }

    public void setCountKO(String countKO) {
        this.countKO = countKO;
    }

    public String getCountKO() {
        return countKO;
    }

    public void setDataAcquisizione(String dataAcquisizione) {
        this.dataAcquisizione = dataAcquisizione;
    }

    public String getDataAcquisizione() {
        return dataAcquisizione;
    }

    public void setIdFlusso(String idFlusso) {
        this.idFlusso = idFlusso;
    }

    public String getIdFlusso() {
        return idFlusso;
    }

    public void setProgressivoRiga(String progressivoRiga) {
        this.progressivoRiga = progressivoRiga;
    }

    public String getProgressivoRiga() {
        return progressivoRiga;
    }

    public void setIdentificativoTT(String identificativoTT) {
        this.identificativoTT = identificativoTT;
    }

    public String getIdentificativoTT() {
        return identificativoTT;
    }

    public void setIdIdentificativoTT(String idIdentificativoTT) {
        this.idIdentificativoTT = idIdentificativoTT;
    }

    public String getIdIdentificativoTT() {
        return idIdentificativoTT;
    }

    public void setTipoServizio(String tipoServizio) {
        this.tipoServizio = tipoServizio;
    }

    public String getTipoServizio() {
        return tipoServizio;
    }

    public void setServizioErogato(String servizioErogato) {
        this.servizioErogato = servizioErogato;
    }

    public String getServizioErogato() {
        return servizioErogato;
    }

    public void setTipoTicketOlo(String tipoTicketOlo) {
        this.tipoTicketOlo = tipoTicketOlo;
    }

    public String getTipoTicketOlo() {
        return tipoTicketOlo;
    }

    public void setOggettoSegnalato(String oggettoSegnalato) {
        this.oggettoSegnalato = oggettoSegnalato;
    }

    public String getOggettoSegnalato() {
        return oggettoSegnalato;
    }

    public void setRiscontro(String riscontro) {
        this.riscontro = riscontro;
    }

    public String getRiscontro() {
        return riscontro;
    }

    public void setDataOraInizioSegn(String dataOraInizioSegn) {
        this.dataOraInizioSegn = dataOraInizioSegn;
    }

    public String getDataOraInizioSegn() {
        return dataOraInizioSegn;
    }

    public void setDataOraFineServizio(String dataOraFineServizio) {
        this.dataOraFineServizio = dataOraFineServizio;
    }

    public String getDataOraFineServizio() {
        return dataOraFineServizio;
    }

    public void setChiusuraTTTTMWeb(String chiusuraTTTTMWeb) {
        this.chiusuraTTTTMWeb = chiusuraTTTTMWeb;
    }

    public String getChiusuraTTTTMWeb() {
        return chiusuraTTTTMWeb;
    }

    public void setNomeOlo(String nomeOlo) {
        this.nomeOlo = nomeOlo;
    }

    public String getNomeOlo() {
        return nomeOlo;
    }

    public void setCodiceFonte(String codiceFonte) {
        this.codiceFonte = codiceFonte;
    }

    public String getCodiceFonte() {
        return codiceFonte;
    }

    public void setDescCausaChiusuraOlo(String descCausaChiusuraOlo) {
        this.descCausaChiusuraOlo = descCausaChiusuraOlo;
    }

    public String getDescCausaChiusuraOlo() {
        return descCausaChiusuraOlo;
    }

    public void setClassificazioneTecnica(String classificazioneTecnica) {
        this.classificazioneTecnica = classificazioneTecnica;
    }

    public String getClassificazioneTecnica() {
        return classificazioneTecnica;
    }

    public void setCompetenzaChiusura(String competenzaChiusura) {
        this.competenzaChiusura = competenzaChiusura;
    }

    public String getCompetenzaChiusura() {
        return competenzaChiusura;
    }

    public void setAnnoChiusura(String annoChiusura) {
        this.annoChiusura = annoChiusura;
    }

    public String getAnnoChiusura() {
        return annoChiusura;
    }

    public void setMeseChiusura(String meseChiusura) {
        this.meseChiusura = meseChiusura;
    }

    public String getMeseChiusura() {
        return meseChiusura;
    }

    public void setRiscontratiAutorip(String riscontratiAutorip) {
        this.riscontratiAutorip = riscontratiAutorip;
    }

    public String getRiscontratiAutorip() {
        return riscontratiAutorip;
    }

    public void setRemotoOnField(String remotoOnField) {
        this.remotoOnField = remotoOnField;
    }

    public String getRemotoOnField() {
        return remotoOnField;
    }

    public void setCodiceImpresa(String codiceImpresa) {
        this.codiceImpresa = codiceImpresa;
    }

    public String getCodiceImpresa() {
        return codiceImpresa;
    }

    public void setDescrizioneImpresa(String descrizioneImpresa) {
        this.descrizioneImpresa = descrizioneImpresa;
    }

    public String getDescrizioneImpresa() {
        return descrizioneImpresa;
    }

    public void setAddCircuitInfo(String addCircuitInfo) {
        this.addCircuitInfo = addCircuitInfo;
    }

    public String getAddCircuitInfo() {
        return addCircuitInfo;
    }

    public void setAddrCust(String addrCust) {
        this.addrCust = addrCust;
    }

    public String getAddrCust() {
        return addrCust;
    }

    public void setLocationDesc(String locationDesc) {
        this.locationDesc = locationDesc;
    }

    public String getLocationDesc() {
        return locationDesc;
    }

    public void setTechAssigned(String techAssigned) {
        this.techAssigned = techAssigned;
    }

    public String getTechAssigned() {
        return techAssigned;
    }

    public void setDataCreazioneWr(String dataCreazioneWr) {
        this.dataCreazioneWr = dataCreazioneWr;
    }

    public String getDataCreazioneWr() {
        return dataCreazioneWr;
    }

    public void setCompCandaDateTime(String compCandaDateTime) {
        this.compCandaDateTime = compCandaDateTime;
    }

    public String getCompCandaDateTime() {
        return compCandaDateTime;
    }

    public void setStatoErrore(String statoErrore) {
        this.statoErrore = statoErrore;
    }

    public String getStatoErrore() {
        return statoErrore;
    }

    public void setCodeErrrore(String codeErrrore) {
        this.codeErrrore = codeErrrore;
    }

    public String getCodeErrrore() {
        return codeErrrore;
    }

    public void setDescrizioneErrore(String descrizioneErrore) {
        this.descrizioneErrore = descrizioneErrore;
    }

    public String getDescrizioneErrore() {
        return descrizioneErrore;
    }

    public void setTypology(String typology) {
        this.typology = typology;
    }

    public String getTypology() {
        return typology;
    }

    public void setCodiceOlo(String codiceOlo) {
        this.codiceOlo = codiceOlo;
    }

    public String getCodiceOlo() {
        return codiceOlo;
    }

    public void setNomeRagSocGest(String nomeRagSocGest) {
        this.nomeRagSocGest = nomeRagSocGest;
    }

    public String getNomeRagSocGest() {
        return nomeRagSocGest;
    }

    public void setCodiceOrdineOlo(String codiceOrdineOlo) {
        this.codiceOrdineOlo = codiceOrdineOlo;
    }

    public String getCodiceOrdineOlo() {
        return codiceOrdineOlo;
    }

    public void setStatoAggr(String statoAggr) {
        this.statoAggr = statoAggr;
    }

    public String getStatoAggr() {
        return statoAggr;
    }

    public void setCodiceCausaleOlo(String codiceCausaleOlo) {
        this.codiceCausaleOlo = codiceCausaleOlo;
    }

    public String getCodiceCausaleOlo() {
        return codiceCausaleOlo;
    }

    public void setDescrizioneCausaleOlo(String descrizioneCausaleOlo) {
        this.descrizioneCausaleOlo = descrizioneCausaleOlo;
    }

    public String getDescrizioneCausaleOlo() {
        return descrizioneCausaleOlo;
    }

    public void setDro(String dro) {
        this.dro = dro;
    }

    public String getDro() {
        return dro;
    }

    public void setIdRisorsa(String idRisorsa) {
        this.idRisorsa = idRisorsa;
    }

    public String getIdRisorsa() {
        return idRisorsa;
    }

    public void setDno(String dno) {
        this.dno = dno;
    }

    public String getDno() {
        return dno;
    }

/*    public void setParticella(String particella) {
        this.particella = particella;
    }

    public String getParticella() {
        return particella;
    }

    public void setVia(String via) {
        this.via = via;
    }

    public String getVia() {
        return via;
    }

    public void setCivico(String civico) {
        this.civico = civico;
    }

    public String getCivico() {
        return civico;
    }

    public void setLocalita(String localita) {
        this.localita = localita;
    }

    public String getLocalita() {
        return localita;
    }
*/
    public void setFlagNpd(String flagNpd) {
        this.flagNpd = flagNpd;
    }

    public String getFlagNpd() {
        return flagNpd;
    }

    public void setDataChiusura(String dataChiusura) {
        this.dataChiusura = dataChiusura;
    }

    public String getDataChiusura() {
        return dataChiusura;
    }

    public void setFlMosMoi(String flMosMoi) {
        this.flMosMoi = flMosMoi;
    }

    public String getFlMosMoi() {
        return flMosMoi;
    }

    public void setDescImpresa(String descImpresa) {
        this.descImpresa = descImpresa;
    }

    public String getDescImpresa() {
        return descImpresa;
    }

    public void setMittente(String mittente) {
        this.mittente = mittente;
    }

    public String getMittente() {
        return mittente;
    }

    public void setCaratteristica(String caratteristica) {
        this.caratteristica = caratteristica;
    }

    public String getCaratteristica() {
        return caratteristica;
    }

    public void setTipologia(String tipologia) {
        this.tipologia = tipologia;
    }

    public String getTipologia() {
        return tipologia;
    }

    public void setCodiceCausaleSospOlo(String codiceCausaleSospOlo) {
        this.codiceCausaleSospOlo = codiceCausaleSospOlo;
    }

    public String getCodiceCausaleSospOlo() {
        return codiceCausaleSospOlo;
    }

    public void setDataInizioSospensione(String dataInizioSospensione) {
        this.dataInizioSospensione = dataInizioSospensione;
    }

    public String getDataInizioSospensione() {
        return dataInizioSospensione;
    }

    public void setDataFineSospensione(String dataFineSospensione) {
        this.dataFineSospensione = dataFineSospensione;
    }

    public String getDataFineSospensione() {
        return dataFineSospensione;
    }

    public void setDescrizioneCausaleSospOlo(String descrizioneCausaleSospOlo) {
        this.descrizioneCausaleSospOlo = descrizioneCausaleSospOlo;
    }

    public String getDescrizioneCausaleSospOlo() {
        return descrizioneCausaleSospOlo;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getCognome() {
        return cognome;
    }

    public void setFisso(String fisso) {
        this.fisso = fisso;
    }

    public String getFisso() {
        return fisso;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getMobile() {
        return mobile;
    }

    public void setQualifaReferente(String qualifaReferente) {
        this.qualifaReferente = qualifaReferente;
    }

    public String getQualifaReferente() {
        return qualifaReferente;
    }
    
    public void setCodiceProgetto(String codiceProgetto) {
        this.codiceProgetto = codiceProgetto;
    }

    public String getCodiceProgetto() {
        return codiceProgetto;
    }

    public void setViaOlo(String viaOlo) {
        this.viaOlo = viaOlo;
    }

    public String getViaOlo() {
        return viaOlo;
    }

    public void setParticellaOlo(String particellaOlo) {
        this.particellaOlo = particellaOlo;
    }

    public String getParticellaOlo() {
        return particellaOlo;
    }

    public void setCivicoOlo(String civicoOlo) {
        this.civicoOlo = civicoOlo;
    }

    public String getCivicoOlo() {
        return civicoOlo;
    }

    public void setComune(String comune) {
        this.comune = comune;
    }

    public String getComune() {
        return comune;
    }

    public void setLocalitaOlo(String localitaOlo) {
        this.localitaOlo = localitaOlo;
    }

    public String getLocalitaOlo() {
        return localitaOlo;
    }

    public void setProv(String prov) {
        this.prov = prov;
    }

    public String getProv() {
        return prov;
    }

    public void setCodiceRichullTi(String codiceRichullTi) {
        this.codiceRichullTi = codiceRichullTi;
    }

    public String getCodiceRichullTi() {
        return codiceRichullTi;
    }

    public void setDataRicezioneOrdine(String dataRicezioneOrdine) {
        this.dataRicezioneOrdine = dataRicezioneOrdine;
    }

    public String getDataRicezioneOrdine() {
        return dataRicezioneOrdine;
    }

    public void setCodiceCausale(String codiceCausale) {
        this.codiceCausale = codiceCausale;
    }

    public String getCodiceCausale() {
        return codiceCausale;
    }

    public void setDescrizioneCausale(String descrizioneCausale) {
        this.descrizioneCausale = descrizioneCausale;
    }

    public String getDescrizioneCausale() {
        return descrizioneCausale;
    }

    public void setDataUltimaModificaOrdine(String dataUltimaModificaOrdine) {
        this.dataUltimaModificaOrdine = dataUltimaModificaOrdine;
    }

    public String getDataUltimaModificaOrdine() {
        return dataUltimaModificaOrdine;
    }

    public void setDataInvioNotificaSosp(String dataInvioNotificaSosp) {
        this.dataInvioNotificaSosp = dataInvioNotificaSosp;
    }

    public String getDataInvioNotificaSosp() {
        return dataInvioNotificaSosp;
    }

    public void setCognomeRef(String cognomeRef) {
        this.cognomeRef = cognomeRef;
    }

    public String getCognomeRef() {
        return cognomeRef;
    }

    public void setEmailRef(String emailRef) {
        this.emailRef = emailRef;
    }

    public String getEmailRef() {
        return emailRef;
    }

    public void setFaxRef(String faxRef) {
        this.faxRef = faxRef;
    }

    public String getFaxRef() {
        return faxRef;
    }

    public void setFissoRef(String fissoRef) {
        this.fissoRef = fissoRef;
    }

    public String getFissoRef() {
        return fissoRef;
    }

    public void setMobileRef(String mobileRef) {
        this.mobileRef = mobileRef;
    }

    public String getMobileRef() {
        return mobileRef;
    }

    public void setNomeRef(String nomeRef) {
        this.nomeRef = nomeRef;
    }

    public String getNomeRef() {
        return nomeRef;
    }

    public void setQualificaReferente(String qualificaReferente) {
        this.qualificaReferente = qualificaReferente;
    }

    public String getQualificaReferente() {
        return qualificaReferente;
    }


    public void setCodeItrfFatXdsl(String codeItrfFatXdsl) {
        this.codeItrfFatXdsl = codeItrfFatXdsl;
    }

    public String getCodeItrfFatXdsl() {
        return codeItrfFatXdsl;
    }

    public void setCodeRichXdslTi(String codeRichXdslTi) {
        this.codeRichXdslTi = codeRichXdslTi;
    }

    public String getCodeRichXdslTi() {
        return codeRichXdslTi;
    }

    public void setDescIdRisorsa(String descIdRisorsa) {
        this.descIdRisorsa = descIdRisorsa;
    }

    public String getDescIdRisorsa() {
        return descIdRisorsa;
    }

    public void setCodeTipoPrest(String codeTipoPrest) {
        this.codeTipoPrest = codeTipoPrest;
    }

    public String getCodeTipoPrest() {
        return codeTipoPrest;
    }

    public void setCodePrestAgg(String codePrestAgg) {
        this.codePrestAgg = codePrestAgg;
    }

    public String getCodePrestAgg() {
        return codePrestAgg;
    }

    public void setCodeCausXdsl(String codeCausXdsl) {
        this.codeCausXdsl = codeCausXdsl;
    }

    public String getCodeCausXdsl() {
        return codeCausXdsl;
    }

    public void setCodeTipoCausVariaz(String codeTipoCausVariaz) {
        this.codeTipoCausVariaz = codeTipoCausVariaz;
    }

    public String getCodeTipoCausVariaz() {
        return codeTipoCausVariaz;
    }

    public void setCodeComune(String codeComune) {
        this.codeComune = codeComune;
    }

    public String getCodeComune() {
        return codeComune;
    }

    public void setDataDro(String dataDro) {
        this.dataDro = dataDro;
    }

    public String getDataDro() {
        return dataDro;
    }

    public void setDataDvct(String dataDvct) {
        this.dataDvct = dataDvct;
    }

    public String getDataDvct() {
        return dataDvct;
    }

    public void setDataDest(String dataDest) {
        this.dataDest = dataDest;
    }

    public String getDataDest() {
        return dataDest;
    }

    public void setCodeStatoPsXdsl(String codeStatoPsXdsl) {
        this.codeStatoPsXdsl = codeStatoPsXdsl;
    }

    public String getCodeStatoPsXdsl() {
        return codeStatoPsXdsl;
    }

    public void setCodePsFatt(String codePsFatt) {
        this.codePsFatt = codePsFatt;
    }

    public String getCodePsFatt() {
        return codePsFatt;
    }

    public void setDataAcqChius(String dataAcqChius) {
        this.dataAcqChius = dataAcqChius;
    }

    public String getDataAcqChius() {
        return dataAcqChius;
    }

    public void setCodeContr(String codeContr) {
        this.codeContr = codeContr;
    }

    public String getCodeContr() {
        return codeContr;
    }

    public void setTipoFlashAcqRich(String tipoFlashAcqRich) {
        this.TipoFlashAcqRich = tipoFlashAcqRich;
    }

    public String getTipoFlashAcqRich() {
        return TipoFlashAcqRich;
    }

    public void setCodeAreaRaccolta(String codeAreaRaccolta) {
        this.codeAreaRaccolta = codeAreaRaccolta;
    }

    public String getCodeAreaRaccolta() {
        return codeAreaRaccolta;
    }

    public void setCodeGest(String codeGest) {
        this.codeGest = codeGest;
    }

    public String getCodeGest() {
        return codeGest;
    }

    public void setServizioIav(String servizioIav) {
        this.servizioIav = servizioIav;
    }

    public String getServizioIav() {
        return servizioIav;
    }

/*    public void setNomeFile(String nomeFile) {
        this.nomeFile = nomeFile;
    }

    public String getNomeFile() {
        return nomeFile;
    }*/

    public void setMotivoScarti(String motivoScarti) {
        this.motivoScarti = motivoScarti;
    }

    public String getMotivoScarti() {
        return motivoScarti;
    }

    public void setCodiceServizio(String codiceServizio) {
        this.codiceServizio = codiceServizio;
    }

    public String getCodiceServizio() {
        return codiceServizio;
    }

    public void setVerificaIvRef(String verificaIvRef) {
        this.verificaIvRef = verificaIvRef;
    }

    public String getVerificaIvRef() {
        return verificaIvRef;
    }

    public void setChiamataIvRef(String chiamataIvRef) {
        this.chiamataIvRef = chiamataIvRef;
    }

    public String getChiamataIvRef() {
        return chiamataIvRef;
    }

    public void setPinIvRef(String pinIvRef) {
        this.pinIvRef = pinIvRef;
    }

    public String getPinIvRef() {
        return pinIvRef;
    }

    public void setIndicatoreIvRef(String indicatoreIvRef) {
        this.indicatoreIvRef = indicatoreIvRef;
    }

    public String getIndicatoreIvRef() {
        return indicatoreIvRef;
    }

    public void setIndicatoreIvRefDati(String indicatoreIvRefDati) {
        this.indicatoreIvRefDati = indicatoreIvRefDati;
    }

    public String getIndicatoreIvRefDati() {
        return indicatoreIvRefDati;
    }

    public void setIndicatoreIvRefFonia(String indicatoreIvRefFonia) {
        this.indicatoreIvRefFonia = indicatoreIvRefFonia;
    }

    public String getIndicatoreIvRefFonia() {
        return indicatoreIvRefFonia;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getNome() {
        return nome;
    }

    public void setFlagReferente(String flagReferente) {
        this.flagReferente = flagReferente;
    }

    public String getFlagReferente() {
        return flagReferente;
    }

    public void setVerifica4Ref(String verifica4Ref) {
        this.verifica4Ref = verifica4Ref;
    }

    public String getVerifica4Ref() {
        return verifica4Ref;
    }

    public void setChiamata4Ref(String chiamata4Ref) {
        this.chiamata4Ref = chiamata4Ref;
    }

    public String getChiamata4Ref() {
        return chiamata4Ref;
    }

    public void setIndicatore4Ref(String indicatore4Ref) {
        this.indicatore4Ref = indicatore4Ref;
    }

    public String getIndicatore4Ref() {
        return indicatore4Ref;
    }

    public void setPin4Ref(String pin4Ref) {
        this.pin4Ref = pin4Ref;
    }

    public String getPin4Ref() {
        return pin4Ref;
    }

    public void setIndicatore4RefFonia(String indicatore4RefFonia) {
        this.indicatore4RefFonia = indicatore4RefFonia;
    }

    public String getIndicatore4RefFonia() {
        return indicatore4RefFonia;
    }

    public void setIndicatore4RefDati(String indicatore4RefDati) {
        this.indicatore4RefDati = indicatore4RefDati;
    }

    public String getIndicatore4RefDati() {
        return indicatore4RefDati;
    }
}
