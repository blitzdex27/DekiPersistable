#  DekiPersistable

Make your codable instances persistable (not using UserDefaults, SwiftData, CoreData)

## Use case

Saving

```swift
struct User: DekiPersistable {
    var name: String
    var email: String
}

let user = User(name: "Deki", email: "deki@example.com")
do {
    try user.save()
} catch {
    print("Error saving user \(user): \(error.localizedDescription)")
}
```

Loading

```swift
do {
    let loadedUser = try User.load()
    print(loadedUser)
} catch {
    print("Error loading user: \(error.localizedDescription)")
}
```
