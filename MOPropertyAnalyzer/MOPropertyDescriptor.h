#import <Foundation/Foundation.h>

typedef NS_ENUM(char , MOPropertyType) {
    MOPropertyTypeUnknown = '?',

    MOPropertyTypeVoid = 'v',
    MOPropertyTypeChar = 'c',
    MOPropertyTypeShort = 's',
    MOPropertyTypeUnsignedShort = 'S',
    MOPropertyTypeInt = 'i',
    MOPropertyTypeUnsigned = 'I',
    MOPropertyTypeLong = 'l',
    MOPropertyTypeUnsignedLong = 'L',
    MOPropertyTypeLongLong = 'q',
    MOPropertyTypeUnsignedLongLong = 'Q',
    MOPropertyTypeFloat = 'f',
    MOPropertyTypeDouble = 'd',
    MOPropertyTypeBool = 'B',

    MOPropertyTypeString = '*',
    MOPropertyTypeObject = '@',
    MOPropertyTypeClass = '#',
    MOPropertyTypeMethod = ':',
    MOPropertyTypeArray = '[',
    MOPropertyTypeStructure = '{',
    MOPropertyTypeUnion = '(',
};

@interface MOPropertyDescriptor : NSObject
@property(nonatomic, readonly) NSString *name;
@property(nonatomic, readonly) NSString *className;
@property(nonatomic, readonly) MOPropertyType type;
@property(nonatomic, readonly, getter=isPointer) BOOL pointer;
@property(nonatomic, readonly, getter=isPrimitive) BOOL primitive;
@property(nonatomic, readonly, getter=isReadonly) BOOL readonlyAttribute;
@property(nonatomic, readonly, getter=isCopy) BOOL copyAttribute;
@property(nonatomic, readonly, getter=isRetain) BOOL retainAttribute;
@property(nonatomic, readonly, getter=isWeak) BOOL weakAttribute;
@property(nonatomic, readonly, getter=isNonatomic) BOOL nonatomicAttribute;
@property(nonatomic, readonly, getter=isDynamic) BOOL dynamicAttribute;

+ (instancetype)descriptorWithName:(NSString *)name className:(NSString *)className type:(MOPropertyType)type pointer:(BOOL)pointer primitive:(BOOL)primitive readonlyAttribute:(BOOL)readonlyAttribute copyAttribute:(BOOL)copyAttribute retainAttribute:(BOOL)retainAttribute weakAttribute:(BOOL)weakAttribute nonatomicAttribute:(BOOL)nonatomicAttribute dynamicAttribute:(BOOL)dynamicAttribute;
- (instancetype)initWithName:(NSString *)name className:(NSString *)className type:(MOPropertyType)type pointer:(BOOL)pointer primitive:(BOOL)primitive readonlyAttribute:(BOOL)readonlyAttribute copyAttribute:(BOOL)copyAttribute retainAttribute:(BOOL)retainAttribute weakAttribute:(BOOL)weakAttribute nonatomicAttribute:(BOOL)nonatomicAttribute dynamicAttribute:(BOOL)dynamicAttribute;

- (BOOL)isNSNumberValidType;
- (BOOL)isNSStringValidType;

@end
