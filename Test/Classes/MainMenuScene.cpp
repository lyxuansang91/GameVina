#include "MainMenuScene.h"
#include "DefaultSocket.h"
#include <vector>
#include <iostream>

USING_NS_CC;
using namespace std;

Scene* MainMenuScene::createScene()
{
	// 'scene' is an autorelease object
	auto scene = Scene::create();

	// 'layer' is an autorelease object
	auto layer = MainMenuScene::create();

	// add layer as a child to scene
	scene->addChild(layer);

	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
bool MainMenuScene::init()
{
	//////////////////////////////
	// 1. super init first
	if (!Layer::init())
	{
		return false;
	}

	Size visibleSize = Director::getInstance()->getVisibleSize();
	Vec2 origin = Director::getInstance()->getVisibleOrigin();

	DefaultSocket *defaultSocket;
	defaultSocket = new DefaultSocket();
	bool isConnected = defaultSocket->connectSocket("192.168.1.50", 1240);
	CCLOG("already connected: %s", isConnected ? "true": "false");
	char* data = "123";
	defaultSocket->sendData(data, 3);
	vector<char> buffer(500);
	// defaultSocket->readData(buffer, );
	defaultSocket->readData(buffer, 500);
	// CCLOG("read data: %c", buffer[0]);
	defaultSocket->closeSocket();
	
	return true;
}