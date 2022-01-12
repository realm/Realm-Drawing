# Realm-Draw iOS App
This is the iOS app for Realm-Draw.

![Realm-Draw demo](../assets/Realm-Draw.gif)

## Configure and Run
- Create the [backend Realm App](../Realm)
- Open `DrawingApp.xcodeproj` in Xcode
- Copy the Realm App ID from your Realm-Draw backend Realm app, and paste it into `DrawingApp.swift`:

```swift
let realmApp = RealmSwift.App(id: "draw-xxxxx")
```
- Select your target in Xcode
- Build and run with `⌘R`

## Technology Stack
This app uses SwiftUI.

The lines making up a  drawing are persisted locally in Realm. Those Realm objects are then automatically synced to any other device where the same user is logged in to Realm-Draw (currently iOS, but could also be Android).

## Using the App

You can register new users within the app.

If multiple people (devices) want to work on the same drawings then they should log in with the same username/password.

In the settings, you can choose between:

- Persisting a line as soon as you start drawing it. Each movement of your finger/pencil will be synced to other devices as they happen. The other devices will show every movement of your pencil. This is the most interactive mode, but it works Realm sync much harder.
- Delaying persisting of a new line until your finger/pencil is lifted from the screen.