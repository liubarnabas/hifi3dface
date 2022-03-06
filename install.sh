#!/bin/bash
echo "compiling rasterizer"
TF_INC=/root/anaconda3/pkgs/tensorflow-base-1.15.0-gpu_py37h9dcbed7_0/lib/python3.7/site-packages/tensorflow/include
TF_LIB=/root/anaconda3/pkgs/tensorflow-base-1.15.0-gpu_py37h9dcbed7_0/lib/python3.7/site-packages/tensorflow
# you might need the following to successfully compile the third-party library
tf_mesh_renderer_path=$(pwd)/third_party/kernels/
g++ -std=c++11 \
    -shared $tf_mesh_renderer_path/rasterize_triangles_grad.cc $tf_mesh_renderer_path/rasterize_triangles_op.cc $tf_mesh_renderer_path/rasterize_triangles_impl.cc $tf_mesh_renderer_path/rasterize_triangles_impl.h \
    -o $tf_mesh_renderer_path/rasterize_triangles_kernel.so -fPIC \
    -I$TF_INC -L$TF_LIB -ltensorflow_framework -O2

if [ "$?" -ne 0 ]; then echo "compile rasterizer failed"; exit 1; fi
