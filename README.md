#estimate-cards
a simple ios app for story sizing during sprint planning.

#Current Features

1. Shake for random estimate
2. Tap card to view in Big Card view
3. Scrolling in Big Card View
4. Multiple Deck Types (Shirt Size, Fibonacci, etc..)

#Tasks
1. Convert menu from broken collection view to working Table View (in progress)
  - Should show deck names in Title and values as subtitle
  - Also, card background (if applicable) as the image on the table view cell.
2. Settings screen
  - Mostly just for editing decks
3. Custom deck types, editable from Settings
4. Enable custom decks types w/ custom background (store background as base64 data in the json file)
  - Image picker for background should have custom overlay that shows card size for zooming/placement
6. Pinch to dismiss gesture should not look like crap.
  - Actually shrink with pinch and disappear, not just slide away after pinch

#Implementation Stuff
I'd like to use this as a testbed to further my understanding of Reactive Cocoa, and MVVM on the iOS platform.

