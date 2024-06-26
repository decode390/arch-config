from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import subprocess
import os

mod = "mod4"
terminal = guess_terminal()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
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
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]

def latest_group(qtile):
    qtile.current_screen.set_group(qtile.current_screen.previous_group)

# Customs
keys += [
    Key([mod], "e", lazy.spawn('rofi -show drun'), desc="Spawn rofi"),
    Key([mod], "p", lazy.spawn('rofi -show power-menu -modi power-menu:rofi-power-menu'), desc="Rofi power menu"),
    Key([mod], "s", lazy.function(latest_group)),
    Key([mod], "escape", lazy.spawn('slock'), desc="Lock screen"),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [
    Group("1"),
    Group("2", matches = [ Match(wm_class="firefox") ]),
    Group("3", matches = [ Match(wm_class="KeePassXC") ]),
    Group("4"),
    Group("5"),
    Group("6"),
    Group("7"),
    Group("8"),
    Group("9"),
]

for i in groups:
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )
    

layout_theme = {
    "border_focus":"#46d9ff",
    "border_normal":"#282c34",
    "border_width": 2,
    "margin": 5
}

layouts = [
    layout.Columns(**layout_theme),
    layout.Max(),
]

widget_defaults = dict(
    font="Hack Nerd Font",
    fontsize=13,
    padding=3,
)
extension_defaults = widget_defaults.copy()

default_spacer_widget = widget.Spacer(length=12)
                
screens = [
    Screen(
        top=bar.Bar(
            [
                default_spacer_widget,
                widget.Clock(
                    format="%H:%M - %d/%m/%Y ",
                    update_interval=60.0
                ),
                widget.Prompt(),
                widget.Spacer(),
                widget.GroupBox(
                    highlight_method="block",
                    padding=10,
                    this_current_screen_border='#312c4b',
                ),
                widget.Spacer(),
                #widget.Prompt(),
                #widget.WindowName(max_chars=60),
                widget.CurrentLayout(),
                default_spacer_widget,
                widget.CheckUpdates(
                    distro='Arch',
                    display_format='󰣇 {updates}',
                    no_update_string='󰣇 '
                ),
                default_spacer_widget,
                widget.CPU(format="󰘚 {load_percent}%"),
                default_spacer_widget,
                widget.Memory(format="{MemUsed: .0f}{mm} "),
                default_spacer_widget,
                widget.Battery(
                    format='{char}{percent:2.0%}',
                    charge_char='󰂄 ',
                    full_char='󰂄 ',
                    discharge_char='󰂀 ',
                    show_short_text=False
                ),
                default_spacer_widget,
                widget.Systray(icon_size = 13 ),
                default_spacer_widget,
            ],
            24,
            #margin=3,
            #opacity=0.9,
            border_width=3,
            border_color="#121117",
            padding=5,
            background="#121117"
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
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

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


# Customs
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')
    
    processes = [
        ['feh', '--bg-fill', '/usr/share/backgrounds/space.png'],
        ['picom', '-b'],
        ['xrandr', '--output', 'eDP-1', '--off'],
        ['volumeicon'],
        ["xidlehook","--not-when-audio","--not-when-fullscreen","--timer", "600", "slock", ""],
        ['setxkbmap', 'us', '-variant', 'intl'],
        #["xidlehook","--not-when-audio","--not-when-fullscreen","--timer", "20", "systemctl suspend", ""],
    ]
    
    for p in processes:
        subprocess.Popen(p)

