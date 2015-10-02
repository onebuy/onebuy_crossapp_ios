#import "FBEncryptorAES.h"
#import "NSData+Base64.h"

@implementation FBEncryptorAES


#pragma mark -
#pragma mark Initialization and deallcation


#pragma mark -
#pragma mark Praivate


#pragma mark -
#pragma mark API



+ (NSString*)CriptografarDinamico:(NSString*)textoCriptografar comChave:(NSString*)chaveCriptografia comVetor: (NSString*)vetorCriptografia
{
    
    NSString * textoCriptografado;
    
    if(textoCriptografar && [textoCriptografar length] > 0){
    
        NSData *data = [textoCriptografar dataUsingEncoding:NSUTF8StringEncoding];
        
        NSData *key =  [chaveCriptografia dataUsingEncoding:NSUTF8StringEncoding];
        
        NSData *iv = [vetorCriptografia dataUsingEncoding:NSUTF8StringEncoding];
        
        NSData* result = nil;
        
        // setup key
        unsigned char cKey[FBENCRYPT_KEY_SIZE];
        bzero(cKey, sizeof(cKey));
        [key getBytes:cKey length:FBENCRYPT_KEY_SIZE];
        
        // setup iv
        char cIv[FBENCRYPT_BLOCK_SIZE];
        bzero(cIv, FBENCRYPT_BLOCK_SIZE);
        if (iv) {
            [iv getBytes:cIv length:FBENCRYPT_BLOCK_SIZE];
        }
        
        // setup output buffer
        size_t bufferSize = [data length] + FBENCRYPT_BLOCK_SIZE;
        void *buffer = malloc(bufferSize);
        
        // do encrypt
        size_t encryptedSize = 0;
        CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                              FBENCRYPT_ALGORITHM,
                                              kCCOptionPKCS7Padding,
                                              cKey,
                                              FBENCRYPT_KEY_SIZE,
                                              cIv,
                                              [data bytes],
                                              [data length],
                                              buffer,
                                              bufferSize,
                                              &encryptedSize);
        if (cryptStatus == kCCSuccess) {
            result = [NSData dataWithBytesNoCopy:buffer length:encryptedSize];
        } else {
            free(buffer);
        }
        
        textoCriptografado =  [result base64EncodedStringWithSeparateLines:false];
    }
    else
    {
        textoCriptografado = nil;
    }
    
    return textoCriptografado;
}

+ (NSString*)DescriptografarDinamico:(NSString*)textoDescriptografar comChave:(NSString*)chaveCriptografia comVetor: (NSString*)vetorCriptografia
{
    NSString * textoDescriptografado;
    
    if(textoDescriptografar && [textoDescriptografar length] > 0){
        
        NSData *data = [NSData dataFromBase64String:textoDescriptografar];
        
        NSData *key =  [chaveCriptografia dataUsingEncoding:NSUTF8StringEncoding];
        
        NSData *iv = [vetorCriptografia dataUsingEncoding:NSUTF8StringEncoding];
        
        NSData* result = nil;
        
        // setup key
        unsigned char cKey[FBENCRYPT_KEY_SIZE];
        bzero(cKey, sizeof(cKey));
        [key getBytes:cKey length:FBENCRYPT_KEY_SIZE];
        
        // setup iv
        char cIv[FBENCRYPT_BLOCK_SIZE];
        bzero(cIv, FBENCRYPT_BLOCK_SIZE);
        if (iv) {
            [iv getBytes:cIv length:FBENCRYPT_BLOCK_SIZE];
        }
        
        // setup output buffer
        size_t bufferSize = [data length] + FBENCRYPT_BLOCK_SIZE;
        void *buffer = malloc(bufferSize);
        
        // do decrypt
        size_t decryptedSize = 0;
        CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                              FBENCRYPT_ALGORITHM,
                                              kCCOptionPKCS7Padding,
                                              cKey,
                                              FBENCRYPT_KEY_SIZE,
                                              cIv,
                                              [data bytes],
                                              [data length],
                                              buffer,
                                              bufferSize,
                                              &decryptedSize);
        
        if (cryptStatus == kCCSuccess) {
            result = [NSData dataWithBytesNoCopy:buffer length:decryptedSize];
        } else {
            free(buffer);
        }
        
          textoDescriptografado =  [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    else
    {
        textoDescriptografado = nil;
       
    }
    
    return textoDescriptografado;
}
@end
