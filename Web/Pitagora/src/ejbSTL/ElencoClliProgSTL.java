package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;
import com.utl.*;

public interface ElencoClliProgSTL extends EJBObject 
{
public Vector getAllCLLIProg() throws RemoteException, CustomException;
}