# ladderlogic

A simple ladder logic simulator I made using "Processing"

To use simply select a position on any rung to modify it. Use the buttons at the bottom to change it to a wire, contact, or coil.
You can attach the output of a coil to a contact by selecting the desired coil and the contact and clicking the attach button (two inward 
facing triangles).

Add a label to a desired coil by selecting the coil then clicking "Label". Type the desired labele and press "Enter", any labeled coil 
will automatically provide its label to attached contacts.

X0-X7 are togglable inputs, turn on an Input, select a contact, and press "X+" to attach it to the contact. A label can be added the same 
as a coil. "X-" will un-attach the selected contact from an input, and "XC" will clear all attachments.

You can add as many rungs as you need, the remove rung button will remove the last rung. Use the mouse wheel to scroll through rungs.

Use "CE" to clear the entire board, press "S" to save, and "L" to load.
