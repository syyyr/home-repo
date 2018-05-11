#include <cstdio>
#include <unistd.h>
#include <csignal>
#include <chrono>
#include <thread>
#include <atomic>
#include <condition_variable>
FILE* process = NULL;

std::mutex mtx;
std::condition_variable cond;
std::atomic<bool> cont = true;
std::thread x;

void wait_func(int timeout)
{
    std::chrono::seconds s(timeout);

    while (cont)
    {
        std::unique_lock lock(mtx);
        if(cond.wait_for(lock, s) == std::cv_status::timeout)
            system("kbacklight 0");
    }
}

void done(int signum)
{
    pclose(process);
    process = NULL;
    cont = false;
    x.join();
    exit(0);
}

int main(int argc, char* argv[])
{
    signal(SIGTERM, done);
    signal(SIGINT, done);

    int timeout;
    char* env_timeout = getenv("TIMEOUT");
    if(!env_timeout || sscanf(env_timeout, "%d", &timeout) != 1)
    {
        timeout = 3;
    }

    while(!process)
    {
        process = popen("xinput test \"AT Translated Set 2 keyboard\"", "r");
        sleep(1);
    }
    x = std::thread(wait_func, timeout);

    int a;
    while(cont)
    {
        char* line = NULL;
        size_t len = 0;
        getline(&line, &len, process);
        if (sscanf(line, "key press %d\n", &a) != 1)
        {
            printf("couldnt read keypress: ");
            printf("%s", line);
        }
        else
        {
            printf("%d caught, lighting KB, notifying the waiting thread\n", a);
            system("kbacklight 2");
            cond.notify_one();
        }
    }

    pclose(process);
    return 0;
}
