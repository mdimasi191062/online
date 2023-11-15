package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import com.utl.CustomException;
import java.rmi.RemoteException;

public interface FILTRO_MOV_NON_RICEJB extends EJBObject 
{
  public Vector FindAll(String FiltroCODE_TIPO_CONTR) throws RemoteException,CustomException;
  public Vector FindAcc(String Codefornitore, String Provenienza, String TipoContratto) throws RemoteException,CustomException;
  public Vector FindClass() throws RemoteException,CustomException;
  public Vector FindOgg(String Codeclasse) throws RemoteException,CustomException;
  public String FindIst(String Codeistanza, String Codeaccount) throws RemoteException,CustomException;
  public int FindTemp(int Mese, int Anno, String Codeaccount) throws RemoteException,CustomException;
  public Vector FindOcc(String Codemovimento) throws RemoteException,CustomException;
}