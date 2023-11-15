package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface ControlliSTL extends EJBObject 
{
   public ControlliElem getInventPsSpVerEs(String codesito,String codeaccount) throws RemoteException, CustomException;
   public int verFattAccount(String codesito,String codeaccount,String dataini) throws RemoteException, CustomException;
   
}