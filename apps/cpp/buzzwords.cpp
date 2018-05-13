#include <iostream>
#include <cstdlib>
#include <ctime>
#include <string>
using namespace std;

void GenerateBuzzword(int len, string& out)
{
    len ?  out+=(char)(rand() % 255), GenerateBuzzword(len-1, out) : (void)(out+=".js");
}

int main(int argc, char* argv[])
{
    if(argc == 1)
    {
        cout << "Usage: " << argv[0] << " [buzzword-length]" << endl;
        return 0;
    }
    string out;
    srand(time(0));
    GenerateBuzzword(stoi(argv[1]), out);
    cout << out << endl;
    return 0;
}
