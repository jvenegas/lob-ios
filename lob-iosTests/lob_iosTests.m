//
//  lob_iosTests.m
//  lob-iosTests
//
//  Created by Robert Maciej Pieta on 1/3/14.
//  Copyright (c) 2014 Lob. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LobLibrary.h"
static NSString *testApiKey = @"test_0dc8d51e0acffcb1880e0f19c79b2f5b0cc";

@interface lob_iosTests : XCTestCase {
    LobRequest *request;
    dispatch_semaphore_t sem;
}

@end

@implementation lob_iosTests

-(void)setUp {
    [super setUp];
    request = [[LobRequest alloc] initWithAPIKey:testApiKey];
    sem = dispatch_semaphore_create(0);
}

-(void)tearDown {
    while (dispatch_semaphore_wait(sem, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:5]];
    }

    [super tearDown];
    NSLog(@"\n\n\n\n");
}

#pragma mark -
#pragma mark Tests

/**
 * Address Tests
 */

-(void)testAddressList {
    NSLog(@"Test Address List");
    
    [request listAddressesWithResponse:^(NSArray *addresses, NSError *error) {
        NSLog(@"*** Address List Response ***");
        NSLog(@"    Addresses: %@",addresses);
        dispatch_semaphore_signal(sem);
    }];
}


-(void)testAddressCreate {
    NSLog(@"Test Address Create");

    NSDictionary *dict = @{@"name" : @"Harry Zhang", @"email" : @"harry@lob.com",
                           @"phone" : @"5555555555", @"address_line1" : @"123 Test Street",
                           @"address_line2" : @"Unit 199", @"address_city" : @"Mountain View",
                           @"address_state" : @"CA", @"address_zip" : @"94085", @"address_country" : @"US"};
    
    LobAddressModel *addrModel = [LobAddressModel initWithDictionary:dict];
    
    [request createAddressWithModel:addrModel withResponse:^(LobAddressModel *addr, NSError *error) {
        NSLog(@"*** Address Create Response ***");
        NSLog(@"    Address: %@",addr);
        dispatch_semaphore_signal(sem);
    }];
}

-(void)testAddressRetrieve {
    NSLog(@"Test Address Retrieve");

    [request retrieveAddressWithId:@"adr_fa85158b26c3eb7c" withResponse:^(LobAddressModel *addr, NSError *error) {
        NSLog(@"*** Address Retrieve Response ***");
        NSLog(@"    Address: %@",addr);
        dispatch_semaphore_signal(sem);
    }];
}

-(void)testAddressDelete {
    NSLog(@"Test Address Delete");

    [request deleteAddressWithId:@"adr_43769b47aed248c2" withResponse:^(NSString *message, NSError *error) {
        NSLog(@"*** Address Delete Response ***");
        NSLog(@"    Message: %@",message);
        dispatch_semaphore_signal(sem);
    }];
}

/**
 * Bank Account Tests
 */

-(void)testBankAccountList {
    NSLog(@"Test Bank Account List");

    [request listBankAccountsWithResponse:^(NSArray *accounts, NSError *error) {
        NSLog(@"*** Bank Account List Response ***");
        NSLog(@"    Accounts: %@",accounts);
        dispatch_semaphore_signal(sem);
    }];
}

-(void)testBankAccountCreate {
    NSLog(@"Test Bank Account Create");

    NSDictionary *accountAddrDict = @{@"name" : @"Leore Avidar", @"address_line1" : @"123 Test Street",
                                   @"address_line2" : @"Apt 155", @"address_city" : @"Sunnyvale",
                                   @"address_state" : @"CA", @"address_zip" : @"94085", @"address_country" : @"US"};
    
    NSDictionary *bankAddrDict = @{@"name" : @"Chase Bank", @"address_line1" : @"55 Edmonds Street",
                                   @"address_city" : @"Palo Alto", @"address_state" : @"CA",
                                   @"address_zip" : @"90081", @"address_country" : @"US"};

    
    NSDictionary *bankDict = @{@"routing_number" : @"123456789", @"account_number" : @"123456789",
                               @"bank_code" : @"123456789", @"bank_address" : bankAddrDict,
                               @"account_address" : accountAddrDict};

    LobBankAccountModel *bankModel = [LobBankAccountModel initWithDictionary:bankDict];
    [request createBankAccountWithModel:bankModel withResponse:^(LobBankAccountModel *account, NSError *error) {
        NSLog(@"*** Bank Account Create Response ***");
        NSLog(@"    Bank Account: %@",account);
        dispatch_semaphore_signal(sem);
    }];
}

-(void)testBankAccountRetrieve {
    NSLog(@"Test Bank Account Retrieve");

    [request retrieveBankAccountWithId:@"bank_dfceb4a2a05b57e" withResponse:^(LobBankAccountModel *account, NSError *error) {
        NSLog(@"*** Bank Account Retrieve Response ***");
        NSLog(@"    Bank Account: %@",account);
        dispatch_semaphore_signal(sem);
    }];
}

