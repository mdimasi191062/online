package com.ejbBMP.impl;
import javax.sql.*;
import javax.naming.*;
import javax.ejb.EntityBean;
import javax.ejb.EntityContext;
import com.utl.*;
import javax.ejb.*;
import java.sql.*;
import java.util.*;
import javax.ejb.RemoveException;
import java.rmi.*;
import oracle.jdbc.OracleTypes;
import java.math.BigDecimal;

public class I5_2MOV_NON_RICEJBBean extends AbstractEntityCommonBean implements EntityBean 
{
  private String Id_movim = null;    
  private String Code_account = null;  
  private String Desc_acc = null;
  private String Code_gest = null;
  private String Nome_Rag_Soc_Gest=null;
  private String Code_Clas_Ogg_Fatrz=null;
  private String Desc_Clas_Ogg_Fatrz=null;  
  private java.util.Date DATA_INIZIO_VALID_OF = null;
  private String Code_Ogg_Fatrz = null;
  private String Desc_Ogg_Fatrz = null;  
  private String Code_utente = null;
  private String Code_invent = null;
  private String Code_Istanza_Ps = null;
  private String Desc_mov = null;
  private java.math.BigDecimal Impt_Mov_Non_Ric;
  private java.util.Date Data_fatrb = null;
  private java.util.Date Data_eff_fatrz = null;
  private java.util.Date Data_transaz = null;
  private String Data_mm = null;
  private String Data_aa = null;
  private String Tipo_Flag_Nota_Cred_Fattura = null;
  private String Tipo_Flag_Dare_Avere = null;
  private boolean EseguiStore = false;
  
  public EntityContext entityContext;
  private String CreaMovim     = "{? = call PKG_BILL_CLA.I5_2MOV_NON_RICEJBCreate(?,?,?,?,?,?,?,?,?,?,?,?,?) }";
  private String AggiornaMovim = "{? = call PKG_BILL_CLA.I5_2MOV_NON_RICEJBStore(?,?,?,?,?,?,?,?,?,?,?,?) }";
  private String CancellaMovim = "{? = call PKG_BILL_CLA.I5_2MOV_NON_RICEJBRemove(?) }";
  private String CaricaMovim   = "{? = call PKG_BILL_CLA.I5_2MOV_NON_RICEJBLoad(?) }";
  private String LeggiMovim    = "{? = call PKG_BILL_CLA.I5_2MOV_NON_RICEJBFindall(?,?,?,?,?,?) }";
  
