#!/usr/bin/env node

var fs = require('fs');

var args = process.argv.splice(2);

var filenameIn = args[0]
var filenameOut = args[1]

var text = fs.readFileSync(filenameIn, "utf8");
text = text.replace(/<!-- if dev -->[\s\S]*?<!-- endif -->/g,"")
text = text.replace(/<!-- if !dev/g,"")
text = text.replace(/endif -->/g,"")
text = text.replace(/\n[\s]*?\n/g,"\n")
text = text.replace(/\n+/g,"\n")


console.log(text);