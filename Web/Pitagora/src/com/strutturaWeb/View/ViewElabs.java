package com.strutturaWeb.View;
import java.util.*;
import com.utl.*;
import com.ejbBMP.*;
public class ViewElabs extends ViewInterface
{
 
  public ViewElabs(Vector vettore)
  {
    _vettore=vettore;
   
  }
  public int getNumeroParametri()
  {
    return _vettore.size();
  }
  public String getCodeElab(int indice)
  {
      return ((ElaborBatchBMPPK)_vettore.get(indice)).getCodeElab();
  }
  public String getDataIni(int indice)
  {
      return ((ElaborBatchBMPPK)_vettore.get(indice)).getDataIni();
  }
  public String getDataFine(int indice)
  {
      return ((ElaborBatchBMPPK)_vettore.get(indice)).getDataFine();
  }
    public String getStato(int indice)
  {
      return ((ElaborBatchBMPPK)_vettore.get(indice)).getStato();
  }

      public String getNPS(int indice)
  {
      return ((ElaborBatchBMPPK)_vettore.get(indice)).getNPS();
  }
}