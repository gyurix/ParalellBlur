# ParalPr - Task2 - Paralelized image blur

**Author:** Juraj Baráth

## About

This application applies a blur effect to a 4K image in.bmp by calculating the average color of every
pixel in a 5 block rectangular range around the changeable pixel (total 11 x 11 = 121 pixels average color
is calculated for determining the color of one pixel).

## Paralelization

After the image is loaded for speeding up the calculation of this blur effect the image can be divided into several equal sized parts. Each parts pixels can be calculated separately and paralelly. In the end the main thread needs to write the result image to the **out.bmp** file

## Testing

I have run an OpenMP test on a Linux dedicated server and the MPI test on my own laptop. Both MPI and OpenMP was tested with
1, 2, 4, 8, 16, 32 and 64 threads.

## OpenMP

The openmp implementation uses a shared array of pixel colors which it processed through another shared array.

### Test result

    ./p2.bash 
    Compiling openmp...

    [OpenMP] 1 thread (1. test): 7.053
    [OpenMP] 2 thread (1. test): 3.583
    [OpenMP] 4 thread (1. test): 1.798
    [OpenMP] 8 thread (1. test): 1.081
    [OpenMP] 16 thread (1. test): 0.927
    [OpenMP] 32 thread (1. test): 0.946
    [OpenMP] 64 thread (1. test): 0.915

    [OpenMP] 1 thread (2. test): 7.078
    [OpenMP] 2 thread (2. test): 3.577
    [OpenMP] 4 thread (2. test): 1.797
    [OpenMP] 8 thread (2. test): 0.954
    [OpenMP] 16 thread (2. test): 0.926
    [OpenMP] 32 thread (2. test): 0.935
    [OpenMP] 64 thread (2. test): 0.915

    [OpenMP] 1 thread (3. test): 7.033
    [OpenMP] 2 thread (3. test): 3.605
    [OpenMP] 4 thread (3. test): 1.796
    [OpenMP] 8 thread (3. test): 0.939
    [OpenMP] 16 thread (3. test): 0.900
    [OpenMP] 32 thread (3. test): 0.954
    [OpenMP] 64 thread (3. test): 0.924

## MPI

The MPI sends the whole image array to each process, and in the end process 0 receives the partial results from them
directly to the output image buffer

### Test results
    [MPI] 1 thread (1. test): 10.515
    [MPI] 2 thread (1. test): 5.448
    [MPI] 4 thread (1. test): 4.968
    [MPI] 8 thread (1. test): 2.979
    [MPI] 16 thread (1. test): 4.679
    [MPI] 32 thread (1. test): 3.843
    [MPI] 64 thread (1. test): 5.400

    [MPI] 1 thread (2. test): 13.682
    [MPI] 2 thread (2. test): 5.922
    [MPI] 4 thread (2. test): 5.543
    [MPI] 8 thread (2. test): 3.101
    [MPI] 16 thread (2. test): 5.163
    [MPI] 32 thread (2. test): 4.316
    [MPI] 64 thread (2. test): 6.662

    [MPI] 1 thread (3. test): 10.842
    [MPI] 2 thread (3. test): 7.149
    [MPI] 4 thread (3. test): 4.095
    [MPI] 8 thread (3. test): 4.214
    [MPI] 16 thread (3. test): 5.363
    [MPI] 32 thread (3. test): 5.034
    [MPI] 64 thread (3. test): 6.536


## Test results review

On the Linux machine with the OpenMP test after going above 16 threads the execution time does not really change too much.

On the Windows machine with the MPI test after going above 8 threads we see a significant worsening of the execution time.

Overall it looks like the OpenMP was faster than the MPI.

## Files included in this folder

- **in.bmp**: The programs input image

- **p2.bash**: Tester for running the OpenMP test on Linux

- **test.sh**: Tester for running the MPI test on Windows with Git Bash

- **p2.cpp**: The OpenMP implementation of the program
 
- **Task2.cpp**: The MPI implementation of the program
