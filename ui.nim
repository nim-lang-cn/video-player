import osproc
import nigui
# First, import the library.

app.init()
# Initialization is mandatory.

var window = newWindow("NiGui Example")
# Create a window with a given title:
# By default, a window is empty and not visible.
# It is played at the center of the screen.
# A window can contain only one control.
# A container can contain multiple controls.

window.width = 600.scaleToDpi
window.height = 400.scaleToDpi
# Set the size of the window

# window.iconPath = "example_01_basic_app.png"
# The window icon can be specified this way.
# The default value is the name of the executable file without extension + ".png"

var container = newLayoutContainer(Layout_Vertical)
# Create a container for controls.
# By default, a container is empty.
# It's size will adapt to it's child controls.
# A LayoutContainer will automatically align the child controls.
# The layout is set to clhorizontal.

window.add(container)
# Add the container to the window.

var textArea = newTextArea()
container.add(textArea)
# Create a multiline text box.
# By default, a text area is empty and editable.
# Add the text area to the container.


var buttonContainer = newLayoutContainer(Layout_Horizontal)
buttonContainer.padding = 10
container.add(buttonContainer)

# 开始录屏
var startButton = newButton("开始录屏")
# Create a button with a given title.
startButton.width = 100
startButton.height = 50
buttonContainer.add(startButton)
# Add the button to the container.

# 播放视频
var playButton = newButton("播放视频")
# Create a button with a given title.
playButton.width = 100
playButton.height = 50
buttonContainer.add(playButton)



startbutton.onClick = proc(event: ClickEvent) =
# Set an event handler for the "onClick" event (here as anonymous proc).

  textArea.addLine("Button 1 clicked, message box opened.")
  window.alert("This is a simple message box.")
  textArea.addLine("Message box closed.")


proc play(path: string) = 
  let (output, _) = execCmdEx("ffplay -x 320 -y 240 " & path)


playButton.onClick = proc(event: ClickEvent) =
  var dialog = newOpenFileDialog()
  dialog.title = "请选择视频文件"
  dialog.multiple = true
  dialog.directory = "./"
  dialog.run()
  if dialog.files.len > 0:
    for file in dialog.files:
      var p = startProcess("ffplay -window_title Nim播放器 -autoexit -x 640 -y 320 -threads 2 " & file,options = {poEvalCommand})
      defer:p.close




window.show()
# Make the window visible on the screen.
# Controls (containers, buttons, ..) are visible by default.

app.run()
