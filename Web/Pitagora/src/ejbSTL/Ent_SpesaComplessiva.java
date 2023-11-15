package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_SpesaComplessiva extends EJBObject 
{

// updDataEstrazioneImpt
Integer updDataEstrazioneImpt (int pint_OperazioneRichiesta,
                                    String pstr_CodeTestSpesaCompl,
                                    String pstr_DataEstrazioneImpt)
    throws CustomException, RemoteException;

// updTotaleSpesaCompl
Integer updTotaleSpesaCompl (int pint_OperazioneRichiesta,
                                    String pstr_CodeTestSpesaCompl,
                                    String pstr_ImptTotSpesaCompl,
                                    String pstr_DataRicezTotSpesa)
    throws CustomException, RemoteException;

// updDettaglioSpesaCompl
Integer updDettaglioSpesaCompl (int pint_OperazioneRichiesta,
                                    DB_SpesaComplessiva pdb_SpesaComplessiva)
    throws CustomException, RemoteException;

// insDettaglioSpesaCompl
Integer insDettaglioSpesaCompl (int pint_OperazioneRichiesta,
                                    DB_SpesaComplessiva pdb_SpesaComplessiva)
    throws CustomException, RemoteException;

// delDettSpesaCompl
Integer delDettSpesaCompl (int pint_OperazioneRichiesta,
                                    String pstr_CodeTestSpesaCompl)
    throws CustomException, RemoteException;

// getProcedureEmittenti
Vector getProcedureEmittenti (int pint_OperazioneRichiesta,
                                    String pstr_CodeTipoContratto,
                                    DB_Account pdb_Account)
    throws CustomException, RemoteException;

// getPeriodoAutomTLD
Vector getPeriodoAutomTLD (String pstr_CodeTipoContratto)
    throws CustomException, RemoteException;


// CountDettSpComplNoPit
Integer CountDettSpComplNoPit (String pstr_MeseRiferimento,
                           String pstr_AnnoRiferimento,
                           String pstr_CodeTipoContratto)
    throws CustomException, RemoteException;



// GetElabBatchVerificaxTLD
Vector GetElabBatchVerificaxTLD (String pstr_CodeFunz,
                                        String pstr_CodiceTipoContratto)
    throws CustomException, RemoteException;

 // getScartiTLD
   Vector getScartiTLD (String pstr_CodeFunz)
   throws CustomException, RemoteException;
   
}