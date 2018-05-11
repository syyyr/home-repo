#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <stdbool.h>

int main(int argc, char* argv[])
{
    seteuid(0);
    int interval;
    char* env_interval = getenv("INTERVAL");
    if(!env_interval || sscanf(env_interval, "%d", &interval) != 1)
    {
        interval = 3000;
    }
    interval *= 1000; //usleep accepts microseconds
    FILE* file;

    while(true)
    {
        file = fopen("/sys/devices/platform/thinkpad_acpi/leds/tpacpi::kbd_backlight/brightness", "w");
        fwrite("0", sizeof(char), 1, file);
        fclose(file);
        usleep(500);
        file = fopen("/sys/devices/platform/thinkpad_acpi/leds/tpacpi::kbd_backlight/brightness", "w");
        fwrite("2", sizeof(char), 1, file);
        fclose(file);
        usleep(interval);
    }
}
