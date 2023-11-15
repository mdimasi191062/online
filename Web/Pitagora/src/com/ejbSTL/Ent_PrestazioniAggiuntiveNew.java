package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;

public interface Ent_PrestazioniAggiuntiveNew extends EJBObject 
{
  public Vector getPrestAggProdotto(int Prodotto)throws CustomException, RemoteException;
  public Vector getPrestAggComponente(int Componente)throws CustomException, RemoteException;
}