# Project 4 - *Twitter Redux*

Time spent: **15** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] Hamburger menu
   - [X] Dragging anywhere in the view should reveal the menu.
   - [X] The menu should include links to your profile, the home timeline, and the mentions view.
   - [X] The menu can look similar to the example or feel free to take liberty with the UI.
- [X] Profile page
   - [X] Contains the user header view
   - [X] Contains a section with the users basic stats: # tweets, # following, # followers
- [X] Home Timeline
   - [X] Tapping on a user image should bring up that user's profile page

The following **optional** features are implemented:

- [ ] Profile Page
   - [ ] Implement the paging view for the user description.
   - [ ] As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
   - [X] Pulling down the profile page should blur and resize the header image.
- [ ] Account switching
   - [ ] Long press on tab bar to bring up Account view with animation
   - [ ] Tap account to switch to
   - [ ] Include a plus button to Add an Account
   - [ ] Swipe to delete an account


The following **additional** features are implemented:

- [X] Infinite scrolling for all tweet timelines
- [X] Re-used custom XIB for the tweet UITableViewCell to ensure consistency across all tweet timeline views

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

  1. Curious how folks implemented the image blur effect on the background/clouds image on the profile page
  2. 


## Video Walkthrough

Here's a walkthrough of implemented user stories:

![Twitter Redux walkthrough](http://i.imgur.com/ykj80ho.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

- I had difficulty getting the image blur to work the way that I wanted it to when pulling down on the UITableView in the profile view.  For one, I tried adding it programmatically and couldn't get the bounds to show up correctly (maybe I also needed to add programmatic layout constraints to make sure it always aligned with the background image view?).  Eventually I added it on the Storyboard and that resolved the issue.  Also the default UIBlurEffect doesn't seem to offer much customization (wanted to reduce the blur radius), and I wasn't sure whether plugging into the scollViewerDidScroll override was better than attaching a pan gesture recognizer and handling the 'animation' there.
- It took me a long time to figure out why the back button wasn't appearing when I pushed a new viewcontroller onto the navigation stack.  Eventually I think I figured it out...I needed to either remove the existing left bar button item, or set the leftItemsSupplementBackButton property to true.  Is that the correct approach?

## License

    Copyright 2017 Sean McRoskey

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
