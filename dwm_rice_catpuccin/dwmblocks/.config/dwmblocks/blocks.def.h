//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/

	{" ", " free -h | awk 'NR==2{print $3}'", 10,      0}, 

	{" ", "./.config/dwmblocks/scripts/cpu.sh", 10,      0}, 

	{" ", "date '+%R'",	60,		0},

	{" ", "date '+%A %b %d' ",					60,		0},

};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "   ";
static unsigned int delimLen = 5;
