local newdecoder = require 'lib.YMlib.lunajson.decoder'
local newencoder = require 'lib.YMlib.lunajson.encoder'
local sax = require 'lib.YMlib.lunajson.sax'
-- If you need multiple contexts of decoder and/or encoder,
-- you can require lunajson.decoder and/or lunajson.encoder directly.
return {
	decode = newdecoder(),
	encode = newencoder(),
	newparser = sax.newparser,
	newfileparser = sax.newfileparser,
}
