# t0yboX
Docker image including ctf tools!!!

## Install

```bash
$ python -c "`curl -fsSL https://raw.githubusercontent.com/takuzoo3868/t0yboX/master/install.py `"
```

## Usage

```bash
$ t0yboX                # run docker
$ t0yboX -c <filename>  # copy file to container home dir
$ t0yboX -m <filename>  # move file to container home dir

$ t0yboX -B             # build docker image
$ t0yboX -R             # clear docker container
```

If you have problems with gdb or gdbserver you can run the container in privileged mode and with the host network.

```bash
$ sudo docker run -it --privileged --net=host takuzoo3868/t0ybox
```

## Licence

The MIT License.


