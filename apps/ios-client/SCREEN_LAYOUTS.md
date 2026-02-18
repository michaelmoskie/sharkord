# Sharkord iOS Client - Screen Layouts

## 1. Connection Screen

```
┌─────────────────────────────────────────┐
│                                         │
│                                         │
│           💬 (Shark + Discord)         │
│                                         │
│              Sharkord                   │
│                                         │
│       Connect to your server            │
│                                         │
│                                         │
│   ┌───────────────────────────────┐   │
│   │ Server URL                    │   │
│   │ ws://localhost:4991           │   │
│   └───────────────────────────────┘   │
│                                         │
│   ┌───────────────────────────────┐   │
│   │ Access Token                  │   │
│   │ ●●●●●●●●●●●●●●●●●●●●●●●●●   │   │
│   └───────────────────────────────┘   │
│                                         │
│   ┌───────────────────────────────┐   │
│   │         Connect               │   │
│   └───────────────────────────────┘   │
│                                         │
│                                         │
└─────────────────────────────────────────┘
```

## 2. Server View - Text Channel

```
┌──────────┬────────────────────────────┬─────────┐
│My Server │        # general           │ Online  │
│ ⚙        │    General discussion      │ — 2     │
├──────────┤  🔔 📌 👥 🔍              ├─────────┤
│          ├────────────────────────────┤         │
│TEXT      │                            │ 👤 Admin│
│CHANNELS  │ 👤 admin 10:30 AM         │ 🟢 In   │
│ v        │ Welcome to Sharkord!       │   voice │
│          │                            │         │
│# general │ 👤 user1 11:15 AM         │ 👤 User1│
│          │ This is a self-hosted...   │ 🟢      │
│# announ. │                            │         │
│          │ 👤 admin 12:00 PM         │ Offline │
│VOICE     │ You can chat and share!    │ — 1     │
│CHANNELS  │                            │         │
│ v        │                            │ 👤 User2│
│          │                            │ ⚫      │
│🔊 General│                            │         │
│          │                            │         │
│🔊 Gaming │                            │         │
│          ├────────────────────────────┤         │
│          │ + 😊 ↑                    │         │
│          │ Message...                 │         │
├──────────┴────────────────────────────┴─────────┤
│ 👤 admin     🎤 🔊 ⚙                            │
│ 🟢 Online                                       │
└─────────────────────────────────────────────────┘
```

## 3. Voice Channel View

```
┌──────────┬────────────────────────────┬─────────┐
│My Server │   🔊 General Voice         │ Online  │
│ ⚙        │                            │ — 3     │
├──────────┤  🔔 📌 👥 🔍              ├─────────┤
│          ├────────────────────────────┤         │
│TEXT      │                            │ 👤 Admin│
│CHANNELS  │  ┌──────────┬──────────┐  │ 🟢 In   │
│ v        │  │          │          │  │   voice │
│          │  │  👤 A    │  👤 U1   │  │         │
│# general │  │          │          │  │ 👤 User1│
│          │  │  Admin   │  User1   │  │ 🟢 In   │
│# announ. │  │  🟢      │  🟢      │  │   voice │
│          │  └──────────┴──────────┘  │         │
│VOICE     │                            │ Offline │
│CHANNELS  │  ┌──────────┐             │ — 1     │
│ v        │  │          │             │         │
│          │  │  👤 U2   │             │ 👤 User2│
│🔊 General│  │          │             │ ⚫      │
│   ↻      │  │  User2   │             │         │
│          │  │  🟢      │             │         │
│🔊 Gaming │  └──────────┘             │         │
│          │                            │         │
│          ├────────────────────────────┤         │
│          │    🎤   🔊   📹   📞     │         │
│          │   Mute Deaf Camera Leave  │         │
├──────────┴────────────────────────────┴─────────┤
│ 👤 admin     🎤 🔊 ⚙                            │
│ 🟢 Online                                       │
└─────────────────────────────────────────────────┘
```

## 4. User Settings

```
┌────────────────────────────────────────────────┐
│ Settings                              ✕        │
├──────────┬─────────────────────────────────────┤
│          │                                     │
│USER      │   My Account                        │
│SETTINGS  │                                     │
│          │   Username                          │
│My Account│   testuser                          │
│ ↻        │                                     │
│Profile   │   Email                             │
│          │   user@example.com                  │
│Privacy   │                                     │
│          │   ┌──────────────────────┐         │
│Appear.   │   │  Change Password     │         │
│          │   └──────────────────────┘         │
│APP       │                                     │
│SETTINGS  │   ┌──────────────────────┐         │
│          │   │     Log Out          │         │
│Voice &   │   └──────────────────────┘         │
│Video     │                                     │
│          │                                     │
│Notific.  │                                     │
│          │                                     │
│          │                                     │
└──────────┴─────────────────────────────────────┘
```

## 5. User Profile

```
┌─────────────────────────────────────────┐
│                                    Done │
├─────────────────────────────────────────┤
│  ███████████████████████████████████   │
│  ███████████████████████████████████   │
│           ┌──────────┐                  │
│           │          │                  │
│           │  👤 T    │                  │
│           │          │                  │
│           └──────────┘                  │
│                                         │
│           Test User                     │
│           @testuser                     │
│                                         │
│        🟢 Online                        │
│                                         │
│  ┌───────────────────────────────────┐ │
│  │ ABOUT ME                          │ │
│  │ No information provided           │ │
│  └───────────────────────────────────┘ │
│                                         │
│  ┌───────────────────────────────────┐ │
│  │ MEMBER SINCE                      │ │
│  │ February 17, 2026                 │ │
│  └───────────────────────────────────┘ │
│                                         │
│  ┌───────────────────────────────────┐ │
│  │   💬 Send Message                │ │
│  └───────────────────────────────────┘ │
│                                         │
│  ┌───────────────────────────────────┐ │
│  │   📞 Start Voice Call            │ │
│  └───────────────────────────────────┘ │
│                                         │
└─────────────────────────────────────────┘
```

## Color Legend

🟢 Green - Online/Success
⚫ Gray - Offline
🔴 Red - Busy/Error
🟡 Yellow - Away/Warning

## Icons Used

- 👤 User/Avatar
- 💬 Chat/Messaging
- 🔊 Voice/Speaker
- 🎤 Microphone
- 📹 Video/Camera
- 📞 Phone/Call
- ⚙ Settings/Gear
- 🔔 Notifications/Bell
- 📌 Pin
- 🔍 Search
- 👥 Members/People
- 😊 Emoji
- ↑ Send
- + Add/Attach
- # Hashtag (Text Channel)
- ✕ Close

## Dark Theme Characteristics

All screens use:
- Dark backgrounds (#202225, #2f3136, #36393f)
- Light text (#dcddde, #b9bbbe)
- Accent blue (#5865f2) for primary actions
- Green (#3ba55d) for success/online
- Red (#ed4245) for danger/errors
- Consistent spacing and padding
- Rounded corners (8px typically)
- Subtle borders and dividers
