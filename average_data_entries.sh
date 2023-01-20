#!/bin/bash

echo “Enter Year”
read year

echo “Enter Month”
read month

path=/Users/ronan/Documents/malicious_domain_lists/$year/$month

cd $path

line_count=0
file_count=0
for folder in *; 
    do cd $folder; 
    
    for file in *; 
        do 
        if file "$file" | grep -iq gzip; then
        echo -e "gzip file \tFile path: $folder/$file \tLine count: $(< "$file" zcat | wc -l)"; 
        new_count=$(< "$file" zcat | wc -l); 
        line_count=$(($line_count+$new_count));
        file_count=$(($file_count+1))
        break; 
        elif file "$file" | grep -iq tsv; then
        echo -e "tsv file \tFile path: $folder/$file \tLine count: $(< "$file" cat | wc -l)"; 
        new_count=$(< "$file" cat | wc -l); 
        line_count=$(($line_count+$new_count));
        file_count=$(($file_count+1))
        break;
        else
        echo -e "txt file \tFile path: $folder/$file \tLine count: $(< "$file" wc -l)"; 
        new_count=$(< "$file" wc -l); 
        line_count=$(($line_count+$new_count));
        file_count=$(($file_count+1))
        break; 
        fi
    done; 
    
    cd ../; 
done

echo "Average line count = $(($line_count / $file_count))"
