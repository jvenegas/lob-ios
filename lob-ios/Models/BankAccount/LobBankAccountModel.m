//
//  LobBankAccountModel.m
//  lob-ios
//
//  Created by Zealous Amoeba on 1/3/14.
//  www.zealousamoeba.org
//  Copyright (c) 2014 Lob. All rights reserved.
//

#import "LobBankAccountModel.h"
#import "LobAddressModel.h"

@implementation LobBankAccountModel

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    if(self = [super initWithDictionary:dict]) {
        _bankId = dict[@"id"];
        _routingNumber = dict[@"routing_number"];
        _accountNumber = dict[@"account_number"];
        _bankCode = dict[@"bank_code"];
        _bankAddress = [LobAddressModel initWithDictionary:dict[@"bank_address"]];
        _accountAddress = [LobAddressModel initWithDictionary:dict[@"account_address"]];
    }
    return self;
}

#pragma mark -
#pragma mark Description 

-(NSString*)description {
    NSString *format = @"(%@) %@ %@, %@ | %@ | %@";
    return [NSString stringWithFormat:format,_bankId,_routingNumber,_accountNumber,_bankCode,_bankAddress,_accountAddress];
}

#pragma mark -
#pragma mark Request Methods

-(NSString*)urlParamsForCreateRequest {
    NSMutableArray *items = [NSMutableArray array];
    
    NSArray *nameValues = @[@[@"routing_number",@"routingNumber"],@[@"account_number",@"accountNumber"],
                            @[@"bank_code",@"bankCode"]];
    
    [LobAbstractModel populateItems:items fromPairs:nameValues onObject:self prefix:@""];
    
    if([self bankAddress] != NULL) {
        NSString *addrParams = [[self bankAddress] urlParamsForInclusionWithPrefix:@"bank_address"];
        [items addObject:addrParams];
    }
    
    if([self accountAddress] != NULL) {
        NSString *addrParams = [[self accountAddress] urlParamsForInclusionWithPrefix:@"account_address"];
        [items addObject:addrParams];
    }
    
    return [LobAbstractModel paramStringWithItems:items];
}

@end
