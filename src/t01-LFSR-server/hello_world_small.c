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
//#include <sys/socket.h>
#include <stdlib.h>
#include<winsock2.h>
// #include <netinet/in.h>
#include <string.h>

#include <system.h>
#include "io.h"

// #define LFSR_0_BASE 0x0 from system.h
#define ADDR_WR_SEED 0
#define ADDR_WR_ENABLE_GEN 1
#define ADDR_RD_RANDOM_NUMBER 2

#pragma comment(lib,"ws2_32.lib") //Winsock Library

#define PORT_USE 8008


void write_seed(unsigned int seed){
	int enable_gen = 0xFFFFFFFF;
	IOWR(LFSR_0_BASE, ADDR_WR_SEED, seed);
	IOWR(LFSR_0_BASE, ADDR_WR_ENABLE_GEN, enable_gen);
}

unsigned int get_random(){
	IORD(LFSR_0_BASE, ADDR_RD_RANDOM_NUMBER);
	unsigned int* rand_pointer = (unsigned int*)(LFSR_0_BASE+ADDR_RD_RANDOM_NUMBER);
	return *rand_pointer;
}

int main(int argc , char *argv[])
{
	WSADATA wsa;
	SOCKET s , client_socket;
	struct sockaddr_in server , client;
	unsigned int recv_uint;
	unsigned int send_buff[1024];
	int c;

	printf("\nInitialising Winsock...");
	if (WSAStartup(MAKEWORD(2,2),&wsa) != 0)
	{
		printf("Failed. Error Code : %d",WSAGetLastError());
		return 1;
	}

	printf("Initialised.\n");

	//Create a socket
	if((s = socket(AF_INET , SOCK_STREAM , 0 )) == INVALID_SOCKET)
	{
		printf("Could not create socket : %d" , WSAGetLastError());
	}

	printf("Socket created.\n");

	//Prepare the sockaddr_in structure
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = inet_addr("127.0.0.1");
	server.sin_port = htons( PORT_USE );

	//Bind
	if( bind(s ,(struct sockaddr *)&server , sizeof(server)) == SOCKET_ERROR)
	{
		printf("Bind failed with error code : %d" , WSAGetLastError());
	}

	puts("Bind done");


	//Listen to incoming connections
	listen(s , 3);
	int is_init = 0;
	while(1){
		//Accept and incoming connection
		puts("Waiting for incoming connections...");

		c = sizeof(struct sockaddr_in);
		client_socket = accept(s , (struct sockaddr *)&client, &c);
		if (client_socket == INVALID_SOCKET)
		{
			printf("accept failed with error code : %d" , WSAGetLastError());
			continue;
			// closesocket(s);
			// WSACleanup();
			// return 1;
		}

		puts("Connection accepted");
		int iResult;
		do{
			iResult = recv(client_socket, (char*)&recv_uint, sizeof(recv_uint), 0);
			if (iResult > 0) {
				printf("Bytes received: %d\n", iResult);
				printf("recv uint %d\n", recv_uint);
				if(recv_uint > 1024){
					printf("recv error %d\n", recv_uint);
					continue;
				}

				if(!is_init){
					write_seed(recv_uint);
					is_init = 1;
				}else{
					unsigned int i;
					for(i = 0; i < recv_uint; i++){
						send_buff[i] = get_random();
					}
					int iSendResult = send(client_socket, (char*)send_buff, sizeof(unsigned int)*recv_uint, 0);
					printf("sended %d bytes\n", recv_uint*sizeof(unsigned int));
					if(iSendResult == SOCKET_ERROR){
						printf("send failed with error: %d\n", WSAGetLastError());
						closesocket(client_socket);
						WSACleanup();
						return 1;
					}
					closesocket(client_socket);
					break;
				}
			}else if(iResult == 0){
				printf("Connection closing...\n");
			}else{
				printf("recv failed with error: %d\n", WSAGetLastError());
				closesocket(client_socket);
				WSACleanup();
				return 1;
			}
		} while( iResult > 0);
		closesocket(client_socket);
	}

	// No longer need server
	closesocket(s);
	WSACleanup();
	return 0;
}
