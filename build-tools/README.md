# Build Tools

## meson

### Source

Source: https://github.com/mesonbuild/meson

Example:

```sh
./packaging/create_zipapp.py --outfile meson.pyz --interpreter '/usr/bin/env python3' <source checkout>
```

Commands:

```sh
cd ~/sources/meson
./packaging/create_zipapp.py --outfile meson.pyz --interpreter '/usr/bin/env python3'
mv ./meson.pyz ~/cust-bin
cd ~/cust-bin
sudo ln -s /home/$USER/cust-bin/meson.pyz /usr/bin/meson
```

### Deps
```sh
sudo apt-get install python3 python3-pip python3-setuptools python3-wheel ninja-build
```

