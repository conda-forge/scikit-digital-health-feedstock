#!/usr/bin/env bash

set -ex

# [FROM NUMPY] necessary for cross-compilation to point to the right env
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig

mkdir builddir

# if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" != "1" ]]; then
#   "${PYTHON}" -m pip install . -vv
# else
#   cat >> pkgconfig.ini <<EOF
# [binaries]
# pkgconfig = '$BUILD_PREFIX/bin/pkg-config'
# EOF
#   meson setup _build ${MESON_ARGS} --cross-file pkgconfig.ini
#   meson compile -C _build
#   meson install -C _build --no-rebuild
# fi

# commenting to match numpy build
# Pass ``MESON_ARGS`` to ``meson`` [from knowledgebase]
# meson ${MESON_ARGS} builddir/

# copied/modified from numpy, -wnx flags mean: --wheel --no-isolation --skip-dependency-check
$PYTHON -m build -w -n -x \
    -Cbuilddir=builddir \
    -Csetup-args=${MESON_ARGS// / -Csetup-args=} \
    || (cat builddir/meson-logs/meson-log.txt && exit 1)

$PYTHON -m pip install dist/scikit_digital_health*.whl

