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

      figlet = require 'figlet'
      font = 'ANSI Shadow'

      # get file extension
      fileName = editor.getTitle()
      extension = fileName.substr(fileName.lastIndexOf('.') + 1, fileName.length)
      if extension == fileName then extension = ''

      # auto select words
      editor.selectWordsContainingCursors()

      # get multi-cursor selections
      selections = editor.getSelections()

      for selection in selections
        do (selection) ->
          if selection.isEmpty() then return

          figlet selection.getText(), { font: font }, ( error, art ) ->
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

              switch extension
                when 'js'
                  commentStart = '/*\n'
                  commentEnd = '\n*/'

                when 'sh','yaml',''
                  commentStart = ''
                  commentEnd = ''
                  # add '# ' to the beginning of each line
                  art = art.replace /^/, "# "
                  art = art.replace /\n/g, "\n# "

                when 'coffee'
                  commentStart = '###\n'
                  commentEnd = '\n###'

                when 'html','md'
                  commentStart = '<!--\n'
                  commentEnd = '\n-->'

                when 'php'
                  commentStart = '/**\n
                  \t * Block comment\n
                  \t *\n
                  \t * @param type\n
                  \t * @return void\n'
                  commentEnd = '\t */\n\t'

                else
                  commentStart = '/*\n'
                  commentEnd = '\n*/'

              selection.insertText(
                "#{commentStart+art+commentEnd}",
                {select: true}
              )
