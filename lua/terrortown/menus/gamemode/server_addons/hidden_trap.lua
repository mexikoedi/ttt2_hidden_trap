CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"
CLGAMEMODESUBMENU.priority = 0
CLGAMEMODESUBMENU.title = "submenu_addons_hidden_trap_title"
function CLGAMEMODESUBMENU:Populate(parent)
    local form = vgui.CreateTTT2Form(parent, "header_addons_hidden_trap")
    form:MakeCheckBox({
        serverConvar = "ttt2_hidden_trap_primary_sound",
        label = "label_hidden_trap_primary_sound"
    })

    form:MakeCheckBox({
        serverConvar = "ttt2_hidden_trap_secondary_sound",
        label = "label_hidden_trap_secondary_sound"
    })

    form:MakeCheckBox({
        serverConvar = "ttt2_hidden_trap_damage_sound",
        label = "label_hidden_trap_damage_sound"
    })

    form:MakeCheckBox({
        serverConvar = "ttt2_hidden_trap_damage_popup",
        label = "label_hidden_trap_damage_popup"
    })

    form:MakeSlider({
        serverConvar = "ttt2_hidden_trap_damage_popup_duration",
        label = "label_hidden_trap_damage_popup_duration",
        min = 0,
        max = 15,
        decimal = 0
    })

    form:MakeSlider({
        serverConvar = "ttt2_hidden_trap_damage",
        label = "label_hidden_trap_damage",
        min = 0,
        max = 200,
        decimal = 0
    })

    form:MakeSlider({
        serverConvar = "ttt2_hidden_trap_ammo",
        label = "label_hidden_trap_ammo",
        min = 0,
        max = 10,
        decimal = 0
    })

    form:MakeSlider({
        serverConvar = "ttt2_hidden_trap_clipSize",
        label = "label_hidden_trap_clipSize",
        min = 0,
        max = 10,
        decimal = 0
    })
end