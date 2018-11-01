/*
 * Copyright (c) {{yearrange}} Padman. ()
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

namespace BackupRestore.Widgets {
    public class MainView : Granite.SimpleSettingsPage {
        private string pathToBackup = "/home/padman/FakeRoot/";
        private string backupPath = "/home/padman/FakeBackup/";
        private const string configPath = "/etc/mcflys-backup/";
        private const string configFile = "backup.cfg";

        public MainView (BackupRestore.Backend.Settings settings) {
            Object (
                icon_name: "com.github.DkGr.mcfyls-timemachine.png",
                title: _("Backup & Restore"),
                activatable: true
            );
        }

        construct {
            var welcome_screen = new Granite.Widgets.Welcome (_("Go back in time !"), _("Configure your backup space."));

            welcome_screen.append("drive-removable-media", _("Choose a backup destination"), _("Select a storage device for your backup"));

            welcome_screen.activated.connect ((index) => {
                switch (index) {
                    case 0:
                        try {
                            var file_chooser = new Gtk.FileChooserDialog (_("Select a Backup Folder"), this,
                                                                          Gtk.FileChooserAction.SELECT_FOLDER,
                                                                          _("Cancel"),
                                                                          Gtk.ResponseType.CANCEL,
                                                                          _("OK"),
                                                                          Gtk.ResponseType.ACCEPT);

                            file_chooser.set_local_only (true);
                            file_chooser.set_select_multiple (false);
                            file_chooser.set_current_folder (backupPath);

                            string? folder = null;

                            if (file_chooser.run () == Gtk.ResponseType.ACCEPT){
                                backupPath = file_chooser.get_filename ();
                                WriteConfig();
                            }


                            file_chooser.destroy ();
                        } catch (Error e) {
                            warning (e.message);
                        }

                        break;
                }
            });
            content_area.add(welcome_screen);
        }

        private void WriteConfig()
        {
            // A reference to our file
            var configPathFile = File.new_for_path (configPath);
            var configFileInstance = File.new_for_path (configPath + configFile);
            FileIOStream ios;
            if (!configPathFile.query_exists ()) {
                configPathFile.make_directory ();
                ios = configFileInstance.create_readwrite (FileCreateFlags.NONE);
            }
            else{
                ios = configFileInstance.open_readwrite();
            }

            try {
                OutputStream ostream = ios.output_stream;
		        DataOutputStream dostream = new DataOutputStream (ostream);
		        dostream.put_string ("backup_folder="+backupPath+"\n");
            } catch (Error e) {
                error ("%s", e.message);
            }
        }
    }
}
