//
//  ProtobufObject.m
//  ProtobufferWithCocoaPods
//
//  Created by Bui Duy Thuoc on 12/16/14.
//  Copyright (c) 2014 Viettel. All rights reserved.
//

#import "ProtobufObject.h"
#import "ViettelCommon.h"
#include "ViettelProto.pb.h"

@interface ProtobufObject()

    + (NSData *)getDataForZombie:(std::string)zombie ;

@end


static ViettelProto::BINAppInfo *binAppInfo = nil;

@implementation ProtobufObject : NSObject

+ (void) setBinAppInfoFromDict:(NSDictionary*) respDict{
    if(binAppInfo == nil){
        NSString *publisherId = [respDict objectForKey:PARAM_PUBLISHER_ID];
        NSString *appId = [respDict objectForKey:PARAM_APP_ID];
        NSString *packageName = [respDict objectForKey:PARAM_PACKAGE_NAME];
        NSString *appName = [respDict objectForKey:PARAM_APP_NAME];
        NSString *appKey = [respDict objectForKey:PARAM_APP_KEY];
        BOOL isTestDevice = [[respDict objectForKey:PARAM_TEST_DEVICE] boolValue];
        
        binAppInfo = new ViettelProto::BINAppInfo();
        binAppInfo->set_publisherid([publisherId UTF8String]);
        binAppInfo->set_appid([appId UTF8String]);
        binAppInfo->set_packagename([packageName UTF8String]);
        binAppInfo->set_appname([appName UTF8String]);
        binAppInfo->set_appkey([appKey UTF8String]);
        binAppInfo->set_testdevice(isTestDevice);
    }
}

+ (NSData *)getDataForZombie:(std::string)zombie {
    std::string ps = zombie;
    return [NSData dataWithBytes:ps.c_str() length:ps.size()];
}

//+ (NSData*) smsgwCodeRequest:(BINAppInfo*)binAppInfo idListenerClient:(int)idListenerClient
//{
//    return [self BINChargingGatewayRequest:binAppInfo idListener:idListenerClient];
//}


/**
 *          GET BYTE DATA
 */
+ (NSData*)BINLoadMetadataRequest:(NSString *)ipAddress{
    ViettelProto::BINLoadMetaDataRequest* binLoadMetaDataRequest = new ViettelProto::BINLoadMetaDataRequest();
    binLoadMetaDataRequest->set_allocated_appinfo(binAppInfo);
    binLoadMetaDataRequest->set_ipaddress([ipAddress UTF8String]);
    
    std::string x = binLoadMetaDataRequest->DebugString();
    NSString* output = [NSString stringWithCString:x.c_str() encoding:NSUTF8StringEncoding];
    NSLog(@"BinLoadMetaDataRequest %@", output);
    
    return [self getDataForZombie:binLoadMetaDataRequest->SerializeAsString()];
}

+ (NSData*)BINPhoneNumberRequest:(int)idListenerClient ipAdress:(NSString *)ipAddress{
    ViettelProto::BINPhoneNumberRequest* binPhonenumberRequest = new ViettelProto::BINPhoneNumberRequest();
    binPhonenumberRequest->set_allocated_appinfo(binAppInfo);
    binPhonenumberRequest->set_idlistener(idListenerClient);
    binPhonenumberRequest->set_ipaddress([ipAddress UTF8String]);
    
    std::string x = binPhonenumberRequest->DebugString();
    NSString* output = [NSString stringWithCString:x.c_str() encoding:NSUTF8StringEncoding];
    NSLog(@"BinPhonenumberRequest %@", output);
    
    return [self getDataForZombie:binPhonenumberRequest->SerializeAsString()];
}

+ (NSData*)BINLocationRequest:(int)idListenerClient phoneNumer:(NSString *) phoneNumber
{
    ViettelProto::BINLocationRequest * binLocationRequest = new ViettelProto::BINLocationRequest();
    binLocationRequest->set_allocated_appinfo(binAppInfo);
    binLocationRequest->set_idlistener(idListenerClient);
    binLocationRequest->set_phonenumber([phoneNumber UTF8String]);
    
    std::string x = binLocationRequest->DebugString();
    NSString* output = [NSString stringWithCString:x.c_str() encoding:NSUTF8StringEncoding];
    NSLog(@"BinLocationRequest: %@", output);
    
    return [self getDataForZombie:binLocationRequest->SerializeAsString()];
}

+ (NSData*)BINMdmInfoRequest:(int)idListenerClient requestType:(int)requestType param:(NSString *)params
{
    ViettelProto::BINMdmInfoRequest* binMdmInfoRequest = new ViettelProto::BINMdmInfoRequest();
    binMdmInfoRequest->set_allocated_appinfo(binAppInfo);
    binMdmInfoRequest->set_idlistener(idListenerClient);
    binMdmInfoRequest->set_requesttype(requestType);
    binMdmInfoRequest->set_parameter([params UTF8String]);
    
    return [self getDataForZombie:binMdmInfoRequest->SerializeAsString()];
}

