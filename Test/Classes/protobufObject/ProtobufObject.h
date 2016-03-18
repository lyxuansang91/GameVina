//
//  ProtobufObject.h
//  ProtobufferWithCocoaPods
//
//  Created by Bui Duy Thuoc on 12/16/14.
//  Copyright (c) 2014 Viettel. All rights reserved.
//

#include <iostream>
#include <map>

using namespace std;

//public class ProtobufObject {
//	void setBinAppInfoFromDict(map<vector<char>, vector<char>>  respDict);
//	char* BINloadMetadataRequest(vector<char> ipAddress);
//	char* BINLocationRequest(int idListenerClient, vector<char> phoneNumber);
//	char* BINMdmInfoRequest(int idListenerClient, int requestType);
//	char* BINPhoneNumberRequest(int idListenerClient, vector<char> ipAdress);
//	char* BINChargingGatewayRequest(int idListener, vector<char> phoneNumber);
//	char* 
//};

@interface ProtobufObject : NSObject

+ (void) setBinAppInfoFromDict:(NSDictionary*) respDict;

//+ (NSData*) smsgwCodeRequest:(BINAppInfo*)binAppInfo idListenerClient:(int)idListenerClient;


//----------------- - ---------------------- --------------- - - - - - - - -- -- - - - -- - - -- -

+ (NSData*)BINLoadMetadataRequest:(NSString *) ipAddress;

+ (NSData*)BINLocationRequest:(int)idListenerClient phoneNumer:(NSString *) phoneNumber;

+ (NSData*)BINMdmInfoRequest:(int)idListenerClient requestType:(int)requestType param:(NSString *)params;

+ (NSData*)BINPhoneNumberRequest:(int)idListenerClient ipAdress:(NSString *)ipAddress;

+ (NSData*)BINChargingGatewayRequest:(int) idListener phoneNumber:(NSString *)phoneNumber;

+ (NSData*)BINChargingGatewayRequest:(int)idListenerClient msisdn:(NSString *)msisdn chargeAmount:(NSString *)chargAmount;

//
//- ----- -- ----  ---- ------ ---- -------- ---- - --- --- -- ---- - - - -- - - - - - -- - - -
+ (NSData*)JsonReturnFromData:(NSData *)data messageID:(NSInteger)messageID;

//+ (NSDictionary *)getBinChargingGamewayResponse:(NSData *)data;
+ (NSData*)JsonFrom:(NSInteger)messageId;

//+ (NSDictionary *)getBinLoadMetaDataResonse:(NSData *)data ;
+ (NSData*)JsonFromBINLoadMetaDataResponse:(NSInteger)messageId;

//+ (NSDictionary *)getBinLocationResponse:(NSData *)data;
+ (NSData*)JsonFromBINLocationResponse:(NSInteger)messageId;
@end
