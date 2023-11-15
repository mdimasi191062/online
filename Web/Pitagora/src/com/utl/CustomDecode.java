package com.utl;

import java.io.IOException;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Random;
import com.utl.DecodingException;

public class CustomDecode
{
String theString;
String theKey;

  public CustomDecode(String aString,String aKey)
  {
    theString=aString;
    theKey=aKey;
  }
    public CustomDecode()
  {
    theString=null;
    theKey=null;
  }
  public void setKey(String aKey) {
    theKey=aKey;
  }
  
  public void setStringToUse(String aString) {
    theString=aString;
  }

/*    public String encode()
    {
    String out=encode (theString, Trasform(theKey));
    return out;
    }*/
    
    public String decode() throws DecodingException
    {
    String out=decode (theString, Trasform(theKey));
    return out;
    }

    
/*    private String encode(String s, int ai[])
    {
        Random random = new Random();
        String s1 = "000";
        int i = 3;
        for(int j = 0; j < s.length(); j++)
        {
            char c = s.charAt(j);
            int k = c + ai[j % ai.length] * (j % 12 + 1);
            s1 = s1 + (k / 100 - (k / 1000) * 10);
            if(i++ >= 50)
            {
                s1 = s1 + "\n";
                i = 0;
            }
            s1 = s1 + (k / 10 - (k / 100) * 10);
            if(i++ >= 50)
            {
                s1 = s1 + "\n";
                i = 0;
            }
            s1 = s1 + (k - (k / 10) * 10);
            if(i++ >= 50)
            {
                s1 = s1 + "\n";
                i = 0;
            }
            int l = c % 3;
            for(int i1 = 0; i1 < l; i1++)
            {
                int j1 = random.nextInt() % 10;
                s1 = s1 + (j1 < 0 ? -j1 : j1);
                if(i++ >= 50)
                {
                    s1 = s1 + "\n";
                    i = 0;
                }
            }

        }

        s1 = s1 + "000";
        return s1;
    }*/

    private String decode(String s, int ai[]) throws DecodingException
    {
        String s1 = "";
        int i = 0;
        int j = 0;
        try
        {
            while(j + 2 < s.length() && (s.charAt(j) != '0' || s.charAt(j + 1) != '0' || s.charAt(j + 2) != '0')) 
                j++;
            if(j + 2 < s.length())
            {
                for(j += 3; j < s.length(); j++)
                {
                    char c = s.charAt(j);
                    if(c >= '0' && c <= '9')
                        s1 = s1 + c;
                }

                s = "";
                for(int k = 0; k + 2 < s1.length() && (s1.charAt(k) != '0' || s1.charAt(k + 1) != '0' || s1.charAt(k + 2) != '0');)
                {
                    int l = (s1.charAt(k) - 48) * 100 + (s1.charAt(k + 1) - 48) * 10 + (s1.charAt(k + 2) - 48);
                    l -= ai[i % ai.length] * (i % 12 + 1);
                    k += 3 + l % 3;
                    s = s + (char)l;
                    i++;
                }

                return s;
            } else
            {
                new DecodingException("Error during decoding Text");
                return null;
            }
        }
        catch(IndexOutOfBoundsException _ex)
        {
            new DecodingException("IndexOutOfBoundException during decoding Text");
            return null;
        }
    }

    private int[] Trasform (String s)
    {
        int ai[] = new int[s.length()];
        int i = 0;
        for(int j = 0; j < s.length(); j++)
        {
            char c = s.charAt(j);
            if(c >= 'A' && c <= 'Z')
            {
                ai[j] = (c - 65) + 1;
                i++;
            }
            if(c >= 'a' && c <= 'z')
            {
                ai[j] = (c - 97) + 1;
                i++;
            }
            if(c >= '0' && c <= '9')
            {
                ai[j] = (c - 48) + 1;
                i++;
            }
        }

        if(i > 0)
        {
            int ai1[] = new int[i];
            for(int k = 0; k < i; k++)
                ai1[k] = ai[k];

            return ai1;
        }
        int ai2[] = new int[5];
        for(int l = 0; l < 5; l++)
            ai2[l] = l;

        return ai2;
    }


public static void main(String args[]) throws DecodingException
  {


/*    String theString ="TEST";
    String theKey ="CORNELI";
    System.out.println ("String to Encode:"+theString);
    System.out.println ("SIZE IN -->"+theString.length());
    System.out.println ("Key to Use:"+theKey);
    
    CustomEncode myEnc = new CustomEncode(); 
    myEnc.setStringToUse(theString);
    myEnc.setKey(theKey);
    String EncodedString=myEnc.encode();
    System.out.println ("OUT ENCODED-->"+EncodedString);
    System.out.println ("SIZE OUT -->"+EncodedString.length()); 
    theString=EncodedString;
*/

    System.out.println ("-------------------------------------------------");    
    String theKey ="CORNELI";
    String theString="00008709913713140000";
    System.out.println ("-------------------------------------------------");    
    System.out.println ("String to Decode:"+theString);
    CustomDecode myEnc2 = new CustomDecode(); 
    myEnc2.setStringToUse(theString);
    System.out.println ("Key to Use:"+theKey);
    myEnc2.setKey(theKey);
    String DecodedString= myEnc2.decode();
    System.out.println ("OUT DECODED-->"+DecodedString);
  }
}  
  
