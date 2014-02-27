#import <Foundation/Foundation.h>
#import "MOPropertyDescriptor.h"

@interface MOPropertyAnalyzer : NSObject
@property(nonatomic, readonly) NSArray *propertyDescriptors;

+ (instancetype)analyzerWithClass:(Class)klass;
- (instancetype)initWithClass:(Class)klass;

- (MOPropertyDescriptor *)descriptorForProperty:(SEL)selector;
- (MOPropertyDescriptor *)descriptorForPropertyName:(NSString *)name;
@end
