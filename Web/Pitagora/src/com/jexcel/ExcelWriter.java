package com.jexcel;
import java.util.*;
import java.text.*;
import java.io.*; 
import jxl.*; 
import jxl.format.Alignment;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.write.*; 
import jxl.format.*;
import com.utl.*;
import java.sql.*;

public class ExcelWriter 
{
  
  private String inputPath;
  private String outputPath;
  private String logPath;
  
  private Hashtable users;

  private WritableWorkbook workbook;
  private WritableSheet sheet0;
  private WritableSheet sheet1;

  private String generationDate;
  
  private String generationDate1;

  private PrintStream log;


  public final static String NOT_IN_STATIC="NOT IN STATIC";
  public final static String OUT_OF_RANGE="OUT OF RANGE";
  public final static String OUT_OF_RANGE_6_MONTH="OUT OF RANGE 6 MONTH";
  public final static String DATE_EQUALS="DATE START EQUALS DATE END";
  public final static String DATE_END_ACCESS="DATE END ACCESS IS NULL";

  private final static int hF=20;
  private final static int wF=4;
  




  private final static WritableFont headerFont = new WritableFont(WritableFont.ARIAL,
                    8,
                    WritableFont.BOLD,
                    false,
                    UnderlineStyle.NO_UNDERLINE,
                    Colour.BLACK);

  private final static WritableFont textFont = new WritableFont(WritableFont.ARIAL,
                    8,
                    WritableFont.NO_BOLD,
                    false,
                    UnderlineStyle.NO_UNDERLINE,
                    Colour.BLACK);


  private final static WritableFont italicFont = new WritableFont(WritableFont.ARIAL,
                    7,
                    WritableFont.NO_BOLD,
                    true,
                    UnderlineStyle.NO_UNDERLINE,
                    Colour.BLACK);


  private final static WritableFont messageFont = new WritableFont(WritableFont.TIMES,
                    8,
                    WritableFont.NO_BOLD,
                    false,
                    UnderlineStyle.NO_UNDERLINE,
                    Colour.BLACK);


  private final static WritableCellFormat headerCellFormat1=new WritableCellFormat(headerFont);
  private final static WritableCellFormat headerCellFormat2=new WritableCellFormat(headerFont);

  private final static WritableCellFormat textCellFormat = new WritableCellFormat(textFont);
  private final static WritableCellFormat italicCellFormat = new WritableCellFormat(italicFont);
  private final static WritableCellFormat messageCellFormat = new WritableCellFormat(messageFont);



