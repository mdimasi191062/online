package com.strutturaWeb.View;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;
import java.util.Vector;

public class ViewTabella
{
  public HashMap<String,ArrayList<String>> _tabella;
  public ViewTabella(HashMap<String,ArrayList<String>> tabella)
  {
    this._tabella=tabella;
  }
  public String[] getNomeCampi()
  {
    String[] campi=new String[_tabella.keySet().size()];
    _tabella.keySet().toArray(campi);
    return campi;
  }
  public String getValore(String colonna,int riga)
  {
      return _tabella.get(colonna).get(riga);
  }
  public int getNumeroRighe()
  {
    return _tabella.get(_tabella.keySet().toArray()[0]).size();
  }
}
