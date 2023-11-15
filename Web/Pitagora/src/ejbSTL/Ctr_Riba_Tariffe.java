package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ctr_Riba_Tariffe extends EJBObject 
{
	// lancioBatch
	String lancioBatch (String pstr_CodeUtente,
								String pstr_CodeContrattoOr,
								String pstr_CodeContrattoDest,
								String pstr_CodePS,
								String pstr_CodePrestAgg,
								String pstr_CodeOggFatrz)
		throws CustomException, RemoteException;

	// chkRibaTariffa
	String chkRibaTariffa (String pstr_CodeContrOri,
							String pstr_CodeContrDest,
							String pstr_CodePS,
							String pstr_CodePrestAgg,
							String pstr_CodeOggFattrz)
		throws CustomException, RemoteException;
}