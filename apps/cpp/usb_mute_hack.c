#include <linux/input.h>
#include <stdlib.h>
#include <stdio.h>

int main(int argc, char* argv[])
{
    char* device_path = getenv("DEVICE_PATH");
    if(!device_path)
    {
        printf("[ERR] DEVICE_PATH not specified.\n");
        return 1;
    }

    FILE* device = fopen(device_path, "r");
    while(1) {
        struct input_event event;

        fread(&event, sizeof(event), 1, device);

        if (event.type == EV_KEY && event.value == 0 && event.code == KEY_MUTE) {
            system("amixer -c 1 set Speaker mute; amixer -c 1 set Speaker unmute");
        }
    }
}
