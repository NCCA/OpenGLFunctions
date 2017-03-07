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
LIBS += -L$$PWD/../../../SDL2/lib/x64/ -lSDL2
LIBS+=-lopengl32
CONFIG+=console

}
