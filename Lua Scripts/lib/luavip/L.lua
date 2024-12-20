local newdecoder = require 'lib.luavip.GTL.decoder'
local newencoder = require 'lib.luavip.GTL.encoder'
local sax = require 'lib.luavip.GTL.sax'
-- If you need multiple contexts of decoder and/or encoder,
-- you can require lunajson.decoder and/or lunajson.encoder directly.
return {
	decode = newdecoder(),
	encode = newencoder(),
	newparser = sax.newparser,
	newfileparser = sax.newfileparser,
}
