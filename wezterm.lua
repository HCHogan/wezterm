local wezterm = require("wezterm")
local triple = wezterm.target_triple

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
-- local font_name = "RecMonoSmCasual Nerd Font Propo"
-- local font_name = "Quando"
-- local font_name = "Operator Mono"

local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "#000000"
custom.tab_bar.background = "#040404"
custom.tab_bar.inactive_tab.bg_color = "#0f0f0f"
custom.tab_bar.new_tab.bg_color = "#080808"

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")

local colors = {
  -- 通用
  background    = '#131313',
  foreground    = '#A3BE8C',
  cursor_bg     = '#A3BE8C',
  cursor_border = '#A3BE8C',
  cursor_fg     = '#131313',
  selection_bg  = '#8FBCBB',
  selection_fg  = '#131313',

  -- ANSI 8 色正常
  ansi          = {
    '#212121', -- noir_9 当作 Black
    '#BF616A', -- diagnostic_error 当作 Red
    '#A3BE8C', -- diff_add 当作 Green
    '#EBCB8B', -- diagnostic_warning 当作 Yellow
    '#8FBCBB', -- secondary 当作 Blue
    '#B48EAD', -- diagnostic_info 当作 Magenta
    '#D08770', -- diagnostic_hint 当作 Cyan
    '#D5D5D5', -- noir_2 当作 White
  },
  -- ANSI 8 色高亮
  brights       = {
    '#323232', -- noir_8 Bright Black
    '#BF616A', -- Red
    '#A3BE8C', -- Green
    '#EBCB8B', -- Yellow
    '#8FBCBB', -- Blue
    '#B48EAD', -- Magenta
    '#D08770', -- Cyan
    '#F5F5F5', -- noir_1 Bright White
  },

  -- 选项卡栏
  tab_bar       = {
    background = '#121212', -- 来自 minimal 预设的原始 background
    active_tab = {
      bg_color = '#131313',
      fg_color = '#A3BE8C',
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = '#212121',
      fg_color = '#737373', -- noir_6
    },
    inactive_tab_hover = {
      bg_color = '#323232', -- noir_8
      fg_color = '#949494', -- noir_5
    },
    new_tab = {
      bg_color = '#212121',
      fg_color = '#8FBCBB',
    },
    new_tab_hover = {
      bg_color = '#323232',
      fg_color = '#D08770',
    },
  },
};

local kanso = {
  foreground = "#C5C9C7",
  background = "#090E13",

  cursor_bg = "#090E13",
  cursor_fg = "#C5C9C7",
  cursor_border = "#C5C9C7",

  selection_fg = "#C5C9C7",
  selection_bg = "#24262D",

  scrollbar_thumb = "#24262D",
  split = "#24262D",

  ansi = {
    "#090E13",
    "#C4746E",
    "#8A9A7B",
    "#C4B28A",
    "#8BA4B0",
    "#A292A3",
    "#8EA4A2",
    "#A4A7A4",
  },
  brights = {
    "#A4A7A4",
    "#E46876",
    "#87A987",
    "#E6C384",
    "#7FB4CA",
    "#938AA9",
    "#7AA89F",
    "#C5C9C7",
  },
}

local config = {
  force_reverse_video_cursor = false,
  front_end = "WebGpu",
  -- front_end = "OpenGL",
  -- window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  native_macos_fullscreen_mode = true,

  color_schemes = {
    ["OLEDppuccin"] = custom,
    ["Noirbuddy"] = colors,
    ["Kanso"] = kanso,
  },

  color_scheme = "Kanso",
  initial_cols = 96,
  initial_rows = 32,

  -- Font config
  font = font_with_fallback(font_name),
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
    right = 0,
    top = 5,
    bottom = 0,
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

if triple == "aarch64-apple-darwin" then
  config.font_size = 15
  config.window_decorations = "RESIZE"
end

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
