
#include <windows.h>
#include <powrprof.h>
#include <string>
//#include <cstdio>


int logf(std::string f,...){
    va_list args;
    va_start(args,f);
    f.append("\n");
    int rv=vprintf(f.c_str(),args);
    va_end(args);
    return rv;
}


int suspend_s3()
{
    int rv=SetSuspendState(0,0,0);
    return rv;
}

int suspend_s0()
{
    int rv=SendMessage(HWND_BROADCAST,WM_SYSCOMMAND,SC_MONITORPOWER,2);
    return rv;
}




int usage(char* argv[]){
    const char* f=R"EOF(SYNOPSIS
    %s --s0
    %s --s3
EPILOGUE
    --s0 DPMS off. MS's "modern standby".
    --s3 Suspend to RAM.
)EOF";
    logf(f,argv[0],argv[0]);
    return 0;
}

int main(int argc,char* argv[])
{
    int rv=0;
    if(argc>1){
        if(std::strcmp(argv[1],"--s0")==0){
            rv=suspend_s0();
            logf("sleep state: S0ix, rv: %d",rv);
            return rv>0?0:1;
        }
        if(std::strcmp(argv[1],"--s3")==0){
            rv=suspend_s3();
            int err=0;
            if(rv==0){
                err=GetLastError();
            }
            logf("sleep state: S3, rv: %d, err: %d",rv,err);
            return rv>0?0:1;
        }
    }

    rv=usage(argv);
    return 1;
}