  static {
    try {     
      headerCellFormat1.setBackground(Colour.YELLOW);
      headerCellFormat1.setAlignment(Alignment.RIGHT);
      headerCellFormat1.setVerticalAlignment(VerticalAlignment.CENTRE);
      headerCellFormat1.setWrap(true);      
      headerCellFormat1.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
      
      headerCellFormat2.setBackground(Colour.YELLOW);
      headerCellFormat2.setAlignment(Alignment.CENTRE);
      headerCellFormat2.setVerticalAlignment(VerticalAlignment.CENTRE);
      headerCellFormat2.setWrap(true);      
      headerCellFormat2.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
      
      
      textCellFormat.setBackground(Colour.WHITE);
      textCellFormat.setAlignment(Alignment.LEFT);
      textCellFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
      textCellFormat.setWrap(false);      
      textCellFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
      
      
      italicCellFormat.setBackground(Colour.WHITE);
      italicCellFormat.setAlignment(Alignment.LEFT);
      italicCellFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
      italicCellFormat.setWrap(false);      
      italicCellFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
      
      
      messageCellFormat.setBackground(Colour.WHITE);
      messageCellFormat.setAlignment(Alignment.LEFT);
      messageCellFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
      messageCellFormat.setWrap(false);      
      messageCellFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
      
      
      
    }catch(Exception ex){
      System.out.println("Exception ExcelWriter.static: "+ex.toString());
    }
  }


  
  public ExcelWriter(String inputPath, String outputPath, String logPath, Hashtable users)
  {
    this.inputPath = inputPath;
    this.users = users;
    Calendar c = Calendar.getInstance();
    StringBuffer sb = new StringBuffer();
    
    if (c.get(Calendar.DAY_OF_MONTH)<10) sb.append("0");
    sb.append(c.get(Calendar.DAY_OF_MONTH));
    sb.append("/");
    if ((c.get(Calendar.MONTH)+1)<10) sb.append("0");
    sb.append(c.get(Calendar.MONTH)+1);
    sb.append("/");
    sb.append(c.get(Calendar.YEAR));
    this.generationDate1 = new String(sb.toString());
    sb.append(" ");
    if (c.get(Calendar.HOUR_OF_DAY)<10) sb.append("0");
    sb.append(c.get(Calendar.HOUR_OF_DAY));
    sb.append(":");
    if (c.get(Calendar.MINUTE)<10) sb.append("0");
    sb.append(c.get(Calendar.MINUTE));
    sb.append(":");
    if (c.get(Calendar.SECOND)<10) sb.append("0");
    sb.append(c.get(Calendar.SECOND));

    this.generationDate= sb.toString();
    this.outputPath = outputPath+"_"+generationDate.replace('/', '_').replace(':', '_').replace(' ', '_')+".xls";
    this.logPath= logPath+"_"+generationDate.replace('/', '_').replace(':', '_').replace(' ', '_')+".log";

  }


