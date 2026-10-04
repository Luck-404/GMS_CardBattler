//===============================================================================//
//
// CREATE: OBJ_GUI_CHEATS_PANE
// FUNCTION: Initializes the developer Cheats Menu.
//           Supports overworld and battle cheat layouts.
//           Defines menu, paging, targeting, and cheat-action helpers.
//
//===============================================================================//

//================//
//VARIABLES//
//================//
#region VARIABLES

_str_type = "CHEATS";

//================//
//DRAW ORDER//
//================//
// GameMaker's safe drawable depth range is -16000 to 16000.
// Keep Cheats in front of the project's -15000/-15001 transition/battle GUI
// layers without moving the instance outside the drawable range.
depth = -15100;

// Explicitly ensure the instance participates in Draw / Draw GUI events.
visible = true;

_str_mode = (room == rm_battle) ? "BATTLE" : "OVERWORLD";
_str_state = "MENU";

_str_tool = "";
_str_tool_label = "";
_str_tool_target_type = "";

_str_selected_id = "";

_ref_swap_first = undefined;

//================//
//CTRL TOOLTIPS//
//================//
_str_hover_tooltip_title = "";
_str_hover_tooltip_body = "";

_it_tab = 0;
_it_page = 0;

// Separate submenu state from page state.
// 0 = NONE
// 1 = STATUS
// 2 = MINION
_it_submenu = 0;

_flag_authenticated = false;
_flag_password_entry = false;

_str_password = "";
_str_password_correct = "TESTER";

_ct_input_lockout = 8;

_val_gui_width = display_get_gui_width();
_val_gui_height = display_get_gui_height();

//================//
//PANE LAYOUT//
//================//
_val_pane_x1 = 100;
_val_pane_y1 = 100;

_val_pane_x2 =
    _val_gui_width - 100;

_val_pane_y2 =
    _val_gui_height - 100;

_val_pane_w =
    _val_pane_x2 - _val_pane_x1;

_val_pane_h =
    _val_pane_y2 - _val_pane_y1;

//----------------//
//HEADER//
//----------------//
_val_header_h = 38;

//----------------//
//TABS//
//----------------//
_val_tab_h = 38;

_val_tab_y1 =
    _val_pane_y1 +
    _val_header_h;

_val_tab_y2 =
    _val_tab_y1 +
    _val_tab_h;

//----------------//
//FOOTER//
//----------------//
_val_footer_h = 34;

//----------------//
//CONTENT//
//----------------//
_val_content_x1 =
    _val_pane_x1 + 18;

_val_content_x2 =
    _val_pane_x2 - 18;

_val_content_y1 =
    _val_tab_y2 + 16;

_val_content_y2 =
    _val_pane_y2 -
    _val_footer_h -
    10;

_val_content_w =
    _val_content_x2 -
    _val_content_x1;

_val_content_h =
    _val_content_y2 -
    _val_content_y1;

_val_content_y =
    _val_content_y1;

//----------------//
//ROWS//
//----------------//
_val_row_h = 34;
_val_row_gap = 5;

_val_row_step =
    _val_row_h +
    _val_row_gap;

_ct_rows_per_page =
    max(
        1,
        floor(
            (
                _val_content_h -
                60
            ) /
            _val_row_step
        )
    );

_arr_tabs = [];

if (_str_mode == "BATTLE"){
    _arr_tabs = [
        "INTERACT",
        "EVENTS AND WEATHER",
        "HAND",
        "END BATTLE"
    ];
}
else{
    _arr_tabs = [
        "BEASTS",
        "CARDS",
        "ITEMS",
        "MISC"
    ];
}

//================//
//STATUS CATALOG//
//================//

// Target-hosted Statuses only.
// Excluded here: statuses that require a separate source Card, linked caster,
// Minion ownership, or global/team-only state instead of a target Beast.

_arr_cheat_dots = [
    "BLEED",
    "BURN",
    "FROSTBITE",
    "FROSTBURN",
    "POISON",
    "RAGE",
    "STORMSTRUCK",
    "VENOM"
];

_arr_cheat_cc = [
    "BANISH",
    "BLIND",
    "CONFUSED",
    "FROZEN",
    "SLEEP",
    "STUN"
];

_arr_cheat_debuffs = [
    "ANEMIA",
    "ANTIHEAL",
    "ARMORBREAK",
    "BLOODLET",
    "BRITTLE_CONSTITUTION",
    "CHAR",
    "CRIPPLING_VINES",
    "DRAINED",
    "FOCUS",
    "FROZEN_CURSE",
    "HEMOPHILIA",
    "MOLTEN_BRAND",
    "STATIC_RESONANCE",
    "UNSTABLE_COIL",
    "VULNERABLE",
    "WEAKNESS",
    "WHITEOUT",
    "WITHER"
];

_arr_cheat_buffs = [
    "ABYSSAL_FORM",
    "APEX_PREDATOR",
    "ARCTIC_FOCUS",
    "ARMOR_OVER_TIME",
    "BACKDRAFT",
    "BATTLE_FRENZY",
    "BOOST",
    "BURNING_PARRY",
    "BURNING_THORNS",
    "CALL_THE_DEEP",
    "CINDERGUARD",
    "CRIMSON_FOCUS",
    "DEEP_MOMENTUM",
    "DIVINE_PROTECTION",
    "ENDLESS_RAGE",
    "FLAMING_LASHES",
    "FROZEN_ARMOR",
    "FROZEN_PRECISION",
    "FROST_WEAPON",
    "FURNACE_HEART",
    "ICEBOUND_INSTINCT",
    "ICE_MIRROR",
    "IMMOVABLE",
    "INNER_FLAME",
    "LAST_STAND",
    "MALLEABILITY",
    "MELTING_ARMAMENTS",
    "MOLTEN_AEGIS",
    "NATURES_BOND",
    "OVERHEALTH",
    "PACK_INSTINCT",
    "PAIN_RESPONSE",
    "PERSISTENT_OVERHEALTH",
    "PHOENIX_REBIRTH",
    "PYRE_WEAPON",
    "RAZOR_SHELL",
    "REGENERATION",
    "RELENTLESS",
    "SAILORS_RESOLVE",
    "SECOND_LIFE",
    "SECOND_WIND",
    "STATIC_BARRIER",
    "TAUNT",
    "THORNS",
    "TOXIC_HIDE",
    "VERDANT_INSIGHT",
    "WILD_VIGOR"
];

_arr_cheat_auras = [
    "3RD_DEGREE",
    "BURGEONING_BLOOM",
    "CALM_SEAS",
    "FROSTFORM",
    "HONEYED_SCENT",
    "HUNGERING_FLAMES",
    "KRAKENS_CHOSEN",
    "ROUGH_SEAS"
];

_arr_cheat_globals = [
    "DRAW_2",
    "ECHO",
    "ENDLESS_BLOOM",
    "HEART_OF_THE_FOREST",
    "INFERNO_ETERNAL",
    "INSPIRATION",
    "MANAVINE",
    "MANA_SPRING",
    "PLAGUE_GARDEN"
];

_arr_cheat_weather = [
    "FIRESTORM",
    "HEATWAVE",
    "RAIN",
    "SEEDFALL",
    "SNOW",
    "STORMING"
];

_arr_cheat_events = [
    "BLOOD_MOON",
    "BLOODMIST",
    "BLOOMTIDE"
];

_arr_cheat_minions = [
    "ABYSSAL_HARPOON",
    "ANCHOR_STONE",
    "ASH_PHOENIX",
    "BLOOMING_SPRITE",
    "CINDERLING",
    "CORAL_GUARDIAN",
    "DORMANT_SEED",
    "EMBER_TURRET",
    "FLAMEGUARD",
    "FUNGI",
    "GROVE_SPIRIT",
    "ICE_WALL",
    "LIFE_SPIRIT",
    "LIVING_FLAME",
    "MAGMA_CANNON",
    "RIMEFROST_ELEMENTAL",
    "SERPENT",
    "SPORELING",
    "STORM_WISP",
    "TENTACLE",
    "THORNLING",
    "WASP_DRONE"
];

#endregion

//================//
//INIT//
//================//
#region INIT

if (
    variable_instance_exists(id,"_flag_open_authenticated") &&
    _flag_open_authenticated
){
    _flag_authenticated = true;
}
else{
    _flag_password_entry = true;
    keyboard_string = "";
}

global.ref_active_gui = id;

scr_debug_log(
    "GUI",
    "CHEATS",
    self,
    "CHEATS MENU INITIALIZED" +
    " | MODE: " + _str_mode +
    " | VISIBLE: " + (visible ? "YES" : "NO") +
    " | DEPTH: " + string(depth) +
    " | GUI: " +
    string(_val_gui_width) + "x" +
    string(_val_gui_height) +
    " | PANE: (" +
    string(_val_pane_x1) + "," +
    string(_val_pane_y1) + ")-(" +
    string(_val_pane_x2) + "," +
    string(_val_pane_y2) + ")",
    "INFO",
    "OBJ_GUI_CHEATS_PANE:CREATE"
);

#endregion

