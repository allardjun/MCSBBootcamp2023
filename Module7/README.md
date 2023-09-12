# Module 6

## Background

Many molecules must travel from the cell surface to a pore on the nucleus (called a nuclear pore complex or NPC), either alone or in a relay with other molecules. Examples include [WNT](https://www.google.com/search?q=wnt+pathway&tbm=isch), [YAP/TAZ](https://www.google.com/search?q=yap+taz+pathway&tbm=isch), [Hedgehog](https://www.google.com/search?q=hedgehog+signaling+pathway&tbm=isch).

* We can simulate this in Matlab using the m-file in the `matlab` directory.

* We can simulate this in C using the c file in the `C` directory.

  C has a reputation for being very fast. You can tell by the 100,000s of people who compare themselves to it by saying things like ["Faster than C"](https://www.google.com/search?q=Faster+than+C) or ["As fast as C"](https://www.google.com/search?q=As+fast+as+C).

  To do so, you need a C compiler like `gcc`. At the terminal, run

    ```
    gcc -lm -O3 main.c
    time ./a.out
    ```

* We can also do this using other languages like Julia.

## Julia in a Jupyter notebook on an external server

To use the Julia language inside a notebook on Google's free Colab servers, follow the instructions at this link: [Julia notebook in Colab](https://colab.research.google.com/github/ageron/julia_notebooks/blob/master/Julia_Colab_Notebook_Template.ipynb)




