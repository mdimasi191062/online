package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.Collection;
import java.sql.*;
import com.utl.*;

public interface I5_2MOV_NON_RICEJBHome extends EJBHome 
{
  public I5_2MOV_NON_RICEJB create (String flag_sys, String code_account, String data_oggetto, String code_ogg_fatrz,
                          String code_utente, String code_invent, String desc_mov, java.math.BigDecimal imp_mov,
                          String data_fatrz, String data_mm, String data_aa,
                          String tipo_flag_ncf, String tipo_flag_da)  throws RemoteException, CreateException;
  public Collection findAll(String tipoContratto,String code_gest, java.util.Date data_da, java.util.Date data_a,
                            String code_acc, String tipo_data) throws FinderException, RemoteException,CustomException;
  public I5_2MOV_NON_RICEJB findByPrimaryKey(String primaryKey) throws RemoteException, FinderException;
}