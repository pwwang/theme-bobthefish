function __bobthefish_pretty_ms -S -a ms interval -d 'Millisecond formatting for humans'
	set -l interval_ms
	set -l scale 1
	set -l ret

	switch $interval
		case s
			set interval_ms 1000
		case m
			set interval_ms 60000
		case h
			set interval_ms 3600000
			set scale 2
	end

	switch $FISH_VERSION
		# Fish 2.3 and lower doesn't know about the -s argument to math.
		case 2.0.\* 2.1.\* 2.2.\* 2.3.\*
			set ret (math "scale=$scale;$ms/$interval_ms" | string replace -r '\\.?0*$' $interval)
		case \*
			set ret (math -s$scale "$ms/$interval_ms" | string replace -r '\\.?0*$' $interval)
	end
	echo -ns "$ret"
end

function __bobthefish_cmd_duration -S -d 'Show command duration'
	[ "$theme_display_cmd_duration" = "no" ]; and return
	[ -z "$CMD_DURATION" -o "$CMD_DURATION" -lt 100 ]; and return

	set -l ret

	if [ "$CMD_DURATION" -lt 5000 ]
		set ret (echo -ns $CMD_DURATION 'ms')
	else if [ "$CMD_DURATION" -lt 60000 ]
		set ret (__bobthefish_pretty_ms $CMD_DURATION s)
	else if [ "$CMD_DURATION" -lt 3600000 ]
		set ret (__bobthefish_pretty_ms $CMD_DURATION m)
	else
		set ret (__bobthefish_pretty_ms $CMD_DURATION h)
	end
	echo -n $ret
end

function __bobthefish_timestamp -S -d 'Show the current timestamp'
	[ "$theme_display_date" = "no" ]; and return
	set -q theme_date_format
		or set -l theme_date_format "+%c"

	echo -ns (date $theme_date_format) ' '
end
