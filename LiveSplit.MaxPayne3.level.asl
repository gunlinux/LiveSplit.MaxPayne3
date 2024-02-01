state("MaxPayne3")
{
	float chapterTime   : 0x13B0EE0, 0x20C;  // no correct yet
	string7 chapterName : 0x142461D;
	int checkpoint:  0x149169C;              // no correct yet
}

state("MaxPayne3", "Steam")
{
	float chapterTime   : 0x13C51EC, 0x20C;
	string7 chapterName : 0x143899D;
	int checkpoint: 0x013C51EC, 0x1B4;
}

state("MaxPayne3", "Steam0124") {
	float chapterTime   : 0x013C42E0, 0x20C;
	string7 chapterName : 0x1437A1D;
	int checkpoint: 0x013C42E0, 0x1B4; // not correct yet
}

state("MaxPayne3", "Social Club")
{
	float chapterTime :   0x13C216C, 0x20C; 
	string7 chapterName : 0x143591D;
	int checkpoint: 0x013C51EC, 0x1B4;      // no correct yet
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
   		case 303793152:
   			version = "Steam0124"; 
   			print("Steam0124");
   			break;
 	}
	vars.totalTime = 0;
	vars.chapter0 = "";
	vars.chapter1 = "fashion";
	vars.chapterTemp = "";
	vars.storeChapter = 0;
	print("init ok");
}

start
{
	if (current.chapterTime > 0)
	{
		print("start. 1 by chapter time ");
		vars.chapterTemp = "";
		vars.storeChapter = 1;
		vars.totalTime = 0;
		return true;
	}
	if (vars.storeChapter == 1)
	{
		print("start. 2 by chapter name ");
		vars.chapterTemp = "";
		vars.storeChapter = 1;
		vars.totalTime = 0;
		return true;
	}
}

update
{
	print("current level");
	print(current.chapterName.ToString());
	print("current checkpoint");
	print(current.checkpoint.ToString());
	
	if (current.chapterTime > old.chapterTime)
	{
		vars.totalTime = vars.totalTime + (current.chapterTime - old.chapterTime);
	}
	if (current.chapterName == vars.chapter0 && vars.storeChapter == 1)
	{
		vars.chapterTemp = old.chapterName;
		print("update.store chapterTemp: " + vars.chapterTemp.ToString());
		vars.storeChapter = 0;
	}
	if (current.chapterName != old.chapterName &&  current.chapterName != vars.chapter0 && vars.storeChapter == 0)
	{
		print("update.store chapter: " + current.chapterName.ToString() + " " + old.chapterName.ToString() + " " + vars.chapterTemp.ToString());
		vars.storeChapter = 1;
	}
}

split
{
	if (current.chapterName != old.chapterName && current.chapterName != vars.chapter0 && current.chapterName != vars.chapterTemp)
	{
		print("split by chapter lvl");
		return true;
	}
	if (current.checkpoint > old.checkpoint) {
		print("split by checkpoint: " + current.checkpoint.ToString() + " / " + old.checkpoint.ToString() );
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
