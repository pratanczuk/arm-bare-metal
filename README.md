  
  

**ARM Bare-Metal programming without a metal :)**

**QEMU supports many variants of the ARM architecture due to its diversity in terms of bitness, endianness, and Application Binary Interfaces (ABI). Here's an explanation of the different versions:**

1.  **Bitness (32-bit vs. 64-bit)**:
    
    -   **qemu-arm-static**: Emulates 32-bit ARM applications.
        
    -   **qemu-arm64-static**: Emulates 64-bit ARM applications (also known as AArch64 or ARMv8).
        
2.  **Endianness (byte order)**:
    
    -   **qemu-armeb-static**: Emulates 32-bit ARM applications in big-endian mode.
        
3.  **ABI (Application Binary Interface)**:
    
    -   **qemu-armel-static**: Emulates 32-bit ARM applications using the "armel" ABI (soft-float).
        
    -   **qemu-armhf-static**: Emulates 32-bit ARM applications using the "armhf" ABI (hard-float).
        
4.  **Emulation Mode**:
    
    -   **qemu-system-arm**: Emulates an entire system based on 32-bit ARM, including hardware and peripherals.
        
    -   **qemu-system-arm64**: Emulates an entire system based on 64-bit ARM.
        
    -   **qemu-system-armel** and **qemu-system-armhf**: Specialized system emulators for specific ABIs.
        

**Why so many versions?**

The ARM architecture is used in a wide range of devices with varying hardware and software configurations. Differences can include:

-   **Bitness**: Some devices run on 32-bit ARM, while others use 64-bit.
    
-   **Endianness**: While most systems use little-endian, some applications require big-endian.
    
-   **ABI**: Different distributions and operating systems for ARM may use different ABIs, affecting how floating-point operations and system calls are handled.
    

Having multiple versions of QEMU allows developers and users to precisely match the emulation to a specific target configuration, which is crucial for testing and debugging software on various ARM platforms.

**Corresponding GCC Compilers**

To ensure that your compiled applications run correctly under QEMU emulation, it's crucial to use a GCC compiler that targets the same architecture, endianness, and ABI as the QEMU version you're using. Below is a mapping of QEMU versions to the appropriate GCC cross-compilers:

1.  **qemu-arm-static**:
    
    -   **GCC Compiler**: `arm-linux-gnueabi-gcc`
        
    -   **Description**: Targets 32-bit ARM (little-endian) with the **"armel" ABI** (soft-float).
        
2.  **qemu-armel-static**:
    
    -   **GCC Compiler**: `arm-linux-gnueabi-gcc`
        
    -   **Description**: Same as above, suitable for the **"armel" ABI** (soft-float).
        
3.  **qemu-armhf-static**:
    
    -   **GCC Compiler**: `arm-linux-gnueabihf-gcc`
        
    -   **Description**: Targets 32-bit ARM (little-endian) with the **"armhf" ABI** (hard-float).
        
4.  **qemu-arm64-static**:
    
    -   **GCC Compiler**: `aarch64-linux-gnu-gcc`
        
    -   **Description**: For 64-bit ARM architectures (AArch64), little-endian.
        
5.  **qemu-armeb-static**:
    
    -   **GCC Compiler**: `armeb-linux-gnueabi-gcc`
        
    -   **Description**: Targets 32-bit ARM **big-endian** with the **"armel" ABI** (soft-float).
        
6.  **qemu-system-arm**:
    
    -   **GCC Compiler**:
        
        -   For **"armel" ABI**: `arm-linux-gnueabi-gcc`
            
        -   For **"armhf" ABI**: `arm-linux-gnueabihf-gcc`
            
    -   **Description**: Emulates an entire 32-bit ARM system; choose the compiler based on the ABI you intend to use.
        
7.  **qemu-system-arm64**:
    
    -   **GCC Compiler**: `aarch64-linux-gnu-gcc`
        
    -   **Description**: Emulates an entire 64-bit ARM system.
        
8.  **qemu-system-armel**:
    
    -   **GCC Compiler**: `arm-linux-gnueabi-gcc`
        
    -   **Description**: Specialized for the **"armel" ABI** (soft-float).
        
9.  **qemu-system-armhf**:
    
    -   **GCC Compiler**: `arm-linux-gnueabihf-gcc`
        
    -   **Description**: Specialized for the **"armhf" ABI** (hard-float).
        

**Notes:**

-   **Endianness**:
    
    -   **Little-endian**: Most common in ARM systems; data is stored with the least significant byte first.
        
    -   **Big-endian**: Use compilers with the `-eb` suffix, such as `armeb-linux-gnueabi-gcc`, for big-endian targets.
        
