/* 
 * "Small Hello World" example. 
 * 
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example 
 * designs. It requires a STDOUT  device in your system's hardware. 
 *
 * The purpose of this example is to demonstrate the smallest possible Hello 
 * World application, using the Nios II HAL library.  The memory footprint
 * of this hosted application is ~332 bytes by default using the standard 
 * reference design.  For a more fully featured Hello World application
 * example, see the example titled "Hello World".
 *
 * The memory footprint of this example has been reduced by making the
 * following changes to the normal "Hello World" example.
 * Check in the Nios II Software Developers Manual for a more complete 
 * description.
 * 
 * In the SW Application project (small_hello_world):
 *
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 * In System Library project (small_hello_world_syslib):
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 *    - Define the preprocessor option ALT_NO_INSTRUCTION_EMULATION 
 *      This removes software exception handling, which means that you cannot 
 *      run code compiled for Nios II cpu with a hardware multiplier on a core 
 *      without a the multiply unit. Check the Nios II Software Developers 
 *      Manual for more details.
 *
 *  - In the System Library page:
 *    - Set Periodic system timer and Timestamp timer to none
 *      This prevents the automatic inclusion of the timer driver.
 *
 *    - Set Max file descriptors to 4
 *      This reduces the size of the file handle pool.
 *
 *    - Check Main function does not exit
 *    - Uncheck Clean exit (flush buffers)
 *      This removes the unneeded call to exit when main returns, since it
 *      won't.
 *
 *    - Check Don't use C++
 *      This builds without the C++ support code.
 *
 *    - Check Small C library
 *      This uses a reduced functionality C library, which lacks  
 *      support for buffering, file IO, floating point and getch(), etc. 
 *      Check the Nios II Software Developers Manual for a complete list.
 *
 *    - Check Reduced device drivers
 *      This uses reduced functionality drivers if they're available. For the
 *      standard design this means you get polled UART and JTAG UART drivers,
 *      no support for the LCD driver and you lose the ability to program 
 *      CFI compliant flash devices.
 *
 *    - Check Access device drivers directly
 *      This bypasses the device file system to access device drivers directly.
 *      This eliminates the space required for the device file system services.
 *      It also provides a HAL version of libc services that access the drivers
 *      directly, further reducing space. Only a limited number of libc
 *      functions are available in this configuration.
 *
 *    - Use ALT versions of stdio routines:
 *
 *           Function                  Description
 *        ===============  =====================================
 *        alt_printf       Only supports %s, %x, and %c ( < 1 Kbyte)
 *        alt_putstr       Smaller overhead than puts with direct drivers
 *                         Note this function doesn't add a newline.
 *        alt_putchar      Smaller overhead than putchar with direct drivers
 *        alt_getchar      Smaller overhead than getchar with direct drivers
 *
 */
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <winsock2.h>
#include <ws2tcpip.h>
#include <stdlib.h>
#include <string.h>

#define PORT_USE 8080

/*
	C socket server example
*/


void write_seed(unsigned int seed){
	srand(seed);
}

unsigned int get_random(){
	unsigned int r = (unsigned int )rand();
	return r;
}

int main(int argc , char *argv[])
{
	int c , read_size;
	struct sockaddr_in address;
	int addrlen = sizeof(address);

	unsigned int client_message;
	unsigned int data_snd[1024];


	//Create socket
	int server_fd = socket(AF_INET, SOCK_STREAM, 0);
	if (server_fd == -1)
	{
		printf("Could not create socket");
        exit(EXIT_FAILURE);
	}
	puts("Socket created");

	// Forcefully attaching socket to the port 8080
	//Prepare the sockaddr_in structure
	address.sin_family = AF_INET;
	address.sin_addr.s_addr = inet_addr("127.0.0.1");
	address.sin_port = htons( PORT_USE );

    // Forcefully attaching socket to the port 8080
    if (bind(server_fd, (struct sockaddr *)&address,
                                 sizeof(address))<0)
    {
        perror("bind failed");
        exit(EXIT_FAILURE);
    }
	puts("bind done");

	//Listen
	int ret = listen(server_fd , 3);
	if(ret < 0){
		exit(EXIT_FAILURE);
	}

	int is_initialized = 0;
	while(1){
		//Accept and incoming connection
		puts("Waiting for incoming connections...");

		//accept connection from an incoming client
		struct sockaddr_in client;
		int client_sock = accept(server_fd, (struct sockaddr *)&client, (socklen_t*)&addrlen);
		if (client_sock < 0)
		{
			perror("accept failed");
			continue;
		}

		puts("Connection accepted");

		//Receive a message from client
		int read_size = read(client_sock , (void*)client_message, sizeof(client_message));

		if(read_size > 0){
			if(!is_initialized){
				unsigned int seed = client_message;
				write_seed(seed);
			}
			else{
				// Send the message back to client
				unsigned int n_numbers_generate = client_message;
				if(n_numbers_generate  <= 1024){
					int i;
					for(i = 0; i < n_numbers_generate; i++){
						data_snd[i] = get_random();
					}
					write(client_sock , data_snd, n_numbers_generate*sizeof(unsigned int));
				}
			}
		}
		else if(read_size == 0)
		{
			puts("Client disconnected");
			fflush(stdout);
		}
		else if(read_size == -1)
		{
			perror("recv failed");
		}
	}
	return 0;
}


