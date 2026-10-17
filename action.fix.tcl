# action.fix.tcl  v4.0
#
# Tothwolf  25May1999: cleanup
# Tothwolf  04Oct1999: changed proc names slightly
# poptix    07Dec2001: handle irssi (and some others) "correct" messages for DCC CTCP
# MC_8      20Jul2002: fixed over trimming of \001's and stream lined both action
#                      types into 1 proc

# fix for mIRC dcc chat /me's
bind filt - "\001ACTION *\001" filt:dcc_action
bind filt - "CTCP_MESSAGE \001ACTION *\001" filt:dcc_action
proc filt:dcc_action {idx text} {
	regexp -- "^(?:CTCP_MESSAGE )?\001ACTION (.*?)\001\$" $text -> text
	return ".me $text"
}

# fix for telnet session /me's
bind filt - "/me *" filt:telnet_action
proc filt:telnet_action {idx text} {
	return ".me [join [lrange [split $text] 1 end]]"
}