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

namespace BackupRestore.Widgets {
    public class BackupPanel : Granite.SimpleSettingsPage {

        public BackupPanel () {
            Object (
                activatable: true,
                description: _("%s can store local usage data to provide extra functionality like offering recently-used files and more relevant local search. Regardless of this setting, usage data is never transmitted off of this device or to third parties.").printf (get_operating_system_name ()),
                icon_name: "document-open-recent",
                title: _("History")
            );
        }

        construct {
            var description = ("%s %s\n\n%s".printf (
                _("%s won't retain any further usage data.").printf (get_operating_system_name ()),
                _("The additional functionality that this data provides will be affected."),
                _("This may not prevent apps from recording their own usage data, such as browser history.")
            ));

            var alert = new Granite.Widgets.AlertView (_("History Is Disabled"), description, "");
            alert.show_all ();

            var description_frame = new Gtk.Frame (null);
            description_frame.no_show_all = true;
            description_frame.add (alert);

            status_switch.active = true;

            var clear_data = new Gtk.ToggleButton.with_label (_("Clear History…"));
            clear_data.notify["active"].connect (() => {

            });

            content_area.attach (description_frame, 0, 1, 2, 1);

            update_status_switch ();
        }

        private static string get_operating_system_name () {
            string system = _("Your system");
            try {
                string contents = null;
                if (FileUtils.get_contents ("/etc/os-release", out contents)) {
                    int start = contents.index_of ("NAME=") + "NAME=".length;
                    int end = contents.index_of_char ('\n');
                    system = contents.substring (start, end - start).replace ("\"", "");
                }
            } catch (FileError e) {
                debug ("Could not get OS name");
            }
            return system;
        }

        private void update_status_switch () {
            if (status_switch.active) {
                status_type = Granite.SettingsPage.StatusType.SUCCESS;
                status = _("Enabled");
            } else {
                warning ("Trying to set offline");
                status_type = Granite.SettingsPage.StatusType.OFFLINE;
                status = _("Disabled");
            }
        }
    }
}