+ (NSData*)BINTestLoadMetaData {
    ViettelProto::BINLoadMetaDataRequest* loadMetadata = new ViettelProto::BINLoadMetaDataRequest();
    loadMetadata->set_ipaddress("192.168.8.118");
    return [self getDataForZombie:loadMetadata->SerializeAsString()];
}

//------------------------------------CHARGING
+ (NSData*)BINChargingGatewayRequest:(int) idListener phoneNumber:(NSString *)phoneNumber
{
    ViettelProto::BINChargingGatewayRequest * binChargingGatewayRequest = new ViettelProto::BINChargingGatewayRequest();
    binChargingGatewayRequest->set_allocated_appinfo(binAppInfo);
    binChargingGatewayRequest->set_idlistener(idListener);
    binChargingGatewayRequest->set_smsgwcode(true);
    binChargingGatewayRequest->set_phonenumber([phoneNumber UTF8String]);
    
    std::string x = binChargingGatewayRequest->DebugString();
    NSString* output = [NSString stringWithCString:x.c_str() encoding:NSUTF8StringEncoding];
    NSLog(@"BINChargingGatewayRequest: %@", output);
    
    return [self getDataForZombie:binChargingGatewayRequest->SerializeAsString()];
}

+ (NSData*)BINChargingGatewayRequest:(int)idListenerClient msisdn:(NSString *)msisdn chargeAmount:(NSString *)chargAmount
{
    ViettelProto::BINChargingGatewayRequest * binChargingGatewayRequest = new ViettelProto::BINChargingGatewayRequest;
    binChargingGatewayRequest->set_allocated_appinfo(binAppInfo);
    binChargingGatewayRequest->set_idlistener(idListenerClient);
    binChargingGatewayRequest->set_phonenumber([msisdn UTF8String]);
    binChargingGatewayRequest->set_chargamount([chargAmount UTF8String]);
    
    std::string x = binChargingGatewayRequest->DebugString();
    NSString* output = [NSString stringWithCString:x.c_str() encoding:NSUTF8StringEncoding];
    NSLog(@"BINChargingGatewayRequest: %@", output);
    
    return [self getDataForZombie:binChargingGatewayRequest->SerializeAsString()];
}

//- --- -------- ---- --- --- -- -- -- -- -- -- -- -- - - - - - - ----------------------
+ (NSData*)JsonReturnFromData:(NSData *)data messageID:(NSInteger)messageID {
    switch (messageID) {
        case MESSAGE_ID_CHARGING_GATEWAY:
        {
            ViettelProto::BINChargingGatewayResponse *binChargingGamewayResponse = [self getBinChargingGamewayResponse: data];
            return [self JsonFrom:binChargingGamewayResponse messageId:messageID];
        }
            break;
        case MESSAGE_ID_LOADMETADATA:
        {
            ViettelProto::BINLoadMetaDataResponse *binLoadMetadataResponse =[self getBinLoadMetaDataResonse:data];
            return [self JsonFromBINLoadMetaDataResponse:binLoadMetadataResponse messageId:messageID];
        }
            break;
        case MESSAGE_ID_LOCATION:
        {
            ViettelProto::BINLocationResponse * binLocationResponse = [self getBinLocationResponse:data];
            return [self JsonFromBINLocationResponse:binLocationResponse messageId:messageID];
        }
            break;
        case MESSAGE_ID_MDM_INFO:
        {
            
        }
            break;
        case MESSAGE_ID_PHONE_NUMBER:
        {
            
        }
            break;
        case MESSAGE_ID_SERVER_DATA:
        {
            
        }
            break;
        default:
            return nil;
            break;
    }
    return nil;//Tam thoi
}

///////////////////////////////////////////////////////
+ (ViettelProto::BINChargingGatewayResponse *)getBinChargingGamewayResponse:(NSData *)data {
    int len = [data length];
    char raw[len];
    ViettelProto::BINChargingGatewayResponse *BinChargingResponse = new ViettelProto::BINChargingGatewayResponse;
    [data getBytes:raw length:len];
    BinChargingResponse->ParseFromArray(raw, len);
    
    return BinChargingResponse;
}

