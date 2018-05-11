#include <stdio.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <stdbool.h>

void done(int signum)
{
    remove("/tmp/kbd_pulse.pid");
    exit(0);
}

void daemonize()
{

    pid_t pid = fork();

    if (pid < 0)
        exit(1);

    if (pid > 0)
        exit(0);

    if (setsid() < 0)
        exit(1);



    signal(SIGTERM, done);
    pid = fork();
    if (pid < 0)
        exit(1);

    if (pid > 0)
        exit(0);

    umask(0000);
    chdir("/");
    int x;
    for (x = sysconf(_SC_OPEN_MAX); x>=0; x--)
    {
        close (x);
    }


}

int main(int argc, char* argv[])
{
    daemonize();

    seteuid(0);
    FILE* run = fopen("/tmp/kbd_pulse.pid", "a");
    if (ftell(run) == 0)
    {
        fprintf(run, "%d\n", getpid());
        fflush(run);
        fclose(run);
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
            sleep(3);
        }
    }
    else
    {
        exit(1);
    }
}
