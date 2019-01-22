# optee-qemu-docker

An OP-TEE QEMU container to simplify TA testing.

This container provides two working mode:
- Interactive mode: Manually use normal world shell to execute commands
- Batch mode: Runs a user-provided script and exits



## Run in interactive mode

```
docker run -it blukat29/optee-qemu:3.3.0 interactive
```

- The normal world shell will start.
- Login as `root` without password to continue.
- Try `hello_world` or `xtest` to see if TEE is working.
- Exit by `docker rm -f`. Currently there is no way to gracefully shutdown.


## Log files

Log files are saved under `/opt/logs`. Mount this directory to get log files.

- `/opt/logs/qemu.log`: Saved qemu console output.
- `/opt/logs/normal.log`: Saved normal world stdout (boot logs and shell)
- `/opt/logs/secure.log`: Secure world logs.


## Shared directory

A shared directory between inside and outside qemu is already configured.
To access the shared directory outside docker container, mount `/opt/shared`.
Then in the normal world shell,


```
$ docker run -v /path/to/shared:/opt/shared -it blukat29/optee-qemu:3.3.0

    (...)

buildroot login: root
# mount -t 9p -o trans=virtio host /mnt
# ls /mnt
```


## Run in batch mode

In batch mode, one user-provided script will run in the normal world
and then the container automatically exits whtn the script finishes.

Below example run executes the `hello_world` test program that tests
the built-in example `hello_world` TA.

```
$ cd /path/to/shared
$ echo 'hello_world' > run.sh
$ chmod +x run.sh
$ docker run -v /path/to/shared:/opt/shared -it blukat29/optee-qemu:3.3.0 batch

    (...)

buildroot login: root
# mount -t 9p -o trans=virtio host /mnt
# cd /mnt
# ls -al
total 8
drwxr-xr-x    2 1002     test          4096 Jan 22 01:51 .
drwxr-xr-x   18 root     root             0 Jan 21 13:52 ..
-rwxr-xr-x    1 1002     test            12 Jan 22 01:47 run.sh
# sh run.sh
D/TC:0 0 core_mmu_entry_to_finer_grained:653 xlat tables used 5 / 5
D/TC:? 0 tee_ta_init_pseudo_ta_session:273 Lookup pseudo TA 8aaaf200-2450-11e4-abe2-0002a5d5c51b
D/TC:? 0 load_elf:842 Lookup user TA ELF 8aaaf200-2450-11e4-abe2-0002a5d5c51b (Secure Storage TA)
D/TC:? 0 load_elf:842 Lookup user TA ELF 8aaaf200-2450-11e4-abe2-0002a5d5c51b (REE)
D/TC:? 0 load_elf_from_store:810 ELF load address 0x40005000
D/TC:? 0 tee_ta_init_user_ta_session:1029 Processing relocations in 8aaaf200-2450-11e4-abe2-0002a5d5c51b
D/TA:  TA_CreateEntryPoint:39 has been called
D/TA:  TA_OpenSessionEntryPoint:68 has been called
I/TA: Hello World!
Invoking TA to increment 42
D/TA:  inc_value:105 has been called
I/TA: Got value: 42 from NW
I/TA: Increase value to: 43
TA incremented value to 43
D/TC:? 0 tee_ta_close_session:380 tee_ta_close_session(0xe169cf0)
D/TC:? 0 tee_ta_close_session:399 Destroy session
I/TA: Goodbye!
D/TA:  TA_DestroyEntryPoint:50 has been called
D/TC:? 0 tee_ta_close_session:425 Destroy TA ctx
```

