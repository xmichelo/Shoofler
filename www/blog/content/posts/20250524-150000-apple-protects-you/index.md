---
date: '2025-05-24T15:00:00+02:00'
draft: false
title: 'Apple Protects You'
---
Apple protects you.
Well, so to speak. Apple engineers' latest trick to put obstacles in developers' way consists of adding [protection against clipboard access](https://9to5mac.com/2025/05/12/macos-16-clipboard-privacy-protection/). The user will need to confirm that they authorize clipboard access via a system message box.

There are several ways text expanders can operate, but the most common consists in using the clipboard. When a trigger is detected, the application saves the current clipboard content, places the snippet in it, synthesizes the 'Paste' command, then replaces the original content in the clipboard.

The motivation is understandable, but the result is annoying, and useless. By constantly adding new notifications and authorization requests, the result obtained is the opposite of the desired effect. Users see so many messages that they end up ignoring the content and validating without thinking.