/* Copyright 2011-2018 elementary LLC. (https://elementary.io)
*
* This program is free software: you can redistribute it
* and/or modify it under the terms of the GNU Lesser General Public License as
* published by the Free Software Foundation, either version 3 of the
* License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be
* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
* Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with this program. If not, see http://www.gnu.org/licenses/.
*/

namespace BackupRestore {
    public class MainView : Granite.SettingsPage {
        private BackupRestore.Backend.BackupRestoreSettings backup_settings;
        private string pathToBackup = "/home/padman/FakeRoot/";

        public signal void settings_changed ();

        public MainView () {
            Object ();
        }

        construct {
            load_settings();
            if(!backup_settings.backup_path_configured){
                var welcome_screen = new Granite.Widgets.Welcome (_("Go back in time !"), _("Configure your backup space."));

                welcome_screen.append("drive-removable-media", _("Choose a backup destination"), _("Select a storage device for your backup"));

                welcome_screen.activated.connect ((index) => {
                    switch (index) {
                        case 0:
                            try {
                                var file_chooser = new Gtk.FileChooserDialog (_("Select a Backup Folder"), null ,
                                                                              Gtk.FileChooserAction.SELECT_FOLDER,
                                                                              _("Cancel"),
                                                                              Gtk.ResponseType.CANCEL,
                                                                              _("OK"),
                                                                              Gtk.ResponseType.ACCEPT);

                                file_chooser.set_local_only (true);
                                file_chooser.set_select_multiple (false);

                                if (file_chooser.run () == Gtk.ResponseType.ACCEPT){
                                    backup_settings.backup_path = file_chooser.get_filename ();
                                    backup_settings.backup_path_configured = true;
                                    this.remove(welcome_screen);
                                    this.add(new Gtk.Switch());
                                    show_all();
                                }

                                file_chooser.destroy ();
                            } catch (Error e) {
                                warning (e.message);
                            }

                            break;
                    }
                });

                this.add(welcome_screen);
            }
            else{
                this.add(new Gtk.Switch());
            }

            show_all();
        }

        private void load_settings () {
            backup_settings = new BackupRestore.Backend.BackupRestoreSettings();
        }
    }
}
