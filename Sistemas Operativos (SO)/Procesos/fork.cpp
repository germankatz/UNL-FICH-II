#include <iostream>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

using namespace std;

int main(int argc, char *argv[]) {
		fork();
		fork();
		fork();
		printf("FICH\n");
	return 0;
}