+ (NSData*)JsonFrom:(ViettelProto::BINChargingGatewayResponse *)binChargingResponse messageId:(NSInteger)messageId{
    std::string x = binChargingResponse->DebugString();
    NSString *output = [NSString stringWithCString:x.c_str() encoding:NSUTF8StringEncoding];
    NSLog(@"Charging Gateway Response: %@", output);
    //TODO
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    int idListener  =     binChargingResponse->idlistener();
    BOOL result     =     (BOOL)binChargingResponse->result();
    
    NSString* message = [NSString stringWithCString:binChargingResponse->message().c_str()
                                           encoding:NSUTF8StringEncoding];
    
    NSString* smsgMessage = [NSString stringWithCString:binChargingResponse->smsgwmessage().c_str()
                                               encoding:NSUTF8StringEncoding];
    
    [dict setObject:[NSNumber numberWithInteger:messageId] forKey:PARAM_MESSAGE_ID];
    [dict setObject:[NSNumber numberWithInt:idListener] forKey:PARAM_ID_LISTENNER];
    [dict setObject:[NSNumber numberWithBool:result] forKey:PARAM_RESULT];
    [dict setObject:message forKey:PARAM_MESSAGE];
    [dict setObject:smsgMessage forKey:PARAM_SMSG_MESSAGE];
    
    NSError* error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    binChargingResponse->release_message();
    binChargingResponse->release_smsgwmessage();
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
        return nil;
    } else {
        return  jsonData;
    }
}
///////////////////////////////////////////////////////
+ (ViettelProto::BINLoadMetaDataResponse *)getBinLoadMetaDataResonse:(NSData *)data {
    int len = [data length];
    char raw[len];
    ViettelProto::BINLoadMetaDataResponse *binLoadMetadataResponse = new ViettelProto::BINLoadMetaDataResponse();
    [data getBytes:raw length:len];
    binLoadMetadataResponse->ParseFromArray(raw, len);
    
    return binLoadMetadataResponse;
}

+ (NSData*)JsonFromBINLoadMetaDataResponse:(ViettelProto::BINLoadMetaDataResponse *)binLoadMetaDataResponse messageId:(NSInteger)messageId
{
    std::string x = binLoadMetaDataResponse->DebugString();
    NSString *output = [NSString stringWithCString:x.c_str() encoding:NSUTF8StringEncoding];
    NSLog(@"Bin LoadMetadata Response: %@", output);

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    BOOL apiAvaiable = (BOOL)binLoadMetaDataResponse->apiavaiable();
    BOOL accountAvaiable = (BOOL)binLoadMetaDataResponse->accountavaiable();
    NSString* seasionId = [NSString stringWithCString:binLoadMetaDataResponse->seasionid().c_str() encoding:NSUTF8StringEncoding];
    NSString* msisdn = [NSString stringWithCString:binLoadMetaDataResponse->phonenumber().c_str() encoding:NSUTF8StringEncoding];
    
    int seasionTimeOut = binLoadMetaDataResponse->seasiontimeout();
    
    [dict setObject:[NSNumber numberWithInteger:messageId] forKey:PARAM_MESSAGE_ID];
    [dict setObject:[NSNumber numberWithBool:apiAvaiable] forKey:PARAM_API_AVAIABLE];
    [dict setObject:[NSNumber numberWithBool:accountAvaiable] forKey:PARAM_ACC_AVAIABLE];
    [dict setObject:seasionId forKey:PARAM_SEASION_ID];
    [dict setObject:[NSNumber numberWithInt:seasionTimeOut] forKey:PARAM_SEASION_TIMEOUT];
    [dict setObject:msisdn forKey:PARAM_MSISDN];
    
    NSError* error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if(!jsonData)
    {
        NSLog(@"Got Error : %@", error);
        return nil;
    }
    else
    {
        return jsonData;
    }
}
///////////////////////////////////////////////////////
+ (ViettelProto::BINLocationResponse *)getBinLocationResponse:(NSData *)data {
    int len = [data length];
    char raw[len];
    ViettelProto::BINLocationResponse *binLocationResponse = new ViettelProto::BINLocationResponse();
    [data getBytes:raw length:len];
    binLocationResponse->ParseFromArray(raw, len);
    
    return binLocationResponse;
}

+ (NSData*)JsonFromBINLocationResponse:(ViettelProto::BINLocationResponse *)binLocationResponse messageId:(NSInteger)messageId
{
    std::string x = binLocationResponse->DebugString();
    NSString *output = [NSString stringWithCString:x.c_str() encoding:NSUTF8StringEncoding];
    NSLog(@"BinLocation Response: %@", output);
    
    //Read From BINLocationResponse
    NSString* message       = [NSString stringWithCString:binLocationResponse->message().c_str() encoding:NSUTF8StringEncoding];
    NSString* latitute      = [NSString stringWithCString:binLocationResponse->latitude().c_str() encoding:NSUTF8StringEncoding];
    NSString* longitute     = [NSString stringWithCString:binLocationResponse->longtitude().c_str() encoding:NSUTF8StringEncoding];
    int idListener          = binLocationResponse->idlistener();
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:message forKey:PARAM_MESSAGE];
    [dict setObject:[NSNumber numberWithInt:idListener] forKey:PARAM_ID_LISTENNER];
    [dict setObject:latitute forKey:PARAM_LOCATION_LATITUDE];
    [dict setObject:longitute forKey:PARAM_LOCATION_LONGTITUDE];
    
    
    NSError* error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if(!jsonData)
    {
        NSLog(@"Got Error : %@", error);
        return nil;
    }
    else
    {
        return jsonData;
    }
}


@end
