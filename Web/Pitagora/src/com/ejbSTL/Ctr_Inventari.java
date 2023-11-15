package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ctr_Inventari extends EJBObject 
{
  int inserimentoRettifica(String strCodeUtente,Vector vct_InventariProd,
  Vector vct_InventariCompo, Vector vct_InventariPrest, Vector vct_InventariAnag
  ,Vector vct_InventariCompoDIF, String strpropagaDesc1, Vector vctpropagaCompo,Vector vPropagaElem
  ,Vector vct_InventariCompoC_A,Vector vct_InventariCompoxInsProd, String strNoteRettificaRipristino )
  throws CustomException, RemoteException;
}