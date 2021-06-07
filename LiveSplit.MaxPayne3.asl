state("MaxPayne3")
{
	float chapterTime   : 0x13B0EE0, 0x20C;  // no correct yet
	string7 chapterName : 0x142461D;
}

state("MaxPayne3", "Steam")
{
	float chapterTime   : 0x13C51EC, 0x20C;
	string7 chapterName : 0x143899D;
}

state("MaxPayne3", "Social Club")
{
	float chapterTime :   0x13C216C, 0x20C; 
	string7 chapterName : 0x143591D;
}

init
{
	print(modules.First().ModuleMemorySize.ToString());
	switch (modules.First().ModuleMemorySize)
 	{
  		case 303780864:
   			version = "Social Club";
   			break;
   		case 303797248:
   			version = "Steam";
   			break;
 	}
	vars.totalTime = 0;
	vars.chapter0 = "";
	vars.chapter1 = "fashion";
	vars.chapter14 = "air";
	vars.chapterTemp = "";
	vars.storeChapter = 1;
}

start
{
	if (current.chapterTime > 0)
	{
		vars.chapterTemp = "";
		vars.storeChapter = 1;
		vars.totalTime = 0;
		return true;
	}
	else if (current.chapterName == vars.chapter1)
	{
		vars.chapterTemp = "";
		vars.storeChapter = 1;
		vars.totalTime = 0;
		return true;
	}
}

update
{
	if (current.chapterTime > old.chapterTime)
	{
		vars.totalTime = vars.totalTime + (current.chapterTime - old.chapterTime);
	}
	if (current.chapterName == vars.chapter0 &&
	vars.storeChapter == 1)
	{
		vars.chapterTemp = old.chapterName;
		vars.storeChapter = 0;
	}
	if (current.chapterName != old.chapterName && 
	current.chapterName != vars.chapter0 && 
	vars.storeChapter == 0)
	{
		vars.storeChapter = 1;
	}
}

split
{
	if (current.chapterName != old.chapterName && 
	current.chapterName != vars.chapter0 && 
	current.chapterName != vars.chapterTemp)
	{
		return true;
	}
}

isLoading //For Score Attack and NYM only. Does nothing in Story Mode.
{
	return true;
}

gameTime //For Score Attack and NYM only. Does nothing in Story Mode.
{
	if (current.chapterTime > old.chapterTime)
	{
		return TimeSpan.FromSeconds(vars.totalTime);
	}
}