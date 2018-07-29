# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-snake_game

CONFIG += sailfishapp

SOURCES += src/harbour-snake.cpp \
    src/gameboard.cpp \
    src/snake.cpp \
    src/apple.cpp

DISTFILES += \
    qml/cover/CoverPage.qml \
    qml/pages/*.qml \
    qml/components/*.qml \
    rpm/harbour-snake.changes.in \
    rpm/harbour-snake.changes.run.in \
    translations/*.ts \
    sounds/*.wav \
    qml/harbour-snake_game.qml \
    rpm/harbour-snake_game.yaml \
    harbour-snake_game.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-snake_game-ru.ts

HEADERS += \
    src/gameboard.h \
    src/snake.h \
    src/apple.h