//================//
//METHODS//
//================//
#region METHODS

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_LOG
//-------------------------------------------------------------------------------//
hscr_cheats_log = function(_str_action,_str_details=""){

    scr_debug_log(
        "GUI",
        "CHEATS",
        self,
        string_upper(_str_action) +
        ((_str_details != "") ? " | " + _str_details : ""),
        "INFO",
        "OBJ_GUI_CHEATS_PANE"
    );
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_ERROR
//-------------------------------------------------------------------------------//
hscr_cheats_error = function(_str_action,_str_details=""){
    audio_play_sound(snd_gui_error,0,false);
    hscr_cheats_log(_str_action,_str_details);
    return false;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_POINT_IN_RECT
//-------------------------------------------------------------------------------//
hscr_cheats_point_in_rect = function(_mx,_my,_x1,_y1,_x2,_y2){

    return
        _mx >= _x1 &&
        _mx <= _x2 &&
        _my >= _y1 &&
        _my <= _y2;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_SET_HOVER_TOOLTIP
// FUNCTION: Stores the tooltip belonging to the currently hovered control.
//-------------------------------------------------------------------------------//
hscr_cheats_set_hover_tooltip = function(_str_title,_str_body){

    _str_hover_tooltip_title =
        string_upper(
            string_replace_all(
                string(_str_title),
                "_",
                " "
            )
        );

    _str_hover_tooltip_body =
        string(_str_body);
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_GET_STATUS_TOOLTIP
// FUNCTION: Returns concise mechanics text for every Status exposed by Cheats.
//-------------------------------------------------------------------------------//
hscr_cheats_get_status_tooltip = function(_str_status){

    switch (string_upper(_str_status)){

        case "BLEED":
            return "Deals damage equal to its Bleed stacks when Bleed resolves.";

        case "BURN":
            return "Deals damage per Burn stack when Burn resolves.";

        case "FROSTBITE":
            return "Per stack: -1 Max HP, PHYDEF, and MAGDEF. At START, deals 1 NEU damage per stack. Reductions restore when removed.";

        case "FROSTBURN":
            return "At START: destroys Armor, deals NEU damage, then removes the oldest cleansable positive effect.";

        case "POISON":
            return "Stacking poison damage. Uses the normal Poison scaling and lifetime.";

        case "RAGE":
            return "Resource DOT. +1 Linear damage per stack; at START takes 1 NEU per stack. Maximum 5 stacks; normal lifetime 5.";

        case "STORMSTRUCK":
            return "When the host acts: deals 2 NEU damage per stack, removes 1 stack, and refreshes lifetime.";

        case "VENOM":
            return "Stacking toxin. Uses the normal Venom thresholds/stat penalties and lifetime.";

        case "BANISH":
            return "Removes the Beast from active battle. It cannot act, be targeted, or trigger effects while Banished; hosted durations pause.";

        case "BLIND":
            return "Ordinary Attacks must target the front enemy. Flank/backline Attacks are blocked; Self/Teamwide/Global are unaffected.";

        case "CONFUSED":
            return "Hostile single-Beast cards have a 66% chance to retarget to another living Beast, including self.";

        case "FROZEN":
            return "Cannot act or reposition. Frozen grants immovability and applies Frostbite as its countdown advances.";

        case "SLEEP":
            return "Cannot act while asleep. Taking damage wakes the Beast; Sleep also uses its normal CON-based wane behavior.";

        case "STUN":
            return "Cannot act for the Status lifetime.";

        case "ANEMIA":
            return "Reduces PHYPOW for its normal duration.";

        case "ANTIHEAL":
            return "Prevents all healing.";

        case "ARMORBREAK":
            return "Immediately destroys 20% of current Armor and halves subsequent Armor gains while active.";

        case "BLOODLET":
            return "Applies the normal Bloodlet debuff effect and lifetime.";

        case "BRITTLE_CONSTITUTION":
            return "Reduces CON for its normal duration.";

        case "CHAR":
            return "-2 outgoing damage per stack. Permanent until removed by a valid effect.";

        case "CRIPPLING_VINES":
            return "Reduces PPOW for its normal duration.";

        case "DRAINED":
            return "Reduces MPOW for its normal duration.";

        case "FOCUS":
            return "Opposing Minions prioritize this Beast when selecting targets.";

        case "FROZEN_CURSE":
            return "When attacked while Frost-affected, takes additional NEU damage per stack.";

        case "HEMOPHILIA":
            return "When attacked, gains Bleed.";

        case "MOLTEN_BRAND":
            return "Increases Vermilion damage taken.";

        case "STATIC_RESONANCE":
            return "Gains 1 Stormstruck whenever this Beast is repositioned.";

        case "UNSTABLE_COIL":
            return "DISCHARGE spreads Stormstruck to all other allied Beasts instead of only adjacent allies.";

        case "VULNERABLE":
            return "Increases damage taken by its normal magnitude.";

        case "WEAKNESS":
            return "Reduces outgoing damage per stack.";

        case "WHITEOUT":
            return "Card casts have a chance to whiff while Whiteout is active.";

        case "WITHER":
            return "Reduces current and maximum HP.";

        case "ABYSSAL_FORM":
            return "+40 TO EVERY PRIMARY STAT: HP, CON, PPOW, MPOW, PDEF, MDEF, AND SPEED FOR 5 ROUNDS. ATTACKS RANDOMLY APPLY STUN, BANISH, OR STORMSTRUCK.";

        case "APEX_PREDATOR":
            return "Increases Linear damage using its normal Apex Predator scaling.";

        case "ARCTIC_FOCUS":
            return "Grants immunity to Crowd Control.";

        case "ARMOR_OVER_TIME":
            return "Grants Armor immediately and again at host END. Reapplication preserves the strongest magnitude/lifetime.";

        case "BACKDRAFT":
            return "The next incoming direct damage is split/reflected through Backdraft's normal damage-redirection effect.";

        case "BATTLE_FRENZY":
            return "The next Attack gains its normal damage-only repeat hits at reduced damage.";

        case "BOOST":
            return "Increases damage by its normal magnitude.";

        case "BURNING_PARRY":
            return "For its normal duration, blocks the next qualifying Melee hit and reflects physical damage.";

        case "BURNING_THORNS":
            return "The next enemy that directly damages this Beast gains 1 Burn.";

        case "CALL_THE_DEEP":
            return "The next direct damage effect gains its normal Call the Deep damage bonus.";

        case "CINDERGUARD":
            return "When an enemy Attack damages this Beast, consumes a charge to apply 1 Burn to the attacker.";

        case "CRIMSON_FOCUS":
            return "Increases Critical Hit Chance by its normal magnitude.";

        case "DEEP_MOMENTUM":
            return "Attacks generate 1 Mana while active.";

        case "DIVINE_PROTECTION":
            return "Each stack blocks one qualifying direct Attack damage instance.";

        case "ENDLESS_RAGE":
            return "Maintains protected Rage, increases damage/crit, doubles Rage self-damage, and prevents spending from reducing Rage.";

        case "FLAMING_LASHES":
            return "Attacks splash a percentage of damage to an adjacent enemy.";

        case "FROZEN_ARMOR":
            return "When struck, applies 1 Frostbite to the attacker.";

        case "FROZEN_PRECISION":
            return "Attacks ignore Dodge while active.";

        case "FROST_WEAPON":
            return "Attacks apply Frostbite.";

        case "FURNACE_HEART":
            return "Absorbs the next Magical direct damage instance and stores part of the prevented damage for the next Attack.";

        case "ICEBOUND_INSTINCT":
            return "Card-applied Crowd Control lasts 1 additional round.";

        case "ICE_MIRROR":
            return "When struck, gains Armor.";

        case "IMMOVABLE":
            return "Cannot be repositioned.";

        case "INNER_FLAME":
            return "The next Attack gains its normal bonus damage.";

        case "LAST_STAND":
            return "For its normal duration, fatal damage leaves the Beast at 5 HP, cleanses nonpermanent effects, and grants Rage.";

        case "MALLEABILITY":
            return "The next Card ignores caster requirements.";

        case "MELTING_ARMAMENTS":
            return "Attacks destroy additional Armor before damage.";

        case "MOLTEN_AEGIS":
            return "Each Attack applies 1 Burn and consumes one Molten Aegis charge.";

        case "NATURES_BOND":
            return "When healed, gains Armor per stack.";

        case "OVERHEALTH":
            return "Grants temporary Overhealth using the Status's normal amount/rules.";

        case "PACK_INSTINCT":
            return "Applies Pack Instinct's normal damage/Max-HP bonuses.";

        case "PAIN_RESPONSE":
            return "The first HP damage each round grants 1 Rage.";

        case "PERSISTENT_OVERHEALTH":
            return "Non-expiring Overhealth that remains until consumed by damage.";

        case "PHOENIX_REBIRTH":
            return "The next defeat revives the Beast, cleanses negative effects, and heals other allies.";

        case "PYRE_WEAPON":
            return "Attacks apply Burn.";

        case "RAZOR_SHELL":
            return "When struck, deals NEU damage back to the attacker.";

        case "REGENERATION":
            return "Heals HP at round START using its normal magnitude.";

        case "RELENTLESS":
            return "Cards cast through this Beast do not Exhaust.";

        case "SAILORS_RESOLVE":
            return "Increases healing received.";

        case "SECOND_LIFE":
            return "The next defeat restores a portion of Maximum HP instead of leaving the Beast defeated.";

        case "SECOND_WIND":
            return "The next Attack gains additional direct damage per stack.";

        case "STATIC_BARRIER":
            return "When struck, applies 1 Stormstruck to the attacker.";

        case "TAUNT":
            return "Newest Taunt controls hostile primary targeting. Ignores range/Blind and does not prevent AoE.";

        case "THORNS":
            return "Melee attackers take stored neutral retaliation damage.";

        case "TOXIC_HIDE":
            return "Melee attackers receive Poison.";

        case "VERDANT_INSIGHT":
            return "Increases MPOW by its normal magnitude.";

        case "WILD_VIGOR":
            return "Increases PPOW by its normal magnitude.";

        case "3RD_DEGREE":
            return "Aura: +25% outgoing damage and +15% incoming damage. Infinite until removed.";

        case "BURGEONING_BLOOM":
            return "Aura: reduces host Max HP and splashes a portion of healing received to adjacent allies.";

        case "CALM_SEAS":
            return "Team Aura: allies heal each round but deal less Linear damage.";

        case "FROSTFORM":
            return "Applies Frostform's persistent Aura/form effect using its normal mechanics.";

        case "HONEYED_SCENT":
            return "Team Aura: allied Attack casts summon Wasp Drones; the caster suffers the Aura's defensive drawback.";

        case "HUNGERING_FLAMES":
            return "Team Aura that scales its round-end healing from burning enemies.";

        case "KRAKENS_CHOSEN":
            return "Applies Kraken's Chosen team Aura using its normal trigger/effect rules.";

        case "ROUGH_SEAS":
            return "Team Aura: damaged enemies are randomly repositioned; allied Beasts take increased damage.";

        case "DRAW_2":
            return "Global Buff: upcoming draw events draw 2 additional cards per charge.";

        case "ECHO":
            return "Global Buff: the next eligible Card repeats once per Echo stack.";

        case "ENDLESS_BLOOM":
            return "Global Buff: allied Minion deaths/sacrifices create inherited Dormant Seeds.";

        case "HEART_OF_THE_FOREST":
            return "Global Buff: healing also grants Armor and grows hosted Minions.";

        case "INFERNO_ETERNAL":
            return "Global Buff: lowers ERUPTION thresholds while active.";

        case "INSPIRATION":
            return "Global Buff: increases Maximum Mana and grants current Mana on application.";

        case "MANAVINE":
            return "Global Buff: increases Maximum Mana and grants current Mana on application.";

        case "MANA_SPRING":
            return "Global Buff: increases Maximum Mana and grants current Mana on application.";

        case "PLAGUE_GARDEN":
            return "Global Buff: enemy Bleed, Poison, and Venom gains summon Sporelings.";

    }

    return "Applies " + string_upper(_str_status) + " using its normal Status mechanics, default magnitude, and default lifetime.";
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_GET_MINION_TOOLTIP
//-------------------------------------------------------------------------------//
hscr_cheats_get_minion_tooltip = function(_str_minion){

    switch (string_upper(_str_minion)){

        case "ABYSSAL_HARPOON":
            return "Spawn on clicked Beast. Attacks a preferred back-half enemy for amplified damage, then pulls it forward 1.";

        case "ANCHOR_STONE":
            return "Spawn on clicked Beast. Passive/defensive construct; uses Anchor Stone's normal hosted effect.";

        case "ASH_PHOENIX":
            return "Spawn on clicked Beast. Attacks for 3x Magnitude and applies Weakness for 1 round.";

        case "BLOOMING_SPRITE":
            return "Spawn on clicked Beast. Passive Viridian elemental; uses Blooming Sprite's normal hosted Buff effect.";

        case "CINDERLING":
            return "Spawn on clicked Beast. Deals Magnitude damage; also uses its normal Cinderling death effect.";

        case "CORAL_GUARDIAN":
            return "Spawn on clicked Beast. Each activation grants its host Armor equal to 2x Magnitude.";

        case "DORMANT_SEED":
            return "Spawn on clicked Beast. Ages during Minion phases and hatches after reaching its normal age threshold.";

        case "EMBER_TURRET":
            return "Spawn on clicked Beast. If target is Burning, deals 2x Magnitude damage; otherwise applies 1 Burn.";

        case "FLAMEGUARD":
            return "Spawn on clicked Beast. Passive Vermilion construct; uses Flameguard's normal hosted defensive effect.";

        case "FUNGI":
            return "Spawn on clicked Beast. On player team, draws cards based on Max HP; death also uses Fungi's normal Sleep effect.";

        case "GROVE_SPIRIT":
            return "Spawn on clicked Beast. Heals its host; at higher Max HP unlocks an attack and then Stun. Also grows from host Armor gains.";

        case "ICE_WALL":
            return "Spawn on clicked Beast. Passive Cerulean construct; uses Ice Wall's normal hosted defensive effect.";

        case "LIFE_SPIRIT":
            return "Spawn on clicked Beast. Heals its host for 2x Magnitude each activation.";

        case "LIVING_FLAME":
            return "Spawn on clicked Beast. Deals Magnitude damage, with bonus damage against armored targets.";

        case "MAGMA_CANNON":
            return "Spawn on clicked Beast. Deals Magnitude damage, gaining bonus damage against Burning targets.";

        case "RIMEFROST_ELEMENTAL":
            return "Spawn on clicked Beast. Applies Frostbite equal to its Magnitude.";

        case "SERPENT":
            return "Spawn on clicked Beast. Applies Venom equal to its Magnitude.";

        case "SPORELING":
            return "Spawn on clicked Beast. Uses Sporeling's normal Poison behavior and death/replacement effect.";

        case "STORM_WISP":
            return "Spawn on clicked Beast. Deals 3x Magnitude damage, then applies Stormstruck to an enemy with the highest current stacks.";

        case "TENTACLE":
            return "Spawn on clicked Beast. Deals Magnitude fixed damage to a random enemy.";

        case "THORNLING":
            return "Spawn on clicked Beast. Deals 2x Magnitude fixed damage to a random enemy.";

        case "WASP_DRONE":
            return "Spawn on clicked Beast. Damages one random enemy and applies Weakness to another valid enemy when possible.";

    }

    return "";
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_GET_TAB_TOOLTIP
//-------------------------------------------------------------------------------//
hscr_cheats_get_tab_tooltip = function(_str_tab){

    switch (string_upper(_str_tab)){

        case "BEASTS":
            return "Browse Beast entries, add Beasts to Party/Ranch, and edit current Party members.";

        case "CARDS":
            return "Browse Cards and add copies directly to the Deck or Card Library.";

        case "ITEMS":
            return "Browse Items and add them directly to Inventory.";

		case "MISC":
			return "Gold controls, encounter-start controls, player movement/unstuck tools, and visible wild-Beast spawning tools.";

        case "INTERACT":
            return "Targeted battle cheats: HP, damage, level, cleanse, Status application, and Minion spawning.";

        case "EVENTS AND WEATHER":
            return "Start/replace battle Weather or Event effects.";

        case "HAND":
            return "Draw, discard, or Exhaust player hand Cards.";

        case "END BATTLE":
            return "Force the current battle result to Win or Loss.";

    }

    return "Open this Cheats Menu section.";
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_GET_BUTTON_TOOLTIP
// FUNCTION: Resolves normal buttons, Status entries, Minions, Weather, Events,
//           and dynamic Gold buttons.
//-------------------------------------------------------------------------------//
hscr_cheats_get_button_tooltip = function(_str_text){

    var _str_upper =
        string_upper(
            string(_str_text)
        );

//================//
//STATUS ENTRY//
//================//
    var _it_colon =
        string_pos(
            ": ",
            _str_upper
        );

    if (_it_colon > 0){

        var _str_prefix =
            string_copy(
                _str_upper,
                1,
                _it_colon - 1
            );

        if (
            _str_prefix == "DOT" ||
            _str_prefix == "CC" ||
            _str_prefix == "DEBUFF" ||
            _str_prefix == "BUFF" ||
            _str_prefix == "AURA" ||
            _str_prefix == "GLOBAL"
        ){

            var _str_status =
                string_copy(
                    _str_upper,
                    _it_colon + 2,
                    string_length(_str_upper)
                );

            return
                hscr_cheats_get_status_tooltip(
                    _str_status
                );
        }
    }

//================//
//MINION ENTRY//
//================//
    var _str_minion_tooltip =
        hscr_cheats_get_minion_tooltip(
            _str_upper
        );

    if (_str_minion_tooltip != ""){
        return _str_minion_tooltip;
    }

//================//
//WEATHER//
//================//
    switch (_str_upper){
        case "FIRESTORM":
            return "Weather: end of round applies Burn to every living Beast. ERUPTION 10 consumes Burn, deals heavy NEU damage, and applies Char. Normal lifetime 5.";

        case "HEATWAVE":
            return "Weather: +25% Vermilion damage, Burn deals additional damage per stack, and the Char threshold is reduced. Normal lifetime 5.";

        case "RAIN":
            return "Weather: +25% Cerulean damage. End of round heals a random living Beast and cleanses a Debuff from a random living Beast. Normal lifetime 5.";

        case "SEEDFALL":
            return "Weather: +25% Viridian damage. End of round summons Dormant Seeds into open slots and hatches one random Seed. Normal lifetime 5.";

        case "SNOW":
            return "Weather: end of round applies Frostbite to unarmored Beasts; 3 Frostbite converts into Frostburn. Normal lifetime 5.";

        case "STORMING":
            return "Weather: end of round randomly repositions one Beast, then lightning damages two random Beasts and applies Stormstruck.";
    }

//================//
//EVENT//
//================//
    switch (_str_upper){
        case "BLOOD_MOON":
            return "Event: prevents healing. End of round grants Rage to living Beasts and grows their Minions; expiration applies Bloodlet. Normal lifetime 4.";

        case "BLOODMIST":
            return "Event: uses the current Bloodmist implementation and replaces any existing Event.";

        case "BLOOMTIDE":
            return "Event: end of round heals all living Beasts; excess healing becomes Persistent Overhealth. Replaces any existing Event.";
    }

//================//
//NORMAL BUTTON//
//================//
    switch (_str_upper){

        case "START EASY BATTLE":
            return "Starts an EASY encounter using the nearest encounter zone's Beast and loot pools.";

        case "START MEDIUM BATTLE":
            return "Starts a MEDIUM encounter using the nearest encounter zone's Beast and loot pools.";

        case "START HARD BATTLE":
            return "Starts a HARD encounter using the nearest encounter zone's Beast and loot pools.";

        case "START ELITE BATTLE":
            return "Elite encounters are not implemented yet.";

        case "TELEPORT RANCH":
            return "Teleports the player to the normal Ranch transition entry point.";

        case "ROOM CENTER":
            return "Teleports the player to the exact center of the current overworld room. Cheats stays open.";

        case "CLICK TELEPORT":
            return "Starts a world-position tool. Left-click repeatedly to teleport to visible world positions; right-click returns to Cheats.";	
		
        case "PARTY":
            return "Adds the displayed Beast directly to the active Party if space is available.";

        case "RANCH":
            return "Adds the displayed Beast directly to the Ranch.";

        case "+LV":
            return "Raises this Party Beast by 1 level using the normal Beast level update path.";

        case "-LV":
            return "Lowers this Party Beast by 1 level, respecting the normal level floor.";

        case "HEAL":
            return "Fully restores this Party Beast's HP.";

        case "TALENTS":
            return "Talent reset is not implemented yet; this button currently only reports an error.";

        case "ADD TO DECK":
            return "Adds one copy of the displayed Card directly to the player's Deck.";

        case "ADD TO LIBRARY":
            return "Adds/unlocks the displayed Card in the player's Card Library.";

        case "ADD TO INVENTORY":
            return "Adds the displayed Item directly to the player's Inventory.";

        case "SPAWN":
            return "Starts a world-position tool. Click a location to spawn the displayed wild Beast there.";

        case "RESURRECT":
            return "Target a defeated battle Beast and restore it using the Cheats resurrection path.";

        case "HEAL +1":
            return "Target a living battle Beast and restore 1 HP.";

        case "HEAL +10":
            return "Target a living battle Beast and restore 10 HP.";

        case "FULL HEAL":
            return "Target a living battle Beast and restore it to full HP.";

        case "DAMAGE -1":
            return "Target a living battle Beast and deal 1 direct cheat damage.";

        case "DAMAGE -10":
            return "Target a living battle Beast and deal 10 direct cheat damage.";

        case "KILL":
            return "Target a living battle Beast and reduce it to defeated state through the Cheats kill path.";

        case "SWAP":
            return "Select two living battle Beasts on the same team to swap their formation positions. Right-click exits the tool.";

        case "+1":
            return "Target a battle Beast and increase its level by 1.";

        case "+5":
            return "Target a battle Beast and increase its level by 5.";

        case "-1":
            return "Target a battle Beast and decrease its level by 1.";

        case "-5":
            return "Target a battle Beast and decrease its level by 5.";

        case "DOT -1":
            return "Target a Beast and remove 1 stack from one eligible DOT Status.";

        case "DOT ALL":
            return "Target a Beast and remove all eligible DOT Statuses.";

        case "DEBUFF 1":
            return "Target a Beast and remove 1 eligible Debuff Status.";

        case "DEBUFF ALL":
            return "Target a Beast and remove all eligible Debuff Statuses.";

        case "CC 1":
            return "Target a Beast and remove 1 eligible Crowd Control Status.";

        case "CC ALL":
            return "Target a Beast and remove all eligible Crowd Control Statuses.";

        case "AURA 1":
            return "Target a Beast and remove 1 eligible Aura Status.";

        case "AURA ALL":
            return "Target a Beast and remove all eligible Aura Statuses.";

        case "NEGATIVE ALL":
            return "Target a Beast and remove all eligible Debuff, DOT, and CC Statuses.";

        case "ALL":
            return "Target a Beast and remove all eligible Aura, Buff, CC, Debuff, and DOT Statuses.";

        case "STATUS TARGET":
            return "Opens the complete Status list. Choose a Status, then click a Beast to apply it.";

        case "SPAWN MINION":
            return "Opens the Minion list. Choose a Minion, then click a living Beast to host it.";

        case "CLOSE LIST":
            return "Closes the currently open Status or Minion list.";

        case "DRAW 1 CARD":
            return "Draws 1 Card using the normal battle draw pathway. Errors if no Card can be drawn.";

        case "DISCARD CARD":
            return "Starts a Card-target tool. Click a hand Card to discard it through the normal discard pathway.";

        case "EXHAUST CARD":
            return "Starts a Card-target tool. Click a hand Card to Exhaust it through the normal Exhaust pathway.";

        case "WIN":
            return "Immediately forces the current battle to resolve as a player victory.";

        case "LOSS":
            return "Immediately forces the current battle to resolve as a player loss.";
    }

//================//
//GOLD BUTTON//
//================//
    if (
        string_pos(
            " GP",
            _str_upper
        ) > 0
    ){
        return
            "Adds or removes the displayed Gold amount. Gold cannot be reduced below 0.";
    }

//================//
//FALLBACK//
//================//
    return
        "Activates the " +
        string_replace_all(
            _str_upper,
            "_",
            " "
        ) +
        " cheat action.";
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_DRAW_TOOLTIP
// FUNCTION: Draws the currently hovered control's tooltip while Ctrl is held.
//           Uses increased spacing for readability between tooltip lines,
//           title/body content, and the mouse cursor.
//-------------------------------------------------------------------------------//
hscr_cheats_draw_tooltip = function(){

    if (!keyboard_check(vk_control)){
        return;
    }

    if (_str_hover_tooltip_body == ""){
        return;
    }

    var _mx =
        device_mouse_x_to_gui(0);

    var _my =
        device_mouse_y_to_gui(0);

    var _val_gui_w =
        display_get_gui_width();

    var _val_gui_h =
        display_get_gui_height();

//================//
//TOOLTIP SPACING//
//================//
    var _val_line_sep = 8;
    var _val_title_gap = 11;
    var _val_mouse_offset = 22;

    var _val_panel_w =
        min(
            420,
            _val_gui_w - 24
        );

    var _val_pad =
        10;

    var _val_body_w =
        _val_panel_w -
        (_val_pad * 2);

    draw_set_font(
        fnt_gui_party_small
    );

    var _val_title_h =
        string_height(
            _str_hover_tooltip_title
        );

    var _val_body_h =
        string_height_ext(
            _str_hover_tooltip_body,
            _val_line_sep,
            _val_body_w
        );

    var _val_panel_h =
        _val_pad +
        _val_title_h +
        _val_title_gap +
        _val_body_h +
        _val_pad;

    var _val_x =
        _mx +
        _val_mouse_offset;

    var _val_y =
        _my +
        _val_mouse_offset;

//================//
//KEEP ON SCREEN//
//================//
    if (
        _val_x +
        _val_panel_w >
        _val_gui_w - 8
    ){
        _val_x =
            _mx -
            _val_panel_w -
            _val_mouse_offset;
    }

    if (
        _val_y +
        _val_panel_h >
        _val_gui_h - 8
    ){
        _val_y =
            _my -
            _val_panel_h -
            _val_mouse_offset;
    }

    _val_x =
        clamp(
            _val_x,
            8,
            _val_gui_w -
            _val_panel_w -
            8
        );

    _val_y =
        clamp(
            _val_y,
            8,
            _val_gui_h -
            _val_panel_h -
            8
        );

//================//
//PANEL//
//================//
    draw_set_alpha(0.96);

    draw_set_colour(c_black);

    draw_rectangle(
        _val_x,
        _val_y,
        _val_x +
        _val_panel_w,
        _val_y +
        _val_panel_h,
        false
    );

    draw_set_alpha(1);

    draw_set_colour(c_white);

    draw_rectangle(
        _val_x,
        _val_y,
        _val_x +
        _val_panel_w,
        _val_y +
        _val_panel_h,
        true
    );

//================//
//TITLE//
//================//
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_colour(c_yellow);

    draw_text(
        _val_x +
        _val_pad,
        _val_y +
        _val_pad,
        _str_hover_tooltip_title
    );

//================//
//BODY//
//================//
    draw_set_colour(c_white);

    draw_text_ext(
        _val_x +
        _val_pad,
        _val_y +
        _val_pad +
        _val_title_h +
        _val_title_gap,
        _str_hover_tooltip_body,
        _val_line_sep,
        _val_body_w
    );

//================//
//RESET//
//================//
    draw_set_alpha(1);
    draw_set_colour(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_BUTTON
// FUNCTION: Draws one cheat button and returns true when clicked.
//-------------------------------------------------------------------------------//
hscr_cheats_button = function(_str_text,_x1,_y1,_x2,_y2,_flag_enabled=true){

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    var _flag_pointer_hover =
        hscr_cheats_point_in_rect(
            _mx,
            _my,
            _x1,
            _y1,
            _x2,
            _y2
        );

    var _flag_hover =
        _flag_enabled &&
        _flag_pointer_hover;

    if (_flag_pointer_hover){

        hscr_cheats_set_hover_tooltip(
            _str_text,
            hscr_cheats_get_button_tooltip(
                _str_text
            )
        );
    }

    draw_set_colour(
        !_flag_enabled
        ? c_dkgray
        : (_flag_hover ? c_gray : global.c_dk_gray)
    );

    draw_rectangle(
        _x1,
        _y1,
        _x2,
        _y2,
        false
    );

    draw_set_colour(
        _flag_enabled
        ? c_white
        : c_gray
    );

    draw_rectangle(
        _x1,
        _y1,
        _x2,
        _y2,
        true
    );

    draw_set_font(fnt_gui_party_small);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_text(
        (_x1 + _x2) * 0.5,
        (_y1 + _y2) * 0.5,
        _str_text
    );

    return
        _flag_hover &&
        mouse_check_button_pressed(mb_left);
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_COLORED_BUTTON
// FUNCTION: Draws a color-coded cheat button and returns true when clicked.
//-------------------------------------------------------------------------------//
hscr_cheats_colored_button = function(
    _str_text,
    _x1,
    _y1,
    _x2,
    _y2,
    _str_color_group,
    _flag_enabled=true
){

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    var _flag_pointer_hover =
        hscr_cheats_point_in_rect(
            _mx,
            _my,
            _x1,
            _y1,
            _x2,
            _y2
        );

    var _flag_hover =
        _flag_enabled &&
        _flag_pointer_hover;

    if (_flag_pointer_hover){

        hscr_cheats_set_hover_tooltip(
            _str_text,
            hscr_cheats_get_button_tooltip(
                _str_text
            )
        );
    }

    var _c_background =
        hscr_cheats_get_color(
            _str_color_group
        );

    if (_flag_hover){
        _c_background =
            merge_colour(
                _c_background,
                c_white,
                0.25
            );
    }

    if (!_flag_enabled){
        _c_background = c_dkgray;
    }

    draw_set_colour(_c_background);
    draw_rectangle(_x1,_y1,_x2,_y2,false);

    draw_set_colour(
        _flag_enabled
        ? c_white
        : c_gray
    );

    draw_rectangle(_x1,_y1,_x2,_y2,true);

    draw_set_font(fnt_gui_party_small);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_set_colour(
        _flag_enabled
        ? c_black
        : c_gray
    );

    draw_text(
        (_x1 + _x2) * 0.5,
        (_y1 + _y2) * 0.5,
        _str_text
    );

    return
        _flag_hover &&
        mouse_check_button_pressed(mb_left);
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_GET_COLOR
//-------------------------------------------------------------------------------//
hscr_cheats_get_color = function(_str_color){

    switch (string_upper(_str_color)){
        case "VIRIDIAN":  return make_colour_rgb(45,150,70);
        case "VERMILION": return make_colour_rgb(190,55,55);
        case "CERULEAN":   return make_colour_rgb(90,175,235);
        case "UNCOLORED":  return make_colour_rgb(120,120,120);
    }

    return make_colour_rgb(120,120,120);
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_GET_ENTRY_COLOR
// FUNCTION: Supports Logbook entries and raw Beast/Card structs.
//-------------------------------------------------------------------------------//
hscr_cheats_get_entry_color = function(_entry){

    if (!is_struct(_entry)){
        return "UNCOLORED";
    }

    if (
        variable_struct_exists(_entry,"_str_color_group") &&
        _entry._str_color_group != undefined
    ){
        return string_upper(_entry._str_color_group);
    }

    if (
        variable_struct_exists(_entry,"_stct_beast_info") &&
        is_struct(_entry._stct_beast_info)
    ){
        var _stct_beast = _entry._stct_beast_info;
        if (
            variable_struct_exists(_stct_beast,"_arr_beast_colors") &&
            is_array(_stct_beast._arr_beast_colors) &&
            array_length(_stct_beast._arr_beast_colors) > 0 &&
            _stct_beast._arr_beast_colors[0] != undefined
        ){
            return string_upper(_stct_beast._arr_beast_colors[0]);
        }
    }

    if (
        variable_struct_exists(_entry,"_stct_card_info") &&
        is_struct(_entry._stct_card_info)
    ){
        var _stct_card = _entry._stct_card_info;
        if (
            variable_struct_exists(_stct_card,"_arr_card_colors") &&
            is_array(_stct_card._arr_card_colors) &&
            array_length(_stct_card._arr_card_colors) > 0 &&
            _stct_card._arr_card_colors[0] != undefined
        ){
            return string_upper(_stct_card._arr_card_colors[0]);
        }
    }

    if (
        variable_struct_exists(_entry,"_arr_beast_colors") &&
        is_array(_entry._arr_beast_colors) &&
        array_length(_entry._arr_beast_colors) > 0 &&
        _entry._arr_beast_colors[0] != undefined
    ){
        return string_upper(_entry._arr_beast_colors[0]);
    }

    if (
        variable_struct_exists(_entry,"_arr_card_colors") &&
        is_array(_entry._arr_card_colors) &&
        array_length(_entry._arr_card_colors) > 0 &&
        _entry._arr_card_colors[0] != undefined
    ){
        return string_upper(_entry._arr_card_colors[0]);
    }

    return "UNCOLORED";
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_GET_STATUS_COLOR_GROUP
// FUNCTION: Color-specific Statuses use their BeastCards color.
//           Generic and cross-color Statuses use UNCOLORED grey.
//-------------------------------------------------------------------------------//
hscr_cheats_get_status_color_group = function(
    _str_category,
    _str_status
){

    _str_status = string_upper(_str_status);

//================//
//VERMILION//
//================//
    switch (_str_status){

        case "3RD_DEGREE":
        case "ANEMIA":
        case "BACKDRAFT":
        case "BATTLE_FRENZY":
        case "BLOODLET":
        case "BURN":
        case "BURNING_PARRY":
        case "BURNING_THORNS":
        case "CHAR":
        case "CINDERGUARD":
        case "CONFUSED":
        case "ENDLESS_RAGE":
        case "FLAMING_LASHES":
        case "FURNACE_HEART":
        case "HEMOPHILIA":
        case "HUNGERING_FLAMES":
        case "INFERNO_ETERNAL":
        case "INNER_FLAME":
        case "LAST_STAND":
        case "MELTING_ARMAMENTS":
        case "MOLTEN_AEGIS":
        case "MOLTEN_BRAND":
        case "PAIN_RESPONSE":
        case "PHOENIX_REBIRTH":
        case "PYRE_WEAPON":
        case "RAGE":
        case "RELENTLESS":
            return "VERMILION";
    }

//================//
//CERULEAN//
//================//
    switch (_str_status){

        case "ABYSSAL_FORM":
        case "ARCTIC_FOCUS":
        case "BANISH":
        case "BRITTLE_CONSTITUTION":
        case "CALL_THE_DEEP":
        case "CALM_SEAS":
        case "CRIMSON_FOCUS":
        case "DEEP_MOMENTUM":
        case "DIVINE_PROTECTION":
        case "FROSTBITE":
        case "FROSTBURN":
        case "FROSTFORM":
        case "FROZEN":
        case "FROZEN_ARMOR":
        case "FROZEN_CURSE":
        case "FROZEN_PRECISION":
        case "FROST_WEAPON":
        case "ICEBOUND_INSTINCT":
        case "ICE_MIRROR":
        case "IMMOVABLE":
        case "KRAKENS_CHOSEN":
        case "MANA_SPRING":
        case "RAZOR_SHELL":
        case "ROUGH_SEAS":
        case "SAILORS_RESOLVE":
        case "SECOND_WIND":
        case "STATIC_BARRIER":
        case "STATIC_RESONANCE":
        case "STORMSTRUCK":
        case "UNSTABLE_COIL":
        case "WHITEOUT":
            return "CERULEAN";
    }

//================//
//VIRIDIAN//
//================//
    switch (_str_status){

        case "APEX_PREDATOR":
        case "BOOST":
        case "BURGEONING_BLOOM":
        case "CRIPPLING_VINES":
        case "DRAINED":
        case "ENDLESS_BLOOM":
        case "HEART_OF_THE_FOREST":
        case "MANAVINE":
        case "PLAGUE_GARDEN":
        case "HONEYED_SCENT":
        case "NATURES_BOND":
        case "PACK_INSTINCT":
        case "POISON":
        case "REGENERATION":
        case "SLEEP":
        case "THORNS":
        case "TOXIC_HIDE":
        case "VENOM":
        case "VERDANT_INSIGHT":
        case "WILD_VIGOR":
        case "WITHER":
            return "VIRIDIAN";
    }

    return "UNCOLORED";
};


//-------------------------------------------------------------------------------//
// HSCR_CHEATS_GET_MINION_COLOR_GROUP
//-------------------------------------------------------------------------------//
hscr_cheats_get_minion_color_group = function(_str_minion){

    switch (string_upper(_str_minion)){

        case "ASH_PHOENIX":
        case "CINDERLING":
        case "EMBER_TURRET":
        case "FLAMEGUARD":
        case "LIVING_FLAME":
        case "MAGMA_CANNON":
            return "VERMILION";

        case "ABYSSAL_HARPOON":
        case "ANCHOR_STONE":
        case "CORAL_GUARDIAN":
        case "ICE_WALL":
        case "RIMEFROST_ELEMENTAL":
        case "STORM_WISP":
        case "TENTACLE":
            return "CERULEAN";

        case "BLOOMING_SPRITE":
        case "DORMANT_SEED":
        case "FUNGI":
        case "GROVE_SPIRIT":
        case "LIFE_SPIRIT":
        case "SERPENT":
        case "SPORELING":
        case "THORNLING":
        case "WASP_DRONE":
            return "VIRIDIAN";
    }

    return "UNCOLORED";
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_GET_ITEM_COLOR
//-------------------------------------------------------------------------------//
hscr_cheats_get_item_color = function(_str_item_type){
    switch (string_upper(_str_item_type)){
        case "QUEST": return c_yellow;
        case "CONSUMABLE": return c_green;
        case "MATERIAL": return make_colour_rgb(184,156,110);
        case "PRISM": return c_aqua;
        case "HELD": return make_colour_rgb(255,140,0);
        case "EGG": return make_colour_rgb(180,100,255);
    }
    return global.c_dk_gray;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_GET_MAX_PAGE
//-------------------------------------------------------------------------------//
hscr_cheats_get_max_page = function(_ct_entries,_ct_rows){
    if (_ct_rows <= 0){
        return 0;
    }
    return max(0,ceil(_ct_entries / _ct_rows) - 1);
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_SET_PAGE
// FUNCTION: Changes the current Cheats page within the supplied page bounds.
//           Reaching the first/last page is intentionally silent.
//-------------------------------------------------------------------------------//
hscr_cheats_set_page = function(
    _it_new_page,
    _it_max_page
){

    var _it_old_page =
        _it_page;

    _it_page =
        clamp(
            _it_new_page,
            0,
            max(
                0,
                _it_max_page
            )
        );

    if (
        _it_page !=
        _it_old_page
    ){

        hscr_cheats_log(
            "PAGE CHANGED",
            "PAGE: " +
            string(
                _it_page + 1
            ) +
            "/" +
            string(
                _it_max_page + 1
            )
        );

        return true;
    }

//================//
//PAGE LIMIT//
//================//
// Intentionally silent.
// W/S, arrows, and mouse wheel can continue being used
// against the first/last page without playing an error.
    return false;
};
//-------------------------------------------------------------------------------//
// HSCR_CHEATS_CHANGE_TAB
//-------------------------------------------------------------------------------//
hscr_cheats_change_tab = function(_val_direction){

    if (!_flag_authenticated || _str_state != "MENU"){
        return false;
    }

    _it_tab += _val_direction;

    if (_it_tab < 0){
        _it_tab = array_length(_arr_tabs) - 1;
    }

    if (_it_tab >= array_length(_arr_tabs)){
        _it_tab = 0;
    }

    _it_page = 0;
    _it_submenu = 0;

    audio_play_sound(snd_gui_press,0,false);

    hscr_cheats_log(
        "TAB CHANGED",
        "TAB: " + _arr_tabs[_it_tab]
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_START_TOOL
//-------------------------------------------------------------------------------//
hscr_cheats_start_tool = function(
    _str_new_tool,
    _str_new_label,
    _str_new_target_type,
    _str_id=""
){

    _str_state = "TOOL";

    _str_tool = _str_new_tool;
    _str_tool_label = _str_new_label;
    _str_tool_target_type = _str_new_target_type;

    _str_selected_id = _str_id;

    _ref_swap_first = undefined;

    hscr_cheats_log(
        "TOOL START",
        "TOOL: " + string_upper(_str_tool) +
        " | TARGET: " + string_upper(_str_tool_target_type) +
        ((_str_selected_id != "")
            ? " | ID: " + string_upper(_str_selected_id)
            : "")
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_CANCEL_TOOL
//-------------------------------------------------------------------------------//
hscr_cheats_cancel_tool = function(){

    if (_str_state != "TOOL"){
        return false;
    }

    var _str_old_tool = _str_tool;

    _str_state = "MENU";
    _str_tool = "";
    _str_tool_label = "";
    _str_tool_target_type = "";
    _str_selected_id = "";

    _ref_swap_first = undefined;

    audio_play_sound(snd_gui_close,0,false);

    hscr_cheats_log(
        "TOOL CANCEL",
        "TOOL: " + string_upper(_str_old_tool)
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_SUBMIT_PASSWORD
//-------------------------------------------------------------------------------//
hscr_cheats_submit_password = function(){

    _str_password = keyboard_string;

    if (string_upper(_str_password) == _str_password_correct){

        _flag_authenticated = true;
        _flag_password_entry = false;

        keyboard_string = "";

        audio_play_sound(snd_gui_press,0,false);

        hscr_cheats_log("AUTHENTICATION SUCCESS");

        return true;
    }

    audio_play_sound(snd_gui_error,0,false);

    keyboard_string = "";
    _str_password = "";

    hscr_cheats_log("AUTHENTICATION FAILED");

    return false;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_ADD_BEAST
// FUNCTION: Creates a fully initialized Beast and adds it to Party or Ranch.
//           PARTY automatically routes to Ranch if the Party is full.
//-------------------------------------------------------------------------------//
hscr_cheats_add_beast = function(
    _str_beast_id,
    _str_destination
){

//================//
//INITIALIZE BEAST//
//================//
    var _stct_beast =
        scr_beast_init_random(
            _str_beast_id
        );

    if (!is_struct(_stct_beast)){

        audio_play_sound(
            snd_gui_error,
            0,
            false
        );

        hscr_cheats_log(
            "BEAST ADD FAILED",
            "BEAST: " +
            string_upper(
                _str_beast_id
            ) +
            " | REASON: INITIALIZATION FAILED"
        );

        return false;
    }

//================//
//PARTY//
//================//
    if (_str_destination == "PARTY"){

        var _flag_added =
            scr_party_add_beast(
                _stct_beast
            );

        if (!_flag_added){

            audio_play_sound(
                snd_gui_error,
                0,
                false
            );

            hscr_cheats_log(
                "BEAST ADD FAILED",
                "BEAST: " +
                string_upper(
                    _str_beast_id
                ) +
                " | REQUESTED: PARTY"
            );

            return false;
        }

//----------------//
//RANCH DUMMY//
//----------------//
        if (
            room == rm_ow_ranch &&
            instance_exists(
                obj_ranch_interactable
            ) &&
            ds_exists(
                global.list_player_ranch,
                ds_type_list
            ) &&
            ds_list_find_index(
                global.list_player_ranch,
                _stct_beast
            ) != -1
        ){

            obj_ranch_interactable
                .hscr_ranch_spawn_beast_dummy(
                    _stct_beast
                );
        }

//----------------//
//SOUND//
//----------------//
        audio_play_sound(
            snd_gui_press,
            0,
            false
        );

//----------------//
//DEBUG//
//----------------//
        var _str_actual_destination =
            (
                ds_exists(
                    global.list_player_party,
                    ds_type_list
                ) &&
                ds_list_find_index(
                    global.list_player_party,
                    _stct_beast
                ) != -1
            )
            ? "PARTY"
            : "RANCH";

        hscr_cheats_log(
            "BEAST ADDED",
            "BEAST: " +
            string_upper(
                _str_beast_id
            ) +
            " | REQUESTED: PARTY" +
            " | DESTINATION: " +
            _str_actual_destination +
            " | TYPE: " +
            string_upper(
                _stct_beast
                    ._str_beast_color_type
            ) +
            " | LEVEL: " +
            string(
                _stct_beast
                    ._val_beast_level
            ) +
            " | UID: " +
            string(
                _stct_beast
                    ._uid_beast
            )
        );

        return true;
    }

//================//
//RANCH//
//================//
    if (_str_destination == "RANCH"){

        if (
            !variable_global_exists(
                "list_player_ranch"
            ) ||
            !ds_exists(
                global.list_player_ranch,
                ds_type_list
            )
        ){

            audio_play_sound(
                snd_gui_error,
                0,
                false
            );

            hscr_cheats_log(
                "BEAST ADD FAILED",
                "BEAST: " +
                string_upper(
                    _str_beast_id
                ) +
                " | DESTINATION: RANCH" +
                " | REASON: RANCH LIST INVALID"
            );

            return false;
        }

//----------------//
//ADD TO RANCH//
//----------------//
        ds_list_add(
            global.list_player_ranch,
            _stct_beast
        );

//----------------//
//LOGBOOK//
//----------------//
        if (
            variable_global_exists(
                "map_logbook_beasts"
            ) &&
            ds_exists(
                global.map_logbook_beasts,
                ds_type_map
            )
        ){

            scr_logbook_mark_beast_captured(
                _stct_beast
                    ._str_beast_name
            );
        }

//----------------//
//RANCH DUMMY//
//----------------//
        if (
            room == rm_ow_ranch &&
            instance_exists(
                obj_ranch_interactable
            )
        ){

            obj_ranch_interactable
                .hscr_ranch_spawn_beast_dummy(
                    _stct_beast
                );
        }

//----------------//
//SOUND//
//----------------//
        audio_play_sound(
            snd_gui_press,
            0,
            false
        );

//----------------//
//DEBUG//
//----------------//
        hscr_cheats_log(
            "BEAST ADDED",
            "BEAST: " +
            string_upper(
                _str_beast_id
            ) +
            " | DESTINATION: RANCH" +
            " | TYPE: " +
            string_upper(
                _stct_beast
                    ._str_beast_color_type
            ) +
            " | LEVEL: " +
            string(
                _stct_beast
                    ._val_beast_level
            ) +
            " | UID: " +
            string(
                _stct_beast
                    ._uid_beast
            )
        );

        return true;
    }

//================//
//INVALID DESTINATION//
//================//
    audio_play_sound(
        snd_gui_error,
        0,
        false
    );

    hscr_cheats_log(
        "BEAST ADD FAILED",
        "BEAST: " +
        string_upper(
            _str_beast_id
        ) +
        " | INVALID DESTINATION: " +
        string_upper(
            _str_destination
        )
    );

    return false;
};

//===============================================================================//
//
// LOCAL METHOD REPLACEMENT: HSCR_CHEATS_ADD_CARD
// FUNCTION: Adds a Card to Deck or Library from Cheats.
//           Uses SCR_DECK_GET_MAX_SIZE instead of a hard-coded Deck cap.
//
// INSTALL: Replace the existing HSCR_CHEATS_ADD_CARD local method inside the
//          current Cheats GUI Create event.
//
//===============================================================================//

hscr_cheats_add_card = function(_str_card_id,_str_destination){

	var _stct_card =
		scr_card_get_info(
			_str_card_id
		);

	if (
		!is_struct(_stct_card) ||
		_stct_card._str_card_name ==
			"DEFAULT"
	){
		return false;
	}

	if (_str_destination == "DECK"){

		if (
			ds_list_size(
				global.list_player_deck
			) >=
			scr_deck_get_max_size()
		){

			audio_play_sound(
				snd_gui_error,
				0,
				false
			);

			return false;
		}

		ds_list_add(
			global.list_player_deck,
			_stct_card
		);
	}
	else{

		ds_list_add(
			global.list_player_library,
			_stct_card
		);
	}

	if (
		variable_global_exists(
			"map_logbook_cards"
		) &&
		ds_exists(
			global.map_logbook_cards,
			ds_type_map
		)
	){

		scr_logbook_mark_card_obtained(
			_str_card_id
		);
	}

	audio_play_sound(
		snd_battle_card_move,
		0,
		false
	);

	hscr_cheats_log(
		"CARD ADDED",
		"CARD: " +
		_str_card_id +
		" | DESTINATION: " +
		_str_destination
	);

	return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_ADD_ITEM
//-------------------------------------------------------------------------------//
hscr_cheats_add_item = function(_str_item_id){

    var _stct_item =
        scr_inventory_get_item_info(_str_item_id);

    if (_stct_item == undefined){
        return false;
    }

    scr_inventory_add_item(
        _str_item_id,
        1
    );

    audio_play_sound(snd_gui_press,0,false);

    hscr_cheats_log(
        "ITEM ADDED",
        "ITEM: " + _str_item_id
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_PARTY_LEVEL
//-------------------------------------------------------------------------------//
hscr_cheats_party_level = function(_stct_beast,_val_change){

    if (!is_struct(_stct_beast)){
        return hscr_cheats_error("PARTY LEVEL FAILED","INVALID BEAST");
    }

    var _val_old = _stct_beast._val_beast_level;
    var _val_new = clamp(_val_old + _val_change,1,30);

    if (_val_new == _val_old){
        return hscr_cheats_error(
            "PARTY LEVEL CAPPED",
            "BEAST: " + string_upper(_stct_beast._str_beast_name) +
            " | LEVEL: " + string(_val_old)
        );
    }

    scr_beast_set_level(_stct_beast,_val_new,false);
    audio_play_sound(snd_gui_press,0,false);

    hscr_cheats_log(
        "PARTY LEVEL CHANGED",
        "BEAST: " + string_upper(_stct_beast._str_beast_name) +
        " | LEVEL: " + string(_val_old) + " -> " + string(_val_new)
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_PARTY_HEAL
//-------------------------------------------------------------------------------//
hscr_cheats_party_heal = function(_stct_beast){

    if (!is_struct(_stct_beast)){
        return hscr_cheats_error("PARTY HEAL FAILED","INVALID BEAST");
    }

    if (_stct_beast._val_beast_hp_cur >= _stct_beast._val_beast_hp_max){
        return hscr_cheats_error(
            "PARTY HEAL CAPPED",
            "BEAST: " + string_upper(_stct_beast._str_beast_name) + " | HP ALREADY FULL"
        );
    }

    _stct_beast._val_beast_hp_cur = _stct_beast._val_beast_hp_max;
    audio_play_sound(snd_battle_heal,0,false);

    hscr_cheats_log("PARTY HEALED","BEAST: " + string_upper(_stct_beast._str_beast_name));
    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_GET_BATTLE_TARGET
// FUNCTION: Returns Beast or Minion under mouse.
//-------------------------------------------------------------------------------//
hscr_cheats_get_battle_target = function(_flag_allow_dead=true){

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    var _ref_minion =
        instance_position(
            _mx,
            _my,
            obj_battle_minion
        );

    if (instance_exists(_ref_minion)){
        return _ref_minion;
    }

    var _ref_beast =
        instance_position(
            _mx,
            _my,
            obj_battle_beast
        );

    if (!instance_exists(_ref_beast)){
        return undefined;
    }

    if (
        !_flag_allow_dead &&
        _ref_beast._val_cur_hp <= 0
    ){
        return undefined;
    }

    return _ref_beast;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_BATTLE_HEAL
//-------------------------------------------------------------------------------//
hscr_cheats_battle_heal = function(_ref_target,_val_amount){

    if (!instance_exists(_ref_target)){
        return hscr_cheats_error("TARGET HEAL FAILED","INVALID TARGET");
    }

    if (_ref_target._val_cur_hp <= 0){
        return hscr_cheats_error("TARGET HEAL FAILED","TARGET IS DEAD");
    }

    if (_ref_target._val_cur_hp >= _ref_target._val_max_hp){
        return hscr_cheats_error("TARGET HEAL CAPPED","HP ALREADY FULL");
    }

    var _val_before = _ref_target._val_cur_hp;

    if (_val_amount == -1){
        _ref_target._val_cur_hp = _ref_target._val_max_hp;
    }
    else{
        _ref_target._val_cur_hp = min(_ref_target._val_max_hp,_ref_target._val_cur_hp + _val_amount);
    }

    audio_play_sound(snd_battle_heal,0,false);
    hscr_cheats_log("TARGET HEALED","HP: " + string(_val_before) + " -> " + string(_ref_target._val_cur_hp));
    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_BATTLE_DAMAGE
// FUNCTION: Applies direct Cheat damage to one living battle Beast.
//           Lethal Cheat damage immediately routes through the Beast's normal
//           death handler so formation, graveyard, Status, Minion, Trap, and
//           battle-end state remain synchronized.
//-------------------------------------------------------------------------------//
hscr_cheats_battle_damage = function(_ref_target,_val_amount){

	//================//
	//VALIDATE TARGET//
	//================//
	if (!instance_exists(_ref_target)){
		return hscr_cheats_error(
			"TARGET DAMAGE FAILED",
			"INVALID TARGET"
		);
	}

	if (_ref_target._val_cur_hp <= 0){
		return hscr_cheats_error(
			"TARGET DAMAGE CAPPED",
			"TARGET IS ALREADY DEAD"
		);
	}

	//================//
	//SNAPSHOT TARGET//
	//================//
	var _val_before =
		_ref_target._val_cur_hp;

	var _str_team =
		string_upper(_ref_target._str_team);

	var _str_beast_name =
		"UNKNOWN";

	if (
		variable_instance_exists(
			_ref_target,
			"_ref_unit"
		) &&
		is_struct(_ref_target._ref_unit) &&
		variable_struct_exists(
			_ref_target._ref_unit,
			"_str_beast_name"
		)
	){
		_str_beast_name =
			string_upper(
				_ref_target._ref_unit._str_beast_name
			);
	}

	//================//
	//APPLY DAMAGE//
	//================//
	if (_val_amount == -1){

		_ref_target._val_cur_hp = 0;
	}
	else{

		_ref_target._val_cur_hp =
			max(
				0,
				_ref_target._val_cur_hp -
				_val_amount
			);
	}

	audio_play_sound(
		snd_battle_hit_neu,
		0,
		false
	);

	//================//
	//DEBUG CHEAT//
	//================//
	hscr_cheats_log(
		"TARGET DAMAGED",
		"TARGET: " +
		_str_team + " " +
		_str_beast_name +
		" | HP: " +
		string(_val_before) +
		" -> " +
		string(_ref_target._val_cur_hp)
	);

	//================//
	//HANDLE DEATH//
	//================//
	if (_ref_target._val_cur_hp <= 0){

		if (
			variable_instance_exists(
				_ref_target,
				"hscr_battle_handle_death"
			) &&
			is_callable(
				_ref_target.hscr_battle_handle_death
			)
		){

			_ref_target.hscr_battle_handle_death();
		}
		else{

			return hscr_cheats_error(
				"TARGET DEATH FAILED",
				"TARGET: " +
				_str_team + " " +
				_str_beast_name +
				" | NORMAL DEATH HANDLER MISSING"
			);
		}
	}

	return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_RESURRECT
//-------------------------------------------------------------------------------//
hscr_cheats_resurrect = function(_ref_target){

    if (!instance_exists(_ref_target)){
        return hscr_cheats_error("RESURRECT FAILED","INVALID TARGET");
    }

    if (!variable_instance_exists(_ref_target,"_str_list")){
        return hscr_cheats_error("RESURRECT FAILED","TARGET CANNOT BE RESURRECTED");
    }

    if (_ref_target._str_list != "DEAD" || _ref_target._val_cur_hp > 0){
        return hscr_cheats_error("RESURRECT CAPPED","TARGET IS ALREADY ALIVE");
    }

    var _ref_controller = (_ref_target._str_team == "PLAYER") ? obj_battle_player_controller : obj_battle_enemy_controller;
    if (!instance_exists(_ref_controller)){
        return hscr_cheats_error("RESURRECT FAILED","MISSING TEAM CONTROLLER");
    }

    var _it_dead = ds_list_find_index(_ref_controller._list_beasts_graveyard,_ref_target);
    if (_it_dead != -1){
        ds_list_delete(_ref_controller._list_beasts_graveyard,_it_dead);
    }

    if (ds_list_find_index(_ref_controller._list_beasts_alive,_ref_target) == -1){
        ds_list_add(_ref_controller._list_beasts_alive,_ref_target);
    }

    _ref_target._val_cur_hp = max(1,ceil(_ref_target._val_max_hp * 0.25));
    _ref_target._str_list = "ALIVE";
    _ref_target._flag_death_handled = false;
    _ref_target._flag_corpse_consumed = false;

    scr_battle_refresh_formation(_ref_target._str_team);
    audio_play_sound(snd_battle_heal,0,false);

    hscr_cheats_log("TARGET RESURRECTED","TEAM: " + _ref_target._str_team);
    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_BATTLE_LEVEL
// FUNCTION: Changes one battle Beast's Level and refreshes OUTLEVELED disparity.
//-------------------------------------------------------------------------------//

hscr_cheats_battle_level = function(_ref_target,_val_change){

//================//
//VALIDATE TARGET//
//================//

    if (!instance_exists(_ref_target)){
        return hscr_cheats_error(
            "TARGET LEVEL FAILED",
            "INVALID TARGET"
        );
    }

    if (!is_struct(_ref_target._ref_unit)){
        return hscr_cheats_error(
            "TARGET LEVEL FAILED",
            "TARGET HAS NO BEAST STRUCT"
        );
    }

//================//
//GET NEW LEVEL//
//================//

    var _val_old_level =
        _ref_target._ref_unit._val_beast_level;

    var _val_new_level =
        clamp(
            _val_old_level +
            _val_change,
            1,
            30
        );

    if (_val_new_level == _val_old_level){

        return hscr_cheats_error(
            "TARGET LEVEL CAPPED",
            "LEVEL: " +
            string(_val_old_level)
        );
    }

//================================//
//TEMPORARILY REMOVE OUTLEVELED//
//================================//

    var _ref_outleveled =
        scr_status_check(
            "OUTLEVELED",
            _ref_target
        );

    if (
        _ref_outleveled != -1 &&
        instance_exists(_ref_outleveled)
    ){

        scr_status_buff_outleveled(
            "SET",
            _ref_outleveled,
            0
        );
    }

//================//
//STORE HP RATIO//
//================//

    var _val_ratio =
        clamp(
            _ref_target._val_cur_hp /
            max(
                1,
                _ref_target._val_max_hp
            ),
            0,
            1
        );

//================//
//CHANGE LEVEL//
//================//

    scr_beast_set_level(
        _ref_target._ref_unit,
        _val_new_level,
        false
    );

//================//
//SYNC RUNTIME HP//
//================//

    _ref_target._val_max_hp =
        _ref_target._ref_unit._val_beast_hp_max;

    _ref_target._val_cur_hp =
        clamp(
            ceil(
                _ref_target._val_max_hp *
                _val_ratio
            ),
            0,
            _ref_target._val_max_hp
        );

    _ref_target._ref_unit._val_beast_hp_cur =
        _ref_target._val_cur_hp;

//=======================//
//REFRESH LEVEL DISPARITY//
//=======================//

    scr_battle_refresh_outleveled();

//================================//
//REFRESH PRE-BATTLE INITIATIVE//
//================================//

    if (
        instance_exists(obj_battle_turn_controller) &&
        !obj_battle_turn_controller._flag_started_game
    ){

        obj_battle_turn_controller.hscr_battle_set_initial_turn_order();

        if (instance_exists(obj_gui_battle_start_pane)){

            obj_gui_battle_start_pane._val_player_avg_speed =
                obj_battle_turn_controller._val_player_opening_speed;

            obj_gui_battle_start_pane._val_enemy_avg_speed =
                obj_battle_turn_controller._val_enemy_opening_speed;

            obj_gui_battle_start_pane._str_first_team =
                obj_battle_turn_controller._str_opening_team;
        }
    }

//================//
//FEEDBACK//
//================//

    audio_play_sound(
        snd_gui_press,
        0,
        false
    );

    hscr_cheats_log(
        "TARGET LEVEL CHANGED",
        "LEVEL: " +
        string(_val_old_level) +
        " -> " +
        string(_val_new_level)
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_APPLY_GLOBAL_STATUS
// FUNCTION: Applies one GLOBAL Status using the clicked Beast as team/caster
//           context where the Status requires it.
//
//           The resulting Status remains registered in global.list_statuses.
//           The clicked Beast is context only, not the Status host.
//-------------------------------------------------------------------------------//
hscr_cheats_apply_global_status = function(
    _ref_context,
    _str_status
){

//================//
//VALIDATE CONTEXT//
//================//
    if (!instance_exists(_ref_context)){
        return hscr_cheats_error(
            "GLOBAL STATUS APPLY FAILED",
            "INVALID CONTEXT BEAST"
        );
    }

    if (!is_struct(_ref_context._ref_unit)){
        return hscr_cheats_error(
            "GLOBAL STATUS APPLY FAILED",
            "INVALID BEAST CONTEXT"
        );
    }

    if (_ref_context._val_cur_hp <= 0){
        return hscr_cheats_error(
            "GLOBAL STATUS APPLY FAILED",
            "CONTEXT BEAST IS DEAD"
        );
    }

//================//
//SAVE CONTEXT//
//================//
    var _flag_had_caster =
        variable_global_exists(
            "ref_caster_beast"
        );

    var _flag_had_target =
        variable_global_exists(
            "ref_target_beast"
        );

    var _ref_previous_caster =
        undefined;

    var _ref_previous_target =
        undefined;

    if (_flag_had_caster){
        _ref_previous_caster =
            global.ref_caster_beast;
    }

    if (_flag_had_target){
        _ref_previous_target =
            global.ref_target_beast;
    }

//================//
//SET CONTEXT//
//================//
    global.ref_caster_beast =
        _ref_context;

    global.ref_target_beast =
        _ref_context;

    _str_status =
        string_upper(
            _str_status
        );

    var _ref_status =
        undefined;

//================//
//APPLY GLOBAL//
//================//
    switch (_str_status){

        case "DRAW_2":

            _ref_status =
                scr_status_buff_draw_2(
                    "APPLY",
                    undefined,
                    1,
                    _ref_context
                );

        break;

        case "ECHO":

            _ref_status =
                scr_status_buff_echo(
                    "APPLY",
                    undefined,
                    1
                );

        break;

        case "ENDLESS_BLOOM":

            _ref_status =
                scr_status_buff_endless_bloom(
                    "APPLY",
                    undefined,
                    undefined,
                    5,
                    _ref_context
                );

        break;

        case "HEART_OF_THE_FOREST":

            _ref_status =
                scr_status_buff_heart_of_the_forest(
                    "APPLY",
                    undefined,
                    undefined,
                    5,
                    _ref_context
                );

        break;

        case "INFERNO_ETERNAL":

            _ref_status =
                scr_status_buff_inferno_eternal(
                    "APPLY",
                    undefined,
                    2,
                    5,
                    _ref_context
                );

        break;

        case "INSPIRATION":

		_ref_status =
			scr_status_buff_inspiration(
				"APPLY",
				undefined,
				2,
				3,
				_ref_context
			);
			
        break;

        case "MANAVINE":

            _ref_status =
                scr_status_buff_manavine(
                    "APPLY",
                    undefined,
                    1,
                    3,
                    _ref_context
                );

        break;

        case "MANA_SPRING":

            _ref_status =
                scr_status_buff_mana_spring(
                    "APPLY",
                    undefined,
                    2,
                    3,
                    _ref_context
                );

        break;

        case "PLAGUE_GARDEN":

            _ref_status =
                scr_status_buff_plague_garden(
                    "APPLY",
                    undefined,
                    undefined,
                    5,
                    _ref_context
                );

        break;
    }

//================//
//RESTORE CONTEXT//
//================//
    global.ref_caster_beast =
        _ref_previous_caster;

    global.ref_target_beast =
        _ref_previous_target;

//================//
//VALIDATE RESULT//
//================//
    if (!instance_exists(_ref_status)){

        return hscr_cheats_error(
            "GLOBAL STATUS APPLY FAILED",
            "STATUS: " +
            _str_status +
            " | CONTEXT TEAM: " +
            string_upper(
                _ref_context._str_team
            )
        );
    }

//================//
//SOUND//
//================//
    audio_play_sound(
        snd_gui_press,
        0,
        false
    );

//================//
//DEBUG//
//================//
    hscr_cheats_log(
        "GLOBAL STATUS APPLIED",
        "STATUS: " +
        _str_status +
        " | CONTEXT TEAM: " +
        string_upper(
            _ref_context._str_team
        ) +
        " | STACKS: " +
        string(
            _ref_status._ct_status_stacks
        )
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_APPLY_STATUS
// FUNCTION: Applies one Status application to the clicked Beast.
//           DOT / CC / Debuff cheat applications bypass CON resistance.
//
//           RAGE remains a DOT-type Status, but is granted through
//           SCR_STATUS_GAIN_RAGE exactly like normal Rage-generator cards.
//-------------------------------------------------------------------------------//
hscr_cheats_apply_status = function(
    _ref_target,
    _str_category,
    _str_status
){

//================//
//VALIDATE TARGET//
//================//
    if (!instance_exists(_ref_target)){
        return hscr_cheats_error(
            "STATUS APPLY FAILED",
            "INVALID TARGET"
        );
    }

    if (!is_struct(_ref_target._ref_unit)){
        return hscr_cheats_error(
            "STATUS APPLY FAILED",
            "TARGET DOES NOT SUPPORT BEAST STATUSES"
        );
    }

    if (_ref_target._val_cur_hp <= 0){
        return hscr_cheats_error(
            "STATUS APPLY FAILED",
            "TARGET IS DEAD"
        );
    }

//================//
//NORMALIZE//
//================//
    _str_category =
        string_upper(
            _str_category
        );

    _str_status =
        string_upper(
            _str_status
        );

//================//
//GLOBAL//
//================//
    if (_str_category == "GLOBAL"){

        return hscr_cheats_apply_global_status(
            _ref_target,
            _str_status
        );
    }

//================//
//APPLY//
//================//
    var _ref_status =
        undefined;

    switch (_str_category){

        case "DOT":

            if (_str_status == "RAGE"){

                _ref_status =
                    scr_status_gain_rage(
                        _ref_target,
                        1
                    );
            }
            else{

                _ref_status =
                    scr_status_apply_dot(
                        _str_status,
                        _ref_target,
                        undefined,
                        true,
                        true
                    );
            }

        break;

        case "CC":

            _ref_status =
                scr_status_apply_cc(
                    _str_status,
                    _ref_target,
                    undefined,
                    true
                );

        break;

        case "DEBUFF":

            _ref_status =
                scr_status_apply_debuff(
                    _str_status,
                    _ref_target,
                    undefined,
                    undefined,
                    true
                );

        break;

        case "BUFF":

//----------------//
//ABYSSAL FORM//
//----------------//
// Abyssal Form's own APPLY defaults are magnitude 40 / lifetime 5.
// Do not override its magnitude with the generic Cheat value of 1.
            if (_str_status == "ABYSSAL_FORM"){

                _ref_status =
                    scr_status_apply_buff(
                        _str_status,
                        _ref_target,
                        undefined,
                        undefined
                    );
            }

//----------------//
//OTHER BUFFS//
//----------------//
            else{

                _ref_status =
                    scr_status_apply_buff(
                        _str_status,
                        _ref_target,
                        1,
                        undefined
                    );
            }

        break;

        case "AURA":

            _ref_status =
                scr_status_apply_aura(
                    _str_status,
                    _ref_target,
                    0
                );

        break;
    }

//================//
//VALIDATE RESULT//
//================//
    if (!instance_exists(_ref_status)){

        return hscr_cheats_error(
            "STATUS APPLY FAILED",
            "CATEGORY: " +
            _str_category +
            " | STATUS: " +
            _str_status
        );
    }

//================//
//SOUND//
//================//
    audio_play_sound(
        snd_gui_press,
        0,
        false
    );

//================//
//DEBUG//
//================//
    hscr_cheats_log(
        "STATUS APPLIED",
        "CATEGORY: " +
        _str_category +
        " | STATUS: " +
        _str_status +
        " | STACKS: " +
        string(
            _ref_status._ct_status_stacks
        )
    );

    return true;
};
//-------------------------------------------------------------------------------//
// HSCR_CHEATS_CLEANSE
//-------------------------------------------------------------------------------//
hscr_cheats_cleanse = function(
    _ref_target,
    _str_filter,
    _str_mode,
    _var_amount
){

    if (!instance_exists(_ref_target)){
        return false;
    }

    if (!variable_instance_exists(_ref_target,"_list_statuses")){
        return false;
    }

    var _stct_result =
        scr_status_cleanse(
            _ref_target,
            _str_filter,
            _var_amount,
            {
                _str_mode: _str_mode,
                _flag_ignore_uncleansable: false,
                _flag_show_popups: true,
                _flag_force_vfx: true
            }
        );

    if (
        _stct_result._ct_statuses_removed <= 0 &&
        _stct_result._ct_stacks_removed <= 0
    ){
        return hscr_cheats_error("TARGET CLEANSE CAPPED","NOTHING MATCHING TO CLEANSE");
    }

    audio_play_sound(snd_battle_heal,0,false);

    hscr_cheats_log(
        "TARGET CLEANSED",
        "FILTER: " + _str_filter +
        " | STATUSES: " +
        string(_stct_result._ct_statuses_removed) +
        " | STACKS: " +
        string(_stct_result._ct_stacks_removed)
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_SPAWN_MINION
//-------------------------------------------------------------------------------//
hscr_cheats_spawn_minion = function(
    _ref_target,
    _str_minion
){

    if (!instance_exists(_ref_target)){
        return false;
    }

    if (!is_struct(_ref_target._ref_unit)){
        return false;
    }

    var _ref_minion =
        scr_minion_init(
            _str_minion,
            undefined,
            undefined,
            _ref_target
        );

    if (!instance_exists(_ref_minion)){
        return hscr_cheats_error("MINION SPAWN FAILED","MINION: " + _str_minion);
    }

    audio_play_sound(snd_battle_minion_spawn,0,false);

    hscr_cheats_log(
        "MINION SPAWNED",
        "MINION: " + _str_minion
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_MOVE_HAND_CARD
// FUNCTION: Moves one selected player Hand Card directly to Discard or Exhaust
//           using the normal shared battle Card-flow implementation.
//-------------------------------------------------------------------------------//
hscr_cheats_move_hand_card = function(
    _ref_card,
    _str_destination
){

//================//
//VALIDATE CARD//
//================//
    if (
        !instance_exists(
            _ref_card
        )
    ){

        return hscr_cheats_error(
            "CARD MOVE FAILED",
            "INVALID CARD"
        );
    }

    if (
        !is_struct(
            _ref_card._ref_card
        )
    ){

        return hscr_cheats_error(
            "CARD MOVE FAILED",
            "CARD HAS NO CARD STRUCT"
        );
    }

//================//
//VALIDATE HAND CARD//
//================//
    if (
        _ref_card._str_team != "PLAYER" ||
        _ref_card._str_location != "HAND"
    ){

        return hscr_cheats_error(
            "CARD MOVE FAILED",
            "TARGET IS NOT A PLAYER HAND CARD"
        );
    }

//================//
//VALIDATE CONTROLLER//
//================//
    if (
        !instance_exists(
            obj_battle_player_controller
        )
    ){

        return hscr_cheats_error(
            "CARD MOVE FAILED",
            "PLAYER BATTLE CONTROLLER MISSING"
        );
    }

    if (
        !ds_exists(
            obj_battle_player_controller
                ._list_battle_hand,
            ds_type_list
        )
    ){

        return hscr_cheats_error(
            "CARD MOVE FAILED",
            "PLAYER HAND INVALID"
        );
    }

    if (
        ds_list_find_index(
            obj_battle_player_controller
                ._list_battle_hand,
            _ref_card
        ) == -1
    ){

        return hscr_cheats_error(
            "CARD MOVE FAILED",
            "CARD NOT FOUND IN PLAYER HAND"
        );
    }

//================//
//CARD NAME//
//================//
    var _str_card_name =
        string_upper(
            _ref_card
                ._ref_card
                ._str_card_name
        );

//================//
//MOVE CARD//
//================//
    var _flag_moved =
        false;

    switch (
        string_upper(
            _str_destination
        )
    ){

//----------------//
//DISCARD//
//----------------//
        case "DISCARD":

            _flag_moved =
                scr_battle_discard_card(
                    _ref_card
                );

        break;

//----------------//
//EXHAUST//
//----------------//
        case "EXHAUST":

            _flag_moved =
                scr_battle_exhaust_card(
                    _ref_card
                );

        break;

//----------------//
//INVALID//
//----------------//
        default:

            return hscr_cheats_error(
                "CARD MOVE FAILED",
                "INVALID DESTINATION: " +
                string_upper(
                    _str_destination
                )
            );
    }

//================//
//VALIDATE MOVE//
//================//
    if (!_flag_moved){

        return hscr_cheats_error(
            "CARD MOVE FAILED",
            "CARD: " +
            _str_card_name +
            " | DESTINATION: " +
            string_upper(
                _str_destination
            )
        );
    }

//================//
//SOUND//
//================//
    audio_play_sound(
        snd_battle_card_move,
        0,
        false
    );

//================//
//DEBUG//
//================//
    hscr_cheats_log(
        "HAND CARD MOVED",
        "CARD: " +
        _str_card_name +
        " | DESTINATION: " +
        string_upper(
            _str_destination
        )
    );

    return true;
};

//===============================================================================//
//
// REPLACE: HSCR_CHEATS_SPAWN_WILD
// FUNCTION: Spawns a fully initialized visible wild Beast at the exact
//           world-space mouse position.
//
//===============================================================================//

hscr_cheats_spawn_wild = function(
    _str_beast_id
){

//================//
//VALIDATE ROOM//
//================//
    if (room == rm_battle){

        audio_play_sound(
            snd_gui_error,
            0,
            false
        );

        hscr_cheats_log(
            "WILD BEAST SPAWN FAILED",
            "BEAST: " +
            string_upper(
                _str_beast_id
            ) +
            " | REASON: BATTLE ROOM"
        );

        return false;
    }

//================//
//VALIDATE PLAYER//
//================//
    if (
        !instance_exists(
            obj_player
        )
    ){

        audio_play_sound(
            snd_gui_error,
            0,
            false
        );

        hscr_cheats_log(
            "WILD BEAST SPAWN FAILED",
            "BEAST: " +
            string_upper(
                _str_beast_id
            ) +
            " | REASON: PLAYER MISSING"
        );

        return false;
    }

//================//
//WORLD MOUSE POSITION//
//================//
    /*
        device_mouse_x/y already return room-space coordinates
        through the active GameMaker view.

        Do NOT convert GUI coordinates through the camera again.
    */
    var _val_spawn_x =
        device_mouse_x(0);

    var _val_spawn_y =
        device_mouse_y(0);

//================//
//CLAMP TO ROOM//
//================//
    _val_spawn_x =
        clamp(
            _val_spawn_x,
            0,
            room_width
        );

    _val_spawn_y =
        clamp(
            _val_spawn_y,
            0,
            room_height
        );

//================//
//PLAYER DISTANCE//
//================//
    if (
        point_distance(
            _val_spawn_x,
            _val_spawn_y,
            obj_player.x,
            obj_player.y
        ) < 50
    ){

        audio_play_sound(
            snd_gui_error,
            0,
            false
        );

        hscr_cheats_log(
            "WILD BEAST SPAWN FAILED",
            "BEAST: " +
            string_upper(
                _str_beast_id
            ) +
            " | REASON: TOO CLOSE TO PLAYER"
        );

        return false;
    }

//================//
//INITIALIZE BEAST//
//================//
    var _stct_unit =
        scr_beast_init_random(
            _str_beast_id
        );

    if (!is_struct(_stct_unit)){

        audio_play_sound(
            snd_gui_error,
            0,
            false
        );

        hscr_cheats_log(
            "WILD BEAST SPAWN FAILED",
            "BEAST: " +
            string_upper(
                _str_beast_id
            ) +
            " | REASON: BEAST INITIALIZATION FAILED"
        );

        return false;
    }

//===============================================================================//
// ENCOUNTER POOL
//===============================================================================//

    var _arr_encounter_pool = [];

    var _str_pool_source =
        "RANDOM ALL";

    var _ref_nearest_zone =
        noone;

//================//
//FIND CLOSEST ZONE//
//================//
    if (
        instance_exists(
            obj_overworld_encounter_zone
        )
    ){

        _ref_nearest_zone =
            instance_nearest(
                _val_spawn_x,
                _val_spawn_y,
                obj_overworld_encounter_zone
            );
    }

//================//
//USE ZONE POOL//
//================//
    if (
        instance_exists(
            _ref_nearest_zone
        ) &&
        variable_instance_exists(
            _ref_nearest_zone,
            "_arr_encounter_beasts"
        ) &&
        is_array(
            _ref_nearest_zone
                ._arr_encounter_beasts
        ) &&
        array_length(
            _ref_nearest_zone
                ._arr_encounter_beasts
        ) > 0
    ){

        _arr_encounter_pool =
            _ref_nearest_zone
                ._arr_encounter_beasts;

        _str_pool_source =
            "CLOSEST ZONE";
    }

//================//
//RANDOM ALL FALLBACK//
//================//
    else{

        if (
            variable_global_exists(
                "list_logbook_beasts"
            ) &&
            ds_exists(
                global.list_logbook_beasts,
                ds_type_list
            )
        ){

            for (
                var _it_beast = 0;
                _it_beast <
                ds_list_size(
                    global.list_logbook_beasts
                );
                _it_beast++
            ){

                var _stct_entry =
                    ds_list_find_value(
                        global.list_logbook_beasts,
                        _it_beast
                    );

                if (
                    !is_struct(
                        _stct_entry
                    )
                ){
                    continue;
                }

                if (
                    !variable_struct_exists(
                        _stct_entry,
                        "_str_beast_id"
                    )
                ){
                    continue;
                }

                var _str_pool_beast =
                    _stct_entry
                        ._str_beast_id;

                if (
                    !is_string(
                        _str_pool_beast
                    ) ||
                    _str_pool_beast == ""
                ){
                    continue;
                }

                array_push(
                    _arr_encounter_pool,
                    _str_pool_beast
                );
            }
        }
    }

//================//
//FINAL FALLBACK//
//================//
    if (
        array_length(
            _arr_encounter_pool
        ) <= 0
    ){

        _arr_encounter_pool = [
            _str_beast_id
        ];

        _str_pool_source =
            "SELF FALLBACK";
    }

//===============================================================================//
// CREATE WILD BEAST
//===============================================================================//

    var _ref_beast =
        instance_create_layer(
            _val_spawn_x,
            _val_spawn_y,
            "ily_npcs",
            obj_overworld_beast
        );

    if (
        !instance_exists(
            _ref_beast
        )
    ){

        audio_play_sound(
            snd_gui_error,
            0,
            false
        );

        hscr_cheats_log(
            "WILD BEAST SPAWN FAILED",
            "BEAST: " +
            string_upper(
                _str_beast_id
            ) +
            " | REASON: INSTANCE CREATION FAILED"
        );

        return false;
    }

//================//
//ASSIGN BEAST DATA//
//================//
    _ref_beast._str_team =
        "WILD";

    _ref_beast._stct_unit =
        _stct_unit;

//================//
//ASSIGN POOL//
//================//
    _ref_beast._arr_encounter_pool =
        _arr_encounter_pool;

//================//
//HOME POSITION//
//================//
    _ref_beast._ref_home =
        noone;

    _ref_beast._val_home_x =
        _val_spawn_x;

    _ref_beast._val_home_y =
        _val_spawn_y;

//================//
//ASSIGN VISUALS//
//================//
    _ref_beast._spr_beast =
        _stct_unit._spr_beast;

    _ref_beast._spr_shadow =
        scr_beast_get_type_shadow(
            _stct_unit
                ._str_beast_color_type
        );

//================//
//SOUND//
//================//
    audio_play_sound(
        snd_battle_minion_spawn,
        0,
        false
    );

//================//
//DEBUG//
//================//
    var _str_zone_details = "";

    if (
        instance_exists(
            _ref_nearest_zone
        ) &&
        _str_pool_source ==
        "CLOSEST ZONE"
    ){

        _str_zone_details =
            " | ZONE DISTANCE: " +
            string(
                round(
                    point_distance(
                        _val_spawn_x,
                        _val_spawn_y,
                        _ref_nearest_zone.x,
                        _ref_nearest_zone.y
                    )
                )
            );
    }

    hscr_cheats_log(
        "WILD BEAST SPAWNED",
        "BEAST: " +
        string_upper(
            _str_beast_id
        ) +
        " | TYPE: " +
        string_upper(
            _stct_unit
                ._str_beast_color_type
        ) +
        " | LEVEL: " +
        string(
            _stct_unit
                ._val_beast_level
        ) +
        " | UID: " +
        string(
            _stct_unit
                ._uid_beast
        ) +
        " | POSITION: (" +
        string(
            round(
                _val_spawn_x
            )
        ) +
        "," +
        string(
            round(
                _val_spawn_y
            )
        ) +
        ")" +
        " | POOL SOURCE: " +
        _str_pool_source +
        " | POOL SIZE: " +
        string(
            array_length(
                _arr_encounter_pool
            )
        ) +
        _str_zone_details
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_END_BATTLE
//-------------------------------------------------------------------------------//
hscr_cheats_end_battle = function(_str_result){

    if (
        room != rm_battle ||
        !instance_exists(obj_battle_turn_controller)
    ){
        return false;
    }

    if (instance_exists(obj_gui_end_battle_pane)){
        return false;
    }

    obj_battle_turn_controller._flag_battle_ended = true;

    obj_battle_player_controller._state_player =
        ENUM_PLAYER_STATE.WAIT;

    obj_battle_enemy_controller._state_enemy =
        ENUM_ENEMY_STATE.WAIT;

    var _ref_end =
        instance_create_layer(
            room_width * 0.5,
            room_height * 0.5,
            "ily_fx",
            obj_gui_end_battle_pane
        );

    _ref_end._str_condition = _str_result;

    hscr_cheats_log(
        "BATTLE FORCE ENDED",
        "RESULT: " + _str_result
    );

    obj_gui_controller.hscr_gui_destroy_active(
        "CHEAT BATTLE END"
    );

    obj_gui_controller.hscr_gui_set_pause(
        false,
        "CHEAT BATTLE END"
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_FINISH_TOOL
// FUNCTION: Returns from a completed targeting tool to the Cheats Menu.
//           Unlike CANCEL_TOOL, this is a successful completion and does not
//           close the Cheats pane.
//-------------------------------------------------------------------------------//
hscr_cheats_finish_tool = function(){

	if (_str_state != "TOOL"){
		return false;
	}

	var _str_old_tool =
		_str_tool;

	_str_state =
		"MENU";

	_str_tool =
		"";

	_str_tool_label =
		"";

	_str_tool_target_type =
		"";

	_str_selected_id =
		"";

		_ref_swap_first = undefined;

	hscr_cheats_log(
		"TOOL COMPLETE",
		"TOOL: " +
		string_upper(
			_str_old_tool
		)
	);

	return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_SNAP_CAMERA_TO_PLAYER
// FUNCTION: Immediately centers/clamps the active overworld camera on the
//           player's current position.
//
//           Normal OBJ_PLAYER camera following will continue from this position
//           afterward.
//
// RETURNS: True when the camera was moved.
//-------------------------------------------------------------------------------//
hscr_cheats_snap_camera_to_player = function(){

	//================//
	//VALIDATE PLAYER//
	//================//
	if (
		!instance_exists(
			obj_player
		)
	){
		return false;
	}

	//================//
	//VALIDATE CAMERA//
	//================//
	if (
		!variable_global_exists(
			"ref_camera"
		) ||
		global.ref_camera ==
			undefined
	){
		return false;
	}

	//================//
	//CAMERA SIZE//
	//================//
	var _val_camera_w =
		camera_get_view_width(
			global.ref_camera
		);

	var _val_camera_h =
		camera_get_view_height(
			global.ref_camera
		);

	//================//
	//CAMERA LIMITS//
	//================//
	var _val_cam_max_x =
		max(
			0,
			room_width -
			_val_camera_w
		);

	var _val_cam_max_y =
		max(
			0,
			room_height -
			_val_camera_h
		);

	//================//
	//CENTER ON PLAYER//
	//================//
	var _val_camera_x =
		clamp(
			obj_player.x -
			(
				_val_camera_w *
				0.5
			),
			0,
			_val_cam_max_x
		);

	var _val_camera_y =
		clamp(
			obj_player.y -
			(
				_val_camera_h *
				0.5
			),
			0,
			_val_cam_max_y
		);

	camera_set_view_pos(
		global.ref_camera,
		_val_camera_x,
		_val_camera_y
	);

	return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_TELEPORT_PLAYER
// FUNCTION: Teleports the overworld player to a supplied world-space position.
//           Keeps the Cheats Menu open and immediately moves the camera.
//
// ARGUMENTS:
//     _val_target_x - Destination world X.
//     _val_target_y - Destination world Y.
//     _str_source   - Debug source label.
//
// RETURNS: True when the player was teleported.
//-------------------------------------------------------------------------------//
hscr_cheats_teleport_player = function(
	_val_target_x,
	_val_target_y,
	_str_source="CHEATS"
){

	//================//
	//VALIDATE ROOM//
	//================//
	if (room == rm_battle){

		return hscr_cheats_error(
			"PLAYER TELEPORT FAILED",
			"BATTLE ROOM"
		);
	}

	//================//
	//VALIDATE PLAYER//
	//================//
	if (
		!instance_exists(
			obj_player
		)
	){

		return hscr_cheats_error(
			"PLAYER TELEPORT FAILED",
			"PLAYER MISSING"
		);
	}

	//================//
	//OLD POSITION//
	//================//
	var _val_old_x =
		obj_player.x;

	var _val_old_y =
		obj_player.y;

	//================//
	//CLAMP POSITION//
	//================//
	var _val_new_x =
		clamp(
			_val_target_x,
			0,
			room_width
		);

	var _val_new_y =
		clamp(
			_val_target_y,
			0,
			room_height
		);

	//================//
	//MOVE PLAYER//
	//================//
	obj_player.x =
		_val_new_x;

	obj_player.y =
		_val_new_y;

	//================//
	//MOVE CAMERA//
	//================//
	hscr_cheats_snap_camera_to_player();

	//================//
	//FEEDBACK//
	//================//
	audio_play_sound(
		snd_gui_press,
		0,
		false
	);

	hscr_cheats_log(
		"PLAYER TELEPORTED",
		"SOURCE: " +
		string_upper(
			_str_source
		) +
		" | ROOM: " +
		string_upper(
			room_get_name(room)
		) +
		" | POSITION: (" +
		string(
			round(
				_val_old_x
			)
		) +
		"," +
		string(
			round(
				_val_old_y
			)
		) +
		") -> (" +
		string(
			round(
				_val_new_x
			)
		) +
		"," +
		string(
			round(
				_val_new_y
			)
		) +
		")"
	);

	return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_TELEPORT_PLAYER_TO_MOUSE
// FUNCTION: Converts the GUI mouse position into overworld world coordinates,
//           then teleports the player there.
//
//           Uses the same camera conversion convention as SPAWN_WILD.
//
// RETURNS: True when the player was teleported.
//-------------------------------------------------------------------------------//
hscr_cheats_teleport_player_to_mouse = function(){

    //================//
    //VALIDATE ROOM//
    //================//
    if (room == rm_battle){

        return hscr_cheats_error(
            "CLICK TELEPORT FAILED",
            "BATTLE ROOM"
        );
    }

    //================//
    //VALIDATE PLAYER//
    //================//
    if (
        !instance_exists(
            obj_player
        )
    ){

        return hscr_cheats_error(
            "CLICK TELEPORT FAILED",
            "PLAYER MISSING"
        );
    }

    //================//
    //WORLD MOUSE//
    //================//
    /*
        This is already the correct room-space mouse position
        for the active view/camera.
    */
    var _val_world_x =
        device_mouse_x(0);

    var _val_world_y =
        device_mouse_y(0);

    //================//
    //TELEPORT//
    //================//
    return hscr_cheats_teleport_player(
        _val_world_x,
        _val_world_y,
        "CLICK TELEPORT"
    );
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_TELEPORT_RANCH
// FUNCTION: Immediately changes to the Ranch room.
//
//           A pending flag lets OBJ_PLAYER center itself using the destination
//           room's actual dimensions during Room Start.
//
//           Changing rooms intentionally closes the current Cheats instance.
//
// RETURNS: True when the room change was requested.
//-------------------------------------------------------------------------------//
hscr_cheats_teleport_ranch = function(){

    //================//
    //VALIDATE PLAYER//
    //================//
    if (
        !instance_exists(
            obj_player
        )
    ){

        return hscr_cheats_error(
            "RANCH TELEPORT FAILED",
            "PLAYER MISSING"
        );
    }

    //================//
    //GET NORMAL SPAWN//
    //================//
    var _arr_room_info =
        scr_transition_get_room_info(
            "RANCH",
            ""
        );

    if (
        !is_array(
            _arr_room_info
        ) ||
        array_length(
            _arr_room_info
        ) < 4 ||
        _arr_room_info[0] ==
            undefined
    ){

        return hscr_cheats_error(
            "RANCH TELEPORT FAILED",
            "RANCH TRANSITION DATA INVALID"
        );
    }

    //================//
    //ALREADY AT RANCH//
    //================//
    if (room == rm_ow_ranch){

        return hscr_cheats_teleport_player(
            _arr_room_info[2],
            _arr_room_info[3],
            "RANCH ENTRY"
        );
    }

    //================//
    //CLEAR OLD CENTER FLAG//
    //================//
    if (
        variable_global_exists(
            "flag_cheat_center_player_on_room_start"
        )
    ){

        global.flag_cheat_center_player_on_room_start =
            false;
    }

    //================//
    //POSITION PLAYER//
    //================//
    /*
        OBJ_PLAYER is persistent, so assign the same destination
        coordinates used by the normal Ranch transition before room_goto.
    */
    obj_player.x =
        _arr_room_info[2];

    obj_player.y =
        _arr_room_info[3];

    //================//
    //DEBUG//
    //================//
    hscr_cheats_log(
        "PLAYER TELEPORT ROOM",
        "DESTINATION: " +
        string_upper(
            room_get_name(
                _arr_room_info[0]
            )
        ) +
        " | POSITION: (" +
        string(
            round(
                _arr_room_info[2]
            )
        ) +
        "," +
        string(
            round(
                _arr_room_info[3]
            )
        ) +
        ")"
    );

    audio_play_sound(
        snd_gui_press,
        0,
        false
    );

    //================//
    //RELEASE GUI PAUSE//
    //================//
    global.ref_active_gui =
        undefined;

    if (
        instance_exists(
            obj_gui_controller
        )
    ){

        obj_gui_controller
            .hscr_gui_set_pause(
                false,
                "CHEAT TELEPORT RANCH"
            );
    }

    //================//
    //CHANGE ROOM//
    //================//
    room_goto(
        _arr_room_info[0]
    );

    return true;
};


//-------------------------------------------------------------------------------//
// HSCR_CHEATS_START_BATTLE
// FUNCTION: Starts a normal overworld encounter at an explicitly selected
//           EASY / MEDIUM / HARD difficulty.
//
//           Uses the nearest OBJ_OVERWORLD_ENCOUNTER_ZONE to the player for:
//           - Enemy Beast encounter pool.
//           - Loot-zone ID.
//
//           The encounter itself still uses the normal shared scaling pipeline.
//           ELITE remains intentionally disabled until Elite encounter rules exist.
//-------------------------------------------------------------------------------//
hscr_cheats_start_battle = function(
    _str_difficulty
){

    #region VALIDATION

    //================//
    //OVERWORLD ONLY//
    //================//
    if (room == rm_battle){

        return hscr_cheats_error(
            "BATTLE START FAILED",
            "ALREADY IN BATTLE"
        );
    }

    //================//
    //PLAYER//
    //================//
    if (
        !instance_exists(
            obj_player
        )
    ){

        return hscr_cheats_error(
            "BATTLE START FAILED",
            "PLAYER MISSING"
        );
    }

    //================//
    //DIFFICULTY//
    //================//
    _str_difficulty =
        string_upper(
            string(
                _str_difficulty
            )
        );

    if (
        _str_difficulty != "EASY" &&
        _str_difficulty != "MEDIUM" &&
        _str_difficulty != "HARD"
    ){

        return hscr_cheats_error(
            "BATTLE START FAILED",
            "INVALID OR DISABLED DIFFICULTY: " +
            _str_difficulty
        );
    }

    //================//
    //TRANSITION LOCK//
    //================//
    if (
        instance_exists(
            obj_transition
        ) ||
        instance_exists(
            obj_transition_fader
        ) ||
        instance_exists(
            obj_battle_wait
        )
    ){

        return hscr_cheats_error(
            "BATTLE START FAILED",
            "BATTLE TRANSITION ALREADY ACTIVE"
        );
    }

    #endregion

    #region NEAREST ENCOUNTER ZONE

    //================//
    //FIND ZONE//
    //================//
    var _ref_zone =
        noone;

    if (
        instance_exists(
            obj_overworld_encounter_zone
        )
    ){

        _ref_zone =
            instance_nearest(
                obj_player.x,
                obj_player.y,
                obj_overworld_encounter_zone
            );
    }

    if (
        !instance_exists(
            _ref_zone
        )
    ){

        return hscr_cheats_error(
            "BATTLE START FAILED",
            "NO ENCOUNTER ZONE FOUND IN ROOM"
        );
    }

    //================//
    //ENEMY POOL//
    //================//
    if (
        !variable_instance_exists(
            _ref_zone,
            "_arr_encounter_beasts"
        ) ||
        !is_array(
            _ref_zone
                ._arr_encounter_beasts
        ) ||
        array_length(
            _ref_zone
                ._arr_encounter_beasts
        ) <= 0
    ){

        return hscr_cheats_error(
            "BATTLE START FAILED",
            "NEAREST ENCOUNTER ZONE HAS NO BEAST POOL"
        );
    }

    var _arr_enemy_pool =
        _ref_zone
            ._arr_encounter_beasts;

    //================//
    //LOOT ZONE//
    //================//
    var _str_loot_zone_id =
        "UNASSIGNED";

    if (
        variable_instance_exists(
            _ref_zone,
            "_str_loot_zone_id"
        ) &&
        is_string(
            _ref_zone
                ._str_loot_zone_id
        ) &&
        _ref_zone
            ._str_loot_zone_id != ""
    ){

        _str_loot_zone_id =
            string_upper(
                _ref_zone
                    ._str_loot_zone_id
            );
    }

    #endregion

    #region CLAIM TRANSITION

    //================//
    //CLAIM BATTLE//
    //================//
    var _ref_transition =
        scr_transition_trigger(
            rm_battle
        );

    if (
        !instance_exists(
            _ref_transition
        )
    ){

        return hscr_cheats_error(
            "BATTLE START FAILED",
            "BATTLE TRANSITION COULD NOT BE CLAIMED"
        );
    }

    #endregion

    #region ENCOUNTER SCALING

    // Roll only after the cheat successfully owns the transition,
    // matching ordinary encounter entry behavior.
    var _stct_encounter_scaling =
        scr_overworld_roll_encounter_scaling(
            room,
            _str_difficulty
        );

    if (
        !is_struct(
            _stct_encounter_scaling
        )
    ){

        // The transition has not advanced yet, so destroy the claim
        // instead of allowing an invalid battle transition to continue.
        with (_ref_transition){
            instance_destroy();
        }

        return hscr_cheats_error(
            "BATTLE START FAILED",
            "ENCOUNTER SCALING FAILED"
        );
    }

    #endregion

    #region STORE BATTLE STATE

    //================//
    //RETURN POSITION//
    //================//
    global.val_last_player_x =
        obj_player.x;

    global.val_last_player_y =
        obj_player.y;

    global.rm_last_player =
        room;

    //================//
    //ENCOUNTER DATA//
    //================//
    global.arr_last_enemy_pool =
        _arr_enemy_pool;

    global.str_last_loot_zone_id =
        _str_loot_zone_id;

    // Cheat-started encounters behave like ordinary grass encounters:
    // no forced visible Beast occupies slot 0.
    global.stct_forced_enemy_unit =
        undefined;

    global.stct_encounter_scaling =
        _stct_encounter_scaling;

    #endregion

    #region DEBUG

    var _str_source_room =
        string_upper(
            room_get_name(
                room
            )
        );

    var _val_zone_distance =
        round(
            point_distance(
                obj_player.x,
                obj_player.y,
                _ref_zone.x,
                _ref_zone.y
            )
        );

    hscr_cheats_log(
        "BATTLE STARTED",
        "ROOM: " +
        _str_source_room +
        " | DIFFICULTY: " +
        _str_difficulty +
        " | POOL SOURCE: NEAREST ZONE" +
        " | ZONE DISTANCE: " +
        string(
            _val_zone_distance
        ) +
        " | POOL SIZE: " +
        string(
            array_length(
                _arr_enemy_pool
            )
        ) +
        " | LOOT ZONE: " +
        _str_loot_zone_id +
        " | ENEMIES: " +
        string(
            _stct_encounter_scaling
                ._ct_enemy_beasts
        ) +
        " | ZONE LEVELS: " +
        string(
            _stct_encounter_scaling
                ._val_zone_level_min
        ) +
        "-" +
        string(
            _stct_encounter_scaling
                ._val_zone_level_max
        )
    );

    #endregion

    #region START TRANSITION

    //================//
    //LOCK PLAYER//
    //================//
    scr_player_set_movement_state(
        "STOP"
    );

    obj_player.visible =
        false;

    //================//
    //SOUND//
    //================//
    audio_play_sound(
        snd_overworld_encounter_trigger,
        0,
        false
    );

    //================//
    //CLOSE CHEATS//
    //================//
    if (
        instance_exists(
            obj_gui_controller
        )
    ){

        obj_gui_controller
            .hscr_gui_destroy_active(
                "CHEAT START BATTLE"
            );

        obj_gui_controller
            .hscr_gui_set_pause(
                false,
                "CHEAT START BATTLE"
            );
    }
    else{

        if (
            variable_global_exists(
                "ref_active_gui"
            ) &&
            global.ref_active_gui == id
        ){
            global.ref_active_gui =
                undefined;
        }

        global.flag_pause =
            false;
    }

    #endregion

    return true;
};

#endregion