  private boolean writeSheet1(String tipo_tracciamento){
    boolean b = false;
    java.sql.Connection con=null;
    try {
      sheet1 = workbook.createSheet("Tracciamento Dinamico Accessi", 1);
      // altezza/larghezza colonne (il fattore hF è necessario per riportare le dimensioni excel)
      sheet1.setRowView(0, hF*27);
      sheet1.setRowView(1, hF*27);
      sheet1.setRowView(2, hF*21);
      sheet1.setRowView(3, hF*21);
      sheet1.setRowView(4, hF*48);

      sheet1.setColumnView(0, 15);
      sheet1.setColumnView(1, 20);
      sheet1.setColumnView(2, 20);
      sheet1.setColumnView(3, 30);
      sheet1.setColumnView(4, 26);
      sheet1.setColumnView(5, 20);
      sheet1.setColumnView(6, 20);

      // --- SCRITTURA DELL'HEADER (SCRITTURA PER RIGHE)

      // c, r, testo, formato
      Label label = new Label(0,0, "Sistema:", headerCellFormat1);
      sheet1.addCell(label);
      
      label = new Label(1, 0, "JPUB", textCellFormat);
      sheet1.addCell(label);
      
      label = new Label(0, 1, "Data Generazione: (GG/MM/AAAA)", headerCellFormat1);
      sheet1.addCell(label);
      
      label = new Label(1, 1, generationDate1, textCellFormat);
      sheet1.addCell(label);

      /*
      label = new Label(0, 2, "Il tracciamento è necessario per le User ID il cui profilo accede a Dati Riservati degli OLO", textCellFormat);
      sheet1.addCell(label);
      */
      
      label = new Label(0,4, "User ID / Matricola", headerCellFormat2);
      sheet1.addCell(label);

      label = new Label(1,4, "Nome Utente", headerCellFormat2);
      sheet1.addCell(label);

      label = new Label(2,4, "Cognome Utente", headerCellFormat2);
      sheet1.addCell(label);

      label = new Label(3,4, "Funzione di appartenenza/Azienda d’Appartenenza (utente esterno) e Funzione TI di riferimento", headerCellFormat2);
      sheet1.addCell(label);

      label = new Label(4,4, "Profilo di Abilitazione", headerCellFormat2);
      sheet1.addCell(label);

      label = new Label(5,4, "Data e Ora Inizio Accesso (GG/MM/AAAA HH24:MM:SS)", headerCellFormat2);
      sheet1.addCell(label);

      label = new Label(6,4, "Data e Ora Fine Accesso (GG/MM/AAAA HH24:MM:SS)", headerCellFormat2);
      sheet1.addCell(label);

      // --- SCRITTURA DATI
      User u=null;
      User ui = null;
      int r=5;
      String strVetDate;
      Vector vetStrDate;
      
      FileReader fr = new FileReader(inputPath);
      if (fr.open()){
        java.sql.Connection conDate=null;
        Properties pr = new Properties();
        try{
        
          try{
            con = DBManage.getConnection(StaticContext.DSNAME);
          }catch(Exception e){}
        
          String data_oggi = DBManage.getDate(con);
        
          StringTokenizer stzOggi = new StringTokenizer(data_oggi, "/ :.");
          int dateOggi=Integer.parseInt(stzOggi.nextToken());
          int monthOggi=Integer.parseInt(stzOggi.nextToken());
          int yearOggi=Integer.parseInt(stzOggi.nextToken());
          int hrsOggi=Integer.parseInt(stzOggi.nextToken());
          int minOggi=Integer.parseInt(stzOggi.nextToken());
          int secOggi=Integer.parseInt(stzOggi.nextToken());

          if(monthOggi < 7){
            yearOggi = yearOggi - 1;
            switch(monthOggi){
              case 6:
                monthOggi = 12;
                break;
              case 5:
                monthOggi = 11;
                break;
              case 4:
                monthOggi = 10;
                break;
              case 3:
                monthOggi = 9;
                break;
              case 2:
                monthOggi = 8;
                break;
              case 1:
                monthOggi = 7;
                break;
              case 0:
                monthOggi = 6;
                break;
            }
          }else{
            monthOggi = monthOggi - 6;
          }
        
          Calendar dOggi = Calendar.getInstance();
          dOggi.set(yearOggi, monthOggi, dateOggi, hrsOggi, minOggi, secOggi);
        
          while(fr.next()){
            u = fr.getUser();
            ui = (User)users.get(u.getUserID());
            if (ui!=null){
              StringTokenizer stzIniAcc = new StringTokenizer(u.getDataInizioAccesso(), "/ :.");
              int dateIniAcc=Integer.parseInt(stzIniAcc.nextToken());
              int monthIniAcc=Integer.parseInt(stzIniAcc.nextToken());
              int yearIniAcc=Integer.parseInt(stzIniAcc.nextToken());
              int hrsIniAcc=0;
              int minIniAcc=0;
              int secIniAcc=0;
              try {
                hrsIniAcc=Integer.parseInt(stzIniAcc.nextToken());
                minIniAcc=Integer.parseInt(stzIniAcc.nextToken());
                secIniAcc=Integer.parseInt(stzIniAcc.nextToken());
              }catch(Exception ex1){}
              Calendar dIniAcc = Calendar.getInstance();
              dIniAcc.set(yearIniAcc, monthIniAcc, dateIniAcc, hrsIniAcc, minIniAcc, secIniAcc);
              if(dIniAcc.equals(dOggi) || dIniAcc.after(dOggi)){
                if(u.getDataFineAccesso() == null){
                  log.println(fr.getLineNumber()+":"+ui.getUserID()+":"+ExcelWriter.DATE_END_ACCESS);  
                }else if(u.getDataInizioAccesso().equals(u.getDataFineAccesso())){
                  log.println(fr.getLineNumber()+":"+ui.getUserID()+":"+ExcelWriter.DATE_EQUALS);           
                }else{
                  ui.setDataInizioAccesso(u.getDataInizioAccesso());
                  ui.setDataFineAccesso(u.getDataFineAccesso());
                  if (ui.isInRange()){
                    vetStrDate = ui.getVetDateAccessoDisconnessione();
                    if (vetStrDate == null)
                      vetStrDate = new Vector();
                    strVetDate = u.getDataInizioAccesso() + " - " + u.getDataFineAccesso();
                    vetStrDate.add(strVetDate);
                    ui.setVetDateAccessoDisconnessione(vetStrDate);
                  }else {
                    log.println(fr.getLineNumber()+":"+ui.getUserID()+":"+ExcelWriter.OUT_OF_RANGE);
                  }
                }
              }else{
                log.println(fr.getLineNumber()+":"+u.getUserID()+":"+ExcelWriter.OUT_OF_RANGE_6_MONTH);
              }
            }else {
              log.println(fr.getLineNumber()+":"+u.getUserID()+":"+ExcelWriter.NOT_IN_STATIC);
            }
          }

          //Inizio controllo delle date per il tracciamento dinamico per il singolo utente
          Enumeration e = users.elements();
          Vector provaVett = new Vector();
          String dataAccesso = null;
          String dataDisconnessione = null;
          String dataAccessoApp = null;
          String dataDisconnessioneApp = null;
          String profilo_old = null;
          int controllo_profilo = 0;
          int giro = 0;
          SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
          java.util.Date dataInizioApp;
          java.util.Date dataFineApp;
          java.util.Date data;

          while(e.hasMoreElements()) {
            dataAccesso = null;
            dataDisconnessione = null;
            User uStampa = ((User)e.nextElement());
            profilo_old = uStampa.getProfilo();
            provaVett = uStampa.getVetDateAccessoDisconnessione();
            if(provaVett != null)
            {
              Enumeration f = provaVett.elements();
              
              while(f.hasMoreElements()){
                 StringTokenizer stz = new StringTokenizer((String)f.nextElement(), "-");
                 //Controllo se primo elemento del vettore
                 if(giro == 0){
                    dataAccesso = stz.nextToken().trim();
                    dataDisconnessione = stz.nextToken().trim();
                    uStampa.setDataInizioAccesso(dataAccesso);
                    uStampa.setDataFineAccesso(dataDisconnessione);
                    giro = 1;
                 }else{
                    dataAccessoApp = stz.nextToken().trim();
                    dataDisconnessioneApp = stz.nextToken().trim();
                  
                    dataInizioApp = format.parse(dataAccessoApp);
                    dataFineApp = format.parse(dataDisconnessioneApp);
                    data = format.parse(uStampa.getDataFineAccesso());
                    //Controllo date
                    if (data.before(dataInizioApp)){

                        /* scrittura elemento - inizio */
                        Hashtable usersBakup = DBManage.getUsersProfileBackup(con,uStampa.getUserID(), uStampa.getDataInizioAccesso(), uStampa.getDataFineAccesso());
                        Enumeration eb = usersBakup.elements();
                        controllo_profilo = 0;                   
                        while(eb.hasMoreElements()) {
                          User userBackup = ((User)eb.nextElement());
                          uStampa.setProfilo(userBackup.getProfilo());
                          controllo_profilo = 1;
                        }

                        
                        if (controllo_profilo == 0)
                          uStampa.setProfilo(profilo_old);

                        /*se l'utente è UTE devo vedere se esiste per lo stesso utente un profilo diverso
                         * nella tabella i5_6anag_prof_utente *
                         * altrimenti non deve essere scritto nulla per quell'utente*/
                        
                        if(uStampa.getProfilo().equals("Gestione Utenze") &&
                          tipo_tracciamento.equals("DEL_152_02_CONS")){
                          /*utente profilo GESTIONE UTENZE*/   
                          System.out.println("non da scrivere");
                        }else if(!uStampa.getProfilo().equals("Gestione Utenze") &&
                                 tipo_tracciamento.equals("DEL_152_02_CONS")){
                          writeUserAccessRow(r, uStampa);
                          r++;  
                        }else{
                          writeUserAccessRow(r, uStampa);
                          r++;
                        }
                        
                        /* scrittura elemento - fine */
                        dataAccesso = dataAccessoApp;
                        dataDisconnessione = dataDisconnessioneApp;
                        uStampa.setDataInizioAccesso(dataAccesso);
                        uStampa.setDataFineAccesso(dataDisconnessione);                  
                    }else if(data.after(dataInizioApp)){
                        if(dataFineApp.after(data) || dataFineApp.equals(data)){
                          uStampa.setDataFineAccesso(dataDisconnessioneApp); 
                          //System.out.println("Record successivo a cavallo nell'intervallo principale");
                        }else{
                          //System.out.println("Record successivo compreso nell'intervallo principale");
                        }                      
                    }else{
                        //System.out.println("Data inizio successivo uguale o minore a data fine principale");
                        uStampa.setDataFineAccesso(dataDisconnessioneApp);
                    }
                 }
              }
              Hashtable usersBakup = DBManage.getUsersProfileBackup(con,uStampa.getUserID(), uStampa.getDataInizioAccesso(), uStampa.getDataFineAccesso());
              Enumeration eb = usersBakup.elements();
              controllo_profilo = 0;
              while(eb.hasMoreElements()) {
                User userBackup = ((User)eb.nextElement());
                uStampa.setProfilo(userBackup.getProfilo());
                controllo_profilo = 1;
              }

              if (controllo_profilo == 0 )
                uStampa.setProfilo(profilo_old);
              
              /*se l'utente è UTE devo vedere se esiste per lo stesso utente un profilo diverso
               * nella tabella i5_6anag_prof_utente *
               * altrimenti non deve essere scritto nulla per quell'utente*/
                        
              if(uStampa.getProfilo().equals("Gestione Utenze") &&
                tipo_tracciamento.equals("DEL_152_02_CONS")){
                /*utente profilo GESTIONE UTENZE*/   
                System.out.println("non da scrivere");
              }else if(!uStampa.getProfilo().equals("Gestione Utenze") &&
                       tipo_tracciamento.equals("DEL_152_02_CONS")){
                writeUserAccessRow(r, uStampa);
                r++;  
              }else{
                writeUserAccessRow(r, uStampa);
                r++;
              }

              giro = 0;
            }
          }
          b=true;
        }catch(Exception e){
        }finally{
          try {
            DBManage.closeCon(con);
          }catch(Exception ex){
            StaticContext.writeLog(StaticMessages.getMessage(5002,"Exception ExcelWriter.main_jexcel: "+ex.toString()));
          }
        }
      }
      
    }catch(Exception ex){
      System.out.println("Exception ExcelWriter.writeSheet1: "+ex.toString());
    }
    return b;
  }




