//
//  Criptografia.m
//  OneBuy
//
//  Created by Andre Luiz Costa on 18/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import "Criptografia.h"
#import "NSData+AES.h"

@implementation Criptografia

#pragma mark Métodos públicos

+ (NSString *)descriptografarDadosTrafegados:(NSString *)valorCriptografado chaveDescriptografia:(NSString *)chaveDescriptografia{
    
    NSString * textoDescriptografado = nil;
    
    if(valorCriptografado && [valorCriptografado length] > 0)
    {
        if(!chaveDescriptografia){
            
            @throw [NSException
                    exceptionWithName:@"ERRO_AUTENTICAR_CHAVE_CRIPTOGRAFIA_NAO_ENCONTRADA"
                    reason:NSLocalizedString(@"ERRO_AUTENTICAR_CHAVE_CRIPTOGRAFIA_NAO_ENCONTRADA", @"")
                    userInfo:nil];
        }
        
        NSData *encryptedData = [self dataFromHexString:valorCriptografado];
        NSData *plainData = nil;
        
        // 'key' should be 32 bytes for AES256, will be null-padded otherwise
        char keyPtr[kCCKeySizeAES128+1]; // room for terminator (unused)
        bzero( keyPtr, sizeof( keyPtr ) ); // fill with zeroes (for padding)
        
        // fetch key data
        [chaveDescriptografia getCString:keyPtr maxLength:sizeof( keyPtr ) encoding:NSUTF8StringEncoding];
        
        NSUInteger dataLength = [encryptedData length];
        
        //See the doc: For block ciphers, the output size will always be less than or
        //equal to the input size plus the size of one block.
        //That's why we need to add the size of one block here
        size_t bufferSize = dataLength + kCCBlockSizeAES128;
        void *buffer = malloc( bufferSize );
        
        size_t numBytesDecrypted = 0;
        CCCryptorStatus cryptStatus = CCCrypt( kCCDecrypt,
                                              kCCAlgorithmAES128,
                                              kCCOptionECBMode,
                                              keyPtr, kCCKeySizeAES128,
                                              NULL /* initialization vector (optional) */,
                                              [encryptedData bytes], dataLength, /* input */
                                              buffer, bufferSize, /* output */
                                              &numBytesDecrypted );
        
        if( cryptStatus == kCCSuccess )
        {
            //the returned NSData takes ownership of the buffer and will free it on deallocation
            plainData = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        }
        else
        {
            free( buffer ); //free the buffer
        }

        textoDescriptografado = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
        
        textoDescriptografado = [textoDescriptografado stringByReplacingOccurrencesOfString:@"\0"
                                                               withString:@""];
    }
    
    return textoDescriptografado;
}

+ (NSString *)criptografarDadosEntreApps:(NSString *)valorDescriptografado comChaveCriptografia:(NSString *)chaveCriptografia{
    
    NSString * textoCriptografado = nil;
    
    if(valorDescriptografado && [valorDescriptografado length] > 0)
    {
        if(!chaveCriptografia){
            
            @throw [NSException
                    exceptionWithName:@"ERRO_AUTENTICAR_CHAVE_CRIPTOGRAFIA_NAO_ENCONTRADA"
                    reason:NSLocalizedString(@"ERRO_AUTENTICAR_CHAVE_CRIPTOGRAFIA_NAO_ENCONTRADA", @"")
                    userInfo:nil];
        }
        
        NSData *data = [valorDescriptografado dataUsingEncoding:NSUTF8StringEncoding];
        NSData* result = nil;
        
        // ‘key’ should be 16 bytes for AES128
        char keyPtr[kCCKeySizeAES128 + 1]; // room for terminator (unused)
        bzero( keyPtr, sizeof( keyPtr ) ); // fill with zeroes (for padding)
        
        // fetch key data
        [chaveCriptografia getCString:keyPtr maxLength:sizeof( keyPtr ) encoding:NSUTF8StringEncoding];
        
        NSUInteger dataLength = [data length];
        
        //See the doc: For block ciphers, the output size will always be less than or
        //equal to the input size plus the size of one block.
        //That’s why we need to add the size of one block here
        size_t bufferSize = dataLength + kCCBlockSizeAES128;
        void *buffer = malloc( bufferSize );
        
        size_t numBytesEncrypted = 0;
        CCCryptorStatus cryptStatus = CCCrypt( kCCEncrypt, kCCAlgorithmAES128, kCCOptionECBMode | kCCOptionPKCS7Padding,
                                              keyPtr, kCCKeySizeAES128,
                                              NULL /* initialization vector (optional) */,
                                              [data bytes], dataLength, /* input */
                                              buffer, bufferSize, /* output */
                                              &numBytesEncrypted );
        if( cryptStatus == kCCSuccess )
        {
            result = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
            textoCriptografado =  [result base64EncodedStringWithSeparateLines:false];
        }
        else
        {
            free( buffer ); //free the buffer
        }
    }
    
    return textoCriptografado;
}