  public String ejbCreate(String flag_sys, String code_account, String data_oggetto, String code_ogg_fatrz,
                          String code_utente, String code_invent, String desc_mov, java.math.BigDecimal imp_mov,
                          String data_fatrb, String data_mm, String data_aa,
                          String tipo_flag_ncf, String tipo_flag_da)  throws CreateException
  {
    CallableStatement cs = null;
    String primarykey = null;
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(CreaMovim);
      cs.registerOutParameter(1,OracleTypes.VARCHAR) ;
      cs.setString(2,flag_sys);
      cs.setString(3,code_account);
      cs.setString(4,data_oggetto);      
      cs.setString(5,code_ogg_fatrz);
      cs.setString(6,code_utente);
      cs.setString(7,code_invent);
      cs.setString(8,desc_mov);
      cs.setBigDecimal(9,imp_mov);
      cs.setString(10,data_fatrb);
      cs.setString(11,data_mm);
      cs.setString(12,data_aa);
      cs.setString(13,tipo_flag_ncf);
      cs.setString(14,tipo_flag_da);
      cs.execute();      
      primarykey = cs.getString(1);
      if (primarykey==null)
      {
        throw new EJBException("Errore in fase di inserimento: ");
      }
    }
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
      throw new EJBException("Errore oracle: " + e.getMessage());
    }
    catch(Throwable ex)
    {
      System.out.println(ex.getMessage());
      ex.printStackTrace();
    }
    finally 
    {
      try 
      {
	       cs.close();
      } 
      catch (Exception e){
      }
      try 
      {
	       conn.close();
      } 
      catch (Exception e){
      }
    }    
    return primarykey;
  }
  public void ejbPostCreate(String flag_sys, String code_account, String data_oggetto, String code_ogg_fatrz,
                          String code_utente, String code_invent, String desc_mov, java.math.BigDecimal imp_mov,
                          String data_fatrb, String data_mm, String data_aa,
                          String tipo_flag_ncf, String tipo_flag_da)  throws CreateException
  
  {
  }

  public Collection ejbFindAll(String tipoContratto, String code_gest, java.util.Date data_da, java.util.Date data_a,
                               String code_acc, String tipo_data) throws FinderException, RemoteException,CustomException
  {
    CallableStatement cs = null;
    Vector Vectorpk = new Vector();
    ResultSet rs = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiMovim);
      long i = 0;
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.setString(2,code_gest);
      cs.setString(5,code_acc);
      cs.setString(6,tipo_data);
      cs.setString(7,tipoContratto);
      if (data_da != null)
      {
        cs.setDate(3,new java.sql.Date(data_da.getTime()));
      }
      else
      {
        cs.setNull(3,Types.DATE);
      }
      if (data_a != null)
      {
        cs.setDate(4,new java.sql.Date(data_a.getTime()));
      }
      else
      {
        cs.setNull(4,Types.DATE);
      }
      cs.execute();
      rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      {   
        i++;
        Vectorpk.add(new String(rs.getString(1)));
      } 
    } 
    catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2MOV_NON_RIC","FindAll","I5_2MOV_NON_RIC",StaticContext.FindExceptionType(e));                            
    } finally {
      try {
         if (rs != null){
           rs.close();
         }  
	       cs.close();
      } catch (Exception e) {}
      try {
	       conn.close();
      } catch (Exception e) {}
    }
    return Vectorpk;
  }

  public String ejbFindByPrimaryKey(String primaryKey) throws FinderException
  {
    ResultSet rs =null;
    CallableStatement cs = null;
    if (primaryKey == null)
    {
      throw new FinderException("La chiave primaria deve essere valorizzata");
    }
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(CaricaMovim);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.setString(2,primaryKey);
      cs.execute();
      rs = (ResultSet) cs.getObject(1);
      boolean found = rs.next();
      if (!found) 
      {       
        System.out.println("Occorrenza non trovata");
        throw new ObjectNotFoundException("Occorrenza non trovata");
      }    
    } 
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());    
    } 
    catch(Throwable ex)
    {
      ex.printStackTrace();
    }
    finally {
      try {
         if (rs != null){
           rs.close();
         }  
	       cs.close();
      } catch (Exception e) {}
      try {
	       conn.close();
      } catch (Exception e) {}
    }    
    return primaryKey;
  }

  public void ejbActivate()
  {
  }

  public void ejbLoad()
  {
    CallableStatement cs = null;
    ResultSet rs = null;
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(CaricaMovim);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      String primaryKey = (String) entityContext.getPrimaryKey();
      cs.setString(2,primaryKey);
      cs.execute();
      rs = (ResultSet) cs.getObject(1);
      boolean found = rs.next();
      if (found) 
      {
        Id_movim = primaryKey;            
          //Fornitore
        Code_gest = rs.getString("CODE_GEST");
        Nome_Rag_Soc_Gest = rs.getString("NOME_RAG_SOC_GEST");
          //Account        
        Code_account = rs.getString("Code_account");
        Desc_acc = rs.getString("DESC_ACCOUNT");
          //Classe Oggetto Fatturazione
        Code_Clas_Ogg_Fatrz = rs.getString("CODE_CLAS_OGG_FATRZ");
        Desc_Clas_Ogg_Fatrz = rs.getString("DESC_CLAS_OGG_FATRZ");        
          //Oggetto Fatturazione
        Code_Ogg_Fatrz = rs.getString("CODE_OGG_FATRZ");
        Desc_Ogg_Fatrz = rs.getString("DESC_OGG_FATRZ");        
        DATA_INIZIO_VALID_OF = rs.getDate("DATA_INIZIO_VALID_OF");
          //Codice Istanza ps
        Code_Istanza_Ps = rs.getString("code_istanza_ps");          
          //Descrizione
        Desc_mov = rs.getString("DESC_MOV_NON_RIC");
          //Importo
        Impt_Mov_Non_Ric = rs.getBigDecimal("IMPT_MOV_NON_RIC");        
        Data_eff_fatrz = rs.getDate("DATA_EFF_FATRZ");
          //Data Fatturabilita
        Data_fatrb = rs.getDate("DATA_FATRB");
          //Data Transazione        
        Data_transaz = rs.getDate("DATA_TRANSAZ");
          //Mese     
        Data_mm = rs.getString("DATA_MM_FATTURA_DI_RIF");          
          //Anno
        Data_aa = rs.getString("DATA_Aa_FATTURA_DI_RIF");                    
          //Descrizione Movimento (N Nota di credito f Fattura)
        Tipo_Flag_Nota_Cred_Fattura = rs.getString("TIPO_FLAG_NOTA_CRED_FATTURA");                              
          //(Fattura C Credito D Debito)
        Tipo_Flag_Dare_Avere = rs.getString("TIPO_FLAG_DARE_AVERE");                                                     
      }  
    } 
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
    } 
    catch(Throwable ex)
    {
      System.out.println(ex.getMessage());
      ex.printStackTrace();
    }
    finally {
      try {
         if (rs != null){
           rs.close();
         }  
	       cs.close();
      } catch (Exception e) {}
      try {
	       conn.close();
      } catch (Exception e) {}
    }    
    
  }

  public void ejbPassivate()
  {
  }

  public void ejbRemove() throws RemoveException
  {
    CallableStatement cs = null;
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(CancellaMovim);
      cs.registerOutParameter(1,OracleTypes.NUMBER);
      String primaryKey = (String) entityContext.getPrimaryKey();
      cs.setString(2,primaryKey);
      int righecancellate = cs.executeUpdate();
      if (righecancellate != 1) 
      {
        throw new EJBException("Errore in fase di cancellazione: " + primaryKey);
      }
    } 
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
    } 
    catch(Throwable ex)
    {
      System.out.println(ex.getMessage());
      ex.printStackTrace();
    }
    finally {
      try {       
	       cs.close();
      } catch (Exception e) {}
      try {
	       conn.close();
      } catch (Exception e) {}
    }    
    
  }

  public void ejbStore()
  {
    if (EseguiStore){
      CallableStatement cs = null;
      try 
      {
        conn = getConnection(dsName);
        cs = conn.prepareCall(AggiornaMovim);
        cs.registerOutParameter(1,OracleTypes.NUMBER);
        String primaryKey = (String) entityContext.getPrimaryKey();
        cs.setString(2,primaryKey);
        cs.setString(3,Code_Ogg_Fatrz);
        cs.setString(4,Code_utente);
        cs.setString(5,Code_invent);
        cs.setString(6,Desc_mov);
        cs.setBigDecimal(7,Impt_Mov_Non_Ric);
        cs.setDate(8,new java.sql.Date(Data_fatrb.getTime()));
        cs.setString(9,Data_mm);
        cs.setString(10,Data_aa);
        cs.setString(11,Tipo_Flag_Nota_Cred_Fattura);
        cs.setString(12,Tipo_Flag_Dare_Avere);
        cs.setDate(13,new java.sql.Date(DATA_INIZIO_VALID_OF.getTime()));      
        cs.executeUpdate();
      } 
      catch (SQLException e) 
      {
        System.out.println(e.getMessage());
        e.printStackTrace();
      } 
      catch(Throwable ex)
      {
        System.out.println(ex.getMessage());
        ex.printStackTrace();
      }
      finally 
      {
        try 
        {
           cs.close();
        } 
        catch (Exception e){
        }
        try 
        {
           conn.close();
        } 
        catch (Exception e){
        }
      }
    }      
  }

  public void setEntityContext(EntityContext ctx)
  {
    this.entityContext = ctx;
  }

  public void unsetEntityContext()
  {
    this.entityContext = null;
  }
  
  public void setCode_Ogg_Fatrz(String code_ogg_fatrz)
  {
    Code_Ogg_Fatrz = code_ogg_fatrz;
  }

  public void setCode_utente(String code_utente)
  {
    Code_utente = code_utente;
  }

  public void setCode_invent(String code_invent)
  {
    Code_invent = code_invent;
  }

  public void setDesc_mov(String desc_mov)
  {
    Desc_mov = desc_mov;
  }

  public void setImpt_Mov_Non_Ric(java.math.BigDecimal newImpt_Mov_Non_Ric)
  {
    Impt_Mov_Non_Ric = newImpt_Mov_Non_Ric;
  }

  public void setData_fatrb(java.util.Date data_fatrb)
  {
    Data_fatrb = data_fatrb;
  }

  public void setData_mm(String data_mm)
  {
    Data_mm = data_mm;
  }

  public void setData_aa(String data_aa)
  {
    Data_aa = data_aa;
  }

  public void setTipo_Flag_Nota_Cred_Fattura(String tipo_flag_ncf)
  {
    Tipo_Flag_Nota_Cred_Fattura = tipo_flag_ncf;
  }

  public void setTipo_Flag_Dare_Avere(String tipo_flag_da)
  {
    Tipo_Flag_Dare_Avere = tipo_flag_da;
  }
  
  public void setCode_Clas_Ogg_Fatrz(String newCode_Clas_Ogg_Fatrz)
  {
    Code_Clas_Ogg_Fatrz = newCode_Clas_Ogg_Fatrz;
  }

  public void setDATA_INIZIO_VALID_OF(java.util.Date newDATA_INIZIO_VALID_OF)
  {
    DATA_INIZIO_VALID_OF = newDATA_INIZIO_VALID_OF;
  }

  public void setCode_Istanza_Ps(String newCode_Istanza_Ps)
  {
    Code_Istanza_Ps = newCode_Istanza_Ps;
  }

  public void setEseguiStore(boolean newEseguiStore)
  {
    EseguiStore=newEseguiStore;
  }

  public String getId_movim()
  {
    return Id_movim;
  }

  public String getDesc_acc()
  {
    return Desc_acc;
  }

  public String getCode_gest()
  {
    return Code_gest;
  }

  public String getNome_Rag_Soc_Gest()
  {
    return Nome_Rag_Soc_Gest;
  }
   
  public String getCode_account()
  {
    return Code_account;
  }

  public String getDesc_mov()
  {
    return Desc_mov;
  }

  public java.util.Date getData_fatrb()
  {
    return Data_fatrb;
  }

  public java.util.Date getData_eff_fatrz()
  {
    return Data_eff_fatrz;
  }

  public java.util.Date getData_transaz()
  {
    return Data_transaz;
  }
  
  public String getCode_Clas_Ogg_Fatrz()
  {
    return Code_Clas_Ogg_Fatrz;
  }
  
  public String getDesc_Clas_Ogg_Fatrz()
  {
    return Desc_Clas_Ogg_Fatrz;
  }
  
  public String getCode_Ogg_Fatrz()
  {
    return Code_Ogg_Fatrz;
  }
  
  public String getDesc_Ogg_Fatrz()
  {
    return Desc_Ogg_Fatrz;
  }  
  
  public java.math.BigDecimal getImpt_Mov_Non_Ric()
  {
    return Impt_Mov_Non_Ric;
  }  

  public String getCode_invent()
  {
    return Code_invent;
  }  
  public String getData_mm()
  {
    return Data_mm;
  }
  public String getData_aa()
  {
    return Data_aa;
  }
  public String getTipo_Flag_Nota_Cred_Fattura()
  {
    return Tipo_Flag_Nota_Cred_Fattura;
  }
  public String getTipo_Flag_Dare_Avere()
  {
    return Tipo_Flag_Dare_Avere;
  }
  public java.util.Date getDATA_INIZIO_VALID_OF()
  {
    return DATA_INIZIO_VALID_OF ;
  }
  public String getCode_Istanza_Ps()
  {
    return Code_Istanza_Ps;
  }

}