--[[
-------------------------------------------------------------------------------
-- QuickSettings, by Ayantir
-------------------------------------------------------------------------------
This software is under : CreativeCommons CC BY-NC-SA 4.0
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

You are free to:

    Share — copy and redistribute the material in any medium or format
    Adapt — remix, transform, and build upon the material
    The licensor cannot revoke these freedoms as long as you follow the license terms.


Under the following terms:

    Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
    NonCommercial — You may not use the material for commercial purposes.
    ShareAlike — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.
    No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.


Please read full licence at : 
http://creativecommons.org/licenses/by-nc-sa/4.0/legalcode
]]

local ADDON_NAME = "QuickSettings"

local settingsData = {
	[SETTING_TYPE_GRAPHICS] = {
		[GRAPHICS_SETTING_CLUTTER_2D] = SI_GRAPHICS_OPTIONS_VIDEO_CLUTTER_2D,
	},
	[SETTING_TYPE_UI] = {
		[UI_SETTING_ULTIMATE_NUMBER] = SI_INTERFACE_OPTIONS_ULTIMATE_NUMBER,
		[UI_SETTING_SHOW_QUEST_TRACKER] = SI_INTERFACE_OPTIONS_SHOW_QUEST_TRACKER,
		[UI_SETTING_SHOW_FRAMERATE] = SI_INTERFACE_OPTIONS_SHOW_FRAMERATE,
		[UI_SETTING_SHOW_LATENCY] = SI_INTERFACE_OPTIONS_SHOW_LATENCY,
		[UI_SETTING_FRAMERATE_LATENCY_LOCK] = SI_INTERFACE_OPTIONS_FRAMERATE_LATENCY_LOCK,
		[UI_SETTING_COMPASS_QUEST_GIVERS] = SI_INTERFACE_OPTIONS_COMPASS_QUEST_GIVERS,
		[UI_SETTING_SHOW_WEAPON_INDICATOR] = SI_WEAPON_INDICATOR,
		[UI_SETTING_SHOW_ARMOR_INDICATOR] = SI_ARMOR_INDICATOR,
		[UI_SETTING_SHOW_QUEST_BESTOWER_INDICATORS] = SI_INTERFACE_OPTIONS_SHOW_QUEST_BESTOWERS,
		[UI_SETTING_AUTO_DECLINE_DUEL_INVITES] = SI_SOCIAL_OPTIONS_AUTO_DECLINE_DUEL_INVITES,
	},
	[SETTING_TYPE_NAMEPLATES] = {
		[NAMEPLATE_TYPE_ALL_NAMEPLATES] = SI_INTERFACE_OPTIONS_NAMEPLATES_ALL,
		[NAMEPLATE_TYPE_SHOW_PLAYER_TITLES] = SI_INTERFACE_OPTIONS_NAMEPLATES_SHOW_PLAYER_TITLES,
		[NAMEPLATE_TYPE_SHOW_PLAYER_GUILDS] = SI_INTERFACE_OPTIONS_NAMEPLATES_SHOW_PLAYER_GUILDS,
	},
	[SETTING_TYPE_IN_WORLD] = {
		[IN_WORLD_UI_SETTING_HIDE_HELM] = SI_INTERFACE_OPTIONS_HIDE_HELM,
		[IN_WORLD_UI_SETTING_HIDE_MOUNT_STAMINA_UPGRADE] = SI_INTERFACE_OPTIONS_HIDE_MOUNT_STAMINA_UPGRADE,
		[IN_WORLD_UI_SETTING_HIDE_MOUNT_SPEED_UPGRADE] = SI_INTERFACE_OPTIONS_HIDE_MOUNT_SPEED_UPGRADE,
		[IN_WORLD_UI_SETTING_HIDE_MOUNT_INVENTORY_UPGRADE] = SI_INTERFACE_OPTIONS_HIDE_MOUNT_INVENTORY_UPGRADE,
		[IN_WORLD_UI_SETTING_TARGET_GLOW_ENABLED] = SI_INTERFACE_OPTIONS_TARGET_GLOWS_ENABLED,
		[IN_WORLD_UI_SETTING_INTERACTABLE_GLOW_ENABLED] = SI_INTERFACE_OPTIONS_INTERACTABLE_GLOWS_ENABLED,
	},
	[SETTING_TYPE_CHAT_BUBBLE] = {
		[CHAT_BUBBLE_SETTING_ENABLED] = SI_INTERFACE_OPTIONS_CHAT_BUBBLES,
	},
	[SETTING_TYPE_COMBAT] = {
		[COMBAT_SETTING_MONSTER_TELLS_ENABLED] = SI_INTERFACE_OPTIONS_COMBAT_MONSTER_TELLS_ENABLE,
		[COMBAT_SETTING_ROLL_DODGE_DOUBLE_TAP] = SI_INTERFACE_OPTIONS_COMBAT_ROLL_DODGE_ENABLED,
		[COMBAT_SETTING_CLAMP_GROUND_TARGET_ENABLED] = SI_INTERFACE_OPTIONS_COMBAT_CLAMP_GROUND_TARGET_ENABLED,
		[COMBAT_SETTING_PREVENT_ATTACKING_INNOCENTS] = SI_INTERFACE_OPTIONS_COMBAT_PREVENT_ATTACKING_INNOCENTS,
	},
	[SETTING_TYPE_LOOT] = {
		[LOOT_SETTING_AOE_LOOT] = SI_INTERFACE_OPTIONS_LOOT_USE_AOELOOT,
		[LOOT_SETTING_AUTO_LOOT] = SI_INTERFACE_OPTIONS_LOOT_USE_AUTOLOOT,
		[LOOT_SETTING_AUTO_LOOT_STOLEN] = SI_INTERFACE_OPTIONS_LOOT_USE_AUTOLOOT_STOLEN,
		[LOOT_SETTING_AUTO_ADD_TO_CRAFT_BAG] = SI_INTERFACE_OPTIONS_LOOT_AUTO_ADD_TO_CRAFT_BAG,
		[LOOT_SETTING_LOOT_HISTORY] = SI_INTERFACE_OPTIONS_LOOT_TOGGLE_LOOT_HISTORY,
	},
	[SETTING_TYPE_TUTORIAL] = {
		[TUTORIAL_ENABLED_SETTING_ID] = SI_INTERFACE_OPTIONS_TOOLTIPS_TUTORIAL_ENABLED,
	},
	[SETTING_TYPE_GAMEPAD] = {
		[GAMEPAD_SETTING_GAMEPAD_PREFERRED] = SI_GAMEPAD_OPTIONS_GAMEPAD_MODE,
	},
	[SETTING_TYPE_CAMERA] = {
		[CAMERA_SETTING_SMOOTHING] = SI_INTERFACE_OPTIONS_CAMERA_SMOOTHING,
		[CAMERA_SETTING_INVERT_Y] = SI_INTERFACE_OPTIONS_CAMERA_INVERT_Y,
		[CAMERA_SETTING_FOV_CHANGES_ALLOWED] = SI_INTERFACE_OPTIONS_CAMERA_FOV_CHANGES,
		[CAMERA_SETTING_ASSASSINATION_CAMERA] = SI_INTERFACE_OPTIONS_CAMERA_ASSASSINATION_CAMERA,
	},
	[SETTING_TYPE_SUBTITLES] = {
		[SUBTITLE_SETTING_ENABLED] = SI_INTERFACE_OPTIONS_TOOLTIPS_SUBTITLES_ENABLED,
	},
	[SETTING_TYPE_AUDIO] = {
		[AUDIO_SETTING_MUSIC_ENABLED] = SI_AUDIO_OPTIONS_MUSIC_ENABLED,
		[AUDIO_SETTING_SOUND_ENABLED] = SI_AUDIO_OPTIONS_SOUND_ENABLED,
		[AUDIO_SETTING_BACKGROUND_AUDIO] = SI_AUDIO_OPTIONS_BACKGROUND_AUDIO,
	},
}

local function InitializeSettings()

	for systemIndex, systemData in pairs(settingsData) do
		for settingId, textId in pairs(systemData) do
			ZO_CreateStringId("SI_BINDING_NAME_QUICKSETTINGS_" .. systemIndex .. "_" .. settingId, GetString(textId))
		end
	end

end

function QuickSettings_SetSetting(system, settingId)
	local isEnabled = GetSetting(system, settingId) == "1"
	local valueToSet
	if isEnabled then
		valueToSet = "0"
	else
		valueToSet = "1"
	end
	SetSetting(system, settingId, valueToSet)
end

local function OnAddonLoaded(_, addon)
	if addon == ADDON_NAME then
		InitializeSettings()
		EVENT_MANAGER:UnregisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED)
	end
end

EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED, OnAddonLoaded)