/**
 * Check Tests
 */

-(void)testCheckList {
    NSLog(@"Test Check List");

    [request listChecksWithResponse:^(NSArray *checks, NSError *error) {
        NSLog(@"*** Check List Response ***");
        NSLog(@"    Checks: %@",checks);
        dispatch_semaphore_signal(sem);
    }];
}

-(void)testCheckCreate {
    NSLog(@"Test Check Create");

    NSDictionary *toAddrDict = @{@"name" : @"Harry Zhang", @"address_line1" : @"123 Test Street",
                                 @"address_city" : @"Mountian View", @"address_state" : @"CA",
                                 @"address_zip" : @"94041", @"address_country" : @"US"};
    
    
    NSDictionary *checkDict = @{@"name" : @"Demo Check", @"to" : toAddrDict,
                                @"bank_account" : @{@"id" : @"bank_3e64d9904356b20"},
                                @"amount" : @"2200", @"memo" : @"rent"};
    
    LobCheckModel *checkModel = [LobCheckModel initWithDictionary:checkDict];
    [request createCheckWithModel:checkModel withResponse:^(LobCheckModel *check, NSError *error) {
        NSLog(@"*** Check Create Response ***");
        NSLog(@"    Check: %@",check);
        dispatch_semaphore_signal(sem);
    }];
}

-(void)testCheckRetrieve {
    NSLog(@"Test Check Retrieve");

    [request retrieveCheckWithId:@"chk_a70f7e3893f8f1d8" withResponse:^(LobCheckModel *check, NSError *error) {
        NSLog(@"*** Check Retrieve Response ***");
        NSLog(@"    Check: %@",check);
        dispatch_semaphore_signal(sem);
    }];
}

/**
 * Country Tests
 */

-(void)testCountryList {
    NSLog(@"Test Country List");

    [request listCountriesWithResponse:^(NSArray *countries, NSError *error) {
        NSLog(@"*** Country List Response ***");
        NSLog(@"    Countries: %@",countries);
        dispatch_semaphore_signal(sem);
    }];
}

/**
 * Job Tests
 */

-(void)testJobList {
    NSLog(@"Test Job List");

    [request listJobsWithResponse:^(NSArray *jobs, NSError *error) {
        NSLog(@"*** Job List Response ***");
        NSLog(@"    Jobs: %@",jobs);
        dispatch_semaphore_signal(sem);
    }];
}

-(void)testJobCreate {
    NSLog(@"Test Job Create");

    NSDictionary *objectDict = @{@"name" : @"Go Blue", @"setting" : @{@"id" : @"100"},
                                 @"file" : @"https://www.lob.com/goblue.pdf"};
    
    NSDictionary *jobDict = @{@"name" : @"Michigan fan letter", @"to" : @{@"id" : @"adr_43769b47aed248c2"},
                              @"from" : @{@"id" : @"adr_7f9ece71fbca3796"},
                              @"objects" : @[@{@"id" : @"obj_7ca5f80b42b6dfca"},
                                            @{@"id" : @"obj_12128d3aad2aa98f"},
                                            objectDict]};
    
    LobJobModel *jobModel = [LobJobModel initWithDictionary:jobDict];
    [request createJobWithModel:jobModel withResponse:^(LobJobModel *job, NSError *error) {
        NSLog(@"*** Job Create Response ***");
        NSLog(@"    Job: %@",job);
        dispatch_semaphore_signal(sem);
    }];
}

-(void)testJobRetrieve {
    NSLog(@"Test Job Retrieve");

    [request retrieveJobWithId:@"job_0e3eff58cb59c935" withResponse:^(LobJobModel *job, NSError *error) {
        NSLog(@"*** Job Retrieve Response ***");
        NSLog(@"    Job: %@",job);
        dispatch_semaphore_signal(sem);
    }];
}

/**
 * Object Tests
 */

-(void)testObjectList {
    NSLog(@"Test Object List");

    [request listObjectsWithResponse:^(NSArray *objects, NSError *error) {
        NSLog(@"*** Object List Response ***");
        NSLog(@"    Objects: %@",objects);
        dispatch_semaphore_signal(sem);
    }];
}

-(void)testObjectCreate {
    NSLog(@"Test Object Create");

    NSDictionary *objectDict = @{@"name" : @"Go Blue", @"setting" : @{@"id" : @"100"},
                                 @"file" : @"https://www.lob.com/goblue.pdf"};
    
    LobObjectModel *objectModel = [LobObjectModel initWithDictionary:objectDict];
    [request createObjectWithModel:objectModel withResponse:^(LobObjectModel *object, NSError *error) {
        NSLog(@"*** Object Create Response ***");
        NSLog(@"    Object: %@",object);
        dispatch_semaphore_signal(sem);
    }];
}

