package com.taglib;
import javax.servlet.jsp.tagext.*;
import javax.servlet.jsp.*;
import java.io.PrintWriter;
import java.util.Vector;
import javax.naming.Context;
import javax.naming.InitialContext;
import com.utl.*;
import com.ejbSTL.*;
import java.rmi.RemoteException;
import javax.rmi.PortableRemoteObject;

public class TableTariffe extends TagSupport 
{
  private Vector pvct_Tariffe = new Vector();
  private Vector pvct_Regole = new Vector();
  private JspWriter out = null;
  private Ent_TariffeNew lent_TariffeNew = null;
  private Ent_TariffeNewHome lent_TariffeNewHome = null;
  private Ent_RegoleTariffe lent_RegoleTariffe = null;
  private Ent_RegoleTariffeHome lent_RegoleTariffeHome = null;

  private int tipoTariffa; 
  private int CodeServizio;
  private int CodeProdotto;
  private int CodeOfferta;
  private int CodeComponente;
  private int CodePrestAgg;
  private int CodeTariffa;  
  private int CodeClasse = -1;
  private int CodeFascia = -1;
  
  private String ClassRow1 = "row1";
  private String ClassRow2 = "row2";
  private String ClassRowSpecial  = "rowSpecial";
  private String ClassRowSpecial2 = "rowSpecial2";
  private String ClassRowSpecial3 = "rowSpecial3";  
  private String ClassIntest = "rowIntest";
  private String Caption = "";
  private boolean EnableUPD = true;
  private boolean EnableDEL = true;
  private boolean EnableStorico = true;  
  private String HeightRow = "20";

  private String strColSpan = "6";
  private String curClassRow = "";

  /**
   * Method called at start of tag.
   * @return SKIP_BODY
   */
  public int doStartTag() throws JspException
  {
    Context lcls_Contesto = null;
    Object homeObject = null;

    try
    {
      lcls_Contesto = new InitialContext();

      homeObject = lcls_Contesto.lookup("Ent_RegoleTariffe");
      lent_RegoleTariffeHome = (Ent_RegoleTariffeHome)PortableRemoteObject.narrow(homeObject,Ent_RegoleTariffeHome.class);
      lent_RegoleTariffe = lent_RegoleTariffeHome.create();

      homeObject = lcls_Contesto.lookup("Ent_TariffeNew");
      lent_TariffeNewHome = (Ent_TariffeNewHome)PortableRemoteObject.narrow(homeObject, Ent_TariffeNewHome.class);
      lent_TariffeNew = lent_TariffeNewHome.create();

      out = pageContext.getOut();
      if (CodeClasse!=-1 || CodeFascia!=-1)
        loadTableSelectTariffeXTariffePerc();
      else if (CodeTariffa!=0)
        loadTableStoricoTariffe();
      else
          loadTableTariffe();
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }

    return SKIP_BODY;
  }

  /**
   * Method is invoked after every body evaluation to control whether the body will be reevaluated or not.
   * @return SKIP_BODY
   */
  public int doAfterBody() throws JspException
  {
    return SKIP_BODY;
  }

  /**
   * Method called at end of tag.
   * @return EVAL_PAGE
   */
  public int doEndTag()
  {
    return EVAL_PAGE;
  }

  public void setCodeTariffa(int value)
  {
    CodeTariffa = value;
  }

  public int getCodeTariffa()
  {
    return CodeTariffa;
  }

  public void setCodeServizio(int value)
  {
    CodeServizio = value;
  }

  public int getCodeServizio()
  {
    return CodeServizio;
  }

  public void setCodeProdotto(int value)
  {
    CodeProdotto = value;
  }

  public int getCodeProdotto()
  {
    return CodeProdotto;
  }

  public void setTipoTariffa(int value)
  {
    tipoTariffa= value;
  }

  public int getTipoTariffa()
  {
    return tipoTariffa;
  }


  public void setCodeOfferta(int value)
  {
    CodeOfferta = value;
  }

  public int getCodeOfferta()
  {
    return CodeOfferta;
  }

  public void setCodeComponente(int value)
  {
    CodeComponente = value;
  }

  public int getCodeComponente()
  {
    return CodeComponente;
  }

  public void setCodePrestAgg(int value)
  {
    CodePrestAgg = value;
  }

  public int getCodePrestAgg()
  {
    return CodePrestAgg;
  }

  public void setClassRowSpecial(String value)
  {
    ClassRowSpecial = value;
  }

  public String getClassRowSpecial()
  {
    return ClassRowSpecial;
  }

  public void setClassRowSpecial2(String value)
  {
    ClassRowSpecial2 = value;
  }

  public String getClassRowSpecial2()
  {
    return ClassRowSpecial2;
  }

  public void setClassRowSpecial3(String value)
  {
    ClassRowSpecial3 = value;
  }

  public String getClassRowSpecial3()
  {
    return ClassRowSpecial3;
  }

