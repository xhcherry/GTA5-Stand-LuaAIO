
local newdecoder = require 'BeezyLib.lunajson.decoder'
local newencoder = require 'BeezyLib.lunajson.encoder'
local sax = require 'BeezyLib.lunajson.sax'
-- If you need multiple contexts of decoder and/or encoder,
-- you can require lunajson.decoder and/or lunajson.encoder directly.
return {
	decode = newdecoder(),
	encode = newencoder(),
	newparser = sax.newparser,
	newfileparser = sax.newfileparser,
}
