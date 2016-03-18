#include "GameOverScene.h"

#include "protobufObject/login.pb.h"
#include <iostream>
#include "DefaultSocket.h"

#include <google/config.h>
#include <google/protobuf/message_lite.h>
#include <google/protobuf/descriptor.h>
#include <google/protobuf/io/zero_copy_stream_impl.h>
#include <google/protobuf/io/coded_stream.h>
#include <google/protobuf/io/zero_copy_stream_impl_lite.h>



USING_NS_CC;
using namespace net::jarlehansen::protobuf::javame;
using namespace google::protobuf::io;
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
	// loginRequest->ByteSize();
	int size = loginRequest->ByteSize() + 4;
	char* ackBuf = new char[size];
	// ArrayOutputStream os(ackBuf, size);
	ArrayOutputStream arrayOut(ackBuf, size);
	CodedOutputStream codedOut(&arrayOut);
	codedOut.WriteVarint32(loginRequest->ByteSize());
	// loginRequest->SerializeToCodedStream(&codedOut);

	DefaultSocket *defaultSocket = new DefaultSocket();
	bool isConnected = defaultSocket->connectSocket("192.168.1.50", 1240);
	CCLOG("already connected: %s", isConnected ? "true" : "false");
	defaultSocket->sendData(ackBuf, size);
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