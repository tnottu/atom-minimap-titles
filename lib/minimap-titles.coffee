{CompositeDisposable} = require 'atom'

module.exports = Figletify =
  subscriptions: null

  activate: (state) ->

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
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

            # insert text in editor
            editor.insertText "#{art}", {select: true}
