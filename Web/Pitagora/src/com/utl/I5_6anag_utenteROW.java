package com.utl;
import java.io.Serializable;
import java.util.Date;

public class I5_6anag_utenteROW implements Serializable
{
    String code_utente;
    String code_prof_utente;
    String code_unita_organiz;
    String nome_cogn_utente;
    Date date_end;
    String data_login;
    String flag_admin_ind;
    String flag_disabled;
    String flag_logged_in;
    String universal_number;
    String code_prof_abil;
    String baseIDN_LDAP;
    String searchIDN_LDAP;
    Date dateStart;
    int num_months_disabled;
    Date dt_disable_not_access;
    String date_end_char;
    String date_start_char;
    String mail;
    String mail_manager;
    int num_tnt_login;
    String flag_disabled_pwd_err;
    String date_end_user;
    String nome_utente;
    String cogn_utente;
    
    
    public I5_6anag_utenteROW() {
      code_utente = null;
      code_prof_utente = null;
      nome_cogn_utente = null;
      date_end = null;
      data_login = null;
      flag_admin_ind = null;
      flag_disabled = null;
      flag_logged_in = null;
      universal_number = null;
      code_prof_abil = null;
      baseIDN_LDAP = null;
      searchIDN_LDAP = null;
      dateStart = null;
      num_months_disabled = 0;
      dt_disable_not_access = null;
      date_end_char = null;
      date_start_char = null;
      num_tnt_login = 0;
      flag_disabled_pwd_err = null;
      mail = null;
      mail_manager = null;
      date_end_user = null;
      nome_utente = null;
      cogn_utente = null;     
    }
    
    public I5_6anag_utenteROW(String code_utente) {
      this.code_utente = code_utente;
      code_prof_utente = null;
      code_unita_organiz = null;
      nome_cogn_utente = null;
      date_end = null;
      data_login = null;
      flag_admin_ind = null;
      flag_disabled = null;
      flag_logged_in = null;
      universal_number = null;
      code_prof_abil = null;
      baseIDN_LDAP = null;
      searchIDN_LDAP = null;
      dateStart = null;
      num_months_disabled = 0;
      dt_disable_not_access = null;
      num_tnt_login = 0;
      flag_disabled_pwd_err = null;
      mail = null;
      mail_manager = null;
      date_end_user = null;
      nome_utente = null;
      cogn_utente = null;    
    }
    
    public String getCode_utente() {
      return code_utente;
    }
    
    public void setCode_utente(String newCode_utente) {
      code_utente = newCode_utente;
    }
    
    public String getCode_prof_utente() {
      return code_prof_utente;
    }
    
    public void setCode_prof_utente(String newCode_prof_utente) {
      code_prof_utente = newCode_prof_utente;
    }
    
    public String getCode_unita_organiz() {
      return code_unita_organiz;
    }
    
    public void setCode_unita_organiz(String newCode_unita_organiz) {
      code_unita_organiz = newCode_unita_organiz;
    }
    
    public String getNome_cogn_utente() {
      return nome_cogn_utente;
    }
    
    public void setNome_cogn_utente(String newNome_cogn_utente) {
      nome_cogn_utente = newNome_cogn_utente;
    }
    
    public Date getDate_end() {
      return date_end;
    }
    
    public void setDate_end(Date newDate_end) {
      date_end = newDate_end;
    }
    
    public String getData_login() {
      return data_login;
    }
    
    public void setData_login(String newData_login) {
      data_login = newData_login;
    }
    
    public String getFlag_admin_ind() {
      return flag_admin_ind;
    }
    
    public void setFlag_admin_ind(String newFlag_admin_ind) {
      flag_admin_ind = newFlag_admin_ind;
    }
    
    public String getflag_disabled() {
      return flag_disabled;
    }
    
    public void setflag_disabled(String newflag_disabled) {
      flag_disabled = newflag_disabled;
    }
    
    public String getFlag_logged_in() {
      return flag_logged_in;
    }
    
    public void setFlag_logged_in(String newFlag_logged_in) {
      flag_logged_in = newFlag_logged_in;
    }
    
    public String getUniversal_number() {
      return universal_number;
    }
    
    public void setUniversal_number(String newUniversal_number) {
      universal_number = newUniversal_number;
    }
    
    public String getCode_prof_abil() {
      return code_prof_abil;
    }
    
    public void setCode_prof_abil(String newCode_prof_abil) {
      code_prof_abil = newCode_prof_abil;
    }
    
    public String getBaseIDN_LDAP() {
      return baseIDN_LDAP;
    }
    
    public void setBaseIDN_LDAP(String newBaseIDN_LDAP) {
      baseIDN_LDAP = newBaseIDN_LDAP;
    }
    
    public String getSearchIDN_LDAP() {
      return searchIDN_LDAP;
    }
    
    public void setSearchIDN_LDAP(String newSearchIDN_LDAP) {
      searchIDN_LDAP = newSearchIDN_LDAP;
    }
    
    public Date getDateStart() {
      return dateStart;
    }
    
    public void setDateStart(Date newDateStart) {
      dateStart = newDateStart;
    }
    
    public int getNum_months_disabled() {
      return num_months_disabled;
    }
    
    public void setNum_months_disabled(int newNum_months_disabled) {
      num_months_disabled = newNum_months_disabled;
    }
    
    public Date getDt_disable_not_access() {
      return dt_disable_not_access;
    }
    
    public void setDt_disable_not_access(Date newDt_disable_not_access) {
      dt_disable_not_access = newDt_disable_not_access;
    }
    
    public void setData_end_char(String newData_end_char) {
      date_end_char = newData_end_char;
    }
    
    public String getData_end_char() {
      return date_end_char;
    }
    
    public void setData_start_char(String newData_start_char) {
      date_start_char = newData_start_char;
    }
    
    public String getData_start_char() {
      return date_start_char;
    }
    
    public int getNum_tnt_login() {
      return num_tnt_login;
    }
    
    public void setNum_tnt_login(int newNum_tnt_login) {
      num_tnt_login = newNum_tnt_login;
    }
    
    public String getflag_disabled_pwd_err() {
      return flag_disabled_pwd_err;
    }
    
    public void setflag_disabled_pwd_err(String newflag_disabled_pwd_err) {
      flag_disabled_pwd_err = newflag_disabled_pwd_err;
    }
    
    public String getMail() {
      return mail;
    }
    
    public void setMail(String newMail) {
      mail = newMail;
    }
    
    public String getMail_manager() {
      return mail_manager;
    }
    
    public void setMail_manager(String newMail_manager) {
      mail_manager = newMail_manager;
    }

    public void setData_end_user(String newData_end_user) {
      date_end_user = newData_end_user;
    }
    
    public String getData_end_user() {
      return date_end_user;
    }

    public void setNome_utente(String newNomeUtente) {
      nome_utente = newNomeUtente;
    }
    
    public String getNome_utente() {
      return nome_utente;
    }

    public void setCogn_utente(String newCognomeUtente) {
      cogn_utente = newCognomeUtente;
    }
    
    public String getCogn_utente() {
      return cogn_utente;
    }
}