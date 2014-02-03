//
//  LobObjectModel.h
//  lob-ios
//
//  Created by Zealous Amoeba on 1/3/14.
//  www.zealousamoeba.org
//  Copyright (c) 2014 Lob. All rights reserved.
//

#import "LobAbstractModel.h"

@class LobSettingModel;
@interface LobObjectModel : LobAbstractModel
@property(nonatomic, strong) NSString *objectId;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *quantity;
@property(nonatomic, assign) BOOL doubleSided;
@property(nonatomic, assign) BOOL fullBleed;
@property(nonatomic, strong) LobSettingModel *setting;
@property(nonatomic, strong) NSString *url;

@end
