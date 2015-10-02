//
//  Util.m
//  OneBuy
//
//  Created by Andre Luiz Costa on 18/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import "Util.h"
#import "NSString+MD5.h"

@implementation Util

#pragma mark Métodos públicos

+ (NSString *)gerarIdentificadorTransacao{
    NSString *guid = [[NSUUID UUID] UUIDString];
    
    return  guid;
}

+ (NSString *)gerarIdentificadorAparelho{
    
    NSString *identificadorAparelho = [[NSString alloc] initWithFormat: @"%@ - %@ - %@ - %@ - %@", [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion], [[UIDevice currentDevice] model], [[UIDevice currentDevice] localizedModel], [[UIDevice currentDevice] name]];
    
    identificadorAparelho = [Util criarChaveMD5:identificadorAparelho];
    
    return identificadorAparelho;
}


#pragma mark Métodos Privados
+ (NSString *)criarChaveMD5:(NSString *)valorOriginal{
    
    NSString *md5 = [valorOriginal MD5String]; // returns NSString of the MD5 of test
    return  md5;
}
@end
