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

Select some text to convert something like this:

```
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
- Select `Minimap Titles: Convert` in the [command palette](https://atom.io/docs/latest/getting-started-atom-basics#command-palette) **or**
- Select _Packages_ -> _Minimap Titles Convert_ from the main menu **or**
- Right click on the selected text, and select _Minimap Titles: Convert_ from the context menu

## Credits
Based on the following packages:
- [atom-figletify](https://github.com/robatron/atom-figletify)
- [block-comment](https://github.com/RayKwon/atom-block-comment/)
