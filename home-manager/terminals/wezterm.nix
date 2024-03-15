{pkgs, ...}:
###########################################################
#
# Wezterm Configuration
#
# Useful Hot Keys for Linux(replace `ctrl + shift` with `cmd` on macOS)):
#   1. Increase Font Size: `ctrl + shift + =` | `ctrl + shift + +`
#   2. Decrease Font Size: `ctrl + shift + -` | `ctrl + shift + _`
#   3. And Other common shortcuts such as Copy, Paste, Cursor Move, etc.
#
# Default Keybindings: https://wezfurlong.org/wezterm/config/default-keys.html
#
###########################################################
{
  # wezterm has catppuccin theme built-in,
  # it's not necessary to install it separately.

  # we can add wezterm as a flake input once this PR is merged:
  #    https://github.com/wez/wezterm/pull/3547

  programs.wezterm = {
    enable = true; # disable

    # TODO: Fix: https://github.com/wez/wezterm/issues/4483
    # package = pkgs.wezterm.override { };

    extraConfig = let
      fontsize =
        if pkgs.stdenv.isDarwin
        then "14.0"
        else "13.0";
    in ''
      -- Pull in the wezterm API
      local wezterm = require 'wezterm'

      -- This table will hold the configuration.
      local config = {}

      -- In newer versions of wezterm, use the config_builder which will
      -- help provide clearer error messages
      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      wezterm.on('toggle-opacity', function(window, pane)
        local overrides = window:get_config_overrides() or {}
        if not overrides.window_background_opacity then
          overrides.window_background_opacity = 0.93
        else
          overrides.window_background_opacity = nil
        end
        window:set_config_overrides(overrides)
      end)

      wezterm.on('toggle-maximize', function(window, pane)
        window:maximize()
      end)

      -- This is where you actually apply your config choices
      config.font = wezterm.font_with_fallback {
        "FiraCode Nerd Font",

        -- To avoid 'Chinese characters displayed as variant (Japanese) glyphs'
        --"Source Han Sans SC",
        --"Source Han Sans TC"
      }

      config.hide_tab_bar_if_only_one_tab = true
      config.scrollback_lines = 10000
      config.enable_scroll_bar = true
      config.term = 'wezterm'

      config.keys = {
        -- toggle opacity(CTRL + SHIFT + B)
        {
          key = 'B',
          mods = 'CTRL',
          action = wezterm.action.EmitEvent 'toggle-opacity',
        },
        {
          key = 'M',
          mods = 'CTRL',
          action = wezterm.action.EmitEvent 'toggle-maximize',
        },
      }
      config.font_size = ${fontsize}

      return config
    '';
  };
}
