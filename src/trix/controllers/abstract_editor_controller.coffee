#= require trix/models/text
#= require trix/models/document
#= require trix/utilities/dom
#= require trix/utilities/html_parser

class Trix.AbstractEditorController
  constructor: (@config) ->
    {@textElement, @toolbarElement, @textareaElement, @inputElement, @delegate} = @config
    @text = @createText()
    @document = new Trix.Document [@text]
    @initialize()

  initialize: ->

  createText: ->
    if @textElement.textContent.trim()
      Trix.Text.fromHTML(@textElement.innerHTML)
    else if @inputElement?.value
      Trix.Text.fromJSON(@inputElement.value)
    else
      new Trix.Text

  saveSerializedText: ->
    @textareaElement.value = @textElement.innerHTML
    Trix.DOM.trigger(@textareaElement, "input")
    @inputElement?.value = @text.asJSON()