-   **ABI (Application Binary Interface)**:
    
    -   **"armel" (Soft-float)**:
        
        -   Uses software emulation for floating-point operations.
            
        -   Suitable for processors without a Floating Point Unit (FPU).
            
    -   **"armhf" (Hard-float)**:
        
        -   Utilizes hardware FPU for floating-point operations.
            
        -   Provides better performance on processors with an FPU.
            

**Installing GCC Cross-Compilers**

On Debian-based systems (like Ubuntu), you can install the necessary cross-compilers using the following commands:

-   For **"armel" ABI**:
    
    ```
    sudo apt-get install gcc-arm-linux-gnueabi
    ```
    
-   For **"armhf" ABI**:
    
    ```
    sudo apt-get install gcc-arm-linux-gnueabihf
    ```
    
-   For **AArch64 (64-bit ARM)**:
    
    ```
    sudo apt-get install gcc-aarch64-linux-gnu
    ```
    
-   For **Big-endian ARM**:
    
    ```
    sudo apt-get install gcc-armeb-linux-gnueabi
    ```
    

**Example Usage**

When compiling your code, specify the appropriate cross-compiler:

```
arm-linux-gnueabi-gcc -o myapp myapp.c   # For qemu-arm-static or qemu-armel-static
```

**Conclusion**

By aligning the GCC cross-compiler with the corresponding QEMU emulator version, you ensure that the binaries are correctly built for the target architecture and ABI. This alignment is essential for cross-platform development, testing, and debugging of applications intended to run on various ARM-based systems.

  
  

**Example: Writing, Compiling, and Running a "Hello, World" Assembly Program on ARM Platforms**

In this example, we'll write a simple "Hello, World" program in ARM assembly language, compile it using GCC cross-compilers, and run it using the appropriate QEMU emulator. We'll cover two scenarios:

1.  **32-bit ARM with "armel" ABI (soft-float)**
    
2.  **64-bit ARM (AArch64)**
    

### **Scenario 1: 32-bit ARM with "armel" ABI (soft-float)**

#### **Step 1: Write the Assembly Code**

Create a file named `hello_armel.s` with the following content:

```
    
```

#### **Step 2: Compile the Assembly Code**

Use the `arm-linux-gnueabi-gcc` compiler to assemble and link the program:

```
arm-linux-gnueabi-gcc -nostdlib -o hello_armel hello_armel.s
```

-   **Explanation**:
    
    -   `-nostdlib`: Do not use the standard library.
        
    -   `-o hello_armel`: Output the executable as `hello_armel`.
        

#### **Step 3: Run the Program Using QEMU**

Use `qemu-arm-static` to emulate and run the compiled binary:

```
qemu-arm-static ./hello_armel
```

-   **Output**:
    
    ```
    Hello, World!
    ```
    

### **Scenario 2: 64-bit ARM (AArch64)**

#### **Step 1: Write the Assembly Code**

Create a file named `hello_arm64.s` with the following content:

```
    
```

-   **Note**: In AArch64, loading addresses requires `adrp` and `add` instructions due to the 64-bit address space.
    

#### **Step 2: Compile the Assembly Code**

Use the `aarch64-linux-gnu-gcc` compiler:

```
aarch64-linux-gnu-gcc -nostdlib -o hello_arm64 hello_arm64.s
```

#### **Step 3: Run the Program Using QEMU**

Use `qemu-aarch64-static` to emulate and run the compiled binary:

```
qemu-aarch64-static ./hello_arm64
```

-   **Output**:
    
    ```
    Hello, World!
    ```
    

### **Detailed Explanation**

#### **Assembly Code Breakdown**

**32-bit ARM Assembly (**`hello_armel.s`**):**

-   **Registers**:
    
    -   `r0` to `r3`: Used for passing arguments to system calls.
        
    -   `r7`: Used to specify the system call number.
        
-   **System Calls**:
    
    -   `sys_write`: System call number `4`.
        
    -   `sys_exit`: System call number `1`.
        

**64-bit ARM Assembly (**`hello_arm64.s`**):**

-   **Registers**:
    
    -   `x0` to `x7`: Used for passing arguments to system calls.
        
    -   `x8`: Used to specify the system call number.
        
-   **System Calls**:
    
    -   `sys_write`: System call number `64`.
        
    -   `sys_exit`: System call number `93`.
        
-   **Addressing**:
    
    -   `adrp` and `add` are used together to load a 64-bit address.
        

#### **Compiling with GCC Cross-Compilers**

-   `-nostdlib`:
    
    -   Tells the compiler not to link against the standard library.
        
    -   Necessary because we're writing our own `_start` symbol and handling system calls directly.
        

#### **Running with QEMU Emulators**

-   **QEMU Static Binaries**:
    
    -   `qemu-arm-static`: For 32-bit ARM binaries.
        
    -   `qemu-aarch64-static`: For 64-bit ARM binaries.
        
-   **Usage**:
    
    -   Ensure that the QEMU static binaries are installed and accessible in your `PATH`.
        

