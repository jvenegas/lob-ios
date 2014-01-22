//
//  LobVerifyModel.m
//  lob-ios
//
//  Created by Zealous Amoeba on 1/3/14.
//  www.zealousamoeba.org
//  Copyright (c) 2014 Lob. All rights reserved.
//

#import "LobVerifyModel.h"
#import "LobAddressModel.h"

@implementation LobVerifyModel
@synthesize dateCreated = _dateCreated;
@synthesize dateModified = _dateModified;

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    if(self = [super init]) {
        _dateCreated = NULL;
        _dateModified = NULL;
        
        _address = [LobAddressModel initWithDictionary:dict[@"address"]];
        _message = dict[@"message"];
    }
    return self;
}

#pragma mark -
#pragma mark Description

-(NSString*)description {
    NSString *format = @"%@ | %@";
    return [NSString stringWithFormat:format,_message,_address];
}


@end
