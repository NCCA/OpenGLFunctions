# we are going to build a lib
TEMPLATE=lib
# this flag makes it a static .a lib easier for this simple program
CONFIG+=staticlib
# use C++ 11
CONFIG+=c++11
# qt 5 wants this may cause errors with 4
isEqual(QT_MAJOR_VERSION, 5) {cache() }
QT += core
QT +=opengl

TARGET=GLFunctionsLib
DESTDIR=$$PWD/lib
OBJECTS_DIR=$$PWD/obj
SOURCES=$$PWD/src/GLFunctions.cpp \
        $$PWD/src/Vec4.cpp \
        $$PWD/src/Mat4.cpp


HEADERS+=$$PWD/include/GLFunctions.h \
         $$PWD/include/Vec4.h \
         $$PWD/include/Mat4.h

# add the ngl lib
# this is where to look for includes
INCLUDEPATH +=include

QMAKE_CXXFLAGS+= -msse -msse2 -msse3
macx:QMAKE_CXXFLAGS+= -arch x86_64



LIBS += -L/usr/local/lib
macx:LIBS+= -framework OpenGL

# windows build
win32:{
DEFINES+=_USE_MATH_DEFINES

}
