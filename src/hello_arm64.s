    .section .data
msg:
    .ascii "Hello, World!\n"
    len = . - msg

    .section .text
    .global _start

_start:
    mov     x0, #1          // file descriptor: stdout
    adrp    x1, msg         // address of message (page)
    add     x1, x1, :lo12:msg  // complete address
    mov     x2, #len        // length of message
    mov     x8, #64         // syscall: sys_write
    svc     #0              // make system call

    mov     x0, #0          // exit code 0
    mov     x8, #93         // syscall: sys_exit
    svc     #0              // make system call