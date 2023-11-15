var bottomBorder  = false;
var isNav = false;
var isIE  = false;
var winPrefs="";
if (navigator.appName == "Netscape")
{
    isNav = true;
    winPrefs="dependent=yes,width=200,height=200,status=no,screenX=200,screenY=200,title=no";
}
else
{
    isIE = true;
    winPrefs="width=200,height=200,status=no,left=200,top=200,title=no";
}


buildCalParts();


function setInitialValues(dateField,dateInitial) 
{

    calDateField = "document."+dateField;

    calDate = new Date(dateInitial);

    // Controlla se la data in input è una data valida, altrimenti la setta al giorno corrente
    if (isNaN(calDate))
        calDate = new Date();
    
    calDay  = calDate.getDate();

    calDate.setDate(1);

}

function showCalendar(dateField,dateInitial) 
{
	if (!top.newWin|| (top.newWin && top.newWin.closed))
	{

	    setInitialValues(dateField,dateInitial);

	    calDocFrameset = 
		"<HTML><HEAD><TITLE>JavaScript Calendar</TITLE></HEAD>\n" +
		"<FRAMESET ROWS='60,*' FRAMEBORDER='0'>\n" +
		"  <FRAME NAME='topCalFrame' SRC='javascript:parent.opener.buildTopCalFrame()' SCROLLING='no'>\n" +
		"  <FRAME NAME='bottomCalFrame' SRC='javascript:parent.opener.buildBottomCalFrame()' SCROLLING='no'>\n" +
		"</FRAMESET>\n";

	    top.newWin = window.open("javascript:parent.opener.calDocFrameset", "calWin", winPrefs);
	    top.newWin.focus();
	}
	else
	    top.newWin.focus();

}


function buildTopCalFrame() 
{

    var calDoc =
        "<HTML>" +
        "<HEAD>" +
        
        "<STYLE type='text/css'>" +
        "<!--" +
        ".text { text-decoration: none; color:006699; font: normal 8pt Verdana,Arial; }" +
        ".textB { text-decoration: none; color:004256; font: bolder 8pt Verdana,Arial; }" +
        "-->" +
        "</STYLE>" +
        
        "<SCRIPT LANGUAGE='JavaScript'>"+
        
        "function handlefocus()"+
        "{"+
            "if (parent.opener.isNav)"+
            "{ "+
              "document.captureEvents(Event.KEYUP); "+
              "document.onKeyUp=key; "+
            "} "+
            "else "+
              "document.onkeyup=key; "+
          
        "} "+       
        "function key(k)"+
        "{ " +
        
        "if (document.calControl.year.value.length==4) "+
            "parent.opener.setYear(); "+   
        "return true; "+
        "}"+

        "</SCRIPT>"+
        "</HEAD>" +
        "<BODY>" +
        "<FORM NAME='calControl' onSubmit='return false;'>" +
        "<TABLE CELLPADDING=0 CELLSPACING=1 BORDER=0 ALIGN='CENTER'>" +
        "<TR><TD class='text' ALIGN='CENTER'>" +
        getMonthSelect() +
        "<INPUT class='text' NAME='year' VALUE='" + calDate.getFullYear() + "'TYPE=TEXT SIZE=4 MAXLENGTH=4 onFocus='handlefocus()'>" +
        "</TD>" +
        "</TR>" +
        "<TR>" +
        "<TD ALIGN='CENTER'>" +
        "<INPUT class='textB' TYPE=BUTTON NAME='previousYear' VALUE='<<'    onClick='parent.opener.setPreviousYear()'>"+
        "<INPUT class='textB' TYPE=BUTTON NAME='previousMonth' VALUE=' < '   onClick='parent.opener.setPreviousMonth()'>"+
        "<INPUT class='textB' TYPE=BUTTON NAME='today' VALUE='Oggi' onClick='parent.opener.setToday()'>"+
        "<INPUT class='textB' TYPE=BUTTON NAME='nextMonth' VALUE=' > '   onClick='parent.opener.setNextMonth()'>"+
        "<INPUT class='textB' TYPE=BUTTON NAME='nextYear' VALUE='>>'    onClick='parent.opener.setNextYear()'>" +
        "</TD>" +
        "</TR>" +
        "</TABLE>" +
        "</FORM>" +
        "</BODY>" +
        "</HTML>";

    return calDoc;
}


