package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.*;
import com.utl.*;
import java.util.Collection;

public interface AssOfPsBMPHome extends EJBHome 
{
  AssOfPsBMP create() throws RemoteException, CreateException;
  AssOfPsBMP create(String dataIniOfPs, String codeOf,
                    String codePs, String dataIniOf, String codeMod, String codeFreq,
                    String codeUte, int quntShift, String flgAP, String dataFineOfPs) 
                      throws RemoteException, CustomEJBException, CreateException;
  AssOfPsBMP findByPrimaryKey(AssOfPsBMPPK primaryKey) throws RemoteException, FinderException;
  Collection findAll(String CodTipoContr, boolean solo_attivi ) throws FinderException, RemoteException;
  
}