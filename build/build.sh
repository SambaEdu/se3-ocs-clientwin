#!/bin/sh

script_dir=$(cd $(dirname "$0"); pwd)
pkg_name="$(basename $(cd ..;pwd))"

cd "$script_dir" || {
    echo "Error, impossible to change directory to $script_dir."
    echo "End of the script."
    exit 1
}

# Remove old *.deb files.
rm -rf "$script_dir/"*.deb

cp -ra "$script_dir/../sources" "$script_dir/$pkg_name"

cd  "$script_dir/$pkg_name"
find ./ \( -name *.sh -o -name *.pl -o -name *.py \) -exec chmod +x {} \;

dh_clean
debuild -uc -us -b
# Cleaning.
rm -r "$script_dir/$pkg_name"


