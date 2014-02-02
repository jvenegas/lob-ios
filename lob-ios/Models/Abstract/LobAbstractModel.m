//
//  LobAbstractModel.m
//  lob-ios
//
//  Created by Zealous Amoeba on 1/11/14.
//  Copyright (c) 2014 Lob. All rights reserved.
//

#import "LobAbstractModel.h"

@implementation LobAbstractModel

-(instancetype)initWithDictionary:(NSDictionary*)dict {
    if(dict == NULL || [dict isEqual:[NSNull null]]) return NULL;
    
    if(self = [super init]) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
        
        NSString *dateCreated = dict[@"date_created"];
        if(dateCreated)
            self.dateCreated = [dateFormat dateFromString:dateCreated];
        NSString *dateModified = dict[@"date_modified"];
        if(dateModified)
            self.dateModified = [dateFormat dateFromString:dateModified];
    }
    return self;
}

+(instancetype)initWithDictionary:(NSDictionary*)dict {
    if(dict == NULL || [dict isEqual:[NSNull null]]) return NULL;
    return [[self alloc] initWithDictionary:dict];
}

+(NSArray*)modelsFromArrayOfDictionaries:(NSArray*)array {
    NSMutableArray *mutableArray = [NSMutableArray array];
    for(NSDictionary *dict in array) {
        LobAbstractModel *model = [self initWithDictionary:dict];
        [mutableArray addObject:model];
    }
    
    return [NSArray arrayWithArray:mutableArray];
}

#pragma mark -
#pragma mark Request Methods

+(void)populateItems:(NSMutableArray*)items fromPairs:(NSArray*)pairs onObject:(id)object prefix:(NSString*)prefix {
    for(NSArray *arr in pairs) {
        NSString *value = [object valueForKey:arr[1]];
        if(value) {
            value = [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *item = [LobAbstractModel paramItemWithName:arr[0] andValue:value prefix:prefix];

            [items addObject:item];
        }
    }
}

+(NSString*)paramStringWithItems:(NSArray*)items {
    return [NSString stringWithFormat:@"%@",[items componentsJoinedByString:@"&"]];
}

+(NSString*)paramItemWithName:(NSString*)name andValue:(NSString*)value prefix:(NSString*)prefix {
    if([prefix isEqualToString:@""]) return [name stringByAppendingFormat:@"=%@",value];
    else return [NSString stringWithFormat:@"%@[%@]=%@",prefix,name,value];
}

-(NSString*)urlParamsForCreateRequest {
    return @"";
}

-(NSString*)urlParamsForInclusionWithPrefix:(NSString*)prefix {
    return @"";
}

@end
