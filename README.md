#Feature Toggling Demo

A quick demo app to help compare different approaches to feature toggling. Includes demos for:

1. Build time 
2. Run time (including overriding from user defaults)

##Common setup

The project uses `FeaturesDebug.xcconfig` as its configuration. This file imports the cocoapods config files so everything from pods should be passed through. There are ruby gems to modify these files but the setup here is fairly simple text so can get away with basic scripts as well.

##Build time
 
Swift can have other flags set with "-D <flag name>" in `OTHER_SWIFT_FLAGS` (same way we setup DEBUG) now. The config here adds `BUILD_TIME_FEATURE` to existing flags 

At point of use the code can be compiled in or out using `#if <FEATURE_NAME> ... #endif`. This can be nice because it means code thats not ready for wider use can not be enabled at runtime, but gets a little repetitive if there is no obvious place to cut out the code. It would be nice to use `@available` here for a class and have swift enforce its use but it doesnt seem to work within compilation directives

##Run time

Pretty similar to the other example except it uses user-defined build values and Info.plist settings to expose via runtime instead of build. There is a simple function to check the info dictionary from bundle for matching strings 

Point of use here is a function to check Info.plist (or helper vars to clean it up). Can also be overriden in user defaults (or remotely as well if we want to do that)