### **Installing Required Tools**

For Debian-based systems (Ubuntu, Debian):

```
sudo apt-get update
```

-   **gcc-arm-linux-gnueabi**: GCC cross-compiler for 32-bit ARM (`armel` ABI).
    
-   **gcc-aarch64-linux-gnu**: GCC cross-compiler for 64-bit ARM.
    
-   **qemu-user-static**: QEMU user emulation binaries.
    

### **Additional Examples**

#### **32-bit ARM with "armhf" ABI (hard-float)**

If you prefer to use the "armhf" ABI:

**Modify Step 2:**

```
arm-linux-gnueabihf-gcc -nostdlib -o hello_armhf hello_armel.s
```

**Run with:**

```
qemu-arm-static ./hello_armhf
```

#### **Big-Endian ARM**

For big-endian targets:

**Modify Step 2:**

```
armeb-linux-gnueabi-gcc -nostdlib -o hello_armeb hello_armel.s
```

**Run with:**

```
qemu-armeb-static ./hello_armeb
```

Ensure that the big-endian cross-compiler and QEMU emulator are installed.

### **Understanding System Calls**

#### **32-bit ARM System Calls**

-   **Arguments**:
    
    -   `r0`: First argument.
        
    -   `r1`: Second argument.
        
    -   `r2`: Third argument.
        
-   **System Call Number**: Placed in `r7`.
    
-   **Making the Call**: `svc #0`.
    

#### **64-bit ARM System Calls**

-   **Arguments**:
    
    -   `x0`: First argument.
        
    -   `x1`: Second argument.
        
    -   `x2`: Third argument.
        
-   **System Call Number**: Placed in `x8`.
    
-   **Making the Call**: `svc #0`.
    

### **Conclusion**

By following these steps, you can:

-   Write a simple "Hello, World!" program in ARM assembly.
    
-   Compile it using the appropriate GCC cross-compiler.
    
-   Run it on the corresponding ARM architecture using QEMU.
    

This process is essential for learning low-level programming on ARM architectures and for cross-platform development.

**References**

-   **ARM Architecture Reference Manual**
    
-   **GNU Assembler (GAS) Documentation**
    
-   **QEMU User Documentation**
    
-   **System Call Numbers for ARM and AArch64**
    

  
  

  
  

**Example: Writing "Hello, World!" to the Serial Port on an Emulated ARM Platform Without Using System Calls**

In this example, we'll create an ARM assembly program that writes "Hello, World!" directly to a serial port by accessing the UART hardware registers, without using system calls (`svc`). We'll compile it using GCC cross-compilers and run it using QEMU, emulating the ARM VersatilePB platform.

### **Overview**

-   **Platform**: ARM VersatilePB (emulated by QEMU)
    
-   **UART**: PL011 UART (Memory-mapped I/O)
    
-   **Compiler**: `arm-none-eabi-gcc` or `arm-linux-gnueabi-gcc`
    
-   **Emulator**: QEMU (`qemu-system-arm`)
    

### **Step 1: Write the Assembly Code**

Create a file named `hello_serial.s` with the following content:

```
    
```

#### **Explanation:**

-   **UART Registers:**
    
    -   **UART0_BASE**: Base address of UART0 on the VersatilePB platform (`0x101f1000`).
        
    -   **UARTFR**: Offset for the Flag Register (`0x18`).
        
    -   **UARTDR**: Offset for the Data Register (`0x00`).
        
    -   **UARTFR_TXFF**: Transmit FIFO Full flag (`0x20`).
        
-   **Program Flow:**
    
    -   **_start**: Entry point of the program.
        
    -   **uart_print_string**: Function to print a null-terminated string to the UART.
        
    -   **wait_uart**: Loop that waits if the UART transmit FIFO is full.
        
    -   **message**: The string "Hello, World!\n" to be printed.
        

### **Step 2: Compile the Assembly Code**

Use the `arm-none-eabi-gcc` or `arm-linux-gnueabi-gcc` compiler to assemble and link the program:

```
arm-none-eabi-gcc -nostdlib -nostartfiles -Ttext=0x10000 -o hello_serial.elf hello_serial.s
```

#### **Explanation:**

-   **Compiler Options:**
    
    -   `-nostdlib`: Do not link against the standard library.
        
    -   `-nostartfiles`: Do not use standard startup files.
        
    -   `-Ttext=0x10000`: Set the program's starting address to `0x10000`.
        
    -   `-o hello_serial.elf`: Output the executable as `hello_serial.elf`.
        

**Note:** If `arm-none-eabi-gcc` is not available, you can use `arm-linux-gnueabi-gcc`, but you may need to adjust compiler options.

### **Step 3: Run the Program Using QEMU**

Use `qemu-system-arm` to emulate the ARM VersatilePB platform and run the compiled binary:

