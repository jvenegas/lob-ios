//
//  LobSettingModel.m
//  lob-ios
//
//  Created by Zealous Amoeba on 1/3/14.
//  www.zealousamoeba.org
//  Copyright (c) 2014 Lob. All rights reserved.
//

#import "LobSettingModel.h"

@implementation LobSettingModel
@synthesize dateCreated = _dateCreated;
@synthesize dateModified = _dateModified;

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    if(self = [super init]) {
        _dateCreated = NULL;
        _dateModified = NULL;
        
        _settingId = dict[@"id"];
        _type = dict[@"type"];
        _description = dict[@"description"];
        _paper = dict[@"paper"];
        _width = dict[@"width"];
        _length = dict[@"length"];
        _color = dict[@"color"];
        _notes = dict[@"notes"];
    }
    return self;
}

#pragma mark -
#pragma mark Description

-(NSString*)description {
    NSString *format = @"(%@) %@, %@ - %@, %@, %@ - %@, %@";
    return [NSString stringWithFormat:format,_settingId,_type,_description,_paper,_width,_length,_color,_notes];
}

@end
