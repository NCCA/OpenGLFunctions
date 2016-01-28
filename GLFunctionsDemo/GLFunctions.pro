# we are going to build an app
TEMPLATE=app
CONFIG+=c++11
# qt 5 wants this may cause errors with 4
isEqual(QT_MAJOR_VERSION, 5) {cache() }
QT += core
QT +=opengl

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
LIBS+= -L ../GLFunctionsLib/lib -lGLFunctionsLib
QMAKE_CXXFLAGS+= -msse -msse2 -msse3
macx:QMAKE_CXXFLAGS+= -arch x86_64

QMAKE_CXXFLAGS += $$system(sdl2-config --cflags)
LIBS+=$$system(sdl2-config --libs)


LIBS += -L/usr/local/lib
macx:LIBS+= -framework OpenGL
# now if we are under unix and not on a Mac (i.e. linux) define GLEW
linux-g++:linux-g++-64 {
    LIBS+= -lGLEW
}
linux-clang {
    LIBS+= -lGLEW
}
