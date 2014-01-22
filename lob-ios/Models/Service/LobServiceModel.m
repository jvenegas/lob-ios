//
//  LobServiceModel.m
//  lob-ios
//
//  Created by Zealous Amoeba on 1/3/14.
//  www.zealousamoeba.org
//  Copyright (c) 2014 Lob. All rights reserved.
//

#import "LobServiceModel.h"

@implementation LobServiceModel
@synthesize dateCreated = _dateCreated;
@synthesize dateModified = _dateModified;

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    if(self = [super init]) {
        _dateCreated = NULL;
        _dateModified = NULL;
        
        _serviceId = dict[@"id"];
        _name = dict[@"name"];
        _description = dict[@"description"];
    }
    return self;
}

#pragma mark -
#pragma mark Description

-(NSString*)description {
    NSString *format = @"(%@) %@, %@";
    return [NSString stringWithFormat:format,_serviceId,_name,_description];
}

@end
