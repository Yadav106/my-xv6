#include "types.h"
#include "stat.h"
#include "user.h"

#define MAX_SZ 1000

int main(int argc, const char **argv)
{
	int n;
	n = atoi(argv[1]);
	int procType[n];
	int pids[n];
	int i;
	// Set the Process types
	for(i=0; i<n; i++)
	{
		procType[i] = atoi(argv[i+2]);
	}
	// Execute the children programmes
	for(i=0;i<n;i++)
	{
		int ret;
		ret = fork();
		if(ret == 0)
		{
			if(procType[i] == 0)
			{
				int id = fork();
				if(id==0){
					sleep(200);
				}
				else 
					wait();

				exit();

			}
			else if (procType[i] == 1)
			{
				while(1){}
			}
			exit();
		}

		else if(ret>0) 
            pids[i] = ret;
	}

	int ret;
	ret = fork();
	if(ret == 0)
	{
		sleep(100);
		get_sibling();
		exit();
	}

	// Wait for the last child
	sleep(150);
	wait();

	for (i = 0; i < n; i++)
	{
		kill(pids[i]);
	}

	for(i = 0; i< n; i++)
		wait();

	exit();
}
