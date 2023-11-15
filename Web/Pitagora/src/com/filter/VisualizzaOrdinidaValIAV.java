package com.filter;

import com.ejbSTL.ResultRefuseIav;
import com.ejbSTL.ResultInventIav;
import com.ejbSTL.ResultItrfIav;

import com.ejbSTL.TypeFlussoIav;
import com.ejbSTL.impl.VisualizzaOrdinidaValIAVBean;

import com.model.ValorPathModel;

import com.utl.CustomException;

import com.utl.GenerateCompressFile;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import java.io.PrintWriter;

import java.net.URL;

import java.rmi.RemoteException;

import java.sql.SQLException;

import java.util.Vector;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.text.ParseException;

import java.util.Date;
import java.util.StringTokenizer;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;


public class VisualizzaOrdinidaValIAV {

    public Vector<TypeFlussoIav> listVisualizzaOrdIav = new Vector<TypeFlussoIav>();
    private VisualizzaOrdinidaValIAVBean visOrdVal;
    
    public String pathDownload="";

    public VisualizzaOrdinidaValIAV() {
        visOrdVal = new VisualizzaOrdinidaValIAVBean();
    }
    
    public Vector<TypeFlussoIav> getListaFlussi() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listVisualizzaOrdIav = visOrdVal.getListaFlussi();
        
