/*******************************************************************************

 ----------------------------------------------------
* GUIDE FOR USING GENETIC ALGORITHM PAINTING PROGRAM *
 ----------------------------------------------------

Project Overview :
  The way this setup works is that each individual in the population is
  represented by a canvas, and has a number of genes that determine how
  it will paint a target image.  Every frame each canvas is updated, and
  stopped when it reaches a set number of strokes.  When all are finished
  they are then scored and selected by lexicase selection to produce the next
  generation.  The process continues and the hope is that the painting produced
  will improve over time.

GenTest01.pde :
  This is where the main flow of the genetic process takes place.  the global
  variable GENECOUNT is the number of genes that each individual has, and 
  POPULATION is the number of individuals.
  In setup you just have to worry about input, which is the target image all
  of your individuals are trying to paint, and the random values that are
  passed in to each canvas when they are all initialized in setup.  These
  random values represent the range that each gene can fall into.  These 
  should be tweaked depending on canvas size and desired outcome.
  In this processing program's case, all the draw function does is wait untill
  all of the canvases are finished to start the scoring, selection, and
  reproduction process.
  
bristle.pde :
  The bristle class is what creates the simulation of a brush stroke.  you can
  tweak the class variables to change how the brush moves in relation to speed
  and pressure.  You can use the brush yourself by running the NewBrush processing
  program.
  
canvas.pde :
  The canvas class represents each individual in the population.  All of its genes
  are assigned in the initializer, as well as all of the bristles that make up the
  brush.  The brush is either moved or dragged along the canvas every frame.
  Unless the canvas is done, advance is called every frame to move the brush.
  Advance is where a lot of the genes are used.  If the boolean value 'move' is
  true, then advance places the brush down at a new spot, otherwize it drags the
  brush.
  The method crossover combines the genes of the parent and partner to create
  a new canvas by chosing a random parent for each gene.  Also, each gene can
  have an x% change of mutating depending on what you set it too, right now
  it is at 10%.
  The method mutate takes an integer value of the gene it's going to change.
  All of the random ranges in mutate are set to the same ranges as the genes
  when they are initialized.
  GetEdgeAngle, detectEdge, getBrushAngle, and getAverageBetweenAngles all have
  to do with how the brush reacts to finding an edge.  The brush angle is always
  between 0 and 2PI.  When the brush detects an edge, the brush changes its angle
  to the average between it and the edge angle weighted in some direction based
  on genes.
  
PARENT AND CHILD IN PARALLEL :
  These programs were made so that a very big population could be run without
  slowing down a single computer too much.  To run with however many computers,
  you run one as a parent and the rest as children.
  Make sure you give each computer a different number for NUM, the parent must
  always be zero, set the numbers on the children from 1 to amount of children.
  Also set COMPS to the number of computers you are using.
  It's necessary for every computer to have the same population, so set 
  POPULATION on each computer to some number, and then TOTALPOPULATION on each
  computer to that number * COMPS.
  
RUNNING ON HPC :
  Log into grid.hpc.hamilton.edu account, cd testjob or to whichever directory
  your script for running on the hpc is, copy your processing project to the
  same directory, copy the linux version of the processing app into the same
  directory.  To test to see if your project will work before putting it on the
  queue, run the command...
    xvbf-run processing-java --sketch=./ProjectName --run.
  
********************************************************************************/