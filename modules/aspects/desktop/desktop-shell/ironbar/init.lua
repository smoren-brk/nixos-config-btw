local Gio = require("lgi").Gio

local function toggle_bar(window)
    local revealer = window:get_child()
    if not Gtk.Revealer:is_type_of(revealer) then
        local bar = revealer
        revealer = Gtk.Revealer {
            valign = Gtk.Align.START,
            transition_type = Gtk.RevealerTransitionType.SLIDE_DOWN,
            transition_duration = 180,
            reveal_child = window:get_visible(),
        }
        window:set_child(nil)
        revealer:set_child(bar)
        window:set_child(revealer)

        -- Unmap the layer after the slide so Niri releases its reserved space.
        revealer.on_notify["child-revealed"] = function(widget)
            if not widget:get_reveal_child() and not widget:get_child_revealed() then
                widget:get_root():set_visible(false)
            end
        end
    end

    local show = not (window:get_visible() and revealer:get_reveal_child())
    if show then window:set_visible(true) end
    revealer:set_reveal_child(show)
end

local toggle = Gio.SimpleAction.new("toggle-bar", nil)
toggle.on_activate = function()
    for _, window in ipairs(Gtk.Window.list_toplevels()) do
        if window:get_name() == "top" then toggle_bar(window) end
    end
end
Gio.Application.get_default():add_action(toggle)
