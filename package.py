name = "houdini"

version = "17.5.360"

authors = [
    "SideFX"
]

description = \
    """
    Houdini is a 3D animation software application developed by SideFX, based in Toronto. SideFX adapted Houdini
    from the PRISMS suite of procedural generation software tools. Its exclusive attention to procedural generation
    distinguishes it from other 3D computer graphics software.
    """

requires = [
    "cmake-3+",
    "license_manager"
]

variants = [
    ["platform-linux"]
]

tools = [
    "houdini",
    "houdinicore",
    "houdinifx"
]

build_system = "cmake"

with scope("config") as config:
    config.build_thread_count = "logical_cores"

uuid = "houdini-{version}".format(version=str(version))

def commands():
    env.PATH.prepend("{root}/bin")
    env.HFS.set("{root}")
    env.H.set("{root}")
    env.HB.set("{root}/bin")
    env.HDSO.set("{root}/dso")
    env.HH.set("{root}/houdini")
    env.HHC.set("{root}/config")
    env.HT.set("{root}/toolkit")
    env.HSB.set("{root}/sbin")
    env.HOUDINI_PATH.set("{root}/houdini")

    # We setup the license server.
    if "HOUDINI_LICENSE_SERVER" in env.keys():
        env.SESI_LMHOST.set(str(env.HOUDINI_LICENSE_SERVER))

    # Helper environment variables.
    env.HOUDINI_BINARY_PATH.set("{root}/bin")
    env.HOUDINI_INCLUDE_PATH.set("{root}/toolkit/include/")
    env.HOUDINI_LIBRARY_PATH.set("{root}/dsolib")
