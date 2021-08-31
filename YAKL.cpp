
#include "YAKL.h"

namespace yakl {

  #ifdef YAKL_ARCH_SYCL
    sycl::queue sycl_default_stream;
  #endif

  std::mutex yakl_mtx;

  Gator pool;

  void * functorBufferDevice;

  bool yakl_is_initialized = false;

  // YAKL allocator and deallocator
  std::function<void *( size_t , char const *)> yaklAllocDeviceFunc = [] ( size_t bytes , char const *label ) -> void* {
    std::cout << "ERROR: attempting memory alloc before calling yakl::init()\n"; exit(-1);
  };
  std::function<void ( void * , char const *)>  yaklFreeDeviceFunc  = [] ( void *ptr    , char const *label )          {
    std::cout << "ERROR: attempting memory free before calling yakl::init()\n"; exit(-1);
  };

  // YAKL allocator and deallocator
  std::function<void *( size_t , char const *)> yaklAllocHostFunc = [] ( size_t bytes , char const *label ) -> void* {
    std::cout << "ERROR: attempting memory alloc before calling yakl::init()\n"; exit(-1);
  };
  std::function<void ( void * , char const *)>  yaklFreeHostFunc  = [] ( void *ptr    , char const *label )          {
    std::cout << "ERROR: attempting memory free before calling yakl::init()\n"; exit(-1);
  };
}


extern "C" void gatorInit() {
  yakl::init();
}


extern "C" void gatorFinalize() {
  yakl::finalize();
}


// Fortran binding
extern "C" void* gatorAllocate( size_t bytes ) {
  return yakl::yaklAllocDevice( bytes , "");
}


// Fortran binding
extern "C" void gatorDeallocate( void *ptr ) {
  yakl::yaklFreeDevice( ptr , "");
}