  private boolean writeSheet0(){
    boolean b = false;
    User u = null;
    String profilo_old = null;
    int controllo_profilo = 0;
    java.sql.Connection con = null;
    
    try {
      sheet0 = workbook.createSheet("Tracciamento Statico", 0);
      // altezza/larghezza colonne (il fattore hF è necessario per riportare le dimensioni excel)
      sheet0.setRowView(0, hF*27);
      sheet0.setRowView(1, hF*27);
      sheet0.setRowView(2, hF*21);
      sheet0.setRowView(3, hF*21);
      sheet0.setRowView(4, hF*48);

      sheet0.setColumnView(0, 15);
      sheet0.setColumnView(1, 20);
      sheet0.setColumnView(2, 20);
      sheet0.setColumnView(3, 26);
      sheet0.setColumnView(4, 44);
      sheet0.setColumnView(5, 14);
      sheet0.setColumnView(6, 14);
      sheet0.setColumnView(7, 24);
      sheet0.setColumnView(8, 14);

      // --- SCRITTURA DELL'HEADER (SCRITTURA PER RIGHE)

      // c, r, testo, formato
      Label label = new Label(0,0, "Sistema:", headerCellFormat1);
      sheet0.addCell(label);
      
      label = new Label(1, 0, "JPUB", textCellFormat);
      sheet0.addCell(label);
      
      label = new Label(0, 1, "Data Generazione: (GG/MM/AAAA)", headerCellFormat1);
      sheet0.addCell(label);
      
      label = new Label(1, 1, generationDate1, textCellFormat);
      sheet0.addCell(label);
  
      label = new Label(0, 2, " *Tali campi sono da prevedere nel tracciamento solo se il sistema in esame prevede la possibilità di modificare l’associazione tra un’utenza e relativo profilo d’abilitazione", italicCellFormat);
      sheet0.addCell(label);
      
      label = new Label(0, 3, "Il tracciamento è necessario per gli eventi di creazione, variazione e annullamento delle abilitazioni per le User ID il cui profilo gestisce Dati Riservati.", textCellFormat);
      sheet0.addCell(label);

      label = new Label(0,4, "User ID / Matricola", headerCellFormat2);
      sheet0.addCell(label);

      label = new Label(1,4, "Nome Utente", headerCellFormat2);
      sheet0.addCell(label);

      label = new Label(2,4, "Cognome Utente", headerCellFormat2);
      sheet0.addCell(label);

      label = new Label(3,4, "Profilo di Abilitazione", headerCellFormat2);
      sheet0.addCell(label);

      label = new Label(4,4, "Funzione di appartenenza/Azienda d’Appartenenza (utente esterno) e Funzione TI di riferimento", headerCellFormat2);
      sheet0.addCell(label);

      label = new Label(5,4, "Data di abilitazione (GG/MM/AAAA)", headerCellFormat2);
      sheet0.addCell(label);

      label = new Label(6,4, "Data disabilitazione (GG/MM/AAAA)", headerCellFormat2);
      sheet0.addCell(label);

      label = new Label(7,4, "Modifiche al Profilo*", headerCellFormat2);
      sheet0.addCell(label);

      label = new Label(8,4, "Data modifica al Profilo* (GG/MM/AAAA)", headerCellFormat2);
      sheet0.addCell(label);

      // --- SCRITTURA DATI
      int r = 5;
      for (Enumeration en = users.keys(); en.hasMoreElements();){

        u = (User)users.get((String)en.nextElement());
      
        /* scrittura elemento - inizio */
        try{
          con = DBManage.getConnection(StaticContext.DSNAME);
        }catch(Exception e){}

        profilo_old = u.getProfilo();
        u.setDataInizioAccesso(DBManage.getDateMinusOrPlusMonth(con,-6));
        u.setDataFineAccesso(DBManage.getDateMinusOrPlusMonth(con,0));
        Hashtable usersBakup = DBManage.getUsersProfileBackup(con,u.getUserID(), u.getDataInizioAccesso(), u.getDataFineAccesso());
        Enumeration eb = usersBakup.elements();
        controllo_profilo = 0;                   
        while(eb.hasMoreElements()) {
          User userBackup = ((User)eb.nextElement());
          u.setProfilo(userBackup.getProfilo());
          controllo_profilo = 1;
          writeUserRow(r++,u);
        }
        if(!con.isClosed())
          con.close();

        u.setProfilo(profilo_old);
        /* scrittura elemento - fine */
        
        writeUserRow(r,u);
        r++;
      }

      b=true;
    }catch(Exception ex){
      System.out.println("Exception ExcelWriter.writeSheet0: "+ex.toString());
    }
    return b;
  }


