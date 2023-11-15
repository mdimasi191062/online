package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ctr_SpesaComplessiva extends EJBObject 
{

    // getPeriodiRiferimento
    Vector getPeriodiRiferimento (String pstr_CodeTipoContr)
        throws CustomException, RemoteException;

    // congela
    String congela (String pstr_CodeTipoContratto,
                        Vector pvct_Account)
        throws CustomException, RemoteException;

    // delDettaglioSpesaCompl
    String delDettaglioSpesaCompl (String pstr_CodeTestSpesaCompl)
        throws CustomException, RemoteException;

    // salvaDettaglioSpesaCompl
    String salvaDettaglioSpesaCompl (Vector pvct_DettSpesaCompl)
        throws CustomException, RemoteException;

    // generaDettaglioSpesaCompl
    Vector generaDettaglioSpesaCompl (String pstr_CodeTipoContr,
                                                String pstr_CodeAccount)
        throws CustomException, RemoteException;

    // lancioBatch
    String lancioBatch (String pstr_CodeTipoContratto,
                                String pstr_CodeUtente,
                                String pstr_MeseRiferimento,
                                String pstr_AnnoRiferimento,
                                String pstr_DataFinePeriodo,
                                Vector pvct_Account)
        throws CustomException, RemoteException;

    // lancioBatchTLD
  String lancioBatchTLD (String pstr_CodeTipoContratto,
                            String pstr_CodeUtente,
                            String pstr_MeseRiferimento,
                            String pstr_AnnoRiferimento,
                            String pstr_FlagScelta)
    throws CustomException, RemoteException;

}