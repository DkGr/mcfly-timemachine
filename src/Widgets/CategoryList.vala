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
    public class CategoryList : Gtk.ListBox {
        Gee.HashMap<string, CategoryItem> categories = new Gee.HashMap<string, CategoryItem> ();

        public CategoryList () {
            Object (activate_on_single_click: true,
                    selection_mode: Gtk.SelectionMode.SINGLE);
        }

        construct {
            var privacy_item = new CategoryItem ("com.github.dkgr.mcflys-timemachine", "tracking", _("Backup"));

            add_category (privacy_item);
        }

        private void update_category_status (CategoryItem category_item, bool category_status) {
            if (category_status) {
                category_item.status = CategoryItem.Status.ENABLED;
            } else {
                category_item.status = CategoryItem.Status.DISABLED;
            }
        }

        public void add_category (CategoryItem category) {
            add (category);
            categories.set (category.title, category);
        }

        public void select_category_name (string name) {
            select_row (categories[name]);
        }
    }
}