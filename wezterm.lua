local wezterm = require("wezterm")

local function font_with_fallback(name, params)
  local names = { name, "FiraCode Nerd Font", "Apple Color Emoji", "azuki_font" }
  return wezterm.font_with_fallback(names, params)
end

-- local font_name = "CartographCF Nerd Font"
-- local font_name = "Fira Code iScript"
-- local font_name = "FiraCode Nerd Font"
-- local font_name = "Operator Mono Lig"
-- local font_name = "Fisa Code"
-- local font_name = "Cascadia Code"
local font_name = "Recursive"
-- local font_name = "Quando"
-- local font_name = "Operator Mono"

local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "#000000"
custom.tab_bar.background = "#040404"
custom.tab_bar.inactive_tab.bg_color = "#0f0f0f"
custom.tab_bar.new_tab.bg_color = "#080808"

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")

local config = {
  front_end = "WebGpu",
  -- front_end = "OpenGL",
  -- window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  window_decorations = "RESIZE | TITLE",
  native_macos_fullscreen_mode = true,

  color_schemes = {
    ["OLEDppuccin"] = custom,
  },

  color_scheme = "Catppuccin Mocha",
  initial_cols = 96,
  initial_rows = 32,

  -- Font config
  font = font_with_fallback(font_name),
  font_rules = {
    {
      italic = true,
      font = font_with_fallback(font_name, { italic = true, weight = "Regular" }),
    },
    {
      italic = false,
      -- font = font_with_fallback(font_name, { bold = false }),
      font = font_with_fallback(font_name, { italic = false, weight = "Regular" }),
    },
    {
      intensity = "Bold",
      font = font_with_fallback(font_name, { bold = true }),
    },
  },
  warn_about_missing_glyphs = false,
  font_size = 11.5,
  line_height = 1.0,
  -- dpi = 144,

  -- Cursor style
  default_cursor_style = "SteadyBar",
  cursor_blink_rate = 0,

  -- X11
  enable_wayland = true,

  -- Keybinds
  disable_default_key_bindings = true,
  keys = {
    {
      key = [[\]],
      mods = "CTRL|ALT",
      action = wezterm.action({
        SplitHorizontal = { domain = "CurrentPaneDomain" },
      }),
    },
    {
      key = [[\]],
      mods = "CTRL",
      action = wezterm.action({
        SplitVertical = { domain = "CurrentPaneDomain" },
      }),
    },
    {
      key = "q",
      mods = "CTRL",
      action = wezterm.action({ CloseCurrentPane = { confirm = false } }),
    },
    {
      key = "h",
      mods = "CTRL|SHIFT",
      action = wezterm.action({ ActivatePaneDirection = "Left" }),
    },
    {
      key = "l",
      mods = "CTRL|SHIFT",
      action = wezterm.action({ ActivatePaneDirection = "Right" }),
    },
    {
      key = "k",
      mods = "CTRL|SHIFT",
      action = wezterm.action({ ActivatePaneDirection = "Up" }),
    },
    {
      key = "j",
      mods = "CTRL|SHIFT",
      action = wezterm.action({ ActivatePaneDirection = "Down" }),
    },
    {
      key = "h",
      mods = "CTRL|SHIFT|ALT",
      action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }),
    },
    {
      key = "l",
      mods = "CTRL|SHIFT|ALT",
      action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }),
    },
    {
      key = "k",
      mods = "CTRL|SHIFT|ALT",
      action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }),
    },
    {
      key = "j",
      mods = "CTRL|SHIFT|ALT",
      action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }),
    },
    { -- browser-like bindings for tabbing
      key = "t",
      mods = "CTRL",
      action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
    },
    {
      key = "w",
      mods = "CTRL",
      action = wezterm.action({ CloseCurrentTab = { confirm = false } }),
    },
    {
      key = "Tab",
      mods = "CTRL",
      action = wezterm.action({ ActivateTabRelative = 1 }),
    },
    {
      key = "Tab",
      mods = "CTRL|SHIFT",
      action = wezterm.action({ ActivateTabRelative = -1 }),
    }, -- standard copy/paste bindings
    {
      key = "x",
      mods = "CTRL",
      action = "ActivateCopyMode",
    },
    {
      key = "v",
      mods = "CTRL|SHIFT",
      action = wezterm.action({ PasteFrom = "Clipboard" }),
    },
    {
      key = "c",
      mods = "CTRL|SHIFT",
      action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
    },
    {
      key = "n",
      mods = "CTRL|SHIFT",
      action = wezterm.action.ToggleFullScreen,
    },
  },

  -- Aesthetic Night Colorscheme
  bold_brightens_ansi_colors = true,
  -- Padding
  window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5,
  },

  -- Tab Bar
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  show_tab_index_in_tab_bar = false,
  use_fancy_tab_bar = true,
  tab_bar_at_bottom = true,

  -- General
  automatically_reload_config = true,
  inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
  window_background_opacity = 0.85,
  macos_window_background_blur = 40,
  window_close_confirmation = "NeverPrompt",
  window_frame = { active_titlebar_bg = "#45475a", font = font_with_fallback(font_name, { bold = true }) },
}

bar.apply_to_config(
  config,
  {
    modules = {
      pane = {
        enabled = false,
      }
    }
  }
)

return config
