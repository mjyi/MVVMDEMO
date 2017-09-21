//
//  JDViewModel.h
//  myJanDan
//
//  Created by mervin on 2017/8/16.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPService.h"
#import "JDRequestProtocol.h"

@interface JDViewModel : NSObject<JDRequestProtocol>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) RACSubject *errors;
@property (nonatomic, strong) RACCommand *requestRemoteDataCommand;

- (void)initialize;

@end
