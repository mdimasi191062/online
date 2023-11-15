package com.strutturaWeb.View;
import java.util.*;
import com.utl.*;
public class ViewLancioBatch extends ViewInterface
{

  public ViewLancioBatch(String messaggio)
  {

    _vettore=new Vector();   
    _vettore.add(new MessaggioBean(messaggio));
  }

  public String getMessaggio()
  {
    return ((MessaggioBean)_vettore.get(0)).getMessaggio();
  }

  
}