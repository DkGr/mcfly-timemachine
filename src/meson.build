plug_files = files(
    'Backend/BackupRestoreSettings.vala',
    'MainView.vala',
    'Plug.vala',
    'Permission.vala',
    'Widgets/CategoryItem.vala',
    'Widgets/CategoryList.vala'
)

switchboard_dep = dependency('switchboard-2.0')

shared_module(
    meson.project_name(),
    plug_files,
    dependencies: [
        dependency('glib-2.0'),
        dependency('gio-2.0'),
        dependency('gobject-2.0'),
        dependency('granite'),
        dependency('gtk+-3.0'),
        switchboard_dep,
        dependency('polkit-gobject-1'),
        meson.get_compiler('vala').find_library('posix'),
    ],
    install: true,
    install_dir : join_paths(switchboard_dep.get_pkgconfig_variable('plugsdir'), 'system')
)
