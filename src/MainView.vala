public class MainView : Gtk.Grid {
    private string pathToBackup = "/home/padman/TestToBackup/";
    private string backupPath = "/home/padman/";

    construct {    
        orientation = Gtk.Orientation.VERTICAL;
        margin_bottom = 12;

        var main_grid = new Gtk.Grid ();
        main_grid.margin = 24;
        main_grid.column_spacing = 12;
        main_grid.row_spacing = 12;
        
        add(main_grid);
    }

    /*protected override void activate () {
        try {
            // Either directly from a file ...
            main_window.icon = new Gdk.Pixbuf.from_file ("../data/icons/mcfly-backup-128.png");
        } catch (Error e) {
            stderr.printf ("Could not load application icon: %s\n", e.message);
        }

        var welcome_screen = new Granite.Widgets.Welcome (_("Go back in time !"), _("Configure your backup space."));
        
        welcome_screen.append("drive-removable-media", _("Choose a backup destination"), _("Select a storage device for your backup"));
        
        welcome_screen.activated.connect ((index) => {
            switch (index) {
                case 0:
                    try {
                        var file_chooser = new Gtk.FileChooserDialog (_("Select Music Folder"), main_window,
                                                                      Gtk.FileChooserAction.SELECT_FOLDER,
                                                                      _("Cancel"),
                                                                      Gtk.ResponseType.CANCEL,
                                                                      _("Open"),
                                                                      Gtk.ResponseType.ACCEPT);
        
                        file_chooser.set_local_only (true);
                        file_chooser.set_select_multiple (false);
                        file_chooser.set_current_folder (backupPath);
        
                        string? folder = null;
        
                        if (file_chooser.run () == Gtk.ResponseType.ACCEPT)
                            folder = file_chooser.get_filename ();
        
                        file_chooser.destroy ();
                        
                        Posix.system("rsnapshot hourly");
                    } catch (Error e) {
                        warning (e.message);
                    }

                    break;
            }
        });
        
        main_window.add (welcome_screen);

        main_window.show_all ();
    }

    public static int main (string[] args) {
        var app = new MyApp ();
        return app.run (args);
    }*/
}
