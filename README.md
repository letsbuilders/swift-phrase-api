# swift-phrase-api

Swift wrapper for Phrase API

Current version supports only some part of the Phrase API v2. 
You are welcome to extend if you need to use parts not yet included.

---

**NOTE**: You will need Xcode 12.5 or [Swift 5.4](https://swift.org/download/#swift-54) to try out `PhraseAPI`. 
It may work with older version of swift, but it wasn't tested. 

## Getting started

If you have a server-side Swift application, or maybe a cross-platform (for example Linux & macOS) app/library, and you would like to call Phrase API this wrapper package is a great idea. 
Below you'll find all you need to know to get started.

#### Adding the dependency

`PhraseApi` is designed for Swift >= 5.4. To use the wrapper, you need to declare your dependency in your `Package.swift`:

```swift
.package(url: "https://github.com/letsbuilders/swift-phrase-api.git", from: "0.0.1"),
```

and to your application/library target, add `"PhraseApi"` to your `dependencies`, e.g. like this:

```swift
// Target for Swift 5.2
.target(name: "BestExampleApp", dependencies: [
    .product(name: "PhraseApi", package: "swift-phrase-api")
],
```

#### Calling phrase API

The code snippet below illustrates how to make a simple interaction with Phrase API.

Please note that the example will spawn a new `HTTPClient`, which will spawn new `EventLoopGroup` which will _create fresh threads_ which is a very costly operation. 
In a real-world application that uses [SwiftNIO](https://github.com/apple/swift-nio) for other parts of your application (for example a web server), 
please prefer to initialise with `httpClient: mySharedClient` to share `HTTPClient` and the `EventLoopGroup` with other parts of your application.

If your application does not use SwiftNIO yet, it is acceptable to use `httpClient: nil` but please make sure to share the returned `PhraseClinet` instance throughout your whole application. 
Do not create a large number of `PhraseClinet` instances with `httpClient: nil`, this is very wasteful and might exhaust the resources of your program.

```swift
import PhraseApi

let phraseClient = PhraseClient(accessToken: myPhraseOauthToken)

phraseClient.project(id: projectId).whenComplete { result in
    switch result {
    case .failure(let error):
    // process error
    case .success(let projectScope):
        projectScope.keys().whenComplete { result in 
            // process keys response
        }
    }
}
```

There are other ways to handle async results - please check SwiftNIO documents how to do that. 
Hopefully with swift 5.5 it will work with async/await

### Logging

For logging this library is using [SwiftLog](https://github.com/apple/swift-log).
Please follow their documentation for setting up the logging.

### Using it with Vapor
Instead of importing adding `PhraseApi` to your dependencies you can add `PhraseApiVapor`

```swift
// Target for Swift 5.2
.target(name: "BestExampleApp", dependencies: [
    .product(name: "PhraseApiVapor", package: "swift-phrase-api")
],
```

#### Configure
In your app configuration you need to pass token and optionally project ID

```swift
try app.phrase.configure(token: myToken, defaultProjectId: myPhraseProjectId).wait()
```
or 
```swift
app.phrase.configure(token: token)
```

**NOTE:** When you are passing `defaultProjectId`, `app.phrase.project` will be set asynchronously, 
so it is recommended to wait for result, so `app.phrase.project` is set. 

#### Usage

You can access shared PhraseAPI client on the app instance for example by using:

```swift
if let phraseClient = app.phrase.client {
    // My api calls go here
}
```

or you can access default project scope directly 

```swift
if let phraseProject = app.phrase.project {
    // My API calls go here
}
```
