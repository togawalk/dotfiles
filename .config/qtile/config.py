##   IMPORTS   ##
import os
import subprocess
from libqtile import qtile
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.dgroups import simple_key_binder

##   VARIABLES   ##
mod = "mod4"
myTerm = "alacritty"      # My terminal of choice
myBrowser = "firefox" # My browser of choice

##   KEYBINDINGS   ##
keys = [
    Key([mod], "Return", lazy.spawn(myTerm), desc="Launches my terminal"),
    Key([mod, "shift"], "Return", lazy.spawn("dmenu_run -p Run:"), desc='Run Launcher'),
    Key(["control", "shift"], "e", lazy.spawn("emacsclient -c"), desc='Doom Emacs'),
    Key([mod], "b", lazy.spawn(myBrowser), desc='Launch firefox'),

    Key([mod, "shift"], "c", lazy.window.kill(), desc='Kill active window'),
    Key([mod, "shift"], "q", lazy.shutdown(), desc='Shutdown Qtile'),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),

    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.

    Key([mod], "h",
        lazy.layout.shrink(),
        lazy.layout.decrease_nmaster(),
        desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
        ),
    Key([mod], "l",
        lazy.layout.grow(),
        lazy.layout.increase_nmaster(),
        desc='Expand window (MonadTall), increase number in master pane (Tile)'
        ),
    Key([mod], "n",
        lazy.layout.normalize(),
        desc='normalize window size ratios'
        ),
    Key([mod], "m",
        lazy.layout.maximize(),
        desc='toggle window between minimum and maximum sizes'
        ),

    Key([mod, "shift"], "f",
        lazy.window.toggle_floating(),
        desc='toggle floating'
        ),
    Key([mod], "f",
        lazy.window.toggle_fullscreen(),
        desc='toggle fullscreen'
        ),

    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
#    Key(
#        [mod, "shift"],
#        "Return",
#        lazy.layout.toggle_split(),
#        desc="Toggle between split and unsplit sides of stack",
#    ),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    #Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]

colors = ["#002b36", "#073642", "#586e75", "#657b83", "#839496", "#93a1a1", "#eee8d5", "#fdf6e3",
          "#b58900", # Yellow
          "#cb4b16", # Orange
          "#dc322f", # Red
          "#d33682", # Magenta
          "#6c71c4", # Violet
          "#268bd2", # Blue
          "#2aa198", # Cyan
          "#859900", # Green
          "#000000"  # Black
          ]

colors2 = {
    "primaryColor": "#d79921",
    "secondaryColor": "#fabd2f",

    "primaryBlueColor": "#458588",
    "secondaryBlueColor": "#83a598",

    "primaryBackgroundColor": "#282828",
    "secondaryBackgroundColor": "#1d2021",

    "primaryWarningColor": "#cc241d",
    "secondaryWarningColor": "#fb4934",

    "textPrimaryColor": "#ebdbb2",
    "textSecondaryColor": "#fbf1c7",

}

##   WORKSPACES   ##
groups = [Group("1", label="dev", layout='max', matches=[Match(wm_class='emacs')]),
          Group("2", label="term", layout='monadtall', matches=[Match(wm_class='alacritty')]),
          Group("3", label="www", layout='max', matches=[Match(wm_class='firefox')]),
          Group("4", label="sys", layout='monadtall', matches=[Match(wm_class='nitrogen'), Match(wm_class='lxappearance')]),
          Group("5", label="vbox", layout='monadtall'),
          Group("6", label="chat", layout='stack', matches=[Match(wm_class='telegram-desktop')]),
          Group("7", label="mus", layout='monadtall'),
          Group("8", label="vid", layout='monadtall'),
          Group("9", label="gfx", layout='monadtall')]

dgroups_key_binder = simple_key_binder("mod4")

##   WINDOW STYLE IN LAYOUTS   ##
layout_theme = {
    "border_width": 3,
    "margin": 0,
    "border_focus": colors2["primaryBlueColor"],
    "border_normal": colors[1]
}

layouts = [
    layout.MonadTall(
        border_width=4,
        margin=10,
        border_focus=colors2["primaryBlueColor"],
        border_normal=colors[1]
    ),
    layout.Stack(
        border_width=4,
        border_focus=colors2["primaryBlueColor"],
        border_normal=colors[1],
    ),
    layout.Max(),
    layout.Floating(**layout_theme)
]

##   BAR   ##
widget_defaults = dict(
    font="Jetbrains Mono Bold",
    fontsize = 17,
    padding = 2,
    background = colors2["primaryBackgroundColor"],
    foreground = colors2["textPrimaryColor"],
)

extension_defaults = widget_defaults.copy()

