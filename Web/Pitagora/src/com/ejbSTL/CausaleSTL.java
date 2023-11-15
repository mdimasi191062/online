package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;
import com.utl.*;

public interface CausaleSTL extends EJBObject 
{
  public Vector getCaus(String CodTipoContr, String ClassOf, String CodPs, String CodOf) throws RemoteException, CustomException;
  public Vector getCausTar(String CodTipoContr, String CodPs, String CodOf) throws RemoteException, CustomException;
  public Vector getCausTar(String CodTipoContr, String CodContr, String CodPs, String CodOf) throws RemoteException, CustomException;
  public Vector getCausXContr(String CodTipoContr, String CodContr, String ClassOf, String CodPs, String CodOf) throws RemoteException, CustomException;
  public Vector getCausaliXTariffe(String CodTipoContr,String ClassOf) throws RemoteException, CustomException;
  public Vector getLstPromozioni(String CodTipoContr,String ClassOf) throws RemoteException, CustomException;
  public PromozioniDett loadPromozione(String codeTariffa,String codePrTariffa,String codePromozione) throws RemoteException, CustomException;
  public PromozioniDett getPromozioneParam(String codePromozione) throws RemoteException, CustomException;
  public Vector getLstPromozioniTariffa(String codeTariffa, String codePrTariffa) throws RemoteException, CustomException;
}
