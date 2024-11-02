volatile unsigned int * const UART0DR = (unsigned int *)0x101f1000;

void uart_putc(char c) {
    while (*(volatile unsigned int *)(0x101f1000 + 0x18) & 0x20); // Wait if TX FIFO is full
    *UART0DR = c;
}

void uart_print(const char *s) {
    while (*s != '\0') {
        uart_putc(*s++);
    }
}

void _start(void) {
    uart_print("Hello, World!\n");
    uart_print("'Press CTRL + a, x' to exit from qemu !\n");
    while (1); // Loop indefinitely
}