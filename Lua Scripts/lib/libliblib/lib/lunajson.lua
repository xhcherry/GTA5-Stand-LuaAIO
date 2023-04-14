local newdecoder = require 'lib.libliblib.lib.lunajson.decoder'
local newencoder = require 'lib.libliblib.lib.lunajson.encoder'
local sax = require 'lib.libliblib.lib.lunajson.sax'
-- If you need multiple contexts of decoder and/or encoder,
-- you can require lunajson.decoder and/or lunajson.encoder directly.
return {
	decode = newdecoder(),
	encode = newencoder(),
	newparser = sax.newparser,
	newfileparser = sax.newfileparser,
}
