import javax.servlet.*; 
import javax.servlet.http.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import java.io.*;
import java.util.*;

public class AjaxHelloWorld extends HttpServlet {

  private static final String separatore = "|";
  private static final String CONTENT_TYPE = "text/html";
  private ServletContext context;
  private Dipendente dip = null;
  
  private HashMap<String, String> capProv = new HashMap<String, String>();
  private HashMap<String, String> cittaReg = new HashMap<String, String>();

  public void init(ServletConfig config) throws ServletException {
    super.init(config);
    context = config.getServletContext();

    dip = new Dipendente(context);
    
    capProv.put("75100", "Matera");
    capProv.put("67100", "L'Aquila");

    cittaReg.put("Matera", "Basilicata");
    cittaReg.put("L'Aquila", "Abruzzo");

  }
  
  public void doGet(HttpServletRequest request,
                    HttpServletResponse response) 
                           throws ServletException, IOException {
    response.setContentType(CONTENT_TYPE);
    PrintWriter out = response.getWriter();
    
    String zip = request.getParameter("cap");
    String citta = capProv.get(zip);
    String regione = cittaReg.get(citta);
    if (citta != null)
      out.println(citta + separatore + regione);
    else
      out.println("Errore");
  }

  public void doPost(HttpServletRequest request,
                    HttpServletResponse response) 
                           throws ServletException, IOException {

    response.setContentType(CONTENT_TYPE);
    response.setHeader("Cache-Control", "no-cache");
    PrintWriter out = response.getWriter();

    String matricola = request.getParameter("matricola");
    
    String[] coNo = dip.getCognomeNome(matricola);
        
    if (coNo != null) {
      out.println(coNo[0] + separatore + coNo[1]);
    }
    else {
      out.println("Errore");
    }
  }

  public void destroy() {
  
    System.out.println("Istanza distrutta");

    // shut down del database
    boolean gotSQLExc = false;
    try {
      try {
        DriverManager.getConnection("jdbc:derby:;shutdown=true");
      }
      catch (SQLException se) {
        gotSQLExc = true;
      }

      if (!gotSQLExc) {
        System.out.println("Shut down non normale del database");
      } else {
        System.out.println("Shut down normale del database");
      }
    }
    catch (Throwable e) {
      if (e instanceof SQLException) {
        printSQLError((SQLException) e);
      } else {
        e.printStackTrace();
      }
    }
  }

  static void printSQLError(SQLException e) {
      while (e != null) {
          System.out.println(e.toString());
          e = e.getNextException();
      }
  }
        
}
