//
//  LobBankAccountModel.h
//  lob-ios
//
//  Created by Zealous Amoeba on 1/3/14.
//  www.zealousamoeba.org
//  Copyright (c) 2014 Lob. All rights reserved.
//

#import "LobAbstractModel.h"

@class LobAddressModel;
@interface LobBankAccountModel : LobAbstractModel
@property(nonatomic, strong) NSString *bankId;
@property(nonatomic, strong) NSString *routingNumber;
@property(nonatomic, strong) NSString *accountNumber;
@property(nonatomic, strong) NSString *bankCode;
@property(nonatomic, strong) LobAddressModel *bankAddress;
@property(nonatomic, strong) LobAddressModel *accountAddress;

@end
