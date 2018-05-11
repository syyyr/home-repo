#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <stdbool.h>

int main(int argc, char* argv[])
{
    FILE* file;
    file = fopen("/sys/devices/platform/thinkpad_acpi/leds/tpacpi::kbd_backlight/brightness", "w");
    fwrite(argv[1], sizeof(char), 1, file);
    fclose(file);
}