  public void setHeightRow(String value)
  {
    HeightRow = value;
  }

  public String getHeightRow()
  {
    return HeightRow;
  }

  public void setClassRow1(String value)
  {
    ClassRow1 = value;
  }

  public String getClassRow1()
  {
    return ClassRow1;
  }

  public void setClassRow2(String value)
  {
    ClassRow2 = value;
  }

  public String getClassRow2()
  {
    return ClassRow2;
  }

  public void setClassIntest(String value)
  {
    ClassIntest = value;
  }

  public String getClassIntest()
  {
    return ClassIntest;
  }

  public void setCaption(String value)
  {
    Caption = value;
  }

  public String getCaption()
  {
    return Caption;
  }

  public void setEnableUPD(boolean value)
  {
    EnableUPD = value;
  }

  public boolean getEnableUPD()
  {
    return EnableUPD;
  }

  public void setEnableDEL(boolean value)
  {
    EnableDEL = value;
  }

  public boolean getEnableDEL()
  {
    return EnableDEL;
  }

  public void setEnableStorico(boolean value)
  {
    EnableStorico = value;
  }

  public boolean getEnableStorico()
  {
    return EnableStorico;
  }

  private void loadTableStoricoTariffe() throws JspException {
    try{
      DB_TariffeNew objTariffa = null;
      getStoricoTariffe();
      strColSpan = "4";
      objTariffa = (DB_TariffeNew)pvct_Tariffe.get(0);
      out.println("<TABLE width=\"100%\" border=\"0\" cellspacing=\"1\" cellpadding=\"0\">");

      out.print("   <Caption class=\"textB\" align=\"center\">");
      out.print(objTariffa.getDESC_OGGETTO_FATRZ());
      if(!objTariffa.getCODE_TIPO_CAUSALE().equals(""))
       out.print(", causale : " + objTariffa.getDESC_TIPO_CAUSALE());
      out.println("</Caption>");
      
      out.println(" <TR class=\"" + getClassIntest() + "\" align=\"center\" height=\"" + HeightRow +  "\">");
      out.println("   <TD width=\"15\">&nbsp;</TD>");
      out.println("   <TD>Data Inizio</TD>");
      out.println("   <TD>Data Creazione</TD>");
      out.println("   <TD>Stato</TD>");      
      out.println(" </TR>");
      for (int i=0;i<pvct_Tariffe.size();i++){
        writeRiepilogoStorico(i);
        objTariffa = (DB_TariffeNew)pvct_Tariffe.get(i);
        getRegoleStoricoTariffa(CodeTariffa,objTariffa.getDATA_CREAZ_TARIFFA());
        i=writeDettaglio(i);
      }          
      out.print("</TABLE>");
    }
    catch(Exception lexc_Exception) {
        System.out.println(lexc_Exception.getMessage());
        lexc_Exception.printStackTrace();
        throw new JspException(lexc_Exception.toString());
    }   

  }


  private void writeRiepilogoStorico(int Index)  throws JspException{
    DB_TariffeNew objTariffa = null;
    String strFlagProvv = "";

    objTariffa = (DB_TariffeNew)pvct_Tariffe.get(Index);

    curClassRow = curClassRow.equals(getClassRow2()) ? getClassRow1() : getClassRow2();

    try{
        strFlagProvv = getFlagProvvisoria(Index);
        out.println("<TR class=\"" + curClassRow + "\" align=\"center\" height=\"" + HeightRow + "\">");
        out.print("  <TD width=\"15\" class=\"textB\" align=\"center\" onclick=\"Expand('TAR" + "+" + getIdTariffa() + "+" + objTariffa.getCODE_TARIFFA() + "-" + objTariffa.getCODE_PR_TARIFFA() + "',this)\" style=\"CURSOR: hand\">");
        out.println("+</TD>");
        out.print("  <TD>");
        out.println(objTariffa.getDATA_INIZIO_VALID() + "</TD>");
        out.print("  <TD>");
        out.println(objTariffa.getDATA_CREAZ_TARIFFA() + "</TD>");
        out.print("  <TD>");         
        if(strFlagProvv.equals("N"))
          out.print("Nuova");         
        else if(strFlagProvv.equals("D"))
          out.print("Definitiva");         
        else if(strFlagProvv.equals("P"))
          out.print("Provvisoria");         
        out.println("  </TD>");
        out.println("</TR>");
    }
    catch(Exception exception)
    {
        System.out.println(exception.getMessage());
        exception.printStackTrace();
        throw new JspException(exception.toString());
    }
  }

