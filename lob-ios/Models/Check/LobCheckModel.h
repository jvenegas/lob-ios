//
//  LobCheckModel.h
//  lob-ios
//
//  Created by Zealous Amoeba on 1/3/14.
//  www.zealousamoeba.org
//  Copyright (c) 2014 Lob. All rights reserved.
//

#import "LobAbstractModel.h"

@class LobAddressModel;
@class LobBankAccountModel;
@interface LobCheckModel : LobAbstractModel
@property(nonatomic, strong) NSString *checkId;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *checkNumber;
@property(nonatomic, strong) NSString *memo;
@property(nonatomic, strong) NSString *amount;
@property(nonatomic, strong) LobAddressModel *toAddress;
@property(nonatomic, strong) LobBankAccountModel *bank;
@property(nonatomic, strong) NSString *status;
@property(nonatomic, strong) NSString *message;

@end
