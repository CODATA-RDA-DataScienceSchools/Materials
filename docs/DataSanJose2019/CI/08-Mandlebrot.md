# A brief detour through the Mandlebrot set

Before we dive into a more complicated DAG, let's get a more interesting job. I'm tired of this lazy, sleepy job that only does trivial mathematics. Let's make pretty pictures!

We have a small program that draws pictures of the Mandlebrot set. You can [read about the Mandlebrot set on Wikipedia](https://secure.wikimedia.org/wikipedia/en/wiki/Mandelbrot_set), or you can simply appreciate the pretty pictures. It's a fractal. 

We have a simple program that can draw the Mandlebrot set. It's called `goatbrot`,

## A simple invocation of goatbrot

You can generate the Mandlebrot set with two simple commands. 

1. Generate a PPM image of the Mandlebrot set:

```
$ /stash/user/rquick/public/goatbrot-master/goatbrot -i 1000 -o tile_000000_000000.ppm -c 0,0 -w 3 -s 1000,1000
```

2. Add the Fast Fourier Transform and ImageMagick packages:

```
$ module load fftw
```

3. Convert it to a JPEG image and write into your home directory:

```
$ convert tile_000000_000000.ppm ~/mandle.gif
```

Run the commands above, make sure you can create the Mandlebrot image. When you create the image, you might wonder how you can view it.
In order to view the image, you should move the file to a web accessible location. 

   1. `cp ~/mandle.gif ~/public`
   1. point your browser at the stash web server:

```
http://stash.osgconnect.net/~USER
```

The `goatbroat` program takes several parameters. Let's break them down:

   * `-i 1000` The number of iterations. Bigger numbers generate more accurate images but are slower to run. 
   * `-o tile_000000_000000.ppm` The output file to generate. 
   * `-c 0,0` The center point of the image. Here it is the point (0,0).
   * `-w 3` The width of the image. Here is 3.
   * `-s 1000,1000` The size of the final image. Here we generate a picture that is 1000 pixels wide and 1000 pixels tall. 

## Dividing goatbrot up

The Mandlebrot set can take a while to create, particularly if you make the iterations large or the image size large. What if we broke the creation of the image into multiple invocations then stitched them together? Once we do that, we can run the each goatbroat in parallel in our cluster. Here's an example you can run by hand. 

   1. *Run goatbroat 4 times*: 

```
$ /stash/user/rquick/public/goatbrot-master/goatbrot -i 1000 -o tile_000000_000000.ppm -c -0.75,0.75 -w 1.5 -s 500,500
$ /stash/user/rquick/public/goatbrot-master/goatbrot -i 1000 -o tile_000000_000001.ppm -c 0.75,0.75 -w 1.5 -s 500,500
$ /stash/user/rquick/public/goatbrot-master/goatbrot -i 1000 -o tile_000001_000000.ppm -c -0.75,-0.75 -w 1.5 -s 500,500
$ /stash/user/rquick/public/goatbrot-master/goatbrot -i 1000 -o tile_000001_000001.ppm -c 0.75,-0.75 -w 1.5 -s 500,500
```

   2. *Stitch them together*: 

```
$ montage tile_000000_000000.ppm tile_000000_000001.ppm tile_000001_000000.ppm tile_000001_000001.ppm -mode Concatenate -tile 2x2 ~/mandle.gif
```

This will produce the same image as above. We broke the image space into a 2 by 2 grid and ran `goatbrot` on each section of the grid. The `montage` program simply stitches the files together. 

Check if the results are the same by copying the file to the `public` directory
