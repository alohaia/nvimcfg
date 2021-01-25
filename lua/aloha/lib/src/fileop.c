/* #include "include/apue.h" */
#include <stdio.h>
#include <dirent.h>

int ReadDir(int argc, char** argv)
{
    DIR *dp;
    struct dirent *dirp;

    if(argc != 2)
        /* err_quit("usage: ls directory_name"); */
        argv[1] = ".";

    if((dp = opendir(argv[1])) == NULL)
        return -1;

    while ((dirp = readdir(dp)) != NULL)
        printf("%s\n", dirp->d_name);

    closedir(dp);
    return 0;
}