  private void writeRiepilogoTariffeXtariffePerc(int Index)  throws JspException{
    DB_TariffeNew objTariffa = null;
    String strFlagProvv = "";

    objTariffa = (DB_TariffeNew)pvct_Tariffe.get(Index);

    curClassRow = curClassRow.equals(getClassRow2()) ? getClassRow1() : getClassRow2();     

    try{
        strFlagProvv = getFlagProvvisoria(Index);
        out.println("<TR class=\"" + curClassRow + "\" align=\"center\" height=\"" + HeightRow + "\">");
        out.print("  <TD width=\"15\" class=\"textB\" align=\"center\" onclick=\"Expand('TAR" + "+" + getIdTariffa() + "+" + objTariffa.getCODE_TARIFFA() + "-" + objTariffa.getCODE_PR_TARIFFA() + "',this)\" style=\"CURSOR: hand\">");
        out.println("+</TD>");
        out.print("  <TD>");
        out.println(objTariffa.getDESC_PRODOTTO() + "<BR>" + objTariffa.getDESC_COMPONENTE() + "<BR>" + objTariffa.getDESC_PREST_AGG() + "</TD>");
        out.print("  <TD>");
        out.println(objTariffa.getDESC_OGGETTO_FATRZ() + "</TD>");
        out.print("  <TD>");
        out.println(objTariffa.getDESC_TIPO_CAUSALE() + "</TD>");
        out.print("  <TD>");
        out.println(objTariffa.getDATA_INIZIO_VALID() + "</TD>");
        out.println("<TD><input type=\"checkbox\" name=\"CodeTariffa\" value=\"" + objTariffa.getCODE_TARIFFA() + 
              "\" OggettoFatturazione=\"" + objTariffa.getDESC_OGGETTO_FATRZ() + "\"" +
              " ModalitaApplicazione=\"" + objTariffa.getDESC_MODAL_APPL_TARIFFA() + "\"" +
              " Prodotto=\"" + objTariffa.getDESC_PRODOTTO() + "\"" +
              " Componente=\"" + objTariffa.getDESC_COMPONENTE() + "\"" +
              " PrestAgg=\"" + objTariffa.getDESC_PREST_AGG() + "\"" +               
              " Dettaglio=\"" + getDettaglioTariffa(objTariffa) + "\"" +
              " TipoCausale=\"" + objTariffa.getDESC_TIPO_CAUSALE() + "\"" +
              " DataInizio=\"" + objTariffa.getDATA_INIZIO_VALID() + "\"" + 
              "\">");
        out.println("</TR>");
    }
    catch(Exception exception)
    {
        System.out.println(exception.getMessage());
        exception.printStackTrace();
        throw new JspException(exception.toString());
    }
  }
  
