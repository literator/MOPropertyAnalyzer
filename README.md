Property Analyzer
===

It's a small project that allow to get all necessary information about properties of given class. Easy and simple tool ready to use. 
Just copy _MOPropertyAnalyzer_ folder to destination project.

## Example

```objective-c
MOPropertyAnalyzer *propertyAnalyzer = [MOPropertyAnalyzer analyzerWithClass:[MyObject class]];
MOPropertyDescriptor *descriptor = [propertyAnalyzer descriptorForPropertyName:@"complexRatio"];

NSAssert(descriptor.isPrimitive, @"It should be primitive type.");
NSAssert(descriptor.isReadonly, @"It should be readonly type.");
...

NSArray *propertyDescriptors = propertyAnalyzer.propertyDescriptors;
for (MOPropertyDescriptor *descriptor in propertyDescriptors) {
    NSLog(@"Property class name = %@", descriptor.className ?: @"No class name");
}
```

## TODO

* Get struct, union details

## Feedback

If you have some good thoughts, you want to contribute or give me an advice, please do. Contact me, create an issue or PR.

## License 
MIT
