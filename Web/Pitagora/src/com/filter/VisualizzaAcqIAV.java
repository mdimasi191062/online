package com.filter;

import com.ejbSTL.ResultRefuseIav;
import com.ejbSTL.TypeFlussoIav;
import com.ejbSTL.impl.VisualizzaAcqIAVBean;

import com.model.ValorPathModel;

import com.service.ReportService;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;

import com.utl.CustomException;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import java.net.URL;

import java.rmi.RemoteException;

import java.sql.SQLException;

import java.util.Vector;

import javax.swing.JOptionPane;

public class VisualizzaAcqIAV {

    public Vector<TypeFlussoIav> listAcqIav = new Vector<TypeFlussoIav>();
    private VisualizzaAcqIAVBean acq;
    private ReportService reportService;
    public String pathDownload="";

    public VisualizzaAcqIAV() {
        acq = new VisualizzaAcqIAVBean();
    }
    
    public Vector<TypeFlussoIav> getListaFlussi() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listAcqIav = acq.getListaFlussi();
        
        return listAcqIav;
    }
    
    public Vector<ResultRefuseIav> getResultFromFilter(String code, String startDate, String endDate, String area) throws SQLException,
                                                                              RemoteException {
        return acq.getTableFromFluxCode(code, startDate, endDate, area);
    }
    
    public String getNameFluxFromCode(String code) throws SQLException,
                                                          RemoteException {
        return acq.getNameFluxFromCode(code);
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
                
               // JOptionPane.showMessageDialog(null, "Download eseguito con successo!", "InfoWindow", JOptionPane.INFORMATION_MESSAGE);
               
        }catch (IOException e) {
        
                System.out.println(e);
               // JOptionPane.showMessageDialog(null, "Errore Download File!", "InfoWindow", JOptionPane.ERROR_MESSAGE);
                
            }
        
      
        
    }
    
    public String getPathDownload() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        pathDownload = acq.getPathJPUB2Download();
        
        return pathDownload;
    }
    
    
    
    
    public String generateFileCSVFromFluxName(String[] listName, String startDate, String endDate, String code, String area) throws RemoteException,
                                                                             SQLException {
              
       String pathFileZip = "";
       
        ValorPathModel model = acq.getInfoFromType("SI");
        
        try{
                for(int i = 0; i < listName.length; i++){
                    String fileName = listName[i];
                    Vector<ResultRefuseIav> results = new Vector<ResultRefuseIav>();
                    results = acq.getAllFieldsFromFileName(fileName, code, startDate, endDate, area );
                    writeFileCSV(fileName, results, model, area, code);
                }
                
                 String nameFileZip = code + model.getExtFile();
                
                generateZipFile(listName, model.getPathStorico(), model.getPathZip(), nameFileZip,area);
                
                pathFileZip = model.getPathZip() + code + model.getExtFile();
           
               // JOptionPane.showMessageDialog(null, "Download eseguito con successo!", "InfoWindow", JOptionPane.INFORMATION_MESSAGE);
               
        }catch (Exception e) {
        
                System.out.println(e);
               // JOptionPane.showMessageDialog(null, "Errore Download File!", "InfoWindow", JOptionPane.ERROR_MESSAGE);
                
            }
            
            return pathFileZip;
    }
    
    public int generateZipFile(String[] strElencoFile,String pathFile,
                                          String pathZipFile,String nomeFileZip,String area) throws Exception {
    
       for(int i = 0; i < strElencoFile.length; i++){
           strElencoFile[i] = strElencoFile[i].trim();
//           strElencoFile[i] = strElencoFile[i] + ".csv";
             strElencoFile[i] = strElencoFile[i] +"- ACQ " + area+ ".csv";

       }
    
    
    return reportService.generateZipFileByArray(strElencoFile, pathFile, pathZipFile, nomeFileZip);
                                              
    }
        
    public void writeFileCSV(String fileName, Vector<ResultRefuseIav> queryData, ValorPathModel model, String area, String code){
        if(queryData != null){
        
            PrintWriter pw = null;
            
            System.out.println("AREA:"  + area);
        
            try{
                
                String nameFile = fileName.trim() +"- ACQ " + area + ".csv";
                
                pw = new PrintWriter(new File(model.getPathStorico() + nameFile));
                
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
                        pw.write( getHeadForProvisioningStagingOperaCSV() );                        
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
                        pw.write(getHeadForProvisioningInteracciaOperaCSV());                        
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
                        pw.write(getResultForProvisioningStagingOperaCSV(item));                        
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
                            pw.write(getResultForProvisioningInterfacciaOperaCSV(item));                        
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
    
    public String getHeadForProvisioningStagingOperaCSV(){
        
        String header = "NOME_FILE; DATA_ACQUISIZIONE; ID_FLUSSO; PROGRESSIVO_RIGA; NOME_RAG_SOC_GEST; CODICE_OLO;CODICE_ORDINE_OLO;ID_RISORSA;TIPO_SERVIZIO;CODICE_SERVIZIO;" +
        "CODICE_PROGETTO;DRO;DATA_CHIUSURA;VIA;PARTICELLA;CIVICO;COMUNE;LOCALITA;PROV;CODICE_CAUSALE_OLO;DESCRIZIONE_CAUSALE_OLO;TIPOLOGIA;CODICE_CAUSALE_SOSP_OLO;" +
        "DESCRIZIONE_CAUSALE_SOSP_OLO;DATA_INIZIO_SOSPENSIONE;DATA_FINE_SOSPENSIONE;FLAG_REFERENTE;COGNOME;NOME;FISSO;MOBILE;VERIFICA_IV_REF;CHIAMATA_IV_REF;PIN_IV_REF;" +
        "INDICATORE_IV_REF;INDICATORE_IV_REF_DATI;INDICATORE_IV_REF_FONIA";
        
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

    public String getHeadForProvisioningInteracciaOperaCSV(){
        String header = "CODE_ITRF_FAT_XDSL; CODE_RICH_XDSL_TI; DESC_ID_RISORSA; CODE_TIPO_PREST; CODE_PREST_AGG; CODE_CAUS_XDSL; CODE_TIPO_CAUS_VARIAZ; CODE_COMUNE;" + 
           "DATA_DRO; DATA_DVTC; DATA_DEST; CODE_STATO_PS_XDSL; CODE_PS_FATT; DATA_ACQ_CHIUS; CODE_CONTR; TIPO_FLAG_ACQ_RICH; CODE_AREA_RACCOLTA; CODE_GEST; SERVIZIO_IAV;" + 
           "NOME_FILE; ID_FLUSSO;"+
           
           "PROGRESSIVO_RIGA; CODICE_OLO; NOME_RAG_SOC_GEST; CODICE_ORDINE_OLO; IDRISORSA; CODICE_RICHULL_TI; CODICE_CAUSALE_OLO;" +
           "DESCRIZIONE_CAUSALE_OLO; CARATTERISTICA; DATA_ULTIMA_MODIFICA_ORDINE; VIA_OLO; PARTICELLAOLO; LOCALITA_OLO;" +
           "PROV; DESC_IMPRESA; MITTENTE; TIPOLOGIA; CODICE_CAUSALE_SOSP_OLO; DATA_INIZIO_SOSPENSIONE; DATA_FINE_SOSPENSIONE;" +
           "DATA_CHIUSURA; FLAG_NPD; COGNOME_REF; EMAIL_REF; FAX_REF; MOBILE_REF; NOME_REF; QUALIFICA_REFERENTE; FLAG_REFERENTE; VERIFICA_4_REF; CHIAMATA_4_REF; PIN_4_REF; INDICATORE_4_REF";
        
        return header;
    }    
    public String getResultForProvisioningInterfacciaCSV(ResultRefuseIav item){
           
            StringBuilder builder = new StringBuilder();
           
           builder.append(checkString(item.getCodeItrfFatXdsl()) + ";");
           builder.append(checkString(item.getCodeRichXdslTi()) + ";");
           builder.append(checkString(item.getDescIdRisorsa()) + ";");
           builder.append(checkString(item.getCodeTipoPrest()) + ";");
           builder.append(checkString(item.getCodePrestAgg())  + ";");
           builder.append(checkString(item.getCodeCausXdsl()) + ";");
           builder.append(checkString(item.getCodeTipoCausVariaz()) + ";");
           builder.append(checkString(item.getCodeComune()) + ";");
           builder.append(checkString(item.getDataDro()) + ";");
           builder.append(checkString(item.getDataDvct()) + ";");
           builder.append(checkString(item.getDataDest()) + ";");
           builder.append(checkString(item.getCodeStatoPsXdsl()) + ";");
           builder.append(checkString(item.getCodePsFatt()) +";");
           builder.append(checkString(item.getDataAcqChius()) + ";");
           builder.append(checkString(item.getCodeContr()) + ";");
           builder.append(checkString(item.getTipoFlashAcqRich()) + ";");
           builder.append(checkString(item.getCodeAreaRaccolta()) + ";");
           builder.append(checkString(item.getCodeGest()) + ";");
           builder.append(checkString(item.getServizioIav()) + ";");
           builder.append(checkString(item.getNameFile()) + ";");
           builder.append(checkString(item.getIdFlusso()) + ";");
           
            builder.append(checkString(item.getProgressivoRiga()) + ";");
            builder.append(checkString(item.getCodiceOlo()) + ";");
            builder.append(checkString(item.getNomeRagSocGest()) + ";");
            builder.append(checkString(item.getCodiceOrdineOlo()) + ";");
            builder.append(checkString(item.getIdRisorsa()) + ";");
            builder.append(checkString(item.getCodiceRichullTi()) + ";");
            builder.append(checkString(item.getCodiceCausaleOlo()) + ";");
            builder.append(checkString(item.getDescrizioneCausale()) + ";");
            builder.append(checkString(item.getCaratteristica()) + ";");
            builder.append(checkString(item.getDataUltimaModificaOrdine()) + ";");
            builder.append(checkString(item.getViaOlo()) + ";");
            builder.append(checkString(item.getParticellaOlo()) + ";");
            builder.append(checkString(item.getLocalitaOlo()) + ";");
            builder.append(checkString(item.getProv()) + ";");
            builder.append(checkString(item.getDescImpresa()) + ";");
            builder.append(checkString(item.getMittente()) +";");
            builder.append(checkString(item.getTipologia()) + ";");
            builder.append(checkString(item.getCodiceCausaleSospOlo()) + ";");
            builder.append(checkString(item.getDataInizioSospensione()) + ";");
            builder.append(checkString(item.getDataFineSospensione()) + ";");
            builder.append(checkString(item.getDataChiusura()) + ";");
            builder.append(checkString(item.getFlagNpd()) + ";");
            builder.append(checkString(item.getCognomeRef()) + ";");
            builder.append(checkString(item.getEmailRef())  + ";");
            builder.append(checkString(item.getFaxRef()) + ";");
            builder.append(checkString(item.getMobileRef()) + ";");
            builder.append(checkString(item.getNomeRef()) + ";");
            builder.append(checkString(item.getQualificaReferente()) + ";");
            
            return builder.toString();

        }

    public String getResultForProvisioningInterfacciaOperaCSV(ResultRefuseIav item){
           
            StringBuilder builder = new StringBuilder();
           
           builder.append(checkString(item.getCodeItrfFatXdsl()) + ";");
           builder.append(checkString(item.getCodeRichXdslTi()) + ";");
           builder.append(checkString(item.getDescIdRisorsa()) + ";");
           builder.append(checkString(item.getCodeTipoPrest()) + ";");
           builder.append(checkString(item.getCodePrestAgg())  + ";");
           builder.append(checkString(item.getCodeCausXdsl()) + ";");
           builder.append(checkString(item.getCodeTipoCausVariaz()) + ";");
           builder.append(checkString(item.getCodeComune()) + ";");
           builder.append(checkString(item.getDataDro()) + ";");
           builder.append(checkString(item.getDataDvct()) + ";");
           builder.append(checkString(item.getDataDest()) + ";");
           builder.append(checkString(item.getCodeStatoPsXdsl()) + ";");
           builder.append(checkString(item.getCodePsFatt()) +";");
           builder.append(checkString(item.getDataAcqChius()) + ";");
           builder.append(checkString(item.getCodeContr()) + ";");
           builder.append(checkString(item.getTipoFlashAcqRich()) + ";");
           builder.append(checkString(item.getCodeAreaRaccolta()) + ";");
           builder.append(checkString(item.getCodeGest()) + ";");
           builder.append(checkString(item.getServizioIav()) + ";");
           builder.append(checkString(item.getNameFile()) + ";");
           builder.append(checkString(item.getIdFlusso()) + ";");
           
            builder.append(checkString(item.getProgressivoRiga()) + ";");
            builder.append(checkString(item.getCodiceOlo()) + ";");
            builder.append(checkString(item.getNomeRagSocGest()) + ";");
            builder.append(checkString(item.getCodiceOrdineOlo()) + ";");
            builder.append(checkString(item.getIdRisorsa()) + ";");
            builder.append(checkString(item.getCodiceRichullTi()) + ";");
            builder.append(checkString(item.getCodiceCausaleOlo()) + ";");
            builder.append(checkString(item.getDescrizioneCausale()) + ";");
            builder.append(checkString(item.getCaratteristica()) + ";");
            builder.append(checkString(item.getDataUltimaModificaOrdine()) + ";");
            builder.append(checkString(item.getViaOlo()) + ";");
            builder.append(checkString(item.getParticellaOlo()) + ";");
            builder.append(checkString(item.getLocalitaOlo()) + ";");
            builder.append(checkString(item.getProv()) + ";");
            builder.append(checkString(item.getDescImpresa()) + ";");
            builder.append(checkString(item.getMittente()) +";");
            builder.append(checkString(item.getTipologia()) + ";");
            builder.append(checkString(item.getCodiceCausaleSospOlo()) + ";");
            builder.append(checkString(item.getDataInizioSospensione()) + ";");
            builder.append(checkString(item.getDataFineSospensione()) + ";");
            builder.append(checkString(item.getDataChiusura()) + ";");
            builder.append(checkString(item.getFlagNpd()) + ";");
            builder.append(checkString(item.getCognomeRef()) + ";");
            builder.append(checkString(item.getEmailRef())  + ";");
            builder.append(checkString(item.getFaxRef()) + ";");
            builder.append(checkString(item.getMobileRef()) + ";");
            builder.append(checkString(item.getNomeRef()) + ";");
            builder.append(checkString(item.getQualificaReferente()) + ";");
            builder.append(checkString(item.getFlagReferente()) + ";");
            builder.append(checkString(item.getVerifica4Ref()) + ";");
            builder.append(checkString(item.getChiamata4Ref()) + ";");
            builder.append(checkString(item.getPin4Ref()) + ";");
            builder.append(checkString(item.getIndicatore4Ref()) + ";");
            return builder.toString();

        }        
        public String getResultForAssuranceInterfacciaCSV(ResultRefuseIav item){
           
            StringBuilder builder = new StringBuilder();
           
           builder.append(checkString(item.getCodeItrfFatXdsl()) + ";");
           builder.append(checkString(item.getCodeRichXdslTi()) + ";");
           builder.append(checkString(item.getDescIdRisorsa()) + ";");
           builder.append(checkString(item.getCodeTipoPrest()) + ";");
           builder.append(checkString(item.getCodePrestAgg())  + ";");
           builder.append(checkString(item.getCodeCausXdsl()) + ";");
           builder.append(checkString(item.getCodeTipoCausVariaz()) + ";");
           builder.append(checkString(item.getCodeComune()) + ";");
           builder.append(checkString(item.getDataDro()) + ";");
           builder.append(checkString(item.getDataDvct()) + ";");
           builder.append(checkString(item.getDataDest()) + ";");
           builder.append(checkString(item.getCodeStatoPsXdsl()) + ";");
           builder.append(checkString(item.getCodePsFatt()) +";");
           builder.append(checkString(item.getDataAcqChius()) + ";");
           builder.append(checkString(item.getCodeContr()) + ";");
           builder.append(checkString(item.getTipoFlashAcqRich()) + ";");
           builder.append(checkString(item.getCodeAreaRaccolta()) + ";");
           builder.append(checkString(item.getCodeGest()) + ";");
           builder.append(checkString(item.getServizioIav()) + ";");
           builder.append(checkString(item.getNameFile()) + ";");
           builder.append(checkString(item.getIdFlusso()) + ";");
           builder.append(checkString(item.getProgressivoRiga()) + ";");
           builder.append(checkString(item.getIdentificativoTT()) + ";");
           builder.append(checkString(item.getIdIdentificativoTT()) + ";");
           builder.append(checkString(item.getTipoServizio()) + ";");
           builder.append(checkString(item.getServizioErogato()) + ";");
           builder.append(checkString(item.getTipoTicketOlo()) + ";");
           builder.append(checkString(item.getOggettoSegnalato()) + ";");
           builder.append(checkString(item.getRiscontro()) + ";");
           builder.append(checkString(item.getDataOraInizioSegn()) + ";");
           builder.append(checkString(item.getDataOraFineServizio()) + ";");
           builder.append(checkString(item.getChiusuraTTTTMWeb()) + ";");
           builder.append(checkString(item.getNomeOlo()) + ";");
           builder.append(checkString(item.getCodiceFonte()) + ";");
           builder.append(checkString(item.getDescCausaChiusuraOlo()) + ";");
           builder.append(checkString(item.getClassificazioneTecnica()) + ";");
           builder.append(checkString(item.getCompetenzaChiusura()) + ";");
           builder.append(checkString(item.getAnnoChiusura()) + ";");
           builder.append(checkString(item.getMeseChiusura()) + ";");
           builder.append(checkString(item.getRiscontratiAutorip()) + ";");
           builder.append(checkString(item.getRemotoOnField()) + ";");
           builder.append(checkString(item.getCodiceImpresa()) + ";");
           builder.append(checkString(item.getDescImpresa()) + ";");
           builder.append(checkString(item.getAddCircuitInfo()) + ";");
           builder.append(checkString(item.getAddrCust()) + ";");
           builder.append(checkString(item.getLocationDesc()) + ";");
           builder.append(checkString(item.getTechAssigned()) + ";");
           builder.append(checkString(item.getDataCreazioneWr()) + ";");
           builder.append(checkString(item.getCompCandaDateTime()) + ";");
          // builder.append(item.getStatoErrore() + ";");
           //builder.append(item.getCodeErrrore() + ";");
          // builder.append(item.getDescrizioneErrore() + ";");
           
            
            return builder.toString();

        }
        
        public String getResultForAssuranceStaginCSV(ResultRefuseIav item){
            
            StringBuilder builder = new StringBuilder();
            
            builder.append( checkString(item.getNameFile()) + ";");
            builder.append( checkString(item.getDataAcquisizione()) + ";");
            builder.append( checkString(item.getIdFlusso()) + ";");
            builder.append( checkString(item.getProgressivoRiga()) + ";");
            builder.append( checkString(item.getIdentificativoTT()) + ";");
            builder.append( checkString(item.getIdIdentificativoTT()) + ";");
            builder.append( checkString(item.getTipoServizio()) + ";");
            builder.append( checkString(item.getServizioErogato()) + ";");
            builder.append( checkString(item.getTipoTicketOlo()) + ";");
            
            builder.append( checkString(item.getOggettoSegnalato()) + ";");
            builder.append( checkString(item.getRiscontro()) + ";");
            builder.append( checkString(item.getDataOraInizioSegn()) + ";");
            builder.append( checkString(item.getDataOraFineServizio()) + ";");
            builder.append( checkString(item.getChiusuraTTTTMWeb()) + ";");

            builder.append( checkString(item.getNomeOlo()) + ";");
            builder.append( checkString(item.getCodiceFonte()) + ";");
            builder.append( checkString(item.getDescCausaChiusuraOlo()) + ";");
            builder.append( checkString(item.getClassificazioneTecnica()) + ";");
            builder.append( checkString(item.getCompetenzaChiusura()) + ";");
            builder.append( checkString(item.getAnnoChiusura()) + ";");
            builder.append( checkString(item.getMeseChiusura()) + ";");
            builder.append( checkString(item.getRiscontratiAutorip()) + ";");
            builder.append( checkString(item.getRemotoOnField()) + ";");
            builder.append( checkString(item.getCodiceImpresa()) + ";");
            builder.append( checkString(item.getDescrizioneImpresa()) + ";");
            builder.append( checkString(item.getAddCircuitInfo()) + ";");
            builder.append( checkString(item.getAddrCust()) + ";");
            builder.append( checkString(item.getLocationDesc()) + ";");
            builder.append( checkString(item.getTechAssigned()) + ";");
            builder.append( checkString(item.getDataCreazioneWr()) + ";");
            builder.append( checkString(item.getCompCandaDateTime()) + ";");
            
           /* builder.append(item.getStatoErrore() + ";");
            builder.append(item.getCodeErrrore() + ";");
            builder.append(item.getDescrizioneErrore() + ";");*/
            
            return builder.toString();
        }
        
        public String getResultForProvisioningStagingCSV(ResultRefuseIav item){
            
            StringBuilder builder = new StringBuilder();
                
             builder.append(checkString(item.getNameFile()) + ";");
             builder.append(checkString(item.getDataAcquisizione()) + ";");
             builder.append(checkString(item.getIdFlusso()) + ";");
             builder.append(checkString(item.getProgressivoRiga()) + ";");
             builder.append(checkString(item.getCodiceOlo()) + ";");
             builder.append(checkString(item.getNomeRagSocGest()) + ";");
             builder.append(checkString(item.getCodiceCausaleOlo()) + ";");
             builder.append(checkString(item.getDescrizioneCausale()) + ";");
             builder.append(checkString(item.getCodiceProgetto()) + ";");
             builder.append(checkString(item.getCodiceOrdineOlo()) + ";");
             builder.append(checkString(item.getStatoAggr()) + ";");
             builder.append(checkString(item.getCaratteristica()) + ";");
             builder.append(checkString(item.getViaOlo()) + ";");
             builder.append(checkString(item.getParticellaOlo()) + ";");
             builder.append(checkString(item.getCivicoOlo()) + ";");
             builder.append(checkString(item.getComune()) + ";");
             builder.append(checkString(item.getLocalitaOlo()) + ";");
             builder.append(checkString(item.getProv()) + ";");
             builder.append(checkString(item.getIdRisorsa()) + ";");
             builder.append(checkString(item.getCodiceRichullTi()) + ";");
             builder.append(checkString(item.getDescImpresa()) + ";");
             builder.append(checkString(item.getMittente()) +";");
             builder.append(checkString(item.getCaratteristica()) + ";");
             builder.append(checkString(item.getTipoServizio()) + ";");
             builder.append(checkString(item.getTipologia()) + ";");
             builder.append(checkString(item.getCodiceCausaleSospOlo()) + ";");
             builder.append(checkString(item.getDataInizioSospensione()) + ";");
             builder.append(checkString(item.getDataFineSospensione()) + ";");
             builder.append(checkString(item.getDataRicezioneOrdine()) + ";");
             builder.append(checkString(item.getCodiceCausale()) + ";");
             builder.append(checkString(item.getDescrizioneCausale()) + ";");
             builder.append(checkString(item.getDataUltimaModificaOrdine()) + ";");
             builder.append(checkString(item.getDataChiusura()) + ";");
             builder.append(checkString(item.getFlagNpd()) + ";");
             builder.append(checkString(item.getCognomeRef()) + ";");
             builder.append(checkString(item.getEmailRef())  + ";");
             builder.append(checkString(item.getFaxRef()) + ";");
             builder.append(checkString(item.getMobileRef()) + ";");
             builder.append(checkString(item.getNomeRef()) + ";");
             builder.append(checkString(item.getQualificaReferente()) + ";");

            /*builder.append(item.getStatoErrore() + ";");
            builder.append(item.getCodeErrrore() + ";");
            builder.append(item.getDescrizioneErrore() + ";");*/
            
            return builder.toString();

        }
        
    public String getResultForProvisioningStagingOperaCSV(ResultRefuseIav item){
        
        StringBuilder builder = new StringBuilder();
            
         builder.append(checkString(item.getNameFile()) + ";");
         builder.append(checkString(item.getDataAcquisizione()) + ";");
         builder.append(checkString(item.getIdFlusso()) + ";");
         builder.append(checkString(item.getProgressivoRiga()) + ";");
         builder.append(checkString(item.getNomeRagSocGest()) + ";");
         builder.append(checkString(item.getCodiceOlo()) + ";");
         builder.append(checkString(item.getCodiceOrdineOlo()) + ";");
         builder.append(checkString(item.getIdRisorsa()) + ";");
         builder.append(checkString(item.getTipoServizio()) + ";");
         builder.append(checkString(item.getCodiceServizio()) + ";");
         builder.append(checkString(item.getCodiceProgetto()) + ";");
         builder.append(checkString(item.getDro()) + ";");
         builder.append(checkString(item.getDataChiusura()) + ";");
         builder.append(checkString(item.getViaOlo()) + ";");
         builder.append(checkString(item.getParticellaOlo()) + ";");
         builder.append(checkString(item.getCivicoOlo()) + ";");
         builder.append(checkString(item.getComune()) + ";");
         builder.append(checkString(item.getLocalitaOlo()) + ";");
         builder.append(checkString(item.getProv()) + ";");
         builder.append(checkString(item.getCodiceCausaleOlo()) + ";");
         builder.append(checkString(item.getDescrizioneCausaleOlo()) + ";");
         builder.append(checkString(item.getTipologia()) + ";");
         builder.append(checkString(item.getCodiceCausaleSospOlo()) + ";");
         builder.append(checkString(item.getDescrizioneCausaleSospOlo()) + ";");
         builder.append(checkString(item.getDataInizioSospensione()) + ";");
         builder.append(checkString(item.getDataFineSospensione()) + ";");
         builder.append(checkString(item.getFlagReferente()) + ";");
         builder.append(checkString(item.getCognome()) + ";");
         builder.append(checkString(item.getNome()) + ";");
         builder.append(checkString(item.getFisso()) + ";");
         builder.append(checkString(item.getMobile()) + ";");
         builder.append(checkString(item.getVerificaIvRef()) + ";");
         builder.append(checkString(item.getChiamataIvRef()) + ";");
         builder.append(checkString(item.getPinIvRef()) + ";");
         builder.append(checkString(item.getIndicatoreIvRef()) + ";");
         builder.append(checkString(item.getIndicatoreIvRefDati()) + ";");
         builder.append(checkString(item.getIndicatoreIvRefFonia()) + ";");
        
        
        return builder.toString();

    }        
        private String checkString(String str){
            String check = " ";
            if(str != null){
                if(!"null".equals(str)){
                    check = str;
                }
                check = str;
                check = check.replace(";"," ");
            }
            return check;
        }

        

    
}
