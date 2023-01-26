local newdecoder = require 'lib.baibailib.lib.lunajson.decoder'
local newencoder = require 'lib.baibailib.lib.lunajson.encoder'
local sax = require 'lib.baibailib.lib.lunajson.sax'
-- If you need multiple contexts of decoder and/or encoder,
-- you can require lunajson.decoder and/or lunajson.encoder directly.
return {
	decode = newdecoder(),
	encode = newencoder(),
	newparser = sax.newparser,
	newfileparser = sax.newfileparser,
}
