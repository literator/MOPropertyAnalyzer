//  MOPropertyAnalyzerExampleTests.m
//  MOPropertyAnalyzerExampleTests
//
//  Created by Maciej Oczko on 27.02.2014.
//  Copyright (c) 2014 Maciej Oczko. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MOPropertyAnalyzer.h"
#import "MOPropertyAnalyzerFixture.h"


@interface MOPropertyAnalyzerExampleTests : XCTestCase

@end

@implementation MOPropertyAnalyzerExampleTests {
    MOPropertyAnalyzer *_propertyAnalyzer;
}

- (void)setUp {
    [super setUp];
    _propertyAnalyzer = [MOPropertyAnalyzer analyzerWithClass:[MOPropertyAnalyzerFixture class]];
}

- (void)tearDown {
    _propertyAnalyzer = nil;
    [super tearDown];
}

- (void)testCharReadonlyProperty {
    MOPropertyDescriptor *descriptor = [_propertyAnalyzer descriptorForPropertyName:@"charReadonly"];
    XCTAssertEqual(descriptor.type, MOPropertyTypeChar, @"charReadonly should be char type.");
    XCTAssertTrue(descriptor.isPrimitive, @"charReadonly should be primitive type.");
    XCTAssertTrue(descriptor.isReadonly, @"charReadonly should be readonly.");
}

- (void)testWeakId {
    MOPropertyDescriptor *descriptor = [_propertyAnalyzer descriptorForPropertyName:@"weakId"];
    XCTAssertEqual(descriptor.type, MOPropertyTypeObject, @"weakId should be object type.");
    XCTAssertFalse(descriptor.isPrimitive, @"weakId shouldn't be primitive type.");
    XCTAssertFalse(descriptor.isReadonly, @"weakId shouldn't be readonly.");
    XCTAssertTrue(descriptor.isWeak, @"weakId should be weak.");
}

- (void)testWeakReadonlyId {
    MOPropertyDescriptor *descriptor = [_propertyAnalyzer descriptorForPropertyName:@"weakReadonlyId"];
    XCTAssertEqual(descriptor.type, MOPropertyTypeObject, @"weakReadonlyId should be object type.");
    XCTAssertFalse(descriptor.isPrimitive, @"weakReadonlyId shouldn't be primitive type.");
    XCTAssertTrue(descriptor.isReadonly, @"weakReadonlyId should be readonly.");

    // Comment: When property has weak and readonly attributes
    // readonly cover weak, and weakness is undiscoverable
    // at runtime.
    XCTAssertFalse(descriptor.isWeak, @"weakReadonlyId shouldn't be weak.");
    XCTAssertTrue(descriptor.isNonatomic, @"weakReadonlyId should be nonatomic.");
}

- (void)testStrongId {
    MOPropertyDescriptor *descriptor = [_propertyAnalyzer descriptorForPropertyName:@"strongId"];
    XCTAssertEqual(descriptor.type, MOPropertyTypeObject, @"strongId should be object type.");
    XCTAssertFalse(descriptor.isWeak, @"strongId shouldn't be weak.");
    XCTAssertFalse(descriptor.isReadonly, @"strongId shouldn't be readonly.");
}

- (void)testString {
    MOPropertyDescriptor *descriptor = [_propertyAnalyzer descriptorForPropertyName:@"string"];
    XCTAssertEqual(descriptor.type, MOPropertyTypeObject, @"string should be object type.");
    XCTAssertTrue(descriptor.isNonatomic, @"string should be nonatomic.");
    XCTAssertTrue([descriptor.className isEqualToString:@"NSString"], @"string should be have class name NSString.");
    XCTAssertTrue([descriptor isNSStringValidType], @"string should be NSString valid type.");
}

- (void)testNumber {
    MOPropertyDescriptor *descriptor = [_propertyAnalyzer descriptorForPropertyName:@"number"];
    XCTAssertEqual(descriptor.type, MOPropertyTypeObject, @"number should be object type.");
    XCTAssertFalse(descriptor.isNonatomic, @"number should be atomic.");
    XCTAssertTrue([descriptor.className isEqualToString:@"NSNumber"], @"number should be have class name NSNumber.");
    XCTAssertTrue([descriptor isNSNumberValidType], @"number should be NSNumber valid type.");
}

- (void)testInteger {
    MOPropertyDescriptor *descriptor = [_propertyAnalyzer descriptorForPropertyName:@"integer"];
#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
#define _MOIntegerAssertType MOPropertyTypeLongLong
#else
#define _MOIntegerAssertType MOPropertyTypeInt
#endif
    XCTAssertEqual(descriptor.type, _MOIntegerAssertType, @"integer should be proper type.");
    XCTAssertTrue(descriptor.isPrimitive, @"integer should be primitive type.");
    XCTAssertTrue([descriptor isNSNumberValidType], @"integer should be NSNumber valid type.");
}

- (void)testSuperclassDate {
    MOPropertyDescriptor *descriptor = [_propertyAnalyzer descriptorForPropertyName:@"date"];
    XCTAssertEqual(descriptor.type, MOPropertyTypeObject, @"date should be object type.");
    XCTAssertTrue([descriptor.className isEqualToString:@"NSDate"], @"date should be have class name NSDate.");
    XCTAssertTrue(descriptor.isCopy, @"date should be copy.");
}

@end
