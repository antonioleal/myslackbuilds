#!/bin/bash

# test dependencies

# lazarus
# ├ cqrlog  (Gustavo Conrad <gus3963 gmail>)
# ├ ddrescueview  (Jeremy Hansen <jebrhansen+SBo@gmail.com>)
# ├ doublecmd-qt5  (Hao Chi Kiang <no@no.noooo.ooo>)
# ├ easymp3gain  (Chernov V. V. <manbornofwoman@gmail.com>)
# ├ transgui  (Jeremy Hansen <jebrhansen+SBo@gmail.com>)
# └ winff  (Vijay Marcel <vijaymarcel@outlook.com>)


# install all dependents
slapt-src -i  \
    tqsl xplanet hamlib cqrlog \
    ddrescueview \
    doublecmd-qt5 \
    mp3gain vorbisgain easymp3gain \
    transgui \
    winff


