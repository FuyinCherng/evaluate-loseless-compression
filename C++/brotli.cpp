#include "brotli/decode.h"
#include "brotli/encode.h"
#include <iostream>
#include <fstream>
#include <chrono>
#include <cmath>
#include <algorithm>

#include <dirent.h>
#include <vector>

using namespace std;
using namespace chrono;

#define TOTAL_SAMPLES 50
#define KB 1024
#define MB 1048576
#define INCREMENT_STEP_KB 100 //100KB
#define MAX_INPUT_SIZE_MB 64 //64MB

/****************
 * Random string block
 */
static const char alphanum[] =
        "0123456789"
                "!@#$%^&*"
                "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                "abcdefghijklmnopqrstuvwxyz";
int stringLength = sizeof(alphanum) - 1;

string random_string(int length) {
    string out = "";
    for (int v = 0; v < length; ++v) {
        out += alphanum[rand() % stringLength];
    }
    return out;
}


/**************
 * From file
 */
string load_from_file(string path, int length) {
    ifstream ifs(path);
    std::string str;
    while (!ifs.eof() && length-- > 0) {
        str.append(1, ifs.get());
    }
    return str;
}

void incrementalSamples(char *argv[]) {



    int quality = 3;
    int lgwin = 0;

    for (int input_size = INCREMENT_STEP_KB * KB;
         input_size < MAX_INPUT_SIZE_MB * MB; input_size += INCREMENT_STEP_KB * KB) {


        string input;
        //random
        if (argv[1][0] == 'r')
            input = random_string(input_size);
        //from file
        if (argv[1][0] == 'f') {
            input = load_from_file(argv[2], input_size);
        }


        long compressed_size = 0;


        long *time_samples_compression = new long[TOTAL_SAMPLES];
        long *time_samples_decompression = new long[TOTAL_SAMPLES];


        //size_t input_size = input.length();

        size_t output_size = input_size * 2;
        uint8_t *output_buffer = (uint8_t *) malloc(output_size);

        size_t decode_size = input_size;
        uint8_t *decode_buffer = (uint8_t *) malloc(decode_size);

        for (int j = 0; j < TOTAL_SAMPLES; ++j) {

            /*************
             * COMPRESSION
             */
            //string compressed;
            auto start_compression = high_resolution_clock::now();
            //compress(input, output);
            BrotliEncoderCompress(quality, lgwin, BROTLI_MODE_GENERIC, input_size, (uint8_t *) input.c_str(),
                                  &output_size, output_buffer);


            auto elapsed_compression = high_resolution_clock::now() - start_compression;
            long long microseconds_elapsed_compression = duration_cast<chrono::microseconds>(
                    elapsed_compression).count();
            time_samples_compression[j] = microseconds_elapsed_compression;
            compressed_size = output_size;


            /*************
             * DECOMPRESSION
             */
            //string original;
            auto start_decompression = high_resolution_clock::now();
            BrotliDecoderDecompress(output_size, output_buffer, &decode_size, decode_buffer);

            //cout << decode_size;


            auto elapsed_decompression = high_resolution_clock::now() - start_decompression;
            long long microseconds_elapsed_decompression = duration_cast<chrono::microseconds>(
                    elapsed_decompression).count();
            time_samples_decompression[j] = microseconds_elapsed_decompression;

        }

        free(output_buffer);
        free(decode_buffer);


        //cout << input_size << "\t" << compressed_size << "\t" << ((float) compressed_size) / input_size;
        for (int i = 0; i < TOTAL_SAMPLES; ++i) {
            cout << input_size << "\t" << compressed_size;
            cout << "\t" << time_samples_compression[i] << "\t" <<time_samples_decompression[i]<<"\n";
        }

    }

}




vector<string> getFiles(string folder) {
    DIR *dir;
    struct dirent *ent;
    vector<string> files_list;
    if ((dir = opendir(folder.c_str())) != NULL) {
        /* print all the files and directories within directory */
        while ((ent = readdir(dir)) != NULL) {
            if (ent->d_name[0] != '.') {
                files_list.push_back(folder + "/" + string(ent->d_name));
            }
        }
        closedir(dir);
    } else {
        /* could not open directory */
        perror("");
    }
    return files_list;
}

ifstream::pos_type filesize(const char *filename) {
    std::ifstream in(filename, std::ifstream::ate | std::ifstream::binary);
    return in.tellg();
}

void fromDirectory(char *argv[]) {
    vector<string> files_list = getFiles(string(argv[2]));

    int quality = 3;
    int lgwin = 0;
    for (int i = 0; i < files_list.size(); ++i) {

        string input = load_from_file(files_list[i], filesize(files_list[i].c_str()));

        long compressed_size = 0;

        size_t output_size = input.size() * 2;
        uint8_t *output_buffer = (uint8_t *) malloc(output_size);

        size_t decode_size = input.size();
        uint8_t *decode_buffer = (uint8_t *) malloc(decode_size);
        //string compressed;
        auto start_compression = high_resolution_clock::now();
        //compress(input, output);
        BrotliEncoderCompress(quality, lgwin, BROTLI_MODE_GENERIC, input.size(), (uint8_t *) input.c_str(),
                              &output_size, output_buffer);


        auto elapsed_compression = high_resolution_clock::now() - start_compression;
        long long microseconds_elapsed_compression = duration_cast<chrono::microseconds>(
                elapsed_compression).count();
        compressed_size = output_size;


        /*************
         * DECOMPRESSION
         */
        //string original;
        auto start_decompression = high_resolution_clock::now();
        BrotliDecoderDecompress(output_size, output_buffer, &decode_size, decode_buffer);

        //cout << decode_size;


        auto elapsed_decompression = high_resolution_clock::now() - start_decompression;
        long long microseconds_elapsed_decompression = duration_cast<chrono::microseconds>(
                elapsed_decompression).count();



        free(output_buffer);
        free(decode_buffer);

        cout << input.length() << "\t" << compressed_size << "\t" << microseconds_elapsed_compression << "\t"
             << microseconds_elapsed_decompression << "\n";

    }
}


int main(int argc, char *argv[]) {

    if (argc < 2) {
        cout << "Missing params";
        return 0;
    }

    if (argv[1][0] == 'd') {
        fromDirectory(argv);
    } else {
        incrementalSamples(argv);
    }


    return 0;
}