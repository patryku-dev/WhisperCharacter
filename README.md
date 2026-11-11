# WhisperCharacter

Whisper a Battle.net friend's **character** instead of their account.

For WoW Forever (interface `16001`).

## Usage

Right-click a Battle.net friend and choose **Whisper**.

- Friend is logged in to WoW (same game version and region): chat opens a whisper to their character.
- Hold **Shift** while clicking **Whisper**: normal Battle.net whisper to the account.
- Friend is offline, in another game, or on another WoW version: normal Battle.net whisper.

## Install

Copy this folder to `Interface\AddOns\` and make sure it is named `WhisperCharacter`, then `/reload`.

## Notes

- The whisper target is the character name only, without the realm. Characters on non-connected realms may not be reachable.
- Cross-faction whispers depend on what the game allows.
