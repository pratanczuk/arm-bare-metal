    .section .data
msg:
    .ascii "Hello, World!\n"
    len = . - msg

    .section .text
    .global _start

_start:
    mov     r7, #4          @ syscall: sys_write
    mov     r0, #1          @ file descriptor: stdout
    ldr     r1, =msg        @ address of message
    mov     r2, #len        @ length of message
    svc     #0              @ make system call

    mov     r7, #1          @ syscall: sys_exit
    mov     r0, #0          @ exit code 0
    svc     #0              @ make system call
