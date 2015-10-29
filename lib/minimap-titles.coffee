{CompositeDisposable} = require 'atom'

module.exports = MinimapTitles =
  subscriptions: null

  activate: (state) ->

    # Events subscribed to in atom's system can be
    # easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'minimap-titles:convert': => @convert()

  deactivate: ->
    @subscriptions.dispose()

  convert: ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()

      # If there is text in the selection
      if selection.length > 0
        figlet = require 'figlet'

        font = 'ANSI Shadow'
        figlet selection, { font: font }, ( error, art ) ->
          if error
            console.error error
          else

            ###
            remove font shadow (or minimap won't display it properly)
            - find unicode chars here: http://unicodelookup.com/#%E2%95%9D/1
            - convert hex (ie 0x255D) to unicode (ie \u255D)
            ###
            art = art.replace /[\u2550-\u255D]/g, " "

            # delete empty lines
            art = art.replace /^[\s\t]*(\r\n|\n|\r)/gm, ""
            art = art.replace /\r?\n?[^\r\n]*$/, ""


            ###
             ██████  ██████  ███    ███ ███    ███ ███████ ███    ██ ████████
            ██      ██    ██ ████  ████ ████  ████ ██      ████   ██    ██
            ██      ██    ██ ██ ████ ██ ██ ████ ██ █████   ██ ██  ██    ██
            ██      ██    ██ ██  ██  ██ ██  ██  ██ ██      ██  ██ ██    ██
             ██████  ██████  ██      ██ ██      ██ ███████ ██   ████    ██
            ###

            # file extension
            fileName = editor.getTitle()
            extension = fileName.substr(fileName.lastIndexOf('.') + 1, fileName.length)
            if extension == fileName
              extension = ''

            # comment types
            if extension is 'js'
              commentStart = '/*\n'
              commentEnd = '\n*/'
            else if extension is 'sh' or extension is 'yaml' or extension is ''
              commentStart = ''
              commentEnd = ''
            else if extension is 'coffee'
              commentStart = '###\n'
              commentEnd = '\n###'
            else if extension is 'html' or extension is 'md'
              commentStart = '<!--\n'
              commentEnd = '\n-->'
            else if extension is 'php'
              commentStart = '/**\n
              \t * Block comment\n
              \t *\n
              \t * @param type\n
              \t * @return void\n'
              commentEnd = '\t */\n\t'
            else
              commentStart = '/*\n'
              commentEnd = '\n*/'


            if extension is 'sh' or extension is 'yaml' or extension is ''
              # add '# ' to the beginning of each line
              art = art.replace /^/, "# "
              art = art.replace /\n/g, "\n# "

            #start = art.trim().substr(0, commentStart.length)
            #end = art.trim().substr(-1 * commentEnd.length)

            # insert text
            #if start is commentStart and end is commentEnd
            if commentStart == '' and commentEnd == ''
              replaced = art.trim().substr(commentStart.length)
              replaced = replaced.substr(0, replaced.length - commentEnd.length)
              editor.insertText(replaced, {select: true})
            else
              editor.insertText(
                "#{commentStart+art+commentEnd}",
                {select: true}
              )
