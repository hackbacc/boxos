#include<stdio.h>
void main()
{
    //char *video_memory;
    //video_memory = (char*) 0xb8000;
    
    unsigned char* video_memory; // = (char*) 0xb8000;
    video_memory = (unsigned char*) 0xb8000;
    // 01 VA
    // 23-VA
    /* video_memory[0] = str[0]; */
    /* video_memory[0] = 'H'; */
    video_memory[1] = 'H';
    video_memory[3] = 'E';
    video_memory[5] = 'L';
    /* video_memory[7] = 'L'; */
    /* char str[10] = "Hello!0"; */
    /* int offset = 1; */
    /* for(int i=0;str[i]!='0';i++) */
    /* { */
    /*    video_memory[offset] = str[i]; */
    /*    offset += 2; */
    } 
}
