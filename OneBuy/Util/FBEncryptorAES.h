#import <CommonCrypto/CommonCryptor.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

#define FBENCRYPT_ALGORITHM     kCCAlgorithmAES128
#define FBENCRYPT_BLOCK_SIZE    kCCBlockSizeAES128
#define FBENCRYPT_KEY_SIZE      kCCKeySizeAES256
#define FBENCRYPT_IV_HEX_LEGNTH (FBENCRYPT_BLOCK_SIZE*2)

@interface FBEncryptorAES : NSObject {
    
}

extern NSString * const CHAVE_CRIPTOGRAFIA;
extern NSString * const IV_CRIPTOGRAFIA;

+ (NSString*)CriptografarDinamico:(NSString*)textoCriptografar comChave:(NSString*)chaveCriptografia comVetor: (NSString*)vetorCriptografia;

+ (NSString*)DescriptografarDinamico:(NSString*)textoDescriptografar  comChave:(NSString*)chaveCriptografia comVetor: (NSString*)vetorCriptografia;

@end