```
qemu-system-arm -M versatilepb -m 128M -nographic -kernel hello_serial.elf
```

#### **Explanation:**

-   **QEMU Options:**
    
    -   `-M versatilepb`: Emulate the ARM VersatilePB machine.
        
    -   `-m 128M`: Set the memory size to 128 MB.
        
    -   `-nographic`: Disable graphical output; use console instead.
        
    -   `-kernel hello_serial.elf`: Load `hello_serial.elf` as the kernel image.
        

#### **Expected Output:**

```
Hello, World!
```

### **Detailed Explanation**

#### **Understanding the UART on VersatilePB**

-   **UART Base Address:** `0x101f1000`
    
-   **Registers:**
    
    -   **UARTDR (Data Register):** Used to read/write data.
        
    -   **UARTFR (Flag Register):** Provides status flags.
        
        -   **Transmit FIFO Full (TXFF):** Bit 5 (0x20). When set, the transmit FIFO is full, and no more data can be written until space is available.
            

#### **Assembly Code Breakdown**

-   **Entry Point (**`_start`**):**
    
    -   Loads the address of the `message` into `r0`.
        
    -   Calls `uart_print_string` to print the string.
        
    -   Enters an infinite loop (`loop:`) to prevent the program from exiting.
        
-   **Printing Function (**`uart_print_string`**):**
    
    -   **Loop Structure:**
        
        -   **Load Byte:** Loads one character from the string into `r1` and increments the pointer `r0`.
            
        -   **Null Check:** Compares `r1` with `0` to detect the end of the string.
            
        -   **Wait for UART:** Checks if the UART's transmit FIFO is full and waits if necessary.
            
        -   **Send Character:** Writes the character to the UART Data Register.
            

#### **Compiling Without Standard Libraries**

-   `-nostdlib` **and** `-nostartfiles`**:**
    
    -   We are writing a bare-metal program without an operating system.
        
    -   These options prevent the inclusion of standard startup code and libraries, which are unnecessary and may cause issues in this context.
        
-   **Setting the Entry Point:**
    
    -   `-Ttext=0x10000`**:** Places the program at memory address `0x10000`, which is a common load address for bare-metal programs on the VersatilePB platform.
        

#### **Running with QEMU**

-   `-nographic`**:**
    
    -   Redirects the serial output to the console.
        
    -   Useful for seeing the UART output directly in your terminal.
        
-   `-M versatilepb`**:**
    
    -   Emulates the VersatilePB machine, which includes the PL011 UART we're using.
        

### **Installing Required Tools**

#### **GCC Cross-Compiler**

On Debian-based systems:

```
sudo apt-get update
```

-   `gcc-arm-none-eabi`**:** GCC cross-compiler for ARM bare-metal development.
    
-   `qemu-system-arm`**:** QEMU emulator for ARM systems.
    

**Note:** If `gcc-arm-none-eabi` is not available, you can use `gcc-arm-linux-gnueabi`, but ensure you adjust the code and options accordingly.

### **Additional Information**

#### **Adjusting for Different Platforms**

-   **Different UART Addresses:**
    
    -   If you choose a different emulated machine, ensure you update the `UART0_BASE` to the correct address for that platform.
        
-   **Alternative Machines:**
    
    -   You can use other machines supported by QEMU, such as `realview-pb-a8` or `stellaris`.
        

#### **Using a Linker Script**

For more control over the memory layout, you can use a linker script.

**Create a file named** `linker.ld`**:**

```
SECTIONS
```

**Compile with the linker script:**

```
arm-none-eabi-gcc -nostdlib -nostartfiles -T linker.ld -o hello_serial.elf hello_serial.s
```

### **Alternative: Using C Code**

If you prefer to write in C instead of assembly, you can write directly to the UART registers in C.

**Create a file named** `hello_serial.c`**:**

```
volatile unsigned int * const UART0DR = (unsigned int *)0x101f1000;
```

**Compile the C code:**

```
arm-none-eabi-gcc -nostdlib -nostartfiles -Ttext=0x10000 -o hello_serial_c.elf hello_serial.c
```

**Run with QEMU:**

```
qemu-system-arm -M versatilepb -m 128M -nographic -kernel hello_serial_c.elf
```

### **Conclusion**

By directly accessing the UART hardware registers, we can output text to the serial port without relying on operating system services or system calls (`svc`). This approach is commonly used in bare-metal programming and embedded systems development.

**Key Takeaways:**

-   **Direct Hardware Access:** Writing to memory-mapped I/O addresses allows communication with hardware peripherals.
    
-   **Bare-Metal Programming:** Running code without an operating system requires careful setup of the environment and hardware initialization.
    
-   **QEMU Emulation:** QEMU provides a versatile platform for emulating ARM systems and testing low-level code.