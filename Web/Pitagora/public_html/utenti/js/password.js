function checkPassword(password,noSpeciali)
{
    //controllo lunghezza
    if(password.length<8){
      alert("La lunghezza della password deve essere di almeno 8 caratteri.")
      return false;
    }
    /*verifica dell'esistenza di caratteri:
      1) numerici;
      2) alfanumerici;
      3) speciali.
    */
    var numerici = "1234567890";
    var alfanumerici = "abcdefghilmnopqrstuvzxywkj";
    var speciali = "!�$%&/()=?^[]#@���*-_.:,;";
    var numNumerici=0;
    var numAlfa=0;
    var numSpeciali=0;
    for (var i=0;i<password.length;i++)
    {
      var appo = password.charAt(i).toLowerCase();
      if(appo==" ")
      {
        alert("La password non pu� contenere lo spazio.");
        return false;
      }
      if (numerici.search(appo)>-1)
      {
        numNumerici++;
      }
      if (alfanumerici.search(appo)>-1)
      {
        numAlfa++;
      }
      if (speciali.search(appo)>-1)
      {
        numSpeciali++;
      }
    }
    if(noSpeciali)
    {
        if(numSpeciali>0)
        {
          alert("La password non pu� contenere caratteri speciali.")
          return false;
        }
        
    }
    else
    {
        if(numSpeciali==0 || numNumerici==0 || numAlfa==0)
        {
          alert("La password deve contenere almeno un carattere di ognuno dei seguenti insiemi:\n1) Numerici\n2) Alfanumerici\n3) Speciali(escluso lo spazio).")
          return false;
        }      
    }
    return true;
}