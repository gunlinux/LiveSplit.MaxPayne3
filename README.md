
# MAX PAYNE 3 AUTOSPLITTER
by *CJACOBS*!
bug tested by JJMONDO and AKHEON!
updated by gunlinux
	
# Table of Contents:

1. Installation/Setup
2. Using the Plugin Ingame
3. How it Works - Basically
4. How it Works - In-Depth
5. Changelog

# 1. Installation/Setup

This plugin is pretty easy to set up and will work with any
copy of Max Payne 3 and LiveSplit, so here's a not-super-long
step by step guide!

1. Put the plugin somewhere you won't forget. I have mine in my
LiveSplit installation folder. It doesn't matter where you stick
it, LiveSplit can load it from anywhere, but your Layout will go
wonky if it can't find the script and you load it up.

2. Open LiveSplit and right click on your timer. Go to 'Edit
Layout' and click the + button in the top left. Navigate to
'Control > Scriptable Auto Splitter' and add it to your Layout.

3. Double-click on 'Scriptable Auto Splitter'. Change the Script
Path to point at wherever you saved the plugin and it should load
all of its options in the box below. Make sure that only the box
for the category you are running is checked! You can come back
here and switch it at any time.

4. Exit out of these various menus and right click on your timer.
Go to 'Compare Against' and choose either real time or game time,
depending on your category. Check the rules for which timing method
to use on speedrun.com!

5. Make sure you have the appropriate splits!! If you are running
Story Mode, you need a split for 4-2, 5-2, 6-2, and 7-2! If you
are running either Arcade Mode, you need a split for 4-2, 5-2, and
6-2. If you do not follow this part to the letter, the autosplitter
will become desynchronized.

6. You're done! Start up Max Payne 3 and the timer will automatically
begin when you leave the main menu to start a run. Good luck! :)

# 2. Using the Plugin Ingame

You actually don't have to do anything to use the plugin, but here 
are the specifics for when it splits and pauses for each category if
you want a handy reference.

TIMER STARTS AUTOMATICALLY WHEN:
	Story Mode: The Chapter 1 intro FMV ends, just before gaining control of Max
	Score Attack: When Chapter 1 finishes loading, just before gaining control of Max
	NYM HC: Exactly when you gain control of Max in Chapter 1

TIMER PAUSES AUTOMATICALLY WHEN:
	Story Mode: The timer never pauses as Story Mode uses RTA
	Score Attack: The player is on the main menu, or in a loading screen
	NYM HC: The player is NOT in gameplay of any kind (cutscenes, chapter end, etc)

TIMER SPLITS AUTOMATICALLY WHEN:
	Story Mode: You skip the FMV outro for a chapter and enter the next one's intro
	Score Attack: Returning to the main menu from a chapter end screen
	NYM HC: Continuing to the next chapter from a chapter end screen

TIMER STOPS AUTOMATICALLY WHEN:
	Story Mode: The timer does not currently stop automatically, sorry :(
	Score Attack: The chapter end screen appears after destroying Victor's plane
	NYM HC: The 'congratulations' screen appears after destroying Victor's plane

# 3. How it Works - Basically

It's actually pretty simple, not even 70 lines of code!

In a nutshell, Max Payne 3 keeps track of how long you have been playing
the game when you go from the main menu to gameplay. This number is kept
in seconds, and resets every time you enter a new chapter or return to 
the main menu. The plugin works by looking through your game's data to
find this number and read it while you're playing. With that, in combination
with finding what chapter you are on, the plugin is able to intelligently
make splits for you and keep track of time better than a human ever could!

# 4. How it Works - In Depth

There's actually not much more to it than that, but if you want a more
thorough breakdown, here it is!

At address 0x144C97C, a 'base address' can be found with some fiddling that
keeps track of your gameplay time. The plugin shows you this number as your
current IGT on the timer. It also looks at addresses 0x142461D and 0x155B07C
to find the name of your current map and chapter. Using these three values
in combination, it can determine when you have finished a chapter, gone back
to the main menu, and are or are not currently in control of Max! The plugin
checks every update (every 1 or 2 frames) to see if the gameplay time is the
same as it was on the previous frame- if it is, this means your game is paused
for any of the reasons I just listed, and it pauses your timer for you. It
also checks every update to see if your chapter is different than it was on
the last update- if so, it then does a second check to see what it has just
changed to. If it changed to 'frontend' outside of Score Attack, it means
your run is over. If you ARE in Score Attack, it makes a split, as that's the
main menu which is where Score Attack splits are made. If it changes to anything
else, it makes a split, because it means you've entered a new chapter.

# 5. Changelog

## v1.0 [11/24/18] - Initial release.
	
## v1.1 [11/25/18] - Bug fixes.
	
	- Replaced the gameplay timer address with one that has fewer offests. This
	should result in much better compatibility. Thanks for the help AKheon and JJMondo!
	
	- Added a new variable to force all modes to reset the 'rememberTime' variable
	when you start a new run. Previously it didn't do this, which meant your timer
	would start with a random amount of time tacked on in a new run. That's fixed now.
	
## v1.2 [11/26/18] - Major code overhaul.
	
	- Got rid of some unnecessary variables and changed how the plugin interprets
	Max Payne 3's gameplay timer. Previously the plugin displayed Max Payne 3's
	gameplay timer as YOUR time, which was 100% accurate but led to irreparable
	weirdness if the player died and restarted from checkpoint.
	
	- The new variable that displays on your LiveSplit timer is controlled by the 
	plugin, not Max Payne 3. The plugin now takes Max Payne 3's gameplay timer and 
	interprets it so that the gameplay timer going DOWN (resetting from checkpoint,
	changing chapters) does not affect your LiveSplit timer. It is still 1:1
	accurate with gameplay and the game's timescale. Thanks for the help JJMondo!
	
	- In addition, I removed the need for the option checkboxes. Now the plugin
	automatically knows which gamemode you're playing by checking if Max Payne 3's
	gameplay timer is even running. If it's not, it means you're playing Story Mode,
	so it doesn't bother checking again on that run.

## v1.3 [02/21/19] - Added sanity checks.
	
	- The splitter now has a couple of sanity checks, so that it can be used with
	glitches, exploits, or other strategies that require quitting back to the menu.
	This means the timer will now work and split properly with during runs that
	make use of Future Data!
	
	- Specifically, before this update, the splitter didn't actually check to see
	if you had gone to a new chapter than the one you were on, only if the name of
	the chapter had changed. Since the chapter name changes to "frontend" when you
	return to the main menu, the splitter would make a split.
	
	- The sanity check looks at your chapter name when you return to the main menu
	and stores it for later use. When you continue your game, it checks to see if
	the new chapter name is different than what it has stored, and if not, then it
	does not make a split. This means you can quit to the main menu and continue
	during a run (necessary for Future Data) without the splitter bugging out!

##v1.4 [4/23/21] by @gunlinux

	- Added support for current Max Payne 3 build 1.0.0.255 with fallback for 1.3 build. Works on rockstar game launcher as well  
	
	- Sanity and debug for next updates
	
	- Thanks Tha_YETI for rockstar game launcher version 
