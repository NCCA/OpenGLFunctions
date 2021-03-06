/// under mac __APPLE__ is defined by the compiler so we can check
/// this to get the correct includes for OpenGL
#ifdef __APPLE__
  #include <OpenGL/gl.h>
  #include <OpenGL/glu.h>
#else
  #include <GL/gl.h>
  #include <GL/glu.h>
#endif

#include <iostream>
#include <cstdlib>
#include <GLFunctions.h>
#include "SDLOpenGL.h"


// function to init the basic OpenGL scene for this demo
void initOpenGL();
// function to render our scene.
void draw();

int main()
{
  // create our SDLWindow
  SDLOpenGL win("GLFunctions Demo",0,0,720,576);
  // this makes sure the window is active for OpenGL calls, if we have
  // more than one window we need to call this for the window we want to
  // set OpenGL for
  win.makeCurrent();
  // setup our default OpenGL window state
  initOpenGL();

  bool quit=false;
  while(!quit)
  {
    SDL_Event event;
    // grab the event from the window (note this explicitly calls make current)
    win.pollEvent(event);
    switch (event.type)
    {
      // this is the window x being clicked.
      case SDL_QUIT : quit = true; break;
      // now we look for a keydown event
      case SDL_KEYDOWN:
      {
        switch( event.key.keysym.sym )
        {
          // if it's the escape key quit
          case SDLK_ESCAPE :  quit = true; break;
          // make OpenGL draw wireframe
          case SDLK_w : glPolygonMode(GL_FRONT_AND_BACK,GL_LINE); break;
          // make OpenGL draw solid
          case SDLK_s : glPolygonMode(GL_FRONT_AND_BACK,GL_FILL); break;
          default : break;
        } // end of key process
      } // end of keydown

      default : break;
    } // end of event switch
   // draw scene
   draw();
   // update the buffer so we can see what we have drawn.
   win.swapWindow();
  }

  return EXIT_SUCCESS;
}

void initOpenGL()
{
  // this sets the background colour
  glClearColor(0.8,0.8,0.8,1.0);
  // this is how big our window is for drawing
  glViewport(0,0,720,576);
  GLFunctions::perspective(45,float(1024/720),0.01,500);
  GLFunctions::lookAt(Vec4(4,4,4),Vec4(0,0,0),Vec4(0,1,0));
  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
  glColor3f(1,1,0);
  glEnable(GL_COLOR_MATERIAL);
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_NORMALIZE);

}



void draw()
{
  Vec4 red(1,0,0);
  Vec4 green(0,1,0);
  Vec4 blue(0,0,1);
  Vec4 white(1,1,1);
  Vec4 yellow(1,1,0);
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  // now draw etc
  yellow.colourGL();
  glRotatef(1.0,1,1 ,1);
  GLFunctions::cube(1.0f,1.0f,1.0f);
  glPushMatrix();
    glTranslatef(0,1,0);
    red.colourGL();
    GLFunctions::sphere(0.5,30);
  glPopMatrix();
  glPushMatrix();
    glTranslatef(-1,1,0);
    blue.colourGL();
    GLFunctions::capsule(0.2,0.6,30);
  glPopMatrix();

  glPushMatrix();
    glTranslatef(1,1,0);
    white.colourGL();
    GLFunctions::cylinder(0.5,2.0,30,30);
  glPopMatrix();

  glPushMatrix();
    glColor3f(0,1,0);
    glTranslatef(1,-1,0);
    GLFunctions::cone(0.5,2.0,30,30);
  glPopMatrix();
  glPushMatrix();
    green.colourGL();
    glTranslatef(1,1,1);
    GLFunctions::disk(0.5,30);
  glPopMatrix();

}