function buildBottomCalFrame() 
{       

    var calDoc = calendarBegin;
    month   = calDate.getMonth();
    year    = calDate.getFullYear();
    day     = calDay;
    var i   = 0;
    var columnCount = 0;
    var currentDay = 0;
    var dayType    = "weekday";
    var paddingChar = "";
    var days = getDaysInMonth();

    if (day > days)
        day = days;

    var firstOfMonth = new Date (year, month, 1);

    var startingPos  = firstOfMonth.getDay();
    if (startingPos==0)
        startingPos=7; 	
    days += startingPos;

    // Disegna le celle iniziali vuote
    for (i = 1; i < startingPos; i++) 
    {
        calDoc += "<TD bgcolor='#DBEAF5' class='blanck'>&nbsp;&nbsp;&nbsp;</TD>";
    	columnCount++;
    }
    
    // Disegna le celle dei giorni del mese
    for (i = startingPos+1; i <= days; i++) 
    {


        if (i-startingPos+1 <= 10) 
            padding = "&nbsp;&nbsp;";
        else
            padding = "&nbsp;";

        currentDay = i-startingPos;

        if ((columnCount % 7 == 6) ||(columnCount % 7 == 5) )
        {
    		if (currentDay == day) 
    			calDoc += "<TD bgcolor='white'>" + "<a class='focusDay' href='javascript:parent.opener.returnDate(" + currentDay + ")'>" + padding + currentDay + paddingChar +"</a></TD>";
    		else
    		        calDoc += "<TD  bgcolor='#CCCCCC'>" + "<a class='weekDay' href='javascript:parent.opener.returnDate(" + currentDay + ")'>" + padding + currentDay + paddingChar + "</a></TD>";
        }
        else 
        {
    		if (currentDay == day) 
    			calDoc += "<TD  bgcolor='white'>" + "<a class='focusDay' href='javascript:parent.opener.returnDate(" + currentDay + ")'>" + padding + currentDay + paddingChar + "</a></TD>";
    		else
    			calDoc += "<TD  bgcolor='#DBEAF5'>" + "<a class='weekDay' href='javascript:parent.opener.returnDate(" + currentDay + ")'>" + padding + currentDay + paddingChar + "</a></TD>";
        
        }
        columnCount++;

        if (columnCount % 7 == 0) 
            calDoc += "</TR><TR>";
    }
    
    // Disegna le celle finali vuote
    for (i=days; i<=42; i++)  
    {

        calDoc += "<TD bgcolor='#DBEAF5' class='blanck'>&nbsp;&nbsp;&nbsp;</TD>";
        columnCount++;

        if (columnCount % 7 == 0) 
        {
            calDoc += "</TR>";
            if (i<41)
                calDoc += "<TR>";
        }
    }

    calDoc += calendarEnd;
    return calDoc;
}


function writeCalendar() 
{

    calDocBottom = buildBottomCalFrame();

    top.newWin.frames['bottomCalFrame'].document.open();
    top.newWin.frames['bottomCalFrame'].document.write(calDocBottom);
    top.newWin.frames['bottomCalFrame'].document.close();
}


function setToday() {

    calDate = new Date();

    var month = calDate.getMonth();
    var year  = calDate.getFullYear();
    calDay  = calDate.getDate();

    top.newWin.frames['topCalFrame'].document.calControl.month.selectedIndex = month;

    top.newWin.frames['topCalFrame'].document.calControl.year.value = year;
    
    writeCalendar();
}