+ (NSString *)descriptografarDadosEntreApps:(NSString *)valorCriptografado chaveDescriptografia:(NSString *)chaveDescriptografia{
    
    NSString * textoDescriptografado = nil;
    
    if(valorCriptografado && [valorCriptografado length] > 0)
    {
        if(!chaveDescriptografia){
            
            @throw [NSException
                    exceptionWithName:@"ERRO_AUTENTICAR_CHAVE_CRIPTOGRAFIA_NAO_ENCONTRADA"
                    reason:NSLocalizedString(@"ERRO_AUTENTICAR_CHAVE_CRIPTOGRAFIA_NAO_ENCONTRADA", @"")
                    userInfo:nil];
        }
        
        NSData *encryptedData = [NSData dataFromBase64String:valorCriptografado];
        
        NSData* result = nil;

        // 'key' should be 32 bytes for AES256, will be null-padded otherwise
        char keyPtr[kCCKeySizeAES128+1]; // room for terminator (unused)
        bzero( keyPtr, sizeof( keyPtr ) ); // fill with zeroes (for padding)
        
        // fetch key data
        [chaveDescriptografia getCString:keyPtr maxLength:sizeof( keyPtr ) encoding:NSUTF8StringEncoding];
        
        NSUInteger dataLength = [encryptedData length];
        
        //See the doc: For block ciphers, the output size will always be less than or
        //equal to the input size plus the size of one block.
        //That's why we need to add the size of one block here
        size_t bufferSize = dataLength + kCCBlockSizeAES128;
        void *buffer = malloc( bufferSize );
        
        size_t numBytesDecrypted = 0;
        CCCryptorStatus cryptStatus = CCCrypt( kCCDecrypt,
                                              kCCAlgorithmAES128,
                                              kCCOptionECBMode,
                                              keyPtr, kCCKeySizeAES128,
                                              NULL /* initialization vector (optional) */,
                                              [encryptedData bytes], dataLength, /* input */
                                              buffer, bufferSize, /* output */
                                              &numBytesDecrypted );
        
        if (cryptStatus == kCCSuccess) {
            result = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        } else {
            free(buffer);
        }
        
        textoDescriptografado =  [[NSString alloc] initWithData:[NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted] encoding:NSUTF8StringEncoding];
    }
    
    return textoDescriptografado;
}

#pragma mark Métodos Privados
+ (NSData *)dataFromHexString:(NSString *)string
{
    NSMutableData *data = [NSMutableData new];
    for (NSUInteger i=0; i<string.length; i+=2) {
        char high = (char)[string characterAtIndex:i];
        char low = (char)[string characterAtIndex:i+1];
        char bchars[3] = {high, low, '\0'};
        UInt8 byte = strtol(bchars, NULL, 16);
        [data appendBytes:&byte length:1];
    }
    return [NSData dataWithData:data];
}

@end
