package com.filter;

import com.ejbSTL.ResultRefuseIav;
import com.ejbSTL.TypeFlussoIav;
import com.ejbSTL.impl.VisualizzaOrdiniAcqIAVBean;

import com.model.ValorPathModel;

import com.service.ReportService;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;

import com.utl.CustomException;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.IOException;


import java.rmi.RemoteException;

import java.sql.SQLException;

import java.io.*;

import java.net.URL;


import java.util.Vector;

public class VisualizzaOrdiniAcqIAV {

    public Vector<TypeFlussoIav> listOrdiniAcqIav = new Vector<TypeFlussoIav>();
    private VisualizzaOrdiniAcqIAVBean ordAcq;
    private ReportService reportService;
    public Vector<TypeFlussoIav> listServiziIav = new Vector<TypeFlussoIav>();
    public String pathDownload = "";

    public VisualizzaOrdiniAcqIAV() {
        ordAcq = new VisualizzaOrdiniAcqIAVBean();
    }
    
    public Vector<TypeFlussoIav> getListaFlussi() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listOrdiniAcqIav = ordAcq.getListaFlussi();
        
        return listOrdiniAcqIav;
    }
       
    public String getNameFluxFromCode(String code) throws SQLException,
                                                          RemoteException {
        return ordAcq.getNameFluxFromCode(code);
    }
    public Vector<TypeFlussoIav> getListaOperatori() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listOrdiniAcqIav = ordAcq.getListaOperatori();
        
        return listOrdiniAcqIav;
    }
    
    public Vector<TypeFlussoIav> getListaServizi() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listServiziIav = ordAcq.getListaServizi();
        
        return listServiziIav;
    }
    
    public Vector<ResultRefuseIav> getResultFromFilter(String code, String startDate, String endDate, String area,String serviziIav, String operatoreIav) throws SQLException,
                                                                              RemoteException {
        return ordAcq.getTableFromFluxCode(code, startDate, endDate, area,serviziIav,operatoreIav);
    }
    

    public static void downloadUsingStream(String path, String file) throws IOException{
        
        try{
                

                String  urlStr ="file:///"+path+"\\"+file;
                URL url = new URL(urlStr);
                BufferedInputStream bis = new BufferedInputStream(url.openStream());
                FileOutputStream fis = new FileOutputStream(file);
                byte[] buffer = new byte[1024];
                int count=0;
                while((count = bis.read(buffer,0,1024)) != -1)
                {
                    fis.write(buffer, 0, count);
                }
                fis.close();
                bis.close();
                
                //JOptionPane.showMessageDialog(null, "Download eseguito con successo!", "InfoWindow", JOptionPane.INFORMATION_MESSAGE);
               
        }catch (IOException e) {
        
                System.out.println(e);
                //JOptionPane.showMessageDialog(null, "Errore Download File!", "InfoWindow", JOptionPane.ERROR_MESSAGE);
                
            }
        
      
        
    }
    
    public String getPathDownload() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        pathDownload = ordAcq.getPathJPUB2Download();
        
        return pathDownload;
    }
    
    
    
    public String generateFileCSVFromFluxName(String[] listName, String startDate, String endDate, String code, String area) throws RemoteException,
                                                                                 SQLException {
                  
           String pathFileZip = "";
           
            ValorPathModel model = ordAcq.getInfoFromType("SI");
            
            try{
                    for(int i = 0; i < listName.length; i++){
                        String fileName = listName[i];
                        Vector<ResultRefuseIav> results = new Vector<ResultRefuseIav>();
                        results = ordAcq.getAllFieldsFromFileName(fileName, code, startDate, endDate, area );
                        writeFileCSV(fileName, results, model, area, code);
                    }

                    String nameFileZip = code + model.getExtFile();

                    generateZipFile(listName, model.getPathStorico(), model.getPathZip(), nameFileZip,area);
                    
                    pathFileZip = model.getPathZip() + code + model.getExtFile();
               
                    //JOptionPane.showMessageDialog(null, "Download eseguito con successo!", "InfoWindow", JOptionPane.INFORMATION_MESSAGE);
                   
            }catch (Exception e) {
            
                    System.out.println(e);
                    //JOptionPane.showMessageDialog(null, "Errore Download File!", "InfoWindow", JOptionPane.ERROR_MESSAGE);
                    
                }
                
                return pathFileZip;
        }

    public int generateZipFile(String[] strElencoFile,String pathFile,
                                          String pathZipFile,String nomeFileZip,String area) throws Exception {
    
       for(int i = 0; i < strElencoFile.length; i++){
           strElencoFile[i] = strElencoFile[i].trim();
           strElencoFile[i] = strElencoFile[i] + ".csv";
             //strElencoFile[i] = strElencoFile[i] +"- ACQ " + area+ ".csv";
       }
    
        return reportService.generateZipFileByArray(strElencoFile, pathFile, pathZipFile, nomeFileZip);
                                              
    }

        
    public void writeFileCSV(String fileName, Vector<ResultRefuseIav> queryData, ValorPathModel model, String area, String code){
        if(queryData != null){
        
            PrintWriter pw = null;
            
            System.out.println("AREA:"  + area);
        
            try{
                
                pw = new PrintWriter(new File(model.getPathStorico() + fileName.trim() + ".csv"));
                
                if(area.equals("STAG")){
                    if(code.equals("ASS_MEN")){
                        pw.write( getHeadForAssuranceCSV() );
                    } else if (code.equals("ASS_TRI")){
                        pw.write( getHeadForAssuranceCSV() );
                    }else if (code.equals( "IFV_BTS")){
                        pw.write( getHeadForProvisioningStagingCSV() );
                    }else if (code.equals("IFV_ULL")){
                        pw.write( getHeadForProvisioningStagingCSV() );
                    }else if (code.equals("IFV_PRO")){
                        pw.write( getHeadForProvisioningStagingOPERACSV() );
                   }else {
                        pw.write( getHeadForProvisioningStagingCSV() );
                    }
                } else {
                    if(code.equals("ASS_MEN")){
                       pw.write(getHeadForAssuranceInteracciaCSV());
                    } else if (code.equals("ASS_TRI")){
                        pw.write(getHeadForAssuranceInteracciaCSV());
                    }else if (code.equals( "IFV_BTS")){
                        pw.write(getHeadForProvisioningInteracciaCSV());
                    }else if (code.equals("IFV_ULL")){
                        pw.write(getHeadForProvisioningInteracciaCSV());
                    }else if (code.equals("IFV_PRO")){
                        pw.write(getHeadForProvisioningInteracciaOPERACSV());
                    }else {
                        pw.write(getHeadForProvisioningInteracciaCSV());
                    }
                }
                
                
                pw.write( "\n" );
                
            }catch(FileNotFoundException e){
                e.printStackTrace();
            }
        
            for(int i = 0; i < queryData.size(); i++){
            
                ResultRefuseIav item = queryData.get(i);
                
                if(area.equals("STAG")){
                    if(code.equals("ASS_MEN")){
                        pw.write( getResultForAssuranceStaginCSV(item) );
                    } else if (code.equals("ASS_TRI")){
                        pw.write( getResultForAssuranceStaginCSV(item) );
                    }else if (code.equals( "IFV_BTS")){
                        pw.write(getResultForProvisioningStagingCSV(item));
                    }else if (code.equals("IFV_ULL")){
                        pw.write(getResultForProvisioningStagingCSV(item));
                    }else if (code.equals("IFV_PRO")){
                        pw.write(getResultForProvisioningStagingOPERACSV(item));
                    }else {
                        pw.write(getResultForProvisioningStagingCSV(item));
                    }
                } else {
                    if(code.equals("ASS_MEN")){
                        pw.write(getResultForAssuranceInterfacciaCSV(item));
                    } else if (code.equals("ASS_TRI")){
                        pw.write(getResultForAssuranceInterfacciaCSV(item));
                    }else if (code.equals( "IFV_BTS")){
                        pw.write(getResultForProvisioningInterfacciaCSV(item));
                    }else if (code.equals("IFV_ULL")){
                        pw.write(getResultForProvisioningInterfacciaCSV(item));
                    }else if (code.equals("IFV_PRO")){
                        pw.write(getResultForProvisioningInterfacciaOPERACSV(item));
                    }else {
                        pw.write(getResultForProvisioningInterfacciaCSV(item));
                    }
                }
                            
               
                
                pw.write( "\n" );
            }
            
            pw.close();
        }
    }
    
    
    
    public String getHeadForAssuranceCSV(){
        
        String header = "NOME_FILE; DATA_ACQUISIZIONE; ID_FLUSSO; PROGRESSIVO_RIGA; IDENTIFICATIVOTT; ID_IDENTIFICATIVO_TT; TIPOSERVIZIO; SERVIZIO_EROGATO; TIPOTICKETOLO;"
        + " OGGETTO_SEGNALATO; RISCONTRO; DATAORAINIZIOSEGN; DATAORAFINEDISSERVIZIO; CHIUSURATT_TTMWEB; NOMEOLO; CODICEFONTE;"
        + " DESCCAUSACHIUSURAOLO; CLASSIFICAZIONE_TECNICA; COMPETENZA_CHIUSURA; ANNO_CHIUSURA; MESE_CHIUSURA; RISCONTRATI_AUTORIPR; REMOTO_ON_FIELD;"
        + " CODICE_IMPRESA; DESCRIZIONE_IMPRESA; ADDR_CIRCUITINFO; ADDR_CUST; LOCATIONDESC; TECHASSIGNED; DATA_CREAZIONE_WR; COMPCANDATETIME";
        
        return header;   
    }
    
    public String getHeadForProvisioningStagingCSV(){
        
        String header = "NOME_FILE; DATA_ACQUISIZIONE; ID_FLUSSO; PROGRESSIVO_RIGA; CODICE_OLO; NOME_RAG_SOC_GEST; CODICE_CAUSALE_OLO; DESCRIZIONE_CAUSALE_OLO"
              + "; CODICE_PROGETTO; CODICE_ORDINE_OLO; STATO_AGGR; CARATTERISTICA; VIA_OLO; PARTICELLAOLO; CIVICOOLO; COMUNE; LOCALITA_OLO; PROV; IDRISORSA; CODICE_RICHULL_TI"
              + "; DESC_IMPRESA; MITTENTE; CARATTERISTICA; TIPO_SERVIZIO; TIPOLOGIA; CODICE_CAUSALE_SOSP_OLO; DATA_INIZIO_SOSPENSIONE; DATA_FINE_SOSPENSIONE"
              + "; DATA_RICEZIONE_ORDINE; CODICE_CAUSALE; DESCRIZIONE_CAUSALE; DATA_ULTIMA_MODIFICA_ORDINE; DATA_CHIUSURA; FLAG_NPD; FL_MOS_MOI"
              + "; DESC_IMPRESA; MITTENTE; TIPOLOGIA; CODICE_CAUSALE_SOSP_OLO; DATA_FINE_SOSPENSIONE; DATA_INIZIO_SOSPENSIONE; DATA_INVIO_NOTIFICA_SOSP; DESCRIZIONE_CAUSALE_SOSP_OLO"
              + "; COGNOME_REF; EMAIL_REF; FAX_REF; MOBILE_REF; NOME_REF; QUALIFICA_REFERENTE";
        
        return header;
        
    }
    
    public String getHeadForProvisioningStagingOPERACSV(){
        
        String header = "NOME_FILE; DATA_ACQUISIZIONE; ID_FLUSSO; PROGRESSIVO_RIGA; CODICE_OLO; NOME_RAG_SOC_GEST; CODICE_CAUSALE_OLO; DESCRIZIONE_CAUSALE_OLO"
              + "; CODICE_PROGETTO; CODICE_ORDINE_OLO; STATO_AGGR; CARATTERISTICA; VIA_OLO; PARTICELLAOLO; CIVICOOLO; COMUNE; LOCALITA_OLO; PROV; IDRISORSA; CODICE_RICHULL_TI"
              + "; DESC_IMPRESA; MITTENTE; CARATTERISTICA; TIPO_SERVIZIO; TIPOLOGIA; CODICE_CAUSALE_SOSP_OLO; DATA_INIZIO_SOSPENSIONE; DATA_FINE_SOSPENSIONE"
              + "; DATA_RICEZIONE_ORDINE; CODICE_CAUSALE; DESCRIZIONE_CAUSALE; DATA_ULTIMA_MODIFICA_ORDINE; DATA_CHIUSURA; FLAG_NPD; FL_MOS_MOI"
              + "; DESC_IMPRESA; MITTENTE; TIPOLOGIA; CODICE_CAUSALE_SOSP_OLO; DATA_FINE_SOSPENSIONE; DATA_INIZIO_SOSPENSIONE; DATA_INVIO_NOTIFICA_SOSP; DESCRIZIONE_CAUSALE_SOSP_OLO"
              + "; COGNOME_REF; EMAIL_REF; FAX_REF; MOBILE_REF; NOME_REF; QUALIFICA_REFERENTE"
              + ";VERIFICA_IV_REF;CHIAMATA_IV_REF;PIN_IV_REF"
              + ";INDICATORE_IV_REF;INDICATORE_IV_REF_DATI;INDICATORE_IV_REF_FONIA";
        
        return header;
        
    }    
    
    public String getHeadForAssuranceInteracciaCSV(){
        String header = "CODE_ITRF_FAT_XDSL; CODE_RICH_XDSL_TI; DESC_ID_RISORSA; CODE_TIPO_PREST; CODE_PREST_AGG; CODE_CAUS_XDSL; CODE_TIPO_CAUS_VARIAZ; CODE_COMUNE;" + 
           "DATA_DRO; DATA_DVTC; DATA_DEST; CODE_STATO_PS_XDSL; CODE_PS_FATT; DATA_ACQ_CHIUS; CODE_CONTR; TIPO_FLAG_ACQ_RICH; CODE_AREA_RACCOLTA; CODE_GEST; SERVIZIO_IAV;" + 
           "NOME_FILE; ID_FLUSSO; PROGRESSIVO_RIGA; IDENTIFICATIVOTT; ID_IDENTIFICATIVO_TT; TIPOSERVIZIO; SERVIZIO_EROGATO; TIPOTICKETOLO; OGGETTO_SEGNALATO; RISCONTRO; DATAORAINIZIOSEGN; DATAORAFINEDISSERVIZIO;" +
           "CHIUSURATT_TTMWEB; NOMEOLO; CODICEFONTE; DESCCAUSACHIUSURAOLO; CLASSIFICAZIONE_TECNICA; COMPETENZA_CHIUSURA; ANNO_CHIUSURA; MESE_CHIUSURA; RISCONTRATI_AUTORIPR; REMOTO_ON_FIELD; CODICE_IMPRESA;" + 
           "DESCRIZIONE_IMPRESA; ADDR_CIRCUITINFO; ADDR_CUST; LOCATIONDESC; TECHASSIGNED; DATA_CREAZIONE_WR; COMPCANDATETIME";
        
        return header;
    }
    
    public String getHeadForProvisioningInteracciaCSV(){
        String header = "CODE_ITRF_FAT_XDSL; CODE_RICH_XDSL_TI; DESC_ID_RISORSA; CODE_TIPO_PREST; CODE_PREST_AGG; CODE_CAUS_XDSL; CODE_TIPO_CAUS_VARIAZ; CODE_COMUNE;" + 
           "DATA_DRO; DATA_DVTC; DATA_DEST; CODE_STATO_PS_XDSL; CODE_PS_FATT; DATA_ACQ_CHIUS; CODE_CONTR; TIPO_FLAG_ACQ_RICH; CODE_AREA_RACCOLTA; CODE_GEST; SERVIZIO_IAV;" + 
           "NOME_FILE; ID_FLUSSO;"+
           
           "PROGRESSIVO_RIGA; CODICE_OLO; NOME_RAG_SOC_GEST; CODICE_ORDINE_OLO; IDRISORSA; CODICE_RICHULL_TI; CODICE_CAUSALE_OLO;" +
           "DESCRIZIONE_CAUSALE_OLO; CARATTERISTICA; DATA_ULTIMA_MODIFICA_ORDINE; VIA_OLO; PARTICELLAOLO; LOCALITA_OLO;" +
           "PROV; DESC_IMPRESA; MITTENTE; TIPOLOGIA; CODICE_CAUSALE_SOSP_OLO; DATA_INIZIO_SOSPENSIONE; DATA_FINE_SOSPENSIONE;" +
           "DATA_CHIUSURA; FLAG_NPD; COGNOME_REF; EMAIL_REF; FAX_REF; MOBILE_REF; NOME_REF; QUALIFICA_REFERENTE;";
        
        return header;
    }

    public String getHeadForProvisioningInteracciaOPERACSV(){
        String header = "CODE_ITRF_FAT_XDSL; CODE_RICH_XDSL_TI; DESC_ID_RISORSA; CODE_TIPO_PREST; CODE_PREST_AGG; CODE_CAUS_XDSL; CODE_TIPO_CAUS_VARIAZ; CODE_COMUNE;" + 
           "DATA_DRO; DATA_DVTC; DATA_DEST; CODE_STATO_PS_XDSL; CODE_PS_FATT; DATA_ACQ_CHIUS; CODE_CONTR; TIPO_FLAG_ACQ_RICH; CODE_AREA_RACCOLTA; CODE_GEST; SERVIZIO_IAV;" + 
           "NOME_FILE; ID_FLUSSO;"+
           
           "PROGRESSIVO_RIGA; CODICE_OLO; NOME_RAG_SOC_GEST; CODICE_ORDINE_OLO; IDRISORSA; CODICE_RICHULL_TI; CODICE_CAUSALE_OLO;" +
           "DESCRIZIONE_CAUSALE_OLO; CARATTERISTICA; DATA_ULTIMA_MODIFICA_ORDINE; VIA_OLO; PARTICELLAOLO; LOCALITA_OLO;" +
           "PROV; DESC_IMPRESA; MITTENTE; TIPOLOGIA; CODICE_CAUSALE_SOSP_OLO; DATA_INIZIO_SOSPENSIONE; DATA_FINE_SOSPENSIONE;" +
           "DATA_CHIUSURA; FLAG_NPD; COGNOME_REF; EMAIL_REF; FAX_REF; MOBILE_REF; NOME_REF; QUALIFICA_REFERENTE; FLAG_REFERENTE; VERIFICA_4_REF; CHIAMATA_4_REF; PIN_4_REF; INDICATORE_4_REF";
        
        return header;
    }


    public String getResultForProvisioningInterfacciaOPERACSV(ResultRefuseIav item){
       
        StringBuilder builder = new StringBuilder();
       
       builder.append(item.getCodeItrfFatXdsl() + ";");
       builder.append(item.getCodeRichXdslTi() + ";");
       builder.append(item.getDescIdRisorsa() + ";");
       builder.append(item.getCodeTipoPrest() + ";");
       builder.append(item.getCodePrestAgg()  + ";");
       builder.append(item.getCodeCausXdsl() + ";");
       builder.append(item.getCodeTipoCausVariaz() + ";");
       builder.append(item.getCodeComune() + ";");
       builder.append(item.getDataDro() + ";");
       builder.append(item.getDataDvct() + ";");
       builder.append(item.getDataDest() + ";");
       builder.append(item.getCodeStatoPsXdsl() + ";");
       builder.append(item.getCodePsFatt() +";");
       builder.append(item.getDataAcqChius() + ";");
       builder.append(item.getCodeContr() + ";");
       builder.append(item.getTipoFlashAcqRich() + ";");
       builder.append(item.getCodeAreaRaccolta() + ";");
       builder.append(item.getCodeGest() + ";");
       builder.append(item.getServizioIav() + ";");
       builder.append(item.getNameFile() + ";");
       builder.append(item.getIdFlusso() + ";");
       
        builder.append(item.getProgressivoRiga() + ";");
        builder.append(item.getCodiceOlo() + ";");
        builder.append(item.getNomeRagSocGest() + ";");
        builder.append(item.getCodiceOrdineOlo() + ";");
        builder.append(item.getIdRisorsa() + ";");
        builder.append(item.getCodiceRichullTi() + ";");
        builder.append(item.getCodiceCausaleOlo() + ";");
        builder.append(item.getDescrizioneCausaleOlo() + ";");
        builder.append(item.getCaratteristica() + ";");
        builder.append(item.getDataUltimaModificaOrdine() + ";");
        builder.append(item.getViaOlo() + ";");
        builder.append(item.getParticellaOlo() + ";");
        builder.append(item.getLocalitaOlo() + ";");
        builder.append(item.getProv() + ";");
        builder.append(item.getDescImpresa() + ";");
        builder.append(item.getMittente() +";");
        builder.append(item.getTipologia() + ";");
        builder.append(item.getCodiceCausaleSospOlo() + ";");
        builder.append(item.getDataInizioSospensione() + ";");
        builder.append(item.getDataFineSospensione() + ";");
        builder.append(item.getDataChiusura() + ";");
        builder.append(item.getFlagNpd() + ";");
        builder.append(item.getCognomeRef() + ";");
        builder.append(item.getEmailRef()  + ";");
        builder.append(item.getFaxRef() + ";");
        builder.append(item.getMobileRef() + ";");
        builder.append(item.getNomeRef() + ";");
        builder.append(item.getQualificaReferente() + ";");

        builder.append(item.getFlagReferente() + ";");
        builder.append(item.getVerifica4Ref() + ";");
        builder.append(item.getChiamata4Ref() + ";");
        builder.append(item.getPin4Ref() + ";");
        builder.append(item.getIndicatore4Ref() + ";");

        return builder.toString();

    }

    
    public String getResultForProvisioningInterfacciaCSV(ResultRefuseIav item){
       
        StringBuilder builder = new StringBuilder();
       
       builder.append(item.getCodeItrfFatXdsl() + ";");
       builder.append(item.getCodeRichXdslTi() + ";");
       builder.append(item.getDescIdRisorsa() + ";");
       builder.append(item.getCodeTipoPrest() + ";");
       builder.append(item.getCodePrestAgg()  + ";");
       builder.append(item.getCodeCausXdsl() + ";");
       builder.append(item.getCodeTipoCausVariaz() + ";");
       builder.append(item.getCodeComune() + ";");
       builder.append(item.getDataDro() + ";");
       builder.append(item.getDataDvct() + ";");
       builder.append(item.getDataDest() + ";");
       builder.append(item.getCodeStatoPsXdsl() + ";");
       builder.append(item.getCodePsFatt() +";");
       builder.append(item.getDataAcqChius() + ";");
       builder.append(item.getCodeContr() + ";");
       builder.append(item.getTipoFlashAcqRich() + ";");
       builder.append(item.getCodeAreaRaccolta() + ";");
       builder.append(item.getCodeGest() + ";");
       builder.append(item.getServizioIav() + ";");
       builder.append(item.getNameFile() + ";");
       builder.append(item.getIdFlusso() + ";");
       
        builder.append(item.getProgressivoRiga() + ";");
        builder.append(item.getCodiceOlo() + ";");
        builder.append(item.getNomeRagSocGest() + ";");
        builder.append(item.getCodiceOrdineOlo() + ";");
        builder.append(item.getIdRisorsa() + ";");
        builder.append(item.getCodiceRichullTi() + ";");
        builder.append(item.getCodiceCausaleOlo() + ";");
        builder.append(item.getDescrizioneCausaleOlo() + ";");
        builder.append(item.getCaratteristica() + ";");
        builder.append(item.getDataUltimaModificaOrdine() + ";");
        builder.append(item.getViaOlo() + ";");
        builder.append(item.getParticellaOlo() + ";");
        builder.append(item.getLocalitaOlo() + ";");
        builder.append(item.getProv() + ";");
        builder.append(item.getDescImpresa() + ";");
        builder.append(item.getMittente() +";");
        builder.append(item.getTipologia() + ";");
        builder.append(item.getCodiceCausaleSospOlo() + ";");
        builder.append(item.getDataInizioSospensione() + ";");
        builder.append(item.getDataFineSospensione() + ";");
        builder.append(item.getDataChiusura() + ";");
        builder.append(item.getFlagNpd() + ";");
        builder.append(item.getCognomeRef() + ";");
        builder.append(item.getEmailRef()  + ";");
        builder.append(item.getFaxRef() + ";");
        builder.append(item.getMobileRef() + ";");
        builder.append(item.getNomeRef() + ";");
        builder.append(item.getQualificaReferente() + ";");
        
        return builder.toString();

    }
    
    public String getResultForAssuranceInterfacciaCSV(ResultRefuseIav item){
       
        StringBuilder builder = new StringBuilder();
       
       builder.append(item.getCodeItrfFatXdsl() + ";");
       builder.append(item.getCodeRichXdslTi() + ";");
       builder.append(item.getDescIdRisorsa() + ";");
       builder.append(item.getCodeTipoPrest() + ";");
       builder.append(item.getCodePrestAgg()  + ";");
       builder.append(item.getCodeCausXdsl() + ";");
       builder.append(item.getCodeTipoCausVariaz() + ";");
       builder.append(item.getCodeComune() + ";");
       builder.append(item.getDataDro() + ";");
       builder.append(item.getDataDvct() + ";");
       builder.append(item.getDataDest() + ";");
       builder.append(item.getCodeStatoPsXdsl() + ";");
       builder.append(item.getCodePsFatt() +";");
       builder.append(item.getDataAcqChius() + ";");
       builder.append(item.getCodeContr() + ";");
       builder.append(item.getTipoFlashAcqRich() + ";");
       builder.append(item.getCodeAreaRaccolta() + ";");
       builder.append(item.getCodeGest() + ";");
       builder.append(item.getServizioIav() + ";");
       builder.append(item.getNameFile() + ";");
       builder.append(item.getIdFlusso() + ";");
       builder.append(item.getProgressivoRiga() + ";");
       builder.append(item.getIdentificativoTT() + ";");
       builder.append(item.getIdIdentificativoTT() + ";");
       builder.append(item.getTipoServizio() + ";");
       builder.append(item.getServizioErogato() + ";");
       builder.append(item.getTipoTicketOlo() + ";");
       builder.append(item.getOggettoSegnalato() + ";");
       builder.append(item.getRiscontro() + ";");
       builder.append(item.getDataOraInizioSegn() + ";");
       builder.append(item.getDataOraFineServizio() + ";");
       builder.append(item.getChiusuraTTTTMWeb() + ";");
       builder.append(item.getNomeOlo() + ";");
       builder.append(item.getCodiceFonte() + ";");
       builder.append(item.getDescCausaChiusuraOlo() + ";");
       builder.append(item.getClassificazioneTecnica() + ";");
       builder.append(item.getCompetenzaChiusura() + ";");
       builder.append(item.getAnnoChiusura() + ";");
       builder.append(item.getMeseChiusura() + ";");
       builder.append(item.getRiscontratiAutorip() + ";");
       builder.append(item.getRemotoOnField() + ";");
       builder.append(item.getCodiceImpresa() + ";");
       builder.append(item.getDescImpresa() + ";");
       builder.append(item.getAddCircuitInfo() + ";");
       builder.append(item.getAddrCust() + ";");
       builder.append(item.getLocationDesc() + ";");
       builder.append(item.getTechAssigned() + ";");
       builder.append(item.getDataCreazioneWr() + ";");
       builder.append(item.getCompCandaDateTime() + ";");
       /*builder.append(item.getStatoErrore() + ";");
       builder.append(item.getCodeErrrore() + ";");
       builder.append(item.getDescrizioneErrore() + ";");*/
       
        
        return builder.toString();

    }
    
    public String getResultForAssuranceStaginCSV(ResultRefuseIav item){
        
        StringBuilder builder = new StringBuilder();
        
        builder.append( item.getNameFile() + ";");
        builder.append( item.getDataAcquisizione() + ";");
        builder.append( item.getIdFlusso() + ";");
        builder.append( item.getProgressivoRiga() + ";");
        builder.append( item.getIdentificativoTT() + ";");
        builder.append( item.getIdIdentificativoTT() + ";");
        builder.append( item.getTipoServizio() + ";");
        builder.append( item.getServizioErogato() + ";");
        builder.append( item.getTipoTicketOlo() + ";");
        
        builder.append( item.getOggettoSegnalato() + ";");
        builder.append( item.getRiscontro() + ";");
        builder.append( item.getDataOraInizioSegn() + ";");
        builder.append( item.getDataOraFineServizio() + ";");
        builder.append( item.getChiusuraTTTTMWeb() + ";");

        builder.append( item.getNomeOlo() + ";");
        builder.append( item.getCodiceFonte() + ";");
        builder.append( item.getDescCausaChiusuraOlo() + ";");
        builder.append( item.getClassificazioneTecnica() + ";");
        builder.append( item.getCompetenzaChiusura() + ";");
        builder.append( item.getAnnoChiusura() + ";");
        builder.append( item.getMeseChiusura() + ";");
        builder.append( item.getRiscontratiAutorip() + ";");
        builder.append( item.getRemotoOnField() + ";");
        builder.append( item.getCodiceImpresa() + ";");
        builder.append( item.getDescrizioneImpresa() + ";");
        builder.append( item.getAddCircuitInfo() + ";");
        builder.append( item.getAddrCust() + ";");
        builder.append( item.getLocationDesc() + ";");
        builder.append( item.getTechAssigned() + ";");
        builder.append( item.getDataCreazioneWr() + ";");
        builder.append( item.getCompCandaDateTime() + ";");
        
        /*builder.append(item.getStatoErrore() + ";");
        builder.append(item.getCodeErrrore() + ";");
        builder.append(item.getDescrizioneErrore() + ";");*/
        
        return builder.toString();
    }
    
    
    public String getResultForProvisioningStagingOPERACSV(ResultRefuseIav item){
        
        StringBuilder builder = new StringBuilder();
            
         builder.append(item.getNameFile() + ";");
         builder.append(item.getDataAcquisizione() + ";");
         builder.append(item.getIdFlusso() + ";");
         builder.append(item.getProgressivoRiga() + ";");
         builder.append(item.getCodiceOlo() + ";");
         builder.append(item.getNomeRagSocGest() + ";");
         builder.append(item.getCodiceCausaleOlo() + ";");
         builder.append(item.getDescrizioneCausale() + ";");
         builder.append(item.getCodiceProgetto() + ";");
         builder.append(item.getCodiceOrdineOlo() + ";");
         builder.append(item.getStatoAggr() + ";");
         builder.append(item.getCaratteristica() + ";");
         builder.append(item.getViaOlo() + ";");
         builder.append(item.getParticellaOlo() + ";");
         builder.append(item.getCivicoOlo() + ";");
         builder.append(item.getComune() + ";");
         builder.append(item.getLocalitaOlo() + ";");
         builder.append(item.getProv() + ";");
         builder.append(item.getIdRisorsa() + ";");
         builder.append(item.getCodiceRichullTi() + ";");
         builder.append(item.getDescImpresa() + ";");
         builder.append(item.getMittente() +";");
         builder.append(item.getCaratteristica() + ";");
         builder.append(item.getTipoServizio() + ";");
         builder.append(item.getTipologia() + ";");
         builder.append(item.getCodiceCausaleSospOlo() + ";");
         builder.append(item.getDataInizioSospensione() + ";");
         builder.append(item.getDataFineSospensione() + ";");
         builder.append(item.getDataRicezioneOrdine() + ";");
         builder.append(item.getCodiceCausale() + ";");
         builder.append(item.getDescrizioneCausale() + ";");
         builder.append(item.getDataUltimaModificaOrdine() + ";");
         builder.append(item.getDataChiusura() + ";");
         builder.append(item.getFlagNpd() + ";");
         builder.append(item.getCognomeRef() + ";");
         builder.append(item.getEmailRef()  + ";");
         builder.append(item.getFaxRef() + ";");
         builder.append(item.getMobileRef() + ";");
         builder.append(item.getNomeRef() + ";");
         builder.append(item.getQualificaReferente() + ";");

        builder.append(item.getFlagReferente() + ";");
        builder.append(item.getVerifica4Ref() + ";");
        builder.append(item.getChiamata4Ref() + ";");
        builder.append(item.getPin4Ref() + ";");
        builder.append(item.getIndicatore4Ref() + ";");

       /* builder.append(item.getStatoErrore() + ";");
        builder.append(item.getCodeErrrore() + ";");
        builder.append(item.getDescrizioneErrore() + ";");*/
        
        return builder.toString();

    }
    
    public String getResultForProvisioningStagingCSV(ResultRefuseIav item){
        
        StringBuilder builder = new StringBuilder();
            
         builder.append(item.getNameFile() + ";");
         builder.append(item.getDataAcquisizione() + ";");
         builder.append(item.getIdFlusso() + ";");
         builder.append(item.getProgressivoRiga() + ";");
         builder.append(item.getCodiceOlo() + ";");
         builder.append(item.getNomeRagSocGest() + ";");
         builder.append(item.getCodiceCausaleOlo() + ";");
         builder.append(item.getDescrizioneCausale() + ";");
         builder.append(item.getCodiceProgetto() + ";");
         builder.append(item.getCodiceOrdineOlo() + ";");
         builder.append(item.getStatoAggr() + ";");
         builder.append(item.getCaratteristica() + ";");
         builder.append(item.getViaOlo() + ";");
         builder.append(item.getParticellaOlo() + ";");
         builder.append(item.getCivicoOlo() + ";");
         builder.append(item.getComune() + ";");
         builder.append(item.getLocalitaOlo() + ";");
         builder.append(item.getProv() + ";");
         builder.append(item.getIdRisorsa() + ";");
         builder.append(item.getCodiceRichullTi() + ";");
         builder.append(item.getDescImpresa() + ";");
         builder.append(item.getMittente() +";");
         builder.append(item.getCaratteristica() + ";");
         builder.append(item.getTipoServizio() + ";");
         builder.append(item.getTipologia() + ";");
         builder.append(item.getCodiceCausaleSospOlo() + ";");
         builder.append(item.getDataInizioSospensione() + ";");
         builder.append(item.getDataFineSospensione() + ";");
         builder.append(item.getDataRicezioneOrdine() + ";");
         builder.append(item.getCodiceCausale() + ";");
         builder.append(item.getDescrizioneCausale() + ";");
         builder.append(item.getDataUltimaModificaOrdine() + ";");
         builder.append(item.getDataChiusura() + ";");
         builder.append(item.getFlagNpd() + ";");
         builder.append(item.getCognomeRef() + ";");
         builder.append(item.getEmailRef()  + ";");
         builder.append(item.getFaxRef() + ";");
         builder.append(item.getMobileRef() + ";");
         builder.append(item.getNomeRef() + ";");
         builder.append(item.getQualificaReferente() + ";");

       /* builder.append(item.getStatoErrore() + ";");
        builder.append(item.getCodeErrrore() + ";");
        builder.append(item.getDescrizioneErrore() + ";");*/
        
        return builder.toString();

    }
        
   
    
}