  private void loadTableTariffe() throws JspException {

    try{
        int Index = 0;
        getTariffe();
        strColSpan = "6";
        out.print("<TABLE align=\"center\" width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"");
        out.println("name=\"TABLE-" + getIdTariffa() + "\" id=\"TABLE-" + getIdTariffa() + "\" style=\"display:none\">");
        if(!Caption.equals(""))
        out.println("  <Caption class=\"textB\" align=\"center\">" + Caption + "</Caption>");
        out.println("  <TR>");
        out.println("     <TD>");
        out.println("        <TABLE width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\">");
        out.println("           <TR>");
        out.println("              <TD class=\"white\" colspan=\"2\">");
        out.println("                 <TABLE width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"1\" align=\"center\">");
        out.println("                   <TR>");
        out.println("                      <TD>");
        writeIntestazioneTab();
        out.println("                      </TD>");
        out.println("                   </TR>");
        out.println("                   <TR>");
        out.println("                      <TD>");
        Index = writeTabellaTariffa(Index,false);
        Index = writeTabellaTariffa(Index,true);
        out.println("                      </TD>");
        out.println("                   </TR>");
        out.println("                 </TABLE>");
        out.println("              </TD>");
        out.println("           </TR>");        
        out.println("        </TABLE>");                
        out.println("     </TD>");                        
        out.println("  </TR>");                                
        out.println("</TABLE>");                        
    }
    catch(Exception exception){
        System.out.println(exception.getMessage());
        exception.printStackTrace();
        throw new JspException(exception.toString());
    }
  }

  private void getTariffe() throws CustomException, RemoteException{

    try{
      pvct_Tariffe = lent_TariffeNew.getListaTariffe(getCodeServizio(),getCodeOfferta(),
        getCodeProdotto(),getCodeComponente(),getCodePrestAgg(),getTipoTariffa());
    }
    catch(Exception lexc_Exception) {
        throw new CustomException(lexc_Exception.toString(), "", "getTariffe",
                      this.getClass().getName(), StaticContext.FindExceptionType(lexc_Exception));
    }   
  }

  private void getStoricoTariffe() throws CustomException, RemoteException{

    try{
      pvct_Tariffe = lent_TariffeNew.getStoricoTariffa(CodeTariffa,tipoTariffa);
    }
    catch(Exception lexc_Exception) {
        throw new CustomException(lexc_Exception.toString(), "", "getStoricoTariffe",
                      this.getClass().getName(), StaticContext.FindExceptionType(lexc_Exception));
    }   
  }

  private void getTariffeXTariffePercentuale() throws CustomException, RemoteException{

    try{
    
      pvct_Tariffe = lent_TariffeNew.getListaTariffeRiferimXPerc(CodeServizio,CodeOfferta,CodeClasse,CodeFascia,tipoTariffa);
    }
    catch(Exception lexc_Exception) {
        throw new CustomException(lexc_Exception.toString(), "", "getStoricoTariffe",
                      this.getClass().getName(), StaticContext.FindExceptionType(lexc_Exception));
    }   
  }

  private void getRegoleTariffa(int CodeTariffa) throws CustomException, RemoteException{

    try{
      pvct_Regole = lent_RegoleTariffe.getRegoleTariffa(CodeTariffa,tipoTariffa);
    }
    catch(Exception lexc_Exception) {
        throw new CustomException(lexc_Exception.toString(), "", "getRegoleTariffa",
                      this.getClass().getName(), StaticContext.FindExceptionType(lexc_Exception));
    }   
  }

  private void getRegoleStoricoTariffa(int CodeTariffa,String DataCreazione) throws CustomException, RemoteException{

    try{
      pvct_Regole = lent_RegoleTariffe.getStoricoRegoleTariffa(CodeTariffa,DataCreazione);
    }
    catch(Exception lexc_Exception) {
        throw new CustomException(lexc_Exception.toString(), "", "getRegoleStoricoTariffa",
                      this.getClass().getName(), StaticContext.FindExceptionType(lexc_Exception));
    }   
  }

  private void writeIntestazioneTab() throws JspException{
    try{
      out.println("<TABLE width=\"100%\" border=\"1\" cellspacing=\"0\" cellpadding=\"1\" bgcolor=\"" +  StaticContext.bgColorHeader + "\" bordercolor=\"" + StaticContext.bgColorHeader + "\">");
      out.println("  <TR align=\"center\">");
      out.print("    <TD bgcolor=\"" + StaticContext.bgColorTabellaForm + "\"");
      out.print(" name=\"TD-" + getIdTariffa() + "\" id=\"TD-" + getIdTariffa() + "\"");
      out.println("class=\"blackB\" width=\"250\" onclick=\"CambiaTab('TAR-" + getIdTariffa() + "',this)\" style=\"CURSOR: hand\">");
      out.println("    Tariffe</TD>");
      out.print("    <TD bgcolor=\""+ StaticContext.bgColorHeader + "\"");
      out.print(" name=\"TDPC-" + getIdTariffa() + "\" id=\"TDPC-" + getIdTariffa() + "\"");
      out.println("class=\"white\" width=\"250\" onclick=\"CambiaTab('TARPC-" + getIdTariffa() + "',this)\" style=\"CURSOR: hand\">");
      out.println("    Tariffe per causale</TD>");
      out.println("    <TD bgcolor=\""+ StaticContext.bgColorHeader + "\" class=\"white\"></TD>");
      out.println("    <TD bgcolor=\""+ StaticContext.bgColorCellaBianca + "\" class=\"white\" align=\"center\" width=\"9%\">");
      out.println("      <IMG height=\"8\" alt=\"immagine\" src=\"" + StaticContext.PH_COMMON_IMAGES + "quad_blu.gif\" width=\"8\">");
      out.println("    </TD>");
      out.println("  </TR>");
      out.println("</TABLE>");
    }
    catch(Exception exception)
    {
        System.out.println(exception.getMessage());
        exception.printStackTrace();
        throw new JspException(exception.toString());
    }
  }

  private void writeRiepilogo(int Index,boolean Causale)  throws JspException{
    
    DB_TariffeNew objTariffa = null;

    objTariffa = (DB_TariffeNew)pvct_Tariffe.get(Index);

   String Code_Componente = String.valueOf(getCodeComponente());
   String Code_PrestAgg = String.valueOf(getCodePrestAgg());
   String Code_Prodotto = String.valueOf(getCodeProdotto());

   curClassRow = curClassRow.equals(getClassRow2()) ? getClassRow1() : getClassRow2();     

/*  martino 08-03-2004 INIZIO */
    /* Controllo La tariffa presente e se
     * Tariffa 
     *            Codice Prodotto           NULL
     *  ( Catalogo 
     *            Codice della componente   NOT NULL
     *  
     *    OPPURE 
     *    Catalogo 
     *            Codice della componente   NULL
     *            Codice della prestazione  NOT NULL
     * Le tariffe vengono evidenziate in marroncino ClassRowSpecial */

    if(objTariffa.getCODE_PRODOTTO().equals(""))
      if (  !Code_Componente.equals("0")|| 
            (Code_Componente.equals("0")&&!Code_PrestAgg.equals("0"))
          )
      curClassRow = ClassRowSpecial;

    /* Controllo La tariffa presente e se
     * Tariffa 
     *            Codice del   prodotto     NOT NULL
     *            Codice della componente   NULL
     *            Codice della prestazione  NOT NULL
     * Catalogo 
     *            Codice della componente   NOT NULL
     *            Codice della prestazione  NOT NULL
     *            
     * Le tariffe vengono evidenziate in Giallino ClassRowSpecial2 */
    if (  (!objTariffa.getCODE_PRODOTTO().equals("")) && (objTariffa.getCODE_COMPONENTE().equals("")) && (!objTariffa.getCODE_PREST_AGG().equals(""))
              && !Code_Componente.equals("0") && !Code_PrestAgg.equals("0")  )
      curClassRow = ClassRowSpecial2;

    /* Controllo La tariffa presente e se
     * Tariffa 
     *            Codice del   prodotto     NULL
     *            Codice della componente   NULL
     * Catalogo 
     *            Codice della componente   NOT NULL
     *            Codice della prestazione  NOT NULL
     *            
     * Le tariffe vengono evidenziate in Rossiccio ClassRowSpecial3 */
    if ( (objTariffa.getCODE_COMPONENTE().equals("")) && (objTariffa.getCODE_PRODOTTO().equals(""))
              && !Code_Componente.equals("0") && !Code_PrestAgg.equals("0")  )
      curClassRow = ClassRowSpecial3;
/*  martino 08-03-2004 FINE  */

    try{
        out.println("<TR class=\"" + curClassRow + "\" align=\"center\" height=\"" + HeightRow + "\">");
        out.print("  <TD class=\"textB\" align=\"center\" onclick=\"Expand('TAR" + "+" + getIdTariffa() + "+" + objTariffa.getCODE_TARIFFA() + "-" + objTariffa.getCODE_PR_TARIFFA() + "',this)\" style=\"CURSOR: hand\">");
        out.println("+</TD>");
        out.print("  <TD align=\"left\">");
        out.println(objTariffa.getDESC_OGGETTO_FATRZ() + "</TD>");
        out.print("  <TD align=\"left\">");
        out.println(objTariffa.getDESC_MODAL_APPL_TARIFFA() + "</TD>");
        out.println("  <TD align=\"left\">" + getDettaglioTariffa(objTariffa) + "</TD>");
        if(Causale)
          out.println("  <TD align=\"left\">" + objTariffa.getDESC_TIPO_CAUSALE() + "</TD>");
        out.println("  <TD>" + objTariffa.getDATA_INIZIO_VALID() + "</TD>");
        out.print("  <TD nowrap>");
        if(getEnableUPD()==true){
          out.print("    <IMG style=\"CURSOR: hand\" onclick=\"ApriDettaglio('" + objTariffa.getCODE_TARIFFA() + "')\"");
          out.println("height=\"13\" alt=\"modifica\\aggiorna\" src=\"" + StaticContext.PH_COMMON_IMAGES + "editrow2.gif\" width=\"14\">");
        }
        //if(lent_TariffeNew.isDeletable(Integer.parseInt(objTariffa.getCODE_TARIFFA())) && getEnableDEL()==true){                
        //Abilitata cancellazione anche nel caso di presenza in tariffa_x_tariffa_perc
        if(objTariffa.getTIPO_FLAG_PROVVISORIA().equals("N") && getEnableDEL()==true){
          out.print("    <IMG style=\"CURSOR: hand\" onclick=\"EliminaTariffa('" + objTariffa.getCODE_TARIFFA() + "')\"");
          out.println("alt=\"elimina\" src=\"" + StaticContext.PH_COMMON_IMAGES + "delete.gif\">");
        }
        if(getEnableStorico()==true){
          out.print("    <IMG style=\"CURSOR: hand\" onclick=\"StoricoTariffa('" + objTariffa.getCODE_TARIFFA() + "')\"");
          out.println("alt=\"storico\" src=\"" + StaticContext.PH_COMMON_IMAGES + "Storico.gif\">");
        }
        out.println("  </TD>");
        out.println("</TR>");
    }
    catch(Exception exception)
    {
        System.out.println(exception.getMessage());
        exception.printStackTrace();
        throw new JspException(exception.toString());
    }
  }

  private int writeDettaglio(int Index) throws JspException{

    DB_TariffeNew objTariffa = null;
    
    String strCodeTariffa = "";
    String strCodePrTariffa = "";
    String strDataCreazione = "";
    String strCodeFascia = null;
    String strCodeSconto = null;
    String strElem = "";
    int Intest = 0;
    Vector vctIntestazione = new Vector();
    Vector vctRows = new Vector();
    Vector vctRow = new Vector();

    //pvct_Regole.clear();
    
    try{
        
    objTariffa = (DB_TariffeNew)pvct_Tariffe.get(Index);
    strCodeTariffa = objTariffa.getCODE_TARIFFA();
    strDataCreazione = objTariffa.getDATA_CREAZ_TARIFFA();
    strCodePrTariffa = objTariffa.getCODE_PR_TARIFFA();

    while(strCodeTariffa.equals(objTariffa.getCODE_TARIFFA()) && 
      strDataCreazione.equals(objTariffa.getDATA_CREAZ_TARIFFA())){
       //Scorro il vettore delle tariffe e prendo i dati per l'intestazione
       // e gli importi
       if(strCodeSconto==null || !strCodeSconto.equals(objTariffa.getCODE_PR_CLAS_SCONTO())){

          strCodeSconto = objTariffa.getCODE_PR_CLAS_SCONTO();

          if (!objTariffa.getCODE_PR_CLAS_SCONTO().equals("")){
            strElem = "da " + objTariffa.getIMPT_MIN_SPESA();
            if (!objTariffa.getIMPT_MAX_SPESA().equals(""))
              strElem += " a " + objTariffa.getIMPT_MAX_SPESA();
          }
          else{
             strElem = "Tariffa";
          }
          vctIntestazione.addElement(strElem);
       }
       if(strCodeFascia==null || !strCodeFascia.equals(objTariffa.getCODE_PR_FASCIA())){
          if (vctRow.size()>0){
            vctRows.addElement(vctRow);
            vctRow = new Vector();
          }
          strCodeFascia=objTariffa.getCODE_PR_FASCIA();
          
          if (!objTariffa.getCODE_FASCIA().equals("")){
            strElem = "da " + objTariffa.getDESC_UNITA_MISURA() + " " + objTariffa.getVALO_LIM_MIN();
            if (!objTariffa.getVALO_LIM_MAX().equals("")) 
              strElem +=  " a " + objTariffa.getDESC_UNITA_MISURA() + " " + objTariffa.getVALO_LIM_MAX();
          }
          else{
            strElem = "Fascia Non Applicabile";
          }

          vctRow.addElement(strElem);

       }
       vctRow.addElement(objTariffa.getIMPT_TARIFFA());

       Index++;

       if (Index>=pvct_Tariffe.size()) break;
       
       objTariffa = (DB_TariffeNew)pvct_Tariffe.get(Index);
    }

    Index--;
    vctRows.addElement(vctRow);
    Intest = vctRow.size() -1;

    int withCol = 100 / (Intest + 1);
    
    out.println("<TR bgcolor=\"white\" align=\"center\" name=\"TAR" + "+" + getIdTariffa() + "+" + strCodeTariffa + "-" + strCodePrTariffa + "\" id=\"TAR" +  "+" + getIdTariffa() + "+" + strCodeTariffa + "-" + strCodePrTariffa + "\" style=\"DISPLAY: none\">");
    out.println("    <TD colspan=\"" + strColSpan + "\">");
    out.println("        <TABLE width=\"100%\" border=\"0\" cellspacing=\"2\" cellpadding=\"0\">");
    out.println("            <TR>");
    if(pvct_Regole.size()>0){
      out.println("                <TD width=\"15\" background=\"" + StaticContext.PH_COMMON_IMAGES + "i.gif\">");
      out.println("                   <IMG alt=\"immagine\" src=\"" + StaticContext.PH_COMMON_IMAGES + "t.gif\">");
      out.println("                </TD>");
    }
    else{
      out.println("                <TD width=\"15\" valign=\"top\">");
      out.println("                   <IMG alt=\"immagine\" src=\"" + StaticContext.PH_COMMON_IMAGES + "l.gif\">");
      out.println("                </TD>");
    }
    out.println("                <TD class=\"text\" align=\"left\">");
    out.println("                   <TABLE width=\"70%\" border=\"0\" cellspacing=\"1\" cellpadding=\"1\">");
    out.println("                      <TR align=\"center\">");
    out.println("                          <TD class=\"" + getClassIntest() +  "\" width=\"" + withCol + "%\"></TD>");
    for (int j=0;j<Intest;j++){
      out.println("                          <TD class=\"" + getClassIntest() +  "\" width=\"" + withCol + "%\" align=\"center\" nowrap>");
      out.println("                             " + (String)vctIntestazione.get(j) );      
      out.println("                          </TD>");
    }
    out.println("                      </TR>");   
    for (int j=0;j<vctRows.size();j++){
      if ((j%2)>0){
        out.println("                      <TR class=\"" + getClassRow1() + "\" align=\"center\">");
      }
      else{
        out.println("                      <TR class=\"" + getClassRow2() + "\" align=\"center\">");
      }

      vctRow = (Vector)vctRows.get(j);

      for (int z=0;z<vctRow.size();z++){
        if(z==0){
          out.println("                         <TD align=\"left\" nowrap>");
          out.println("                         " + (String)vctRow.get(z)); 
        }
        else{
          out.println("                         <TD align=\"right\">");
        /*  out.println("                         " + CustomNumberFormat.setToCurrencyFormat((String)vctRow.get(z))); */
         out.println("                         " + CustomNumberFormat.setToCurrencyFormat((String)vctRow.get(z),2,6));
        }
        
        out.println("                        </TD>");
      }
      out.println("                      </TR>");
    }
    
    out.println("                   </TABLE>");
    out.println("                </TD>");
    out.println("            </TR>");
    writeRegole();
    out.println("        </TABLE>");      
    out.println("    </TD>");
    out.println("</TR>");

    return Index;
    }
    catch(Exception exception)
    {
        System.out.println(exception.getMessage());
        exception.printStackTrace();
        throw new JspException(exception.toString());
    }
  }

  private void writeRegole() throws JspException{
    try{
      //Reperisco e visualizzo le regole relative alla tariffa

      if (pvct_Regole.size()>0){
      
        DB_RegolaTariffa objRegolaTariffa = null;
        out.println("<TR>");
        out.println("  <TD width=\"15\" valign=\"top\">");
        out.println("    <IMG alt=\"immagine\" src=\"" + StaticContext.PH_COMMON_IMAGES + "l.gif\">");
        out.println("  </TD>");
        out.println("  <TD align=\"left\">");
        out.println("    <TABLE width=\"70%\" border=\"0\" cellspacing=\"1\" cellpadding=\"1\">");
        out.println("      <TR class=\"" + getClassIntest() + "\"align=\"center\">");
        out.println("        <TD>Nome regola</TD>");
        out.println("        <TD>Parametro</TD>");
        out.println("      </TR>");

        for(int i=0;i<pvct_Regole.size();i++){
          if((i%2)>0) out.println("      <TR class=\"" + ClassRow1 + "\" align=\"center\">");
          else out.println("      <TR class=\"" + ClassRow2 + "\" align=\"center\">");
          objRegolaTariffa = (DB_RegolaTariffa)pvct_Regole.get(i);
          out.println("        <TD>" +  objRegolaTariffa.getDESC_REGOLA() + "</TD>");
          //modifica 10032014 
          if(objRegolaTariffa.getCODE_REGOLA().equals("13"))
             out.println("        <TD>" +  objRegolaTariffa.getDESC_ACCOUNT() + "</TD>");
           else
              out.println("        <TD>" +  objRegolaTariffa.getPARAMETRO() + "</TD>");
          out.println("      </TR>");
        }
      
        out.println("    </TABLE>");
        out.println("  </TD>");
        out.println("</TR>");
      }
    }
    catch(Exception exception)
    {
          System.out.println(exception.getMessage());
          exception.printStackTrace();
          throw new JspException(exception.toString());
    }
  }

  private String getIdTariffa(){
    //"Codice identificativo" Identificativo della tabella della tariffa
    //Ogni suo componente sarà identificato da suffisso seguito dal codice identificativo della tabella
    //Es  TABLE-PROD1COMP1PRAG1,TARIFFA-PROD1COMP1PRAG1,TARCAUSALE-PROD1COMP1PRAG1
    return "PROD" + String.valueOf(getCodeProdotto()) + "COMP" + String.valueOf(getCodeComponente()) + "PRAG" + String.valueOf(getCodePrestAgg());
  }

  private String getDettaglioTariffa(DB_TariffeNew objTariffa){
    String strDettaglio="";
    if(objTariffa.getTIPO_FLAG_ANT_POST().equals("U"))
      strDettaglio += "Una tantum";
    else if(objTariffa.getTIPO_FLAG_ANT_POST().equals("C"))
          strDettaglio += "Una tantum cessazione";    //DOR ADD
    else if(objTariffa.getTIPO_FLAG_ANT_POST().equals("A"))
      strDettaglio += "Anticipata";    
    else if(objTariffa.getTIPO_FLAG_ANT_POST().equals("P"))
      strDettaglio += "Posticipata";    
    if(!objTariffa.getVALO_FREQ_APPL().equals(""))
      strDettaglio += ",Frequenza:" + objTariffa.getVALO_FREQ_APPL();
    if(!objTariffa.getQNTA_SHIFT_CANONI().equals(""))
      strDettaglio += ",Shift:" + objTariffa.getQNTA_SHIFT_CANONI();
    return strDettaglio;
  }

  private int writeTabellaTariffa(int Index,boolean Causale) throws JspException{

    DB_TariffeNew objTariffa = null;
    int i;
    
    try{
        out.print("<TABLE width=\"100%\" border=\"0\" cellspacing=\"1\" cellpadding=\"0\"");
        if(Causale){
          out.print(" style=\"display:none\"");        
          out.println(" name=\"TARPC-" + getIdTariffa() + "\" id=\"TARPC-" + getIdTariffa() + "\">");
        }
        else{          
          out.println(" name=\"TAR-" + getIdTariffa() + "\" id=\"TAR-" + getIdTariffa() + "\">");
        }      

        writeIntestazioneTariffa(Causale);
        
        for (i=Index;i<pvct_Tariffe.size();i++){
          objTariffa = (DB_TariffeNew)pvct_Tariffe.get(i);
          
          if(Causale != !objTariffa.getCODE_TIPO_CAUSALE().equals("")){
            break;
          }
          
          writeRiepilogo(i,Causale);
          getRegoleTariffa(Integer.parseInt(objTariffa.getCODE_TARIFFA()));
          i=writeDettaglio(i);
        }          

        out.print("</TABLE>");           
        return i;
    }
    catch(Exception exception)
    {
        System.out.println(exception.getMessage());
        exception.printStackTrace();
        throw new JspException(exception.toString());
    }
  }

  private void writeIntestazioneTariffa(boolean Causale) throws JspException{
    try{
       out.println("<TR class=\"" + getClassIntest() + "\" align=\"center\" height=\"" + HeightRow +  "\">");
       out.println("<TD width=\"15\">&nbsp;</TD>");
       out.println("<TD>Descrizione</TD>");
       out.println("<TD>Mod. applic.</TD>");
       out.println("<TD>Dettaglio</TD>");
       if(Causale)
       out.println("<TD>Causale</TD>");
       out.println("<TD>Data Inizio</TD>");
       out.println("<TD>&nbsp;</TD>");
       out.println("</TR>");
          
    }
    catch(Exception exception)
    {
        System.out.println(exception.getMessage());
        exception.printStackTrace();
        throw new JspException(exception.toString());
    }
  }

  private String getFlagProvvisoria(int Index)  throws JspException
  {
    DB_TariffeNew objTariffa = null;
    String strCodeTariffa = "";
    String flagProv = "N";
    int i = Index;

    objTariffa = (DB_TariffeNew)pvct_Tariffe.get(i);
    
    strCodeTariffa = objTariffa.getCODE_TARIFFA();

    while(strCodeTariffa.equals(objTariffa.getCODE_TARIFFA())){
      if(objTariffa.getTIPO_FLAG_PROVVISORIA().equals("D"))
      {
        return "D";
      }
      if(objTariffa.getTIPO_FLAG_PROVVISORIA().equals("P"))
      {
        flagProv = "P";
      }
      i++;
      if (i>=pvct_Tariffe.size()) break;
      objTariffa = (DB_TariffeNew)pvct_Tariffe.get(i);
    }
    return flagProv;
  }

  private void loadTableSelectTariffeXTariffePerc() throws JspException {
    try{
      DB_TariffeNew objTariffa = null;
      getTariffeXTariffePercentuale();
      strColSpan = "4";
      if(pvct_Tariffe.size()>0){
        objTariffa = (DB_TariffeNew)pvct_Tariffe.get(0);
        out.println("<TABLE width=\"100%\" border=\"0\" cellspacing=\"1\" cellpadding=\"0\">");

        /*out.print("   <Caption class=\"textB\" align=\"center\">");
        out.print(objTariffa.getDESC_OGGETTO_FATRZ());
        if(!objTariffa.getCODE_TIPO_CAUSALE().equals(""))
         out.print(", causale : " + objTariffa.getDESC_TIPO_CAUSALE());
        out.println("</Caption>");*/
      
        out.println(" <TR class=\"" + getClassIntest() + "\" align=\"center\" height=\"" + HeightRow +  "\">");
        out.println("   <TD width=\"15\">&nbsp;</TD>");   
        out.println("   <TD>Prod.-Comp.-Prest.Agg.</TD>");
        out.println("   <TD>Oggetto Fatturazione</TD>");
        out.println("   <TD>Causale</TD>");
        out.println("   <TD>Data Inizio</TD>");
        out.println("   <TD width=\"15\">&nbsp;</TD>");
        out.println(" </TR>");
        for (int i=0;i<pvct_Tariffe.size();i++){
          writeRiepilogoTariffeXtariffePerc(i);
          objTariffa = (DB_TariffeNew)pvct_Tariffe.get(i);
          getRegoleTariffa(Integer.parseInt(objTariffa.getCODE_TARIFFA()));
          i=writeDettaglio(i);
        }          
        out.print("</TABLE>");
      }
      else{
        out.print("<P align=\"center\" valign=\"middle\" class=\"textB\">");
        out.print("<FONT class=\"textMsg\" id=\"msg\" name=\"msg\">");
        out.print("Nessuna tariffa trovata!");
        out.print("</FONT>");
        out.print("</P>");
      }
    }
    catch(Exception lexc_Exception) {
        System.out.println(lexc_Exception.getMessage());
        lexc_Exception.printStackTrace();
        throw new JspException(lexc_Exception.toString());
    }   

  }


  public void setCodeClasse(int value)
  {
    CodeClasse = value;
  }


  public int getCodeClasse()
  {
    return CodeClasse;
  }


  public void setCodeFascia(int value)
  {
    CodeFascia = value;
  }


  public int getCodeFascia()
  {
    return CodeFascia;
  }
}