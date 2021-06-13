###########################################
# INSTALL OPENCV ON Rasbery PI 3 or newer #
###########################################

# -------------------------------------------------------------------- |
#                       SCRIPT OPTIONS                                 |
# ---------------------------------------------------------------------|
OPENCV_VERSION='4.2.0'       # Version to be installed
OPENCV_CONTRIB='NO'          # Install OpenCV's extra modules (YES/NO)
# -------------------------------------------------------------------- |

# |          THIS SCRIPT IS TESTED CORRECTLY ON          |
# |------------------------------------------------------|
# | OS               | OpenCV       | Test | Last test   |
# |------------------|--------------|------|-------------|
# | RPI 3b           | OpenCV 4.2.0 | OK   | 6  Jun 2021 |
# |----------------------------------------------------- |



# 1. KEEP RPI UP TO DATE

sudo apt-get -y update
sudo apt-get -y upgrade       # Uncomment to install new versions of packages currently installed
sudo apt-get -y dist-upgrade  # Uncomment to handle changing dependencies with new vers. of pack.
sudo apt-get -y autoremove    # Uncomment to remove packages that are now no longer needed


# 2. INSTALL THE DEPENDENCIES

# Build tools:
sudo apt-get install -y build-essential cmake

# GUI (if you want GTK, change 'qt5-default' to 'libgtkglext1-dev' and remove '-DWITH_QT=ON'):
sudo apt-get install -y qt5-default libvtk6-dev

# Media I/O:
sudo apt-get install -y zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libjasper-dev \
                        libopenexr-dev libgdal-dev

# Video I/O:
sudo apt-get install -y libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev \
                        libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev yasm \
                        libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev

# Parallelism and linear algebra libraries:
sudo apt-get install -y libtbb-dev libeigen3-dev

# Python:
sudo apt-get install -y python-dev  python-tk  pylint  python-numpy  \
                        python3-dev python3-tk pylint3 python3-numpy flake8

# Java:
sudo apt-get install -y ant default-jdk

# Documentation and other:
sudo apt-get install -y doxygen unzip wget

sudo apt-get install -y imutils

# 3. INSTALL THE LIBRARY

# wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip
wget https://github.com/michaelmcode/files/${OPENCV_VERSION}.zip

unzip ${OPENCV_VERSION}.zip && rm ${OPENCV_VERSION}.zip
tar -xf open-cv${OPENCV_VERSION}-armhf.tar.bz2 && rm open-cv${OPENCV_VERSION}-armhf.tar.bz2
sudo mv opencv-4.2.0 /opt

sudo mv opencv.pc /usr/lib/arm-linux-gnueabihf/pkgconfig
echo 'export LD_LIBRARY_PATH=/opt/opencv-4.2.0/lib:$LD_LIBRARY_PATH' >> .bashrc
source .bashrc
sudo ln -s /opt/opencv-4.2.0/lib/python2.7/dist-packages/cv2 /usr/lib/python2.7/dist-packages/cv2
sudo ln -s /opt/opencv-4.2.0/lib/python3.7/dist-packages/cv2 /usr/lib/python3/dist-packages/cv2

#if [ $OPENCV_CONTRIB = 'YES' ]; then
#  wget https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip
#  unzip ${OPENCV_VERSION}.zip && rm ${OPENCV_VERSION}.zip
#  mv opencv_contrib-${OPENCV_VERSION} opencv_contrib
#  mv opencv_contrib OpenCV
#fi

#cd OpenCV && mkdir build && cd build

#if [ $OPENCV_CONTRIB = 'NO' ]; then
#cmake -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON \
#      -DWITH_XINE=ON -DENABLE_PRECOMPILED_HEADERS=OFF ..
#fi

#if [ $OPENCV_CONTRIB = 'YES' ]; then
#cmake -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON \
#      -DWITH_XINE=ON -DENABLE_PRECOMPILED_HEADERS=OFF \
#      -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules ..
#fi

#make -j8
#sudo make install
#sudo ldconfig


# ---------------------- |
# Also install imutils   |
# ---------------------- |
cd ~
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py
rm get-pip.py
sudo pip install imutils