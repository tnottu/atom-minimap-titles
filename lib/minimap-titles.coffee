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

      # get multi-cursor selections
      selections = editor.getSelections()

      for selection in selections
        do (selection) ->
          if selection.isEmpty()
            # auto select word
            selection.selectLine()
            if selection.isEmpty() then return

          figlet selection.getText().trim(), { font: font }, ( error, art ) ->
            if error
              console.error error

            else
              ###
              remove font shadow (or minimap won't display it properly)
              - find unicode chars here: http://unicodelookup.com/#%E2%95%9D/1
              - convert hex (ie 0x255D) to unicode (ie \u255D)
              ###
              art = art.replace /[\u2550-\u255D]/g, " "

              # delete empty lines & tailing spaces
              art = art.replace /\s+$/gm, ""

              switch extension
                when 'sh','yaml',''
                  commentStart = ''
                  commentEnd = ''
                  commentRepeat = 80
                  # add '# ' to the beginning of each line
                  art = art.replace /^/, "# "
                  art = art.replace /\n/g, "\n# "

                when 'coffee', 'cjsx', 'cson'
                  commentStart = '###\n' + Array(commentRepeat).join('#') + '\n'
                  commentEnd = Array(commentRepeat).join('#') +'\n###\n'

                when 'html','md'
                  commentStart = '<!--' + Array(commentRepeat-4).join('-') + '\n' 
                  commentEnd = Array(commentRepeat-3).join('-') +'\n-->'

                when 'php'
                  commentStart = '/**' + Array(commentRepeat-3).join('*') + '\n
                  \t * Block comment\n
                  \t *\n
                  \t * @param type\n
                  \t * @return void\n'
                  commentEnd = Array(commentRepeat-2).join('*') + '*/\n\t'

                else
                  commentStart = '/*' + Array(commentRepeat-2).join('*') + '\n'
                  commentEnd = '\n' + Array(commentRepeat-2).join('*') + '*/\n'

              selection.insertText(
                "#{commentStart+art+commentEnd}\n",
                {
                  select: true,
                  autoIndent: true
                  autoIndentNewline: true
                }
              )
