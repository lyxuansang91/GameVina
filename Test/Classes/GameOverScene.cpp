#include "GameOverScene.h"

#include "protobufObject/login.pb.h"
#include <iostream>
#include "DefaultSocket.h"

#pragma comment(lib, "libprotobuf.lib")

#include <google/protobuf/message.h>
#include <google/protobuf/descriptor.h>
#include <google/protobuf/io/zero_copy_stream_impl.h>
#include <google/protobuf/io/coded_stream.h>
#include <google/protobuf/io/zero_copy_stream_impl_lite.h>



USING_NS_CC;
using namespace net::jarlehansen::protobuf::javame;
using namespace std;


Scene* GameOverScene::createScene()
{
	// 'scene' is an autorelease object
	auto scene = Scene::create();

	// 'layer' is an autorelease object
	auto layer = GameOverScene::create();

	// add layer as a child to scene
	scene->addChild(layer);

	// return the scene
	return scene;
}

void testProtoLogin() {
	BINLoginRequest* loginRequest = new BINLoginRequest();
	loginRequest->set_username("SANGLX");
	loginRequest->set_password("12345");
	loginRequest->set_cp("1");
	loginRequest->set_appversion("1");
	loginRequest->set_clienttype(1);
	
	CCLOG("byte size: %d" , loginRequest->ByteSize());
	int size = loginRequest->ByteSize() + 4;
	char* ackBuf = new char[size];
	// ArrayOutputStream os(ackBuf, size);
	google::protobuf::io::ArrayOutputStream arrayOut(ackBuf,size);
	google::protobuf::io::CodedOutputStream codedOut(&arrayOut);
	//codedOut.WriteVarint32(loginRequest->ByteSize());
	loginRequest->SerializeToCodedStream(&codedOut);

	DefaultSocket *defaultSocket = new DefaultSocket();
	bool isConnected = defaultSocket->connectSocket("192.168.1.50", 1240);
	CCLOG("already connected: %s", isConnected ? "true" : "false");
	// CCLOG("Send data: %s", loginRequest->SerializeAsString());
	defaultSocket->sendData(ackBuf, size);
	vector<char> bufferRead(500);
	defaultSocket->readData(bufferRead, 500);
	defaultSocket->closeSocket();
	delete(ackBuf);
}

// on "init" you need to initialize your instance
bool GameOverScene::init()
{
	//////////////////////////////
	// 1. super init first
	if (!Layer::init())
	{
		return false;
	}

	Size visibleSize = Director::getInstance()->getVisibleSize();
	Vec2 origin = Director::getInstance()->getVisibleOrigin();

	testProtoLogin();
	return true;
}