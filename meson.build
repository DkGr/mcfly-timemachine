project('com.github.dkgr.mcflys-timemachine', 'vala', 'c')

gettext_name = meson.project_name() + '-plug'
gnome = import('gnome')
# Include the translations module
i18n = import('i18n')

# Set our translation domain
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')

polkit_dep = dependency('polkit-gobject-1')

subdir('src')
subdir('data')
subdir('po')

meson.add_install_script('meson/post_install.py')