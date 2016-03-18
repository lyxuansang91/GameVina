#ifndef DEFAULT_SOCKET_H_
#define DEFAULT_SOCKET_H_
#include "CommonSocket.h"


#if WIN32
	#pragma comment(lib, "Ws2_32.lib")
	//#include <winsock.h>
#else
	#include <sys/types.h>
	#include <sys/socket.h>
	#include <netinet/in.h>
	#include <arpa/inet.h>
	#include <netdb.h> 
#endif
class DefaultSocket:
	public CommonSocket
{
public:
	DefaultSocket();
	~DefaultSocket();
#if WIN32
	static bool initWinSock2_0();
	#endif
public:
	int peerSocket;
	int optval;
	int optlen;
	bool connectSocket(const char* serverIP, int serverPort);
	void closeSocket();
	int sendData(const char* data, int len);
//	int	readData(char* buffer,int len);
	int	readData(vector <char> &vectorBuffer,int len);
private:
	int hClientSocket;
};
#endif // !1
