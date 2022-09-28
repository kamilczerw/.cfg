local wezterm = require 'wezterm';
local act = wezterm.action;

wezterm.on("update-right-status", function(window, pane)
  local path = nil;
  local host = nil;

  -- Figure out the cwd and host of the current pane.
  -- This will pick up the hostname for the remote host if your
  -- shell is using OSC 7 on the remote host.
  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri then
    cwd_uri = cwd_uri:sub(8);
    local slash = cwd_uri:find("/")
    local cwd = ""
    local hostname = ""
    if slash then
      hostname = cwd_uri:sub(1, slash-1)
      -- Remove the domain name portion of the hostname
      local dot = hostname:find("[.]")
      if dot then
        hostname = hostname:sub(1, dot-1)
      end
      -- and extract the cwd from the uri
      cwd = cwd_uri:sub(slash)

      path = cwd;
      host = hostname;
    end
  end


  local success, sharship_status, err = wezterm.run_child_process({"sh", "/Users/kamilczerwinski/.wezterm/status.sh", path})


  local status = wezterm.format({
    {Attribute={Underline="Single"}},
    {Attribute={Italic=true}},
    {Text= sharship_status .. "   " .. string.format("%s path: %s", success, os.getenv("PATH"))},
  })
  window:set_right_status(status);
end);


return {
  debug_key_events = false,
  window_decorations = "RESIZE",
  tab_bar_at_bottom = true,

  font_size = 10.0,
  color_scheme = "Dracula",


  leader = { key="a", mods="CTRL", timeout_milliseconds=1000 },
  keys = {
    -- Tmux like pane switching
    { key = "h", mods="LEADER", action=act.ActivatePaneDirection("Left") },
    { key = "l", mods="LEADER", action=act.ActivatePaneDirection("Right") },
    { key = "k", mods="LEADER", action=act.ActivatePaneDirection("Up") },
    { key = "j", mods="LEADER", action=act.ActivatePaneDirection("Down") },

    -- Tmux like tab actions
    { key = "c", mods="LEADER", action=act.SpawnTab("CurrentPaneDomain") },
    { key = "n", mods="LEADER", action=act.ActivateTabRelative(1) },
    { key = "p", mods="LEADER", action=act.ActivateTabRelative(-1) },

    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    { key="LeftArrow", mods="OPT", action=wezterm.action{SendString="\x1bb"} },
    -- Make Option-Right equivalent to Alt-f; forward-word
    { key="RightArrow", mods="OPT", action=wezterm.action{SendString="\x1bf"} },

    { key="\\", mods="LEADER", action=wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"} },
    { key="-", mods="LEADER", action=wezterm.action.SplitVertical{domain="CurrentPaneDomain"} },
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    { key="a", mods="LEADER|CTRL", action=wezterm.action.SendString("\x01") },
  }
}
