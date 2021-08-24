/*
	Bind socket to port 8888 on localhost
*/

#include<stdio.h>
#include<winsock2.h>
#include <stdlib.h>

#pragma comment(lib,"ws2_32.lib") //Winsock Library

#define PORT_USE 8008

void write_seed(unsigned int seed){
	srand(seed);
}

unsigned int get_random(){
	unsigned int r = (unsigned int )rand();
	return r;
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