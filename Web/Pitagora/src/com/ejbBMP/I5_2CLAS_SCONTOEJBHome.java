package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.Collection;
import com.utl.CustomException;

public interface I5_2CLAS_SCONTOEJBHome extends EJBHome 
{

   public Collection findAll() throws FinderException, RemoteException,CustomException;
   public Collection findAll(String filtro, String strCodRicerca) throws FinderException, RemoteException,CustomException;
   public I5_2CLAS_SCONTOEJB findByPrimaryKey(I5_2CLAS_SCONTOPK primaryKey) throws RemoteException, FinderException;
   public Collection findAllByCodeClsSconto(String FiltroCODE_CLS_SCONTO) throws FinderException, RemoteException,CustomException; 
//   public I5_2CLAS_SCONTOEJB create(I5_2CLAS_SCONTOPK newPrimaryKey, String newDataInizio, String txtDescrizioneIntervallo, String txtValoreMinimo, String txtValoreMassimo) throws RemoteException, CreateException;
   public I5_2CLAS_SCONTOEJB create(I5_2CLAS_SCONTOPK newPrimaryKey, String newDataInizio, String txtDescrizioneIntervallo, java.math.BigDecimal txtValoreMinimo,  java.math.BigDecimal txtValoreMassimo) throws RemoteException, CreateException;
   public I5_2CLAS_SCONTOEJB create() throws RemoteException, CreateException;
  // public  I5_2CLAS_SCONTOEJB ejbStore() throws RemoteException, CreateException;
} 