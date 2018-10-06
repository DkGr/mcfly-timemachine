public class MyApp : Gtk.Application {
    private string pathToBackup = "/";
    private string backupPath = "/home/padman";

    public MyApp () {
        Object (
            application_id: "com.github.yourusername.yourrepositoryname",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this);
        main_window.window_position = Gtk.WindowPosition.CENTER;
        main_window.default_height = 300;
        main_window.default_width = 640;
        main_window.title = "McFly's Time Machine";
        try {
            // Either directly from a file ...
            main_window.icon = new Gdk.Pixbuf.from_file ("../data/icons/mcfly-backup-128.png");
        } catch (Error e) {
            stderr.printf ("Could not load application icon: %s\n", e.message);
        }

        var welcome_screen = new Granite.Widgets.Welcome ("Go back in time !", "Configure your backup space.");
        
        welcome_screen.append("drive-removable-media", "Choose a backup destination", "Select a storage device for your backup");
        
        welcome_screen.activated.connect ((index) => {
            switch (index) {
                case 0:
                    try {
                        var file_chooser = new Gtk.FileChooserDialog ("Select Music Folder", main_window,
                                                                      Gtk.FileChooserAction.SELECT_FOLDER,
                                                                      "Cancel",
                                                                      Gtk.ResponseType.CANCEL,
                                                                      "Open",
                                                                      Gtk.ResponseType.ACCEPT);
        
                        file_chooser.set_local_only (true);
                        file_chooser.set_select_multiple (false);
                        file_chooser.set_current_folder (backupPath);
        
                        string? folder = null;
        
                        if (file_chooser.run () == Gtk.ResponseType.ACCEPT)
                            folder = file_chooser.get_filename ();
        
                        file_chooser.destroy ();
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
    }
}
