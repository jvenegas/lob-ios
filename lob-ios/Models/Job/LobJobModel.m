//
//  LobJobModel.m
//  lob-ios
//
//  Created by Zealous Amoeba on 1/3/14.
//  www.zealousamoeba.org
//  Copyright (c) 2014 Lob. All rights reserved.
//

#import "LobJobModel.h"
#import "LobAddressModel.h"
#import "LobPackagingModel.h"
#import "LobServiceModel.h"
#import "LobObjectModel.h"

@implementation LobJobModel

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    if(self = [super initWithDictionary:dict]) {
        _jobId = dict[@"id"];
        _name = dict[@"name"];
        _price = dict[@"price"];
        _toAddress = [LobAddressModel initWithDictionary:dict[@"to"]];
        _fromAddress = [LobAddressModel initWithDictionary:dict[@"from"]];
        _quantity = dict[@"quantity"];
        _status = dict[@"status"];
        _packaging = [LobPackagingModel initWithDictionary:dict[@"packaging"]];
        _service = [LobServiceModel initWithDictionary:dict[@"service"]];
        _objects = [LobObjectModel modelsFromArrayOfDictionaries:dict[@"objects"]];
    }
    return self;
}

#pragma mark -
#pragma mark Description

-(NSString*)description {
    NSString *format = @"(%@) %@, %@ | %@ | %@ | %@, %@ | %@ | %@ | %@";
    return [NSString stringWithFormat:format,_jobId,_name,_price,_toAddress,_fromAddress,_quantity,_status,_packaging,_service,_objects];
}

#pragma mark -
#pragma mark Request Methods

-(NSString*)urlParamsForCreateRequest {
    NSMutableArray *items = [NSMutableArray array];
    
    NSArray *nameValues = @[@[@"name" , @"name"],@[@"price" , @"price"],
                            @[@"qunatity" , @"quantity"], @[@"status" , @"status"]];
    
    [LobAbstractModel populateItems:items fromPairs:nameValues onObject:self prefix:@""];
    
    if([self toAddress] != NULL) {
        NSString *addrParams = [[self toAddress] urlParamsForInclusionWithPrefix:@"to"];
        [items addObject:addrParams];
    }
    
    if([self fromAddress] != NULL) {
        NSString *addrParams = [[self fromAddress] urlParamsForInclusionWithPrefix:@"from"];
        [items addObject:addrParams];
    }
    
    if([self packaging] != NULL) [items addObject:[NSString stringWithFormat:@"packaging_id=%@",[[self packaging] packagingId]]];
    if([self service] != NULL) [items addObject:[NSString stringWithFormat:@"service_id=%@",[[self service] serviceId]]];
    
    int index = 1;
    for(LobObjectModel *object in [self objects]) {
        NSString *name = [NSString stringWithFormat:@"object%i",index];
        NSString *item = [object urlParamsForInclusionWithPrefix:name];
        [items addObject:item];
        index++;
    }
    
    return [LobAbstractModel paramStringWithItems:items];
}


@end
