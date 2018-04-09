# The Trifold Tessellator Computer Bag Gennerator
Fashion Designers, especially accessory designers, love to use patterns that repeat. Brands like Gucci, Hermes and Louis Vuitton built their brands upon these patterns. I used Processing to create a sketch that will let you design your own pattern (tessellation) and give you files to need to laser etch/cut your own computer bag.  Instructions on how to sew the bag: https://www.instructables.com/id/Laser-Etched-Trifold-Leather-Bag/

## The Math

<div class="step-body">

Exploring the math behind these wallpaper patterns is fascinating. Understanding the underlying maths makes the development of these patterns even more fun.

Escher was a master of these patterns and I took the opportunity to see his work at [The Escher exhibit at the Pallazo Blu](https://palazzoblu.it/mostra/escher/) in Pisa this January.

I explored these tessellations further using the [oog-processing](https://github.com/iddi/oogway-processing) library by Jun Hu. This library takes a deep look at the 17 wallpaper patterns (28 Tessellations) developed by Heesch and Kinzle in the 1963 book Flächenschluß. The image above is from Jun Hu's processing examples.

In the attached code, congruent tiles are laid down using a pShape object to allow for the visualisation of the tile and how it will lie on the finished bag. The processing sketch found in the next step is designed to explore square or quadrilateral Heesch tessellations.

The Heesch system is easy:  
1\. Look at your shape like a bathroom tile. How many sides does it have? So far I only do 4 sided shapes in the processing sketch.

2\. Moving clockwise around the tile, figure out which kind of symmetry each side has

1.  (T) Translation aka move: the shape moves around on each side
2.  (G) Glide + Reflection: The shape flips over.
3.  (C) Rotation aka. spin, the shapes rotate around a circle

Tessellations are the covering of a surface with reoccurring geometric patterns. There are many ways of achieving tessellations. I started with the TTTT, in order to make a sketch that other fashion designers could appreciate as well. This naturally evolved into two shapes interacting in the TTTT tessellation. These tessellations start in a one dimensional Frieze patterns that show how patterns repeat in a line. The famous mathematician Conway created a [great example](https://www.maa.org/sites/default/files/images/upload_library/4/vol1/architecture/Math/seven.html) of how this works.

The tesselations explored here are commonly known as quadrilateral tiles, 11 possibilities exist: TTTT, CCCC, TCTC, C3C3C3C3, C4C4C4C4, C3C3C6C6, CCGG, TGTG, CGCG, G1G1G2G2, and G1G2G1G2\.

I created the processing sketch, The Trifold Tessellator, as a way to help fashion designers explore the use of TTTT patterns to make their own trifold computer bag. The software attached is meant as a way for designers to explore how to make patterns while understanding the underlying math. Controls are made to allow the freedom to design patterns while seeing an immediate tessellation.

Thanks to [Prof. Loe Feijs](https://www.tue.nl/en/university/departments/industrial-design/department/staff/detail/ep/e/d/ep-uid/19980800/), [Prof. Jun Hu](https://www.tue.nl/en/university/departments/industrial-design/department/staff/detail/ep/e/d/ep-uid/19992092/) and [Dr. Mathias Funk](https://www.tue.nl/en/university/departments/industrial-design/department/staff/detail/ep/e/d/ep-uid/20062508/) for the course on [Golden Ratio and Generative Arts](http://wiki.id.tue.nl/goldenratio) at the [Eindhoven University of Technology](https://www.tue.nl/en/university/departments/industrial-design/).

</div>

</section>
