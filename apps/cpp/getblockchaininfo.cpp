#include <ncursesw/ncurses.h>
#include <cstdlib>
#include <cstdio>
#include <unistd.h>
#include <cstring>
#include <clocale>
#include <cwchar>
#include <map>
using namespace std;
int cur_pair = 1;
int def_back = 0;
int def_fore = 255;
int cur_back = 0;
int cur_fore = 255;
const int CMD_BACK_DEF = 0;
const int CMD_BACK_CHG = 1;
const int CMD_FORE_DEF = 2;
const int CMD_FORE_CHG = 3;

map<pair<int, int>, int> pairs;


void printinfo()
{
	char buff[1024];
	FILE* fp;
	fp = popen("dogecoin-cli getblockchaininfo", "r");
	if (fp == NULL)
	{
		printf("Failed to run command\n" );
		return;
	}
	clear();
	printw("Dogecoin blockchain data\n");
	while (fgets(buff, sizeof(buff)-1, fp) != NULL)
	{
	 	printw(buff);
	}
	/*attron(COLOR_PAIR(1));
	printw("\nvery doge\n");
	attroff(COLOR_PAIR(1));
	attron(COLOR_PAIR(2));
	printw("\n          much wow\n");
	attroff(COLOR_PAIR(2));
	attron(COLOR_PAIR(3));
	printw("\n     so coin\n");
	attroff(COLOR_PAIR(3));*/
	
	fclose(fp);
}

void changebackcolor(int num)
{
	attroff(COLOR_PAIR(cur_pair));
	
	if(pairs.find(make_pair(cur_fore, num)) == pairs.end())
	{
		cur_pair = pairs.size()+1;
		init_pair(pairs.size()+1, cur_fore, num);
		pairs.insert(make_pair(make_pair(cur_fore, num), pairs.size()+1));
	}
	else
	{
		cur_pair = pairs.find(make_pair(cur_fore, num))->second;
	}
	attron(COLOR_PAIR(cur_pair));
	cur_back = num;
}

void changeforecolor(int num)
{
	attroff(COLOR_PAIR(cur_pair));
	
	if(pairs.find(make_pair(num, cur_back)) == pairs.end())
	{
		cur_pair = pairs.size()+1;
		init_pair(pairs.size()+1, num, cur_back);
		pairs.insert(make_pair(make_pair(num, cur_back), pairs.size()+1));
	}
	else
	{
		cur_pair = pairs.find(make_pair(num, cur_back))->second;
	}
	attron(COLOR_PAIR(cur_pair));
	cur_fore = num;
}

void printdoge()
{
	FILE* doge = fopen("doge.txt", "r");
	wchar_t buff[1024] = {0};
	int k = 0;
	while (fgetws(buff, sizeof(buff)-1, doge) != NULL)
	{
		k++;	
		int i = 0;
		for	(i = 0; i < wcslen(buff); i++)
		{
			if('' == buff[i] && '[' == buff[i+1])
			{
				int command;
				if(buff[i+2] == '4' && buff[i+3] == '9') command = CMD_BACK_DEF;
				if(buff[i+2] == '4' && buff[i+3] == '8') command = CMD_BACK_CHG;
				if(buff[i+2] == '3' && buff[i+3] == '9') command = CMD_FORE_DEF;
				if(buff[i+2] == '3' && buff[i+3] == '8') command = CMD_FORE_CHG;
				switch(command)
				{
					case 0:
					{				
						changebackcolor(def_back);
						i += 4;
						
						break;
					}
					case 1:
					{
						wchar_t colorNumString[5] = {0};
						int size = 0;
						int j;
						for(j = i+7; ; j++)
						{
							if(buff[j] == 'm')
								break;
							colorNumString[size++] = buff[j];
							
						}
						changebackcolor(wcstol(colorNumString, NULL, 10));
						i +=  wcslen(colorNumString)+1+6;

						break;
					}
					case 2:
					{
						changeforecolor(def_fore);
						i += 4;
						break;
					}
					case 3:
					{
						wchar_t colorNumString[5] = {0};
						int size = 0;
						int j;
						for(j = i+7; ; j++)
						{
							if(buff[j] == 'm')
								break;
							colorNumString[size++] = buff[j];
							
						}
						changeforecolor(wcstol(colorNumString, NULL, 10));
						i += wcslen(colorNumString)+1+6;
						break;
					}
					
				}
				
			}
			else
			{
				wchar_t wstr[] = { buff[i], L'\0' };
				addwstr(wstr);
			}

		}	
	}
}

void reset()
{
	attroff(COLOR_PAIR(cur_pair));
	cur_pair = 1;
	cur_back = 0;
	cur_fore = 255;
	attron(COLOR_PAIR(cur_pair));
}

int main(int argc, char* argv[])
{
	setlocale(LC_ALL, "");
	initscr();
	raw();
	noecho();
	start_color();
	pairs.insert(make_pair(make_pair(cur_fore, cur_back), pairs.size()+1));
	init_pair(cur_pair, cur_fore, cur_back);
	attron(COLOR_PAIR(1));
	int delay = 1000;
	if (argc > 1)
		delay = atoi(argv[1]);
	timeout(delay);
	int end = 0;
	while(!end)
	{
		reset();
		printinfo();
		printdoge();
		refresh();
		int ch = getch();
		switch(ch)
		{
			case ERR:
				break;
			default:
				end = 1;
				break;			
		}
		reset();
	}
	
	endwin();
	
	return 0;
}

