package com.utl;

import java.util.Date;
import java.util.Vector;

public class DettaglioListinoOpereSpeciali
{

  private Date dataInizioValidita;
  private Date dataFineValidita;
  private String descrizioneListino;
  private Vector<TariffaOpereSpeciali> listaTariffe;
  
  public DettaglioListinoOpereSpeciali()
  {
  }

  public void setDataInizioValidita(Date dataInizioValidita)
  {
    this.dataInizioValidita = dataInizioValidita;
  }

  public Date getDataInizioValidita()
  {
    return dataInizioValidita;
  }

  public void setDataFineValidita(Date dataFineValidita)
  {
    this.dataFineValidita = dataFineValidita;
  }

  public Date getDataFineValidita()
  {
    return dataFineValidita;
  }

  public void setDescrizioneListino(String descrizioneListino)
  {
    this.descrizioneListino = descrizioneListino;
  }

  public String getDescrizioneListino()
  {
    return descrizioneListino;
  }

  public void setListaTariffe(Vector<TariffaOpereSpeciali> listaTariffe)
  {
    this.listaTariffe = listaTariffe;
  }

  public Vector<TariffaOpereSpeciali> getListaTariffe()
  {
    return listaTariffe;
  }
}
