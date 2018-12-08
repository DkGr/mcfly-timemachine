# McFly's Time Machine

## Install, build and run

```bash
# install elementary-sdk, meson and libswitchboard
sudo apt install elementary-sdk meson libswitchboard-2.0-dev libpolkit-gobject-1-dev
# clone repository
git clone {{repourl}} mcflys-timemachine
# cd to dir
cd mcflys-timemachine
# run meson
meson build --prefix=/usr
# cd to build, build and test
cd build
sudo ninja install
# restart switchboard to load your widget into switchboard
pkill switchboard -9
```

## Generating pot file

```bash
# after setting up meson build
cd build

# generates pot file
ninja com.github.dkgr.mcflys-timemachine-pot

# to regenerate and propagate changes to every po file
ninja com.github.dkgr.mcflys-timemachine-update-po
```
