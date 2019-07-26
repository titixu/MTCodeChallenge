#  MoneyTree Code Challenage
This is a demo project for MoneyTree code Challenage

## Requirements
- Xcode Version 10 or above
- MacOS 10.14 or above

## Assumptions and Limitations 
- the currency string is harcoded to use "jp_JP" locale for currency format
- Currency string is not displaying with the "comma" in the simulator device, looks like a system bug 

## Unit Tests
The development are base on TDD by using nano-cycles, and micro-cycles. 
Both Unit Test targets have the "Randomize execution order" option on, this will make sure all unit tests are independ on its own and will no require tests to execute in linear order. 

There are two Unit Tests targets.
- "MTCodeChallengeTests" that rquires the MTCodeChallenge app as host. Which it is for testing the app
- "LogicTests" is a host-less testing target. As it doesn't requires the host app, it is good for test the logics, and it making sure the testing logic in not depend on the app or other object. Also this make TDD development faster.

## Something to consider for real life app
* Implement SwiftLint ( https://github.com/realm/SwiftLint ) to enforce Swift style and conventions.
* Use FastLane ( https://fastlane.tools ) for continually integration
* Use AppCenter ( https://appcenter.ms ) for storing build and collecting crashes


## Development Workflows
### Create Data Objects and logic tests target
1 Create and test the APIClient that loadup the account details
2 Create and test the data models: Account and Transaction
3 Create API Client that load json files and convert json data to Objects
4 Create HomeViewModel
5 Create home table view concontroller
6 Create AccountViewModel
7 Create AccountViewController