function setYear() 
{

    var year  = top.newWin.frames['topCalFrame'].document.calControl.year.value;

    if (isFourDigitYear(year)) 
    {
        calDate.setFullYear(year);
        writeCalendar();
    }
    else 
    {
        top.newWin.frames['topCalFrame'].document.calControl.year.focus();
        top.newWin.frames['topCalFrame'].document.calControl.year.select();
    }
}


function setCurrentMonth() 
{

    var month = top.newWin.frames['topCalFrame'].document.calControl.month.selectedIndex;

    calDate.setMonth(month);
    writeCalendar();
}


function setPreviousYear() 
{

    var year  = top.newWin.frames['topCalFrame'].document.calControl.year.value;

    if (isFourDigitYear(year) && year > 1000) 
    {
        year--;
        calDate.setFullYear(year);
        top.newWin.frames['topCalFrame'].document.calControl.year.value = year;
        writeCalendar();
    }
}


function setPreviousMonth() 
{

    var year  = top.newWin.frames['topCalFrame'].document.calControl.year.value;
    if (isFourDigitYear(year)) 
    {
        var month = top.newWin.frames['topCalFrame'].document.calControl.month.selectedIndex;

        if (month == 0) 
        {
            month = 11;
            if (year > 1000)
            {
                year--;
                calDate.setFullYear(year);
                top.newWin.frames['topCalFrame'].document.calControl.year.value = year;
            }
        }
        else
            month--;
        calDate.setMonth(month);
        top.newWin.frames['topCalFrame'].document.calControl.month.selectedIndex = month;
        writeCalendar();
    }
}


function setNextMonth() 
{

    var year = top.newWin.frames['topCalFrame'].document.calControl.year.value;

    if (isFourDigitYear(year))
    {
        var month = top.newWin.frames['topCalFrame'].document.calControl.month.selectedIndex;

        if (month == 11) 
        {
            month = 0;
            year++;
            calDate.setFullYear(year);
            top.newWin.frames['topCalFrame'].document.calControl.year.value = year;
        }
        else
            month++;
        calDate.setMonth(month);
        top.newWin.frames['topCalFrame'].document.calControl.month.selectedIndex = month;
        writeCalendar();
    }
}


function setNextYear() 
{

    var year  = top.newWin.frames['topCalFrame'].document.calControl.year.value;
    if (isFourDigitYear(year)) 
    {
        year++;
        calDate.setFullYear(year);
        top.newWin.frames['topCalFrame'].document.calControl.year.value = year;
        writeCalendar();
    }
}


function getDaysInMonth()  
{

    var days;
    var month = calDate.getMonth()+1;
    var year  = calDate.getFullYear();

    if (month==1 || month==3 || month==5 || month==7 || month==8 || month==10 || month==12) 
        days=31;
    else if (month==4 || month==6 || month==9 || month==11)
        days=30;
    else if (month==2)  
    {
        if (isLeapYear(year)) 
            days=29;
        else 
            days=28;
    }
    return (days);
}


function isLeapYear (Year) 
{

    if (((Year % 4)==0) && ((Year % 100)!=0) || ((Year % 400)==0))
        return (true);
    else
        return (false);
}


function isFourDigitYear(year) 
{

    if (year.length != 4)
    {
        top.newWin.frames['topCalFrame'].document.calControl.year.value = calDate.getFullYear();
        top.newWin.frames['topCalFrame'].document.calControl.year.select();
        top.newWin.frames['topCalFrame'].document.calControl.year.focus();
        return false;
    }
    else
        if (!Number(year))
        {
            window.alert("Questo campo contiene valori numerici");
            top.newWin.frames['topCalFrame'].document.calControl.year.value = calDate.getFullYear();
            top.newWin.frames['topCalFrame'].document.calControl.year.select();
            top.newWin.frames['topCalFrame'].document.calControl.year.focus();
            return false;
        }
    return true;
}


