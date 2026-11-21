# GumSyrup

<img src="media/gumsyrup-title-en.png" alt="GumSyrup" width="992">

## Start your next Terminal command in English

GumSyrup is a macOS CLI tool that switches the current input source back to English before the next shell prompt appears.
When you switch between input sources in Terminal, GumSyrup helps ensure that the next command starts in English automatically.

## Features

- Sister command to CursorTint
- macOS only
- Automatically switches to a supported English input source
- No input source ID configuration required
- No GumSyrup-specific configuration file required
- Does nothing if multiple supported English input sources are enabled
- No background process required

## Supported English Input Sources

GumSyrup supports the following English input sources:

- U.S.
- ABC
- ABC Extended

If exactly one of these supported English input sources is enabled, GumSyrup uses it as the destination input source.

If multiple supported English input sources are enabled, GumSyrup does nothing.

Other input sources, such as Japanese IMEs, are not restricted.

## Requirements

- macOS 12 or later
- Apple Silicon: tested
- Intel Mac: built as a Universal Binary, but not tested on actual Intel hardware
- Exactly one supported English input source must be enabled
- A shell that can run `gumsyrup` before the next prompt appears

Automatic execution has been tested with:

- zsh
- bash

Other shells can also be used as long as they can run `gumsyrup` before displaying the next prompt.

## Installation

### Homebrew

If you use Homebrew, install GumSyrup with:

```shell
brew install fixdot/tap/gumsyrup
```

Update:

```shell
brew upgrade gumsyrup
```

Uninstall:

```shell
brew uninstall gumsyrup
```

### Manual Installation

Download `gumsyrup.zip` from the [Releases](https://github.com/fixdot/gumsyrup/releases) page.

After extracting the archive, place `gumsyrup` somewhere in your `PATH`.

Example:

```
/usr/local/bin/gumsyrup
```

The distributed binary is signed with a Developer ID and notarized by Apple.

### zsh

Add the following to `~/.zshrc`:

```zsh
autoload -Uz add-zsh-hook

gumsyrup_precmd() {
    gumsyrup
}

add-zsh-hook precmd gumsyrup_precmd
```

After adding the configuration, run the following command to apply it, or open a new Terminal window.

```shell
source ~/.zshrc
```

#### Temporarily Disabling and Re-enabling GumSyrup

GumSyrup runs before each zsh prompt is displayed. It has little impact during normal use, but rapidly pressing Return may occasionally cause the prompt display to become distorted.

You can temporarily disable GumSyrup's automatic execution for the current zsh session.

**Disable:**

```zsh
add-zsh-hook -d precmd gumsyrup_precmd
```

**Re-enable:**

```zsh
add-zsh-hook precmd gumsyrup_precmd
```

These commands affect only the current zsh session and do not modify `~/.zshrc`. GumSyrup will be enabled as usual in new sessions.

### bash

Add GumSyrup to `PROMPT_COMMAND` in `~/.bashrc`:

```bash
PROMPT_COMMAND="gumsyrup${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
```

After adding the configuration, run:

```shell
source ~/.bashrc
```

## Usage

GumSyrup is normally called automatically from your shell.

You can also run it manually:

```shell
gumsyrup
```

Help:

```shell
gumsyrup -h
gumsyrup --help
```

Version:

```shell
gumsyrup -V
gumsyrup --version
```

## CursorTint

GumSyrup is a sister command to [CursorTint](https://github.com/fixdot/cursortint).
Using them together makes Japanese input in Terminal easier to manage.

- **CursorTint**
  Visualizes the current input mode using the Terminal cursor color.
- **GumSyrup**
  Switches the input source back to English before the next shell command is entered.

## Privacy

- GumSyrup does not read or store your input.
- It only checks the current macOS input source and switches to an English input source when necessary.
- It does not perform any network communication.

## Feedback

If you find a bug or have a feature request, please report it through [GitHub Issues](https://github.com/fixdot/gumsyrup/issues).

## License

GumSyrup is released under the MIT License.

Copyright © 2026 fix

## Project

GitHub: https://github.com/fixdot/gumsyrup