-(void)testObjectRetrieve {
    NSLog(@"Test Object Retrieve");

    [request retrieveObjectWithId:@"obj_4241a46e01b4f892" withResponse:^(LobObjectModel *object, NSError *error) {
        NSLog(@"*** Object Retrieve Response ***");
        NSLog(@"    Object: %@",object);
        dispatch_semaphore_signal(sem);
    }];
}

-(void)testObjectDelete {
    NSLog(@"Test Object Delete");

    [request deleteObjectWithId:@"obj_4241a46e01b4f892" withResponse:^(NSString *message, NSError *error) {
        NSLog(@"*** Object Delete Response ***");
        NSLog(@"    Message: %@",message);
        dispatch_semaphore_signal(sem);
    }];
}

/**
 * Packaging Tests
 */

-(void)testPackaingList {
    NSLog(@"Test Packaging List");

    [request listPackagingsWithResponse:^(NSArray *packagings, NSError *error) {
        NSLog(@"*** Packaging List Response ***");
        NSLog(@"    Packagings: %@",packagings);
        dispatch_semaphore_signal(sem);
    }];
}

/**
 * Postcard Tests
 */

-(void)testPostcardList {
    NSLog(@"Test Postcard List");

    [request listPostcardsWithResponse:^(NSArray *postcards, NSError *error) {
        NSLog(@"*** Postcard List Response ***");
        NSLog(@"    Postcards: %@",postcards);
        dispatch_semaphore_signal(sem);
    }];
}

-(void)testPostcardCreate {
    NSLog(@"Test Postcard Create");

    NSDictionary *toDict = @{@"name" : @"Harry Zhang", @"address_line1" : @"123 Test Street",
                             @"address_city" : @"Mountain View", @"address_state" : @"CA",
                             @"address_zip" : @"94041", @"address_country" : @"US"};
    
    NSDictionary *postcardDict = @{@"name" : @"Demo Postcard", @"front" : @"https://www.lob.com/postcardfront.pdf",
                                   @"back" : @"https://www.lob.com/postcardback.pdf", @"to" : toDict,
                                   @"from" : toDict};
   
    LobPostcardModel *postcardModel = [LobPostcardModel initWithDictionary:postcardDict];
    [request createPostcardWithModel:postcardModel withResponse:^(LobPostcardModel *postcard, NSError *error) {
        NSLog(@"*** Postcard Create Response ***");
        NSLog(@"    Postcard: %@",postcard);
        dispatch_semaphore_signal(sem);
    }];
}

-(void)testPostcardRetrieve {
    NSLog(@"Test Postcard Retrieve");

    [request retrievePostcardWithId:@"psc_5c002b86ce47537a" withResponse:^(LobPostcardModel *postcard, NSError *error) {
        NSLog(@"*** Postcard Retrieve Response ***");
        NSLog(@"    Postcard: %@",postcard);
        dispatch_semaphore_signal(sem);
    }];
}

/**
 * Service Tests
 */

-(void)testServiceList {
    NSLog(@"Test Service List");

    [request listServicesWithResponse:^(NSArray *services, NSError *error) {
        NSLog(@"*** Service List Response ***");
        NSLog(@"    Services: %@",services);
        dispatch_semaphore_signal(sem);
    }];
}

/**
 * Setting Tests
 */

-(void)testSettingList {
    NSLog(@"Test Setting List");

    [request listSettingsWithResponse:^(NSArray *settings, NSError *error) {
        NSLog(@"*** Setting List Response ***");
        NSLog(@"    Settings: %@",settings);
        dispatch_semaphore_signal(sem);
    }];
}

-(void)testSettingRetrieve {
    NSLog(@"Test Setting Retrieve");

    [request retrieveSettingWithId:@"100" withResponse:^(LobSettingModel *setting, NSError *error) {
        NSLog(@"*** Setting Retrieve Response ***");
        NSLog(@"    Setting: %@",setting);
        dispatch_semaphore_signal(sem);
    }];
}

/**
 * State Tests
 */

-(void)testStateList {
    NSLog(@"Test State List");

    [request listStatesWithResponse:^(NSArray *states, NSError *error) {
        NSLog(@"*** State List Response ***");
        NSLog(@"    States: %@",states);
        dispatch_semaphore_signal(sem);
    }];
}


/**
 * Verify Tests
 */

-(void)testVerify {
    NSLog(@"Test Verify Address");

    LobAddressModel *model = [[LobAddressModel alloc] initWithDictionary:@{
                    @"address_line1" : @"220 William T Morrissey Boulevard",
                    @"address_city" : @"Boston",
                    @"address_state" : @"MA",
                    @"address_zip" : @"02125"}];
    NSLog(@"Model: %@",model);
    
    [request verifyAddressModel:model withResponse:^(LobVerifyModel *validation, NSError *error) {
        NSLog(@"*** Verify Address Response ***");
        NSLog(@"    Validation: %@",validation);
        dispatch_semaphore_signal(sem);
    }];
}

@end
