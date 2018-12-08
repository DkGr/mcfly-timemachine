/*
 * Copyright (c) 2018 Padman ()
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA.
*
* Authored by: Padman <>
 */
namespace BackupRestore {
    public class MainView : Gtk.Grid {
        private BackupRestore.Backend.BackupRestoreSettings backup_settings;
        private string pathToBackup = "/home/padman/FakeRoot/";

        Widgets.CategoryList category_list;

        public signal void settings_changed ();

        public MainView () {
            Object ();
        }

        construct {
            load_settings();
        }

        public void DisplayScreen(){
            if(!backup_settings.backup_path_configured){
                DisplayWelcomeScreen();
            }
            else{
                DisplayMainScreen();
            }
        }

        private void DisplayWelcomeScreen(){
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
                                DisplayMainScreen();
                            }

                            file_chooser.destroy ();
                        } catch (Error e) {
                            warning (e.message);
                        }

                        break;
                }
            });

            this.add(welcome_screen);
            show_all();
        }

        private void DisplayMainScreen(){
            var lock_button = new Gtk.LockButton (get_permission ());

            var permission_label = new Gtk.Label (_("Some settings require administrator rights to be changed"));

            var permission_infobar = new Gtk.InfoBar ();
            permission_infobar.message_type = Gtk.MessageType.INFO;
            permission_infobar.get_content_area ().add (permission_label);

            var area_infobar = permission_infobar.get_action_area () as Gtk.Container;
            area_infobar.add (lock_button);


            var stack = new Gtk.Stack ();

            var grid = new Gtk.Grid ();
            grid.attach (stack, 0, 3, 1, 1);

            category_list = new Widgets.CategoryList ();

            var paned = new Gtk.Paned (Gtk.Orientation.HORIZONTAL);
            paned.position = 200;
            paned.add1 (category_list);
            paned.add2 (grid);

            this.add (paned);

            category_list.row_selected.connect ((row) => {
                var title = ((Widgets.CategoryItem)row).title;
                stack.visible_child_name = title;
            });

            show_all();
        }

        private void load_settings () {
            backup_settings = new BackupRestore.Backend.BackupRestoreSettings();
        }
    }
}
