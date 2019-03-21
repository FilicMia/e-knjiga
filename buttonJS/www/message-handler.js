// This recieves messages of type "testmessage" from the server.
// See http://shiny.rstudio.com/gallery/server-to-client-custom-messages.html
// for details
var caesarShift = function(str, amount) {

	// Wrap the amount
	if (amount < 0)
		return caesarShift(str, amount + 26);

	// Make an output variable
	var output = '';

	// Go through each character
	for (var i = 0; i < str.length; i ++) {

		// Get the character we'll be appending
		var c = str[i];

		// If it's a letter...
		if (c.match(/[a-z]/i)) {

			// Get its code
			var code = str.charCodeAt(i);

			// Uppercase letters
			if ((code >= 65) && (code <= 90))
				c = String.fromCharCode(((code - 65 + amount) % 26) + 65);

			// Lowercase letters
			else if ((code >= 97) && (code <= 122))
				c = String.fromCharCode(((code - 97 + amount) % 26) + 97);

		}

		// Append
		output += c;

	}

	// All done!
	return output;
};

function createButton(context, value, func) {
    var button = document.createElement("input");
    button.type = "button";
    button.value = value;
    button.onclick = func;
    context.appendChild(button);
}

function isBlank(str) {
    return (!str || /^\s*$/.test(str));
}

function shiftAllLetters(event){
  if(isBlank(event.target.value)) return;
  var shift = event.target.value.charCodeAt(0)  - textDec[event.target.id].charCodeAt(0) ;
  alert(shift);
  var div = document.getElementById('chiperButtons');
  var i;
  for (i = 0; i < div.childNodes.length; i++) { 
    var node = div.childNodes[i];
    node.value = caesarShift(textDec[i],shift);
  }
}

function createTextInput(context, value, id ,func) {
    var elem = document.createElement("input");
    elem.type = "text";
    elem.value = value;
    elem.addEventListener('input', func);
    elem.id = id;
    context.appendChild(elem);
}


textDec = [];

Shiny.addCustomMessageHandler("setdecypher",
  function(message) {
    
    var input = document.getElementById('plaintext');
    textDec=input.value.replace(/\s+/g,"").split('');

    var div = document.createElement('div');
    div.id = 'chiperButtons';
    
    i = 0;
    while (i < textDec.length){
      createTextInput(div, textDec[i], i, shiftAllLetters);
      i = i+1;
    }
    document.body.appendChild(div);
  }
);

Shiny.addCustomMessageHandler("encrypt",
  function(message) {
    text = JSON.stringify(message);
    var div = document.createElement('div');
    div.id = 'chiperButtons';
    createButton(div, 'new', function(){});
    document.body.appendChild(div);
    
    var el = $("#chipertext");
    el.css("background-color", "Red");
    el.text(caesarShift(text,3));
  }
);