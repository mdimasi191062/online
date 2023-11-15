package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.*;
import java.util.*;
import java.rmi.*;
import java.sql.*;
import oracle.jdbc.*;
import oracle.sql.*;
import com.utl.*;
import java.rmi.RemoteException;

public class OggettoFattLstOfAssocbSTLBean extends AbstractSessionCommonBean implements SessionBean 
{
  
  public Vector getDesc(String codeTipoContratto, String codeCOf) throws RemoteException,CustomException
  {
    //System.out.println(" <<getDesc in OggettoFattLstOfAssocbSTLBean");
   Vector vect=new Vector();
   Connection conn=null;
   try
      {
      conn = getConnection(dsName);
     
//      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_NICOLA.OGGETTO_FATT_LST_OF_ASSOCB(?,?,?,?,?)}");
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".OGGETTO_FATT_LST_OF_ASSOCB(?,?,?,?,?)}");

      // Impostazione types I/O
      
        
      cs.setString(1,codeTipoContratto);
      cs.setString(2,codeCOf);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_OGG_DI_FATRZ");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();

      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
        throw new Exception("DB:"+cs.getInt(4)+":"+cs.getString(5));

      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_OGG_DI_FATRZ",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();
//     //System.out.println("dati.length="+dati.length+"."); 

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              //System.out.println("i="+i); 
              OggettoFattListaPsElem elem= new OggettoFattListaPsElem();
                   
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();

              elem.setCodeCOf(attr[0].stringValue());
              elem.setDescCOf(attr[1].stringValue());

              vect.addElement(elem);
          }      

      // Chiudo la connessione
      conn.close();
        
      }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDesc",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
  	}
    //System.out.println(" getDesc in OggettoFattLstOfAsscbSTLBean>>");
    return vect;
  }
}