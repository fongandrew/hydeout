---
layout: page
title: Chat platform
sidebar_link: false
---

![Admixture](/assets/images/banners/admixture.png)

ISBA donates to the [archaeo.social](https://about.archaeo.social) scholarly collective, to support the hosting of dedicated chat workspaces for all members and each affiliate group.

The chat platform is [Element](https://element.io) (Matrix), and can be accessed via web browser, desktop, or mobile apps.

It has a relatively similar layout to Slack, but is open source and federated, meaning that you can communicate with other Matrix servers and communities.
For more information why we selected this platform, see the [FAQ](#faq) below.

Due to the federated and data-privacy-centric nature of the platform, there are some aspects that may be new to many people, therefore the rest of this page will provide documentation and [instructions](#sign-up) on how to join the server, how to use it, and how to secure your account.

_We recommend reading ALL three sections instructions for the most optimal experience._

If you have any issues or questions, please contact the [ISBA webmaster](webmaster@isbarch.org).

> Note: ISBA does not guarantee 100% uptime of the chat service as a volunteer-ran self-hosted platform.

## Sign up

These steps can be carried out on most Matrix-related apps, whether the Element web-browser, or Element or other desktop clients or mobile apps.

If you're unsure what to use, we recommend starting with the 'official' Element set of apps: [https://element.io/download](https://element.io/download).

### Create an account

_ℹ️ Note: you do not need to create a new account if you already have an matrix account on another server! If you do, join the workspace directly via [https://matrix.to/#/#isba:archaeo.social](https://matrix.to/#/#isba:archaeo.social)_

To create an account, go through the following steps:

_For a graphical guide, read this section and then see [here](/chat-graphical#create-an-account)_.

1. Go to [https://chat.archaeo.social/#/welcome](https://chat.archaeo.social/#/welcome) in your web browser to create an account and follow the instructions
   - ⚠️ make sure the server is set to ‘archaeo.social’ (URL: [https://matrix.archaeo.social](https://matrix.archaeo.social)) and NOT just the default ‘matrix.org’
2. Fill in the username and password details as necessary
3. Check your email account to confirm the account
   - The confirmation email might take up to 10m to arrive in your mail post
   - Don't forget to check your spam folder!
4. Confirm your password as instructed in the email
5. Skip the onboarding _survey_
6. You should then see the initial chat page of the archaeo.social workspace!
   - Note that this is _not_ yet the ISBA space but the common space of the archaeo.social collective!
   - Feel free to go through the onboarding steps (e.g. turn on notifications)
7. _To join the ISBA space_: in the search bar at the top, search for `#isba:archaeo.social`
   - If this does not work, go to the following link in your web browser [https://matrix.to/#/#isba:archaeo.social](https://matrix.to/#/#isba:archaeo.social) and open the redirect in your Element client/app
8. Once you're in the ISBA space, should see at least two public 'rooms' (a.k.a. channels) - General and Random.
9. Go to to the room 'Introductions' and introduce yourself to the ISBA community!
   - If you don't see the 'Introduction' room in your side bar, press the `+` symbol next to the 'Room' section of the side bar
   - Press 'Explore rooms'
   - Press the 'Join' button

To join any other public room, press the `+` next to the 'Rooms' section header of the side bar.
We give some [recommendations](#using-element-matrix) below.

## Verification

You likely at this point have a message at the top of your window saying that your ‘session is not verified’.

Element is a highly security-focused messaging system.
You may need to set up _two things_ with your account after sign up to remove the verification warning.
You also _need to verify to be able to access your messages if you log in in a different location_.

Therefore we highly recommend carrying out the next two steps!

### First step: encryption

#### Background

To allow you to access your old messages on other devices and on re-login, you will _first_ need to set up encryption to prove it's you when you want to get the old messages back when on the same client.
In case you get logged out of all your sessions, you can retrieve your old messages using a _security key_.
This is similar to the recovery key when setting up two-factor authentication as you have to do on most web platforms nowadays.

#### Steps

To set this up:

_For a graphical guide, read this section and then see [here](/chat-graphical#first-step-encryption)_.

1. Open the personal settings menu (click on your face/profile picture in the top left)
2. Go to the ‘Security and Privacy’ section
3. In the menu, under Encryption, and Secure Backup, press ‘Set up’
4. Select either generate a security key (similar to Two-factor authentication backup OTP codes), or enter a security phrase (like a second password)
   - Even if you use a security phrase, you will get a security key (in case you forget your phrase)
   - You’ll then be asked to confirm your password (not phrase or key!)
5. Save the security key somewhere safe (e.g. print it off and store somewhere secure!)

### Second step: Cross-sign

#### Background

To allow you to access your old messages on _other devices_ on re-login, you ideally want to cross-sign your devices.
This allows you to unlock the encrypted messages sent from another device, and verify it is indeed you logging in.
_Note: you can do new session login verification simply with the security key generated in the first step, but this is more of a faff to do every time_

For setting this you need to log into an independent client from the one you used to originally sign up.
This could be any of the following:

- The browser version of [chat.archaeo.social](https://chat.archaeo.social)
- The desktop app of Element
- The android, OSX, or other mobile app from Element
- Any other matrix compatible desktop or mobile app supporting encryption and cross-sign.

Basically any of the above options that you didn't use during your initial sign up.

#### Steps

To validate the encryption you set up in the first step, (and/or verify a new login/session):

_For a graphical guide, read this section and then see [here](/chat-graphical#second-step-cross-sign)_.

1. If not already in a session, log into the first session (e.g., in the web-browser client as at the end of the procedure for ‘sign up’)
2. Make sure cross-signing is available
   - Go to personal settings menu (click on your face/profile picture in the top left)
   - Navigate to Security and Privacy > Cross-signing
   - Make sure it says ‘Cross-signing is ready for use’ (if it does not say this, check the encryption step above)
3. Log into the second session on a different client with your account and password (e.g., the Element mobile app, see all options above)
4. After logging in you will be prompted to 'verify with another device'
   - This may come up as notification or a banner at the top of the session
5. Press the ‘verify’ button, and follow the instructions
6. Go to your other device, and you should have a notification to ‘verify session’
7. Press 'verify'
8. Follow the instructions to either cross-compare an emoji combination displayed on both sessions, or scan a QR code
9. Press verify on both sessions when you see the shield.

## Using Element (matrix)

You can log into the workspace via most matrix-compatible web browser, desktop app, or mobile apps.

Element/Matrix uses a common structure of chatting with members of a 'space' (i.e., workspace).

You have group chats via public and private 'rooms', however you can also have direct messages with individuals.
Group chats (Rooms) and direct messages (People) are separated in different sections of the left hand side bar.

To start new messages, or create or join rooms, press the `+` symbol next to the corresponding section of the side bar.

We recommend to join at a minimum to join the following common rooms:

- General: for any general conversation related to biomolecular archaeology
- Random: for any off-topic conversation
- Introductions: for new members to introduce themselves to the community, and allow you to connect with people with similar research interests
- Events: for announcement posting or adverting of any type of event related to biomolecular archaeology
- Jobs: for adverts or job positions requests (note ISBA provides warranty to the accuracy or guarantees to any posts in this channel)
- Papers: for requesting of sharing of PDFs of published papers, or to announce to the community your own!
- No Stupid Questions: for posting any questions of any kind related to any area of biomolecular archaeology

Another important thing to remember: you can also join public rooms in other servers from your account!
Typically this works by getting a unique room + server URL (or just the room name) and putting this in the 'Explore rooms' interface.

## FAQ

### Why not use Slack, Discord or similar popular ?

There were long discussions with the ISBA board as well as affiliate groups about the choice of platform.

Many affiliate groups initially started out with free Slack workspaces, which was great due familiarity and ease of use. However, as the groups grew, the free tier of Slack became limiting, and the cost of upgrading to a paid tier was prohibitive - even with discounts.
Furthermore, increasingly useful aggregated knowledge stored in messages were being lost over time as they were locked behind paywalls.

Other proprietary alternative solutions were considered such as Mattermost, Discord, or Zulip - but in all cases they were too expensive even when self-hosting or did not have guarantees that the companies behind each one would go in the same direction as Slack with paywalls. Therefore it was opted to go for an open source option.

In this vein, we decided to go with support the wider archaeology community by opting to support the archaeo.social hosted chat platform.
The archaeo.social platform already hosts an Element server, which runs on the matrix federated network.
Element/Matrix is open.source, and is becoming extremely popular with many other communities and organisations, including academic and federal institutions around the world (particularly in Germany).

This solution allows us to retain control over our data and privacy, and makes it easier for portability (we can move our servers and workspaces to other locations if necessary).
By supporting an existing platform it reduces financial costs on the society, reduces time investment to set up and maintain, and we can strengthen the existing platform by providing a longer term source of funding and maintainer hours support.
