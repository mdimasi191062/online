package com.applet;

//Importare le seguenti 2 classi per la comunicazione con la pagina HTML !!!
//Sono della Netscape ma si trovano nelle api della SUN in jaws.jar !!!!!!!
import netscape.javascript.JSException;	
import netscape.javascript.JSObject;
import java.applet.Applet;

public class CryptoApplet  extends Applet {
	
	public void setData(String data1, String data2) 
  {

    
    com.utl.CustomEncode myEnc = new com.utl.CustomEncode(); 
    myEnc.setStringToUse(data2);
    myEnc.setKey(data1); //usa la login come chiave per codificare la password

    String OUT=myEnc.encode();
    returnValue(OUT);
	}

public void init()
  {
  }
	
	public void returnValue(String rit) {
		try {
			// Recupero l'oggetto window dove c'?a pagina HTML
			JSObject topWindow = JSObject.getWindow(this);

			//Richiamo la function (<script>) presente nella pagina HTML
			//Prende come argomenti array di oggetti!!!!!
			Object args[] = {rit};
			topWindow.call("risposta", args);
		}
		catch(JSException jse) {
			System.out.println("JSException "+jse.getMessage());
		}
	}
}