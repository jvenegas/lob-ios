//
//  LobAddressModel.h
//  lob-ios
//
//  Created by Zealous Amoeba on 1/3/14.
//  www.zealousamoeba.org
//  Copyright (c) 2014 Lob. All rights reserved.
//

#import "LobAbstractModel.h"

@interface LobAddressModel : LobAbstractModel
@property(nonatomic, strong) NSString *addressId;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSString *phone;
@property(nonatomic, strong) NSString *addressLine1;
@property(nonatomic, strong) NSString *addressLine2;
@property(nonatomic, strong) NSString *addressCity;
@property(nonatomic, strong) NSString *addressState;
@property(nonatomic, strong) NSString *addressZip;
@property(nonatomic, strong) NSString *addressCountry;

@end
