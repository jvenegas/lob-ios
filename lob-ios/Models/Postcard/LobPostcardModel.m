//
//  LobPostcardModel.m
//  lob-ios
//
//  Created by Zealous Amoeba on 1/3/14.
//  www.zealousamoeba.org
//  Copyright (c) 2014 Lob. All rights reserved.
//

#import "LobPostcardModel.h"
#import "LobAddressModel.h"

@implementation LobPostcardModel

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    if(self = [super initWithDictionary:dict]) {
        _postcardId = dict[@"id"];
        _name = dict[@"name"];
        _message = dict[@"message"];
        _toAddress = [LobAddressModel initWithDictionary:dict[@"to"]];
        _fromAddress = [LobAddressModel initWithDictionary:dict[@"from"]];
        _status = dict[@"status"];
        _price = dict[@"price"];
        _frontUrl = dict[@"front"];
        _backUrl = dict[@"back"];
        
        if(dict[@"full_bleed"]) _fullBleed = [dict[@"full_bleed"] boolValue];
        else _fullBleed = false;
    }
    return self;
}

#pragma mark -
#pragma mark Description

-(NSString*)description {
    NSString *format = @"(%@) %@, %@ | %@ | %@ | %@, %@";
    return [NSString stringWithFormat:format,_postcardId,_name,_message,_toAddress,_fromAddress,_status,_price];
}

#pragma mark -
#pragma mark Request Methods

-(NSString*)urlParamsForCreateRequest {
    NSMutableArray *items = [NSMutableArray array];
    
    NSArray *nameValues = @[@[@"name" , @"name"],@[@"message" , @"message"],
                            @[@"status" , @"status"], @[@"price" , @"price"],
                            @[@"front" , @"frontUrl"], @[@"back" , @"backUrl"]];
    

    [LobAbstractModel populateItems:items fromPairs:nameValues onObject:self prefix:@""];
    
    NSString *toParams = [[self toAddress] urlParamsForInclusionWithPrefix:@"to"];
    [items addObject:toParams];
    
    NSString *fromParams = [[self fromAddress] urlParamsForInclusionWithPrefix:@"from"];
    [items addObject:fromParams];
    
    return [LobAbstractModel paramStringWithItems:items];
}

@end
