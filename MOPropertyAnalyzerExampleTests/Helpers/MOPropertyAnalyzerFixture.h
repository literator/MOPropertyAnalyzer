#import <Foundation/Foundation.h>
#import "MOFixture.h"


@interface MOPropertyAnalyzerFixture : MOFixture

@property(nonatomic, readonly) char charReadonly;
@property(nonatomic, weak) id weakId;
@property(nonatomic, weak, readonly) id weakReadonlyId;

@property(nonatomic, strong) id strongId;
@property(nonatomic, copy) NSString *string;
@property(copy) NSNumber *number;
@property(nonatomic) NSInteger integer;

@end
