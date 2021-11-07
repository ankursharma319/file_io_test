#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>

void print_data(char* data, size_t size) {
    for(size_t i=0;i<size; i++) {
        printf("%c",data[i]);
    }
}

void read_iteratively(FILE* file, size_t iter_read_size, int n_loops, int wait_time_s) {
    for(int i = 0; i< n_loops; i++) {
        char data[iter_read_size];
        if (feof(file)) {
            printf("eof file reached\n");
            return 0;
        }
        size_t bytes_read = fread(data, 1, iter_read_size, file);
        if(bytes_read!=iter_read_size) {
            printf("\nError, read not enough bytes\n");
            continue;
        }
        print_data(data, iter_read_size);
        printf("\n");
        usleep(wait_time_s*1000*1000);
    }
}

int main() {
    printf("File Reader\n");
    FILE* file = fopen("./data.txt", "rb");
    setvbuf(file , NULL , _IONBF , 0 );
    read_iteratively(file, 100, 1000, 1);
    fclose(file);
    printf("\nExiting Program\n");
    return 0;
}