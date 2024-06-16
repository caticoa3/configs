#!/usr/bin/env python3.7
# https://notes.arne.me/automatic-darkmode-for-iterm/

import subprocess
import time

import iterm2


def is_dark_mode():
    cmd = "defaults read -g AppleInterfaceStyle"
    p = subprocess.Popen(
        cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True
    )
    return bool(p.communicate()[0])


async def set_profile(connection):
    app = await iterm2.async_get_app(connection)

    # themes during daylight
    profile = "solarized light"
    # theme for comparing git diffs during the day
    subprocess.run("git config --global delta.syntax-theme GitHub".split())

    if is_dark_mode():
        # themes during daylight
        profile = "Groovy Boxy"
        # theme for comparing git diffs  after sunset
        subprocess.run("git config --global delta.syntax-theme gruvbox-dark".split())

    print(profile)

    partialProfiles = await iterm2.PartialProfile.async_query(connection)
    for partial in partialProfiles:
        if partial.name == profile:
            full = await partial.async_get_full_profile()
            # Set profile in _all_ sessions
            for window in app.terminal_windows:
                for tab in window.tabs:
                    for session in tab.sessions:
                        await session.async_set_profile(full)
                        print(profile)
                return


async def main(connection):
    await set_profile(connection)
    while True:
        time.sleep(2)
        await set_profile(connection)


iterm2.run_forever(main)
