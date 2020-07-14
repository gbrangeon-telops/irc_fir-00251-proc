## Bitstream Encryption Constraints Section

set_property BITSTREAM.ENCRYPTION.ENCRYPT No [current_design]
set_property BITSTREAM.ENCRYPTION.ENCRYPTKEYSELECT efuse [current_design]

# Use the keyfile for the IRCAM product line (cameras and modules) or the electronic kits (stand-alone boards)
set_property BITSTREAM.ENCRYPTION.KEYFILE {\\stark\test$\xc7k160t_irc.nky} [current_design]
#set_property BITSTREAM.ENCRYPTION.KEYFILE {\\stark\test$\xc7k160t_kit.nky} [current_design]
#set_property BITSTREAM.ENCRYPTION.KEY0 0000000000000000000000000000000000000000000000000000000000000000 [current_design]