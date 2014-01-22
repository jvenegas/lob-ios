//
//  LobObjectModel.m
//  lob-ios
//
//  Created by Zealous Amoeba on 1/3/14.
//  www.zealousamoeba.org
//  Copyright (c) 2014 Lob. All rights reserved.
//

#import "LobObjectModel.h"
#import "LobSettingModel.h"


@implementation LobObjectModel

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    if(self = [super initWithDictionary:dict]) {
        _objectId = dict[@"id"];
        _name = dict[@"name"];
        _quantity = dict[@"quantity"];
        
        if(dict[@"double_sided"]) _doubleSided = [dict[@"double_sided"] boolValue];
        else _doubleSided = false;
        
        if(dict[@"full_bleed"]) _fullBleed = [dict[@"full_bleed"] boolValue];
        _fullBleed = false;
        
        _setting = [LobSettingModel initWithDictionary:dict[@"setting"]];
        _file = dict[@"file"];
    }
    return self;
}

#pragma mark -
#pragma mark Description

-(NSString*)description {
    NSString *format = @"(%@) %@, %@ - %@, %@";
    return [NSString stringWithFormat:format,_objectId,_name,_quantity,_doubleSided ? @"YES" : @"NO",_setting];
}

#pragma mark -
#pragma mark Request Methods

-(NSMutableArray*)urlParamItemsWithPrefix:(NSString*)prefix {
    NSMutableArray *items = [NSMutableArray array];
    
    NSArray *nameValues = @[@[@"name" , @"name"],@[@"quantity" , @"quantity"]];
    
    [LobAbstractModel populateItems:items fromPairs:nameValues onObject:self prefix:prefix];
    
    if([prefix isEqualToString:@""]) [items addObject:[NSString stringWithFormat:@"setting_id=%@",[[self setting] settingId]]];
    else [items addObject:[NSString stringWithFormat:@"%@[setting_id]=%@",prefix,[[self setting] settingId]]];
    
    if([self file]) {
        NSString *item = [self file];
         item = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef) item,NULL,CFSTR("!*'();:@+$,/?%#[]\" "),kCFStringEncodingUTF8));
        
        if([prefix isEqualToString:@""]) [items addObject:[NSString stringWithFormat:@"file=%@",item]];
        else [items addObject:[NSString stringWithFormat:@"%@[file]=%@",prefix,item]];
    }
    if([self doubleSided]) {
        if([prefix isEqualToString:@""]) [items addObject:@"double_sided=1"];
        else [items addObject:[NSString stringWithFormat:@"%@[double_sided]=1",prefix]];
    }
    if([self fullBleed]) {
        if([prefix isEqualToString:@""]) [items addObject:@"full_bleed=1"];
        else [items addObject:[NSString stringWithFormat:@"%@[full_bleed]=1",prefix]];
    }

    return items;
}

-(NSString*)urlParamsForCreateRequest {
    NSMutableArray *items = [self urlParamItemsWithPrefix:@""];
    return [LobAbstractModel paramStringWithItems:items];
}

-(NSString*)urlParamsForInclusionWithPrefix:(NSString *)prefix {
    if([self objectId] != NULL && ![[self objectId] isEqualToString:@""])
        return [NSString stringWithFormat:@"%@=%@",prefix,[self objectId]];
    else {
        NSMutableArray *items = [self urlParamItemsWithPrefix:prefix];
        return [LobAbstractModel paramStringWithItems:items];
    }
}


@end