        return listVisualizzaOrdIav;
    }
    
    public Vector<ResultInventIav> getResultFromFilter(String operatoreIav, String serviziIav, String fatturazioneIav) throws SQLException,
                                                                              RemoteException {
        return visOrdVal.getTableFromFluxCode(operatoreIav, serviziIav, fatturazioneIav);
    }
    
    public Vector<ResultInventIav> getResultFromFilter2(String operatoreIav, String ambitoIav, String statoOrdiniIav) throws SQLException,
                                                                              RemoteException {
        return visOrdVal.getTableFromFluxCode2(operatoreIav, ambitoIav, statoOrdiniIav);
    }
    
    public String getNameFluxFromCode(String code) throws SQLException,
                                                          RemoteException {
        return visOrdVal.getNameFluxFromCode(code);
    }
    
    public Vector<TypeFlussoIav> getListaServizi() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listVisualizzaOrdIav = visOrdVal.getListaServizi();
        
        return listVisualizzaOrdIav;
    }
    
    public Vector<TypeFlussoIav> getListaOperatori() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listVisualizzaOrdIav = visOrdVal.getListaOperatori();
        
        return listVisualizzaOrdIav;
    }
    
    public Vector<TypeFlussoIav> getFatrzCycle(String serviziIav, String operatoreIav) throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listVisualizzaOrdIav = visOrdVal.getFatrzCycle(serviziIav, operatoreIav);
        
        return listVisualizzaOrdIav;
    }
    
    public Boolean alterTableOpe(String SelOf, String input) throws SQLException,
                                                                              RemoteException {
        return visOrdVal.alterExceptionOpe(SelOf, input);
    }
    
    
    public boolean isValid(String dateStr) {
            DateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            sdf.setLenient(false);
            try {
                sdf.parse(dateStr);
            } catch (ParseException e) {
                return false;
            }
            return true;
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
    
 
    public String generateFileCSVFromFluxName2(String[] listName, String operatoreIav, String ambitoIav, String statoOrdiniIav) throws RemoteException,
                                                                                 SQLException {
                  
           String pathFileZip = "";
            String nameFIle = "";
            
            ValorPathModel model = visOrdVal.getInfoFromType("SI");
            String elencoFile = "";
            try{
                    for(int i = 0; i < listName.length; i++){
                        String codeInvent = listName[i];
                        Vector<ResultItrfIav> results = new Vector<ResultItrfIav>();
                        results = visOrdVal.getAllFieldsFromCodeInvent2(codeInvent, operatoreIav, ambitoIav, statoOrdiniIav);
                        String nomeFile = "";
                         if (codeInvent.toUpperCase().contains("ASS")) {
                             nomeFile = writeFileASS(codeInvent, results, model);
                         } else if (codeInvent.toUpperCase().contains("BTS")) {
                             nomeFile = writeFileBTS(codeInvent, results, model);
                         } else if (codeInvent.toUpperCase().contains("ULL")) {
                             nomeFile = writeFileULL(codeInvent, results, model);
                         } else if (codeInvent.toUpperCase().contains("WLR")) {
                             nomeFile = writeFileWLR(codeInvent, results, model);
                         } else if (codeInvent.toUpperCase().contains("PROVI") && codeInvent.length() > 3 && codeInvent.toUpperCase().substring(codeInvent.length()-3).equalsIgnoreCase("PRO")) {
                             nomeFile = writeFileOPERA(codeInvent, results, model);
                         }
                        elencoFile = elencoFile + "|" + nomeFile;
                    }
                    
                    pathFileZip = model.getPathZip();  
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("ddMMyyyyhhmmss");
                    String date = simpleDateFormat.format(new Date());
                    nameFIle = "Estrazione_Eventi_Acquisiti_" + date + ".zip";
///////////////////7
                       GenerateCompressFile.generateZipFile(elencoFile,model.getPathStorico(), model.getPathZip(), nameFIle);
///////////////////7 
                    //JOptionPane.showMessageDialog(null, "Download eseguito con successo!", "InfoWindow", JOptionPane.INFORMATION_MESSAGE);
                   
            }catch (Exception e) {
            
                    System.out.println(e);
                    //JOptionPane.showMessageDialog(null, "Errore Download File!", "InfoWindow", JOptionPane.ERROR_MESSAGE);
                    
                }
                
                return pathFileZip + nameFIle;
        }


    public String writeFileCSV2(String codeInvent, Vector<ResultInventIav> queryData, ValorPathModel model){
        
        String nomeFile = null;
        
        if(queryData != null){
            
            PrintWriter pw = null;
            String pattern = "ddMMyyyy_hhmmss";
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);

            String date = simpleDateFormat.format(new Date());
            System.out.println(date);
            
            try{
                nomeFile = codeInvent.toUpperCase().trim().replace(" ","_").replace("PROVISIONING","PROV") + "_" + date + "-EV_ACQ.csv";
                pw = new PrintWriter(new File(model.getPathStorico() + nomeFile));
                
                pw.write( getHeadForInventCSV() );
                
                pw.write( "\n" );
                
            }catch(FileNotFoundException e){
                e.printStackTrace();
            }
        
            for(int i = 0; i < queryData.size(); i++){
            
                ResultInventIav item = queryData.get(i);
                
                pw.write( getResultForInventCSV(item) );
                
                pw.write( "\n" );
            }
            
            pw.close();
        }
        return nomeFile;
    }        

    public String writeFileASS(String codeInvent, Vector<ResultItrfIav> queryData, ValorPathModel model){
        
        String nomeFile = null;
        
        if(queryData != null){
            
            PrintWriter pw = null;
            String pattern = "ddMMyyyy_hhmmss";
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);

            String date = simpleDateFormat.format(new Date());
            System.out.println(date);
            
            try{
                nomeFile = codeInvent.toUpperCase().trim().replace(" ","_").replace("PROVISIONING","PROV") + "_" + date + "-EV_ACQ.csv";
                pw = new PrintWriter(new File(model.getPathStorico() + nomeFile));
                
                pw.write( getHeadForAssCSV() );
                
                pw.write( "\n" );
                
            }catch(FileNotFoundException e){
                e.printStackTrace();
            }
        
            for(int i = 0; i < queryData.size(); i++){
            
                ResultItrfIav item = queryData.get(i);
                
                pw.write( getResultForAssCSV(item) );
                
                pw.write( "\n" );
            }
            
            pw.close();
        }
        return nomeFile;
    }    
        public String getHeadForAssCSV(){
        
        String header = 
        "NOME_FILE; DATA_ACQ_CHIUS; IDENTIFICATIVOTT; ID_IDENTIFICATIVO_TT; TIPOSERVIZIO; SERVIZIO_EROGATO; TIPOTICKETOLO; " + 
        "OGGETTO_SEGNALATO; RISCONTRO; DATAORAINIZIOSEGN; DATAORAFINEDISSERVIZIO; CHIUSURATT_TTMWEB; NOMEOLO; CODICEFONTE; DESCCAUSACHIUSURAOLO; CLASSIFICAZIONE_TECNICA; "+ 
        "COMPETENZA_CHIUSURA; ANNO_CHIUSURA; MESE_CHIUSURA; RISCONTRATI_AUTORIPR; REMOTO_ON_FIELD; CODICE_IMPRESA; DESCRIZIONE_IMPRESA; ADDR_CIRCUITINFO; ADDR_CUST; LOCATIONDESC; "+ 
        "TECHASSIGNED; DATA_CREAZIONE_WR; CODE_GEST; SERVIZIO_IAV; DATA_DRO; CODE_CONTR; CODE_PS_FATT; STATO_REC";
        
        return header;   
    }

    public String getResultForAssCSV(ResultItrfIav item){
        StringBuilder builder = new StringBuilder();
        
        builder.append( item.getNOME_FILE() + ";");
        builder.append( item.getDATA_ACQ_CHIUS() + ";");
        builder.append( item.getIDENTIFICATIVOTT() + ";");
        builder.append( item.getID_IDENTIFICATIVO_TT() + ";");
        builder.append( item.getTIPOSERVIZIO() + ";");
        builder.append(item.getSERVIZIO_EROGATO() + ";");
        builder.append(item.getTIPOTICKETOLO() + ";");
        builder.append(item.getOGGETTO_SEGNALATO() + ";");
        builder.append(item.getRISCONTRO() + ";");
        builder.append(item.getDATAORAINIZIOSEGN() + ";");
        builder.append(item.getDATAORAFINEDISSERVIZIO() + ";");
        builder.append(item.getCHIUSURATT_TTMWEB() + ";");
        builder.append(item.getNOMEOLO() + ";");
        builder.append(item.getCODICEFONTE() + ";");
        builder.append(item.getDESCCAUSACHIUSURAOLO() + ";");
        builder.append(item.getCLASSIFICAZIONE_TECNICA() + ";");
        builder.append(item.getCOMPETENZA_CHIUSURA() + ";");
        builder.append(item.getANNO_CHIUSURA() + ";");
        builder.append(item.getMESE_CHIUSURA() + ";");
        builder.append(item.getRISCONTRATI_AUTORIPR() + ";");
        builder.append(item.getREMOTO_ON_FIELD() + ";");
        builder.append(item.getCODICE_IMPRESA() + ";");
        builder.append(item.getDESCRIZIONE_IMPRESA() + ";");
        builder.append(item.getADDR_CIRCUITINFO() + ";");
        builder.append(item.getADDR_CUST() + ";");
        builder.append(item.getLOCATIONDESC() + ";");
        builder.append(item.getTECHASSIGNED() + ";");
        builder.append(item.getDATA_CREAZIONE_WR() + ";");
        builder.append(item.getCODE_GEST() + ";");
        builder.append(item.getSERVIZIO_IAV() + ";");
        builder.append(item.getDATA_DRO() + ";");
        builder.append(item.getCODE_CONTR() + ";");
        builder.append(item.getCODE_PS_FATT() + ";");
        builder.append(item.getTIPO_FLAG_ACQ_RICH() + ";");

        
        return builder.toString();
    }    
    
    public String writeFileBTS(String codeInvent, Vector<ResultItrfIav> queryData, ValorPathModel model){
        
        String nomeFile = null;
        
        if(queryData != null){
            
            PrintWriter pw = null;
            String pattern = "ddMMyyyy_hhmmss";
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);

            String date = simpleDateFormat.format(new Date());
            System.out.println(date);
            
            try{
                nomeFile = codeInvent.toUpperCase().trim().replace(" ","_").replace("PROVISIONING","PROV") + "_" + date + "-EV_ACQ.csv";
                pw = new PrintWriter(new File(model.getPathStorico() + nomeFile));
                
                pw.write( getHeadForBtsCSV() );
                
                pw.write( "\n" );
                
            }catch(FileNotFoundException e){
                e.printStackTrace();
            }
        
            for(int i = 0; i < queryData.size(); i++){
            
                ResultItrfIav item = queryData.get(i);
                
                pw.write( getResultForBtsCSV(item) );
                
                pw.write( "\n" );
            }
            
            pw.close();
        }
        return nomeFile;
    }    
        public String getHeadForBtsCSV(){
        
        String header = 
        "NOME_FILE; DATA_ACQ_CHIUS; CODICE_OLO; NOME_RAG_SOC_GEST; CODICE_ORDINE_OLO; STATO_AGGR; CODICE_CAUSALE_OLO; DESCRIZIONE_CAUSALE_OLO; DRO; ID_RISORSA; DNO; PARTICELLA; "+
        "VIA; CIVICO; LOCALITA; FLAG_NPD; DATA_CHIUSURA; FL_MOS_MOI; DESC_IMPRESA; MITTENTE; CARATTERISTICA; TIPO_SERVIZIO; TIPOLOGIA; CODICE_CAUSALE_SOSP_OLO; DATA_INIZIO_SOSPENSIONE; "+
        "DATA_FINE_SOSPENSIONE; DESCRIZIONE_CAUSALE_SOSP_OLO; COGNOME; FISSO; MOBILE; NOME; QUALIFICA_REFERENTE; CODE_GEST; SERVIZIO_IAV; DATA_DRO; CODE_CONTR; CODE_PS_FATT; TIPO_FLAG_ACQ_RICH";
        
        return header;   
    }

    public String getResultForBtsCSV(ResultItrfIav item){
        StringBuilder builder = new StringBuilder();
        
        builder.append( item.getNOME_FILE() + ";");
        builder.append( item.getDATA_ACQ_CHIUS() + ";");
      
        builder.append( item.getCODICE_OLO() + ";");
        builder.append( item.getNOME_RAG_SOC_GEST() + ";");
        builder.append( item.getCODICE_ORDINE_OLO() + ";");
        builder.append(item.getSTATO_AGGR() + ";");
        builder.append(item.getCODICE_CAUSALE_OLO() + ";");
        builder.append(item.getDESCRIZIONE_CAUSALE_OLO() + ";");
        builder.append(item.getDATA_RICEZIONE_ORDINE() + ";");
        builder.append(item.getIDRISORSA() + ";");
        builder.append(item.getDATA_DRO() + ";");
        builder.append(item.getPARTICELLAOLO() + ";");
        builder.append(item.getVIA_OLO() + ";");
        builder.append(item.getCIVICOOLO() + ";");
        builder.append(item.getLOCALITA_OLO() + ";");
        builder.append(item.getFLAG_NPD() + ";");
        builder.append(item.getDATA_CHIUSURA() + ";");
        builder.append(item.getFL_MOS_MOI() + ";");
        builder.append(item.getDESC_IMPRESA() + ";");
        builder.append(item.getMITTENTE() + ";");
        builder.append(item.getCARATTERISTICA() + ";");
        builder.append(item.getTIPO_SERVIZIO() + ";");
        builder.append(item.getTIPOLOGIA() + ";");
        builder.append(item.getCODICE_CAUSALE_SOSP_OLO() + ";");
        builder.append(item.getDATA_INIZIO_SOSPENSIONE() + ";");
        builder.append(item.getDATA_FINE_SOSPENSIONE() + ";");
        builder.append(item.getDESCRIZIONE_CAUSALE_SOSP_OLO() + ";");
        builder.append(item.getCOGNOME_REF() + ";");
        builder.append(item.getFISSO_REF() + ";");
        builder.append(item.getMOBILE_REF() + ";");
        builder.append(item.getNOME_REF() + ";");
        builder.append(item.getQUALIFICA_REFERENTE() + ";");
        builder.append(item.getCODE_GEST() + ";");
        builder.append(item.getSERVIZIO_IAV() + ";");
        builder.append(item.getDATA_DRO() + ";");
        builder.append(item.getCODE_CONTR() + ";");
        builder.append(item.getCODE_PS_FATT() + ";");
        builder.append(item.getTIPO_FLAG_ACQ_RICH() + ";");
        
        return builder.toString();
    }

    public String writeFileULL(String codeInvent, Vector<ResultItrfIav> queryData, ValorPathModel model){
        
        String nomeFile = null;
        
        if(queryData != null){
            
            PrintWriter pw = null;
            String pattern = "ddMMyyyy_hhmmss";
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);

            String date = simpleDateFormat.format(new Date());
            System.out.println(date);
            
            try{
                nomeFile = codeInvent.toUpperCase().trim().replace(" ","_").replace("PROVISIONING","PROV") + "_" + date + "-EV_ACQ.csv";
                pw = new PrintWriter(new File(model.getPathStorico() + nomeFile));
                
                pw.write( getHeadForUllCSV() );
                
                pw.write( "\n" );
                
            }catch(FileNotFoundException e){
                e.printStackTrace();
            }
        
            for(int i = 0; i < queryData.size(); i++){
            
                ResultItrfIav item = queryData.get(i);
                
                pw.write( getResultForUllCSV(item) );
                
                pw.write( "\n" );
            }
            
            pw.close();
        }
        return nomeFile;
    }    
        public String getHeadForUllCSV(){
        
        String header = 
        "NOME_FILE; DATA_ACQ_CHIUS; CODICE_OLO; NOME_RAG_SOC_GEST; CODICE_CAUSALE_OLO; DESCRIZIONE_CAUSALE_OLO; CODICE_PROGETTO; CODICE_ORDINE_OLO; STATO_AGGR;  CARATTERISTICA; "+
        "VIA_OLO; PARTICELLAOLO; CIVICOOLO; COMUNE; LOCALITA_OLO; PROV; IDRISORSA; CODICE_RICHULL_TI; DATA_RICEZIONE_ORDINE; CODICE_CAUSALE; DESCRIZIONE_CAUSALE; TIPO_SERVIZIO; "+
        "DATA_ULTIMA_MODIFICA_ORDINE; DATA_CHIUSURA; FLAG_NPD; FL_MOS_MOI; DESC_IMPRESA; MITTENTE; TIPOLOGIA; CODICE_CAUSALE_SOSP_OLO; DATA_INIZIO_SOSPENSIONE; DATA_FINE_SOSPENSIONE; "+
        "DATA_INVIO_NOTIFICA_SOSP; DESCRIZIONE_CAUSALE_SOSP_OLO; COGNOME_REF; EMAIL_REF; FAX_REF; FISSO_REF; MOBILE_REF; NOME_REF; QUALIFICA_REFERENTE; CODE_GEST; SERVIZIO_IAV; DATA_DRO; "+
        "CODE_CONTR; CODE_PS_FATT; TIPO_FLAG_ACQ_RICH";
        
        return header;   
    }

    public String getResultForUllCSV(ResultItrfIav item){
        StringBuilder builder = new StringBuilder();
        
        builder.append( item.getNOME_FILE() + ";");
        builder.append( item.getDATA_ACQ_CHIUS() + ";");
        builder.append(item.getCODICE_OLO() + ";");
        builder.append(item.getNOME_RAG_SOC_GEST() + ";");
        builder.append(item.getCODICE_CAUSALE_OLO() + ";");
        builder.append(item.getDESCRIZIONE_CAUSALE_OLO() + ";");
        builder.append(item.getCODICE_PROGETTO() + ";");
        builder.append(item.getCODICE_ORDINE_OLO() + ";");
        builder.append(item.getSTATO_AGGR() + ";");        
        builder.append(item.getCARATTERISTICA() + ";");
        builder.append(item.getVIA_OLO() + ";");
        builder.append(item.getPARTICELLAOLO() + ";");
        builder.append(item.getCIVICOOLO() + ";");
        builder.append(item.getCOMUNE() + ";");
        builder.append(item.getLOCALITA_OLO() + ";");
        builder.append(item.getPROV() + ";");
        builder.append(item.getIDRISORSA() + ";");
        builder.append(item.getCODICE_RICHULL_TI() + ";");
        builder.append(item.getDATA_RICEZIONE_ORDINE() + ";");
        builder.append(item.getCODICE_CAUSALE() + ";");
        builder.append(item.getDESCRIZIONE_CAUSALE() + ";");  
        builder.append(item.getTIPO_SERVIZIO() + ";");
        builder.append(item.getDATA_ULTIMA_MODIFICA_ORDINE() + ";");
        builder.append(item.getDATA_CHIUSURA() + ";");
        builder.append(item.getFLAG_NPD() + ";");
        builder.append(item.getFL_MOS_MOI() + ";");
        builder.append(item.getDESC_IMPRESA() + ";");
        builder.append(item.getMITTENTE() + ";");
        builder.append(item.getTIPOLOGIA() + ";");
        builder.append(item.getCODICE_CAUSALE_SOSP_OLO() + ";");
        builder.append(item.getDATA_INIZIO_SOSPENSIONE() + ";");
        builder.append(item.getDATA_FINE_SOSPENSIONE() + ";");
        builder.append(item.getDATA_INVIO_NOTIFICA_SOSP() + ";");
        builder.append(item.getDESCRIZIONE_CAUSALE_SOSP_OLO() + ";");
        builder.append(item.getCOGNOME_REF() + ";");
        builder.append(item.getEMAIL_REF() + ";");  
        builder.append(item.getFAX_REF() + ";");  
        builder.append(item.getFISSO_REF() + ";");
        builder.append(item.getMOBILE_REF() + ";");
        builder.append(item.getNOME_REF() + ";");
        builder.append(item.getQUALIFICA_REFERENTE() + ";");
        builder.append(item.getCODE_GEST() + ";");
        builder.append(item.getSERVIZIO_IAV() + ";");
        builder.append(item.getDATA_DRO() + ";");
        builder.append(item.getCODE_CONTR() + ";");
        builder.append(item.getCODE_PS_FATT() + ";");
        builder.append(item.getTIPO_FLAG_ACQ_RICH() + ";");
        
        return builder.toString();
    }    

    public String writeFileOPERA(String codeInvent, Vector<ResultItrfIav> queryData, ValorPathModel model){
            
            String nomeFile = null;
            
            if(queryData != null){
                
                PrintWriter pw = null;
                String pattern = "ddMMyyyy_hhmmss";
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);

                String date = simpleDateFormat.format(new Date());
                System.out.println(date);
                
                try{
                    nomeFile = codeInvent.toUpperCase().trim().replace(" ","_").replace("PROVISIONING","PROV") + "_" + date + "-EV_ACQ.csv";
                    pw = new PrintWriter(new File(model.getPathStorico() + nomeFile));
                    
                    pw.write( getHeadForOPERACSV() );
                    
                    pw.write( "\n" );
                    
                }catch(FileNotFoundException e){
                    e.printStackTrace();
                }
            
                for(int i = 0; i < queryData.size(); i++){
                
                    ResultItrfIav item = queryData.get(i);
                    
                    pw.write( getResultForOPERACSV(item) );
                    
                    pw.write( "\n" );
                }
                
                pw.close();
            }
            return nomeFile;
        }    

