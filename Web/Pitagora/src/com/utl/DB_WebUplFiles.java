package com.utl;

public class DB_WebUplFiles  extends AbstractDataBean
{
  private String CODE_FUNZ;
  private String DESC_FUNZ;
  private String VAR_PATH_DOWNLOAD;
  private String NAME_BATCH_IMPORT;
  private String LIM_MAX_SIZE_UPLOAD;
  private String NAME_FILE_OUT;
          
  public DB_WebUplFiles()
  {
    CODE_FUNZ = "";
    DESC_FUNZ = "";
    VAR_PATH_DOWNLOAD = "";
    NAME_BATCH_IMPORT = "";
    LIM_MAX_SIZE_UPLOAD = "";
    NAME_FILE_OUT = "";
  }

  public String getNAME_FILE_OUT () {
    return NAME_FILE_OUT;
  }

  public void setNAME_FILE_OUT (String value) {
    NAME_FILE_OUT = value;
  }
  

  public String getLIM_MAX_SIZE_UPLOAD () {
    return LIM_MAX_SIZE_UPLOAD;
  }

  public void setLIM_MAX_SIZE_UPLOAD (String value) {
    LIM_MAX_SIZE_UPLOAD = value;
  }
  
  public String getCODE_FUNZ () {
    return CODE_FUNZ;
  }

  public String getDESC_FUNZ () {
    return DESC_FUNZ;
  }

  public String getVAR_PATH_DOWNLOAD () {
    return VAR_PATH_DOWNLOAD;
  }

  public String getNAME_BATCH_IMPORT () {
    return NAME_BATCH_IMPORT;
  }

  public void setCODE_FUNZ(String value)
  {
    CODE_FUNZ = value;
  }

  public void setDESC_FUNZ(String value)
  {
    DESC_FUNZ = value;
  }

  public void setVAR_PATH_DOWNLOAD(String value)
  {
    VAR_PATH_DOWNLOAD = value;
  }

  public void setNAME_BATCH_IMPORT(String value)
  {
    NAME_BATCH_IMPORT = value;
  }
}