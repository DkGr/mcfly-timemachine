icon_sizes = ['16', '24', '32', '48', '64', '128']

foreach i : icon_sizes
    install_data(
        join_paths('icons', i, meson.project_name() + '.png'),
        install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', i + 'x' + i, 'apps')
    )
endforeach

install_data(
    meson.project_name() + '.gschema.xml',
    install_dir: join_paths(get_option('datadir'), 'glib-2.0', 'schemas')
)

install_data(
    meson.project_name() + '.appdata.xml',
    install_dir: join_paths(get_option('datadir'), 'metainfo')
)

config_data = configuration_data()
config_data.set('GETTEXT_PACKAGE', gettext_name)
config_data.set('PKGDATADIR', join_paths(get_option('prefix'), get_option('datadir')))

configure_file(
    input: 'io.elementary.switchboard.backuprestore.policy.in',
    output: '@BASENAME@',
    configuration: config_data,
    install_dir: polkit_dep.get_pkgconfig_variable('policydir')
)