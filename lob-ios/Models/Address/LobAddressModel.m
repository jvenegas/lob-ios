//
//  LobAddressModel.m
//  lob-ios
//
//  Created by Zealous Amoeba on 1/3/14.
//  www.zealousamoeba.org
//  Copyright (c) 2014 Lob. All rights reserved.
//

#import "LobAddressModel.h"

@implementation LobAddressModel

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    if(self = [super initWithDictionary:dict]) {
        _addressId = dict[@"id"];
        _name = dict[@"name"];
        _email = dict[@"email"];
        _phone = dict[@"phone"];
        _addressLine1 = dict[@"address_line1"];
        _addressLine2 = dict[@"address_line2"];
        _addressCity = dict[@"address_city"];
        _addressState = dict[@"address_state"];
        _addressZip = dict[@"address_zip"];
        _addressCountry = dict[@"address_country"];
    }
    return self;
}

#pragma mark -
#pragma mark Description

-(NSString*)description {
    NSString *format = @"(%@) %@, %@, %@ - %@ %@, %@ %@, %@, %@";
    return [NSString stringWithFormat:format,_addressId,_name,_email,_phone,_addressLine1,_addressLine2,_addressCity,_addressState,_addressZip,_addressCountry];
}

#pragma mark -
#pragma mark Request Methods

-(NSString*)urlParamsForCreateRequest {
    NSMutableArray *items = [NSMutableArray array];
    
    NSArray *nameValues = @[@[@"name", @"name"], @[@"address_line1",@"addressLine1"],
                            @[@"address_line2",@"addressLine2"], @[@"address_city",@"addressCity"],
                            @[@"address_state",@"addressState"], @[@"address_zip",@"addressZip"],
                            @[@"address_country",@"addressCountry"]];
    
    [LobAbstractModel populateItems:items fromPairs:nameValues onObject:self prefix:@""];
    return [LobAbstractModel paramStringWithItems:items];
}

-(NSString*)urlParamsForInclusionWithPrefix:(NSString*)prefix {
    if([self addressId] != NULL && ![[self addressId] isEqualToString:@""])
        return [NSString stringWithFormat:@"%@=%@",prefix,[self addressId]];
    else {
        NSArray *nameValues = @[@[@"name",@"name"], @[@"email",@"email"],@[@"phone",@"phone"],
                                @[@"address_line1",@"addressLine1"],@[@"address_line2",@"addressLine2"],
                                @[@"address_city",@"addressCity"],@[@"address_state",@"addressState"],
                                @[@"address_zip",@"addressZip"],@[@"address_country",@"addressCountry"]];
    
        NSMutableArray *items = [NSMutableArray array];
        [LobAbstractModel populateItems:items fromPairs:nameValues onObject:self prefix:prefix];
        return [LobAbstractModel paramStringWithItems:items];
    }
}

@end
