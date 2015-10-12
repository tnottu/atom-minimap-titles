<<<<<<< HEAD
# Minimap Titles
[Atom](https://atom.io/) package to convert the selected text to ASCII art using [FIGlet](http://www.figlet.org/) and then comment it.

The chosen figlet font (ANSI Shadow) is perfect for minimap visualization. Commenting supports several file extensions:
- js
- sh
- yaml
- coffee
- html
- md
- php
=======
# figletify

> [Atom](https://atom.io/) package to convert the selected text to ASCII art using [FIGlet](http://www.figlet.org/)
>>>>>>> 8a40d23cf6f856b0ad3213090e55e37eac873139

Select some text to convert something like this:

```
<<<<<<< HEAD
hello world
```

into something like this:

```
# ██   ██ ███████ ██      ██       ██████      ██     ██  ██████  ██████  ██      ██████  
# ██   ██ ██      ██      ██      ██    ██     ██     ██ ██    ██ ██   ██ ██      ██   ██
# ███████ █████   ██      ██      ██    ██     ██  █  ██ ██    ██ ██████  ██      ██   ██
# ██   ██ ██      ██      ██      ██    ██     ██ ███ ██ ██    ██ ██   ██ ██      ██   ██
# ██   ██ ███████ ███████ ███████  ██████       ███ ███   ██████  ██   ██ ███████ ██████
```

## Usage
To convert text, select the text you wish to convert, and do **any** of the following:
- Press `ctrl-shift-del` **or**
- Select `Minimap Titles: Convert` in the [command pallet](https://atom.io/docs/latest/getting-started-atom-basics#command-palette) **or**
- Select _Packages_ -> _Minimap Titles Convert_ from the main menu **or**
- Right click on the selected text, and select _Minimap Titles: Convert_ from the context menu

## Credits
Based on the following packages:
- [atom-figletify](https://github.com/robatron/atom-figletify)
- [block-comment](https://github.com/RayKwon/atom-block-comment/)
=======
Hello World!
```

to something like this:

```
 _  _     _ _      __      __       _    _ _
| || |___| | |___  \ \    / /__ _ _| |__| | |
| __ / -_) | / _ \  \ \/\/ / _ \ '_| / _` |_|
|_||_\___|_|_\___/   \_/\_/\___/_| |_\__,_(_)
```

## Usage

To figletify text, select the text you wish to convert, and do **any** of the following:

- Press `ctrl-alt-f` **or**
- Select `Figletify: Convert` in the [command pallet](https://atom.io/docs/latest/getting-started-atom-basics#command-palette) **or**
- Select *Packages* -> *Figletify Selection* from the main menu **or**
- Right click on the selected text, and select *Figletify Selection* from the context menu

## Configuration

You can configure the FIGfont produced by editing the following configuration
entry in you Atom config file:

```
figletify:
  font: "Small"
```

To see a demo of available fonts, go here: http://patorjk.com/software/taag

## Credits

Based on the [Hacking Atom: Package: Modifying Text](https://atom.io/docs/v1.0.0/hacking-atom-package-modifying-text) tutorial.
>>>>>>> 8a40d23cf6f856b0ad3213090e55e37eac873139
