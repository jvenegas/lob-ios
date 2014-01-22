//
//  LobCheckModel.m
//  lob-ios
//
//  Created by Zealous Amoeba on 1/3/14.
//  www.zealousamoeba.org
//  Copyright (c) 2014 Lob. All rights reserved.
//

#import "LobCheckModel.h"
#import "LobAddressModel.h"
#import "LobBankAccountModel.h"

@implementation LobCheckModel

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    if(self = [super initWithDictionary:dict]) {
        _checkId = dict[@"id"];
        _name = dict[@"name"];
        _checkNumber = dict[@"check_number"];
        _memo = dict[@"memo"];
        _amount = dict[@"amount"];
        _toAddress = [LobAddressModel initWithDictionary:dict[@"to"]];
        _bank = [LobBankAccountModel initWithDictionary:dict[@"bank_account"]];
        _status = dict[@"status"];
        _message = dict[@"message"];
    }
    return self;
}

#pragma mark -
#pragma mark Description

-(NSString*)description {
    NSString *format = @"(%@) %@, %@ %@, %@ | %@ | %@ | %@, %@";
    return [NSString stringWithFormat:format,_checkId,_name,_checkNumber,_memo,_amount,_toAddress,_bank,_status,_message];
}

#pragma mark -
#pragma mark Request Methods

-(NSString*)urlParamsForCreateRequest {
    NSMutableArray *items = [NSMutableArray array];
    
    NSArray *nameValues = @[@[@"name" , @"name"],@[@"check_number" , @"checkNumber"],
                            @[@"memo" , @"memo"], @[@"amount" , @"amount"],
                            @[@"status" , @"status"], @[@"message" , @"message"]];
    
    [LobAbstractModel populateItems:items fromPairs:nameValues onObject:self prefix:@""];
    
    if([self toAddress] != NULL) {
        NSString *addrParams = [[self toAddress] urlParamsForInclusionWithPrefix:@"to"];
        [items addObject:addrParams];
    }
    
    [items addObject:[NSString stringWithFormat:@"bank_account=%@",[[self bank] bankId]]];
    
    return [LobAbstractModel paramStringWithItems:items];
}

@end
