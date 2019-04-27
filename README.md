# KLaunch
A minimal overhead kernel launcher for performance portability

KLaunch is a minimally invasive library intended to allow a user to define kernels in the form of functors (possibly lambdas) without having to marry themselves to a specific data type. This library provides:

* Various launchers such as parallel_for or reduce_[operation], which can run on GPUs using CUDA or CPUs (serial or threaded), and potentially other architectures if they are added
* Wrappers for atomic accesses and synchronization
* Utility functions to extract multi-dimensional indices from a pool of flattened indices
* An optional multi-dimensional array class that uses CUDA Managed Memory if __NVCC__ is defined. Users do not need to use this in order to use the launchers. These are completely orthogonal options.
