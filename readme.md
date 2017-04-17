# Project 3 - *Twitter*

**Twitter** is a basic twitter app to read and compose tweets from the [Twitter API](https://apps.twitter.com/).

Time spent: **15** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User can sign in using OAuth login flow.
- [X] User can view last 20 tweets from their home timeline.
- [X] The current signed in user will be persisted across restarts.
- [X] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.  In other words, design the custom cell with the proper Auto Layout settings.  You will also need to augment the model classes.
- [X] User can pull to refresh.
- [X] User can compose a new tweet by tapping on a compose button.
- [X] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.

The following **optional** features are implemented:

- [ ] When composing, you should have a countdown in the upper right for the tweet limit.
- [ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [X] Retweeting and favoriting should increment the retweet and favorite count.
- [ ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [X] Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I'm curious how other people chose how to split methods between the TwitterClient class and model classes like User and Tweet.  For instance, I duplicated a lot of method signatures from TwitterClient to the User model, so calls to User.tweet() would just forward to the TwitterClient API
2. What networking debugging tools and workflows did people find useful?  I don't feel like I had a good one.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

![Twitter client walkthrough](http://i.imgur.com/nBdKLH9.gif)
[Twitter client walkthrough](http://i.imgur.com/nBdKLH9.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

I don't feel like I had a good workflow for debugging network requests, and I couldn't figure out why special characters in some tweets resulted in failures in the API.  I tried percent-escaping the param string, but then it actually tweeted the escaped string :/

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