def left_arrow(background_color, foreground_color):
    return widget.TextBox(
        text = '\uE0B2',
        background = background_color,
        foreground = foreground_color,
        fontsize = 35,
        padding = 0
    )

def right_arrow(background_color, foreground_color):
    return widget.TextBox(
        text = '\uE0B0',
        background = background_color,
        foreground = foreground_color,
        fontsize = 35,
        padding = 0
    )

def right_space(background = 0):
    if (background == 1):
        return widget.Spacer(
            length = 15,
            background = colors2["secondaryBackgroundColor"]
        )
    else:
        return widget.Spacer(
            length = 15,
        )


screens = [
    Screen(
        top = bar.Bar(
            [
                widget.TextBox(
                    font = "Jetbrains Mono Nerd",
                    text = "",
                    fontsize = 38,
                    padding = 20,
                    background = colors2["secondaryBackgroundColor"],
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm)}
                ),
                widget.GroupBox(
                    highlight_method = "line",
                    font = "Syne Mono",
                    fontsize = 22,
                    highlight_color = colors2["secondaryBackgroundColor"],
                    this_current_screen_border = colors[10], # border color
                    active = colors2["textPrimaryColor"],
                    inactive = colors2["textPrimaryColor"],
                    borderwidth = 4,
                    disable_drag = True,
                    hide_unused = True,
                    background = colors2["secondaryBackgroundColor"]
                ),
                right_arrow(colors2["primaryBackgroundColor"], colors2["secondaryBackgroundColor"]),
                widget.CurrentLayoutIcon(
                    padding = 3,
                    scale = 0.5
                ),
                widget.CurrentLayout(
                    foreground = colors2["primaryColor"],
                    padding = 0,
                    font = "Source Code Pro Medium"
                ),
                widget.WindowCount(
                    fmt = "<i>{}</i>",
                    padding = 10
                ),
                widget.Spacer(),
                widget.Clock(
                    format = "%H:%M"
                ),
                widget.Spacer(),
                left_arrow(colors2["primaryBackgroundColor"], colors2["secondaryBackgroundColor"]),
                widget.TextBox(
                    text = "<u>BTC</u>:",
                    background = colors2["secondaryBackgroundColor"],
                ),
                widget.CryptoTicker(
                    crypto = "BTC",
                    format = "{symbol}{amount:.0f}",
                    foreground = colors2["primaryColor"],
                    background = colors2["secondaryBackgroundColor"],
                ),
                right_space(1),
                left_arrow(colors2["secondaryBackgroundColor"], colors2["primaryBackgroundColor"]),
                widget.TextBox(
                    text = "<u>FREE</u>:",
                ),
                widget.DF(
                    foreground = colors2["primaryColor"],
                    visible_on_warn = False,
                    warn_color = colors2["primaryWarningColor"],
                    warn_space = 10,
                    format = "{uf}{m}"
                ),
                right_space(),
                left_arrow(colors2["primaryBackgroundColor"], colors2["secondaryBackgroundColor"]),
                widget.TextBox(
                    text = "<u>CPU</u>:",
                    background = colors2["secondaryBackgroundColor"],
                ),
                widget.CPU(
                    format = "{load_percent}%",
                    foreground = colors2["primaryColor"],
                    background = colors2["secondaryBackgroundColor"],
                ),
                right_space(1),
                left_arrow(colors2["secondaryBackgroundColor"], colors2["primaryBackgroundColor"]),
                widget.TextBox(
                    text = "<u>RAM</u>:",
                ),
                widget.Memory(
                    format = "{MemUsed:.0f} Mb",
                    measure_mem = "M",
                    foreground = colors2["primaryColor"],
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e btm')},
                ),
                right_space(),
                left_arrow(colors2["primaryBackgroundColor"], colors2["secondaryBackgroundColor"]),
                widget.TextBox(
                    background = colors2["secondaryBackgroundColor"],
                    text = "<u>TEMP</u>:",
                ),
                widget.OpenWeather(
                    location="Tyumen",
                    format = "{temp:.0f}º{units_temperature}",
                    foreground = colors2["primaryColor"],
                    background = colors2["secondaryBackgroundColor"],
                ),
                right_space(1),
                left_arrow(colors2["secondaryBackgroundColor"], colors2["primaryBackgroundColor"]),
                widget.TextBox(
                    text = "<u>DATE</u>:",
                ),
                widget.Clock(
                    format = "%d:%m:%Y",
                    foreground = colors2["primaryColor"],
                ),
                right_space(),
            ],
            38,
            border_width=[0, 0, 4, 0],  # Draw top and bottom borders
            border_color = colors2["primaryBlueColor"],  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(
    border_width=3,
    border_focus=colors[3],
    border_normal=colors[1],
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

wmname = "Qtile"
