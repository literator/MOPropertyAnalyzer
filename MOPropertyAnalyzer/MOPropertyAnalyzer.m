#import "MOPropertyAnalyzer.h"
#import "MOPropertyDescriptor.h"
#import <CoreData/CoreData.h>
#import <objc/runtime.h>

@implementation MOPropertyAnalyzer {
    NSArray *_propertyDescriptors;
}

+ (instancetype)analyzerWithClass:(Class)klass {
    return [[self alloc] initWithClass:klass];
}

- (instancetype)initWithClass:(Class)klass {
    self = [super init];
    if (self) {
        [self analyzePropertiesForClass:klass];
    }

    return self;
}

- (void)analyzePropertiesForClass:(Class)klass {
    NSMutableArray *propertyDescriptors = [NSMutableArray array];

    Class workingClass = klass;

    do {
        unsigned int propertyCount = 0;
        objc_property_t *properties = class_copyPropertyList(workingClass, &propertyCount);
        for (unsigned int i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            char *typeEncoding = property_copyAttributeValue(property, "T");

            BOOL isPointer = NO;
            BOOL isPrimitive = YES;
            NSString *className = nil;
            MOPropertyType propertyType;
            switch (typeEncoding[0]) {
                case '^':
                    if (typeEncoding[1] == '?') {
                        propertyType = MOPropertyTypeMethod;
                    } else {
                        propertyType = (MOPropertyType) typeEncoding[1];
                    }
                    isPointer = YES;
                    break;
                case '@': {
                    if (strlen(typeEncoding) > 3) {
                        NSString *typeInformation = [NSString stringWithCString:typeEncoding encoding:NSUTF8StringEncoding];
                        className = [typeInformation substringWithRange:NSMakeRange(2, [typeInformation length] - 3)];
                    }
                }
                case '{':
                case '#':
                    isPrimitive = NO;
                default:
                    propertyType = (MOPropertyType) typeEncoding[0];
                    break;
            }

            BOOL isReadonly = property_copyAttributeValue(property, "R") != nil;
            BOOL isCopy = property_copyAttributeValue(property, "C") != nil;
            BOOL isRetain = property_copyAttributeValue(property, "&") != nil;
            BOOL isWeak = property_copyAttributeValue(property, "W") != nil;
            BOOL isNonatomic = property_copyAttributeValue(property, "N") != nil;
            BOOL isDynamic = property_copyAttributeValue(property, "D") != nil;

            NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];

            free(typeEncoding);

            MOPropertyDescriptor *propertyDescriptor = [MOPropertyDescriptor descriptorWithName:propertyName
                                                                                      className:className
                                                                                           type:propertyType
                                                                                        pointer:isPointer
                                                                                      primitive:isPrimitive
                                                                              readonlyAttribute:isReadonly
                                                                                  copyAttribute:isCopy
                                                                                retainAttribute:isRetain
                                                                                  weakAttribute:isWeak
                                                                             nonatomicAttribute:isNonatomic
                                                                               dynamicAttribute:isDynamic];
            [propertyDescriptors addObject:propertyDescriptor];
        }

        workingClass = class_getSuperclass(workingClass);
    } while (workingClass && workingClass != [NSObject class] && workingClass != [NSManagedObject class]);

    _propertyDescriptors = propertyDescriptors;
}

#pragma mark - Public

- (MOPropertyDescriptor *)descriptorForProperty:(SEL)selector {
    return [self descriptorForPropertyName:NSStringFromSelector(selector)];
}

- (MOPropertyDescriptor *)descriptorForPropertyName:(NSString *)name {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", NSStringFromSelector(@selector(name)), name];
    NSArray *propertiesWithName = [self.propertyDescriptors filteredArrayUsingPredicate:predicate];
    NSAssert([propertiesWithName count] < 2, @"Wrong number of elements in filtered array.");
    return [propertiesWithName lastObject];
}

@end
