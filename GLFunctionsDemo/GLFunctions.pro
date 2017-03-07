# we are going to build an app
TEMPLATE=app
CONFIG+=c++11
# qt 5 wants this may cause errors with 4
isEqual(QT_MAJOR_VERSION, 5) {cache() }
QT += opengl
QT -= corex`
TARGET=GLFunctions
OBJECTS_DIR=$$PWD/obj
SOURCES=$$PWD/src/main.cpp \
        $$PWD/src/SDLOpenGL.cpp

HEADERS +=$$PWD/include/SDLOpenGL.h
CONFIG-=app_bundle
# add the ngl lib
# this is where to look for includes
INCLUDEPATH +=include
INCLUDEPATH += ../GLFunctionsLib/include
LIBS+= -L$$PWD/../GLFunctionsLib/lib -lGLFunctionsLib
macx:QMAKE_CXXFLAGS+= -arch x86_64

!win32 :{
QMAKE_CXXFLAGS += $$system(sdl2-config --cflags)
LIBS+=$$system(sdl2-config --libs)
}

!win32:LIBS += -L/usr/local/lib
macx:LIBS+= -framework OpenGL


win32 : {
DEFINES+=_USE_MATH_DEFINES
INCLUDEPATH +=c:/SDL2/include
LIBS += -L$$PWD/../../../SDL2/VisualC/SDL/x64/Debug/ -lSDL2
LIBS += -L$$PWD/../../../SDL2/VisualC/SDLmain/x64/release/ -lSDL2main
LIBS+=-lopengl32
CONFIG+=console

}




win32: LIBS += -L$$PWD/../../../SDL2/VisualC/SDLmain/x64/Debug/ -lSDL2main

INCLUDEPATH += $$PWD/../../../SDL2/VisualC/SDLmain/x64/Debug
DEPENDPATH += $$PWD/../../../SDL2/VisualC/SDLmain/x64/Debug

win32:!win32-g++: PRE_TARGETDEPS += $$PWD/../../../SDL2/VisualC/SDLmain/x64/Debug/SDL2main.lib
else:win32-g++: PRE_TARGETDEPS += $$PWD/../../../SDL2/VisualC/SDLmain/x64/Debug/libSDL2main.a
