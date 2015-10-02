//
//  AutorizacaoCrossAppRequest.h
//  OneBuy
//
//  Created by Andre Luiz Costa on 18/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AutorizacaoResponse.h"

@interface AutorizacaoCrossAppRequest : NSObject


- (void)obterAutorizacao:(void (^)(AutorizacaoResponse *objAutorizacaoResponse))block;

@end
