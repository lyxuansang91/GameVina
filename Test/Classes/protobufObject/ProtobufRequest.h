//
//  ProtobufRequest.h
//  ProtobufferWithCocoaPods
//
//  Created by Bui Duy Thuoc on 12/18/14.
//  Copyright (c) 2014 Viettel. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "ViettelProto.pb.h"

@interface ProtobufRequest : NSObject

+ (NSData*) smsgwCodeRequest:(BINAppInfo*)binAppInfo idListenerClient:(int)idListenerClient;

@end
