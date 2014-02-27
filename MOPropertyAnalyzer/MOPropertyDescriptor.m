#import "MOPropertyDescriptor.h"

@implementation MOPropertyDescriptor

+ (instancetype)descriptorWithName:(NSString *)name className:(NSString *)className type:(MOPropertyType)type pointer:(BOOL)pointer primitive:(BOOL)primitive readonlyAttribute:(BOOL)readonlyAttribute copyAttribute:(BOOL)copyAttribute retainAttribute:(BOOL)retainAttribute weakAttribute:(BOOL)weakAttribute nonatomicAttribute:(BOOL)nonatomicAttribute dynamicAttribute:(BOOL)dynamicAttribute {
    return [[self alloc] initWithName:name className:className type:type pointer:pointer primitive:primitive readonlyAttribute:readonlyAttribute copyAttribute:copyAttribute retainAttribute:retainAttribute weakAttribute:weakAttribute nonatomicAttribute:nonatomicAttribute dynamicAttribute:dynamicAttribute];
}

- (instancetype)initWithName:(NSString *)name className:(NSString *)className type:(MOPropertyType)type pointer:(BOOL)pointer primitive:(BOOL)primitive readonlyAttribute:(BOOL)readonlyAttribute copyAttribute:(BOOL)copyAttribute retainAttribute:(BOOL)retainAttribute weakAttribute:(BOOL)weakAttribute nonatomicAttribute:(BOOL)nonatomicAttribute dynamicAttribute:(BOOL)dynamicAttribute {
    self = [super init];
    if (self) {
        _name = name;
        _className = className;
        _type = type;
        _pointer = pointer;
        _primitive = primitive;
        _readonlyAttribute = readonlyAttribute;
        _copyAttribute = copyAttribute;
        _retainAttribute = retainAttribute;
        _weakAttribute = weakAttribute;
        _nonatomicAttribute = nonatomicAttribute;
        _dynamicAttribute = dynamicAttribute;
    }

    return self;
}

- (BOOL)isNSNumberValidType {
    NSArray *validTypes = @[
            @(MOPropertyTypeChar),
            @(MOPropertyTypeShort),
            @(MOPropertyTypeUnsignedShort),
            @(MOPropertyTypeInt),
            @(MOPropertyTypeLong),
            @(MOPropertyTypeUnsignedLong),
            @(MOPropertyTypeLongLong),
            @(MOPropertyTypeUnsignedLongLong),
            @(MOPropertyTypeFloat),
            @(MOPropertyTypeDouble),
            @(MOPropertyTypeBool),
    ];

    return [validTypes containsObject:@(self.type)] || [self.className isEqualToString:NSStringFromClass([NSNumber class])];
}

- (BOOL)isNSStringValidType {
    return [self.className isEqualToString:NSStringFromClass([NSString class])];
}

@end
