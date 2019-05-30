######################################
# INSTALL OPENCV ON UBUNTU OR DEBIAN #
######################################

# VERSION TO BE INSTALLED
OPENCV_VERSION='4.1.0'


echo "Installing OpenCV..."


echo "Installing OpenCV Dependencies..."

sudo apt-get install -y build-essential cmake unzip wget pkg-config gfortran

sudo apt-get install -y yasm libv4l-dev python2-dev libgtk-3-dev

sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libjasper-dev libopenexr-dev

sudo apt-get install -y libxvidcore-dev libx264-dev libatlas-base-dev libtiff5-dev python3-dev

sudo apt-get install -y zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libopenblas-base

sudo apt-get install -y libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools

echo "Installing OpenCV Library..."

cd $HOME

wget -qq -O opencv.zip https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip
wget -qq -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip

unzip opencv.zip
unzip opencv_contrib.zip

mv opencv-${OPENCV_VERSION} opencv
mv opencv_contrib-${OPENCV_VERSION} opencv_contrib

rm opencv.zip
rm opencv_contrib.zip

cd $HOME/opencv
mkdir build
cd build

PYTHON2_LIB=$(python2 -c "import distutils.sysconfig as sysconfig; import os; print(os.path.join('/usr/lib/x86_64-linux-gnu/', sysconfig.get_config_var('LDLIBRARY')))")
PYTHON3_LIB=$(python3 -c "import distutils.sysconfig as sysconfig; import os; print(os.path.join('/usr/lib/x86_64-linux-gnu/', sysconfig.get_config_var('LDLIBRARY')))")

cmake -DCMAKE_BUILD_TYPE=RELEASE -DOPENCV_EXTRA_MODULES_PATH=$HOME/opencv_contrib/modules -DCMAKE_INSTALL_PREFIX=/usr/local -DINSTALL_PYTHON_EXAMPLES=OFF -DBUILD_DOCS=OFF -DBUILD_EXAMPLES=OFF  -DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF -DBUILD_opencv_java=OFF -DWITH_LIBV4L=0N  -DWITH_V4L=ON -DOPENCV_SKIP_PYTHON_LOADER=ON -DPYTHON2_LIBRARY=$PYTHON2_LIB -DPYTHON3_LIBRARY=$PYTHON3_LIB ..
make -j10
sudo make install
sudo ldconfig

echo "Done Installing OpenCV...!!!"

cd $HOME