### Self-made Docker image

1. Build image from this repo

        git clone https://github.com/DmitrySandalov/docker-zoom.git
        cd docker-zoom
        docker build -t zoom .

2. Start Zoom:

        docker run -h `hostname` --name zoom -d -e DISPLAY=$DISPLAY --device /dev/video0:/dev/video0 -v /tmp/.X11-unix:/tmp/.X11-unix -v /run/user/`id -u`/pulse:/run/pulse zoom

### Notes

* Note 1. To set up a proxy server, modify the file `conf/zoomus.conf` and rebuild the image

https://zoom.us/

https://support.zoom.us/hc/en-us/articles/204206269-Getting-Started-on-Linux
