package com.strutturaWeb.View;
import java.util.*;
import com.utl.*;
public class ViewErrore extends ViewInterface
{

  public ViewErrore(String messaggio)
  {

    _vettore=new Vector();   
    _vettore.add(new MessaggioBean(messaggio));
  }

  public String getMessaggio()
  {
    return ((MessaggioBean)_vettore.get(0)).getMessaggio();
  }

  
}