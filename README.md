# Shoofler

Shoofler is a text expansion tool for macOS.

# Links

- [Website](https://shoofler.app)
- [Development blog](https://blog.shoofler.app)

# Compiling

This project is managed using [Tuist](https://tuist.dev), a command-line build tool that help managing Xcode projects. More information about Tuist can be found in the [official documentation](https://docs.tuist.dev/en/guides/tuist/about). Xcode project file are not committed to the repository, they're generated for the Tuist project files (written in Swift).

The Tuist project for Shoofler includes targets for the application itself, the shootool automation tool and the unit test project.

## Opening the project in Xcode

Assuming Tuist is installed (via [Homebrew](https://brew.sh), for instance), you can start working on the project in xcode by running:

```shell
tuist install # download and setup the external dependencies for the project.
tuist generate # Generate the xcode project file and open it in Xcode.
```

`tuist install` is only required the first time, if you update the dependencies, or after a `tuist clean`.

## Creating a build

To create a build, use the following sequence of commands:

```bash
tuist install
tuist build --clean --generate -C Release --build-output-path ~/Desktop/ShooflerBuild
```

Once finished, the build (containing all targets) will be in `~/Desktop/ShooflerBuild`


> [!NOTE]
Release builds are configured to be signed (but not notarized) if the `TUIST_SHOOFLER_DEV_TEAM_ID` environment variable contains a developer ID and the appropriate certificate is installed in the OS keychain.

# Contributions

This project is currently not looking for contributors.

# Licence

Shoofler is licensed under the [MIT license](https://github.com/xmichelo/Shoofler#MIT-1-ov-file).
