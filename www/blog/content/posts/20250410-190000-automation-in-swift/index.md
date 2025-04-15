---
date: '2025-04-15T18:00:00+02:00'
draft: false
title: 'Automation in Swift'
---

A few months ago, I had a discussion with my teammates at work about the language and tools to use for automation. The colleague who set up the CI system did it using shell scripts, and the many command-line tools that are available. This approach works well, but the scripts are difficult to read and understand, barely debug-able, and difficult to test in an automated way.

I suggested that we try to rewrite some parts using [Go](https://go.dev), the language powering the core of the application we work on, which happen to be popular among the DevOps community. Unfortunately, the return on investment was not interesting enough and this project never came to fruition.

I have yet to commit the first lines of code for Shoofler (I'm experimenting some options at the moment), but I have already considered automation. I initially wanted to do it in Go, but after second thought, Shoofler will be written in Swift, so why not try to use Swift for automation too? I have starter the development of the [shootool](https://github.com/xmichelo/Shoofler/tree/master/shootool) command-line tool, which can already publish the content of this blog and the Shoofler homepage (for now a simple placeholder page).
