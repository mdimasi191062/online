package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.Vector;
import java.rmi.RemoteException;
import com.utl.*;

public interface Ent_ClassiSconto extends EJBObject 
{
    // getClassiSconto
    Vector getClassiSconto(int pint_OperazioneRichiesta)
        throws CustomException, RemoteException;

    // getDettaglioClassiSconto
    Vector getDettaglioClassiSconto(int pint_OperazioneRichiesta,
                                      String pstr_CodeClasseSconto)
        throws CustomException, RemoteException;
  // getClassiScontoCalParAll
    Vector getClassiScontoCalParAll (String pstr_Mese,
                                     String pstr_Anno)
        throws CustomException, RemoteException;


    // getClassiScontoCalPar
    Vector getClassiScontoCalPar (int pint_OperazioneRichiesta,
                                        String pstr_ImptSpesa,
                                        String pstr_CodeGest,
                                        String pstr_Mese,
                                        String pstr_Anno)
        throws CustomException, RemoteException;

    // insDettaglioSpesaCompl
    Integer insParamClasSconto (int pint_OperazioneRichiesta,
                                    DB_ClasseSconto pdb_ParamClasSconto)
        throws CustomException, RemoteException;
}