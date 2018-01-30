#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
int main() {
	pid_t pid;
	int i;
	pid = fork();
	//la funcion fork(); retorna un 0 a los procesos hijos
		if (pid == 0) {
			/* Proceso hijo:
			* Aquí contamos hasta diez, uno cada segundo.*/
			for(i=0; i < 10; i++) {
				printf("hijo: %d \n", i);
				sleep(1);
			}
			return 0;
		}
		else if
			(pid > 0) {
			/* Proceso padre:
			* Si no estamos en el proceso padre.
			* De nuevo contamos hasta diez. */
			for(i=0; i < 10; i++) {
				printf("padre: %d \n", i);
				sleep(1);
			}
			return 0;
		}
		else {
			/*ha ocurrido un error. */
			printf("no se ha podido bifurcar");
		}
		return 0;
}
