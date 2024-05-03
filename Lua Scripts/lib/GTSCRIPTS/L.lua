local newdecoder = require 'lib.GTSCRIPTS.GTL.decoder'
local newencoder = require 'lib.GTSCRIPTS.GTL.encoder'
local sax = require 'lib.GTSCRIPTS.GTL.sax'
-- If you need multiple contexts of decoder and/or encoder,
-- you can require lunajson.decoder and/or lunajson.encoder directly.
return {
	decode = newdecoder(),
	encode = newencoder(),
	newparser = sax.newparser,
	newfileparser = sax.newfileparser,
}