public String writeFileWLR(String codeInvent, Vector<ResultItrfIav> queryData, ValorPathModel model){
        
        String nomeFile = null;
        
        if(queryData != null){
            
            PrintWriter pw = null;
            String pattern = "ddMMyyyy_hhmmss";
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);

            String date = simpleDateFormat.format(new Date());
            System.out.println(date);
            
            try{
                nomeFile = codeInvent.toUpperCase().trim().replace(" ","_").replace("PROVISIONING","PROV") + "_" + date + "-EV_ACQ.csv";
                pw = new PrintWriter(new File(model.getPathStorico() + nomeFile));
                
                pw.write( getHeadForWlrCSV() );
                
                pw.write( "\n" );
                
            }catch(FileNotFoundException e){
                e.printStackTrace();
            }
        
            for(int i = 0; i < queryData.size(); i++){
            
                ResultItrfIav item = queryData.get(i);
                
                pw.write( getResultForWlrCSV(item) );
                
                pw.write( "\n" );
            }
            
            pw.close();
        }
        return nomeFile;
    }    

        public String getHeadForOPERACSV(){
    
        String header = 
        "NOME_FILE; DATA_ACQ_CHIUS; CODICE_OLO; NOME_RAG_SOC_GEST; CODICE_ORDINE_OLO; STATO; IDRISORSA; CODICE_RICHULL_TI; CODICE_CAUSALE_OLO; DESCRIZIONE_CAUSALE_OLO; DATA_ULTIMA_MODIFICA_ORDINE; "+
        "CARATTERISTICA; UTENZA_PRIMARIA; CODICE_CAUSALE_SOSP_OLO; PARTICELLAOLO; VIA_OLO; LOCALITA_OLO; PROV; DATA_CHIUSURA; FLAG_NPD; FL_MOS_MOI; DESC_IMPRESA; MITTENTE; TIPOLOGIA; DATA_INIZIO_SOSPENSIONE; "+
        "DATA_FINE_SOSPENSIONE; DATA_INVIO_NOTIFICA_SOSP; DESCRIZIONE_CAUSALE_SOSP_OLO; COGNOME_REF; EMAIL_REF; FAX_REF; FISSO_REF; MOBILE_REF; NOME_REF; QUALIFICA_REFERENTE; CODE_GEST; SERVIZIO_IAV; "+
        "DATA_DRO; CODE_CONTR; CODE_PS_FATT; TIPO_FLAG_ACQ_RICH;FLAG_REFERENTE;VERIFICA_4_REF;CHIAMATA_4_REF;PIN_4_REF;INDICATORE_4_REF";
        
        return header;   
    }
    
        public String getHeadForWlrCSV(){
        
        String header = 
        "NOME_FILE; DATA_ACQ_CHIUS; CODICE_OLO; NOME_RAG_SOC_GEST; CODICE_ORDINE_OLO; STATO; IDRISORSA; CODICE_RICHULL_TI; CODICE_CAUSALE_OLO; DESCRIZIONE_CAUSALE_OLO; DATA_ULTIMA_MODIFICA_ORDINE; "+
        "CARATTERISTICA; UTENZA_PRIMARIA; CODICE_CAUSALE_SOSP_OLO; PARTICELLAOLO; VIA_OLO; LOCALITA_OLO; PROV; DATA_CHIUSURA; FLAG_NPD; FL_MOS_MOI; DESC_IMPRESA; MITTENTE; TIPOLOGIA; DATA_INIZIO_SOSPENSIONE; "+
        "DATA_FINE_SOSPENSIONE; DATA_INVIO_NOTIFICA_SOSP; DESCRIZIONE_CAUSALE_SOSP_OLO; COGNOME_REF; EMAIL_REF; FAX_REF; FISSO_REF; MOBILE_REF; NOME_REF; QUALIFICA_REFERENTE; CODE_GEST; SERVIZIO_IAV; "+
        "DATA_DRO; CODE_CONTR; CODE_PS_FATT; TIPO_FLAG_ACQ_RICH";
        
        return header;   
    }

    public String getResultForOPERACSV(ResultItrfIav item){
        StringBuilder builder = new StringBuilder();
        
        builder.append( item.getNOME_FILE() + ";");
        builder.append( item.getDATA_ACQ_CHIUS() + ";");

    
        builder.append(item.getCODICE_OLO() + ";");
        builder.append(item.getNOME_RAG_SOC_GEST() + ";");
        builder.append(item.getCODICE_ORDINE_OLO() + ";");
        builder.append(item.getSTATO() + ";");
        builder.append(item.getIDRISORSA() + ";");
        builder.append(item.getCODICE_RICHULL_TI() + ";");
        builder.append(item.getCODICE_CAUSALE_OLO() + ";");
        builder.append(item.getDESCRIZIONE_CAUSALE_OLO() + ";");
        builder.append(item.getDATA_ULTIMA_MODIFICA_ORDINE() + ";");        
        builder.append(item.getCARATTERISTICA() + ";");
        builder.append(item.getUTENZA_PRIMARIA() + ";");    
        builder.append(item.getCODICE_CAUSALE_SOSP_OLO() + ";");        
        builder.append(item.getPARTICELLAOLO() + ";");
        builder.append(item.getVIA_OLO() + ";");        
        builder.append(item.getLOCALITA_OLO() + ";");
        builder.append(item.getPROV() + ";");
        builder.append(item.getDATA_CHIUSURA() + ";");
        builder.append(item.getFLAG_NPD() + ";");
        builder.append(item.getFL_MOS_MOI() + ";");
        builder.append(item.getDESC_IMPRESA() + ";");
        builder.append(item.getMITTENTE() + ";");
        builder.append(item.getTIPOLOGIA() + ";");
        builder.append(item.getDATA_INIZIO_SOSPENSIONE() + ";");
        builder.append(item.getDATA_FINE_SOSPENSIONE() + ";");
        builder.append(item.getDATA_INVIO_NOTIFICA_SOSP() + ";");
        builder.append(item.getDESCRIZIONE_CAUSALE_SOSP_OLO() + ";");
        builder.append(item.getCOGNOME_REF() + ";");
        builder.append(item.getEMAIL_REF() + ";");  
        builder.append(item.getFAX_REF() + ";");  
        builder.append(item.getFISSO_REF() + ";");
        builder.append(item.getMOBILE_REF() + ";");
        builder.append(item.getNOME_REF() + ";");
        builder.append(item.getQUALIFICA_REFERENTE() + ";");
        builder.append(item.getCODE_GEST() + ";");
        builder.append(item.getSERVIZIO_IAV() + ";");
        builder.append(item.getDATA_DRO() + ";");
        builder.append(item.getCODE_CONTR() + ";");
        builder.append(item.getCODE_PS_FATT() + ";");
        builder.append(item.getTIPO_FLAG_ACQ_RICH() + ";");

        builder.append(item.getFLAG_REFERENTE() + ";");
        builder.append(item.getVERIFICA_4_REF() + ";");
        builder.append(item.getCHIAMATA_4_REF() + ";");
        builder.append(item.getPIN_4_REF() + ";");
        builder.append(item.getINDICATORE_4_REF() + ";");
        
        return builder.toString();
    }    



    public String getResultForWlrCSV(ResultItrfIav item){
        StringBuilder builder = new StringBuilder();
        
        builder.append( item.getNOME_FILE() + ";");
        builder.append( item.getDATA_ACQ_CHIUS() + ";");

  
        builder.append(item.getCODICE_OLO() + ";");
        builder.append(item.getNOME_RAG_SOC_GEST() + ";");
        builder.append(item.getCODICE_ORDINE_OLO() + ";");
        builder.append(item.getSTATO() + ";");
        builder.append(item.getIDRISORSA() + ";");
        builder.append(item.getCODICE_RICHULL_TI() + ";");
        builder.append(item.getCODICE_CAUSALE_OLO() + ";");
        builder.append(item.getDESCRIZIONE_CAUSALE_OLO() + ";");
        builder.append(item.getDATA_ULTIMA_MODIFICA_ORDINE() + ";");        
        builder.append(item.getCARATTERISTICA() + ";");
        builder.append(item.getUTENZA_PRIMARIA() + ";");    
        builder.append(item.getCODICE_CAUSALE_SOSP_OLO() + ";");        
        builder.append(item.getPARTICELLAOLO() + ";");
        builder.append(item.getVIA_OLO() + ";");        
        builder.append(item.getLOCALITA_OLO() + ";");
        builder.append(item.getPROV() + ";");
        builder.append(item.getDATA_CHIUSURA() + ";");
        builder.append(item.getFLAG_NPD() + ";");
        builder.append(item.getFL_MOS_MOI() + ";");
        builder.append(item.getDESC_IMPRESA() + ";");
        builder.append(item.getMITTENTE() + ";");
        builder.append(item.getTIPOLOGIA() + ";");
        builder.append(item.getDATA_INIZIO_SOSPENSIONE() + ";");
        builder.append(item.getDATA_FINE_SOSPENSIONE() + ";");
        builder.append(item.getDATA_INVIO_NOTIFICA_SOSP() + ";");
        builder.append(item.getDESCRIZIONE_CAUSALE_SOSP_OLO() + ";");
        builder.append(item.getCOGNOME_REF() + ";");
        builder.append(item.getEMAIL_REF() + ";");  
        builder.append(item.getFAX_REF() + ";");  
        builder.append(item.getFISSO_REF() + ";");
        builder.append(item.getMOBILE_REF() + ";");
        builder.append(item.getNOME_REF() + ";");
        builder.append(item.getQUALIFICA_REFERENTE() + ";");
        builder.append(item.getCODE_GEST() + ";");
        builder.append(item.getSERVIZIO_IAV() + ";");
        builder.append(item.getDATA_DRO() + ";");
        builder.append(item.getCODE_CONTR() + ";");
        builder.append(item.getCODE_PS_FATT() + ";");
        builder.append(item.getTIPO_FLAG_ACQ_RICH() + ";");
        
        return builder.toString();
    }    

 public String getHeadForInventCSV(){
     
     String header = 
     "NOME_FILE; DATA_ACQ_CHIUS; CODE_INVENT; CODE_TIPO_CAUS; CODE_ACCOUNT; CODE_CAUS_ORD; CODE_STATO_PS; CODE_TIPO_OFF; CODE_TIPO_CAUS_VARIAZ; CODE_PS; "+
     "CODE_TIPO_CONTR; DATA_DRO;DATA_DVTC; DATA_INIZIO_VALID; CODE_ISTANZA_PS; DATA_FINE_VALID; DATA_INIZIO_FATRZ; DATA_ULTIMA_FATRZ; " +
     "DATA_FINE_NOL; DATA_CESS; DATA_VARIAZ; DATA_FINE_FATRZ; DATA_FATRB; QNTA_VALO; DATA_ULTIMA_APPL_CANONI; CODE_UTENTE_CREAZ; DATA_CREAZ; "+ 
     "CODE_UTENTE_MODIF; DATA_MODIF; NUM_VARIAZ; CODE_PS_FATT_PRINC; CODE_AREA_RACCOLTA; CODE_NUM_TD; CODE_LOTTO; CODE_PS_OLD; "+
     "CODE_ISTANZA_OLD; TIPO_CONTR_OLD; TIPO_FLAG_PROMOZ; DESC_CODE_VPI ; VALO_MCR; ID_TRASPORTO; FLAG_TRASPORTO; ID_BANDA; VALO_PCR_BANDA; "+
     "FLAG_SYS; ID_ACCESSO; ID_VC; QNTA_VALO_OLD; TIPO_PROVENIENZA ; OPZ_CONTRATTUALE ; VALO_PCR_UP; UTENZA_RIF; CODE_OL; TIPO_SLA_PLUS; "+
     "OFFERTA_SLA_PLUS; COPERTURA_ORARIA; FLAG_DISP; OPZ_COMM; TIPO_MODULAZ; MOD_ACCESSO; TIPO_VALID; CODICE_PROGETTO; TIPO_MOD_FAT; "+
     "DATA_INIZIO_NOL; CODE_TIPO_PREST; FLAG_ESITO_PREQ;BANDA_VL; CODE_CLLI; CODE_ID_ULLCO; CODE_COMUNE; CODE_DISTR; VALO_MCR_UP; "+
     "ID_RIS_OLD; PROFILO_ACCESSO; MOD_VENDITA ; FLAG_MODEM; TIPO_FAMIGLIA; MOD_FATTURAZIONE; MOD_FATTURAZIONE_TRASP; CODE_PROFILO_ESTESO; "+
     "FLAG_LINEA_NUM_AGG; CLASS_SERV; CODE_MACRO_AREA; CODE_IDBRE_DSLAM; FLAG_NUOVO_FEEDER; COUNT_FEEDER; CODICE_PROGETTO_BILL; "+
     "CODICE_QUALITA; CODICE_DELIVERY; CAMPO_SERV_IT; FLAG_MONITORAGGIO; TECNOLOGIA; ID_ORD_CRMWS; CODE_ITRF_FAT_XDSL; ID_CVLAN; "+
     "CODE_TIPO_CAUS_VARIAZ_CONG; CODE_SUPER_MACRO_AREA; FLAG_LA; INSTALLAZIONE; ID_MTCO; CONNETTORE_MTCO; COD_TOPONOMASTICA; "+
     "FLAG_4REFERENTE; TIPO_CPE; FLAG_INTERVENTO; CODE_HOSTING; TECNOLOGIA_FIBRA; FLAG_QUALIFICA; FLAG_TEST2; TIPO_CLUSTER; CODE_CLUSTER; TIPO_FLAG_ACQ_RICH";
     
     return header;   
 }
    public String getResultForInventCSV(ResultInventIav item){
        StringBuilder builder = new StringBuilder();
        
        builder.append( item.getNOME_FILE() + ";");
        builder.append( item.getDATA_ACQ_CHIUS() + ";");
        
        builder.append( item.getCODE_INVENT() + ";");
        builder.append( item.getCODE_TIPO_CAUS() + ";");
        builder.append( item.getCODE_ACCOUNT() + ";");
        builder.append(item.getCODE_CAUS_ORD() + ";");
        builder.append(item.getCODE_STATO_PS() + ";");
        builder.append(item.getCODE_TIPO_OFF() + ";");
        builder.append(item.getCODE_TIPO_CAUS_VARIAZ() + ";");
        builder.append(item.getCODE_PS() + ";");
        builder.append(item.getCODE_TIPO_CONTR() + ";");
        builder.append(item.getDATA_DRO() + ";");
        builder.append(item.getDATA_DVTC() + ";");
        builder.append(item.getDATA_INIZIO_VALID() + ";");
        builder.append(item.getCODE_ISTANZA_PS() + ";");
        builder.append(item.getDATA_FINE_VALID() + ";");
        builder.append(item.getDATA_INIZIO_FATRZ() + ";");
        builder.append(item.getDATA_ULTIMA_FATRZ() + ";");
        builder.append(item.getDATA_FINE_NOL() + ";");
        builder.append(item.getDATA_CESS() + ";");
        builder.append(item.getDATA_VARIAZ() + ";");
        builder.append(item.getDATA_FINE_FATRZ() + ";");
        builder.append(item.getDATA_FATRB() + ";");
        builder.append(item.getQNTA_VALO() + ";");
        builder.append(item.getDATA_ULTIMA_APPL_CANONI() + ";");
        builder.append(item.getCODE_UTENTE_CREAZ() + ";");
        builder.append(item.getDATA_CREAZ() + ";");
        builder.append(item.getCODE_UTENTE_MODIF() + ";");
        builder.append(item.getDATA_MODIF() + ";");
        builder.append(item.getNUM_VARIAZ() + ";");
        builder.append(item.getCODE_PS_FATT_PRINC() + ";");
        builder.append(item.getCODE_AREA_RACCOLTA() + ";");
        builder.append(item.getCODE_NUM_TD() + ";");
        builder.append(item.getCODE_LOTTO() + ";");
        builder.append(item.getCODE_PS_OLD() + ";");
        builder.append(item.getCODE_ISTANZA_OLD() + ";");
        builder.append(item.getTIPO_CONTR_OLD() + ";");
        builder.append(item.getTIPO_FLAG_PROMOZ() + ";");
        builder.append(item.getDESC_CODE_VPI() + ";");
        builder.append(item.getVALO_MCR() + ";");
        builder.append(item.getID_TRASPORTO() + ";");
        builder.append(item.getFLAG_TRASPORTO() + ";");
        builder.append(item.getID_BANDA() + ";");
        builder.append(item.getVALO_PCR_BANDA() + ";");
        builder.append(item.getFLAG_SYS() + ";");
        builder.append(item.getID_ACCESSO() + ";");
        builder.append(item.getID_VC() + ";");
        builder.append(item.getQNTA_VALO_OLD() + ";");
        builder.append(item.getTIPO_PROVENIENZA() + ";");
        builder.append(item.getOPZ_CONTRATTUALE() + ";");
        builder.append(item.getVALO_PCR_UP() + ";");
        builder.append(item.getUTENZA_RIF() + ";");
        builder.append(item.getCODE_OL() + ";");
        builder.append(item.getTIPO_SLA_PLUS() + ";");
        builder.append(item.getOFFERTA_SLA_PLUS() + ";");
        builder.append(item.getCOPERTURA_ORARIA() + ";");
        builder.append(item.getFLAG_DISP() + ";");
        builder.append(item.getOPZ_COMM() + ";");
        builder.append(item.getTIPO_MODULAZ() + ";");
        builder.append(item.getMOD_ACCESSO() + ";");
        builder.append(item.getTIPO_VALID() + ";");
        builder.append(item.getCODICE_PROGETTO() + ";");
        builder.append(item.getTIPO_MOD_FAT() + ";");
        builder.append(item.getDATA_INIZIO_NOL() + ";");
        builder.append(item.getCODE_TIPO_PREST() + ";");
        builder.append(item.getFLAG_ESITO_PREQ() + ";");
        builder.append(item.getBANDA_VL() + ";");
        builder.append(item.getCODE_CLLI() + ";");
        builder.append(item.getCODE_ID_ULLCO() + ";");
        builder.append(item.getCODE_COMUNE() + ";");
        builder.append(item.getCODE_DISTR() + ";");
        builder.append(item.getVALO_MCR_UP() + ";");
        builder.append(item.getID_RIS_OLD() + ";");
        builder.append(item.getPROFILO_ACCESSO() + ";");
        builder.append(item.getMOD_VENDITA() + ";");
        builder.append(item.getFLAG_MODEM() + ";");
        builder.append(item.getTIPO_FAMIGLIA() + ";");
        builder.append(item.getMOD_FATTURAZIONE() + ";");
        builder.append(item.getMOD_FATTURAZIONE_TRASP() + ";");
        builder.append(item.getCODE_PROFILO_ESTESO() + ";");
        builder.append(item.getFLAG_LINEA_NUM_AGG() + ";");
        builder.append(item.getCLASS_SERV() + ";");
        builder.append(item.getCODE_MACRO_AREA() + ";");
        builder.append(item.getCODE_IDBRE_DSLAM() + ";");                     
        builder.append(item.getFLAG_NUOVO_FEEDER() + ";");
        builder.append(item.getCOUNT_FEEDER() + ";");
        builder.append(item.getCODICE_PROGETTO_BILL() + ";");
        builder.append(item.getCODICE_QUALITA() + ";");
        builder.append(item.getCODICE_DELIVERY() + ";");
        builder.append(item.getCAMPO_SERV_IT() + ";");
        builder.append(item.getFLAG_MONITORAGGIO() + ";");
        builder.append(item.getTECNOLOGIA() + ";");
        builder.append(item.getID_ORD_CRMWS() + ";");
        builder.append(item.getCODE_ITRF_FAT_XDSL() + ";");
        builder.append(item.getID_CVLAN() + ";");
        builder.append(item.getCODE_TIPO_CAUS_VARIAZ_CONG() + ";");
        builder.append(item.getCODE_SUPER_MACRO_AREA() + ";");
        builder.append(item.getFLAG_LA() + ";");
        builder.append(item.getINSTALLAZIONE() + ";");
        builder.append(item.getID_MTCO() + ";");
        builder.append(item.getCONNETTORE_MTCO() + ";");
        builder.append(item.getCOD_TOPONOMASTICA() + ";");
        builder.append(item.getFLAG_4REFERENTE() + ";");
        builder.append(item.getTIPO_CPE() + ";");
        builder.append(item.getFLAG_INTERVENTO() + ";");
        builder.append(item.getCODE_HOSTING() + ";");
        builder.append(item.getTECNOLOGIA_FIBRA() + ";");
        builder.append(item.getFLAG_QUALIFICA() + ";");
        builder.append(item.getFLAG_TEST2() + ";");
        builder.append(item.getTIPO_CLUSTER() + ";");
        builder.append(item.getCODE_CLUSTER() + ";");        
        
        builder.append(item.getTIPO_FLAG_ACQ_RICH() + ""); 
        
        return builder.toString();
    }
    
    public String getPathDownload() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        pathDownload = visOrdVal.getPathJPUB2Download();
        
        return pathDownload;
    }
    
}
