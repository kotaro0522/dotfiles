# asdf 0.16 以降（Go 版）は asdf.fish がなくなったので、shims を PATH に追加するだけで良い
# https://asdf-vm.com/guide/getting-started.html
if test -z "$ASDF_DATA_DIR"
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims
