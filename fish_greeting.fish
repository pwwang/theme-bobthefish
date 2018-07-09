function fish_greeting -d "What's up, fish?"
  set_color $fish_color_autosuggestion
  uname -nmsr | string trim
  # uptime not available in cygwin
  if test type -q uptime
    uptime | string trim
  end
  set_color normal
end
