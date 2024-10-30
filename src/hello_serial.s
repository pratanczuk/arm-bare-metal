 .syntax unified
    .cpu cortex-a8
    .align 4

    .global _start

    .equ UART0_BASE, 0x101f1000   @ Base address of UART0 on VersatilePB
    .equ UARTFR,    0x18          @ Flag Register offset
    .equ UARTDR,    0x00          @ Data Register offset
    .equ UARTFR_TXFF, 0x20        @ Transmit FIFO Full flag

    .section .text

_start:
    ldr r0, =message        @ Load address of the message
    bl  uart_print_string   @ Call function to print the string

loop:
    b loop                  @ Loop indefinitely

@ Function to print a null-terminated string to UART
@ Input: r0 = address of the string
uart_print_string:
    push {r1, r2, lr}       @ Save registers
print_char:
    ldrb r1, [r0], #1       @ Load byte from string and increment pointer
    cmp r1, #0              @ Check for null terminator
    beq done                @ If null, we are done
wait_uart:
    ldr r2, =UART0_BASE
    ldr r3, [r2, #UARTFR]   @ Read UART Flag Register
    tst r3, #UARTFR_TXFF    @ Check if TX FIFO is full
    bne wait_uart           @ If full, wait
    str r1, [r2, #UARTDR]   @ Write character to Data Register
    b   print_char          @ Repeat for next character
done:
    pop {r1, r2, lr}        @ Restore registers
    bx  lr                  @ Return from function

    .section .data
message:
    .asciz "Hello, World!\n"
