import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.*; 

import java.util.Properties;

public class Dipendente {

  /* framework embedded*/
  private String framework = "embedded";
  private String driver = "org.apache.derby.jdbc.EmbeddedDriver";
  private String protocol = "jdbc:derby:";
  private String database = "MyDB";
  private String pathDB;
  private Connection conn = null;

  Dipendente(ServletContext context) {
    
    try {
      pathDB = context.getRealPath("//WEB-INF//classes");
      Class.forName(driver).newInstance();
       
//      conn = DriverManager.getConnection(protocol + pathDB + "/" + database);
    }
    catch (Throwable e) {
      if (e instanceof SQLException) {
        printSQLError((SQLException) e);
      } else {
        e.printStackTrace();
      }
    }
  }

  String[] getCognomeNome(String matricola) {

    String[] dip = null;
    try {
      conn = DriverManager.getConnection(protocol + pathDB + "/" + database);

      Statement s = conn.createStatement();
      ResultSet rs = s.executeQuery("SELECT * FROM dipendente WHERE matricola = \'" + matricola + "\'");
      if (rs.next()) { 
        dip = new String[2];
        dip[0] = rs.getString(2);
        dip[1] = rs.getString(3);
      }

      rs.close();
      s.close();
      conn.close();
    }
    catch (Throwable e) {
      if (e instanceof SQLException) {
        printSQLError((SQLException) e);
      } else {
        e.printStackTrace();
      }
    }
    return dip;
  }
    
  static void printSQLError(SQLException e) {

    while (e != null) {
      System.out.println(e.toString());
      e = e.getNextException();
    }
  }

}
