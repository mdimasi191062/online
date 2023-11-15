package com.strutturaWeb.View;
import java.util.*;
import com.utl.*;
public class ViewAccounts extends ViewInterface
{
 
  public ViewAccounts(Vector vettore)
  {
    _vettore=vettore;
  }
  public int getNumeroAccount()
  {
    return _vettore.capacity();
  }
  public String getNomeAccount(int indice)
  {
      return ((LstAccElabElem)_vettore.get(indice)).getAccount();
  }
  public String getCodeAccount(int indice)
  {
      return ((LstAccElabElem)_vettore.get(indice)).getCodeAccount();
  }
  public String getCodeParam(int indice)
  {
      return ((LstAccElabElem)_vettore.get(indice)).getCodeParam();
  }
  
}