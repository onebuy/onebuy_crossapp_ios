//
//  Criptografia.h
//  OneBuy
//
//  Created by Andre Luiz Costa on 18/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+Base64.h"
#import <CommonCrypto/CommonCryptor.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

#define FBENCRYPT_ALGORITHM     kCCAlgorithmAES128
#define FBENCRYPT_BLOCK_SIZE    kCCBlockSizeAES128
#define FBENCRYPT_KEY_SIZE      kCCKeySizeAES256

@interface Criptografia : NSObject

+ (NSString *)descriptografarDadosTrafegados:(NSString *)valorCriptografado chaveDescriptografia:(NSString *)chaveDescriptografia;
+ (NSString *)criptografarDadosEntreApps:(NSString *)valorDescriptografado comChaveCriptografia:(NSString *)chaveCriptografia;
+ (NSString *)descriptografarDadosEntreApps:(NSString *)valorCriptografado chaveDescriptografia:(NSString *)chaveDescriptografia;

@end
