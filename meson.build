project('BackupRestore', 'vala', 'c')

gettext_name = meson.project_name() + '-plug'
gnome = import('gnome')
# Include the translations module
i18n = import('i18n')

# Set our translation domain
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')

subdir('src')
subdir('po')
