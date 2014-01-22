//
//  LobCountryModel.m
//  lob-ios
//
//  Created by Zealous Amoeba on 1/3/14.
//  www.zealousamoeba.org
//  Copyright (c) 2014 Lob. All rights reserved.
//

#import "LobCountryModel.h"

@implementation LobCountryModel
@synthesize dateCreated = _dateCreated;
@synthesize dateModified = _dateModified;

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    if(self = [super init]) {
        _dateCreated = NULL;
        _dateModified = NULL;
        
        _countryId = dict[@"id"];
        _name = dict[@"name"];
        _shortName = dict[@"short_name"];
    }
    return self;
}

#pragma mark -
#pragma mark Description

-(NSString*)description {
    NSString *format = @"(%@) %@, %@";
    return [NSString stringWithFormat:format,_countryId,_name,_shortName];
}

@end