  public boolean writeFileExcel(String tipo_tracciamento){
    boolean b = false;
    try {

      // impostazione file di log
      log = new PrintStream(new FileOutputStream(logPath));
      
      // impostazione file di output
      workbook = Workbook.createWorkbook(new File(outputPath));
      

      //b = writeSheet0()&&writeSheet1(tipo_tracciamento);
      b = writeSheet1(tipo_tracciamento);

    }catch(Exception ex){
      System.out.println("Exception ExcelWriter.writeFileExcel: "+ex.toString());
      b=false;
    }finally {
      try {
        workbook.write(); 
        workbook.close(); 
      }catch(Exception ex1){}
      try {
        log.flush();
        log.close();
      }catch(Exception ex1){}
    }
    return b;
  }

  private void writeUserRow(int r, User u) throws Exception {
      sheet0.setRowView(5, hF*12);
      
      Label label = new Label(0,r, u.getUserID(), textCellFormat);
      sheet0.addCell(label);

      label = new Label(1,r, u.getNome(), textCellFormat);
      sheet0.addCell(label);

      label = new Label(2,r, u.getCognome(), textCellFormat);
      sheet0.addCell(label);

      label = new Label(3,r, u.getProfilo(), textCellFormat);
      sheet0.addCell(label);

      label = new Label(4,r, u.getFunzione(), textCellFormat);
      sheet0.addCell(label);

      label = new Label(5,r, u.getDataAbilitazione(), textCellFormat);
      sheet0.addCell(label);

      label = new Label(6,r, u.getDataDisabilitazione(), textCellFormat);
      sheet0.addCell(label);

      //label = new Label(6,r, "", textCellFormat);
      //sheet0.addCell(label);

      label = new Label(7,r, u.getModificheProfilo(), textCellFormat);
      sheet0.addCell(label);

      label = new Label(8,r, u.getDataModifica(), textCellFormat);
      sheet0.addCell(label);
  }


