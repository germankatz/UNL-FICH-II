#include <iostream>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

using namespace std;

int main(int argc, char *argv[]) {
	int a=5,p;
	cout<<a<<endl;
	p=fork();
	if (p==0)
		++a;
	cout<<(++a)<<endl;
	return 0;
}