// Costruisce il combo dei mesi
function getMonthSelect() 
{
    var monthArray = new Array('Gennaio', 'Febbraio', 'Marzo', 'Aprile', 'Maggio', 'Giugno','Luglio', 'Agosto', 'Settembre', 'Ottobre', 'Novembre', 'Dicembre');
    
    var activeMonth = calDate.getMonth();

    monthSelect = "<SELECT class='text' NAME='month' onChange='parent.opener.setCurrentMonth()'>";

    for (i in monthArray) 
    {
        if (i == activeMonth)
            monthSelect += "<OPTION SELECTED>" + monthArray[i] + "\n";
        else
            monthSelect += "<OPTION>" + monthArray[i] + "\n";
    }
    monthSelect += "</SELECT>";

    return monthSelect;
}


function createWeekdayList() 
{

    weekdayArray = new Array('Lun','Mar','Merc','Gio','Ven','Sab','Dom');

    var weekdays = "<TR>";

    for (i in weekdayArray)
        weekdays += "<TD  bgcolor='#0A6B98' align='center' class='heading'>" + weekdayArray[i] +"</TD>";
    weekdays += "</TR>";

    return weekdays;
}


function buildCalParts() 
{

    weekdays = createWeekdayList();

    calendarBegin =
        "<HTML>" +
        "<HEAD>" +
        "<STYLE type='text/css'>" +
        "<!--" +
        "TD.heading { text-decoration: none; color:white; font: bold 8pt Verdana,Arial; }" +
        "TD.blanck { color: #004256; text-decoration: none; font:8pt Verdana,Arial; }" +
        "A.focusDay:link { color: #004256; text-decoration: none; font:8pt Verdana,Arial; }" +
        "A.focusDay:visited { color: #004256; text-decoration: none; font:8pt Verdana,Arial; }" +
        "A.focusDay:hover { color: #FF0000; text-decoration: none; font: 8pt Verdana,Arial; }" +
        "A.weekday:link { color: blue; text-decoration: none; font: 8pt Verdana,Arial; }" +
        "A.weekday:hover { color: blue; text-decoration: none; font: 8pt Verdana,Arial; }" +
        "A.weekday:visited { color: blue; text-decoration: none; font: 8pt Verdana,Arial; }" +
        "-->" +
        "</STYLE>" +
        "</HEAD>" +
        "<BODY" +
        "<CENTER>";

    if (isNav) 
    {
        calendarBegin += 
            "<TABLE CELLPADDING=0 CELLSPACING=1 BORDER=0 ALIGN=CENTER BGCOLOR='black'><TR><TD>";
    }

    calendarBegin +=
        "<TABLE CELLPADDING=0 CELLSPACING=1 BORDER=0 ALIGN=CENTER BGCOLOR='black'>" + weekdays + "<TR>";


    calendarEnd = "";

    if (bottomBorder) 
        calendarEnd += "<TR></TR>";

    if (isNav)
        calendarEnd += "</TD></TR></TABLE>";

    calendarEnd +=
        "</TABLE>" +
        "</CENTER>" +
        "</BODY>" +
        "</HTML>";
}

function makeTwoDigit(inValue) 
{

    var numVal = parseInt(inValue, 10);

    if (numVal < 10) 
        return("0" + numVal);
    else 
        return numVal;
}
  
function returnDate(inDay)
{
    calDate.setDate(inDay);
    
    var day           = calDate.getDate();
    var month         = calDate.getMonth()+1;
    var year          = calDate.getFullYear();
    
    var returnField= eval(String(calDateField));
    
    day = makeTwoDigit(day);
    month = makeTwoDigit(month);
    returnField.value =day+"/"+month+"/"+year;
    top.newWin.close()
    
  //  alert(calDateField);
    if (calDateField=='document.frmDati.srcDIF'
        || calDateField=='document.frmDati.strDataFineFatrz'
         || calDateField=='document.frmDati.strDataInizioValid'
         || calDateField=='document.frmDati.strDataFineValid'
         || calDateField=='document.frmDati.strDataCreaz'
         || calDateField=='document.frmDati.strDataInizioNol'
         || calDateField=='document.frmDati.strDataRicezOrdine'
          || calDateField=='document.frmDati.strDataCessaz'
       ){

       returnField.onchange();
    }
}