  private void writeUserAccessRow(int r, User u) throws Exception {
      sheet1.setRowView(5, hF*12);
      
      Label label = new Label(0,r, u.getUserID(), textCellFormat);
      sheet1.addCell(label);

      label = new Label(1,r, u.getNome(), textCellFormat);
      sheet1.addCell(label);

      label = new Label(2,r, u.getCognome(), textCellFormat);
      sheet1.addCell(label);

      label = new Label(3,r, u.getFunzione(), textCellFormat);
      sheet1.addCell(label);

      label = new Label(4,r, u.getProfilo(), textCellFormat);
      sheet1.addCell(label);

      label = new Label(5,r, u.getDataInizioAccesso(), textCellFormat);
      sheet1.addCell(label);

      label = new Label(6,r, u.getDataFineAccesso(), textCellFormat);
      sheet1.addCell(label);
  }

  public static int main_jexcel(String tipo_tracciamento){
    System.out.println("ExcelWriter main");
    java.sql.Connection con=null;
    String inputFile=null;
    Properties pr = new Properties();      
    System.out.println("ExcelWriter main");
    //inputFile=pr.getProperty("INPUTFILE");
    inputFile=StaticContext.JEXCEL_INPUTFILE;
    System.out.println("ExcelWriter => inputFile => ["+inputFile+"]");
    FileReader fr = new FileReader(inputFile);
    System.out.println ("Checking input file:"+inputFile);
    if (fr.open()) 
      System.out.println ("Checking ok.");
    else
    {
      System.out.println ("Checking ko. File: "+inputFile+" not found.");
      //System.exit(1);
      return -1;
    }

    try{
    
      try{
        con = DBManage.getConnection(StaticContext.DSNAME);
      }catch(Exception e){
        return -1;
      }

      Hashtable users = DBManage.getUsers(con,tipo_tracciamento);
      //Hashtable users = DBManage.getUsers(con,"");
      ExcelWriter ew = null;
    
      if(tipo_tracciamento.equals("DEL_152_02_CONS")){
        ew = new ExcelWriter(inputFile, StaticContext.JEXCEL_OUTPUTFILE_DEL_152, StaticContext.JEXCEL_LOGFILEHEADER, users);
      }else{
        ew = new ExcelWriter(inputFile, StaticContext.JEXCEL_OUTPUTFILE_DLGS_196, StaticContext.JEXCEL_LOGFILEHEADER, users);
      }
    
      ew.writeFileExcel(tipo_tracciamento);
      DBManage.closeCon(con);
      return 0;  
    }catch(Exception e){
      return -1;
    }finally{
      try {
        DBManage.closeCon(con);
      }catch(Exception ex){
        StaticContext.writeLog(StaticMessages.getMessage(5002,"Exception ExcelWriter.main_jexcel: "+ex.toString()));
        return -1;
      }
    }

    
  }

}