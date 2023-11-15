function ShowHide(objName)
{
	if (objName.style.display=="")
	{
	DownLevel_1.style.display="none"
	DownLevel_2.style.display="none"
	
	DownLevel_1_2.style.display="none"
	DownLevel_2_2.style.display="none"
	
	objName.style.display="none"
	}
else
	{
	DownLevel_1.style.display="none"
	DownLevel_1_2.style.display="none"
	DownLevel_2.style.display="none"
	DownLevel_2_2.style.display="none"
	objName.style.display=""
	}

}
function ShowHide2(objName)
{
if (objName.style.display=="")
	{
		objName.style.display="none"
	}
else
	{
		objName.style.display=""
	}
}

