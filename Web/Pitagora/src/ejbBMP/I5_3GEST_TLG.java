package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.*;

public interface I5_3GEST_TLG extends EJBObject 
{
  public String getCode_gest()  throws RemoteException;
  public void setCode_gest(String newCode_gest)  throws RemoteException;
  public String getNome_rag_soc_gest()  throws RemoteException;
  public void setNome_rag_soc_gest(String newNome_rag_soc_gest)  throws RemoteException;
/*
    code_tipol_operatore           VARCHAR2(3),
    code_tipo_gest                 VARCHAR2(3),
    code_comune_sede_legale        VARCHAR2(5),
    code_comune_sede_centrale      VARCHAR2(5),
    nome_gest_sigla                VARCHAR2(15),
    code_partita_iva               VARCHAR2(16),
    indr_via_sede_legale           VARCHAR2(70),
    indr_civ_sede_legale           VARCHAR2(10),
    code_cap_sede_legale           VARCHAR2(5),
    indr_tel_sede_legale           VARCHAR2(20),
    indr_fax_sede_legale           VARCHAR2(20),
    indr_via_sede_centrale         VARCHAR2(70),
    indr_civ_sede_centrale         VARCHAR2(10),
    code_cap_sede_centrale         VARCHAR2(5),
    indr_tel_sede_centrale         VARCHAR2(20),
    indr_fax_sede_centrale         VARCHAR2(20),
    indr_internet                  VARCHAR2(70),
    text_note                      VARCHAR2(500),
    qnta_dip                       NUMBER(9),
    text_alleanze                  VARCHAR2(500),
    text_info_estero               VARCHAR2(500),
    text_dip                       VARCHAR2(100),
    text_tipol_operatore           VARCHAR2(250),
    code_gest_tirks                VARCHAR2(4))
*/
}